Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140A47A9B67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjIUTAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjIUS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:59:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C027D5B8E5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:54:00 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LI5JV4020957;
        Thu, 21 Sep 2023 18:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=CMAMwzrrvEljK62aP+j26xjGSuiBcMC2/6oAE9CStLw=;
 b=r1SlraRqGFAH6J7o2Tc8Bjj0ep2J7q2ygqY9B4xX4BWnTqtl5fz1FlIGnISFpFttJytX
 6q+QwL3jL1V29TRdR02f1rNn8fPOC+9RNMmiYXrhcH53gsdidxaPyCh24N7c4ohLE+oE
 GI8ruWJBCKuuLTFHWIp9DPDv9MLbnbV+hH0bv60x2ZK4yoKR0u4FOS63g/VpSkU6fzU3
 hbU7GGtyNpdiuZZ2xEGqF/eSzu2HebNxL4R6cOLmfvLsMBl8+ZuKFOVtw7tftcEpJUX/
 zNdIvpmWV+7fo0GbhYf0izQdTh1rWTejU+iZu31TjPAO5krF3wlTVxSqYg/6a0eReWnZ lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsv037y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:53:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LINV4i001146;
        Thu, 21 Sep 2023 18:53:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u2ms4hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 18:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu6H0A6q5TKzkYKCqc+konxKdUXlmiHtMVmyrGq5Gjp5o2m5r6pXxStHxJizoXvuiUyP3MFHNgz9fYwrdmbivsc0+NYbt4Gmm6kUps+MmcvW8Dk4KAekGfiXxkB0eoqHaouvLvLvoxkQ1GmIALV7LjEGjgNJF9M9X0ZaLamMQCLdE1VLig3uwDEgvkFBmxbrF/2olvJ3dM0HXBkpQVWaxai1Dju9TMNhs8pZfQY/CHgTDh3kdBZKJ8VzRnB1v3MAtJ7Nykn/ws8hPxNTdsTJMqddM1Gf+3LaRXR2o2hkmo3O6iF4aHXmG4ZTNmlNWVZr8zBNMcYQd06Cl9v4KugccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMAMwzrrvEljK62aP+j26xjGSuiBcMC2/6oAE9CStLw=;
 b=ZSFX34OwbeVJb2UqRH9qyTrY+2IXv8+Mj9vNmzfwUpvGgXTxizBQWDVDsdeAQqSGIb4cJ80eBT5pDoqp0unuGnIVMAoUJuFLcssATYoMVTKEMKa2eaC2rLIoFRNnZnx9kbrUp5u8P6XO5FhGJBfSbA0PydhwMFW8o+Id9xMmXWlSu004enRU+/B//nvZerofrRF80Atz9HMThI3VUul5HnO51Bb0NlDt3anUO3kqidagm8vmkTVI+zTgSmJ5/+quvKB2KZGhzXDsoMAPkka6s82fZ3fPkyF+cY0HjJpwz3IRIQC7xgzHTGUAT/R09jJGif6uHfvVerWIpWWcDidpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMAMwzrrvEljK62aP+j26xjGSuiBcMC2/6oAE9CStLw=;
 b=BTgXKsAyXAX9YPFk1LqUTrNDBQ9Ptiwdtq9FjeUwAfNSSNqfNyAqP8Nt29XnaiaR8EpeETTpd3YkzxUTsQdlXnZzHNKolvlYocdESC0UwLEtavtSow+UCJk5+hDAqzZUv2abbOg4kIlL3ot3Mdxr2oRzhm38QFKgc6LehSmf0eI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5343.namprd10.prod.outlook.com (2603:10b6:5:3b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 18:53:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 18:53:33 +0000
Date:   Thu, 21 Sep 2023 14:53:30 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
Subject: Re: [PATCH 0/2] maple_tree: Fix mas_prev() state regression.
Message-ID: <20230921185330.j5jw3oms4tc6crkf@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
 <20230921112521.fc07c658804f4e188179da77@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921112521.fc07c658804f4e188179da77@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0072.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: 24de1866-93b0-4fb1-aaaa-08dbbad40dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kj9eKEYnun6TDn9v5IQilyxVG+KOofjB5c2bY8tzY2WA/edbw2Kpvr/JEPsX27zkIDYNbiPQrx2Y2o6+D+2q5CvPORlnNBA/7Hvm0osh8oS4L4NPG10wkC9IUEzJ9mLKfdlD3szOWjCPubSJSDOwoca4Z0994IkBPNBBIWLCsd8WTGaI+NIyETdn1gtzDGT2yhj/WqZIsQbNEmaiAOr3Zv2QfEP6xvoOOWGoSE9va2Y1H++Qi0RbVlzIzUWfSlp3dFZ1rdSJc83isNcjwNHXxl1uw056VHHzEzhiV7Ggk0AkwI8nAqt0ddJ0LSetBvJFdDbWMNSXeLh4K/J3b/oFP+QtUhQ1W8wyaZyqdhPTRJ8AhokKU9nIrQUjArJ7R1uK9DzpT2ti1eBIxFo0aJWVXCUso873npCGe0yD/MNRGlL8J8tALInxIZ8nulHMBec3tixBEjINWE8Br46e1ZuaCgxrN4qfIkiqwWBKJBmmwfO8o5KziLriLi5PRTwrhz2D4it5boyOAPSaUx8azQofETixwCQ0dAmBp7ASkIQVfO1J6aXBfIV5ZGMSkjK+lni
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(39860400002)(366004)(396003)(186009)(1800799009)(451199024)(6916009)(316002)(66556008)(66946007)(66476007)(86362001)(478600001)(38100700002)(2906002)(33716001)(41300700001)(4326008)(5660300002)(8676002)(8936002)(83380400001)(1076003)(6506007)(26005)(6486002)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k3jDLGT3ldm+WNG9nlSjVmnCEDk/j1AWnvbbO3evtWwcDZe6Q4SSNqZU1pnP?=
 =?us-ascii?Q?ftnu1nb5GxIF+cqiHSRw2+2amBFXFyQJhLWCAoCkvbbCejZZFcAF54BeHRUT?=
 =?us-ascii?Q?LY7AwZRUVXIraAdf12mAG5tDoKJXd4lHk6rNIXSEbvRBqBa3EPAF5xoCvBGx?=
 =?us-ascii?Q?N+INxbIGQWlfCsyK7axZGxCrv0RxBSsX9BFe3cVt132szUqH3MsLHt7bRP4G?=
 =?us-ascii?Q?IHWtxBrncsTrjPPSeFT8HzUqwlbmnS0grcOgosT3zPjP+5rGOwv4zBLxo74W?=
 =?us-ascii?Q?KmjY43aWJXpfH5BQ9wfnUG/fCe0cWMh5KdTuYy3NwRgn43ado3BGoLMj8cSS?=
 =?us-ascii?Q?kbVhz3HHCoI2Y5TS80yTshdO4ci5w4lCfgkxYBUwQ5RduKfkc/H42fwpW+Pr?=
 =?us-ascii?Q?mDRpFOFp1zg4Z+OxOgBmLfTxCNQn6ItqFdVy7l1+gsJrs/1BrFndKnEemF4P?=
 =?us-ascii?Q?ZoLwgA0qayv7tXbL05zRLYQuX45d7CyKDrzYeeIAKbFb82l3y6qcVLb350/6?=
 =?us-ascii?Q?ZEd8qZEGTAH18Bof9OeoENiGLqXoyfNYyrDrKLW8nly4EdCR5/gksMrEr2W4?=
 =?us-ascii?Q?uAjBuFAckdy6gIJpchoL5RNj8Mdbx25necDco2L3GlRTWdyjYXbgc3UQTd+6?=
 =?us-ascii?Q?hBnRUW9Thr8eQDZghBIxCGiUvZC8ugGibq6IieViVNsln9wkNonOusrs3dr0?=
 =?us-ascii?Q?YPiCPf/c1jpkdhdm6I7J0PPoNuZzjmMjzS7JcpArEHEUUGBfniwIfR2m9PQB?=
 =?us-ascii?Q?D1xCYM/3ltAWNvgkMpA/bcQOuTrwPO4VZfmEFnBHMfjtAQnLwQNY2pQGOGEo?=
 =?us-ascii?Q?/MGY5FSu30+VcyjakaoOYXZde0GVTzLXO/g0bzUwfmyobtLyLVbgQCPxsSPa?=
 =?us-ascii?Q?+wUHl+d8wFXr8OOYI1czgDiSTmFB2b0VCen/HAVcvEIxTbBDNQ+BioZVYQrm?=
 =?us-ascii?Q?qp4li+2ta82qSynp/71yLAcMQozC2vHR47pQAq2HejQvHVCoGgoMrDiu0Ozl?=
 =?us-ascii?Q?ZFHT5zRBqX6D03grc2GdWKR9Bn/ADiI6hwy6L5EO4IqRMHGb6dPybSFC4f3Y?=
 =?us-ascii?Q?XvDpr/uo6SOKZPqVMK6bmPAvawmdnO3g1VimPey699wVYoa3rMI3msrA5xHH?=
 =?us-ascii?Q?4CzsrCVK9GdYVRx0n65Zm5wx0s8anXPSpbUhVNTSP2N6eF5vtxndC9Safcid?=
 =?us-ascii?Q?LYb4duz2iH4CsLbFmhRih9Vf70nuec4sWEmH4PCLRMzZ5qNN/UaQ2h5aQYEs?=
 =?us-ascii?Q?y9gkse+CRYJOlPl+EhQ77o44v1qMe/GlkDpMxcS8VQEFr2qARdPjCDw9Ei+R?=
 =?us-ascii?Q?Z0ieXHwu5xig75IYZr7P050PTx1WESWHj3ocTFjPzLTadAEwGu56fzCejsdh?=
 =?us-ascii?Q?OU9zs2U8Ra+y0zXdaM6gArP+bFrbfY4Vxl3TRBuofIyFqzo7EmAVk4Q6HfD8?=
 =?us-ascii?Q?ecwePdiKmKQ0mP9GpAaLlVDvSTopmam3nVjilU6SfNT4mW9OB1TCOzGEnm4c?=
 =?us-ascii?Q?FGQtiFQpNONedsBo8y1ANl3oDjXGB7ucxPw/belYhZtr0T6lRk0gp82seebg?=
 =?us-ascii?Q?JoJUbg+ARlULDMOCSnVjZ8m9/lmyNttdrCH/wN7z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zO8Wf5d8wU2kCi7AaGkF6woruFPs6jcoipis275IGsCoAuIJbFrAJ3g3unbu?=
 =?us-ascii?Q?UXtEmK0WaXUEm6uT1nGAzuvZimeUm2fLT543cZQKBUJd6PgpZGmUlG4PNdhH?=
 =?us-ascii?Q?R3CS0FRhSenI7XwjczkgEmS5XhE2ZPKHJ5Im5yfkMOISBGXincWoFpjn+P8k?=
 =?us-ascii?Q?wEdfS4YRe2z6IEVQDtzt3haEmW+9J3l8gU9Iv7Q8wdCF3QabYwh1s2sEZSmb?=
 =?us-ascii?Q?KxcQHrP1MJjJfAAk85TmLV7TesThBvauQTmuAnnYgZjhv1Nv016fXj+iwGSq?=
 =?us-ascii?Q?7L75pt4ZDLTqLWmr6YZKwedNdWzm2wwN98pgKnzaBgjMMM58oTouOGb+ZMsB?=
 =?us-ascii?Q?76uvUA+gB29aFkbhYXxLN3wXDy5IVF0ALssO/QmEPZCf0CEPlRMstqqI3CNN?=
 =?us-ascii?Q?mygGja0OQDsBP8bjhq2w3YCT375xvkRJfM7uL5RBlMrfwMDHAnD1CQF1JO4L?=
 =?us-ascii?Q?keIdYyU+NFlfOrmqIl9i884PrsWbfE1n+c+joOKrNj68yN0TWd2EM1EjK044?=
 =?us-ascii?Q?IPUVn+QdO1pixMF5dA9gKAOvu3rysCVWQGZ/P2Ij0vanIe3v5nEIXp9WAe07?=
 =?us-ascii?Q?/0VflTNpHW4IrYyDUp0OzuL/x3Hz8OUPr7ajn9DbaleHjnJ52/6/gSAQIBF/?=
 =?us-ascii?Q?gKPRIFi6XOKkD2vswljVf2OHeZJb57SG4VzgwL7A5S9pk+j8uyKrnt2K2m5T?=
 =?us-ascii?Q?6b/vyCMfVEklghpxEPrp/A/TjFcSAzvQMQnYTM5mxWWLhYlxuINjUJ2sIRnh?=
 =?us-ascii?Q?wB6j63kSIYdJsf3t7wwYy1IUCo2xp+KdAmSCYuQmZkl9ThNruNZtgUp+FDbY?=
 =?us-ascii?Q?X1Q/UZA0hYqQP6Fkp6smgQwL4yxY0ZY/+6yVmAWP++0xTNSzzMe32D5Mtzf7?=
 =?us-ascii?Q?Uj5kriCsiJKv1eIwR/IOB7/mN5x2Df2DVfXO+USGYPVbn9YWIAWGWurl8ORV?=
 =?us-ascii?Q?RL/IoM+rz0CRTF0RUBGf3g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24de1866-93b0-4fb1-aaaa-08dbbad40dd4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 18:53:33.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9Cr02SWrK4DGko/JJTWLW7wTQSWp0oBkaZwhI/+x/v2wu34YzBRi3fpzhuc8wIH82Jy+zYEbPBpzIryL19amA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_16,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=775 phishscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210163
X-Proofpoint-ORIG-GUID: uPaoMghAA-_QHHzvk1nKaLZvbNydE_qO
X-Proofpoint-GUID: uPaoMghAA-_QHHzvk1nKaLZvbNydE_qO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230921 14:25]:
> On Thu, 21 Sep 2023 14:12:34 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > Pedro Falcato contacted me on IRC with an mprotect regression which was
> > bisected back to the iterator changes for maple tree.  Root cause
> > analysis showed the mas_prev() running off the end of the VMA space
> > (previous from 0) followed by mas_find(), would skip the first value.
> > 
> > This patch set introduces maple state underflow/overflow so the sequence
> > of calls on the maple state will return what the user expects.
> 
> It isn't clear what are the user-visible effects of this flaw?  Please
> send this along and I'll paste it in.


User may notice that mas_prev() or mas_next() calls that result in going
outside of the limit passed to the call will cause incorrect returns on
subsequent calls using that maple state, such as mas_find() skipping an
entry.

> 
> Patch 1 should be titled "Add mas_is_active ...".

Oh yes, sorry.

> 
> And patch 1 should have had cc:stable in the changelog.

Ah, I sent the series to stable but didn't add that to the changelog.
I'll do that in v2 as it seems I need to update patch 2 anyways.

> 
> It's stable@vger.kernel.org, although stable@kernel.org works just fine.
