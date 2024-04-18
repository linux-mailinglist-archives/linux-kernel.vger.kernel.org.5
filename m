Return-Path: <linux-kernel+bounces-150131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C578A9AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471781C20D04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A5136E29;
	Thu, 18 Apr 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XM0m0Bn2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z9sN3Bm3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CF13247D;
	Thu, 18 Apr 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445628; cv=fail; b=K+/XxnP8qYTBl+6SvfiK/NGD74IdiB2jHIXZJXtR6R5xKWxyTUOcGs3JVF+ddRMTHINLRe/IcFX2Tf112fgU3iwngx74QlEN82NAQ6e49F1cHbTb5qy9RtW+0Qn1CnCHodGig3SkFHt3XYKg9JXSak+Ujtp1JNrixkIiMZVX5fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445628; c=relaxed/simple;
	bh=t3l5pmkkxP6DlapqTJ5S3E/IGPQsM4WBLCy87dTzwoo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EwtlIk1JdLjsnSSbTRmF+MgoPSXE3IEWql27B1OxLdi/MPdNxDp9wIo0DjDhqY1H5wKbPm66uHvDeXBZy4Vb9PWpgKHyeCY+Bid9Dia/FmY7cLQpQmtsFX+k1mbi0/xIBt46XZIaDdi/BgdM0s7/CtDYaP2FncVj23QX6ucmSXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XM0m0Bn2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z9sN3Bm3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43ICJ7I0018233;
	Thu, 18 Apr 2024 13:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Zz5WXsVGM+/bdAqTcO/el7v11ovF2uL2la5gDPKxZFA=;
 b=XM0m0Bn2TIWpYXb0aEMW5TQEBWNXrpF+iDIWR8pBNdfokdSd1BWxvKBSEILD2JZ/gaoz
 xjkxEIgtg1y9YxOrCVqX0myZoEGqFCDqZh+LRugRy3yVznj5DjTo+0n2MGnJu6B6exU/
 pP5IdfcRW2IR4UbH5bX33dPozNyfqFejMmKdkKI2MYwi960sT9s6d/8q9IB8GvpzNa3h
 eMyyqXTWY3QHHVagEwkaJbru09pFSvvRlFC9sccOth+vandZlz9p4yjHDRoFVmFW776G
 npG1VrU2yp8zByA1OA3Omme2zVa603bwaYoAIn99sbgBEtp204zH2GEcZiAtMXePMxcR 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffjc8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 13:06:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ICr4Qo021605;
	Thu, 18 Apr 2024 13:06:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgggnx9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 13:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdS8qcQDjgTM2BYd5ZNQNG8oHSgg8TvNJXUFfw0ymboNdbxjkkf4sLD+MfAvYBc2eu2/gRMJgHE6CO4EbQqGD82ExLlOQ56n6IvwImgasZ7hz9U/ApDFAeYK6MlzbnWCdxSjYJ3pp3XFkVmFjBsx5dP3T2DPqNn8B57qUIvL4yzDinOX6X1/NEybhV8llEMgMN9JJ2jwBgJ07jYHJxKv9DmMkQo1hKYWNZR9ly7xXuw8CP/EaP5KjwybUR8C/FCYdy+Ju4GjcxaoXKDTrIE9s2QxWHO8+ZS/ucHQ5TJTvbZ5exge8Wo13odtdd4ZAjFsSOReCAjrF0gh4f5PB+o1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zz5WXsVGM+/bdAqTcO/el7v11ovF2uL2la5gDPKxZFA=;
 b=O4/B4rbIrezAIHw2ynH9NicpfHzzW4K5Ghki5Ym49Mn7jFPYN7GXVXQx9UubDVXOqVriwyo9g60OPXVWW8Fj360axjUHtjAp53GLg9LNNDmgHP0WTqmrZ+fKQJDAKp9jpvRqnpDUhF/grpLQT+tzXBbIhGQRFZ8spLYWjIaDu22QDABGU7BKfSgwc1DPXyHDSfImllwWMlZZcIQr401tTvOP84wgRhQFOjrp/knwu7k0bpvZZASK50eva2jbYX5J+8HKbdTKraoxg6n7/W2fPQRKUW4OWTghN+2GmV+UrmX9UqVPHz+/aOgmXUy7lUHOERIEe5hm2DB9T/UwEhG0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zz5WXsVGM+/bdAqTcO/el7v11ovF2uL2la5gDPKxZFA=;
 b=Z9sN3Bm3hGa2yz330HaDGHYEJ3Zapa2HcJR1E/5ptQ/pmWufk1eg8ETTxAzNR6d2VkwEU42uZwiTEtPJyNEfZTx5rxXJ+7e6RJNu0+Pn8LJAGGCPey7MvSvCfpPO0lCFpzNdGTRVChZ+zAOKR6DDiiFR+mQm1ZeFFrBEIf7lpU0=
