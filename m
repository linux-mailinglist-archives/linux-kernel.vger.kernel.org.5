Return-Path: <linux-kernel+bounces-149444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA78A9136
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01631F22017
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DD04F1FA;
	Thu, 18 Apr 2024 02:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM3BZftC"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C46FB0;
	Thu, 18 Apr 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713407912; cv=none; b=oq8n5vHq673jUSyZmg2d+tHXp9yt97j+gj3SZadZ3KBRdADMW7Vz7nEitTHMcFjWSjHoM1sM4+6D5OwyIZoHHaBMswlV61g/Tgn4SG/Dk9BwOtfdU/iMzyKghTRJmehDqDndoHf9WZ56H8ZFpaSACXrMZSlWjVTxoqrtMPfN7B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713407912; c=relaxed/simple;
	bh=2/BplMB/+NX39KzviOne3YvcFRg/KQzo16KNiJwJ4bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg3bzIfzDNL7HaNIXAfyd5++grT3aDIn/j7alzHFmUayfWxIXdDJ1aCKxLwJSPrO4mUzhjQqCWfT9gaH2XhaFHmG6xuHAnrURHvBBrG1PmQBDOOEu2tZGEC114UdgYPfFokmiKdb9Q11UED28x1WlPsqdWjFbYGGPNvEvmqiDC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM3BZftC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed32341906so448424b3a.1;
        Wed, 17 Apr 2024 19:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713407910; x=1714012710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+K4sgg9aCm8qn+G/ntS65DmA1a0W6wNNqGijj5xDwRw=;
        b=kM3BZftCYpNRU9NqysGOuBK8t/x1CaB1gMIcCfLmAhIlWJN+GdBvwqiiDVji6HTYtC
         Ych80x2ZQFwL6aCuqArdB5s0jvB2GZH5LU9TujrBAz3zmLw5P/3SjEUajN9rp7mwI0YA
         UTSIafXZs4Ak9uoaDPDCHpMaabnJQqqS0DEoaDUofxo5XvgsOHn9J+ETUdVsl/htx9mP
         O4FvXcu5WidbG8bUioa79SWOIrMlgi0o6rNIp7No9k+KRJ8hKfdK80pXMoAhtFT3+bmj
         1F9Cky9hIxgp5MC/OuZ3Xn1SR2oLRxAsGkASgprqZh1aANtRk3ISrSujxL3VKgKOq5/d
         3Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713407910; x=1714012710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K4sgg9aCm8qn+G/ntS65DmA1a0W6wNNqGijj5xDwRw=;
        b=Ar+gIFtC2c/TbjWuTIHQUIrOgLf+2fcdwtTVg/1gzc/1+cJwmq4c2sXxlBxZQk/1hM
         YRco9ivIR9csk85Gr4Q+5UzRHQP4Wx3C9QB1KRgyW9M/8oIK2EYD0UWiZfJk6MZqAbOu
         ILD3WWgmuxp8K3htizTIp3CKLVPt2wO/SBpk9W067KzRCJ/ByTNOsDu2AeeGu+fgMf11
         SA5HM9UJOwE8Lkp2Ei+8z/IEU4kMIEagjnOP0Tfy005pIyfwR/TS7zwxRNrxg6hjMa61
         UNQllZ4gHplOUGZoK1w5FcyFjI7CMJQS09jG/ILUb0PvrOJfk5K/IdJ+WgvZ8ZRkSI/b
         kJpA==
X-Forwarded-Encrypted: i=1; AJvYcCUVh5w9cHbaoz9BA9OWPOALfWy5Ff9BciB04TdOhMBN0rwDK8EXCSSWdxGkO6rOiZI/tbsAaYAqwQUBSxvpGlXLve051QDXP+gjreEysIAF0pdpypxde5MNnyBsGjInU9NLqfghXE16Qd3scORoIJAlphpVWJiZF7/mP2VcFVj2
X-Gm-Message-State: AOJu0YxY1N5YWPCiHl7p+Z1WPeO6DReDSaqXuqAPk+uJKQFpUN1wVXjb
	h81Pp+xGnUEFhgkXGBzxoermqExmzWGbdX8pea8cblP+psjSROLM
