Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E8E7D8DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjJ0Eaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJ0Eaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:30:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9361B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 21:30:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R0hvuG015401;
        Fri, 27 Oct 2023 04:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=x/0XmfYCaRJvl4vyeQM1ZmcCRsuWvG+FnvUMmpPiEQY=;
 b=sm7iOuS+cL7/WiLtYowmvwQDMfszV5d4zw3Pckm50piidtXdcbOH2sLSOLkX3NgEmEh0
 y7mMnvQgbKBu4qc3bOS1ZDsO0AVqA35rocHZdzx9Um6URjz+DGw9OdOOK+EcCRCZxh//
 ByhWT8ZRlR443drdfsi4q2CmWbhl5DRMV3j0Z2VPPsxkxFSwFLITvilxJAUoAL1FGx3H
 UuD2cTVVFNC4rGDTGmwhkqXOpRnBpaXLjmY3Ax+UvU292yQYTgCJrfNB55hh1sLP9sCa
 a+omahKoxKL96XSJamYHbU7H/7yokM8YMOzXCupJMrOESfCWXuXzdCChi3/eTpWwJcre 3A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxge0hxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 04:30:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39R3IYtN038210;
        Fri, 27 Oct 2023 04:30:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqsf0t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 04:30:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flhVHSnPQfruc301puDkzm+5mTyQIJI2V53dup2n7ASQrgHXDut//zDtML4mTnWP4/iSopu9MuRsuB46v9Kv5LLMeeUJqaGAEtY8NODuPMX06sm2S95ZRJBybIl0HywXawNFtSi/pxmcgO/61R/jNmtZ8Y674+z8Kny1d1YZa/1XyVLkoC3F0BirRl5JERUQtFyPxn+Zr6oZ/2MumnPQyPDegCGwqJj5ZLzOrGWx2AI2V3+7aDj2ZRE1ykAqxFuXuUZTzLZEubaLI5xPi5xBy2tuaCYAS/xthqHPaN5ZXAn8jirLCAwehREtFZjjtamG3psahRf1th1dyf7ZmFFNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/0XmfYCaRJvl4vyeQM1ZmcCRsuWvG+FnvUMmpPiEQY=;
 b=ICIrttGQpORm8W0aI5D2dtzsJB9hfRDNeNd3VLP5jQ71nMPI0lIhQkyVj+ZqB2oVL7+FsOo7AizHz76lcDaPkZ9wJFp4Q4rcTkZ9PeMmfgm9893nGcwUTql3Yo4yxtrdUcoqgZfe2S7m/h0Re1PV3vna/Po6XvRKU6tN2IQZFvnd943DICk27sqMVOCHmUMyT6IlOzF19i61BQgYf+oYUOCp1bnCEGj/CUCIUPbUqHbHFIdLsNDVj47YrTCnoCpNB8p/kZeiDcBTFmJJ6O7TzCNv5m3fmDbx+4j4M+VWa/JTOd2EKkB/vCkdlyFFY1fbpAXFHLDC9OUxqGCLnTA8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/0XmfYCaRJvl4vyeQM1ZmcCRsuWvG+FnvUMmpPiEQY=;
 b=ILiIs4PyCaqAToqrtbOXFlgagNFTnJvIXuHxFA/ZmJ3LJwpFgI8r/P1swB0/JAgxXnuigZqKzhCfpYcVdC3UlwvIrY77bEd+P9bqcvwgHLWBVF+d6Z/HaJfkJ553HeIcKSPZSRdo0wqiHgiw4frkfU60Uh3KPgl/msOSJNYAiLs=
