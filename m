Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085DB77CA61
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbjHOJ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjHOJZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:25:10 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2128.outbound.protection.outlook.com [40.107.247.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFBC1986;
        Tue, 15 Aug 2023 02:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZvrt0waSUuO5HMkOINmWt3dVUyn8mol+4sqwCFRwCpzoYoy9eGEazXlTbTM/4mf18aZyzRCOkwuzNy6Bf+rwxGyC5i9JwWNQFAZoEENTgQLNGqbuDUG0dwicxNwPUsrNL87vVZ9EIy6UXeYKqQFhs5iQcN18F24crKyNOLb2Cpl/pvRMAC7dXxmu+qlYt9SRScZjGf5c2CXZ4Pcb4uZs/VdWQ1KzQNiaVC9fK3HR+bIvvctyn3qhwyqLIEMpO9aBaGCyraCTHh4HCAxIYVuKtJVA0XrII7AfGflZs65sRiEAvV2WZiV5WLwIo40GOMkMEauhmHEH5EsXtqPF0TfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbXCbiSwK3MqlgW4xzp8Ne1KbpWLP7BLDVa4fDEBckE=;
 b=MrtPCZ6SiBdF1Hoh1BXyqFcxzTcebacU8aF1rx8EEyA/vUd8a+ZjUTdPKyXZr3l16o6hXbciinmnHyURtqPmRGuc5yDh/IrGBkL+O5FBF/dx1ZIN0CKFLqsuqeNrAhmZfrbZF9vRJxTGEz6Ldj6dQb6CpL/Knq049xVW2a2omVSdcIfC9SQEZZWyeSNOdPiC59Xnp0XNbtfEIdgEs+UCEjLslJfoa0CmoVsmtPBHIlDL/SQooGaubw17U44BrqI+IpEr/I2TeJK4De0QBQboYRdsR1tPe6ZyQzkNvcSynFKWKs1J7i2LdvOgjL7Ct92RCiymLbb9pjCS4SUuDBuDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbXCbiSwK3MqlgW4xzp8Ne1KbpWLP7BLDVa4fDEBckE=;
 b=kWGAI0SSZqytgMyLiFxfuniXlRot2T494l2lS84gkCpRiRBJqCgrc5gcrZadqXE7CE5gq06SMEmcxZUEeOGqYL+rw2/iGqPftkSiFyzv1pauVak+D24N6rZi1Bax7ulOauOnmsfCgoJ4PhnBNlpmQBlwk7LisGEOr50+g397JO7ZIYNvYmJhlFsBd8k1Nmi3ubtL5tL+qGFlX+YbOzyzuCtp/vkw78BZBOQLl2lHe/XoWunPj+yeaeNEI7VYPiVCvirvJPT2qWVxVuskwEQOR/kMKwNUmdyWAdennLWnbw4nG3GqrVVe20sekfXUOSVqO552s8iKIzPvewx0FHdmrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by PA4PR03MB7405.eurprd03.prod.outlook.com (2603:10a6:102:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 09:25:04 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 09:25:04 +0000
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
Subject: [PATCH v2 net-next 0/3] netem: use a seeded PRNG for loss and corruption events
Date:   Tue, 15 Aug 2023 11:23:37 +0200
Message-ID: <20230815092348.1449179-1-francois.michel@uclouvain.be>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0131.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::10) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|PA4PR03MB7405:EE_
X-MS-Office365-Filtering-Correlation-Id: f97ff2a3-89b5-40b6-5860-08db9d7181eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d00PC3+QovuBfm+DivSs8NbnwEtFV/5RqFkUFl1dMja2t3RQL1MN0i2Fbm5eMTTAREllSJ+vMaJ7zZxNU/MAXJHxf1LXIP4rnY5Zt5cCPSxgjeX7CJLdA+xejD5m8PG1IkLsWXUya1g0g7nfbDnHgfzRNom+Ax4rlj2y/G3Cr1NVkTPr+mQwQnF/k/oqhQOZTt8T1/cjUzmf8a25BMLxaWQUrtBzFfOuyq3GlPCT/Fln4TUvKcdQFATMFLdJlVbaZm1EleQAAAnUniSFul8ESatvQIoVQM6Bs+tJ9R0zrLtnwjYVDO6xvs6ckrBm44Z2iDheBiJU2CysaJHuh1a5JgCTKv3fg3O8bnNEpXlWLyf232flNZRf7ZFw2V9RIbkzomr6k1Jh/7m7KgFBkaug0UMoL6Q+oOyy4+fKHaMpJSgfzToT23l2G50GvjF55aVyj0NLGKbvtx2PWJUmI1JobtlBirDHj8YWOA4A44S0fp5F+Nj3oA5fvF2DG8n9z2b/Gl8p4wmJ8HtWV8tkvDbaa+WkUOxHbcjYA2/rF1GrPM52N+4nU0xgQeeyXW3/91JlEu4Fqy3wQ7++vLsSylkK+psh5eysfQQ1O9fsfi+a0wg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(109986019)(186006)(1800799006)(6506007)(1076003)(966005)(6512007)(52116002)(6486002)(2616005)(6666004)(83380400001)(66574015)(5660300002)(44832011)(7416002)(8676002)(8936002)(2906002)(54906003)(478600001)(786003)(316002)(41300700001)(66476007)(66556008)(66946007)(4326008)(86362001)(36756003)(38100700002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW8xUm9SUGJNZVNjclB3a3o2VEY4NFE2L1EwSksyWnlyRDJHL21nUEVNSUE1?=
 =?utf-8?B?YU9QVHV3Y0xlaHRKcVRzYUcvdmxvTVc1R1Y5cGtEVDQvdUFDbEJNK2FlNTl6?=
 =?utf-8?B?SEkrV0d2dWJKY0Zvblk1c1RkNjYxN085cVNBN09xcXlNMFY4dWZmeW9CSEE3?=
 =?utf-8?B?dnlDUUFMWWxXN1NtZmRTaThvY041YUJUczlLV0RWMExCS3BXZGRBVlZaRXkv?=
 =?utf-8?B?SnU3Rm9nNHFtTEd0U1o5TmhtZWRGYXFKYzdFTTkwTTZvdWZqUHVod1g2cEFN?=
 =?utf-8?B?YVQ3QlI0TXh1aFlrQjdKenUzNEFDRmhBMFRrWUlPaWlNM2RlS0tVSENoL01x?=
 =?utf-8?B?aWRxMnlTdGhySFhGZWVlVmFia3ZPc1Y3S1N2NjAwWUduNVdvUW4xeUVIVlBy?=
 =?utf-8?B?LzRvcW5icVhIT1lQaU5mc0FiQ0xwdXUxR1VVMm5jMGFTMDlzYjV2VTVwdnFR?=
 =?utf-8?B?YnMvQUE3c3dCY21nMDRlZ3RRUk5QUmdPTE0yYmFWazhHVDRON0xpUUJOM1Vt?=
 =?utf-8?B?UmRWTzhOakZSQkxMbG5wK3AwZDNPV3haYW9OVVJZUGdPQzhCNjJacDdHVHV2?=
 =?utf-8?B?YXZPQlF3SmNSZWxTR0lDRUlzWFU2Sko0cVNXc21zYUVOZGQrL0ZKTTJQOUdo?=
 =?utf-8?B?N2Znc29wUFFMY1BCd2N3eXJLWXVjckN5aEwydVE3eVh4T2pCTFZ0Y1RjQ25M?=
 =?utf-8?B?UkhUejlOcW0zbThYaVdRSHVDMWdubStpcjZaN1hjT2syNG1YUDNxZzJVZzkx?=
 =?utf-8?B?MUdNNzV3VElQRVdaVXRES08vNXlVSUxnWFVGWlJ1VHdmMWZwamdkVDhwWDJs?=
 =?utf-8?B?b0VReEY3aUovaHBiWDN3ZFV1ZDFlcE1jeFhQQy9PV0dEYWw3c1dhZTFna2Vv?=
 =?utf-8?B?S3R2T3psSzdJYTBtdWhVTUluaVJNWkNmdFlLRElnbkZhVXptaWpkcDh5WHRY?=
 =?utf-8?B?Wk5kNnVaNUNxOGg3NG1BWVJlNGYwL0JBTlNxSEVmOCtVb1FWV3ZDUXJHZGNS?=
 =?utf-8?B?di9xM25ucFJHY2JxYytveUs2b2thcG1TeU5yNS9MTXU1ZHRWb1BieVN1M2dJ?=
 =?utf-8?B?T1R4SDMvOURkK1VvSEhud25UVlJBU2plNXEzbHRndXVLM2gvbUN5TWRBdy84?=
 =?utf-8?B?dEplemkySUYra3pubFgwM2RvZjVORGpMSWIyS0tkRURyanYvL1JHcTk0Wndi?=
 =?utf-8?B?Tlk1bzNObXpsUk13NnlMYWdwY1dVSFptM0RCQUxaT1U3a3NlNEpGWWF4MlNF?=
 =?utf-8?B?MnVjSTA3K3BzdnoybkFySURncnAwSXNKZHJ0U2UvUlRqQWp1b2pRMDZsZzdj?=
 =?utf-8?B?a2Jmd0NIMzJBS2RCM2tWaUgwOE9BQmFLcElZdE9YUG82Rk50TkViZytNZ2Jv?=
 =?utf-8?B?cDUyUExhUU5TdnVoTDNEZ2VFOTVTM1h4QUJXUmtzQTIwaFI3QlZUWkhhY1RM?=
 =?utf-8?B?Vm1GOGtaOWV0citsMUZPRW4xVHlSaTZPZ3pIbE5NS1Q0QnBEM3hidklrWTlT?=
 =?utf-8?B?T2NDYzdOdUk0ejVib2RleVBpYVZTT0tsN3ErbUVSTDdlMk1CanN0Z2c4M2U4?=
 =?utf-8?B?c1F2cE1SYzc1UG15OHJ1UlRGNEdkYk1EM0xDR0RrMkFqeU1oM3hQZWFEQlEz?=
 =?utf-8?B?eFlrUkMxS01yL2RlcmNqalpUVTNEbjhqK0ZybWR3cEtwZCszQlNMUDJTSGhy?=
 =?utf-8?B?WmtkUktiODRUV0xraXd6U3haNi91RWZnSVJOdWtOT3VwYjEvMCtyOGk3bzFI?=
 =?utf-8?B?MCtLd3RSbnhWbWVFYnMwc2RpZ2YzcDRGek5LODBEY0hOOThzeDE5enR3MUhR?=
 =?utf-8?B?RUZCazlXNWlROW13VHhUSVZYZEQ2OHRKNkFnTEltMjlLaGdMSzVabDFua1Vt?=
 =?utf-8?B?NmNuOFVHQ2tKMU1hWDBmeDRTMTJtb2p5bEptdGgzdkZCMVpqOHo3dXRZa3h2?=
 =?utf-8?B?ZUk5cy9pMmcyVXpHbmRmbTJmV1FmcldkY1U2b0NNckxISFI1MzI3bDNDQVBJ?=
 =?utf-8?B?djJHRW1KMS9yUThxK3FWTEFoZ2xGUXJ3UDFtVjl1SzNkcHFDRmloajZDUGdQ?=
 =?utf-8?B?WDlCeHIvSklITm1USFRmREYxSm1kR0wyNUpNME4vRFEzdEFDdTk1MndWUXps?=
 =?utf-8?B?ZTJOQnVCNmdaelZHRllsZVI2M05xRW1ETXhjWjdGUkdqSzhEOVFOQ29CWVhi?=
 =?utf-8?Q?4YpphWSmAU8B+Wu4P1LIRYP/FrJv2Is4EoKanNyKQbWn?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: f97ff2a3-89b5-40b6-5860-08db9d7181eb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 09:25:04.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9TVT3gXtOdJ8dl6IJWH/Gk426D/likj1rwBX+7to433NIXz+qX8e3TCr4xQgc+XtQM+DgQUes4x9JzJh4A8J5X1EMNC5C4rnX+ajG1l24g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
a way to specify a PRNG seed through the
TCA_NETEM_PRNG_SEED attribute for generating netem
loss and corruption events. Initializing the qdisc
with the same seed leads to the exact same loss
and corruption patterns. If no seed is explicitly
specified, the qdisc generates a random seed using
get_random_u64().

This patch can be and has been tested using tc from
the following iproute2-next fork:
https://github.com/francoismichel/iproute2-next

For instance, setting the seed 42424242 on the loopback
with a loss rate of 10% will systematically drop the 5th,
12th and 24th packet when sending 25 packets.

v1 -> v2: Address comments and directly use
prandom_u32_state() instead of get_random_u32() for
generating loss and corruption events. Generates a random
seed using get_random_u64() if none was provided explicitly.

François Michel (3):
  netem: add prng attribute to netem_sched_data
  netem: use a seeded PRNG for generating random losses
  netem: use seeded PRNG for correlated loss events

 include/uapi/linux/pkt_sched.h |  1 +
 net/sched/sch_netem.c          | 49 +++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 15 deletions(-)


base-commit: f614a29d6ca6962139b0eb36b985e3dda80258a6
-- 
2.41.0

