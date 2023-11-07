Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E217E4B67
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbjKGWDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbjKGWDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275010E7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:33 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJjiN005490;
        Tue, 7 Nov 2023 21:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=BRrX2dYuc/prXhp7fcx3fQvnR9baltRD3epzo2LIORw=;
 b=Nm3CUDkqwTu+EpA1oPmfc5WXJvzwS/suCLC+Uj1op8U+vhdLQCqg3wLLwCbOaFG5dda7
 E5HH0+FqFVp1dgzbx/gT8tpGHSdRbt5fl/ZbAu0nTOt9HFUYWfNf3jEBT4uht1cE1uVe
 LoWKVV2T4NFZtjbP/vyiIT85k4nBNnUUiFxiKNSyajQRL5f5MU2wLFAdcH7Xzg1OvagL
 +TQ6h8BvBLpXawQ11ucMhZvStT/HTJKNgHXFfHPHrNk+ehd/d2dQrFZlPB7WIP0PZQOC
 RzmFYKd6GTVedodLNwsu/4eTGONd6CzDyWQ7gD5K55Rozu1EmglFORH1CFjHfjhGblB6 kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIt9Q003973;
        Tue, 7 Nov 2023 21:59:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsjqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgySwZRCOjqZMlQN3bWspUSRwWFzIZLAJWirq3LVJj2U/fw3OjqY+OO5y0D+lJz7zgeeKdgeKADRBhmp7m68S4NE3TOEAG83CGYCbcAYOvLChGnPCi76MXOOJekqvT/DedF4h+lUeSH0Zmm/ydm6j6nQ8IrdIwsjq7/XCsE5qN5GC3ytZEnp9VUWMdRkP9MnUGHcmdYGCJOHGRwQMPOmRKs+qX8s8qrliPHkudyP5gphA4Eh/BIdFnCugFgz+haz/IIum29BY/lO8fCCc6iBSQLD5aErINiflKjnsfT2pd1Uaa+RlzZ9XkuUQA6iF5srTfyCYIGbBqiPqmGxu/1lnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRrX2dYuc/prXhp7fcx3fQvnR9baltRD3epzo2LIORw=;
 b=Ep3X0SmXT39huIWz5vvog9aW1rpaxxy6OmGTeMS4uA+kL39tfDINt1/9fQCS3ZQo690V0V7tjuORz2vZZjCv1aI/8MrEU9Fbi74KXmB1JG7xQ1QDZY5GChAxt8uDvtjiiSmPoZFSkDhRaOJwK8SvgXUW7uJylnEPjgR/VdZF5Y3PrBgMpXecmxm9E1kL4r5Xie+7NMgUid6202rDwP36HCSC9nfN01YQIOt8vlHwz8/Lk7aV+5M+jGe5WgU2YFSad63ll0IqvSyYZl/AL1gjpDjvNqj/RMgLgXxVP7ieUqpC78Zaq9OYPkuqsrfI7QJ+dFvVql9SgtqMentOJsU86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRrX2dYuc/prXhp7fcx3fQvnR9baltRD3epzo2LIORw=;
 b=pUoY77pMZdLLLOnoYitJ3kkpqpl2J4bX51HiGpp/aUidH3viTn1lGezmnXVAeLiLe3z/vY3c1QIgoBKIyGTPEzvIu6O42VFKWHnTuO1pgcb9Tn9o8t/kaMCRpIVK6WYPtepiZ6BzK6RLF/uFzB11MXRGn1FEDzm2rb0K9prkzPw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:25 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 33/86] entry/kvm: handle TIF_NEED_RESCHED_LAZY
