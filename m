Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1BB7D1111
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377484AbjJTN5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377405AbjJTN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:57:05 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEAF126
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:57:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c2a0725825so131472666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697810222; x=1698415022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uv9UU3kI2GN01PVvTMVaUt4C4ErvxXyE3r2m0CfdYU4=;
        b=msxUYX2GvYopnDqUaiYV6JsRTaUoooh294F2sHA4aTHIF1aBVY6YtEtnr1yQv+r7Ru
         4IIxYpADwl41vuVTpecN4JG38eD4YvJuxlPOAVNTjvj8p6ZRPNY0vPgiL/FZl/+hosl+
         NO9YW3GrSD9/5CPm3Gwz0ofeLk6nrhQ55048mkLj5NfH9n5xLqj6Xs7CQw+XGSYPOeBs
         e/OKfV2VnasXyaFA6VVJUpgqed28mDFIhDtU7xci3q8OPxMRNPmXGgvVVdgNceeEd21d
         Z/YGa3RtLI40LVmclZhb/8U3iqKA8G9qn3jyEch7rZNJJCiBzX1s1Ee76DizI3tMHaOO
         NkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697810222; x=1698415022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uv9UU3kI2GN01PVvTMVaUt4C4ErvxXyE3r2m0CfdYU4=;
        b=NvhF2GRfHcfz4p1niLONkxsnNPV+F2dan7X+LcdMJlyNf2dc3i3xu2yFJAojXZ1C1c
         4pe+AXgUEDZRodxZCPtIlKo9sQN4a7+mcu7RHXjBCKSrctrTYcy1y4xQ71a4hBPs4D2C
         tp/gYANajv0GHowQv2cGtbopn6+IOhnuwuK+iO1BUhtfBbkh5xavuBvJVZRexIr+JZWu
         4/is5vQoXLsVTScQWC/oAtNH6jx+wpH5J9SWyY/IzVkZ9qJwaJJxQVO9Rz6Kzfoh7xmu
         RA6XJwc69D7JxXKsz7Pm7hzoSEI+R8SZFqM0Kj+pnXAcIGKFNAaiJg6a1T6g45Z0OL2h
         vHHw==
X-Gm-Message-State: AOJu0Yw6v/Du0YkZQmn0CcCzR5y6oBOj7uZo6cwFviy1tubR4i8hgzgr
        wcdz2QASKJb5jz0a5V8OrO0=
X-Google-Smtp-Source: AGHT+IElLKZVwPAu6e682+Bx3CFjYmJeQt2oOrba7RwzSNyojrJUFpdvUgU4BFXWYYfXsoHxCW65TQ==
X-Received: by 2002:a17:907:804:b0:9be:e278:4d47 with SMTP id wv4-20020a170907080400b009bee2784d47mr1700592ejb.27.1697810221876;
        Fri, 20 Oct 2023 06:57:01 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090611ce00b009b29553b648sm1513371eja.206.2023.10.20.06.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 06:57:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 20 Oct 2023 15:56:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during
 newidle balance
Message-ID: <ZTKHK2EwgOc8y38v@gmail.com>
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org>
 <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDk+awL2RxrRL_4-epj069-iXRbUeSwPH5NYz7ncpVzHA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> Even if your figures look interesting, your patch adds regression in
> the load balance and the fairness.

Indeed - I've removed it from tip:sched/core for the time being.

Thanks,

	Ingo
