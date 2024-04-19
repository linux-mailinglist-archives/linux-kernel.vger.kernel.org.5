Return-Path: <linux-kernel+bounces-151157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D3E8AAA02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8BF1C20EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69F52F7D;
	Fri, 19 Apr 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YfWiQtEy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V7TkGgrI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7814E1DC;
	Fri, 19 Apr 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515006; cv=fail; b=iasaE+dcack5g8uGnTbQuHvr1F7GnrGVx4VZOpseTi5FnZ8nNeLcHaDa78NNbeWLbeBw6VSPG03NJRzX3E306dP3KSvqD+/abQSyKcq36sR2YVTOpW6wsPMt/QeJYqP+EoYYNCk5O/zwqzBfwoAkxYmpAQB0YAWJGk0ZKn0VvDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515006; c=relaxed/simple;
	bh=idfeOgsgtgwMYuIU0q/FufmUIPava+s96Y3ArKmZJCU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oOPhJjL7URfNnt2A1Vwm/6KYl39f3havX/2snIhWcHn/9PwIQ9uTNJ7G0Gld+0JJG42kgkYEEUylTvcL7v6OregQg8dVtVRY+Uvv55/3dPVe9ANYClVhgcKev203730/ok93rDFi9AjdOhKdzHsARrUytkXqRqIP2m69G9V+Gzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YfWiQtEy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V7TkGgrI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43J7jqVZ024854;
	Fri, 19 Apr 2024 08:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=PAFX66Kho9G9WHDMxxQ8kNv3BDsJBSEUF78+Rj8cnz4=;
 b=YfWiQtEyxuSrD2tBh7zormzmGmdlpDNlhLV3AMn2HtRIpplWqb9lai2hwOQiN/5suLZZ
 pEWkCX37AICIvdD5K2sLStf2n2DNAlop5CR7VCLp0Oi5dCZr1eUE/wpFdpUIGRGM6hY2
 Twklcu3gtBlmLDTcpK+70yoJUpqRfbHF86ZzrF7rU3jBsqgN0Yc6ksXHL2AnNNBofGdA
 obsYTianWhHwTdRhjjQIS1iBih8dRMPoMN8q3e970vEUx2Ud5skDqp+mxctWu1WWNTSX
 +TSgD3bEnY+mXdH7cIgIrjZA5B7LE6wOORcSC8lzKgFcF/xu4uPeWyVUUJZ+vH3ZxSnu Xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujvf65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 08:23:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43J6jdqh016794;
	Fri, 19 Apr 2024 08:23:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xkbjbsa0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 08:23:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exSYtUnuHfQslG2nM4ugBTEZ+GKkxZwarbuqYdLc+kmLbqQ00xQXz45nHeVhIGNdmKEwW2F29xy8606jszh1kOzJwQiR/X9EUovR/oaHTFkFkLWvyRjK+nNtuuV+YvsyGqXO/7GKRhDJIWURkD703NLatp9B6NLzTR5m0wla5PrIppWMdeYJXWLJ+qkJ7jpkiCefPGmAJ4dZHD5YFqwKBf9ZU+WCSYLaaaLSgCu+6GM7kxOozrGvYgmtb1S8jwV5Yp260hkI4+DfcAxtWfav91nkyopsqVGotDDkheWCvjqjJVoiRXn4gIHE/bsaOF8gz1xiNlrQVKxlJ9uMBJUGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAFX66Kho9G9WHDMxxQ8kNv3BDsJBSEUF78+Rj8cnz4=;
 b=c1/3cl8umnYnLUSVzBipGbMcVjbPVfc2p3slpc0H//X8MwtQ7VWGOoO0qyzBHvrsopUz5ORzll3bmJpZ+rIvS9S7hOYYskPlHFC0r7+YNaTYNTBfz1HFq16UwLVMuzaatORKDJzGh3vYebfN1zrJ2L8tBK2EfM77vV2nUDDTZHa+StsIWstMdqMbSlrWo+1JiINC2BQGugQodsax7mfLkosA3ku65tF+zgYCIlQfKQk9+GIhpT03EZh3x82XFeLrC3Jx7t8fF76FRoZUVZWY5MGbROWY+mdO8nEY8ImLH+SDTT4OV493Mf93HyQkVYroP+XkcLw6Wvt6eltgP2bX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAFX66Kho9G9WHDMxxQ8kNv3BDsJBSEUF78+Rj8cnz4=;
 b=V7TkGgrIsM2T6m/uL0iGhHONekuaaZO9XE7n/86tS3EoEjFnk/EpRq3xq9mEzCnezDKfoY7i7WHrR1rMw3bmZz08CMEZCr1v3UmaNINOc4PQW+rKktPHx97zqcjt2p0wYDW9YlEr1/3MzPuYkdG5Mig7hJfQdqfelN6RSKgGInI=
