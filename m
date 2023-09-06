Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC37945D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbjIFWA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjIFWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:00:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D2419B3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:00:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386LFFWp020040;
        Wed, 6 Sep 2023 21:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=SmoSPuxN0hrc9hJDiDnB+BwSsvTKWxfQg+8Dfxwt07A=;
 b=DprNosJsu4Tj6ND4LQumq9YXwpAz29/Y0cWGdF8v1+qLLL26ygHDzRnbitgn427t2GrN
 E+h+j39l8R2SQgIt1h29oK/dyOhm8CM4MrVi/tQ9LURmbB1rYzgckD9ZMucUUsyzq9id
 x27PhBtn31fk1PFjR2shVNaDENofEzXqjenugOxORabun25gGnQXINSed7aIEzooUqk2
 gVXfnWH+yUSotdMTFIxFZL2lDjZcGl+5ZlffWdStshjNM1EAu3azvPvLIV/eTfMLs7gI
 H+febI7CHtCk4leU4GLiyyYOqddmnG/+w2KmBtiAuRPa+HD/2KBBAZ8Nb5wVmR3D4GL4 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sy15vg38a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 21:59:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386Lbwwv037089;
        Wed, 6 Sep 2023 21:59:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugd4mxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 21:59:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mubj4ashBfFmR7DNJGA25jBvT25RXlJd5qEwDC3eNWbVanvbmVOcQH/Ah2Bgo6u7ea/jbWUxQXE2qN9sn/55shcmYs6kiBPk9OgzJwOsNhPUfmn1OziHid+DN++KYpVwpTECZvlWIv5d2Kn/IoxcjdGn0+PIJeFhZFwl2DGtb2MJWtAqcY2JlLeqGm86xShDW5ZDsGR7SxE4uccwA47iJrphI1XGBIxNRTCfmdAGIrIYAqyMw3ec1WbEtJnkuERi4cgoVERZSQPPGJWwhiFXbDEsKfg/hcJvWbOUy5uBfcDCUs2dcRhFsO9hr+ttPJq2wgY/LXW82NX/8ypm1CNCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmoSPuxN0hrc9hJDiDnB+BwSsvTKWxfQg+8Dfxwt07A=;
 b=oLH5mk1dyCN0EkPH2ljDOIoJ+ijkgwqa67hL/+dLh6tFc2W6ZccRBVJYleWAaj2Gy4BL+5lSvh2loR8SGhbzaUOAFeUlu9/b1nuoAMfLjwxlIMusQQiN/BmpdKixOJoIM7vIqiF/yHhn5Zo0X90VOCITV0l1Fd8qcbRg4hABRUySbMOYrNCHvQgJ3KXr1f4t6gu15jeB8iBvWx1Yt4kKjvKONqr/IpDMXMbY729h+ABbaShLkqi0DOoXqjWpAWbGbkzlF5Sa9Q66tgcf48DRIFQlXLzwwDyHS/l1/NhHJsiG2fMrsPcVdyV0Ha4Xh+B9C5Ty4RLw6pKhAwXvb8IPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmoSPuxN0hrc9hJDiDnB+BwSsvTKWxfQg+8Dfxwt07A=;
 b=c6knXPIsw3muz2pwgCf/VzqVkbPUg1IglQj5dPxI8ZzYsUAQtA09uxMyX4ieRNtZpbIkl7pKKjoHozSwQ51hhlm1Zhuka8Orf8IyH4WRTaIRcqOYMJLuJUeyMZvG2YAZugPVR1za1RYpzjXEoRpw2ioXnCiDXv3ncqKL7xFL30E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 21:59:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 21:59:30 +0000
Date:   Wed, 6 Sep 2023 14:59:27 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [External] Re: [v4 4/4] mm: hugetlb: Skip initialization of
 gigantic tail struct pages if freed by HVO
