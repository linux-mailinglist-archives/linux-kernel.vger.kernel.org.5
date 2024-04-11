Return-Path: <linux-kernel+bounces-140303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E98A1276
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7651C2120F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CBE1474CA;
	Thu, 11 Apr 2024 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5xWKPg9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e/aUaN30"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64F146D79;
	Thu, 11 Apr 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833390; cv=fail; b=PWmvrHV7Yu4ZitguMS4S5KNx+3PPbqmMzkp2962T9FFTH8YX6vjo998XPa867G4XZNAwbSG13uLlNh/O0pjkuxkXh9ojeEpQkIZI2ic6iJqxWQDyNnDDVfGpvps5CefSh/vyUSZnz2vzWNJONnHyZuBlNLtbvg53gHNVTuFkwZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833390; c=relaxed/simple;
	bh=tMQsbvXuawsM3S+XWcIScm0kYl5bpF8nEb/dIfOI4i4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P08fwbvq2gcTPMFX/FwssmYpWsMKmqedm3HGtJk/BvJSAhZh5Sflh8IeZya3EU3vq9b6YPund+r/peBfQ8Q9nNosBQNc23A5t6TbtP+5Hoe8wHM9XBfJwJeLyjvD07U+GiwH0RNPlRF/iGewbR2VZR3g337TUXpDu1eXr9/3khI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H5xWKPg9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e/aUaN30; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43B91wFp002656;
	Thu, 11 Apr 2024 11:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=T83Xj24KnLdwzbEybs5gN3NKvWZCvqkHvRZKbsT9UiY=;
 b=H5xWKPg92OthA4QCJL8Y9s8vW6TNVu92pJdg7VNn6HT4855pN30OYM1U6XiLBdtZ29x8
 ZX8gleyyU8fYcXWXxlQdOKqs+IndMKTlpvkbc7S01X0pjYCY775SIJwvwKcT491Y6irC
 /oP2aqBpQsMVJ4VWL3Tn5XZCDbdiaBuiVmV3in+C6n5QkfhW4fhCF0d0ODqk5vqELtWx
 6dcFUJUOK9DhTdoL7/ur6IUHnt88m2Xj8sAqLeHVpJf+odRn2xjTF8upo3Zzh9UySmTO
 vsbYyUvKpv8huLBUFtKOTZAdH7wu56bieC/pDGUqUf7qq6z01AakHIHNWNDtzSHmpyto bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw029cwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 11:02:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43B9TAAS026448;
	Thu, 11 Apr 2024 11:02:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrsseysc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 11:02:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiYPXeiVN77PkiZZQHrPoq+gftldNw6SfFmW1WAayU4shcVC+reVV9o1sL4mGDtXyugK87I1GmTXx+I+wWvT0Xm9U+m9ivzZjOPdsUiIm1IXL808S3C1LorT347bgL49OCAXlI4vHBtVvPNlwhrGUwul0gjPAFCGFiPOMjKnlgVj1xRQv9dLRGgH2YAw6KxnCUbtSw89eAXd6KIAsRY2OW6ONpkDsrrb0Vh0DlK71+sMpnubFZOTwm2ClKQlKbvsSai5wmOX+5CYgaklZLepC3LiNZfjsS4Z2fYWfRJ0TixXo0s00ScJmLSh1DDEcwUlRUiBL1UndocTBtghoLul/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T83Xj24KnLdwzbEybs5gN3NKvWZCvqkHvRZKbsT9UiY=;
 b=i5MMRAoOj2E+fhjl9azdzGCvGjRbvXi06Z6cwVdm5asI4pjmxVMxeY66QdMH6tFbzjQSYePv4oa+ez8ZL7CCizhlC3yJeDU7uuBS+KVJWB3OlNrNcahcGQfxHofX659n7TdBTRRsovxtovR1XWxWJPIEoylHSV+mXUs3W8eJq1k1EG3KGXTkLF3MjZrBsotGEOb08g9bzr6qOxcL+pPCfSsTLURtbyZRQdLpHh1nD6F0+3gINouE1QIdCL852qzT0Jntdgh1UVkJ/SoRrdLZ5IfGfyXRPjpp1metd2voG9puaXBGGccg/56JfuG0TG/I1wh88TVOeFBOdW2uGDf37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T83Xj24KnLdwzbEybs5gN3NKvWZCvqkHvRZKbsT9UiY=;
 b=e/aUaN30sLzLW5GBrdz9+/vb57Ls8qp3enGT/E2ubuM0W1PVMo0ofB6QIr9n5BULvXrD7xaRYCz1Obq6g5xGObGyVkFfmAt3aHeDRHt0oop8NHJ5Wc1Runmv4qpjeJjXzc5G2p9LG3eSZpOB1UJdxz+r/BSrFYQ/VIAnuRawCBo=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:02:37 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 11:02:37 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 4/4] ACPI: processor: refactor acpi_processor_remove:
 isolate acpi_unmap_cpu under CONFIG_ACPI_HOTPLUG_CPU
