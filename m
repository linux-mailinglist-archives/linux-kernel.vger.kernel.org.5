Return-Path: <linux-kernel+bounces-69840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F19858F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A728C1C21BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203442C6A4;
	Sat, 17 Feb 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lJUz/Tl2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ra64DCPQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C077A72C;
	Sat, 17 Feb 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708173600; cv=fail; b=qgcPxH4/N/O4KPS4NVofSaJ33e4n2AlAXp0MiFF7DRprqyBFxepUUb6Y/3jncEmD/t2URt5mvrvQR23JrYaVpsVsxpdM74O31GJK26PRvWER3zqM1PfLciSvvaW7bRgZLYJG2eg/yqFgVQ4N+CNxGFeJcAWLxXX3S+NBdIHI6bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708173600; c=relaxed/simple;
	bh=SSoJZ4iN51yAAvqHO30JDipHk+8EN5o0qN7X6x5MWxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OlMUK/ylr7dJbRvuNpRtPscfbWRIpr+oFDF+BXtKQKDNleidJ6TQWW0fPh+Sb646pieHy1H0bZWWNBN4wDv4T1j8LL8P2rizjJEDHeIFEhY1ttG/zyd+Z3oOPvMO4KUB1nng8vM1L5cTXd+A2mUXFDbIQ4OWZFw+iOP6FaxamA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lJUz/Tl2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ra64DCPQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41HCErA8016914;
	Sat, 17 Feb 2024 12:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ee+J2GayXoUg853GqKsmLty8FMDF8NV4iDWJa362SWI=;
 b=lJUz/Tl2y/nmN6NMvVxUZVAFT69UcOidIUYHpzqX5OX9WhQ+mKdQXXCebeBdCw8i57qY
 hDdsPSE2uTKpS1A/MSmV7yN7Psbu0lCSikIRHNS8nh3UZMv8e0jwEIHpt9Atjll93Ntj
 HqS6Pt7LOa/Clv2SutQ+EsSVfKDNxlqkgLqedcRowkxiWCLMPsrBnllGS6w6UeWvry00
 gF5ulVPPAX8a2R2wHUkIHqPf3FePv+5tX3xSfCqTEKvoJY6DRjlu9M+ESt8J5GId+KXT
 plTMLj56pebsmwV0nxOwvoilQj9XVL0M8Nnyi5yKAzu4AGcVE6Jkf1NXxjuhysS1NxxE UQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamucrpxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 12:39:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41HBSUtq016501;
	Sat, 17 Feb 2024 12:39:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak83wcky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 12:39:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH+VompRIEhhR697rQ7qkcmC0i4kaiRkfOo3p3Q+OKBDcwvIdzJWE3wS5Ewdgcbw4ivPsGcu2y7gyBM5VTEWqLoo8uqlTiCXF2/gbQsfjyCL8ckLXKOD0qB2zp/V3ORiOT4CN3rTjWufLzB3Eg4CJyV8ylgBOrNvOW/ZSVNz5RXDSIK7R/hhu2UD89LJkvSIxnnRm2YoEXkinVXodI2VUE/h4y18Jaum1Sv9dJf/apAE/4nS6Sqaiq+IDAMWcMgO2hmINYmhl4O3mujxxOpO63demcWEzdyISzklpQAbcdmigwn4/sNyzHWnciHehttfWlVTBuyF4gu2O384DkxHew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee+J2GayXoUg853GqKsmLty8FMDF8NV4iDWJa362SWI=;
 b=m75xkSQRGXm4IHoAvSrRsRD1yQJgzv9u51Xy1F1VLdOVZK9hSGwX3Qpow6spAffFOHiGXAGb3BwMuu2jaMQ2YI36mNgNE7mmw8Fog4ObDJqPTRYaq8l2YC+Br662d0I3xbBYI45l8y/zoCIeOrmtTNd1j7kVXIe5WfwuStPrUHTSWtz0VCXdgKvYiQCWwvo2/gIBwHppDcO9TxRf7Pp6WpQ5FT7t5SaRkzdbL2IaO5KZFPMxaSPLSiJxNfCYIEh/4WGXCisOO/qZxZbddAWtaKn0SC3WosUVcjWQU57VvMr3Bhwfj3I8o3YCJUl5UPjrbyx7Hwt4y2CjAroKBHDRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee+J2GayXoUg853GqKsmLty8FMDF8NV4iDWJa362SWI=;
 b=ra64DCPQAwCbZfWrpsrqBSalrvtWFWOgzF4xkeDuOp9V2oUUG6olbo0Gf9YjakyQwPIb5URgcgInnx6fVywYkXhMhqHmSsu6JuogisalWbZL9MSMndiQoR+qgr0gfXp6t4rCqdUck/pe2GSV17roIRbv2Xf39F9tSq7NydgIvYE=
