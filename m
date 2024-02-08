Return-Path: <linux-kernel+bounces-58882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1579484EE0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B16288EF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1B51005;
	Thu,  8 Feb 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PkhLmw2I";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZS8bMPML";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="o38VUJGe"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E3F50254;
	Thu,  8 Feb 2024 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436229; cv=fail; b=CvVSE1bEOWr4TM0KjrUMoQFKnfuofz1taf0SJ9z2Eo1UX4N54kjBuusnpBRf4QMsiaUfwKiNAoz3eBcRtdiDb1+Qj6F5xDOof8A4sIIMUcWeTsNQdCINfeMZa9foockPsx0lIc4niprAWGTnAD0TmdPEmTKFn3zTiaUsTzluIHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436229; c=relaxed/simple;
	bh=vY9qPf1zuV+XlzYaVfBeaf6jUL/wCqr1oDqNvT97aVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=priEAvvbhhKShAvpxtVcSqlVYhWdqpM7eQqs576Ey5L4TSjI2rQ8TOhiZlnCqb/yr+7xLT/XCGm47j5wyRBsVzjLXaOURId++yORT/7pAE1dH2EgKCyFHLsH0pJRA2UwlUcQJ+bpAXjbihIzg1mo8xFkv5yPkTxUt105w5GTdY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PkhLmw2I; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZS8bMPML; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=o38VUJGe reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418M6Lnt032433;
	Thu, 8 Feb 2024 14:28:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=vY9qPf1zuV+XlzYaVfBeaf6jUL/wCqr1oDqNvT97aVA=; b=
	PkhLmw2IINLi+SYTY4yW/BSBGR776Qm6j99xQW70uP6uojv1dzOIJQNW7wCJqBtz
	e1Nw9t3r6ATBeAvIo9OhfsCZXapDsRY2slATJ25BswzEFGm5BSUeYHxhKyUYWzdZ
	VkGxyRhXSvwd5m1XRr1lPuqN2IpwXDcPoffjUAD7ajk2DRjDkP2sk4Gl5pY1vVb6
	u7RB0MmeW6OQjcwmhBCrnOzF7wdzMUknsXFo/FAKtW2rtk6qdcGbfO8W4JoS1y2N
	DBvnzeA5fJBhmXBPXjBz8427YlqjHpPa9L9aJOMPhqw8xjbFBw7pzDTK/GXM1QCF
	tbbqSBBy/XLA+D9Ge1ntfg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w1ncprxxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 14:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1707431309; bh=vY9qPf1zuV+XlzYaVfBeaf6jUL/wCqr1oDqNvT97aVA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ZS8bMPML3wTwUctEKq/T4v1RdHZ8OLcTFam3KQY2x5t0KHkP6YUN/BNt/iKH+SVvV
	 Hdi4WT7tMj56Y4j+HmxAZXxDlHGWbtc78/+O1OTPClo7HITgIVvKA43psEKhLgUBUA
	 uVkBvvnVgVj25f27tLZJsU441uOjczjMXAPIo3tm53m93N58+lzS5nii+PtX2MP0/C
	 WGDRoz0QP9Wm5hRHi7dGP/OAdpTfGElQTjykCHTQllArEwqJplbh0192WCVznkIlwb
	 ms2wRyrJaWRZhAMJWccc/Z99c6TJ3WqbNOAx/mOilkHY8YrGYMc6bMQ2CTMcETayVk
	 tAxkLIo3+JA7A==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7623640524;
	Thu,  8 Feb 2024 22:28:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 0B1DEA0063;
	Thu,  8 Feb 2024 22:28:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=o38VUJGe;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5A30B404D4;
	Thu,  8 Feb 2024 22:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPnc5dUZyneqZ8E738OklMA2+3VANVfBkxF8yZDCdRQ3sHTxxfExpWLkny8mKeSJm871GlF+vEDFSGJ/hkeb3IAQFshqeFpw1lPCq3g7GgT8tmNguiFXoTCdLdpeX5KTupf0cZrLiz5lYLfg2eiLW2vPY3lsqiYK/VTpgluKyps1r/KyWK5KjU0EJBIMUwN6CiU07m9qTzTTRvKodqXO8FVqKzyXQti0tViwuxbtqXFiqsL7E2GsHAZ8jb7EmTyeWpU3H8wTIL/JUyKaXsBVSAtfRegStSWpUHEYhM915vTRWq8eM/vleasi8Wjkkzn0svH6NO6lk5vcjfL2rNM75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY9qPf1zuV+XlzYaVfBeaf6jUL/wCqr1oDqNvT97aVA=;
 b=PvjBWCKDsgFIDsktAsUht9afLSWAoMYivTXzxWQ59VcwMjCqOuNhaDPxb1+n2T3riXMEuOMsWHOISWaVcKb+2RsyWWRIhKQ1ks81Z3jof/2VN49x8O6TXmV5HNuDYwfgwvXqcSS9198LoxplIaAYRLw4Pt7EQi4Hmxb7jrszYXfJH0te7fdjlWVBF6POJOseEDO8EKF1fevwLw1WnrFqqjRnJ4nsZ0cLV8YF4G6pCscrQCfY+EYaKYTsrIhJxDPyYiic3VKKFhI6jKtv9jgbq+S4yAMza6sGhln+cOBoUOM84g4DdFCaRk0wrHygepVjdMP7MkuB3WwKwpFO/duqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY9qPf1zuV+XlzYaVfBeaf6jUL/wCqr1oDqNvT97aVA=;
 b=o38VUJGekvI+58+kezuCPcl5noFtQ2clabs6S1dJk/XnleuezbT4WcNxnfYbTTbBjJjRkR4dG5ZDKV6i2WWxWY358hNqXrFql1o4ovH8FmYhX2WRfN2ZDR+6etRAlkrihSWHo8bTfJag3LIHrQ/Xy7SZtC2IlaMZzHtAC0m3Dc8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Thu, 8 Feb
 2024 22:28:24 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7270.009; Thu, 8 Feb 2024
 22:28:23 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Conor Dooley <conor@kernel.org>
