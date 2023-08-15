Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9B677C88C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjHOHaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjHOH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:29:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E708DFB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:29:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOsiS023657;
        Tue, 15 Aug 2023 07:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=p6FsxYGsyGejCg7s9U6WTFuyEH3DhYB7+UOYzZu9wK0=;
 b=ogB1toqgaXF9G+r5rbyR/se3gmufk1B95lb2RvhgQAtPgQBGJ+PrWJ541SPduu3iVo2I
 oiwKJOpXzLRYyVdxEjJPoMWCPfTryg7qC+f+WTXRNbNqt4k0C2fDuNzlHRWNIj4+AGGX
 zfqTfmfYHA0ilWEpmAiYTZowwmkY/xM1Ro3w6mrhED35109HPlCoPRf3uZrCLDfJ0GR4
 BJnKzkAKKqhIpBJTZ9QpKQRFbUZtHtmg1RHdbeMPhSqTnwB01WPPQzq3Z1K3ydoniQvh
 YfrCqbTPOvNrUT548jWW5OzERdA/zkpupupsheXEs2papK46Wf4kYZg/S0FuRQeqpktl 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5v50q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 07:29:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F6NCRG006641;
        Tue, 15 Aug 2023 07:29:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2ct8yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 07:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YunKtKQx/TnRCx0JoDYg3Yu/LVqh6BxeoZnBt+zbhjAsfj/ArNSMWjMB7DzAhhRuZQzO+fG71BslyJaqR5jtJ50E2nw73MffTIXo1wA91XdePYwPPFsXmesZRbhqDJkTTT+HHp5JvEQmJwwm68V7lOmROrQHfP3JXzABmSch5JXd8T+aPjoUdTQLVAqNa6WFPLxJS3OPp+ZobOn12s4y2x+n3dPFyElA7rm/XcGsBchy1cGYe/W7JwuCXVBHudFx9tC6O0nh9gpssCoOjKNoVLFVs2T5QuUYeR8BVJjuXlhr7d75H7FBIcIF0nIQEU/rXFn/ZXI/3tqTBb2xu07oEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6FsxYGsyGejCg7s9U6WTFuyEH3DhYB7+UOYzZu9wK0=;
 b=EzXl6GCh1m6JAI0tZ34aI6JvT02xbvfPBCAXo5eVVmH4V3a7BwrOHTP6FR3iHpkZ94AdrzXI99cC9v6JNf5GfZKr9oQKJycS5n/MjOWlsyzxM1IQ7gzgcVSPa7ODzGZn1eEk6LT7EtilOjpqND4yfdAt+JosiDzQAkxuwfQ1X2+WNv3dizCBEplpoHEMSKdFiUuH5VSR5xc9KEhFu2hxgK4hk2yAGfxSwzGJHSTeomTaugoGgUWDfQlYw182K3Sb6goDVt4h/RDRSFkvn7MPxLmRAtXf+fD+TmElLMy6nrjrVx04aTC9HUSNjuOKtZ8wYC4FISq2vnyt+2imkPurBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6FsxYGsyGejCg7s9U6WTFuyEH3DhYB7+UOYzZu9wK0=;
 b=qYqEwWYk7lhU79zAo0FMcB+h+MFAL31Q3bGYGsIXjS9XJUyaJYEeHfzuGwmnQRAX1yeRQBQxd/c8K8aKcNGjWIXNKmdSnO8NCGoWR8+erGHRAe6PMpgShIKUozf18zsUoeHtOBtJCeJavJprfJjXiqD9p95HJCWERVMTeFj69Fc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6994.namprd10.prod.outlook.com (2603:10b6:8:151::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 07:29:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 07:29:09 +0000
Date:   Tue, 15 Aug 2023 03:29:07 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/15] mm/mmap: Change vma iteration order in
 do_vmi_align_munmap()
