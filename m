Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EDF76A1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjGaUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGaUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:31:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B9F1BD7;
        Mon, 31 Jul 2023 13:31:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKIDQ7029586;
        Mon, 31 Jul 2023 20:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2023-03-30; bh=0+9QMi9k6S3RTomrvrmxknDVw6+PRzCkqawTlCvvSLk=;
 b=CKdQq1k0QEXDLkHlEBJfJe4pU1iz2CVuOLxMTXEQUVUJG2mFw4Qk8jH/Vao7x3QAlD2i
 0L0UGw1RU245PC2kc46Cl4KbfnL5iqJ9vECGFPyQpY6e6UxZ56AbNmA67CqWiQhnwNVp
 W5Y0/+AGxpYFQT/snp+Zk4DQugYaaS2FV5h8971DQe3kamIQ4tHRswqGJMd/NMdTM34b
 7z/5+Iz7NE59ncYY9BmjFxMN6e7Fc5RRXbABNsVkcnN6/WWFKi25o3uAo+6/eXhDTM6M
 V00LyIPucvcGNsRP7sw/MbCawrUxksaCgwGvS8rFoChQEfVRbTGOPkyw/1OJNQFpNwOf Hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd3j4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 20:30:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VJNU5H038121;
        Mon, 31 Jul 2023 20:30:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bp818-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 20:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SECpAGvcChPuJ0QpOXKe+MjLVQfermGqJVLxyMBmtRTOAMkJPqD3GGC4mF768V5txhJAqNS+7jtR9fy2AZ6eFhbQ3LE7vTCS7O7/WltUv2X2zTmM/SfFp710LgkvISnzAQmzXyuoYmUUMAOhcjlLfqmiKXU7VrnybYHmRudj1M/3qHp4G9+/SYYPVsZXMxhvZ+tprvYUnHtT2jbksXaGPk1Iyp85R+OsaoH+0Ohd2Q5fVFfaCK0Lgv2dWAKB0fH38qK1Jz5FisVgFau/a+32+5eANebPur55JC10B0f9ZQs1hQKUFlOFfg9AOB8JPP49v+Z7jN5cU8ddqR11P4/oNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+9QMi9k6S3RTomrvrmxknDVw6+PRzCkqawTlCvvSLk=;
 b=kYNKbiEIWl3XZCMdHNmvIT6nsQJuh9Oisfb5QCiWHk737/mooprGWjporD1X73tRKXpMlqV9uTxuCGVzccZXXk5dJYbAYCQRzFmASeOUY5hGAiUKscFCIbpNnD3FsWudGOhWS6gUnwgCf3Wnr7Y0F0Q+NFC6ksVuCxg6z+27fZh4RoS74tB0TRCMcud9lslODiWB7EFY2WbNNlzH+t5jA2Dl1bpZoTcKZpvj1kwnZ/HEsur8wHhw5bFP41Ie3FB7jnnF8Ek5G69X9nzz6GS7bxH+P+x+0hP9/BPQVph+kcC+u9Gr3+/ok3WqfVJaxpgi9G8rRoS1klnMh07ryVq1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+9QMi9k6S3RTomrvrmxknDVw6+PRzCkqawTlCvvSLk=;
 b=h9/P5u12hBqwOSqGxM8Vgil6qHNM4X9SLD4FqIPYeb8MYqqayeq2t1iSZiuX4oQ5YaP55a8chG11A6/Tqv7A6OaWy0B5D4FNDmWuTYhkBNiUDrTefDL6YDoaKDrRLdr/m5lk9k0xJ/14gapjN4EIve4fMH20+aA6kAfk5JX8Xxo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5671.namprd10.prod.outlook.com (2603:10b6:a03:3ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 20:30:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 20:30:36 +0000
Date:   Mon, 31 Jul 2023 16:30:32 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        jannh@google.com, willy@infradead.org, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH 6/6] mm: move vma locking out of vma_prepare
Message-ID: <20230731203032.z66gjqv5p4y662zo@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731171233.1098105-7-surenb@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BL0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:2d::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: c298882c-62aa-4738-b506-08db9204ff0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZpOkqdc0aSLOiG8BwkDH12OHKW04XAVOl+uVlym2PpnujZdKqqTJy16/q/oza/2sIS8YYjpWiB1ICcPsPV+ziiGziODiys9JmLyOJjyxz/74grZvShlUCyHC7K27ElFYImTLXMsbMx03OBzXH+R1gF1+1xivIxCNCdbSjyj/VIYnycvKhFpDOnJ0AvbR7FPvzusJJcJ650m/aGIhKLW6kGJxOuihw31G+u4/baFZAqiRWNqLnzkW5WljT2kXlHBQLknzYtrChHg/VKz1R3tUEpeqeb4NvdsMbf/5evZ/68fBM2m80ZshPqkCG37gp6B3T1k1QMJpwCDKn/t9W7YcZLhx27Zad04eNNkAeDLdfJIhKcPbrFaN93MIDbzIMUeSRtxLSqH03Eez2W1d0wIgvCHsLAjXiqXhqFcuJNivWcWVlxFmEURFX6DWiWNsRSpF5kgwfh3oJCKf+jGfl5yg+MlOh2lATgmtRPVL2616g+gBfHzmB7WGe4bAA+yT/xlNKY9i2v4n5SF2u5ZpoJnl2DTDwO2MOoBGOVgglVDVVgGQBUzcrm/Y07xiVD+vSB0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(86362001)(316002)(2906002)(8936002)(8676002)(41300700001)(7416002)(5660300002)(33716001)(6486002)(6666004)(478600001)(1076003)(6506007)(26005)(186003)(54906003)(9686003)(83380400001)(66556008)(66946007)(6512007)(38100700002)(66476007)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F18djFVC4Fcf2byyo1YWfTU8e5fQdyez8BHqV80wZ+k18c8STk9DDI0Jghyb?=
 =?us-ascii?Q?88/L/4brnMvKEDJLeIIQX1VL9u0HiH/1/mw0U1zVOL+00Dvbg4OWh0VJBuGc?=
 =?us-ascii?Q?Zd8VvEHeiWMrBvJAgLRvPWa2nLJJZFuCyyQQFYlGNserEicFkLgPc0YhYlp5?=
 =?us-ascii?Q?PpUJ+DDJsZagpgg3boDnk6WLzRer9vcIvml1LMOEQCFsd/7gbVR8mb2yJXyy?=
 =?us-ascii?Q?xEozOi2X57giLyEU+rT/x9i2JgEq49VX34H8BGOgijybLVXwxTVn8URhsLwN?=
 =?us-ascii?Q?q/vEK4rLc8eU38DrEex901ar6bvB+TQV/7nXCrrD6O8CZmpFTnVOCtyJRNn8?=
 =?us-ascii?Q?S8nGfoewLLGRi6VKO+EbQjRutQiqAeKeR4KhnufCN05AZY5GcUOFDbPfsXfM?=
 =?us-ascii?Q?JsNzYeien2+ShO+RmzMx7eZ9mZOjMv5QX4Y58n59EWTk/6f6+bjnJn0OeFLU?=
 =?us-ascii?Q?BUs+rzkr/2pfaFOEf6Tu/kiy+WRC8AEU2mAaxQs17tG2DAxg1w3m40WnXZpx?=
 =?us-ascii?Q?7VCb973j1M9NFTB+w3JuBB4jUC+Dxrk4nHUgp5xgB6oEvwtaB76USn1rVO9W?=
 =?us-ascii?Q?yoo0MrjP8DLN940wUIsqmtf5fVHdpPGOkx6GEXlxRVLD/RHK6Mvjrhq9vcSF?=
 =?us-ascii?Q?8jp1uioPkag83uouIg9Mv0no9sWmhFCRUs7fJiGRYDN7C0SIA3voDf/rYy5Q?=
 =?us-ascii?Q?u8ytKF0eAd/i2TFkbIZK7noaqsHtSGJ8WmWugQhpRpUv1f0FzuRodY64izib?=
 =?us-ascii?Q?FBccc5MnpJxtELW+Od/iYqYANIKvC7YP7rJqFelrsY//Sn/pwQg3N2FJKqen?=
 =?us-ascii?Q?viTXJltXWGDCx57Nrs91QZHXULss56grXsWTkh+CV6JSGk25AV1T90s+IMkI?=
 =?us-ascii?Q?8XDXRhHS+DSfT8zpQ+4eNC99iPj/M1KFwte6rjbhvJViujYm59IPq/SdJiVS?=
 =?us-ascii?Q?rrJmhshMSr2VpqEeJu6qDxyoSg72F0ubo0UwZASEsifyy9P6igsp1Swc8KqB?=
 =?us-ascii?Q?G/L+sEwHvGnrdTM8kucsuMyQ6HS7lizqLSP7b5FhNuPZ8esWhtEcVWvVBPy5?=
 =?us-ascii?Q?WYFuOUaQnx34LHguB3F8i7Oggl3MVug96b9ttV9zxEKgxSospVILmTQbykWO?=
 =?us-ascii?Q?t/pNgRchFBcFRURMHQJ0Eu5QbtnV2nX49ZAYcnsTEaaPn4Psp1DVfKSlDq/6?=
 =?us-ascii?Q?FEjyxdhdK0vmAGlHn67dg6jII0+KP9YL2Yu6xxxkxH+9afm7zSpyRsmgSGyl?=
 =?us-ascii?Q?AHJTeXEb0ky2qAuNcg6npi30zrJb8ZBV9qjLhkkiYi/BKAl+GD+/N5Wv87lM?=
 =?us-ascii?Q?sxCXAHrUfG6WKt549qZ1fQJTg/MUTCFz8Dk4zuE5dF4FQVZEQHES/bTuaftr?=
 =?us-ascii?Q?gl3VYbxQetWu0aVT30IpVSe2/sY14DripkL0TbVSBcAe+ZvHkkWmed1QPFD2?=
 =?us-ascii?Q?BdtMicbpPSy0KGj1dCmOxzCa3y2u/8RuRY9Hqn4a66nPK2Ykd7nbNIhCSCFP?=
 =?us-ascii?Q?0RTG0ZatoYyOF64INCUQ0v3vhD9KuR20yAPo8LlszZkJ6yb00iD3dz5ga495?=
 =?us-ascii?Q?bYuBszWAilB51H2IOUDs3c7RoInT6xV+IcET7mHr+dynNS9io67QAHsnY48H?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5ppwYt6UQl2e/qHl1zGl6wUJ9p5M93Xp6LjeRB5wYpN4xdw2BSg8EMcKrOCD?=
 =?us-ascii?Q?fNSXz2KI3R2tLa1zix3sk6bmoJbuA9Q/kF0gkkW35x1K+EfNNY26IRzW4IAf?=
 =?us-ascii?Q?ivOLrGmyow2F7UHnBQIU+LOOY2vGG/pmgjj3neIU3qWZw70ZFJNj115+EQeE?=
 =?us-ascii?Q?HiHAOyhzrzD9z4vB88pcSXVe8UXoZ9C77NSJuO1P24TxvwZXPYt4z+V44ATe?=
 =?us-ascii?Q?YOpuyosKGgSv3A204yz7igMKV8kbuVHby+GZbaALDqIwg04KeVi9kM13CCZJ?=
 =?us-ascii?Q?mP93ioJh1V0ZJabnTxekd9eXabQ7XlCxN7ITxEMcnGXUsZ4dhfMRImvJB1bK?=
 =?us-ascii?Q?ZJHzZfLDKbvMLHQAvupeyrNp+Gzi2DJU8p844wYAjljzO+H14Tm0K86q3d4o?=
 =?us-ascii?Q?Yc7GOYVaaypEPl+zd7GxHyjSujmadqTxF0ay8nT+ChlsiFrqNz7eQsT8QPXZ?=
 =?us-ascii?Q?AB7tLx5ed3VWxeddXpdyvIqaLVbiWlYXnVuv4IZahC7zyGuItFmNbqneweQG?=
 =?us-ascii?Q?7zhvw7JhgH7eWij92VE5+8ENqqT7SZ1JT0aR7AT61jxVhZFkmYSh0gPXguUj?=
 =?us-ascii?Q?x6dRYuwP/oJ2nsS0/PgER8nq8qspCTDa+bRvcoZrMQLMbkYyn4OWnvuidV6+?=
 =?us-ascii?Q?OW4IctQ71gpbwgoaq13rusB4ouP47hS4OxwApmG4Wf0o5Ld8y+RqGXXYYfkk?=
 =?us-ascii?Q?UpJ09Oxus7H+1coifPPCAd/4Vmsp0ZGJHELtBtlepn6WXjDQrE3OdQiaeLFI?=
 =?us-ascii?Q?A/h6+37orZdiTu6/1RC6Aq/esfdH2Q9yzFXKj1kbt5B71/lvhIhYvwkYFVvb?=
 =?us-ascii?Q?Lo3MKfIKwGkJI+fEI61DLhIWdn9TviLDnqKJlVsRnXDDsadinKH7zREY7XQC?=
 =?us-ascii?Q?wSERq8aezNc1jpOkf+ZcTr0AqFYE5Rxr7DzCnwfqtXd8CHFg1xvIVcIiGjJ1?=
 =?us-ascii?Q?nGx4gZx7MUtTSShpUBqxXIEzys0UL+a6aIg8qTR4/KC3P4LV9/mNoGJpC+vB?=
 =?us-ascii?Q?qED13HCsZnotKm4MOG+Sro7FAY1xbeAA4uBbrB0AhoVilnk35a4yOuwNDIT6?=
 =?us-ascii?Q?H8XGIxM4PO9fIHhx2f8lS1QN1c916+WR27IPmlQRMRrEsMCPKNebHdcrdGyt?=
 =?us-ascii?Q?wB/SXQeG/d3jVsyjRPwEDkA0FGuYRyiW417zBkW68f21oGKF9xJavnjZJ8/r?=
 =?us-ascii?Q?Y66t3HeoDHqGXkqyc7VOzYCTODr78WRGvo9/PA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c298882c-62aa-4738-b506-08db9204ff0f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 20:30:36.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lsf72idXgzqiiYQOJ53ydfib2dcR2o2A8Nizrje+rn5EMUYIM6SMwCbA/jVk3RoDEEefIjzq+CxcjYB9EfqW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_14,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=590 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310186
