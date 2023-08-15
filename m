Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E568D77CD89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbjHONtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbjHONtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:49:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71544110;
        Tue, 15 Aug 2023 06:49:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAx3KF020677;
        Tue, 15 Aug 2023 13:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=4Y+NsQFRkUV2xKuPrBrd1qhL0CWpt0aQX/jWjXhjB/c=;
 b=nahhTSNqE0HUBHcfR6nhx03g3H4cTaGCgRZgVmcob0KjvpzhJQfjbdt8jQuqeC0V1nzp
 0pm2y2iKb2djfMR+5ak5oE4FAkCsJzPccKIwUj2+4P3EkfZmt8/fgu98UNZtFMMCOdu1
 kA0UrmTso5R0OhEABa7zv9V4915t9FzS2k5zip50cr/oCevN45FuHK3sYbg9xxdp4yNX
 lbPxstdSKIHvGI2KridP0jh1e/MMVdp7XwwoxJz42lsAoNfyjj7ecvQc6KFnHHkDLbFO
 dEHJA+sK5wR+I0/o2+8VGwg5EqbNiJPgCPjM2WkHsGmmwE/62Ek6FRa1TYirWxrrJ879 ag== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2vrm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 13:49:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FD3D5Q006639;
        Tue, 15 Aug 2023 13:49:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2d3dh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 13:49:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egcG8h2+aZPkUeTLvdmXypzUCyKvC7vAzEku/OjTdS8+ClbaHCVhufT9RiahUc+FE9LyuIXlNf0QzOxm5x/buXPjNB1RrE90c9ri/LDhPz2yP9+JFvR72pnVqqUryjmQzuX8QqOPCqt+Sf4yyHrQIsB51TNrt3bGTnNJ2M4Ao4ZcXS/dKJWrmN3aaua+dHIXx+8VgA35OJS7U5ZuQX9VtkIpBehQlPh1K9dKX9kA2CZcD4ObX4KsMuwyao39PWm+A/ICZsn6D/dfkqCd9nOIMvrAGiyGiW1C6E19+jLa8xLm3S9aC5lI7YRCklJ37nLJ/kT/9JuVWc0oJBt8QRWbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y+NsQFRkUV2xKuPrBrd1qhL0CWpt0aQX/jWjXhjB/c=;
 b=DE+SIB9K09fiohucCVDammxIfOuV2t8jT6YYgct3QH4fA9NGipW8lcgX1lRjlZDnbyNcAO7zfrYLc1H/KONbXTtAcKMuGBg/Jy+WjBN7MK2MB7yD1B0EM6ZUqMIZbyggYF/N0UFGNpGbJkf0RJGjZV0FhhZLwLD07CBs/qIIXYwhkOeREWLtA5qLkpR9/WA1QejtOAekY3DIBTB54HjajljPEJ1T51p4y0etTSzkLw126oPa7zHXLJgzES6w0z8M17w5+9rzm160cz2v99mHv577HSgXz0bj+6EqpJrIke2R+Woc7zMBYOaccOKTRID3cl7VmGMkNX/ia2Rkm9nxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y+NsQFRkUV2xKuPrBrd1qhL0CWpt0aQX/jWjXhjB/c=;
 b=pTxqJicZFoDDvdQ9BkJvZgJ21wwYqe0IS8jPlNmInTutsCMdy3Cz5TSI8VDCndQXiRn3Eh+K2qbzt8ukc+Z0u6V88xRUWTwA/DK/HdS4zf7GKdQsgkb5EFp6xvkcmiLZWuGWpr611i1Psx/wyAchOrAJj36q7ARmtE34mqpLJXA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6481.namprd10.prod.outlook.com (2603:10b6:510:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 13:49:04 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 13:49:04 +0000
Date:   Tue, 15 Aug 2023 09:49:00 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the nfsd tree with the nfsd-fixes
 tree
Message-ID: <ZNuCTMg2NS4d3xhf@tissot.1015granger.net>
References: <20230815110627.5d985043@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815110627.5d985043@canb.auug.org.au>
X-ClientProxiedBy: CH0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:610:cd::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eee6fc1-f226-40e2-10eb-08db9d966382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7tHBjLwrD4jitflply91AREydaliDaFqMWG9+sYbtWdhOcO4e1OaBMNSY8UOoQSVX/myiTCq4avzIiSi3LQ8L2dmXSD6c2Fibn5X0yxckFO9zOOv8QLeNFbzeN1ugOANeCap8VM6vkQnK6vcdZgDjK3l7DqRfZRpai51wOGhPCBHintcGz1ED7CyemSEnMo3KfFnrzWxxfvqqUaFNBRA6ITBWJaBiWBZwWOayQq2SJyyDV30WcNDH7M9nseNfqmkz78nP5xMB7JqnmHyfQabfU1GLMlrDD+M8a7Reb72ytsbfkjY7zEdp1x98iwomTRysyDx4wbYYwwGz4mCU3OT2lOFHum3cDZPI04s4Y2KkyVZMLeQ3a08McsimJWuidK/WfnzJsqwHasgk7ORrFklfwXNPIFZFBXUmEl9GwyieSJxk45OMKG8e64PesSWWgxHATbbFoMIW4Slw/qM7arTxylX9ShbuEANaycyKbdZZ1e1bnvo2QQm5g7SB1iOwA/hKUtpvwgb14NsOmb4SqZnn3pkTMZBlu5Nh4poigHzUhzx2BDaaTA/fvPWVpHbKrN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(451199024)(186009)(44832011)(5660300002)(8676002)(8936002)(4326008)(41300700001)(2906002)(4744005)(316002)(6916009)(66556008)(66476007)(66946007)(38100700002)(86362001)(26005)(54906003)(6666004)(6486002)(6506007)(9686003)(6512007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AaX2JhUZeNybjiww2F4FQTeDjXRdBVSTA01/uKiBVVi6ntfnqqJP34BThaXh?=
 =?us-ascii?Q?6RprltAcdJkrpH/UdYmK20REVSeECXG4Z7bMPfhCvgcdXZ3thYq95BWt2eyR?=
 =?us-ascii?Q?r0aDF/vHvcMY7HDmGWLFgH0Fbma3Lqc9pyFNpNG9mAttluIfqAqJeGemQeJ3?=
 =?us-ascii?Q?2GkzPtj8n6OIBmIpcyk4aCDqP8TQdXKNNMv3QrKr/uwCdqa9tFRA3nNN6UAO?=
 =?us-ascii?Q?2Ko00uswq0Atf1eEC6KOKqZzc9PF7sOisISard14/GmMVV6vSKnXdfnaVY+S?=
 =?us-ascii?Q?+fJ/EB1bLvYo7LPhRZdxXI6y6LZDMMi8lN2DjcwQvUEjOwCJTIrVRwLdQ9e7?=
 =?us-ascii?Q?79UhVJKi5fstLBt10fM++0LLKyNWxlxhYZ6+vrwoHBMDaVI/Bx1ZzI3U9ScG?=
 =?us-ascii?Q?mml0MDf00gFRqlACcUb1UscYTOXMoyK7v5FPury+QLyhshewGJbcrKB5lafn?=
 =?us-ascii?Q?aYkeR7prN/xV7Y+sn6mwspNRntQb4poQv48SuCyAqk2M32z9VDJpRTu/fhvh?=
 =?us-ascii?Q?cdEKd9CFUu8rxUeyA/5uT3WkY3xgP+/ZkDAkxWSEdyQP6VJnvGI0MoGsRwU9?=
 =?us-ascii?Q?hVpZcSavHk8PLLKl2Rr7t4ALm+jz3h/zjPi0yDJO8Eu7nfwMi57FImjFOF4+?=
 =?us-ascii?Q?zZkcqZcxjrcEziDhv4xlGG2vB45ZfynbmrzudBuniywXXF0C3zJ+Gjewrrh7?=
 =?us-ascii?Q?INC8b7nHrPwPyz58hxYcdSKGudELRiPtHPWUhUKv0VwmFqI2OMNqTfaXspRx?=
 =?us-ascii?Q?0XN/8eVkb1g7NO2L1JCYWrlOyWqSNR+FDGeD9NWErNnZiqVp7KAW1XuM36A6?=
 =?us-ascii?Q?t11Mcd+AZ70CdGMKiwVPRST05RY8O9GFAMRPe7igEmeOS0ZUu4ZrncLD0ywv?=
 =?us-ascii?Q?V5l0nW3pw3/IEzZbBXelHiI1E/nvrLEbqHUtaCP+qiDgF4OC75WYgcW0gx7F?=
 =?us-ascii?Q?P1dtKAB5XGuTA8F3I1cyEkV8uxk30eDM/sUBDwg1GolybTLIa9bgY60IoL7Y?=
 =?us-ascii?Q?GiagTXI8oz5AHbCcOcBDTWk6viYeo4BgV0nkC0Zu0MFEHZ8Gl+s1EbD+OfTu?=
 =?us-ascii?Q?wpmmUUxRwyaxL5tefxKplJjMY192kHR/Xx+jVZcTsHf4chfXfVH95sGz150o?=
 =?us-ascii?Q?ZB5uSG2C18YECzjTDksCJUy5vxLHyJ0ZW2MfhDFnJ/g7TqPVmdYWX1x54aO/?=
 =?us-ascii?Q?w0V/RRgAUyiFhTMXwqda7YwgLjvQBjmpFL65wYK8b5PEwIFQWOrlwTOSQLMY?=
 =?us-ascii?Q?KyIqMR4gZa/WwrYQdzc0Z8EK7VWBC+iY/A2iN5LabJK2hm20AtEx3KvKaHL+?=
 =?us-ascii?Q?9NLhjhvWdzHrPw3dpDXLSbOFzeudrOM6mZguvKNTzNpAG9zKKukYxP58V1AR?=
 =?us-ascii?Q?WSko+hlnO5tINk8j0ZDC/ZFhmJIGHQKqz0gCxuo0jsunTvMxnG3pBSlfqgy2?=
 =?us-ascii?Q?mIZIXSQ3hgn6BRpTgYpn9utsgIav89RApDbSpscpcWPzNI0hlAhUjnHV4vpT?=
 =?us-ascii?Q?52oidY3gc6M11/25VG7d3tKMNzectwh/Q7TeH6LO2MDyLYwcuzVQ9fGQfH31?=
 =?us-ascii?Q?ct1DWZRLPiwKzp663rRqFHKu7cdHPYFmQOJ4tYkfdEPh1mAjJoVUKZ5jWfrx?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y3LFwFB7wyofYmE80fks2tj8oEQPqFV64WRe7dO/I3mIVedJCXZJT42X2nLvrZvG7QVqmHigHen7jRfBWYFFDYIyXJRkdrwtZtyj2Snvqwz3NlDxiT79tLRTJcXN6O//O8u8sw1uZh8mbME+V2MlK7XXfbbCI7i/gafdA49PZv72cIvWGne/8TJfRw2hv/eKF5rj5AS6TqPDZf7YJCLAeVEW8oSPF45Bs4D3XluLZUv8gbXI3cqenoef3IGLj+nfTwh6/5IXsECBpkm+yDLdZNSMbR3cJfuQhzqTALNOCTVzqg2wrgCxS/bu19/8Zp7YbUB8MhqtC0q8bKmVt+ky8GjqwwiiQ42aI3fWjN7bkId3eGXQHGup0F3ozcK4Va78+lKvwThTIySMYpkP3qzCp+j4qEoIvor3yB3+Q0L0Pfs7T1PYp04nclQi8V6knRS/a1L9xFF6CsambltlQ5w3jmcpWHFtc86NueiYEzmxM8VumvnNH/KW23tCXONLlt/kTgLIekmdzbHpeCvSxF2VFiz3x2qUrHxC9uwaIJqepzmp1eEYVd4nY/1l8T3r1E97SkN3r1gW9bZ07Zf5fEo5Yd+nI80TMSwq522+ml0tFDfJkMBqd4YLqJa251C78CAoP/6CbbgVu0AMlu6JBzB4htWzQl1DOA+nQPh92WyXj09a9xWwIXIcDQE5Plc7+nXnuYdyKq4Gr21g94ARedDnqHOHoee25ka2goB9TnqaSD0tax3L7IyVgXe/gkxOn7fZwe1AI06n7WxWTKeKK9gmfSzXgQATFddqAqrA/o4w23TDzj0mJ3FwZQOSk+qOE/X07s5kOgQinoPOanw0mHTbzw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eee6fc1-f226-40e2-10eb-08db9d966382
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 13:49:04.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+bWIjUCSCbYY0NgFLeNI1Z4kn/3LFF6qVMs7QCOxp3xMRFINS0k8emGyWCH0Xx7bNJws+BRbt9OUAuxcgnlig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_14,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150123
X-Proofpoint-ORIG-GUID: dYfqDEyJYATTVfh41AtaoBC5j9Kowmkp
X-Proofpoint-GUID: dYfqDEyJYATTVfh41AtaoBC5j9Kowmkp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:06:27AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the nfsd tree got a conflict in:
> 
>   net/sunrpc/svcsock.c
> 
> between commit:
> 
>   c96e2a695e00 ("sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg")
> 
> from the nfsd-fixes tree and commit:
> 
>   62c25ceb29a6 ("SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly")
> 
> from the nfsd tree.
> 
> I fixed it up (I just used the latter) and can carry the fix as
> necessary.

Thanks, using the latter is the correct fix. I will address this in
my repo, since c96e2a695e00 is destined for v6.5-rc soon.


> This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Chuck Lever