Date:   Tue,  7 Nov 2023 13:57:19 -0800
Message-Id: <20231107215742.363031-34-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0358.namprd04.prod.outlook.com
 (2603:10b6:303:8a::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5e03d1-507c-4ff4-4b3a-08dbdfdcce92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SbOaHlW3bXazlqZO5KgRFT26tVQyLgX4/uLPOWxL5zNMjE23eVLa3CGKs2V0TKYbjFVAOyXBZUi3liRWH98OnljZytVTTQ8DWStxGrn0KNRszSeoKxPU9x1efiLEeokhO2H4qZjJVLMLONKCn0/v0WPdeQux5XhaJMnX/3FAhAsab62ZxBT5jGR/KbsvrkXvCcjks5batbzMMfU4Vn+0b30cfNUdaztWZ6bQgmzmY9FMbDAw1d9BdG5uIchkW0EoSdt8j4H2t4BUn4FZeBdL1d25PV786TA43glVNBgpTK3/KNQiP6KEa6wmhQg+tq+EGJ3ghwvr78bAL08L7hYjIbf/bQsu2sYkh099okicZWOTilcInI+FA97gfcGI6nlMPJiq538be5tZHFehFGyEEFJLwLr1bx7xSlA4MYAkoh+2lhQ2xptoWRmkVBlwWA7kniwVQsT/nnEyAfYWyp0Qlu7fn//MKEDQL+O73Q5mNnyD649FGkPcsH9iAIJABkTCm+ZLam6/lCGK+0AW0CPTIhVopZeRcf+Fhyn4XYVZCUrAnMQyigP3+eTWgvAGtKsk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udbg9GDDPx14YM1VKbCYCfPj5nyscNc+sks3ITVvdWzwHYkCC47ZMB2TWWyl?=
 =?us-ascii?Q?SyjmY8h05K89IzRkWfo1EyW7CFiSHlPLauGahkaeq+9rPEFhy3mKd8+xbTrl?=
 =?us-ascii?Q?lj1rc2verMlCQsxEKkafZPO0u5U6ZoZtFeZ5wnflGz83KkNV/xeet8+8U3c1?=
 =?us-ascii?Q?5huY5I69zk6qX8z0geKB6wlpGg5cFQyIzMY14UB5KkOk2238/yCcpoKuoA3B?=
 =?us-ascii?Q?o9NLOmyWQZGZlGLyHSkpZ4+SMAsgFaw7uCCXjUOmlahu8ActvYDPwa74s8VX?=
 =?us-ascii?Q?HcHnw2LbooSCKss3MHgZe1eKx2Ezdwi8tkED0NuJu7U8owwZEaMANOJqLbVs?=
 =?us-ascii?Q?GyGeY60dLTwAR/Vjj/8RI82RLV1T3wbYSW+oRsgj1sUtiglGwY0VE+ciZVC8?=
 =?us-ascii?Q?lgM/lCSbJQshoLIm3QipDoISll43gyMd9rys5hVk9n0MneNgT/hnPEgOwTbz?=
 =?us-ascii?Q?RHLnZ2Xz96VD2EGqrgh/stEhWhBxeLOjL5YcktyosOPOB9JAkUor/KwbHiHX?=
 =?us-ascii?Q?jkF/tIzQ0/W/7+moUhtyxtoHqAXySGugjgXQwP6U3d3zwY3jbzDpZq30AiD0?=
 =?us-ascii?Q?opbgt/VVs2VOYFG/TqI/KnbIALX2noK9IrNFtoLhoAHk64g3LiAkDP7Wml9u?=
 =?us-ascii?Q?QjOCEcYWGVcTOVd/X6fvH2HJ8ovnSV1QMLy2kzAmAvbnN4EkPpqDWkbH+bHP?=
 =?us-ascii?Q?iq2FRMNRJEt03Lw2T3TI806QP2lW4uiVFLBrw6QpFROtpMfwumx8r2ucOHSU?=
 =?us-ascii?Q?PJ8xN7uGiAGmgj9hNaSP4rbBO7gdB5+QPjqsSR1nxFjj+IfIKmoV7hahjOGT?=
 =?us-ascii?Q?FHN80ual3unDEmK3sV0Nz7vvauB2Ug9rqgEkESrDu1DAPYarBXwN0MSPmjIi?=
 =?us-ascii?Q?LbpBO1VIn9NIlY75DDtrqszBcTTONLjQ1ZVyVklpI+A8vuQsmQGVKLFC8rZP?=
 =?us-ascii?Q?PwaIjMoIbL5yguZFlqd4nl3zW2we4PtFnEUW+Mekycbvn7Aq5rni5vkPiOVI?=
 =?us-ascii?Q?ZGiH//FCQ/d9/m/d+rXwZiC4eqw2cXHiM8ru9cXZRUvrlJ/QnZWi0I9n5Xlh?=
 =?us-ascii?Q?qr0YaWwABUXUmsQdqB7X70oGX9x+tMmrtFkwpIGCzmh7pSBQjNgmhiohC2Md?=
 =?us-ascii?Q?tHoeXG9LVuWq5KOPCKb9zY7jBiwunrGNt8zXSkjnsglqD6VZ/S4c5XntifCR?=
 =?us-ascii?Q?xrIgdST9GKvbArfSh1VLlOhDefTFfWI2yCGFIlaNTDdClO9AAzNKPyVRnlQJ?=
 =?us-ascii?Q?fFILOU8NiqIDRiiH1Iu2xTagUOjGRDprZOFULkue0oAtbY327us7/xjLYqdn?=
 =?us-ascii?Q?T9CkaHN4+tfjoVWfRhMwEq4ZFVdRhCTC+euNBWWAKRLzp6FK8VjGC1VJhIZA?=
 =?us-ascii?Q?67/5HESxVnwq3zMJTxkM3Bnsdz+/XZKOSCKobNzI3nZctym9U6NCFMu4ePt6?=
 =?us-ascii?Q?ZVV5YWADgNKMor8XEeZdsi0Og0XKPykaSdjrLjEANKlffvc1DX/GXouAw9lN?=
 =?us-ascii?Q?gbVrjUcvF/hYgHdEdjhH7LCXrFvKpZTBYgmGyUu4d91RnCPA0S6cNDDUHyCa?=
 =?us-ascii?Q?/uUGX9WI7b2CwxXRNMLFcBPDZKa6xICj/eSC1xob6xGzxnrwLQmWSuypI9k1?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Baa8sOWp/qDOdKYoJ4aaMq9lUdCjjszLYBerfBqwvxWjsBerWOG87dbMHI7J?=
 =?us-ascii?Q?6YYLg1YesnFj9S3Cb7gwnKXDufZrniSIbeYMMt9QvqOVior0qsWz3U+F8JyM?=
 =?us-ascii?Q?x0kgWMjlCNBOZcDzJbk/XvflvbS9CgT1uXwqTovB9HFqzp+FsTJSg0pM7Csu?=
 =?us-ascii?Q?UehQZmv+BGRnifQR6URK/PyjzCePKCBXyAH3pgUmK11LlAo2QCMgZyaJGbSv?=
 =?us-ascii?Q?bkuOdFQcvkJamnT9Y54P2lrKQ0E6DnRT0YQI96idEKsayaXnNHrfe9a60ilG?=
 =?us-ascii?Q?R7rqPZEBEX83sXvFNkBIr1QxI106OvijMD0W96qGJQHlEFSR5NyGsnhUHitp?=
 =?us-ascii?Q?IjIRnN/R5kfrUAART3UH/VezcsF6sbOIvxse24WlvAj8N7UEjaXVh+4pkKht?=
 =?us-ascii?Q?3bVLNwXrMJmRex8v9qo8x6v0twXiIVBvWmZlyI+26uxrFnc3Q+YKw4qFNQNf?=
 =?us-ascii?Q?+h5hUFBdOG/VP4dMMVWvAfDnuyfkfbRhgPN/Hb5FHnuUsC1WbK3jkrKoivis?=
 =?us-ascii?Q?poMhuCVxY+lxpQLEBSvVY8tGI2m68dCoOqyXCAAjBQQy/qz0jz4lTvp9K8H4?=
 =?us-ascii?Q?gt4tw29Ef9Z/DbENdXjxa7HDIf+F7ZmRUoo8KmcfEqSZfNlxf9hEj4LhPpuE?=
 =?us-ascii?Q?CdLAoMeGNcaEGWEI/pnscVKFl4Mvjqe1Lfgmn0ciIOq/TEjXPwT5QFZJMoxC?=
 =?us-ascii?Q?ebkfg/YyB/Meq0+YPVEw/VxBHozdueWmCKIkqky0VHPej6cLxiAwy6Kuy4s/?=
 =?us-ascii?Q?C6kj/LC3uhUBZeAeQ32xVuehVuESF++Qr3LtsV8xPDhF3sRpOIE9ylB//J6N?=
 =?us-ascii?Q?SeFsfMHa08oWBTgjuHCHJb/UWjOLVt2M6s9cbq827+hjf//LN96RtilSfd1M?=
 =?us-ascii?Q?m+mPP2GYlvnu1mLrWEKCjQjrsssZX7jltbfcxsXdlL2aqSPD5yPJL19EiqT2?=
 =?us-ascii?Q?OztXuU268JqXuB/6kd4vdjnvrjdJ/nLU1H+B0l3QKULLdkYIo4FB5FNR1d5R?=
 =?us-ascii?Q?J73AZEh3lS2gSTr6oqi0VA5qhwdj5C9YHpUQ9ECOXoh9yhEG6WMJw4mulKtB?=
 =?us-ascii?Q?N3se7+8peUvpPjyWFEqU3plGoJXRelZXUWvIBmq3Fej+XApSQLi7CjxJWs27?=
 =?us-ascii?Q?mLegpsThsfWLW7WWUmNJn2YS92fAKGA6rnB1LXVkP53/4pDsXepKVTxhhaPR?=
 =?us-ascii?Q?dq+KCEcOKKvuLGozqazd0oWpd1whx7VtVKhnyZAma2UuOlUGPQoMqTr5ee2Y?=
 =?us-ascii?Q?s/NJrSClydF7wxe7vq+uZx7JF1s4r9RBUhBmOfWTCs+WgZI2540aw1d/A9XE?=
 =?us-ascii?Q?V5n9RrSoiWOKN3qMvXdfpQre6iBKW4LtwKugTt51LquIziLirBRA3egloXLd?=
 =?us-ascii?Q?ykOiIAX4AFehMRR8t0CR6kw9iL59ZIPsr5Z3NuFYmnYbAiqVmIvs7UCDvfFu?=
 =?us-ascii?Q?AG7ldnjsaEIoV3Q/JwlQPoDJC8owyRp1EpN5uhSOoKXfts6snWHaEjSpDHUm?=
 =?us-ascii?Q?NaNqqJVdr4ss8OwMHI+ThGap8g1PbObczyQLGTNlqeQvihHgQMJtFgkOkQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5e03d1-507c-4ff4-4b3a-08dbdfdcce92
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:25.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GU/w1Byy4BTjU99GQQoJx2r8jfAVHXpKo0DI16pfh1GOgvEPN2AlpVxfp5DHbgAYwdFLhR5Ocl6JaAdnzrlDRFzh+8bavRErvoQi2/3mENs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=685 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: 8LIYsEx4CFEbCZXTJGr-E7wjx8Sw9P-L
X-Proofpoint-ORIG-GUID: 8LIYsEx4CFEbCZXTJGr-E7wjx8Sw9P-L
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Executing in xfer_to_guest_mode_work() we are free of kernel
entanglements that cannot span preemption.

So, handle TIF_NEED_RESCHED_LAZY alongside TIF_NEED_RESCHED.

Also, while we at it, remove the explicit check for need_resched()
in the exit condition as that is already covered in the loop
condition.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/entry-kvm.h | 2 +-
 kernel/entry/kvm.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 6813171afccb..674a622c91be 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -18,7 +18,7 @@
 
 #define XFER_TO_GUEST_MODE_WORK						\
 	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+	 _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED_LAZY | ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 2e0f75bcb7fd..8485f63863af 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return -EINTR;
 		}
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
@@ -24,7 +24,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return ret;
 
 		ti_work = read_thread_flags();
-	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
+	} while (ti_work & XFER_TO_GUEST_MODE_WORK);
 	return 0;
 }
 
-- 
2.31.1

