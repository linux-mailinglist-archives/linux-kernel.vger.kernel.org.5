Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633E57748B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjHHTh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjHHThI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:37:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A927A9E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:01:52 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DA5qs018182;
        Tue, 8 Aug 2023 19:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=3fYhBY2AG8jgaUejs6159iwVaShg4vhdWJG2HQoyp40=;
 b=LjdztRAvFufZBHZZ7JzLzLcP6Y1Vzo4Nk52EI+BtHxgB6rjePoYVY3SCMzVmU4TZolFx
 X0SArn9bpIqiESUAKnfy6D5jKuX3Y4V4AU7YJG5CWlocCdjTjxJdcmutWAs/g6PB0wyu
 j07z+nP3LdIaxDgXrCJHgQzMzTptDgygU25K8SXF3QROzAhoR/pQKi4Il+DgXoma1aID
 P4eYkH1g2/U5znPFMdl+oJPli5d94QxS1gBYRtTqLpyyg3NKhhrz5aiU+qSZbXKboRGB
 Y2nXdlifEY3mJXu/K1ObT9LtL+o14Z9z1Nehf8orhhh5J2/6iwg3CEFk/6Zo2aeurbpA 9A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9efd6102-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 19:01:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378InhpN010527;
        Tue, 8 Aug 2023 19:01:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv5y098-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 19:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXI1x09v/CxB1Ts39LTTcVWtDSJTTSNu6S8m1LyofMXBO8h7hVxSsgVyTxBroLvetTLJhYvn6Fddi5aluD/rNZFu/QD7qOMaXwkHwyvYg2NDnEKFeIYPpi5oWRW0F0broUzb4bgi9Fyl4GvbmyMebwMegjRyUTqDcr40fRYRDGljjAXQxmLtsERPsoMsSkepmpF4AXZeMBs6w9T1sTfbXPI2jqHVk2o6AsEpXx/O43vCU9/m9WNXlAzqXICdHkf2JhI4bBUoiWXrYK1FUp/sRnzIEyMvkrivL6NpmbHewk/zizBB4aZYW25cbyv/oaTh5T1UI6So9knqiEPt+nIRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fYhBY2AG8jgaUejs6159iwVaShg4vhdWJG2HQoyp40=;
 b=mtjsXkRW5CAI6wwIBYqF4SYtsVA5Ibpck0QMLecPnnrd24H5hX+NerSVvdOm/EHKa4OlUKlUWALXFRTARq5t1ARSDwg8ni/diw//3DnquseaVl6yR3sj1txe7q3nbYZ3TwTrf+w/KnVZSwRebcXR3u0RQEQ+ZSISM14ez6951DanQQAQzH/NI2EZJBtRA4nvcdQFv3sWkzL8aiugIEXWIUj8I9o/aHtDVFRKrojYlX4FPwba8M0gguFWp5qYwMuH3iQ4En5qPzV0Mh5qJEKXyICZ+tP9MlHfGnTcaqxtstdsOzdOA6HhdWcEFqxXUIehx3/MnNolmn5rS6IKy5OFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fYhBY2AG8jgaUejs6159iwVaShg4vhdWJG2HQoyp40=;
 b=UHeN2d/npZm4fqc6D6I7s0IAvfGz0W3YgK/BI64k8wPFxaHKTEVneuXCLsdfp/CB8ffHGzK/xx2GGOTA8as5lmBwrgm91HTq357VfalSuKJ6lR5FVTe9JOBpcid0Pz+mxRx1Qr/n4bM/kmeAQbx5Lrp9PUkpZUp/eQhPzJSwGBs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by LV3PR10MB7938.namprd10.prod.outlook.com (2603:10b6:408:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 19:01:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 19:01:21 +0000
Date:   Tue, 8 Aug 2023 15:01:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC v1 5/5] maple_tree: replace preallocation with slub percpu
 array prefill
Message-ID: <20230808190119.3d5pq66vq5xqyt2k@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230808095342.12637-7-vbabka@suse.cz>
 <20230808095342.12637-12-vbabka@suse.cz>
 <20230808143748.t5ravl4yaxxktikw@revolver>
