Return-Path: <linux-kernel+bounces-56358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F6F84C931
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09ECC287F02
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E01804F;
	Wed,  7 Feb 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kaCrr1CL"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD417BAE;
	Wed,  7 Feb 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304046; cv=fail; b=abr6Ga97Y1XZmcFuAwq5JOG09JFHCtl1M2KLDuVgxxRH19eyjSnXu/DdlQze/6TyFm86He9eB0DyS0Q1ctafbykbTvSAfPn7GUwNWc4kFBHiMsJJ67YcbGanx0xkSxJ7Jm90VixUcdWJQyiDB5/BZnyZQj9QcuwrXkuGhE7aFmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304046; c=relaxed/simple;
	bh=8QwE1KQHL/qKe4Bde/k7CjWmBsGoeIQup219KwcPguU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=btep5eey3Uw7iPopJQ6s+T4Xe62+qgfoaAA6MgCzak+nbPP2W7mITxAfvas7DYgHs46NWrx95WFd4510MDHhj3YE46e8YnRScMI75re+iHCVdoMe5WrPRKYRVazkXnjCtdNE4plVDZYzJkhmxT/pNnjQo2XfIlirb5ZLjOeh/sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kaCrr1CL; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4178kPMJ018090;
	Wed, 7 Feb 2024 04:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=8QwE1KQHL/qKe4Bde/k7CjWmBsGoeIQup219KwcPguU=; b=kaCrr1CLxBFo
	g6P91gxQp7yBVHtTny+HhdNSbpw1oECf6b7QGXY3zFSljF4VV6/ngZ2Zf9Jyn6IZ
	sJRxU3p754XpaksGsCCpWG67cY7QwTZuJ0SLP1GNdsrcDLY9vWiDMsAGf94UKHBa
	0P1OzrOogtHyyv6J88LCjPixkabiglUqWGfMFYsB7Lg9J2w2JLz5mLE1XXM+n2jK
	4IYZdVPaXFuwPlZVjlvx0eSML6IPgOeDqimE8w+HmfKx+dBLCv9VRDxsa1eIOMqP
	lLZEVMG5EXCr3EGrY3oS3/HMZoMIr/LnKuqthc1p2qiWhdjoZz3p6jSCNKreSB8b
	sA8sR580eg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3w3pkeun2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 04:54:48 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6y05PbOyYHgCq0WIydFfmcnxbIUgqerkYDIHIjhtZplExS9T89GQkEChN3+K5RQrcSVPo9oEiObu/iGeq5YCi+DorZ9XaA25l+mM1e+MqslLxpZFHHJcUzEeQkfJ+343NtG3QDik1psJ4v0vV+rdma7HUYLD3u9WVB0gZ/zcOBL6tYz9B0ILT/DsvDseas5bvSJlOuBtSdfbWEBe/Jvp9b6WTejx414b9/kEHRooFxepeCc6DugBzKei65pjRNeBFdvJb9m4yUNyQ15jc8YzfFoD6r8y5+wu6vDQcMjasEbC1S6pa0HesEy/Ws5aYhRnC51gt82Dnf5evclX60peA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QwE1KQHL/qKe4Bde/k7CjWmBsGoeIQup219KwcPguU=;
 b=Y12MtSKH3LK/JTpdS4qNbsbtoDQnGu7L4vynMRk9Bgr588xwyJVKigv4Xo4su9tqMcTru0zcjNNeir/gEezofdjpXl12dekzq47nu7rEMUOtIMtUDC+qQALUSVr0+OzTUayJHrfeMQjlnveIsH0X3O85Vy9zKMzqCDP+nulhm5P8L60D0UJVcwZaEMSA6NvzfZp26qVTrjYQN+aTL0XWodGqfxfxhmrlnS2tFP+Nnj8IXmUxjdkYNFmI3fzmxlJ+5LbN2Qrc4n/FkhTDE8KhKn482xdWsJcrMkf2PdIi0mBf2HBfKHJQTavf2/vAoC0dhOTAy3BaKG/cOJhzZNhulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by MN2PR03MB4975.namprd03.prod.outlook.com (2603:10b6:208:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 09:54:46 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::290e:c9df:b53f:a531]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::290e:c9df:b53f:a531%6]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 09:54:45 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chris Packham
	<Chris.Packham@alliedtelesis.co.nz>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "noname.nuno@gmail.com"
	<noname.nuno@gmail.com>,
        "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Topic: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Index: 
 AQHaVYLwKZaLnt2to0CJhEutu94e97D2uKUAgAcP3QCAAA7jgIAAB/oAgAAJ8ACAAMAXAA==
