Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF0C804105
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjLDViO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDViM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:38:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F4B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:38:19 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4LbU1r027806;
        Mon, 4 Dec 2023 21:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Nb8EvzZFm3oDrqhyIni1+93d7Kssp+KWCKUwWl+I2wM=;
 b=hpt2VkxIU3r/LyePRAZn4Os9mcurWM2cQW2ofcoaFZPHpHa4cM1bpevsRTycLhCNsxqs
 KD8Nun5TsQUxJUwzRluPd7oPCWD19larvxbKsfZO6ayy18RDqfCvvBYun5+SVn67Fb1j
 EAx7dhGy7y2jcde4U60N0o2t2fUFm06nqStcNxBBUH0Dq33piEuDSC4Bhi6DHhZrtf0Z
 MLBAajK5qN+2FT55F9RN38RDddx4GCYma8kBPnVk2xWJo38Wtk8q2BGq4KQjGrUFwTY0
 hN6N6DbKPHWdZE58q/DWkze2hPK+15OFJTEwSCcc4MeBkeBhong+gj3e1BCKpANNtI7t 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uspuj8028-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 21:38:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4L2BXY006000;
        Mon, 4 Dec 2023 21:38:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu167vq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 21:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgrO9QVqWGf6p1s04rjqvhMidO7ss8WtTxBmHC72Blt/v1p8aDyybd2YxQyCNd0ZlrXoD8tARKurBAqd1diX1JqZqDYVOZIKiab1aNyjckmJpKZ34o619MmJ7LPmCkkOCprxw0OBBER19qWYrqgyurkZOhpE5zsPFLtSTSrr63Pd8FP9Q8oJSFBMgUfajBP5AoJzYfPivKAGKptWeZ+HA0604VHK08O2n/2LmEgAZ6/JxK2SUtmCud9ew4hKuRUcvM0t5j1Dh6zHDffdu+EacN6j5Tm4vg9yt9o4X34iw1T3xS7f98RPx5GjeX8Uwn37LONqcTk8ajvPMxe4OwH17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb8EvzZFm3oDrqhyIni1+93d7Kssp+KWCKUwWl+I2wM=;
 b=JsUzQpC1ioOZtiwaiYlO7Dy5/CJQShkHAByA5Y/i8ul5ja1h3OnTE3JGkaTMolzL8PCkvlZm+TM7LzQ1D8PGfn/5KYWvb85Wv5BBhGzJZDMvr0pAR9akftK+qh5KatyytKPGcEoyWpknlJ/xfN1uYUeU31IAbwQytQhcs/zGwEPZLg+lmpPxLklDjviSwAYMr2RJp7hgyOLwPh7Tx5/fzobYpBLTdPW5eXi6D8H7PVIqnWi/D+0B3UlS4o2p4RrPQL1BeYIsCVAX5NruZNxHhIN+OiN9UYKHhaGp8ocj2RS9Zm4Vn0hvGNvf5ieMWxSNb7k8SvgyEN72wJ2LgRS7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb8EvzZFm3oDrqhyIni1+93d7Kssp+KWCKUwWl+I2wM=;
 b=V3hDMwfpPnkE1YNshInmfr00cguLgj9shJ/fU8ofjOSh7dQwMMWpjzuVsXigj8i1IuVUz5kn7EGfvx+vKEhIfdoeToV2x/ICO6w410Co65TrOnYdUf4ZmibonxC+XN0KXsc+j+0gk98V9wmgt+jTuC3vnJq11p3BNSaWUK619KU=