Content-Type: multipart/mixed; boundary="el5bneffsbguj2yk"
Content-Disposition: inline
In-Reply-To: <20230808143748.t5ravl4yaxxktikw@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0031.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|LV3PR10MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 46cd2df7-f464-457d-4044-08db9841daf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRY6Aei4/LddcuMlL6RW9/qsXQtAtnK1qw4hTS8hY4IMac4ru270qvVGEVSKhqk3oHunZRhNm0pObnosm2+ncDyYaByV21pQf40iD+FPT5sURC0vXsSiSSyuYcP2Mf/BPvyRTF3lcEvs7sfcxyb9asX403XOxD3f7bsRTowKE55ivw8TwL444VdN6r6Qxgmg43NPZn4Ytioqihpe9z2agxFq0OC0Dq4LUco2pCJDk8Zo8ncTeF+QK8VtaUebhfv6UgdUq6r1UKzPLVtGjwPIxa1aUE/WZJC5L3LZvJJgsYsWYKbWoPMNbHsvUkTnOP5b1Q2//3NlNBTjOAcKO+AaSEjS6YaqCJ6FqIdAQ8oRnPQ3BUhy2q06mhM8S/PzQJoUDxic9QxjM38hZJxD0jSFYajt1EBjCV86eVmk7u4LhlohAW3u7j4CTWv9PIbn2Sdwfc0g1RDPA4w1wEdDrmbRf3nvOZu2hTydWx02HLAAMkENmHBAB4zLzDTN3Dx3GeihCWzjAMtGC6yxjX5yL2CVcPD8GQCkV2vyTfkHXlYygUJOsLNvXCFBeuVWBQGqX0iYX87fMgkZrCh8S3lqDFygqhCsLSTdd9FSlpFSojMM7OM+KP6wcPfTtzc8X3lD0Vt6JVSYd40AqSQpH31w8CVyIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(186006)(1800799003)(921005)(44144004)(9686003)(6486002)(6512007)(86362001)(478600001)(26005)(6506007)(1076003)(33716001)(41300700001)(235185007)(316002)(7416002)(8936002)(8676002)(110136005)(2906002)(66556008)(66946007)(38100700002)(5660300002)(66476007)(83380400001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iosj57QDzEyq3WRWlpvq1birPslwAhIuAX16VgyC1OG2NIaGAG9tiNR+QTFD?=
 =?us-ascii?Q?yJGQE9SJQCmc3C4+g0VwIA5EeFq61nnKGGX0TYp81fd9MDJjWCB7xyy96dAI?=
 =?us-ascii?Q?g31mZfVYIXuDXPT3/aQmVzZcICHbbJVQiKRHfcqoAq+z3RiIaARmezh867X0?=
 =?us-ascii?Q?AYkCSePgvZhItaMXjt/UxMC+zveVgfolX9iKXXHV6zdUDw1a38CPLveZku+f?=
 =?us-ascii?Q?JQkNyfGpi1msQ5+QAghKnX9s0WpfNxK5DUz3mXDV5aZLaFVE5hwgBVkuQ4xC?=
 =?us-ascii?Q?sBvkOA7sh2DMKVD5CwMYXiOqqaWYx/dUqwvl2CaW6Vw0ICYPt69r3AKRJUFA?=
 =?us-ascii?Q?i5X+JtMmLECd2Dx4HI8/XKtZs6aU6Z4uqbuYE7VaaQS2R6GL6G8mmyNRIHaT?=
 =?us-ascii?Q?ywEOpkUtvmY+RGV4nLvSWNuTm0Ls4vJ1lG7veQb9Nzp9TQvmcHSWzw8NZBIr?=
 =?us-ascii?Q?/8zsSH8BTCxji2oAMFUp9AUN0z5/3In/57cuy37DFS+LpMpfgrQe8V3hoduG?=
 =?us-ascii?Q?U2d1TAiI9Oy3zbfyxp6plELdPXdIiMf5+VOriYeyvuy1R/gxXjpzfMdo8Sj8?=
 =?us-ascii?Q?2+dnrvKxEsdx9wen7Y1JmkxCVMHj8itpbW+7VEczs/Fy0XZIo0XhE7+zhcCw?=
 =?us-ascii?Q?Em+N2E1sXq2mneF6UmnemMO+ccsyUFLKI9cr8957PZOMasyRtpsBwutElvdO?=
 =?us-ascii?Q?W+VyXydhZJhh+jn5oqxBHIjU4HYsNSLP48izWlCp8Df6qDhtN8i510ilCpl1?=
 =?us-ascii?Q?TwcD1OxU2p43nnenljiRODCVs9cqfBb7h9nAAhktt+dH0AJmY3RVphW5zWiK?=
 =?us-ascii?Q?0R+nr3UtHD7mqNPjOpwuRzo+R1nKMk+cQAJLMWQOnJAHlmIExDPxcRJhHff4?=
 =?us-ascii?Q?cNyfjRQzxmItzd786zZGQbg4sRmTvCcFd/HFGjtmRPucSQ81Se44RstQ3+t/?=
 =?us-ascii?Q?864eg/7schoE/8qVOo8OBUkKy4pLY32pGk6t5QiAVxtj77MnVzq6CABAqgLw?=
 =?us-ascii?Q?OpT/PFiv0cqqB/y2+DxiAq4Q0J/WCBnuUjO7yLYNK53Vb6LaplEkfalHR4fC?=
 =?us-ascii?Q?Nu3IOuHtog4RDYj/UQjnrcpPDlvmkb24wHL0Vz//52YfcLTJFdjN1t+PUEst?=
 =?us-ascii?Q?TYxffaJN2BqEzlnZmTuszgLCPrLIr1uVfSbAOHv4YJEX1qywPzqWSKIlSE2L?=
 =?us-ascii?Q?St1l50oopEPH3brA9sYRHH6DHW7RuCNLhgSemKVOjkxRwtOde9wCR/t6sMSo?=
 =?us-ascii?Q?M5CawLJGpb3Gf7wdBvB4Jjf2j5EyOMvSFV1a7NXEH64LkQj0PiOOR9AgZYG+?=
 =?us-ascii?Q?3+R/OK0Ag6MPwrzOYUb9Bb9jshD+EFyY0/JlX8qqPaZt8tIFGqFZyz4rp7AU?=
 =?us-ascii?Q?U20eHwqTu8luWRIuhCeW1Dqjwq/RFnT6gSVmc8xwhuvvfYWqMdXlzZBXYZXb?=
 =?us-ascii?Q?3qnzl/G25iGLPFwsOTisZkLmzGvKN12GxQ5Bn1upRb/fNdA0xKsk/zo6PYCg?=
 =?us-ascii?Q?PDoZSXuYi5losXR+kUxG04NKNfxefrtNl0Jwkm3RhAAcjKqeImppsaOcLX/r?=
 =?us-ascii?Q?4PsP1LpSAreiM0HFRUTxlF/N6Y+5R2qofEhgswN/pLNP18YhFWtH1o6fXSH7?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MNFFp7Hsia6G1rS2/tI0st6bpeWfz4MViRVmgkE5dX3yw+cDDiubEaoQXRsb?=
 =?us-ascii?Q?634Lu1Ye40e/ew0o6gBwtl7hhzJutwhdmjWdutQQmaFtVqQWamnZrcxiiSg8?=
 =?us-ascii?Q?nRAPKXVVD5Vzc7yMIqyezZzyXuDqIeqEwUR1jhGBGmlZ7T59q3T3cWIasDKQ?=
 =?us-ascii?Q?VRIPbOIDoKT9/iDF6giGunBN2eYeLzSW3zW3HOfUepcYQ6ZcNhKcfiiZUQnm?=
 =?us-ascii?Q?/Nh6mkFfM0H9gc2VZK1noKCGxNQndDRNQ35kX5P30C1sFuYm0OC2dYtlU3Tc?=
 =?us-ascii?Q?OnrD9LQk2ZwU5l6GjUq9Rx63yNJBagJTeYYdqYQtbjfSz1nNbLHUoMhqmRqK?=
 =?us-ascii?Q?Dt5YJ8vMwehU2XRDv73fTgt0DaEAjbTP38tv3wkb2ilzP/XFexya4dVtHTC2?=
 =?us-ascii?Q?UGc5YzfEZVWiYcPaH0BKjJ0Sl2ZuuCgLxKc4JLB/AG++MPfVpEInn0rl/wPg?=
 =?us-ascii?Q?jgUdUIrdjAffM/UMhBK0l9fwWj1QxFVDGoUCP4K8GLnyNHu5UYrfwEg8RwZl?=
 =?us-ascii?Q?w6x0gAI51z9PvAVRewfGppx197ENAVGoZC2UWNKSpZrOFnxXjN3uAV7kN7fR?=
 =?us-ascii?Q?gN+N+CrObRSdHg5OcZ+jlpABr+M+dXD4ydbOgtzQNSkOcxrSN7iidtSQj1J2?=
 =?us-ascii?Q?vng3CTFva7SsKnuN9w6yGrA5/GUWww0M/7ljp5NE2neJBH/38VAUroUDGgyH?=
 =?us-ascii?Q?Dzi6a0vVZeZdTbfEckxn6B7aDZdJRL1KWw4IKS9o/yxY0s1Clbz1kDjPF8RV?=
 =?us-ascii?Q?m3IwQbPZAOJAAI8nwksiLq/QihpQjSHjQqVk/oJiC+QxnBTFdt+7cektXkOh?=
 =?us-ascii?Q?2S1NfblGKkmwT2GkzjY1hSRkVp3YOQe9+LKgdRrMR8NXIEu07At3NQVWud/5?=
 =?us-ascii?Q?xw9SkmdUtpiMStjGFGNbn9lE4Wewbqu9ByrfdEplGKbI2uTr3rNWmumHCsmP?=
 =?us-ascii?Q?TxGEa0e+uMchYOqTMW/Z7kzS3rOV6cvOBRzuKsDRBJXvKu0il3+kIasuz3xl?=
 =?us-ascii?Q?AT0IaNs/mXsliD0fhgFb46wd1tPpfLnOFnvLYe6/rHdW9Uk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cd2df7-f464-457d-4044-08db9841daf4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 19:01:21.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IONV6Zi4as+5rI8yBCOvwygd3wIssVC4XBFK1ugNaas1HZ9j8m20aiQxH7Xpamk2Hb0iQjp04bULoWlIEZEWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7938
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_17,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080168
X-Proofpoint-GUID: JIPQvti_D3Ar0Y7shdLAXdhsnSPdcfKp
X-Proofpoint-ORIG-GUID: JIPQvti_D3Ar0Y7shdLAXdhsnSPdcfKp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--el5bneffsbguj2yk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230808 10:37]:
> * Vlastimil Babka <vbabka@suse.cz> [230808 05:53]:
> > With the percpu array we can try not doing the preallocations in maple
> > tree, and instead make sure the percpu array is prefilled, and using
> > GFP_ATOMIC in places that relied on the preallocation (in case we miss
> > or fail trylock on the array), i.e. mas_store_prealloc(). For now simply
> > add __GFP_NOFAIL there as well.
> > 
> > First I tried to change mas_node_count_gfp() to not preallocate anything
> > anywhere, but that lead to warns and panics, even though the other
> > caller mas_node_count() uses GFP_NOWAIT | __GFP_NOWARN so it has no
> > guarantees... So I changed just mas_preallocate(). I let it still to
> > truly preallocate a single node, but maybe it's not necessary?
> 
> Ah, yes.  I added a check to make sure we didn't allocate more nodes
> when using preallocations.  This check is what you are hitting when you
> don't allocate anything.  This is tracked in mas_flags by
> setting/clearing MA_STATE_PREALLOC.  Good news, that check works!

