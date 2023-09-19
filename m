Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1603C7A6C83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjISUus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjISUuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:50:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB28BD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:50:40 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JKgZex023754;
        Tue, 19 Sep 2023 20:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Z6z1w6gruHEtEVN+5aglaeIPS3pkBJ9dfxS1Ajt6U/A=;
 b=uThaptew7St49joZL7GCqd5V2PzrCTx8ujWKav3MaXr5bl5mIw94T4lVlCKFpXr/8wH0
 46/ArO0W/rZ8OB5UV9cTcDiTub+X6/fp3CllVdzSzWXzsZq07LR29r4G31FQZJaNQtkM
 dxcr5GJ99qUYAvCMJuF9IAgOETDqznzFdiJR8/Y36YRm/iM6KcctTnLLP9sFRZJIv/xZ
 I3J0OqZ6VjdHyhJg9zeb3W3DDAzBn5sbv3aiBRBEyKHQrQwsnVNeiv6HilItctQdamqR
 RK4W1lR0slW7bzEqhaOhHVkyqWRxLlk+tYEyr/EvXUxhH87d3W+N7fQH/rt46Noupqyq 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd5vcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 20:50:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JK6kZd027348;
        Tue, 19 Sep 2023 20:50:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t6etk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 20:50:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoXq5vSGia7zMysvBU5JmtK+gkTnzKtU5NJgfswl6IHhIz5tBoppec98pFp5WZN7u4cqlnS3S92WdQLGe2G4UekzDgxce+lPZpLmVoOjIiZKOVJHE+q4aplNM9Whh8bi3Ux7/oIXdjOz5z7v7096UQKBbjccaVW+IATsOcgDTQzAXGcNU/SQdDNWbVskTDi3KmP4ETZLqSyu0pxPteITSkicTgRA6fH/pYZ6wzPDFBnzvq5Mv8udw9VQl1yggGViwNpNZt73D8nEJpkw45xYvliXOMIXYEdGLa9BP8UFQF/z9wWYEPbE4OF1/G1MUDIUOAODxUN2ctx3zMknR/axAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6z1w6gruHEtEVN+5aglaeIPS3pkBJ9dfxS1Ajt6U/A=;
 b=Il68uniM+Vs42/lZOlpoinT8RgP/u7i3dH55y5EOlIHdoiQCQ/3I3cgNgyuRnrNEpUb5FI/em2icsOpOm4YR4bAGE0S5VFr4FKWdZ4nYR7JHtt/HPtW+Kdv2Err+WRAMKXyXt3neHcBpImkZvXjWnb7Tqx/2ekltWKGIW2ja4rjEmMhUagYe9O61O2GMCWqH7xQJgOHKYjVcY/l6DxTQUbpUlvTW4z0wcaj30GOg7l3jeA45XaSa/VTzDDmw1bOItEh1qzuqa195o+8OLIsgotAL6JQFSlVWLUmIld2NK0H9jLLrh2C3bgLnZcf2AWA6v6vJX82QgzQuzPjVGHIwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6z1w6gruHEtEVN+5aglaeIPS3pkBJ9dfxS1Ajt6U/A=;
 b=eeeTIUCg4uf/OlwgzKnsEwjJZBZ54jPVFyOP1K++aUC9cjnXecJlPZZ97sfkGQRwOEQmVLsFreZPEBAp04/feEShlIu9pP5Ew9VWL8qqMsLwD7IHvMc8ffYkG9z1tzEzqYugKSaPKClvgxZzuWcr4ENfaC6L1AkOwrIn1FSRyTY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 20:49:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 20:49:57 +0000
Date:   Tue, 19 Sep 2023 13:49:54 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 3/8] hugetlb: perform vmemmap optimization on a list
 of pages
Message-ID: <20230919204954.GA425719@monkey>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-4-mike.kravetz@oracle.com>
 <e284396d-c32d-b69d-21c6-7025db93b873@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e284396d-c32d-b69d-21c6-7025db93b873@linux.dev>
