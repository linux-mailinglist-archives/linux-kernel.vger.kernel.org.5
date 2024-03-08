Return-Path: <linux-kernel+bounces-96745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F848760EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A81DB211C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14915535A4;
	Fri,  8 Mar 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Hk5w+bKc"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9EE53388
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890187; cv=none; b=L+x/ie56cjFqIl1VtumKOldALqaJphm0jmOgEbMOYhd6lgsodTNsE0a5bnry3Z2vuGhctZaQRlNNI16CIcW09O+VqK0vq/hQ4bZvuzKultRLgZo9/sEN8+LsCZiHBsub0cVRvCNzcIR2eWrPa/Ljd/gkudfluw6TSn+sILASVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890187; c=relaxed/simple;
	bh=/610z7NeZF3AbbrUp5Ct8IK+na88MeCP5euuoex7my0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bgIG8xdev4L7tOUTdTIWvxm6k8ENqsx5u78z2meEE164jTQ/rRFmACtMOG+Jr3xhMwX6OeUIiXZ617dwAk3r4Szx5tweGZM03KzIppgk4YaTrTJs/x+9ldzirNRntiX1qqlSQnKKhlXK9I4XV6N/W6wQjIw/1WMtW4ZfN2PDBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Hk5w+bKc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so794620a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1709890183; x=1710494983; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTJ56TsgHxx+ey5O16dDKClnhRLxsOWJSpToCms/BRE=;
        b=Hk5w+bKcsI4DKVXfVrgQUXpGnLBv56bBr9AVwMSQbl3JAhwEOXcIJSCPlGJ+BZtXNH
         FhoOV3EkGZMBa7SC+0BgrssnMCQprx8E4T/tG5L8+PGvke6uScjxMpb/mcwA6vmeFwlT
         273vgYYA1isLu/vaCASpIxkBrfv8HHVN7HkifH3jqFCaM6PCzqUSuYshOU9Wk52mEoEq
         5pWrlyo6aPh51az5yr4vZnmZ1tQjwiW/XkN4I42VmnHx/y+0kbSCPd63tjLTyftpaeja
         WTdEv/M1Ol8Zo2UA6a7EfqZ0alMRMlh/iVqRqRrH0j16OD0MVZDm5Ibv1lXwuojb5t8A
         ShNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890183; x=1710494983;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xTJ56TsgHxx+ey5O16dDKClnhRLxsOWJSpToCms/BRE=;
        b=iqe9EdGCZFIolSxTKc+PP8UiEdvCEOtuARerFDtUmPc06bZq9WZ901o+SKBHDW5ReG
         HJ5I8AMz3pRUidP8MF8zE+KE6TcS/bmO+2OwCFfeHaF4U68vLX0OJ7o75w9L7J4qE97Z
         f8AD+lL8tsbeyNa06WuEKc4FgcQuJw0Bc7FFwX7pCXxwpcJDYA5eMsGL6vVwHt5BdAfN
         4KuuJLa+ZMtDJULbbBvABxgz2JFIyKFbDKeDvpHegzovpBmIOU1iI3za/gk5FIITgHgQ
         QDxkbA07psZ8GySh83uy4mZtennto4/PxVW5bOmvFLonLYdhEA2cfsZ46rwE5nYAlSdZ
         aqWA==
X-Forwarded-Encrypted: i=1; AJvYcCVIzfw89WNtRJ6OpUyDhox9dq0warrzDEzMVcUqd3eHZFlyFrsMyIX0CUgMsinXkrskqCS7CGjl6QU1WE0nSCUL8u6dNkpuhoZklEEQ
X-Gm-Message-State: AOJu0YxpO3+tN0l42SropHWI7xWkMLsAxPUbgLCRwnAknCvxSO9to+0w
	CMMk/KhAnm6tXgjgIEM4M/tBOdGs9othq0fvpn35bmH3UOuprOlO9/ElDo8N6Ao=
X-Google-Smtp-Source: AGHT+IEVEG7pI97UFUoSKdm0T77oCm/IjNnF2X00bMMaoqhxQZtaQiQDnkm1z665OJP8Smo71pGd9A==
X-Received: by 2002:a17:906:b78c:b0:a44:44e0:868f with SMTP id dt12-20020a170906b78c00b00a4444e0868fmr12636544ejb.11.1709890183560;
        Fri, 08 Mar 2024 01:29:43 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709060dc500b00a4537466591sm5611025eji.32.2024.03.08.01.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Mar 2024 10:29:42 +0100
Message-Id: <CZO9HDL1N45S.1JIXM2QUFTQCS@fairphone.com>
Cc: <neil.armstrong@linaro.org>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com> <b1da07f9-7e15-4d83-bef3-d0ce157654bc@linaro.org> <CYGUWBAM3D62.35CPP5HGEYJ3Y@fairphone.com> <CZHGFD9QYM82.371U2DPG1AEGQ@fairphone.com> <CAA8EJppZRABYGuoDc-6e6VMwtAo3LvEyDpsHdkHFckrR=q+0ig@mail.gmail.com>
In-Reply-To: <CAA8EJppZRABYGuoDc-6e6VMwtAo3LvEyDpsHdkHFckrR=q+0ig@mail.gmail.com>

