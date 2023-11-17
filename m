Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C047EEB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 04:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbjKQDSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQDSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:18:31 -0500
Received: from sonic301-20.consmr.mail.gq1.yahoo.com (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDBAB9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 19:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1700191107; bh=bO5ted+P1A5SGXs96O4z/73BO8Z3ap47fgrFTtk6ec0=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=p7PoNBbbpxMlpHgmJtjMlBR1ErmscOnmpwr/7UwZ4JnTv4ZCtoCF4f9ULpqSqsAjtTW7k7l33yB4792Af1PXGxwQ/uh3caCCf9zWLw9BJGN9Cmx3xdtVvS2HO40UHvdFhFMOqzARJvUJMkBihEtGNFPwgchxI+7nrAlHO5lDHKsFxqUS8HJZxNq/uruusywRD9hgrVsXCUnKSRK08YVkGY8XWpeNwMzg/JYnW7lVifc14I+sVWeA6hETngdIuc4Ee4stuSS5eEsdN+x02o9gEFzT2kXdkDHOeB5jcLWEOMTh8tWzhLzr8+g8p7K2aY87dDR63CNrTUldyAfit7vkZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700191107; bh=FS3Ium9Ve7xz7p3mB3DqxcJ6Cse7/KC59ZGsgR4a/Si=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=JJGC2O4POKRNdrTd/RZst9d5SbYmI/XQXhF1+bG+ZReqMkgykDkpOY99+LuGzQ6gZrt1Ct7jq5syKPu5Tzpx/aEv2F3l41WcRMiEbE6+ibzXhgPpQwgg79BdMiAqV39jeiPIr3h8POP/66iQi3iqy49nfQdQrLuLSm5SxY/9YlYOT+fQwTbJKRVMhGZkIiM1LZM+vrdhdDt2EfD/NmnwYC8M82Fb960PT/udi74m0vn3DYiwYdCA/NNXMTnzP3TgWRvlfEHTL821IM4efV+D5fP9NCsSpzTHiNJlZAbOGI0lkOTbrDOtlcwT+cgzhjQ7h0WBLo61yx5+uQ7j+5NwJQ==
X-YMail-OSG: X_Xv1XoVM1kFtq0nkQmJiT2QiH5WrIQ.SG1S_4P9MhRhfHZfdB_Jwt7weFsLUf5
 9vP5BOHJh5dMSxRbfHXcfAaLcetnSNeqobLaBUAAsDtlTKLF22Zf0SvPbhElIc2cXK7cqzC3DR1a
 6vch9fZQ7mrxvR3MO4yWlZK7bPzuFpJLvbzuh.lOtJpWo0uyymlNgubH7GVkp2VUJHa3X_bYp3eE
 levu7Xh_YKp9CMgWshqxD5LN2iSWxcTZ2ihGYEgg70y7_DSb09OwMDQmjGzxOgy8GknRMV74Pbc6
 W9iHeBPrsMxruWkSg5dQ7E7zyELsp8pEwq1OMl5PZ4EMYs2WQ3KgoTnxATm2a9sgClZpnS_upp35
 sH_0hzO1gEVI6u__L4ySgVsG_ZigDNaxvS96AF6b1PH_VW3faAH_Q04YSfMxOw7RVVon9rZcwFPs
 iH2ETdwx3qeQAE5QbLMl06CbnQExqBwi2Wq9paPp4geoMon0aOs9BDvEe6QfFbh0sId5gCYifXa1
 wntIwEz2HXib9pBEJwrIzGBOroYX2YmoCJ4x_pb0B6.1AtwEqT8bVNk3LSMFOWDnneWOSzSVzJWG
 zwcIqboziQm0obx8QL68hpDAkH4MLc2IeDib8ZzF38pVaO7pFSMrBPXPAqqsaJiwVxPnCOekvXU4
 OTY7cUtpMRycsoLwhbZNsUv3YVzfOa5OL.IzZzPHtFVZROX48Llg7dyxbT3fiCdy3KEyHejZiGNJ
 tZnGRyhlSIsZOeco5_LV.2uxzjX.NXglgdvGPkcDtmqYSHA9pXlX4WWBjkYBZnVfkWJiaXokwnCq
 sh6nrSUh5aLSidUeRBhgjrM2gidfVlU.ObTlg_MRilsU94emz66FL3pQ1XbQgbmLUK9qNzdd26jf
 xvzYTVL_Mmggz7dM2.KnqY9vVdjROG8MCjK2jVeT6IrA9OPyNQwZK6EWqD6GNkvnZk8xGdjc6xnq
 _8X4iOZxAoqzWaLSWz2Md0f6TkdHf_Jz2Bi8hYvrn35vsmJeVe3wV9dn0P7ATMpQ5d9zF9G_qSyc
 gALkSz6F1zaFvRDlXdTU6CjBc6.QZ_3Pi_zeGQvkulNDI9WgaT1GEQkZBkWYlDAJSjxGaXmKx8pD
 .X0DsjfNh9QN7Aa_ZVG_o6YpVbxwsWm2lnx2GWAE2AmM1nLuM.EGB1VQ11dMzLXrxRRqYZCosTUa
 4Zo_CCKdeOOUOlgQDIrBLqZpnRrVI5OT2ENNIwkBhlwrszGVoPo5taBIvwYz1gF.xO4dKF1RHlDF
 fgQNvaYFHIWoVOQdOyNYORX.Iqj7Scyg85zdJtdYBA90HdkhFiM5uIqx9Lo6sqB7HukUxrMaENtJ
 SPhGAXP.lgxe29nC38kTyyge0.fzmtr_OWtke92APn_DP5IwuQSYWAWi_Y3pii1GQqEMqYHXOXUe
 79HcaMthZKqn5K.ORPFxWrHB1ryXXS_CXSwkWWcLflnF6qxWdo65KWxWQL3xVxnyd_TQ4_s_AAu9
 bt4IH57bS58RE7FipGm.DepK.5pxctkNDYrxx5icEr9WrZ8b1_ohpXEqON6Aiq4GwWOH1UmM_Bxt
 C0bO85BrDkBYk4tpzDb9PDJ0OhCTxHUhpAkQRqzVMlhxErheRs2ukVWW8AYI.gVRyabfNeVgfI73
 RkAuyuDizj3iiRdqIm8.ra_DaDiJaQCrxpEK17wRhkX4g2Jl3e2EHEW4mhCaZMPxbzQRr.GXd6Xw
 A5230sohrdi5GHy0B4YcY3AbY_EZrOrZhDyIWlr.ewHxlBcWLvgTW3PF76BgcSH0jZMSmDC5MEqy
 lbMu8P30HGGZtQpGG7pUkp6.VOLWa5YfmjElS4pYCPjdMDmuytw6FaawKI25DXb8JcMEvTGaOBty
 G3t5Sz.2649Abf7ehcOT6EErPLhuIodN4BrAdicnJeBQXMvhDsIT7NQz0g5Ffl9uvSk2Nvxtw.I2
 dNHsI3LhTYsMY2RrEGlA3PDfpH4qIKbXXgIU.v38jrThXzpoZwAf3Mm1EZLTX.uiwxfjIgq4CeeU
 LA2zuW8rHYJ0dtInRxAaQX4iLKqhihZeMlEQDwa3LqbjVtvrz0jfoCoNLw4COytbD2xKV5w91JDj
 6.S8P2wmOnrlbEpp8J3LwSPHWuie7wt5eBWWRH1AC1ygWggXrw_PQa3BVY_RBnyLekH68z6_pWOz
 .RDqKB_hrbB_Y7i9FCiF.eU.1IAEA49YEscW8X_QDxfcWZxR0by0OBQQT4BB66g0thmTpxxFdzA8
 .5wMF.tzi
X-Sonic-MF: <brchuckz@aim.com>
X-Sonic-ID: 681c8a96-fdee-4e51-ac62-0881e8c8f908
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Fri, 17 Nov 2023 03:18:27 +0000
Received: by hermes--production-ne1-56df75844-2xz9h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2d6715d33867073cd4a75dc60ca8514f;
          Fri, 17 Nov 2023 03:18:24 +0000 (UTC)
Message-ID: <f1e3f54a-7553-46c9-ac89-5a760437c3eb@netscape.net>
Date:   Thu, 16 Nov 2023 22:18:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/mm: add option to prefer IOMMU ops for DMA on Xen
Content-Language: en-US
From:   Chuck Zmudzinski <brchuckz@netscape.net>
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
 <edefba96-0a17-4b3d-992c-6bfe9e62bf97@netscape.net>
In-Reply-To: <edefba96-0a17-4b3d-992c-6bfe9e62bf97@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2023 12:56 PM, Chuck Zmudzinski wrote:
> On 11/14/2023 5:20 PM, Stefano Stabellini wrote:
>> On Tue, 14 Nov 2023, Robin Murphy wrote:
>>> On 11/11/2023 6:45 pm, Chuck Zmudzinski wrote:
>>> > Enabling the new option, ARM_DMA_USE_IOMMU_XEN, fixes this error when
>>> > attaching the Exynos mixer in Linux dom0 on Xen on the Chromebook Snow
>>> > (and probably on other devices that use the Exynos mixer):
>>> > 
>>> > [drm] Exynos DRM: using 14400000.fimd device for DMA mapping operations
>>> > exynos-drm exynos-drm: bound 14400000.fimd (ops 0xc0d96354)
>>> > exynos-mixer 14450000.mixer: [drm:exynos_drm_register_dma] *ERROR* Device
>>> >                               14450000.mixer lacks support for IOMMU
>>> > exynos-drm exynos-drm: failed to bind 14450000.mixer (ops 0xc0d97554): -22
>>> > exynos-drm exynos-drm: adev bind failed: -22
>>> > exynos-dp: probe of 145b0000.dp-controller failed with error -22
>>> > 
>>> > Linux normally uses xen_swiotlb_dma_ops for DMA for all devices when
>>> > xen_swiotlb is detected even when Xen exposes an IOMMU to Linux. Enabling
>>> > the new config option allows devices such as the Exynos mixer to use the
>>> > IOMMU instead of xen_swiotlb_dma_ops for DMA and this fixes the error.
>>> > 
>>> > The new config option is not set by default because it is likely some
>>> > devices that use IOMMU for DMA on Xen will cause DMA errors and memory
>>> > corruption when Xen PV block and network drivers are in use on the system.
>>> > 
>>> > Link:
>>> > https://lore.kernel.org/xen-devel/acfab1c5-eed1-4930-8c70-8681e256c820@netscape.net/
>>> > 
>>> > Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
>>> > ---
>>> > The reported error with the Exynos mixer is not fixed by default by adding
>>> > a second patch to select the new option in the Kconfig definition for the
>>> > Exynos mixer if EXYNOS_IOMMU and SWIOTLB_XEN are enabled because it is
>>> > not certain setting the config option is suitable for all cases. So it is
>>> > necessary to explicitly select the new config option during the config
>>> > stage of the Linux kernel build to fix the reported error or similar
>>> > errors that have the same cause of lack of support for IOMMU on Xen. This
>>> > is necessary to avoid any regressions that might be caused by enabling the
>>> > new option by default for the Exynos mixer.
>>> >   arch/arm/mm/dma-mapping.c |  6 ++++++
>>> >   drivers/xen/Kconfig       | 16 ++++++++++++++++
>>> >   2 files changed, 22 insertions(+)
>>> > 
>>> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>>> > index 5409225b4abc..ca04fdf01be3 100644
>>> > --- a/arch/arm/mm/dma-mapping.c
>>> > +++ b/arch/arm/mm/dma-mapping.c
>>> > @@ -1779,6 +1779,12 @@ void arch_setup_dma_ops(struct device *dev, u64
>>> > dma_base, u64 size,
>>> >   	if (iommu)
>>> >   		arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
>>> >   +#ifdef CONFIG_ARM_DMA_USE_IOMMU_XEN
>>> 
>>> FWIW I don't think this really needs a config option - if Xen *has* made an
>>> IOMMU available, then there isn't really much reason not to use it, and if for
>>> some reason someone really didn't want to then they could simply disable the
>>> IOMMU driver anyway.
>> 
>> The fact that the Exynos IOMMU is exposed to Linux is a mistake. Xen
>> doesn't recognize the Exynos IOMMU (it is not one of the IOMMUs Xen has
>> a driver for) so it assigns the IOMMU to Dom0. It doesn't happen on
>> purpose, it happens by accident. Certain things are going to break,
>> specifically I am fairly certain PV drivers are going to break.
>> 
>> If Xen recognized the Exynos IOMMU as an IOMMU it would probably hide it
>> from Dom0. (Today Xen doesn't have a list of IOMMUs Xen recognizes but
>> doesn't have a driver for.)
>> 
>> I think it is OK for Chuck and others to play around with this
>> configuration but I wouldn't add a new kconfig option to Linux to
>> support it.
>> 
>> If we do want a kconfig option, I would add a kconfig option or Linux
>> command line option to enable/disable swiotlb-xen. Basically a way to
>> force-enable or force-disable xen_swiotlb_detect(). That could be
>> generally useful for debugging and would also solve the problem here as
>> it could be used to force-disable swiotlb-xen. I would imagine that the
>> end result is the same: the default ops (iommu_ops) are used.

Actually, if the swiotlb-xen DMA ops are disabled, arm/mm/dma-mapping.c
does not set DMA ops for any of the devices except for the two devices
that the Exyos DRM driver uses: the Exyno fimd and the Exynos mixer,
and only for those two devices do iommu_ops get set.

The same thing happens on bare metal. Only those same two devices have
iommu_ops set, and all the other devices do not have any DMA ops set at
all on the bare metal, at least not by arm/mm/dma-mapping.c.

I will work on implementing the option to disable swiotlb-xen on the command
line which makes it possible to do testing and debugging and also enables
fixing the problem with the Exynos mixer by setting a command line option
instead of recompiling the kernel with a new config option.

> 
> I will try this. It isn't exactly what I have tested until now because
> in all my tests so far all the DMA capable devices on the Chromebook use
> swioltlb-xen except for the two devices that need to use the Exynos IOMMU
> to fix the error with the Exynos mixer.
> 
>> 
>> 
>> 
>>> > +	if (dev->dma_ops == &iommu_ops) {
>>> > +		dev->archdata.dma_ops_setup = true;
>>> 
>>> The existing assignment is effectively unconditional by this point anyway, so
>>> could probably just be moved earlier to save duplicating it (or perhaps just
>>> make the xen_setup_dma_ops() call conditional instead to save the early return
>>> as well).
>>> 
>>> However, are the IOMMU DMA ops really compatible with Xen? The comments about
>>> hypercalls and foreign memory in xen_arch_need_swiotlb() leave me concerned
>>> that assuming non-coherent DMA to any old Dom0 page is OK might not actually
>>> work in general :/
>> 
>> Xen has (not yet upstreaming) support for nested IOMMU (Xen uses the
>> IOMMU while also it exposes a virtual IOMMU to guests.) In those cases
>> the iommu_ops should be compatible with Xen.
>> 
>> swiotlb-xen is useful in cases where there is no IOMMU on the platform
>> (or the IOMMU doesn't cover all DMA-capable devices) and Dom0 is 1:1
>> mapped. See include/xen/arm/swiotlb-xen.h:xen_swiotlb_detect. If Dom0 is
>> not 1:1 mapped swiotlb-xen doesn't work. If an IOMMU is present and
>> covers all DMA-capable devices, then swiotlb-xen is superfluous.
> 
> It seems that swiotlb-xen works on this Chromebook since all but two
> of the DMA capable devices use it when configured with the Kconfig option
> added here and it seems to work fine so I presume Dom0 is 1:1 mapped as
> expected. It is possible that on this device, the IOMMU is only covering
> the two devices that need to use the Exynos IOMMU in the tests I have done.
> There are many other DMA capable devices that use swiotlb-xen DMA ops
> on Xen, but I have not checked what DMA ops the other devices use when
> Linux runs on the Chromebook on bare metal without Xen.
> 
> So I plan to do some tests and see what DMA ops the other devices use if
> swiotlb-xen is disabled and also what DMA ops the other devices use when
> Linux runs on the Chromebook on bare metal without Xen. If these tests
> show the problem can be fixed by disabling swiotlb-xen with a Kconfig  or
> command line option, I will propose v2 to implement that as a solution.
> 
>> This last case is the interesting case for virtual IOMMU and Linux usage of
>> iommu_ops.

