Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA37A325E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbjIPT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjIPT6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:58:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D41AD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:58:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38GJfGbn027479;
        Sat, 16 Sep 2023 19:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=i8z4sjeaX8kQwulqFhYnrNt2JZVKYV1HVpsHpXp1UBg=;
 b=gJ4nHYlUlj782z3BxfZDjPf2BHNdmM5S6o5idYsZfwdcnJBi7P3vmQtvLabWmVeq0FRj
 lWQNeuU0F6JeFsG+2xlyl1bo9zG1PrEzHg6LHB4VZnfQeAvESIUtAl88ixctiotH2/ya
 UzfMO0ZRSK067FLbblNaDRO0MthLx5W9Tv9568c+YJkYmmTED5d1ZjkaL+/rlDk6mjHM
 OYft0cQjuaoyo9N7QDYs9jrnsb7jYtfXC1c4+fYDSopQBEjAEK3iitPXd9tTafNFhibL
 cejvyFCauv9KXGFPxZ+Z+6Z00wnjs0m9m6v5t0mruEXFdG00+j+GLKDw+ES0MP9scWMA 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352rnxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Sep 2023 19:57:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38GEjimA002209;
        Sat, 16 Sep 2023 19:57:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t2k2gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Sep 2023 19:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCQFnr6JeBSAcBVuoxrG7XJxJoEf0BukzRQYimZaVeJr3EeV8M5MEMYIVYiznZViza1Vp5hrFNfMqBqcnFJtvn5Zipdd0+ugkhFmsjbWThxy554tVeAUd5IYwZODnvkm032yOtJo+MgPRHiib2C8WDxLH5/4n5jNztsLTvYh+KKY2SCpBYccyXwUqTKgHV3S3wuw/xAmnx8fcKvXoeXF5e5uIfFOMsUVNhcSXCqE2MFsfdplA1AfYbLdqll3ku9GJFMctUqBrancQoueouKzDWxRZRY+oAyLRcM2cLIDuAl/xKWsXRwG3SnHiboTKprJmEbCVofoG8MtUzV/lr61YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8z4sjeaX8kQwulqFhYnrNt2JZVKYV1HVpsHpXp1UBg=;
 b=e+qT8CFHqg1GxoreMHV7vKpntfvtcwBzlY9psV7xmBhJjNn/VY6SfI5Eg9Dkr2kQUhLp29HSwVH1wjeb7Vf6pc2XQNE3O0vhdKl5ga0TUECbszT6l/839BBe486ZvZ5wbL8yQVPfvwanLHmE0MDe+QH9VjNsYYH9B9Cgy9lMYTowiFHh6Us9udBoZLVL0w9g8qdx/jeCEGzoMZ5SIbaQSfpX3r/ikyLex3XaC6vhqPNBNmx2yUIsvjOJ+1zD0w44hPbmNqmYIlJfMNYNsJZE1Q+yTR3FmO8YHTj8+NX44JpdNiU96YV7i3jWd27NsQ5ONjrCz9ajzOhxDYBEx1W24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8z4sjeaX8kQwulqFhYnrNt2JZVKYV1HVpsHpXp1UBg=;
 b=UhjoY/a1Wk7r5FsJvZZZS589bOwZWrp3Nw7F95vw7d9Ywl7xMkaz0bVtJrINEEBPviu0HeIMc86Rtti3O4cSYiqHy8A0xhzHUAtfJHg9kRmFxWToluMz5uxSZKq5qMZkCN1oAdMnKG+rQNkg8Nj6B1l8tM56WPHiFusbav1/WeI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7576.namprd10.prod.outlook.com (2603:10b6:610:17d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 19:57:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.024; Sat, 16 Sep 2023
 19:57:42 +0000
Date:   Sat, 16 Sep 2023 12:57:39 -0700
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
Message-ID: <20230916195739.GB618858@monkey>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey>
 <20230915141610.GA104956@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915141610.GA104956@cmpxchg.org>
X-ClientProxiedBy: MW4PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:303:85::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cecb2a-9fb4-44dc-23d0-08dbb6ef3025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGIsIM2IFhPNNNbikfoTltZDnNLXgIQYwTcKOBRMd5kOv9ch4LnVLCSzecuIa4wGhmLY24BG0QIo6Q7xbW946H8WRD6bz6hhgN5DnaFOgtadwQyn054mdAtUpEmIDsyWbTBsmangkc9tquWjAOSZnn11dFWIaIGfKqlrFU6DGyGniFnejIK635EqDDiV+AhVccF05JBsxnnVo3iEpXZXpircaPrCzObMvQGn9scsyqYtIFHIYW7aaUPwqH9UlaLYLyciHM6DgY/YN82VBplRsNaS9LQybUXlE2oY71DItidZMtGLmk5uwbhMI8w31YwrlBDgnu26ZEvdRKJ3x83caBuLoX32JUnxyRO+80wwMiyhQjbSo/W9uDtozldIhFHjcMl7pKbQj9d/lYkESnv/NYlCirHtWDADMmWxrVj0OV0QJCu6IYE3nAnTdyLhRI35R2GpOsiE/0bDaEAbqXAmWsueAUIpOSgjnpumJDpjk6AKPeAyhXh0LIdb4oA+lZVl9lFpDnS/OXQh3fFOnGi4+GVKESvy2BePhdW23wzTnL/MNZESqWFmG9SsjY2xXRcl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(26005)(8936002)(8676002)(1076003)(4326008)(83380400001)(33656002)(33716001)(2906002)(30864003)(5660300002)(44832011)(86362001)(53546011)(6506007)(6486002)(478600001)(6666004)(45080400002)(6916009)(316002)(54906003)(9686003)(6512007)(66946007)(66476007)(38100700002)(41300700001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oTR/F0uN2hZoVwij1L4ElanoAzWAZwCX2KcKzz+pVC0vZgOYrSE8PKaKhLg4?=
 =?us-ascii?Q?+mUhXQcgveVclYhQWMDXFldV3M1p1KkBXLrvhywNiFdZXzSlt9KwJOzaOaqE?=
 =?us-ascii?Q?OY7DtRNZPDwaIuOBkQclkystcq4FjkzZ6jli7wRBx4KNJ++V3xsBoQErLkyD?=
 =?us-ascii?Q?338HzZmiFdawgeLEpO0RZXLtd+PQxU0zIcvIu+EFge2oViG6FKdKUwE8vJvI?=
 =?us-ascii?Q?kkBNcZa1aJbdOnoSWdujwXL24AZDnzr160GTVrnDDij1ffrBPkFSW3cXK2nI?=
 =?us-ascii?Q?CvJBrD/1+ldKsq9/i00F4OPGB6OhGsS6RsqdWrDyoR1CvDDuR4Nqrr2qAtP+?=
 =?us-ascii?Q?5RSVkOsXQeNrVYS+wykOAocLQG/f9rEoDHJ7PP2EXkmw9IkKqNID7yi2gQs5?=
 =?us-ascii?Q?JIT235/F3tgGmcpg6Io6aTrydKFDXxySv55phOYX6UD0bgee475vh7y2ca0z?=
 =?us-ascii?Q?Hb9PQKfbKmYEUGucDpuIULJEzUvUo1nY4g/bhbEO7z9zbEAGkmEOl0j1DKQN?=
 =?us-ascii?Q?3Y8PujeCUwVSKkVW60+1/03PEjp+E8nTggZCW7KG3B4tom6Ad+FLcONrPkIs?=
 =?us-ascii?Q?fqpK9qBmxPSd+H/edS3/ROZY3xgAkxwH8IeDKQjfOcNwVgPswyJ3+SSBQjf0?=
 =?us-ascii?Q?dx1Cgox3G1Wn2IZoHvnnxebibTDDeFuT7ymCVi/VuAr4MTiUlnVNcm29nWMJ?=
 =?us-ascii?Q?R+CA/pXhhUmymFUDHCAkFJ2EvgkTXN5Jn7t9EKZF8DTZLSK89iMcnNiMztp7?=
 =?us-ascii?Q?WzBhtWenqdlWuJM8gus4YGau9xIC/qZiExP/8d3bxHsa4Y7OvRFN5A3PjYHD?=
 =?us-ascii?Q?sRbQ9eSAIZ/4AHsSHaK3MHEgI60jnTpBMg8zTTtOxbvLw1Rgb0jOUE3v5Rvc?=
 =?us-ascii?Q?3qaQs21zpYunOsDFkMOYGbUFn76yUsU0+21dJBRBg7tupgox+JVJwuK6RYGG?=
 =?us-ascii?Q?x8RIfgZHr691q9AagRsEmrinOf/OW+bZIk/PkYGv8ujt78QPeldOuv0gPZ/9?=
 =?us-ascii?Q?6NvR2tfnJuifajUAW1i8s83l+PhdTZdSJw7pic6aavFqbCIZjKoQdL/Up1zu?=
 =?us-ascii?Q?HeMIXEc/A945DDq+POJPLBcx5uom375YZQRE8gkTETFG8HPS+NVJqb3vJNqL?=
 =?us-ascii?Q?6B8US0zBG8Ln2N7qqybMrerWYQ2a78eXcF2Eral+MgXLrLE2GAGbcHkju2VE?=
 =?us-ascii?Q?ghCOFrB3POI/cxxJbfDP2meVi6DlSO9w5sZWcMyHyijDpqLM7MQE6ENMlFXh?=
 =?us-ascii?Q?8uTteLq9gJP5LzbnbQzRUm6teqgIrbgyKP8emqQ2AtS7cIlZBTXIKWwR/aLB?=
 =?us-ascii?Q?Ovc+77VJeCWwAYbBvVCRp/MWWxMtFgU6M79XKZt4irUF0LJe65xYFPfvWzOj?=
 =?us-ascii?Q?2g7xd1Oa+VccjSHi+gRWF7WHTf/rniOI4QJOO1+ATnhNUiLsynLoQmSuhUjr?=
 =?us-ascii?Q?nfyZ/0Yk6ssS+q/IQvH6kzNXe/XX1zfxPmhPc08HfEAfTuvigdJfCHxk7mCv?=
 =?us-ascii?Q?91dWABBjcXpzsMZmlZgWuIGQPnplnI//oHzKemxbsjN0FdWdcyELNOfyGNMt?=
 =?us-ascii?Q?aqEZn0asAisRK/UdJ1y0bhwS+QO92DNKukrMDwQV3+e5gbdM+UVBeVdx+vf2?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PzErmm5LsHJy9XiDlgr/f1k5woW2dmKCRnPSZ7FS9yZFETkr8xybpuyEUvWx?=
 =?us-ascii?Q?Hvr4WvIan87a+k/WxoxOo0YjZQNpoqLwxtWTb4n8xwp+uFW/LV4dFyIyvn5Y?=
 =?us-ascii?Q?putY83+BWlA/AtFd+hBRXgBel5URADS58xDvPIejmR9k4LRiQupLfXa1tDDi?=
 =?us-ascii?Q?aiU4MMENetHrdtKgbRyfRcn6DmPNs+N1MORz+B19GRRLAQgtMPALdGpMzUa3?=
 =?us-ascii?Q?yjKn43Y+KYNBSiIL293iFeJr2NpLI1dPQTTq/+iBSDuGchYp35kwKA2urlBk?=
 =?us-ascii?Q?7eWei/H2o0rJDTVFRsQwLMIqWgOLcT6Cbn7e3mvQcsQF0/tKAgMGMEAQNVE1?=
 =?us-ascii?Q?lL12YTY/YmFRCdEFen/AaWTVfNPQrlckpugjyODDhZWd1orng/8NRLcXN4rS?=
 =?us-ascii?Q?zUKgvzSMjARVoy4cHRubsSi6RiMoIQX5g2RThMTDhKMORIyeHmV+P52+HsnQ?=
 =?us-ascii?Q?BiAdr16lauV2qHTZfr7zuBBn0ptYAdT2tRbTb1/RYNou/AmBpjxb2f+f454s?=
 =?us-ascii?Q?0FnsRAlWh4Gexwr99HcWaJEGoxLzE+m7yggLTs7JEIYMRq0Q9mHYpiwstQpT?=
 =?us-ascii?Q?kngf9b7XsoWJIA+bVdURD28uSjtgqtB6e4DIlPqsT24vK0TzIcSYSVWxc2Tz?=
 =?us-ascii?Q?0lrfDrO9vEZllA9YfCDbrvt72mLlS2E9J/7dbGdb7m2Kgq/FPmr0CN21TIyO?=
 =?us-ascii?Q?Teb2fDKxzFPUy3nggGumQcWkGnyb0T3ntxc0L+H9t1ZOsviKeuAF95m5gc/a?=
 =?us-ascii?Q?1F3soOigqslmq4oFMW25UAO1iC5xqDgXhgsmEV9pJmzba/aSq/0KcXSF/Q1u?=
 =?us-ascii?Q?ME2b7huvmda6ZiRfH9rRMZGN7c/3r/MwsgT2CpAsAU1WQjqBYiMKXwSGHBVn?=
 =?us-ascii?Q?Wq46MUkmmXRWez614bHxSNP1ZK0D0PMVohh+fIOkBKEjc173WqlzOUEn5P0n?=
 =?us-ascii?Q?DwHM13Q9QyynP8BDgnjf/Xkye8glqzkHIK29JkQ1bHPDRJ/K2v4XgXda6nOe?=
 =?us-ascii?Q?MKSh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cecb2a-9fb4-44dc-23d0-08dbb6ef3025
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 19:57:42.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+lDCqyJqeXK67zxyxMi0mRLwfsdXkCGhDWnGFD1da/JfFWgZi+mlFRvP8TmxobB/ToAkcplmDS0v9licL+MxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309160175
X-Proofpoint-ORIG-GUID: KsvK1q1pH36HX8k2Nx0saUv6GsZ1dqe8
X-Proofpoint-GUID: KsvK1q1pH36HX8k2Nx0saUv6GsZ1dqe8
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

With the patch below applied, a slightly different workload triggers the
following warnings.  It seems related, and appears to go away when
reverting the series.

[  331.595382] ------------[ cut here ]------------
[  331.596665] page type is 5, passed migratetype is 1 (nr=512)
[  331.598121] WARNING: CPU: 2 PID: 935 at mm/page_alloc.c:662 expand+0x1c9/0x200
[  331.600549] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq 9p snd_seq_device netfs 9pnet_virtio snd_pcm joydev snd_timer virtio_balloon snd soundcore 9pnet virtio_blk virtio_console virtio_net net_failover failover crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
[  331.609530] CPU: 2 PID: 935 Comm: bash Tainted: G        W          6.6.0-rc1-next-20230913+ #26
[  331.611603] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[  331.613527] RIP: 0010:expand+0x1c9/0x200
[  331.614492] Code: 89 ef be 07 00 00 00 c6 05 c9 b1 35 01 01 e8 de f7 ff ff 8b 4c 24 30 8b 54 24 0c 48 c7 c7 68 9f 22 82 48 89 c6 e8 97 b3 df ff <0f> 0b e9 db fe ff ff 48 c7 c6 f8 9f 22 82 48 89 df e8 41 e3 fc ff
[  331.618540] RSP: 0018:ffffc90003c97a88 EFLAGS: 00010086
[  331.619801] RAX: 0000000000000000 RBX: ffffea0007ff8000 RCX: 0000000000000000
[  331.621331] RDX: 0000000000000005 RSI: ffffffff8224dce6 RDI: 00000000ffffffff
[  331.622914] RBP: 00000000001ffe00 R08: 0000000000009ffb R09: 00000000ffffdfff
[  331.624712] R10: 00000000ffffdfff R11: ffffffff824660c0 R12: ffff88827fffcd80
[  331.626317] R13: 0000000000000009 R14: 0000000000000200 R15: 000000000000000a
[  331.627810] FS:  00007f24b3932740(0000) GS:ffff888477c00000(0000) knlGS:0000000000000000
[  331.630593] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  331.631865] CR2: 0000560a53875018 CR3: 000000017eee8003 CR4: 0000000000370ee0
[  331.633382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  331.634873] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  331.636324] Call Trace:
[  331.636934]  <TASK>
[  331.637521]  ? expand+0x1c9/0x200
[  331.638320]  ? __warn+0x7d/0x130
[  331.639116]  ? expand+0x1c9/0x200
[  331.639957]  ? report_bug+0x18d/0x1c0
[  331.640832]  ? handle_bug+0x41/0x70
[  331.641635]  ? exc_invalid_op+0x13/0x60
[  331.642522]  ? asm_exc_invalid_op+0x16/0x20
[  331.643494]  ? expand+0x1c9/0x200
[  331.644264]  ? expand+0x1c9/0x200
[  331.645007]  rmqueue_bulk+0xf4/0x530
[  331.645847]  get_page_from_freelist+0x3ed/0x1040
[  331.646837]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
[  331.647977]  __alloc_pages+0xec/0x240
[  331.648783]  alloc_buddy_hugetlb_folio.isra.0+0x6a/0x150
[  331.649912]  __alloc_fresh_hugetlb_folio+0x157/0x230
[  331.650938]  alloc_pool_huge_folio+0xad/0x110
[  331.651909]  set_max_huge_pages+0x17d/0x390
[  331.652760]  nr_hugepages_store_common+0x91/0xf0
[  331.653825]  kernfs_fop_write_iter+0x108/0x1f0
[  331.654986]  vfs_write+0x207/0x400
[  331.655925]  ksys_write+0x63/0xe0
[  331.656832]  do_syscall_64+0x37/0x90
[  331.657793]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  331.660398] RIP: 0033:0x7f24b3a26e87
[  331.661342] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  331.665673] RSP: 002b:00007ffccd603de8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  331.667541] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f24b3a26e87
[  331.669197] RDX: 0000000000000005 RSI: 0000560a5381bb50 RDI: 0000000000000001
[  331.670883] RBP: 0000560a5381bb50 R08: 000000000000000a R09: 00007f24b3abe0c0
[  331.672536] R10: 00007f24b3abdfc0 R11: 0000000000000246 R12: 0000000000000005
[  331.674175] R13: 00007f24b3afa520 R14: 0000000000000005 R15: 00007f24b3afa720
[  331.675841]  </TASK>
[  331.676450] ---[ end trace 0000000000000000 ]---
[  331.677659] ------------[ cut here ]------------


