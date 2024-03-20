Return-Path: <linux-kernel+bounces-108296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB768808DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C8C1F23E15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5BA1364;
	Wed, 20 Mar 2024 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="GG30uRsB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pO3hryBN"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E246A35;
	Wed, 20 Mar 2024 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896699; cv=none; b=O3qI9fErWvzhVuthChUnqg7EOmnszWEa0v9sMjaNaf+uYBAePZF1j5ef8+UVYYPvQzc6dt5cARPyR15AJylVLZy/BVPkUyaNmYW+rKmQHfY3ztHi9YRyHhz7sbzW8eKLutWr34bHEqwrgVKVt1cMNiV2nz2djqjZm2L7xVZRJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896699; c=relaxed/simple;
	bh=filHmaOZ0jB99bSb2CiUDlnINxPoUzPw9CnM2LJOMyU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oL2EKbQxLrCkiSPqzmLd7zEvBQdwWVgYVAvp2idS+0sh373AtrPkuyXXVxat5QZKE9Iy2MonkAgixkExsL1qHF0uJ4OHSyRbV74gH4ET41dF5K7EltWbQQ/8i7wsWVMRmCddLKCN91JutBzeSv6ziqDwayqU/OD3d8V3B81Wjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=GG30uRsB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pO3hryBN; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 038BE5C0097;
	Tue, 19 Mar 2024 21:04:56 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Tue, 19 Mar 2024 21:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1710896695;
	 x=1710983095; bh=wVmJomyhMfKULc4mCMJrQpu56DfpLXcVyI7vE3AsPZA=; b=
	GG30uRsBP0qIqV9epOnSZgmvCSrbjSXPXxW0PHrXq85WYUMSYtW4NUzD48SzMeT6
	5iH1c+UHcl0sr/4VBOBV4S56UVKSMr6QWfOaLk66pRfyBdrF6Uue5m2uRA+XwrZv
	uvcSWQFhyOcZblQIMjCVpcBqhs3Xev1el6VbjOLPXD9zn8k3zS2dSseRlwjs3Bie
	mm4e9LvvSwh4xR8CbBw6ew2eCkKVBQLaLPLWtGzxpjtjAv5i4JMVO+VgVRYeSRm4
	3SwrxJVwOVVagUjbVayfcdZqBAFmTmBIDH7+WXs3WYQZBBkZs53Od8zl7GDd917k
	WdQAUv49LYy4OuPg2ch9tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710896695; x=
	1710983095; bh=wVmJomyhMfKULc4mCMJrQpu56DfpLXcVyI7vE3AsPZA=; b=p
	O3hryBNrs1R6ajh8BE9QMhW2U1uOAq3KjvSi+HVbDL9iPNc+nAk2pSv6P31a+oGX
	HVvyQkGrK3ixSUfAFdKntELS+UYMZhOnyN+xI/wo2URG2EBpJjKhm7ToxsohgCSz
	SSXA2z2PsFvHIUqUYfcQmAhqWjaNxlPYc1JHJDgh1zBZXrTRmrw+zRj7BV7c7w43
	a0KTv0lZKiswxMwsehdBvROPfw88md+bzRYzdWD6L5ONYqikzowzsSBJtONXa/H/
	I71eUSG/YKxWmBeMGVSrOAhzM1sH8KIoNGKGByoozQKDMhdoQ2+q62slqa4LaScd
	JE8djt+0KNZnnLsB0zc6g==
X-ME-Sender: <xms:Nzb6ZbwPSWnCQ3xPhvcaludQmIiBWp7S7EIfn5cpWWFutbTg5bJYpQ>
    <xme:Nzb6ZTS3hEmR4pRUpzNTJMt1rV8X3Ub_SwnLbBPgnULE7_JCpvPFwG_810nrGKs3y
    ZabeQKLAUxeeLLhJbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfnuhhkvgcu
    lfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epfeeugffhvdeufeehieelvdegfeffveegleehtddvheegkeetueegtdegueehvdelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:Nzb6ZVURa30MkrpD_LGU52CFQpW9VC-YxmG57KFpM0N3zvKHZ448KQ>
    <xmx:Nzb6ZVgraI21U6hyc1zj5K7koAhmO4YXn4w0B7DdU00A5Nff5BJ0rw>
    <xmx:Nzb6ZdBIr02jFjb5nAlkcSS6RinzO6na91Cv3pOz3DNnxOmFUhcW0w>
    <xmx:Nzb6ZeJ8s4_-BEQa-CZ7GGUFg-0wiP23Z273PAnJhcDieC4-aWzOZA>
    <xmx:Nzb6ZQOgrFRXLzH5XdsEcvDMipevbvWAN52uczehMPck4R2Q98uaYA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9EAD12340081; Tue, 19 Mar 2024 21:04:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fbd2dc65-33d9-447e-9edb-78df370778be@app.fastmail.com>
In-Reply-To: <0f35beb8-5453-63cb-0570-752b2693f6ec@linux.intel.com>
References: <20240310055312.11293-1-luke@ljones.dev>
 <20240310055312.11293-2-luke@ljones.dev>
 <0f35beb8-5453-63cb-0570-752b2693f6ec@linux.intel.com>
