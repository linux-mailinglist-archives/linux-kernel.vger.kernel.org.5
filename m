Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C150A7A21EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjIOPIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjIOPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:08:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0555F3A85
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:06:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FD1xdD019536;
        Fri, 15 Sep 2023 15:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=gP2mgIoKJpLA9UDVS1B1xoMC6/Sm8HrD8W6RlwbEVmc=;
 b=I3cPNU1867Uu36tvtDXBwJXqnerQi9wbx20LuRTUBf33D1sTe4ilbFUgtaLeOYKUPtK4
 OpFhg+JDVOaJmWXFyTR2tqdsBWOBvGeFC/8RvA+ngHcc97TxXkCfS5rNGI8nX5hS4Ua4
 YwN5eXLjTf+hTYc4ULSLn3YcX9rkZNlz6vyTMSV9UsGmYltDhvdA/+KlxNzPsoZvciGW
 2rWXnszgDm32etYnQZjxzz8Yt16U1nsMAs45HZwCxCpzNoS3TGzofbDtqTvQj/H6DBI4
 3+jGHoI6x63eNo0VY5IBmLtrVRDauKWlErtOpKTzKPSlxHX+S9aIlwMmQlSiAAfcWQqf pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t37jr77wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 15:06:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FDaY0P036185;
        Fri, 15 Sep 2023 15:06:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gfvq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 15:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNBt7+/uIMjknUa3LIjki5Rd1R65sE0m1Z58hl27bZNHGY53Ot3/ERpWz17oeQ4YlmYVj9ekaRE+LBGib2mZDPGFysj7qcziboEb4EvLQNDl8JvpbPMTzoxOw5OBPBLL0KBxRZdG1HqMlSeR1L1PFXIq2y0N6GwYJGUgAhb62isvQoMOPAHdMyx6gqA9uAkoSi1PxbPjSIsyrwxaJtNY6Kir0xpibM95ZWtDup6+8G5DP+4LP73W1UqYQ9MzVb+gVGAAxu+46SlcDThVhso3wcQKMJHX/YbrzOKWMDz1tWiHMoTsHoLoPPtuZizq5AyDDrRkZMuG/2rbsr+k4trRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP2mgIoKJpLA9UDVS1B1xoMC6/Sm8HrD8W6RlwbEVmc=;
 b=fhMnZmjCCTV4IFzK1TIc70s+bc8z9zWYqdSYxddJSG2VsJu9Q8/IFFwmeHslPtPx7LOabRDw+o+U50ciC6UFuwQ6n3ZNcXTVu6WaVrAdJ12nON4YfFWZHj44nyQC2qp+9HKXGCh6+mxd/0sN197EtpyK+ADV+oHPW1mAaFwJiPsj+r3qgdRbY2DLIDdVnUjvsrApGQ7AoOUedsibFw3xJuUUMF7o1VlAVpG2kBOszEwRvV4OyE1cdyM2QkjxtILxtM8JJVYY5hBp8dX8Bu9A8aFulRJz8KqpKU5Tv5FMSi5wQ4JpqqvbIepuh0sNhh7kQdpO3KtvWaOLd8iBfH+tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP2mgIoKJpLA9UDVS1B1xoMC6/Sm8HrD8W6RlwbEVmc=;
 b=K0IuA62JntMow84I7VSJqLvmSIFF9ytwkVI3hsnADiqQSSPmd/iJgKmQ6icMe14g5cXUBthRARQ3u2XILEsT29tjTLdgz8DBFDKMUIBK1LrHtpbheChq/zw9LM130qRLS1XKBIw+dGaiDshC+i42MDz3vJnVJCSYyN07jrj0+BU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN4PR10MB5655.namprd10.prod.outlook.com (2603:10b6:806:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 15:06:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 15:06:13 +0000
Date:   Fri, 15 Sep 2023 08:05:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230915150533.GA426926@monkey>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey>
 <20230915141610.GA104956@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915141610.GA104956@cmpxchg.org>
X-ClientProxiedBy: MW4PR04CA0319.namprd04.prod.outlook.com
 (2603:10b6:303:82::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN4PR10MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ba0d77-28e4-4dff-2c3a-08dbb5fd4d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAYlM31OBXHACO/t6fb+b7kFXwUD8UYXyofviPdsUY6J7Gsw9vaMGNj0VZsmtbQFAQOcC+dZGo0uLHYlkUuz4cLp/yB9nQuAvXHosg31oCRWgC+GmMPTk4qQuoZTiiwG0j4RaEQudjHeDC/R7k70zqQbsX7WKkH1qKzBy0tfeeqxqd6s26d+70Q56GkP35+uk6xu7HcRweMOzYO5GVNiP4xF9zW2+yuop2A7Ve28ZE7LHo7qOUiYb4/hCQIcSLKQaxKwF/W0PN821RehKFOn8LMzYa0ZsnJWzk8s5HVZOVY4TKNzf2KaVmlfrpYs6CKSMAp3rzWBY0PYD9pX6EJC/Qdz87IRjyE9+aFGUE9IRhlvo1MSy3r/1ocj2K1gIvN+NjGBjUR+ZtoMDX5lFRpnYpq1RbqDI1febUNfji1ws61HjEQNoHoaNAGZ/46jNlY0yCgsY9SPkQWrhEesoJT/dZ1b5ukiSuhc8+R+f+jXDkmSE0KTvJjTPqGZsiIpCfj1laZ8kydKxzwBeYLeEWjZTtDBkbOguXVtapYzGZxuG2fnQCXplNjoUMdQXAsn0z9T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(6666004)(53546011)(6506007)(6486002)(83380400001)(33656002)(38100700002)(86362001)(1076003)(26005)(2906002)(9686003)(6512007)(478600001)(4326008)(8676002)(5660300002)(41300700001)(8936002)(33716001)(54906003)(66556008)(66476007)(316002)(6916009)(66946007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h0xId+MrWXX1YgquYFn15HSrfFy4KMw1d553w/WIq6maEUZeMFsAdyb8K1r+?=
 =?us-ascii?Q?hsi4VCSmlyNQ2mgNN1OpxMJ07ClN8SRC2KVIeCPzBDrUzC1HE59MQlV5Exfa?=
 =?us-ascii?Q?2J8gUL0992M6kZEyCUOmR6WoT0Iw6L8PtVhvugr8TXR+Z9HBRed6r2ABt6hK?=
 =?us-ascii?Q?Xk0sBtA1yBtRmx8dVxq+FZHVIKH12JsWJbqVgkUazRgviU66xfHh6az3JFgT?=
 =?us-ascii?Q?mqg8nNS0KvfqazfVQ8aYQuLAmYEk84A1ZgsipUXU/TIiLWgAA61gpVWvMw/k?=
 =?us-ascii?Q?BioKOgseouncPCK/RLYhzjAx3nuvTcYL3U6/LZoS/DQrbJh7WvCe2m+GuNBm?=
 =?us-ascii?Q?6cze+lBr6xEsWuy89w+0fryMt7/RIAf63F0OTvRhIarOebjxegjezHiXxalF?=
 =?us-ascii?Q?ifNUp2/kOZOL7DeAgwX7NmJ2exqtSsXIBchDabpBx1LiIR/e6k+E11OWeTdW?=
 =?us-ascii?Q?0HKY4rSlYF4OKwnc0sbdMrNReX0N8XwZpX9Wfo9NfleB5ZiQ4ZmWe+VMblHQ?=
 =?us-ascii?Q?+xV4gTmE9DGXEKLO2aN1ckiqWqrfRTwUCJRfSKs8JmR0oUMNbgzAvatCY7Cn?=
 =?us-ascii?Q?rd7yW5gCPi4AvXQDZHBei0yqgk4CELkU5KEGi+8EG2dw6O8MnA7vTF+XDaSl?=
 =?us-ascii?Q?/qdUdXYXj64YZK2ZJIhK06m6ykLUU7m8PPjXMsmlqrvvDIV+2HOtt2MoFeDt?=
 =?us-ascii?Q?YEAnr+OQ0mk/Qq/ECh6hxghO0YEgMqOIMnXNVBn/eqFTj2TRhsT1PbdQXr2G?=
 =?us-ascii?Q?TRTNUtMKt55mGbuQmQWYr5YS+CZSZm7Kvshyyq+dXSd11zqgUtuTEC8XmFdS?=
 =?us-ascii?Q?Vqu2EtVAVWk2DGsjfELn6zdDbPdFRjPntOayCx8KmDaGIKGjrHhvTPNkThGq?=
 =?us-ascii?Q?YrZnau9kfzKdUI5URFCo3/Xcv6Gde7hdV1QZU3+7rTwy9RIDCnXoYr7ty9Yp?=
 =?us-ascii?Q?zsA9BUGlp30Ug4kGlt+xG0xpk0WdpwrGlHE9V+lBp9sMATwNLdqNWOAUAs91?=
 =?us-ascii?Q?+UJU6W9Hln8/0YwjDSJwaeDh6HnjKraEVmbbEhKa/0HJTmFTk9M5hTBYYiDW?=
 =?us-ascii?Q?eprpN6WfM2AS20Vk+eF3PNUij1klKRoi/dxl1neiUXXrq/CffNv4d0IA0Zjr?=
 =?us-ascii?Q?mUKk31YA4rosLTlESXnem7fMrb4zIyEM8b3u8pxAONfVU3HSMp7ToIq/DJt4?=
 =?us-ascii?Q?qvGaXP06bh3ePoluOHgV6czTMw9DPrploOyOQJIc8WrL+QTQQROuH0+UDGlt?=
 =?us-ascii?Q?PGOCaUaeTIOGkYseh1QVzjjJ40q1YbaOJ/tI7znbJPAlm7COE7h9pzaE9VzW?=
 =?us-ascii?Q?Z67PRagItKb6pwP5RTmxClEpcR3lc9nTbMcJav8X+h38R2lsxVffBCh+naZc?=
 =?us-ascii?Q?LQlECR8lqSt7ZhKj6b6hVFbF6cpgitwJphSHg3m9qGWeHXxS6y4wWO135uXQ?=
 =?us-ascii?Q?5r60eFsJ8oXvOWcZqQLc1HBNBVchOnZnZnJ00hLbZKi+RbCs/7wbsfjCHDTh?=
 =?us-ascii?Q?JHlzIxRFX8nBxfjx55AXRbP/0l04y+S2gw/tVlNAv7pZKcZfhqmw+w5qy5eS?=
 =?us-ascii?Q?vRQ1dsw8DFkfIT3drlRYh0Gms8vJhTEkIvA4Q1hu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?w8vLfW2nGu6BSwwCzpp3GJihNPjaYVs40UE6fEjR7/RnJ2l3PdP8lLrRmAAd?=
 =?us-ascii?Q?3+vBXdZQOVxH95S4TG0EfIN8wtPetOdP8VC6p3iHZ92UjWUKoe328Gl2Z5W0?=
 =?us-ascii?Q?GMU+NFJFZrCsnfQ+mi0OqTeu9hz0GqBiD7BeYReVBwHl6eINv8IGV/ZYpPfk?=
 =?us-ascii?Q?rySQh3q8qUf2CpaHpE51qLn1iiQ+2+JlppyIHq/S3I86JKDziUTVFaqSduj6?=
 =?us-ascii?Q?SxSxx9qFFfsVEuLlAmeWy5Vr35ZRpOTp9q9bme1MGqYydYlcZMvGlYeoAsyu?=
 =?us-ascii?Q?dO2u2e14ZOyTlXeYO/OwX8FUtlSEp2zrw9kjwylrxwq9BDM3KQJtVpc11Xia?=
 =?us-ascii?Q?6usgP8evlLiOptWlFk5q0XNSXHHYvOicUvhIf9kYcbvAKSszpCIkjtdlTdsQ?=
 =?us-ascii?Q?NgSHgDmmP0KN9JKWoXAI/iA/vICo/iDOjLBZ/fDlLOxzoN5X5wF1DkfvDlgQ?=
 =?us-ascii?Q?8pTCakZSTScqQFChsn2fmz1huZtJeoG3qO/JObiHePvQwLCQEDd9w6mQlJiy?=
 =?us-ascii?Q?2yqR3c5NtiDa9QQTKB+TkFTiUatu3d4nss1Vn1dfQVQAFHCxsaMNaN0mqRH6?=
 =?us-ascii?Q?kIv3ux46hg/QwM4UaHI2AztBTxTGi+ofSbfGe460WSSJojl8nOkzfmXY6K8V?=
 =?us-ascii?Q?9QTYvOlR37XONeXqs1keHDobodLh8wrS++RGWUCSSME+HC8z/zBBARihPFht?=
 =?us-ascii?Q?VvAiQGrat+u4F0LX7rAgE9PBN4cbHhVR42DgWSq1pPHJwC98+0xr+d0qbI2a?=
 =?us-ascii?Q?u4v8MqyfWZOjamMIUJHhxLSPBaavPywKpFnHGFoWqqzJCowRUP87WbJw7XYR?=
 =?us-ascii?Q?R1aYnmF2cU8v8B8au1qG66Kber9Aewvnx2t2QBytfFNza70E6M22/zuEErbk?=
 =?us-ascii?Q?fZbJLylwXeAdYtEfz4l6QJ1F+MGZUpS2Nlzn0QXWAhjsALPo+XfC15YUSfsq?=
 =?us-ascii?Q?zRg0OT6ixs90GK2BpAslusIk7/Z+OHc0Nl1g5kBLgMFehDKvBgfAfYs4B6pu?=
 =?us-ascii?Q?WYvT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ba0d77-28e4-4dff-2c3a-08dbb5fd4d45
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 15:06:13.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0Pt9AVhajfB89EXEhGz9liNgJi1Dgx34o3S6dXqhAqesdVHJANABVi3+xJdvOUCVM3yI+xf47k/OnUB9ijvOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_11,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=831 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150134
X-Proofpoint-ORIG-GUID: hCIG8KVPhrDq3uAf7xMHYf0VO1ZnBij-
X-Proofpoint-GUID: hCIG8KVPhrDq3uAf7xMHYf0VO1ZnBij-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/23 10:16, Johannes Weiner wrote:
> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
> > In next-20230913, I started hitting the following BUG.  Seems related
> > to this series.  And, if series is reverted I do not see the BUG.
> > 
> > I can easily reproduce on a small 16G VM.  kernel command line contains
> > "hugetlb_free_vmemmap=on hugetlb_cma=4G".  Then run the script,
> > while true; do
> >  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> >  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
> >  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > done
> > 
> > For the BUG below I believe it was the first (or second) 1G page creation from
> > CMA that triggered:  cma_alloc of 1G.
> > 
> > Sorry, have not looked deeper into the issue.
> 
> Thanks for the report, and sorry about the breakage!
> 
> I was scratching my head at this:
> 
>                         /* MIGRATE_ISOLATE page should not go to pcplists */
>                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> 
> because there is nothing in page isolation that prevents setting
> MIGRATE_ISOLATE on something that's on the pcplist already. So why
> didn't this trigger before already?
> 
> Then it clicked: it used to only check the *pcpmigratetype* determined
> by free_unref_page(), which of course mustn't be MIGRATE_ISOLATE.
> 
> Pages that get isolated while *already* on the pcplist are fine, and
> are handled properly:
> 
>                         mt = get_pcppage_migratetype(page);
> 
>                         /* MIGRATE_ISOLATE page should not go to pcplists */
>                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> 
>                         /* Pageblock could have been isolated meanwhile */
>                         if (unlikely(isolated_pageblocks))
>                                 mt = get_pageblock_migratetype(page);
> 
> So this was purely a sanity check against the pcpmigratetype cache
> operations. With that gone, we can remove it.

Thanks!  That makes sense.

Glad my testing (for something else) triggered it.
-- 
Mike Kravetz