Message-ID: <20230815072907.fsvetn4dzohgt2z5@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
 <20230724183157.3939892-16-Liam.Howlett@oracle.com>
 <CAG48ez09ELhVYZftGtcxrvUaW6pF+k9RzwFtjRs-pcRx1aUweQ@mail.gmail.com>
 <20230814191835.jzj7ryvhi6dqwruy@revolver>
 <CAG48ez2UbpFb41gfcwyoA73ado=+YEiRtU2KmKt560_M_B7JUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez2UbpFb41gfcwyoA73ado=+YEiRtU2KmKt560_M_B7JUw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::33) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 4176dd4c-0fb3-4174-b353-08db9d6150de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZmqIo/G8qbtRW7C8fWpHGzMHXQCp51YzUn7Q7j8heVtEXe2zKHp8NLwl66REZ+L8fWLobQAQZP86lGpG+11a5Gq99Y79+pCZVUJ1rUv5iSnG2H0jUevWGTfK1lZQVPtebuB3fEAxtGxtH5yyiWljgQQiW37AUw8NjL3LMBpJLox46yZqfOzv4ykbm/LqVrKhb/VFtzEXbnmvruO54nAg+hIt8VT/jYUPmR7QA57xrSFZ5+5OILCGLQJzCuzD9oDL/W1lOxIuYMs+/d668gtCzn+kkUY0aMLss2dDF0JzvkYob6UsYQEvQihj/5RwYJb+cVVGAPfgiH0VTfJd71WBS1Tb7hbD31+ypZkTHtQ2DE8FosfT2w6dtfR9+WT5RqgXuUPD296gZy+SCtQ75JT5ZjY0adGBY6VcGuLupkCSE9zU5YMxcyVOkw1bSR7DOj+qsKD6Gf/BHET/ayBiWLzR0njSvAF91+L8kqBMnxnnPFvss9tk0CQn6wnrTzEEWSP7K0vdsNo//LZ33TCvWuSY3mSEZb2NyZO3BPAVH5vp+yN5zP6rxk4rO8kKP8QXKG7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(54906003)(6486002)(478600001)(2906002)(5660300002)(86362001)(33716001)(4326008)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(1076003)(53546011)(6506007)(26005)(83380400001)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZoRllQbmtDYXBTS2Jld1pNenNuckFrVmdCQWlmVnlPWFBzeDA2VkEwTC9G?=
 =?utf-8?B?QVV3V3pSUUJncXQxMGkrTFNEcW96R1dOY0w3ZVFRZCtjVkd2RFBuUkhlTWlZ?=
 =?utf-8?B?TFcrem5oaGtxYzk4MFVEbUNPVExZT0xPOVJqN2dxc3VFN2M4K1ZwMm1zdllZ?=
 =?utf-8?B?NlRPMEZCR05sWXhyU2pZWnErbnRpdkJDUUplZFJYUG93T0thQ2FLMmt5YTlG?=
 =?utf-8?B?Z3FNZ2VQOUR5MjNyVS9hZUc3M0lPY2xjcUhrem55N2JEdjRtdS9uY2Y1cmgv?=
 =?utf-8?B?TjBHRkZwNkRZSjZsbGl5K0xDREZ1b3g2NGhtVzFTK3pFSmZJbDlLRUdPOFNz?=
 =?utf-8?B?SWY1eEFGYWZEd3JFVUgwTFRMYS93bThJOXBxWFJpVGhwT0NFZlM1VmZ6K2FY?=
 =?utf-8?B?dkVya0s1V1JpL3dPcmF0MkRpS1gzdzl1ejF3WktLV0VFSUhQeVJWUnM3V1JT?=
 =?utf-8?B?bXFreThCekUyb29TdTlnc1FTVklFVVlwSDZ6bDRtbndPRVFHRTVwWWszWS9V?=
 =?utf-8?B?OUZQUG1oUjJCSDgvRU81RFc1SE1Hak8zZDdsb3dndGhWZ3huZHRoa0srNjRq?=
 =?utf-8?B?YUhScjM2MTBOTHowS3g4clc3WU5lL0Y1bzlrVGhESFdYNFRyczZqQWdkYWVZ?=
 =?utf-8?B?L1hOOE4vK1BRZWg2SGxNSDlsc3ZtU3M1TW1PdXd0b2dvTkJQcllQRWcvcllF?=
 =?utf-8?B?My9GS21kN25mUHNTdXB1cFJlNXdpWlNMKzlrY202K2lkTW1IVHk5UmlOTzdL?=
 =?utf-8?B?N0JhQnM4UlE0akVxUjgwdjZQYzVUTGZTYjc5REtVOFlLVi84aTFrdjZiQWxL?=
 =?utf-8?B?YXk2bS94bXYyOE02SVU1ME5jRE9CbWpYdkpkQW8vbUZVZEMzeGpSK1ZWZW9a?=
 =?utf-8?B?U3d0UG1KYm1BSUtVM3B2L2ZROS9NN1ovT2ZuMkQ0SCthZW1LTXEvRHgyb3pp?=
 =?utf-8?B?ZkhGa0I4UEpSY0xIcDBScVRiSnlQektWY0NrTHhlbVVHT2FJR1g1WU9wWGw0?=
 =?utf-8?B?YmQ2Qk9leFV1STF5SWx5VEdraGNkeHNpLzR6OU5uTVBMOThFemxPTWtJWjA0?=
 =?utf-8?B?QnZaRUpQZlcwa2hMRnc1dzYvYVVHd1IxSjlEa0tsUlFIVE5yQWxheG96K1Na?=
 =?utf-8?B?MmduY1RiV1ZnY0l0SUhZMDR3d2grQ2Q5V3cwUDJRNFZkSy9xQkpPOWhzbFhQ?=
 =?utf-8?B?TW5vUGFSOWJpZm0xNTFVS002MjBwNFBwaXdhT2xOeXVVNjAvZTBFdngxWmZD?=
 =?utf-8?B?SW5yL2hpMVhkWk9VSFp0bEx0TmtvOUdkRXZQRVZURjZQUWtwbmtoazVQWndw?=
 =?utf-8?B?Zk11ZnVXYkJIYStPOUx6V2REYUg3Qml3dFZkNGxNWjUzaThJZ3ZSbHo2K3hK?=
 =?utf-8?B?SWRxZ003NkNnZHR2RGpLLzQ1ODMrczRzVElGL0t0b1Z3clNJVVJsNmxCWDJQ?=
 =?utf-8?B?QTgxb1VRMWNNcTQvVWJQNU0raEN4VzYxQTc1ZU5oSnRKS2wxUUNtbFJQRjVl?=
 =?utf-8?B?THp1bCt3OW9ZVENoTjQyL3Q0RjA4WGlyRlU5R2pob3ZqQ2UrRHl0TDNvK1VY?=
 =?utf-8?B?dFdYRUZGVWZ3dThLK25nVWRJSXpXOExLNEZtZnE1M1ZoOFppK1liN0ZQUU4z?=
 =?utf-8?B?eGJneDU5SHZkVlVzRXJPclppM0tQVWJRR05nbTlsUi90LzRVZmZRY3BNNWVh?=
 =?utf-8?B?Mityc0RzNUxHQUdUbGlPSTVzTWFDMTVOcFJkT3hvSEdTbUxSSEU2eno2azVE?=
 =?utf-8?B?TmtORnRqb0ZReFFuVTh1ck9ybzhheGM1V3pPTVdoZ0lRclJGVnJXYXNyTUpx?=
 =?utf-8?B?R3o0NUVDU1ZDR2gvNnFsK1krVGFlMkdON3M5UGlQdDdEQ2VVQ0FtcmZnTXk1?=
 =?utf-8?B?Zk9FZ0IxMU1Sb2F1NGZNQkRmVGszSnhXMENGd0ZPMC9qZDZVUUZyVlNWU1hX?=
 =?utf-8?B?WHlOTXFyejZ6NC9WZm0rclNRQTRmSzhSZVViVGZuMk5ET3lSdlFhZjhnZk53?=
 =?utf-8?B?QlRNTVNUN1JxcWhVbXpZbE5MYTl1KzBiOVV6OEtyRkIzM3c3VzcrNGR2TThD?=
 =?utf-8?B?eUwxRzIzWU14cHZlY3UzQ0tjdFJSMDVSQnBUdkU5Sy9xdlZycjNCemRWdmph?=
 =?utf-8?B?WFhESVAvSDhLVDk3L244QlpvOEJRam5RczNRUzc3dVpuVFc4TjRhSXoyNVA2?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X0rGxeCMCmMLHQLwIiMwo0kZrx816XDD1sCsFz2tuG/Dk+lfC591XFXivetJ624VrWUWD4Vxc951KjluWg6uAO04rpLzxVtQVhlhoTC5jng1sQ3XcPuf8qMM32ROOAAmXAzN2e/MeYD7Suayo8cIFUw/g+jIpWuCAG906mYx8YEmqejQaD8NDgG14kR3g0P7/8WVyA0EKM2Qu0RWcWr6PpRyl9Vcp/6obezkkqqJ7rmeCJqXrge4LHeorATfeCs+fJeaAeue8X/u5RFiFYUOwKDVlWztEBUFdg722xbVrW6aSKt7CwVixvE9u5HnWhSw8MpHQPYajEvfHz4QmCWzdTDv4J3GdqqOpuNqxtB7OOCzhg4OhFlAwRjP8Hw88kFxeHE/blERPR5fKHyC0lENZ8yz41qzThJEL6Wg3SmemNW1LjrLZq7x2NHno1DuxFQz/nT7NJJMb1nXwwvPflto1afpTym57e9xXErrG9XDe1EeAKblykSz4wT8OeR9sUviWwVscfeNf5BOOi2xBpS8N/lU4pnuxiCXLHNIAmX9w9jEjjrb/uY0YVZqDee+iOg478lfI5335D3J1xCfNCmzL3WKLFyArQKNS3dgPfjfnuF3L0mowpqSiMq7tSXFsZ7we3ZybLgp+v3zf9Nf2yUz7uCevm3lAI7ytovCtHSYH79NXYMqJ9x0IKDDDSLGTAKFwtdrHUveEP3UQ83YtjYomLWBiypdoSOfhG7NigqwIqjWMwGOp/ra1syIVyLPNV9yuU0RqYIrDeYKMJrFVcGx5s+3EP6WdcUwEAB9XD2+PgNby4J6wSmGzhP5JdLzbQMJIF30QI1UvDJL14rAn7DVc83yWXk4ejVIKQqfgsd+3vw8wSYXrLdV9aEznCO16Ong
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4176dd4c-0fb3-4174-b353-08db9d6150de
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 07:29:09.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNeeokO42p0LmnNvYi2qNB9wTPpFBiqSIej/l50jyGMIyACYn9i6/3A2Q+7jOCGRlo5jWiL9mVntHogtCgR7gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=444 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150066
X-Proofpoint-ORIG-GUID: d1KyVYoYcmYhZLRb9GF2jl0SjXUa5agT
X-Proofpoint-GUID: d1KyVYoYcmYhZLRb9GF2jl0SjXUa5agT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jann Horn <jannh@google.com> [230814 17:22]:
> On Mon, Aug 14, 2023 at 10:32=E2=80=AFPM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> > * Jann Horn <jannh@google.com> [230814 11:44]:
> > > @akpm
> > >
> > > On Mon, Jul 24, 2023 at 8:31=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > > Since prev will be set later in the function, it is better to rever=
se
> > > > the splitting direction of the start VMA (modify the new_below argu=
ment
> > > > to __split_vma).
> > >
> > > It might be a good idea to reorder "mm: always lock new vma before
> > > inserting into vma tree" before this patch.
> > >
> > > If you apply this patch without "mm: always lock new vma before
> > > inserting into vma tree", I think move_vma(), when called with a star=
t
> > > address in the middle of a VMA, will behave like this:
> > >
> > >  - vma_start_write() [lock the VMA to be moved]
> > >  - move_page_tables() [moves page table entries]
> > >  - do_vmi_munmap()
> > >    - do_vmi_align_munmap()
> > >      - __split_vma()
> > >        - creates a new VMA **covering the moved range** that is **not=
 locked**
