Return-Path: <linux-kernel+bounces-10395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB8381D3D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFBF283935
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B9D2F9;
	Sat, 23 Dec 2023 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eUxlpxCZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C11D260;
	Sat, 23 Dec 2023 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BNBmWw8070915;
	Sat, 23 Dec 2023 05:48:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703332112;
	bh=ixx5eKC7D350eGsWjnFnGkx+0CQd+9Mx6yAwL3APhkM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=eUxlpxCZasYOO9/dHe5eZHzfdRBoXPkmjVk3GXo+b7lqx7QYDsDgjiBw5ATfGo1xJ
	 0L9PK841lxYveLyQxDYP6/NGagAyjpw/9lodPELpfyTEJ2vkTb3VkNY+XoVm9a9WK9
	 gI/6OOiYEc7Zkhi8zo4Mqy+RPoDMOtsUD4eJQhrg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BNBmWgK109334
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 23 Dec 2023 05:48:32 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 23
 Dec 2023 05:48:31 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Sat, 23 Dec 2023 05:48:31 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz"
	<perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com"
	<liam.r.girdwood@intel.com>,
        "soyer@irl.hu" <soyer@irl.hu>, "tiwai@suse.de"
	<tiwai@suse.de>,
        "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund"
	<navada@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
 from yaml
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
 from yaml
Thread-Index: AQHaM/ZoVp/s6ZS3j0yS0WAx9ZwYwbC0R4MAgAJ4v4A=
Date: Sat, 23 Dec 2023 11:48:31 +0000
Message-ID: <b81d5b15036c4a1b8f338ab1b2b1f981@ti.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
 <ZYReyHQxMAe-DKq4@smile.fi.intel.com>
In-Reply-To: <ZYReyHQxMAe-DKq4@smile.fi.intel.com>
Accept-Language: en-US, zh-CN
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



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, December 21, 2023 11:51 PM
> To: Ding, Shenghao <shenghao-ding@ti.com>
> Cc: broonie@kernel.org; conor+dt@kernel.org;
> krzysztof.kozlowski@linaro.org; robh+dt@kernel.org; Lu, Kevin <kevin-
> lu@ti.com>; Xu, Baojun <baojun.xu@ti.com>; devicetree@vger.kernel.org;
> lgirdwood@gmail.com; perex@perex.cz; pierre-louis.bossart@linux.intel.com=
;
> 13916275206@139.com; linux-sound@vger.kernel.org; linux-
> kernel@vger.kernel.org; liam.r.girdwood@intel.com; soyer@irl.hu;
> tiwai@suse.de; Gupta, Peeyush <peeyush@ti.com>; Navada Kanyana,
> Mukund <navada@ti.com>
> Subject: [EXTERNAL] Re: [PATCH v2 1/5] ASoC: dt-bindings: remove tas2563
> from yaml
>=20
> On Thu, Dec 21, 2023 at 06:13:41PM +0800, Shenghao Ding wrote:
> > Remove tas2563 from tas2562, it will be supported in tas2781 to better
> > support dsp mode.
>=20
> DSP
>=20
> Shouldn't this patch go after the actual change happen?
> I don't know the answer myself, I would like to hear DT people on this.
>=20
tas2781 driver can be reused as tas2563 driver, except for the DSP firmware=
 file,=20
and both DSP firmware files complied with TI SmartAMP DSP spec 3.0.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20


