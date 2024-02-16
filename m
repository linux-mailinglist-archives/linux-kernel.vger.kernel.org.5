Return-Path: <linux-kernel+bounces-68226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D30C857794
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2B128547C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D8E1D54F;
	Fri, 16 Feb 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b="bXDEcl+Y"
Received: from whm50.louhi.net (whm50.louhi.net [77.240.19.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725B1D546
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.240.19.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071596; cv=none; b=YJbtzW0RfwXCoHRr352SuxWFw2KsQtreM2WwoqiaZFJP4dh1GNyLqfzyzjX8uhzLMbVsu30VoUrFZqqBl9Hnefqgk1yu9JwGpJxzDSTgMjm8dAMyRRuryMtNKVEcm5soC1tQRwe985DkIbqy6PVLFLaJUaLilUmPdkQDFo5foyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071596; c=relaxed/simple;
	bh=uGpKEecCmfuEyzbj6dA7yDBuDlpAYE7i+nfn0lZLzFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPApxzsf84oLRjQKazWdHAD5aBuenzh+pu4hLVzI5DwBBcxo2lyw9ophMlOJJ2AXcIiooNVG/etTH4Ppu5KzgS1Qi6izKvV+DwPZX3Um6PG2qBS88SiTpsFT8MwICsiiaEeOn056fEx6amQUzoModH78P611PFFCGm5Z0laf+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi; spf=pass smtp.mailfrom=haloniitty.fi; dkim=pass (2048-bit key) header.d=haloniitty.fi header.i=@haloniitty.fi header.b=bXDEcl+Y; arc=none smtp.client-ip=77.240.19.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haloniitty.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haloniitty.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=haloniitty.fi; s=default; h=Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SwArZZWoMGaUCC+AgKvruw60znKf1jRE+TFnKaPirqQ=; b=bXDEcl+YuVId6rnVYekHhMzP3m
	8VFTkcifS/od+wIoEWEZmqojntpPTVvKkyPo/o6Ct9sDh7TXU28ldRbXwmrVoiJ/ELzBp8eKhR3p7
	kxss9xDt1E1B6oKtymfcp3oh36SLnfh04pA94ai2xmrQPRqlxLT47gaW6CttbAzuty6YYjsUMsqxu
	VkvJMYkf7XdvLUS4u77ltc72S42TOxLAqGeQO03Vf1FM8pQ9R2wMcvUuHCGwJSEKxl3pz9LCkOPZe
	5Zl2xs9kwZUu7go8VrYgbYjEuWpH2tfm+EoV3HK/bm57WzBYE57KnTwdg8kVEE6GpmfDjlkTnJn4y
	QsEbgJvQ==;
Received: from [194.136.85.206] (port=48728 helo=eldfell)
	by whm50.louhi.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <pekka.paalanen@haloniitty.fi>)
	id 1ratRf-0004TR-1u;
	Fri, 16 Feb 2024 10:19:43 +0200
Date: Fri, 16 Feb 2024 10:19:36 +0200
From: Pekka Paalanen <pekka.paalanen@haloniitty.fi>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo
 Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Alex Hung
 <alex.hung@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/amd/display: add panel_power_savings sysfs entry
 to eDP connectors
Message-ID: <20240216101936.2e210be2@eldfell>
In-Reply-To: <20240202152837.7388-1-hamza.mahfooz@amd.com>
References: <20240202152837.7388-1-hamza.mahfooz@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N0j5fPzI_9+T2QzPPLs30WV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whm50.louhi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - haloniitty.fi
X-Get-Message-Sender-Via: whm50.louhi.net: authenticated_id: pekka.paalanen@haloniitty.fi
X-Authenticated-Sender: whm50.louhi.net: pekka.paalanen@haloniitty.fi
X-Source: 
X-Source-Args: 
X-Source-Dir: 

--Sig_/N0j5fPzI_9+T2QzPPLs30WV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Feb 2024 10:28:35 -0500
Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:

> We want programs besides the compositor to be able to enable or disable
> panel power saving features.

Could you also explain why, in the commit message, please?

It is unexpected for arbitrary programs to be able to override the KMS
client, and certainly new ways to do so should not be added without an
excellent justification.

Maybe debugfs would be more appropriate if the purpose is only testing
rather than production environments?

> However, since they are currently only
> configurable through DRM properties, that isn't possible. So, to remedy
> that issue introduce a new "panel_power_savings" sysfs attribute.

When the DRM property was added, what was used as the userspace to
prove its workings?


Thanks,
pq

>=20
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v2: hide ABM_LEVEL_IMMEDIATE_DISABLE in the read case, force an atomic
>     commit when setting the value, call sysfs_remove_group() in
>     amdgpu_dm_connector_unregister() and add some documentation.
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8590c9f1dda6..3c62489d03dc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6436,10 +6436,79 @@ int amdgpu_dm_connector_atomic_get_property(struc=
t drm_connector *connector,
>  	return ret;
>  }
> =20
> +/**
> + * DOC: panel power savings
> + *
> + * The display manager allows you to set your desired **panel power savi=
ngs**
> + * level (between 0-4, with 0 representing off), e.g. using the followin=
g::
> + *
> + *   # echo 3 > /sys/class/drm/card0-eDP-1/amdgpu/panel_power_savings
> + *
> + * Modifying this value can have implications on color accuracy, so tread
> + * carefully.
> + */
> +
> +static ssize_t panel_power_savings_show(struct device *device,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct drm_connector *connector =3D dev_get_drvdata(device);
> +	struct drm_device *dev =3D connector->dev;
> +	u8 val;
> +
> +	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> +	val =3D to_dm_connector_state(connector->state)->abm_level =3D=3D
> +		ABM_LEVEL_IMMEDIATE_DISABLE ? 0 :
> +		to_dm_connector_state(connector->state)->abm_level;
> +	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}
> +
> +static ssize_t panel_power_savings_store(struct device *device,
> +					 struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	struct drm_connector *connector =3D dev_get_drvdata(device);
> +	struct drm_device *dev =3D connector->dev;
> +	long val;
> +	int ret;
> +
> +	ret =3D kstrtol(buf, 0, &val);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (val < 0 || val > 4)
> +		return -EINVAL;
> +
> +	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> +	to_dm_connector_state(connector->state)->abm_level =3D val ?:
> +		ABM_LEVEL_IMMEDIATE_DISABLE;
> +	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +
> +	drm_kms_helper_hotplug_event(dev);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(panel_power_savings);
> +
> +static struct attribute *amdgpu_attrs[] =3D {
> +	&dev_attr_panel_power_savings.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group amdgpu_group =3D {
> +	.name =3D "amdgpu",
> +	.attrs =3D amdgpu_attrs
> +};
> +
>  static void amdgpu_dm_connector_unregister(struct drm_connector *connect=
or)
>  {
>  	struct amdgpu_dm_connector *amdgpu_dm_connector =3D to_amdgpu_dm_connec=
tor(connector);
> =20
> +	sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
>  	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
>  }
> =20
> @@ -6541,6 +6610,13 @@ amdgpu_dm_connector_late_register(struct drm_conne=
ctor *connector)
>  		to_amdgpu_dm_connector(connector);
>  	int r;
> =20
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> +		r =3D sysfs_create_group(&connector->kdev->kobj,
> +				       &amdgpu_group);
> +		if (r)
> +			return r;
> +	}
> +
>  	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
> =20
>  	if ((connector->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort) ||


--Sig_/N0j5fPzI_9+T2QzPPLs30WV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmXPGpgACgkQI1/ltBGq
qqc/7hAAlGiJifPdESkeAkI4ecEIa/VhPtuaQOWtX9tA2Lv+8u5VMhA0YyAn2ql2
dYiw24Gu1A1b69qvyUvKzQPbhBX80PT9LEfzysYMpjCVZMv/9VlvANNZaQUojoYV
a9+ETsbiugKUxWLgj8q7a522nPTfqZ4Hg0X0wlt31qQ9eRQDZv8v2z+x6FvEn70V
R3C3Pi2NXCjYkqG3F+n9fcN2JDUSFFFrIZuwPJIi4MO8PWUNk47a+nyxOVKmAI/E
MwoGilxW7pm/B7W1A1FfKo/FS+G8KhWchNB70nsE+x1fxEOLd0YypFH8fIlT86T5
rkUNueHG73/do6FEdx5TOB//stiSnG7RRSJA2xOYd2iwPZB5VdQ/v9YB9EyW2zun
ba9Ne51RpmT1VDBxrknWZV/wCtoRiMzRAXl4YPLlXkYZtWids7+OzJR9R2oDGw13
8k0lgfgvV3cWFtEXpNXdcL1ErTOeow8/vmST2BTPVhuDw04pdU0RsQriV8ZygEwz
cXmpEgkfpn/Ay8Ppe5l0Jw0IuSGRW90Sf4hmd7SQ5klLB/lV4CxLAF+xtoMDbzfP
Ok8485dWkxEntrpGLvR/LcLXRyLuRIAFD5znUbKlBKCWQcPn8l+4gt93S2e9jiWV
bU3eKOG1TEAOgW7hSD/yWeFQr5ceYxERSdPaMn2rN6pp2X5NiGw=
=N/D3
-----END PGP SIGNATURE-----

--Sig_/N0j5fPzI_9+T2QzPPLs30WV--