Thread-Topic: [RFC PATCH 4/4] ACPI: processor: refactor acpi_processor_remove:
 isolate acpi_unmap_cpu under CONFIG_ACPI_HOTPLUG_CPU
Thread-Index: AQHaio+eWHoiqm80uEG8ucHr7P+8e7FhgYiAgAFo0gA=
Date: Thu, 11 Apr 2024 11:02:37 +0000
Message-ID: <25259BC7-8CDB-4714-AEDE-CFFD14986148@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
 <20240409150536.9933-5-miguel.luis@oracle.com>
 <20240410143101.00001f5a@Huawei.com>
In-Reply-To: <20240410143101.00001f5a@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|DS0PR10MB7174:EE_
x-ms-office365-filtering-correlation-id: 8562eb35-19ec-4879-0e32-08dc5a16e61b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ho9iLmgwlrrdeJP6LTePSDoHIBHz0JmrcFqG+DtQsBd/nYSOS78TeggQ4kneVjzpjJyE01L1a1XF2ZbHp1M9sHsSxHGNVhYKz3A7IajX5U8Z3I7/LWqsJatotv1STMUN50yFq7QJuCUBaJHH/alAjkOcVSGMjppKOwcSADRnGuUVLijLTjMeNirmKdchYNYhAXpjk4hCQCX/mflgFH/1XAxTTE53FtMamrlq3KIfuyzacwz23k1g8jUBjQagqB4LpfuqJbFSdJl0J8+suoV0uznYlcOKHskw8DwXam+PfvLu3SQ0jnXla+5XKoKuMjBBrI2Th0huC8xLr3ow6muIK6K6kNp4DFiN/U3I6kJpSFu4btC+tPZNEF1S1uigSBY51Suo4SK+Nf2oKFrr2yzCA3frsRT0dclXGv+qkET1Q72MHl22m8ANpeBfIuHvhhCOFtNkGzxCRPZ0kfCKPx7ljK0RmRsMeBdJQjDstXpAKnGBVB3SET318QXH4OySlxLL/Dskbn/+1mLR3r+hDHApqidhrXwqOGlV7GQHySO7NOrfPDy/auuEe3q/SrqQevL5Sg/NBdRtas9B55iPe6pgAKWV6jl/GsfRW5HMmZcl1EcI2oGQn6HizwnXP43HdUE7hEyqvmy8qQHTfm/t4T8Q+68bBC8UX8tpGlrW9G6ak/rUZMnebfcu6cbOB6z3GXoXWmetMWv2s72eOfgo7BMl5lv9wWM56l8puTqJsk85Z5Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?hP59epU5mGbkejuZbUVS0wpy+KcyJBKc1YQNcltZVAaq98rmFbvX6q+qP+7N?=
 =?us-ascii?Q?u6la38TvY1i5pL0KPQ4Y9azpkpPlS1sSy0MbqGYVa18hr5ezLZ+dB4a43B43?=
 =?us-ascii?Q?rWZkpDIA6JF101FhTue7ejiw9Jy/2hxNAs43Tr23rjXG9MD1zVwkZ+GCb8Vi?=
 =?us-ascii?Q?LW69E7KsTExqhhTamMfnMYLR1Zr1ObPVvDkSj3hXgxojFYwmYrnS7mDqx5oa?=
 =?us-ascii?Q?r5TOM0l1TmbH8YacObR2W0WUEq0tbILund9iVw9iWbvUZX8tsqBUY38vTqpU?=
 =?us-ascii?Q?DOEOAnS/aHPNWQPDk5y9aaWxf/rhYDBBrLDF6CGVkezUdeGPM80jLho/ueaD?=
 =?us-ascii?Q?cOjHZlIO3TB0hA0bPCJUrqbxwxlZe0EmVloxsDBAw5+Lgj3BBSxuwqYnY8iL?=
 =?us-ascii?Q?pwAu4yMb4YPIY476kXSY9vhPErXjlIiiwOfDRWIJmBmZ3vk5tlTvChjSFhwi?=
 =?us-ascii?Q?jV152YjcWP25IUz42yIk7/wHEuDEBozZDewsUP6vJtGERSdKp39LRYftdEZA?=
 =?us-ascii?Q?860mpBZvJrtPa5SfJOuexPDIjLeNHzmmXq4+k3qfU+SiAfMNpty5aPTyGB6E?=
 =?us-ascii?Q?6ZyqDg9MB0ULTGYUq4FgSTudRLYxR0l7JdSTC5K7y7ZoSS+TXtyh5V/2DNPq?=
 =?us-ascii?Q?HnzHzURwKIvqFKcCtAAqloJ8JIMRpRsyClKK9ze5M9parW45p2fUJNEgmwzR?=
 =?us-ascii?Q?frigV6lAkOX9LBHh+G++uvySJ3K47VY5oN1e7G2zrBRHGEN57OrRzWZVdZw+?=
 =?us-ascii?Q?qO3ud0wsbxGVjg+Dm/YOlLDMuhJaiIam4C7Gb7LK2YZDl+/0LtucHX1TzloV?=
 =?us-ascii?Q?kzb1PLmy02Cp84O6pR4a+KVXRGq9R5zW2dx9CAdWdKZ3pwD2fuMmSuWO9rt2?=
 =?us-ascii?Q?RqXB1l8Tnt4b+J8khoKe+UJ3dU6x5dNwBfmJUPE1hzkbJrATIC/hPis+hqNR?=
 =?us-ascii?Q?2ubHP1pqG7D9tFsSkd34Jg/PccJXfHQkiv6quHdAHw0K3yUrexG+RNVElCPH?=
 =?us-ascii?Q?qA2wFbAhnuF4lysYAn0RCoJJgfES8+Db1YowfxM+8qaHQEpokp3vMTXLdlQB?=
 =?us-ascii?Q?IstG53QcXSYP0K6gdoNsFASJrRPkTVutXStkP2g5pK1aVdmbyePjKcsqK4pd?=
 =?us-ascii?Q?WhUzBsipJHHDyWe4G+j4AS49RnYZGNIxCtvngLRtA3jqgkHwVD1wWnN8hBXL?=
 =?us-ascii?Q?wmP6OzbvJf1PFEik2USSw1Vwopmc5RH27ZSRMPaapwmdHgqhIMC7jR79fARY?=
 =?us-ascii?Q?oiY4u75N/iB9CkZ5vW2SKmYTJZ5KCP5MyPAYHOLgLCQJF/zbybhznCZ5PNWz?=
 =?us-ascii?Q?AoME5qDxK3fGRMHFKYiEjfKORc5K8cuPCV9rzcvLf+IU4jrrRiUTsdoA+StY?=
 =?us-ascii?Q?WG3iH3Hocx2aQW6DLwnaWRdHp2lICYpZ1SxTVSaN84Jci0J8XKeQl7TYjBOg?=
 =?us-ascii?Q?2XOzrbh4Zf/MoOwVdy3FAWIYVv/3oVd4LTaGcEUBHRyhjRD+GZsnbt1d8wN/?=
 =?us-ascii?Q?VAlX0sMb+5FbMDOkG+kSy2Dx/wH7zIj+qXb+S0aIHXL0j5AwdjipZBr8WOO+?=
 =?us-ascii?Q?66RemyXFLmP40+jRsH0M8PEaqBieKiPo0bypDl7dEeUvynDlZatCQhGUlxwc?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17906F31F50AD248B0FB2F258884B7F0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	T7/97ciLSjpUU/0VLz9Xm+FT07PYd1asfl88IqT4WPPe6iwqs7AsGjoSoOVR2yNHf91ekgw5wjJxEmjU1Mrt3pY0XGK0LtIJVf+jdVrDqoAclCIhOzPTWiVPPLxSvzaHHCKYrU6Fy9+vjALpncVRsbsKEc/utVcvU0FKfitH74pN4ppFkeLYUncOv2O2vKQTCQ3bVQ4JqJKEG8iBBMd69niIGA6sgNXkhVUSIZrGxyf70yj2RRaObuizyWVuMoCwQZQ+VaUzJ3su0bWQ3iAEHcxcfhFPoKEyn5N7bMphBGhNokEjKMVBgzidinKaGJSgDDK1QqT+NdOlR9EfnAD5Tjf3S054Xk2XmvU2mpIdnrsCBuWKewYixVZqdprmBc+t1fPbU5ZScTCSxFov2SVSO4ina4xKpL8NsPk23//avlh2OqfRLet4cuR5Dbt3wrZbeV0H2Js+io/kjlighbxK3qvbI7vufLGyL8z+iRKxXiUYg2vEXL0YhoU9BelM7INqZOLpHLXYcH5ZxANVO4ERhP5vCmlyPP8q6/55RMQAK/IyEpalcqQL6vCHwTr5hnpKcFpWQaBRxMRZKLp73RuQ2bJ7aT+W1vFCekYKNcvGX4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8562eb35-19ec-4879-0e32-08dc5a16e61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 11:02:37.5539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BnweWAk4Kis8yaq56mJCxsvaRO0jcGlhgzKYaoLRKTEbrF+ZTpj74O0hLfOBP0diQdIE53yfVvgvYnXOU2hYlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404110079
