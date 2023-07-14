Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A85753257
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjGNG4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjGNG4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:56:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF631FF1;
        Thu, 13 Jul 2023 23:56:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso1778925a12.3;
        Thu, 13 Jul 2023 23:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689317807; x=1691909807;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPb0IpHExepFSS8AXjqT5uPHoWnDc8tyYxdhzyJGpP4=;
        b=Tn/tFtotoj3kKWGu/JeFCWLAdynH7BSSFEU2fT6alKvccsV98nUG36uaNDdrSJH7uX
         sug4xoJ4Joim8NEL2ut/TLKgwOG1Ukr6nd4GnOeuCpP55/m2d7bH1PdG1ntxsI1/9udE
         ZTDPrjBWC9xn2L2bukiBiuS+UqWiEO3QXjPhby85+ZJZdP0Zs0cHDYSj/Ru0z+ubKF1v
         tE6WLqQZa72GPLZ2NtWtkVKTc65j+m+5xwRx96KSjRA7M5LTUjtgePQLs7gthHUEhvh8
         NnnPAi/5UnluiHCywIFJ+1xMvNYWmBn+8qKu0AOMuZJw6S+k9reoVEuBiYh7BWKjYxdt
         klGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689317807; x=1691909807;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPb0IpHExepFSS8AXjqT5uPHoWnDc8tyYxdhzyJGpP4=;
        b=R1aFFYrsSvx02iipFuVNXGa47iJzDkDt/kepTvDjBeJXgDazsfQV7qVvv8PwY8IpwU
         wz26KcM7o6eMEf30jtp40MGZ0WIVfE/1fa0hEgVZgAVjpkksj1giH6Q3A1I88dUdFc+9
         Q9hB9aDmaCCSptfRuKNEh+JD06Lw9ly1PGYREU7G/spIKmYrESrOIRDuhNfiiIS3myNV
         qo2Yy4wUWvciizdfz1wJ5eIXUtorUeGqFJ1C8LNu/SjLtNmJdqX+slL+eM8v2lPs2Bah
         X1KE1sM8FAlftsLiTJsisQ6uAS3nHPvg29AyD17wOAQmzhMU85MuwKcfzSNWiHJs8ymZ
         4Q8g==
X-Gm-Message-State: ABy/qLbyP+K8FSBDLvxP4qBtvnCeXLV32qvdzRbjDVf0xTCe+V2MsNVx
        E+zECXdzf5BFuTYEF00Y5To=
X-Google-Smtp-Source: APBJJlHP8ZGSCoWsVEJI8fyskK0DGjUW9zRUPX9p4poeYfNF02mfyM0n6gDfoS1lWJSkrsQTKOFDGg==
X-Received: by 2002:a05:6402:b26:b0:51d:92bf:e6ae with SMTP id bo6-20020a0564020b2600b0051d92bfe6aemr3724889edb.18.1689317807282;
        Thu, 13 Jul 2023 23:56:47 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d3-20020aa7c1c3000000b0051de52f8adesm5288703edp.32.2023.07.13.23.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:56:46 -0700 (PDT)
Date:   Fri, 14 Jul 2023 08:56:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Stanimir Varbanov <stanimir.varbanov@suse.com>,
        Stanimir Varbanov <svarbanov@suse.de>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Message-ID: <ZLDxrDMoLsniQx4x@orome>
References: <20230710082252.9702-1-svarbanov@suse.de>
 <ZKvgG4-IzqiYPSUT@orome>
 <93026b47-3b72-8439-486e-e0cda21dd0fe@suse.com>
 <ZK17X4ueSI5rWKVL@orome>
 <ZK_8uU2XJAWMk23M@orome>
 <2a6fe812-3881-8dc9-1e7e-237ce7490155@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I3VsAWuDrtgMS3gi"