Adding the attached patch to your series prior to the below allows for
the removal of the extra preallocation.

> 
> > ---
> >  lib/maple_tree.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 7a8e7c467d7c..5a209d88c318 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -5534,7 +5534,12 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
> >  
> >  	mas_wr_store_setup(&wr_mas);
> >  	trace_ma_write(__func__, mas, 0, entry);
> > +
> > +retry:
> >  	mas_wr_store_entry(&wr_mas);
> > +	if (unlikely(mas_nomem(mas, GFP_ATOMIC | __GFP_NOFAIL)))
> > +		goto retry;
> > +
> >  	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
> >  	mas_destroy(mas);
> >  }
> > @@ -5550,9 +5555,10 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
> >  int mas_preallocate(struct ma_state *mas, gfp_t gfp)
> >  {
> >  	int ret;
> > +	int count = 1 + mas_mt_height(mas) * 3;
> >  
> > -	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
> > -	mas->mas_flags |= MA_STATE_PREALLOC;
> > +	mas_node_count_gfp(mas, 1, gfp);
> > +	kmem_cache_prefill_percpu_array(maple_node_cache, count, gfp);
> >  	if (likely(!mas_is_err(mas)))
> >  		return 0;
> >  
> > -- 
> > 2.41.0
> > 

--el5bneffsbguj2yk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-maple_tree-Remove-MA_STATE_PREALLOC.patch"
Content-Transfer-Encoding: quoted-printable

From 5f1f230ed424ec37d65a3537f03c7e6e961cc713 Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Tue, 8 Aug 2023 14:54:27 -0400
Subject: [PATCH] maple_tree: Remove MA_STATE_PREALLOC

MA_SATE_PREALLOC was added to catch any writes that try to allocate when
the maple state is being used in preallocation mode.  This can safely be
removed in favour of the percpu array of nodes.

Note that mas_expected_entries() still expects no allocations during
operation and so MA_STATE_BULK can be used in place of preallocations
for this case, which is primarily used for forking.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5a209d88c318..78796342caf0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -68,11 +68,9 @@
  * Maple state flags
  * * MA_STATE_BULK		- Bulk insert mode
  * * MA_STATE_REBALANCE		- Indicate a rebalance during bulk insert
- * * MA_STATE_PREALLOC		- Preallocated nodes, WARN_ON allocation
  */
 #define MA_STATE_BULK		1
 #define MA_STATE_REBALANCE	2
-#define MA_STATE_PREALLOC	4
=20
 #define ma_parent_ptr(x) ((struct maple_pnode *)(x))
 #define ma_mnode_ptr(x) ((struct maple_node *)(x))
@@ -1279,11 +1277,8 @@ static inline void mas_alloc_nodes(struct ma_state *=
mas, gfp_t gfp)
 		return;
=20
 	mas_set_alloc_req(mas, 0);
-	if (mas->mas_flags & MA_STATE_PREALLOC) {
-		if (allocated)
-			return;
-		WARN_ON(!allocated);
-	}
+	if (mas->mas_flags & MA_STATE_BULK)
+		return;
=20
 	if (!allocated || mas->alloc->node_count =3D=3D MAPLE_ALLOC_SLOTS) {
 		node =3D (struct maple_alloc *)mt_alloc_one(gfp);
@@ -5601,7 +5596,7 @@ void mas_destroy(struct ma_state *mas)
=20
 		mas->mas_flags &=3D ~MA_STATE_REBALANCE;
 	}
-	mas->mas_flags &=3D ~(MA_STATE_BULK|MA_STATE_PREALLOC);
+	mas->mas_flags &=3D ~MA_STATE_BULK;
=20
 	total =3D mas_allocated(mas);
 	while (total) {
@@ -5650,9 +5645,6 @@ int mas_expected_entries(struct ma_state *mas, unsign=
ed long nr_entries)
 	 * of nodes during the operation.
 	 */
=20
-	/* Optimize splitting for bulk insert in-order */
-	mas->mas_flags |=3D MA_STATE_BULK;
-
 	/*
 	 * Avoid overflow, assume a gap between each entry and a trailing null.
 	 * If this is wrong, it just means allocation can happen during
@@ -5669,8 +5661,9 @@ int mas_expected_entries(struct ma_state *mas, unsign=
ed long nr_entries)
 	/* Add working room for split (2 nodes) + new parents */
 	mas_node_count(mas, nr_nodes + 3);
=20
-	/* Detect if allocations run out */
-	mas->mas_flags |=3D MA_STATE_PREALLOC;
+	/* Optimize splitting for bulk insert in-order */
+	mas->mas_flags |=3D MA_STATE_BULK;
+
=20
 	if (!mas_is_err(mas))
 		return 0;
--=20
2.39.2


--el5bneffsbguj2yk--
