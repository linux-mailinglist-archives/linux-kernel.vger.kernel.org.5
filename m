Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B47E8132
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345803AbjKJSZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345810AbjKJSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:24:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85943A219
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:03:33 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAA8U4x021885;
        Fri, 10 Nov 2023 15:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=yKiIrAOTcro5FqcyAHms6i1ayN4yxCnYmd5dXBc+UK4=;
 b=iCPzozlAfVSfmuAB7wosJJaloLEycCzDIlKXr8uciv+pTOJoYVP5xh9imDk6HV8MZyh+
 ndunPNLedFjT6bTTmQOtJaBaDMBYvcslEGoOG5otbDhwxr/6n9EivfEs2Dfgqpt06hww
 y/Si5axUzvfj9WC+SgVprpoQxHdWKCTw4IsJIuD9KKe2ECShUSte8oTi9fthocXYelx8
 KVicfX2SYEShYUXdowuZuj35k/tqhFURBJ+Ny/tokJEhvVwTT1u86d2JyilHOY5RUGx/
 tTxahI/u2nN9Z08f4aJKaQlHtYdXaCzFnxC3L1GEw6P4uGU3qWXBI9sWfcRkrmUF2mkt lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w226hjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 15:03:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAEYZ9v003856;
        Fri, 10 Nov 2023 15:03:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w210mfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 15:03:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUjaXDaNCUIlGe649P7Rzs4MU5TNwHQOczTqdLJqzuzfooZPjbVk4GliU+qeoTziDWsYwwpASvRrlVug6eMoFYBNZT8ObfmuibT0AM9HMYKq2XUyR6ZMzwXGSeWF3ay4H5MFr2uh74HtO3kChtXFW/AaeY2Vq/4Y+fvnkd30FNXzJCCIU8DLNHu9vqXyvUv5/1o3m4boafcUZ1iEn5I8gzIthXPjEqjxY2x9b7/rNrEpHbX+t0BqQIgXQ41NxUlgrE9yEurABmAn52J3UQRxPVtrXaNT7zr+qb98xxODYnxYrO6lopr0BuUDmyiMYf5zRU7B+EDBCzT8417WJESOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKiIrAOTcro5FqcyAHms6i1ayN4yxCnYmd5dXBc+UK4=;
 b=T4DSteWF3WTi99RzWUY6+ikBt7z4Lo5sptrpDQET44H0ZWvxkmE3AFpQJ6xQ52N8BcMjyFRrOJUJgZ70/t5PL/BW1qgTs4tEIK3uAwKCQCPAxZkCF9NrXEzRgXGpdBe6glaVwmdGxmxY/5iAe0kO37Yzf0iOdJQ/IwKVLWB5K32S2fjp8INChrIwSlLUBHlxEqFpjqsr3aW0ZLCpZPtYnSYJfn2Q/sthyfwOVLczpojK+UqAxlmwUzygESTvvt5I1vARYHRU0F4n5guqfFz+73z+phh4zUKPhWHbJhTlR9T2PFj3rADfFziQIMq66e0fRZU/1z6inufJupb4NTTQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKiIrAOTcro5FqcyAHms6i1ayN4yxCnYmd5dXBc+UK4=;
 b=ehnSL0Y++YyliD/HcKcDqsh5ST7XxU5KrI8bDQiFFAL9IxuHv7RG9HBimxpYl52Q8yyHDzFJeOCaoKUk5dNXwXRPZH6EkixJ6oQyt/ixOahUrfs52Y+5F2TXZl4Zqlr785Prg/Aq/tW40qvaQYRq6yzgeHqO/Hyx95sU2fmAJH4=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by DS7PR10MB5229.namprd10.prod.outlook.com (2603:10b6:5:3ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Fri, 10 Nov
 2023 15:03:06 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::14c1:ec52:951f:14d5]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::14c1:ec52:951f:14d5%3]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 15:03:06 +0000
Date:   Fri, 10 Nov 2023 10:03:04 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: change return type of mas_split_final_node
 as void.
