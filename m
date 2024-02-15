Return-Path: <linux-kernel+bounces-67642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E7856E66
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C3B28A64C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199F613AA5C;
	Thu, 15 Feb 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="onjgSPew";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="azc4v9AW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD5313AA2A;
	Thu, 15 Feb 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028081; cv=fail; b=l9B8pTzt97czabQNqmw2+K/85WnevMAcfDYQqAE1glvhg58960CMa36avjXipQHqfcYCijXVJl/Xummx4fXfQE57Mye4Bc3AWVXtcanOtDbrilPSoQ2QpzKlgXQrSzm8+03Ppr6PRg3GFgf3eDAjtzLifaZoVVcY9S+wBLbfIC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028081; c=relaxed/simple;
	bh=k8PxIUjBam3Wvgcp9sTQly0/U1ZZ2RDFWsB1l8jjU4I=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=TEqWAL/aS833QGCX3oZDs+mO4dbn0tA1j2d9XlhBn+h0vxVrBtcoM+bzORnilldBkWr90hye+N7RKkPg7h53trXNq2QmlOOWMIfujQEaIIDVTVhPnEebT4TruJ6zaG3ED7ftyiBI7wXo6pxma+qri8JMZzHktwj0O4Ak25k3PxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=onjgSPew; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=azc4v9AW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFT5Pi022514;
	Thu, 15 Feb 2024 20:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=GUu7Fwe5jbS+kdDrTH2czP6bXKJhpzOKgFfcn4yC6SQ=;
 b=onjgSPewdSWvDsBAk5igjjW8Avc8Nd//5vORGtK7ISqpbbhassoegp6QQ0DW/xiXU04s
 LPbJs+jiM6lCm9Lcp1+Fh6zRbsQj1dXeBVOeJ/R8H7vY1wSqiC1pvWXe3jE6vLCHBbXo
 YPA33sPqo5dexAuW8ANx4LAnTY7Wkd6rjQFYHoXmZd4sSxX44ujTYr6o4DujXmWEaJ1B
 Cteb4FlyA8kZIdVonevnVyNV/bYK9+ncE3FX65Tt7ir1aD1Zg6drewBBWZntzLR4I9JE
 EPZdYfARpbkc8Gj1w4lJmYe31LDbem9nPSREj42FPtvr3WQX1ooKDYg7MoN1+4ecPXfk 4A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db36yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:14:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJFPeQ031494;
	Thu, 15 Feb 2024 20:14:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykb2fjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:14:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baxzo1fJ4NmxXmp86BduP9EAWJakrJmosYOhg5SPEZl9MrNuuCMS7wjvFPrF/cEo/qFS0QI+j6m6vJTPZWWg+wKZRh06hb6pAStU7zwY2j8S/2qEqO4nb1vUZW422Yk+7L0cCb4bbCRXpoJH8Lz9RX2rt4ml6ZoOoJyRQate4FQ8dIj4dBBR6eNTE6D+utHVTlsbzrXtgTH0wD/zrQUFr371xKA8NMZT/mvCBgjnuI0NcVmt8avwqkyfL8DnDVrKthu1eVqSBRxctnWP6lq1yz4ypMfUQX0H9Lcp5PHLFOCpbAhrXt6YNtX2HAfXfgrCFM6qMb9T2/GTxNQuhgPEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUu7Fwe5jbS+kdDrTH2czP6bXKJhpzOKgFfcn4yC6SQ=;
 b=deAYl30zAPn0Ij995Hu3H0W7nZn5QrbvRA2yQTNmcwvHJ4oNHnRMdW4dxNHcAYhAFco8rjoGZ3ZhWjhonajpYiR5OUTuHGQO/Wo4Shgg7IUlVfzDXowluz9Kpj4UFc/I/XlSHSS6qRM5iQzCSQFUPDx/JPyPH953HatOWp8lZ687ZSjmzszfdHhL5LdAhcKmKOo30FxPvxalhkUKNwV2Ol4j3CucaQDTDTxD3R5z/EFEEX91e32tGcA/7dnewHgnzwVghE/Ox9tQBaSDhpau84sUG1cA9A6z+XyUBjO6cbWcG1uxdVYRj53ki9FY7tuoko7RIYEybeotoxh/YY3e4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUu7Fwe5jbS+kdDrTH2czP6bXKJhpzOKgFfcn4yC6SQ=;
 b=azc4v9AW1ZAe3znS8EQ+TiGjYsQoIyAodxPxNODBN3BBBg4bQdTHE+gyV2rXTqBUUMzcObZbDCQZVP+SFjGXdGF3IV+G5OsPMr4ZGz8PI8EhrCn5gSEJbEc7jAc1YP1tSDPKMUX8ywTgTLWw+t+Hyac/q8qiJr9gPfwWfdJSRDY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7128.namprd10.prod.outlook.com (2603:10b6:8:dd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.29; Thu, 15 Feb 2024 20:14:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79%4]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 20:14:21 +0000
