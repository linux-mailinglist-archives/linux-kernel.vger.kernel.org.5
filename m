Return-Path: <linux-kernel+bounces-120298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46EB88D57E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D12FBB22EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FAA3C3C;
	Wed, 27 Mar 2024 04:38:20 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4EA36B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711514299; cv=none; b=E7/xf/l/xeXfihZsgUAVp4CIGy0p7g0o1BXKQlXemc7dRh321Mluo7vv6c9F9Fa1R3YqWioN9fiRvTK4KwA9noKh/yVnuUlpyQJwLfDQiyrfauujigz6OGPBkt73ll0H3hyHOz/VfILbMt43wqp0IFjpSRGhumZmmIC20Fx6uU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711514299; c=relaxed/simple;
	bh=QKsyCGDDI1f2T2lFBQjEUtSKoQc+lcEtpV7k81MihOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/flolti/EAtQFuZWx5UQDypUUmaXMVPQI4hkpbA0Ich9N9FuFgq31bBEJeIDejOccg2Gmqlf8az/6B4fv83ozKeKZ8m6NQmUI1zvw9BR3t7/P/OGH7SzAT3PN8OrC8VNcNjgtFdZ/wrvaUYQx9sJtm1s0u1zYoODGSwOP6TOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp91t1711514281t7ur2yp8
X-QQ-Originating-IP: 49La9BzcrdF7FP1AKN2R+oPZWQ3HKAgYrCqktBUM0H8=
Received: from john-PC ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 27 Mar 2024 12:38:00 +0800 (CST)
X-QQ-SSF: 01400000000000E0L000000A0000000
X-QQ-FEAT: hP8KuKYkBUtODjCoeZw+29v4rvuaceahf+7fN42DIHhBpvzd6hFxxKjyN5dVH
	pBOUoFTIQfa8ILp1t6nFTaZc8F1+bfzsSdN7+XhGUFqE9NmaIr55Ee29Pq/VXlcXGwSghYN
	3ccQbPaZIy5RFDVnpcyyh0qIBRUbGHLPNMjpch8YKoaMoG8Nhcb62xH7xd/uQPI7OEhvOME
	PNnulRPz/gk+SekXyvoB0iuJAJIAA+eQrkRryDqcBoMPV4UQFnH0iBnAJOVv2To4pPxyQj7
	DYy64qzUYgqKy/kGW6pUjMC7zeETyr/WyJg3oT82XCWp1RCDqDXW/BMGjMoesJ29UWk/5bT
	2ISFBBIbcr+mS8dkyJp8sNr5SyHuLBUDaVU8hJqf+t2k9jUxvop8IHXGQ2HV9AClyihsG5o
	ZsPujIqlhf2u+QBH/ITgqMBN95BSwa0F
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9839420910490350448
Date: Wed, 27 Mar 2024 12:37:59 +0800
From: Qiang Ma <maqianga@uniontech.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch"
 <daniel@ffwll.ch>, "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "sunran001@208suo.com" <sunran001@208suo.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/amdgpu: Clear the hotplug interrupt ack bit
 before hpd initialization
Message-ID: <38A7C5A6073A7AC5+20240327123759.21edc87f@john-PC>
In-Reply-To: <CADnq5_OrMX=hVyLHWZecy8N6=dUaFOrMF+pf_2GTMRB3-iWskg@mail.gmail.com>
References: <20240131075703.24600-1-maqianga@uniontech.com>
	<A65A2F93D9F165EC+20240313141827.40f30bd5@john-PC>
	<BL1PR12MB5144F6A9CAB0504C8AD5728CF7292@BL1PR12MB5144.namprd12.prod.outlook.com>
	<933F2B53EE8DA7B7+20240327113100.6742ccd5@john-PC>
	<CADnq5_OrMX=hVyLHWZecy8N6=dUaFOrMF+pf_2GTMRB3-iWskg@mail.gmail.com>
Organization: UOS
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

On Tue, 26 Mar 2024 23:51:45 -0400
Alex Deucher <alexdeucher@gmail.com> wrote:

> On Tue, Mar 26, 2024 at 11:41=E2=80=AFPM Qiang Ma <maqianga@uniontech.com>
> wrote:
> >
> > On Thu, 14 Mar 2024 14:40:40 +0000
> > "Deucher, Alexander" <Alexander.Deucher@amd.com> wrote:
> > =20
> > > [Public]
> > > =20
> > > > -----Original Message-----
> > > > From: Qiang Ma <maqianga@uniontech.com>
> > > > Sent: Wednesday, March 13, 2024 2:18 AM
> > > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > > Christian <Christian.Koenig@amd.com>; Pan, Xinhui
> > > > <Xinhui.Pan@amd.com>; airlied@gmail.com; daniel@ffwll.ch;
> > > > SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> > > > sunran001@208suo.com Cc: amd-gfx@lists.freedesktop.org;
> > > > dri-devel@lists.freedesktop.org; linux- kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v2] drm/amdgpu: Clear the hotplug interrupt
> > > > ack bit before hpd initialization
> > > >
> > > > On Wed, 31 Jan 2024 15:57:03 +0800
> > > > Qiang Ma <maqianga@uniontech.com> wrote:
> > > >
> > > > Hello everyone, please help review this patch. =20
> > >
> > > This was applied back in January, sorry if I forget to reply.
> > >
> > > Alex =20
> >
> > Hi, Alex, it doesn't matter, please take some time to help review
> > this patch.
> >
> > This patch mainly solves the problem that after unplugging the HDMI
> > display during bios initialization, the display does not light up
> > after the system starts.
> > =20
>=20
> I already reviewed and applied the patch.  It's in mainline:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Daeaf3e6cf84282500b6fa03621b0c225ce1af18a
>=20
> Alex

