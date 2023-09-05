Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D49A792F47
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbjIETve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjIETva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:51:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D8FBE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:51:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so28666915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693943483; x=1694548283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJYAcQwFsTu5wp90zpyT0x1iool+m0LCHUeIwLSnZnY=;
        b=X+HSQm+fh9KTXrGoPBTve1EdNyZIqllgZE7fLRCsimh4BDRoD7woRhZWBC8cBZ6Sse
         mZIpWR+De3eKI8EwEc2PPymCRGoDmzph40GfTTAVXMuwkXxJn16KWrkSS1bwfhnc078V
         XI8xMxLvYobtOyP0w7GvaWJQdKUTu5UUhuPwO/u0/Nt1O7C57bRy3OhWue+g+fRPzotM
         6/CnK0Hs0AWbSZR5mo13Uu2rWRu023+MxHm1XrMyTDRNqq3bwF+6Fz6CvEFotwDtCkSs
         eW73EqT+8CRnxyIR3Ftdkazb0JFBDFZ8IGBrg+7XhShB3IrxvpIPONJTROyV9Yye5h4Q
         54rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693943483; x=1694548283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJYAcQwFsTu5wp90zpyT0x1iool+m0LCHUeIwLSnZnY=;
        b=IvU71w0kXmX7QAm4jV5yK6+yUbhZVPwjdkTHMVvFqXSOb8PRR++ftFBWvaYFXPAckZ
         HLk1J5e+Dz60gWquIgKnZxp7ealruWexht6VgLQJSJjyXinXksqGMn3RQJbzSLfsYmd9
         6VLAwkwN2i4zmDgy/xP4nnIONzJRy7LSXU0BbLnvuNfJWj72EN+WAFTvRLuODpnlUmsR
         I7QVyRiCkTcp0/yMAyXMYUtMTKvNo/wJpej21k2yByqf4utLEDrZF7ow2K6eK2ARSGg1
         wwXNua7/BhREf4BlaGKDZ0Xy1k2Bl/E3rWwwR1RGi0OPlSBv0MQpHWjmiWoEeF/e/U2U
         Fsuw==
X-Gm-Message-State: AOJu0Ywsr4DEGXlJ8Q+ruiZ11B1gIY0/B/xj0x25mbbn7qZAKYfR+1MG
        8VLf63fU0jemMn4YuSsqdZVwQQkTvVM=
X-Google-Smtp-Source: AGHT+IEjfGn92Cp60YCuP+ifP2NOmKxILRiEHLBeOKQNX5q4vsTNprZFSWRupkmEKtNcZqsKQRHGVA==
X-Received: by 2002:a05:600c:2349:b0:3fb:c9f4:1506 with SMTP id 9-20020a05600c234900b003fbc9f41506mr611529wmq.1.1693943482915;
        Tue, 05 Sep 2023 12:51:22 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id dd8-20020a0560001e8800b0031f5f0d0be0sm375039wrb.31.2023.09.05.12.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 12:51:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 5 Sep 2023 21:51:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Yunying Sun <yunying.sun@intel.com>
Subject: Re: [PATCH V2] perf/x86/uncore: Correct the number of CHAs on EMR
Message-ID: <ZPeGuCJ9xWF+EGHY@gmail.com>
References: <20230905134248.496114-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905134248.496114-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Starting from SPR, the basic uncore PMON information is retrieved from
> the discovery table (resides in an MMIO space populated by BIOS). It is
> called the discovery method. The existing value of the type->num_boxes
> is from the discovery table.
> 
> On some SPR variants, there is a firmware bug. So the value from the
> discovery table is incorrect. We use the value from the
> SPR_MSR_UNC_CBO_CONFIG to replace the one from the discovery table.
> Commit 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
> 
> Unfortunately, the SPR_MSR_UNC_CBO_CONFIG isn't available for the EMR
> XCC (Always returns 0). But the above firmware bug
> doesn't impact the EMR XCC. Don't let the value from the MSR replace
> the existing value from the discovery table.
> 
> Fixes: 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
> Reported-by: Stephane Eranian <eranian@google.com>
> Reported-by: Yunying Sun <yunying.sun@intel.com>
> Tested-by: Yunying Sun <yunying.sun@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 4d349986f76a..8250f0f59c2b 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6474,8 +6474,18 @@ void spr_uncore_cpu_init(void)
>  
>  	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
>  	if (type) {
> +		/*
> +		 * The value from the discovery table (stored in the type->num_boxes
> +		 * of UNCORE_SPR_CHA) is incorrect on some SPR variants because of a
> +		 * firmware bug. Using the value from SPR_MSR_UNC_CBO_CONFIG to replace it.
> +		 */
>  		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
> -		type->num_boxes = num_cbo;
> +		/*
> +		 * The MSR doesn't work on the EMR XCC, but the firmware bug doesn't impact
> +		 * the EMR XCC. Don't let the value from the MSR replace the existing value.
> +		 */
> +		if (num_cbo)
> +			type->num_boxes = num_cbo;

Thank you, that's a perfect description of the quirk - applied to 
tip:perf/urgent.

	Ingo
