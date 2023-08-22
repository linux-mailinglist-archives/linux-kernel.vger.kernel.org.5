Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAE178485F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjHVR0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjHVR0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:26:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900E44DD60
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:26:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MFndZg019336;
        Tue, 22 Aug 2023 17:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=g75LTQW146iku68GrmoxRY3/aQ9UV4PUG6IWfn5tsBY=;
 b=ZN0lI5/I3H5L7aTQhLEfQUB6Ym9eOyWPX+pD9avpJ5j1jjxHZgjybGiHIlR1N2R691qZ
 irHX8FKCOs3nBSL33S99rDWJKavgiepVUa6gWte9DtLByFgU0xIDMhQD8GByF+0DjYJK
 lb5lHq17j3OKssztQH8inJqpBR289+iCDVVKCwU2aW65RkBjy7xCl7SLNGJTSujOQ8Q1
 M5LQU4X2F53+osW/Bp4Ss6nJskLokkQPydi3AsYDI/IX3dnachh1F8GMSfTvuC2YH325
 moywYT3NK8S6Dpu/YwEhAzPrm5xOv1S67XJHxVJHgiJ5RjjbYYBkw7dr8nsu/62iFyVh lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmb1wxbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 17:25:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37MGTVeP031684;
        Tue, 22 Aug 2023 17:25:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm65eak6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 17:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7K3JcZeHqY2eH++aOumfIvWDcDAsCO6j4zlgRKAvzD6g6dVG8fn1jkD3lCfRo4/SuRgAHXza20YkF1dzlSXv7twBSTqVSqhREgCcqpDO0OUaDfko/bi4ICw9PMifk8DkUG+wX/vD97SKejuV8+9o59KEF29IRl0u3367rnIQ4SHSg1Ajytaa/V5VR9UOVJBULEa27+vheHP9Y4xgdAS5C9cwQnzmU9Ka7CGj/PQHP4u6C5HziQxDYQKNT0alO1RabboFeLYhpmpatyezikf0z3hxzd+ivvwhehM7PXpOVzhPg/b2pnwi2aYzBMILNVxsFVhJXLTGCMlJm9A2N8oDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g75LTQW146iku68GrmoxRY3/aQ9UV4PUG6IWfn5tsBY=;
 b=J6wpJKpX5ACeg8JlB04+XD3l9JNi7t74tBKwT/0+lHYXy6BaW1/J005GXjeIASbOKaxzeD9Y9o0ZsRjgMZyuK5gAZgRU9KpA6RpCEao/D2SjmUltqxKJ0FSupZii6f1xA79KyhkCHFazqD8fTWVf+akmh5M23LSPMedxExNsJKY7UYzk+x+cekWwPa4GxDP1I7bp9fjIZiFATFUmSzxJLPJ+tGasOmn85i7ZchfhKsarNsXl/Zs0VC9fERDgiVpkrJsesWtVoFGObibqWt9xU8t2ofVzkiCpAOEg7gqY3Dtvkf/pa8txGGQxp2Yi2I2p5RyHHhLTdyjudXSoZgNlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g75LTQW146iku68GrmoxRY3/aQ9UV4PUG6IWfn5tsBY=;
 b=0RpEEG62y0DU7+vc5GUcRidCMsNueGMda9ZMxUra23Yo3v66Fnzy9iSV63+ISSvW2SV2LmGwVqbXJ+Um0BvMfYk/uhEDDJu6B5HALd7cZMjeRfHVB36SiSfl1CrcD4Jf+Qv2GHBekiTw26OwpX6VW/VxwVQvXby7MGLul/hhPBM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6524.namprd10.prod.outlook.com (2603:10b6:806:2a7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 17:25:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.025; Tue, 22 Aug 2023
 17:25:16 +0000
Date:   Tue, 22 Aug 2023 10:25:13 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     syzbot <syzbot+7423f066b632d9ff23d5@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, muchun.song@linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        willy@infradead.org
Subject: Re: [syzbot] [mm?] kernel BUG in free_unref_page_prepare
Message-ID: <20230822172513.GB4509@monkey>
References: <0000000000001f4d4806037fc7b8@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001f4d4806037fc7b8@google.com>
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fd3cf5-8631-40d2-addf-08dba334c087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maZwVZ2a8hIcqNSr6oSwmi3Su8v3NPgYpPN3hNiGXiOByMw4VOms1BtLxTwctpvJA2ag1XVupfSKGUfzsR9px3pto8HBNtrgY9HPWR6Rga2eM2RmNW+7d0MQZnT4tLGtBG22bvrXXgxw27tO0Gtrgl/3JbnRXNu1HvHbVc+o6ZkT5MDyIZEjJo4xp2ASXbCNtkTeqLO3GCQzY9/RR6CGevTnBVr83ToI84ZdnyodE1p3bl1CG174RaE9fjYHwV+SU17bQeUDfHehrR/VeNuLyeSC4BBAxHpl+it6jmV1TS/LjHtVZ95NRgJgFui1f1Tf7aQ/MGDGXCCyg+2Ul9FqntmIA72gmr17tMaL/CLC1KrI6PBD+IE7Z+7L4T7CmlqgysXmu2utHwxbwHTof+3UGvtKxq0FYf8gF3MUfiGmUdegjgtzCXzMLJCKJVY0oG7764yQjpHjHdu2Bovnvflpqs5iDyturaYFcOhmkBkHRjS5bBBAIXhGpDqpV16cg7s6DCaGUY/vGWXfB/jJRyt9nEAmbydCQ0aCLjhB6CmyY/7CKEtpFq3V6EYNj4Rtvno0T6n44BiWQbICUMBwFCqATBUtPvYNcoRQetQd0D28Cs83RIs8EiFOngV+hiziJvOTMEjmvxYkGSvOiEzhCsQb9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199024)(186009)(1800799009)(2906002)(7416002)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(44832011)(26005)(33656002)(86362001)(8676002)(8936002)(4326008)(966005)(316002)(66946007)(6512007)(9686003)(66556008)(66476007)(478600001)(6666004)(1076003)(41300700001)(33716001)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N2DDPDqC21GjX1KOlDTZJsaVG3EJGI8Uz42GMJ2V9Qy51vAr/eELj4F1oBjd?=
 =?us-ascii?Q?RUvX+deJYOZnL4ZiSGsUZF8V45U+hEhIliewuA/hUv5pgj2XUXS62rlhwmTI?=
 =?us-ascii?Q?lbsYrJglM662m8g4si8JgoqNSCuUQX5zluqp4sbqoS3X10JvSHBnldndXPJh?=
 =?us-ascii?Q?ubNBKbjj4LwTO5ptgJkF1trGZNraLWbcxZUHSM5LAYgXS9TE1RGgw5aedNkw?=
 =?us-ascii?Q?lT0dM2lmO9JwpTdMXliJXNJfkqyFBGCLkbzDO/p1zs3qCxHU3azs1p4Ay3MR?=
 =?us-ascii?Q?txGnNigY1s8jKmsvd0LMlEjFrbGgaSKysXEWHr3KoJzcs/d/SNvL8GmJuatd?=
 =?us-ascii?Q?on5muRnhrOYFfNtgugE70Nrv1pOfro+bD2oZo+YSABN06syLkftcduG4p9zS?=
 =?us-ascii?Q?ABFVB8hKh3/7MYEmXQaO+L7kjNcaNsKD08Z7KfhByX8uUPvUH1x+G9pSkOv6?=
 =?us-ascii?Q?NZrFnHizot/xraHj9zP7uFVfimJAGqauctkjkVc+dPu2Mx5eQgsZYwst1rwp?=
 =?us-ascii?Q?4wtyFXd1ZLHm+7jPDE84253tVMZ6g6rjD9mLeEP+ACeJuw1TaaY4TdGHSQYC?=
 =?us-ascii?Q?cbYgUwk/m7sGr3T7M5nhqRiRy8qbLU5gz4zEo9Y459yCt2qSw8+BLsFuh5gc?=
 =?us-ascii?Q?yYnXCnA76mGpc0B0csXhgbvaF+RPQSm2mMIiKEklvoTto8w5vqJBimg9mCG1?=
 =?us-ascii?Q?TXpwFyLJ0hnp27zxb84f8lP7GMdSixedBQU6LNCVO0stCqsctwuGVgucxyH4?=
 =?us-ascii?Q?k7fmLCcbA2Aba/hluOH+hqYvmqP2AxzLCSBXNKDivJNKawy9xB1mJkAi4Wfm?=
 =?us-ascii?Q?0pYdnqUDTz18ATENzRGqP3a5h5Vi9i6UbXttcawIChlzxSIAAxFTRwhpG3pK?=
 =?us-ascii?Q?kUUiTxLG3qAAGwIhBR5IdbgWAUH3G+Va6Rof0brogNSAB2/yGXnyi05ci90p?=
 =?us-ascii?Q?i/S2k9ZJhNb/nSpU5mhir90YGdVHIRoa+61yQVOZ0fsoSgyzOrKM/GC9wlL7?=
 =?us-ascii?Q?hr5gPsDdnacrRKgP5xJKffBEhPEhxrcpct/NwtElXh1AyxjrmCEnye4xwrFn?=
 =?us-ascii?Q?5jg5TLHmPhpUlARdGG3rtT/H22M6nL/s9OfWTnxx4N+bUAopquxxHd4hgPta?=
 =?us-ascii?Q?Vood0jjkO9wjA345ER40CUB7gOxda7N5io6zEREFq8dWh+3X00ZfySxS09au?=
 =?us-ascii?Q?NVo5UPLf22hKaEZrRRUzYlxGnHkrqo6CWfH9gPrKmoT9y02VMAJCGZTeT4fI?=
 =?us-ascii?Q?SBtkQ+pIsmg+qXMkXVqRhxMHsFi5yWnLnQ77zGTX8VcpYNjPE/HdEqcScOKX?=
 =?us-ascii?Q?G6JjnSB54Kz3gjqh6cQx4C8V+j7oHYxThSUtgP/0ztIkGHw/9AhFGNvv1RKq?=
 =?us-ascii?Q?zslWDsbYsmyX6306TxOhRPUKwDTT0GgY+AebRugJpBBxCAKkV0Fl+e91CSjS?=
 =?us-ascii?Q?EJaUQjh8t0Ga+B1I/UE2amaFVlUbPwUEZmmdOrdhJMBTlG32l2S4WpcsesVj?=
 =?us-ascii?Q?AQIDHtRL17b8Sd3W/C0c5YX1J906NQay23e1x4tjDvWWDqMa5H306HvkfaLN?=
 =?us-ascii?Q?3vL++vG4BfTLOP+xFqLJA9KSQbnNjoQF/8Us/kHuKN8y8l4nhxQ3VUw3IIIl?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nS+zjhSdvNX4BlNOlCLB9R9/DyDCJlhCjKeVkU8VtCsHK3fDocIHBIykd3+b?=
 =?us-ascii?Q?p4H1+ZmW4BeKDjw1dLIckxh6f0Womolx5bYLyJtOvdufWVZAvkyUfoJDbYaP?=
 =?us-ascii?Q?lkya9XDVd0fr7AO4PQJG3km6BfCHpz2OiZDKe+HyABKDH4LRNn528Pjsc064?=
 =?us-ascii?Q?rGrwuxQrPrtVVmMOn8vkYCvxiUr59ZfSU1GMJG6HLsW/Yv9BLnvCaIBfBwQU?=
 =?us-ascii?Q?618VySXxCnk8O9yyh8wwc7JnalfHYJorT65zvZNHl2CgzYRJm6DfGKP7/Wwh?=
 =?us-ascii?Q?aithIb3VjUBsW9dPUur/SgP7gcDW5vSUDf3plKo6EGEMNfTU9R9T0MhfVHfh?=
 =?us-ascii?Q?w0sY7wI7BMkQ3k4I7RsxKtgaQf5jpPbkTMRJpl+QSr4DpI6zhDN/vnsC5MkN?=
 =?us-ascii?Q?q4YIjvODWWjXkByGo40BbO2006BE8IuVhTk2kufWhRiVw40ZcBefQuTd9IIM?=
 =?us-ascii?Q?JlUC392R3RHigpMsjjwdykACXAfDGznuBG/HY/juhEE/aPhLDEV0LFzCybo6?=
 =?us-ascii?Q?3NZgJedAZ7g8ovrHzv2Xh9U8xJXDsveeugoUr6ExQugGIwBQtMGUONwYtIsr?=
 =?us-ascii?Q?Lr/4YsNtGIGrcxGq70BfoxFKwXSvFy1tGqUQKmHBAcGm95/3g+QTmjL9aQLG?=
 =?us-ascii?Q?2bkJ86mOyKc++a/KfP5/m8kewOrJTDw58n3lXxX+rRAF/8JhbNVKYHv9Tvry?=
 =?us-ascii?Q?j88GD0GQGCt0m3ImCg4r/BZSBaju3k2xlmbyluA34VfFOypFejUfXcLQY5Yy?=
 =?us-ascii?Q?pSCiBXxR8rfmdXKG0TqvKqrqQUtyadHHomJGdFy0LHqvryziHyc8HtA14O8M?=
 =?us-ascii?Q?BDSSHKODLOyz+OLXHijnVmedGfAaGXUdU82R2bENiZfH9FJIWtTeU3aibYvV?=
 =?us-ascii?Q?SARLXoR5G2jcmjLjEhqMv9XuRfsuZdEuGfE7N8bB7U5yCGKRjoD5yeK+0jA8?=
 =?us-ascii?Q?9R8TY7X0kVz/xdrcMAck8QIwB52/N/PsZOuHc5+BeyAt/tY5HEKD1RMw7A6f?=
 =?us-ascii?Q?JaTIgM2qOr56lOxbxxoZuQdDHD1H+qZShyv1gZdEbp0MqE3O0PKE9VfDSdb2?=
 =?us-ascii?Q?0lUgj3BMaWy6UBZRhro3qYI/8C475W+xm8xhLbx86dgw2dku70306sGFeiG9?=
 =?us-ascii?Q?fYO+jSMSndLvIgxygP3O4WaTE0XdP7V6Vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fd3cf5-8631-40d2-addf-08dba334c087
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 17:25:16.9360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hhw2XjR561FrAEJY2cbrpzbSrriei5JdRJ6EA5FyWi8UvBmPJqYn62OEWNMuxrNhlwOK6Ak8mqFja53pBiXqaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_14,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220138
X-Proofpoint-ORIG-GUID: rSlj-3Vs5vuqbUvmNxmolUZhISqovNYF
X-Proofpoint-GUID: rSlj-3Vs5vuqbUvmNxmolUZhISqovNYF
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/23 02:39, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7271b2a53042 Add linux-next specific files for 20230818
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=119dbe4ba80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
> dashboard link: https://syzkaller.appspot.com/bug?extid=7423f066b632d9ff23d5
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112386f3a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15044717a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d81109bc02c1/disk-7271b2a5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4b3bf8e2a4f7/vmlinux-7271b2a5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6404cd473c1e/bzImage-7271b2a5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7423f066b632d9ff23d5@syzkaller.appspotmail.com

Looks to be caused by Matthew's series "Remove _folio_dtor and _folio_order"
It has already been noted that this series caused issues.

-- 
Mike Kravetz
