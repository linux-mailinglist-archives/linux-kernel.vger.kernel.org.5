Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB67523D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjGMNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjGMNb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:31:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE21BF3;
        Thu, 13 Jul 2023 06:31:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so10365381fa.3;
        Thu, 13 Jul 2023 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689255100; x=1691847100;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa6e/lhCTJOCTxBJEriSeGHFVRF2vh6uyI7vl6ZgskI=;
        b=LXsEK9eNwo2w18kU7YqM+r4mM9ZLk9MbehN036EEQvaXqdgW+RwRgc62z9FQr8xtDA
         Y/rKWzUt6SB20FPFU3exK47icsoh9H6M9jXJmfUeaqZEi31YSUGU/59X5qgPP/20xGQI
         HqnTkCjC2T5OYj6Wt9VymfpV02TqIgHCxu/STprG3natVy9V9KmBe0Y/uoGhLUH4scgQ
         Ou03P1EI+tsk36LnOR+4XlcAJzLKL5Yeb96ca/FGdIKcCD0iiz8Ps3aFjkwTsgJx1NGT
         NzdEktIySxP+ozcdyeHz5ZTsDFN5gvNrd7C7RPxesnAn8ppoQ3Zqu/4sM7ybAzvWvPD7
         Jq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689255100; x=1691847100;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa6e/lhCTJOCTxBJEriSeGHFVRF2vh6uyI7vl6ZgskI=;
        b=Vv5HWEHI7RzFMB9W3rU7Cm6JoauD7CRX7Ded2eIYPgQvDB0B2Ck8tcf689uZ7328aV
         QfpahuNRzpkjx5UiVmtGvTGV5LuKgjQvsOSJkTdRPFueysN3gK6qtcSJXnwySCpDuqDT
         hYJG/krEmMU8xR0kKC8RnS0gbbXNGWGcBb83cj6QUTTVd2sPzjGqdJjXkQPFU5lf8GFR
         kEjLH30FI5WWNo0Sb/BU2bzPj7K069b/P/clR9x7Bmf7t9SescWCsQWstAqCPQeAyOUK
         xsZIePWy/77Ysg6/FBdpazH1Jbo0n1UB97Hl0Uau2iHp5zJhfz6mEpUzV1AahSZ5JOiW
         oL6w==
X-Gm-Message-State: ABy/qLYSGacBjSnf4avQchnoXl7kjuMWWeW8ni6u+PQO9p9w0s1zQeW1
        dKSrhJQKbjZ2pbs7phX6XsyMEpQ+xmw=
X-Google-Smtp-Source: APBJJlFk/PyUiI1I/eHInh6A/Q9Fujkzp022tCuwgdB/CAIRnI8GZTY0OLtEnxyXd/R7O/BAcbESnw==
X-Received: by 2002:a2e:b70a:0:b0:2b6:eb5a:6504 with SMTP id j10-20020a2eb70a000000b002b6eb5a6504mr1574550ljo.18.1689255099548;
        Thu, 13 Jul 2023 06:31:39 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u17-20020a170906069100b00985bdb7dd5fsm3955331ejb.201.2023.07.13.06.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 06:31:39 -0700 (PDT)
Date:   Thu, 13 Jul 2023 15:31:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Stanimir Varbanov <stanimir.varbanov@suse.com>
Cc:     Stanimir Varbanov <svarbanov@suse.de>, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH] iommu: arm-smmu-nvidia: Add default domain type
 implementation op
Message-ID: <ZK_8uU2XJAWMk23M@orome>
References: <20230710082252.9702-1-svarbanov@suse.de>
 <ZKvgG4-IzqiYPSUT@orome>
 <93026b47-3b72-8439-486e-e0cda21dd0fe@suse.com>
 <ZK17X4ueSI5rWKVL@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tk29Bp8nI2wnEwQO"
Content-Disposition: inline
In-Reply-To: <ZK17X4ueSI5rWKVL@orome>
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