Message-ID: <20230906215927.GE3612@monkey>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-5-usama.arif@bytedance.com>
 <20230906181016.GA3612@monkey>
 <57c8dd7f-d1a0-37c4-1d3b-d6374e92ffa1@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c8dd7f-d1a0-37c4-1d3b-d6374e92ffa1@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:303:85::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bb96b4-7a11-42de-8739-08dbaf248bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DB/kBKGAH0M49oUlyHK21SovHVuC3cS7kmStebLDXBrCkxtozJGM6/38bVm6SwD0OSf3615hyqDmNEKXoeEX78epXge4Uj9aNuEOyExZIJYEwZYRNSGfHi2gmJWCnSCynxkkQ+mB2SPBEhIqlzRCk0KDLi76u9GBuCWEou5LUqUdMika6TIjme/60bK617z27Sx5SD8yqRIffYIwa/xHDtbwan7tdSYxv+02xPI+XqL6MHENi7+EFP3glBIO/yf6JhsvbzpPN+/pnc7vqQ0L8B1WtJvGeJH4ZoAxigbGxA+1WxV+nA7E8GIHtlMjRZ6BhwjgArfPBAG2qR7+4FcWC4k/dNGaUefMmwn8BYnI9UsfsFXaC9NdnqTCMyrac+kiPoZeAvCbmfVYJ2zeEbShLhAqeNlWfyt4n6AL2Y6kEs1VP6J8E7Ik+w7Yv2Hc+8kVO8OWIJxnkCFTs4BzAAX7K13rJDeWbqlmxBL+URw8M3GSC/MlQtpEIbsFc+RBC9hpo7jNh3kl6oAsKkrNVPsdsiYmE36ZtMHqxUrH1esU+PmGWuJ7N01vnTbbV0IeCqDiamfUJcck+SPIjVXAUma2BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(396003)(136003)(366004)(346002)(186009)(1800799009)(451199024)(478600001)(41300700001)(6666004)(33716001)(26005)(86362001)(33656002)(38100700002)(83380400001)(9686003)(966005)(1076003)(6512007)(53546011)(6506007)(6486002)(8676002)(66476007)(66556008)(6916009)(316002)(2906002)(66946007)(8936002)(44832011)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/YkKHejLl7ol7kDmPXQTQds+Rz32Y2afV4XsqfefR9LIolSHWaSN4kmLVqF+?=
 =?us-ascii?Q?qe3ZN7Va43Joee1W2COzQVT4fckMI3W8CHgO2zit+Lk+NYH4CRaumOH8mALZ?=
 =?us-ascii?Q?PHF9F2aVibo4VWnSvEWS6UZSdtDOhOIG7PZVfHoIsUzEE/zdIQim+pjN5gO9?=
 =?us-ascii?Q?MVwuGY5DbBEKHRpfkmUp2B8FiQy+3UdXz3WmxdUE8FycOQykcuDPhVZ3/Tuq?=
 =?us-ascii?Q?g6N+gNxq8inV4W+j9zxhXv6sx/uus0K3b/jME+14jykTSfP8ZotbaTuwxNA7?=
 =?us-ascii?Q?vpTcmGUB2mv/Qcj2Z75hkqY41eyQ1sC265+kFI3iggOZuauTjoLtv9qOWdWT?=
 =?us-ascii?Q?3Ej8WElBbY67MRFpH/lHNcRXpfBZEi+j6ToOb4M6ifBuBXCrUSD0eUo9likI?=
 =?us-ascii?Q?cfFNwGwVoUlSH9ghWdhxCHt9JHhq4P5gc7IliHiePZACiZJrEBVqNAlqd2Md?=
 =?us-ascii?Q?+F6X2GhGfA2ITEWRTLjxqAPd56HsND69LqWmU8uTGXBgF6rTWxzE5PwR+O+0?=
 =?us-ascii?Q?+0zB7/g8SxoaqwO5t5P10ZgO2CjvHrRwNaQPiHMPXUN4Q3xn/Be+7T5/J2Cs?=
 =?us-ascii?Q?JRLQve1QkRNtAyDyOlE3YR9BqwoNJjRj9uKte53hbDO/nqpAjL13aP9vBaiI?=
 =?us-ascii?Q?v11HfkLnHfdI37jRpOt66VB8V+8FvzgUOtY0G6OjCzoVpM/pXQa1Wsbu4jKz?=
 =?us-ascii?Q?C49XsOIhb7B+HNIqo0O/MNeSprLwvtIeevYHzVquzP/0jvJ5uieeeEdSyfIY?=
 =?us-ascii?Q?UQh5ttWhFlBbH+kBMluk/fuI9nuVIXYdrQBTQUpuX0Ox7YTCuLDj67ImHRdh?=
 =?us-ascii?Q?TXI9LT4AmV4ickYsj3+q7b1IuiX+9ngK8b7Iy/XgyILDMbaTBd0/Xh/3rZlU?=
 =?us-ascii?Q?yapTuFhD1S/ICiIirGGKJz4Gh9ZWKzhvbrsfJ0PDWz2GNyVQxnlTNAlxDsB/?=
 =?us-ascii?Q?wZiH8XmLuGO5ZyJanTIIETvQKmwSK/Em9Gt8Tw74oEf1OEsiIgmWf/Bdorzx?=
 =?us-ascii?Q?AmuBSBWwHDeiauv9WZEEiCjhv8LeD2h5xN7R+1kpg9QkM//RPDCdA3OZ7iWn?=
 =?us-ascii?Q?PSMRFxo/YJEik3AIlDXNFdiI4314WDPOjIw7TIyKfaqkbatN4JgCsMCDPWoD?=
 =?us-ascii?Q?+tN0IJ95gTAsSPtQfH8/fm/pqpEMy0bzxfKc75lvbMFmAtunJAMznPSZZ7pT?=
 =?us-ascii?Q?dg+1rXSzRRsQmewk6arDibShsaL6N07JxZjN/7mvrWi2cq0sZVgLUpVvxz27?=
 =?us-ascii?Q?hQRy/MdfBFmOrtn6ePQ39O0gCvQq6F7fnpIUZ1LRa0vO3KsS9MTGYpMqbO4j?=
 =?us-ascii?Q?9HdD1uDeHVghmVozsSasdq1HYBjkDLjzrkkXhmyCL2YZvq007EiJBljhGbV0?=
 =?us-ascii?Q?l7EVRaf96cyktQS0EamvEoaZbm27Ur5DJKlRGN2X69BUhb+vKKkj/zkjMlAz?=
 =?us-ascii?Q?RucinueeX1jHuUt/gx4SpbVsPirgoyjDtutDu9+QEM4xAWHcyHF6KVpo/F5H?=
 =?us-ascii?Q?Z66losww4lRO8BlFjdrpINb+Fq28rKrUubpognb8gloEec2y3OKrDzR1iUNC?=
 =?us-ascii?Q?c1/wTzgf84J2yXzOW2NQD/EkNptMjpik92xsk9q5hnuEhFOzyz37y3NmMtEc?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5dDSouAyTMy/BYLcL1h3O3FWByNXJbOzztY/9x6ZyjMB5qDMmdq8oxeRDR1sG2lpF1TsosEdvjXTOBfLwAKryK04SrHYSDXfymlFTWdKdVbt49P51MqUkUp7z95fqOXFkPbDNQyzqwAHmxrblse+VI8fOnb0cd+HWuIMmOLJX86leipGjgIgnwAXTdjCVnATc1j/v5JvriD2z7MHio7xsViEH3S+iBy5nPlVl6cvocwYoP0cc2fY3cn3R4YBvyaSJmkTseF3/ZTlJwCtTaFOvOsX8+CmDR1ypNcx1n2sBhqgqnZnl6VbEuQ6c0r5DopvqcNWhy9/H8Q4MRqTUqIE6msjzVvLIYhee1pn5BuOhaCCaaY0M6nqcoXvWRQG7/5BOwT7rjuA8L2V5MaOLWGS09MAwANWdTslrMntbvV/TqhOj4w/3Aa/XFl8lItvPXSb6zC+q9lvly5sNXCS9rdX/Bs3VG7xnYGqS9LJfUBeae6XvQt5C4PKUZk6zcPFM8PpxKIknf6uqvBbJa8inxuQEDb+meUijtsph1opugOyFRrn9piTDqq32myn/0LI8FfHD0jufR/5kGuGxtMNrM7vkml6EpOjPaCCD1Bv7OmpcCJQSQFJzFtoghOhPjSVk11sjSzaFmei202DSrIq+JJdCwyugpAId9D78wG7xaCzQE3Swafn51c9myB6CVQIEhDgQrR0CD//wsdAl12/w079Jk1RTjdHFQ+oHEXgEezLv34SXmG6NQwsytuO7RtrIjNNsXZmngt8x7k+DfI3s3PGTRhETQyr8k47b6Rjrel9z4es/qZVKM6I+Bp+HR4v1r4ZTRB2861cYmGKdZbqpUmqoKiY34z2oVbwucCoSLFI+VDAYVJsDOPd81cC1DFYd3C3kn+Vrm6wkyzzg33xCQA61uLkXpYYw2x3la4llFaNMjM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bb96b4-7a11-42de-8739-08dbaf248bf4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 21:59:30.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOwub1dwHDW2VWHmmJiu9rbNSKFzApqi1Mi5p3iFztnxbfGAV7/jdzxHL5HQW/pFXkroU65BCB7lNznFvq5WZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060190
