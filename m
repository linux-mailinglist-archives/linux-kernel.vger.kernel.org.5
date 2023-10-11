Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093927C5F17
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjJKV2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:28:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF739E;
        Wed, 11 Oct 2023 14:28:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae75ece209so45193566b.3;
        Wed, 11 Oct 2023 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697059711; x=1697664511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xi4hRupYAPdxlVps7j6FmsE6VUo3wpqHYU7pBZ7s4FY=;
        b=D0lUgLaEkPd/jkyrZZmb9i+AgShrUinX2P6HRBoYzkXIzFjpuja6471IetqIH4U5Uu
         cbcP+lFq82tXGVP1P0yrxGCcdJwCSC2LXM5suvS56lx+I41/E3E3XCb4DZ5gTcCtEzpT
         u0zfiGSdofiNunlZ8VoSEMgkYqsou6fOmq6ApMy6cCfIcEVOrE8IN1Abeqlwxf9dEeRd
         1QwoKOMprD/hU7r2rU7yzoPMP63O4HBwLzcfGJFwfuCdOC7ZVwhlfPxtcCrPoipzeTUC
         bkZyXs96n4GpGcay9cY3eIwbiyFm531AhOREF3GL2+hxh62zPKai/eGQo6EQ/Ym4gVMR
         86BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059711; x=1697664511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xi4hRupYAPdxlVps7j6FmsE6VUo3wpqHYU7pBZ7s4FY=;
        b=idSl33bHc5aw8PBrawJUcfG3mGloYGZfgFSTmLa9FoF0TENBT+SdonC//s7G85aKuX
         C5KtaIkQxjg7iaJdUWE9OLImWZX660Z9MDzNxsrLHtaSJcThgLr+2upB2fh2SQzx8E1j
         PtTnMawEhTkxoPqB3xWEGsrw4j/etYd9O8T5AqC3hB5ePhkRCPcBOtOuRrMloGnHbn0d
         D/qsrq9VUIFOKcv6RbnAxxVVyKrhwsxfZfuuw1CbfId8htLMwrHhDSOfa4250ZSsWrLG
         Li5uvdhkeo/IyLKYUzgfdgsfF7TKT64hkezPaMKpGUhglexCmAZQ8t5DIsEDhvz6Sx/C
         Y8gw==
X-Gm-Message-State: AOJu0Yza/H+yLRcD4VVHLo9LJDtmY3WiFNyAj3c3JwLocNm+ofvAwM3I
        2+uERL8dGwv7qeZQbqpMg0Is/iyHGa4=
X-Google-Smtp-Source: AGHT+IGirQ45rifXF7Dl5gS6nTPB+N42nlq3bwmEJ9/mSZMAxKhMJ6M7VSarm1Kr6NLuGDlU6fF8fg==
X-Received: by 2002:a17:907:6c14:b0:9ae:588e:142 with SMTP id rl20-20020a1709076c1400b009ae588e0142mr19669529ejc.67.1697059711038;
        Wed, 11 Oct 2023 14:28:31 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b009ad875d12d7sm10157553eja.210.2023.10.11.14.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:28:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 11 Oct 2023 23:28:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, rene@exactcode.de,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip: x86/urgent] x86/cpu: Fix AMD erratum #1485 on Zen4-based
 CPUs
Message-ID: <ZScTem8iF8CUZqf6@gmail.com>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
 <169701622768.3135.17489375930381616520.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169701622768.3135.17489375930381616520.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Borislav Petkov (AMD) <tip-bot2@linutronix.de> wrote:

>  /* AMD Last Branch Record MSRs */
>  #define MSR_AMD64_LBR_SELECT			0xc000010e
>  
> +/* Zen4 */
> +#define MSR_ZEN4_BP_CFG			0xc001102e
> +#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
>  
> +/* Zen 2 */
>  #define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
>  #define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)
>  
> +/* Fam 17h MSRs */
> +#define MSR_F17H_IRPERF			0xc00000e9

Yeah, so these latest AMD MSR definitions in <asm/msr-index.h> are pretty 
confused, they list MSRs in the following order:

   Zen 4
   Zen 2
   Fam 19h         // resolution in tip:master
   Fam 17h

where perf/core added a Fam 19h section a couple of days ago ...

While in reality:

   Zen 2 == Fam 17h
   Zen 4 == Fam 19h

So it's confusing to list these separately and out of order.

So in resolving the conflict in perf/core I updated this section to read:

  /* Fam 19h (Zen 4) MSRs */
  #define MSR_F19H_UMC_PERF_CTL		0xc0010800
  #define MSR_F19H_UMC_PERF_CTR		0xc0010801

  #define MSR_ZEN4_BP_CFG		0xc001102e
  #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5

  /* Fam 17h (Zen 2) MSRs */
  #define MSR_F17H_IRPERF		0xc00000e9

  #define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
  #define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	BIT_ULL(1)

This doesn't change the definitions themselves, only merges the comments 
and the sections, (to keep the Git conflict resolution non-evil), but 
arguably once perf/core goes upstream, we should probably unify the naming 
to follow the existing nomenclature, which is, starting at around F15H, the 
following:

   MSR_F15H_
   MSR_F16H_
   MSR_F17H_
   MSR_F19H_

Or are the MSRs named ZEN2 and ZEN4 in AMD SDMs, which we should follow?

Anyway, something to keep in mind.

Thanks,

	Ingo
