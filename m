Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD4375E48A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjGWT15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGWT1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:27:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5321BE;
        Sun, 23 Jul 2023 12:27:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJEB81001697;
        Sun, 23 Jul 2023 19:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=SQ3t6wurwGG+1wK+VOjl7GvZ2ctDD7Y/5t0PftFj7iY=;
 b=HQh3RiLUSP3VNK5o8dVDoVi0zuNszVD6Hu7nyWyLPF4qaGEnVUWkI7Lwy3ZRfUpGIGED
 bBmOqFLy2T73uCd7WVfSLbMZXtKhv3YKBTPzl/oi/VA56y+DsDWNGBOjqh+tSxSjyjl7
 EG63tw1FZynsU42nqPYXLgXIVmBe72X8HYisgQVKkC3s/iuu5N5W8ihRepbY/gngnalj
 tVqcUb+DGxE+hoqIaXM+5FKLZbh0XzhX78SWQU/gp0T6TlbsoIFZjkzUUJh4fhHsR/Na
 O3/e7IxHyRWJ8Ef2AyD44QnGHxgd3n5pjowrEK3BCVFLBWyvuvRHsUKSZhxWw58606w0 zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1sgvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:27:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJL4nL029022;
        Sun, 23 Jul 2023 19:27:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8x5jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/Ssj8jAW4yfvmMYMZom5KFUdF7M6YRQe/3zRo1qjSE5Do2pu/+H1Gdm5LsOQrWb6BO5SCT6uEp75t78EYv8BDVGSTpx3bYDf84F83f47o+kq8PErxAYjc4369lga6ZwXpaKE1HnxiPyjbqfDQDyGuWd+NCptyvxGxwtXh6fZoyw/kEjSFqhB848bvQVqCUL9LT3W1WWT5VB1DEgRfHqgkURsxC/40ZVx3DQ+KGXFxbYUQMvccPLxBkVv9GkUVH986RD14lckPb2XvkW1KPSLTxj2RSrx7zRocvA5wmEdrbTFmDnIHrrEmkd3LMs3khFVDuGERou8Au9AMX4QyQQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ3t6wurwGG+1wK+VOjl7GvZ2ctDD7Y/5t0PftFj7iY=;
 b=Ia5Nv/48S69H4d4huio+Y2r0ZJIoRRkkfZV7rbsjri0g4lqMhlSPjVp8AtwvDyKb5MaiPMkLQ394mF+xNVrVexkx/9bdpP97crrPyaJ5LDwxacqfw0bywBsA8D0JQ51ukB3S7WpW1LttmX4Qzun+9vWWcVplcUgKcOhtUVwH6jw2D0+9BvAYM0Qn42Uui4OleLkrzc83eNSiQFNuYw98Tsdcw4muDRJnOZj/izx7TXh1Xl2aGZeisUE3/LKeuNduQ+ik6mRbg66yEMgJ7xdRCX72mqZJ9NRHK9LPvnlQHQM+hx+fR/ciPahihmMZW5GpRNLTvdc7PPPYmrw1jG+phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ3t6wurwGG+1wK+VOjl7GvZ2ctDD7Y/5t0PftFj7iY=;
 b=ulIfdweiqHrmt8rMo9+xtKrwqyhdf/iQApsW2kvoRcZB+L7P36QS91XJc7BzOA9FWamy03EjpnfQxs6uYWewoDuRHpO1ZVOMTCojrqQBYA/biwOz4T7bQqbANZkpMsfZzdsEXhOPMRTYF+8rwZ8mmXBdfPIEKWiTqTb+aYp3ITE=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CH3PR10MB7495.namprd10.prod.outlook.com (2603:10b6:610:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 19:27:32 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 19:27:32 +0000
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     stanley.chu@mediatek.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] scsi: ufs: ufs-mediatek: Remove surplus dev_err()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pm4i5syu.fsf@ca-mkp.ca.oracle.com>
References: <20230712064832.44188-1-yang.lee@linux.alibaba.com>
Date:   Sun, 23 Jul 2023 15:27:26 -0400
In-Reply-To: <20230712064832.44188-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Wed, 12 Jul 2023 14:48:32 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::13) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|CH3PR10MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 765ad909-8ab1-4edc-7a87-08db8bb2dc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRqHGaaOqBrp0vCWhoPPnkPY0PliAizKP99gYJ66klatRs8qWsW3Ey9VENVhaaaJF/DaYHHYM+QRYh/Ww+OXqX2z6eZhXQVFiqF2/7cecyS/TmvgkIXiFH+Go0F2zBSFv6DYH8vvU4mCzqjK0olPHCqwMF76T8EaesTB7Lh0L0YjZIIFSb722Go5MlhelEQBh5bC3nCdJRIpyrP1JarOsM/STHOjCZlxV25dq2HWQxQg4C3iNUiQ8oTFh/PTQN2O2JgNeYYuNpZYIC/QAznyPhPSM+KwbiQKQlEDP/SGa6thHCKOW/6W0b5+r8BuF+MrnqKlYB9JufcpdeqHnKQ4/cBZQfRVt9e4/eiqeyFDQZFqHjgly0ECC9tA5EvSM96enmKpHU6chSFggOa5xK99GoCSL3eVB6SwpPSwAyfMLehX0xNDfACwRnrf2okFiseLzl9IgfP3YcLJc++vLbyjtyX7O2mnNep0h1Mtl/oGVXuxS11An+rgQr+DiG8ZG93vG66Dlew74gWmrwnlKxwBYK3s+aBWujAQFctokuFYBGreiJr/T5OaKZnXFK834sXz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(2906002)(38100700002)(6512007)(83380400001)(186003)(6506007)(26005)(478600001)(5660300002)(86362001)(8936002)(4744005)(7416002)(6666004)(6486002)(36916002)(8676002)(4326008)(6916009)(66556008)(66946007)(66476007)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9CRqLoenG59VpXgWQ8hYYzTDjrnBU4TPGto5+hrg95Y7tG/kUZ1ylN7n2Uk?=
 =?us-ascii?Q?i1ZjuZz9u6r4e2i+lJaLr2tLrsM/X6LFzkj/jE/4/ZLs3z0KTyvzVAG4gwZw?=
 =?us-ascii?Q?rte3+am9/3k9IlyClbHrXYAQep0ppuaJTeKdO6r/5nEEOaMZjd2y/rOZIZNz?=
 =?us-ascii?Q?pa0ZeP4XbKGcMzAzBcArZBFthdR0S7pvcTZRtIxLxh/DCVsaXBfwZHdLdzwX?=
 =?us-ascii?Q?pGKToXIEtoNhR/zCO3qhyDnGgGK3WyK0yv6Le4UPdFDUhN44sxnfaSlWcMna?=
 =?us-ascii?Q?VjadvzPY6fl8o+5RsTgXs0W/Sr6C6xD74N6Jh2XTHU66h6Dfw7CxASjOwyYd?=
 =?us-ascii?Q?ey54/1UgQd7n66BPpsbMXM8zGaZpW4C3sJ+bjBfdLFkPzOsGOBjyEiAtX7J6?=
 =?us-ascii?Q?E5iA6EU/X5r9AHZR6TwnieWVteQkDaMQ5bz9T9MMIntwZ2ZR0CD3Aqe+tI7r?=
 =?us-ascii?Q?Een2vHQ/EnOsucSBlAMhbKKsAGexz5mxNHFrSgC3B1bhGUQxPY4TiMEkfq4b?=
 =?us-ascii?Q?Iv4RrBu0/wo/t0o/cn97T36NSyek5B9pVsdVK08Fre82bOwkzWeCpV3SqlmA?=
 =?us-ascii?Q?DMP4HFhGSQqSvEcYvBMA7W1fvgl39W0lVSlYUCGyMM99bn/82it6McchlG+j?=
 =?us-ascii?Q?QEYrbABElrtGodQ47SO77KTBQVlh1WL1E2YvdXBtj6rvFJJZQr0sJzZcFaQV?=
 =?us-ascii?Q?j9Fi2Zqh0L5reQ5baezEw6oS4d9hZ2PoFoU452DRGAdCyJAmipYwwhYKfc4r?=
 =?us-ascii?Q?rAbXp0QozKv9RKw9pdg/KJHK5DDddjHCQkQoXAB45U+YkSY/4n1hu9+vzmyZ?=
 =?us-ascii?Q?KDFsQRLJx/6PuPg4EwmsDBkSNVxOz2HIFAbRQLaq3/APFYmZHeDz3d81g5np?=
 =?us-ascii?Q?aCfnBl5fPyPW7yDwnueOmDru+tMEVetDZFVjWHN07IHiPceZ77dMd7YrzcqF?=
 =?us-ascii?Q?XtGhf9Xzkfw5Wgjm3NbEf3QItkP+WE9Nxf2XZhTc8R07F3Y2EpmPkZWZIJPh?=
 =?us-ascii?Q?pCfzE9QpM5Z4hW6sTB39tteBRSK7eK5X40ElgiQlkS9f4aI5EPyigmxJDOwv?=
 =?us-ascii?Q?9HiZnZ/MDCVYZBArFeDIuyV5+xj7A13rMcl1mb9fnYJCgUnMzol9apY30AJm?=
 =?us-ascii?Q?/GtymRwLfnh7shDTxljOkhYdsRA9rj76e/JVsMyQjLkrLsVUFVPElP62doQC?=
 =?us-ascii?Q?stbcjANmEOkndGcxx0yB+kNH2Qo8cFADhl1K8V3y4Nh0MIIx2SMv4td20l7q?=
 =?us-ascii?Q?pF/w5JuxA9gf8N7u1j8EtWsLpiI7x/hcTaysBOvKirO/KqybnlpXA84Xh/jF?=
 =?us-ascii?Q?y49ZEYqKHHI6Kyi163CGzHLdVMYtqBkKxBjj/MaQbofMMrsCJ6jKP64GT96N?=
 =?us-ascii?Q?AAaxjBbp+504/WGqGEgJroI6JC9M3OUpa8n3Lm8CkoqTlWvbl9jnZ463aKTE?=
 =?us-ascii?Q?8p9EwsLHstobpn8Y0MkiBiwgBJJYQX4DKbT4joDcqOyaFHU3+b6OGGUTfnLm?=
 =?us-ascii?Q?HcsZdItYS9Q2UxSlcWPXXWal9rylj38tyPNsqKAGyGReEwcQwL0hskJ69bJz?=
 =?us-ascii?Q?gdN+9OBfz81i0ktlA4DD5zOroJoEn6j8ni1cWAgAl822HwUu6L2ifZ0IQPAR?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7vtq5UBneQZB7dxSf7LqDsCaYLgbnicFrVkMMaeq6DJ31C5vQSpXyrIV8Obv?=
 =?us-ascii?Q?kZJmRUE4rA4omriGnnEnO73S8ScfGyAX6V/cdRetxgJx3uBACxVsqv99o/zx?=
 =?us-ascii?Q?lGC5yx2+I7jRu60+CsXSewCfOHLGqVQ+oxhGQuGuji+sNyOka96Kf362fQAe?=
 =?us-ascii?Q?aWfWJr0mnVnrRO5hjS/3GzoNvAZMHRw/fwAXWmasSWrldH17sndbh/uPlIrd?=
 =?us-ascii?Q?H2agyYRPinrlZaI3yTGai7AfvAxcc93Lu1OyaxcAFsfrCbSyKJKHoLFKr7Hr?=
 =?us-ascii?Q?XVDG4RoC3BAwH/G66laL8knJyJRF81lYBErEfEH+2ypLSWqfNvOg03ezvPa4?=
 =?us-ascii?Q?6kqhu05O0juqeXczWJ3QIqmiAt8KG7veBXuM54ARWtnJqNIPg/B0vgZ/3+hz?=
 =?us-ascii?Q?m4T8bmg318h9rwPTRa0F9lDyBslkugM+cgsCiKz4nJr36Gq8R07Zn70vwi1K?=
 =?us-ascii?Q?WWa1Jqh1H8EzFWzGTgfSQ4j2KfSAUqzHsWykkRuJCEseDPW2zwHh8/IGWJDq?=
 =?us-ascii?Q?KEZLWQpJosaFXaXyY6HdWpc8duTu5YGLRtG4CwGYHmKPVm8w49rUpr8XCiQn?=
 =?us-ascii?Q?nfokV4dakzldogqBPMzbtEpXrKvrLhOOh2r8J758kWAhL4rWPJLetPJ4pnsK?=
 =?us-ascii?Q?6YbqWM08/f1kpGGeSHwdFrV/XMRA1g82MkoUUB4cjkLaRHXs5WQ3W2VRvEWd?=
 =?us-ascii?Q?cPwiGs525mWJVegTaQypeG1GLv3OwDrqJd/DdkrRyrzUzo/Xy7kuNxu9kApJ?=
 =?us-ascii?Q?kjzW3bOo3ACBbdAGS60quyMXy6f6PHzVTw3AT4540jEn+GJ/e9TU7F3583cV?=
 =?us-ascii?Q?bhHhWSNF6/PbzhO1No+PlvijzMZeuHN4qO3H7Ws/qSEN6K/2YU+qw/2Pb6p/?=
 =?us-ascii?Q?eU7T959COar6UvDcMVzYVT/iCok4RDHuzLm6h6JoCiWvTJ+r/TVH+GNJcRZX?=
 =?us-ascii?Q?y4y4cOmuqEivmDytrnLJrriypOWsu8DnU5OqdVeXFQ4UUeRLSJ+Atkfc4fO5?=
 =?us-ascii?Q?OADT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765ad909-8ab1-4edc-7a87-08db8bb2dc71
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 19:27:32.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2Dv7k7rkcmewAWSNv9v9S23xDMQZBQTs/e8LxHnIMYMCjAmiqTb2EyLRg9gu/qihNsKI8yFKI3JdJ+StWyQhrqSfKGONrtygecLBR9ZDR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=897 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230182
X-Proofpoint-GUID: 20BYSjVp2nO_5DjyC-8DGGC9Iw5lgZXq
X-Proofpoint-ORIG-GUID: 20BYSjVp2nO_5DjyC-8DGGC9Iw5lgZXq
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
