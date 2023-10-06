Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268527BC242
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjJFWgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjJFWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:36:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF5BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:36:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396LNtRU001709;
        Fri, 6 Oct 2023 22:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=P1BLpiH/P6vmFEjJ88sOIy5xeSiQATmRJyl7kNY+6NE=;
 b=D5LTOoQ2xzrQn0H70T3Rmf+MwPDnkAfvO53zMG+wsXW6E3EH/0S9izHHhUFlVhIAMH1i
 DHikWNUWoXtl4PaHjc1wkAzbkUF+MWrbD5GFYUX8VY2OcKAzsP+Qq/VuJmpPkgfwGEI7
 SlyYxaUeUWooLbtRw6x9CnoWYR3hsig3U7q7fViSfU9LXw9oKSPLqBH+Bwbz3tPMnfQ9
 dp/gNouCuGKvQvUzE3PsJAcRVrkMWZ3weVLzA9zps27QCVmOfLV6IGnuqRN2u9y052AW
 /31nq10mXwClhGLGSlw2ZHQz5Rzsv60I6Tzx2tmvx1q8ChDAjE2+R/xE7z/ZzFVJHw0k kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf4cx8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 22:35:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 396LL2hF000467;
        Fri, 6 Oct 2023 22:35:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4b6hxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 22:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH2LeVBSGhB53yKfe/z7ZVgkWXY/nIlh7YGDrXnwyZT/5bBqizzNV9MxMCXvfYCdfzvxNPruVa3NK3wRYTbzuCQnqwMjyJdJSXbaE3AmKwFIEA/Cvo5aUHPkYDaBc96mj3rO5dtNcU7Dd5IMlYLJJjsty40Ys63hBZFJ/eFToHaN0QON4J5Trh4YMuraVTL8W2vvX8ahDv5siPPpN8pRO0k9Cwk1eX4mXT1hqeYwO+PAs5kGjE5xTpYN3/F8XRYaPjmk7QWP4h45BZk7wfhJGSQdLu3b2rwW/3zrUXeVOo18Br1jVRLVs6xVyirOssmDll/m6DGWU1wT9x90p69s3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1BLpiH/P6vmFEjJ88sOIy5xeSiQATmRJyl7kNY+6NE=;
 b=hl4e9Qx6/rAWKeQJQyfUd4/ueB81Hw0aQyFk1WwdrhbwKIALTwUEYM0+mZn9jbx9Otpy750DzbHKZr+SCyjRhRze2jmZrKnjAUMjjJT5wlFsefVehI6UnFipWfCNCxWZPn2bZqH9yRckdIftAjRAazzbZbRojgE+bxMKrR/+IMh1pPBHrsx/rCUGrvO85onHZHaY+4plKumNzh1joEtdk05pNUhSYH/Zu3jECufMln/gEEzImJfaTJMIZwYDHnBsnon1zvAPO4ef8u3Mgc4eQChwDiHFl52L9lfcfNdImu3hzysG4Gy8j1J2JEor6ElfQQ6IVDRHmD9b8O3YxVZyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1BLpiH/P6vmFEjJ88sOIy5xeSiQATmRJyl7kNY+6NE=;
 b=w7PZqPZIqcf7atK8GFdFLUtmj9o9PU1OGelG4lpUtnb8hPfk8Mb+Lmze1ZaTzwwgJnqKUqPy31EKAHTynXz784FFLrMPgigPRIAOHSqHT9xBA136cPXPZ7hN9mkyaXjHzPEFSx5+uqHRBEvlbVvGwQ9ZpihGL6sCZguYfRFlYzA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Fri, 6 Oct
 2023 22:35:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 22:35:16 +0000
Date:   Fri, 6 Oct 2023 15:35:12 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Message-ID: <20231006223512.GC3861@monkey>
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
 <20230929205731.GA10357@monkey>
 <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
