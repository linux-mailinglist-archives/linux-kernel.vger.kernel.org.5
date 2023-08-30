Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928EF78E150
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbjH3VSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbjH3VSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:18:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F37E0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:18:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInWYr032351;
        Wed, 30 Aug 2023 18:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=f4OnxoLyqQLXegBCEBZgTprHs3FXRbEDL24PiKFwl6s=;
 b=RK56wnOu0QkZnqxXtEboZftEvj3JUv080fonk/+0gHTOOvTw7L/cMPx+AFJN6AdHcBil
 iZBWRJCt+1lJsvtm28C45xjyNhvEl6hGU//2VRSr6OP1IhkX+ZVQ5tW5p12nX4Yr60H1
 WgWtAUU/om0pqn6uxoYD7qX799j0yA3SFCE31QntrW78sY1uo0kaEPvNNjRuvmjONUGv
 Mz9qX28sHojw6zHK9T+2wOem8eYsPufN+ZlyiGupl2ReB0/qNaggRaYBIInEYygBXGFZ
 4ChqchpSHEuzwdaaNZT2bK4y0z+uH08VZPiciLbUReSjJt8CJCLzlGw+kY/pZ0N0kEE8 Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k686be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UH8ZkU024310;
        Wed, 30 Aug 2023 18:50:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dpxdpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8Xs569DfhBMDWIx4oYi2tvNYohrKLluzf5YBgQD6Zd8pZUJ4U7EbXLEo6Ujq8BMseL4it+qNQgluUOamBna3zsD8lMVsoXKJy5EosExOf+FT8OtFjRCcN6ut/ZdFzgua4bkDCd3suFnjhLGFjlOC95xOC7oJnqNqqELBNDnWugsVk7d/ZtrTmDAUKvk283UWPjpXcg9VKn+k0nhm+jGv97NWX0Dijn+93Wl3Y1sXIyuGPPIkpFSxguHkH+91pbFva0JrWdjmYDaBia8YKMyMkLuaJFVL9V0uOt90x67qrpAhkYdDoezUjB/N2CQ/79EBVvCXLJ3jCiKsnB1iAsoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4OnxoLyqQLXegBCEBZgTprHs3FXRbEDL24PiKFwl6s=;
 b=HCG0LwtYtWklSbdIm7GxY7e7b274OOIDlZXuNk4GeZUENMy6He0A6SsGl0ho3XwxmlzL3ms5Z64+2OFGW3fZv/lP36RqCUPj3Yb9AiSDUv5GodhlG+3BYXqc1rMzoYtn7yUTXJoGy2Z+hCDClp07Txc6JPJqHDmOutAQTY1uMLa6incS7PdMUmyQ+QJiNk3/7pW3lcoP4cvnT5hjHOiC2cDiwowRtTTBgwwaIop+A19F/EntWrXPQDoS7TQLl/1y5boJvH4KAEgMv/p9q07/ln4ode2baN0QtsohEweK2yDY0VtiiGqx0e4hh69+3AwdCjGqIytA/QFywzmxIcabqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4OnxoLyqQLXegBCEBZgTprHs3FXRbEDL24PiKFwl6s=;
 b=mQSij2sFzFH8OF49dSJHo/HEyZWcj9i4r/H3CJfmd/InDcvKDv+E6araT8qKmOdpxGzrtCYWwc0DGqidrLrU+E/UZGtmXq4JrKRUoAzSmUwwDm1Ha8ycoOzYV3uOdTF38l65K71DzU9CAgUKfiLkQetx89ytqmLwJS/ZPzNChFI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:50:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:50:16 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 5/9] x86/clear_page: add clear_pages()
