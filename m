Return-Path: <linux-kernel+bounces-71419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF1585A4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681F028738F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68F3CF4F;
	Mon, 19 Feb 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E3Q7PDLi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dmL2ClLZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6500364A4;
	Mon, 19 Feb 2024 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349795; cv=fail; b=cmKOhRfLgmVwnuCsAaGRG3b1R/QmKeZaWC2W7k7ZzWCi0Pn5wSmoxsxfi46cjwAkmZ9JuGvRFJUA016BbPl2u3gcX4OR4zvpS/a74aRGZQoC7wcBXFAS4wD++EXeO7tKl0v9rHoWA/GcfC8Y0yrtYmKdzjvHVc1Cgvq/YoKAdlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349795; c=relaxed/simple;
	bh=7fgsTIDDdReDIg+uZTAUgiyDKQLyUmyCUhQ9JAJ4K6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSfckyXg0wRiHKuybZTmFggk9Vxmq04B+v1vPu+kgm2WxQvZ5tP50HLwqbH7PVvjA4lobRLeVNTVtGtBft/vRLm95MmWJqPCfmZZe3Qy6ORtvtZB4MkurBrNs1/wY6/VhiP33Dkn8j6yIGHK2AilLc6foIh1eoNRNOKO0HObQUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E3Q7PDLi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dmL2ClLZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8OBOD022536;
	Mon, 19 Feb 2024 13:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=DdU7JijCkgC6QRJ6Jo2sWT1BvaWjIEyPdzIa6VzsRoM=;
 b=E3Q7PDLiNndbn2GSspJEKbqTnd2DOiUJxxIuVxQe+cxo5KsfTbWntFIiq0IRH3DLmX4M
 sghwS63GPa6N6rfxwV8YE10xHzbfVNVGoAB+dTd5GP1quZAnbWq3LpRFYGZsSbkUj39s
 nDPisn/8HrySspNqFCrR+LCKRDoPwbJxqvdmFPTd6PTE5oBFw589+OZCXr/zVand57pO
 DQQVWHEMkhjiZ2S7KOGj9UeSHW1Xbc02yjYqnacjDNoq+A8r18huxXLRpaD5Uu8/UGlu
 zUn4KaJF9HwaQ9xeB8Wi1DtxdPovqJDAagZYLP2AySjqU5BiUacSIgcuGucPnMQb2IvI fQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdtv5wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:36:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCPB3n032054;
	Mon, 19 Feb 2024 13:36:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak85xbnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3aLV+0+5lSJABy9ZPZT0AkIYbGpxxDfRv2y6jAtRT6vY2dAdQvf8mWGdOEpPOMkpNiQSCrq7nSdRRcMqS3f3f//q0gs79sXgLOdY+DLmkSqXBsKLOexCPsjOjwdSasxnLtB/ZBdXEjDt7UPbzcrQj+yO/Kg1QyzA2mbRl+PErWA1rNd9Phjdv1gjUPEj+qHqJrPtI5HJ+GihWap5ZfsLEeTJbtTiPbSt6DeJ1+yLOnkTgbtyvfrH6/94hE3vr7IOIVE+MVV3MbI7TjMd/KfZf/yAqLl/DeAibAk0skxbuQ7+qwBAFX6v8WdvIf8Ylb3S3lEK/yq3ItbaCV2X+Uiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdU7JijCkgC6QRJ6Jo2sWT1BvaWjIEyPdzIa6VzsRoM=;
 b=Hc105SFBOe60b+1QZUKb2n1pqGmx+e1Y72UKUAliinG/SGef/XLTkLzLggvh7mhitvMHPDldO2mpPJAQRWYi62xNUSV7k6WS5hEFFa+AXIJjS2KmVF9B4ilLicPm0s6p1tZa1u5qqxkuKYa08bNF0WJJ2D1C+hds70VstBnqOmmyWbzvEqJeYEUsHEavE175oxgxwDvsqV+6Xm89Q7t511+ke6wVzMxYrGXSlfpxDszsxtfadqvZ5MKUhnUqv9i0+lSuQx49W51i3zzgwHkKjFbrP5i8bE5lHKv5ZrEpJGBS82ylnDEeOcFrukrtPVTIMbZqqKvvjW9rC3Ii9dirtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdU7JijCkgC6QRJ6Jo2sWT1BvaWjIEyPdzIa6VzsRoM=;
 b=dmL2ClLZGTeiyGmhbCK4Tg38pS3FswlsIDlswCQVOhRrlyqh1njUiKYDhG4Ds2AXDQtK+TcRscuAFYNTKp3Po1hJwiWotIXKoNKuqAjW4iTT7bIOC4RscbWr5chW5MxJioBpS7TUbvjsnZ/sOHBROU38SLu4bT/9yD7oGiEvQ64=