--tk29Bp8nI2wnEwQO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:55:11PM +0200, Thierry Reding wrote:
> On Tue, Jul 11, 2023 at 01:58:34PM +0300, Stanimir Varbanov wrote:
> > Hi Thierry,
> >=20
> > Thank you for the comments!
> >=20
> > On 7/10/23 13:40, Thierry Reding wrote:
> > > On Mon, Jul 10, 2023 at 11:22:52AM +0300, Stanimir Varbanov wrote:
> > >> Add def_domain_type implementation op and override default IOMMU
> > >> domain Kconfig option (CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy), which
> > >> could be enabled on some distros. The current quirk has been done
> > >> for Tegra234 machine, because I found the issue on it. The issue
> > >> itself appears on USB host controller which cannot be initialized
> > >> without IOMMU translation. Something more, we proved that IOMMU
> > >> translation is needed for display and GPU drivers as well.
> > >>
> > >> I evaluated few possible options to solve that:
> > >>
> > >>  a) select default IOMMU domain from .def_domain_type op
> > >>  b) Unset CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dn
> > >>  c) add iommu.passthrough=3D0 on the kernel cmdline
> > >>  d) firmware - ACPI / DT
> > >>
> > >> a) This option is implemented in the proposed patch.
> > >>
> > >> b) Since that the community has agreed that pass-through is preferred
> > >> as a default IOMMU domain option because this will avoid performance
> > >> impacts on some of the platforms [1]. On the other side we have exam=
ples
> > >> where you cannot even install Linux distribution on a machine where =
the
> > >> storage media cannot be detected and the system just hangs.
> > >=20
> > > That's not how I read that thread. It sounds more to me like Will and
> > > Robin had ideas on how to improve the performance and were planning to
> > > address these issues. It doesn't exactly sound to me like there was
> > > concensus to make passthrough the default.
> > >=20
> > > Having said that, given that it's possible for distributions and users
> > > to set CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy, I think it would be usef=
ul in
> > > general to have a way of enforcing IOMMU translations if it's needed =
by
> > > the hardware.
> >=20
> > Exactly, the problem is that some platforms prefer passthrough to avoid
> > performance impacts but others cannot even boot the kernel (and thus
> > installation failure). Passing iommu.passthrough=3D0 should be an
> > administrator decision, balancing between security and performance.
> >=20
> > On the other hand the aforementioned mail thread gave some performance
> > numbers which might be are outdated having the improvements made in smmu
> > driver in mind. Unfortunately, I cannot confirm that the performance has
> > been improved during that time.
> >=20
> > >=20
> > > I'm not sure I fully understand the particular problems that you're
> > > seeing on Tegra234, though. I'm not aware of anything in the USB host
> > > controller driver (or hardware, for that matter) that would require t=
he
> > > IOMMU to be enabled. The only peculiarity that I can think of is the
> > > firmware, which is typically loaded by an early bootloader and theref=
ore
> > > might perhaps need the IOMMU to properly map this in the kernel.
> > > However, my understanding is that this firmware is loaded into special
> > > carveout regions which don't require remapping.
> >=20
> > On Jetson Orin AGX (R35.2.1) I see these errors:
> >=20
> > tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000080:
> > EMEM address decode error (EMEM decode error)
> >=20
> > tegra-xusb 3610000.usb: Error while assigning device slot ID
> > tegra-xusb 3610000.usb: Max number of devices this xHCI host supports i=
s 36.
> > usb usb2-port3: couldn't allocate usb_device
> > tegra-mc 2c00000.memory-controller: unknown: write @0x0000000000000090:
> > EMEM address decode error (EMEM decode error)
> > tegra-xusb 3610000.usb: Error while assigning device slot ID
> > tegra-xusb 3610000.usb: Max number of devices this xHCI host supports i=
s 36.
> > usb usb1-port3: couldn't allocate usb_device
> >=20
> > tegra-mc 2c00000.memory-controller: unknown: write @0x00000000000000a0:
> > EMEM address decode error (EMEM decode error)
> > tegra-xusb 3610000.usb: Error while assigning device slot ID
> > tegra-xusb 3610000.usb: Max number of devices this xHCI host supports i=
s 36.
> > usb usb1-port4: couldn't allocate usb_device
> >=20
> > >=20
> > > However, passthrough is admittedly not something that we've thoroughly
> > > tested, so it's possible you're running into a use-case that I'm not
> > > aware of. In that case, could you provide a few more specifics (such =
as
> > > the DTB and .config) of your build configuration so that I can try and
> > > reproduce?
> >=20
> > To reproduce you have to add iommu.passthrough=3D1 on kernel cmdline. T=
he
> > dtb is from Jetpack.
>=20
> I was able to reproduce this on Jetson Orin NX (the differences to AGX
> Orin should be negligible in this context), though I ended up patching
> the DTB to disable all SMMUs. What fixed it for me was to drop the
> dma-coherent property from the usb@3610000 node. Can you try that on
> your end to see if that works for you as well?
>=20
> Not that that's a proper solution, of course, but just trying to find
> out if there's perhaps something else going on.
>=20
> From the looks of it, it seems like these devices aren't actually DMA
> coherent inherently, but rather the SMMU translations make the accesses
> to memory coherent. I'm trying to find out the exact details, but if it
> turns out to be the case, then what we really want is a way for an IOMMU
> to mark any devices that get attached to it as DMA coherent. It's not
> sufficient to hard-code this in DT because there are various ways in
> which device can end up not attached to an IOMMU despite what the DT
> says.
>=20
> Jason, or anyone of the IOMMU folks, any thoughts on how this could be
> achieved? DT already has a way of walking up the "DMA hierarchy" looking
> for a DMA coherent parent, but again, making this rely entirely on DT
> seems insufficient.