CC: Frank Li <Frank.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 0/2] usb: dwc3: drop 'quirk' suffix at
 snps,host-vbus-glitches-quirk
Thread-Topic: [PATCH 0/2] usb: dwc3: drop 'quirk' suffix at
 snps,host-vbus-glitches-quirk
Thread-Index: AQHaWhEfRhf51KoSiUePcxfNoeJAb7D/b1yAgAACaYCAAYDGAIAAFWkA
Date: Thu, 8 Feb 2024 22:28:22 +0000
Message-ID: <20240208222748.cc2eodhtqpt2jmpf@synopsys.com>
References: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
 <20240207-settling-drone-90e6f10a3476@spud>
 <ZcQAqVViPHcbgn52@lizhi-Precision-Tower-5810>
 <20240208-unquote-palace-83edc6220acd@spud>
In-Reply-To: <20240208-unquote-palace-83edc6220acd@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB7173:EE_
x-ms-office365-filtering-correlation-id: 451c72a8-b9e4-48e3-7354-08dc28f542a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +OlYTelt3N68jBGArX/zIMkkH5P3uojU199gkAvp0dSRp2IjPS4EE1gK68/UabKuwk2znyH6xXYNmCIs2RhDV6vu7s95jd2bOLsqlhmpbqevGXp+inv/yT3PbzMwOyYdBg2gXN84kjdQdLIJfBh3MCK331tMk9YrUeKH7+LMyQQwD3xbXUABzRXYx5ocMakvizreTZ5sGyVOovf6ZGj/GPHj8xwTNtqt8UAxHeNI6/AwB2DdwboHC6pPYBObB6P4jkoMCRtKc7WZtzOHIgzFevUJn6XnWWaIV7HphHyAiIIFbXow7Z41fa1/qxs131eWUCnC5QUNnexuefVA4Ans3dNDBWtVSThkLVPmWOUaWEuboLgEJHO4LyoFgq9b/07HrdsNBR6ksgEuOXznP43Ct1nduYjJbGI72yhIxUWKDgrXkUqM2S6vxFpjMX60G7QYmmS5fsbZdW8fjCOpuINyRnT0uExgZE+ElhcwU6eSC7hnzuVzfI4RW1+CrMQKWwqQbzJdmySrB5MdcT9zq+dK3fGO8+mHZr6YoNv6Azj//j27ZVtaEAkE7kUxtuI0WcY9v9RVKty1codelp3CMBFtlM1igf7pc5qA1ysan+RcZbM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(86362001)(38100700002)(54906003)(6486002)(6916009)(478600001)(316002)(66556008)(66946007)(2616005)(26005)(66446008)(64756008)(66476007)(1076003)(966005)(122000001)(71200400001)(6506007)(76116006)(6512007)(38070700009)(36756003)(7416002)(8936002)(5660300002)(41300700001)(8676002)(4326008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SEpZSTlRcnQ4eTNYMGhJUFhZR1RpQTB2SEtzWkV4b1oxYmZTd1NuV0dwWEQy?=
 =?utf-8?B?MnA4S0FjL2MvRjRnMWlJNzBhSk96MVlMNVBRNmdSVFBKM1QvaHduWFk4azFr?=
 =?utf-8?B?dCs3cWtQQnBGWkxSck5Wb09VMmF6dHJRWmhVeW9ZbEZybmsvR1ZFUTFHblRm?=
 =?utf-8?B?b3dTcDlUL29yWDh4SFdOTEtiMTVadStnVlAzUS9jVHR5dGIwams5Ymh4eUtP?=
 =?utf-8?B?dEFSdUNaTnYzbzkwdW0xSXluaEI0YkkvckJxSlVTNFJpcEZ1dTdpcEVBOEhO?=
 =?utf-8?B?Y2wxcTM3cjdCa3FJWlJPMnhGd2oyQ1UrbHpvdDREdllvSmRUeG43bk00QXc0?=
 =?utf-8?B?Ti9MZDVqeVVDWjZkTk9jOFA5NDhoTXdjVUpJNFJDYW1PeGxNRzNvblQyQURK?=
 =?utf-8?B?aE9VZlVDTnZlM0VKOHhRWGFxazU0WjdzaGdIRUc3dU9rOXJpMkFUS1lLSUkz?=
 =?utf-8?B?d1liNlBaUGEzZlhpU2lhdVNLR3p6QXFxNGJ0Tlo1UVR0MWxadEtqUTltUk5X?=
 =?utf-8?B?MEFEV3lDMkd5Rk5tT1Z2bTJBa0hyQlluTXZYUFN1amtoOVNpMllEcjZ2RlNR?=
 =?utf-8?B?NklCZVdHNHh6RTJuaVgvQ0JYTStxeHRVTm82ZmYzaXl0Yms1ajVuQlRheEVD?=
 =?utf-8?B?cTlVSHZTS2h4ditmTFNDVExFY080S3I2ZzdnVjlML21DbkZIUVIwUjFidCtM?=
 =?utf-8?B?eVk0Z1lGWGE2dzNzSjR2N3ExVm1MdExCM1l1dk42eWZDYzdXY1hncVFiY3BZ?=
 =?utf-8?B?cklFQzRxbzZ4aEc0OGtlNmIvajFTdUZBZmVobC9ZcXZjSWFEK1kxOXRTOGVk?=
 =?utf-8?B?TmxLcUt4Y1ZjMlNGK01qbzNBc3BOZnRpRFBhSDZnZ2FycFFhQ0h3WDFFM3I0?=
 =?utf-8?B?TEZrR1dRSXNGWlMrcEJVRFBhNlhZZ2NScDRXb1FmYnVsWWY4dHRYNCt0UWU2?=
 =?utf-8?B?dTg2Mkc1RENSYnVVWEZST1RIaEdoL1FiZVppR0lPNHZuY1Ntaksvb2R2N2Zy?=
 =?utf-8?B?M2ptRktrcHVaV29iVTFadDlwWnBTbXQ4b3BLd0tNRi9mb3hlcVBEbUlSMGdq?=
 =?utf-8?B?emJNNGFzQzBXdHZvZVEyM1lyWEZjR3JFaHFMdmxvd3M2YWQ4RlpLNFVZcVZD?=
 =?utf-8?B?OUdqaUFQbmFwbWVDeGxibnBzTzl2c0xNdk5sM3FQQUsxVDczYW02Yk5EZ29v?=
 =?utf-8?B?SlNnZldVbXRtdjZXV0cxaUlTMm1MenBBcDZiOUZLanlvVFpjVCsxNTIyWkcx?=
 =?utf-8?B?dWRNRVVvMk5UZ1ZuTTBOYkhQVGtLdXdIWEI0UEdkbXJoTXp2alRidmZnUnpx?=
 =?utf-8?B?OHdhQTlib1FLL21OUnpTNFcxSit1YmllSzNBK2JZdFNtWVZJQTRRTSszbzBX?=
 =?utf-8?B?cUVQM2ljdGtMV2JFbnF4M21QSG5PdDJYTjRHSFBWUERMVlZmWmdDSmRPTE1Q?=
 =?utf-8?B?V0NhL3JGWGhYTW5keGlUZWZZM1loQkN0OUVEcWJhZ254ZWdndGZtcUd6Mmhi?=
 =?utf-8?B?Y0t5cXVuUGZMTXFlWkloWk5FVHB2TE9LQ3ZlaUJhNWJnQWZoYTVsSUlwTTBz?=
 =?utf-8?B?OXdmUTRSNUZzRy82Q3BocnBNaXlYY2x1WHFuc2hxYThJek95anM3NzdPd0Zm?=
 =?utf-8?B?a2lxeGJuZkw0YkdIakJtSVdnNXdXN1hkVHI5V1ZkZm02NlB4dGZBNms3aW1a?=
 =?utf-8?B?SVpnUnBvYWhRdUxjWGJOdlhCZ0FCUm9xWFdHN3F2cGlQMm9BaU1sNU1aaEVT?=
 =?utf-8?B?ajMzTVVVdGEySVE5WkRHakFNVERMdXB0WUprMkVtRzRXNnhMUDYwK1U5TlJj?=
 =?utf-8?B?Z3kwL0pTUmxwc29ZcENLNW91NGEybzRhaGxBL1duQ1NWMDJJcVBnYVpCWFJ3?=
 =?utf-8?B?Y1QxWDhkWEFVdHkzTjduak9CaExuWmpDVlJqaFZtOXNpTmU4VU1Cb1ZnS0Fo?=
 =?utf-8?B?ejFLb3lpVENuY0VwWXE4RXpvTlZGQTRhTmpHeDFpY1haTDh2NGQ5aW1EYWdx?=
 =?utf-8?B?OWJSZVRENngzb2ROZm55dWVyd1Y3YnBZM0VqemlMNTBGZkozc28waWpkNlFH?=
 =?utf-8?B?LzB1T0hlOXo3MzYxN1lQd0VlWGdYdmFvSHYyTG1VNzlBWTY3SUlSaHlXL1Nz?=
 =?utf-8?Q?3LNbpslvhQi9+jVByPOIW4O3c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D2AB7487AE9EE4F96450368198C065D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Qt1T5N8E+dcPMXQFt01/w8bigZG3Bva6OGWr5IAQkKuMBgIYepH5fbbcgIKCA66kgSkOz1zFn7QcNej8LaAgxVMbXGtHmnYn09xugJUnOTe45IVZR4tUqyNyQJdqfTmWNkI+iGI51wrFQYhSTMAUe2xzNHRmIqJYkxuAUHRNDFhiqHgSEbIVa1Q1X5TyxIfwXRf2XAy3ZcIDIIq9tW6fg4v0jOJ0K2psEER9bhP7q+r5Yx5IaHGZZK5Regf+/MwEvcTbyNmYXTAjhUsxVcmWKQ/vI+CIPR6AdEnzM677GE7wKoRHK+2i3vmWSSLTdUhh3f1lKyxtDSCpOGHgvXMaLQR0RMnMvCNCIWVJBPiaMVbGHGXFhBLLO/+hXU0S+0A3XiIZlDKqI1oIqifXnYboSEVXQAxiKZDU+MUHKX1JrJDfuElloyclDtkCnTmhr7lCWOQH9YkieIUUruaji8GQcW9ObpgPYqJ3/adNbhmVZaS9NPg2c1xYGjeMhONa3xuuIC8GlRWJXVxsqPqi2qGn0+yG7vdpEcSjlhl9+f4orHkAq65whYggEFusQ+eboijCZdDNLUchG3F9wAlX6i6FtNdB+m/pwpBN/7F2ofsyq1jKeQl5ItP3KwHGplhkPaX2eVcJEzQIzNaO02ngOEhtAg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451c72a8-b9e4-48e3-7354-08dc28f542a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 22:28:22.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoDRfLflLZsCfhsrLOZOnbdXwhlaMm3s9Atd16OwLt3OTB8YQt36p10HackjTd7J5HYAf6ROTmu0yL5f8335DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