Date: Wed, 20 Mar 2024 14:04:35 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
 "Hans de Goede" <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for Vivobook GPU MUX
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Mar 2024, at 1:26 AM, Ilpo J=C3=A4rvinen wrote:
> On Sun, 10 Mar 2024, Luke D. Jones wrote:
>=20
> > Adjust existing MUX support to select whichever MUX support is avail=
able
> > so that ASUS Vivobook MUX can also be used if detected.
>=20
> This description is a bit on the short side. It wouldn't have hurt to=20
> first state that Vivobooks come with a GPU MUX WMI that has a differen=
t=20
> WMI device ID. I can infer that after reading the diff but the descrip=
tion=20
> should not require reading the patch.

Would you prefer I changed the commit message?

>=20
> The code change itself looks fine,
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> --=20
> i.
>=20
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/asus-wmi.c            | 18 +++++++++++++-----
> >  include/linux/platform_data/x86/asus-wmi.h |  1 +
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 94cc589607b3..2cf695289655 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -268,6 +268,7 @@ struct asus_wmi {
> >  bool egpu_connect_available;
> >  bool dgpu_disable_available;
> >  bool gpu_mux_mode_available;
> > + u32 gpu_mux_dev;
> > =20
> >  /* Tunables provided by ASUS for gaming laptops */
> >  bool ppt_pl2_sppt_available;
> > @@ -682,7 +683,7 @@ static ssize_t dgpu_disable_store(struct device =
*dev,
> >  return -EINVAL;
> > =20
> >  if (asus->gpu_mux_mode_available) {
> > - result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_M=
UX);
> > + result =3D asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
> >  if (result < 0)
> >  /* An error here may signal greater failure of GPU handling */
> >  return result;
> > @@ -748,7 +749,7 @@ static ssize_t egpu_enable_store(struct device *=
dev,
> >  }
> > =20
> >  if (asus->gpu_mux_mode_available) {
> > - result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_M=
UX);
> > + result =3D asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
> >  if (result < 0) {
> >  /* An error here may signal greater failure of GPU handling */
> >  pr_warn("Failed to get gpu mux status: %d\n", result);
> > @@ -801,7 +802,7 @@ static ssize_t gpu_mux_mode_show(struct device *=
dev,
> >  struct asus_wmi *asus =3D dev_get_drvdata(dev);
> >  int result;
> > =20
> > - result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_M=
UX);
> > + result =3D asus_wmi_get_devstate_simple(asus, asus->gpu_mux_dev);
> >  if (result < 0)
> >  return result;
> > =20
> > @@ -847,7 +848,7 @@ static ssize_t gpu_mux_mode_store(struct device =
*dev,
> >  }
> >  }
> > =20
> > - err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_GPU_MUX, optimus, &re=
sult);
> > + err =3D asus_wmi_set_devstate(asus->gpu_mux_dev, optimus, &result);
> >  if (err) {
> >  dev_err(dev, "Failed to set GPU MUX mode: %d\n", err);
> >  return err;
> > @@ -4507,7 +4508,6 @@ static int asus_wmi_add(struct platform_device=
 *pdev)
> >  asus->egpu_enable_available =3D asus_wmi_dev_is_present(asus, ASUS_=
WMI_DEVID_EGPU);
> >  asus->egpu_connect_available =3D asus_wmi_dev_is_present(asus, ASUS=
_WMI_DEVID_EGPU_CONNECTED);
> >  asus->dgpu_disable_available =3D asus_wmi_dev_is_present(asus, ASUS=
_WMI_DEVID_DGPU);
> > - asus->gpu_mux_mode_available =3D asus_wmi_dev_is_present(asus, ASU=
S_WMI_DEVID_GPU_MUX);
> >  asus->kbd_rgb_mode_available =3D asus_wmi_dev_is_present(asus, ASUS=
_WMI_DEVID_TUF_RGB_MODE);
> >  asus->kbd_rgb_state_available =3D asus_wmi_dev_is_present(asus, ASU=
S_WMI_DEVID_TUF_RGB_STATE);
> >  asus->ppt_pl2_sppt_available =3D asus_wmi_dev_is_present(asus, ASUS=
_WMI_DEVID_PPT_PL2_SPPT);
> > @@ -4529,6 +4529,14 @@ static int asus_wmi_add(struct platform_devic=
e *pdev)
> >  asus->mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
> >  }
> > =20
> > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX)) {
> > + asus->gpu_mux_mode_available =3D true;
> > + asus->gpu_mux_dev =3D ASUS_WMI_DEVID_GPU_MUX;
> > + } else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VI=
VO)) {
> > + asus->gpu_mux_mode_available =3D true;
> > + asus->gpu_mux_dev =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> > + }
> > +
> >  err =3D fan_boost_mode_check_present(asus);
> >  if (err)
> >  goto fail_fan_boost_mode;
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/li=
nux/platform_data/x86/asus-wmi.h
> > index 9cadce10ad9a..b48b024dd844 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -128,6 +128,7 @@
> > =20
> >  /* gpu mux switch, 0 =3D dGPU, 1 =3D Optimus */
> >  #define ASUS_WMI_DEVID_GPU_MUX 0x00090016
> > +#define ASUS_WMI_DEVID_GPU_MUX_VIVO 0x00090026
> > =20
> >  /* TUF laptop RGB modes/colours */
> >  #define ASUS_WMI_DEVID_TUF_RGB_MODE 0x00100056
> >=20

