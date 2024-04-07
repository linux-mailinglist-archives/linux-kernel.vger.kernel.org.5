Return-Path: <linux-kernel+bounces-134594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCAC89B358
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435E11C21179
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E62F3BBCF;
	Sun,  7 Apr 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEEROaIn"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1591E864;
	Sun,  7 Apr 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712511455; cv=none; b=oSJhfyNurQ7ZayKF534HL8k1ZZhkAD//RGz5TlpR9aYaFPigFq/DWrE8TvAFmkAhAynN4+JS8oDOG2YC9S8eDfBY5b3Pz29wjz8R1e6dzhAJm3E8KDSoFajcj+4ix13p13tTtn9f6FwSY+LQpBIcWIMotegrCOIg8uGKunTlylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712511455; c=relaxed/simple;
	bh=5E3I208ZRfLfnXBiRp3HidYhlnwHD8M9uL2fwenzHlo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ci6aiuuSc9s0NxbXFTYNu1HwU6zEGv9a6BzvfyU6t5HjR4axlbKrkUEpzbCgPKJR9tlYprLFCvDkLdfJ63QC37RTC+7BIV3CyLgxOLRd4mHDVjQ3Q36KnEBOHqZJRLNEArkIe7xyj0iVpZaHvEezXXXUaprz5V3HqFzANtfeeU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEEROaIn; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so677085e87.1;
        Sun, 07 Apr 2024 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712511452; x=1713116252; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiAuzQn2Z2TB48wpHO151bWpj2tXPyvASblLxy16+ls=;
        b=AEEROaIn9FjOQDIEpv8qzoRfdQhvZCGVClBD6KlpyLjl4cBCLpdk+YLZ40zZmYzc2Y
         ublM+4Yu/8Pw3Sf/9TN1aC4FnDQ1sxu3KFOXKX6dWgp7j1cPecWo+FxafTQfcB4lDPD5
         lDmQZBt1WY9q8pyX5kBXcnQEdNitdpTT/DGFwcnSVlkS4N39No/HGp8/0b632jeS5wuv
         /cyX8D5oW+osTSds8g9DiOR7tjle1auYa7KsxVJhesmHF0vkv6JXkciska+rBjWnzE+i
         8GGT8jLMM9++WA3uHz5uGnGS6uHyp28a7cyUZFQn6NSoiMXMuz44bEqIvTv6M6WXysBz
         fv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712511452; x=1713116252;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiAuzQn2Z2TB48wpHO151bWpj2tXPyvASblLxy16+ls=;
        b=ED5FXTNktC17S5kgE5qvA6jyU559z8x2y47Vdo4i7+9qeoAFoqlA+rph63FELnu+p+
         MjnfaKAubslxBaqcvxMiOgTyUL6S8oIlNOBk3LkYDzmkWrKgK7f3q+jeIaMUdsgnlPJb
         tbmgjBwLkv9wQX4Y1O7z0iaLRsBB0sbRDfEY2sXvMNGpkCnr9XP83JYxz4aG9zt1EpWY
         R9m0LnHlpvc60PXnfbeO8PRcjxHZvOKmQ4FMUxZE+33s8lIvXOwI+ncDWycGxRTdvVS5
         9oqPcB0spB77s3Z7BCbxZYPikofz+hrwk54reqQ2TdSCPEgdkpmBfrsIYCsgZuICr6Tz
         aoCA==
X-Forwarded-Encrypted: i=1; AJvYcCVAT6ZkoDkGtIoQPLWTnMc/d11KSmUmQfL6tgKa+8gsEZ2/u8n3RI1Ja0IbXBXV1X+BJccJFBhMwgfPcue+pP486ORV2pv3a06jUQDzFoiygAMvUXcYmv9duMKu9G4n/opiPDW/1m4=
X-Gm-Message-State: AOJu0YybtcGnCk7jmvNO3D4ILs015PBJ61qSaLFBR3dGzbtRoP3U5QxE
	1Meh7bB3f4QkxZA95TzEcPFakNAHs62qK/GSzkV67Z9wvWOnscUQ
X-Google-Smtp-Source: AGHT+IG29g68C2NTBORFcpoM+CsYGHQEH7u1c7R6m+exnck9GhHNuVs6qlv3W6w3fNSnAGwG+0GVGA==
X-Received: by 2002:a05:6512:4015:b0:516:a6ff:2467 with SMTP id br21-20020a056512401500b00516a6ff2467mr5800058lfb.0.1712511451821;
        Sun, 07 Apr 2024 10:37:31 -0700 (PDT)
Received: from smtpclient.apple (2a01-036d-0103-8d29-0484-7a18-3936-0af1.pool6.digikabel.hu. [2a01:36d:103:8d29:484:7a18:3936:af1])
        by smtp.gmail.com with ESMTPSA id xi1-20020a170906dac100b00a51d3785c7bsm508799ejb.196.2024.04.07.10.37.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 10:37:31 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] intel_idle: Add RaptorLake support
From: =?utf-8?B?TMOhc3psw7MgUMOpdGVy?= <peter.laszlo2@gmail.com>
In-Reply-To: <7e2c1da24b48217045e8ad95b739ec96cdce5931.camel@intel.com>
Date: Sun, 7 Apr 2024 19:37:19 +0200
Cc: "smarter3@gmail.com" <smarter3@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "noltari@gmail.com" <noltari@gmail.com>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Bityutskiy, Artem" <artem.bityutskiy@intel.com>,
 "Kumar, Vinay" <vinay.kumar@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCBB0027-F0E9-42EE-BB43-D50091D9115F@gmail.com>
References: <20230119070205.90047-1-noltari@gmail.com>
 <c79904e98b86b68c87add286aa1487b3f81712b6.camel@intel.com>
 <c7d1eced-d77b-aca7-1422-6eefaf704f3e@gmail.com>
 <7e2c1da24b48217045e8ad95b739ec96cdce5931.camel@intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 20 Aug 2023, at 11:20, Zhang, Rui <rui.zhang@intel.com> wrote:
>=20
> This is still work in progress because there are still some open
> questions that we cannot answer from our measurement, and the table is
> not finalized yet.
>=20
> thanks,
> rui
>=20
>=20

Hi,

I also just stumbled upon this patch series as I was wondering about the =
lack of specific support for RaptorLake in intel_idle. The AlderLake =
specific part of the intel_idle.c code mentions that "On AlderLake C1 =
has to be disabled if C1E is enabled, and vice versa =E2=80=A6. By =
default we enable C1E and disable C1 by marking it with...=E2=80=9D.   =
Without a patch on RaptorLake (which I assume works the same way) this =
cannot be controlled with the preferred_cstates kernel parameter. Also =
on my NUC 13 Pro i5-1340P the latency for C10 looks suspiciously large =
compared to the AlderLake cstates table.

grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/desc
/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
/sys/devices/system/cpu/cpu0/cpuidle/state1/desc:ACPI FFH MWAIT 0x0
/sys/devices/system/cpu/cpu0/cpuidle/state2/desc:ACPI FFH MWAIT 0x21
/sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI FFH MWAIT 0x60

grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/latency
/sys/devices/system/cpu/cpu0/cpuidle/state0/latency:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/latency:1
/sys/devices/system/cpu/cpu0/cpuidle/state2/latency:127
/sys/devices/system/cpu/cpu0/cpuidle/state3/latency:1048

Thanks,
Peter