Received: from DM6PR10MB2810.namprd10.prod.outlook.com (2603:10b6:5:71::18) by
 CY8PR10MB6729.namprd10.prod.outlook.com (2603:10b6:930:94::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.41; Thu, 18 Apr 2024 13:06:42 +0000
Received: from DM6PR10MB2810.namprd10.prod.outlook.com
 ([fe80::639f:6c93:12d3:cd5c]) by DM6PR10MB2810.namprd10.prod.outlook.com
 ([fe80::639f:6c93:12d3:cd5c%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 13:06:42 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-cve-announce@vger.kernel.org"
	<linux-cve-announce@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [External] : Re: CVE-2024-26920: tracing/trigger: Fix to return
 error if failed to alloc snapshot
Thread-Topic: [External] : Re: CVE-2024-26920: tracing/trigger: Fix to return
 error if failed to alloc snapshot
Thread-Index: AQHakYflavlUUMfH9kOorpGL09z+TLFt9pSAgAAI2AA=
Date: Thu, 18 Apr 2024 13:06:42 +0000
Message-ID: <92ec3ce16c7e640de19b44165e2bb88b63dd2478.camel@oracle.com>
References: <2024041738-CVE-2024-26920-a681@gregkh>
	 <6fa1eb4368cbaa2d0b243539f1d91692da95e117.camel@oracle.com>
	 <2024041805-rippling-entourage-1a72@gregkh>
In-Reply-To: <2024041805-rippling-entourage-1a72@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB2810:EE_|CY8PR10MB6729:EE_
x-ms-office365-filtering-correlation-id: 434ea3ab-13c5-4c30-7a04-08dc5fa86476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zSEKNUrHMoahuzt4zPn8p4alhtmVrigxjdKdFlcbzjR5uljDxPx2q2+QiCXfHqdO2phctJZEQiY2hUGswlU2fZEhQLh21fvjpS5SkJqHFk0D4Hae+seYiU9j5l7t0p4Lsed43TuF2hYlU72kXInqHAyHTWxmRwmIqR+sQWzXWwgSyLszsOAI/fiyvO+mptVPbLfEfh5Sh5N0+NmNo1QWd0B2Nvkj8YZZQNbo/w2aikDzl6ImdUs2wK4aKY/PJ6FyeeTg10ESalTkuOMQz1Iyn1QqtfLXhl4sCXFm3Iwdop+/YuHwR2Ozyh66S1JWf/GClLUGSwm1a5OtnIIydr6+HzNSutTC9XvE8jq0SPXc/WW/t97o1hi4NtrM6hfHHmJxVFsLrMBIOuREEliTh3HGtpKerWqXI6fIZhfIlFT+f5wQqd0mChbA5Ej9X0Px7NxuoEGCdC/RhsbuE6kc3SWC/pQMuINrER3zEOaWTn1V32XWTSRvZW5xyVLRfyuT0JF7xsjdBgbkSwUuc7GlSzyu1L/QZKuTrGgyP3hvRD1FOVbQJY89qi5ebkiMjGSTt/RkGVje5XnHCO0lHlGAhVxnMetoksuCQqlKVbd1axHkqCK0J2CrJu1bkcv4rTjMh7MuHO2O9Ou3ELKyYGu4YIQshEpQx4yKE1d6humcqoMyJfsJOpDabMbnA08mBldvGrXxMipHk2WfldWBll1St30iqverjsGWPm8TOFoxySSl2uQ=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RkxPaVBTaFRSTUZSeDZlK0ZzUjZLaXVBRmR6eDJlUGtwZGVSaFJOQ21QL1g0?=
 =?utf-8?B?Y1o2aDgxejQ5WG9RV2tISFVCb1ZMUkova0RvbDlHbHVjYld1ZEk5dklaRTEz?=
 =?utf-8?B?Nm9XaGhyb0RqRklwYURRS2ZDc3ZmS0pHblVzcytSOXd5SDEzNFFTV1lWZ1JC?=
 =?utf-8?B?VU5aeUdNUG1xT0l5SHNLQllQYnBOd3ZMVUlkZCs5WnpVRTBFSmpqYjM4dGgv?=
 =?utf-8?B?SVNzajBybnU2eEtseEt1N3FQcys3YXE1RlhqM0dSQWNsMFVCL05ZNXFLSzhi?=
 =?utf-8?B?RWNISDRTZVFkV3hYSGVDK3pSMGprVEpvNHFrUEJjUDVjSVM3azhhRnZCNFJL?=
 =?utf-8?B?Y3ZTNDN4Vm1qUjkvNmpVNG9pamhzUVAwVCs0M3ZKU1JjclUrK3djUXJ1dThB?=
 =?utf-8?B?cEJvbjFLb0FRNGhIR3BueFVXUHZWNVorbkhkRTdjNFVOK0FoUXR5aU1MVVNQ?=
 =?utf-8?B?TFNsWjRRbTR4UUlsYmd0Z0lkWlZGd05WczZxSzZBbzZ6MTNaWnNyNnJ1ZGJI?=
 =?utf-8?B?VW1sOWUwdUptWUd5VXNBQzdMRWlmR1JIZHR3ZDNpZ0RLS01GMExJaTR3ODBr?=
 =?utf-8?B?S00zQThzQzJzU2Y0emtWTi96Ky8wcVdNMnBLSTQ2RFBLUXR1Z3M2c0o1Wldw?=
 =?utf-8?B?eDY2eGJOMm9lTVZVN2FQVkFoaU5mcGRFMXZTZm80RHRIMzV0LzZOSnJWZXRB?=
 =?utf-8?B?ZVEvYTlEUWFleENHYkF3djR5blpVM0pVdEZpQXQ1a2RZSS84L3ljUXhCNG91?=
 =?utf-8?B?OXBkZGFuYW1MWlVoYUQxRTREZEZmVWh2cFNaTmFFUnZuQm9WOURJcHRpUEhW?=
 =?utf-8?B?L1lCeU5ITFNTYVVUelFBSkM5RG82S0ptcU9NcTRiaStkaXpLbm5QdHZMWC9S?=
 =?utf-8?B?bm9sU2NQaGVGenl5dHJBTnFjR2RRcThURnp4WHZucGlaWWFHUHBoNkZEZ2o2?=
 =?utf-8?B?eUNqSlVRcE5pOTROc1lhZEhlS1ltSEppWG9oYUlTWlFqL1ZCS3ErNE9Yek1v?=
 =?utf-8?B?QVoyam1wS080ZG0xcE1wNDFpamZOYVRLSFdJT3ZENUJIMWR6cU55SWpSMzBO?=
 =?utf-8?B?L1pqTk9mU09YdUtOWHVIRVNOSjU4UG12eCtLNWNKNCtwc1I5Z2dMUkdOdHA4?=
 =?utf-8?B?WHNtUVUyazZ0emREd2hJNnh6UVJGc045UUYxTzJlODdqSTM3UmE2S3I0Skgr?=
 =?utf-8?B?em1vMkQvelhlTytzSjQ2d0Q1blVNSDI2cStkOVdiMlhwTnh0WkxWbDNjaWNU?=
 =?utf-8?B?UEU3QnZaWDJkeWNoVllyZ0Q0YkkrcDNBVWIwc3BQSFh4T0F1UnIzT2VHSjhM?=
 =?utf-8?B?dTY0MllVeExPMXRQTUU3MnJzODFJbjlkdFBKUitrSXc0M2xkcU5ZaWZMWjNB?=
 =?utf-8?B?dHF0V1FsTWhVRU45amN6WkxscWtIV3lBbjZ4RGJjU2pWdzFtZXIyQ250c1Bi?=
 =?utf-8?B?TGJFck5pT3pBRjNWTDJBcTB3V0ptd1VBK0MyNmk3QnpyUnFnbHhNK0VlYk9h?=
 =?utf-8?B?cHJSamhlVzBXMEZSRkZGa2ZmM3g4dG1INHlSY0Qrc0RMTUFmbnppQk9iaVRn?=
 =?utf-8?B?MHQ4YVd5T2o0bno1enZmYmdNdTNiZW51eWdwZm5sQ1pnaU5wV2JzNkJ2djNI?=
 =?utf-8?B?NVU4UmV6c20vSGNnQWEvR243MGdLYW0vNHRNSGNpTTllRU9XakdxRUUvNDkz?=
 =?utf-8?B?OVRNTlFROUpXbnlQZUZ4RmtHczAyNDBrcTUrbk5hU0N2TGx2L2tmNlFKdXIw?=
 =?utf-8?B?ODhYNGt6MXJaQXVVZXlqbzgvT2RHSFVPTjVOcC9oMEpuZjhGVE9IWjM0SDZQ?=
 =?utf-8?B?Q3NJMVRXd2srS0Y1dFMxOG03N0ZhakRmeCtMTWxYbjg4MDZiYnYyNWo4VUxn?=
 =?utf-8?B?MUdYaHdMNTFTbHgyQlBpWWR0eVdudDJocEdiT3JGNnhyTEZFN1Zmb3JDcSsz?=
 =?utf-8?B?R3c2RjR4QVAyY1ZTbHhaRytwazhKMXJxYko2S0VDd3JDWU9iMGVLRU1RaVhY?=
 =?utf-8?B?akd2aWJwS3VjYXF6MEt2TVFGZUVCeDBEaVJkVVlXK1laVW1jQXJod0Y2K095?=
 =?utf-8?B?U1VXOEZwNEpWaHZGcitZclZBWkR2WU9KbjlJTUIrMGV6d0xSWHdrZm12bXhs?=
 =?utf-8?B?cGxvbkpOc0Zna2JWSEM3dnpNWk82T3IwMnQxSE5NbVF2ODVNZ2ZNS1c2cit1?=
 =?utf-8?Q?+mqFOnzwROASj/lSt0P5wDo4B6vqbLuMAwNsFvS4920q?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-JAhC1ryRAGvOU1zuwHLD"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sYCy0DEkkVR9l+Bb3BkWaybgDcw5+EvP2dqwxvufLuMrNMOR6toMuE0DQR2PV9/wXBD2jppjlkFFz12lxX/ctZEst4RUi5nwXTG13m1Epx0OoxXCi7I3yVtVgGEgpEEw+D7kqvAczWTAcE3QT7n/0PGs82R5HMx7FSI985EpGAZnMJCtKUIL4U4T0r43/OmuzDfiU2rZFyyGW4bybYu4RUinAqCqEfcFkvyxkvHwEAED2awDzT6/23iaPiMsMIbt3m6thsGNogeEjuHypTkdiiYdCmohAfRGRwyIvKtz/h+z/JgrbtMiIfZbQlMS0c6T2vNEs7STSkjWP3CWqXbPgyVieKZkfmw/3thymeoH+G6eClFFE1lJ0XotfEWiZMnipNXS4xrWfUnj4SX4NiVxKXIbyuiqOYD3wT/zKn1rwYWIOkJwottT3qmaKXiUqF6THRro3wgxLISPY699mdnep6L26tDNRsxVRC2U8uYEbwI53DiN6yqkglIJw8lAnctHmiNB+Uj0+DYeLnk5QfaAZRoCN65HjGNcob7opLuybuI6zQxHsO4hiMmDb7EJOqdNNNPpUyW3AHovLr66zj+yuMtIVATfd+JQQPf5AoYPR0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434ea3ab-13c5-4c30-7a04-08dc5fa86476
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 13:06:42.4058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdSi6PPwjXg/mTcK3TRfM8U5JUQzFKnQ9XJgrN3dvzKD6yGpGy/CcYIfOpDc6SpYEMkzcB+86IqbR9zZwMsbH2Y+XrB3VtH6Q/jtTqrXcmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_11,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180093
X-Proofpoint-ORIG-GUID: 5uOdh-UHVV5JUanuzfEF3paOJJqblc_J
X-Proofpoint-GUID: 5uOdh-UHVV5JUanuzfEF3paOJJqblc_J

--=-JAhC1ryRAGvOU1zuwHLD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18 2024 at 14:34:57 +0200, gregkh@linuxfoundation.org
wrote:
> On Thu, Apr 18, 2024 at 11:59:41AM +0000, Siddh Raman Pant wrote:
> > Hi Greg,
> >=20
> > > In the Linux kernel, the following vulnerability has been resolved:
> > >=20
> > > tracing/trigger: Fix to return error if failed to alloc snapshot
> > >=20
> > > Fix register_snapshot_trigger() to return error code if it failed to
> > > allocate a snapshot instead of 0 (success). Unless that, it will regi=
ster
> > > snapshot trigger without an error.
> >=20
> > This commit is problematic on 4.19.y, 5.4.y, 5.10.y, and 5.15.y,
> > and should be reversed, and this CVE should be rejected for those
> > versions.
>=20
> Then please submit a patch for this.

Sure.


> But note, CVEs are not for specific versions, sorry.  We give a hint as
> to what kernel versions might be affected, but we don not assign CVE to
> versions.

Cool.

> >=20
> > The return value should be 0 on failure, because in the functions
> > event_trigger_callback() and event_enable_trigger_func(), we have:
> >=20
> > 	ret =3D cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> > 	/*
> > 	 * The above returns on success the # of functions enabled,
> > 	 * but if it didn't find any functions it returns zero.
> > 	 * Consider no functions a failure too.
> > 	 */
> > 	if (!ret) {
> > 		ret =3D -ENOENT;
> >=20
> > Thus, the commit breaks this assumption.
> >=20
> > This commit needs b8cc44a4d3c1 ("tracing: Remove logic for registering
> > multiple event triggers at a time") as a prerequisite, as it removes
> > the above.
>=20
> Should we just take that patch instead?

The series in which the patch is posted is here:
- https://lore.kernel.org/lkml/cover.1644010575.git.zanussi@kernel.org/
- https://lore.kernel.org/lkml/cover.1641823001.git.zanussi@kernel.org/

Seems like some good tracing subsystem refactoring. So if I understand
Documentation/process/stable-kernel-rules.rst correctly, I would say we
should not.

Thanks,
Siddh

--=-JAhC1ryRAGvOU1zuwHLD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmYhGtsACgkQBwq/MEwk
8irmGg/9E8tYBkfLbPAvvI3LhRki3vAjOjQI7neB/4Z7Cy2UuMUdp8XcsHvwnwXP
Drjam9ycJFRy0N0sOOZVKk6UF0t6A2RgNbaxkjYMfI6vSSFo/MaG2MrvSzJLTJut
pConpoNB3SDJePhhVv1uiEF0ANQEkGeMAW/iO4FOF7Dye66Bde3lD7AFgz3qo9bY
rqkfisBqAYZUMqReNq6lLt0IbKxRgw9WOY+YedzH56wqz9yuYllCJiFhCRIumdAW
gKZcPk2ARzNaTOn6kZGtV17LyjuKq8LjQ0AD7qNdrpIifEcx6Ilv0ynbcrufaDn5
0JBEe8SAuMsFt9haCEYIIO23IEzjaxgj5J6Ua9vrBUuQhNC+kcfouK3qUnMw0XbX
rA/+3+rkPOrfaT4JrfBeMeRbq+y7DkAo/JfTJfxJcJddsSg6odGM1kglJ0n3WZiE
BNiHDMcYDAp8uBmSE78FWxmH303im9zexBXnRTVbgL26hTJK079r9svSTycVB1q4
3mSt4LjeYzz5heGGrMufJrmyel5AlCohBlODRH7dzAzTsKIlxEEp683EDW9LBN9S
nCu8jlhufCTookGegNYrbSxuFq0CFjeazoM6uBWuSnXyecNRRshw136vH9ZFKLD/
qEVXLupwSGpcHyzfz9G909MR8wRthj0D09jyvhxPMCEphr6Swh4=
=m4Ys
-----END PGP SIGNATURE-----

--=-JAhC1ryRAGvOU1zuwHLD--

