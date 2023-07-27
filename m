Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5942764D97
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjG0IgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjG0If5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:35:57 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD649E8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:19:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C47B13200909;
        Thu, 27 Jul 2023 04:18:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 27 Jul 2023 04:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690445939; x=1690532339; bh=hn
        g3WZRTtWy/pum5YHKA8yoijDvQq1MS4/4YMQFGEqA=; b=cdaXIRWdK0xAlMtH4d
        F7OUmA9U3BBKaCph5NtQIsSqdRMvDzuFTYjqNLCsUJ4tbDI0MstNnAkDvt60ItGc
        sOtUVA4GOCXezkdhGuaGX4RpuEKldn65pJEaqsnfIFFlpUMUGFlrgv1QmDbkbdZM
        3VHkTgdWtHG67OquuQ6HYFtDsL/NFCxcKEb3saTajR5GC7WAH2opmLVGc59B5CK/
        1M5VU4Lo0EcA4S3SLImkf5Ofk3UZUc1sGY79BxI8BSSVkmWuVspLJ5lzH1mV8als
        H3Upf4dt8rN4GHUi9A+7FbnVV0hcfk4QrvGHMXqEh+WpnBQL8JYilm9z2gN9iv+o
        GrxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690445939; x=1690532339; bh=hng3WZRTtWy/p
        um5YHKA8yoijDvQq1MS4/4YMQFGEqA=; b=AiZoeFwLuVJnTumxa/nBMbr9jULO9
        mjDkeTQuCmr8csl4JRFjNc9L1pKXghFxBcEMbS7dNyo074Ise+xJnyqdzfuTnygp
        oGjnmdd6JVTejm5UNd+S9lv3JrHB3dRj06F/EsQ3dMYg6UaNnhLcaNJQqPLZS+sw
        dOhpDFgxO4NsBYCcvJN0Rdd9uujs+fXFzjUB3I0TvMlkj+8vX9qqA8YXAIdVLnfa
        dCzWQIOtXGYrf77IWMxNFOLeHsm0n9SB5YIcA/uA/7jXMBfwliepIMtl8BJ9MSXN
        axrpgbA/6AXln0kPxHXSMGsUHAGlBUFd5Pp94Jm3dUo5jcHx/279EeXdw==
X-ME-Sender: <xms:cyjCZBjWSSI3Cwzwu2qw6cK8sJABqp4Vihezk2jVSCWJTGfHrNGVsg>
    <xme:cyjCZGDU32U26_MPbc1dHePkZ936wPWxZfdeLQSO7uSpX__Ev0gFEz_t8s0K4TyBI
    qfUXqSnVOVzAlTVmZo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieefgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cyjCZBEF_HjECq_DzOo0-miZPjjEFswujBrjUP7y7CxZTIVCVbdTNg>
    <xmx:cyjCZGTaap5Uh__RZPUioMceYfh5EMhCjUap0q0_efMDLRihNfgOag>
    <xmx:cyjCZOyYKLxYp96a7DzOst4XqGBDNwHcvq1zOaExkqPv-Qxwe8hRGw>
    <xmx:cyjCZDpONZHbOhZgtl_QeFCTBEWhHXnZ6xspajM_4w0qOZNMkNRTGQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 06D8DB60089; Thu, 27 Jul 2023 04:18:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <95ce8aa7-46fc-405c-acec-e94e8f93d186@app.fastmail.com>
In-Reply-To: <ZMG4kw3k1cCGTL2L@MiWiFi-R3L-srv>
References: <20230726145432.1617809-1-arnd@kernel.org>
 <ZMG4kw3k1cCGTL2L@MiWiFi-R3L-srv>
Date:   Thu, 27 Jul 2023 10:18:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomem: remove __weak ioremap_cache helper
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023, at 02:21, Baoquan He wrote:
> On 07/26/23 at 04:54pm, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> No portable code calls into this function any more, and on
>> architectures that don't use or define their own, it causes
>> a warning:
>> 
>> kernel/iomem.c:10:22: warning: no previous prototype for 'ioremap_cache' [-Wmissing-prototypes]
>>    10 | __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
>> 
>> Fold it into the only caller that uses it on architectures
>> without the #define.
>> 
>> Note that the fallback to ioremap is probably still wrong on
>> those architectures, but this is what it's always done there.
>
> Do we need to add a definition of ioremap_cache in asm-generic/io.h like
> ioremap_wc|wt?
>
> #ifndef ioremap_cache
> #define ioremap_cahce ioremap
> #endif

No, we really want to eliminate ioremap_cache() from the API,
not make it more visible.

> Unless it's for sure that drivers calling ioremap_cache are only built in
> on those architecures defining it. Or we just want to see the breakage
> on those ARCH-es so that they will add their own definition.

Right now, it's only possible to call ioremap_cache() on the couple
of architectures that explicitly declare this in their asm/io.h header
(arm, arm64, ia64, loongarch, mips, powerpc, sh, x86, and xtensa).

I think we could also go ahead and remove it from sh and xtensa.

> Not sure if I missed anything when understanding this.
>
> drivers/acpi/apei/bert.c:       boot_error_region = 
> ioremap_cache(bert_tab->address, region_len);
> drivers/acpi/apei/einj.c:       trigger_tab = 
> ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
> drivers/acpi/apei/einj.c:       trigger_tab = 
> ioremap_cache(trigger_paddr, table_size);
> drivers/acpi/apei/erst.c:       erst_erange.vaddr = 
> ioremap_cache(erst_erange.base,
> include/acpi/acpi_io.h:       return ioremap_cache(phys, size);

acpi is used on x86, arm64 ia64, and loongarch

> drivers/firmware/meson/meson_sm.c:      return 
> ioremap_cache(sm_phy_base, size);

arm/arm64 specific

> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:                
> adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
> drivers/gpu/drm/hyperv/hyperv_drm_drv.c:        hv->vram = 
> ioremap_cache(hv->mem->start, hv->fb_size);
> drivers/gpu/drm/ttm/ttm_bo_util.c:                      map->virtual = 
> ioremap_cache(res, size);
> drivers/gpu/drm/ttm/ttm_bo_util.c:                      vaddr_iomem = 
> ioremap_cache(mem->bus.offset,

All guardeded with an x86 check

> drivers/hv/hv.c:                /* Mask out vTOM bit. ioremap_cache() 
> maps decrypted */
> drivers/hv/hv.c:                        = (void *)ioremap_cache(base, 
> HV_HYP_PAGE_SIZE);
> drivers/hv/hv.c:                /* Mask out vTOM bit. ioremap_cache() 
> maps decrypted */
> drivers/hv/hv.c:                        = (void *)ioremap_cache(base, 
> HV_HYP_PAGE_SIZE);
> drivers/video/fbdev/hyperv_fb.c:        fb_virt = 
> ioremap_cache(par->mem->start, screen_fb_size);

x86 and arm64 specific

> drivers/mtd/devices/bcm47xxsflash.c:            b47s->window = 
> ioremap_cache(res->start, resource_size(res));
> drivers/mtd/maps/pxa2xx-flash.c:        info->map.cached = 
> ioremap_cache(info->map.phys, info->map.size);
> drivers/soc/fsl/qbman/qman_ccsr.c:      void __iomem *tmpp = 
> ioremap_cache(addr, sz);

arm/arm64 specific.

There is also one more caller in mips that gets used by dmi:

arch/mips/include/asm/dmi.h:#define dmi_early_remap(x, l)		ioremap_cache(x, l)
arch/mips/include/asm/dmi.h:#define dmi_remap(x, l)			ioremap_cache(x, l)

      Arnd