Received: from CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12)
 by SJ0PR10MB4446.namprd10.prod.outlook.com (2603:10b6:a03:2d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:38:01 +0000
Received: from CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::300b:9614:f3b7:17d8]) by CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::300b:9614:f3b7:17d8%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 21:38:01 +0000
Date:   Mon, 4 Dec 2023 15:37:56 -0600
From:   Aron Silverton <aron.silverton@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
References: <ZWTtTjgBrNxpd9IO@x130>
 <20231127160719.4a8b2ad1@kernel.org>
 <20231128044628.GA8901@u2004-local>
 <20231128065321.53d4d5bb@kernel.org>
 <20231128162413.GP436702@nvidia.com>
 <20231128084421.6321b9b2@kernel.org>
 <20231128175224.GR436702@nvidia.com>
 <20231128103304.25c2c642@kernel.org>
 <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112922-lyricist-unclip-8e78@gregkh>
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To CH2PR10MB4309.namprd10.prod.outlook.com
 (2603:10b6:610:ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4309:EE_|SJ0PR10MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d1cd0e-b0c9-4901-5ecf-08dbf51149e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8JOeo/lMgQaYaqCaT7WmZTp6mc74WVWfH6vwjhr2hADQoSmP55Z+VMV0c9nNJYdM3dplJMpipOrBo/XXrLiEk72oghv3tvK175HxQomZQiCOs4VmiTnAZnJcyCXHtcHr21iakDN7wUH8dwZjwRzmnDpZJRA2J/9GxyUpxhJmuSfvZ8SR0M0rRxWKpqlLQLj2Mshg6h53ezpuQSyLhUcbaJOg3c1cw5RX8jmvlPL3G67FFxTpwb/4ie1XzpHwmJVKgwYY1adT/gXtbh4YNSVWFO7X5gTKg+kuEDtbA87OvGQe1AFouH9647hLABi/oGgy5O8n+3ZCVCH/vAInKTdvN7bm3phPYEq5T98tU5NbPTxuaNfbAlWrJgjAaJE+Ae01DxpaehLkvMOTz8hzkmsLqX48i0Ac/pG5Ywvoa9NFF73ojBVryEDnAYjVLoBWHcoFVhUL5oqWkBFvA2A+dGG9FmGEmcPvOBKVZZ1JKJIxknH91lIC6euo/e5UwIYj7/eADvcD2vqUvyfOHU9VstDK8aWgNHhnNBFp9ccoX9Zf/GKKHuy9rkY65UYjc8/4TqwUfjkLVPxZayqXk8lSjBqFo968BcVcZ3gVvn5+Gbmx59eqSFwjDYnC5w3k1nDX/Knfw3V7jtG8BbPOXsa0dFaFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66946007)(66476007)(6916009)(54906003)(316002)(478600001)(6486002)(41300700001)(6666004)(5660300002)(33716001)(2906002)(7416002)(4326008)(8936002)(8676002)(86362001)(44832011)(83380400001)(38100700002)(26005)(6506007)(9686003)(6512007)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qkop49tpKzw/O84NaQ70fu3rDRgk2oXloeeP4uf6sBKtJceW4/H6D05pJjFX?=
 =?us-ascii?Q?h69mdk9krQfDfODzOzVYZfUYH/J5W15jpuyUtVRx+cU6xGGk686GkEFnidyn?=
 =?us-ascii?Q?91KXnJHdderCwfANNhi46KMTWkeJGO8Vi7V2wfJGqmhFfX6Ok5dI1Qmst3bD?=
 =?us-ascii?Q?+g1pKrN5/ACmO6cA4hdUoFDsZGdb1srZFBJy03fjgeH/QX3MSCraNDR32Tsw?=
 =?us-ascii?Q?99hBWYXcDmqMLmidL5/+3e+BGilaKI5MwqTWrhR5XriWIz92irVoSilABNHR?=
 =?us-ascii?Q?ABE6DZQlrFYJ22NXpQ8mL8XVaokmdJ+phgYKA0ye12cCJXKhsJ2ntDKmYjs/?=
 =?us-ascii?Q?zIcpz/2aDIg1K8XatyTyg24rNU7qXrETEiO04qryaNBkjoTH6KbLo4HMuUFj?=
 =?us-ascii?Q?y1Bwi+ZZYe8VhLU0n9MdokHQv3eOTPKXpgGJDpesjkuk8twKCcEPkr9pdPZl?=
 =?us-ascii?Q?OXxAHY15cadMs7GCG4b7niho7zERMmsni+OIQxVhzcO7jahI6RclS3jMmP48?=
 =?us-ascii?Q?T9LhVH74hmRwRdSpOuJsrUG7hc/46AtLx+AVRIKyJm+/+6aQmO9d0Jf9y4FF?=
 =?us-ascii?Q?ttyezqVUGuw61NnErC82hszOMKJ0+jKfNqAW+XhqPaPyk+5S4D5aPybAQtSe?=
 =?us-ascii?Q?BO4ZPMAgIvXZrxjXCx3aIV69e2DA5bCtZ6bY3rx1R9SnbJCQkHCBHgbzeYY5?=
 =?us-ascii?Q?3SeNjf+MyXRuYqPauWnU5YtjlWEvb43jXlkfCidgkcMtX8ysKOk0BoWv+3xF?=
 =?us-ascii?Q?IR4xM8uxM82Gt8rmKZJG/k/oMThFVvxanISf2TMaiVg7qYjmcqxnAq3mRqPA?=
 =?us-ascii?Q?Oqxsaopr7D0Baz3FSchKA5O70RLZNGwdBfhkzh4Cf+a0wXJGT2O8e7cSMqje?=
 =?us-ascii?Q?EXKwKz+9CWpj6xMgPLVACYBo5g4tIXs3sj2sFR9PfaLv5eNQANZaQq8p6AJY?=
 =?us-ascii?Q?AhKxFJQtfpVYD/WlBgeQIqG5VeTfL1KsaIiOqMpECItGnpy63+PMpO39SXQb?=
 =?us-ascii?Q?54YsshEjd/Bc9YQV9msl2nzE1le3pMZYNzwW0yxV/0W9KuVdMLWs6J5uINdY?=
 =?us-ascii?Q?75kmJqj74wR4o31ZMJGnpzsXAQko5UvhhyQXA3PxQu+mgnrLZPnopyCgI7wS?=
 =?us-ascii?Q?eCoZoMT9bbEvgRIkYJ3/EEmCtdaXLG+uvFrb/NcHjmTWAf0cFmfljQpnzZ/C?=
 =?us-ascii?Q?UtEo5qYlxrqAPszElxapkIAkPbZ5YTT/k/n5dHq1oUmnjCZpqzcZd7Pozxxj?=
 =?us-ascii?Q?/4MmhHPgxoZLbANeCNdRFaMUsubXBthw/4QK7IGU4DbpRsQBpLyleZ6qZ/E1?=
 =?us-ascii?Q?5Z/BlSOFXritWqDwYWe5YMhudfq47Tv3crQoiM1AmMjX9SaPrnXit2fs1RVA?=
 =?us-ascii?Q?IrDDQyO1jSinIQlb4qoTGw7ogpVhIMLqMvXBRDXU2XOmMYqxdAdTDCsAwH8t?=
 =?us-ascii?Q?Gewyt9YBeg3SFsKsKqVeWpisxqyOwKo/oal07zH7T5EicSzZaJr7XVBu79QG?=
 =?us-ascii?Q?Sjz1HvzGQiZlTA6VZL/aWCjeptQ8zSiTjJnWC1dkjX4cQ9Bup3ERaZLxfESs?=
 =?us-ascii?Q?Xf4yTCd63DzP0/n8K5b52i8F7X6u51GpDj/PPdm77Lmw92Pf7MGX2WLuy9dp?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c3lB13cdp7evpjjIu8TNRc8b2odJhKj4ea3MI4tAz1mBcojzFXKHSipIc8IRo4GWFwRvnJ+qDgQ5XjPvWzP9LNCiUvtxBNVg6gT1CImeMJD+JiN7gh/Dh2NXTGopqrL9WBZ4EO6gTqI4jHcoebTljUP/Vms4OzF4Oy4HPRaa1gN2R/tE4xbr9igDKvt2EXPplq7bGCZVhUJEl0JJtEZjUihkM9kdHzHRaJaej+EmX1PxwrAcTNmg1iMVGPjsVnhtLgp1mBfVCarM6waZD3w//v71SQcBuMF/F+hFfF/0+YOTdy4aemagT/0CFDd1T/Qad3RCpB7Et/s0iXHj2/rZWoQojZeztUeXrz+wLNlCqwxN/jtC7lA/xnN9Fqv/878ELZ03eXnvLMnrw2ZEsvtVpHZy2olTJ8ZtN6PIiUUD79BZtbPywMGTp/X02Hy+NKZKZETm0ZvsnrHzo+HDZ5swzbq/81Gg0JqDjoYUjKyWLdSMcskjvXlZqZnLOdvCodflEFhAMKlSEPLQsJD1FFFTlsTD3chBGn5k0HJO74hEtzFnnwFPQj6k6LilJy3SYbQOjIeqALtXSbQOza1haP+wna5uxfrwxnK4AC2eVdfmIIbJbJbrBST6X+MmUITHY5ncapWX5rX5PIEJVY7pyTpeDVQN801Qc48gVLGyn7n4lueETBzhjcIw2BZNI6PWX46708UR4N4KaDEQYAN3hSDIPOs28xDiFm2fkhZhBSES3KhJNMpzSJklvJesIv+JeKA0j9D9qoR6kQ9uXPVNtY9PpR5nL2lft2o03w0DHe1YRSiYeNNSspwKJAoK/ovwFpG0ghSH0FXJ0Vu+bqMs1mRw1lXwWZm16J2j/fGFzGhEUmJlWQ3q6PtaZXwC5f/urMe9+8RsD9Hg/fyAEsu/i9V/Rw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d1cd0e-b0c9-4901-5ecf-08dbf51149e1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:38:01.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMCcyBuSp4dltS70LefmcCsPgVSLSyExfDYX6EnV+LHVs7ZUHIRo+Jr0QJuNR7MJljX4Jtqq7MoA0f3Vhd5ncaF9Z9g9N1zn3ZJ7s09SZ6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_19,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=875 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040168