On Sun Mar 3, 2024 at 9:37 PM CET, Dmitry Baryshkov wrote:
> On Thu, 29 Feb 2024 at 11:27, Luca Weiss <luca.weiss@fairphone.com> wrote=
:
> >
> > On Wed Jan 17, 2024 at 9:59 AM CET, Luca Weiss wrote:
> > > On Mon Jan 15, 2024 at 9:43 AM CET, Neil Armstrong wrote:
> > > > Hi Luca,
> > > >
> > > > On 11/01/2024 13:38, Luca Weiss wrote:
> > > > > Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
> > > > > bridge/panel.o to drm_kms_helper object, we need to select
> > > > > DRM_KMS_HELPER to make sure the file is actually getting built.
> > > > >
> > > > > Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge wil=
l not
> > > > > be properly available:
> > > > >
> > > > >    aarch64-linux-gnu-ld: drivers/phy/qualcomm/phy-qcom-qmp-combo.=
o: in function `qmp_combo_bridge_attach':
> > > > >    drivers/phy/qualcomm/phy-qcom-qmp-combo.c:3204:(.text+0x8f4): =
undefined reference to `devm_drm_of_get_bridge'
> > > > >
> > > > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > > > ---
> > > > > I can see "depends on DRM_KMS_HELPER" was removed with commit
> > > > > 3c3384050d68 ("drm: Don't make DRM_PANEL_BRIDGE dependent on DRM_=
KMS_HELPERS")
>
> Could you please make sure that the usecase described in the mentioned
> commit message doesn't get broken by your change?

Hi Neil,

The problem fixed in that linked patch (3c3384050d68) is about fixing
undefined reference errors with specific .config setups - similar to
this patch.

Since we're only adding a 'select' and not removing anything I don't see
how it could cause new errors like that, and it does fix the one I'm
describing.

And also I checked again and I don't see any circular dependencies
(something that was also mentioned in the linked patch), so apart from
what I mentioned with that I'm not too familiar when 'select' should be
used and when 'depend' should be used, it's good from my perspective.

Regards
Luca

>
> > > > >
> > > > > I'm not too familiar with Kconfig but it feels more correct if
> > > > > PHY_QCOM_QMP_COMBO selects DRM_PANEL_BRIDGE that that's enough; a=
nd it
> > > > > doesn't also has to explicitly select DRM_KMS_HELPER because of h=
ow the
> > > > > objects are built in the Makefile.
> > > > >
> > > > > Alternatively solution to this patch could be adjusting this line=
 in
> > > > > include/drm/drm_bridge.h:
> > > > >
> > > > >    -#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
> > > > >    +#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE) &&=
 defined(CONFIG_DRM_KMS_HELPER)
> > > > >     struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,=
 struct device_node *node,
> > > > >                                              u32 port, u32 endpoi=
nt);
> > > > >
> > > > > .. and then selecting DRM_KMS_HELPER for PHY_QCOM_QMP_COMBO.
> > > > >
> > > > > But I think the solution in this patch is better. Let me know wha=
t you
> > > > > think.
> > > >
> > > > I think this is no more the case after on linux-next:
> > > > 35921910bbd0 phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE
> > > >
> > > > But could you still check ?
> > >
> > > On next-20240117 the error happens in the aux-bridge file instead the=
n.
> > >
> > > aarch64-linux-gnu-ld: drivers/gpu/drm/bridge/aux-bridge.o: in functio=
n `drm_aux_bridge_probe':
> > > drivers/gpu/drm/bridge/aux-bridge.c:115:(.text+0xe0): undefined refer=
ence to `devm_drm_of_get_bridge'
> > >
> > > I'm attaching the defconfig with which I can reproduce this but it's
> > > really just DRM_KMS_HELPER=3Dn and PHY_QCOM_QMP_COMBO=3Dy I believe.
> >
> > Hi Neil,
> >
> > Ping on this patch
> >
> > Regards
> > Luca
> >
> > >
> > > Regards
> > > Luca
> > >
> > >
> > > >
> > > > Neil
> > > >
> > > > > ---
> > > > >   drivers/gpu/drm/bridge/Kconfig | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bri=
dge/Kconfig
> > > > > index ac9ec5073619..ae782b427829 100644
> > > > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > > > @@ -8,6 +8,7 @@ config DRM_BRIDGE
> > > > >   config DRM_PANEL_BRIDGE
> > > > >           def_bool y
> > > > >           depends on DRM_BRIDGE
> > > > > + select DRM_KMS_HELPER
> > > > >           select DRM_PANEL
> > > > >           help
> > > > >             DRM bridge wrapper of DRM panels
> > > > >
> > > > > ---
> > > > > base-commit: b9c3a1fa6fb324e691a03cf124b79f4842e65d76
> > > > > change-id: 20240111-drm-panel-bridge-fixup-5c2977fb969f
> > > > >
> > > > > Best regards,
> >


