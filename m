Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DF67A9ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjIUSsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjIUSr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:47:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02669EE854
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:47:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LI59E2026382;
        Thu, 21 Sep 2023 18:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=vPI8UeAhV+6QaPYyayDAGmzA+qaIcf19iPIueG/tDrE=;
 b=cxSg5/MbVYFmqxsnvkCWSn23mdaCd1XX7dHzV9865P3oQZTOYG14oJ+9QsFey8MFnTp4
 EY8qbgnDdkBOvjn0l7DliNPw36+dCrGe7KwfbqUPFRqPwcEAC99O4xCcSXlP/cH4mJlU
 6UlbP+vJfi5XB1Ir2od4ooSZjqvoq4ZKZ8/FpbYXX/6l8ZchJDcYDht8PV5P7CfAubH1
 I8ZzurWufSs+fsmr63RGgrtK0j1umplI7jSdov6vShB9duGwBkE16QFC66bRa2ZjqnQM
 nsKsp9MKnCzJjQaZjUMjX6Rz429gmsjMvY5SKoVpgYEvXCSwsPsMBHQquXssT0MQxyCk AQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvr2v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:47:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LI5Wo3033987;
        Thu, 21 Sep 2023 18:47:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8tt71jgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:47:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmWsp5iLSgAPBf1AZEhUG1utvbqn99c3680ETBmhkJmXx7tAheBBHjCdsZfpS99r12G4fGHijbE6J0XPJPNfiCTx99N1APbd2d7oGbB5twyFZqsB4WBKY+UQdP64WrB4/UX/+EBI92f9H6UNil5RsF/IZkaFzOX/lc50poB1+20zCbyO/L8+kC0disK4k15mhPvM43IdBpJl9kwu7BxaqPDEIKZsXbVAG/Rg/ZTgNn8rgd8v6bX/Zul9if7QvN8hdti4M3NWx5o85Rf30dOi8YkMkiBCLSsKF8FLJFYqiwjlc7vW8c/+bo4uN66W0pNN2qkWks6qhKMZzvqMb2scBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPI8UeAhV+6QaPYyayDAGmzA+qaIcf19iPIueG/tDrE=;
 b=Rn4Nsw81EB4P2B3EVFbK2pppJ8uDta4d2X1qfDAZZUgFIcQ9dL5beaw/rZp+UMiy6AfX06COVfXknk4cOQk7XFKqaA6eJgeJrQHAdw8C62hl2UMrJvDG1zG8a/0PssZbdSg1/PP1t6zsaTqSPyJK9o4vFZX//N/UI0FUIYbwFBiPd4D/BxiyGOipyMvPgQFNfyXF4b/y6XqYwADFgJnlxEZ5sNcr8a2tbGQcmS8rris0dT6qC6l8+6zPmrIaYc5da3WVXq4u13d1SBHe8rBxu1Hc/r6fytAif2nqC+JwdYLZXEMG39hpvAVY5HRgU6JE5Tb32tdCV7tvuGH87G/4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPI8UeAhV+6QaPYyayDAGmzA+qaIcf19iPIueG/tDrE=;
 b=v5lfVFV3qFN8n/MNVR7B4tLra1BoNQOKOeM7MGrW+SwoC2hK+wgv4U6144EjADea1dCDwguOEoAyw4lAlStna3xPXzp3YCKYMKIW/0CztBsRLjJFgZ3LtOfIYdQy5LWPsjuHWEKfysxdMOjRbqFr+cRKH9D0A3u1udDBc/NaLvk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4843.namprd10.prod.outlook.com (2603:10b6:610:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 18:47:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 18:47:33 +0000
Date:   Thu, 21 Sep 2023 14:47:31 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
Subject: Re: [PATCH 2/2] maple_tree: Add MAS_UNDERFLOW and MAS_OVERFLOW states
Message-ID: <20230921184731.mg3h777fmpndoru4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
 <20230921181236.509072-3-Liam.Howlett@oracle.com>
 <ZQyOHcQFhHqO7JAY@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQyOHcQFhHqO7JAY@casper.infradead.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0396.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd9367a-d2e3-4f50-16ab-08dbbad337a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aioTtKI6I+pZzchcEsKZd3eyRcuOKD4K/ik0weL0M0DiuhiR4fFz574bzhdhPS3IyXSE83K0lATYfvYL67ZuctXYl5sAOYQ48sVHk563FuBsFOsiyn5KMsoINjZj3XZFOcyb7/KzwDCa1qSdgsH5xyyMX9cT7oOPHlpON7F7eQYXG+4wvgsdxRwg2qMtg2zgzd4x8QrFZ1Gc1/oufR7N3ZjsXXjg+FyXXVJQgcuSapgYvq9yJ35Re++zj4hbPHAex7DHrQr+G0eFX4dnVQgNnvE0g6zDYmn+f4t4x4PVPMu21fvpCDdo0dXXhvwishETRtc3ZFJvhlwrO4ZcNWkIfWBPpD4d+37k3boIGc+wT4x/JdyxBd9fWdUmrlTMGifC33nXnLWc2f+1iaT9Mt/GE3BIf+P1oV2uveL9Ny47RY3C2lpfY80F5YHmK9f58kEvJUAMPA0X8zTt6ZI2N5juO5OHsoLRGDOUv3jeKqqlZDMEAsc4YpcHvgfXVSIvJJvWrv2lI6uk43e+/qbzsb6bONeld7oOQL+wZojv3TVivv8AVkGkqFYqt1hpE7j28ma
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199024)(1800799009)(186009)(2906002)(5660300002)(1076003)(26005)(54906003)(6916009)(41300700001)(66476007)(66556008)(316002)(66946007)(8676002)(4744005)(8936002)(4326008)(478600001)(6486002)(6506007)(9686003)(6512007)(33716001)(86362001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?csmguMJAtpIYobPuMdkQc1fM1noCvhyaFq3zSRph6QICScRu3FvRgHcPORBd?=
 =?us-ascii?Q?geuxhYpDN6U5TBSe76SFFU+OdPG+sVwa+l6GP43NIiQJLGvXhEyCVghbaQX9?=
 =?us-ascii?Q?B5qvu5V02bg075KUuz+pN3Hv8YYd9qs9RHZYLBMFN8odB7DYicop4CUIvsg+?=
 =?us-ascii?Q?F9sEYdTKLBrdszjwq6H9HlAa28oWGSv2O6cRqyAosml5J7gTcujYcFW5gWgl?=
 =?us-ascii?Q?pzTX0xcgh6j5bzKvxehiq/t8U/t1l1l0t4ciWjYtRZ9ZnQiqSLtyisrXKu5N?=
 =?us-ascii?Q?NHS3C8pgBZCjmTieQ0shs8I21bMomvkOidxMaSPu684UgHvEW/7O/hhSimuY?=
 =?us-ascii?Q?YLo+U0V8fmElxDKFCc+Hvd/lnOc0pO+JIEzrZ9j2yc+b0cgh58IPnGaQ/zi1?=
 =?us-ascii?Q?wYQVYhtBBcQOeVYSvLriF4JdY3xQLUSi1ODWqPs3ewiw8va3wJn1B6nq3jJR?=
 =?us-ascii?Q?o2yD1PEAxyvSae6PG9/0Ax+Y9+oj28/5L+hlD0XxCu/pmLqXwxU65MQe4PBC?=
 =?us-ascii?Q?B6HIVq+sUGqGJNTLVW0Go9gshPq0oSDlRh9nIiAEdZ50NfhwIqyRd6M9RaWp?=
 =?us-ascii?Q?ZtrAXca79cFSc0f/aG4MxGM/Qgs/NBiHCYUF5wpO0DMgQamhM1Xl6XNk/CM0?=
 =?us-ascii?Q?UBZvtpRiCfw9FhG0HC++Sq9QFF8aVxN2iwr5afyW9oWaP5tfvjPnikwOuipL?=
 =?us-ascii?Q?9nHx9t73QjdL5oXviBCsTjn9fK3e2a1oeZaUn4N9vc3E3XUYLMPZD4zO33qN?=
 =?us-ascii?Q?juZyyE+rF4+RzqRVRl6i1Kpfi2a8d5xNT2tvAKg0m/nI56+7tBZpxme1pB4z?=
 =?us-ascii?Q?PBz8rE3kh9FA6MlpSbLGNGrhO27YhYBB/jasYVWL3oNdSlXz1iw7ogvSunTn?=
 =?us-ascii?Q?FwRKys2TRRaoGHSJ27gtQTWJzDS6meN0+qM/ctWs4M0sZZ3y+m+TQVMeizmV?=
 =?us-ascii?Q?RvQZkA8Q+TnKnhxZLEXsXVS+B4kiVEZEwu0o9k7ljGnhHPxpOOdT/NLhxFCU?=
 =?us-ascii?Q?HnZhl+VK6FtQFY5zB4hA8C+9QZWohv7vqbMl3NxAeUTzQclqLNxhhJAe+cxH?=
 =?us-ascii?Q?QHqF2U4yakPeqmb5DIj7pqIYdT8Z8dry2Y+1cL4i7niEcJowPRiYa/TcDzlC?=
 =?us-ascii?Q?24/AHUpvNqluPkgkypt8LM9l0Vzcflv0J+ppQCAwc8+6p1G/USU8Ga7oirSF?=
 =?us-ascii?Q?5WvY5DB0LT6FUknsnkEIo4EY4zi/ZK0UdQP+WoL3107h9JqhMJOxQ4ujm6Ko?=
 =?us-ascii?Q?MughBmhF6qXX3YrLRzU9Ly+y0nHI2BOheZVb3op9RGTKJUA/0oMcg4WDvdth?=
 =?us-ascii?Q?UyArTCMTDKaSU/k/ihRPw8t4e7uTB8Cbi2pNmoVKYsucWwOLNYf4BRD+W14E?=
 =?us-ascii?Q?do5oFpn/C4QiI5iEyh60IFDQ6eHEDihI7sobUHtKfcH0UQdrIcQvhjXUuRss?=
 =?us-ascii?Q?5bYZyK00b460n+kxRHFNVFm0zc49XNEh70FISVt1dFRNcjbRMnMaIOdc9IWC?=
 =?us-ascii?Q?JWOuZXns2qLCflgztV2QQ1udZpetNp65f903Q5+LbFLAgugku1CHZvSTf71U?=
 =?us-ascii?Q?6LhVo6MY7hJShA4Gkv+iY5MBebpzj/dx+AE8o8oZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+gv/r82BVxhum4TZRLgt5ValqsgH3a0pmL6fV+HVauJhPS7DHfHFGZs4Lshu?=
 =?us-ascii?Q?80jNSdXyAJWJ3piEBOaA6dQ8F0dq9XgGsciSblqnHRW4HL/FMBGDmzkViBPg?=
 =?us-ascii?Q?Vtu7EW5vlR4iBELff67PBrjezq28gvdmKAWXEofOQMrSbqHQfIrWwIWUEbup?=
 =?us-ascii?Q?bJNhrqXCPLMI0EiY+82SnBw2cYhqF5twZXJZkdm9K1Eg/bQlQfz6G/kif5Sm?=
 =?us-ascii?Q?d2PJeKetQNJDuO0HG2+Ga/cputozXQlXDP1vOn2t3GhvzV4+Qtgj4rdHHDjR?=
 =?us-ascii?Q?CNfvmaakdY9YU6l3/16XAcDYBZXTUQN03wxH6mAF3awaZMBTNIaNeGqL/maF?=
 =?us-ascii?Q?A7qJR9AVAEXPTR3xNucOqU0OrqAku6gBGOpPmg9WIwt8RE3b8HoffBWwCkKK?=
 =?us-ascii?Q?EUT/QLdxqxxYa4YZHW0V2HYbub7adzudbi1DHC0mY7Snk9pd6Pym5CQY8+Ax?=
 =?us-ascii?Q?yRrgUcXTSbEyRwGp/iqqYHE6e/1anfGZrAV4/fLURF74do30+3Dz68upmuRs?=
 =?us-ascii?Q?tnPplMme3qtgYoIbA6qB4ZLrUuF5CI0cd+tpLMIGSlvBuGuyAp+PQup8iGZU?=
 =?us-ascii?Q?ZYTUonQwIrapoh5wm9cIPOr1da0G+ZnbbGDUntjwYi8dd/B1wiiZZ2iQ8WgA?=
 =?us-ascii?Q?BIcrbS+Ld3iv6N9bRUkgVf6wlUDFv6H/ta7gwQTjWGKoPxiRALTjxtZa5+7+?=
 =?us-ascii?Q?0omc0AxcWPC7yETZjoo5S/ovRsaFK5thnb816E2kxjaIteanXkYBXO2AgWEp?=
 =?us-ascii?Q?3zdSTdCebGY9LtN8Kix8ybZ174wZjQ96m7B2EGk2L6nT5ohoQs7hrpxTIxil?=
 =?us-ascii?Q?pDa48kUjoIAsQQJ3uLXM+WnAwBlX+Zxt2izIyUM8No1TCDbWQAGEFNhreT/4?=
 =?us-ascii?Q?OgGeZXDxuJxBtv3+N8GO/o1zr5vEwg7U97KQ6BdGPeleUMcLDf46uqcOC04+?=
 =?us-ascii?Q?mNyOrPvtbvKDfcK2mb93qZtWRMJQ63YnhtMl8E1i27E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd9367a-d2e3-4f50-16ab-08dbbad337a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 18:47:33.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jO8itPZwdtF9iCWgrx3+nhWi0GqJH4Z+16l91lOIZHbdRhwaoqVbHlpdP+3rKjpx6qfArc1X8zV0D28QZ9Flw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=646
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210162
X-Proofpoint-GUID: nZq-V9kXkfYhqOmK5ORcy-mVHE_NSevD
X-Proofpoint-ORIG-GUID: nZq-V9kXkfYhqOmK5ORcy-mVHE_NSevD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [230921 14:40]:
> On Thu, Sep 21, 2023 at 02:12:36PM -0400, Liam R. Howlett wrote:
> > Since MAS_NONE is used for handling of the maple tree when it's a single
> > entry at 0 (just a pointer), changing the handling of MAS_NONE in
> > mas_find() would make the code more complicated and error prone.
> 
> Single entry at index 0 is MAS_ROOT, not MAS_NONE.

Ah, sorry.  I didn't explain this well.  We end up in MAS_NONE when we
search from MAS_ROOT upwards.. that is, there's a value only at 0 and we
request 1 - ULONG_MAX, or we've called mas_find() with an index > 0.  So
there is no node in the tree for this entry.

The complication arises when mas_prev(), mas_next() or
mas_walk()/mas_find() has already set MAS_NONE, then we can't tell the
difference and so we don't really know what the Right Thing to do would
be.

