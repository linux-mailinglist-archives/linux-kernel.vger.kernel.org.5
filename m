Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA3808F92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443621AbjLGSGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLGSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:06:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF512E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:06:53 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7HW74X012101;
        Thu, 7 Dec 2023 18:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=D2/BqWpu1Vj1CENw/MnyeIPUErFVPXIoJTuDF1VERVI=;
 b=jUUgMYYinRFM1Qmn3AS6Ylf/l01CwcG+zxgIl8JjWSlT0Dt/qD49mj7xID6BRhFS1H4i
 xWils4AjUdBRlri+MGzGVt6Npz1LOkM1mUA4o40LlQpjZBsG30VwiCGFUwEoU/I8oMgz
 6Z9KZOW67kXsXpYdmSQXD9OyET7LaIAQyD/Buu9p2VTV7SbikBw4KlhfN0/9uDrJklqp
 hcUpg3l6UM/8lPFGGNPkJqUVb7KRnN9+EhzR/54L4oZIpU4hjnpNUzk3U1r3zj+lwyrE
 VeTEHdiXrCa+U27stB2aupFSiJQrqzGHjYKMWA90z9cr+GETTu4cqnu5l2T+qdWlF2Eo zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc1cd3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Dec 2023 18:06:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7HW4Tg019704;
        Thu, 7 Dec 2023 18:06:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan6j8vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Dec 2023 18:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKH/Blzi8ALNosDFzK2GrTYUW7fQorTg+uogzOspS1CeFGMH7NTJMfavJIZXdJ+AJ6vu6D0JmjKC4HrtboYFGJf67fsziGMra+8d5yWKeig+uv1OKistbXAHLgSooG7hpNR/rWkoWZXD9/mMWVhkozc9D6MyXvoGk/djZh1pao+9wewaWt1iWyI+wyK718q0Ey98pBDx+eX8HL1qgfphGxI10M7qYVhuDjCSpOsJnhztx96jMqNv1Y74BHJDFspcjHGBIwqExIwALIiLRajFjr7TKQiWQuvTrXEvD2REb0M+8wLb5rIb5hzvZx2t2m83+MscULzTaPwOtEQLgWdGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2/BqWpu1Vj1CENw/MnyeIPUErFVPXIoJTuDF1VERVI=;
 b=XAzlVr0EYAZZh1CRI7sHAxy6CTiFtf6EZedWAvcfux7TQQbg4TkJpcm5vkYKz3Nnxghr8baKMd+YAqSPgSkQqqSvn1IqWCV1D/lwCm1ONZnBtejnr6YqgwZvBb1w984eCfou/v0eO0Av7r23yF68TBsbErLAz/SiqxN8pSR7Ykss8CRx91TVKry0h3VWgG0qudB9wmIher4PLZMEz1s8CHHqzj0UKjEjcgeoxWTETrUKY2tYnYfsXyJruKwLUfnXRkMpMW6ebiNAkx/wg6Kj4ZAAMNomJQl7GA8ZnqtjXaBiew5YYPy6m58/ZnhzQq5itBpISUiEOfl+9D+N7jEANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2/BqWpu1Vj1CENw/MnyeIPUErFVPXIoJTuDF1VERVI=;
 b=Lv8FJRQ7dmJFRN2H/FfbwDdAFWFlRGgNF0YmI49OJKJw/VUiCRs2iwGQJdJdA9NgLGLIapDdN8luamJ4DqC3yWd7xTnkBoVagVXDSyZHYeRvXSd2LGsGoCb6/D9az+n6kVfLduJB4W+7KXWVPfv1JQ/Ud75wXKTXnEnutMJoTHg=
Received: from CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12)
 by DS7PR10MB5072.namprd10.prod.outlook.com (2603:10b6:5:3b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 18:06:34 +0000
Received: from CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::300b:9614:f3b7:17d8]) by CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::300b:9614:f3b7:17d8%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 18:06:34 +0000
Date:   Thu, 7 Dec 2023 12:06:28 -0600
From:   Aron Silverton <aron.silverton@oracle.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <uedlocmp2guvvhgxe2cjrjog3qf6pd7puj7idpygxxpjrnnj2p@nqmg66juf6xm>
References: <20231128175224.GR436702@nvidia.com>
 <20231128103304.25c2c642@kernel.org>
 <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
 <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
 <20231207092329.3ec04dca@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207092329.3ec04dca@kernel.org>