X-Proofpoint-ORIG-GUID: jQbRpz5H6o7VnKh5TT5aZ6vAp8BHJUZ1
X-Proofpoint-GUID: jQbRpz5H6o7VnKh5TT5aZ6vAp8BHJUZ1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 22:27, Usama Arif wrote:
> 
> 
> On 06/09/2023 19:10, Mike Kravetz wrote:
> > On 09/06/23 12:26, Usama Arif wrote:
> > > The new boot flow when it comes to initialization of gigantic pages
> > > is as follows:
> > > - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> > > the region after the first struct page is marked as noinit.
> > > - This results in only the first struct page to be
> > > initialized in reserve_bootmem_region. As the tail struct pages are
> > > not initialized at this point, there can be a significant saving
> > > in boot time if HVO succeeds later on.
> > > - Later on in the boot, the head page is prepped and the first
> > > HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> > > are initialized.
> > > - HVO is attempted. If it is not successful, then the rest of the
> > > tail struct pages are initialized. If it is successful, no more
> > > tail struct pages need to be initialized saving significant boot time.
> > 
> > Code looks reasonable.  Quick question.
> > 
> > On systems where HVO is disabled, we will still go through this new boot
> > flow and init hugetlb tail pages later in boot (gather_bootmem_prealloc).
> > Correct?
> > If yes, will there be a noticeable change in performance from the current
> > flow with HVO disabled?  My concern would be allocating a large number of
> > gigantic pages at boot (TB or more).
> > 
> 
> Thanks for the review.
> 
> The patch moves the initialization of struct pages backing hugepage from
> reserve_bootmem_region to a bit later on in the boot to
> gather_bootmem_prealloc. When HVO is disabled, there will be no difference
> in time taken to boot with or without this patch series, as 262144 struct
> pages per gigantic page (for x86) are still going to be initialized, just in
> a different place.

I seem to recall that 'normal' deferred struct page initialization was
done in parallel as the result of these series:
https://lore.kernel.org/linux-mm/20171013173214.27300-1-pasha.tatashin@oracle.com/
https://lore.kernel.org/linux-mm/20200527173608.2885243-1-daniel.m.jordan@oracle.com/#t
and perhaps others.

My thought is that we lose that parallel initialization when it is being
done as part of hugetlb fall back initialization.

Does that make sense?  Or am I missing something?  I do not have any proof
that things will be slower.  That is just something I was thinking about.
-- 
Mike Kravetz