X-ClientProxiedBy: MW4PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:303:dd::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b982e20-d32a-4a76-bc58-08dbb951fbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lW9ZsV/ReDrIhvG0bgkTJIotrLM5PKTam/Ur76mw9OiyV2GrwV0MnCMXByJZJqx1n8aeWbtfdxlZcBb5lKAN39gvD3MVVueFIK63r10JL550qiH3US2qn32igiv041ynul3FCPEcou7ZscuGc0ZvvBv2RMk0rUMF2BcC5fm62XR9EzEuSQju3VFs6hb1P1L/JsSoT99xUnRyxgpLD+hZR6oHKj4blgPSEU9u442k2wcqYP+zvYt7/Drmka+a8n8xM5hctzuV9/2ucj1tBcSKjauBJD7VcQ/S1CK9go/z/qKs4/nWi+/Ir4uprGXKJExaDKjkzfC0s+Hbf+HBpAG/32qoBNpTo3QDRt1jpu5KNsBXgtFxbqfWPXrQRzQueuj1BkwgqLMwJsTErKxJiSijRBR4/pedQB2Md2bwyem6U4olmuOLTCIFnV9ZFtf13F5JTvgFFyZakEIERLSggNVPCAUVxzSARX5+gQ+SaCqf6DpJ+USOMHpVBrbUTInaJSbNNctD2APytW3Q5zcxVVVYQqyCZf2Hn14c/rdI9IYziYtDZ1JQWPACE7EqHkQTXllwKyQUIbgW+zYUhGkbToj8oJdrEZZ94ZXpb62SkWDgnNVJ5/A2wU3ceuygrOQbBokN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(366004)(376002)(396003)(346002)(186009)(1800799009)(451199024)(38100700002)(9686003)(4326008)(8676002)(8936002)(1076003)(33656002)(53546011)(33716001)(6512007)(66946007)(6916009)(41300700001)(26005)(66476007)(7416002)(66556008)(86362001)(5660300002)(2906002)(44832011)(83380400001)(54906003)(316002)(6506007)(6486002)(6666004)(478600001)(76704002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gjw+Wt+hgGeSsUC7qotZ36AvyOv9VX9tLUxiA/i5ZBbeJ+ef4/QTfCABNLf2?=
 =?us-ascii?Q?nojpQvBzMnyPvOiSXj//rDZiWGdy1IwJMdmUy17EXVAgYYrsCqpkPaFZz8xc?=
 =?us-ascii?Q?LtKuJoEW6PtD8SorqTaAo+okg+6anPFH+Po2kEJ3WCby89TUhjNVk0zYfxKv?=
 =?us-ascii?Q?D922+0CTJHEjkPc6pSj7jN+mKhQrTZK+jyU2tMfn+ZdG5nZHamJDWOUWZJWS?=
 =?us-ascii?Q?u9ijs6l13sMNY6dk8veeSMzuDUqhp7MSvR4bjuSdxYSB+UXh2G+3vKGwNeS1?=
 =?us-ascii?Q?It031zMjcEbTLkhP43sAjfY2R/rgZPhJRtN0CHEJcNoVHaMTDvPr28lQ0XPb?=
 =?us-ascii?Q?aIVjZKgpsroOiIYxyowej063T4MXov9hDMzWy+nI6d+rCuvVI7K1h/h0+zxo?=
 =?us-ascii?Q?sYjIPHvIHJ72mXLTBS8d5OQ7LyhpU2b4Rd0+R35z58icP89yxQe8DoMlv5i0?=
 =?us-ascii?Q?HI8459IWkS3TzCBw5FRCuwZCUJP9Qk8+J/FnoY3AEUE0MAAv9sHHX+0iiHGx?=
 =?us-ascii?Q?yZsfJpKRPwyd1y3LdLrQoiLy9qgxXE7jn/LoMlC7zWzZUEA7ZzPRhRI5xTk3?=
 =?us-ascii?Q?oKBANQ4RcheTKTGEQAcMI6sQ27er3pViflsa1QhfOYOZcw09CFLRn3q8d1KN?=
 =?us-ascii?Q?VLOc/s/9d3ry3fqof+wKMR7/OkipWN/Qj3EnicthfMbrgLf5MgOgYUefm+VW?=
 =?us-ascii?Q?Pm5AVVZba5y6AKyJ8xqwlmcxWOT7SuHIm9h/F/wOB9jjVQ5R5P3sIb+tiSUh?=
 =?us-ascii?Q?uzQYfMf5bxknn4pk0PXr1uPQmf7uZVcdA3tFreG6WHWSinXEJfqXEjPRUhON?=
 =?us-ascii?Q?Q+6CI9VrwAZ+MCFIc0knT5DWzOSslUBxmU6PBytOFJkP8d0qdoZo1TlEzW7R?=
 =?us-ascii?Q?7IFimOaMD3S2omw7gd3rOc4+5Qe+hs4KQ4j7FWU39qhVDRSh+Ci7X35meyEY?=
 =?us-ascii?Q?aRIM8BtpilNbjHxil3BvNTwX3PBlEINPFQEcRzPN+hlYXFRoiUXwmuoJBASk?=
 =?us-ascii?Q?b3Llf1zxym756oxHvrUStEg3XCunhVY9pRTNip7fy7tbayMqUeEdBWiam7PF?=
 =?us-ascii?Q?P6C4xZMaGi3BpyaHet/IhWKKRwLkeyDIBGKBLcixpV04bhWett5n74SOKyva?=
 =?us-ascii?Q?jeGKK9EjGpsnW7vyzIQnzuW+2bDrpqa2jxlPPGB5KjRSqrcoyF+/n1AnWZfh?=
 =?us-ascii?Q?cOppVGeW8AijKbIEgVNimLXXQA8tnZ7Q2B1f03Owsg2Rh0lJrx9E4I8cWYO0?=
 =?us-ascii?Q?rKzRqn+FgFwlF8o6WpXfleAPCLNCvCp0w9SiV6cxUdMNwmr5ECnbAlU1dW7H?=
 =?us-ascii?Q?YIne/COvF7oNdjsLFh+WGBj7kMfoTLQO1n86PpnKtB01sZysNguBq/YatK/e?=
 =?us-ascii?Q?q9LBb7pYjSVHLONHCgD4xO4mNP07Vz6xn9oqElR74Ih6rIhAnLJvbPuYAxDR?=
 =?us-ascii?Q?uM1WUmJGMwVriDnwlNOhYXOL4+4K8LaSL4XyxkUUTRniee/RTajpsEQMb10Q?=
 =?us-ascii?Q?QOd7N+5cO/OEYXEC+/i+0dRejqzC5PgeTN405DU/UKNOqHSNegieKJQPX18y?=
 =?us-ascii?Q?/1mBLayAj8nt8JlHznqwYshC6d+QRW45BkT+DLERMFGphPn2ZPf25KvzrZxc?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xqk6BGni969LiKXbKwtionT0gvWihZwRnr4Z/AuGLqsHIFaCvwJo4Rha34uT?=
 =?us-ascii?Q?O+M8ojJW9Vdfz5IoUV15dPEWxYCc/5DbqdBmNQQGUpoN5kqgzIjWiOQktMKt?=
 =?us-ascii?Q?I2xfdeFYWjJwKoha/g+RAHVmvmmCyIrsAE2L1imWkuG3n3InbDPoiZ+gajtA?=
 =?us-ascii?Q?JUDe4pMTi7I1y0CqKjmxB1+iwg4ewopbBtQjAgcxeprEFc2/6uqlYZXP/5So?=
 =?us-ascii?Q?XgpvsE3UEgin+pwFLk1lkp5WtemtaViquluC//dpkuE1/XlbQKwKur2+3ySJ?=
 =?us-ascii?Q?OfvRdWN1BGVk5es215OkWsiN6Q4AhloQC7OMxhnN0FiPAPbs5+TrrcNC/lrG?=
 =?us-ascii?Q?PcET55BmK7Oi6m6AlrXbyDwx1qwkl8IMYQKRgxtvz1T29EVo93PlJk32wB9m?=
 =?us-ascii?Q?jAUJ/DZLbAy/sTA2FN6bnW+WBsYkNhEvG1STlsgZHe5eSSNGyOlLfEiYwBV0?=
 =?us-ascii?Q?3PcvD4WB/DFWE9YbKL2XITV8/h3ijmkghiVL4UPLFWGmrD7MTyQ+gf8gOGEU?=
 =?us-ascii?Q?3AMV3ItCRY1hDvcSp+NVvRehZFeEx0GTw2JWgAumLbIj6T0VnhQjsGaVUiP4?=
 =?us-ascii?Q?h/7ke+asBdez9piNIMvXSMG3xiIvdjDImOxdh04Oo19mS99sizSN6LnlpC+a?=
 =?us-ascii?Q?7D9b91IqJ+MVVbosaSpd+yv99z9v1MDordWy/LdwS1yRRCiEVAK71nurEL0L?=
 =?us-ascii?Q?BluWYlJXwPNCczPtbQEHoayGO9bqSZSggldXKZrQoW0L4HPVxm2FBp3MA1i7?=
 =?us-ascii?Q?F0UUB/Jc7NFpoYfK/bLqcUYpfRtrTB0HcOi3YWwd8QnyZXgpPOIGTQmM70F5?=
 =?us-ascii?Q?tkzxbVnRt0i0+0VNPaLkwnXYckdJ3R438MSLAZAUOZgZ000Ss7E0AyWvOT4d?=
 =?us-ascii?Q?g2kiB9xdBMHUFDx4/xdKFOBpSSa3HW831rUHQyZYN9j5MBovvi8/VcMaSZJW?=
 =?us-ascii?Q?la/A4arRPnPnBn6vCIA5TSgWipxhIKziQmJuLb/+nwwE9aJE79/JPmID2DfJ?=
 =?us-ascii?Q?0WsChc+pRjSepU4m9RzT7aCpdeH7TwGwAMCTCntoS63ZeWvryv44aNZgoDxq?=
 =?us-ascii?Q?5Aa2j/69Zbp8HlVYmIsWTmyIC12SADLckacrJipxbYNUO5zP3dAU+Nr5Ux8f?=
 =?us-ascii?Q?2mmnqmoATZpY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b982e20-d32a-4a76-bc58-08dbb951fbf5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 20:49:57.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VuiIJo69ew2EKffO/ka0FmoatFtcu4qd7/Vb2fwtV8rCd9ZkcU+N72BuyZ8RuxmZt06a5v3LbtIAb1h4X+Z5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_11,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190178
X-Proofpoint-GUID: MZoUtUK8rGOlLQBC2beA53LYGmjD8-LN
X-Proofpoint-ORIG-GUID: MZoUtUK8rGOlLQBC2beA53LYGmjD8-LN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/23 11:10, Muchun Song wrote:
> 
> 
> On 2023/9/19 07:01, Mike Kravetz wrote:
> > When adding hugetlb pages to the pool, we first create a list of the
> > allocated pages before adding to the pool.  Pass this list of pages to a
> > new routine hugetlb_vmemmap_optimize_folios() for vmemmap optimization.
> > 
> > Due to significant differences in vmemmmap initialization for bootmem
> > allocated hugetlb pages, a new routine prep_and_add_bootmem_folios
> > is created.
> > 
> > We also modify the routine vmemmap_should_optimize() to check for pages
> > that are already optimized.  There are code paths that might request
> > vmemmap optimization twice and we want to make sure this is not
> > attempted.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb.c         | 50 +++++++++++++++++++++++++++++++++++++-------
> >   mm/hugetlb_vmemmap.c | 11 ++++++++++
> >   mm/hugetlb_vmemmap.h |  5 +++++
> >   3 files changed, 58 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 8624286be273..d6f3db3c1313 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2269,6 +2269,11 @@ static void prep_and_add_allocated_folios(struct hstate *h,
> >   {
> >   	struct folio *folio, *tmp_f;
> > +	/*
> > +	 * Send list for bulk vmemmap optimization processing
> > +	 */
> 
> From the kernel development document, one-line comment format is "/**/".
> 

Will change the comments introduced here.

> > +	hugetlb_vmemmap_optimize_folios(h, folio_list);
> > +
> >   	/*
> >   	 * Add all new pool pages to free lists in one lock cycle
> >   	 */
> > @@ -3309,6 +3314,40 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
> >   	prep_compound_head((struct page *)folio, huge_page_order(h));
> >   }
> > +static void __init prep_and_add_bootmem_folios(struct hstate *h,
> > +					struct list_head *folio_list)
> > +{
> > +	struct folio *folio, *tmp_f;
> > +
> > +	/*
> > +	 * Send list for bulk vmemmap optimization processing
> > +	 */
> > +	hugetlb_vmemmap_optimize_folios(h, folio_list);
> > +
> > +	/*
> > +	 * Add all new pool pages to free lists in one lock cycle
> > +	 */
> > +	spin_lock_irq(&hugetlb_lock);
> > +	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
> > +		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
> > +			/*
> > +			 * If HVO fails, initialize all tail struct pages
> > +			 * We do not worry about potential long lock hold
> > +			 * time as this is early in boot and there should
> > +			 * be no contention.
> > +			 */
> > +			hugetlb_folio_init_tail_vmemmap(folio,
> > +					HUGETLB_VMEMMAP_RESERVE_PAGES,
> > +					pages_per_huge_page(h));
> > +		}
> > +		__prep_account_new_huge_page(h, folio_nid(folio));
> > +		enqueue_hugetlb_folio(h, folio);
> > +	}
> > +	spin_unlock_irq(&hugetlb_lock);
> > +
> > +	INIT_LIST_HEAD(folio_list);
> 
> I'm not sure what is the purpose of the reinitialization to list head?
> 

There really is no purpose.  This was copied from
prep_and_add_allocated_folios which also has this unnecessary call.  It is
unnecessary as enqueue_hugetlb_folio() will do a list_move for each
folio on the list.  Therefore, at the end of the loop we KNOW the list
is empty.

I will remove here and in prep_and_add_allocated_folios.

Thanks,
-- 
Mike Kravetz
