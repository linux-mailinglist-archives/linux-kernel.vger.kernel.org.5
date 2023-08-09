Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ECA776A8E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjHIUyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjHIUx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:53:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF4C115
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:53:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379IiOrT020056;
        Wed, 9 Aug 2023 20:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=NuhR9fZ62ntIPpv377T3lgtlUMbUExYjCDOJMtM/oME=;
 b=bnajmPRcXH1JEC9v17zBRC/FOztuClQJm+6pQFVi/4UZCJDRl6q0u1LYOQ/iG928j/w6
 7l9hwShAKmfX6rjnY0/Cz7m59B+BLwEI7VHr93fOk1fDHCZoXdxOilLyfDgGwaLP+QXj
 o/3FFiSBl44rezQjjdtmbG7SLyOAeUPBVHz9EUMZ2qpnowTEbUdNagNYjHPk4IfADgRw
 08k4Lf8T5B3muL8snS646MRBj/fwZC/+L14gurDZ0cmGOzCuZCqd7pr+/rsqxXghx17F
 FVI6KNw2bwzu3JNE/CO22NZnvH1bzTy8HLEoOySbuN9j29yFgghNUgfMPg27vkvZipDF Wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9cuesp04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 20:53:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 379JOnLe007750;
        Wed, 9 Aug 2023 20:53:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv7jgp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 20:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWKQejMtH0/gVEUCZOJYYdihLX6hD7HhYr2ufNf7YQ1boOBNKvqKwf7TRqg+RuRRVVnGcVxb3qY3+m2EJ+WGkaIG3FITuAis9r3qyPxTK9NwMSLNwh+gxeX0iKFzG3qZUfSrNTR0oukUjep/GZU75kWTMPD4mxpgKANfPvsOvNMJJP/eViuS5yF0Gk5VcLWl0yTrgJkJvBcMo/OswoeTuLoIqRJD4ckjKeTgWe+DXe5ahEMVZ5YJUAiC+K6/maFdO5sLXU4BWobSg/StrnE4h1w5tRHX+bZcDj5RsfpPEOF0Uby89YQpgIaJqkONanIoeVZPZaAdw5rbjlizZCzCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QFG9PZrvi476SW/4gebFvRLBGE2Op7paECDYIitPY4=;
 b=mxCTntqBKM5hmusLdwi/13uZl5BTTZoWqVU6hzsJs5f+EK+PUxMdUQ1525mXo4SSvuICqu3u/mrDLm9VxOIFWJMIYAJwGKuj8weG1/k7MxrjfoqPVGGloKcEy/b9yELZa/9JKyjRjYG1ZBNebUqXjRUHpd8EG8c/L+tvj5mhZdWEUjRtJbgppIXumVym4/XImPvbNPMIodq1jUfvb15FjBIdB7pDu0qyt1wh7zSRdy4iil7ZFfd3i9yMkD9VNlRnznItf2Gl5nRHHI8810ub6oBeTZyKkvDBPuMFrtL6DyfDSPioJH1HazV/UIx8jU8zK2gi1t3Bdrj89JxNp90yPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QFG9PZrvi476SW/4gebFvRLBGE2Op7paECDYIitPY4=;
 b=AENl5J0qUByIZ7ORb0s9j4WKaYBo7+HTC3zuOxQyXO4bLzY8+Q6aBadofk7O3/DrGvdbsPJl0MOcj2L2jxLJ5WGv31iHPtC4PV03zvCK5SBUyNNf0nRjvFnOZccA1exvGUvBQS7gwwzk7vmXVuzHxk1ODV1OjVsSHIjyKtooviA=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM4PR10MB6864.namprd10.prod.outlook.com (2603:10b6:8:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 20:53:22 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 20:53:21 +0000
Date:   Wed, 9 Aug 2023 13:53:16 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Zi Yan <ziy@nvidia.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Message-ID: <20230809205316.GA3537@monkey>
References: <20230802095346.87449-2-wangkefeng.wang@huawei.com>
 <ZMpKYfNWA/jNgEuL@casper.infradead.org>
 <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
 <ZMud3RreEpsvFKuA@casper.infradead.org>
 <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
 <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
 <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
 <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
 <5BBFF5D3-3416-4C0E-9FDD-655661657D67@nvidia.com>
 <a34778cb-61dd-4853-9961-afd7568cd0f7@huawei.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a34778cb-61dd-4853-9961-afd7568cd0f7@huawei.com>
X-ClientProxiedBy: MW4PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:303:8d::13) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DM4PR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acaabd1-39ea-4bd3-f83e-08db991aaa62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xc65smnq0kHgrQpLgn7MGjsDmubaD6rZ2aiWlvVatScreXcdvzh9fBVs2cs+uObtZ4Y2uYSJmFCBv2UvxM6jT0jwD25BS2DPKg8jbaOClEtrrcGRw8nW5RCyWmgxLu7Wb5fBldAbcq13RhppVOORhHdxJUK/0gChDMYxhsxwigTzsM4H9Bpzsc5BMvLZwTN6pYZRXCGQsgnrlu3kP1RkTx/tRkCTv9GE/+bDJzQf3+wcIBH1uzyu2FdW/UkgzZ5K8ykm/A0m+4hsTZyQYznTEi4HJurbHfz0zwI5dH+Vyo1X7wAI17vCxPqiA7R9taBGFhSjVa6tYrhxSm+bWLZ+RFaIHuvq98vZDrdrbBqaAlvQ53oKO94tnhI1447/3AORsUaX3Ecno3l/RzvkQX0BDqDEAUc9bxGrxA+49JBk/PkbQV2Taw944mWQ2cN6xlzGxPdNIRMODRooxVByYJ54/SzFz4rsJ+lMep8OnyQFlYSLI84NwPp4SddmbdZn0ppd1WCEMQsZz0T15GsEyP74XbljYmXGHccojyvzMFUUVog=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(396003)(136003)(39860400002)(346002)(1800799006)(451199021)(186006)(966005)(9686003)(1076003)(6512007)(6506007)(53546011)(26005)(54906003)(33656002)(38100700002)(5660300002)(44832011)(86362001)(4326008)(6916009)(2906002)(66476007)(66556008)(66946007)(316002)(8676002)(41300700001)(33716001)(6666004)(8936002)(6486002)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4J6EzCXvHDW+Xh8y7zm4ZglBGSxCkpXfCbv1LWb5N5KsYovxq9ateILFrX?=
 =?iso-8859-1?Q?cmkpRTHG8ieSdCoSlq6IcoRsGj5xvO1ndoz1fpDVRDrkEQMawC+lHEnxXe?=
 =?iso-8859-1?Q?Xv6e8ayoZXVOM0y1LU/u9btNC/7+e33a2uORxeO289I4BSscioea/WASk3?=
 =?iso-8859-1?Q?YRRxIvN6gx1lCeG0wQlVxJNnOHB2AZNa7Zvs15L9AoxUIbiOBVl6q4CQQ3?=
 =?iso-8859-1?Q?Pf6iRmV4i43Hrc062S/yyI/84Rg/1Aui9KnAnFZ5tg+7yox3FFTA1a6HG4?=
 =?iso-8859-1?Q?RSQNEobWNnUpajOVAgiJz9VtDROhnbjncTybU5KCyDxIlY0W+jgoyd279/?=
 =?iso-8859-1?Q?ytCA45/1hddzxtyZBi6+wYP9lSyPpVPJet+e6LzQ6oF1K7Mh5dRMYPZ+al?=
 =?iso-8859-1?Q?4uKrKSTliLJ3AkohJ1yBpJttFqroIGOIzcYpqYv8p3OrbmS9lVnWFc/ig3?=
 =?iso-8859-1?Q?UXs934taZ2ONrQTsrRFpvEeIfG54IrkLNvSqTc14OectP8XTvUevXIIXWR?=
 =?iso-8859-1?Q?TZP7acARCLgzRsyD70VtKWraYyyxQldV33t365afl9MRxnHoWNEgT8F/4O?=
 =?iso-8859-1?Q?Zo+hQsLTAIlQj8xBxy7AJazbubXDTwEeaTZWQy8rXlrOSluGDcwd79K465?=
 =?iso-8859-1?Q?FhMel48ZgpdjEbnhyJTB50D6/eYIBA6tIv0oFO9JcUdZmMdFefNsxL9H16?=
 =?iso-8859-1?Q?BPDGz+xIR8ovejj3AE6D27rBpoV+mLawAqupD8HFR6ZRE2CVcztiYhWC3J?=
 =?iso-8859-1?Q?o81nS+kmg3RZ2MmZT+hZwm/aFLUMcQgafzDyB11PpTy2n7huM0xZzY12HK?=
 =?iso-8859-1?Q?MclwASg217UFVwUJkC2cLfaBXxS3fSfLc9HqlFGpv9Rg3FRlscTOPKV6nK?=
 =?iso-8859-1?Q?l3ovcciEnwXDKg8RQ9ZDcSxnhLqNrIuZ1f6EFlYAAhn3uhZ2K//2qu3v1Q?=
 =?iso-8859-1?Q?8IPAq7aIznDCSBFo/L4R4D8PegNeAhocss1Q/CAz/+5tVZ0S4/KkYRxMLN?=
 =?iso-8859-1?Q?hhFQNbS1T01MPLe6nu6JgOZKDNEXzRDy5mrAjsgCS+e24+giiSDjCJBESY?=
 =?iso-8859-1?Q?WuCN/bhXDyPryh08uipRxZoDDrTsMVtxCH424/TD9WFnJdVo+i1IuP7NZa?=
 =?iso-8859-1?Q?12v/ZUN+K37p11H2dN7INaxNMuKe1hefDqdiGvgh8ZcayyHXEGW+PfIYE7?=
 =?iso-8859-1?Q?omkZnufqcitEV+CkVTyDjTQCsywxbJzyBRtzKwy1ZkbltN6jdUzA5FKy41?=
 =?iso-8859-1?Q?Urvnbn95lLxdTxXXW2TDabWqpPNRKceQu9lzuVI4UPTzL16preSTSN7i1P?=
 =?iso-8859-1?Q?IMJeoFqkWGrxEeJD30P9qql6n88JlfEwAi47WT4zk2j4nRfHP1tvyxBK+g?=
 =?iso-8859-1?Q?/7Ex4BuB2yN+taqkKd6nV8plQMZDYIO3G/qu8c5mBjsXey++YEXZbKqn3V?=
 =?iso-8859-1?Q?/1uawavuwANVdgwheAW36wCfEsrbR79VUAsSztEQvHgVrVc+tatCXWs0h8?=
 =?iso-8859-1?Q?t+9SBCkUEnrsARnSlG6UPi46AwQZfgY7EZ5Tueag5sKTkDLMfXfjaRoM5I?=
 =?iso-8859-1?Q?Si6YsXNGvk+khnjuXa7LM8Vy6lcgjEgf3U8qG4fMMC8yhk6AKR01pzx1eT?=
 =?iso-8859-1?Q?vcuOdgj9Dyw3l59NTD87nJNaEkTfU2lfVZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?lO2/yXlBprv8+0S4UgyjtSp1UXUZ5EC2IKGPsmB0OZWUsKH2JurqLq2Dv1?=
 =?iso-8859-1?Q?wnKVqbCjFgy5iqquED8cEtl1rgdwKsBOHex7uQhSmkAsfgN2VVtnZsD96V?=
 =?iso-8859-1?Q?wbIn+JyhwMw6vB7AOaxw7gaSMOh05OmzUg+9OUnhPY3GnG/pvHwFMPVfcQ?=
 =?iso-8859-1?Q?Qw75tqtHpPs9/szkBc38pZQiSae3RZm5ajfiSu6Z1JWb7uqmF69cDIPdzk?=
 =?iso-8859-1?Q?Yzi924uLjy7PWsKgwj6Zd5mwM17T4457F5zLaJfHK9XMKXzpmsNTLG1m1H?=
 =?iso-8859-1?Q?wi8OOrFvoeSyUTM74yH9fqdEj9irUwy1EVKpmVrjCPaOIOKWXQBn+5Mhty?=
 =?iso-8859-1?Q?1Rzbl/FMf9t21sPAW0gIobySGNHFDfJl7sy0YZpoZCQmVMRBlex1Ry1aWs?=
 =?iso-8859-1?Q?1DPhNZpeLlea6NQLEgmCYUqHl+lEEU/oOD3u+PTYyVdEkx6FnoLKUS26WV?=
 =?iso-8859-1?Q?amKzjVDSAJz2DyG9VXtq1lLuWWNNDJLOLO1BUDmTHzNGzCcdXhTE3Tt2av?=
 =?iso-8859-1?Q?MKLtJgzd6FthTzZ9Sz6vbIn1iJLEv2f6O4EssGTdxtoh71gZaPiwQAxPAb?=
 =?iso-8859-1?Q?KgCYKFTkBcTWEDD2B8Avm+S3ZK0WHos4b5SavkWzu6iTZFKg2x6cFP4/Gf?=
 =?iso-8859-1?Q?fDGnPTKtY/o5Ib1SFTCy6ZQbQu8LC6qPmJxT5JMK6AFiDJwbw3h/3Z76wA?=
 =?iso-8859-1?Q?QH+sClBl6bseBKVOI2Na7dZeIX7/Z4e2FZ/XPnE/qvCyXjg18vuYH6V71p?=
 =?iso-8859-1?Q?3Mjvp4GT5C8RWAtIXIDIqc7GM1q7+W09SUIpFU2vYh3K664cJ/WkXbiSbo?=
 =?iso-8859-1?Q?1aAHCLVA5ZazK9os5MQ+pdi5wa9CahInGD4lWp1n0pxrghm6VepECvqkWJ?=
 =?iso-8859-1?Q?qQSo/0lL01cAXj9Bzg9e0ICfLhGxNdyL1QibvqzE/NgoN6CyKFLvjbPjSf?=
 =?iso-8859-1?Q?AIRjpiExgS0zM70ZXMFVjPec44wHyN6Ugs+4jyZ5qOYZP5j4/RwwEXHNbQ?=
 =?iso-8859-1?Q?vNWQtoXC6mQmaz5GX2LRjiq181s/I/E+FngJIy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acaabd1-39ea-4bd3-f83e-08db991aaa62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 20:53:21.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdsqiLZWsnZZSaTw0bT4GLokJQFGyyjg2et8TE7iKsX/9qxOlW/rqd16EChh28yLe46hwEsxJew0ny0O4I0o5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_19,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090182
