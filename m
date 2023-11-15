Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC747ECA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjKOR5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKOR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:57:08 -0500
Received: from sonic314-19.consmr.mail.gq1.yahoo.com (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3331A8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1700071024; bh=YF2s4xF5SCw6gmmLUOPakvJN8SjfXIcfPpzN9F2wCDs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BCmOSOwKpGksJ+qgav6T+PZAlWXbLvjDFvoge7YjJ95nbkp2AMX2uYObZxRptQTOArnpivIUBLKScJF2W0jEIKXUMP8RQqtVJQRulUffPFWcARHlWFKY2L7jtlAGT2cnVB6hYEz9aGmpCiwJgHm4v0uvc5vUuz9Ja6Ytp2TfxpxLJh3lFs5qzw8NfydOpCwTd8kI9KJCtH6rbkClfnIkEpfk/4tXfveYtHilLJcSCi8hzCxjOVgZ5yki7XgrzKcIWRf7z3FPD6DJGinjxH1n+2aSwvDwqAE/7rChP9lQeBROgB8OyrF2gGdQXH4IZO8ZJ0DIeK76rsMAQX5AFeHQuw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700071024; bh=tZUQH+T6uUeYppUSz3pyuwfs9IOBZqeHgT7YvdwF5AJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kx+C9tc2E+n82NhQQD9iMkwEFzmAUWJBkoo1kKrR0M9dwP91+WaCX0jHT9lcObANY06rtRwyoePM/CpJRpsZT3UscCF7cbaKYVZ0poXvn5Ubpa6zf8Y6iX4Z+b+N8rQZ5I0kIrNy9Mgxl4rLhobMUWE8+RPye8PY2u6w42YuyKexNNA9KXrLO3J5FAGFB4Sv7wCY4bSTCupBKSxCa/flDM4FLNP2Z7XYIw9tFlOOpj+HmMGDYCcSzywkaes4pADtFN7+HLUT3K2PRLkq6pV9woxKcUV6H6DbCoTSJXtWQ4K+6bkUwfB8cIw8ckWDCLy0NszZSCRepVOfPST1BcXclA==
X-YMail-OSG: o4vf5O8VM1m2T3_r0jRIH_we3jJ0AtRvuul.BbvI3Mk5ANcbNuV1L0E_iI0t4zS
 AQJHlsb_f5nY5iR__rSiJC4.VI4lvGkjs608.WrhqmIMTaM5BJdjo8SFO_Od97soEoGqSiIifCvN
 fn6u_OBpUHFStSZBhm_h5CdzJPC7vyyP54NjiyIXwcDMEiwi2mpkQFeBy3KnwcfItF0KxJVhOr_0
 XUE0xXG_y4psjm.cO9GHmn7kvAC3h.M3LJnisqN_kKRQlD_GPav0aA7Eak_dzfjTCuUYrE3x49fW
 hMBM6_gFQutBSLTuRbFLGai4KzPpXE9DTr0f2DBbdN24dXDbT6O27Sg3mGgMw3ZF4n7V9M8PlEXG
 iXZYbozvHP.J4l9q0WyEVrTpj..LYGqQ0BJpc2viekOfAob9BUEqHJ7k.To2ylN0lqmnR2htZ7ST
 kZGV.yq8c.zkLP2rtUbSBh8shCirTzsGgkHth3qyeCl3TznoYq06KDII1_pwmqsqd.IB2hMSC805
 sahonqetVbc2frL8qC26JCys8X2nApej1DAK1tUYr5sr8q3j6SCY9ukk7KLAUHHlRU2Ji1mPaoC7
 7.wHKHxUNVXazMIc21Gl2G4XKo9GEBXfqWrq0f_v4et4XYJxqv4B4OUXI.5ueGyR_FI4pWuSjqZ_
 HtEbIeBHWdCJUCtIiE72QE2hSGaPy4LGnTAT8eTW1UzqpVF9lvdvdph0LOCIrQnsR_SkirVgEBVM
 IRmdWyS3z0wQ9_fyL79DBJDKCLCNrs9PPvlC4CUcR1C.Bx6Q19KrxZmwZOW0aVS6vlAmpver6N1g
 oreyoPu2uczTwIz7RfwsxQxrsF5inMpF2zSz1pmapBIddeVIyX3wfP4vEVh7O18lSjysaQNlsIiM
 dhAr7BQiy7X2cnmjbhYN1zfV2twuQeKOH4r6C5E81nLsGUyAB4NoKNTEleRmLFreINLVJu3HMKpW
 iC6Npahu0cNAsRgpmtRTuKY5wqvFyXQyDFo6GfTqu5tnWWyAyzqXXVXDN7JWdfOC5i4uk7c_sXG7
 wulo3zZYgCPK4ckgI8cL17Tr0CvSbJcikFP.Upn8okAn2K_ZM9cjdMOnpnMpIe4TuZiggyVF_.7o
 edagv6OGXoACMFEcNwf_C76gxMcwo927cEJU7laPG0Vgr8Lrf6pKeWSK3CYV989HIBXPvpvzYnWD
 Omjd4v4Ivarf_.byp3mQba1BLI34EWUtxr8OAQtUr7bdhslNTMRIANZiZh6FgWCzgRgIXcR6pLSK
 QjG67YYBa_3BH95T.DZN07uW7tBuaS5ELrV9Kf_XN_Lfm.0VkWu7hcRckc9VrSQVxHaGt0LCxR2Z
 VaCpk4MYlHPajSWXXLa_i4QDwH0RSLbW.nAjUVM8A99pROm468f5oVo90R0KYCFfeh97IH8vJaex
 Y4cCivmEeF3uPBAjZMJrPQlyig3w8g75V9F66T10s7ZvIe_ej2M32gQkrV84mn7D_0vgLWkCBYJB
 7teKcUwsjC7dMUPKZXBtcPCrKoBvvyEbbHo643pnJmYlQLS8N2jDIHl22Z6dk5sBplHOuywRdY_a
 BPNAPhtgKVNNxbofyw4cycSa_NQ4hbsFhdyEmu_g9pN17Si7TUAl.Dg0IiLRMaR.k7tN1paJ8cDX
 N0bFCY7snGgke6MG5slQmi6TzKhQcSA.LqCdUicf35ZdUs3YzMN34LmH1b8mJT9rkR0tLG1JfTdc
 QlDGFRKjzQR0ypakoDzX_Xis86n4XvAzx143LH6GAldF745jFBP5q9kJVGpiC3nw89iVj2KZj856
 US7Ov8vs8gGbohd4IOXnU4aDircchdr6Gl3vG9TlJ1SnQ1a1bdPfExjXBO_fttDqXWnxsGtGZkFy
 RwlaqKzj7y2TZW8X0z3tPR6_pDns297LwcJUX9iT506xoZrK115U_.J6C7j__f7wkTf507WLmLz7
 3Le4BwBJKnLRLphnFRLJzS7GmmXT0JhRXs7l9uSX7Ss4YecL1gs0JU8o291Df4sFe6cMcWGlH9Xr
 9sidateJiuzaGiqOR9gYWhkMf2LB6z0FMcrzICksbB82Ridy.FbTQ3IZ0.ZS8dk3aRuXLZnOGTD.
 JVJR8x0SfZERFFc7wHC1yUR2qQ7TT1KFvNzQCXCKi9wy5dVFq5xrzM5XlI9fOj60WcPfEqncSq50
 .WH5i5Y88wf_urFpulMmQMfSr9rebA4jz3qQsFZFiGTHCmix0Voiwh4vAFQriYdws6dcAhTDnb.5
 qpEfBR8X0QZgY
X-Sonic-MF: <brchuckz@aim.com>
X-Sonic-ID: b9a247e1-0ea5-473a-acc0-9f2bc933c42c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Wed, 15 Nov 2023 17:57:04 +0000
Received: by hermes--production-bf1-5b945b6d47-pb628 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b4b4a9370e80522ac9d62dc97b11e39c;
          Wed, 15 Nov 2023 17:56:59 +0000 (UTC)
Message-ID: <edefba96-0a17-4b3d-992c-6bfe9e62bf97@netscape.net>
Date:   Wed, 15 Nov 2023 12:56:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/mm: add option to prefer IOMMU ops for DMA on Xen
Content-Language: en-US
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Chuck Zmudzinski <brchuckz@aol.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Julien Grall <julien@xen.org>,
        Mario Marietto <marietto2008@gmail.com>,
        Bertrand Marquis <bertrand.marquis@arm.com>
References: <20231111184538.2371-1-brchuckz.ref@aol.com>
 <20231111184538.2371-1-brchuckz@aol.com>
 <e5ebfde9-7a74-4908-b0b9-db47c4e76315@arm.com>
 <alpine.DEB.2.22.394.2311141407140.160649@ubuntu-linux-20-04-desktop>
From:   Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <alpine.DEB.2.22.394.2311141407140.160649@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2023 5:20 PM, Stefano Stabellini wrote:
> On Tue, 14 Nov 2023, Robin Murphy wrote:
>> On 11/11/2023 6:45 pm, Chuck Zmudzinski wrote:
>> > Enabling the new option, ARM_DMA_USE_IOMMU_XEN, fixes this error when
>> > attaching the Exynos mixer in Linux dom0 on Xen on the Chromebook Snow
>> > (and probably on other devices that use the Exynos mixer):
>> > 
>> > [drm] Exynos DRM: using 14400000.fimd device for DMA mapping operations
>> > exynos-drm exynos-drm: bound 14400000.fimd (ops 0xc0d96354)
>> > exynos-mixer 14450000.mixer: [drm:exynos_drm_register_dma] *ERROR* Device
>> >                               14450000.mixer lacks support for IOMMU
>> > exynos-drm exynos-drm: failed to bind 14450000.mixer (ops 0xc0d97554): -22
>> > exynos-drm exynos-drm: adev bind failed: -22
>> > exynos-dp: probe of 145b0000.dp-controller failed with error -22
>> > 
>> > Linux normally uses xen_swiotlb_dma_ops for DMA for all devices when
>> > xen_swiotlb is detected even when Xen exposes an IOMMU to Linux. Enabling
>> > the new config option allows devices such as the Exynos mixer to use the
>> > IOMMU instead of xen_swiotlb_dma_ops for DMA and this fixes the error.
>> > 
>> > The new config option is not set by default because it is likely some
>> > devices that use IOMMU for DMA on Xen will cause DMA errors and memory
>> > corruption when Xen PV block and network drivers are in use on the system.
>> > 
>> > Link:
>> > https://lore.kernel.org/xen-devel/acfab1c5-eed1-4930-8c70-8681e256c820@netscape.net/
>> > 
>> > Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
>> > ---
>> > The reported error with the Exynos mixer is not fixed by default by adding
>> > a second patch to select the new option in the Kconfig definition for the
>> > Exynos mixer if EXYNOS_IOMMU and SWIOTLB_XEN are enabled because it is
>> > not certain setting the config option is suitable for all cases. So it is
>> > necessary to explicitly select the new config option during the config
>> > stage of the Linux kernel build to fix the reported error or similar
>> > errors that have the same cause of lack of support for IOMMU on Xen. This
>> > is necessary to avoid any regressions that might be caused by enabling the
>> > new option by default for the Exynos mixer.
>> >   arch/arm/mm/dma-mapping.c |  6 ++++++
>> >   drivers/xen/Kconfig       | 16 ++++++++++++++++
>> >   2 files changed, 22 insertions(+)
>> > 
>> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> > index 5409225b4abc..ca04fdf01be3 100644
>> > --- a/arch/arm/mm/dma-mapping.c
>> > +++ b/arch/arm/mm/dma-mapping.c
>> > @@ -1779,6 +1779,12 @@ void arch_setup_dma_ops(struct device *dev, u64
>> > dma_base, u64 size,
>> >   	if (iommu)
>> >   		arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
>> >   +#ifdef CONFIG_ARM_DMA_USE_IOMMU_XEN
>> 
>> FWIW I don't think this really needs a config option - if Xen *has* made an
>> IOMMU available, then there isn't really much reason not to use it, and if for
>> some reason someone really didn't want to then they could simply disable the
>> IOMMU driver anyway.
> 
> The fact that the Exynos IOMMU is exposed to Linux is a mistake. Xen
> doesn't recognize the Exynos IOMMU (it is not one of the IOMMUs Xen has
> a driver for) so it assigns the IOMMU to Dom0. It doesn't happen on
> purpose, it happens by accident. Certain things are going to break,
> specifically I am fairly certain PV drivers are going to break.
> 
> If Xen recognized the Exynos IOMMU as an IOMMU it would probably hide it
> from Dom0. (Today Xen doesn't have a list of IOMMUs Xen recognizes but
> doesn't have a driver for.)
> 
> I think it is OK for Chuck and others to play around with this
> configuration but I wouldn't add a new kconfig option to Linux to
> support it.
> 
> If we do want a kconfig option, I would add a kconfig option or Linux
> command line option to enable/disable swiotlb-xen. Basically a way to
> force-enable or force-disable xen_swiotlb_detect(). That could be
> generally useful for debugging and would also solve the problem here as
> it could be used to force-disable swiotlb-xen. I would imagine that the
> end result is the same: the default ops (iommu_ops) are used.

I will try this. It isn't exactly what I have tested until now because
in all my tests so far all the DMA capable devices on the Chromebook use
swioltlb-xen except for the two devices that need to use the Exynos IOMMU
to fix the error with the Exynos mixer.

> 
> 
> 
>> > +	if (dev->dma_ops == &iommu_ops) {
>> > +		dev->archdata.dma_ops_setup = true;
>> 
>> The existing assignment is effectively unconditional by this point anyway, so
>> could probably just be moved earlier to save duplicating it (or perhaps just
>> make the xen_setup_dma_ops() call conditional instead to save the early return
>> as well).
>> 
>> However, are the IOMMU DMA ops really compatible with Xen? The comments about
>> hypercalls and foreign memory in xen_arch_need_swiotlb() leave me concerned
>> that assuming non-coherent DMA to any old Dom0 page is OK might not actually
>> work in general :/
> 
> Xen has (not yet upstreaming) support for nested IOMMU (Xen uses the
> IOMMU while also it exposes a virtual IOMMU to guests.) In those cases
> the iommu_ops should be compatible with Xen.
> 
> swiotlb-xen is useful in cases where there is no IOMMU on the platform
> (or the IOMMU doesn't cover all DMA-capable devices) and Dom0 is 1:1
> mapped. See include/xen/arm/swiotlb-xen.h:xen_swiotlb_detect. If Dom0 is
> not 1:1 mapped swiotlb-xen doesn't work. If an IOMMU is present and
> covers all DMA-capable devices, then swiotlb-xen is superfluous.

It seems that swiotlb-xen works on this Chromebook since all but two
of the DMA capable devices use it when configured with the Kconfig option
added here and it seems to work fine so I presume Dom0 is 1:1 mapped as
expected. It is possible that on this device, the IOMMU is only covering
the two devices that need to use the Exynos IOMMU in the tests I have done.
There are many other DMA capable devices that use swiotlb-xen DMA ops
on Xen, but I have not checked what DMA ops the other devices use when
Linux runs on the Chromebook on bare metal without Xen.

So I plan to do some tests and see what DMA ops the other devices use if
swiotlb-xen is disabled and also what DMA ops the other devices use when
Linux runs on the Chromebook on bare metal without Xen. If these tests
show the problem can be fixed by disabling swiotlb-xen with a Kconfig  or
command line option, I will propose v2 to implement that as a solution.

> This last case is the interesting case for virtual IOMMU and Linux usage of
> iommu_ops.
