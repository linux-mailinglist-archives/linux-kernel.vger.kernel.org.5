Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADE276D4E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjHBROT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHBRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:14:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1512D1AA;
        Wed,  2 Aug 2023 10:14:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372HAM9E015570;
        Wed, 2 Aug 2023 17:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Ls8iuvmNh2vCZBlLG/GhPPPLXZ+6BxYtRKt42iMRY28=;
 b=JgSShij8bF0F7WHCb8lsGtiJVwwe6vRhLT7qRpEWW7NM6lH5criE9r53DXaNVW0hVEb4
 0l/V/VKMF1DkzXJh/NQQRp+0x2ljWBf0IeTHVDBE1Kd21FSwL7uF7AjOzG81OO4pdGAf
 +kQ1ryoVhjsqMuytmoR+W4mgoXwlNPGXPWHnPDhxAq0GkVtu+0AvDIlGYzs4UdSMwADX
 puBF9DZ27sDNt5FxUGUJiTSESuW3VQOafcqyJwDehg2ZAcqpOWOFKIuSudRFGp8kd7Ak
 3GrvbZnm/6KEk1d32LLST3QP11Sb3vsjlFKA2hyuyxYinV2Y+FvdU+bgJXwuOelYVPci YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tctyrv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 17:13:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372GdNZ3020517;
        Wed, 2 Aug 2023 17:13:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78f4hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 17:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZx0jEw0YkV9ff3Y/I9IZ94/TIixzoDpbT46gA9RMcgeTiR67ZUsUhDiD3/qylxrqF3hEesHZBo0skrL6BLdImpO/C8ghaMxFNjvWfxk64nqhDd7N+hk05k/O/qiI+UrFL9S0HtcB/wPmqFnCwUuHw9zp2nZBHx+WtP0RbqnlTwGZh3zhm8TFbdcOAkLE5Jqdd4rFU2qdDQmxsv8E3VAUQpyCfk2qJlQtw0OJfHTbmvX0JrOqcJfCNCCwF5vbd6hvhOE/TqNJfo26eVCNU4MeLdXHmxiPlLuEeLAIC8psRMASXd0mVKG63pAKnobkUgWH3yMtbEALnI3RL5hQblFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls8iuvmNh2vCZBlLG/GhPPPLXZ+6BxYtRKt42iMRY28=;
 b=aLtdHg+9cZLDiJs38K7OxH5S3GFeoYy+lNQmAb4PcbhNvEXEVKGIOcEmRuUWRVL3aXh7znPGnx6/EgCLobmYOpSl9lIXhWVfF56AJYtmFQbMtd7EBmzy+EuT7aXzugbULToMUQZFqJWnGMkZcvCPcEdJmBT4WZjrkHX3oMmzgrkQ2VTcF0FJtTPAKM82q1EMGb4tNbIHXoBIUuLRwuXMcKqA458VokjE7R944FUcbUPvZYGK+d6zLwoou61OjUyYXnEZJTJH0TEa+mpoPZlMlgf4CbVv5QryAoQuPr8Tn8fBMaSkmQMSCvLaAo3v2zhlCqDVfLud0hSzEycyGh/PaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls8iuvmNh2vCZBlLG/GhPPPLXZ+6BxYtRKt42iMRY28=;
 b=q651bXrv1ApIv5492QnbXRF2kNN9FEIq2n/+LJ0C12jKxRxNvB0F4MIIlawmqcQ26tf1q90sCnkPLLt4pVXw2u+WmNWMVnupMghQkp4MECKMu57kTjbxBwRHg3bNQm+KgHcCYiSwz6/T+XujXafwsqy6vO3sGXraqzZ9xAB9s3I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Wed, 2 Aug
 2023 17:13:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:13:21 +0000
Date:   Wed, 2 Aug 2023 13:13:17 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2 4/6] mm: lock vma explicitly before doing
 vm_flags_reset and vm_flags_reset_once
