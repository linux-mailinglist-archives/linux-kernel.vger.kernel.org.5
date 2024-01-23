Return-Path: <linux-kernel+bounces-35643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5098839494
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A5D1F26742
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB7D64A82;
	Tue, 23 Jan 2024 16:24:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1063762A0A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027041; cv=none; b=J9u/MknNDVZn6D2/8XGEyOKG3yYSxclvYitgeZw+3ABtpwoFpTOLUAjI0IkotcvmBhF25HIIaWMMjFOZNJh43zaZb4ZfllLERYI1Nrk0UXgfWll5TJovo5rfRCkzOAz0BJuTKTfyNz3+fzXRG83fTSFqETzw5Q/PcIlykadaVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027041; c=relaxed/simple;
	bh=B/+qV11QSrMu+hiOf6dsxPzCSJR74DeS4TsuLSCz/AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdCDlE0xklvUGlVYpzF3WL5keSU52HY4l1Eiy/jKE8yKrr3RCKtrKSPdPaIbSVScT9yQF7GdTUKH5JRmdiAk+9R9v1GlhkORueTJG6fOZ+Jaji0tSPpYrDd4BY6UXYepUUsJm7MEDXBLdCAgWgqoAW9sa7AUPMIsMvsHZcBgx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,214,1701097200"; 
   d="asc'?scan'208";a="191449826"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Jan 2024 01:23:57 +0900
Received: from [10.226.92.178] (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 988F64003EBB;
	Wed, 24 Jan 2024 01:23:52 +0900 (JST)
Message-ID: <75f0bfc7-fb95-409a-a5d9-b00732e892f0@bp.renesas.com>
Date: Tue, 23 Jan 2024 16:23:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Resend PATCH] topology: Set capacity_freq_ref in all cases
Content-Language: en-GB
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, sudeep.holla@arm.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc: lukasz.luba@arm.com, ionela.voinescu@arm.com
References: <20240117190545.596057-1-vincent.guittot@linaro.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240117190545.596057-1-vincent.guittot@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------B5ReO8lV4wENvIWB0bKVqZad"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------B5ReO8lV4wENvIWB0bKVqZad
Content-Type: multipart/mixed; boundary="------------z25ZUkkX88nYTC0Hf3QNheKh";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, sudeep.holla@arm.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, linux-kernel@vger.kernel.org
Cc: lukasz.luba@arm.com, ionela.voinescu@arm.com
Message-ID: <75f0bfc7-fb95-409a-a5d9-b00732e892f0@bp.renesas.com>
Subject: Re: [Resend PATCH] topology: Set capacity_freq_ref in all cases
References: <20240117190545.596057-1-vincent.guittot@linaro.org>
In-Reply-To: <20240117190545.596057-1-vincent.guittot@linaro.org>

--------------z25ZUkkX88nYTC0Hf3QNheKh
Content-Type: multipart/mixed; boundary="------------EYn76Hs2EPerobwQepFAbRoR"

--------------EYn76Hs2EPerobwQepFAbRoR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 17/01/2024 19:05, Vincent Guittot wrote:
> If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip th=
e
> normalization step which includes setting per_cpu capacity_freq_ref.
> Always register the notifier but skip the capacity normalization if
> raw_capacity is null.
>=20
> Fixes: 9942cb22ea45 ("sched/topology: Add a new arch_scale_freq_ref() m=
ethod")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

We've had some Ethernet performance issues with linux-next and v6.8-rc1
on the Renesas RZ/G2L and RZ/G2UL arm64 SoCs. I've confirmed that the
CPU frequency is stuck at the minimum (150MHz) in v6.8-rc1, even when
running iperf3. Applying this patch allows the SoC to switch up the the
maximum frequency (1200MHz) when needed and fixes our Ethernet
performance.

iperf3 results in Mbps for RZ/G2L SMARC evaluation board:
                TCP TX    TCP RX    UDP TX    UDP RX
v6.8-rc1        255       175       102       (*)
+this patch     874       650       802       948

(*) Testing UDP RX in v6.8-rc1 with a server sending traffic at 1Gbps
locks up our NFS rootfs mount so we don't get any result at all.

Results with v6.8-rc1 + this patch are in line with what we see in v6.7.

Tested-by: Paul Barker <paul.barker.ct@bp.renesas.com>
--------------EYn76Hs2EPerobwQepFAbRoR
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------EYn76Hs2EPerobwQepFAbRoR--

--------------z25ZUkkX88nYTC0Hf3QNheKh--

--------------B5ReO8lV4wENvIWB0bKVqZad
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZa/oFwUDAAAAAAAKCRDbaV4Vf/JGvWjv
AQC0oj2QJv7YsV8+8MA+RxGu+DNQ4yPpJSFlZ9YTfSwYywEA9kwKv5q7wCjkbDH09pRY3gq413fW
ar8MOfJMJxmhhwg=
=qqSC
-----END PGP SIGNATURE-----

--------------B5ReO8lV4wENvIWB0bKVqZad--