Received: from BYAPR10MB2934.namprd10.prod.outlook.com (2603:10b6:a03:85::22)
 by CY8PR10MB6441.namprd10.prod.outlook.com (2603:10b6:930:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 04:30:31 +0000
Received: from BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::dffc:1a64:12cd:e323]) by BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::dffc:1a64:12cd:e323%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 04:30:31 +0000
From:   Henry Willard <henry.willard@oracle.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu: Avoid unnecessary cache invalidations
Thread-Topic: [PATCH 1/1] iommu: Avoid unnecessary cache invalidations
Thread-Index: AQHaCI5RosCkrUCtHU+bZDyXqNXXIw==
Date:   Fri, 27 Oct 2023 04:30:31 +0000
Message-ID: <196E8628-C1F4-4392-BFDC-BDA2B0D0835C@oracle.com>
References: <20231026084942.17387-1-baolu.lu@linux.intel.com>
In-Reply-To: <20231026084942.17387-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR10MB2934:EE_|CY8PR10MB6441:EE_
x-ms-office365-filtering-correlation-id: 9dde9837-2b2b-4ece-4d64-08dbd6a57462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q43trAnTKRSqL4492kO1gg9Ip9XQzbSaZHSeNuCo9e0sJu0NfU5/3Vgd39oJCafseHfWAlUyzEJPSYJBnOzdOTfZKNXZW/dWcJ5nnkpTOcCAJnV8+gyJH558RcyZGYjRxYrDQphbcSxhNVzsqc9SmYdQX5XwK1fV7Y9fSh35DbLpeYExcS/Y/0PHuYvOoXR4gptCC6mTKekgn0BNOOWArfWo1Vnp0u91q3BCT4Uaz1QncveKUMgTcfY3f+afJPyp3mzD84RuG4Lx/TBa/W6iIbRVtWZ/LjnuAyN67Cr3u1fvx6rFEKlUR1q82RyKX/QaLXpdJpUt0xUuaJHKBtYISyAnvKzEiXKK7pfU4H6gHl+CsXXKa7dfqXltwcXgyr+1y7hiM8yRVdWqVQTNc6eq8ovpaJ50oydm3Yz6CaEenKH+evCUW41a8wU6+GZk1tFAsEgRD0Ek3CfLqyGP2dobKoZLZ/J7wuaJVrc7B6JdN7uzZhofwSruDoL5TKDx2QbAmIEyoYgqAz/S/Y2Cf7wcNs6joeGYBiSm032s0HtHwwXDLQGLqFU50JOWbAi086rJjyRbnywxS+5MrzmfMnunH+PLii6k0QhSFYgHUpHCzKZ1pp9opEAGZC6TNfs9MfvQCzcW/yT5Pa/jGqUfzO6gEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2934.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(44832011)(2906002)(6486002)(5660300002)(6916009)(8936002)(8676002)(41300700001)(4326008)(478600001)(66476007)(66446008)(316002)(66556008)(54906003)(66946007)(76116006)(83380400001)(64756008)(26005)(122000001)(36756003)(38100700002)(38070700009)(86362001)(53546011)(2616005)(33656002)(6512007)(6506007)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cT+ztx/ykhWD79u/xDOoHgR1fsZ1RRFKOpkVFJdfj5766nHcYI6OuAdL1vl6?=
 =?us-ascii?Q?txSXoIGv4aiTAE+UTfIeqIvvjC8+EBWDcYNSpXf6o3/lNeJFhHOfF2eQ5w7K?=
 =?us-ascii?Q?v7byHdFXflDhmzsKDxAuRlugWlAT1ceAObn5P1/mJd8KSqQCBSDlSLAhDRFr?=
 =?us-ascii?Q?zwUQh7S3OsiD1swzJZhjnAq3nKaEFb/nsJUvZGD5teNJ8UJZgXAZ9w+GmwlA?=
 =?us-ascii?Q?eg5fr6RJn17GE71HaUTMH5zSZzLgNlsR7mJNq4q53JUyao6M9AaLWV8ivsRp?=
 =?us-ascii?Q?iXycK3MJxxSvr4eNkt3Huyns0g7TiOXgv923eNWDrsgzu0cMShC2D5bydTs/?=
 =?us-ascii?Q?JjbYJYJhtDMcQMkRYaxo1QEnopS9r/yhKEfAXiElkdDDrc1aBIrU/9mvO9Ri?=
 =?us-ascii?Q?MU+vzwjlNmTSb/o6A05uR/+uN/gxVnFYhZIK9I12FzOQcvtrhrwvdgww2+nU?=
 =?us-ascii?Q?ERJlaplAFToEJTL2RcZQYHL62n0+VgTaUDQ6F+dVBkBaBHFzdfbQpSV56Gzg?=
 =?us-ascii?Q?k6aPp39xYBt0TAv38ldQXjmYtWraiCQkCl3xWiFZEXpwps5tGPCVjPQg7YFw?=
 =?us-ascii?Q?afuRPQ0ioIXdEvnH3sjoEQ12occWpAvT7OQrNW//BtsYs1r2b7P/Dr4op/GR?=
 =?us-ascii?Q?z1bUwilpaI+6gne4TjwZQsuhTlWZjomQsDgqB5IoQXuLRK3yzqXiQZrTxne4?=
 =?us-ascii?Q?inqYXBTIDW0NTdkfLmPDYuHmDWewAAHsZ2MGqA+MLua7LVA1ITe1MgbEkYti?=
 =?us-ascii?Q?2kfGokpc5flVJHeHzQwrVnebuwFYbVHYWIN3o9tLkzLmbVJsDkJPhcVkTBOy?=
 =?us-ascii?Q?dnkbPpyH60JC71Zb/+tZki/iHNOWlkEarJ7s06ithfxo7Pc3Py2gaxOLMhYO?=
 =?us-ascii?Q?S9SAiPSsXCb+nKvo6JhsWIebFym/OJRnbfpjpOirGRxkLQ1oeH6kKmzJ2xgD?=
 =?us-ascii?Q?TJNNCDh/bXKheVZVSNJvf+IEOABTfjQaUNXKwkKi2dqub6X2oDPWrTygYh5F?=
 =?us-ascii?Q?zYwmGz4UD/tZ9jrn51EliuZJSnaadP4Qi5SXUwyfUsB2+S+smn6ZXV47cZWD?=
 =?us-ascii?Q?uIrpYREX7yemwGGAyoTvW0LTjEQt2+DCjf2sp4RRaEfZuB8qYrrW1OKjtAJy?=
 =?us-ascii?Q?di7ccZr+ksPYS0diqwkAZi6XwCpDke7aJNiOv0WDhLMSemdINKIu6W7LaWgO?=
 =?us-ascii?Q?2qSrQRbyLuLaWzWBxbS7f7nbgXXkMqnEXaaU9Zi1B/bs0eHY/XmG6S2ML65x?=
 =?us-ascii?Q?RW9826mgz3NDhoIsMRbFoi6bEu7eZlPeQfJps9jIMpd5aSnEnaAVDRbC7eHt?=
 =?us-ascii?Q?cP3nxP/j6N3EjImltMg/3fiRzdOTOiDd2t6f8pbdk8lfCwX6s9kmOzYxVr0h?=
 =?us-ascii?Q?PDV4kiDMJV4jYPXDzZ3tZlGiYkmE5jc2cqZ+K1MeTrNQKmPswOSBsIl/RZ/k?=
 =?us-ascii?Q?DxDswsEiuhQzTCYzC4uCHRMbI/4tnDP7vMHPj8CNDEfMBBRuv8uhxgRHKsbl?=
 =?us-ascii?Q?3qzhs9RLMK/fski2l2HJtUedvuPa85B9gjzyd5H59kxClHlzhcD2mN+kePsT?=
 =?us-ascii?Q?uDhA1EPOkU94ctp/F9a7HO06lIDj5KzDP2+YrxVdGV12lur1knYyEFmeXCU4?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A03E0CD50A51FA4484014FD62C5F08FE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zmMtMcGmiBawS7NtjY/KO9v3Gmw6cf3YmLF90iIP1uTRKCIxF7iqM46dcf4j?=
 =?us-ascii?Q?VoqL4ZGrnT5OIiinl8GsjGlF3AudEivgo38kVvoYTvzZ3M9/vrTcbTxFHQLF?=
 =?us-ascii?Q?e3n/JOnHEFUiN19vXtfcuk8ruG361IQdeW1z9u4sHPx4vE01fLUEykEXCo4Y?=
 =?us-ascii?Q?qZ20X4Upvl1Unc+d/dilLa0t5S7U3BTepx9v5lslKBUgglwfxBadCMj1kyqZ?=
 =?us-ascii?Q?ArpW6IkAKPFj8tNHwI0b+gHm7TNydN281TS0bv//ynpDfYuNMUoTKC0dUY/Y?=
 =?us-ascii?Q?i9h3XpkVqS4WSJnkvCUYjCtdixqvFgFt6aKBPp+O7yRH6MInFBXE/KQ0tMlR?=
 =?us-ascii?Q?zsvpdngh+ci0MC9jhHzYqlSgZv6VGtPnrUBBjqvEkeTeKm/+3KO5HcJa659+?=
 =?us-ascii?Q?2HEmjD0QFUXjjzvyDYrMaymSSNkNDShBttLMX5GxvyhvmaI71oBcmmFCzGQx?=
 =?us-ascii?Q?LoHrv2ox8vljw3NOC85FhOhKZRmrSMSIOuXgPL5KoLVekWSJda505IBzOozk?=
 =?us-ascii?Q?HxyAV0Hfr1zvzo7dVNxfK9zMCbZRQFFRHafwmKC1zBpd/CueRwnwe5GkcSYS?=
 =?us-ascii?Q?T62ympuDOm7qwugheky6mx+0TOUDXsozixY05h9ItVKPXyO52l3d/g0dapU+?=
 =?us-ascii?Q?iZyAa9ZIsmlpA87GWtkanN1lPLXfdlFQ6NMtAIGMVpfK7HjizxGLnMeMknub?=
 =?us-ascii?Q?jhCk8Ym31rD+IgEw9iwy3yHqs2gO4zDxHLvBy7a91yscfsovTp7S6uQIqJWw?=
 =?us-ascii?Q?q/RuXkQZ123ePxMcTEs2Ww0tNBy90wKKKzDBm69H5LbDxjtQBCZQkR/JkAuM?=
 =?us-ascii?Q?vs0y+yyKwOFN8Pm4cHLj+xM9o2OBGi608/ttMGpie7A1GCaLRCGu0Adm+0vD?=
 =?us-ascii?Q?ZyNMStc8tytYGgH7IldAb53ywyxKX8a/OnV4JziiZc2zPjFulbcp3x5ZCSv+?=
 =?us-ascii?Q?8qu5i6ywfE2M01ujTW38s+8sXRxLl5PIte4/JD3q1+U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2934.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dde9837-2b2b-4ece-4d64-08dbd6a57462
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 04:30:31.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5HFp6UVj9QN/bSAq0IHGUL36Yxvm497yxIVcOko5csokdJVf/pOptCQB4xxD5wYR1988OTsmKDuN3+MOHSzaTq124HeyvoJfKT0j1SNtvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_01,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270038
X-Proofpoint-GUID: tzTQAchtBuoXyZC0Ur865xyrP5YiWHq7
X-Proofpoint-ORIG-GUID: tzTQAchtBuoXyZC0Ur865xyrP5YiWHq7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 26, 2023, at 1:49 AM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> The iommu_create_device_direct_mappings() only needs to flush the caches
> when the mappings are changed in the affected domain. This is not true
> for non-DMA domains, or for devices attached to the domain that have no
> reserved regions. To avoid unnecessary cache invalidations, add a check
> before iommu_flush_iotlb_all().

This also fixes a boot failure on Sapphire Rapids built with=20
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy or the equivalent via=20
kernel command line parameters.=20

>=20
> Fixes: a48ce36e2786 ("iommu: Prevent RESV_DIRECT devices from blocking do=
mains")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by:  Henry Willard <henry.willard@oracle.com>
> ---
> drivers/iommu/iommu.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 00d0a2b5d7dc..0cb676590bfa 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1114,7 +1114,8 @@ static int iommu_create_device_direct_mappings(stru=
ct iommu_domain *domain,
>=20
> 	}
>=20
> -	iommu_flush_iotlb_all(domain);
> +	if (!list_empty(&mappings) && iommu_is_dma_domain(domain))
> +		iommu_flush_iotlb_all(domain);
>=20
> out:
> 	iommu_put_resv_regions(dev, &mappings);
> --=20
> 2.34.1
>=20
>=20

