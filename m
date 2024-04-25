Return-Path: <linux-kernel+bounces-158790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063348B24EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF6D1C22A98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4593A14AD31;
	Thu, 25 Apr 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="hwYIhKSB";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="RH3k+0V6"
Received: from mx0b-0068d901.pphosted.com (mx0b-0068d901.pphosted.com [205.220.180.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6ED14A4F7;
	Thu, 25 Apr 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058429; cv=fail; b=IcuEhu5Yh5yFipyztflAC2MInnTkzbMVRmfelCQspd/v2zBHbDih1IJex7H4nTER88m8uaHXlvsdNI5n+Q8I+JD4iGOkkaLy/GOdffHqc7/NfFL48nj+IeWTu/3bIgvEWBulqg0A1n01sm4B7cR1sTgzyx8ZTOokygqj8dnqtCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058429; c=relaxed/simple;
	bh=ZYvtXtFcoyYuG5vaf03NKUV4CTB3bBJQjdoztJhTW4c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AbEP2LbzmRr+/K3xg4VqwVSZKu2s7wG5lW9fJZgJSm+P+geW26HSsyKOF1wrp/0iXhtzNdGRnveEnGFCFUZReCPCxoJUEXDsAxvADKKKsyonghxNjyCsLa4lHwvVQFj6GwDsDXp8wFNbIsE4Anjj2gY1XnEgXNfvYoco7e7vQLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=hwYIhKSB; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=RH3k+0V6; arc=fail smtp.client-ip=205.220.180.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278265.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PAM66H014918;
	Thu, 25 Apr 2024 08:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=proofpoint; bh=r0YmCo
	HuuGhPZnKctsdMDTTjBPqMJ3audmps9lye55M=; b=hwYIhKSBDVTXDWsbrwJsHC
	kWH9R9/lmOhWUGl5FrKWymnxERu0PGBR7UdwqKpe3yqOnAEtWywoXdIRtWtzoK2M
	2LbyrT7+I0OKY35pvKTvmEodE7GWpkBbC3zQsOs1+qRlse4/scFLEmlH5g9+CeYl
	0Y4iHnun9GP+tB0vgmGmOT4RItfiY8QrozrJO+H8IRHywMHhZnd7zk4p1wE+RzFX
	NAOorrHlFnI2u6XKdW3JZ0MFf4oTrOdJSatHfS0BDpQk4B0gNqhbH8hec1dcPsD3
	GhF3JdOR+3yrzPA6ZPQqEaa46fhm385cVo90cf7+rdaUVqbn9j0G9cqPrrWZUKtA
	==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xmadvkx9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 08:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkokwLXiQa1Q5SqAHRdgNSV3BoPRZB01joBmBOq+wjNmWyon/ocH5I1ac7QvVGEqBnzn+ooioX9gXdeFjtB9nQnyGpy35LpJqT2e/l6Y//0HlcAGszWM2wAQ5Fckyj0vVfTXZcSmj9fInX+HqmLRh+qsRwzCCCge17Aws5eDhehatD87fmcVpjSs6EKy+82f25OoQhzU6JCMqwlEyM2LGDbPrmpfDATlnGnw6n2+KTKNoomlbWfK87OJTqVzx+cvSlas4sUPuqQ7c3TxP36yMP9bNaFA/T4hIsR2r9A374YaW3cLsrm86Wku6v9k2sS/jBeBRy+rEXnEAErIS7rcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0YmCoHuuGhPZnKctsdMDTTjBPqMJ3audmps9lye55M=;
 b=J6tXAxrd1u4fm2+mur6XRGUp96yQ4pNcMjJ/xlt8d5PYR5JLaClj3YUt1uu9rN0T28XnLNKVO6Foap3XFG0I0PyHPakkxTucr76lZqktl/OYmwu/XbVUi6Q7uY0jxG+e+XZXclETTc708B+cN5tAkkFEXWS7WMliln0lsZCOi4p7QfdTmvaREQ3GkgeaQ4rJLpi9t7mQeFTh1ibEpEr4Xyph+z5bfmGLSc3v4RGTAL3ZTVfjRySmc7kVB+I9Sxq5HLTuJI3whqB56VkYdj0qw1WmkPFYSJZ65GXxyBoG+vLYwkmDnKpzxmks6GV2M1/wwVRdaRvW6AcxfQP1xj2Q6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0YmCoHuuGhPZnKctsdMDTTjBPqMJ3audmps9lye55M=;
 b=RH3k+0V6vJZoOAcibeEOBHynzBDLvZSpG7BAyR4GMSQt2rnG31dOhODve2x3mpSZ8XC3rBYGnDsV+VlagXRRbKD0io/6rK2Q4yB1GlC7LTgFeW2diOUSPjYnNv44uSF6/hfx5k1GMiXpj9R4vDhOQuyLx1/+P9q2JdsOUaPiS4NsN9Yh/rSYoN9IoU1F0dWS4XR4OiVrjZ8v1Eb3aQPenLMULZUJVcepKEaJbnRLjQ8TlKNJOrLR/Ujy7PW+0OClKWLMLqXrm1o45tb58cIL/++KfefAksJ13iEVdabQfHOajTFi0qaLdL2seGMha6GYEFEBuc5Wm//4zgzelfgZCA==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by CH2PR17MB3720.namprd17.prod.outlook.com (2603:10b6:610:8c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 15:20:20 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 15:20:20 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi
	<felipe.balbi@linux.intel.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Chris Wulff
	<chris.wulff@biamp.com>
Subject: [PATCH] usb: gadget: u_audio: Clear uac pointer when freed.
Thread-Topic: [PATCH] usb: gadget: u_audio: Clear uac pointer when freed.
Thread-Index: AQHalyPM5H/A1wf4GEWGdCTKp7qtuQ==
Date: Thu, 25 Apr 2024 15:20:20 +0000
Message-ID: 
 <CO1PR17MB54194226DA08BFC9EBD8C163E1172@CO1PR17MB5419.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|CH2PR17MB3720:EE_
x-ms-office365-filtering-correlation-id: c88b3a16-516d-4542-fd1b-08dc653b38b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?Bu1Nf/ChWamIpcuiYId1xTLzOU+rZm/nDMLes6R6nTyFtd9mvVflHs83Sa?=
 =?iso-8859-1?Q?y93j4j+0dXX47UNEda8qZX2w8GRrMqKrQc8jxYU5hkHdyyNpEax02ahEY2?=
 =?iso-8859-1?Q?ngT3+oxr2DJl8BMdTSZvcGE3BSblpRdtCUsbD/kEjASNUkd5IPr9XqYq5p?=
 =?iso-8859-1?Q?QBG5VzKN///rN91VigFIKprQxsZSJUq/5S8WE+pGdZ/VaHObIAC7ADxWl2?=
 =?iso-8859-1?Q?jYC5SUVwWglw8+WatDRWQPSbbBVoheYrz1m6hxH1UyhuAVhnGGRUwh0DFf?=
 =?iso-8859-1?Q?7u6wDl36uwbL3r0bh926DI29VJ5GCQMDbPdKgKDCah7/IPv0+3b5/YT+Ep?=
 =?iso-8859-1?Q?kH7gJ2SPhqs3wlu3kUH3EcVrBTuAotYj+ObFSmSdIjlwdE3OCNX3WjxLy0?=
 =?iso-8859-1?Q?NMJN9oUnP5IsWtdpMwNsawyHoiNZ6UvTxGJ4p5iiRcKsl/S4g/7lKd492f?=
 =?iso-8859-1?Q?fSvBijHc0xGvybac6Fb5YBsj40bmQl7pKDtDEUThhgA4k+dfLXL2hjl9hT?=
 =?iso-8859-1?Q?cFV6Ew596Pu7MAE3rDax8hGKgNywi1PAq/h+ebJ864+y/rGNXs8t2Gwc0P?=
 =?iso-8859-1?Q?dN3t4MTJghmgWkRTotD791UX+PEsfyXdxb8jlhXemW7SJ1+k6Hu8EfkkrA?=
 =?iso-8859-1?Q?M5nv6fZpH2aY8hge6jdhwvzxLu7Bh1zCZ0ow5Mhwk+YO2rvHQTcRPWecN+?=
 =?iso-8859-1?Q?NwcXOFbP5JZKkOyRqVtw5Ht34HgyOKYgz32rX3O5dS1sWhQRWBT0UTaN2l?=
 =?iso-8859-1?Q?JNzuJb8Kr7b9BpWwOKWqFN3v7U7Rr8wPoR1/nnHmolkAhNb3o7jS7gLm9r?=
 =?iso-8859-1?Q?MoCAGAzNX75Coztz5CRcw3L/fT2by3Y4HEr3VBDada6maKMgXGE7OUQPL4?=
 =?iso-8859-1?Q?Z9kN+aUvt7y1pvsUoYrz88PcIUL4I7qN1/uk3IWk8LdQ4IIyfJ90dG1k9L?=
 =?iso-8859-1?Q?LTNAb+PEkfG9kaJKWwVKuUItC5FnvAWal/CnxWvSP52LTA1OI/vezhX04g?=
 =?iso-8859-1?Q?WQm/B1Ds82SpkcgxjGFXYEmuaduAEVnvEwth9Z1TwICsm8VkyCH9Gv+IdT?=
 =?iso-8859-1?Q?zmOJZwnZKajumKclTyPoRwo1wYpGF1JwxW57+bluNjPywCcIwOMXBnYLED?=
 =?iso-8859-1?Q?8DLWatHUYF3ukdBy7qWBq54ePsIKJZdiej9w5RdaQ5YJN42XLRTB2XBKxb?=
 =?iso-8859-1?Q?BtGgtu8r0mjYhbJPbxIU/cMfJix5977pGoT85MNZaWd/SiijPl6HrSZ/P9?=
 =?iso-8859-1?Q?FlpTwbGbtzbW4GUgAMZaEETQQPkVp4kI1iCjO54m/IYrFkwJkqnNRfdBHQ?=
 =?iso-8859-1?Q?gJmsnOeWuYUltkIu/HJcdZAPeqfuSeGZR35/LB281r9E7Y3L0akt/2bH3+?=
 =?iso-8859-1?Q?N7VfrmQoOtcS+W3ye8Qi1WQdySP4O4OA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ADRoXxC/8WWJoeFHX6Gs8IhqkBCMxkC+0v8GNXK5zpukSPSsi9u9jq8Rnr?=
 =?iso-8859-1?Q?HDCQdoEaZYIFIEEl8iMPQB1MJOsjwcGJKhcRIqC6y6bCXoJfMFt+neLRLT?=
 =?iso-8859-1?Q?pH1c/DpV1qipayAbikx+8BjG19sKEqXmv7KIyy+fGZuGWjPX8ZwptrsfH7?=
 =?iso-8859-1?Q?M5lfdb97t+BsyUSklEEszkwNCcwbynczan5D3bOy4+DUc+iL2E086aqG0P?=
 =?iso-8859-1?Q?BAikSy/stwyuNREUI5PSizAxwsScY2mQmLwkO8SXs/MOXgZbc5j+gmTK3A?=
 =?iso-8859-1?Q?IxgA86Ij5vbpk6S5Ykri1DkZYlDiBHl2rEy7UQaObL8489FQZgdzjSsFFK?=
 =?iso-8859-1?Q?JAFUi3oJobr3uOXvPk627a27yuCuRyhuS2TbRzrIpHB2Fe/tmSoNo3IahA?=
 =?iso-8859-1?Q?4A03ugUpB/o1AM+YKLhEYhqcAWLQdF/bIVIC90zC7ec+WJyr8fgqlvD3sO?=
 =?iso-8859-1?Q?bSplutJ8dz3i2HDJBekAgFhCer4lwDdsgiLhUkLpR4l8oa/j3IfRYdhWS5?=
 =?iso-8859-1?Q?ybG3JSoZL9gmpH1+j7KBC74AIuQFkqJvTQhvf41t3i9+nCA6t+1I0bhygi?=
 =?iso-8859-1?Q?tErqHEibYlRYgOjFtqDeyOG78BN+2tWZjCFjU4d+6Oq3JBilOn84P7uPJg?=
 =?iso-8859-1?Q?oKe6bFQLSL7cqAzqFRF8/i1ysUJSOLBUc1zBgLCk1O9fNMtk2ZXrcaohoN?=
 =?iso-8859-1?Q?QylkpLCA81hSgYzs5G98rL+R10lqMMw9iWWF+UR6cU7i5EeJuS4Ee79+P9?=
 =?iso-8859-1?Q?HlAaq1hB8iXWibTEORDsoeHNtk1xQNpazh3pHdy8/RFTZQ+2ABJtr2te7O?=
 =?iso-8859-1?Q?Sm6tQ9PNNKeh4UwAqnBKhEY6dHds5PW3HA2tPpCpiCdLkv5RLmiCdPFjea?=
 =?iso-8859-1?Q?jMDXgdbhCpN7dElOUMD+AKifLkIN8Eiz66DMhbdlw7A4NbTP/+JVTzd2m1?=
 =?iso-8859-1?Q?ijNAnvaRwDzVYQAMiQbt0K+kWncMY6AYtq8cfs/PXNmL34xXyawXJYsK7I?=
 =?iso-8859-1?Q?WLsiqUxabnz9MX+CPLIubxxoBv3/U080iqQEFjWc6qzH4i/LGKuwOrggEh?=
 =?iso-8859-1?Q?onFgPTLZ4iTdEmUqD5hLPKZYehlTYKlZEkD2U/Fe33hp2N1JgCfrvjyOoo?=
 =?iso-8859-1?Q?yEjwHkm7SizsvssTwG9B7Ncx3bt6r2plKq29a/U9ubQw8kICzjcxLdQFwQ?=
 =?iso-8859-1?Q?x3gcFfeNamM5H46gF6Pee1EB1aw9h72ogjdOo7nzDGFPzdw1bprk3NkDxy?=
 =?iso-8859-1?Q?GvU4N0vnjORyeo58VELWFpzohP29SKtRtfPpS6NhaLLPTpyajC52Hyx9Yb?=
 =?iso-8859-1?Q?sU0ZFAlx3x5FmvvOtSrOabALpESsHw5tb8+h+oWOMa8t5kda/8jzFqEq86?=
 =?iso-8859-1?Q?JASsXYjcN9UORfXZkWrBHC2CNN6qW/h92Da/xWzHTjDRdv4w6az9INFB2f?=
 =?iso-8859-1?Q?FOjDMhxF8qsxfAQVf7UFg6Q9c4ZRjAtRA+2DYb2HvWx0URBJEzb28XRqnW?=
 =?iso-8859-1?Q?uEW6cppj7YJ5kcLkFSYd9+uj43yhgULvKZDb+ubmOE+q9P8BQvDfeCxm5W?=
 =?iso-8859-1?Q?RreggqDIIuy2Xz1DXqD/X6PRHoItWoftFPLvkMyKl/tPtYJ1dPyYR+220E?=
 =?iso-8859-1?Q?OIyjv4N6UkDZvYaFo939Q47brWo+u7UB3f?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5419.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88b3a16-516d-4542-fd1b-08dc653b38b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 15:20:20.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tC4sEKKcmxJ6ii7o6bsfem34YwF2R3gs7/7jJAudFj4KeH85aGtkFnUO4PzobOwOXxSxfeZ/lk+WDISxCuxM+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR17MB3720
X-Proofpoint-GUID: WhSVEohAI6JcmigTAqlJxu9d43nvbWM6
X-Proofpoint-ORIG-GUID: WhSVEohAI6JcmigTAqlJxu9d43nvbWM6

=0A=
This prevents use of a stale pointer if functions are called after=0A=
g_cleanup that shouldn't be. This doesn't fix any races, but converts=0A=
a possibly silent kernel memory corruption into an obvious NULL pointer=0A=
dereference report.=0A=
=0A=
Fixes: eb9fecb9e69b ("usb: gadget: f_uac2: split out audio core")=0A=
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>=0A=
---=0A=
v1: Split from https://lore.kernel.org/linux-usb/CO1PR17MB54190B898057616EE=
B3F9E51E10E2@CO1PR17MB5419.namprd17.prod.outlook.com/=0A=
=0A=
 drivers/usb/gadget/function/u_audio.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/fun=
ction/u_audio.c=0A=
index c8e8154c59f5..ec1dceb08729 100644=0A=
--- a/drivers/usb/gadget/function/u_audio.c=0A=
+++ b/drivers/usb/gadget/function/u_audio.c=0A=
@@ -1419,6 +1419,8 @@ void g_audio_cleanup(struct g_audio *g_audio)=0A=
 		return;=0A=
 =0A=
 	uac =3D g_audio->uac;=0A=
+	g_audio->uac =3D NULL;=0A=
+=0A=
 	card =3D uac->card;=0A=
 	if (card)=0A=
 		snd_card_free_when_closed(card);=0A=
-- =0A=
2.34.1=0A=
=0A=