X-Proofpoint-ORIG-GUID: FXLpLYEXS8dUvruqUYWcqymVkyqY9uGl
X-Proofpoint-GUID: FXLpLYEXS8dUvruqUYWcqymVkyqY9uGl



> On 10 Apr 2024, at 13:31, Jonathan Cameron <Jonathan.Cameron@Huawei.com> =
wrote:
>=20
> On Tue,  9 Apr 2024 15:05:33 +0000
> Miguel Luis <miguel.luis@oracle.com> wrote:
>=20
>> acpi_unmap_cpu is architecture dependent. Isolate it.
>> The pre-processor guard for detach may now be restricted to
>> cpu unmap.
>>=20
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
> Again the why question isn't answered by the patch description.
>=20
> I assume this is to try and resolve the remove question of releasing
> resources that was outstanding on vCPU HP v4 series Russell posted.
>=20
> I've not looked as closely at the remove path as the add one yet, but
> my gut feeling is same issue applies.
> This code that runs in here should not be dependent on whether
> CONFIG_ACPI_HOTPLUG_CPU is enabled or not.

I agree.

>  What we do for the
> make disabled flow should not run a few of the steps in=20
> acpi_processor_remove() we should make that clear by calling
> a different function that doesn't have those steps.
>=20

Perhaps this got answered already elsewhere but is it OK for the detach han=
dler
to be out of CONFIG_ACPI_HOTPLUG_CPU ?