Received: from SA1PR10MB6445.namprd10.prod.outlook.com (2603:10b6:806:29d::6)
 by CH0PR10MB5226.namprd10.prod.outlook.com (2603:10b6:610:da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 13:36:19 +0000
Received: from SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219]) by SA1PR10MB6445.namprd10.prod.outlook.com
 ([fe80::f51a:7f6d:973d:c219%4]) with mapi id 15.20.7292.028; Mon, 19 Feb 2024
 13:36:19 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Praveen Kannoju <praveen.kannoju@oracle.com>,
        "j.vosburgh@gmail.com"
	<j.vosburgh@gmail.com>,
        "andy@greyhouse.net" <andy@greyhouse.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>
Subject: RE: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Thread-Topic: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Thread-Index: AQHaYyc9prnjnr7/fEC6BGCnYCMZr7ERqlCA
Date: Mon, 19 Feb 2024 13:36:19 +0000
Message-ID: 
 <SA1PR10MB6445815647A6B49195E417878C512@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240219113140.4308-1-praveen.kannoju@oracle.com>
In-Reply-To: <20240219113140.4308-1-praveen.kannoju@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB6445:EE_|CH0PR10MB5226:EE_
x-ms-office365-filtering-correlation-id: d492ccae-16f7-4d1c-2324-08dc314fc154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KXhsFrZIzxCrwNKJ4flApNXYZ1n0oS07hwGi/kJjzm7LwJiVlRrdj/aR2WXmVqicdWQ8iWj3aZ3/ugkz49dVVTLF43cF+J3yLbTXxBCEx+9nH270iKAyblwJSjSBpCfb0Ry/qtrCnYKMJFK4+hlrQYM/KFmxS3exmkNeaQwoY2mtK3igYaLr/DP+Rq6JltkS+gcSMRn5Loumh+VqjFEXa/pfdQkbopMaY9cAEM7rQ1MX7NVDrHWRYByVc74IpgNpON+CZ2i9q6ORfoTzJ8qnesQGTaH9OcO7458yM3V4dZdaLvn/0tuKqstQ3AZ0TnnS9jqltm+/6TmRHXscZ1K6veyJU64XH0bmz6xq1Jz/48oGs0zZuJTmz7EGUwv+4BnwS5LGU09SSuqc7TKw3/mLvOedVeVdBZPMkuokfHQuz1+bqKnipyG9eoDED+Nts2L6rDmk0MC/n58UMheV8cCbDm2xAgzKbSTDymOgPPhJxfeE4Kov92Ssa0rVQwGPtOQ60B/UBSUjbyjni1fzJoHFR+EilbJlfisB8mDkPS5ebNBF25KrUsuiRc5BPUwppIy5hUzJ4iN1MDGb6cKglO332FCN+TwtIJb8+vq6nG5Lq7A+qdavSJXwIU7iVgZqSy9L
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6445.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sCBxgGxHVOrVjhA0r+X/RLxvOeY/wJzpBJCtYyhr5uzsmGPsICO9XKTYdF3b?=
 =?us-ascii?Q?XoGPeXLmvDSq8r/TXUyW0hGpA5LDdnw6a1sxufAYDm1ZWkolJMgnvlWI3V9P?=
 =?us-ascii?Q?ehQS2KuS8PqjDGMSYM1wD6qcS2G9Bkcy0bj0RqVD2MYJ0qGFU3C2DL88sUW9?=
 =?us-ascii?Q?UrBlDVDrlgrnD/a0ux1C1/5IeOBabAkd2OW7nNZZGax91zKWp9mp+kOSU4uh?=
 =?us-ascii?Q?Fn/Uimd33bh20V2C3MXOAcMQgRE/EuX8HRCMtQZNjWt1aZxYGxeYkyFDvM7m?=
 =?us-ascii?Q?Ym0GBCie/+i5Je/eUpLA4GGgkk68euo2DBDwXlvB3IBEXCGrpILM8e99TMXY?=
 =?us-ascii?Q?afqM6B2HFsG6b7Ch0f0NcgTk11rXYv/1mYyxjSb92UCQU2+b0NnrCdm0IGeA?=
 =?us-ascii?Q?S3UfsrKA4HEShc/YkTNvNViJLP9XnXn7HdOmXcisQ9kkn7VnSApysGn1VKNs?=
 =?us-ascii?Q?37TZugaLLlmmx8EH8rZ+XT2+kZS/NYA1UBaWg/HcB943AFRbNn9xGMCkPNiq?=
 =?us-ascii?Q?sKcyyjSuyDDgtsIE3x8A8ejvhQ7Hn5YQOTu4rBFIWXjqB/EUvhsJryy9ZK/h?=
 =?us-ascii?Q?3enPgR0KPW9wg1uo0YdSyBYhH5mJoqF49/g4MVV2W1YsQpHJoq/+SkNM6KhM?=
 =?us-ascii?Q?DQSt/yToiNvINdZmFMRIXKxdjqgW0EVTQI/xYy9T78V7VgEGHptFxxfEiKWg?=
 =?us-ascii?Q?gywPXzUfp59rDQcWinoQhzqXi0edmoAjc5P5A7Oy20AgV6Zc/WWlWuae9V7I?=
 =?us-ascii?Q?XrUPdP3/OIPPu4VHvQwHSQEtGDzQmjwpQFOwSXhw5GgIJ75p9Hl1TDSzqoqt?=
 =?us-ascii?Q?Se8mntX+bmfmUijD6Bj6i3OEUBHyxLyvlIheQuMN8GtGIFN9nSjQ1274riBi?=
 =?us-ascii?Q?Y/tAvZ5t+B5RZpRrHjkRYldN9F19ce8aXzLwvmzG9YAKc0YGJzTbWdX2Rzlx?=
 =?us-ascii?Q?JNrStPomaUVQPEprHY1tjVAif3XZZxo4ULTDO+4S4mpZpRoe1jpeBkptZcHs?=
 =?us-ascii?Q?pK+fZvNryuTJq8aBom1cWhgq019nHL5IvxzPhT0gTfUpGWB5X551fXS0eVX2?=
 =?us-ascii?Q?lxNkjqriWjD83K8n9CyUJH4pv3rTpFxx1A8cGLhpWR/YBYUoKHV5sdMz/5Kg?=
 =?us-ascii?Q?ebqnlHcKlQRbDvb8x2oNUKCKetRcWyFShj0thHaRB/Lzmp7oxLaR7zOSQZ44?=
 =?us-ascii?Q?MAE1YY4Pu2XHqbBHR51cJd17Wj4ZTa3yPFLYmEbGhKhYw49n26qqcAwND2yC?=
 =?us-ascii?Q?m6uT1UlK5BdDnt8rJ3cynKvbxlkKe8ou1BfUmh0KVYhweAC08PDbEEi5JL0c?=
 =?us-ascii?Q?CNbpLm+j3MorIceUQzvnaRHqLO4vfKT+MiiWdiqF9X2vPdPzYRBYnpAfDflZ?=
 =?us-ascii?Q?ApaLMtVm1Mg1UviqmdjcU0Lv5OQGruX7X6ycKfVFIw7r3Ht6KS2kOYoZ2EoC?=
 =?us-ascii?Q?Fx+lqxSd1LSxkVO+XwmFOjHjPKq/udXPY3tm9CkQNmCHY3KcJGsFlXsK7fqw?=
 =?us-ascii?Q?hGk7tzDtpGvnEcj3jz9jQUaTZYEhuCkYdjsmP+FPdOZrVICVK1U3m5Pi4uCv?=
 =?us-ascii?Q?QE7Zbigp+TJVNhyH9o5SzNfpuVEMXi+WQceQLa43Z+pJQw5BEa/T4yEZeTgs?=
 =?us-ascii?Q?WA=3D=3D?=
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
	DseUesyFCuoGUqBhv0wyfYPfea47rXj4b7BTlmQnO5cxHxZxeQgFKDIC0o97COullS1n4ieH6f7RsLIgWddidypFw5pkNLBOoqXIUd9yxLWhTMOT4VTUutYww2TaWXU0uDsA399/7v01e8scTwvV9nzjEmTSljgTt87rzNH2D7FFeMSjBWHKjypsYCJsfEQ6udvZ1/JToGwHNUS0GNJOJgVmtIdTRgg2S+a2m4H148UTo/lZFrfUb2oWl4pDTW9GPLEzKxRqK/h8tBZnXYPlGVT4eaJdzupjWxHRqlkanwRFT50xKcFiRiRYBkCGAKig1s0prMCb90mUcVfEpMICINYg7O+Xy0lIpUdETulkvlidcfQijzL91bTTjlgGsNNg3zH3uIBQKQRz+CikRuIDZ+Z4a/gD8Bwap11gwgbMGYxetwO5CtokevM3aDH+L1iHdWEcsTQFcstVz9f1IeIuVBf+GwDMwQ/6X6r4KTdRo5HlM4lXn+FyEkHwxY2ZxYC8bzVHHWA9IGWb4xa6Ybyj8KKk+nunwqUkri7r0FcjDMcZwX5Y7m5zQSeUMKATe5r8+MngfyBPoCr1Zb2C/G6Qy16Bn2VmNQDIc8b2LGCL/mo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6445.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d492ccae-16f7-4d1c-2324-08dc314fc154
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 13:36:19.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nW2ikbZlMSVL6dV4N4N349d+5+mpLF3FCWdcMJpIv5nPtdEb+bh49+oLNWqWYYgoxxtZxUahX7km33Zxhn0RLmRF+lRW3nUzVBCb91lqGF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402190101
X-Proofpoint-GUID: 8ERXqgyZ4tHxzmkWo9Yx9NJozsRfL8WB
X-Proofpoint-ORIG-GUID: 8ERXqgyZ4tHxzmkWo9Yx9NJozsRfL8WB