Date: Wed, 7 Feb 2024 09:54:45 +0000
Message-ID: 
 <CY4PR03MB3399844E78F84B6CFA18280A9B452@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
 <20240202025241.834283-3-chris.packham@alliedtelesis.co.nz>
 <aecd80a3-a017-405f-b77d-6deda67ef704@linaro.org>
 <5d4b7fa1-5cc2-4a4a-8fa4-d2c7a8d070b7@alliedtelesis.co.nz>
 <20240206211237d9192660@mail.local>
 <e7a21789-9253-4185-98ed-e335d0167df4@alliedtelesis.co.nz>
 <20240206221644f524816e@mail.local>
In-Reply-To: <20240206221644f524816e@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1lYTY0ZTU2Yi1jNTllLTExZWUtYWViNi00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcZWE2NGU1NmMtYzU5ZS0xMWVlLWFlYjYtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIyMDc3IiB0PSIxMzM1MTc3MzI4MzYz?=
 =?us-ascii?Q?MTY4NzQiIGg9Imx6T3VBWCtndmI1Z0Z3QS9hckFCKzRlRVNtaz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?REtsdXlzcTFuYUFlcUhnTDBvaDF2WjZvZUF2U2lIVzlrREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRU9wbE9nQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|MN2PR03MB4975:EE_