I've got a bit more information on what's happening here. There are
three different ways that a device's memory accesses can coherent on
Tegra: 1) when translated through the ARM SMMU, 2) some devices can
force coherency through configuration registers and 3) each device can
be forced to be coherent via the memory controller.

Option 3) is not something we have much control over because this is
configured during early boot and the corresponding registers locked
down, so the OS can at maximum read out the configuration.

Option 1) is what is typically used, so a common pattern is that if we
enable IOMMU translations via DT, we also set dma-coherent. Conversely,
if IOMMU translations are disabled via DT, the dma-coherent property
should also be removed because by default most devices will not be
hardcoded to be DMA coherent via option 3). Most device drivers will
also not program the device's configuration registers.

As a result the desired configuration is to always enable SMMU and rely
on the SMMU translations to provide DMA coherency. As we've seen this
can be problematic, because the device tree doesn't always tell the true
story. For example even if the iommus property exists, the device may
not end up attached to the IOMMU for a number of reasons (the IOMMU
could itself be disabled, a kernel command-line option could prevent the
attachment, or a device could even be detached explicitly).

So I think what we want to avoid is to mark all device tree nodes as
dma-coherent because it can lead to inconsistencies. A better option
would be to have this property inherited via the IOMMU if the IOMMU
translations themselves cause the coherency to be established. Now it
seems like DT already contains a way of doing that via the "DMA parent".
This works by looking up a special interconnects path called "dma-mem".
We already use this on Tegra to make the memory controller the DMA
parent of all memory clients (i.e. all DMA capable hardware blocks) in
order to enforce a bus-level DMA mask.

However, in order for the DMA parent mechanism to work for IOMMU, we'd
need to redirect the DMA parent to be the IOMMU, but in that case we
loose the link to the memory controller. Unless, perhaps, if there's a
way to construct an ICC path from device to IOMMU and then to memory
controller and external memory controller (EMC).

For reference, here's roughly what the data path looks like on Tegra:

	device --> MC --> SMMU enabled --> SMMU --> EMC --> DRAM
	              |                          ^
	              --> SMMU bypass -----------|

SMMU can be enabled/disabled per device via a stream ID override
register in the memory controller.

The biggest downside of that mechanism is still that it's a static
configuration and doesn't respect the actual runtime attachment of a
device to an IOMMU.

Adding the DT folks to see if they have any good ideas on how best to
represent this from a DT point of view. Would it perhaps be an option
to consider the iommus property when walking up the DMA ancestry?

Thierry

--tk29Bp8nI2wnEwQO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSv/LYACgkQ3SOs138+
s6FAgBAAuBjfGtb7qbKVqJbuRxSpl8MsrnlePeNoimXmSnjI0y7yAfyAa6P3Qjz6
TQ4T3TEmdwO2MWrq38tuOnGmCi5R0N4vypZO3MHX88uz0mt5Y+LyyUeqErIlL7gw
D1Kd9GtmPu608pXNdwQ2uYEeTu/yLBHIht4F5Kk1nz354KYtiqO0kjZcfeXf5IVT
NTO9WFrg69vIjRn6ldVhEk7iafQXx4JTMKeIAS/XtE1WZLJ4ujLTBwxCdpqfI8oc
R8TijKYe60Y2tpbxuSxTCR/s9Xx7z0McziWs959Vg52Mp/wI5NEN404LTwkaz4MU
Cf1bm07+e8lCoSEdJ5Ev7SxehGfmFEYai0xW5YsupdErsMZ4GbPQk4zn/QhwF1BD
4/RP+9uz4tqcGsRcQG9+2Wqrpa8RstS+Brf+K2FmoolTxSV4SvDq/bjB8OTLBXOb
rXUe7lpkRY4axmkLU4B/sEVemfdbNx2aCtelO/AlJmhmGACXGK0oaSfByA2iOZdI
4e7V59Bvzh3PFE5nCwqX489Qf1wo7PaUzgF1QwX0iH+5IUvGKOw8Sf5RdU6lPubi
GUfmdW0CUQGWgZdt5Y7fDmTD9PbvLh1gLEuzqcELeqcsXW7NpFNrO4HuIn2hV+Nw
+e8DrX30MpucWGrbeq7DAV63vt+/NvMUisytDniJp9wMvEmNqqo=
=vg7b
-----END PGP SIGNATURE-----

--tk29Bp8nI2wnEwQO--
