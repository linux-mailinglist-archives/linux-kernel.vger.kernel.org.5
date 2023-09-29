Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748A77B3BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjI2U6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2U62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:58:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D6E1A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:58:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TKi4T4030426;
        Fri, 29 Sep 2023 20:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=euy68juYMSyzP6z7xgo9t9sxOF263S9honYJ3fBCLB4=;
 b=1PgULRFgbukKDJR7iE9pk56409GR6IIwTP4qF5rXoDFAzjZvHXD1LI90ugcbU40tGjum
 Q7R2DFerVlrkGXBR5ch2GQ4n7ivlpwDCmdjO5YP9Cj4j15Ym62UnNuNADdBkr+hgqNZm
 kbOVUl3s6fJFWJLTP2/UgsmrHzAO4rqAKOxKpozs+l8X24VgC5TaJwBei+yzC6QsVMT6
 RBIS8XZAvlMGB0/TYE31HefweaM75JpK+Oj17Uswue3B722djVTPu2rI9PR3d+miTInt
 GUpzyvNl96xi07ophx1uoZZIckLW65wuoSzHNq0QKsFOQVwSFX894nJg3NHQUDVr9JAe 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peeffy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 20:57:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TK0VND015803;
        Fri, 29 Sep 2023 20:57:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhw8fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 20:57:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO5u9CmkvHo7moE8dxAbzJzt87kTYb5xwollmrcUszyJXkOg515VSZkwGQgJJmFYUYp/e3sBhNUphRvQVximNeP5mRk3WNejQokIqI7yyGq6KsSnMjcxmT7/lCSBbj4kSdgDl4cGSH065cWwP3zUzE5jDW5Rq/+vrTK/+1V9pBY3nBR/TCTa9HT5vv6+zr04K7GPfbYemW9neiN+1wuiQF9Mzg7XcrKfjjn4qqsbzyb886nfMUtqmQdeRZF9HiC+FuIIUFIt8Rp5BWRsxuioWUhGouDcPAW+McVJC33cr9N/nbscUQdn+/NnXJJ62M1/OdCVOkfwN10jxmkD45YdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euy68juYMSyzP6z7xgo9t9sxOF263S9honYJ3fBCLB4=;
 b=MbncIftB/PwlwXl39v2rbL5w6ucYJeUZ4t4q5N/JCz68Kp14JmBghA/dDhmgOm9d3LKyYPwXiOpuh6S4ffcFixDO/NQLj8Mzqd2LU4wqQxIlAnJHtznvafTue130/5MAsF5q/eKoswlttqL0r1JzdjjMHAzNC9MkoxWgs6uPbEQ0pi3jcOF+vxhg8jFkaRs3YmyU7Uu/ayJvrmzMxErwRSOzESKSAvpTL5P9l0VlbT5dy11mTcF1cIZ1H7rTuLM2j2p0FEmuWkWZ0MvS2YAgJMDXSzX9fu1VZY95J16lV6bazgerDJbFhybcsuxU17aOLxBfKbBvpD9FCH4u98sbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euy68juYMSyzP6z7xgo9t9sxOF263S9honYJ3fBCLB4=;
 b=mck6JQUssjIUt2pEp5LawD5YKZD8/n6BaaGVNNLYBu508mgK2JgSFB+3T5inhB5jmYncNguELRzf7B22P7L374P3co+dHizSkID10xsnKdfcdGSleLkNT1CVhe9xlTHymBwyBuibEDLtwal8Dqp5Y4EIX/uTHEjMfWVxQj7uAnY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB7440.namprd10.prod.outlook.com (2603:10b6:610:18c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 20:57:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 20:57:34 +0000
Date:   Fri, 29 Sep 2023 13:57:31 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Konrad Dybcio <konradybcio@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Message-ID: <20230929205731.GA10357@monkey>
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH0PR10MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bab5e0-a44f-4f9a-537f-08dbc12eb490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqugLkeY1GjCmfsTN9hQuVTTW1AITnJ9kaFlJcwxEpkZckX99ig26wkPzoy/dP6tWPTTKq4Gn4iUHGC8/UAlG5uyP6QC03MEQKrysEy610HJhXWK1BtbW0ZfRKtmq8rvUpZchS55IiVECkWBjLuJwya4+GfWv0m+2IbBQ9nz+WhqpqOb+jdltHXlRxyF4XJ/c4Od/Y9xsPjbvcOYOjD237xgQS3tgu9sBzn2M9vCBlvUW5GiThk6gq2gvMeDZZqcba8z0Unk7kED+MT0n2Yflhj8mkFXvqtIvoannxA9VtyBW/czANvZs/2mcLinJ2RE8xqfQcFtJwQRRba+QWMc/94JbNK7oCN2KYmFWhd9pdKPA6PYc92THfse1JvnuG+mfCcNOAXMsWmb/Y0RsbQ9V8IYH0S+EQPvJ/a88iBQBrs3SXdoo1JFALp00es0kSDiFKLjVGJzwm92PtzhRy1QJdmA1sPbEhS896ev1p4q9Kd0Yc0zCkexcIAw6izp4EVVqeUNK8TCd1xEvcEl3B7Qcqx3kArT5JfchRn0+eQRkkdGxvynhwV5Wc+6upJ1DMmZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(7416002)(4326008)(5660300002)(8676002)(41300700001)(44832011)(8936002)(33716001)(26005)(66556008)(1076003)(316002)(54906003)(6506007)(66476007)(9686003)(6512007)(6666004)(83380400001)(66946007)(478600001)(38100700002)(6916009)(6486002)(33656002)(53546011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?utgeTmpVDoqOWb0QLW0ya1Vi8zvHejAO+RvK8pFQVB+fn8aGWftsYEHAG2B5?=
 =?us-ascii?Q?1nf/fb2ou1bqP2ru5CQDrDA6FWPamE7MRncio8HeXUjItRNHkIRezcNK8qxp?=
 =?us-ascii?Q?55VRC/nNcOv8DAri2nOEDMf/chw48hcbb8ZRpGCcXq6tIkZY4uXz2NOZwPPB?=
 =?us-ascii?Q?ZSw2nf/5mbg2s+SpAUCy/dYLidD3LH28DNc/Gr7rTcnc2aN4MR4mzcqRPT1W?=
 =?us-ascii?Q?T/KU7aRASb7z09fbnPr/I5bAE9jPPWGIezVQ1IBVHEd7bU8PLx0iot0cN9WN?=
 =?us-ascii?Q?q5yIRGDNN8Pmg1L8onm87yQLvFoIrFdhxI0+sMIULO3MIJjBKOcwL9VfxDAH?=
 =?us-ascii?Q?RYKgiwvvk4dirHQZKnUZphBEkdJnBiliTgIFlPxNmZwW/Je2W4beJQ35vikU?=
 =?us-ascii?Q?azwEU7qu1VvfEoxAHPARmh55yvuVRVEAoYkwnPJoy/pfFk9EBjBPRszeMbhV?=
 =?us-ascii?Q?7I8dBZiyyipfTWbV/YrQa8q7R48Qw79teNiuf2a0MTqam0AVJkPfsmDTEKYi?=
 =?us-ascii?Q?ny2Zm168laekwY8ZvQo+MTcqLb/MFZMhVrdu5qJv3FSL82eRm3DbDuyJU2+P?=
 =?us-ascii?Q?c9+kgV0GcCDDCbOVEbizvZLqEotdiToY0geXk+TAMcdXV5rYtBqbfcqxjNxL?=
 =?us-ascii?Q?K5RwpFltCEQD9E63TmkcfBCmaieGTXJak79E/tFQiBNeeEVsVeuTF7sLXXUJ?=
 =?us-ascii?Q?pgBzWEDEI2JOACYQcqb43SWEBN3C7ax8UjOR1hcs0fh3DoUWRj2rbMWjVjKb?=
 =?us-ascii?Q?ljFwbw2oo+KU9ZVYxmJcwsBoarGpwhqO6LyphR6r5ACdNH96cK1KiC1h89Yc?=
 =?us-ascii?Q?S2CeLpNzsRvzMOxdga1hsOUrmiUR+XDHR4XTabu2KG4eTRuvKcsqmnJ6HydR?=
 =?us-ascii?Q?kzwOyfbJ4tQU8+oVXUunK+HObBor5gP0A2w4VSFuXOL2fieW9nn4y4xN13BW?=
 =?us-ascii?Q?n79yrE+EzYtoPxOXYF4sXWwkE7u1vBl29kfGAN2BRan0IITSk76bABRNg6R3?=
 =?us-ascii?Q?+D45U2A9TEyWGiwjTEzgLFcftPL5+drMznBnw1TbFcIcvWOm9nPMepJgmbwL?=
 =?us-ascii?Q?yJbOuDSciW9d9ihpCEVq3RfEORf7WYWYMgAjAYfgJaAcHFnt1AKMuYDX32bO?=
 =?us-ascii?Q?Vj9XaEXwQFh0Z9J8WjMrxGqJgrrdfmJJyu+5XRHVK57kGg/lLCxty5kYJOcd?=
 =?us-ascii?Q?EWvFJMVCdEHH4GQdR/O3JHOe759H/6I6i7v4lbWO0f4iQRqC0A/cnvw8P+qO?=
 =?us-ascii?Q?Tacd3cFA2PpaF1yTDS+rHbPAgRSSXsGZ3R0GfPBJGTX08+9oYJKUwtaMRr3J?=
 =?us-ascii?Q?WBArdweW8ZftIMqtUku2v4Jk3zpEDovwq7i+t6LiIWTd4JA8kOoa5L/ZZwQl?=
 =?us-ascii?Q?bzY8LBxk8RciVHsQyDOuPQYftG83Y02n2kCDz7eYkbbVH9JK4n0pkueP+YK5?=
 =?us-ascii?Q?1PYZ1HwzAkwIXM0HasI4RLWhVcet0f6Gabtfhza/1uOT+I2N6M7lK5pJsOs0?=
 =?us-ascii?Q?fZZLIMXM4S+w7hnesgz3vkAagbbLbDWV1MzJM6EVpbYkG+ApCLAe50rqe57T?=
 =?us-ascii?Q?Iu3pTsXFQ58samE/aV9yaK6YyvRQJrkMh+tv6H20?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SKR/UQHTnFOZf0VEIWEvHTIBWwhePeRBS4Cj0eVDVNV8sJJIsy+nLX8UuBhP?=
 =?us-ascii?Q?lWBWYjApT8xT+XbbuFhKbctW3Q+wV2Y/ybSkgOix/6cJ9i4FCHSJBzibjIEp?=
 =?us-ascii?Q?4kaYDjo7/xnY2BOvKWtTOKMogPSKan67WzjSQIQWzQKmxpHi4/ncZTyaTtC5?=
 =?us-ascii?Q?PD0Y5KQ6DKzglFLpEjRvL8i6ODfgSPykVsOUQX1U4ysHn4qNARlrhvqfKOYQ?=
 =?us-ascii?Q?A4zKetXbCaC/QbFE7QUZDZKXSbhH/tifFAnG0rsp1SY6xJFXQgPjrGhyEh0t?=
 =?us-ascii?Q?G/4OF6+NyrY9U0UDZK4HHa7s1y5HO2APCdIeGnbNg2kuw6NCMkLgoViww30G?=
 =?us-ascii?Q?maLuAaHDgSvntMVpm1zB3bXsC5X1x/r9xsNZqtISkAvD8ZfuEjyK4+vi+2Hb?=
 =?us-ascii?Q?J3PTLL/RGB845wmRnjrC38I4cxxf2igv0j2rumOnocUlKK0ElmEJVUhJSjdF?=
 =?us-ascii?Q?keb9aAW5wg1B7sGNwv7VpzsT+IZPP6eswtWTuISF23erlvkpsQTjfwJ+13+3?=
 =?us-ascii?Q?cQL239Uc0SwOCOweW5Ek4fGgIRL0SUJGZSR9uNXKHtJ6d4gbMPbVhesRfVtJ?=
 =?us-ascii?Q?CBESK9i++uorqn+7PHeVnUpJj3PJ0ZLC0npFdbcEmBHKSiy2cgk4X8tIgDUt?=
 =?us-ascii?Q?++WV6GlZzLl9pcUXzuMqQQ12IyRqcPtwQ6eyC4DRCal+DlZlZ5Ttv36m1989?=
 =?us-ascii?Q?BdNl9j1oBbhKMqrveejVK61UrGtZuHdFeBnomHFzG8o3PNI96v2XoRGutlLm?=
 =?us-ascii?Q?vURaxPGGt1I38W+kdKOfFXx15LrilZi/8fgK22ZJfGgn5SwGJlTDR/SmtlNK?=
 =?us-ascii?Q?K/nGefCj6TZy/iBtxzk21R27UXzU3/4ZOrrTiujLytK3Oiwnb0XUuNaPngHR?=
 =?us-ascii?Q?ghMkuOvJaSkuKVAwWHP49dVS9noa66Wi2dRtew7YbL/9+6SD0V+juTXPoZQo?=
 =?us-ascii?Q?EQS+5WWkH8hpB/+KCDs7Itrsp4jL+rvxVpswB4c8PmfnUF8k3WU2/7aQ7VzB?=
 =?us-ascii?Q?5a+i0s/X6uscftO+5mF43jcMiz42Fp90d3imcvpDPSfAbj/fNg+Cc6rRtD+0?=
 =?us-ascii?Q?Fpy+NNxz6s32DnQehHC+490CamAsQwDo+b1Xwp4XBk4cnl62sL0kYNyofSti?=
 =?us-ascii?Q?kA4kgpAIE+kNfknza3XbMNmAO66xvPFHmA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bab5e0-a44f-4f9a-537f-08dbc12eb490
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 20:57:34.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7r7Zx9rAFPNg8XybpXuMAkoUA2GsIZyc33ENR4uEMDoOYxVRMrRQhqUqdu8cov1iI6e1XV19mSBNC+Nt9sp8Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_19,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=948 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290179
X-Proofpoint-ORIG-GUID: TRfpeZopUI8__ozii0Dg6EAMm3UNi9WB
X-Proofpoint-GUID: TRfpeZopUI8__ozii0Dg6EAMm3UNi9WB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/23 13:26, Konrad Dybcio wrote:
> 
> 
> On 26.09.2023 01:48, Mike Kravetz wrote:
> > Allocation of a hugetlb page for the hugetlb pool is done by the routine
> > alloc_pool_huge_page.  This routine will allocate contiguous pages from
> > a low level allocator, prep the pages for usage as a hugetlb page and
> > then add the resulting hugetlb page to the pool.
> > 
> > In the 'prep' stage, optional vmemmap optimization is done.  For
> > performance reasons we want to perform vmemmap optimization on multiple
> > hugetlb pages at once.  To do this, restructure the hugetlb pool
> > allocation code such that vmemmap optimization can be isolated and later
> > batched.
> > 
> > The code to allocate hugetlb pages from bootmem was also modified to
> > allow batching.
> > 
> > No functional changes, only code restructure.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> Hi, looks like this patch prevents today's next from booting
> on at least one Qualcomm ARM64 platform. Reverting it makes
> the device boot again.

Can you share the config used and any other specific information such as
kernel command line.

I can not reproduce on the arm64 platforms I have.  Been trying various
config combinations without success.  Although, there are lots of
possibilities.  Also, taking a closer look at the changes.  So far,
nothing is obvious.
-- 
Mike Kravetz
