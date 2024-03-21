Return-Path: <linux-kernel+bounces-109634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7C881BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296FFB21519
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9384BE47;
	Thu, 21 Mar 2024 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex4jMLzr"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA3B657;
	Thu, 21 Mar 2024 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993039; cv=none; b=bI9B4il7nlspXshsWWW/j86YeR49ijrEmXzo8MfJ2WK80nxBNZbBjdtAln0d0g8J+KvobbuaKUyY/aL14jjIEtRK1vHYdIoMZO+j2gJSK3xdQcxSKnb5ISU6lXEtpC3uJIoUP6Oma+mM7ooguiC0l2xU+7kOBieRcyliIhEktOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993039; c=relaxed/simple;
	bh=j2S6cynCmU2K53Zp9zallN4mijbIVeN79Vr53tr35TI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GMoIT/2LoRP/B0NopJVvYcHBagSPQ4GGW4XQkKCsSJDAQWwayRVCW7rRFGqZ5SNpokng0AzFfWwyPMWcnl1MDgAIyzP+JtFzTzSfxMSPVc4/KshKK2VWI2TFO9D7mkoOWUkd+BVqxnnESxVl6e0sXNMiB06JGUPkIMVe7rcCdnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex4jMLzr; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cbf307213fso25108439f.0;
        Wed, 20 Mar 2024 20:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710993036; x=1711597836; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLaHC38H+Pyz5Wr1UNy8Cn2mnK0nIUMa7ITLIsmXL9Y=;
        b=ex4jMLzruh6hrmFcnH4oMEnFn/szXAHjGn/ES2euabX6E6KDFaWThkuwDbPN6uymEZ
         tLKiK80kYcpomaUSAUCRF3FXB0MsBrcaeh2DcX8NeEQaDqVaQBcGfLOQAUBKpwzjzsIU
         8pYlOC8CA49LBUKPThgpOdS+pBfpxNBHsLELaacUqU67ePl1J/NFKvcBSJzDUbHmWpvj
         V4tQXiHYDXGDHHdg8LNFn5C6i2vjb7wx5opEEfJjMUuibRovNn7mCl4DMCpxaHp8RxZr
         kJY+24oX9mn2ts4pMDgjs+FfNgZm/8iTXJSZ/JcmyaT3+81ALnXRumRca6f/mnUmlonX
         xlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710993036; x=1711597836;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLaHC38H+Pyz5Wr1UNy8Cn2mnK0nIUMa7ITLIsmXL9Y=;
        b=My//WiYOS8vr6uI37Po0jOxUk9vqpDUpfJvpcimVOHvKrMcgrBUL9mw2jdCiIHBI8b
         8ew2WkgYgKXfyO7SbxHTcnPaHnHLEZ2TyVJCyo6AmdoKtpPqs2sE56HAuk19TZNXWlY5
         ZrqyxOmBEWnsR/i1kpA2onI3fBixmNPxgqgDdDeOva6AAz+7cRhzUr8TrLkk98GzP5Nm
         k0YdrwtUTiDG0MUo6ldF/8RcjJPlUR0x6XbUnIZxmJ4sf8OSS7517Ap9+YIQZmWsH2j7
         LqukoAOn3grhP/JB1kBWRd9mJw4fXGx7ZqsFaVMRsjL2jqK5m+m9PNgLox7Fw6uRg8OX
         e6WA==
X-Forwarded-Encrypted: i=1; AJvYcCWETDpbCgt62GdHhei/KJ/s0XQ4RQeSAAe4fIF0Yi0RgyD3FWyA9ofFqcBPviftO67oVZS4SiyRDs4XGT8u2+r+GLUm9XVqjnMx1kX1XWU=
X-Gm-Message-State: AOJu0YxCNnlb53A++LrwFj96payU151XMq2UEvXbgYkeokf5jQ4ICRub
	wyUEzYfRCl3v7YbfD30aSzeQr97hVY79Q7u5+THhyRBwConzEgD9FYz0yWN33ZI=
X-Google-Smtp-Source: AGHT+IEmKRIX4hkK0cUpk0R85ZByUJ0UBOOyiNAkhqEE5s0Z+0fYn+TweXg+OHfXe8d4lWtD9JKqzA==
X-Received: by 2002:a05:6a20:8b28:b0:1a0:dfcc:ca95 with SMTP id l40-20020a056a208b2800b001a0dfccca95mr747241pzh.18.1710991354669;
        Wed, 20 Mar 2024 20:22:34 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id ja9-20020a170902efc900b001ddd0eb63f4sm14537860plb.105.2024.03.20.20.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 20:22:33 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B729D1837915B; Thu, 21 Mar 2024 10:22:31 +0700 (WIB)
Date: Thu, 21 Mar 2024 10:22:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	nina <kcvanna@hotmail.com>
Subject: Fwd: ax200 cannot start correctly in linux Failed to send
 MAC_CONFIG_CMD (action:2): -110
Message-ID: <Zfun9x_FeI0wZfhJ@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yvNKTecnjEuv0KB+"
Content-Disposition: inline


