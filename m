Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3F7BD8F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbjJIKtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjJIKtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:49:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37126C5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:49:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-325e9cd483eso4192367f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696848587; x=1697453387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKtWavYyFClcZGohPOMOZVJYNqsc7CwB/QFcdwuBR4s=;
        b=YDHxlL9+lP+Ncndxco9mYfZjF8f0eyldfRLMbH3sWBxEFoZo6oYXmBGhaWCVrrXrxP
         d9GJOIUNH+19BWyPOh+FBqZgNcLoJ2mjX6D9IRNvOW0ok+tCgg1nWmYnA8wpiIOnpVcj
         4ae4OYyWGLcMGwzs3fBo+utuZ9AGrbkdsfYi5DWLSQmL8/nBTTVsfIfdY9ZKyhk0o4pA
         74dHti748xbkoxCJj7zQTgkr2rwtnrAO0KrYEiuxXZKnMMBe2V8ZTy4jJEId9FWPiw9N
         7o8ETrmWxRwhcS2NPSqcVvluvlxL4a7hhuCAj0h8XTuqK/DqqWzCuWVGszhlTcNyfG5N
         ptGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696848587; x=1697453387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKtWavYyFClcZGohPOMOZVJYNqsc7CwB/QFcdwuBR4s=;
        b=AvJzh4i/Z62/ylnB4+7ek1xg8a1w1lpQHf/CWvAorroMOqkefjqO30nPhco1ZNnLUi
         A45vZo9EcTXq0C4a+z7IQRwb2hnj6YzMsKCmDJbjReEzLO5MOIJflzFTaNlewqMbi3xq
         34kQzKa2Nn9+XrUXA8KcvGXcltyi9CbCNBKCnEBalUelBZ9ovDUoKpT53UnKkzwcvAom
         hZ2hSsKPVv3Tc44MAgzBf6GQnioh/40+S7EdFVhpDMLnkAnHAUYCqIFmDe2/lOhCzQBA
         JJkxlb/v9+9of0Km2FrKhFZkSUcbXm1HBSFreqQtn5kIT5R/5cn1KHzMxQcODIWoJgni
         cwPA==
X-Gm-Message-State: AOJu0Yxp4lX4DZ/ZnH8XLE5BhD69R46UBfuet6cHQPDQ3W7FcL0qaSt3
        5XbCa16ov5aqHqT3yxG2sIg=
X-Google-Smtp-Source: AGHT+IGUV4RdKPA871KM7Ftah2uhiovpB9VBRm40U9BfDo7FHG5CuH15+alSryaHMStdlAiGy74R5Q==
X-Received: by 2002:a05:6000:109:b0:320:9e2:b3a2 with SMTP id o9-20020a056000010900b0032009e2b3a2mr13640879wrx.33.1696848587606;
        Mon, 09 Oct 2023 03:49:47 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b003258934a4bcsm9274428wrp.42.2023.10.09.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:49:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 12:49:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     surenb@google.com, peterz@infradead.org, hannes@cmpxchg.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
Subject: Re: [PATCH linux-next v2] sched/psi: Avoid update triggers and
 rtpoll_total when it is unnecessary
Message-ID: <ZSPayGSz6HQBp+3W@gmail.com>
References: <CAJuCfpHV+Tf+-YqdWFwQNAeQJU5aqOM56R2GzbehFaFQcHuxAg@mail.gmail.com>
 <202310071421311735972@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310071421311735972@zte.com.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* yang.yang29@zte.com.cn <yang.yang29@zte.com.cn> wrote:

> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> When psimon wakes up and there are no state changes for rtpoll_states,
> it's unnecessary to update triggers and rtpoll_total because the pressures
> being monitored by user have not changed. This will help to slightly reduce
> unnecessary computations of psi.
> 
> There are also some minor related optimizations, please see below.
> 
> The parameter update_total in update_triggers() is useless now. Since if
> changed_states & group->rtpoll_states is true, new_stall in update_triggers()
> will be true, then update_total should also be true. We have no need for
> update_total to help judgment whether to update rtpoll_total, so delete
> update_total.
> 
> Update_triggers() always return now + group->rtpoll_min_period, and the
> return value is only used by psi_rtpoll_work(), so change update_triggers()
> to a void function, let group->rtpoll_next_update = now +
> group->rtpoll_min_period directly.

Yeah, so please split this up into 3 patches: one change per patch, even
if each patch is relatively small.

Thanks,

	Ingo