X-Proofpoint-ORIG-GUID: T6BIiz1bMPPH_3wLWxr4dt2W2QDdGV6J
X-Proofpoint-GUID: T6BIiz1bMPPH_3wLWxr4dt2W2QDdGV6J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 29, 2023 at 09:08:03AM +0000, Greg Kroah-Hartman wrote:
> On Tue, Nov 28, 2023 at 12:10:00PM -0800, Saeed Mahameed wrote:
> > On 28 Nov 10:33, Jakub Kicinski wrote:
> > > On Tue, 28 Nov 2023 13:52:24 -0400 Jason Gunthorpe wrote:
> > > > > The question at LPC was about making devlink params completely
> > > > > transparent to the kernel. Basically added directly from FW.
> > > > > That what I was not happy about.
> > > > 
> > > > It is creating a back-porting nightmare for all the enterprise
> > > > distributions.
> > > 
> > > We don't care about enterprise distros, Jason, or stable kernel APIs.
> > > 
> > 
> > Oh, I missed this one, so you don't care about users?
> 
> Ok, time out please.  This isn't going anywhere fast except to make
> everyone else mad.
> 
> To Jakub's point, no, we don't care about enterprise distros, they are a
> consumer of our releases and while some of them pay the salaries of our
> developers, they really don't have much influence over our development
> rules as they are just so far behind in releases that their releases
> look nothing like what we do in places (i.e. Linux "like" just like many
> Android systems.)
> 
> If the enterprise distros pop in here and give us their opinions of the
> patchset, I would GREATLY appreciate it, as having more people review
> code at this point in time would be most helpful instead of having to
> hear about how the interfaces are broken 2 years from now.

