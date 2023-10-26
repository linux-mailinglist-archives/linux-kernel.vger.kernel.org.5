Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA97D876A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbjJZRRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:17:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605FA1A1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:17:02 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QDiARX001586;
        Thu, 26 Oct 2023 17:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=5HK8VrtxHIRyYi2wUCbfDfVxMeUeSAxNXyijP+8R/4k=;
 b=hd6yz7CQnXpk0iald2bfMwYTKBHjNO8tMOc+h0tN8ITXkmLo+lG8o0qLShdA/VdKCtiL
 FQ9zbhX+VXbN64bk99vqrMON8OeLUSmYCzwuxIst2ytyODRJi4dSzgy731IludzluqEA
 tcOYsegdIDP4dInbX0+K7M9WmUnb0vrBhoPzkILhQIDNiJiC+I/jyDkGrlw5LkmtNq/t
 E+raDvgcG8FMKqC9iupbXRq1wghbVDLvb4Z94phrEHMfwBI9QDyWpNqO7vfr/4ZF9gZe
 d/HN2gLeb7NQx8McJiShoMYAS/7w0dq0kOgXLfKQop4wprotir0Xu2DmIwPcqQPDuc0x lg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pd3paa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 17:16:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39QFrZgb031147;
        Thu, 26 Oct 2023 17:16:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53f0ta2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 17:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOAWtmZlojZihhnSYNDRuHAPHi0FHc0p6Pqne+SJ3wvH9ml2cUr3HeDcUcVA77DlERIAC8xtCum6rtj8+ME/H0oMSEgHzjSIL/z7dJUk7q9v6EhZYdcOrHWqSaxHB1kjxdf/EKOJs8+xfUTBOSrvyKzEehMhDdNEyuquMT//A/V6HNg2wXEMJMX4A7/WENdLKC/PadZ4LVgeKym4NSGLQH7j4g1aQXddkYUHE1fM0xyEzgFu3vF5BuAD2CJ/EvpzIcIY5Gjy+Zmo5MYC4fTgh/hWtcee9SgFfFHeZHG/AxebMkerJG/ffgZaLx4aFYoLcCulYxar609193tQCLTbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HK8VrtxHIRyYi2wUCbfDfVxMeUeSAxNXyijP+8R/4k=;
 b=Vrf8Nqp3E0Noa5TtBFyyhes1V5NNpRUpMJcTkRlI0MjaerBzgeJCP2YxTRNUaQB5qtje5/Rb18lABtlGbwRU0o3kG0dllhcvF3IKBkKJhmN/iHqmJRCDHucnl7/gt0/DB8Wew49hzqyawpK9rEpFbbk+KtHDthrSfsG+ShUMw/hpfTB52yL3ye0ocmGUwiE6Fw6sZNzX19RVFM3Y0tLmnZoUOVa5IGrn6iZu0qjKEsu3+tXwqdaUW9ytd0O3nFRSmBQJD206J58Rdnqysw440ebPHWoChA1HUcDd6Rw5xGPmYHxJkE7wBl3lY5aj5FRe1si0ad2RvM3MWGR8kIqzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HK8VrtxHIRyYi2wUCbfDfVxMeUeSAxNXyijP+8R/4k=;
 b=b75AM3iI4bUqmzV6llhjWCayLu0PYnYy1J26GV0OhMw/gD5iXJKulyvc8BrXskzTw3TaHITO/xORXr2gWqPvWP47w5MBaUTxAtmake61HHyFWmJuB+U+J7riwI6mgNTqrGd16MixbHEido1EmaH9HPH53NsRUZVPzgrE+tzMedw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4485.namprd10.prod.outlook.com (2603:10b6:510:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 17:16:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 17:16:38 +0000
Date:   Thu, 26 Oct 2023 13:16:35 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] maple_tree: use preallocations in mas_store_gfp()
Message-ID: <20231026171635.3xmpba2cuzjhkcxg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231009201639.920512-3-sidhartha.kumar@oracle.com>
 <202310251706.6e6f6c4a-oliver.sang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310251706.6e6f6c4a-oliver.sang@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 261613a6-b912-4b9e-8df7-08dbd647502e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3oBd8TS6MKpgQfAafa314Ce7qbIZar2Z0wLecmfEnrIb2c3IWfeOa2UP1OhD+DONRa6AOFUuxP3BOIEm6bjDMYxDVHsPvbFqxeXNi2AAtu3I6SdaCjZrNh/9tlSuW1tRqnuiDltKy43H//NHSXY0pcR61f/LFymkOJitat/me8Mu8tfAbYXbbtUgzmRBMOG/NMUBc3L4r035KGsVV9vF6V0fZtCCmPuUt+5qY5J6Bq3vg+3S3nuftSZVAc+1NfMI4Hi/CJokPPDY3iHHfGN3o05pV6u8C7xH9991VNLyHyKQMyqZehI7HBOUPm5KQ45feO2YNFwZaiDUi8edRspu6EiKxxI5WvIulxTnsDEbWJMEKOPejiI6w6mTCjK0UqDfOdgnGlmcvyCZcT1yXLJNhsguyraMgNy7wOGooDo2+0tjDU2Lnjz/5ltfU405N+lFvdeMcmKD/zU5yBkWixl48XIvF09ynuwxoyTJIR6qOvowVyPumU1AtI7t2vFMtvKMaTbmEdG77QYEU5FSgDd5oka3lx5tSIkUiDZ9cdRicQlMAw7+Eb7THmqDSa81SJj4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(8936002)(8676002)(6486002)(4326008)(41300700001)(478600001)(66946007)(4744005)(2906002)(316002)(86362001)(66556008)(6916009)(66476007)(5660300002)(9686003)(33716001)(6666004)(6512007)(38100700002)(6506007)(26005)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zOl8njc70KH0D6OdmIsNzOZ4eumDD+uEw8tcFkFDUFspfeEL2H9Cw37QCc7y?=
 =?us-ascii?Q?hOdrP+1FGk7w2cvPMLZAP/QPYSqRRfRSk16y4n9ofi8rkUo1r1B+xUPZBJB2?=
 =?us-ascii?Q?H4uU6IllOPuqhI/P+pilJlt2d0jgZw+bMY1mj3KBpAaXBwaFAAWBw/YVGcAK?=
 =?us-ascii?Q?ptWb8eufB1O/psciyJgWJ7y6Pe04ufrRTVnxbtkEpuE2pbcrpmYKiju7poRp?=
 =?us-ascii?Q?kO11n8LKDJuhq1KWsoBQadXBkcJqOzzU/iFNGc6jlReTKJF8RiAtj0oth9cW?=
 =?us-ascii?Q?w83nlYl0Y+njqJCZLgFLmTpkDj/DkdxyReqExaKv+nyLpxJVjmvKNWFKhHz7?=
 =?us-ascii?Q?2G9c8Oj9OgnjJVs8TyDSAgzFkUPln8yeUliJdFBcvmMSNdOHyqE3EkKk+4rv?=
 =?us-ascii?Q?oT5NV/59he6ubXF4xCPfd3OVRgzH6IIMdnOrLPFyaWkjkaCVTbS6wX3bgDJC?=
 =?us-ascii?Q?9LTpGqnGwT48d2//vNovuIBhrt1sUhl/7ViBpC7eJsRdIHJpegOrOeQ6AcXj?=
 =?us-ascii?Q?d6lnHIHNJPm8Q5MJVwmS2LzSGp6KwRPGbJuyTTF8xt08X4mwHePG1p+hGIUY?=
 =?us-ascii?Q?9bb1qphK9qRXdgaB2JH7zRFf8UKngRiQHIJ0QqJYki1rR23bDTOLj6PIUier?=
 =?us-ascii?Q?TOibYAfu6QsdizYDa/9vrbZpVmUgWcQJ/C7/mS67Sq8lGDzcS5TaifndOZmZ?=
 =?us-ascii?Q?ZiXrG7Je1DAZfLPw/TljSxJW9A6hrKsKjch15sMLMOakNxXqeFXKFoNogrZr?=
 =?us-ascii?Q?pMpXl8dF8ZJ5dEDJQLGt/qd6nQJVlFINIhYLcfX7konENoePj0765qg+2w96?=
 =?us-ascii?Q?WyZ9NQSf9ZKi+kyjaAXbstXTgbKCszZoN7fAOKSC6/VuWeiw0emfRrhnmyyW?=
 =?us-ascii?Q?BOla1qsMh34GUeKECvJBzMQklhqj3uiQ9gb/Ag/Cxuc3+EM3Y2ShEweSR6Cs?=
 =?us-ascii?Q?jUZ2OxFFxvF3DoDH6zsSHyvs95sbAHtpZgeCebjPOsqiooH75+b0hmnzX1g2?=
 =?us-ascii?Q?vHeceRX9KXNJNIOqG4FhLWMZeeqxX+dVYMbPEU1cTa07klT/ctTbxC3JoqjY?=
 =?us-ascii?Q?WH3DmoZT9lgmD6gktuu5IEatyHIFABbXmMW29sytphAnGOxPPuDUCAOf1yTQ?=
 =?us-ascii?Q?I5U/2LgcwLAgllyFldF+04Q9RVxi6ZTRNqIROKirt+qtmpsCIoVlh9jtK7yD?=
 =?us-ascii?Q?P9KsDRyjklmsCfMv5gz2CqPn+US+GohhiguIuvRFOFbs+V7gJ7cb+mvwVd6S?=
 =?us-ascii?Q?ZBHPX4onUpKfNgeJ7SwQxvzPd02cro8Oe5tEOzjEVWyiiU4KmPRUrjUUQ2Bn?=
 =?us-ascii?Q?UO32R+9dCC2LKlPkQbbia1Pbk3Tla62YWlpW9Ypmox9atUEiJZU/c0kmibsv?=
 =?us-ascii?Q?c5lAFC9cJkHxY759tTz9Q+fnCBafft0YoiAA+UAWbv0D7XXAWbJYp3bNsO2B?=
 =?us-ascii?Q?rwwv2mQNasnctSAEp0lOsfm2ISNSgC01co1p7olWwO+xmUZ3PR003BCnWbqQ?=
 =?us-ascii?Q?cuCnd8XAwr07uT+ZERYvt62KIBX6BrgliRRevIOMaX2RjnmNKIxlEgL6cfl2?=
 =?us-ascii?Q?Pu91gPxZbrod6TWAet4elxGR7YXdSUcO322SXZHN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LpP5ihQGgjKIILbWTS0I0ZpS4/rTYBDgKRnrB8hx7blmjWgczj0+6xUPsmbnvwBQ12U0LybfDgTL5HiuM/PkKgSK2vy6r3NCgPaRhOzNRAWL70jlf70JU0T46G2/FKHm1dUoPTThUFouQuAlQMLQsm+FXnCKovpJuSrORS4qQ5tpmzqEB7sL4Scn1/UfvDOSuipdeyHNwQZ5bVfADsEblnrwNdMWa0BbWloI4Sx+jyPTvBMitejh/iQ9DMkoUjZzGQ0wBle5CsOxAczHiBFn2FRWqZ0u3m5e8e8tolAguH3qmXBr9pm7l/OrVJLQWLPXd6F0rUCZPCt+oAjoDx+iDUr27CY0czyODwDAAubeRQkr7tK9uzcgg/KU9jSl7oHdegGI8O/LzuV3wGjarFIXesBZVoCWAUvXCF53RR3urjvTnYQXg8dsQrqyWPkb3zbrBNZ5/Y963+Kqaib5sddKFS/DGtACnbq3w2CGkXaW4xgQz+7yukP5et1bBpuPgM34KDHKg0L9wbSW0meOtogu6FryNe/vTJ1fpdaQQ2y3KdHN8ZJoFB7WcuVtsQqOE6Z9l6qVMqk8S2jDaglx73mZ+4e6M/Gwv/6HOW270A1DlrtIG7b8jhFIE7SnqKL9eGH+pw3y/CuaYaatJPKZ5bBqRBjI+qL7rQ+ih9Ype+Mpyc1uBB5MW7hBrvoZMtz2QD5f8WilG1rV18ijB3iEb76HlAMlTgeR9Mys+3HOehFV7Kg3E6ehm42bHK8T8fL6ta40Ozxhp0gdM9zv+GhGMilGoznqUgG0lzWZWo+T/1/I9josBRk69BU4NYGWaHBkRtJ7y6baRtb1AUxmah6lD1d+NGVsRZvDbZfhvXAndUoz39mw04MnNVPiz5jXPVRmvY+5LpUqgCwtlxbumJq8GjD8sGsP1nC8l8cl9gYd3E8PSAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261613a6-b912-4b9e-8df7-08dbd647502e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:16:38.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeQvaKP3C5vnl0KFlCimNBA74xrV5d6hxgxY6WjLGw7GEK2+HKAmNY3iCEfx/r9q8yNfhfU1TIM5IfGemdJMaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_16,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=556 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310260150
X-Proofpoint-GUID: C7za1PVnMLLN_b64UA0LStv_rIxXPLjQ
X-Proofpoint-ORIG-GUID: C7za1PVnMLLN_b64UA0LStv_rIxXPLjQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


... Dropping direct Cc's in attempt to avoid even more noise.

* kernel test robot <oliver.sang@intel.com> [231025 05:52]:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:
...

This patch set is being revised and discussed on how to make it a more
complete solution.

In the mean time, is there any way to stop the bot from emailing
everyone and burning more power?

Thank you,
Liam