Received: from DM6PR10MB2810.namprd10.prod.outlook.com (2603:10b6:5:71::18) by
 SA2PR10MB4411.namprd10.prod.outlook.com (2603:10b6:806:116::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.42; Fri, 19 Apr 2024 08:23:17 +0000
Received: from DM6PR10MB2810.namprd10.prod.outlook.com
 ([fe80::639f:6c93:12d3:cd5c]) by DM6PR10MB2810.namprd10.prod.outlook.com
 ([fe80::639f:6c93:12d3:cd5c%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 08:23:17 +0000
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
Thread-Index: AQHakYflavlUUMfH9kOorpGL09z+TLFt9pSAgAAI2ACAAAH5AIABQSkA
Date: Fri, 19 Apr 2024 08:23:17 +0000
Message-ID: <1263c5636be781504b91809a98760001247d0346.camel@oracle.com>
References: <2024041738-CVE-2024-26920-a681@gregkh>
	 <6fa1eb4368cbaa2d0b243539f1d91692da95e117.camel@oracle.com>
	 <2024041805-rippling-entourage-1a72@gregkh>
	 <92ec3ce16c7e640de19b44165e2bb88b63dd2478.camel@oracle.com>
	 <2024041811-freeing-licking-bd94@gregkh>
In-Reply-To: <2024041811-freeing-licking-bd94@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB2810:EE_|SA2PR10MB4411:EE_
x-ms-office365-filtering-correlation-id: 25ba818e-7fd0-40a2-4095-08dc6049f6eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DicFQRWV3mPXlkFxpcwlOUCqoPoi2N8MIFXyXMHPOWoFucTcdIeXFoJnYt34MCtg+01SKWLWC2TExc2PwUsGvb5d804Uo7dgyudHXiqdfrnIz+HT0m8TW+aUoS1J1GjblFydXGTHnCMY6mJ0yiQqD0OH6eGlGvec2tMbb2q4WKDEt5DZLxdYY/gL43eHJQL564zSQmSuuWzXO24U4v0P3De0kBvwu1SoxU1aY7INHt+vBWBz+u4E0/4gNFYH0flHByZLJvsI1ES5nY24SMSjcHN7GqPJoLXS/0tC7vz8bguFAaeqsAZ3PGbp2ltKNbKnd8UWDe1KFoUWCJELqW5lzSPtYQingt/TBqZR0sbXZql8ewBWMCCI0dsK1m38fRn59q++dv0Ox9In1hlzlduiShd1cio0Xd2pes9V+YkgEods7F9xihFFymKfEteB8IxPigj+ft4a867j7lBKaskUU6Zx32LeFPLOuNPWeQ0YdGzo5tTOZawrLws359QBIcF3VTmCluQVZUdAMWvHQM8zlk9wJHtImaHrhzX35OSuVh35cZAs6lsx+xfPzNvNmeQDOFbxYIxDOGcBR2lMlb3TI8s8MtWmNaQ3pGqteKg8VdtxDjckXrn3lpFCrU2feV8/h3umKhNVx5jlXTDhgjV02n8FMIYWiRCEqZ3tC+dTHQDIt3kkZVqdsDoZYonMtSfac/jQok2tIFMw0Ry/YIuw5A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eEdFeUxKTUNlVWRrRnY5MFEwdGVUajJsZyt0blV4cVIyVXFZWEphL2RhejVX?=
 =?utf-8?B?SHNmTVJKbVVBdU0xV1BZUUdXMDZNT1I0M3lCZ3RxQWc1eVBtZTNzYnhjcmJu?=
 =?utf-8?B?dEN4ZWx0VnpWb3JXcDg3QUxVaEJ0OElLcUl0enpVU3NmRVgyTms5TnNtSXNz?=
 =?utf-8?B?TFVWSUtKTzI5ZjlYSTJpeWtoNjNaUkFLanFsQXpoYzFyTk1yL2lIYzJxM3VS?=
 =?utf-8?B?WEhYQ2ZjT3cwVTlaTW81SmdrcUF0WWtTL2NkTTYwTnZUL241NTBpSm9zRGNE?=
 =?utf-8?B?UWd2dFBTUWovTDdvWVUydGdiUTlYTjZqTTFoVEtrY0RvZ3JEa2Q0YmduWGxS?=
 =?utf-8?B?dmJQOWlsOHRPaEk5L0tFWXdIdjh2Z0RqT3Q3RkJEZTdYZlFuNFJXa1pMOEJl?=
 =?utf-8?B?VzBmNURZNFRjTVdzeENlTnp0ZGlUL01YOGZkanZZT2V4LzF2WlJkQ1ZqNEIv?=
 =?utf-8?B?WVM0OGVGanRaWm9FWTZpZFk3Mm1nOGE4WnZYdGxUNHZ2Y0Mrb0thMFlzVUhs?=
 =?utf-8?B?K0k3bDhHcWQ1b2FFWHFTVGpENW1SZjJ3WjB5QU1DUDBYSjRmd244QmtXaHV5?=
 =?utf-8?B?SXNPMWFwSFhjK01hZWNXZFBaMXBRL1NXVWtxblpvNnFlZ3pZdVZXUlJ6d2hk?=
 =?utf-8?B?U0tkZVBhQXd4aWQvaVlkNUtQQnVVc1JRdVZhMUYwelpOVkNYQXl6S1FuN1hO?=
 =?utf-8?B?RWloRFlHOEtwZERjNStLYXJWMXdoZmY0WGduZVIvb1ZCcHBVajBjcmU4VzI3?=
 =?utf-8?B?L3p0WFJNT0ZmdnFzb1dSVmZNZ3BjcTE5VzBKdWduWDRSejlTTGRPN09QNVh1?=
 =?utf-8?B?bFg2OGU3K1hJVmJZQXE5cU1pRk1NQ2k4OGsrazB1ditYc0NLUDdkNDl5WEdy?=
 =?utf-8?B?VTh1TkM5OGRNd3NkcGlTVkpEVnhjQzh3ekE3VnJkVUo2RmhkR1ZHVmZqMnRi?=
 =?utf-8?B?M3dlUSt4Y1pNK2N3MndvKzIwT2o1QnJXb3dET1pKK2V1Yk5MYWcvTXZZRTBJ?=
 =?utf-8?B?UW5zNW9wWUd1eEkyQWdVYmlWVHVZTDFRK0FtL0ZIMEd5dUlaTjE0YURtL2xQ?=
 =?utf-8?B?UHJoMFJnVUFZNGhTNXpsRTJGTDVKcDkrQ1RSSm9ybmRRT0FmYno1UkM4WUNP?=
 =?utf-8?B?Q2UrNDdBNlU3TVVLeExpL0pmWmEwblJ3YmRmNkMyMjdyZnBlaDE1RWFLS3E3?=
 =?utf-8?B?UjlsbEJrRkkyK3hJQzZxWStmYTNxdTZYeGNvRmVBaGozaDdVM04xMnpRci9R?=
 =?utf-8?B?RUNycXBYR0FiZ1Rnb1AxeGFJYldLN0MrMUY3Q0s2TThoVFREUjhRNnprMTZi?=
 =?utf-8?B?ajFaRnZQYldTK080cXlNejMzTURwaHd1Q0VFQWdTVUMxc0RSL0wxU0V1VFpt?=
 =?utf-8?B?dktMaTBqajdxWmRPdWlJLzF0dVUwSjIza2ZuTDNUV1AwaW9UdWI5Z1VocG5H?=
 =?utf-8?B?cjBLb0czN3YxUnBiY2FFLzd3dWRJeW1naXZhUFBkS0ZNd2dLQ0xPbURJZmtM?=
 =?utf-8?B?YlEzMEpJNnlEUnBvR1Qwbk1wMW5EUlpvNmMrZzBEeEx5bVpXcjNyQ2JtQ0ow?=
 =?utf-8?B?dXp0aGdFeitWeTkwM01GMWFpdEZYc24vVlVPTlQxUGRRQXVqSUE1Z0lFYUlj?=
 =?utf-8?B?RmZCeFk2djY5T3B0cjRiN2pjelQ3T2hiQ1VFL200aXZBUTFBUWFmOXd0Mk5t?=
 =?utf-8?B?TjU1c2FMQjNtVldhNTdsMFp6TEdRV2JwNWJTYWdJLzlidTBWQ3FVMmFZZExS?=
 =?utf-8?B?Rzk3a08ydWNiVXFHOVhOanVURFcwNUlyV2ZteW03VnBrQUdkaDVacE84NjE3?=
 =?utf-8?B?eHhRSkRZSnNHVC96N09kUUdEV0d4SXNVaDlTajRRdm1vUEFnUGVRSERqd0ND?=
 =?utf-8?B?SmJvNlUyamZSb3FOenkweHBITkN0Uk5JOTZXN3o0eStsblF0cTdtVytJMVph?=
 =?utf-8?B?SWZsTDU4ZHRxM2RkMjllbUFHWldieDJ0SEVpaWJiSGhrUEw3QjI0c05XOUVC?=
 =?utf-8?B?VXN4dkF4blMvNG5xVTVyRWE0UU40R0QwUDF5QllxTjR1MFFGSHM3K1VMVXVB?=
 =?utf-8?B?ajkzQXd6blR5ZDJxbWtvaXVBS2FBNEYrU0YycjB1RjNZUXliVG1Cd3hrekNB?=
 =?utf-8?B?b2VqREU3RUM5TWNTSVA4UlBpL3pHZ05XaEI0bTJxTnBJTjU2QnFOUXQzUk1q?=
 =?utf-8?Q?+DmDspFQJgjrUItZkRXXLPC0vldqsEVDBsx+eykeAgY0?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-clqxbzT3PEY1e8wsTu5i"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0dYtPB3IglVru5dfaSoSXW24nGmqL39gVn1YblnuRTf+b27tqz+Vb7y/t/adUjqMXhk9TLci3lzMGrqkLfe6lO5+HKo2MPi7CK7mRUPSVvt30Brq21G88TuY4sTWWLyeMz8Bu4er3yu0zt1SLSriOHRXYbCAO7HLFnpAiybYCNSznOKq7+HsYPqdICpygbfqMWT2tkjrtvxVi3dpW9ZqhnJ3iSPfipS9RvkOCKR1qRtOq8zR4cvHrkOlEYSFL9CG4jwtSL5ojieXxmhhxI1dI9gWEN1JXtnBFqx2XMhKSFcDKS9S0jCXfVCWZr9llDF7x5UXABUloTuL+VBUXparXnNujGQCH5lApOpHjq1PtLlwpr08kc/v5Ydd16o25laQ0cak8g4k7jDl8iPkvy0DyGoa7+/kr79ODBv0XibRurMYveBDa8qQ5HTPFH9wEPM0AQ9IAhx8Nap+oKXoJ3/o3QEaxwr4ObrfzQlUHSolpqottsIjf4kCOSuTuW4NeB5ZwD4zFdFWhLv8u9P7k9dRJrRbKX3PvsRLnrvyZqoL2bpl3sktNAbJMv9WJOXzZV5tsppcVpB1nh4Oy6RW2vv1ETkxhgPk1Ju1lxWNolTQFrQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ba818e-7fd0-40a2-4095-08dc6049f6eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 08:23:17.0815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e69kN7MXE4NHuFCxX/hA73RseJ/oUVKgHN5d7yDwMaxQitHwgQeZvABuQX2E+dLSapyUv7L3DAEJ0Q8sK5JhzWBhteUeXkFwvlHvwF2PA7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190061
X-Proofpoint-ORIG-GUID: 8v-s-OHsu3TXq39735M86ua9QxoAiXNJ
X-Proofpoint-GUID: 8v-s-OHsu3TXq39735M86ua9QxoAiXNJ

--=-clqxbzT3PEY1e8wsTu5i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18 2024 at 15:13:40 +0200, gregkh@linuxfoundation.org
wrote:
> > > Should we just take that patch instead?
> >=20
> > The series in which the patch is posted is here:
> > [...]
> >=20
> > Seems like some good tracing subsystem refactoring. So if I understand
> > Documentation/process/stable-kernel-rules.rst correctly, I would say we
> > should not.
>=20
> So the documentation on the commit here is wrong (i.e. wrong Fixes:
> tag?)  If so, that needs to be said somewhere...

Yes, the Fixes tag seems to be wrong.

Thanks,
Siddh

--=-clqxbzT3PEY1e8wsTu5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmYiKesACgkQBwq/MEwk
8ioT/BAAq4EtIZWkKo7m94HQhjcrRlP3RqRYNLbHoWv9MYlbA0MvZ9+WpOoF+U1z
OxPMfCqnQq/MBVwbHU5DYh9VaCx0aJ0TmV3ugA8Gw6WnmeBwVupEwXWL9cwwZmTY
iNx39ANOCTrro/2kqQiUiDWu1dbqhTgyWlfAcUMOE/McRlcqt1Apx1B3YCgVKSPq
IdTVsfjfWnu36o8jHdOmEWWI2bFA/tMbk/Zapp1Z9CmUKw4lcoisR9n3PQnZaqp4
nhp77eTCWneg4VSaV5TEZQgfhJD6HQiUP6jwl6ZEbKCmgVvVdwINuCvoEKIIumo/
ByqiZolYurjEuIBo6bWLddlfS43YE6XhlNSW89wqDxVsp9+N00nf/FQP143BwMOo
C6ndFcjB4qEMI24zpHVZyWmWBwLbPQsLKZpTGSuND6yXZYl/91IZY39VmxCGjTVc
aOpWfVJdt+wdLuB7s2mYZYg+AezMLNtqN7FKhlgZ05W4HO/5KS44SJ545NtWLNfP
12PSZbEb/iFzvufx3JYstY5R9VT/1xOa5vn2zzDHS8T1o3st82FsvPsg47tsJwBd
v3K3UtJNGba5qiG5XcxJE0elE8X41SP380eoR9F2rLvI0emkGU1g9l+xVclHPt55
Ng7aA98LtjTIW+TNEj3OovZGaP11YaJdXywmHm5J5zcJmlhskx8=
=e+7u
-----END PGP SIGNATURE-----

--=-clqxbzT3PEY1e8wsTu5i--

