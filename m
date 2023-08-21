Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B8C782EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjHURCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjHURCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:02:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367EED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:02:47 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxLPb031511;
        Mon, 21 Aug 2023 17:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+GSgAdXiDBr5CvefccHXsh+X9/psFpspjjpRBBLmRpA=;
 b=CoJB/BFRpL8IXqSTOuqzbLOTpSZEVO3TEIwhO3MsOEnhwwTSYnHJ6VYzamAw3crMf68n
 UtgwgJ9C87VUHiKswUzUYDv2i2LElMDbvLRVAnUUprP/qq7EHAhGNhYZ3+cWhcIhaISP
 1MJXcDcGOYRkND1jQmkF6KxGDf2/ntsj0db4PzOE67pbV7BzMAJMeT9wlAguAxqZKBkn
 MPIClyxps5PHdXOrpI89PTCswl+8rugP60Kygf1HR6dub/mGYuUzBQ8/BhJFoZ9K4WwN
 Puzjy7mgRPO5sRkN+14S6BZ/wdZvIjx8u7R3ojr/VBu2bPh6x1vNIoW7XrOvOAmF0PqQ GA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnscbcud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 17:02:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFp2Jj018766;
        Mon, 21 Aug 2023 17:02:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm64793m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 17:02:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3xWgar0lzVjvV1sJhJ7Jc2dIxQjobhLNYH1J8tG4f5NLtbFza2lCKxd9l3bI6EwOD4LzCpTKdNqq3sEo62i/6x38rHI6YE2rN9Mmemomq+ST+c8UUUSRhuyGyAedJYud4kGzuI1qP68NCQo2RUs9+lEvsIAzZX5qrApS9RCkQPMDPpaeWcOp02PSVDrjtrUiPUS/BZUidmCQpF7PMiq1xu9jFRo0quAicBtqX4cdqAKw9/MiBoF+PRzVOinvDu4a3KyDihwgVYzU+r6yPOQ+qwv60vE5strN3al1otrB4u/zqT5CdS0C0+OsdktcGEYn0KXwzI68MCqSFHo4ptcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GSgAdXiDBr5CvefccHXsh+X9/psFpspjjpRBBLmRpA=;
 b=Mr5JTLPejzZBBwtcRPFoRT7bR1nBDbpprSmWsa7NG4WXEcexY9W8bFY0SkvoIriIHFx7xYToLxgUvQI/lScMrRhD4uHYr8X8mM3tHC8Kc9vHSexKAP3AeU/9nPDk9APLEjXT7DZKiRU9VPJ3JOdX1u/AujlZXFFJmymcUHFnSNLM4sm+x8VBN8ykCwlwlSHkNhlqH6pEC4UM6QN8EoPoxvQ4DCCoWXEkOZ4K3AjsVAwdJY5H4dwFxObLqm+mOhpwsurxfPvnI8GFNjs/HeHuza2EDrKTeYUZyMnRrqQcCImbk8VUAMiZAhzqce3BtYRbNi63UZQNRgkpvX7pBw2hfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GSgAdXiDBr5CvefccHXsh+X9/psFpspjjpRBBLmRpA=;
 b=vwktPZz+EtsfHkqloQ/bszGIBba6UIxnLhbRm66VZ/AHIky6jpk+dcvYR0u+A4wTSnt5rqGhN127VxnN6k9XiVnxsejzDauA2aS8eNsrhjEsh6v+sLISRHB5S0s5k7MAxt+Il3h0K07fZuv/JtfKGl/Xm2Qlog85yPDZkK2EMsE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 17:02:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 17:02:37 +0000
Date:   Mon, 21 Aug 2023 13:02:34 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     syzbot <syzbot+609e63261638ff3d5436@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-out-of-bounds Read in
 mt_validate_nulls
