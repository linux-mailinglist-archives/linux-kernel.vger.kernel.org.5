Return-Path: <linux-kernel+bounces-108298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6648808E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66B81C223CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD91364;
	Wed, 20 Mar 2024 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="B0IL9dSi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jz+C5RRW"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A8522F;
	Wed, 20 Mar 2024 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896915; cv=none; b=Koo+CwmLpKcN/XnNbo/ck4wJkwULbzj6K62E1l3BJzm2jR0gZph36ZFtscB42HvEYiB3nh4sJWEonXYlERFES+reghMb3FZL9jLm0GFaJldL4HhW63XqSqwNpVQkBhKxVoTZGfahrkkJs/VMA9pQHoKbg26Ep9QZ3MbLQwlTx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896915; c=relaxed/simple;
	bh=F7XL1d1NzhxHSSb90owMiqYaestUNa3F2eWB6xP/MPM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=S8Oo56F0JuO0u/7qi6eYL58hfR8djByjby7QAPNwIGjsDXMEpYWQ0MXCUzOzxd+hWBZlBteClzAV2hRX36t129vKMG/6mEqwQ86QTuSg+9aOHN59O2IyYdULoCCvgYF4C/Mxln4HdbD3M8L351ls7dWu4XIEmzEgz6vqGQXCXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=B0IL9dSi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jz+C5RRW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 685C51380119;
	Tue, 19 Mar 2024 21:08:31 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 19 Mar 2024 21:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1710896911;
	 x=1710983311; bh=kzSUmvOYEvdj/dHQ60CDAMpS3nZEKun/mJ9D+PUAnTg=; b=
	B0IL9dSiyJvFXBwiYgIP6ur+hHvm3zd+vvdJyc5va3ShNDHbe+dgj9wMkjPjlhtM
	URN+gVmhu3FsYgXLN+ag5l6p2qMcvBbueEOjXJhDv4nqsIj0gJJVPw2KLH4BXvSK
	zFl1zasnsPY+kIFh0d9rRfq5eHNhcU5Mc/wBZKzEeDw8XgrSWEnXmwFoTIH7+wjn
	U3/RdDVWwoDmb5QNPStuHfbPqY43AgyDUC+PyzTXzfOXa81l76QxVI8XdveRnRf6
	lQBIVnRdLdL9kP9RRRzASCW3yZZsWQ53VxrPpRZSXe+MCsCNSg16+6/RIhpH/VMS
	N+gBI6hs7lMpZ2zUGN0trg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710896911; x=
	1710983311; bh=kzSUmvOYEvdj/dHQ60CDAMpS3nZEKun/mJ9D+PUAnTg=; b=j
	z+C5RRW/hiCj4WDRasmzm2VNuuUrFK6NFwD7aU10Dpw085waWaGZ8DjqC+0yAsD1
	sAnP0zezosxi51cXORnVzbsyzFfw1YspOmpKSbX1BD8U98YYGOD8OMs4BcThE7mV
	YSxtEeduwMQqgxo6qbbXAKq34qrswbgiX+5+E1G/hQWp3cYtIIVUygP5SvZvy5gB
	ZEDtwmBNDemSHNJb8WiMH7Fs2oAECKjXRU+goJi/YeLHrSOmwe+MLYHy45yiLe6L
	afuTwlJGFAxSXvQOjxBdSvh/pfWUw/huUJjsv0CAI78JhiwrUjvjzNmubT3loDro
	gabFgcLNuTS3vjWVrM0AA==
