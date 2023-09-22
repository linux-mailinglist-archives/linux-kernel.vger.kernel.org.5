Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB987AB351
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjIVOOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjIVOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:14:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9BBF7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:14:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f1be93bd4so19458307b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695392084; x=1695996884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5SdouEuwealzDWIKT11sTIQU2PskFXEZT/z0WQbWSE=;
        b=xwOd88MTxz6pBwfiqj3GBtGPlfT/7OqtjXRl/K+CwZUIwqWHSdbVeejZ4ac/0yUTkY
         RFvOKc4N6y8sGBk+nPJjjYo2rwzLfBIoan0zKnAAwQzNBEnki43/pNatBwzw7eVAn+Dp
         bR6LBuxbpIcIQss3tjAIHGUjpq2Znfr9B6Gu7FpN9BsgaAtTaeuU0mWEBafIHHbeF670
         VnsdTaoGoTcfV8IjV0Ak/c2pABG98IxPR6yZtfUvr2z1fLe1W5T0JpY8Z9oOzXjEi/RJ
         BULZFY+fzjwgPTk8rpiBIUVpLYUl/X6uee2mPsR90/erBDPtH4RmSK6MOm/3mvL6xl02
         TYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695392084; x=1695996884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5SdouEuwealzDWIKT11sTIQU2PskFXEZT/z0WQbWSE=;
        b=b1SNL2s5wWg4BerqCcJiTBXbtu8nwm3/fMDR+t0J1MeL1B6ZgGwgjzmHIQCAv5GBBo
         AsLW6m+pEUSGn+ZW3cyu/fFJNTCdBmwElrgEoNTdrS4wlkE+BKkeCeJJvU9GvM8HuLl7
         3ZrToGxZvp89imWm1+4i5m/X2eRJyfo8QoSl9GeOpdBs+xO8jTDkzE7SnQhan5ajxFZI
         9P2gcnVtLHh823UXFCyk7D43FEAkC8uIsGoOweqK9Q51furHWzg2EiUXHhD2MdnVLeey
         UKN/G5Ewk3n2R148xR1JrRAC9HQGf6eSqTiZvqLkPAp51qshg7cwXJ4WJzQgjQDow1ZR
         vZeg==
X-Gm-Message-State: AOJu0YzgoK+bCXGp92i3Q6a0+j3nBVHGN+oJ/0rKcKzSbes6WmBV3jRm
        UIOi44alLsrKFPFC+Jy5YUb319q/QhwgJtQgqw==
X-Google-Smtp-Source: AGHT+IHtogp9NjE0VhpUFqQ/Z44IZaJWkFxpQFrQOHjU65PEXgRm7aRgEnFrMDnoMG9nkcHSA7hn699WZKo2dZlg3Q==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:21fc:4594:4831:998b])
 (user=peternewman job=sendgmr) by 2002:a05:6902:100c:b0:d40:932e:f7b1 with
 SMTP id w12-20020a056902100c00b00d40932ef7b1mr142670ybt.7.1695392084431; Fri,
 22 Sep 2023 07:14:44 -0700 (PDT)
Date:   Fri, 22 Sep 2023 16:14:41 +0200
In-Reply-To: <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
Mime-Version: 1.0
References: <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922141441.3353077-1-peternewman@google.com>
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel CAT
From:   Peter Newman <peternewman@google.com>
To:     maciej.wieczor-retman@intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        reinette.chatre@intel.com, tglx@linutronix.de, eranian@google.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Fri, Sep 22, 2023 at 10:48:23AM +0200, Maciej Wieczor-Retman wrote:
> The setting for non-contiguous 1s support in Intel CAT is
> hardcoded to false. On these systems, writing non-contiguous
> 1s into the schemata file will fail before resctrl passes
> the value to the hardware.
> 
> In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
> being reserved and now carry information about non-contiguous 1s
> value support for L3 and L2 cache respectively. The CAT
> capacity bitmask (CBM) supports a non-contiguous 1s value if
> the bit is set.

How new of an SDM do I need? The June 2023 revision I downloaded today didn't
list it.

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..c783a873147c 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
>  	r->cache.cbm_len = 20;
>  	r->cache.shareable_bits = 0xc0000;
>  	r->cache.min_cbm_bits = 2;
> +	r->cache.arch_has_sparse_bitmaps = false;
>  	r->alloc_capable = true;
>  
>  	rdt_alloc_capable = true;
> @@ -267,15 +268,18 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	union cpuid_0x10_1_eax eax;
> +	union cpuid_0x10_x_ecx ecx;
>  	union cpuid_0x10_x_edx edx;
> -	u32 ebx, ecx;
> +	u32 ebx;
>  
> -	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
> +	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>  	hw_res->num_closid = edx.split.cos_max + 1;
>  	r->cache.cbm_len = eax.split.cbm_len + 1;
>  	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>  	r->cache.shareable_bits = ebx & r->default_ctrl;
>  	r->data_width = (r->cache.cbm_len + 3) / 4;
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		r->cache.arch_has_sparse_bitmaps = ecx.split.noncont;

This seems to be called after the clearing of arch_has_sparse_bitmaps in
cache_alloc_hsw_probe(). If we can't make use of the CPUID bit on Haswell,
is it safe to use its value here?

Thanks!
-Peter