Content-Disposition: inline
In-Reply-To: <2a6fe812-3881-8dc9-1e7e-237ce7490155@linux.intel.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I3VsAWuDrtgMS3gi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 11:14:08AM +0800, Baolu Lu wrote:
> On 2023/7/13 21:31, Thierry Reding wrote:
> > On Tue, Jul 11, 2023 at 05:55:11PM +0200, Thierry Reding wrote:
> > > On Tue, Jul 11, 2023 at 01:58:34PM +0300, Stanimir Varbanov wrote:
> > > > Hi Thierry,
> > > >=20
> > > > Thank you for the comments!
> > > >=20
> > > > On 7/10/23 13:40, Thierry Reding wrote:
> > > > > On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
> > > > > > Add def_domain_type implementation op and override default IOMMU
> > > > > > domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy), w=
hich
> > > > > > could be enabled on some distros. The current quirk has been do=
ne
> > > > > > for Tegra234 machine, because I found the issue on it. The issue
> > > > > > itself appears on USB host controller which cannot be initializ=
ed
> > > > > > without IOMMU translation. Something more, we proved that IOMMU
> > > > > > translation is needed for display and GPU drivers as well.
> > > > > >=20
> > > > > > I evaluated few possible options to solve that:
> > > > > >=20
> > > > > >   a) select default IOMMU domain from .def_domain_type op
> > > > > >   b) Unset CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dn
> > > > > >   c) add iommu.passthrough=3D0 on the kernel cmdline
> > > > > >   d) firmware - ACPI / DT
> > > > > >=20
> > > > > > a) This option is implemented in the proposed patch.
> > > > > >=20
> > > > > > b) Since that the community has agreed that pass-through is pre=
ferred
> > > > > > as a default IOMMU domain option because this will avoid perfor=
mance
> > > > > > impacts on some of the platforms [1]. On the other side we have=
 examples
> > > > > > where you cannot even install Linux distribution on a machine w=
here the
> > > > > > storage media cannot be detected and the system just hangs.
> > > > >=20
> > > > > That's not how I read that thread. It sounds more to me like Will=
 and
> > > > > Robin had ideas on how to improve the performance and were planni=
ng to
> > > > > address these issues. It doesn't exactly sound to me like there w=
as
> > > > > concensus to make passthrough the default.
> > > > >=20
> > > > > Having said that, given that it's possible for distributions and =
users
> > > > > to set CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy, I think it would be =
useful in
> > > > > general to have a way of enforcing IOMMU translations if it's nee=
ded by
> > > > > the hardware.
> > > >=20
> > > > Exactly, the problem is that some platforms prefer passthrough to a=
void
> > > > performance impacts but others cannot even boot the kernel (and thus
> > > > installation failure). Passing iommu.passthrough=3D0 should be an
> > > > administrator decision, balancing between security and performance.
> > > >=20
> > > > On the other hand the aforementioned mail thread gave some performa=
nce
> > > > numbers which might be are outdated having the improvements made in=
 smmu
