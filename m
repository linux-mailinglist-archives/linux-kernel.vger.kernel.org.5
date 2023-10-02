Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328BD7B5AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbjJBTGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJBTGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:06:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E12AC;
        Mon,  2 Oct 2023 12:06:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso11591666b.0;
        Mon, 02 Oct 2023 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696273575; x=1696878375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDwLuB+JnJ/fkY5rfqgAXIgE3qv2mbDu3+kGxrUmSpU=;
        b=Wy5w3GDKGCCUYPQDQDRakluGy25n1ifSpE45YYFnbUmbHUtCDF5ipHmeKWuiaqWdPo
         U53McQCrsAmNqtewcY17qcod2Qnz4jjU/MLV1RulXkSZ/t5C+UXvxnPsjKoK93zxl0bo
         mRYlhrMabFfVFR+fuz/N5DDKAB3aB1jbEmNPOa5zinduftGT+m7t2jYK8Pat+hMtk/An
         vVxYqOfri/XJjHxT8UbIoh9dsHvf4qF3OLhbsDztdS7704a6+XhXgkKeh/lEOOuxKNvb
         BrnCdcA0C2jfHMPFKcWVafX1K4RWyf6Vv+aMTRHSNGuRm8Ntu7hyxkRg5B6kHs+ziqNj
         GdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273575; x=1696878375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDwLuB+JnJ/fkY5rfqgAXIgE3qv2mbDu3+kGxrUmSpU=;
        b=lSkvE8WymTAJRCfPnJgIM7YeVfij/EzNDmEA8ugOsMDpJoBai60B/JAXMN8vaul6Id
         p4eDpYbHsHMjXXhjNGp9Y2xDn9BdqdOSny8GuXMml4bgfvPsq9RKbhFHK1hu2fwn+GZt
         7rgU7dnrJp9azMpo9rjsbJAgY2KT/SIJm+znsLXuCMPApzZ/sy2UN3B0y2xA/qCGLIMd
         tjjzpnK1id0CSeyb4x/vChCfoNqKSPzVBidg1CHQVsUKckKMTtTRnEZNyEZcXWGr6Ykt
         ocjJYRYqTFSzk7K7vsq5uXQFF3C3RKIJPOH8lVhQansq1pWiFIN7YkNSIHqxVWtx2iA4
         OHTw==
X-Gm-Message-State: AOJu0YxjNyOPj5vlNOhpa0EeC4Cy1y3JrPAARHXCD+4q4RzLEk43KMiZ
        jDpU7yWCKcbz0dWg15VHaFc=
X-Google-Smtp-Source: AGHT+IGGDBhYu3bqdE4ZFZC99FhZEPMVjvtefbcAnOccKKeoYTwgZpOg0wyyLyG9Xe9kRlQLIbTrlA==
X-Received: by 2002:a17:906:256:b0:9ae:74d1:4b45 with SMTP id 22-20020a170906025600b009ae74d14b45mr12065034ejl.65.1696273575354;
        Mon, 02 Oct 2023 12:06:15 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id rp5-20020a170906d96500b0098e78ff1a87sm17405863ejb.120.2023.10.02.12.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 12:06:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 2 Oct 2023 21:06:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhiquan Li <zhiquan1.li@intel.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        bp@alien8.de, tony.luck@intel.com, naoya.horiguchi@nec.com,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH RESEND v2] x86/mce: Set PG_hwpoison page flag to avoid
 the capture kernel panic
Message-ID: <ZRsUpM/XtPAE50Rm@gmail.com>
References: <20230914030539.1622477-1-zhiquan1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914030539.1622477-1-zhiquan1.li@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhiquan Li <zhiquan1.li@intel.com> wrote:

> Kdump can exclude the HWPosion page to avoid touch the error page
> again, the prerequisite is the PG_hwpoison page flag is set.
> However, for some MCE fatal error cases, there is no opportunity
> to queue a task for calling memory_failure(), as a result,
> the capture kernel touches the error page again and panics.
> 
> Add function mce_set_page_hwpoison_now() which marks a page as
> HWPoison before kernel panic() for MCE error, so that the dump
> program can check and skip the error page and prevent the capture
> kernel panic.
> 
> [Tony: Changed TestSetPageHWPoison() to SetPageHWPoison()]
> 
> Co-developed-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> ---
> V2 RESEND notes:
> - No changes on this, just rebasing as v6.6-rc1 is out.
> - Added the tag from Naoya.
>   Link: https://lore.kernel.org/all/20230719211625.298785-1-tony.luck@intel.com/#t
> 
> Changes since V1:
> - Revised the commit message as per Naoya's suggestion.
> - Replaced "TODO" comment in code with comments based on mailing list
>   discussion on the lack of value in covering other page types.
>   Link: https://lore.kernel.org/all/20230127015030.30074-1-tony.luck@intel.com/
> ---
>  arch/x86/kernel/cpu/mce/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 6f35f724cc14..2725698268f3 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -156,6 +156,22 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
>  
> +/*
> + * Kdump can exclude the HWPosion page to avoid touch the error page again,
> + * the prerequisite is the PG_hwpoison page flag is set. However, for some
> + * MCE fatal error cases, there are no opportunity to queue a task
> + * for calling memory_failure(), as a result, the capture kernel panics.
> + * This function marks the page as HWPoison before kernel panic() for MCE.
> + */

The English in this commit is *atrocious*, both in the changelog and in
the comments - how on Earth did 'Posion' typo and half a dozen other typos
and bad grammar survive ~3 iterations and a Reviewed-by tag??

The version below fixes up the worst, but I suspect that's not the only problem
with this patch...

Thanks,

	Ingo

================>
From: Zhiquan Li <zhiquan1.li@intel.com>
Date: Thu, 14 Sep 2023 11:05:39 +0800
Subject: [PATCH] x86/mce: Set PG_hwpoison page flag to avoid the capture kernel panic

Kdump can exclude the HWPoison page to avoid touching the error page
again, the prerequisite is the PG_hwpoison page flag is set.

However, for some MCE fatal error cases, there is no opportunity
to queue a task for calling memory_failure(), and as a result,
the capture kernel touches the error page again and panics.

Add the mce_set_page_hwpoison_now() function, which marks a page as
HWPoison before kernel panic() for MCE error, so that the dump
program can check and skip the error page and prevent the capture
kernel panic.

[ Tony: Changed TestSetPageHWPoison() to SetPageHWPoison() ]
[ mingo: Fixed the comments & changelog ]

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lore.kernel.org/all/20230719211625.298785-1-tony.luck@intel.com/#t
---
 arch/x86/kernel/cpu/mce/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f724cc14..1a14e8233c5a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -156,6 +156,22 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
+/*
+ * Kdump can exclude the HWPoison page to avoid touching the error page again,
+ * the prerequisite is that the PG_hwpoison page flag is set. However, for some
+ * MCE fatal error cases, there is no opportunity to queue a task
+ * for calling memory_failure(), and as a result, the capture kernel panics.
+ * This function marks the page as HWPoison before kernel panic() for MCE.
+ */
+static void mce_set_page_hwpoison_now(unsigned long pfn)
+{
+	struct page *p;
+
+	p = pfn_to_online_page(pfn);
+	if (p)
+		SetPageHWPoison(p);
+}
+
 static void __print_mce(struct mce *m)
 {
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
@@ -286,6 +302,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+		if (final && (final->status & MCI_STATUS_ADDRV))
+			mce_set_page_hwpoison_now(final->addr >> PAGE_SHIFT);
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