Message-ID: <20230821170234.rqtyias5vbf6zxbu@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        syzbot <syzbot+609e63261638ff3d5436@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <0000000000002d884205ffc75b9a@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002d884205ffc75b9a@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: a242f039-af4c-45b7-8cc4-08dba2686b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvKThWr5YY/uycxKXcoFgp1kyk/t+QgGdpvlvry38B7QtQiU4hJPvasUTzXzthLFoowIrScmCib4q3RghobC0+FLqaDmjF8CVpRGMgwva0c9NPCrGsPilJxcY36pqWp3ZCGMigBkNIKNjN+FGYLhY/UCrrYvq0KKs+s9RB7yT36fUNtn3a9IzPRA58aEFwEwVediihhcf9XlAjxhoFkvzvOf/vFAVF2lQ3ocBUEiH6m3raW0BVT857qVvaFcwvHqMEASdQPl7gJTc1KCSSOcjLREKJ5cxjwUeVgQ0T0j4ytO1RXSTHlaGswlflkTzZQ/klJh44xTp3q1ykK07qRpV+R7NpFFwM1Lxkk6mHaUH18gO32BmTXhIFntC95pZFIWdBPAiGRjafc4okiiR+3LIQRB3iD4jrFtV545fQQUKEs4Sv3NWcLpx3U3jKOcCgl5lkKiSHtgAU+E0E21MhRIu8lbY+Bl/i6V5CNolpEXuwVkaTWWwmRGzuW4McV1AFywJSGdkC3eSg+MMV/tm3ud+L9TFkL32NQAZTJVIGOJmhEQMtTI0jZeBtmPNtHKwQJq3ebE+4VQTQnuZmJ/KgFm3uxk7nEkhCEo1W/iCic2h2g+P/ABAE1lK5tuidOO7IxsgT3xp4X5hzcTxMOvlmxLWt+MUD970SMRoleXgfFooOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(66476007)(66556008)(316002)(9686003)(66946007)(6512007)(8676002)(8936002)(4326008)(1076003)(33716001)(41300700001)(966005)(478600001)(6666004)(38100700002)(6506007)(6486002)(83380400001)(30864003)(2906002)(86362001)(5660300002)(26005)(99710200001)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQ/2ejOuhhs/23lmRQkMooeVoFXJOtPbpsqVzFK2JCpp2vIJYFouopo3VvRl?=
 =?us-ascii?Q?qRcdfRvQBC8BgrhcnPQD4l85XxzuLhELDSHk04elTSG+K4cPROneylGFxZdg?=
 =?us-ascii?Q?edYU41u8EASOKKf/+YpO6XO95foqkP3nW6myARF0zldLoFtqGrNUmwCO8r7o?=
 =?us-ascii?Q?P7M5Kqo3UMHRy/E4CZzfXf9aXO1pXsND2FMF2cmiqjopYN0BUJQ980vupXrE?=
 =?us-ascii?Q?ui9Xf2gRK3WGYtwZDsn/0vG30CfU++FbKzBdTgAh7nJHJSkRGdJ7RtAG7gqn?=
 =?us-ascii?Q?WAenJq9KUDZl7D/nJDUPEQrI1FpndWTJANCBvolcLulStqBCiuPIH19etSCv?=
 =?us-ascii?Q?xK3iuSO4w2Pck6e6WL9hIFu9bAXmU0g3Bc5X/QC5X6clelgKS/sT9KqnE4d2?=
 =?us-ascii?Q?BMMOoe7TfeeDxDZkq89OT5xf1qEPTJEfvBncD+mn1dBfelnH7+3CRp9NJ/pg?=
 =?us-ascii?Q?N5RRnxbSXrDeCfKWzYCUm+wl6VTAAbluk7dkP1DjpNihCC5qteuD+SqNM9+K?=
 =?us-ascii?Q?w82AjGdt1/KS8XCXsatB8CPb/eawv+RhfdPVydrq7bmQgIkQoBrja9RJIfmM?=
 =?us-ascii?Q?EYliL1KZzDwhWIk2DPjSltSi02Oh7it+vyiq2xpHE8jfTX7bDQVmGgaCshAv?=
 =?us-ascii?Q?yxmfSw/c2cJsq3L1EMspzl9aP1QNjeRznW9XFe4aQK1gp5YrZeF/5j6LkXtz?=
 =?us-ascii?Q?5ONOepnaCMIfn+1NsU7165/sfAoS4SXrHVll3kwR6rIDXjRw0W2IRLLf8W0v?=
 =?us-ascii?Q?XICepZCPa7pgiVDhS4xyXDFmJcEVrytDsPTxUMXvraPegsH5Wk6EM4XuPNpM?=
 =?us-ascii?Q?mPfXCiDnP9mxDZYAyaprwu378fbfibwxtMbrI3OuflQwEGwK/r0YrDbFnj/U?=
 =?us-ascii?Q?263YxtcnkLQ0bVbBwYZfC7aTXC1BuMmcyODtXWdOcfULN0hpbDhyfROhk00p?=
 =?us-ascii?Q?2FtMCLt7e7Nl8Cl9mU7NjsaXPf+gd+1tsACHm+ABVoEA9h8+9z/vJ4sdwroj?=
 =?us-ascii?Q?IIqmo4UBh+d/JwAV0s6OytS+423kZJZzDU6KZr5CQ6Dly5wbig1paP0hQP9f?=
 =?us-ascii?Q?Q+MmUsU2hLmH/Lp06BUM67B7l3bR87XyCmtxh0iFjLQIBI5SeQ57dlwfz2/E?=
 =?us-ascii?Q?wo85jXPzGVOJ7AyuJO76qrMFQtEK8c48YRQIIAT2O1uMw7CjvdY1/qIBulFl?=
 =?us-ascii?Q?5uT+tZkO+PjUsTIJAS9ssnHJ2oCp2T75gAHZeJdB1Fji5dCS3Mlpn/bRI3op?=
 =?us-ascii?Q?NE+w5NXfIh/3qAgAlMg24xNyHT8bRGaXGhG8DZRn3xTcpcVBwWIIPgfQ9GZz?=
 =?us-ascii?Q?x6iwmioNEeFxmkIZ7HLenQWz1dxDy8CUNsuYLIr7QSpzmz2B09wskFDEVRH0?=
 =?us-ascii?Q?hK3UXzAsg4ly9yaVVzWBEx5lFmJZq01yumesrlXFtRpKSJ6+NkZMG72KND3Y?=
 =?us-ascii?Q?uFWwj4eopj8FxK0noU+/YtTcWudP+Y3XyJTngoeNIUA6oqVF/VHfsl0a2vbf?=
 =?us-ascii?Q?OIKmP7n6AMZVfN+idEOfufNbQkG4I83kE4unIJwtNJbD3P3x3L1hws8CNoRT?=
 =?us-ascii?Q?eRrFgvW6Fs29q5MuORMv+oao8cdHofBUK3B/1Mzj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QxOXBds/ALs4jVP9LmaXcICjzsjzdIElj/CUH+Vqne5cZpLL6JRyl87UU0+6?=
 =?us-ascii?Q?xGwdf/YAhkEEx6lzxcU8xg4n2rE/ZgViJpcHd64TvlXBxZ3W+ShmQ+VGAseQ?=
 =?us-ascii?Q?wSwQW4JQtOTgyvAedAiYTLlkpNr5M8vgDTaGtWOOfJGJ/ENlAGSzYDKmx33R?=
 =?us-ascii?Q?Wne6JgX9lbQANVMi95mtB3m7FhRR3JOpFZnesv8UChJciMhtslyDTGpeHD5y?=
 =?us-ascii?Q?IIUR3CjDeLpQ7qIAPL2RVHzTXjMkc0cKowUHYgJuMaqrLha+z7+Rsx6KYH4T?=
 =?us-ascii?Q?/e7G0f9b8VofVuoN1MPgvxaDJjP6pxs/Njo+c0wIHH4o/RhwcYAd1hx8gOfk?=
 =?us-ascii?Q?TDDIvN5WlR/xOyeoPI4KAYh2vjP8pS8hZD77H29RALeOzCUKhQ0gmH2j8sJx?=
 =?us-ascii?Q?+SDH/iM8cqZiyLhd+txBx6Jh4YB+tvetM8UIjmlFtKvb9tTuM/Jr0gaX6o+S?=
 =?us-ascii?Q?oY+laTE7vUJZ7JT/clVjrIBr1tOhoxZ8smXpayuV0p62PWvCrNAuMAF7VIX9?=
 =?us-ascii?Q?5VtJvBEtkztEqINHsXV/a3MH3cvnKGdz1YCwSIgw3tsHFQEDNDP5ROz0L8pO?=
 =?us-ascii?Q?VE5Iq5/MryxvZwu3G+acfJUgvOyVgNQtcdiXMn72+taA0i51UlBwjJJ2q0A4?=
 =?us-ascii?Q?2A/QpKs4UEIfqBTH36DktfpqbbXhC3cS0KTdYenY+rFFCDkttncmhuoQpV4Q?=
 =?us-ascii?Q?xE9i0px9U44v7pESdDWMcCdwFlrZJlj1+q9oeFpOr/FqQz70yOIfS4J9fjfn?=
 =?us-ascii?Q?Do+BuId3rEkIRcv82YiSklg9lHNaSX/YLfffD5wx1ZMR91dHmwBT34fH+byj?=
 =?us-ascii?Q?eUnmOroVkyaBjJP6VkULzEPiHWsM8LFJ91dG201Z0rHj3gL+3hsgBkvnDmq7?=
 =?us-ascii?Q?FM8iP8N50Z84LpwVarg6kQH1f4ThvKUtlmLu2qPLRjGls8FCkl7K/STqGHqR?=
 =?us-ascii?Q?ztb/ijLgM/drCGuarc1NKA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a242f039-af4c-45b7-8cc4-08dba2686b7a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:02:36.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pon7tDbEpEajlqk6hDzcneYbthfV6AE2CHQ7m0qY6qnXMPjbg36jZCoadXAtt+VckXLI4VI0hYk8gEnawwPuvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_05,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210158
