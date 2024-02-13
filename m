Return-Path: <linux-kernel+bounces-62867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F92852706
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1276E1C250B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB521E897;
	Tue, 13 Feb 2024 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fTrpFoLl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AM2Y38VG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D531DDD7;
	Tue, 13 Feb 2024 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788281; cv=fail; b=ftjWqUtesdp7scVzl/fm/dvfXOeOYzFTdTe3vx2ReH+ni5y6Tb9b70nc7Q/FmxUedOQQ2TvCYMG3Ljpw0UpezgHaV8ildQ2I9SE7Tq8d+hSI83vqoHO/LVmEBOpvwXQYNYZBbGmxZT3kxoucE6Ngi0yBFXrCNIkny/gt5nJ01ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788281; c=relaxed/simple;
	bh=6sSuB5oUeftcdrulEeP3CRJuREVDBm73ZjxWukOP+cg=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=huPPLH5JZrbHfLYx1A0Sfq8iv4n5BlvuBB74pKl9OYh7EOk+RjMZTUWMA2MnrRFXDCeClL0hVw3WXpkNePoH+fozgJ/jlLuYDpVLQtZmB1kAs0Y/R+NdHHkrIXhSZTDsYrmrRazplXtBwZ/wO+7tBxvjKf1+gE4qNCjq0HjwB7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fTrpFoLl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AM2Y38VG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D1OeWD027813;
	Tue, 13 Feb 2024 01:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=9rO7DzBZbCtURLLFq42siaeBDenDYhjMa8IT7nYLDho=;
 b=fTrpFoLlJ5q7/oB0h8YhO3jxeb1bTcdTN4CmBkNWMFxmjStg3LFQgsE+N+PJXudVyYBu
 x+xgv9hkV/WaID5GTDgE12d2m+yTnpoziw9HeBnzI4NTzJb3mg+1sZKrSr7yvsla3is1
 oMEzFHZufTYmF1SaL7VgIkk7rT30mvO9CK5gVk0janMf1qiwvbeSathmwQ4pqnwZ6wyz
 96G61KSzgt7o4LH5AvopWhHcKv4mbYahNG5PTI9Rr2sJ5FF7kfCE/i2khjyr3ZPe2Zr6
 w8NZPAWe29N3YwcqErd+abpoaw0jyw2+B7zeRSs4AuRSqvNX77/eqkBkywRq/jthcLSh 3Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7xqv00eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:37:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D0Cdv8013778;
	Tue, 13 Feb 2024 01:37:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ap99axx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 01:37:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmySAAWCLfgrGd6IQ35/gWv8V53hk1uoq00mSMKfNsZImK2aW/XelWbHMA7ICW051qOiIq3z9P0XEAVViyDK9Gf7nkM8dg97BaL0TD5YXjkHSC6Aanvdk/vr1E5Fy0QY96s096GaXF2Rn7NONNradfvf9zt4sWBkgKlbkxS2fbEY6Yodtdy0aMrpAHBKFsaq5a/sMIrWHiEO4GnWw2cfRWqqsI04qvMYxj6wVRwB8xl3oBZgqcy8xDhWv7DVDYjF2H2SQkZHe9PpX/E3qcyVqYe/23mW4o/VXX/MHRKlaVkF07+Rk24ak9zbAhbb3PfXiAEEEG7aYeHmbuSBQ8Ld5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rO7DzBZbCtURLLFq42siaeBDenDYhjMa8IT7nYLDho=;
 b=bndRTMLDH5DArp5PZFloJFwh/9anpoY61Ej/ZZ7kl7Y4YdwlYNIa0aTPKVtdJI30s/nKhzr7CYZnS0K9QAXpM7gWQbOloxbdl3pKJkYCl5Ho5QfJmSoMl4sI3YkU+4N2MIHXXeo4oNETBSqAlnpOFYqPyuCuOU7xcRQclrlHTJ7juTt437+ZZRWNuLlCH3KTxMiOaaxCdcP4bDtMywb50aJDSe/DvALMPMHPBvPeJDHAsdjBT8B18UpvVkNg1g5L26Sjr7xeOVxvYn7bxJi4+eDW30Nbl2DwNAWBl2mg8YZKvCTrqou9CmQLXGnhBmYyXd2cfvoOEYuFZV6v+idXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rO7DzBZbCtURLLFq42siaeBDenDYhjMa8IT7nYLDho=;
 b=AM2Y38VGUDeW3ZaZLRMnG0v0zVuc52T0p0ZsOXY3AS2kRIwSMTlGEK700N0DAQ38W//emXKJUl8qjolTEpTmhYaYXkI1s1wuRSQOJk8P9dQ0FUcb7evdGjtBKcXTcfu/29Q1fqBoacrWeiEDULtcIjgZBUeiFGuJxMQoqH+9L2U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB4873.namprd10.prod.outlook.com (2603:10b6:610:c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 01:37:51 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1b19:1cdf:6ae8:1d79%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 01:37:50 +0000
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig
 <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James
 E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: really include kunit tests with
 SCSI_LIB_KUNIT_TEST
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf1xkuu2.fsf@ca-mkp.ca.oracle.com>
References: <20240207145603.15680-1-lukas.bulwahn@gmail.com>
Date: Mon, 12 Feb 2024 20:37:48 -0500
In-Reply-To: <20240207145603.15680-1-lukas.bulwahn@gmail.com> (Lukas Bulwahn's
	message of "Wed, 7 Feb 2024 15:56:03 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bbe6db-5628-4a36-6c21-08dc2c3463cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f5RGVKjrr7v/tb/BDaMeXTtxjeuFWp4cK7Lbs5AQY2E6oZ5SYQCPsWpkFl68lOSkiMELEgeUCzEwRqEsCCMV/oBH01wZnvHz/1KH51Y57RKEGg3aFdx9bXqf5WnHmClZcQUaF/xL9F0w/oGMzyyFL+Xp+zYQWsQF5j/O9axemQrGTSCHbUdUrUvQH4oB6Zz5qNw6SgVrtFae1umSULJ4qha8CsA05qy74pj2oir7t7K+dITDIrM6vH164PtaPc4pyHQwk661sGp5L8lAK3HvY13XDltUP6AsuIrMfjvor+H2iXyx9guxUAPx/TwrO4DulZY0dpsYbef73VWl4wYMoVDTnaECnYubMHoY053qPB+99lhgPvR9RCtTfpmwGbQfUlBhXLjT2kYs+UF3CAfOiBhzy90b2Z7qNVVycxyhtGKmImA29FsCz7RVLdfhJ8p9x20HZ0scJ1QHtfhd819IDjrhfiAK1hsEu7AcCk2r6sNAyeFrQ/f3W+06Ts3/B542sPnRiwl+BJuS53D1fLB7YDFzbRnA4+fC2ugkqIftUv34hvOnS9DXKRQ3nCTNQFGW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(478600001)(6512007)(6486002)(36916002)(26005)(4744005)(5660300002)(2906002)(6916009)(66946007)(66556008)(8676002)(66476007)(8936002)(41300700001)(54906003)(316002)(4326008)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j4gxsoBHuKuGtYZ1sU/7v1emmqIWL3tMdNQgQOZfOIwlcWvRTCJOUGHxbTE1?=
 =?us-ascii?Q?mbupbFiKyUu6AmKiFCYokzqZRwSETIp3eAc45ZpdadPTmuBQeoS7O47H19Cc?=
 =?us-ascii?Q?oeqO+ZzWJqeXmWnc+xn19DqzXRNd6XuV/UupQDWSKXyJmBbjMr0YVzLj5MuH?=
 =?us-ascii?Q?74Z07J/08/ltNnijFSL6QsZ78b8+wutZZ8YjBoDAN8oQ3dzuTYDR+zHkwOGy?=
 =?us-ascii?Q?EMXVAX5vMTx+g/gj6JG2DfY/3jjn5xdxZwl6/gw9gAhfRkqZE6zyIKtrM2HE?=
 =?us-ascii?Q?ENyJnX2o8RjUGgfmUZA8RK2S6KrmnYtNOzcvmMRrztPGZ+w+uplUWhDMDIIo?=
 =?us-ascii?Q?FN3nnbnajPOBl5bA2JVNUZzGk5Ogfvoulkt2qaT/BL2hcTIFe0dlXUFm91/I?=
 =?us-ascii?Q?1A5RpMBPF/g3TPv5XXJR7enCP7RX6XNyJ6rVaXST3PAPCg92P9CvRQE2QFGc?=
 =?us-ascii?Q?m6BCDTRgLHmOBlsG5wlVIUgvjA8tAHvltOzvT18r3o8g6Pexc23Y26cq44Ag?=
 =?us-ascii?Q?JUIeaWR0FOFnzJtsL/1rDR00zOgIMDv9Fm356pINCeE5PASIypk4FgMKjSL3?=
 =?us-ascii?Q?kc287alPBUGcfzWE7KphNTsvQZGh/gg4xBrSLSO37IbPJOMMBC9cLzx4WgBy?=
 =?us-ascii?Q?XFBAZDzDGnlknosbXHMdzk9UVQVAQkZbtEsdDpFn8ZJ7DmnJoJMxKYxhkH5E?=
 =?us-ascii?Q?HWmJ1hMzQwjTPkNiTXnZtXM4ew7AcaF7Hau1h23ymr07XUCHM8QVtwd6Q3FE?=
 =?us-ascii?Q?wz6InKQsrzYvxIupJIANqkZJqZhrqRdfUKeiMzU/vAlOzCTcJL8zXrJC5hT4?=
 =?us-ascii?Q?YjYO//NHddfSHZk2Ys/+BzhTkZLV8H47jNYuQprgSfj1PafPqB30puDZWgQp?=
 =?us-ascii?Q?4xmP85zfSDTwOvCkAkQd30TcTH+MQsvjhej/6wzLk7561C/x64VAP9PlpakX?=
 =?us-ascii?Q?Zc9yyzpwrAkBC6IrwLFvGP40KgI0tx6qspghZ9tkywHBzIOrp1WaSacytCn1?=
 =?us-ascii?Q?EHewTXl/b7z05tJRyWgKyYBPKx6JCAeBq+DBVGIIzVWASBG4bB3bxQ0i166i?=
 =?us-ascii?Q?18o/p/j/pyuMi15ASe4JWB2jwEHARxO2EPjAdRwjkAPsmhqek7ltsHwT8/w5?=
 =?us-ascii?Q?K3BzuLfQ8PT3h49u0g0h+416PB1G/IEkvbRR1MKSgoletWHzGgGx4AeovhfG?=
 =?us-ascii?Q?+veITd7EiI7oH0PMH6RyGi94xGgtHvrk1RRvFy8mKMpks94NAhRnhKPl7/Bw?=
 =?us-ascii?Q?VPER+cPLRLrytiXm67UHX0+jlJa7vnV3lQg2BOjeyPqNJn2A4nlV7HHtsvCI?=
 =?us-ascii?Q?bDl0GQQODwjyYnoUTqgQBBWwwpGm7n1SgWxQ6z8NmcsjJyKOy+BqSCUyFcS1?=
 =?us-ascii?Q?G+gSoyzFRRN9ziH3FFBM6BIj5GjBLvMJ+/IOl9ORbrdvDk4R/TJs9SmZ9ggh?=
 =?us-ascii?Q?goDVpbKBwMR1MkaKAXulsQGD/jMxWdOIPXnECitiaW4w8rW1ftjiM+RVxgOO?=
 =?us-ascii?Q?aJEc09Hap+E0hQHNPrPIlAS+s6GGdS5uIdRQApQtnzprPAooZjp04IIiVpD9?=
 =?us-ascii?Q?G4G6AhShVWmG06bLpbwgaRx/oqscwvv5A2mnJzEJGUF3ewi/gBM+abB9vkhL?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3BIDgn77TtqguK2DnZBY6yuGQTVelw36Y/m8+aaiEv0oikJoHQ/7nSxMUFSQgOxGfs0p16D2j5ZLRHBNZqoEXcz0eF8FUDpSbzO0Oh+fRi6AVfOUJMP/rad1Y2gubE1n0sXl4b8dk9OiIp7pax3F1M3Y2Aj6VRtf0nnnJpCkV5Pb/E1opqd5zZudz5gTuAxKeNqZ8KPodtC9ntUNPUV4GWLhQrKGS80d/tSGxKKs6gaPRTxgZP1wyQIkV4PntCHQUk8NznXzvSHXgTaU9umNQZoSJTAH4f2KjZjvM0dMtnex27NiFlKlGeAdmmuceIzsXbrjAz+HIxm4Q1+6gKGAm3AON4cPlDf/9mBffnLQWqZOvYgOYnG4/mFAylXw8VsdQjCaZk7WQlydGjbkua+XyzX65ifHRpZH8UmQpi4NC6BEt9GYHZ7v0U9NDMxV2Zjy7kQs6O+uU3q6w+3aUoUV/j16N4eQA4ciApVReksWqS0OgIqu7yyHKmpaIxfHFxZD0X0tO/Ou5OLmn8OnXSqE19Sd2KcSJ4JO8HbjiR+z9ecn/B0XMR6jo2LDUvE3g+VkMypeIejiCX4KTEEs/zoUZYwqn8AIAlne16AIfcaA50c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bbe6db-5628-4a36-6c21-08dc2c3463cf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 01:37:50.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsu0Aralle+ZHNt0o0NPwTTl1ug7uHrhYI/7FiMYl4BA+CPrnxpRC4yWT9sTtO5hvBaPe4jkRWlnbDgP1OYYbAe0fO6/A0r6R9CTiWbioFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=837 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130009
X-Proofpoint-ORIG-GUID: CWrxcczAdSV95q2Tw2S0_6jgK3HVC-fR
X-Proofpoint-GUID: CWrxcczAdSV95q2Tw2S0_6jgK3HVC-fR


Lukas,

> Commit 25a1f7a0a1fe ("scsi: core: Add kunit tests for
> scsi_check_passthrough()") adds the config SCSI_LIB_KUNIT_TEST and
> corresponding tests. Due to naming confusion, the actual tests would only
> be included when the non-existing config SCSI_KUNIT_TEST is enabled (note
> this missing 'LIB' in the config name). So, they are basically dead right
> now.
>
> Adjust the name to actual existing config.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