Message-ID: <20231110150304.hvcrpc2g6badys5v@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Levi Yun <ppbuk5246@gmail.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231109160821.16248-2-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109160821.16248-2-ppbuk5246@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BN9PR03CA0650.namprd03.prod.outlook.com
 (2603:10b6:408:13b::25) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|DS7PR10MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 0376f2bb-1ba4-4a5c-bd89-08dbe1fe24ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7T5jI3LYTShf8VFqeU4t1Vs2jB3XLw/FWuRa3odHiDEPyk5PTOP9jsHx8CCICvm8mwehkikFMY90fJ+Y1uRoi+vRQnTgvfTi9HbiwInPY4yfF71tO+HqvYfESR/hxteNas6VjPnZyr54HISezpGZ3fiMs1WLMc9kk1T8aA0Hwl12DZ4q+3EsPAwfK59jw2b1EJT7tjnDpUnn9af1fDkL3NZx++Cm9QnQPFN3odtmUISeyBHoI8gmo77nLi18KhDYAOtg8ctOuPKdR67+9x3TKOAegCvyAYQOWhAlXCCFxQBHrEzSLdbkt3/UFmXBNl4J/pkLCDfI5GGrfJmlkQOmbY2bTU13YGE6209lvTqHjS7G9jjdoWFU6iq5t3DgaCfPFL8njp1XFTYYyX1Bcr6vIrbuc/30aOfsCEzuihEUsvK6d/DojKdhXgT13vdEjHRlH8YWP5HtwskcBlBE9Nigd+bmS0ZHf7zWhDhH1g1wiewyjMdRWqa0qEW/0OBYbLQQmO3zOpze7+yQ124tQZFHOWpnFvLWZV2Au8oEZk6iUqDz3Ez6vWmYymne/9JgdOvc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66946007)(316002)(66476007)(66556008)(6916009)(478600001)(6486002)(4326008)(86362001)(5660300002)(41300700001)(2906002)(33716001)(8676002)(8936002)(83380400001)(26005)(1076003)(38100700002)(6512007)(9686003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xMGzl+dDz1kPteDVI1fpOCrkNQG+Raa6dVRIElF9dB7voZrIVZcAoM60/Ztq?=
 =?us-ascii?Q?m7/89bw8kEAkbvsrsFcc+i9Loj/2RmI43C/WVm+9qUA/ccgPbnpWjbk/d5nI?=
 =?us-ascii?Q?KcYmChncxmpzLqMh+zPhjkPJEnmx/FIGS1cD8yELo3pcr6oqgq0qXJ10hNqQ?=
 =?us-ascii?Q?gj359OYYhVcig+Fdus+Gm3yw+ypc+tzRW+B5edNknOA1MUuAdx0VFfSN8zI6?=
 =?us-ascii?Q?6pPvpDkvnd+/euI4RcnAuso7ezH8jbCAmvrkr9yIZTHjegTN8EAAEYK0ZHxn?=
 =?us-ascii?Q?B4w0OpTShS2DaGwoYes5Li31dVbtrnUzo4J6bapsU6SSSBC2UgPIWFwF/6c9?=
 =?us-ascii?Q?nMud/Njx7R90fm9bPiE4Uua1gIDDn7DsxzB//zTEWbnpHzS4q2y0UYyHMOCm?=
 =?us-ascii?Q?FKr/R/r6BVYFYmTwBX+PJ2Ey9eb6QJzPY1x6wPXzrd2NkrLy63iYfqQli0Kz?=
 =?us-ascii?Q?r/P6V+IgAihyGl1Kl6T0+6SWVK8s58ju602DVY+OF0VPPvSCmbRJovnppgYE?=
 =?us-ascii?Q?TbSPSgGS7pwCrcaGTg+T8ubMqu0RP+hAqTktLSG74SeFqvh5Fk9jWa+/rNSF?=
 =?us-ascii?Q?Cp8vM31amp5kH6rCJS2QYx8dRGWIjnib4I5hpZtUQI2GYF6nN9WUTdP3PuXn?=
 =?us-ascii?Q?K1RQCfWTB9tD6as84+r77sxU6Ok2Szm6QfiPSQeORkNKcWFA4SZoJRxclsiC?=
 =?us-ascii?Q?feMYo1ZufN2nZfZm4Ub23ES/85MHXuDVUd3tA5lfytZQk7cwBVm9e+GBndTs?=
 =?us-ascii?Q?xsUJ91cBiUL69J+FBOfAG2rAKE716HLUHfpvkslBKadaZzeJCXI3s5wQ4/AF?=
 =?us-ascii?Q?uste2yD/mbp+HhjhO1CA4w1oHkV3VQsRb96hw3DgM52zm+u/fIxIZq+auVs5?=
 =?us-ascii?Q?k8IqB7ud44M9FeSiMAQedMCfepgb73wa4MR1Dmc4c6sylImlmSoBWqxlRdgN?=
 =?us-ascii?Q?vR61gEuv7gRS06VjycpZsymiKQZyT7y5l/eCEDFlYbXDOb45b4NyVfCPs9W5?=
 =?us-ascii?Q?4XsiGGvQeEKF+UCeV75HIoaWpB8M1R7TI64b4OT3tY9jua9d7ZNXtO2Q6ekR?=
 =?us-ascii?Q?5IIf6YYf/r0ljSgcULQPenCAUd3/5x2Zw6x4Dyj+vO8BuJsDIKpzZJmnOhdU?=
 =?us-ascii?Q?DHZRBRj3rXhmcZHsW4pXtGXI0d1/Z+ch59+tIvJMp/bTRyzuU3gdBYxDw7ih?=
 =?us-ascii?Q?kW9n89ZzAKYPxw7e7GU7ZFZcV/kXyHztu14Eo3R0x7ykOGWPln+GQ4LpqLz3?=
 =?us-ascii?Q?DdktlB3Lvdx5BbPpcMrlw2ZwFDd5uU8Y5fMKmJlKYrI09gThZxIbSew3SL3s?=
 =?us-ascii?Q?px7sUpUM6ADZzVTjdccAyhWm7AX+cmDTgOd62/Mt2a2p5lSHQk2sNAsv4kFo?=
 =?us-ascii?Q?jJ8Q8h7Nua+jyE/ludRga79LI0QQbydyF4qzhvgsFym+Bf2yQ2t1I/pXvnMn?=
 =?us-ascii?Q?3b6qm+GiDhXlelV8ShnVqmn1dqvN2HIfMPg7T20pLDltuRun1LfUgQH4lRz1?=
 =?us-ascii?Q?qR3P9Oc5FBdw63WNQdLsc+cQxJ9DZulw6RIA/5oYK+xAVSi0nP5QZ85gFyKU?=
 =?us-ascii?Q?6MC5QZ2EzTHF6xjY0RP9wBy8MIhZ2m3a7kitgkOp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jHDr2hurBc3hN4IZ190b6FLrTLRLC+XPFWNRU19FBAwVPOP1SuxVDkd4jJe2UZd5YBBqEd0LP5/LIMR9RPABQK1mtbI0O4tr++G4KInQJ/cKEH0icGRqw+sXM/pLV4JHgbWY7nWtGce+QD8nL1Wh/xTmjxr2pLPrtQtYotinQQ0iSxvrqLERAA27pUZAYH26/a7aCMkelnzopXZTl7Hi/ZLHjCQibPwGZM3zhJOuvXvP264crjo6tcU+3i6NtQ3XKlFWAHxYVviLijx3foyhfv096Ze477OVPHZpM0a4ZLg6Pp1iDtIpo04Xt9jxtBNPLvT6cD23lgkHZLXZrNGERo+LN/Ik+gHsIXoxUnNZ4qDSOCoHJUIzFyE0yvoUHeDO0bhVhex6lUIO3BFnSm8cBnK7B8g67B6GXOFs0o4nAPuHxI0cr43Y0wPyz74/QidZiqxRtdOPEjVZb2x+4zHDt3Tw8/96sXrx/jjEkXHBDUdagGqEnJjQCPg0JfMdy0SS4twGJ5u+KRfrK6HaeZpksGIfR8zNZ4M3KkpTxl9VYEeGum69l7QJZUgd9B4ZbB8XdzCCXFZL4GrgbCb73M7hBTffWrZCgkIjQNlaTlHI9yp8A4oS31fVLZdSEKAtnnp1blc7enIXqJIqsqdfafmxc8o+YRIvbZvuO7O3+9KCmhlSRuHRwe3/mVNX/NLa7MdAiRvFxGnRLqGTn+yV8xiI0s79V75KN5y1ksTP1hRCY73G7/pMr+jxf0rGffd3EdpCEAGGNeV0vQYxj+D3XNcj2L4K6eqWNrf/+ZUxlQX51BdoFlLdN9ZHqlDBXhT57GN46iA6OW8EcPEYZvv6LlE1MejuOGLCDYU3uO6Q3QmtkN9i04ElvlOaY2VQnGOUABIj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0376f2bb-1ba4-4a5c-bd89-08dbe1fe24ff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 15:03:06.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bd9s1tZ90Nbyp9P1EwU2sYHguRj6nAXE4QoGkdHgx8FrYAF4Ff9Vyu2xZS/AferqVXBmoKTPk0tnwmzF6YwP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_12,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100125
X-Proofpoint-GUID: fEi_DeAgAu68N5CkWfzr3AZNTAlvvGK0
X-Proofpoint-ORIG-GUID: fEi_DeAgAu68N5CkWfzr3AZNTAlvvGK0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Levi Yun <ppbuk5246@gmail.com> [231109 11:18]:
> mas_split_final_node always returns true and there is no usage
> for checking return value.
> 
> change return type as void.

Thanks for the patch.

> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index bb24d84a4922..9389a631483a 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3167,7 +3167,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
>   * @mas: The maple state
>   * @height: The height of the tree in case it's a new root.
>   */
> -static inline bool mas_split_final_node(struct maple_subtree_state *mast,
> +static inline void mas_split_final_node(struct maple_subtree_state *mast,
>  					struct ma_state *mas, int height)
>  {
>  	struct maple_enode *ancestor;
> @@ -3191,7 +3191,6 @@ static inline bool mas_split_final_node(struct maple_subtree_state *mast,
>  	mast->l->node = ancestor;
>  	mab_mas_cp(mast->bn, 0, mt_slots[mast->bn->type] - 1, mast->l, true);
>  	mas->offset = mast->bn->b_end - 1;
> -	return true;
>  }
> 
>  /*
> --
> 2.39.2
