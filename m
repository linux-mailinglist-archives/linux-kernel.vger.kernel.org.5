Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1E7CD6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjJRIlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjJRIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:41:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57972B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:41:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9becde9ea7bso828078966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697618501; x=1698223301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5j08sK/r8dFrkgO6zW5CZRHYVk2k1ep5qeNC5sEjjQ=;
        b=CUYw7sx1xQMIArhz00gdDuOKpfs6iPlGO/Zb4QDTFg5lpB+ca7u5LsBYYOSFYdh5a4
         KrRHLkEcJIuQXYFIJyFGscCU0vweRjwohSA+y0duZJGZnPwjgkAOpluAgpbvND9T/UBn
         xmWlCdZIzpScxwetPJco8aVwgA2vBrwvAvwfU0sW8OFbdgBR/Ivm6pMsVkgWMEI1O3n4
         P6FOkzQTLHZxwe9cQ0mCB7YJTF53LAYcKsOeeFMfw/kBuQENcMuHzOZ1uki8QnqDe55T
         Nk5M2CZ+sgCJzxDLE2jdIF9+UVo6jtknfO3vMA8zkiWgDq5O+lR9GWSlpeqYLSPrMI9X
         aUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618501; x=1698223301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5j08sK/r8dFrkgO6zW5CZRHYVk2k1ep5qeNC5sEjjQ=;
        b=hIaYGuPj2q4GyjK1Usj+DyI/3x5yKRDP3Stch9TZkcKmc27quVDVxOaod0QQcXRfW/
         RvFIyo5iPsMYoIAF9dNt284EUU8SycBCrKqnw5EcSLuYheQqz1Hc/TJo5axWaOkJu1bE
         9VwpLLTLngPX/gtbNfSQYgbR3l/21iPIRCexYh2FkoQzhURBKAARSiR9exuNFOif98XC
         XW1hygC9XYdR/sbQaetFCm5AcBMprOlBUzrHJQIGZFODpYM38Rt2O64E7LcuQOLi3JLX
         aD6F4YIe6FZMIzJxic+RMPeE2g9eGvwJ3g6MrzgqCciOlZHOsT855KZ8i4ax5S6VTfA6
         UHWA==
X-Gm-Message-State: AOJu0YznMBD5R6n7lLnToXwzC5PWV4AJBCke/ctnpKw2SDTC9JfK9tkr
        HemX+a9QEaqvyPmqNoPExk4=
X-Google-Smtp-Source: AGHT+IFb6c184Yz/AwwBkUufHqMYA7fdjGFaoZ2zZpDS4j7L6pE8/YVvL5fjZpfiytn3LUq73VDIPQ==
X-Received: by 2002:a17:907:7293:b0:9ae:5df2:2291 with SMTP id dt19-20020a170907729300b009ae5df22291mr3813268ejc.1.1697618500572;
        Wed, 18 Oct 2023 01:41:40 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id os20-20020a170906af7400b009ad89697c86sm1224361ejb.144.2023.10.18.01.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:41:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 10:41:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jgross@suse.com, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] x86/mtrr: Remove redundant code
Message-ID: <ZS+aQbKkNRKKFoQa@gmail.com>
References: <20231018074155.68775-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018074155.68775-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> arch/x86/kernel/cpu/mtrr/cleanup.c:943:4: warning: Value stored to 'highest_pfn' is never read.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6912
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/mtrr/cleanup.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
> index 18cf79d6e2c5..c4ec295cebbc 100644
> --- a/arch/x86/kernel/cpu/mtrr/cleanup.c
> +++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
> @@ -939,8 +939,6 @@ int __init mtrr_trim_uncached_memory(unsigned long end_pfn)
>  	if (mtrr_tom2) {
>  		range[nr_range].start = (1ULL<<(32 - PAGE_SHIFT));
>  		range[nr_range].end = mtrr_tom2 >> PAGE_SHIFT;
> -		if (highest_pfn < range[nr_range].end)
> -			highest_pfn = range[nr_range].end;
>  		nr_range++;
>  	}
>  	nr_range = x86_get_mtrr_mem_range(range, nr_range, 0, 0);

Please explain in the changelog how that redundant code got there and why 
there's no underlying bug to be concerned about.

[ I just did that myself and could share the results - but this kind of 
  analysis has to be done when submitting "cleanup" patches changing such 
  type of code ... or at least it has to be flagged, not just mindlessly 
  removing code ... ]

Thanks,

	Ingo