> > > > driver in mind. Unfortunately, I cannot confirm that the performanc=
e has
> > > > been improved during that time.
> > > >=20
> > > > >=20
> > > > > I'm not sure I fully understand the particular problems that you'=
re
> > > > > seeing on Tegra234, though. I'm not aware of anything in the USB =
host
> > > > > controller driver (or hardware, for that matter) that would requi=
re the
> > > > > IOMMU to be enabled. The only peculiarity that I can think of is =
the
> > > > > firmware, which is typically loaded by an early bootloader and th=
erefore
> > > > > might perhaps need the IOMMU to properly map this in the kernel.
> > > > > However, my understanding is that this firmware is loaded into sp=
ecial
> > > > > carveout regions which don't require remapping.
> > > >=20
> > > > On Jetson Orin AGX (R35.2.1) I see these errors:
> > > >=20
> > > > tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000=
080:
> > > > EMEM address decode error (EMEM decode error)
> > > >=20
> > > > tegra-xusb 3610000.usb: Error while assigning device slot ID
> > > > tegra-xusb 3610000.usb: Max number of devices this xHCI host suppor=
ts is 36.
> > > > usb usb2-port3: couldn't allocate usb_device
> > > > tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000=
090:
> > > > EMEM address decode error (EMEM decode error)
> > > > tegra-xusb 3610000.usb: Error while assigning device slot ID
> > > > tegra-xusb 3610000.usb: Max number of devices this xHCI host suppor=
ts is 36.
> > > > usb usb1-port3: couldn't allocate usb_device
> > > >=20
> > > > tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000=
0a0:
> > > > EMEM address decode error (EMEM decode error)
> > > > tegra-xusb 3610000.usb: Error while assigning device slot ID
> > > > tegra-xusb 3610000.usb: Max number of devices this xHCI host suppor=
ts is 36.
> > > > usb usb1-port4: couldn't allocate usb_device
> > > >=20
> > > > >=20
> > > > > However, passthrough is admittedly not something that we've thoro=
ughly
> > > > > tested, so it's possible you're running into a use-case that I'm =
not
> > > > > aware of. In that case, could you provide a few more specifics (s=
uch as
> > > > > the DTB and .config) of your build configuration so that I can tr=
y and
> > > > > reproduce?
> > > >=20
> > > > To reproduce you have to add iommu.passthrough=3D1 on kernel cmdlin=
e. The
> > > > dtb is from Jetpack.
> > >=20
> > > I was able to reproduce this on Jetson Orin NX (the differences to AGX
> > > Orin should be negligible in this context), though I ended up patching
> > > the DTB to disable all SMMUs. What fixed it for me was to drop the
> > > dma-coherent property from the usb@3610000 node. Can you try that on
> > > your end to see if that works for you as well?
> > >=20
> > > Not that that's a proper solution, of course, but just trying to find
> > > out if there's perhaps something else going on.
> > >=20
> > >  From the looks of it, it seems like these devices aren't actually DMA
> > > coherent inherently, but rather the SMMU translations make the access=
es
> > > to memory coherent. I'm trying to find out the exact details, but if =
it
> > > turns out to be the case, then what we really want is a way for an IO=
MMU
> > > to mark any devices that get attached to it as DMA coherent. It's not
> > > sufficient to hard-code this in DT because there are various ways in
> > > which device can end up not attached to an IOMMU despite what the DT
> > > says.
> > >=20
> > > Jason, or anyone of the IOMMU folks, any thoughts on how this could be
> > > achieved? DT already has a way of walking up the "DMA hierarchy" look=
ing
> > > for a DMA coherent parent, but again, making this rely entirely on DT
> > > seems insufficient.
> >=20
> > I've got a bit more information on what's happening here. There are
> > three different ways that a device's memory accesses can coherent on
> > Tegra: 1) when translated through the ARM SMMU, 2) some devices can
> > force coherency through configuration registers and 3) each device can
> > be forced to be coherent via the memory controller.
> >=20
> > Option 3) is not something we have much control over because this is
> > configured during early boot and the corresponding registers locked
> > down, so the OS can at maximum read out the configuration.
> >=20
> > Option 1) is what is typically used, so a common pattern is that if we
> > enable IOMMU translations via DT, we also set dma-coherent. Conversely,
> > if IOMMU translations are disabled via DT, the dma-coherent property
> > should also be removed because by default most devices will not be
> > hardcoded to be DMA coherent via option 3). Most device drivers will
> > also not program the device's configuration registers.
> >=20
> > As a result the desired configuration is to always enable SMMU and rely
> > on the SMMU translations to provide DMA coherency. As we've seen this
> > can be problematic, because the device tree doesn't always tell the true
> > story. For example even if the iommus property exists, the device may
> > not end up attached to the IOMMU for a number of reasons (the IOMMU
> > could itself be disabled, a kernel command-line option could prevent the
> > attachment, or a device could even be detached explicitly).
> >=20
> > So I think what we want to avoid is to mark all device tree nodes as
> > dma-coherent because it can lead to inconsistencies. A better option
> > would be to have this property inherited via the IOMMU if the IOMMU
> > translations themselves cause the coherency to be established. Now it
> > seems like DT already contains a way of doing that via the "DMA parent".
> > This works by looking up a special interconnects path called "dma-mem".
> > We already use this on Tegra to make the memory controller the DMA
> > parent of all memory clients (i.e. all DMA capable hardware blocks) in
> > order to enforce a bus-level DMA mask.
> >=20
> > However, in order for the DMA parent mechanism to work for IOMMU, we'd
> > need to redirect the DMA parent to be the IOMMU, but in that case we
> > loose the link to the memory controller. Unless, perhaps, if there's a
> > way to construct an ICC path from device to IOMMU and then to memory
> > controller and external memory controller (EMC).
> >=20
> > For reference, here's roughly what the data path looks like on Tegra:
> >=20
> > 	device --> MC --> SMMU enabled --> SMMU --> EMC --> DRAM
> > 	              |                          ^
> > 	              --> SMMU bypass -----------|
> >=20
> > SMMU can be enabled/disabled per device via a stream ID override
> > register in the memory controller.
> >=20
> > The biggest downside of that mechanism is still that it's a static
> > configuration and doesn't respect the actual runtime attachment of a
> > device to an IOMMU.
> >=20
> > Adding the DT folks to see if they have any good ideas on how best to
> > represent this from a DT point of view. Would it perhaps be an option
> > to consider the iommus property when walking up the DMA ancestry?
>=20
> Is it possible to handle this dynamically in the code? Say, set device
> to be DMA coherent in probe_finalize callback of Tegra iommu driver if
> the IOMMU translation for this device is on. And clear it in the iommu
> release device path.
>=20
> Normally we switch the DMA ops in the probe_finalize callback and iommu
> device release.