x-ms-office365-filtering-correlation-id: b47a49bd-36d9-49fd-314e-08dc27c2d0bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 trIQcf9Xi2/f4qrgOhMm35oe2ol7V9iKioR5LBhE7ilAUvWTC0vnKjbLazLOXQVaffAKVZPw2K3eMf/LGrhbx0lYJSJ41+srqbiRmcRxlYyzO0IunmzmvwaeQuSBl24G6M0ZaUcwviSxk3ZvJImLVHVR5/9IJZW4UTYV9SUycF6mXCSScEAv7ISX2UcIRkojtR5DtsQR+IS40EysQGiss9xDYstGJZfebHfoW4uCVO8pwuCBntmjedOxS/NiZBg5R1TQxmm4gye0/BhEKP0JUsf7XMFhIbmwzWxOd2do4MaSSC+ks+VDF3H1L6XkKocjfLhCzI/HJ4ku/V5TsmvGMri7ILQ+HmNtqZqCAA+ssXaBeS27ZA0SpTjysLGQROdcRywaZFDjeo3gFT77twePuw+R0MOQkv9EbJX5IFASOpIAEuKuHg4VZPIH024cpPMlf7lprdL2Oq/5fYMIHCOhgB0ta7eYJmya5/oeEZwKoo/jh/QxLT6Inor1DspWdpJWppD6nb27TU9QpxcRGSEuEp/nL66UJlvAouPh0A8krhMVDg30u2KHdU+fn74/uaHDDqEXvx34CTlxVb8sgDt0VjlPYQf6x0hX5jyO28QJhxk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(84040400005)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38070700009)(41300700001)(55016003)(52536014)(316002)(66946007)(76116006)(110136005)(66476007)(66446008)(64756008)(54906003)(66556008)(5660300002)(966005)(8936002)(8676002)(4326008)(478600001)(33656002)(86362001)(38100700002)(83380400001)(7416002)(2906002)(7696005)(6506007)(53546011)(71200400001)(107886003)(122000001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?5Oh4FUfku7gnkUvK05tkREM2M1yCptbra7k3XKXb9fG7xT7uX5djmMPFhEwy?=
 =?us-ascii?Q?lLwbjGGe8jKTQUjRobsFuw4zt3qDjhjEy9WNhivai0kYi0fTRpuPld3w+/Fm?=
 =?us-ascii?Q?4RtzTTZrXVxSCFVcC/yLbp45K3Nri6utT3Y0rDN3Otfg1OaDkJ4K1bk7zxh+?=
 =?us-ascii?Q?dEvvex/omuR3RVuZSvuEh4Ylk2PYOL3i4zmQ2YmKWiMfq2XsdvaqB0gA1+JW?=
 =?us-ascii?Q?XvUgwT+ULEsB5NZ4zjaf4nOnTCe8tgquLTR7i7V2tH7II59hjetjbJYpHrOy?=
 =?us-ascii?Q?TpRRNZ63fo+3edczjZVnQYupJ+hTxyvwhM1YsRpk1TcR5HjWzfv7BJHOUdMd?=
 =?us-ascii?Q?MLPrItdyNHBEcrxmZI1lDMT8jiyel/UdH+sam4TwpZWsL9GQ10fwyZhMG1Qz?=
 =?us-ascii?Q?qTv9jqoqlZQbthbaoK2u5a0KZv0BMbnCuiZcyo9seNnrD5kEmbMkxZi3aRv9?=
 =?us-ascii?Q?A+j2ARds/E6I/bVS95+0NPF4dC8G4ifJ3iLayhPwzLTfjg/62u9LplHf1XPn?=
 =?us-ascii?Q?2kkAxeORkjHhGO6v1/DaHVLnQBLAd2iidBlb52ubnSd0vjLzVAyv8P3WDSKP?=
 =?us-ascii?Q?MDXfZi+c9UFAtUT/v1RBT5ZprjJAyPj952b67LHdz02R3HD91VTSaCNuIiyJ?=
 =?us-ascii?Q?Hb7f/lHE9d6S4Lj+5KbJExmzLDlpDga1Tnzh8eEFME/3sNCiiYN6SP1C6iRU?=
 =?us-ascii?Q?UelLRrw2D33mv1G0otBQ6WMRv6ZON5W3nl59EGKyhJLLjUAPn+Lh7y2GXGC9?=
 =?us-ascii?Q?1RJp+tE+oXw8ZtygBKYIYB4hu/eMS194ZZb5FYIr/a9GAyvkfgj5I4Furv4N?=
 =?us-ascii?Q?JO96WHc95bvEtkp1Jn3MvIK2Q4eIA/BUCmgCAWV3mtZKhLEixhUyK7VK9BLl?=
 =?us-ascii?Q?vPKLeeEKJeElwQtosapXDPlbD355CRdyRmHTTaDxBXO2Mz8fn+ZFchZU+psF?=
 =?us-ascii?Q?gn0elPgeK+EkF4Pz202p02T9y9QpV5mLLBE1GRJ5nBJuEEP3HwuZwmALmGEV?=
 =?us-ascii?Q?UrwgwnX6wVzNYyOIavW7kOr3wSHb+yXwkA3Cjj1Re2KU4QfolKuBIilC/4+A?=
 =?us-ascii?Q?/JIkfFV+NiJhxq6gYc9usqKswr/jJze+rg1FMlHIywD6h2/mAK7fEVYoikz/?=
 =?us-ascii?Q?5SLuq27Arzn5Et6/a6Hm36+nmORlfOWXMAy8SteFx9lbW7rY7KjIRbJoLVia?=
 =?us-ascii?Q?VVAVN/JrDboYS9nVlY36mKzyaVNOa0n4Z95tmMi0YpC2BFjrAsr2jvkhRHzR?=
 =?us-ascii?Q?c49Cbhpm54TdC2EgEG1rJyCI4hEC9lZ05PCAlf+JWpp4t7fUlCBA97TEVoru?=
 =?us-ascii?Q?dl4CcrP+M6Z0+pb8YSbU+sD+1wKF2ZksVwfbyoP5von+t42AtYw+eOA+EcWg?=
 =?us-ascii?Q?50kyD7nkZN5+WOr7EPc4kii/8++K53tMvU1zYSvDJi90zuPCYNBVBC0wojI5?=
 =?us-ascii?Q?/ag/2sbWYT9HqV+eF3C7EfD6bq1zrUfdSdk3ADopAlTWMdhTZG6dKgzbxazg?=
 =?us-ascii?Q?8kaAIoxFOaOj9ZIIkvc48wC0+m3HWbcbrsMC2Tmizan4XvMj0jjcYrcb4HaI?=
 =?us-ascii?Q?ktnQP6bxEfAsAcTpcjcitbd8fHZxj8c5KRdlOOT4EnUgEqBEZbxny457WH2J?=
 =?us-ascii?Q?pX6RabZRbtG/7xNvEWttshubewQK0wbYi9R5ZxRGJDHm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47a49bd-36d9-49fd-314e-08dc27c2d0bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 09:54:45.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0B5QyzWv/evhNC5czZSn+NMd2EQhQJR0Lh3YIyoeWivof/OpiKJZu4pUgbjnT+BCG1A43pmsB3+D28BdKb4wN+WfXMWMAidLdJ1UoYUN6dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4975
X-Proofpoint-GUID: rVBKUgEQQ221E6YrwThhS1c2AwcsJkbI
X-Proofpoint-ORIG-GUID: rVBKUgEQQ221E6YrwThhS1c2AwcsJkbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 mlxlogscore=742 priorityscore=1501 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070073

> On 06/02/2024 21:41:10+0000, Chris Packham wrote:
> >
> > On 7/02/24 10:12, Alexandre Belloni wrote:
> > > On 06/02/2024 20:19:20+0000, Chris Packham wrote:
> > >> That is an incredibly good point. The max31335 binding covers one
> specific chip. This binding covers more and with that there are a few mor=
e
> properties that the max31335 on it's own doesn't have (e.g. the clock
> consumer, the ability to have different i2c addresses). Binding wise I co=
uld
> probably roll all of the max31335 into this max313xx binding.
> > >>
> > >> Driver wise things are a bit trickier. I've only got access to one o=
f
> > >> the variants so I am hoping to leverage the work Ibrahim had already
> > >> done. I could attempt to incorporate max31335 support into the
> > >> max313xx driver but I wouldn't really be able to test it properly an=
d
> > >> there is a reasonably high chance of regressing something.
> > > But I won't take a separate driver. Everything would be better if Ana=
log
> > > was sharing the datasheets...
> >
> > The datasheets are pretty accessible so I'd give Analog a pass on that
> > (they're certainly better than some vendors). I'll include some links o=
n
> > the next update.
> >
>=20
> The max31335 is not available
>
=20
Indeed, the max31355 datasheet is not available yet. This is also stated in=
 the
cover letter of the patch series for max31335.

It was an urgent request from a customer to have it mainline as soon as pos=
sible.

If there are questions about the part functionality, I can definitely help.

> > I'll attempt to roll the max31335 into the max313xx driver.
>=20
> I guess this would be the opposite. Renaming a driver breaks existing
> kernel configurations.
>=20
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://urldefense.com/v3/__https://bootlin.com__;!!A3Ni8CS0y2Y!7A0VM
> Nj1SLsNWZ8SnPrFwG6KX2TqjeLQi38EYIV164_5MWlQ7yCFvp8yOjaswIRNLC
> 0EK-_bhHEfy6xAXEJimVEW8BZXdn_r$