X-ClientProxiedBy: SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::22) To CH2PR10MB4309.namprd10.prod.outlook.com
 (2603:10b6:610:ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4309:EE_|DS7PR10MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f242885-3ad3-4055-1de1-08dbf74f3f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28Oxq9aldAzmBblxpVfqkdjRzlWfxEKIw45jpWkPpFcF72dzYLopuWQAqomQLMgkHQkLBxRYfkRNj51MtL+x9jTlQV87gZNVrpSb+OriZY0QdPCpY5oX86o3hUbwauXOurnyfdgBvB4Bppiu5zMWYLUIaC61pTGNbYr943Ml1PYXRNgcZs7Sxtvl4QIzN/pWvmLPsFwacO7hUvrNHI949GVrp2YcG1iz4LA3Tj0/7wf9Ua+qdsxSdxFWGTyDdhnTvTHXOmMcHvMyVBEGkzxeYEv6jCnIguYPQfm3nkJpo+nsezrJvJogcsatu7MJjyOTEF2fY9watAY5PWKBUdPY98pjd/wJI6ZqFfaCqGzuO5fasfmBXhwoeNWpLSWBgyGRGaO4yvnZmwOVK759WycwEyx90dF6p1c4gqiv6CjLYy65YsJuxxje3A/VcfrUVBAC+rHd5SFFP0y6DibDbCiGRT17iQloRQhFQp+w4V7reJ+snKVpWoCD3uMBHDYfwGiPWeR1EwbfRzt0VbtcofX0iQT3eqccWEhDykMRe68n/VuFo9D9fPSpNQhD+uI0S0Lc7Ul3F0eCfm1qmShhMpdiivfs8arF1z0+xVG2jE3udYMpUrYI+e2Zi7jc9NaMicoyM+OZTqJtPzQz42wfDprdBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6666004)(6506007)(478600001)(38100700002)(9686003)(6512007)(26005)(83380400001)(5660300002)(2906002)(7416002)(8936002)(8676002)(86362001)(4326008)(41300700001)(44832011)(66946007)(54906003)(66476007)(66556008)(6916009)(316002)(6486002)(33716001)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cQV2tW3M3eFLBjGDDWXblCkmLqdJubuywJ6uJhM6xTkQ2DIW7zyemmLtopRx?=
 =?us-ascii?Q?UnbY/y1gXmowWdduZBTO1LX5cg95D9AaN+szl3OsCEP30F11ii4NBJoYzIsY?=
 =?us-ascii?Q?BezoNAmQRdKyY+NhTkY+aZgEt1sHsSauh1E5mP08PdRHjAuxBAu+Zjx3LIEz?=
 =?us-ascii?Q?8oOyX5c9cT5nwEuWrfm4qibfiRUJwWeTaL37bTFkVGkiGG5bWT4tSOnRBPUG?=
 =?us-ascii?Q?1d/Fmx2Ho/E75wbjbYwECdIC+bVdGqRm4C7bSG1rO6+FQXLO7JKBzB67RzEX?=
 =?us-ascii?Q?5iikCH0rLiLzoJ/wblyHk/GhHd6/23nvjLz+2ASUX4szE+J26kNzz3KjQMXT?=
 =?us-ascii?Q?m88bIKVVXHXkawQy2/oRaQDVu3t4UWdgKbSqP1nW3B+8GJc7u6B2DVOd+zv2?=
 =?us-ascii?Q?91wj3hD3feXz3JDAwiAH0se/1j8jmH3Xk6TArZajWw4nQ5VSx5spiHelIV8j?=
 =?us-ascii?Q?DkUSF5stEphgi0BoMbVawPP6Fqjp05jZw6vr22rPyB2to2GiF8cbVEVkGH79?=
 =?us-ascii?Q?aD9BRRkVIVE3vpeAsvYpHereyxCzLO+7a97h7t9jh6n2YWJZwb+fI66NTWwT?=
 =?us-ascii?Q?BSJkLT7afC6SzOGg8z3TbSpkiKiW6KUkCXgtggy8D9ZYPQ6VedSayARKE0Kb?=
 =?us-ascii?Q?GWdekGH4G/oKwBrVEMW8kZvXkaCeYnY8u3HmMCufutOUbOX+RPiImqWyeeH7?=
 =?us-ascii?Q?gqz4GjwBSQQIWpLsjT88IqXPavZU7snawdPdkUCkwAz972JP+JjoHG3xI4py?=
 =?us-ascii?Q?EhioA7X1b+woT7Fyxa6aQI4eDp8d4L5kRVb/ORqMX29//bSM8+Ymk9rGH8/2?=
 =?us-ascii?Q?t+yj9qr4kewZrKb9uBhGnWDrsWpyVMKRHrenklgL1W0uoBtcOZnRnxZbU6Hy?=
 =?us-ascii?Q?jzxDJmaxkCCU0z/tPnHj7juvonqEbu9B41HHQZaDpvHQCxzrAU3/95W1yipo?=
 =?us-ascii?Q?NItfwD2pv8oV7sPGP+OkLBR1+SKL3lbq6FeIWPTIU5iXuF3eiuXVaYx5+ScE?=
 =?us-ascii?Q?s8PO+t4k1qw5MBI1apP/nvcGrG6pTKtkRs4oVumtaH5clDAHtP0K/mHnq7qk?=
 =?us-ascii?Q?zAgqXiXmBAbQDqKbiPZuX9eQJdLx7uT/netRIIW53oprdCO3+25bRQZQgxDC?=
 =?us-ascii?Q?2SIl6PndGVjSGqKDDL+xCehl+gFsbsTX48KTEbMmpXYZj3ObLl7RlBhpeMjh?=
 =?us-ascii?Q?wf8a2EebcNXf/hTtGXZ/Im0rHj8JlVmXeZEMXgj5tCQIggWN24jBFAvETPd1?=
 =?us-ascii?Q?t/6TDHMcb7UdjqnQwKxMD+VEztwuP3nr652rZeceK5JDtuVSZN3evmeD3E8j?=
 =?us-ascii?Q?dUyh4mFHQIseOqvYvAnW033lPT4/p2UuelWmDxQiBJLycCwyGJ3ugoGSmOgZ?=
 =?us-ascii?Q?m6w5UiYFuyzvXDQQQCcmqfK0ZlZVQNpwl3Pc/Usn3JKSw4s/tVV5lYFlMg/Y?=
 =?us-ascii?Q?eUz5JJl7pvCLUsyOwv9YWZiJkilHqu6QwYfn+dlBNHVT4vLvLdKjBnJ4RHrL?=
 =?us-ascii?Q?pjyDA+2VgZChWcvsrla1fC6IO4trfsxOy8U7kfSbGDMQUXE3kvsfQvYgsq0v?=
 =?us-ascii?Q?MLBy7ULlvEX3EO8d4YsWU2CThXBH9jEJkjGqRcluy3ixY4rxJ4ODnZPkXoEP?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t0bMgx0boDSGkbpBJvkcBX619VGwc3qzNuiqZuwKODc8/62890f1Lu7nTDXWx3Bzxs9P3Z+gFFrexV0uPK4s4VvUHKxDH+gVAmyWIyvdgwZvjt5YftJTCx+K94OwTGUVyWipiY+xrTumy7XO48IHJBUYF57fJpnAx5EqvYXRyWugTb/MyRNhJltzhZ6JxFIFYnzDATE/u/3IRSBGBGXK883HDteTIqHb2j9WGvMuVB/HPoTNkygjO1F44hbAbh+6ck+GnT8heuexnuywOD60rq+fcO6nZ2ypg01202NiO2WfbqNKlWzk1LbXje68IJ/U/CvGgPp1GTskNXSU/vivhOSKl+R+htlMhFz2Cp+xt9kYkt5CSY7D8RUUeglPaSh3NeKsLyDk3B9mk0n8EzVIp/Axe8NQEhntPoFJWx1rvGcBgB9oimaH0yOJKBziWBonEKwCBRjL6Qox6CLFDpoG6i2ML66T63z46FtyXSg+5hvPKKOQX6y8I2CgTXzbzstnsSKSatxBviuNfBBPzDRru8x65aTz4trjdo98gsy16F1t6CJMvWI+LsJtV0spKVm0SUi5DyQTJgyt9B5L06IowtMfKILqQovLQ3BEdGmknckyM7Xo+KhVVpMtHWClxEWDxcx4dn2hGp1Hiqw+SiIPhCiHOM3+0LYAdAz5c85s9aGFo8jztwGWmtvcDF6IFhMACdxh0fxnE45+FqxyaBv/U50nQpmS3Wo1Lm2nn3tIbmof/4jHy/tyKCnEvw8ALOVLb08pdiivYIscOWYiMyk9Imh4uZg8VWGIr/rQRMB2Xmf9Zep6e47L3YcTvPWp04T0MuqOPbmMhI4J/LhCs7/1v64hZulwM1WRAegnTCY7qOXMMkAa8YkI9oSrWDnw7e9+V8DzDyS4tGBefbKJSX/97Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f242885-3ad3-4055-1de1-08dbf74f3f8c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 18:06:34.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQBaFvEIxVPf0qY2WhliulwHn3vvWlIXARc3KONlaS7yFZ1gVXc4IGt9JQTU6yihCmu6mOIR7Fnu5yk+oNmc+DGZTPJlprk/zl+fmWbK0t8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=758 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070151