X-Proofpoint-ORIG-GUID: 9MKEPTvHpjsq-u-JQvKkxBrIIxotrpjR
X-Proofpoint-GUID: 9MKEPTvHpjsq-u-JQvKkxBrIIxotrpjR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/23 20:37, Kefeng Wang wrote:
> Hi Mike
> 
> On 2023/8/8 2:45, Zi Yan wrote:
> > On 7 Aug 2023, at 8:20, Kefeng Wang wrote:
> > 
> > > Hi Zi Yan and Matthew and Naoya,
> > > 
> > > On 2023/8/4 13:54, Kefeng Wang wrote:
> > > > 
> > > > 
> > > > On 2023/8/4 10:42, Zi Yan wrote:
> > > > > On 3 Aug 2023, at 21:45, Kefeng Wang wrote:
> > > > > 
> > > > > > On 2023/8/3 20:30, Matthew Wilcox wrote:
> > > > > > > On Thu, Aug 03, 2023 at 03:13:21PM +0800, Kefeng Wang wrote:
> > > > > > > > 
> > > 
> > > ...
> > > 
> > > > > > 
> > > > > > 
> > > > > >     if (PageHuge(page))  // page must be a hugetlb page
> > > > > >      if (PageHead(page)) // page must be a head page, not tail
> > > > > >                isolate_hugetlb() // isolate the hugetlb page if head
> > > > > > 
> > > > > > After using folio,
> > > > > > 
> > > > > >     if (folio_test_hugetlb(folio)) // only check folio is hugetlb or not
> > > > > > 
> > > > > > I don't check the page is head or not, since the follow_page could
> > > > > > return a sub-page, so the check PageHead need be retained, right?
> > > > > 
> > > > > Right. It will prevent the kernel from trying to isolate the same hugetlb page
> > > > > twice when two pages are in the same hugetlb folio. But looking at the
> > > > > code, if you try to isolate an already-isolated hugetlb folio, isolate_hugetlb()
> > > > > would return false, no error would show up. But it changes err value
> > > > > from -EACCES to -EBUSY and user will see a different page status than before.
> > > > 
> > > 
> > > Before e66f17ff7177 ("mm/hugetlb: take page table lock in follow_huge_pmd()")
> > > in v4.0, follow_page() will return NULL on tail page for Huagetlb page,
> > > and move_pages() will return -ENOENT errno,but after that commit,
> > > -EACCES is returned, which not match the manual,
> > > 
> > > > 
> > > > When check man[1], the current -EACCES is not right, -EBUSY is not
> > > > precise but more suitable for this scenario,
> > > > 
> > > >        -EACCES
> > > >                 The page is mapped by multiple processes and can be moved
> > > >                 only if MPOL_MF_MOVE_ALL is specified.
> > > > 
> > > >        -EBUSY The page is currently busy and cannot be moved.  Try again
> > > >                 later.  This occurs if a page is undergoing I/O or another
> > > >                 kernel subsystem is holding a reference to the page.
> > > >       -ENOENT
> > > >                 The page is not present.
> > > > 
> > > > > 
> > > > > I wonder why we do not have follow_folio() and returns -ENOENT error pointer
> > > > > when addr points to a non head page. It would make this patch more folio if
> > > > > follow_folio() can be used in place of follow_page(). One caveat is that
> > > > > user will see -ENOENT instead of -EACCES after this change.
> > > > > 
> > > > 
> > > > -ENOENT is ok, but maybe the man need to be updated too.
> > > 
> > > According to above analysis, -ENOENT is suitable when introduce the
> > > follow_folio(), but when THP migrate support is introduced by
> > > e8db67eb0ded ("mm: migrate: move_pages() supports thp migration") in
> > > v4.14, the tail page will be turned into head page and return -EBUSY,
> > > 
> > > So should we unify errno(maybe use -ENOENT) about the tail page?
> > > 
> > > 
> > > > 
> > > > 
> > > > 
> > > > [1] https://man7.org/linux/man-pages/man2/move_pages.2.html
> > 
> > I think so. I think -EBUSY is more reasonable for tail pages. But there is
> > some subtle difference between THP and hugetlb from current code:
> > 
> > For THP, compound_head() is used to get the head page for isolation, this means
> > if user specifies a tail page address in move_pages(), the whole THP can be
> > migrated.
> > 
> > For hugetlb, only if user specifies the head page address of a hugetlb page,
> > the hugetlb page will be migrated. Otherwise, an error would show up.
> > 
> > Cc Mike to help us clarify the expected behavior of hugetlb.
> > 
> > Hi Mike, what is the expected behavior, if a user tries to use move_pages()
> > to migrate a non head page of a hugetlb page?
> 
> Could you give some advise, thanks
> 

Sorry, I was away for a while.

It seems unfortunate that move_pages says the passed user addresses
should be aligned to page boundaries.  However, IIUC this is not checked
or enforced.  Otherwise, passing a hugetlb page should return the same
error.

One thought would be that hugetlb mappings should behave the same
non-hugetlb mappings.  If passed the address of a hugetlb tail page, align
the address to a hugetlb boundary and migrate the page.  This changes the
existing behavior.  However, it would be hard to imagine anyone depending
on this.

After taking a closer look at the add_page_for_migration(), it seems to
just ignore passed tail pages and do nothing for such passed addresses.
Correct?  Or, am I missing something?  Perhaps that is behavior we want/
need to preserve?
-- 
Mike Kravetz