X-Proofpoint-GUID: EKYqaWe4xNdHKfSOQfrXeoY1CDo46Y7w
X-Proofpoint-ORIG-GUID: EKYqaWe4xNdHKfSOQfrXeoY1CDo46Y7w
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: mm: validate the mm before dropping the mmap lock

* syzbot <syzbot+609e63261638ff3d5436@syzkaller.appspotmail.com> [230705 21:23]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=116a6d68a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
> dashboard link: https://syzkaller.appspot.com/bug?extid=609e63261638ff3d5436
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10342968a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d4cf70a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/119fd918f733/disk-a901a356.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/79f9ac119639/vmlinux-a901a356.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8bd8662e2869/bzImage-a901a356.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/183577244af6/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+609e63261638ff3d5436@syzkaller.appspotmail.com
> 
> R10: 0000000000002000 R11: 0000000000000246 R12: 00007fb71e6c96b8
> R13: 00007fb71e6c9180 R14: 00007fb71e6c91c0 R15: 00007fb71e7a16e8
>  </TASK>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in mt_slot lib/maple_tree.c:816 [inline]
> BUG: KASAN: slab-out-of-bounds in mas_slot lib/maple_tree.c:849 [inline]
> BUG: KASAN: slab-out-of-bounds in mt_validate_nulls+0xc04/0xd10 lib/maple_tree.c:7172
> Read of size 8 at addr ffff8880770ab100 by task syz-executor263/7002
> 
> CPU: 0 PID: 7002 Comm: syz-executor263 Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:364
>  print_report mm/kasan/report.c:475 [inline]
>  kasan_report+0x11d/0x130 mm/kasan/report.c:588
>  mt_slot lib/maple_tree.c:816 [inline]
>  mas_slot lib/maple_tree.c:849 [inline]
>  mt_validate_nulls+0xc04/0xd10 lib/maple_tree.c:7172
>  mt_validate+0x17e3/0x4370 lib/maple_tree.c:7227
>  validate_mm+0x9d/0x470 mm/mmap.c:300
>  do_vmi_align_munmap+0x1199/0x1680 mm/mmap.c:2561
>  do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
>  __vm_munmap+0x137/0x380 mm/mmap.c:2899
>  __do_sys_munmap mm/mmap.c:2916 [inline]
>  __se_sys_munmap mm/mmap.c:2913 [inline]
>  __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fb71e71cef7
> Code: 00 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb71e6c9168 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb71e71cef7
> RDX: 0000000000002000 RSI: 0000000000002000 RDI: 00007fb716288000
> RBP: 00007fb716288000 R08: 0000000000000000 R09: 0000000000000176
> R10: 0000000000002000 R11: 0000000000000246 R12: 00007fb71e6c96b8
> R13: 00007fb71e6c9180 R14: 00007fb71e6c91c0 R15: 00007fb71e7a16e8
>  </TASK>
> 
> Allocated by task 7002:
>  kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
>  kasan_slab_alloc include/linux/kasan.h:186 [inline]
>  slab_post_alloc_hook mm/slab.h:750 [inline]
>  slab_alloc_node mm/slub.c:3470 [inline]
>  slab_alloc mm/slub.c:3478 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
>  kmem_cache_alloc+0x16c/0x380 mm/slub.c:3494
>  mt_alloc_one lib/maple_tree.c:159 [inline]
>  mas_alloc_nodes+0x4ec/0x8b0 lib/maple_tree.c:1282
>  mas_node_count_gfp+0x106/0x140 lib/maple_tree.c:1362
>  mas_node_count lib/maple_tree.c:1376 [inline]
>  mas_wr_node_store+0xa64/0x1170 lib/maple_tree.c:4100
>  mas_wr_modify+0x28b/0x10d0 lib/maple_tree.c:4346
>  mas_wr_store_entry.isra.0+0x495/0x1030 lib/maple_tree.c:4390
>  mas_store_gfp+0xce/0x1f0 lib/maple_tree.c:5506
>  vma_iter_clear_gfp mm/mmap.c:162 [inline]
>  do_vmi_align_munmap+0xd02/0x1680 mm/mmap.c:2538
>  do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
>  __vm_munmap+0x137/0x380 mm/mmap.c:2899
>  __do_sys_munmap mm/mmap.c:2916 [inline]
>  __se_sys_munmap mm/mmap.c:2913 [inline]
>  __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Last potentially related work creation:
>  kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>  __kasan_record_aux_stack+0xb9/0xd0 mm/kasan/generic.c:491
>  __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2649
>  ma_free_rcu lib/maple_tree.c:189 [inline]
>  mas_free lib/maple_tree.c:1344 [inline]
>  mas_replace+0x98c/0xfa0 lib/maple_tree.c:1785
>  mas_wr_node_store+0xcab/0x1170 lib/maple_tree.c:4151
>  mas_wr_modify+0x28b/0x10d0 lib/maple_tree.c:4346
>  mas_wr_store_entry.isra.0+0x495/0x1030 lib/maple_tree.c:4390
>  mas_store_prealloc+0xb3/0x270 lib/maple_tree.c:5529
>  mmap_region+0x91c/0x2570 mm/mmap.c:2811
>  do_mmap+0x850/0xee0 mm/mmap.c:1362
>  vm_mmap_pgoff+0x1a2/0x3b0 mm/util.c:543
>  ksys_mmap_pgoff+0x7d/0x5b0 mm/mmap.c:1408
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Second to last potentially related work creation:
>  kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>  __kasan_record_aux_stack+0xb9/0xd0 mm/kasan/generic.c:491
>  __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2649
>  ma_free_rcu lib/maple_tree.c:189 [inline]
>  mas_free lib/maple_tree.c:1344 [inline]
>  mas_replace+0x98c/0xfa0 lib/maple_tree.c:1785
>  mas_wr_node_store+0xcab/0x1170 lib/maple_tree.c:4151
>  mas_wr_modify+0x28b/0x10d0 lib/maple_tree.c:4346
>  mas_wr_store_entry.isra.0+0x495/0x1030 lib/maple_tree.c:4390
>  mas_store_prealloc+0xb3/0x270 lib/maple_tree.c:5529
>  vma_complete+0x8fd/0xdc0 mm/mmap.c:553
>  __split_vma+0x53b/0x830 mm/mmap.c:2381
>  split_vma+0xc6/0x110 mm/mmap.c:2409
>  mprotect_fixup+0x891/0xbd0 mm/mprotect.c:643
>  do_mprotect_pkey+0x883/0xd40 mm/mprotect.c:817
>  __do_sys_mprotect mm/mprotect.c:838 [inline]
>  __se_sys_mprotect mm/mprotect.c:835 [inline]
>  __x64_sys_mprotect+0x78/0xb0 mm/mprotect.c:835
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The buggy address belongs to the object at ffff8880770ab000
>  which belongs to the cache maple_node of size 256
> The buggy address is located 0 bytes to the right of
>  allocated 256-byte region [ffff8880770ab000, ffff8880770ab100)
> 
> The buggy address belongs to the physical page:
> page:ffffea0001dc2a80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x770aa
> head:ffffea0001dc2a80 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000010200 ffff88801324d000 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4689, tgid 4689 (dhcpcd-run-hook), ts 21566309288, free_ts 20023594773
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1570
>  prep_new_page mm/page_alloc.c:1577 [inline]
>  get_page_from_freelist+0xfed/0x2d30 mm/page_alloc.c:3221
>  __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4477
>  alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
>  alloc_slab_page mm/slub.c:1862 [inline]
>  allocate_slab+0x25f/0x390 mm/slub.c:2009
>  new_slab mm/slub.c:2062 [inline]
>  ___slab_alloc+0xbc3/0x15d0 mm/slub.c:3215
>  __kmem_cache_alloc_bulk mm/slub.c:3966 [inline]
>  kmem_cache_alloc_bulk+0x270/0x860 mm/slub.c:4041
>  mt_alloc_bulk lib/maple_tree.c:164 [inline]
>  mas_alloc_nodes+0x341/0x8b0 lib/maple_tree.c:1304
>  mas_node_count_gfp+0x106/0x140 lib/maple_tree.c:1362
>  mas_node_count lib/maple_tree.c:1376 [inline]
>  mas_expected_entries+0x117/0x200 lib/maple_tree.c:5656
>  vma_iter_bulk_alloc include/linux/mm.h:898 [inline]
>  dup_mmap+0x4e4/0x19b0 kernel/fork.c:681
>  dup_mm kernel/fork.c:1688 [inline]
>  copy_mm kernel/fork.c:1737 [inline]
>  copy_process+0x6663/0x75c0 kernel/fork.c:2503
>  kernel_clone+0xeb/0x890 kernel/fork.c:2911
>  __do_sys_clone+0xba/0x100 kernel/fork.c:3054
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1161 [inline]
>  free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2348
>  free_unref_page+0x33/0x370 mm/page_alloc.c:2443
>  qlink_free mm/kasan/quarantine.c:166 [inline]
>  qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
>  kasan_quarantine_reduce+0x195/0x220 mm/kasan/quarantine.c:292
>  __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
>  kasan_slab_alloc include/linux/kasan.h:186 [inline]
>  slab_post_alloc_hook mm/slab.h:750 [inline]
>  slab_alloc_node mm/slub.c:3470 [inline]
>  slab_alloc mm/slub.c:3478 [inline]
>  __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
>  kmem_cache_alloc+0x16c/0x380 mm/slub.c:3494
>  getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
>  getname_flags+0x9e/0xe0 include/linux/audit.h:319
>  user_path_at_empty+0x2f/0x60 fs/namei.c:2906
>  do_readlinkat+0xcd/0x2f0 fs/stat.c:477
>  __do_sys_readlink fs/stat.c:510 [inline]
>  __se_sys_readlink fs/stat.c:507 [inline]
>  __x64_sys_readlink+0x78/0xb0 fs/stat.c:507
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Memory state around the buggy address:
>  ffff8880770ab000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8880770ab080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff8880770ab100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                    ^
>  ffff8880770ab180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8880770ab200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