To: Arnd Bergmann <arnd@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Nathan
 Chancellor <nathan@kernel.org>,
        Nick Desaulniers
 <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin
 Stitt <justinstitt@google.com>,
        James Bottomley
 <JBottomley@Parallels.com>,
        Naresh Kumar Inna <naresh@chelsio.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: csiostor: avoid function pointer casts
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1bleb8y.fsf@ca-mkp.ca.oracle.com>
References: <20240213100518.457623-1-arnd@kernel.org>
Date: Thu, 15 Feb 2024 15:14:19 -0500
In-Reply-To: <20240213100518.457623-1-arnd@kernel.org> (Arnd Bergmann's
	message of "Tue, 13 Feb 2024 11:05:00 +0100")
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d75f3c-e550-4ea4-940f-08dc2e62b22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	400iVqZX18coOPQzFAPflYFndfP7IkNicMA1/j9nDP/oNsafeYHKsdVvSnnh0IRE/c4lO6E2CvH/C7SJlPfFc0mxD/CbvP1giUpsSOSNdGjBWU8X8iPi/18niX9gU+CU82sS+BtDH5HvVKY80OYEMi1SL2Of3XlO97+JZSwwtzJrkVbW+rwk8Fo5d41IKYvELuzir2Ia4uMiPgbTLJD28S9xpLuREiScsSwYBmdDhMl5lSuugdRtymqg3uNBu1pJgi4JSSbe5+qnp56Ew/0qZjHMW6PEGYgj5sqEPS8Uz04uSZ7+gg2nkn289OWjVhrAFfQA9zShJB1/ip0VMkRCG9rgL9rMK2EbBLn8Z3ZhNj9Ze5bAPrdYPxe3aExk2LVAmEZ6Y7TBCve8DD9jiwQy5zjRBOm8W9oemCz56/1RaNGdUMgqvFmm50bmVaoSluMjE8ITsL01mXOqf+Bc95NDuP07i9rhgQztl+yapmKrqCjolQJoa6cQzDI0MFKYr9X9YWfVKvzjD1YFX9Kz1ZdLpCB9oB018pC92XOLBdGVqAONiqbuSlEM3y70rMj/2rpG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(558084003)(5660300002)(86362001)(7416002)(2906002)(8676002)(66556008)(8936002)(66946007)(66476007)(4326008)(6916009)(38100700002)(26005)(41300700001)(478600001)(83380400001)(54906003)(316002)(36916002)(6486002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ddFCL3aCjgE92dJ6wbdffyo7E10rzVil18YEUZa79k51Y4A9dOjj8HyZEDGU?=
 =?us-ascii?Q?J4yUb7LZ/xyixonxQCIN4QeqkfUjmy67NHw7PEIjeUJ6Xy83sV4kjoZ1pV/p?=
 =?us-ascii?Q?qb/3JYfMRLC5A+QrEzh5qVgUwrB6rz7gZpQi/rMDLxggaNpK8m+aJfu5o0mK?=
 =?us-ascii?Q?Rk3GX8LA/+kaV89ACnIYLplMY6Ym2JQfaUXUzZMykKvzA6mv5gOSTtRCcbr2?=
 =?us-ascii?Q?N58aFVihbrxcl/fydBUAcdsRK/7hUUdA70gnIA1qZHHfbeY0xRJD8Lk8ipv/?=
 =?us-ascii?Q?o8m9YiWkT5B/HiLCv+iyy+dBvjFZtZrZEWSIrJkMqhOe4/OQChnc5VZZPWb7?=
 =?us-ascii?Q?ovxnxiV2RAHmwI93KSK0vZBoU/SR4MQBsSLZuIV4RRxorbpbZzDVKUOB2oRG?=
 =?us-ascii?Q?l3SSY9zSfAwui3GiEhkvWG7EbwD63TxXCs+SLjXCfpvHo2v5zXUmcQDxyq8h?=
 =?us-ascii?Q?OIRvF6HQEiwx895hhqNaQirHnI18aFqqLb5zd43Wt+TXeh+MQBX7QQxO6f9X?=
 =?us-ascii?Q?dglqq7jZJBV+OeQ4qTx1g+/mZpIyDlAVzGjyKETomIYuRlKVOkkX40hv3L3g?=
 =?us-ascii?Q?lurOCTVqyyTGnlm/eWrn+b6L4lY761AlZBtj4vdCG9njBy6nXL2SirhMR7WF?=
 =?us-ascii?Q?KSxvCpI92gSylVMpRhyCI9sJqbwQnuVYSdK3rL3eU5PdeIdVYt3IjPZt8PVw?=
 =?us-ascii?Q?03Twyf1SDrXNaPRTOESpNsY0KsVdm1lHf0SomD1rt4RbKLUy/Fr57yPaUalu?=
 =?us-ascii?Q?IS8O7SC8NxGld4EOkpnBQoYfZ9lsv2va4F9g0J6qqNG/nfjjYweoUsTSJevY?=
 =?us-ascii?Q?SawN7QhUscIIY0zMwc1faUM3vonLbw/TU0Q+83Xb3BpMdeFwqjuk/XdRHaiJ?=
 =?us-ascii?Q?vq30A+GJFtMSYOv0xLRGoAtMxAqkEXM5KrE2EozSAiAIcK2Ty+tyzDkAq3ho?=
 =?us-ascii?Q?wZFxHCXn5mRR08qliYwiOWfBwoEq6l8U9DAxpmn+O21I39H2cJrF6KBnRQyl?=
 =?us-ascii?Q?mU8wj3hFryVuckk4bVeNCdnoDDNm3wtJhZeEVvjCH0Vp1Qf6TYWgZTu5kqui?=
 =?us-ascii?Q?wiSHJ51p3HrgXyl+DviGP+PWvKcLJ6687FCWw4zTTc+0CyuiJVbScNPQoyRu?=
 =?us-ascii?Q?b2X7TSqKh6JdO461JoXVlK+iSPOJuVn4kxMGfYAZC1E3VJjjbNC9f4ODgY8i?=
 =?us-ascii?Q?aPdeEWGjJbWVM/05uFELKWnExqlYYAV5ELTfvM3CzaKZPOI03bcbhX+N6Jom?=
 =?us-ascii?Q?aQhECGyboMh28JSenyZJ0EU3JmYcf6CCZjD8Fk8vcfqQAnyZ6JdFVHBvnsDb?=
 =?us-ascii?Q?Sf4tQnzZ7leck/Q8BJMEgBEteCIL9cRU3EUfA8m3KpmqoRhwvUBEZ9NIx4Zv?=
 =?us-ascii?Q?ZxRdEyo8WINJbabETB+L070rYdUwxIlOTSJNUxTMdK4n2UCGdAebrRkv6NeL?=
 =?us-ascii?Q?DzKWnmtQJRszRnQy7kjvJ8mKn1TLXnvxYMaHUlASZXqe3gxu7R1y28Ju3FWT?=
 =?us-ascii?Q?oBbfEWP7KbQY3PjrUqlGAe5BR7mN/uBeRBRt06M8cY7aVON1UsqM4Vn+MqA3?=
 =?us-ascii?Q?lSMyYGayZWfe94ketgY8E+4crNjj6bucTOTVELv8pVwnUcRhNjy5rUaGXqlS?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y6Zp82AHvCNb0ncyseGROVRwTPu5dOAbl7EvWr3Af6m5Y64xaOqOD9oWxI++39NAQkF/xI425nqsir94UZ8uiO4BoDsax302/fR/ohecl5/9T9hxnXPJ/2yd6LuC3MDIX0IbfUu2zuzi6/by8jXrQI32znn/VqOaU+sXIt634pYK4NQ4omN/OK5cC9RIZ6gac9izHODoflB8xSJnU37nn6E4qjUsuAADpcVAqXfGLz0GZtPIQzlnSneHnKlvdwf4i346teI7T9eOZeF+KdmOzghnSFzOisxgAmtmnqIlzTTYZyeFTU7Ui/rJdY808t9+j3xNfRHpPfumlKzfRFHuRunA4+DlIyGscvGZFX7eKfgM96eE2IWCHMFTHd4+k3fW3GcGbpp1JyV/xuV4rT4mZXR0vUZExR8IT4ee8CbsDFN/PMjXGjvjd+c4NW5N0esDsAwlePy1X9p+uHMWbSuuJLzyeT8vC3ja2QGgWY3m+6IWKrgk52SOdJBHvY596bo6mPerTACKQXKumv2Q1mlhAtpuNfR02lBPvp8uKCSambYhyND93hFBTk48iNd8IuIMOUXqT/dDvxoyNM4Jlv2tOOgRBp+5PQndhfeQbiIF3sk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d75f3c-e550-4ea4-940f-08dc2e62b22b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:14:21.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 519u5QPPJK9W74Tz5OhXhxfO8MxFV+a0dwrTp2rbo41wDkiyU+CpWuo43FfN7xrRCLCr1OlK6UBz5dFbudN15gDElky8a0N/prx3Pj+kqaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_19,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=849 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150163
X-Proofpoint-GUID: Sawsk50bkQKMXBO6lPqakQmZZFJC54PD
X-Proofpoint-ORIG-GUID: Sawsk50bkQKMXBO6lPqakQmZZFJC54PD


Arnd,

> csiostor uses function pointer casts to keep the csio_ln_ev state
> machine hidden, but this causes warnings about control flow integrity
> (KCFI) violations in clang-16 and higher:

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