X-Proofpoint-GUID: VvI8v6ZNnF1HpQHMCfHWValm47J_9aKx
X-Proofpoint-ORIG-GUID: VvI8v6ZNnF1HpQHMCfHWValm47J_9aKx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:23:29AM -0800, Jakub Kicinski wrote:
> On Thu, 7 Dec 2023 10:41:25 -0600 Aron Silverton wrote:
> > > I understand that having everything packaged and shipped together makes
> > > life easier.  
> > 
> > I think it is a requirement. We operate with Secure Boot. The kernel is
> > locked down. We don't have debugfs access, even if it were sufficient,
> > and we cannot compile and load modules. Even without Secure Boot, there
> > may not be a build environment available.
> 
> This 'no debugfs' requirement is a kernel lockdown thing, I presume?
> Are we expected to throw debugfs out the window and for all vendors
> to reimplement their debug functionality via a misc driver taking
> arbitrary ioctls? Not only does that sound like a complete waste of
> time and going backward in terms of quality of the interfaces, needing
> custom vendor tools etc. etc., but also you go from (hopefully somewhat)
> upstream reviewed debugfs interface to an interface where the only
> security assurance is vendor telling you "trust me, it's all good".

IIRC, with lockdown, we can read from debugfs IFF the entries'
permissions are 0400. We cannot write. It's not suitable for
implementing an interactive debug interface.