X-Google-Smtp-Source: AGHT+IEUVVnRvZxZrZhTcboaTALn+DFf5fhvExyo9g/fu7Aoq5uBj3vcvOQhvSWynLrZ1OycCRPNlQ==
X-Received: by 2002:a05:6a00:10c2:b0:6ea:d149:c4e with SMTP id d2-20020a056a0010c200b006ead1490c4emr1778396pfu.14.1713407909732;
        Wed, 17 Apr 2024 19:38:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id e21-20020a62ee15000000b006e729dd12d5sm381007pfi.48.2024.04.17.19.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 19:38:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DBD2E181A49EF; Thu, 18 Apr 2024 09:38:26 +0700 (WIB)
Date: Thu, 18 Apr 2024 09:38:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, linux@armlinux.org.uk,
	sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next v3 03/10] ethtool: Add an interface for flashing
 transceiver modules' firmware
Message-ID: <ZiCHotDYOfkPrDUt@archie.me>
References: <20240417085347.2836385-1-danieller@nvidia.com>
 <20240417085347.2836385-4-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U4yNIw1J+x8YhZS5"
Content-Disposition: inline
In-Reply-To: <20240417085347.2836385-4-danieller@nvidia.com>


--U4yNIw1J+x8YhZS5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 11:53:40AM +0300, Danielle Ratson wrote:
> +MODULE_FW_FLASH_ACT
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Flashes transceiver module firmware.
> +
> +Request contents:
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +  ``ETHTOOL_A_MODULE_FW_FLASH_HEADER``     nested  request header
> +  ``ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME``  string  firmware image file n=
ame
> +  ``ETHTOOL_A_MODULE_FW_FLASH_PASSWORD``   u32     transceiver module pa=
ssword
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The firmware update process is composed from three logical steps:
                          "... consists of ..."
> +
> +1. Downloading a firmware image to the transceiver module and validating=
 it.
> +2. Running the firmware image.
> +3. Committing the firmware image so that it is run upon reset.
> +
> +When flash command is given, those three steps are taken in that order.
> +
> +The ``ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME`` attribute encodes the firmwa=
re
> +image file name. The firmware image is downloaded to the transceiver mod=
ule,
> +validated, run and committed.
> +
> +The optional ``ETHTOOL_A_MODULE_FW_FLASH_PASSWORD`` attribute encodes a =
password
> +that might be required as part of the transceiver module firmware update
> +process.
> +
> +The firmware update process can take several minutes to complete. Theref=
ore,
> +during the update process notifications are emitted from the kernel to u=
ser
> +space updating it about the status and progress.
> +
> +Notification contents:
> +
> + +---------------------------------------------------+--------+---------=
-------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_HEADER``              | nested | reply he=
ader   |
> + +---------------------------------------------------+--------+---------=
-------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_STATUS``              | u32    | status  =
       |
> + +---------------------------------------------------+--------+---------=
-------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG``          | string | status m=
essage |
> + +---------------------------------------------------+--------+---------=
-------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_DONE``                | u64    | progress=
       |
> + +---------------------------------------------------+--------+---------=
-------+
> + | ``ETHTOOL_A_MODULE_FW_FLASH_TOTAL``               | u64    | total   =
       |
> + +---------------------------------------------------+--------+---------=
-------+
> +
> +The ``ETHTOOL_A_MODULE_FW_FLASH_STATUS`` attribute encodes the current s=
tatus
> +of the firmware update process. Possible values are:
> +
> +.. kernel-doc:: include/uapi/linux/ethtool.h
> +    :identifiers: ethtool_module_fw_flash_status
> +
> +The ``ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG`` attribute encodes a status =
message
> +string.
> +
> +The ``ETHTOOL_A_MODULE_FW_FLASH_DONE`` and ``ETHTOOL_A_MODULE_FW_FLASH_T=
OTAL``
> +attributes encode the completed and total amount of work, respectively.
> +

The rest of doc LGTM.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--U4yNIw1J+x8YhZS5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZiCHnAAKCRD2uYlJVVFO
o9u5AQCh991QKxPxVHkr+z8uTqo7QtFFLL6GSuC0d8NU9MjenwEAh7gsRfJhdnbM
bPm7npHuWepvh/Y0G1tafcOvUPUNKwg=
=VpL+
-----END PGP SIGNATURE-----

--U4yNIw1J+x8YhZS5--