Date:   Wed, 30 Aug 2023 11:49:54 -0700
Message-Id: <20230830184958.2333078-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:303:8e::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 15522295-d22b-44f4-8411-08dba989f376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USGohVyEfoXKqZ7N8gal4AAUWfEUluDAJW0m8qk38KHSH2bKnMBTZnyx0oq60UU8QRtun2Jj9c/YCc8I9Cu1kIgIZkcZ/X2YXNGHZpSYybk1C9EXxyu2qXXZ11wIQ/ZKEJvwR1DcR7Ed3CdM4/Lh67ckdA6XG5HraPBZdeUAP493zzB4kdZ/OIIakf9YNFLNFGcVxrLGQL/OO79lh5qPlaQdHmjt5LjosZEhR9QDDRP3t7UoqIrFcI5qR11HvVYfoCzPqM2ccxODnAAr+Z3SBDP6IabOqJ7AkFpI/LqVnUJ7qVr4Njiiksl08/ssdV8qoIeQwwITDZz7VA6eSsariHcRKasfi7ZUvtMpRNK/D8qDro5IfKjwxAj4o7ZfUlS14E+OH3YvA/jMnen96e0eRb5Q/1Vq3JRIfoDrrByeCioAW6OFAz92mKIbxZIzKs+M1OyWXLvqd5hdRxdY2ZQljrhsLqvficZFlv7DgtO5j6OaMbtCt1wv0lAUs/Z8/Bpy1YfRoFvXX2/w0QvI+su5lkkxrP43uxBYpO+ZdEFs+HatxJUjnHknpoOnQKstbAYS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(1076003)(36756003)(66946007)(41300700001)(6512007)(83380400001)(2616005)(107886003)(66476007)(66556008)(6486002)(6506007)(316002)(6666004)(7416002)(5660300002)(4326008)(8676002)(103116003)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uTu5kpS8sz1hUDLsjANxDWQSDL1AHRQ/Lrwzo6DdSKtBV2JVi7ynx7DVfukC?=
 =?us-ascii?Q?haK4TFII3bjIYSQrcXYQPrejm+V2jLNbLg7hezF8EM+ireVXAB/lN78nveP/?=
 =?us-ascii?Q?9Iqof+6cPPxxQLQqaKXggdkhjorhd6mdcCc39SRH9KeN9/XTHX7B2voVUHL2?=
 =?us-ascii?Q?3H+W69vvRkLCWLHCIGLyi+QglzK4e0EJ7yRrBnPc/nVLOZwbNxFUtZ+3UyXY?=
 =?us-ascii?Q?aOq9hpLfvyJfNsT/aQLcnXl8XB/xo4r6x0wD4i7+JfAllEqVmtBa4Aws019O?=
 =?us-ascii?Q?ahdxw4Vp6jY6AtxY9cNC2LQ4euekRezAQtskAssCfDgQde4rew1QVdtRqY1k?=
 =?us-ascii?Q?xdPkRdJY18SYV+Lkd4sfkO57CrB42356TCZmnLw4sk9Q0BUIlZr1O73J5B1L?=
 =?us-ascii?Q?ISRhixMcNzueELnx9/fFIxj7Ty1wll6BcqZlK0Xp3jA5hR06d3WLJ4wTHX3z?=
 =?us-ascii?Q?JOsrRzmvJGVP5o0cqA+ad2DbWyGfo1MWReO0VKYPiiPewyYOFkM3UxJX4OIc?=
 =?us-ascii?Q?FjhMwPGoKGzygp98Yuq77TP6KCkZA1T1Ezldm40W9NnjDwgqzn7P/cHB+cOO?=
 =?us-ascii?Q?EI19U6C62YfkUhFlOIxvO5x2NLxLpVaz/tkQQC703wBCJ9DymIQ7RD7ep4lC?=
 =?us-ascii?Q?6Vt3/MjfZBfs2NUpoSKLZZaLO9778aPkrmn/9pPmcY+89RK6o/7Y3bpNFv8N?=
 =?us-ascii?Q?OTcl2FAyssEj3Ub0qADaGuPKh+oCUmvE5i8u5fuhVWpwFr6tQbhUDx/MLMFJ?=
 =?us-ascii?Q?Ka6aV0qPKuuZoj30chO7q5nW6pcu9/OYkrVmkI1rP+C4EAC8QBPGYBUJgrg2?=
 =?us-ascii?Q?okLTZz3QYvK7DHb53NgB9LTsV4HcyFqhCWh34bFtnoGUGD8PpvKIPmJeTPlq?=
 =?us-ascii?Q?EMmQ6KCyg7EDGAo6gmSBnkpU+V3ajqqvHW9ku0ilQNW4bJr94NfrWm0f5HBu?=
 =?us-ascii?Q?OYz0FC34/rbv85R0RzS9kVcdvBxd5Sqb5sDAEZKxiGxWvuSqxjEmOrsk4koz?=
 =?us-ascii?Q?TwpYfZCqU7TE3UtshBDAPUOWJ7Y9ZVIKH1yHkuvq+k/90yvfiY05yHS0DrlU?=
 =?us-ascii?Q?jAoY2a7FGN7azisGjGowW7dICnAixq4EL4qvikqQYNDyekAAPXpVfAH8jPBw?=
 =?us-ascii?Q?9zAS0Q/G+Bl4i9PvYDx8jfxoFN38XM3hNGg8LFU2HLULZlP6aBh86Ch96GNQ?=
 =?us-ascii?Q?YR8mTXxAGRmZJ+Qg7Optu4V8wK0MWejXw+L/SyaCyz4UcQGsGmbr4kqnA4Ru?=
 =?us-ascii?Q?3FrR7/SqeqaCK/+Bu9mJHDgiHkPRPfa5snuobhjzZF46DkAbtlWNyIsaOjUO?=
 =?us-ascii?Q?9jQtPb1ZSI1AwiYgV/0v40BTaa7vVvU7jXue8PS0JFO5f1ct6qc5tutJcLGD?=
 =?us-ascii?Q?dfE2/mx8RYG2uNCyOlKKWC2Lnv2IzD8wLNjRLS25sXrVYNME6QKUBtK2mfHh?=
 =?us-ascii?Q?xIEKRmrQ8hVsqKTaaRoA5xCfZiEcEVXYZo//yYg6/gzQyQYiPMscbCM/lrhI?=
 =?us-ascii?Q?TtmED4v0ly3ayu5jHHHf75BQotSPFggOMl96QSxUYxVpXgUPiXR/REOSxFl9?=
 =?us-ascii?Q?z0U/kIW1vOJz/LLnTGkzTbc5gQwFmhOVUYJNSGeU8godSggM301DFivu6BTy?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ehboCqBSLkxqnQy+q3oarupS1pkV6soB3y/SxDVSzvuyROsGoRfahO6VDGmz?=
 =?us-ascii?Q?8k8r8ISv6b7rIiU/zMq28uZ+5MmrHhMt40LeC3wlU0tfTVWea9bi3f12qVuh?=
 =?us-ascii?Q?EXYqNq11Gox/txzKgIw4+M6lo0X6VJ+4SFmLfoP5elSy/ka+cFwdEo7uhKVG?=
 =?us-ascii?Q?Y4Vr1frvd6ZAGUL2o7ZRJDnrPrpnitT6AmobFDhy6NCAei/o8Tsf6qrrEODF?=
 =?us-ascii?Q?2Jv2duQAjeWjb5qtXMeEUUAqjVONB0LtWW8hJ+evr7qZo5a1gESuCYUeMpX9?=
 =?us-ascii?Q?NXINmN3HrUYNhhA8uaeSsGHA1lppA1E+Q7LKTVqvYgAHwgelshFzhISdncwd?=
 =?us-ascii?Q?tKsbixVeiKfzBVp1ZXy0qn2SilIKUoLI1Lwd14n5FU0O/Bx6aa3j1lSU1YBk?=
 =?us-ascii?Q?1Wfr++z6j/yiEnfbTYsPkfspgm3mb5i44nsBITV23AeD12xyk1vsOXUmeAGA?=
 =?us-ascii?Q?rjuEct9+/899gMAynCPnkUyfZUOesWqUpfFIlyhefH4F7iq9lC2MxCRX2bTq?=
 =?us-ascii?Q?lI4D2/EtZ5PPqewcNGZOGaEbb5it2cLpMurR1oSG/TnF+zDopTvt3/MHsD4s?=
 =?us-ascii?Q?Lf8xFqUeLA/Pod3EXdmZ33zNeVWH3oR0sibjKR2bx2eXmVcU1oAKCEKyjYpg?=
 =?us-ascii?Q?sqZmx7IO1NK6/rKOTglF+KsldIrchm5XX6W3GLAVKxTSkqBPKyfCTuImbjI9?=
 =?us-ascii?Q?CdmUlH9pLf/gfjl9nBF7rNo6FWKSxj0BZ35+3V+ct+H+KrgRTP/SuI3CPOG+?=
 =?us-ascii?Q?FbdBtmHpXqM+7oLYETKKSNIDM9FTRby5MJbFTR6sFPN4dF5lofK4OHzS79ll?=
 =?us-ascii?Q?S6bkUSCHfFq6+IRMSdhIBMmvjI3zZh77usblK3w4UOcFRPtkXrTXqPFnAw1O?=
 =?us-ascii?Q?u8RnuE9D7LBowhf/8rK0x2HZb4o+IfWZh43a7GQD+KWFGpeui99CbLUaoe90?=
 =?us-ascii?Q?5Ae4L9aPdIzlo3c6VMVgbgPjDmvRD9OvBiP435+p0eH5k9Iak/roCu8S+DJe?=
 =?us-ascii?Q?zkbMiJIPR4XOFTvb9eqx7+TbhxfjetmB/6xfChP7TVWHISZiAGra7kfmQuby?=
 =?us-ascii?Q?+Ec5MBwGV8+dHFWBoig6PTDtBWfiLQK8Ony3t3HHKvke7dTYtpYxtLK6vGUh?=
 =?us-ascii?Q?ckd/xNsODEFc1C30La2eTNmCRJ72kVl3pDq8vwT76/0+auhaxA6XuVo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15522295-d22b-44f4-8411-08dba989f376
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:50:16.6142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+i1tj9py8sU1bIso13RywBga3n8zHMg0IzyhH9xiDd2k4p1kidQEMFLFUn2Ox/b8NMg7z6xak7NeVxboIogunw420RRDm5kKUiOY+2dVmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300170
X-Proofpoint-GUID: HYKnwjGXzyMIkziu8CDz8UyInc4rrSH5
X-Proofpoint-ORIG-GUID: HYKnwjGXzyMIkziu8CDz8UyInc4rrSH5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose multi-page clearing via clear_pages().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/page_64.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 56f9adf0e892..1e71570ea987 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -43,9 +43,9 @@ void clear_pages_orig(void *page, unsigned int length);
 void clear_pages_rep(void *page, unsigned int length);
 void clear_pages_erms(void *page, unsigned int length);
 
-static inline void clear_page(void *page)
+static inline void clear_pages(void *page, unsigned int nsubpages)
 {
-	unsigned int length = PAGE_SIZE;
+	unsigned int length = nsubpages * PAGE_SIZE;
 	/*
 	 * Clean up KMSAN metadata for the pages being cleared. The assembly call
 	 * below clobbers @page, so we perform unpoisoning before it.
@@ -60,6 +60,11 @@ static inline void clear_page(void *page)
 			   : "cc", "memory", "rax", "rcx");
 }
 
+static inline void clear_page(void *page)
+{
+	clear_pages(page, 1);
+}
+
 void copy_page(void *to, void *from);
 
 #ifdef CONFIG_X86_5LEVEL
-- 
2.31.1

