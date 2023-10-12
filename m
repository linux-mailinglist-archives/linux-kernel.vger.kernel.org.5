Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089267C75B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379677AbjJLSMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjJLSMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:12:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF15A9;
        Thu, 12 Oct 2023 11:12:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so2381955a12.2;
        Thu, 12 Oct 2023 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697134325; x=1697739125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hy/bAuBfATkHRW5izUrrcGF64RAX2eLtYd6RZEYI7j0=;
        b=mIiLE9M/8W7kdVzdwRVIXEQJbISuQME+4DB+4Qmj0V68xzoelIZKT4c4Pbgwpd2T/D
         BN4tLjf0JeHBDwK8HgwBpKbJlFbXo7fOzZNiuIc5NScO5184MBlahpgAM962Yv1WnMRi
         LdiEieuu18ZMoObEW74BN67L5c5M0FD6Wcdf4Zgkynoi34UDcRV5+Q66PF3WlMgo3uFK
         tzfVTLk6S6Asa1JcyTf70T9xbX/TzzL2kd6+hCBlAdQTmaRTvFG7O1/L16CwhhDDViwq
         JpOf84ubeG3Zz5EsuHbOLOC6bQGYSTGFKTe/TH8JZANSAawqycceA9SPOntKDjXMiEh7
         tQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697134325; x=1697739125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy/bAuBfATkHRW5izUrrcGF64RAX2eLtYd6RZEYI7j0=;
        b=fY8To9OzqTLGxia4MikErN46/jZyTR1LeZ4DmAfuWIVKiyDXUrmm/GVcuqW1aLl92O
         dKKDk0JfTCN/8Mbw3fVfRTMBag8MQMGSvZJ1NhU8t+W3MvVOZoF4zPoLErIN21uutaON
         3qjqcXDoMyOv46KqYsLerhE/2FOM1lfbRDCIb9dnaRz25viIYaLTCRwVz0GzUOdjlN+P
         Ji8Qg2JXkwohJR37lUmAJenQCSFTIW6d6Z5goLtK5jsAtw4gD/RzLdLABEWVNnjTSbIb
         O6GJIPjzzOCOFHZYaIxotG8GaXnYERovT30aheswWRQophhvJd72nMgNS7NemVIswH0c
         IkAg==
X-Gm-Message-State: AOJu0YzGh2EmQOhhVGUmqWyVYER2eYEr8W1F1CE9byWdTXhU4Wyy1yuL
        q1rvxwcHXGDdt6VBYZw8founi0NDA54=
X-Google-Smtp-Source: AGHT+IEXmwzIprBVN84eK3SxZakrj0dQ40BnI06rW5q0/QxIsB0obN2KTFBMKIitIRKKwuyLK6Kehw==
X-Received: by 2002:aa7:df0e:0:b0:52c:8a13:2126 with SMTP id c14-20020aa7df0e000000b0052c8a132126mr22162739edy.37.1697134324630;
        Thu, 12 Oct 2023 11:12:04 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id s9-20020a05640217c900b0053d9a862e2csm3598225edy.56.2023.10.12.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 11:12:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 20:12:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        rene@exactcode.de, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/cpu: Fix the AMD Fam 17h, Fam 19h, Zen2 and Zen4
 enumerations
Message-ID: <ZSg28on6W4YB47y+@gmail.com>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
 <169701622768.3135.17489375930381616520.tip-bot2@tip-bot2>
 <ZScTem8iF8CUZqf6@gmail.com>
 <20231012074051.GBZSejA6bTV53638DE@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012074051.GBZSejA6bTV53638DE@fat_crate.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Oct 11, 2023 at 11:28:26PM +0200, Ingo Molnar wrote:
> > While in reality:
> > 
> >    Zen 2 == Fam 17h
> >    Zen 4 == Fam 19h
> 
> If only were that easy...
> 
> family 0x17 is Zen1 and 2, family 0x19 is spread around Zen 3 and 4.
>
...
> See above. The MSRs are per Zen generation while the family is per
> family. Yes, it is confusing. :-\

Fun!
 
> IOW, you want to have this as the end product:
> 
> /* Zen4 */
> #define MSR_ZEN4_BP_CFG                 0xc001102e
> #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
> 
> /* Fam 19h MSRs */
> #define MSR_F19H_UMC_PERF_CTL           0xc0010800
> #define MSR_F19H_UMC_PERF_CTR           0xc0010801
> 
> /* Zen 2 */
> #define MSR_ZEN2_SPECTRAL_CHICKEN       0xc00110e3
> #define MSR_ZEN2_SPECTRAL_CHICKEN_BIT   BIT_ULL(1)
> 
> /* Fam 17h MSRs */
> #define MSR_F17H_IRPERF			0xc00000e9

Ok, thanks - I've distilled your enumeration order into the separate
patch below - there's more commits in perf/core meanwhile, and maybe
it isn't even bad there's a bit of a spotlight on the naming
scheme here.

I've turned your above grouping & comments into a patch, created a 
changelog and added your SOB, see the perf/core commit below.
Lemme know if that's not OK to you.

Thanks,

	Ingo

=============>
From: Borislav Petkov <bp@alien8.de>
Date: Thu, 12 Oct 2023 20:01:59 +0200
Subject: [PATCH] x86/cpu: Fix the AMD Fam 17h, Fam 19h, Zen2 and Zen4 MSR enumerations

The comments introduced in <asm/msr-index.h> in the merge conflict fixup in:

  8f4156d58713 ("Merge branch 'x86/urgent' into perf/core, to resolve conflict")

... aren't right: AMD naming schemes are more complex than implied,
family 0x17 is Zen1 and 2, family 0x19 is spread around Zen 3 and 4.

So there's indeed four separate MSR namespaces for:

  MSR_F17H_
  MSR_F19H_
  MSR_ZEN2_
  MSR_ZEN4_

... and the namespaces cannot be merged.

Fix it up. No change in functionality.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com
---
 arch/x86/include/asm/msr-index.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 0ad9ba8baa8a..f8b502867dd1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -637,18 +637,20 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-/* Fam 19h (Zen 4) MSRs */
-#define MSR_F19H_UMC_PERF_CTL		0xc0010800
-#define MSR_F19H_UMC_PERF_CTR		0xc0010801
-
-#define MSR_ZEN4_BP_CFG			0xc001102e
+/* Zen4 */
+#define MSR_ZEN4_BP_CFG                 0xc001102e
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
-/* Fam 17h (Zen 2) MSRs */
-#define MSR_F17H_IRPERF			0xc00000e9
+/* Fam 19h MSRs */
+#define MSR_F19H_UMC_PERF_CTL           0xc0010800
+#define MSR_F19H_UMC_PERF_CTR           0xc0010801
 
-#define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
-#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
+/* Zen 2 */
+#define MSR_ZEN2_SPECTRAL_CHICKEN       0xc00110e3
+#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT   BIT_ULL(1)
+
+/* Fam 17h MSRs */
+#define MSR_F17H_IRPERF			0xc00000e9
 
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
