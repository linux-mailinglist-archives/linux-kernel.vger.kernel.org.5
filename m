Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FC57AA6CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjIVBy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjIVByZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:54:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C359F1;
        Thu, 21 Sep 2023 18:54:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIsleC031530;
        Fri, 22 Sep 2023 01:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=zagvB+Petw4mAdXFpJ0jSy3bnvE613fSue8jL4GlUus=;
 b=GiTBvcte9q8Nnbmxu0YMRrvofEs2x3XuJZRb38cSN0yWhWecoBmRHeasrNn25O3miD4+
 /DJpykcmsRHlWdLtqmAaj6R9WEuuQDd1A6EmvyciAyRiOxfynRgw0raScceWVd/hCqVW
 67GHVqNn2yUPrQ/cxp77U3nZViq5T62ZAJqxeYajt+eNXg6m40hmUWebcRj8IK/OiReZ
 gurOTxrAzVEp3zE/pA7dS2fAB7OdDyeu17RKFR/7WkN6lqT+cPzGc34oo+zuye6bupR3
 fGA5CPyK3Z6tpw7ciK/08nj6fvfQEDQjrfOq208/vr6B88CDOmE3VRHFbqFTrso7JieQ rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt08krs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:54:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38M1XCUZ033863;
        Fri, 22 Sep 2023 01:54:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8tt7d5eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5aJapef1XBaMTIVhaDd3oHz15hmNbtHtZMqB6wODS205MtepAj6k4i+Mh3k/7v2u91uMWHU5js+BnedaC7Ty07RxMVn4KpUInNPaIDf8IGGAjagAjw05RcTMbCbi+B4aOJOnWpAfa/Zxxkp9lqlCTf6NX0fakD/lHpPQhQX+iUFfLnsU0GXEUYXr3M19k5aJBP9DGWxrY/xZSAUJb1IQUi7vDph/fgc0hUJlXmzIm21EV4WyrbsyEN8vDRjTKf9XAciibJP3bmieGUQnK5GX2GY0u7L4KeB1/KyU8xErYY5fYa6U2BSi/3NneJI34H2+hxlEc8tB3wFre329SdBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zagvB+Petw4mAdXFpJ0jSy3bnvE613fSue8jL4GlUus=;
 b=iEUv6/RY1el+oQTPrs/n55huQAKcTEI/sGz9hsRbaz6nX7ALXh/Db4RoAVK1+23CfC1wVc+6dwX/Szu7tnzB9Uno3QwtVNaRLoLzXIwiX1NEqi4cz5ksMhiK3ZuEcHWPF2WuQCfkXMCPB+p1a9uxENEyMILf/YfNtMV+shc8PACzk65pOApRgImg1cplOAkFAV32KyAEEtpIxl3YtSDJG8OoNepUplFp1Rtk0jQ4npbGerQ0bDS/ew5RRGZ/w0C2ZFFM8uZKmplVXt+iiNbCRHQkuWA9XegqvSzap4I4QDFDZGsCa2Kjff6L0V0fbCPuVBJr0gPyRicetFaBMcEcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zagvB+Petw4mAdXFpJ0jSy3bnvE613fSue8jL4GlUus=;
 b=ouGYczeL/SYQT+T3lFhre7c4RwwlUWCOn5JwCOju9bY682uX55gRxPdIumE7RE4NXt/QoUX7FJp0Dv6z0Q+IFFMvGYT6j/+MK1/GqH8DDBjRZ8Cy+gmSVWSuh33378w65RPVbS8s4VtI+a1pPShB0GXAyISbV77P4Jq/OoNWgiA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB5965.namprd10.prod.outlook.com (2603:10b6:8:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 01:54:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 01:54:08 +0000
To:     ching Huang <ching2048@areca.com.tw>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] scsi: arcmsr: support Areca ARC-1688 Raid controller
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lecz3reu.fsf@ca-mkp.ca.oracle.com>
References: <0608654a043206078d3a27d23cd5e3c2851ee415.camel@areca.com.tw>
Date:   Thu, 21 Sep 2023 21:54:05 -0400
In-Reply-To: <0608654a043206078d3a27d23cd5e3c2851ee415.camel@areca.com.tw>
        (ching Huang's message of "Mon, 18 Sep 2023 18:25:21 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::45) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a2ffec-076a-4aaa-0ff9-08dbbb0ecf29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgEMZlQadUE3HT3y3pZtGgAn2bXelldEQtyC9YPD5xe6ssUh/MZNbHzvogoNqEXKjjbj87IWXgRaHm28gipWFEqGdyIJq2bFeZ3xiOEOKhetB9g/QIVUKUMS7Pmtt76juHSDiFGLL3Dmh06dubpO/mxxc8uwkTjZE51FJ5mXCtZP7peprX4aWVt/hogvnwaV12tVXe3OrZzv/khxx7apOtwhe43bPrUNpNIqXGw2eZm5zkBRemOqdF2unQZ2zzE+xFG6uk/QTw/ptFKKoWpvDlpKHXUx1DrPcbvx4Zx3Up+uSFlwCK+ZZWUBnHnpIWnuzsxQUBEbBS3AWiU1FhSTHiQwKkluQA7M9UMrKNZhe6T0MaV0GEoErqXD4GypqRDG/mzz+30+j8C5HMq8vRgAvbSjgMVbsNz5VR+bCfpwsHyqv3OLiTVdlDgpG4f9vfmP1UPzOuWU2eUzoEz+l7JrCXmp7xLSEh1SvpXGFZVkYemrcWunNy3jBPyuWknawUgVTBVJ05RrvaMNzKUvYqmPoopNLE3ZZ7vnGKnay/nD/TvYBaZbwLr5j2PbMcZLDRLn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(186009)(451199024)(1800799009)(4326008)(83380400001)(86362001)(66946007)(66476007)(316002)(66556008)(2906002)(478600001)(6916009)(38100700002)(36916002)(4744005)(5660300002)(8936002)(41300700001)(8676002)(6506007)(6666004)(6486002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6abi9ckFKyzhZdFzfvtSxxSyyTxzLihT5aevLO+zwMfRoNhi6huDoUK11CxD?=
 =?us-ascii?Q?0x7KsFit7Y5luCuk5QMp1MGrycg9GOUtO5tOfrwFV8vhP2+dXUMjf8HCg8ns?=
 =?us-ascii?Q?dwPg0J3nGE96S/E88ILqnOkygNGt/iRuLnzp5invvvAcsAF6w7WaLVsxrd5W?=
 =?us-ascii?Q?JHblt6UGi3DCBToXbCvU3mjY2nyxPOiAlQjrIhVRqAucxpBYdWiZbumgIvh8?=
 =?us-ascii?Q?gULExHfPa+s6Ey2otHnujrgsJ0dvX6GNq8S1l/fXnrqFugzPYBYPxP7b5Hu8?=
 =?us-ascii?Q?q+wvQl4sidYzuaGOHVvw6J+HaUse0/NencOmziUP9E1FmM2wqqMl49oWKkhq?=
 =?us-ascii?Q?tyrsA9gBCHQ1jSScJfhD+n/kifiu3Oi2gC9QbhwwDYQ7dxesZUMKWz95SpEI?=
 =?us-ascii?Q?53oVJTj7VVZ4REdkIyG+eUuymu8Y31ZF+pMBLNTIeYFz+uDzjdempWcY741d?=
 =?us-ascii?Q?q6orPr3A6N0TtKOM8Hw/plSsJqS2mkF2X60ut/rCJVOAi0cxvXPYlLFDerZE?=
 =?us-ascii?Q?bNu2sWATkdyFSinAVDk+prbG1uG/0w+LMoqtKDxaf0zk2m6gJolZySFUoTsr?=
 =?us-ascii?Q?RrxB+8xaOJGkchKQsquXq2IWJoFIecg6EirbWH4k9+EFKk9HVFQKxuy9PZ8J?=
 =?us-ascii?Q?1eY6IhrAK6q0QCi2zXArj++eha5slFpecVeym2+PWhbULFjnh96RcYF9euDz?=
 =?us-ascii?Q?0HaJQCOgejXVq8E/iRcTZNF7Esc75VEoKXcDIrY1xysy/YN55pj5f4bBYGZq?=
 =?us-ascii?Q?czDn9J7r0Wu7uJnxqnWrK0evoIyJ9wJqcdrPribJG6w4CPHOyZ+7PoHHWqXS?=
 =?us-ascii?Q?IBiDhGcXoozx+k5SE/PsoYV0DNUm8mAzrqcad4lbljbEukqI9CZxl8OzGxKH?=
 =?us-ascii?Q?OQ8z8fcuOZ7P4Wb4AOuRfNpKZJVgyQ2lRJ4MKALST/3kcB6Ko+ojIFMiVK86?=
 =?us-ascii?Q?b12kHj1TdqqrDpbwLdmAIyvuX+tF7MwJa3nXcTV9ybRpytqvGdrosSZC3rz4?=
 =?us-ascii?Q?a6Eo1XFgo+lgFcS36SfH/7X/m2pPIi2ljg2EPU1yoz2lJvUyhMICDGoe1mtQ?=
 =?us-ascii?Q?Tr7TK3NN4NEugJPXyP6CYR+lSRXSP9q6p8rHicoPFHL+0B8S0GBbOMVS/n0f?=
 =?us-ascii?Q?/y9X6tpNrxNEeHgDLaESU6QH1/2U96TlyUt3PKyczCWpdyA+5i4VzH/NKrD1?=
 =?us-ascii?Q?y+2NKL0+/GDGZH4MjY5uHwXx4bdft1ImBzv62CI45Ewt8BDqCbN523Fwc0pc?=
 =?us-ascii?Q?HNgYNMxPMgCKOqVZgJe5dVn2/K0i1tbGw41bCnv21UdBRM3h/oag2qrVMXsW?=
 =?us-ascii?Q?SGSWZTTQIb3dBASLip0r5ObQFFh+eqvpqvUejX3FK6mBmuJIhbNxR9QvY40e?=
 =?us-ascii?Q?a6flzwR5Jo2WwjoKBOv5GtJS23Siswl3B2mdh8MW4YBPcXOwp9iw6au3nlIP?=
 =?us-ascii?Q?kT4qAqk03H6RAgnBFs/xtFZAeh4PJyAH/GfyBf0t3QCSkSMruZBByDmTslQx?=
 =?us-ascii?Q?AOR7w1WKs69e+smjJp2WOI0/B2DIiDBvfzyqcTmd+DHGe70csyC0bLFUFtzI?=
 =?us-ascii?Q?JjsFVJ4yY1R77B2cdowSrrDR7CXwmDtDrRbivKwcS06tXvw2x8FEnIs7nDRs?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +Bo2qrHfs6nryqucW08rVdUH7xU5rnm6ph4oQBuB+qm2ScqlF3PytUSMTKpkX1s/QS4TBDJ5+apOMI+sP30nokaQ9Lb/vmRJGnV8nVi4WFBms0Jwt8KyHcZ0yAPW2rCxeEfvvfoXtNMXqZiZnz3XE/5iiO07VWLw7l6+zLkAq/QEPdtlpznHQRX4JXPlsiUi3Xxkdt5dwyAUbBDmGcnQ+oEE5Q8Y6cirSFKShWIDMPD85+tJWxuMMX15+nqOR9x5kYwxy9RmHd0l0fPloyutm5S9eUECosCwiPO9S/M4av+2e1UvqVIYYq2nHUuPOcbw0JU4hmf9Hv8tQdbt7lwbCm3qFDsJCYOXLT2rQYPQ+cq9mT2B4NknWmQDE0dQfrtyWT7AipQbY2auHTd5tGVWRRRzpu72jF2C9/ZHMcaZvQQCXPncS8KGK6A8cmWrxAdONDEEH5Gui+OOyTxx5797XfF3LLI1n/HwuA+FQWDWlUvCW3BsjkvBVSlleKZ8LZE3VHDAg60qx/8380s3lD8E6tPJA2Z/QMeZ5BlGHLbz0yTE+PuyYzEBpd64rK86gouhnoXcG2qIE2S5mZmeSnIxXiOZ0bVRdIsg4HKUK8wh07sPfd5l07InkCYlL1nuFUPJeHPJVz2dptpHprOcqetHhgnVkolVRp5UGLXUYSieHoaZY5yo1kI9r/kJaEGB7D0jGZoGzr+MUXnYC6OeaINGtpHgpv7fFlG/nTrbX5WQ2+7HWT462FYq9+h0jk0FrQ3tIxWfoxqBmEtywkDuKiHFlMMhXXQik/hZBBrAmS7sSCSjK/RUD6/5ZGSz44XbQLQxGhv8LdC8LJdgjfLhJhL+Pj4/36NLjGzqKX9irhV4nnQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a2ffec-076a-4aaa-0ff9-08dbbb0ecf29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 01:54:08.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKVCTYPQ9XPJfGXKwrvOLLX7BH9tdH2AaLczKWIN3vaEAICFgN5NQSpVBQKqC0wk0wlpaprLgc+Rhln7Njnpf9yQPduWS1lYYMiibw8bfIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_01,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=763
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220015
X-Proofpoint-GUID: F7bJ4jfHLaZYwxzdIILDDwr9524qKr7Y
X-Proofpoint-ORIG-GUID: F7bJ4jfHLaZYwxzdIILDDwr9524qKr7Y
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ching!

> The following patches are made over mkp's 6.7/scsi-staging
>
> This series add supporting new Raid and new PCI device ID controllers
> - support new Raid controller ARC-1688
> - support new PCI device ID 1883 and 1886
> - updated driver's version to v1.51.00.14-20230915

Your patches appear to have mangled whitespace and wrapped lines. Please
repost. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