X-ME-Sender: <xms:Dzf6ZU1nB_hQLrMKdyjOiBWe2BIoFedoDqn2hsBCRMOjM-hiuTfpdQ>
    <xme:Dzf6ZfFF6Ipf0DZbg6LCgHxbU7UYoCkSMb6p6BQNIL5_LTkAK1uaoxxNWbQw6Yec3
    vo3H_3TiwODfjSzK3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledvgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpeefuefghfdvueefheeiledvgeefffevgeelhedtvdehgeekteeugedtgeeuhedv
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Dzf6Zc6lSEMMxHnzFzKqFxrZ3sqjFIPASRyzkbYqMXSKvyGroFfx6w>
    <xmx:Dzf6Zd0Ysa3R3iTtQrUeFpNHf6BWKQk89vE6qTiOTyk-8XJ54OLLdw>
    <xmx:Dzf6ZXHovd4SgJLu2YXSJyXhajFqPXvdxEasKNQuFHvwGkPvfmHkVQ>
    <xmx:Dzf6ZW8axDysL22mMwBhE0M339z7HS1_3dUfHwhmBtF5hsf15Y830A>
    <xmx:Dzf6ZfC-ZUo29pFMD2gxgs7idm6Oo706KvB79F_aI9-eIl5pUfStHg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 28DCD2340080; Tue, 19 Mar 2024 21:08:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22dfda61-6feb-49b1-a2dc-3f4eb0f7ec60@app.fastmail.com>
In-Reply-To: <42f1c0d5-e7ac-4efb-fef7-75d07ad2ffaa@linux.intel.com>
References: <20240310055750.13160-1-luke@ljones.dev>
 <20240310055750.13160-2-luke@ljones.dev>
 <42f1c0d5-e7ac-4efb-fef7-75d07ad2ffaa@linux.intel.com>
Date: Wed, 20 Mar 2024 14:08:10 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
 "Hans de Goede" <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: asus-wmi: add support variant of TUF RGB
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Mar 2024, at 1:31 AM, Ilpo J=C3=A4rvinen wrote:
> On Sun, 10 Mar 2024, Luke D. Jones wrote:
>=20
> > Adds support for a second TUF RGB wmi call that some versions of the=
 TUF
> > laptop come with. Also adjusts existing support to select whichever =
is
> > available.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/asus-wmi.c            | 12 +++++++++++-
> >  include/linux/platform_data/x86/asus-wmi.h |  1 +
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 2cf695289655..ca8c73c15fcc 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -280,6 +280,7 @@ struct asus_wmi {
> >  bool nv_temp_tgt_available;
> > =20
> >  bool kbd_rgb_mode_available;
> > + u32 kbd_rgb_dev;
> >  bool kbd_rgb_state_available;
> > =20
> >  bool throttle_thermal_policy_available;
> > @@ -870,6 +871,7 @@ static ssize_t kbd_rgb_mode_store(struct device =
*dev,
> >  struct device_attribute *attr,
> >  const char *buf, size_t count)
> >  {
> > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> >  u32 cmd, mode, r, g, b, speed;
> >  int err;
> > =20
> > @@ -906,7 +908,7 @@ static ssize_t kbd_rgb_mode_store(struct device =
*dev,
> >  speed =3D 0xeb;
> >  }
> > =20
> > - err =3D asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI=
_DEVID_TUF_RGB_MODE,
> > + err =3D asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, asus->kb=
d_rgb_dev,
> >  cmd | (mode << 8) | (r << 16) | (g << 24), b | (speed << 8), NULL);
> >  if (err)
> >  return err;
> > @@ -4537,6 +4539,14 @@ static int asus_wmi_add(struct platform_devic=
e *pdev)
> >  asus->gpu_mux_dev =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> >  }
> > =20
> > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
> > + asus->kbd_rgb_mode_available =3D true;
> > + asus->kbd_rgb_dev =3D ASUS_WMI_DEVID_TUF_RGB_MODE;
> > + } else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MO=
DE2)) {
> > + asus->kbd_rgb_mode_available =3D true;
> > + asus->kbd_rgb_dev =3D ASUS_WMI_DEVID_TUF_RGB_MODE2;
> > + }
>=20
> Hi,
>=20
> Why are you leaving this line there (unlike in the GPU MUX patch where=20
> you replaced it with the similar if()s as above):
>=20
> asus->kbd_rgb_mode_available =3D asus_wmi_dev_is_present(asus, ASUS_WM=
I_DEVID_TUF_RGB_MODE);

Missed it I guess. Thanks for catching, I'll submit next version.

>=20
> ?
>=20
> --=20
> i.
>=20
>=20

