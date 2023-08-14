Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0777AF91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjHNCeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjHNCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:33:43 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2137.outbound.protection.outlook.com [40.107.249.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DCAE5C;
        Sun, 13 Aug 2023 19:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDEY3eKgaJDp6DaV0JjsgttMqHFQxm2YDBt2QUznpAyd7tjw/0TRpowAGp9JNJDGtvkFQQd3LnlFFxz5NYXZRzsMj9mpYYhJP+XycYHSO/OHGX0FDd9f0NrB82xTUGa8G+mS/ZwytVFp7O6CMIQpwcDGnQHT3S+Gn78HU2UOEm/MggT+EWei08LyWrOpIrkMQb957kX4ETk74AFegvux4uNFYcKyhhxMjzrHeC/WXbHvLuEuq1h5hEZYlMw6Z8VtOKHpzfh5NjTz+6KPX5SYdwWlafJ0UqN8bk9w8e769UfkIT/JLFdAC+GuEbgVLZobVIbbFD+2jTGxscyupWVDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjkszKRacM11YlIxhmX/KT0erpTPSiRH3AqZG33Pneg=;
 b=b0U300LJCC6bYZmsE2o9ktATzho41kElsW+EEr7ziRgIP+TyGr7//CEZqsSZ92AVLJ3X2hYJHxEPHUZE1ljYFhS3JwWF6o7TvJCSNgnRW1NyL7d9d/8YtYUBh0vqgHOoOT3CWAbG7N8I48qu4hJyxMtQMuRBlPR/khCAxfInR9U6jB2JmWuxjGBuoCrc51rI2rHdzCIykEm0zN3dYAfLdoohBjEcjEyMSi70B2uHhlL/EB5P98z3A5lMhRx1x+4zcm2iyjXLcl2fnJn76PSVSGN3rIu3PGi4OxKEf0174VQ4EagdRxSMF3m39DZ0tr5xN7St/yiDYQDHAJtprqQoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjkszKRacM11YlIxhmX/KT0erpTPSiRH3AqZG33Pneg=;
 b=PxXDYS2ziF0neeun0STeNxDlBXH3iCZwug234jhmDos3tiloUM9IVfTe1o3hFGuzQIAIIfppAOX4CoFfkGk3oRsv2wi+ZOjwFKbjCESG9RhU63JdF2ygHFNMUjticMaNua1tzrD0BlI6dAkH80EH4VNH6C5Qcg/zUIRX3lSsg0DONc0Liwirn+wTL9mFV9nsUO4Eb+IpQBozc7zB+VZv1pD316CSZV5E9KufnW39ROGmC0CAcD/JBHwTsKTbMvzsncEPL2t/6d78b/hi4BXnfR3TQzWuFIwPfD1XjbXIf65JloVf227wnEH9EkeB8Rh2sP7TBlN3JKS9n/UWgkynDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by AM7PR03MB6401.eurprd03.prod.outlook.com (2603:10a6:20b:1c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 02:33:38 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 02:33:38 +0000
From:   Francois Michel <francois.michel@uclouvain.be>
Cc:     Francois Michel <francois.michel@uclouvain.be>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] netem: allow using seeded PRNG for loss and corruption events
Date:   Mon, 14 Aug 2023 04:31:37 +0200
Message-ID: <20230814023147.1389074-1-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::21) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|AM7PR03MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8fb7e4-dff4-4e94-c830-08db9c6edd6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNWBtmy6OfKUju1PDeRhfMfToDYLQGF+jEbW4PTz1pma8PZp24CGy9yo4HDdwiZB7DE/VUG0IjkuXRGcuTIUDOZTuv3rulqulrXIaZVeyun6Y0DqwyjUUML2H3mdTmxyBEv6G9cvWUfNz9RSlgvFEkEkSl9vU8rklhwfwCLYckskyKbSHs4uzSRoMcmtls6wC0wULzlBMmyZJwnZhrQB5W+DIih0Id4b3ZcMY8GVEo+GRW+nYKbHVEjJ1B33kDpbYrBfZXSXg2X64KLHmhorASGyR2Rl6r8BXnVr+cyyHjdsMDdQUisnKC5hrcKtxVOolsTsde5DLr365jLir95rCUYJgUswIHR8QEDynodwafkrhzeVjnuapyTz7jVncLEvdv73EnZ0zXaOnpgxRP6fTNYDoVz94A3HMBIOFlKCKJ3N/BupFfeWmNAnkK66++9ajZVuVpl5pGbj5BKBMtaLhg7g5Rj15unnj81Mxcn/i62LCyH5M3718I8z7YDiE/O0J9+thSP9xc6rGCNXtwPlZu5ufpSvy50ebjrRsgJ42Faymxfb4E/UD22QFtT+UbAWzlQhXrZVjV0nkNlKYok2pulI+BwVLstAk0jAi+wDFA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39850400004)(396003)(366004)(376002)(109986019)(451199021)(186006)(1800799006)(38100700002)(52116002)(54906003)(6486002)(478600001)(7416002)(5660300002)(2906002)(36756003)(86362001)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(316002)(786003)(8676002)(83380400001)(66574015)(2616005)(6506007)(1076003)(6512007)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnZjQ0RYeXhaTFBaWlByYWUyMXZ5V1ZkRzh4TnhOU1VaOC9EV1FQMGlmNWlH?=
 =?utf-8?B?Z3RYMW4ydS9iMG1STzhCZW1RNFBCaEhRMDRsdVhGMFZCMFVndVJkRWQ5REMx?=
 =?utf-8?B?VXZkWDVHYkRlNGtia2dtL0lIRHJHbDJaSWtLRGNYSjYyZTZIVFZpRm1RZFRE?=
 =?utf-8?B?eURRYlBBcUdtRjdoNGdaOHAyVHRHRjRLSTNzamxVN0hSY081OHNEbXhyWHlp?=
 =?utf-8?B?VnpVTlovNUppK2JwMWo1RVNnaS9wYWhvYnpXUWp0VkFmZXlvWS9Tc0tXeVl2?=
 =?utf-8?B?VU5KSVJMSDFpYW9rQmZTZ2ZQNU9Bc05jcUl3b3M2RUJQaitWbUljVytNODhU?=
 =?utf-8?B?SklPUjU3cUF0UHozbXVzcUxpT1Z6N2dTcFlXdXE5QnJjSFQxSVN4ZFJQQ3dT?=
 =?utf-8?B?RVM3K20zY09QT1JhV3ByRC80VWZFTGswQzNRZjBDRUxPYzZtdVJrYjFlOWFU?=
 =?utf-8?B?S3FiVjZvTEdkc1NIUFYwNWdGV1RKZzhlTGtlZytGK2MzSUVydnFyVmtYTlVP?=
 =?utf-8?B?Vk1BTHBnaWZRc1BWRk5zb0loK0NvRDZrUWgvUXhQOERXNDhrY1BlZElOeGEz?=
 =?utf-8?B?OGZTbjFTVlBtMFJWZFY5a3JaWWNBTmpwblk0dS9vKytTT05nQkRvbW5abDh3?=
 =?utf-8?B?ZEZzY3lSTk52TkZVZG1Td0lvbDZpUUNhUHA1ZVFQWUpJbTdPSHc3c2kxWVRW?=
 =?utf-8?B?ZzBBTjJlcUF4aUdocTNub2lTSDE5cUZmMlpDTjlYTDFEQlNUZERzWDdsM0Vw?=
 =?utf-8?B?VWRkYStHYk5Bb1Vyc0E5Vnk0T1BzNDYzanBrb3pJM1E4MXVOdVR3QTQ4dUNM?=
 =?utf-8?B?WnRnVFUxZllydzI1Z2JyVUhqa013MURFb1U4K0J5SDRLN1ZYbHdhdDRJdklt?=
 =?utf-8?B?YmxxZHIwb1JRak9aKzVMV3RTa0RhZWQxaXltSXprVmRtczZ1V2E3R3dkc1Zi?=
 =?utf-8?B?NHhjRXJmRm5kczJZdzRtUDJwdDhlNjRKZ3kwNHRaNVZHNXdMQnBNbDlOYVNP?=
 =?utf-8?B?cVdNVkZNalNlb0ltTnRUMGFEWmExbGJrVkFPZE1SMlc1WjVsN0c2NHVGajdB?=
 =?utf-8?B?MU14OUVnWnRGcFpQbXVndVh1K1lyTnFkRnd4WUF5RE9KOHBwb2s3YzlUc3dS?=
 =?utf-8?B?Qk9ieXFXZm5mSDNaRXhVSk5YUCtwK2xaTG5uZ2Z3ZHovRm4zd2lvMm15NHhy?=
 =?utf-8?B?QzhuRmdiQlVvbkhueGx0N1VRcHZYdURabm4ybWJva2ZEMGhTQkh5T09lck11?=
 =?utf-8?B?QVdHZ2pGamQ3NjUxYk1id3Q2cGN2eENXYlJkV2VHcGM2b3p3czl5MHUvcHFn?=
 =?utf-8?B?R1VoMWcxbW0wWkpZcFdoQjA1azhGQWVlREZxTzduZFhMc3NjWHlybEw0ckdz?=
 =?utf-8?B?ZmQxYmNvQ0lIOGhwclhGclJ0YnhRVGc1MGhmRVJuc1BuQno0QTZ0WCtRTXgx?=
 =?utf-8?B?MVMva00zc3JZMk9kaHJzZml0d0VOYlVKajE4VnZHVmtxK1doV1NCbTJINE1M?=
 =?utf-8?B?enFMZlJFZkVjU2N3NWc5dEI2RlduYkxCZzEza2ZMSTBrM0RudjdHSHZ3ejVn?=
 =?utf-8?B?QkI0TlJhVHRHdGVldTFSUE9WMUtFZVl6MVdzNjZFdFA3VklieHRzclJ1NDhU?=
 =?utf-8?B?TGRqVXhEVS9RUFVnczVyV2lHdzBSUDRpMG4rNjUxb2JvVHBVTmdnNVBhbFha?=
 =?utf-8?B?Nnh1WEdPWk5uVXNQSVRRK25OYzEyeDJzMzlWY1N4RFlnTlBUWHlrcEFxek1h?=
 =?utf-8?B?WGNKVmZQQXdBQjVHM3pZbC9Lc3c2NXI2MTNvUGk1Q3pmM20zNG5Na05mT3ZS?=
 =?utf-8?B?WEg2aTR0cVluclhnb2F6aFRaL29IanEvbGZqRUdYOEppQ1grYjNUV2ZURWZK?=
 =?utf-8?B?Z2E2Mk8ydlVGWGVxSGtlTGYycXo2VStnQTk0RjI3dEpOWTVUcUdZdnNjZDFj?=
 =?utf-8?B?dkcyeHVoeTdsTlhjUDZlYzdVT2RvRnBvWnA2cTQ5RWJ0YVFUR04xcDFsdGFX?=
 =?utf-8?B?ZFhleEFWV09Melp6K1pUWTJLb09tdEFuZU1lNzF1RGlPRUVvL3I5K1JsWmJz?=
 =?utf-8?B?SXlrVXhPZTFXRkpiVGs0dzhQNWlvMnROWXVrWFV0Wk9ONnRMY2g5S2FlUE5x?=
 =?utf-8?B?b1JJcnRKN25LcWpqcnk5d0h2bVFKcDVJR0E3MUpUQjFMZXdNRklVM29BMkht?=
 =?utf-8?Q?sTpREaFCV95/NvjGc+z8ktmW4lix+Y6VZ7ig1c2w7uCW?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8fb7e4-dff4-4e94-c830-08db9c6edd6a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 02:33:37.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9ZXN0f9WvAXhyg1LookQ7AeO+EyDqoq4KKvraYIerY0Shxf9ZngU60rHk3MTGVh3Iwn6jLbl0JLsfBECvTDV9YLjMGY9Z8eZ2mW7sK4EF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6401
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: François Michel <francois.michel@uclouvain.be>

In order to reproduce bugs or performance evaluation of
network protocols and applications, it is useful to have
reproducible test suites and tools. This patch adds
a way to specify a PRNG seed for generating netem
loss and corruption events. Initializing the qdisc
with the same seed leads to the exact same loss
and corruption patterns. If no seed is specified, the 
qdisc adopts the classical behaviour, i.e. using the
unseeded get_random_u32() for generating these events.

This patch can be and has been tested using tc from
the following iproute2-next fork:
git@github.com:francoismichel/iproute2-next.git

For instance, setting the seed 42424242 on the loopback
with a loss rate of 10% will systematically drop the 5th,
12th and 24th packet when sending 25 packets.

François Michel (3):
  netem: add prng attribute to netem_sched_data
  netem: allow using a seeded PRNG for generating random losses
  netem: allow using seeded PRNG for correlated loss events

 include/uapi/linux/pkt_sched.h |  1 +
 net/sched/sch_netem.c          | 62 ++++++++++++++++++++++++++--------
 2 files changed, 48 insertions(+), 15 deletions(-)


base-commit: f614a29d6ca6962139b0eb36b985e3dda80258a6
-- 
2.41.0

