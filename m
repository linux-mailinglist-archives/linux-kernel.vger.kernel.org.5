Return-Path: <linux-kernel+bounces-147925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76BA8A7B63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066981C2177B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9A249FF;
	Wed, 17 Apr 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNxW7Rp9"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1A63AE;
	Wed, 17 Apr 2024 04:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328400; cv=none; b=qqZ72fsufZkOLZ/aM27eQMQBTR8DYopVPpJnu75lOVPKs2mXUPRQ5zS9TpxkTVXQu5evxjMtEFUsZqRUDOl28bWA57Q08XMlLynw0K0SpIf/R+SGnfCKZ68bKQTJuFOBUUAY6GeuYSrDjWLv+i8Rc5mujS2HHkWi+lbnuqZU9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328400; c=relaxed/simple;
	bh=mpLVDTpLKi8XhShf+G/CR25JR+GxJ8I+joDMKVFHlz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjRpFWKXCsFr//dCCVNw6/F8HPExl4paR5GqMztizLpbnqEne7suv99uqyCcYeqoTVU72ugM5DZpOvTKzyJVH1cCXmi2WhNWUUAPdVcbl9nArp3eHJsQRUJBBf4SqL2U10MH/ItsjfddmbZM7xoDzzx0IVUjx1baIox38knf+RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNxW7Rp9; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c6f6c5bc37so2393446b6e.1;
        Tue, 16 Apr 2024 21:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713328397; x=1713933197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dANZrBMiijKB2V95Yw9K7Z4407mntfdnL1YgZToKFjc=;
        b=mNxW7Rp9uk61YilBWoW86OmLMDMntg4o93rZ9lWK0q+Oq2Baafe82afVUgibOKRte3
         2xr26DhDhAwd6B907As4CLbGzm5JFFriTF3XM6q/WAG4v8j+bo4gE7eOJ+IXCBTLVbCY
         m0n/igGPM7ozDeiNHF3s2984eJuWQPN6T3If7h/GMV6AtVYousP7DgtavwmZu1JX/4SW
         lSIqwO50ictYmgGJBqJH2xESViOvhcDVEpn+7VkfaFgzwVPpNRDpzfco5JGpH1hIM2S1
         2r6iw/Eagvt79AAXe+HWm1qhW+JXVwM+t/0NSWD0Bl7wXZnl2OhEG4brtxi9DFs2Hcj6
         pfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713328397; x=1713933197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dANZrBMiijKB2V95Yw9K7Z4407mntfdnL1YgZToKFjc=;
        b=vubPxXzylaINz8UVOKfZ5tqquxWYAWYzLQKDtwqRn7gTGp9zbF9gq2gvN16lzz1Uh1
         PkP8d8zYQLqCtMDwEAr40rrtgB/vLwYT5ySNKUjjhjMV8eAW15PGkfi0r1l4MQBoh4zM
         XSajWV0tUiWCc/Hzdu+WaJdLEv0piRJDo5yQW4vKWWz9Egt8+gk+duSRXwak3ZhI5afN
         mfg1iXXtXWlmuZGs6wHljrPeh+/+ymjkfuwSmM5udIzkEWFRrlr0iWP+EYmpV/7yxwMV
         vdpvVO6C4FH3ERlUyLZog0JzCTSsvhCJaYy/1iaelRrn077+TLOncTXoceefsj2mfEx6
         iK4A==
X-Forwarded-Encrypted: i=1; AJvYcCXEoHguWmAZME63FiEofZOna+Wvxxz6vnb8CA5Co1a3DIFGjnQsZ3HVtPRkgWCnmw3bdzjI7B6Gq3VELV8vsGD4Qhk2jSAUJGP6Lr6Xm8oBMUz9J23xVAev2oHwHX6hS0WMlq2PviHzmSqL5RGgohyzBVD3UHONEg8w4QygpHKlUg4PtU8=
X-Gm-Message-State: AOJu0Yw+wuy/lfneODUiJRUtEH7lpjQb5dGwAEfxSqR1AVrFN8CWlmrZ
	d7MBN2gcZgAXmQIAAeEnpkEqouk6vWj+Hmam5HwaFAzI8d2/HMP7