--yvNKTecnjEuv0KB+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Bugzilla, nina <kcvanna@hotmail.com> reported device startup failure
on ax200 device [1]. She wrote:

> The ax200 wireless network card cannot be started under Linux, but it wor=
ks fine in Windows 11. Even if I turn off fast startup and reboot windows i=
nto manjarolive or manjaro after installation, ax200 won't boot, neither wi=
ll other linux distributions.
>=20
> [  116.074418] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (acti=
on:3): -5
> [  116.074431] iwlwifi 0000:01:00.0: Failed to send MAC_CONFIG_CMD (actio=
n:3): -5
> [  116.184543] iwlwifi 0000:01:00.0: Unregistering PHC clock: iwlwifi-PTP=
, with index: 0
> [  116.628089] iwlwifi 0000:01:00.0: Detected crf-id 0x3617, cnv-id 0x100=
530 wfpm id 0x80000000
> [  116.628347] iwlwifi 0000:01:00.0: PCI dev 2723/0084, rev=3D0x340, rfid=
=3D0x10a100
> [  116.629832] iwlwifi 0000:01:00.0: api flags index 2 larger than suppor=
ted by driver
> [  116.629844] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 8=
9.3.35.37
> [  116.630152] iwlwifi 0000:01:00.0: loaded firmware version 77.ad46c98b.=
0 cc-a0-77.ucode op_mode iwlmvm
> [  116.630183] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX200 160M=
Hz, REV=3D0x340
> [  116.630258] thermal thermal_zone1: failed to read out thermal zone (-6=
1)
> [  116.808904] iwlwifi 0000:01:00.0: Detected RF HR B3, rfid=3D0x10a100
> [  116.888877] iwlwifi 0000:01:00.0: base HW address: f4:6d:3f:a6:7f:48
> [  116.916523] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
> [  117.672031] iwlwifi 0000:01:00.0: Registered PHC clock: iwlwifi-PTP, w=
ith index: 0
> [  119.807518] iwlwifi 0000:01:00.0: Error sending MAC_CONFIG_CMD: time o=
ut after 2000ms.
> [  119.807531] iwlwifi 0000:01:00.0: Current CMD queue read_ptr 27 write_=
ptr 28
> [  119.807855] iwlwifi 0000:01:00.0: HCMD_ACTIVE already clear for comman=
d MAC_CONFIG_CMD
> [  119.809783] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> [  119.809786] iwlwifi 0000:01:00.0: Loaded firmware version: 77.ad46c98b=
=2E0 cc-a0-77.ucode
> [  119.809788] iwlwifi 0000:01:00.0: 0x00000084 | NMI_INTERRUPT_UNKNOWN
> [  119.809790] iwlwifi 0000:01:00.0: 0x0000A2F0 | trm_hw_status0
> [  119.809791] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
> [  119.809792] iwlwifi 0000:01:00.0: 0x004F8B7A | branchlink2
> [  119.809793] iwlwifi 0000:01:00.0: 0x004EEC2A | interruptlink1
> [  119.809795] iwlwifi 0000:01:00.0: 0x004EEC2A | interruptlink2
> [  119.809796] iwlwifi 0000:01:00.0: 0x000152DA | data1
> [  119.809797] iwlwifi 0000:01:00.0: 0x01000000 | data2
> [  119.809798] iwlwifi 0000:01:00.0: 0x00000000 | data3
> [  119.809799] iwlwifi 0000:01:00.0: 0x0035B306 | beacon time
> [  119.809800] iwlwifi 0000:01:00.0: 0x002AEB2A | tsf low
> [  119.809801] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
> [  119.809802] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
> [  119.809803] iwlwifi 0000:01:00.0: 0x002B56B8 | time gp2
> [  119.809804] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
> [  119.809805] iwlwifi 0000:01:00.0: 0x0000004D | uCode version major
> [  119.809806] iwlwifi 0000:01:00.0: 0xAD46C98B | uCode version minor
> [  119.809807] iwlwifi 0000:01:00.0: 0x00000340 | hw version
> [  119.809808] iwlwifi 0000:01:00.0: 0x18C89000 | board version
> [  119.809809] iwlwifi 0000:01:00.0: 0x8073FC00 | hcmd
> [  119.809810] iwlwifi 0000:01:00.0: 0x20028000 | isr0
> [  119.809811] iwlwifi 0000:01:00.0: 0x60000000 | isr1
> [  119.809812] iwlwifi 0000:01:00.0: 0x08F04002 | isr2
> [  119.809813] iwlwifi 0000:01:00.0: 0x00C3400C | isr3
> [  119.809814] iwlwifi 0000:01:00.0: 0x00000000 | isr4
> [  119.809815] iwlwifi 0000:01:00.0: 0x00150148 | last cmd Id
> [  119.809817] iwlwifi 0000:01:00.0: 0x000152DA | wait_event
> [  119.809818] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
> [  119.809819] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
> [  119.809820] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
> [  119.809821] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
> [  119.809822] iwlwifi 0000:01:00.0: 0x00000008 | lmpm_pmg_sel
> [  119.809823] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
> [  119.809824] iwlwifi 0000:01:00.0: 0x0000185C | flow_handler
> [  119.810157] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
> [  119.810161] iwlwifi 0000:01:00.0: Transport status: 0x0000004A, valid:=
 7