[  331.677659] ------------[ cut here ]------------
[  331.679109] page type is 5, passed migratetype is 1 (nr=512)
[  331.680376] WARNING: CPU: 2 PID: 935 at mm/page_alloc.c:699 del_page_from_free_list+0x137/0x170
[  331.682314] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_seq 9p snd_seq_device netfs 9pnet_virtio snd_pcm joydev snd_timer virtio_balloon snd soundcore 9pnet virtio_blk virtio_console virtio_net net_failover failover crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
[  331.691852] CPU: 2 PID: 935 Comm: bash Tainted: G        W          6.6.0-rc1-next-20230913+ #26
[  331.694026] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[  331.696162] RIP: 0010:del_page_from_free_list+0x137/0x170
[  331.697589] Code: c6 05 a0 b5 35 01 01 e8 b7 fb ff ff 44 89 f1 44 89 e2 48 c7 c7 68 9f 22 82 48 89 c6 b8 01 00 00 00 d3 e0 89 c1 e8 69 b7 df ff <0f> 0b e9 03 ff ff ff 48 c7 c6 a0 9f 22 82 48 89 df e8 13 e7 fc ff
[  331.702060] RSP: 0018:ffffc90003c97ac8 EFLAGS: 00010086
[  331.703430] RAX: 0000000000000000 RBX: ffffea0007ff8000 RCX: 0000000000000000
[  331.705284] RDX: 0000000000000005 RSI: ffffffff8224dce6 RDI: 00000000ffffffff
[  331.707101] RBP: 00000000001ffe00 R08: 0000000000009ffb R09: 00000000ffffdfff
[  331.708933] R10: 00000000ffffdfff R11: ffffffff824660c0 R12: 0000000000000001
[  331.710754] R13: ffff88827fffcd80 R14: 0000000000000009 R15: 0000000000000009
[  331.712637] FS:  00007f24b3932740(0000) GS:ffff888477c00000(0000) knlGS:0000000000000000
[  331.714861] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  331.716466] CR2: 0000560a53875018 CR3: 000000017eee8003 CR4: 0000000000370ee0
[  331.718441] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  331.720372] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  331.723583] Call Trace:
[  331.724351]  <TASK>
[  331.725045]  ? del_page_from_free_list+0x137/0x170
[  331.726370]  ? __warn+0x7d/0x130
[  331.727326]  ? del_page_from_free_list+0x137/0x170
[  331.728637]  ? report_bug+0x18d/0x1c0
[  331.729688]  ? handle_bug+0x41/0x70
[  331.730707]  ? exc_invalid_op+0x13/0x60
[  331.731798]  ? asm_exc_invalid_op+0x16/0x20
[  331.733007]  ? del_page_from_free_list+0x137/0x170
[  331.734317]  ? del_page_from_free_list+0x137/0x170
[  331.735649]  rmqueue_bulk+0xdf/0x530
[  331.736741]  get_page_from_freelist+0x3ed/0x1040
[  331.738069]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
[  331.739578]  __alloc_pages+0xec/0x240
[  331.740666]  alloc_buddy_hugetlb_folio.isra.0+0x6a/0x150
[  331.742135]  __alloc_fresh_hugetlb_folio+0x157/0x230
[  331.743521]  alloc_pool_huge_folio+0xad/0x110
[  331.744768]  set_max_huge_pages+0x17d/0x390
[  331.745988]  nr_hugepages_store_common+0x91/0xf0
[  331.747306]  kernfs_fop_write_iter+0x108/0x1f0
[  331.748651]  vfs_write+0x207/0x400
[  331.749735]  ksys_write+0x63/0xe0
[  331.750808]  do_syscall_64+0x37/0x90
[  331.753203]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  331.754857] RIP: 0033:0x7f24b3a26e87
[  331.756184] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  331.760239] RSP: 002b:00007ffccd603de8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  331.761935] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f24b3a26e87
[  331.763524] RDX: 0000000000000005 RSI: 0000560a5381bb50 RDI: 0000000000000001
[  331.765102] RBP: 0000560a5381bb50 R08: 000000000000000a R09: 00007f24b3abe0c0
[  331.766740] R10: 00007f24b3abdfc0 R11: 0000000000000246 R12: 0000000000000005
[  331.768344] R13: 00007f24b3afa520 R14: 0000000000000005 R15: 00007f24b3afa720
[  331.769949]  </TASK>
[  331.770559] ---[ end trace 0000000000000000 ]---