> > >        - stores the new VMA in the VMA tree **without locking it** [1=
]
> > >      - new VMA is locked and removed again [2]
> > > [...]
> > >
> > > So after the page tables in the region have already been moved, I
> > > believe there will be a brief window (between [1] and [2]) where page
> > > faults in the region can happen again, which could probably cause new
> > > page tables and PTEs to be created in the region again in that window=
.
> > > (This can't happen in Linus' current tree because the new VMA created
> > > by __split_vma() only covers the range that is not being moved.)
> >
> > Ah, so my reversing of which VMA to keep to the first split call opens =
a
> > window where the VMA being removed is not locked.  Good catch.

Looking at this again, I think it exists in Linus' tree and my change
actually removes this window:

-               error =3D __split_vma(vmi, vma, start, 0);
+               error =3D __split_vma(vmi, vma, start, 1);
                if (error)
                        goto start_split_failed;

The last argument is "new_below", which means the new VMA will be at the
lower address.  I don't love the argument of int or the name, also the
documentation is lacking for the split function.

So, once we split at "start", vm_end =3D "start" in the new VMA while
start will be in the old VMA.  I then lock the old vma to be removed
(again) and add it to the detached maple tree.

Before my patch, we split the VMA and took the new unlocked VMA for
removal.. until I locked the new vma to be removed and add it to the
detached maple tree.  So there is a window that we write the new split
VMA into the tree prior to locking the VMA, but it is locked before
removal.