X-Proofpoint-GUID: b7UR8flQUOVjMUm_x_M7mxeqZetrDcM2
X-Proofpoint-ORIG-GUID: b7UR8flQUOVjMUm_x_M7mxeqZetrDcM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 mlxlogscore=579
 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080125

T24gVGh1LCBGZWIgMDgsIDIwMjQsIENvbm9yIERvb2xleSB3cm90ZToNCj4gT24gV2VkLCBGZWIg
MDcsIDIwMjQgYXQgMDU6MTQ6MDFQTSAtMDUwMCwgRnJhbmsgTGkgd3JvdGU6DQo+ID4gT24gV2Vk
LCBGZWIgMDcsIDIwMjQgYXQgMTA6MDU6MjNQTSArMDAwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0K
PiA+ID4gT24gV2VkLCBGZWIgMDcsIDIwMjQgYXQgMDU6MDA6MTdQTSAtMDUwMCwgRnJhbmsgTGkg
d3JvdGU6DQo+ID4gPiA+IFNpbmNlIGR0IG1haW50YWluZXIgZ2l2ZSBjb21tZW50cyBhdCBvbGQg
dGhyZWFkDQo+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDI0MDEx
OTIxMzEzMC4zMTQ3NTE3LTEtRnJhbmsuTGlAbnhwLmNvbS8NCj4gPiA+ID4gDQo+ID4gPiA+IFRo
ZSBwYXRjaCB2NCBhbHJlYWR5IG1lcmdlZC4NCj4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtdXNiLzIwMjQwMTI0MTUyNTI1LjM5MTAzMTEtMS1GcmFuay5MaUBueHAuY29tLw0K
PiA+ID4gPiANCj4gPiA+ID4gU28gc3VibWl0IG5ldyBwYXRjaCB0byByZW5hbWUgc25wcyxob3N0
LXZidXMtZ2xpdGNoZXMtcXVpcmsgdG8NCj4gPiA+ID4gc25wcyxob3N0LXZidXMtZ2xpdGNoZXMg
dG8gYWxpZ24gZHQgbWFpbnRhaW5lcidzIGNvbW1lbnRzLg0KPiA+ID4gDQo+ID4gPiBJIHRob3Vn
aHQgdGhlIGxhc3QgY29tbWVudCBsZWZ0IG9uIHRoZSB2MSB3YXMgVGhpbmggYWdyZWVpbmcgdGhh
dCBhDQo+ID4gPiBEVCBwcm9wZXJ0eSB3YXMgbm90IG5lZWRlZCBoZXJlIGFuZCB3ZSBzaG91bGQg
YmUgYWJsZSB0byBhcHBseSB0aGlzDQo+ID4gPiBjb25kaXRpb25hbGx5Pw0KPiA+IA0KPiA+IEkg
ZG9uJ3QgdGhpbmsgc28uIFRoaXMgaXMgd29ya2Fyb3VuZC4gV2UgY2FuIHVzZSB0aGlzIHRyYWNr
IHdoaWNoIGNoaXANCj4gPiBhY3R1YWxseSBuZWVkIHRoaXMuIElmIHNvbWUgeWVhciBsYXRlciwg
c3VjaCBjaGlwcyBhbHJlYWR5IGVuZCBvZiBsaWZlLg0KPiA+IFdlIGhhdmUgY2hhbmNlIHRvIGNs
ZWFyIHVwIHRoZXNlIGNvZGUuIE90aGVyd2lzZSwgaXQgd2lsbCBrZWVwIHRoZXJlIGZvcg0KPiA+
IGV2ZXIuDQo+IA0KPiA+IEFuZCBJIGFtIG5vdCBzdXJlIHRoYXQgdGhlIHNpZGUgZWZmZWN0IGZv
ciBvdGhlciBjaGlwcy4gV29ya2Fyb3VuZCBzaG91bGQNCj4gPiBiZSBhcHBsaWVkIGFzIGxlc3Mg
YXMgcG9zc2libGUuDQo+IA0KPiBJJ2QgcmF0aGVyIGRvIGl0IHVuY29uZGl0aW9uYWxseSBpZiB3
ZSBjYW4sIGJ1dCBpZiB5b3UgYW5kIFRoaW5oIHRoaW5rDQo+IHRoYXQgd2UgY2Fubm90IGRvIGl0
IHVuY29uZGl0aW9uYWxseSB0aGVuIHN1cmUsIGtlZXAgdGhlIHByb3BlcnR5Lg0KPiANCg0KUGVy
aGFwcyBJIHdhc24ndCBjbGVhci4gSSBtZWFudCBJIGFncmVlIHRoYXQgd2UgZG9uJ3QgbmVlZCBh
IG5ldyBxdWlyaw0KcHJvcGVydHkuIElmIGFueXRoaW5nLCBpdCBzaG91bGQgYmUgc2FmZXIgdG8g
a2VlcCB2YnVzIGRpc2FibGVkIGJlZm9yZQ0KaGFuZGluZyBvdmVyIHRvIHhoY2kgZHJpdmVyLiBX
ZSBzaG91bGQgYmUgYWJsZSB0byBkbyB0aGlzDQp1bmNvbmRpdGlvbmFsbHkuDQoNCkJSLA0KVGhp
bmg=