X-ClientProxiedBy: MW4P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e59f302-14d1-4efa-d68d-08dbc6bc82ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KrxPVu7bINgAT3TZWQTyZVdsht0XrKWT9LuOFNIz2JtjekIjc7H1wxJmYzGs1hO4uNcYzBN0SIGYp6vUuW0+44aORNZECVj7JvzLZyps1K4cpe/neoqv6A6/OelO1z5xNF0Heku+YKb0LAFlJaQO3jWNlqU/2TOF/N9lTD7WR7X7rM3HVxYRkne1Ilz9A7vlSFBq+3/LoKY7nW9MnXaXuxdwZ7OH9AaRm811U90jbQzW+gR5yHLDUGkRJMrzd31pHtr8Kj4kszXdv5gY4WVEYDEByXo+5SglBp3bMfj9QPydA7S5YFOJZIGezqsE2noYD1+uAmj5utTLfQeVB9TAyvTwA79hDikPSIq5KkU2GFSexkV0ydiMCsttpbs2PfNgnb5kyJrMQcD1mmXamFAOADB9PBA7keBQ+vl6cL+nIYl8ELgtXXyI9TZM+dMHC73iMmrXLLmanbOZHCV3/crAYSof0zuDpRiMa/tDHiRut1urwy9MOCdYWSaGZgZECVhFfMDeeHQv/9EUtlqBVxYdQ+6JP0X2ZOhS4BZgrlk+g1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66476007)(26005)(4326008)(8676002)(66946007)(6916009)(5660300002)(41300700001)(54906003)(44832011)(8936002)(66556008)(6486002)(9686003)(478600001)(966005)(6666004)(6506007)(6512007)(2906002)(7416002)(53546011)(33716001)(316002)(1076003)(83380400001)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?brjkWPmDnGcX883awj0GD8ZVHjPQkX30+7IFIbOmftbNygNmkwIKfxVM3gV4?=
 =?us-ascii?Q?LSkuUDb3bB2g2JpmeLK/r+QNCQMI4AbObs4QBQAuk9SOvTT/npE74ivJ3fpP?=
 =?us-ascii?Q?S3ComxQzNWGIChwZxs3SFWKpiCEQF7rScm16IWE4rBvsCtQf3VI35tmLx36W?=
 =?us-ascii?Q?RYAPlrlmGj2h3NMC6MelaVJB7vqiXA87LW28E1KbG3gHdF+fbnd1pNC5X2Or?=
 =?us-ascii?Q?kldViuQGhWfiNq7ENVbQtX7+5klzG3aZZRbK4KkRnZjIn4uNIfWRRN/qXDlL?=
 =?us-ascii?Q?Erpxv5WYf+aZXEL49qKBQOfcRdlN6i7R4jUveYHh2gRgmvZEOHXOra5UwQgU?=
 =?us-ascii?Q?+OagPB9qk6J+9s6Zdokuuh6xEV17K0wo269U1MLuHffGDoftyvgPfd5owva3?=
 =?us-ascii?Q?nSkccR867MEn9hKcDOMGoynvLBzRj1oExQC/P0xFzxD2GunHw3XvVXR6x+DH?=
 =?us-ascii?Q?YkggaKY6L/uyYvsqeAcFdka+gRQPD3z+C+0D8zWPxNFm+NDcVCzC5jI1YcOi?=
 =?us-ascii?Q?0Wx23Wgfx6MeeH+A0mQGbClOEfDGFLULwkV3kvFejSflUi4QWQDnIDupHDiB?=
 =?us-ascii?Q?Kt6On+XkX1TXm30LLEd5eRTMBOcPgE0MRncE/osPe3eLTB91qDDe/8gQOzck?=
 =?us-ascii?Q?ycoy/12D8rTdiizD/gARickjtBqPyUzJ+o95HZ9AfXF49fzELyDN4sfM2R+w?=
 =?us-ascii?Q?WOZK9yOThddSANbwtOt86Vrb7D25YIy7a7qwtDIiJ5K9JJdyUywkVROKMfgk?=
 =?us-ascii?Q?Gbwnr9O4HIi7PiSCt2udsQmNldV31XuZv0PIdhJXblJXI90PpxZNTQ7yG+us?=
 =?us-ascii?Q?/3hhdRurQXLlgVMgmqFsBPRQpTJaJEPIlMtEY/b2QurpkR4xO1WjIi7DeQ56?=
 =?us-ascii?Q?SCSBd6VnV+0krfOr3lcXmjWfIDyx8D+TORNuPxJbloBW9czINepyR1DQRfHT?=
 =?us-ascii?Q?2yg+qRhZU8We8kZIrDi6Sxdyv79CL6n/lh5eN6JrUmiDUmNcSx2pYHv0ZVnq?=
 =?us-ascii?Q?w/Y2YzCTsl0QPe6r0omW/j5M8WP0NcggtgA4eYOWp8qrT6P3NA8aF6vRbhg6?=
 =?us-ascii?Q?H1kQftB8cxqI/s1O67qkLtaOKfaBrJfepHN//2f6iRLEiqFtLfUggZVcSjpP?=
 =?us-ascii?Q?QQE+r1ex0/Ir5Hsp+JFglNIjMIzlCTPeHTJW1heaKIdXwhV8qpKFRLrlTazS?=
 =?us-ascii?Q?6jR8Q5bbSoteG7MAv8Vc6TSYCEOyGdqA14x+4tjkViymICsTPx68hXkbzfzQ?=
 =?us-ascii?Q?vhTvbSVqVivq8T2d9GOfNtX1K4bCX/8BLs7TckT83ohELHSzOxXqHmFcLPuG?=
 =?us-ascii?Q?Ek5pqqopgkidE4fPysrddoZF0Nn7GgaS19NR3J0ROxVHgYR5yuUe4boQbis9?=
 =?us-ascii?Q?SzB0mZVnhVdDZ4+nsUpzs8PBYp28NdAb5wL1hWTg9WaPI8PdxuIpsF1IwH7e?=
 =?us-ascii?Q?+qbTff7NHeDNfrTS4sw7fV847tcWmUoEW0/isPlS4Xhvbl1mXrw+MFmXzROl?=
 =?us-ascii?Q?V07ypRd+5+pBZnYR7PhRiYuaPGlp6S6HLLV8AseosPDq5rlQ6sGYTcJqLKKW?=
 =?us-ascii?Q?hlN3+5+gw9FuplsazvxFc1Y+LZzaGOf4EKkHV84jPobhXsMAc+0nv7Nt8s7O?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vg/1lYVleUg981Cu4NGGv6QiSkOA7lGy3D9MM6qm9PupSRkECk/S9xqL/AUe?=
 =?us-ascii?Q?yJX60pRh4jWklfdPoBOLmPOUL72aZOcp982VCHY3QPstCl3RWvUO86BRdSRY?=
 =?us-ascii?Q?GdmBGhTeXeFs0ZSVY1MMyOKHnqC1r51+Ej5VMgk284W576MU35pJgq6B5v7k?=
 =?us-ascii?Q?b39CMJydYY09HBVwurDVdVxcyPgAcCdV1RhXD5DIbNcRWGiRL5uzmbkysZl/?=
 =?us-ascii?Q?N43L+rpZbM0LyimJH+Xq/vy4pZeoLkTt3HxkDaSeruRyVGv6bvjzCS0nsm10?=
 =?us-ascii?Q?DV27PPcIVVMVeKXEuz48ZmJ5qsK2EVpPLpctosPIZFcEZeo/PP0Kqb9sN6S/?=
 =?us-ascii?Q?W3WYGkrFcugTir8d2oXmfXydFGNCyzFWtqj10daSzFiPrkrHp3NIOOxC0nl7?=
 =?us-ascii?Q?R4oljK6rY1NdZ683up1a4sEWHMsI5TdE0+tCW34lIYEhCMhhWT5N7N3KUMs1?=
 =?us-ascii?Q?4U4UreTGfBVm1qf3wfBbdWQC5tlLXR9r8HexyjJKDqEj/bQJq1abuo/u74RH?=
 =?us-ascii?Q?Wg5M0ubGXLcYze61IzdQXbBQhxvpmSP5wLhLmpCoM486lTuPB4xAOZAH4mqx?=
 =?us-ascii?Q?vDi1kfWOQjAC6mVPkSbQ2z4sbBWuY6hjLOWJNLXNwFgaVyeS8IndX+ZeN5jI?=
 =?us-ascii?Q?XhdB8TqQIc9cSscRXCHJQ6PK72TOQ8mLvjNa4a4grLfnE0CLIJ+ZhyufPzN+?=
 =?us-ascii?Q?nTyFkdSjQ27Jk8qkG0MgYSkl/HNBXbDNBJme8jRvHwRN+a0J+bykcwSklzZl?=
 =?us-ascii?Q?/iPvWMCK0zP6UzPoPNDNFcleyE57CHbPDET8yWQkN2Vjxnc2ixoArm5T70us?=
 =?us-ascii?Q?Wx9Nnd6nUpURY/LhAR8ZdDEindp3hrYl0g/BoJhPrkdOqA6ahRUON5oMIAJn?=
 =?us-ascii?Q?sEsrrXP5bOrxn60aG4fwIHBAwYKO0wV7kWUtUMIIJRQEq5kwW/d+Rj5WJuMG?=
 =?us-ascii?Q?yqNCo1HgPG7hIuKtCLqtm0Ogt7W00XvSn1NO1bc4ixMtn9+ZUIbN3GwT6GJz?=
 =?us-ascii?Q?YDoDA4cT4Dj181s9jnGE/x53/hUzCHBLsGB5fFUNhI9sj4TcH6xPshIWosJo?=
 =?us-ascii?Q?BpifPi8SiVCle7HRRQczFt0Qdo1V6yPKMfQ2aADqLCVjHd9J2wxWjL480DXn?=
 =?us-ascii?Q?TEIp58ad363+04J7VMsoYy3lLgRabxKyrQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e59f302-14d1-4efa-d68d-08dbc6bc82ee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 22:35:15.9896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfoXBy/eiX5TOaKy9tmPA5gOV8yfK9xQ7oEwoywTCkLKxxQjPhuZIS3DdrcjpRkLul8N2DrnuPQ1NEx5/ywE/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060174