This change actually aligns the splitting with the other callers who use
the split_vma() wrapper.

> >
> > >
> > > Though I guess that's not going to lead to anything bad, since
> > > do_vmi_munmap() anyway cleans up PTEs and page tables in the region?
> > > So maybe it's not that important.
> >
> > do_vmi_munmap() will clean up PTEs from the end of the previous VMA to
> > the start of the next
>=20
> Alright, I guess no action is needed here then.

I don't see a difference between this and the race that exists after the
page fault ends and a task unmaps the area prior to the first task using
the faulted areas?

>=20
> > I don't have any objections in the ordering or see an issue resulting
> > from having it this way... Except for maybe lockdep, so maybe we should
> > change the ordering of the patch sets just to be safe?
> >
> > In fact, should we add another check somewhere to ensure we do generate
> > the warning?  Perhaps to remove_mt() to avoid the exit path hitting it?
>=20
> I'm not sure which lockdep check you mean. do_vmi_align_munmap() is
> going to lock the VMAs again before it operates on them; I guess the
> only checks that would catch this would be the page table validation
> logic or the RSS counter checks on exit?
>=20

I'm trying to add a lockdep to detect this potential window in the
future, but it won't work as you pointed out since it will be locked
before removal.  I'm not sure it's worth it since Suren added more
lockdep checks in his series.

I appreciate you really looking at these changes and thinking them
through.

Regards,
Liam
