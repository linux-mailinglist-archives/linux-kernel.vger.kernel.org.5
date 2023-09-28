Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E67B16E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjI1JMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjI1JMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:12:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9487BAC;
        Thu, 28 Sep 2023 02:11:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-533df112914so10959889a12.0;
        Thu, 28 Sep 2023 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695892317; x=1696497117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Brc/POnVljwtPzRtlqMvgIaGf84HfKdQiP/5OunVW6c=;
        b=Gbilb24IS6Df6CizuMC9ol13s1M+rZRwDw67OyDvf0+3wh2C/53GGi8yCku7qIwHHp
         trv0sU6vn4Ha9HoxrLDlK6J4ICIvCpQ3gjAswgVs7Qt8JuqMBC8BPEryyFmYGYeOBqnw
         fzgM3QS93uX3I1koOu/UAcKip1TicobNNV5KcsErA/uuKA1fiEskRcObihXxPvdoYr+n
         6RMKKObGroabvnEFxV/Aun5kASX6Yb1neQn9uK2P6klpOx6IkQY4fzo2SV5Fz3I06Rq/
         fEnlkASsA9PPmiWqoUTVksF2G6YYQkZ7yd8cigBbFrVupQ5ZZWPcbDECrTxW10rGr9Rm
         jwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892317; x=1696497117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Brc/POnVljwtPzRtlqMvgIaGf84HfKdQiP/5OunVW6c=;
        b=U0yVR16TeMNiNzIng7HVNZkochJD6QXOiqiZMUoe6ybYbUPR1HRWE758N/8K+vAeao
         gOqgunR6WGCvqIqMsHJ2Anag7O/ac5ETotwoujjOtiOx+0UhlvILuB66F0oKb+fBWtfv
         7S1r+sZQbhdKjlcPavYFL7LUiRZHYSkI0ltIS3WHv2LEIBf2fVddc5g9RIjiQN+cKon9
         SjgsSMHxeiVAJWs02Ak1ZnVscybbw08/L54ebaGzEWRjl6Zs0lgjG/yQg3p3CmYoJfIW
         ndi8ftzJ0Q9T9hNqiNNQNDF/YalZ0Zu2ovkTpHXeOAq3tT9cd4WJJofnmcgTONqFgDHK
         O9Ng==
X-Gm-Message-State: AOJu0Yx0H+lEYTOBhW2v8P/3V/D1IWbjKJ/lqw4HkjBrTNZvIrkSUR12
        nKlXIDlUiK0Rb+W+Q2SwXTkIIe7jCEw=
X-Google-Smtp-Source: AGHT+IGYmPodVsPFAEXVbZmP3yNwy6N7YT1n3pbkCv4euWCuA5NpfvbgVHSd1DTJT5srjSEpvjwvEw==
X-Received: by 2002:a05:6402:1850:b0:522:1d23:a1f8 with SMTP id v16-20020a056402185000b005221d23a1f8mr592910edy.26.1695892316632;
        Thu, 28 Sep 2023 02:11:56 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id q6-20020aa7da86000000b005307e75d24dsm9296894eds.17.2023.09.28.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:11:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 11:11:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] tick/nohz: Update comments some more
Message-ID: <ZRVDWtcltu+QUW4+@gmail.com>
References: <20230912104406.312185-3-frederic@kernel.org>
 <169582689118.27769.11953848930688373230.tip-bot2@tip-bot2>
 <ZRVCNeMcSQcXS36N@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRVCNeMcSQcXS36N@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > + * infrastructure actually relies on the tick itself as a backend in
> > + * low-resolution mode (see hrtimer_run_queues()).
> > + *
> > + * This low-resolution handler still makes use of some hrtimer APIs meanwhile
> > + * for commodity with expiration calculation and forwarding.
> 
> commodity?

I presume 'commonality' was intended here?

Thanks,

	Ingo