X-Proofpoint-GUID: 1Vtg_nZs8z0eNskU3jruW2NY03KUyCFX
X-Proofpoint-ORIG-GUID: 1Vtg_nZs8z0eNskU3jruW2NY03KUyCFX
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Lorenzo since this also touches vma_merge() again..

* Suren Baghdasaryan <surenb@google.com> [230731 13:12]:
> vma_prepare() is currently the central place where vmas are being locked
> before vma_complete() applies changes to them. While this is convenient,
> it also obscures vma locking and makes it hard to follow the locking rules.
> Move vma locking out of vma_prepare() and take vma locks explicitly at the
> locations where vmas are being modified.

I get the idea of locking closer to the edits, but vma_merge() is very
hard to follow.  It was worse when it was two functions and much larger,
but adding this into vma_merge() is difficult to validate.

We still set vma = <another vma> in places, so that adds to the
difficulty of ensuring the end result is all VMAs that will be
modified/removed have been locked...and the 'locking rules' are also
obscured.

It's also annoying that this doesn't fully allow you to follow the
locking anyways.  dup_anon_vma() still locks internally, with good
reason, but it's still not clear that the VMA is locked when looking at
this.

That being said, I did go through each case and it looks like it locks
the correct VMA(s) to me.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> 
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 850a39dee075..e59d83cb1d7a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -476,16 +476,6 @@ static inline void init_vma_prep(struct vma_prepare *vp,
>   */
>  static inline void vma_prepare(struct vma_prepare *vp)
>  {
> -	vma_start_write(vp->vma);
> -	if (vp->adj_next)
> -		vma_start_write(vp->adj_next);
> -	if (vp->insert)
> -		vma_start_write(vp->insert);
> -	if (vp->remove)
> -		vma_start_write(vp->remove);
> -	if (vp->remove2)
> -		vma_start_write(vp->remove2);
> -
>  	if (vp->file) {
>  		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
>  
> @@ -650,6 +640,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	bool remove_next = false;
>  	struct vma_prepare vp;
>  
> +	vma_start_write(vma);
>  	if (next && (vma != next) && (end == next->vm_end)) {
>  		int ret;
>  
> @@ -657,6 +648,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		ret = dup_anon_vma(vma, next);
>  		if (ret)
>  			return ret;
> +		vma_start_write(next);
>  	}
>  
>  	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
> @@ -708,6 +700,8 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (vma_iter_prealloc(vmi))
>  		return -ENOMEM;
>  
> +	vma_start_write(vma);
> +
>  	init_vma_prep(&vp, vma);
>  	vma_prepare(&vp);
>  	vma_adjust_trans_huge(vma, start, end, 0);
> @@ -946,10 +940,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	/* Can we merge both the predecessor and the successor? */
>  	if (merge_prev && merge_next &&
>  	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
> +		vma_start_write(next);
>  		remove = next;				/* case 1 */
>  		vma_end = next->vm_end;
>  		err = dup_anon_vma(prev, next);
>  		if (curr) {				/* case 6 */
> +			vma_start_write(curr);
>  			remove = curr;
>  			remove2 = next;
>  			if (!next->anon_vma)
> @@ -958,6 +954,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	} else if (merge_prev) {			/* case 2 */
>  		if (curr) {
>  			err = dup_anon_vma(prev, curr);
> +			vma_start_write(curr);
>  			if (end == curr->vm_end) {	/* case 7 */
>  				remove = curr;
>  			} else {			/* case 5 */
> @@ -969,6 +966,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		res = next;
>  		if (prev && addr < prev->vm_end) {	/* case 4 */
>  			vma_end = addr;
> +			vma_start_write(next);
>  			adjust = next;
>  			adj_start = -(prev->vm_end - addr);
>  			err = dup_anon_vma(next, prev);
> @@ -983,6 +981,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  			vma_pgoff = next->vm_pgoff - pglen;
>  			if (curr) {			/* case 8 */
>  				vma_pgoff = curr->vm_pgoff;
> +				vma_start_write(curr);
>  				remove = curr;
>  				err = dup_anon_vma(next, curr);
>  			}
> @@ -996,6 +995,8 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (vma_iter_prealloc(vmi))
>  		return NULL;
>  
> +	vma_start_write(vma);
> +
>  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
>  	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
>  		   vp.anon_vma != adjust->anon_vma);
> @@ -2373,6 +2374,9 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (new->vm_ops && new->vm_ops->open)
>  		new->vm_ops->open(new);
>  
> +	vma_start_write(vma);
> +	vma_start_write(new);
> +
>  	init_vma_prep(&vp, vma);
>  	vp.insert = new;
>  	vma_prepare(&vp);
> @@ -3078,6 +3082,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (vma_iter_prealloc(vmi))
>  			goto unacct_fail;
>  
> +		vma_start_write(vma);
> +
>  		init_vma_prep(&vp, vma);
>  		vma_prepare(&vp);
>  		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 