Received: from SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 12:39:44 +0000
Received: from SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219]) by SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219%4]) with mapi id 15.20.7292.028; Sat, 17 Feb 2024
 12:39:44 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: "j.vosburgh@gmail.com" <j.vosburgh@gmail.com>,
        "andy@greyhouse.net"
	<andy@greyhouse.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>
Subject: RE: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Thread-Topic: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Thread-Index: AQHaYDQQSI4J0p3dLk+q/3SGugGtKrEMrZSAgAHMEYA=
Date: Sat, 17 Feb 2024 12:39:44 +0000
Message-ID: 
 <SA1PR10MB6445D15BA6BF3CD57CC690328C532@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240215172554.4211-1-praveen.kannoju@oracle.com>
 <Zc8k2wYZRvtfrtmW@Laptop-X1>
In-Reply-To: <Zc8k2wYZRvtfrtmW@Laptop-X1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6445:EE_|SA1PR10MB6615:EE_
x-ms-office365-filtering-correlation-id: c14530bf-2766-4045-4b8e-08dc2fb584cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mW1vUgW/BkMMm5kfV3vgsZloitU1j9Og28p7b7YHHyg5DyhykWA7Dcc+Aiscy/MVJysj5bOQGeTtErpERS2y45B4zSe8vqKvgS5QoGi2vJa9WiRirBypC8gdAQtL6DT0BXUVfe/qoGF3cnM86vkfQh4Oy/5O21hiHOo4PdR1jusyB+FSTZ5+SVDvTFzm+yIhJIzXMO6PvGNiclfKFeC5AdeysmhuCeVfKnKTBNmi2Y5vCZ6kM8e8UwBOdCMG156Ujj0zxEEXiv3MeTdVD3wRfUK+t2YTnJvWlZh6UpezV7FBcieZ+96xirsfv+H6Ki7FWlwGHJyEW95Rwd/I3jtmpr3UrrF5G3EWvMKrJADz2eB62nM+EzTyoogP5rocZJI+urEzB8lzuK589yHv9hNcQRuOWrSBrNm0E9L8SLNQp82F1HPEcxLjmytajcwcQ34kBKOybn4uI8sKVCT9crtHHWaVrT/YAcssov9ZEwEwcjpDSNSBWD7iierS8ipW4Xz6YsCMZfw8j59IpmKqBkyVLU8nvp/2hfTPX5JVfFUSCVRnJWaVbryXRQivcmKhrCLTyBnoh8evEYrDCP9y59Rg5Vv7N03/fTbrrjj4rurwT82WNxe5WX0tLn7l+/+MFCox
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6445.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(55016003)(53546011)(7696005)(55236004)(6506007)(9686003)(86362001)(33656002)(122000001)(4326008)(8676002)(66446008)(66946007)(6916009)(76116006)(66476007)(64756008)(44832011)(52536014)(2906002)(8936002)(15650500001)(66556008)(5660300002)(83380400001)(71200400001)(478600001)(45080400002)(41300700001)(316002)(107886003)(38070700009)(26005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?HY99O1qsa7DG9WrAs3UAzbItqiBhBdrZWULnUWkhu+4cZnmt8o7YgT9xQ5Dv?=
 =?us-ascii?Q?ZFRh4b4KJx4AMufrJVwEscAFdwFyhBdumqOdvu2MrsAaHmJft1exUSzwfp1g?=
 =?us-ascii?Q?S3DP39w+Cvub+HHw/rxqbgUfoaNC2Ha6O1w0R5z1siftNLZ2g3rkH3lwkzp3?=
 =?us-ascii?Q?5Qq3Z9a54GUWhrlI4Nvo2QiA14s4joqVG1gofUTL0JNIpZt8q5sbqpV3FfBc?=
 =?us-ascii?Q?nxIBH/TrgVkqJe8cQ2nrObD8MukeawL7b2aE4R7Yjv7QK6xnpkbL4b5E7TDa?=
 =?us-ascii?Q?evzLf0Opp5qsjhjTftt3vaAhamlWAvBd+FCPDKFJB4Orh9LSzl8tMzmVuvcD?=
 =?us-ascii?Q?IOqnfmt3KfDeq75piaLSG+wdXA7QXTsPe0lljw9wRnDYX8LeIM2MLjM2f3Uf?=
 =?us-ascii?Q?5xYEuehckmVTuyMm+6EyUuZHc073t2PaOWQx9p9PDiSf1+V6lC/bIy73l/W/?=
 =?us-ascii?Q?rZThU25YC7eMEHBBCRvbuZX25tmcKhnKVKBfzsGHIlpMPsx0JNAT7j8QBIpV?=
 =?us-ascii?Q?iDpY5jyLn9QXsh3mWZKIidy/PUgYLeLKJ+UQDwvj0NYYqoAYCR//Pz1CpnLE?=
 =?us-ascii?Q?fcYXOmQ/MLT0O2TmT/rXgR+E1y9GX5tZOrqtAChh1zvkvPJqC2tmphu1qEqm?=
 =?us-ascii?Q?TmQMCd3zVnKized9zg7R6zjwoti8QMTrVT45L5ctw8M719fpEMzD5TfRaq4J?=
 =?us-ascii?Q?3w2vjn5E5vUPrlqy1Qet5Wkg0Kg9fWGJ68J4bNhRzuS3mx9wrsbO5ocCWG1t?=
 =?us-ascii?Q?RegNV/pTNZh1PFELzpwq1xB5JN2OVgiw5WdX929WzpV6Lh6/55/51u52hasO?=
 =?us-ascii?Q?tdTHB+vCUAdOBuT0ccVk/xJg7rcdAweLW9dEUmosAI68gNqiCzsaNB1Y8WZ6?=
 =?us-ascii?Q?yc0TQfryNTHSTlvjfMkIRM1RZIguEbsz3SeiaGT8AfAQZG5vIJFBebn7abfv?=
 =?us-ascii?Q?sQcjCgew0fGq6GbkMy4hVnHZunOfW5qDM/0lBsFpiZ7VUVrxroqwh0a5svXV?=
 =?us-ascii?Q?rf7IgT/E/Fb4la9aQxwxR+B+3fEiZAFwZIzVMOdiAf3CSbQuOPvJ0vkyAaZR?=
 =?us-ascii?Q?DckgxepH6fGUPQqlTFVe8wmWP296RKlR5u/HrBA7yB297W8QiL/M+OKOFGYJ?=
 =?us-ascii?Q?AysGQFYJfRLI55TFs8qcQB0yNju+V9W6SehESWOfgGiSaQ1u/IGjyx6HnfxS?=
 =?us-ascii?Q?StBOxPxHAdEuMIpqKD42kLIFCZs/UZCEtIjAoDcJCoeCvFlac10NHonuOQpz?=
 =?us-ascii?Q?un+tjLDdlFiSC9AJs393SumeHekUCvfOqUISkG+26SHsCPtPeK1CieIxrBX2?=
 =?us-ascii?Q?qsjz5tg7sR/AK8BUJWRi1UWOwOrgTe/m1eZgRmMHoPyQtdigubBSux4Lvqck?=
 =?us-ascii?Q?xdElypW/MturNCS6s/zwPN8G7q5nLOg16KYyOgBvQlpz6qTZXx8EUrCy/oA+?=
 =?us-ascii?Q?CRDqox0uGf2EtH01PZVeGSrPHLQ3y/IuyzRXgLzzYOHPjgIkOxn8HS0TJnlS?=
 =?us-ascii?Q?X+BjbZSINBF/dPzbSEc71nPIIZadiVlR4xW1pwg1L++5cW00BGcaptrTIt9Y?=
 =?us-ascii?Q?iK8bZKRAjJHifPNcUyxG9M9Qhc6i51Kzb1o+vzuWalqnFx0n1lED/OL3XVlf?=
 =?us-ascii?Q?vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n9DV/0LzIp+eRnFhp4y6eEgNKiS2YrMvi6xK1n2fjsR8/MSnUxix4BH5fQJy0e2+dUDTdCnaUv4SWUXx9O1T6eLPeGywKT6+uZRTKnnDqOhVy76TfpwQrY3xequR25Eh5sy7JqcdNHp3+yFw4+EecO+TJS2rTrrbjqvhbYOW9jA3KyzR7sNegviIOAjryUiyy3KVOC7tYsE/LIw2wG0m7ehcLcOsTbm7B3Ko+YIEHQaAINH0FB6Kw2sZChowb1N6LP2W0w0D+bI9B0++x+qtpFcGetgZRZcnP4+f0YGRWzjp/WNetkVBjovGVHYGIQFtE+54fSuUaG8Fj5g44ccbKrVS1o5HLO1MZle562PFGfJ/N+VjG/HpalsIVWYWCmhc2EPU9ZfXcTyU/j7AyaBZAkzavVNbtWQVUNd5IKq3AmrskJecAx6vjiXVgKRDN20DlW3RymNEcaBklEKoV4F8rU430iVfC7rFC/bjovGjFaGXx3ZjwDFruIJc+BX7HYoE3XdSM6twAihsR6FYa/CGz32tbxL8x/AKfRoF65v8H6XfQ3pUC1L7ymNElPfP0kLCUvJrEDalSNgJC6WV0M3Oc1VMEerQInyY0OMyI98BTWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6445.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14530bf-2766-4045-4b8e-08dc2fb584cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 12:39:44.2941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OnsdcSXgaV8HZN8kktPy3oiMxc0hzoKXBGmOCkQdvXMgAS/5h2vUKp6JFZfBmGwitcMrPVpapfnO/sYSkAJaQMxPb7WrcZtDM7NAo/OiEY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_09,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170102
X-Proofpoint-GUID: OUrXf7j7bkNByLfqjAbYejJZdQg1iN-b
X-Proofpoint-ORIG-GUID: OUrXf7j7bkNByLfqjAbYejJZdQg1iN-b

> -----Original Message-----
> From: Hangbin Liu <liuhangbin@gmail.com>
> Sent: 16 February 2024 02:33 PM
> To: Praveen Kannoju <praveen.kannoju@oracle.com>
> Cc: j.vosburgh@gmail.com; andy@greyhouse.net; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; =
Rajesh Sivaramasubramaniom
> <rajesh.sivaramasubramaniom@oracle.com>; Rama Nichanamatlu <rama.nichanam=
atlu@oracle.com>; Manjunath Patil
> <manjunath.b.patil@oracle.com>
> Subject: Re: [PATCH RFC] bonding: rate-limit bonding driver inspect messa=
ges
>=20
> On Thu, Feb 15, 2024 at 10:55:54PM +0530, Praveen Kumar Kannoju wrote:
> > Rate limit bond driver log messages, to prevent a log flood in a
> > run-away situation, e.g couldn't get rtnl lock. Message flood leads to
> > instability of system and loss of other crucial messages.
>=20
> Hi Praveen,
>=20
> The patch looks good to me. But would you please help explain why these
> slave_info() are chosen under net_ratelimit?
>=20
> Thanks
> Hangbin

Thank you, Hangbin.

The routine bond_mii_monitor() periodically inspects the slave carrier stat=
e in order to detect for state changes, on a state change internally record=
s it and does the state change action.

Parked-to-Parked state changes goes through transient state. As an example =
for Up to Down, BOND_LINK_UP to BOND_LINK_DOWN, is thru BOND_LINK_FAIL.  In=
 order to attain next parked state or transient state bond needs rtnl mutex=
 If in a situation it cannot get it, a state change wouldn't happen.  In o=
rder to achieve a state change as quickly as possible  bond_mii_monitor() r=
eschedules itself to come around after 1 msec. And every single come around=
 reinspects the link and sees a state change compared to its internally rec=
orded, which in reality internal state could be not changed earlier as fail=
ed to get rtnl lock, and throws again log indicating it sees a state change=
 If attaining rtnl mutex take long say hypothetical 5 secs, then bond logs=
 5000 state change message. 1 message at every 1 msec.=20

And in production environments we have seen bond taking long to achieve a s=
tate as someone else holding rtnl. Many processes do get rtnl lock.  As an =
example we can see eth drivers. They hold rtnl mutex for the entire duratio=
n while performing a fault recovery. There are many such scenarios.

This patch doesn't change -how- bond functions. It only simply limits this =
kind of log flood.=20

-
Praveen.
> >
> > v2: Use exising net_ratelimit() instead of introducing new rate-limit
> > parameter.
> >
> > Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 36
> > ++++++++++++++++++++----------------
> >  1 file changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c
> > b/drivers/net/bonding/bond_main.c index 4e0600c..e92eba1 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -2610,12 +2610,13 @@ static int bond_miimon_inspect(struct bonding *=
bond)
> >  			commit++;
> >  			slave->delay =3D bond->params.downdelay;
> >  			if (slave->delay) {
> > -				slave_info(bond->dev, slave->dev, "link status down for %sinterfac=
e, disabling it in %d ms\n",
> > -					   (BOND_MODE(bond) =3D=3D
> > -					    BOND_MODE_ACTIVEBACKUP) ?
> > -					    (bond_is_active_slave(slave) ?
> > -					     "active " : "backup ") : "",
> > -					   bond->params.downdelay * bond->params.miimon);
> > +				if (net_ratelimit())
> > +					slave_info(bond->dev, slave->dev, "link status down for %sinterfa=
ce, disabling it in %d ms\n",
> > +						   (BOND_MODE(bond) =3D=3D
> > +						   BOND_MODE_ACTIVEBACKUP) ?
> > +						   (bond_is_active_slave(slave) ?
> > +						   "active " : "backup ") : "",
> > +						   bond->params.downdelay * bond->params.miimon);
> >  			}
> >  			fallthrough;
> >  		case BOND_LINK_FAIL:
> > @@ -2623,9 +2624,10 @@ static int bond_miimon_inspect(struct bonding *b=
ond)
> >  				/* recovered before downdelay expired */
> >  				bond_propose_link_state(slave, BOND_LINK_UP);
> >  				slave->last_link_up =3D jiffies;
> > -				slave_info(bond->dev, slave->dev, "link status up again after %d m=
s\n",
> > -					   (bond->params.downdelay - slave->delay) *
> > -					   bond->params.miimon);
> > +				if (net_ratelimit())
> > +					slave_info(bond->dev, slave->dev, "link status up again after %d =
ms\n",
> > +						   (bond->params.downdelay - slave->delay) *
> > +						   bond->params.miimon);
> >  				commit++;
> >  				continue;
> >  			}
> > @@ -2648,18 +2650,20 @@ static int bond_miimon_inspect(struct bonding *=
bond)
> >  			slave->delay =3D bond->params.updelay;
> >
> >  			if (slave->delay) {
> > -				slave_info(bond->dev, slave->dev, "link status up, enabling it in =
%d ms\n",
> > -					   ignore_updelay ? 0 :
> > -					   bond->params.updelay *
> > -					   bond->params.miimon);
> > +				if (net_ratelimit())
> > +					slave_info(bond->dev, slave->dev, "link status up, enabling it in=
 %d ms\n",
> > +						   ignore_updelay ? 0 :
> > +						   bond->params.updelay *
> > +						   bond->params.miimon);
> >  			}
> >  			fallthrough;
> >  		case BOND_LINK_BACK:
> >  			if (!link_state) {
> >  				bond_propose_link_state(slave, BOND_LINK_DOWN);
> > -				slave_info(bond->dev, slave->dev, "link status down again after %d=
 ms\n",
> > -					   (bond->params.updelay - slave->delay) *
> > -					   bond->params.miimon);
> > +				if (net_ratelimit())
> > +					slave_info(bond->dev, slave->dev, "link status down again after %=
d ms\n",
> > +						   (bond->params.updelay - slave->delay) *
> > +						   bond->params.miimon);
> >  				commit++;
> >  				continue;
> >  			}
> > --
> > 1.8.3.1
> >