We will be happy to test and review v4 of this series.

Fully interactive debugging has become essential to getting to the root
cause of complex issues that arise between the types of devices being
discussed and their interactions with various software layers. Turning
knobs and dumping registers just isn't sufficient, and I wish we'd had
this capability long ago.

Our customers have already benefited from the interactive debugging
capability that these patches provide, but the full potential won't be
realized until this is upstream.

> 
> And I think that's what is driving your work now, the "enterprise"
> distros finally picked up the "lock down the kernel from random PCI
> device access in userspace" which caused you to have to drop your
> userspace implementation to create a real kernel driver, correct?
> 
> And as for stable kernel apis, you all know that's just not a thing, and
> has nothing to do with users EXCEPT it benefits users because it keeps
> kernel code smaller and faster overall, that's well documented and users
> appreciate it.
> 
> > Users often pay to distros for support, and distros always turn to vendors
> > for debug situations, in fact one of the high stakeholders for this is an
> > enterprise distro..
> 
> Hey, I was right, an enterprise distro wants this driver, great, can you
> get them to review it as well?  I'm tired of being the only one to
> review patches like this and could use the help if they are going to
> rely on this (why do they pass that work to me?).  They should be the
> ones helping us catch basic things like the reference count issues I
> pointed out, as they can test the code, I can't :)

Guilty as charged? But, I'm sure we are not the only ones. I'm sorry that
we were not able to spot this and provide a review earlier, but we are
happy to do so for v4.

> 
> But, let's step back a bit further.
> 
> It seems the network device normal interface for this is using devlink.
> And drivers are allowed to have driver-specific devlink interfaces, as
> you know, your driver has lots of them today.  Why not just add more?
> What's wrong with 600+ more interfaces being added as that way they
> would be well documented and fit in with the existing infrastructure
> that you have today.
> 
> Is the issue that the firmware doesn't guarantee that these interfaces
> will be documented or stable or even known at this point in time?  If
> so, how are your going to have a good userspace tool for this?  What am
> I missing that requires a totally-new-and-custom user/kernel api from
> what all other network drivers are using today?
> 
> thanks,
> 
> greg k-h

Aron
