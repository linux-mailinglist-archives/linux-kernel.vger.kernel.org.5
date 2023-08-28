Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19678B75C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjH1Sk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjH1Sjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:39:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD7B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:39:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxH89002520;
        Mon, 28 Aug 2023 18:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=15X5J6l0w6TKbsLwQ7XwloGWuE3a/Y0WU/CQjRKoIyg=;
 b=N6Q226pgnGVdm0jetVgkHjOeoOtnssUFTSZUXhqaKq+xErT4jqSjiFhWoSc9yDJ5bvEx
 jVnZphTaA9u1CSCN7OufsV/4kkrOK1cT8gvzFngu/c4hVQsgAyfcc0TwEFtNeW3QXbl/
 KoEg/uRxbwtbTA6MLduNl9Mdmr3+9sZWqc83T4SqmjXVrmde3jj5M9ZJeDrxZQQP/wl/
 d5oDcnrGove1kcVLBqVx5WVwj68RPGlJ0I0nw0ZJKWIhFB5SL90phYxTGClf3ZsFmt8w
 F1kibtx9Mzwh239lvi21koC1YfsIsYPbkK/0m7E/CvpIWKq78e6WDETY8tHwPbUXeEj8 Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xt3bwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 18:39:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SII5pZ021134;
        Mon, 28 Aug 2023 18:39:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dm2su8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 18:39:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4tm8oSalUTa0Elj0ZnEZcfM1Qn3Jdu+PcZU4fhjg1ZAeV8x+4MlyhY5y4L2OvMnl+mk9jqtL8OZNRn/3fa8b+ShZdnJnY9OIVEmeIoOxSjC6ZZIKa3PBPiMAF2n+dFz5jFGJpjr6oTOp7qYlE28vSHzkTF0ATzVaGIuribW1gDlgyX2CirsvtwxAfBypZ2I8tqOsv9CFkEpl0oNcGnQVh9rs1pbrvqhTiOhLluhmgS4mMYqbjxu4tE02wzXeN5ElJCEKU09ZCS1LzxrkAzNWHvjnJPrEvdppPVWOomYaYJJ/+qntoDxNOM8FxyZzzDzcV3FcxDsxOaTw60OrmRgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15X5J6l0w6TKbsLwQ7XwloGWuE3a/Y0WU/CQjRKoIyg=;
 b=Tc5y2ukAY/kpq/mfJJepbLAICB6YYcol008bYLpaMHoZOTUNCejrtOT/jx+XnrLRjW5uIJwsMEpVNjb01gYLttvGwzRcc4znaqVfj+nlfWXYb27Oir9dfEWSgRf4UkbQBFBplge48rHwDQxA/7oFV1oPLafT9wLonlDpoM63b4mp43lM/v4a2el3Q9NX/YCVOZazkIcoGxUgA6HM7UIfLiutB5SeJqTwog2SCeM0lADfgkSBeI6Zkhimo92R60zlEMg/4y/JXojeobd/WNpz1iszcWMXQlJ7APqdkyh/9bPTX6uiC/p2NmUJL51l2sXE+aUU/nmRQLTySDBkS08xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15X5J6l0w6TKbsLwQ7XwloGWuE3a/Y0WU/CQjRKoIyg=;
 b=rWcjAobB1iR42aEk1Hz9q7AXvOFqXtiJIi6QXCbNMux3764Y17kj/bXOuYCi8q0XXm9W2l2GN3Eimu1F9ZIpbZz8Mtf5qxqwrmt4WhMg5FvYBE3eiv68OMR4113GV6zUgqE+qk3ibbFynqEWSItgTmOTJUIokaP3iQKjaVndNzk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CYXPR10MB7976.namprd10.prod.outlook.com (2603:10b6:930:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 18:39:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 18:39:22 +0000
Date:   Mon, 28 Aug 2023 11:39:19 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v3 2/4] memblock: pass memblock_type to memblock_setclr_flag
Message-ID: <20230828183919.GC3290@monkey>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-3-usama.arif@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825111836.1715308-3-usama.arif@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CYXPR10MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d18f683-dd44-4528-dfd3-08dba7f61890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4morcEUxz2SjjsR5U0urmo1u/qfcOcym+IUMUTMHjowMSunFMoF4IxGpbJQh6B4PHzm2EWfvU0uNUcj2Y+PtuHdlQKA4du1Eqxl8TLBd5ecFKSWHsL/LgbdrYa1KwhgFaQ0OjZ/MugR43PjoEo7wJ5hGubtZxA9rbyzLq4LIpczbdhWUQWDCOndRyV4FrlMQty8/OMXrhXYM8NC8XUN0zV4QDypyuM/p0iR72x+7BI4SqlVgFj5DXCVDleAvzYWi5j+r96+OV3/5JedmwwVqUOB0yL/W9lmtMBztSagqSRmJi/QfB829YAnsoQ1dg6BsyPVrQMiN5WYwFcQXMlrC87OzG9Bros1iEqk7SfMs8QfOq9txDWDsNLmdOPWKf1nAKbVSLXA2LE1Ro/ijNVAvKMaEa9W7PmJupdSqfQ3OKZjN/W9zsYiSdeFQUBUgeBX8YAfoIwIVi+IFw7pjMDR9C1xVAgE8U0HAI1nuMcPLXm8aIyqDD3Ocu+UkNtMbYnjUClRkLeIPvrZ31rvnfYJz5VtLSDydjT1R61KiMOS1hVzyCxJXDxEbBPFRyNGahwFg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(316002)(6916009)(2906002)(33656002)(66476007)(66946007)(66556008)(5660300002)(44832011)(41300700001)(6486002)(6506007)(53546011)(26005)(9686003)(6512007)(1076003)(4744005)(38100700002)(33716001)(478600001)(83380400001)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPcLkeHUZXe+k/8X22xVPXTQcL6EFxqZE6Li9CfSRjIGdXEk7qJ2M7eEH/ie?=
 =?us-ascii?Q?vF0yNaNPikKyr91KvhgcAnXNqUJozB8GG8Qa/gpEejVL0g99t12qcHqs6Jkh?=
 =?us-ascii?Q?Jo0pxqNf/e1thV9ui7ttcG3ygFpeXpOAKHIOIypRRzK2uZPoHjRPGC7yUT5k?=
 =?us-ascii?Q?WCY273oXdUbAG18sapMtq6wjzTcH3qcDyVk9iTk+eAfg9epIbXOj6kwVflIf?=
 =?us-ascii?Q?zebC64Q6kiX3GdN7IXh8FCcC9R3GS5biy53bjQcx1sCwRWozcxdFM3RBH9UU?=
 =?us-ascii?Q?spgsM8ABy4oao+g4aK9vtidUnaLeuR90pndRhoEm7T5ZJ0fPw6QiKgjNTSzb?=
 =?us-ascii?Q?h5Nj3wD4xX226SUOekpDPWElUuCLcDkpQgrZinPkt/GovmHD7QyQUy4pcFdJ?=
 =?us-ascii?Q?w9e++Yb3vHa5BxytJ84xeDpf8NJTbXhqpc/J3Jyzi2k+1Owmrsm8GwmC1SN8?=
 =?us-ascii?Q?8gvJVjTsms8kfZYQSr7Wbx/6aDp0dKUy/huA9tgkGsIUEcLAE+zlLj9nZOth?=
 =?us-ascii?Q?HwlL4nLokwghDR3THkj4cThhPPt8hatcZDVdXQlDKoP4UGHqVS/Uslsaxiod?=
 =?us-ascii?Q?gaAiu/j3DwNuv181jlBBlebx7zq/Z7ddE+MiBNW9vCKEojqsh9IPK8tsB9at?=
 =?us-ascii?Q?mrmxseYMW+xvQlsTYxfCGtnlcGgRQ0mPXYvVUZMPF4mdv9TCaOldK5lbXSeP?=
 =?us-ascii?Q?5behx/hFKS1aMCD26ev1rqwFKmHj9FOteO7VdU3Ze6f3FttlIX/xBF+0VsQv?=
 =?us-ascii?Q?+6fPs/AgL3TwpkdCTL12YySgZUxeMQDVhC9O5ezv2pQRadEgjo8/jmKfNGrj?=
 =?us-ascii?Q?t6uPI5P93UPu3wyXP5NfapMqM1Tnt7b0/JlIf2lLhCvxJawbcyhP42O9M74v?=
 =?us-ascii?Q?FEkKe80CFc+1FkJ1CcfdFwXLcu7Ok25BCnme2DdvOJPDRVakCi5GF2P3SRwC?=
 =?us-ascii?Q?775tAPZANFBPtYdvE7BqOYfIbZ2GcmIZtBtOlUNIwrAY52abUgtrGUK3+zqz?=
 =?us-ascii?Q?aCpbOKb4WO4LpHoEhPM0L1wucMdomkNwBI2HWRC0u0F7vMDPgGVxsSaARhup?=
 =?us-ascii?Q?Ln/UbDMKd5MOtXnJBcAHYD5gvhxk6Ssf9E1GjWDkxOoqSdFfpOxizWaQ8rLp?=
 =?us-ascii?Q?ENvgy43jduci+g2rnjjz6mxJiJRmjQa2zStlotgzHwijqK45C1AaW2JdneKw?=
 =?us-ascii?Q?m0yVnvzD/G5HC5vBCO7Mhgxutx5R+Zi6AqKk4z9M6IobGdxLPMXMM31/ClZG?=
 =?us-ascii?Q?wE7FbsVmfJSoeQf3yStDs/P8Bu+6OesBQaZyIHQfRqHBz9mupdAMuIxtUy16?=
 =?us-ascii?Q?x5USkUroQW6mEUTRDMod3VOCEVd6SYYwPRGspg2E/BzEJlsXl4vzcCclPCf2?=
 =?us-ascii?Q?7Ybjoawdl29/+m8jgq737AoHrrGT2e8iZOXaai7WFKVGD2B5qw/9h/P13xnN?=
 =?us-ascii?Q?nOgSIsXzdAxenybXFnrEeN+U0y5FIjP+UnxrWRtTy8zqnz8oxIAuFYehpjKz?=
 =?us-ascii?Q?nnBMvyOzYSlz5vEQkkLamoAAFjpDvw+JGk28ZUfdMNanWMP2dpF/fLdLwRza?=
 =?us-ascii?Q?CwbkSB0wOmkLOB5CHo3W0SQAxjqJLgfSTHa4Sk3PX6/TvbYqJdiqQF0G5FVd?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ny/pPhJYJsTj513WFWtQ6VFzaZ2YuhyAdF0BaF0qtJ/WAdgMcCXlHdWvGwL9F57Z827wZEFOq6xdpR7z584ppXTg8jSR65e2Fyz8pRwlDXr+15QVyBEZ4qwaHnQKZZh+41tfSPgYLsAfFD8ZJ919Ad2X5i2zi5ek/UuRU7xUhkfaKDWjtsSQh+lXMjNpPPg0dbEDsp+uTYYiEw/c3DWobrwwFrzV4I80VKjLvcprKf1zpdTJyGFHfGMAy4Ovitd0KVXo7QswlPIXTCYc5/ZWjSG16G8Yo4t8vlnLLMP1iLpjayxdT9IVZz52w3yxc/k2Cqs95XYGOlYN6dh4n1ZwCQrH6QGgLJwzvv5OQ6cSv18+uuweYKCuUDwuJ4luoSyZuISZhME68cbnEVLQWR+SSMEPS77qMnA10gHiTgdcMJR7tHv346FQVf+sXMdxfaGadVmDnkAAT9lwpICx/t+anGDm4Pa6sz6MVxJegmgy6LtFcAJ4U506+kNc5GwFdQ5e7FOxbeGfyv+1CNFd6Rn8lVDA/h5gRK2AlHL/peuK8+9laoWy66isa/CWA7fhxAKMhBqzYo+WLLWINWrps6pm7MF1hYfXHHdrpc9T9LeBnA+DQbitaehMDEN3BhCeqnqpo6GzylHzT6YhLKwRwrZXH9iLJKVOK6QIza2yl102UQ5cx4hw+b93AkcDgr5S2IAuaoUtM0ZcmBpf/B4kEef6IDHD0l9wEV77SLpjBxpQh7Fn1v9ZO8WjA5I8NZCEjH7YZLsnmc2ZjUnVspqeTFVWusjUMaacUyDh/3zbgKXrMcxrhxmbXbO9Ol1bvp+T3mJWu1EMrr0HpsoOndvgLZeSW1lhV8QdNI+YknccIDXwAWVMFXoynqYkhPLghTz3yEyLF4wXBkU+3kfDC0cfapWV7JGagwXcl7fNBkH7vpttpy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d18f683-dd44-4528-dfd3-08dba7f61890
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 18:39:22.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfkHYCVxpLBBKYkuqzJXwOBtEa+JJ7I3KhCAsth1PfemePfc3u1RxRhgoIl1A1nqItpkxmynXAXQ2Bdp7pf0Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7976
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=960 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280164
X-Proofpoint-ORIG-GUID: qxUYRzt93UqQyjRZKST89l8-m77Gry0G
X-Proofpoint-GUID: qxUYRzt93UqQyjRZKST89l8-m77Gry0G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/23 12:18, Usama Arif wrote:
> This allows setting flags to both memblock types and is in preparation for
> setting flags (for e.g. to not initialize struct pages) on reserved
> memory region.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  mm/memblock.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
