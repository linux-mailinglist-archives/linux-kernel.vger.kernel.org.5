Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC1805BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjLERLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjLERLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:11:17 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F72D42
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:11:23 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5H49ik015741;
        Tue, 5 Dec 2023 17:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=mREin99aMnLhqE+QOmeE3G5Oxbz9HDQV3QcTgn4hwb0=;
 b=Dp4+vJEgHMQAOha5F7nUO9JT9llTyY3nSBheiileyA05EtmLamIde9i8AEue+NLVBwgw
 EiVndIKLWGdeAGhWRo/cptQUxUQsRromBe6xg2/VPJ9ieA72bhx+f3R7RPuKvK4GFTeA
 Bta98qzdh0Lqj61DR45bCGkq64KQ/uB9hk459zc0fhHibyGG/Z4YYyCOt0Qpo7hoSEpr
 XY7KlU67ngGTVLnEx1QfaGV5O4SlfWPnrkFUHrq/mUwS9VOWGS7n+pBLPeTilKMHw2pu
 RpAT/RuStcnIQ1VWIEx+RErHDIpU+gfh0N1yY0upvOy0BqqqKyqhDe03EsVU7yzKf+6f XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut0n8s959-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 17:11:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5H6nqG014057;
        Tue, 5 Dec 2023 17:11:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu17tn6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 17:11:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5opM9ivQ4dT+Ma6sYAUoXAJV9rfk18tFBhqtMHEE68/bjEdmZO3hwnmmRYcnJ5edeDQe4675RcYyC3nhgLy0cOnhWrRpSqn4ghMp4A+HW/le6Aix4mXVhey68pORnW+ZOA/joni3CHSGXSgWFuO4oPKMbiESyUnEVvFsEW1H02SbGYPmv686ouA73eOxb2J68F9YZ+OoXaVC6rhNu9bNKDueijGdbE+QHdfro8mgM79Z9avV4T9m5zgqabAl5o7mDzHx+Ri+wkCAPQZXGBPnxp2WYtsDaCslxOLT8rxYlk+yMdypx8wFVPaau/N0Zln3J3Ddlii1swlA59dt7krLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mREin99aMnLhqE+QOmeE3G5Oxbz9HDQV3QcTgn4hwb0=;
 b=N9kofoKhp/WKpoWR2wZFFM4VpdkiBVvAwi7t7CrcjeXKKuhTJoZGo+5UtOG8QR9GoL1ydsqbq3GHkibOh9cd+AjvecJ6htzUAUhX7WShZfQOO4H49kbq2XKVTYWDsrhUBsEH/6oQ0v6wF9qEsXsDPBRL0aJ1ePF1WDMuxkocNVZJvadfsMgZPCw1AfKL4hzzGub7pvnYnaT+f7E6LFqagLdG2dFv4QlLL2gHHyRejddzjD4iQGxcuX39O26vYO9IIvM7m5pr/VhBserg6+qPn8Gy7mw1tIgR0mXdGfpUJROm90A74eRV3yOeyqkzDLCJwQIx7BPetviEPx6rCwFvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mREin99aMnLhqE+QOmeE3G5Oxbz9HDQV3QcTgn4hwb0=;
 b=CCqebG3Hsi5VWTBuI4k3GxVifDB/ubdPKZrhgQXapLdXeGOH5Ga7FOzpseNgTFGqaxlXOEli+WK9u7NbegOihO/TTLgeER7atsZhXgpif1UAK/6GW2jHi8LpRtCkfKKz2x1dyjP6MhU5wbCMBnHvXQnTatZA+XVKHyIaxvRpZAc=