Thank you.

Qiang Ma

>=20
> > Qiang Ma =20
> > > =20
> > > >
> > > >   Qiang Ma
> > > > =20
> > > > > Problem:
> > > > > The computer in the bios initialization process, unplug the
> > > > > HDMI display, wait until the system up, plug in the HDMI
> > > > > display, did not enter the hotplug interrupt function, the
> > > > > display is not bright.
> > > > >
> > > > > Fix:
> > > > > After the above problem occurs, and the hpd ack interrupt bit
> > > > > is 1, the interrupt should be cleared during hpd_init
> > > > > initialization so that when the driver is ready, it can
> > > > > respond to the hpd interrupt normally.
> > > > >
> > > > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > > > ---
> > > > > v2:
> > > > >  - Remove unused variable 'tmp'
> > > > >  - Fixed function spelling errors
> > > > >
> > > > > drivers/gpu/drm/amd/amdgpu/dce_v10_0.c |  2 ++
> > > > > drivers/gpu/drm/amd/amdgpu/dce_v11_0.c |  2 ++
> > > > > drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 22
> > > > > ++++++++++++++++++--- =20
> > > > - =20
> > > > > drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 22
> > > > > ++++++++++++++++++--- =20
> > > > - =20
> > > > >  4 files changed, 40 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c index
> > > > > bb666cb7522e..12a8ba929a72 100644 ---
> > > > > a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c +++
> > > > > b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c @@ -51,6 +51,7 @@
> > > > >
> > > > >  static void dce_v10_0_set_display_funcs(struct amdgpu_device
> > > > > *adev); static void dce_v10_0_set_irq_funcs(struct
> > > > > amdgpu_device *adev); +static void
> > > > > dce_v10_0_hpd_int_ack(struct amdgpu_device *adev, int hpd);
> > > > >  static const u32 crtc_offsets[] =3D {
> > > > >     CRTC0_REGISTER_OFFSET,
> > > > > @@ -363,6 +364,7 @@ static void dce_v10_0_hpd_init(struct
> > > > > amdgpu_device *adev) AMDGPU_HPD_DISCONNECT_INT_DELAY_IN_MS);
> > > > >             WREG32(mmDC_HPD_TOGGLE_FILT_CNTL +
> > > > > hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
> > > > > +           dce_v10_0_hpd_int_ack(adev,
> > > > > amdgpu_connector->hpd.hpd); dce_v10_0_hpd_set_polarity(adev,
> > > > > amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev,
> > > > > &adev->hpd_irq, amdgpu_connector->hpd.hpd); diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c index
> > > > > 7af277f61cca..745e4fdffade 100644 ---
> > > > > a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c +++
> > > > > b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c @@ -51,6 +51,7 @@
> > > > >
> > > > >  static void dce_v11_0_set_display_funcs(struct amdgpu_device
> > > > > *adev); static void dce_v11_0_set_irq_funcs(struct
> > > > > amdgpu_device *adev); +static void
> > > > > dce_v11_0_hpd_int_ack(struct amdgpu_device *adev, int hpd);
> > > > >  static const u32 crtc_offsets[] =3D
> > > > >  {
> > > > > @@ -387,6 +388,7 @@ static void dce_v11_0_hpd_init(struct
> > > > > amdgpu_device *adev) AMDGPU_HPD_DISCONNECT_INT_DELAY_IN_MS);
> > > > >             WREG32(mmDC_HPD_TOGGLE_FILT_CNTL +
> > > > > hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
> > > > > +           dce_v11_0_hpd_int_ack(adev,
> > > > > amdgpu_connector->hpd.hpd); dce_v11_0_hpd_set_polarity(adev,
> > > > > amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev,
> > > > > &adev->hpd_irq, amdgpu_connector->hpd.hpd); } diff --git
> > > > > a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c index
> > > > > 143efc37a17f..28c4a735716b 100644 ---
> > > > > a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c +++
> > > > > b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c @@ -272,6 +272,21 @@ =20
> > > > static =20
> > > > > void dce_v6_0_hpd_set_polarity(struct amdgpu_device *adev,
> > > > > WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
> > > > >
> > > > > +static void dce_v6_0_hpd_int_ack(struct amdgpu_device *adev,
> > > > > +                            int hpd)
> > > > > +{
> > > > > +   u32 tmp;
> > > > > +
> > > > > +   if (hpd >=3D adev->mode_info.num_hpd) {
> > > > > +           DRM_DEBUG("invalid hdp %d\n", hpd);
> > > > > +           return;
> > > > > +   }
> > > > > +
> > > > > +   tmp =3D RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
> > > > > +   tmp |=3D DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> > > > > +   WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
> > > > > +
> > > > >  /**
> > > > >   * dce_v6_0_hpd_init - hpd setup callback.
> > > > >   *
> > > > > @@ -311,6 +326,7 @@ static void dce_v6_0_hpd_init(struct =20
> > > > amdgpu_device =20
> > > > > *adev) continue;
> > > > >             }
> > > > >
> > > > > +           dce_v6_0_hpd_int_ack(adev,
> > > > > amdgpu_connector->hpd.hpd); dce_v6_0_hpd_set_polarity(adev,
> > > > > amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev,
> > > > > &adev->hpd_irq, amdgpu_connector->hpd.hpd); } @@ -3088,7
> > > > > +3104,7 @@ static int dce_v6_0_hpd_irq(struct amdgpu_device
> > > > > *adev, struct amdgpu_irq_src *source,
> > > > >                         struct amdgpu_iv_entry *entry)  {
> > > > > -   uint32_t disp_int, mask, tmp;
> > > > > +   uint32_t disp_int, mask;
> > > > >     unsigned hpd;
> > > > >
> > > > >     if (entry->src_data[0] >=3D adev->mode_info.num_hpd) { @@
> > > > > -3101,9 +3117,7 @@ static int dce_v6_0_hpd_irq(struct
> > > > > amdgpu_device *adev, mask =3D interrupt_status_offsets[hpd].hpd;
> > > > >
> > > > >     if (disp_int & mask) {
> > > > > -           tmp =3D RREG32(mmDC_HPD1_INT_CONTROL +
> > > > > hpd_offsets[hpd]);
> > > > > -           tmp |=3D =20
> > > > DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK; =20
> > > > > -           WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd],
> > > > > tmp);
> > > > > +           dce_v6_0_hpd_int_ack(adev, hpd);
> > > > >             schedule_delayed_work(&adev->hotplug_work, 0);
> > > > >             DRM_DEBUG("IH: HPD%d\n", hpd + 1);
> > > > >     }
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c index
> > > > > adeddfb7ff12..8ff2b5adfd95 100644 ---
> > > > > a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c +++
> > > > > b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c @@ -264,6 +264,21 @@ =20
> > > > static =20
> > > > > void dce_v8_0_hpd_set_polarity(struct amdgpu_device *adev,
> > > > > WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
> > > > >
> > > > > +static void dce_v8_0_hpd_int_ack(struct amdgpu_device *adev,
> > > > > +                            int hpd)
> > > > > +{
> > > > > +   u32 tmp;
> > > > > +
> > > > > +   if (hpd >=3D adev->mode_info.num_hpd) {
> > > > > +           DRM_DEBUG("invalid hdp %d\n", hpd);
> > > > > +           return;
> > > > > +   }
> > > > > +
> > > > > +   tmp =3D RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
> > > > > +   tmp |=3D DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> > > > > +   WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
> > > > > +
> > > > >  /**
> > > > >   * dce_v8_0_hpd_init - hpd setup callback.
> > > > >   *
> > > > > @@ -303,6 +318,7 @@ static void dce_v8_0_hpd_init(struct =20
> > > > amdgpu_device =20
> > > > > *adev) continue;
> > > > >             }
> > > > >
> > > > > +           dce_v8_0_hpd_int_ack(adev,
> > > > > amdgpu_connector->hpd.hpd); dce_v8_0_hpd_set_polarity(adev,
> > > > > amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev,
> > > > > &adev->hpd_irq, amdgpu_connector->hpd.hpd); } @@ -3176,7
> > > > > +3192,7 @@ static int dce_v8_0_hpd_irq(struct amdgpu_device
> > > > > *adev, struct amdgpu_irq_src *source,
> > > > >                         struct amdgpu_iv_entry *entry)  {
> > > > > -   uint32_t disp_int, mask, tmp;
> > > > > +   uint32_t disp_int, mask;
> > > > >     unsigned hpd;
> > > > >
> > > > >     if (entry->src_data[0] >=3D adev->mode_info.num_hpd) { @@
> > > > > -3189,9 +3205,7 @@ static int dce_v8_0_hpd_irq(struct
> > > > > amdgpu_device *adev, mask =3D interrupt_status_offsets[hpd].hpd;
> > > > >
> > > > >     if (disp_int & mask) {
> > > > > -           tmp =3D RREG32(mmDC_HPD1_INT_CONTROL +
> > > > > hpd_offsets[hpd]);
> > > > > -           tmp |=3D =20
> > > > DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK; =20
> > > > > -           WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd],
> > > > > tmp);
> > > > > +           dce_v8_0_hpd_int_ack(adev, hpd);
> > > > >             schedule_delayed_work(&adev->hotplug_work, 0);
> > > > >             DRM_DEBUG("IH: HPD%d\n", hpd + 1);
> > > > >     } =20
> > >
> > > =20
> > =20
>=20