> [  119.810165] iwlwifi 0000:01:00.0: 0x20000066 | NMI_INTERRUPT_HOST
> [  119.810170] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
> [  119.810174] iwlwifi 0000:01:00.0: 0x80455D2E | umac branchlink2
> [  119.810177] iwlwifi 0000:01:00.0: 0xC0081614 | umac interruptlink1
> [  119.810181] iwlwifi 0000:01:00.0: 0x80472CBA | umac interruptlink2
> [  119.810184] iwlwifi 0000:01:00.0: 0x01000000 | umac data1
> [  119.810188] iwlwifi 0000:01:00.0: 0x80472CBA | umac data2
> [  119.810192] iwlwifi 0000:01:00.0: 0x00000000 | umac data3
> [  119.810195] iwlwifi 0000:01:00.0: 0x0000004D | umac major
> [  119.810199] iwlwifi 0000:01:00.0: 0xAD46C98B | umac minor
> [  119.810202] iwlwifi 0000:01:00.0: 0x002B56B6 | frame pointer
> [  119.810206] iwlwifi 0000:01:00.0: 0xC0886260 | stack pointer
> [  119.810210] iwlwifi 0000:01:00.0: 0x001B0308 | last host cmd
> [  119.810213] iwlwifi 0000:01:00.0: 0x01800004 | isr status reg
> [  119.810744] iwlwifi 0000:01:00.0: IML/ROM dump:
> [  119.810748] iwlwifi 0000:01:00.0: 0x00000003 | IML/ROM error/state
> [  119.811043] iwlwifi 0000:01:00.0: 0x000067B9 | IML/ROM data1
> [  119.811130] iwlwifi 0000:01:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
> [  119.811211] iwlwifi 0000:01:00.0: Fseq Registers:
> [  119.811252] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
> [  119.811292] iwlwifi 0000:01:00.0: 0x80290021 | FSEQ_TOP_INIT_VERSION
> [  119.811333] iwlwifi 0000:01:00.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
> [  119.811373] iwlwifi 0000:01:00.0: 0x0000A503 | FSEQ_OTP_VERSION
> [  119.811414] iwlwifi 0000:01:00.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
> [  119.811455] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
> [  119.811495] iwlwifi 0000:01:00.0: 0x00100530 | FSEQ_CNVI_ID
> [  119.811535] iwlwifi 0000:01:00.0: 0x00000532 | FSEQ_CNVR_ID
> [  119.811576] iwlwifi 0000:01:00.0: 0x00100530 | CNVI_AUX_MISC_CHIP
> [  119.811618] iwlwifi 0000:01:00.0: 0x00000532 | CNVR_AUX_MISC_CHIP
> [  119.811625] iwlwifi 0000:01:00.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG=
_DIG_DCDC_VTRIM
> [  119.811659] iwlwifi 0000:01:00.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG=
_ACTIVE_VDIG_MIRROR
> [  119.811692] iwlwifi 0000:01:00.0: 0x00050008 | FSEQ_PREV_CNVIO_INIT_VE=
RSION
> [  119.811726] iwlwifi 0000:01:00.0: 0x00290021 | FSEQ_WIFI_FSEQ_VERSION
> [  119.811731] iwlwifi 0000:01:00.0: 0x00290021 | FSEQ_BT_FSEQ_VERSION
> [  119.811763] iwlwifi 0000:01:00.0: 0x00000104 | FSEQ_CLASS_TP_VERSION
> [  119.811838] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0x804727d0
> [  119.811871] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
> [  119.812126] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 =
fired (delay=3D0ms).
> [  119.812132] ieee80211 phy4: Hardware restart was requested
> [  119.812135] iwlwifi 0000:01:00.0: Failed to send MAC_CONFIG_CMD (actio=
n:2): -110
> [  119.812137] iwlwifi 0000:01:00.0: failed to update MAC f4:6d:3f:a6:7f:=
48
> [  120.680323] iwlwifi 0000:01:00.0: Failed to synchronize multicast grou=
ps update
> [  120.680433] iwlwifi 0000:01:00.0: Failed to send LINK_CONFIG_CMD (acti=
on:3): -5
> [  120.680439] iwlwifi 0000:01:00.0: Failed to send MAC_CONFIG_CMD (actio=
n:3): -5
> [  120.680444] iwlwifi 0000:01:00.0: LED command failed: -5

See Bugzilla for attached full dmesg dump.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218604

--=20
An old man doll... just what I always wanted! - Clara

--yvNKTecnjEuv0KB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZfun8wAKCRD2uYlJVVFO
o5QdAP987MgZf4w7req6JDQ3bYVN5G5Wzin/YGwixR0pHz6hdAEA6BX2oVE4wkag
TvVqkQtNTpYmeiv+9a0I7HjKV/xhcAM=
=jrOZ
-----END PGP SIGNATURE-----

--yvNKTecnjEuv0KB+--

