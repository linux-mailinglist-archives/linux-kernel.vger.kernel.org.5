Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E9B76286F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGZB5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGZB5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:57:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E930C4;
        Tue, 25 Jul 2023 18:57:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIf4a019069;
        Wed, 26 Jul 2023 01:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=DIBi9xTxPdvJtu9ICxMlSYs5UBpUnnyTzS8D0oXezMs=;
 b=Oak5sQ4FcBEHVjnXdTZ7g2gn7TdNF4Pj32kr5iWgy9AscMc6C6eF6oItcdeER130db9q
 TocMf+UVkZJeO1CWX1uhAEApVcVaZjoVSjN477WVSyifpONga76VcdAsSq3gZbK99mbu
 Pf/CMMtsZKEDcYTbHDTQArLMuBm9XeVHDw9lic9WcerKbxVrKvC6Redo66zKayLM1X36
 SbuPozCsNIbhty8n0FyMJE87ToE2qhl8PqRwg8hmQ6ODCtIbXDPnGu2HlRVV1+oVmgWE
 OwtkCTrQyniLTtrf8F0cvjp43II1pPo3xEY3FyTH1PqMJc3FYetRCAlbzoyFKg3qNDzp XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070axdc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:56:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q0Rk5E023169;
        Wed, 26 Jul 2023 01:56:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j5j64m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:56:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYgVznCLIrs8IFiT+EKZhBCptYEcMqyOMdzdOXttP6opZ5kQ2nZjKI6g09QbVR12y5yQJn17hQwTzmEpYCe02Mlp3mlYJCB/XBL+HyT/Q5IWMr7UE+OfVsZ3yB4o7rexhnjx/PMvgfdlTwl0Te6bboGSd4+efQOzqM5WSGCpqRBbkFDadsy0LnmGWOu5+rFFDWFIuD4R/vUGrGcWkCOFT4WiZubMTejv/OzFBmvoB2PvzTa2h2xobrS0WwGfSXPBCq3rT8HU9ROz/hEtZuM13rW/rog2K33TGWqcAEdst8sfHBjRl+5hYa1yfjHRWx7ApAijhV97jKNyTq/uVkW1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIBi9xTxPdvJtu9ICxMlSYs5UBpUnnyTzS8D0oXezMs=;
 b=kWiaQzB+Bup1/C4XVBYnOV/NVNaJiKC+DUf33yuRfnK/TbY1Qz1bRWt/mcuAgOBtUNX9Lqmj/10JhNIbihJL6ChrUS/3Upyba2Y3//4dY3p+1Vy6pIVWHBozRs1RxQYmfhL4gEIfl3u5BaeNWp5v3IFXlWVbDwfsb96YyliHe79TT588BOFfeRtSjJqBlzDW944p9Du+tPRfidaJnvIzHmWLHlb2+Q1DDJ2Q9UYzrNwcSJoptu9CY07AS7u019PW13OZ2xDYfZNM7oGuEZtelLs2H0/GXqM5BXFBnJRG4QmIe7KeEdGUGodWKygV5wjcxs2QWHBpvCS4UDKKTmnOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIBi9xTxPdvJtu9ICxMlSYs5UBpUnnyTzS8D0oXezMs=;
 b=pn4DnR3QK2XOtNc64BapVDyUCT9++OHL5zvKJl9ECFS0ET3Vtn9HVjkS3rjVWndVMJkHLa36woihCVledK6SrRNtBGwAOI1LarISL4WKFsS59/5J28ZUxF+mTiFs1s8P4/0+/WN+wR6C9Of3Umob9mktPwT3D4UV96HmTBBtF8w=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7306.namprd10.prod.outlook.com (2603:10b6:610:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 01:56:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 01:56:56 +0000
To:     Lin Ma <linma@zju.edu.cn>
Cc:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scsi: qla4xxx: Add length check when paring nlattrs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lef3xwo2.fsf@ca-mkp.ca.oracle.com>
References: <20230723080053.3714534-1-linma@zju.edu.cn>
Date:   Tue, 25 Jul 2023 21:56:53 -0400
In-Reply-To: <20230723080053.3714534-1-linma@zju.edu.cn> (Lin Ma's message of
        "Sun, 23 Jul 2023 16:00:53 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: f20bb702-6e7c-4e08-9a82-08db8d7b973a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jcgjPf7tpBAbVIAPRcJd+c5CBQJwCkIXoVol2FpwN0LQPRagAyXdag/jrshA?=
 =?us-ascii?Q?JgPbcsuLYY1AsQosJ7NC4lOpwAjJq486plFCkYymOsauQduiZ3aMCjKcZ3Dx?=
 =?us-ascii?Q?us2uWK+oqYzju/0MXGfJv61Xh6Sk1/UhUWSvTTjZgLBwW5RSyC4GZr2zhw2k?=
 =?us-ascii?Q?0BZHdFJB/sz8B7ZwEvwxrhOmoi3L6Xl/R4LcopgeIHXJDlZyD2qt6HGiJCH1?=
 =?us-ascii?Q?CB1Of0wfLRTqFh5AYkF3gNzkTDg7Dg/sU3SabZ3pq3JnMsEYt2TTKjuz6B1M?=
 =?us-ascii?Q?xuY08vaDY417akYkdlMaJHOwSlRHkdH0kdA4B9AfMxXtKVfaF9efbU6l6bcN?=
 =?us-ascii?Q?52iro2hI+JIw4cTyZ4STDmOLWSH3fdgTRjbDJQc5AV+zSPha7TCWHLvzNjMT?=
 =?us-ascii?Q?hSIDYprdV3YSJKsNkEuOw4qPyq2yfIB8Ta6dhKDu1+002JsbONGrFWpaRhy9?=
 =?us-ascii?Q?ixv91HfJABRkISwbbx4lAYzzax8Kw61kSOTui8WZU5C94e3KGWFdf+klMdqV?=
 =?us-ascii?Q?wz8in62J4efXYt2novTMNjELhb2Flx2FCO4S+DmUAzojTomFsRFmRd6Yj0TD?=
 =?us-ascii?Q?HTzlzp0jXtT6NMENgK4ruBExojC0O/s4XAwSRu9FIwvaYA3J2dewFVVc561O?=
 =?us-ascii?Q?1Ki8Ci2ncOwu+jyzpxq+LNZ6pNGgf/NdaQU6K13QRd82zCR+LW7njMp8fAox?=
 =?us-ascii?Q?tLNuQTRHuKs0Yh24waTNfyxP2Wn9SFOm0BSZFS5iBys98n0loGkNVYTkIw0c?=
 =?us-ascii?Q?Oup6XOZjGcz4VRLsmME1Cj9EkuvT8B+nlP5//KBRWSLXRU88eMdgGof+ndoH?=
 =?us-ascii?Q?/lQxtxyVxpokS3UK4whsiR53ksTm2X1qQ5NL/G37e56xhcGFlgXg1V1Wfi1m?=
 =?us-ascii?Q?Y4IU1y9cxkIflYXL7wKt7dzpW9UD/zRH+6/0hjoe3jADHMe1SRKzjMB+1j2C?=
 =?us-ascii?Q?45Syv0eLLGZkJZ0VY4eIa04GsXJSo0S36mjSphH/MT7vct/eA0Sm3KoVnfMi?=
 =?us-ascii?Q?cTAt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230028)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(6486002)(36916002)(6512007)(6666004)(478600001)(66476007)(26005)(186003)(6506007)(2906002)(66556008)(6916009)(66946007)(316002)(4326008)(5660300002)(8676002)(8936002)(41300700001)(38100700002)(558084003)(86362001)(59833002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zEZLB/Xvl6Y0i6EcGUJuSAAV5sAK9A1X0FKpVpDLjuLjN6/jyth1R/htupx?=
 =?us-ascii?Q?Zxs9XBT3MLEJ7gabDXWKEqumj3EiFSKwDx8d1gU2ZMCnAhuLeZTpbm/RPsng?=
 =?us-ascii?Q?LMJrMQVKajebTAKocAXJ224SdxVQoWBuEHrqHzseKZuiY2PUghAmH/Zte5ga?=
 =?us-ascii?Q?Z3LYVZZm7cvmMmGTrk4HRC7oj+ktmn/lYIq8DYP+ofTGp+bUTKCM1PjQVoKl?=
 =?us-ascii?Q?bCyAJI7z56v1Qtr6Hyc1N0quha3YMQxQ9qY0g0NmaBgitXH0UsvQyA0cNdbZ?=
 =?us-ascii?Q?UB3U1PLDnUo2FLbsIdyoohA2t+uXYzzaz0v+trgPwGjd52JiHKWW3KVb1kY+?=
 =?us-ascii?Q?T0agc/DkGJS/xtPryORugJsdGwfkA93/84RjbldCtJgNbcfJjYH9nDSsWNod?=
 =?us-ascii?Q?x2n2WNBy2k2Boc6azLcviZL86dz+TuC4OToZKY/5Nhj5c8A9Sw8Tyq/p1xkE?=
 =?us-ascii?Q?SwP3TSh4H3oc7BvkGcAuzsiDt/P+9/dtwxgZOLTD/x63DkDE/ndwE1Q139Kh?=
 =?us-ascii?Q?9+wv4OulUQJdnwXZ3XtjbMDQ8RreZgOQEwyzBCf1kCcxsRsHbXlPAhDUchWi?=
 =?us-ascii?Q?BFSkxTIWhsODPqLOJDrB+RoQXZ5qs+1EOktvfAoMJqIEiMu76ZnK6ziQEqG3?=
 =?us-ascii?Q?zcgYuGtd0Vq0wdN8WUO5H7uUm53nCIXXvQ+aRsJ9eCzi0VFYe+Uh+NjQhrbg?=
 =?us-ascii?Q?hPwT39cYyEFX7rVtWM21Vanf/9vQ0UxS6IkU8+zaMXJn2P51fQToK4qLHP1K?=
 =?us-ascii?Q?pCQdDs0bu14vD12KTSuWAHC/GP9QPrccutkfb1HlXzolmIVePe2yK5nibOWb?=
 =?us-ascii?Q?br51Z9cO4eP3VIKlGCdYxS9B4YbGBd7xVT8P0+TdDvIdA13DmuqRyJyn0DlN?=
 =?us-ascii?Q?rcRtuHWbhPIYlCTHFP/MgC+zC5MzKriJ5pLWntjZBHiPVYyMN4MkLRdOCkOp?=
 =?us-ascii?Q?7KVHEhEYlDxOEtf7uw+WXpGD9X4PksDXpwccgjSlBSccOd3dXCR1H4c+nDI1?=
 =?us-ascii?Q?KvWCL7LB+LeGsYwrrUk4IytIbhi3GN6u2gu87mnuu7/L8vlUPnBILq5/qGk0?=
 =?us-ascii?Q?muiHGv/YdVe0NtHIIJTYWpw2pC/uRhpL4bxVLkq496NY2VxlzAgw3cjFq/pU?=
 =?us-ascii?Q?aheJHHUjCvf2DNUji+hW9MreJCY3q1eOl909z+3cAjPOnUDD1NVAB+Wfl55G?=
 =?us-ascii?Q?cF85qNkdIXlwXCQKQcb5G2U4pHGG9qhjtGCPNB8oYTwUSwq5aNGsW8Y9gs1F?=
 =?us-ascii?Q?WPIvNJvA1lk1/CZhZTz/N4pVjZB7f2R4q0nDQUbpNF0sP+8wMH3GTTGxKnZ3?=
 =?us-ascii?Q?8rWfz6IDPuYRZewuNQt9cU9JLFlP6T/dzWJ4rhkr6er3kq2VYHj0WXNuPB6Q?=
 =?us-ascii?Q?6Pg4x82QxQcDjWRRKy5Jf9RlzQdOV8n5ySq5SBb9WT5m4Mu+fWHBtuMDWxu/?=
 =?us-ascii?Q?51qm37R/8NCom0dt0UYcuRfdEygjzyX+9xpqmDES4RFcg2cdS6v4SH2H5w9S?=
 =?us-ascii?Q?Gw4T3/S6nZdIM9GvPVAQ+ZTomBN1WuUhpXPTrOYNG6i726UPpM2CDu7tCkT2?=
 =?us-ascii?Q?0yq0Pyup76io2ltw7mn87N0M3as1wxeI2z7s4fHy6yJ1vlqAaENizf42JXOv?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CcD8/s+Vwd5C81LY4fk4LChvipNGWj4zZwqWXmHyMZlrHEGjmT8CalrP+pyxvzk24E0fXcfMhyOcMnN+lLTcrr3ZplVOQZ63yDt0Z6aOcL2g1jsMa3/6ktSZM32frHXboSjDIdsQ2w2UWreR4Qfgnqx8BHKJkF3P2NoTwkyinRNFwLP0Hr6HW2A+cIS4I+RmNtVH9qiQujGw+rtEzG6JnW92RfbXJDwjh/SY8UOMXu4qO3UkHA7ke5bs92nvSorxvDvVz3o1Ftpf44KgPisAC4GMyacr2gk7pAnl+FQdzoGhZM3ga6r+RFa5v6prDekVVBTaPqtZp2wXZN0x7CUxJRYQcJABrYS67FXB1jsIVc0EMFGj1jPjAMnTj3WQ8Um0fCvWEiF87o4Dyb3fi4fX7YSJnvHEtENkYsgn0SxjlJWKji0RJlmKseawKKd2TCTrTgtnwZSSagL7Tcsoyns2CHWJnAeAOd3x8bvjNKzVjNDFlibs3LVK2OhejM8VNfvLdxPThBhRIzd4Bbi4leHwcvEQNBS9Jh9X5c7zbQFCV3PNTdE7zxIisuOQYTut0a5ZCz9T2BF8lofu8vFgJ4Bv7qOmY+5qkTvbVxV3eupz0S5vB7iQA8QIYEbQd75bOOo+ccc6kb4nnIDuBLCSg92zmmXpvvgI1/ImmRKmX5qhzxRuI78Nw2gZTjLDCWsogSXQicuDQ71ULJ2QIl3HykQQaQZGGTjGcCwoLN8jLLym6sYeMh6AbSpMT6Oyncyr4v9mymSfO3Aed8bXOA8oK0kDNruBjHOfsp/+z6OGco4egWoPDI/Cgswh3TgSW9i6uiQDyyCHzsOrtE2tw3lWi32Cg02GAI2zmGZCoz7BqLfxwCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20bb702-6e7c-4e08-9a82-08db8d7b973a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 01:56:56.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT9mcuxe+SFErLJtLB+JeFDDNlcskPCtDvXF/O1F1eOuIglzv4aBznpgykwCRqtA2BHrrbaozZsmOd2gk8p5NH/zeN+Rk0QnsHI5u64S57I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=845
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260014
X-Proofpoint-GUID: ekhOfNHEwRixiuQn_LUqEyfGsQhOvUUH
X-Proofpoint-ORIG-GUID: ekhOfNHEwRixiuQn_LUqEyfGsQhOvUUH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lin,

> There are three places that qla4xxx looply parses nlattrs
> * qla4xxx_set_chap_entry(...)
> * qla4xxx_iface_set_param(...)
> * qla4xxx_sysfs_ddb_set_param(...)

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