X-Proofpoint-GUID: v-ZXPBDN7BWfysSR-fcwbhNMV5U6i-KL
X-Proofpoint-ORIG-GUID: v-ZXPBDN7BWfysSR-fcwbhNMV5U6i-KL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/23 23:39, Konrad Dybcio wrote:
> On 6.10.2023 05:08, Mike Kravetz wrote:
> > On 10/02/23 11:57, Konrad Dybcio wrote:
> >>
> >>
> >> On 9/29/23 22:57, Mike Kravetz wrote:
> >>> On 09/27/23 13:26, Konrad Dybcio wrote:
> >>>>
> >>>>
> >>>> On 26.09.2023 01:48, Mike Kravetz wrote:
> >>>>> Allocation of a hugetlb page for the hugetlb pool is done by the routine
> >>>>> alloc_pool_huge_page.  This routine will allocate contiguous pages from
> >>>>> a low level allocator, prep the pages for usage as a hugetlb page and
> >>>>> then add the resulting hugetlb page to the pool.
> >>>>>
> >>>>> In the 'prep' stage, optional vmemmap optimization is done.  For
> >>>>> performance reasons we want to perform vmemmap optimization on multiple
> >>>>> hugetlb pages at once.  To do this, restructure the hugetlb pool
> >>>>> allocation code such that vmemmap optimization can be isolated and later
> >>>>> batched.
> >>>>>
> >>>>> The code to allocate hugetlb pages from bootmem was also modified to
> >>>>> allow batching.
> >>>>>
> >>>>> No functional changes, only code restructure.
> >>>>>
> >>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> >>>>> ---
> >>>> Hi, looks like this patch prevents today's next from booting
> >>>> on at least one Qualcomm ARM64 platform. Reverting it makes
> >>>> the device boot again.
> >>>
> >>> Can you share the config used and any other specific information such as
> >>> kernel command line.
> >> Later this week.
> > 
> > As mentioned, I have been unable to reproduce on arm64 platforms I can
> > access.  I have tried various config and boot options.  While doing so,
> > I came across one issue impacting kernels compiled without
> > CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP defined.  This is not something
> > that would prevent booting.
> > 
> > I will send out an updated version series in the hope that any other
> > issues may be discovered.
> I'm pushing the "later this week" by answering near end of calendar
> day, Friday, but it seems like this patch in v7 still prevents the
> device from booting..
> 
> You can find my defconfig at the link below.
> 
> https://gist.github.com/konradybcio/d865f8dc9b12a98ba3875ec5a9aac42e
> 

Thanks!

I assume there is no further information such as any console output?
Did any of you other arm64 platforms have this issue?

Just trying to get as much information as possible to get to root cause.
-- 
Mike Kravetz