-- 
Mike Kravetz

> ---
> 
> From b0cb92ed10b40fab0921002effa8b726df245790 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Fri, 15 Sep 2023 09:59:52 -0400
> Subject: [PATCH] mm: page_alloc: remove pcppage migratetype caching fix
> 
> Mike reports the following crash in -next:
> 
> [   28.643019] page:ffffea0004fb4280 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13ed0a
> [   28.645455] flags: 0x200000000000000(node=0|zone=2)
> [   28.646835] page_type: 0xffffffff()
> [   28.647886] raw: 0200000000000000 dead000000000100 dead000000000122 0000000000000000
> [   28.651170] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> [   28.653124] page dumped because: VM_BUG_ON_PAGE(is_migrate_isolate(mt))
> [   28.654769] ------------[ cut here ]------------
> [   28.655972] kernel BUG at mm/page_alloc.c:1231!
> 
> This VM_BUG_ON() used to check that the cached pcppage_migratetype set
> by free_unref_page() wasn't MIGRATE_ISOLATE.
> 
> When I removed the caching, I erroneously changed the assert to check
> that no isolated pages are on the pcplist. This is quite different,
> because pages can be isolated *after* they had been put on the
> freelist already (which is handled just fine).
> 
> IOW, this was purely a sanity check on the migratetype caching. With
> that gone, the check should have been removed as well. Do that now.
> 
> Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e3f1c777feed..9469e4660b53 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1207,9 +1207,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			count -= nr_pages;
>  			pcp->count -= nr_pages;
>  
> -			/* MIGRATE_ISOLATE page should not go to pcplists */
> -			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> -
>  			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
>  			trace_mm_page_pcpu_drain(page, order, mt);
>  		} while (count > 0 && !list_empty(list));
> -- 
> 2.42.0
> 
