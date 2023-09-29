Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE897B3A11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjI2Sb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjI2SbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:31:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DAA1A5;
        Fri, 29 Sep 2023 11:31:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TIJHTF008665;
        Fri, 29 Sep 2023 18:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=EIZ7sdQCBGkQhiWKIP/GTzDDyb7apb1qxOjwco3eXYw=;
 b=O3M36PrlJx2dbFP00G/auCZYAGN3pk42nTrRqykDhyG8Ubj9KVxaZExFwpWPfbzB31E4
 D0QzLJ9uGh5ijLz0Ekg33LfQBk4Db/jphH0cjqQtQVbe3ejSOHFzxBbPL9dxAl5eu2Ix
 ed0eiIktGnRaiD3wOYDwwcx5o2t2TcX5nPfwV+VwsNE1+wFR7vxowfoxxt1ubmabohc6
 VCJkRDSHrrcFVBQwZ2sGTGmDytUB3IFFxuYHqTjffj9fSIDGg/tiJi+MGMUjz9qX10WU
 GueCY8AeSei9K5qYlPKRY4tPMGNGaF/PHmaFW8mcdFbCl4G91DQtuB5rIpKZuoLSNLmB TQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peef7w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 18:30:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TIAbWv014718;
        Fri, 29 Sep 2023 18:30:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfc7f51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 18:30:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL7p3mxMEomepMwIEcfAsZsNBRyFnnb2C7pLOdgS0ByyoTgZ6XbkYEersqxl3OSZyEQ19WHVz0npiKQH2EyvsMgBlNK3/vwL5a6+zyGS/J41YIgcfE0I3TT1TTPe3L4oeet54kqQvNDFPq8kl3i88VHd0lnQzmADv2rr981kEMp6vH7m+qK147Nlww5624mQAyrd8fyCWokDiI7xvDICiTDNkkahICm6xKwikNUtYFEe353ufPXkc66HTC5V6MIpltJB1lg+ghJRKwg2/RODUBEYWY4B8T6ue0kBrhoJRYrvEPsGFNdY4VcWUl4b94NQXl/tFQoinOGBqZmrSagQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIZ7sdQCBGkQhiWKIP/GTzDDyb7apb1qxOjwco3eXYw=;
 b=NpEQOyvHoJrUNKLBtEsHpEAAh/7/2xoLCCGfzQQwgAH7r19SeKYcqI3f+KTxj/x0ueo11lC6HOYPKwadRHEKs/x+OMAnt//cxOP/kbtiJh8Mqd6kBxdvToNkxCokkkDckvkj2SD4I4GFTZGHb4rIgvxGfMCKis5fqojCBhEpx6jLkumJmZ2A2SXfRWJnTV+2eILOLN4Jo9ivA3VBTouceW7ilRF35SRbUtsRcRA+6HVTzvmTnx5EXvBvGYG2ov3vnZS8nKHZbN7LWzrAq6UhxyKlBAYx8eFSP6GvehzG9SHOIKxCe0lGWyPHDWJ1MtAVHMRQSLdg7rM8vI1IV0s/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIZ7sdQCBGkQhiWKIP/GTzDDyb7apb1qxOjwco3eXYw=;
 b=Nwcw2H+qylchfJiKysR0dGngn8J+7CHSNxcbnNHgM7546Tx0v1/GwzYKkeFcaj/FO1e6IU2dPDfmsnb8sW+sY0V+pZmilPmN9TFhKhHl8pDJ5Ru3WGZrb+enGqIMNEVo4J+Mq2wtfA80D+McEZC0oPreYbXGHbag/EWJCeYzh7g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB7482.namprd10.prod.outlook.com (2603:10b6:610:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Fri, 29 Sep
 2023 18:30:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 18:30:50 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v3 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Date:   Fri, 29 Sep 2023 14:30:39 -0400
Message-Id: <20230929183041.2835469-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0005.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6eb506-6251-4d7c-ef45-08dbc11a343c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZCNZ96h6VlBuC/KEY8679tumGpTa7z7Zy5QHwPdbEYpwLfG1SUiBgOMgz6nJshWG0tH70/KV5lctXTbn/EUXHj7d+CkA3hAEsUlxq0crQMFptMcqnF7Nb7e9mrUaVlU/NgnZoF1YFR/bqcP0fXzJ44CSoMFw7TQIZ5y7SBuqviIYyB1WNWXvoIwemj8XE41WOiLSSVdfFxQtNdOEXImCgWKtgzoMHSSy2RKIGkPCO4IKIFFDphY++JKy3xcRIRg8un93BZ0yXNdQqfWvvTbI+ES9qsgqsZcB1XclYhTb0o7JqD2/hzH76imL5K4FNieEji3pDvixiscjqQI/HVfoyhyY9VTE2NBKmrT6thmZ325nGACRCLbcd5Rx4hqWuiMUSIFNqKavJDXuo9dmhX9H7gy9RU0Uo5Z+4q+5n5jhQUHT0wwZJquP9HuYJD1ljzXevkIJzYfsuNiLcb9bdZXjH80Kw/iUhTs6y6UtzZoUcPzjQNleNS5GFhABXnCYeBggtD0Ns5WUnOMDkPWlpanCk2fYB+c0bPjOEyfV5+DtdeBwyeVqt29l6kcV6V+ynhv+UEeNvRKVFdxAlm6SyNsbhzhMe/gSGmFMums60HZkcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(54906003)(316002)(6916009)(66946007)(8676002)(4326008)(8936002)(66476007)(66556008)(5660300002)(83380400001)(6666004)(966005)(478600001)(6506007)(26005)(6512007)(1076003)(2616005)(38100700002)(86362001)(36756003)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dvg0Fdf6I8yeM7DTVCpuxcqCFPcB1FgrmITrf8enQsWpe9aJo8dmiTmJ3cRp?=
 =?us-ascii?Q?l0Z4V89cKsAIRjPaMABlOhP5d0a5XB25wYvvBZ0JcNyxE/y1uJL5YFTj8STe?=
 =?us-ascii?Q?GFcPYjWvulko9Y+lYycNNWEyhWInzrd9Pj8i4r9XAodp6IEIvR58G3myJmOm?=
 =?us-ascii?Q?+LtlsVlqoPjgIXov5Cp0oLvq0OMZAkou0bgdRsh3LNZym4+XpKgjbpIgEI4p?=
 =?us-ascii?Q?ARnv7I8nzecOCiEtCRlXAVJEClefcmL8fBNGf1Oe4nb9A1f7QUN0B/GTA51Q?=
 =?us-ascii?Q?zbUtmgbgpe5V3G1hThfuTGaRN0Z8WTwmfN6sUisgeGDNvLBMn+7s5pcATrhk?=
 =?us-ascii?Q?+mJW0RDl6Ly65TqBbWKKhVtZQDXXgt1eKvcLKKmKjZgqyee7QbgAqJtbyJCm?=
 =?us-ascii?Q?BlWFlsjfE0BaJdfR9UhWEmKTIzinuZ+xX78rPAQ9xKzOVPUGqcMj2PDiKsgS?=
 =?us-ascii?Q?7GmMwEKF0TgRAoI/Uj4RS28dS0XSgV8Vy+Z2DF/NWoG4o+WBku0eNYKlxmOl?=
 =?us-ascii?Q?ZEuIl2qwJRXDJTBrAKwsCrguVgg/LExtFL/wDc9TBMqBchJqPdr6i+8vYCO3?=
 =?us-ascii?Q?Al5dXe2Eyk/V8bWuTq8pjbjfCoSzJADFYb+fQtsvWdG+SC+eUyitnq8dBrmk?=
 =?us-ascii?Q?qGhtV0PSyYph5tPhrY+TNR5Beqlp9Tz0eu9nGkL1SEFdCSAwIXlkIV8reC29?=
 =?us-ascii?Q?twfwaHIkCpzM11ObUxZajLy8fJwPTmts4ciyRNYuJFDAydwsIi6+oaDCoRGU?=
 =?us-ascii?Q?FExq09BQaFA65scLC1yUMWY91eihhZym7MANZ8OVRMKUZAuoHpVdg9zP2LOg?=
 =?us-ascii?Q?oRucJXgQVCepwgH4sfuLCXOnCe5D3YRN1aQnz/97+97VXoVjfblftS2JdgR8?=
 =?us-ascii?Q?WqakpTL8Alw/xXST3jI8duqpRpp1dWdbqP0X+0pHLkAksTifeLdIKDeVDYa7?=
 =?us-ascii?Q?XudeXG0UGlc70y41fbH9WQ/JVDDu3D5Lys1yAM35DZvQ+gQGD7tigeA2ykjI?=
 =?us-ascii?Q?UaAN+XuSVXo0a5S7Y40W5ogzAY80VWdYPULihQoEfnOd1SkgKeLvu4hDUVsy?=
 =?us-ascii?Q?XQPd1ZnYNPKuoakV2qUrKlQciJZi+MpNQKoTGXPOm7lrOSSLts2HDWHHnPSk?=
 =?us-ascii?Q?Rg/y4IZQWX1hLr+lrDSl5zK93QUUcjEOvx5AeWNUmvMmiS13Hq4zJcDniRPI?=
 =?us-ascii?Q?0zJjKPpxCbc9idhwg8MmObSWe5DYKYhd39iIWCg+s57lFGNQK+sGHyE7GWue?=
 =?us-ascii?Q?7YVWb3oUKBGWEWZLca3u31bGdDENf1zskhWlGVllSp3NmLgYv78V4g+4hVkV?=
 =?us-ascii?Q?6/AFD9TjfxgXTn0LA7y4VkRducLoKf26itODHd1l2jYIamfQTRMZ0WYrkVFw?=
 =?us-ascii?Q?LS7coGwalKhS2TxfuKjEWDHN7WkcKldlVr0cwvKqDmjDAyns8WUXKH/GlQRO?=
 =?us-ascii?Q?1AM35Na8PB3oKs2oABd7bhuKGmct1ApgqzY2hoKaHJXLLEpbdTx8UrfEU0R/?=
 =?us-ascii?Q?54PFipGLwEqFIrn/IFOoymmRnzByClGcMsngMtuOxetk0g0mZcTe+N/IlpdJ?=
 =?us-ascii?Q?7e81zxFIJeGeke/8Mg4LJupHcFxeSeYjrxqgzd1d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bPVgEZT8cYWiZGmEYdedrCqVS6FkoreHbalcYzu+TBvCXjMte8jkTdUTJ67W?=
 =?us-ascii?Q?NkD3+TLT7lv/rndZqUq6OO08ZFwLFTep1txwGRmehspONJdMqlgZ4UE1T9gy?=
 =?us-ascii?Q?zlEhWtkQmYuMIuJkz9MOnhTmVQ2nMJIffPCzX1I5BJd/8s56J6aTRpcaa89Q?=
 =?us-ascii?Q?T/77zhfMS5YV90CAb7eKmFGKOAQGdGKft8dHSBZvaqRgu5kUW9viCkujwufE?=
 =?us-ascii?Q?o507L+QBbC1SgOhlZEWM5B18Gw6aWOc4VG0l6NG6GXi6E+QKvzlQmmmlQ6U9?=
 =?us-ascii?Q?3g6uEhCV5RT2YJ18wzu1e/Le3IMAjhHil5ccv6L+Ea74XE/hSRBVgdAyHAWS?=
 =?us-ascii?Q?A/1rT9fgIbR5Ao2ebSu5u3Fg0G3gW/eBOzYjdKV8iwNb3A4r7gS5YXf8WtHM?=
 =?us-ascii?Q?fNnRmZVHoQfyHTjTDcGFpBzRaoeyYp/2aERZjD9lRY415DVO5QIP1ikdUfX4?=
 =?us-ascii?Q?/ChTEETVQhKVcHgw/9VCsxLNaL3KARuy3U1LHg7yaVK16DJZjrqj328uN96H?=
 =?us-ascii?Q?N+qznwMOjgTWRE448IEZ4nJX6yp0XxrDyCNTAwVBGwuHiQXaZXvyGB6QVvIj?=
 =?us-ascii?Q?xoxQPkRcn//98KVlv1XEwC31VayZ6NByE6vlyNE3hbXWXVzHkPqYXZ2du9iM?=
 =?us-ascii?Q?tUzNHSvkbQaGl57MkGWUc9YUPiPQgmrIqZdat4YiFKCfjl8BaAa26vr8mINM?=
 =?us-ascii?Q?64xSyp8vhbhMsI0tjFAIxOh3Yyi8SSVMyAJFBZu42F3TIi/5U1pruvBt4UBP?=
 =?us-ascii?Q?kItU4nO0nutPYpB0/CpqygffAQhj4iFoW6MAy6CE1+dMpPG5bjyBC5TaFwwp?=
 =?us-ascii?Q?Z9XAss0ySWIu0pLN0azJGHqVbzmAh5CIEe5nbgEkc7VTdmBBb9Shu7q/vkGU?=
 =?us-ascii?Q?hQ3OjxNRITUKLzUW5Iz4gqMibNQMya24SrAQoPvTSViet9jrv4RWDqx+GAMH?=
 =?us-ascii?Q?9nb1FnevcA2rRkcyXA9yyw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6eb506-6251-4d7c-ef45-08dbc11a343c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:30:50.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRJN1lODVj2TDzbeJjsHX0/Qwu9nNjTDQtSmCJ3wlE6DvbjGzFI8zopk1bkK+1YNbGQf/q/BYV/5Q2ttnf7crw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=819 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290160
X-Proofpoint-ORIG-GUID: IVGQmONZVIyrJtu6GdSsP5v7YTlTu1HV
X-Proofpoint-GUID: IVGQmONZVIyrJtu6GdSsP5v7YTlTu1HV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the error path, the vma iterator may not be correctly positioned
or set to the correct range.  Undo the vma_prev() call by resetting to
the passed in address.  Re-walking to the same range will fix the range
to the area previously passed in.

Users would notice increased cycles as vma_merge() would be called an
extra time with vma == prev, and thus would fail to merge and return.

Link: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Fixes: 18b098af2890 ("vma_merge: set vma iterator to correct position.")
Cc: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b56a7f0c9f85..acb7dea49e23 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -975,7 +975,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 
 	/* Error in anon_vma clone. */
 	if (err)
-		return NULL;
+		goto anon_vma_fail;
 
 	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
 		vma_expanded = true;
@@ -988,7 +988,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	}
 
 	if (vma_iter_prealloc(vmi, vma))
-		return NULL;
+		goto prealloc_fail;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
 	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
@@ -1016,6 +1016,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	vma_complete(&vp, vmi, mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
+
+prealloc_fail:
+anon_vma_fail:
+	vma_iter_set(vmi, addr);
+	vma_iter_load(vmi);
+	return NULL;
 }
 
 /*
-- 
2.40.1