Miguel

>> ---
>> drivers/acpi/acpi_processor.c | 13 +++++++++----
>> 1 file changed, 9 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor=
c
>> index c6e2f64a056b..edcd6a8d4735 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -492,6 +492,14 @@ static int acpi_processor_add(struct acpi_device *d=
evice,
>> }
>>=20
>> #ifdef CONFIG_ACPI_HOTPLUG_CPU
>> +static void acpi_processor_hotunplug_unmap_cpu(struct acpi_processor *p=
r)
>> +{
>> + acpi_unmap_cpu(pr->id);
>> +}
>> +#else
>> +static void acpi_processor_hotunplug_unmap_cpu(struct acpi_processor *p=
r) {}
>> +#endif /* CONFIG_ACPI_HOTPLUG_CPU */
>> +
>> /* Removal */
>> static void acpi_processor_remove(struct acpi_device *device)
>> {
>> @@ -524,7 +532,7 @@ static void acpi_processor_remove(struct acpi_device=
 *device)
>>=20
>> /* Remove the CPU. */
>> arch_unregister_cpu(pr->id);
>> - acpi_unmap_cpu(pr->id);
>> + acpi_processor_hotunplug_unmap_cpu(pr);
>>=20
>> cpus_write_unlock();
>> cpu_maps_update_done();
>> @@ -535,7 +543,6 @@ static void acpi_processor_remove(struct acpi_device=
 *device)
>> free_cpumask_var(pr->throttling.shared_cpu_map);
>> kfree(pr);
>> }
>> -#endif /* CONFIG_ACPI_HOTPLUG_CPU */
>>=20
>> #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
>> bool __init processor_physically_present(acpi_handle handle)
>> @@ -660,9 +667,7 @@ static const struct acpi_device_id processor_device_=
ids[] =3D {
>> static struct acpi_scan_handler processor_handler =3D {
>> .ids =3D processor_device_ids,
>> .attach =3D acpi_processor_add,
>> -#ifdef CONFIG_ACPI_HOTPLUG_CPU
>> .detach =3D acpi_processor_remove,
>> -#endif
>> .hotplug =3D {
>> .enabled =3D true,
>> },
>=20
>=20


