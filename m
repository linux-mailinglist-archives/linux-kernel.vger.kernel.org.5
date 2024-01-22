Return-Path: <linux-kernel+bounces-33984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE3837168
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E6D1C29EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8304F8AD;
	Mon, 22 Jan 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ6JSGye"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7574F8A3;
	Mon, 22 Jan 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948213; cv=none; b=siStNunE1ndkXKMDYdifxYcn8HSPn49zfx6iUOwVbCeN1fsKWcPEXGmm2P75icEmSXQ3H1h7VxRE5Y8nnuDaAG7JkcNUiltxWlkxfS9gZyG4Tf6GmNtBS9z7Jj7rbeE4hWf1sE8n+1O5ix7orLPcSMXQ9T9Y+QU8N2/7cqN0/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948213; c=relaxed/simple;
	bh=ZObfcGP+YoHst80fAcbqeVtI6wepDHi3JQFGZbUtPxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQx8A7kS9vbeMCw7flOvKJkrOnJ03PZ95q7lbvYkQSiFRjDxD+nwX4jlKQ/Cp1rz8/SBHZCzDJOBTJVsN7EKxEMp1Vn+TBg0OgxIOU8jj3Y/8D09WwALFh/XZKBKk+vlxKMGIuUwP65lfvCf2z1Qh/Iq85J9a813dgkUoz1qwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ6JSGye; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e8d3b29f2so41905535e9.1;
        Mon, 22 Jan 2024 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705948210; x=1706553010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SCLKpuS/EQzGTDzj4ZYNPiG/UyE84EpCOUJLRK52aE=;
        b=fZ6JSGyevIKAfqeZLMhRZfDlauljhlSrKYHrP6YcvA+6/dIsaCO/rIpZDF5EO1bNN7
         6VfqoKaOMFDT0pPLeKqYZ3UnW95eF2U8Q5I8qQTiafdh/Aay3sxZGIktN9+OomSjUBpX
         bx8J0B3Jf1VFIP6wvmPq90oHRypYLT6guDUYgC2x0P5XIvvtnl9OyA1KB3ur2Yi/cF5p
         7K+o8G/zCUj//ET5z5uxpYJ2TC/n/MtboOl0UVpbTgH65S3w2O6IEtIbdKFJ5sohccb+
         tAiB+Pjixac5IwY7UfDhYIFAF3NhH7c6Nz4rxhzcUWIfRP38eDQyyKs4/LC/zxff9LAb
         DA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948210; x=1706553010;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SCLKpuS/EQzGTDzj4ZYNPiG/UyE84EpCOUJLRK52aE=;
        b=e3U2maBACQVgCZjqNLEBQwn9mQIH2pUmqVmWrL5xHJvl+dgffAf8J1KvWwis3Rlie7
         u6zFzQ7Vl8eSlIgA/KigFlOYfQkDezH6GOKnmUQAUckXivsKhn+OuUeZ1qP4pM0owSac
         6RSp1L8eQBoTFysax/ewMdsH4uhDgaHPCDoyv6R2wvcyzUFe4543E2fkZLZ+Hell/eF7
         GvrHeC7q2MP9Y4XoqUzjVqlCToQEWPOo4MwBYbEK/CEAuIVKM2H+34ywUGltHn5v48si
         HQdtHZ0EjbcTvWGGChDpU4fE98duRdlka9gGkhYQBIJYJ8c7HXsJP6mgmjV4rGiAWNxd
         RKVw==
X-Gm-Message-State: AOJu0YyWWWAygoGigUifniRTu7Q6Zenfilt/VVy+yKCe93L5Sq46ZWtK
	zkMEIG92KLB687Kad8rMPWo10dm4sqPeTIz5k0LANd0O7SFQds17JrVb9af+
X-Google-Smtp-Source: AGHT+IGAy43KXNuhdBe+6XJN85HCoZu/ilutcy4svjUNB8hvzUTTadQBZn7KnQ5ijqhvYA1/xwzvog==
X-Received: by 2002:a05:600c:2258:b0:40c:3e6b:efe8 with SMTP id a24-20020a05600c225800b0040c3e6befe8mr1767944wmm.241.1705948209846;
        Mon, 22 Jan 2024 10:30:09 -0800 (PST)
Received: from ?IPv6:2a02:168:6806:0:69e:e66e:2a53:42b5? ([2a02:168:6806:0:69e:e66e:2a53:42b5])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b0040eaebc4e8fsm3577822wms.1.2024.01.22.10.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:30:09 -0800 (PST)
Message-ID: <d8724cd416494bb5cd5b0350266fce0cb7b3b210.camel@gmail.com>
Subject: Re: [GIT PULL] SPI updates for v6.8
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Jan 2024 19:30:09 +0100
In-Reply-To: <20240107223817.EDB59C433C7@smtp.kernel.org>
References: <20240107223817.EDB59C433C7@smtp.kernel.org>
Autocrypt: addr=klaus.kudielka@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-07 at 22:38 +0000, Mark Brown wrote:
> The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471=
ab:
>=20
> =C2=A0 Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)
>=20
> are available in the Git repository at:
>=20
> =C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git=C2=
=A0tags/spi-v6.8
>=20
> for you to fetch changes up to f6cd66231aa58599526584ff4df1bdde8d86eac8:
>=20
> =C2=A0 spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 s=
oc (2023-12-21 20:44:05 +0000)
>=20
> ----------------------------------------------------------------
> spi: Updates for v6.8
>=20
> A moderately busy release for SPI, the main core update was the merging
> of support for multiple chip selects, used in some flash configurations.
> There were also big overhauls for the AXI SPI Engine and PL022 drivers,
> plus some new device support for ST.
>=20
> There's a few patches for other trees, API updates to allow the
> multiple chip select support and one of the naming modernisations
> touched a controller embedded in the USB code.
>=20
> =C2=A0- Support for multiple chip selects.

[skipped the rest]

Hi, it seems I have an issue related with this new feature.

I just booted 6.8.0-rc1 on Turris Omnia (CONFIG_SPI_ORION=3Dy,
device tree: arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts)

and got the following error:

[    0.090231] spi_master spi0: No. of CS is more than max. no. of supporte=
d CS
[    0.097358] spi_master spi0: Failed to create SPI device for /soc/spi@10=
600/flash@0

End result: the three MTD partitions I used to have on the SPI-NOR are gone=
.

***

For reference, here's the output of 6.7.0 (configs as identical as they can=
 be):

[    0.087965] spi-nor spi0.0: s25fl164k (8192 Kbytes)
[    0.183729] Freeing initrd memory: 4676K
[    0.191605] 3 fixed-partitions partitions found on MTD device spi0.0
[    0.191619] Creating 3 MTD partitions on "spi0.0":
[    0.191624] 0x000000000000-0x0000000f0000 : "U-Boot"
[    0.191837] 0x000000100000-0x000000800000 : "Rescue system"
[    0.191982] 0x0000000f0000-0x000000100000 : "u-boot-env"


I haven't bisected this further, but maybe the error message already rings =
a bell.


Best regards, Klaus


