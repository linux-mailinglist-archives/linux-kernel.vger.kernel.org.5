Return-Path: <linux-kernel+bounces-12722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099C781F953
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E9C285C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC68DDC8;
	Thu, 28 Dec 2023 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UHomooy5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54BF4E3;
	Thu, 28 Dec 2023 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BSF0Upq096255;
	Thu, 28 Dec 2023 09:00:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703775630;
	bh=SWUI72zFfaZSzR3YlfrP+ppCc53V4yo2+PSn73pK1Bs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=UHomooy5FpZvIKHjNvZgRtCg5HG0J24dh5w9n2qGf3PgEnoK0rpSVUcEb3RlXLosi
	 QDyCdRHlkxjd1XWO3EUIuSysNWrkRtTizzwe8kdMxH4PktcyoGqmG8TNMT9+yE2RBn
	 MHEiFQlLDhamTDYXkDo2xx54yQ3QrKCcSJIYn6gw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BSF0Uww067178
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Dec 2023 09:00:30 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 09:00:30 -0600
Received: from DLEE108.ent.ti.com ([fe80::922:4dc:27cc:b334]) by
 DLEE108.ent.ti.com ([fe80::922:4dc:27cc:b334%17]) with mapi id
 15.01.2507.023; Thu, 28 Dec 2023 09:00:30 -0600
From: "Brnich, Brandon" <b-brnich@ti.com>
To: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro
 Carvalho Chehab" <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee
	<jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Dafna Hirschfeld
	<dafna.hirschfeld@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: "Menon, Nishanth" <nm@ti.com>, "Etheridge, Darren" <detheridge@ti.com>
Subject: RE: [PATCH v3 0/2] Update Wave521c Compatible for TI Devices
Thread-Topic: [PATCH v3 0/2] Update Wave521c Compatible for TI Devices
Thread-Index: AQHaLHTuykr9ezkXHUS14iKL4BJOWLC+4oXg
Date: Thu, 28 Dec 2023 15:00:30 +0000
Message-ID: <4dba82cd7e264356ad66cf230c61dd89@ti.com>
References: <20231211205920.698939-1-b-brnich@ti.com>
In-Reply-To: <20231211205920.698939-1-b-brnich@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

> -----Original Message-----
> Subject: [PATCH v3 0/2] Update Wave521c Compatible for TI Devices
>=20
> Hello All,
>=20
> There has been ongoing discussion[1] surrounding the issue of having K3
> prefix included in the compatible for dt bindings. This series removes th=
is
> prefix from both the device tree binding as well as the driver. Updating =
the
> binding will not break the ABI at this point as the driver is still only =
in linux-
> next.

I noticed this series has still not made it in linux-next. I assume this is=
 because
I improperly dropped the tags on the second patch [0] in the series between=
 v2
and v3. This series should only be applied before bindings make it into rel=
ease,
or the ABI breaks. Should I resend the series picking up proper tags this t=
ime?
Or is it too late for 6.8 at this point?

[0] https://patchwork.kernel.org/project/linux-media/patch/20231211205920.6=
98939-3-b-brnich@ti.com/

>=20
> Changes in v3:
> - Update example in dt bindings to match new compatible
>=20
> Changes in v2:
> - Include more context surrounding patch
> - Fix style issues addressed by Krzysztof
>=20
> [1] https://lore.kernel.org/all/20231201063309.tingjc3cjhsqb6r7@confusing=
/
>=20
>=20
> Brandon Brnich (2):
>   dt-bindings: media: Remove K3 Family Prefix from Compatible
>   media: chips-media: wave5: Remove K3 References
>=20
>  Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 4 ++--
>  drivers/media/platform/chips-media/wave5/wave5-vpu.c      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> --
> 2.34.1

Thanks,

Brandon Brnich