X-Google-Smtp-Source: AGHT+IFDGMEcFzil5Q4JYz4MGQ3VGv+hJJvcufyp+5Lti0PISMPOCGd6Dz5mz+jD4Ao5+wMnPx36xA==
X-Received: by 2002:a05:6808:315:b0:3c6:f7bd:9825 with SMTP id i21-20020a056808031500b003c6f7bd9825mr15472406oie.22.1713328397578;
        Tue, 16 Apr 2024 21:33:17 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id lc11-20020a056a004f4b00b006e6529c7d75sm9865203pfb.3.2024.04.16.21.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 21:33:17 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 503BE184797FA; Wed, 17 Apr 2024 11:33:13 +0700 (WIB)
Date: Wed, 17 Apr 2024 11:33:12 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-sound@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] ASoC: doc: dapm: improve section "Codec/DSP Widget
 Interconnections"
Message-ID: <Zh9RCMdihgSyZqTw@archie.me>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
 <20240416-dapm-docs-v1-10-a818d2819bf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ljvRn32hn8AsjPHI"
Content-Disposition: inline
In-Reply-To: <20240416-dapm-docs-v1-10-a818d2819bf6@bootlin.com>


--ljvRn32hn8AsjPHI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 07:56:16AM +0200, Luca Ceresoli wrote:
> -Each input in this example has a kcontrol associated with it (defined in=
 example
> -above) and is connected to the output mixer via its kcontrol name. We ca=
n now
> -connect the destination widget (wrt audio signal) with its source widget=
s.
> -::
> +Each input in this example has a kcontrol associated with it (defined in
> +the example above) and is connected to the output mixer via its kcontrol
> +name. We can now connect the destination widget (wrt audio signal) with =
its
> +source widgets.  ::
> <snipped>...
> -Interconnections are created with a call to:
> -::
> +Interconnections are created with a call to::
> =20

Not strictly related to this patch, but for consistency, I'd like
to write remaining literal block markers at the end of previous
paragraph:

---- >8 ----
diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dap=
m.rst
index f76fc97dd16219..e4c44d08c8380b 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -180,15 +180,13 @@ Path Domain Widgets
 -------------------
=20
 Path domain widgets have a ability to control or affect the audio signal or
-audio paths within the audio subsystem. They have the following form:
-::
+audio paths within the audio subsystem. They have the following form::
=20
   SND_SOC_DAPM_PGA(name, reg, shift, invert, controls, num_controls)
=20
 Any widget kcontrols can be set using the controls and num_controls member=
s.
=20
-e.g. Mixer widget (the kcontrols are declared first)
-::
+e.g. Mixer widget (the kcontrols are declared first)::
=20
   /* Output Mixer */
   static const snd_kcontrol_new_t wm8731_output_mixer_controls[] =3D {
@@ -244,8 +242,7 @@ Virtual Widgets
=20
 Sometimes widgets exist in the codec or machine audio graph that don't hav=
e any
 corresponding soft power control. In this case it is necessary to create
-a virtual widget - a widget with no control bits e.g.
-::
+a virtual widget - a widget with no control bits e.g::
=20
   SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
=20
@@ -316,7 +313,7 @@ For example the WM8731 output mixer (wm8731.c) has 3 in=
puts (sources):
 Each input in this example has a kcontrol associated with it (defined in
 the example above) and is connected to the output mixer via its kcontrol
 name. We can now connect the destination widget (wrt audio signal) with its
-source widgets.  ::
+source widgets::
=20
 	/* output mixer */
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
@@ -347,8 +344,7 @@ Machine Widget Interconnections
 Machine widget interconnections are created in the same way as codec ones =
and
 directly connect the codec pins to machine level widgets.
=20
-e.g. connects the speaker out codec pins to the internal speaker.
-::
+e.g. connects the speaker out codec pins to the internal speaker::
=20
 	/* ext speaker connected to codec pins LOUT2, ROUT2  */
 	{"Ext Spk", NULL , "ROUT2"},

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ljvRn32hn8AsjPHI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh9RCAAKCRD2uYlJVVFO
o6WpAQDqeQVtGKQFGdD1X92culQ6ywquZCZjyL1KTr2mheywigEA8mh479ZKhKPs
GpSKPy9F/aEyiG2pG89/J2bGkXHVtwY=
=i9o4
-----END PGP SIGNATURE-----

--ljvRn32hn8AsjPHI--