Hi,
I've forgot to remove RFC in the subject line. Will remove it and re-send a=
nother copy.

-
Praveen.
> -----Original Message-----
> From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> Sent: 19 February 2024 05:02 PM
> To: j.vosburgh@gmail.com; andy@greyhouse.net; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>; R=
ama Nichanamatlu
> <rama.nichanamatlu@oracle.com>; Manjunath Patil <manjunath.b.patil@oracle=
com>; Praveen Kannoju
> <praveen.kannoju@oracle.com>
> Subject: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
>=20
> Through the routine bond_mii_monitor(), bonding driver inspects and commi=
ts the slave state changes. During the times when slave
> state change and failure in aqcuiring rtnl lock happen at the same time, =
the routine bond_mii_monitor() reschedules itself to come
> around after 1 msec to commit the new state.
>=20
> During this, it executes the routine bond_miimon_inspect() to re-inspect =
the state chane and prints the corresponding slave state on
> to the console. Hence we do see a message at every 1 msec till the rtnl l=
ock is acquired and state chage is committed.
>=20
> This patch doesn't change how bond functions. It only simply limits this =
kind of log flood.
>=20
> v2: Use exising net_ratelimit() instead of introducing new rate-limit par=
ameter.
>=20
> v3: Commit message is modified to provide summary of the issue, because o=
f which rate-limiting the bonding driver messages is
> needed.
>=20
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
>  drivers/net/bonding/bond_main.c | 36 ++++++++++++++++++++---------------=
-
>  1 file changed, 20 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c index 4e0600c..e92eba1 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2610,12 +2610,13 @@ static int bond_miimon_inspect(struct bonding *bo=
nd)
>  			commit++;
>  			slave->delay =3D bond->params.downdelay;
>  			if (slave->delay) {
> -				slave_info(bond->dev, slave->dev, "link status down for %sinterface,=
 disabling it in %d ms\n",
> -					   (BOND_MODE(bond) =3D=3D
> -					    BOND_MODE_ACTIVEBACKUP) ?
> -					    (bond_is_active_slave(slave) ?
> -					     "active " : "backup ") : "",
> -					   bond->params.downdelay * bond->params.miimon);
> +				if (net_ratelimit())
> +					slave_info(bond->dev, slave->dev, "link status down for %sinterface=
, disabling it in %d ms\n",
> +						   (BOND_MODE(bond) =3D=3D
> +						   BOND_MODE_ACTIVEBACKUP) ?
> +						   (bond_is_active_slave(slave) ?
> +						   "active " : "backup ") : "",
> +						   bond->params.downdelay * bond->params.miimon);
>  			}
>  			fallthrough;
>  		case BOND_LINK_FAIL:
> @@ -2623,9 +2624,10 @@ static int bond_miimon_inspect(struct bonding *bon=
d)
>  				/* recovered before downdelay expired */
>  				bond_propose_link_state(slave, BOND_LINK_UP);
>  				slave->last_link_up =3D jiffies;
> -				slave_info(bond->dev, slave->dev, "link status up again after %d ms\=
n",
> -					   (bond->params.downdelay - slave->delay) *
> -					   bond->params.miimon);
> +				if (net_ratelimit())
> +					slave_info(bond->dev, slave->dev, "link status up again after %d ms=
\n",
> +						   (bond->params.downdelay - slave->delay) *
> +						   bond->params.miimon);
>  				commit++;
>  				continue;
>  			}
> @@ -2648,18 +2650,20 @@ static int bond_miimon_inspect(struct bonding *bo=
nd)
>  			slave->delay =3D bond->params.updelay;
>=20
>  			if (slave->delay) {
> -				slave_info(bond->dev, slave->dev, "link status up, enabling it in %d=
 ms\n",
> -					   ignore_updelay ? 0 :
> -					   bond->params.updelay *
> -					   bond->params.miimon);
> +				if (net_ratelimit())
> +					slave_info(bond->dev, slave->dev, "link status up, enabling it in %=
d ms\n",
> +						   ignore_updelay ? 0 :
> +						   bond->params.updelay *
> +						   bond->params.miimon);
>  			}
>  			fallthrough;
>  		case BOND_LINK_BACK:
>  			if (!link_state) {
>  				bond_propose_link_state(slave, BOND_LINK_DOWN);
> -				slave_info(bond->dev, slave->dev, "link status down again after %d m=
s\n",
> -					   (bond->params.updelay - slave->delay) *
> -					   bond->params.miimon);
> +				if (net_ratelimit())
> +					slave_info(bond->dev, slave->dev, "link status down again after %d =
ms\n",
> +						   (bond->params.updelay - slave->delay) *
> +						   bond->params.miimon);
>  				commit++;
>  				continue;
>  			}
> --
> 1.8.3.1


