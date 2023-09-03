Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D670790B43
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbjICIlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 04:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjICIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 04:41:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4CE91
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 01:41:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so4699845e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693730461; x=1694335261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9NbmmPLRSRY6DMIqUwVh2a4ddDuws7H3iJDQPyNnGU=;
        b=FsP7TV8feah8/h5IVkA58G5aExOqnt6vyv5IziAaYvgYR8A4+mATAfAmIxMXw4bJt5
         xgWRewS3z+BG5mLC5zMLaiZWtgd/h6dXfrsPTFx1n84kbLixVDlGmzgJOE34tHyo+9b5
         n8c2Ff6M+WEbVJmK1p6jXHBNvyhM/Fp6K9IKXbnjNLp3EqQnimIl4ckE2NNZYRRrBUDW
         6F5Ffwor88m8HbYDolb2s6qnEQOkP0Iv4ehhQnuI4Jdhhbv9ynNZdQ1ZRCwt/8QQVI3l
         72UcxEkF6vaYzZy247NI6JWvXUelYjCbl3YtzL7Z0c6oLEnSOPZv6iup4qk0kqCBN/Uq
         sUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693730461; x=1694335261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9NbmmPLRSRY6DMIqUwVh2a4ddDuws7H3iJDQPyNnGU=;
        b=L5S0PeSaNgrfksh+BjJOC5o3HP96d2Zp2agCasIgO8El5lkonnRkV03kssgp8pzEce
         vTsBjHACLiJrOa7zBdU63RnnkdNiulAStES17NDdpRPP4BBd58GGYEGIafaSKDKNQKBP
         /tJjgCqaSWPE+/f00cxSYj/RYc1G+8HtFfv84Vu0jMoUB49Ex3CkDOCW0fCLmpoeNyx5
         Gxb0FfvzX0flVdPOWIa3orI7B6d4AhGmziVZC0CtorbHJpP4qj2vacHvuNE2gthn27V5
         XVdsq4CGnurDlPuTlRgX7zvNtWxGsVuAKLBkTs08J+4ytiMfqsbsId7RQtESp9Uy5qZZ
         y5vg==
X-Gm-Message-State: AOJu0Yx9Fhy8XZpGucsTst8U73UV1oTDlZ9BbsIFCjvi1D4DfNOgzR67
        acMQDXj066psDNmw/U9Buuc=
X-Google-Smtp-Source: AGHT+IHDSlb9tPUncHMzGV+clFT/OwmInh9rwaV45NUgP5GJ4oK7yvQAUT2kPc43OSF0lSizvT1CUQ==
X-Received: by 2002:a5d:4f01:0:b0:314:36c5:e4c0 with SMTP id c1-20020a5d4f01000000b0031436c5e4c0mr4379022wru.11.1693730460824;
        Sun, 03 Sep 2023 01:41:00 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d4288000000b003176aa612b1sm11089465wrq.38.2023.09.03.01.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 01:41:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 3 Sep 2023 10:40:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Yunying Sun <yunying.sun@intel.com>
Subject: Re: [PATCH] perf/x86/uncore: Correct the number of CHAs on EMR
Message-ID: <ZPRGmoXKvOCFrK26@gmail.com>
References: <20230901142028.298051-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901142028.298051-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The MSR UNC_CBO_CONFIG, which was used to detect the number of CHAs on
> SPR, is broken on EMR XCC. It always returns 0.
> 
> Roll back to the discovery method, which can give the correct number for
> this case.
> 
> Fixes: 38776cc45eb7 ("perf/x86/uncore: Correct the number of CHAs on SPR")
> Reported-by: Stephane Eranian <eranian@google.com>
> Reported-by: Yunying Sun <yunying.sun@intel.com>
> Tested-by: Yunying Sun <yunying.sun@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index d49e90dc04a4..c41d7d46481c 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6475,7 +6475,9 @@ void spr_uncore_cpu_init(void)
>  	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
>  	if (type) {
>  		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
> -		type->num_boxes = num_cbo;
> +		/* The MSR doesn't work on the EMR XCC. Roll back to the discovery method. */
> +		if (num_cbo)
> +			type->num_boxes = num_cbo;

So in the zero case we don't write type->num_boxes and leave it as-is.

How does this fall back to the discovery method, is the existing (default?) 
value of type->num_boxes some special value?

Thanks,

	Ingo