Message-ID: <20230802171317.wccm4gfruhz4mbxh@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>
References: <20230801220733.1987762-1-surenb@google.com>
 <20230801220733.1987762-5-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801220733.1987762-5-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e53554-afa7-42df-33b4-08db937bc5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cViWjCyJOSWZ237nsVOyO6/+Fn4DT6ArEsMQzGCojn4cpib6Yei2vLK6hEZVzVKN7Dl38SL2Nmx9ebmRwdilLF2a4StBHhBTjh8ClinsTe2+EHfO9Cpa/kW0aQ/wO0WMCNXSG1WpFpR97TQoHpMGZs0QSSVdw5w5YA65XkTSZSqn9/Ffjeu0iFygz3mEBlghuwrlfByqhWVwMGNfe6jSbbUSRs2KBhf2IVW1yBQDCJI1fnt+O2JGXV/L6i6+o3r3vze9OjbiZqgaeNB5JipZ/5YB/rYU6aQP+gV+KnOPY+fB+CE+rkfPAHKgRqlpcl9wDs8bURPbG1gzlMyuHmz3D/tx5lm82H0P+J20z+QDAFMJEdKyUNq6Y5zjfLmymN1TyoTP9Uv9cE8OxxdZAo47Hmnw7CMm4jTTx4KKer0hBOnCbYZu0re9ou4emEU7PJL3yqWaYFS4iVZvY5NbD1pxTDPUVOx1gFp0On8kFJrD9NBPE1gMlg45yqhw8va2ocuEspE6j4G9yzqjSVpPR58XQnxzs/hg+8kB+DN2r/iQrT+cuN3yvkhfZNwgyc7SjKc5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(478600001)(86362001)(9686003)(6512007)(6666004)(6486002)(8676002)(8936002)(41300700001)(316002)(5660300002)(66556008)(4326008)(6916009)(66476007)(83380400001)(33716001)(7416002)(38100700002)(66946007)(26005)(1076003)(6506007)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14DNO0WpDkxVqC3CcJJsAwKwlZLF5HxzfK1dgl4bjxBOpEf7yAol1U6E7HK2?=
 =?us-ascii?Q?CSVfpi1B4CYEJMu9QWqoXE5eOpDegbl4FKiV2OkkHPlTFGXMYAYogZMbFt5A?=
 =?us-ascii?Q?qwMWt7TR9Ymw6PzGqvvm2dUo6fe7Qbittf4+qQAaoxj074uC5MtyWavBcSym?=
 =?us-ascii?Q?i/gxIhSVo6JCZn1QtmHNnemFYnbEpy1wPg7jkOrS5wYFVCZqj3J1Ick8uMdP?=
 =?us-ascii?Q?7WsShGFWPXe1mhCZWq+eKD/YvCLkF7b7m7dnokV+6vJnuKZ1hbwBODRO/GEW?=
 =?us-ascii?Q?QEm1y1OIP1B+galAyPASqGRAGpqYj2jJI7GISCFOyS9PzjWD/lWCQBoP4AqL?=
 =?us-ascii?Q?hBUeWMwXwROnB9FRgBU8U5kIyT2HGMkzTK4JKeqRC0zBeb/MnVSI15EviF9d?=
 =?us-ascii?Q?5ekroTcCpi0yEQpUlGoGSRRGj6rawn1ym2tA8JVUBbHX1Eygul7xuKIoxrk/?=
 =?us-ascii?Q?qom6tzDkFLwJ6MgWhZ36LDcwc5iz0C7vNtRzl4vE6anzVAt73kA1x0kHqx3+?=
 =?us-ascii?Q?fIyJ8gtlnCF8z0KIMnM6tA/r7uMxdIDJA4EfyIKzNTCpJJhKiNX/25KwWhZ3?=
 =?us-ascii?Q?q3saI5P6S17hIRJxRpHCPZ7s0GSP3Oj9KxY9jRhUUqRN/ImDzcOfoZnMgzS4?=
 =?us-ascii?Q?3Z+ZpniMHHTZylKp9JDG0inNTX3DkjHOrW52dqp3Y/aH5S4qlHSmYvfR8H1D?=
 =?us-ascii?Q?DfWD89vr+GHuEhw4SDuogM5JFBXJyZK+PUv8QZ7SiGLG/XueyThQD+wgX6eh?=
 =?us-ascii?Q?AmTi+dUG+kTx/ixBOqm7UyK/C3ihcIaUX2js9kdgeDNnQNKiC2pMYwW+mLJS?=
 =?us-ascii?Q?whDHoeAEj28klssFClAs3UDiIICAEgRfJR5UN0mBSc3iHyQS7iAcAcS/UuLD?=
 =?us-ascii?Q?cgaPn1K706uCV4ih2P+Hg9GfA4H/dTKjSY4PBEfRc0jf8pndvxkQzGvil3gW?=
 =?us-ascii?Q?HE/35Su7LC22OtwX4vJGgitYsLaOxgn/XUbGVvsTfnJecHlt2Un+p01L7vn6?=
 =?us-ascii?Q?A0e+CgUfGXmRkvRW94a17PdowS9AFDibNLiIR0SyRdLXBFbaOK2m4RKtM7n3?=
 =?us-ascii?Q?IZ6Fux6yc0VAsyrSAuALveHRkMonsOWggQlnC3JGK4Ic7TBoiDoxtcCylWVF?=
 =?us-ascii?Q?59+GgAmZytRuFCJ7iOnMG4K0lnbsYaICF5h/zjKlGzD09IHBPAMS8up//Pg6?=
 =?us-ascii?Q?smgFbmC9RcMxbfd/zhWmJF79lMwaOHQuDolCTl6nYroZbarwjdmbyk2vFEFU?=
 =?us-ascii?Q?vqFKRQKVuOpBJJBg24c9gwbkkAcSeP4eByncZUfef59dMJobERuynoEjktGQ?=
 =?us-ascii?Q?pvgq+qQcfAWmjSQXMF5LWwp39IFr6X/B9iM/Wf6ZnhySJPQcBgLEqjKpPS4v?=
 =?us-ascii?Q?FDwHsJjw/lSuzjgvf8T9dNio3vgCgaIbKU+6zSOv0FQYcRKMpGg6G2L9ILzL?=
 =?us-ascii?Q?C4+XC4k3xlM0kLnm5WVpHHkyGW8fM8ljA3XtThS++iUbeBHiGHszfo3ni+wb?=
 =?us-ascii?Q?GJl6cjkhbAJuucsN51RZ2bY7SMOyQcWvJwlgMmjabvJAC7gAp2xbPITheIsz?=
 =?us-ascii?Q?+MMrs4dbHLjgjJwB6XeJBL/CxC8fkOgER3iOtFKrWiMarrah8XxWejtSoNGe?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BLmsct17zT2ls7ewLn7PFzV6UHDIUWWrHLktV0mxy8I+bMxUD9TeNleZwcrc?=
 =?us-ascii?Q?B/upfJBFW1iLQb5ausv8Ajb7OjZXnNj6/Tz+E8AVNL9iBArXDlZvb7zxRv1t?=
 =?us-ascii?Q?cYIdre+B//LIR3tPyzgm+tA+eAarZ4tu2xJ98yiwGYT8otbfoIrT4e56+WwL?=
 =?us-ascii?Q?RlhtBEz1uoCKlD78nEnNtIBU6KGLSfV2GWYgeZykzpnqZkRJ/WYrYA+zhe7C?=
 =?us-ascii?Q?hTrS5sVTrXrS0jaVsKnGRFtFtGQkBLHO//CxAYeFaoNDy1AeUgs3SRQXpAXD?=
 =?us-ascii?Q?QvIeR1h7zoyp0URw9QbiTwrhC3QcxCFvCRoQJc44fp2EpnYfMF57wgCY9Hrt?=
 =?us-ascii?Q?FPATVZfH9X+on+NRU9nArKNhmRO5e7G0vvRlR8KKk9eA6K7ejsoAnKVds13z?=
 =?us-ascii?Q?DIouLEKjm554taKnfcVQGHD8JJYyloSLI4BN1S/qPT/8WG50s9Cv2Cvl1Hit?=
 =?us-ascii?Q?Ked68D5+qWjt/KhVPxtXpJ8w3Y1TDhkmrK8QWLezv8+Zrnue0ErvE5mvvFzU?=
 =?us-ascii?Q?OHgMqks5aPhgYkwwihF33SKrUWjNY7fKMT9iJC/1eoTjwDOW24QW4YHrRdkp?=
 =?us-ascii?Q?bNo1jF4wFBaeAKTwV2dTrW+/es5+ilC33AyuS10Xl4ng4JbKK1TD//jIl1nX?=
 =?us-ascii?Q?CklOFJQBYznvb5CVu/RMI0b6OXg78b0vFRFPgK5J/ymB5WFv7xawHGfoWJYh?=
 =?us-ascii?Q?ndGGkfUo+j/pwybrkfgRVYloux7xvBpG057pS5iJ6eiXZcNuFZxZR4Iiork+?=
 =?us-ascii?Q?oA0WALMfnSWP+rj0m1RytxD41gFDthvmeJA/r0cVWkXKNf3NeANWKQomEZom?=
 =?us-ascii?Q?kq6w4pppmirIBI2oYGWrMHtuTSV6HRihKZy3roAoi8nxIeQGCEpIEqPCxNpu?=
 =?us-ascii?Q?gnpMqTki5wxJcSJfBvq94GdvAkqVSczwNXekvrvtWtV3yKTM2Cct4woQmb3y?=
 =?us-ascii?Q?6KD6ROqEGL0Q4F77jNLiT2ceSu57usOdUD3EXi/5l0dzP745/9tliMswjHNd?=
 =?us-ascii?Q?vw/gYH5Gp1PLxfChsmXlI8zi2IkpzHyPg2zVgKZVqeDLmFvzbWHIzlt+9M/k?=
 =?us-ascii?Q?Nrsrc0Hy4t0MpgQk0kcx96HBqm9YLKve1/5psqw4L1vH6OIpLiFy1BTys7pw?=
 =?us-ascii?Q?kMaOiQsQEqHqCLLKIQJDuoGaxRPXGxUsLGmyD4orznRIjnXZGbf09rI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e53554-afa7-42df-33b4-08db937bc5ca
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:13:21.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/YlYrqK0I0z1/5d6PiNuJAPXKazR3pBqR9HWQlI0MC/eqzFKAOcQjvpmNAucXg8DZSnppuElkxBUx9XTpW+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_13,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020153
X-Proofpoint-GUID: AMxavrIlO5sea5LUjk53makuCTJdTaIt
X-Proofpoint-ORIG-GUID: AMxavrIlO5sea5LUjk53makuCTJdTaIt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [230801 18:07]:
> Implicit vma locking inside vm_flags_reset() and vm_flags_reset_once() is
> not obvious and makes it hard to understand where vma locking is happening.
> Also in some cases (like in dup_userfaultfd()) vma should be locked earlier
> than vma_flags modification. To make locking more visible, change these
> functions to assert that the vma write lock is taken and explicitly lock
> the vma beforehand. Fix userfaultfd functions which should lock the vma
> earlier.
> 
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c    |  1 +
>  drivers/infiniband/hw/hfi1/file_ops.c |  1 +
>  fs/userfaultfd.c                      |  6 ++++++
>  include/linux/mm.h                    | 10 +++++++---
>  mm/madvise.c                          |  5 ++---
>  mm/mlock.c                            |  3 ++-
>  mm/mprotect.c                         |  1 +
>  7 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 709ebd578394..e2d6f9327f77 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -410,6 +410,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
>  			ret = H_STATE;
>  			break;
>  		}
> +		vma_start_write(vma);
>  		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
>  		vm_flags = vma->vm_flags;
>  		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
> index a5ab22cedd41..5920bfc1e1c5 100644
> --- a/drivers/infiniband/hw/hfi1/file_ops.c
> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> @@ -344,6 +344,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
>  		goto done;
>  	}
>  
> +	vma_start_write(vma);
>  	/*
>  	 * vm_pgoff is used as a buffer selector cookie.  Always mmap from
>  	 * the beginning.
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 7cecd49e078b..6cde95533dcd 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -667,6 +667,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
>  		mmap_write_lock(mm);
>  		for_each_vma(vmi, vma) {
>  			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
> +				vma_start_write(vma);
>  				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
>  				userfaultfd_set_vm_flags(vma,
>  							 vma->vm_flags & ~__VM_UFFD_FLAGS);
> @@ -702,6 +703,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
>  
>  	octx = vma->vm_userfaultfd_ctx.ctx;
>  	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
> +		vma_start_write(vma);
>  		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
>  		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
>  		return 0;
> @@ -783,6 +785,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
>  		atomic_inc(&ctx->mmap_changing);
>  	} else {
>  		/* Drop uffd context if remap feature not enabled */
> +		vma_start_write(vma);
>  		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
>  		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
>  	}
> @@ -940,6 +943,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>  			prev = vma;
>  		}
>  
> +		vma_start_write(vma);
>  		userfaultfd_set_vm_flags(vma, new_flags);
>  		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
>  	}
> @@ -1502,6 +1506,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  		 * the next vma was merged into the current one and
>  		 * the current one has not been updated yet.
>  		 */
> +		vma_start_write(vma);
>  		userfaultfd_set_vm_flags(vma, new_flags);
>  		vma->vm_userfaultfd_ctx.ctx = ctx;
>  
> @@ -1685,6 +1690,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>  		 * the next vma was merged into the current one and
>  		 * the current one has not been updated yet.
>  		 */
> +		vma_start_write(vma);
>  		userfaultfd_set_vm_flags(vma, new_flags);
>  		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 262b5f44101d..2c720c9bb1ae 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -780,18 +780,22 @@ static inline void vm_flags_init(struct vm_area_struct *vma,
>  	ACCESS_PRIVATE(vma, __vm_flags) = flags;
>  }
>  
> -/* Use when VMA is part of the VMA tree and modifications need coordination */
> +/*
> + * Use when VMA is part of the VMA tree and modifications need coordination
> + * Note: vm_flags_reset and vm_flags_reset_once do not lock the vma and
> + * it should be locked explicitly beforehand.
> + */
>  static inline void vm_flags_reset(struct vm_area_struct *vma,
>  				  vm_flags_t flags)
>  {
> -	vma_start_write(vma);
> +	vma_assert_write_locked(vma);
>  	vm_flags_init(vma, flags);
>  }
>  
>  static inline void vm_flags_reset_once(struct vm_area_struct *vma,
>  				       vm_flags_t flags)
>  {
> -	vma_start_write(vma);
> +	vma_assert_write_locked(vma);
>  	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
>  }
>  
> diff --git a/mm/madvise.c b/mm/madvise.c
> index bfe0e06427bd..507b1d299fec 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -173,9 +173,8 @@ static int madvise_update_vma(struct vm_area_struct *vma,
>  	}
>  
>  success:
> -	/*
> -	 * vm_flags is protected by the mmap_lock held in write mode.
> -	 */
> +	/* vm_flags is protected by the mmap_lock held in write mode. */
> +	vma_start_write(vma);
>  	vm_flags_reset(vma, new_flags);
>  	if (!vma->vm_file || vma_is_anon_shmem(vma)) {
>  		error = replace_anon_vma_name(vma, anon_name);
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 479e09d0994c..06bdfab83b58 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -387,6 +387,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
>  	 */
>  	if (newflags & VM_LOCKED)
>  		newflags |= VM_IO;
> +	vma_start_write(vma);
>  	vm_flags_reset_once(vma, newflags);
>  
>  	lru_add_drain();
> @@ -461,9 +462,9 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * It's okay if try_to_unmap_one unmaps a page just after we
>  	 * set VM_LOCKED, populate_vma_page_range will bring it back.
>  	 */
> -
>  	if ((newflags & VM_LOCKED) && (oldflags & VM_LOCKED)) {
>  		/* No work to do, and mlocking twice would be wrong */
> +		vma_start_write(vma);
>  		vm_flags_reset(vma, newflags);
>  	} else {
>  		mlock_vma_pages_range(vma, start, end, newflags);
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 3aef1340533a..362e190a8f81 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -657,6 +657,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	 * vm_flags and vm_page_prot are protected by the mmap_lock
>  	 * held in write mode.
>  	 */
> +	vma_start_write(vma);
>  	vm_flags_reset(vma, newflags);
>  	if (vma_wants_manual_pte_write_upgrade(vma))
>  		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
> -- 
> 2.41.0.585.gd2178a4bd4-goog
> 
