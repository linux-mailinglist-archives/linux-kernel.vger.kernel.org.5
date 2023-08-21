Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2353783577
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjHUWRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjHUWRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:17:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E33613D;
        Mon, 21 Aug 2023 15:17:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxUXj003629;
        Mon, 21 Aug 2023 22:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vWzAaH/zEIQfIVFehhhmXLMPRKDs4E6hxgG1V1AFUmc=;
 b=UFLQv5/BpWuKDdFyuss04tcKts32z8S/G4DFtZfOShCSoRxOUPG8zTimanmOstai5OjV
 qLnC7MyUbsVqpkR5kaNTuk0Tnu2XeNi7Zz559yKrRvkDI9pllNkrgMXL1nIsHXv+42zb
 IVN1WVY+dhv0XH5BVQBB94dSIIOkO9UgdFaaH55sy/A5BWTgqhj8c3GfFJ/1BrYYBxky
 sYjVKXG8rTyKC1IqLrHJ4Chm08+b406E69rucz7QCXSrC4bvoMVEsMYQZvx1oUFSlqmk
 O2Q3cpRmkZQ50kli9hS5gPKZOxbTfQkSfTtgkfryQrDt6sMOKXrzT6jOj6FR50g08Vj/ nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmnc40q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:16:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LKH8sr017566;
        Mon, 21 Aug 2023 22:16:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6aj0tq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 22:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMZn8y0p6QgpTHKYQLKzCiS3WLUncmAgUJ+GneG6q1NtFDEnxucWDPqzLrjURiSyaXKMSAQ43wZFPQTKokGkfdBA/Q23RzteqbCbM7x9DWWio1nHuOkXTUWWuzlnydBRBhVeOnhG4piFd0iJMVSkp6yr/ePUf1940t4dChgfyaf6e1vBZbYT+lDYD52WTY5iUr55aHetd0HStdoCxGgGnBJ1ZPB6y3+rq4fNQhTqLWGgisEgbeK/SpBG6nmVa+pLTPGQga3o+Z+Xa5nBwBLnQrF8Em1IjlXXSBvIAWyUJp6M1QCpDpYA4Cnr9oXG++ZaAKZBzBTr2VqX2vDTgTChQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWzAaH/zEIQfIVFehhhmXLMPRKDs4E6hxgG1V1AFUmc=;
 b=HHbs0rPk7IIpjAhw9iempIYL74XAQ+oQU6YG3Y30CR1sE4H7VAjuLBhJWoVMnynULjg1h130eUZ1B18BM8s+nY6UE9BPScB2uox84rzh+hOh8/njVc3EMBX2tVZsNNNIiQkrwAJFqqnRWvpNop1Al6O2tooBV7QsBgOORmrNprsOLRViNAbpamAJ0pLMOGyzRUR1Ij/DaOnE/QNGb68VsOb4Q7b2fmxL/zEcrqIykJJMRuwqmuvP3JPXoOK30Lxyxc5fjNgjIj+X0Q/VbGN70ObGWO5CozKp6f8fCLwA6L9NsXB10noNfJiLZOyxiNlev7UhLgQDgV5I+wiNctmSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWzAaH/zEIQfIVFehhhmXLMPRKDs4E6hxgG1V1AFUmc=;
 b=JbHZxlW2uz/IQtoDOIPjuLNNqPtfpsteCr2MOvnPlcmvOXXciInZZzuJGYF6a5skDgSGkmgwZ2s61ygZsOsOMLV2LriA+k1fkCdFuoQANw0UQfbnoYNGXN3ckDGGhnQ3c6Ue5CMqHWlqyHQ6oU55isN2ltOVyB8bo3zmCzvqoWA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7955.namprd10.prod.outlook.com (2603:10b6:8:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 22:16:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 22:16:55 +0000
To:     John Garry <john.g.garry@oracle.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com,
        dlemoal@kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] libsas: Some tidy-up
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qfw59dl.fsf@ca-mkp.ca.oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Date:   Mon, 21 Aug 2023 18:16:52 -0400
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com> (John Garry's
        message of "Tue, 15 Aug 2023 11:51:46 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA1PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: c770aa10-a81f-46e2-a452-08dba29453d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSBwrH1wy4RS5+3Qa414b4bJsP527T4eSn3tub7w17Jcmqh4qy59IeK0w52EX+1X5TAJupjHfaoMukkeUZPb6YXdt399NKtgjHmY9o9wJKSdKU9UwLidQ3v8DIlr1L5d6GGbNN8b+K+mUxeB7lcpSM5Pm/I7qbTuXIDrXoMDBXfNEjsUdnJFVcbyt1FzQ5iaqY6bXZdYYszIGKjVC228gY9GDbwpgbfHGsRguKmNWhfvBMyoHRpe0dYiPpETKjHZJLJS0F7mFusNFu0X78P7nmu2oOmg6EWV2rPn5SmDgQWCekg4hn4Jz4qLn99lD/gK/fDhLNZpU1mwBMpyZGnc0kxwk7yX3igD8oSBk29TViNXUH6r2MLm0Kr0i9GlkfUHEQXWhkigrhzzK8QWq3SGUkaInHhxQuhbKTTi/Hss92PrZ53+Neplb1ACuidfKV7CGmrVtWFe9xGEFV8A826sCsf8DdG6GeRzOwrkf45AJF5broigruqAzWS0vs43Lgk2sDxoVY2M8kJDOf4Fvu7j1sSXs6tlC5QAz1ND8QerqWK6Vt7umUKFX8UMx8CpgYax
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199024)(186009)(1800799009)(6512007)(36916002)(6506007)(6486002)(41300700001)(2906002)(26005)(4744005)(86362001)(83380400001)(5660300002)(38100700002)(8676002)(8936002)(6862004)(4326008)(6666004)(66556008)(66946007)(66476007)(6636002)(316002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMUq34NbzjkvfIzHm19ELNnmENPc5elhPLwSRyGVylHzhfTRBJo7UsTFh8BW?=
 =?us-ascii?Q?/LSAWGdRPWMTv9A1ecaAF6Y4zBIY10C1buqR0XT6KTDfoLQGQ2wSm5AWh92C?=
 =?us-ascii?Q?oJ6AKoidCTcOV1GKmrx/LD6rp9w2zzcyh/EAoDF7LJrd0OIFEnAtdiHSl+gF?=
 =?us-ascii?Q?v9wn3/h7mRL6PzYpHcd8PN6bpY3GCxGbbGXZeNxdqzcXo/3wfCsBDnF7Z+zl?=
 =?us-ascii?Q?PjeJs1yuc9/D/Ga7VFgeaoue2Wd2JJ3dv8k5Y8iFEo1IdgPs4yXzDSjDLuUP?=
 =?us-ascii?Q?3umZtkRhpwB6yjsRGKU5szlH2uiyympjPv1v02p0hlLGSoQcs0clNwa0f63z?=
 =?us-ascii?Q?YJ+zdK2yl53+80m4dNB7YQg/TpnES9quZtGN0HzMJI0c13wUrSbN3xSq/VnY?=
 =?us-ascii?Q?TmBefoizoz6/poDFdzK4HUh3qK+ycUkw9LOhqKfoUOHEqNc6wvNP5WX/ADs5?=
 =?us-ascii?Q?p9641tT1/fZkgU3PGZ05vX1w4NmN7u+Ap/ObYGAV9VWdSlgTbhktyjtgoLGd?=
 =?us-ascii?Q?vwe6rVcg8M+87yJAsJ1OR493cRpDKZLZwUOdTSPFomRRBTdNKgnqjiDxwgqD?=
 =?us-ascii?Q?A3UZHH+M9d1zs0BkC+VAgSKnM0lPecDCop/BWv6+P2ltmPL2CNFpCnVNvohJ?=
 =?us-ascii?Q?fKIRIF6qmDGUlYY8jq6qzCjU/+NtfwG64190/yqfhzvne0vhCi8U9fMpWjM1?=
 =?us-ascii?Q?7brqijgGunnx7dnM7MQa7ag6xgc02fn36wTucxvSZSCNNlbX106lk3FT25sL?=
 =?us-ascii?Q?RIEdU7mcVrwIlEih4qvNTeTxErz9TMV4CG3tlEEuEsfAZ3TGl7QzCZpEwhfo?=
 =?us-ascii?Q?5Ke0ULsrHbwy0WHYrr3EDYTbUVVAId/Hcyv1buEGtNP0SYN+pN+35yN/vMS2?=
 =?us-ascii?Q?VVq4ApcsAjXckII/M6Iy2vEo+Qt2ZaiAofmQLouH+l8zZSc5iJCWP6R4Hta3?=
 =?us-ascii?Q?cB2Dt9iWUnhmDr8dz7M6iUaxEinhUlxP7ZwiatSEDUUUKLIHoCdN0j8SUmgX?=
 =?us-ascii?Q?f97bL48pRcHBhdPzShpYkdNl1SS8ZIEhIlrKx5LwNzJb7Ym9Zedaw1xV7nIs?=
 =?us-ascii?Q?c3CJUIwLMH4jqAtAayGyc0Yo8XJyQV8SgOcYceJngvKjAhN4mRA/RmOCLFgN?=
 =?us-ascii?Q?iMywskvRiGuMgd+DtJYiZ15emgVUwb8+ScuumPRoIgr9g9BvUOzVQ5wvrlJn?=
 =?us-ascii?Q?ltZeFoq97mCCm/izC7T6K12uZu1JtSRtlBatw/kWEZP5qUctmtKwP8FCwdmp?=
 =?us-ascii?Q?84EsW/3uqSSfHP4B/EzONJF8s5oYeTZfKBxHjskbtGf8T4z5mfKvueoIqfsv?=
 =?us-ascii?Q?kPV6lISsLHAtgN0RydjZzAkGanJWaSuFwPAFifjil6TjBtqljpypeq1aggqL?=
 =?us-ascii?Q?TaQCNt1UM3pDBtASIn0yplQjOU+JT8smsAnuRZc/NMvCvnZ8rBfrTBxMoDN8?=
 =?us-ascii?Q?Hl973QZALXwDGrsUcq+eYMq50bQlmnUdNAZokOkovgsAMLiHNjOXfX12gCFK?=
 =?us-ascii?Q?jMW7FqnRD26P+ZWEDiC9gVYqsWJwv4spOIsBbm/1hz7AlWw5Z70RPONW0Xco?=
 =?us-ascii?Q?nIuRAgO/kD2ZNFEiS00/ukMrDAghoF9+DNxoJXuD5x1jkwcamttiYp/iJQW1?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cl1P5V97vp3iI/aOEHOm90yHG5rA5x8LmjPp32TtR2oPWrvqM1u0uTuLgPOz?=
 =?us-ascii?Q?KOnHBrqzAflzNsmHWLtdHQRMcuGa5JGp3ITQxA27/a0b95J83DEsI1FpLHzu?=
 =?us-ascii?Q?u8j/HEF6O+fs/HdOjBqYM6I7sVx6AueLQLSpJeCOShTUCL8a2RfRXhyZrjEo?=
 =?us-ascii?Q?htVj0wDMZ479UsiTVJajLG4+4ZyDOIdHzSNU7Ra/9qS+UICB9/L3+KiyosrV?=
 =?us-ascii?Q?yJPkHCVCr26GIpNoaZvYu8PZZXCKbd+DiEpXB3Jmsvjaiv2tOKuMHF3iWBww?=
 =?us-ascii?Q?9dUZVnCW5ctNB/ipw5I6HkUOGWxfmJ83ihpN8PS9i03AZMkQ9oXWtvPjLMbc?=
 =?us-ascii?Q?so6CUFbOjzERjuVSg/+DZfvyxqdav76V13fQOlHizN37UpYlr98x4qSE6Bl0?=
 =?us-ascii?Q?VJMyanGbivDdRKY9N2NM25z6svup4Juuui6kuD9QSzV1EWjEX8qfOAfA2y6O?=
 =?us-ascii?Q?p7ZWrqEZyw2opYpihPcArFHpPgf+b3WElf8BlR7Vk3GztKcS7LrbDrBjQSq+?=
 =?us-ascii?Q?Cx1aUyCQqe9ygxbxVPTCL23+QQAsCvs37iLxeVbBcofFKZfpevDLsU1qCdJJ?=
 =?us-ascii?Q?u14LMHC1qsjCevmOtXnLouF1T9pLn+4pW8Zidik+nVtoX9terocxJFnOalY2?=
 =?us-ascii?Q?TMMLoQS4jGymgkHZHTyMqttpDakc2Ax4KgGLbC/M3ETVjboWFby7tqMljNVs?=
 =?us-ascii?Q?5qLSU0XSpL+75vjXNXHglqY4FXAlKqzPtUanQF9CoPJeztg+617dF22M42e6?=
 =?us-ascii?Q?JjBasH30a697VO5ONSZ471gf8ENco1U2YsmcTVZSwWKtLak+u8oQ6aPaUCaZ?=
 =?us-ascii?Q?HlEy2MhB1IUW1+z2Ie0TXR/+QBWjuf2iFgR0Dookv2tlmv2S+yMLKiJBuDY8?=
 =?us-ascii?Q?46VVuq6VvLO+ft/rmMb0O/0lYD9W8BKgQZ2JU/MDiMxhO3tXYE7iQTHPEV/4?=
 =?us-ascii?Q?TTItEQhMU5cOuyGRZTdfeA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c770aa10-a81f-46e2-a452-08dba29453d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 22:16:54.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcde5V63IPwBfXzKPDZn/FJwsycl6EtwoaGLPuUqf7vp9E1XQJG9Nsp+YfaeHNAUlFBUjZZyw6zn4Vtq+/SSPVJniI8p0jbA8Y7dvxOK64M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=645 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210205
X-Proofpoint-GUID: gf9D0HxB-kXO7moPa1Ug0SGiXm20eupd
X-Proofpoint-ORIG-GUID: gf9D0HxB-kXO7moPa1Ug0SGiXm20eupd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This series tidies-up libsas a bit, including:
> - delete structure(s) with only one member
> - delete structure members which are only ever set
> - delete structure members which are never set and code which relies on
>   that member being set

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