Yeah, I had looked into this as well. Intel, AMD and VirtIO all seem to
do this during .probe_finalize(), whereas on ARM64 this happens as part
of the bus' .dma_configure() callback.

One thing that we could potentially do is fiddle with the struct device
=2Edma_coherent member in .probe_finalize() and .release_device(), but I'm
not sure about the potential ramifications. That is, do we have places
in the code that assume dev->dma_coherent to be statically set during
device instantiation?

We would have to default to not marking devices as dma-coherent in DT
for that to work, though, because otherwise if someone were to disable
the IOMMU altogether, .probe_finalize() and .release_device() would
never get called and we'd never get a chance to override.

I wonder if we could also use this to dynamically switch a device into
coherent mode. For example, if it is marked as dma-coherent in device
tree but doesn't end up as dev->dma_coherent when the driver probes, we
could try and force coherency via the device's configuration registers.

I don't know yet if that's really a good idea, though. For correctness
it would be enough if we can detect at runtime whether a device is DMA
coherent or not via the IOMMU.

Thierry

--I3VsAWuDrtgMS3gi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSw8aoACgkQ3SOs138+
s6EWbhAAwo/8z3JSQ1oOm2xnLriiNX/bJG4zIyVFglxa+6W27VnYdvEhuGSLQ2+H
6PXcTKE10qxYAGgC/Rdldl6NGAmmE4UXcmP2c+lJ8MRg5e2s5DkHNKu8VfbduX7i
qznQAJp5DrQ6HAZGCVLUph2pYJhF46edMXWfoueyFJO31XudIp/Ycq7wbFA6F83y
sASHvixoAPA6BJQG0C1KTN1b0PJuBxw58BTGcaNQdoNMBEQoABbm0L0r7VCsC6P6
2krh9j3HnCvNdOgLLV+5DHsIFjDeqqiHD/HqQHQHpi2RxjuGAmEoJkQ68invySfa
4rBzLo8C+UOFrROvhG1TW7QkcyFGMFj2RSZpvxrH04z4d6IbYSCBHPMz7/J3VWzO
PtlJ1A6/QGDbdngYvWAyhbE2Wa8n++G4SB5/QJXDGZydHJTErQHBTroVJJNpm3cl
yjZ49iBAs94R2NevNp9d3D9q0zXlCElNeVw8YuMuSZHo+WNnBeQArQJnzKIHnwWe
L+liXsMMO+/HjVcYbtMIHPuPuqmV7aKVKWpB0jWpZ1yYQ5iPlcojkt7Sy/ff655m
SSOEoJq8702zf20Nkld8yymiTnu4VB+MHwp3Hm8rS6y57OFUvYSeStZ6crk6NuIw
WK8Hd6/fpdz316dUSronCZJZtSWVSzDHKflwPpKeEeZX4sMhof8=
=8DJA
-----END PGP SIGNATURE-----

--I3VsAWuDrtgMS3gi--