Received: from CH2PR10MB4309.namprd10.prod.outlook.com (2603:10b6:610:ae::12)
 by DM3PR10MB7972.namprd10.prod.outlook.com (2603:10b6:0:43::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.34; Tue, 5 Dec 2023 17:11:04 +0000
Received: from CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::300b:9614:f3b7:17d8]) by CH2PR10MB4309.namprd10.prod.outlook.com
 ([fe80::300b:9614:f3b7:17d8%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 17:11:04 +0000
Date:   Tue, 5 Dec 2023 11:11:00 -0600
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
Message-ID: <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
References: <20231128044628.GA8901@u2004-local>
 <20231128065321.53d4d5bb@kernel.org>
 <20231128162413.GP436702@nvidia.com>
 <20231128084421.6321b9b2@kernel.org>
 <20231128175224.GR436702@nvidia.com>
 <20231128103304.25c2c642@kernel.org>
 <ZWZJGF7moDM_k6TU@x130>
 <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204185210.030a72ca@kernel.org>
X-ClientProxiedBy: BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::10) To CH2PR10MB4309.namprd10.prod.outlook.com
 (2603:10b6:610:ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4309:EE_|DM3PR10MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8032e2-7cfb-4e9c-357b-08dbf5b529eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kspbULSrMWFVX/dtrMLIl68pB46fO1fPEHJ+nczN7HzMfUvMnKd422i96FiLXbRZ+z5meTGde26Uy17hcEHeXN8HG6Z8ey1SgstEjYlUuQKQcKkNbq0s5s8fByaQK4X6HMhKkJEOQ2ovbUvP5WU7UC+VWrLrNlit9TEHRxYY2gEUPcHMhTLSrMCWvFTlWI2/He/Nmqk/DWuC4vJgzNUGV4mnxaXIRfhFNcecIzFZnaxcoTkn38NbfSfkaJgZYCBdTquQAQ8lnFw63qR20fN4RHfga4khcZLhEktLWC+yyrP0TOZr1oD+exVVcnCuIdDvjB/0rzBRH1N1d3fH47IF0ov559lbXiHnlUJNycnqBm7D5ulCcV9Mpp+UXcL/Al4bqf68k+zceisTEkPhQdHyNajND8OTHXALBaCdxfiSJ8AUaAf1yTMOqQkotk4UNGFUznrlxJXl1Y8NT/kTGYaLshxcLnODecuSzcFsQp72tzgaadiU9rnSjLPpchXZ1TrwYLKbimE7k7SF/jNapAJ8TGN4CoU5+ScpTO2NcljZSKSQXRihOpSiS7vSwYL2Mr27oVDl73KxNjYoZgeunEj1kyvTL91Y4/bOAJoSTcuXypEqxDLdHXOXb5cXEDEouPOcWTAgo4QWPLd1z2dhsTDIoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66899024)(26005)(6512007)(6506007)(6666004)(86362001)(38100700002)(9686003)(5660300002)(7416002)(8936002)(33716001)(41300700001)(8676002)(44832011)(4326008)(83380400001)(54906003)(66946007)(66556008)(316002)(6916009)(66476007)(2906002)(6486002)(478600001)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBwgAzwph0TG/qYHVILUzwRqdJLaUDTsvtBXHXyOBOZabye5V7SdOsxnolVB?=
 =?us-ascii?Q?vG4m4uqBSTSiwGa2osAILhsVy7v2BeJP9lanltbb+hepNuVy/LsN0V+nEeoC?=
 =?us-ascii?Q?1KSh57Y0Yvhnl9boOVlezdcZTZL8y6F5e7ug3aitLyrKThvsv/8v4DrcLKd5?=
 =?us-ascii?Q?rNrfeIjxS7bfqN7X3Lt+j58f2E/zStyr02uZF4B1dKzVOpkjbtgE20x0rBpg?=
 =?us-ascii?Q?uEhvYb1v9PsdPAp4jczfUXi+clVyp2pjiGfQlpf/uD9+IFqS7WZq4EVYmmHn?=
 =?us-ascii?Q?rCsdo9LJ7D1eSXYb9sSPzHph1qLchWYyfRwamD/9//BoWhsYZVTJFbIYtaYe?=
 =?us-ascii?Q?VgQJMMZz8AeKQ7WqKVNVSIuUScLJJJGD5sSecuh5t4mdQPtKgXUFB9lVUWMx?=
 =?us-ascii?Q?DaJxAxksYA7bf91fk4fMyDXjbCMr8pytwYkNj2itsu/iNdz7TPOCTlv3PE5j?=
 =?us-ascii?Q?Q047zzXy5LG1KntUFJljouiqVnbBDHde0/DZPuHFMlfCf/2xDId5aOmF8fil?=
 =?us-ascii?Q?zlBlXl0Hl2FQXpCMLLi8/Ts15xnYbJ2n+Cwq55aNqtw6qAugJnaEjsTwYW8s?=
 =?us-ascii?Q?GWn5vfBopdpwdJu0GKQSHqCwpEsTXJgRRKd4IoKjxTL9YaGV2Y+zC+TyqpLb?=
 =?us-ascii?Q?efotT6oXCKpTOvZ8tk0NvmVO7zAAEAXcrYZMx3GOMAjCOjbfAmxJ+/zYhInq?=
 =?us-ascii?Q?3Y8i08Z98XvB3KGM5U/zm6OBT1Cojq/ekxj0gPSV+eYMiWPH4sH/i0BSzwvu?=
 =?us-ascii?Q?nGwvcX7BVrlom0VAu+Q59JXB5zcIP7ozSEs4f9t3+qcWt9QD+D5AZ6BH2pAa?=
 =?us-ascii?Q?tbCSxlXbuoQCmIjxaANxZ8RWkZprBkLs4/hp7UcJuPaIc2gBDhGSXqBOwiiD?=
 =?us-ascii?Q?iS0xTYzHFx2EilWtYa8wjC+3AHWlLEmpJPi1eXiZNpdA9eeyW+5Ql7FPL6a3?=
 =?us-ascii?Q?ulsq6sVaAWS9OELWADY3zLo1rFOgZfq+T+jKTC8QAqWQD/pxkFhFD3HyrIpa?=
 =?us-ascii?Q?7PN/GKkIM1zSg9M0ONknU+OyrnbBDsuWMwh7l6gD4RU4kYTFhdnI4pPeRepE?=
 =?us-ascii?Q?bbWtaQJw7H8Y8wez21T0Zo/JoYJEK/WeZb6v8c9W+GjIUD7Yoo/w/ncjuQod?=
 =?us-ascii?Q?8+Zxqgdjw23udTo3q/BavVH4NXaW/s+S003BKdoAGNz+zbV071NNvIW7OCXS?=
 =?us-ascii?Q?G055QclZUvNsnW50v8FwwydJ0PAAVd7MSDs6sP3BKa0kNMmjiqe/HFa7Dmrg?=
 =?us-ascii?Q?8N9U9xckYgYfOH5mR8MgRlkuYj1JhDgvhXIKSejf4iQb+ZA7IqgqcZL5Vvw1?=
 =?us-ascii?Q?O5xCvwnlSLNB5Kbo3oq8Zvc1HFUZQ36EQKR34m1vhRuBO1/Ws5GxyVt7l1L2?=
 =?us-ascii?Q?8qEjS4f4YdXELZ1kKWewEL+xZHDQ5lcZ6WinYLCkG6GnuL8tPdvY4T2QX3sO?=
 =?us-ascii?Q?4pkhmg9eB5rxLmxQft8F+uEiYkm+KIhAiCbHkAchtXHOgsqef1JzVN864IvO?=
 =?us-ascii?Q?+9b4DaiVX8hv5P6dhYOqSzaonXJLAd6rT7kh6u/Qm5EV1Odzk9kkzJz6Pmkc?=
 =?us-ascii?Q?mCrN6xQPyK732sGnc5UFARAMTbFl5oWZQ/hkJACC4H27UlOFly5CgpuBZnNU?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9hGBlO243yLf6IqGprtp/m6jOkiK5iQ8iljDhdJ5BeeOf4qxT/OqQHPSKYtTq0jzPYizRIcUk+n0myg0Bcw1PxfVtjAVn11lqv/l2Oui3Oewb5WpS6ONS9r4WwIAgEGk9SOe95TVn4qBD2dbKnL+TGBY1Rw8O6i0DPf/mITDnak5cceHtP5V2dUTrmAM+MrWOc4pqkmHX0N16Iyv3U9XDzuP4zPrvtpYQbkUi7XIXSshxbKzCrEOzt/y1XRKXFPvE5egpOjdqbrkskctQmuy9IeRCzKXhj8Ar+kfvPLbxjuNFumug5pnZlHew3sv2ro/JKQ+6jCwJuA8R6z23WEPLhdc5fa5p0i4F6D5HcHt8bqyV3EW0+4UL1+3Hm1LfI0j0aHxxqWgN3xfliZXQw2WTNaYwmBPYPxv2qSd2agArGAzlw+HmA0tVzJyytEPXMeTDtmG0xa5LnlAkS4TNrZt6EVkbWPRT0g6p2zDheWXYog3cBh526vEr+KrNH0XDKUGq2bb/tQ73Y+by+RvjSk5k1khZejlLlJ5G4ywPdzZ5+/hh1yT4ttHkr7ucKrLKKnVBL9b0tR4lmzwyC0BNPR2MNeKHvD8kfIZO7xrTbNbjBxr34h6QMVE064IIbmFI+UuKXg/iZDmKJZlD5ZRDBXuE3TwY+RWBmp+WjWnJJENsQEm7Vh8zeR41TOJLAKppLw1SUfNLA1pxdHNdW8kV0II3cWUzV32tfA/v9bMIq1Ly9IJZXfvXPRK2ZVbf4Df99rwTYGH0K5I+Eu79Li22hvQ5I3oiEXrjaWZZOODEtAHUCK190rpBHCEc2bcErExg+ETM+tFHZyIsgYOw3kPv4/AaiH3OQBCmkGcLTaM5xfMD8Tu6EKkoicRQz0Jzn3iWd2y/8ofhno6A52EArYbv63I0g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8032e2-7cfb-4e9c-357b-08dbf5b529eb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:11:04.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnX+9KnqNZCcibNsvVMvvo5llMSCuiQ8bymQm96yDDvDyCDDqEOj3sPjxHue4ql2CocxwTUzCmf/0/1PMJKMETWhIKd3FBsi4ebxJspgQCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_12,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=548 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312050135
X-Proofpoint-ORIG-GUID: Lm-TkDp8DaJyuQX7sZ1CWUjZjKgaiRE1
X-Proofpoint-GUID: Lm-TkDp8DaJyuQX7sZ1CWUjZjKgaiRE1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On Mon, Dec 04, 2023 at 06:52:10PM -0800, Jakub Kicinski wrote:
> On Mon, 4 Dec 2023 15:37:56 -0600 Aron Silverton wrote:
> > > To Jakub's point, no, we don't care about enterprise distros, they are a
> > > consumer of our releases and while some of them pay the salaries of our
> > > developers, they really don't have much influence over our development
> > > rules as they are just so far behind in releases that their releases
> > > look nothing like what we do in places (i.e. Linux "like" just like many
> > > Android systems.)
> > > 
> > > If the enterprise distros pop in here and give us their opinions of the
> > > patchset, I would GREATLY appreciate it, as having more people review
> > > code at this point in time would be most helpful instead of having to
> > > hear about how the interfaces are broken 2 years from now.  
> > 
> > We will be happy to test and review v4 of this series.
> > 
> > Fully interactive debugging has become essential to getting to the root
> > cause of complex issues that arise between the types of devices being
> > discussed and their interactions with various software layers. Turning
> > knobs and dumping registers just isn't sufficient, and I wish we'd had
> > this capability long ago.
> 
> Could you shed some light on what issues you were debugging, broadly?
> 

I'll do my best, with two recent instances:

1. As mentioned already, we recently faced a complex problem with RDMA
in KVM and were getting nowhere trying to debug using the usual methods.
Mellanox support was able to use this debug interface to see what was
happening on the PCI bus and prove that the issue was caused by
corrupted PCIe transactions. This finally put the investigation on the
correct path. The debug interface was used consistently and extensively
to test theories about what was happening in the system and, ultimately,
allowed the problem to be solved.

2. We've faced RDMA issues related to lost EQ doorbells, requiring
complex debug, and ultimately root-caused as a defective CPU. Without
interactive access to the device allowing us to test theories like,
"what if we manually restart the EQ", we could not have proven this
definitively.

> > Our customers have already benefited from the interactive debugging
> > capability that these patches provide, but the full potential won't be
> > realized until this is upstream.
> 
> Can you elaborate on why "full potential won't be realized until this
> is upstream"? The driver looks very easy to ship as a standalone module.

Firstly, We believe in working upstream and all of the advantages that
that brings to all the distros as well as to us and our customers.

Secondly, Our cloud business offers many types of machine instances,
some with bare metal/vfio mlx5 devices, that require customer driven
debug and we want our customers to have the freedom to choose which OS
they want to use.

Aron
