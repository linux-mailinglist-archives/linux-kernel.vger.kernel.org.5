Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCA57FD182
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjK2I6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjK2I6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:58:31 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2117.outbound.protection.outlook.com [40.107.8.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF4119B1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0ZT8Vsq5b29c31IiDnWVIF4xaUKeOGsNnDi7mfJca4Z+l8dQYuWscjPeNK/SY4TjsIxjkqTpKXCuDb1axEHtRjQhdUZ3wImxwe6mwBSrFeTKqBREp1HbbQ6bq1KKyVicwxx7hM4J8XI2iZUV8vV34QmH6SkVp1WXgpipjgHhFFfpOCdIHN/DHmbXEkApu44HyGCqVhmGeipdxKZ4QMFCfuBZE8fn0XnDV8wJ8vUB/cKT6Kth2ry27hxQNWFDSkmQdYe2nLYYk7y1XUY/e2rIKcpAVeS/CmSa5K/JkkQsHCWvPLGOQvBtPUkv8rOLz6cYs/lSR2CZqnF6hHa8goYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6lxJwksEENWuftD2IvHCizDR2F4uY6lypZZ5ay/eBw=;
 b=iBriLC5++nPWidFSKR8E0TgroyJT3+PvT5rWPf0sj7LT/xumJu8LdxP8X2CC+QejNUiHUJIjtGCOsk1RIttjIa0f5/OUAp1/WYHqEL83Fa5b04Wpc5oIKMsac9SJOar5eeCvXwzTGZ+pfcbz73V2oqhJdWIhAo/AZ0oMxe7RK0d9gMtufivGala8JyRS0BFVLjBa6CdL719HNRoOLtEoXb8eg+yfEQWyLIzff/e+/bgghxo+L7iRuQSjDhQeV55c7iNu9iNoJvQchyfELFCG64qdc/zRkR4ZLeRmNJGSYPNCtJa56eocPsO6E3YZ6EkyaiTOndaraJvzOfzuREJBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6lxJwksEENWuftD2IvHCizDR2F4uY6lypZZ5ay/eBw=;
 b=miUTksWfBjURc32jopX3zPacoRa/jp5RBVaSS4YRur911JmP/GEfjkXymWpIudtmmqOEivwfvAPfjwaXYetRCgN10Qjy1+0NXa1iiEXBCXZAwqBZUHebUZWdOTwGjl8+3CQCpSR+7kDo0ZR0LaykNDV1houooHR3xWkIF4fDroM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 08:58:26 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 08:58:26 +0000
Message-ID: <713eb42d-114b-4738-92ab-242d73fe71ce@prevas.dk>
Date:   Wed, 29 Nov 2023 09:58:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: don't complain on _Static_assert and _Generic
 use
Content-Language: en-US, da
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20231127151847.52945-1-przemyslaw.kitszel@intel.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231127151847.52945-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::29) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a90a9b-977a-4b90-a809-08dbf0b9597d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wExTd3cBia30UXue50OGEJbvAMfiOApWtARY0qPNzqfzcJuZZbUdLGaZLyTZRBhLkA23lRQIeoSGRGxBr8mJy+9bspYD9+iRNWZFjCFYpQcYt1ZOygQ4maL6LDb43TsIzEnSPpK3UAbNfo5gloZoqKbnAKm/ewyM2IpAse7oVPncQvVu0lC0S5Datg2oL9nOxACel27U5ty4SK/kTEt3cgceaJHfhSXGqfNKSL3b5JN/uAiHTRiOQE6f7d1uYzktc05Dt5HHoptFvDen4R8dlMBaMT84pYO484gnby/w4kIweVENn02JnBatC1SgTJduWGe1kIXs32hSajQU5mf7EOtysR/bZoQRdVfJctIZWifEIvJoRjCnax8hIbrABbdZnJW1OfPj1SHkWcWptMyzkJdnJ70Q6PxhnurbNJsrEWGAyoueJV8MI9odNeGogLBwsAfRfDrwOgXZ6ejSskZw6qvnSCwUCz+8M+T9jNuuaA4oVhINzkHPTcPDTG4pwcphau8ZD8ZoRM5zo9QoefaayahxNgjErfCnSm1M9IJXT01CrHT5PxqEt3Qrb8Mp8pINxcZyY+bcSh94n0MVmietgSHxIfECyDuMafuSM4rhvSVdjwZMHnHJJp36hGvTgISRA8bJQJUOHpAPo2ZzClwHqNU1mPQyCkMFLzjobimeD4I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39850400004)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4744005)(4326008)(44832011)(2906002)(31686004)(41300700001)(8676002)(8936002)(8976002)(110136005)(316002)(66476007)(54906003)(66556008)(26005)(66946007)(6512007)(6666004)(2616005)(5660300002)(6506007)(86362001)(31696002)(38100700002)(6486002)(478600001)(36756003)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZyUmpxYVBIRnpSTGZraXZ5TUQ3SkVUc2cxS0tsVFlzQWIwQVl2TzR1dG9D?=
 =?utf-8?B?VWlLR01aYkYzMGp4am92NEwwVXBPbnJDZE1aSU00VGhueTZtaWVYY2pnRGth?=
 =?utf-8?B?TXNhYTdKUm9QWVN3RWxtRVVtSUIwYWdnRTREc2NwdlIxc2lnd2FuU1k1WS9U?=
 =?utf-8?B?M1IxVjlMTVFjODNtdDdaWXc0ZEMzTlh2MWR0aC9CaW9TSmVzWDJhem5QT0ov?=
 =?utf-8?B?ZnlvcUpoSDRRVnBGcWZpU2FKZHNtdTZCY0xodG1aNWtUR0xqNjFPRWpweE9a?=
 =?utf-8?B?L29CZGxuWnhBdkZienc5U0pEdFFWZlMxbkNsdE5lMVRMQzFuZU5VdXd2UjMv?=
 =?utf-8?B?YVFRZ0ZFVkYzSEZzblovZ0RqNmc5TDV6OXNZOWxXU0YzNHhjbDRXWnZkSy9p?=
 =?utf-8?B?RU9Wc2trYzV5VVU3S2dIdm1UN1dpTlZGdU1oMnl3aE9RUmJ0Y2t2dzA4Nkhy?=
 =?utf-8?B?UC9lSmFYTHRpbkFaak5hQW9JOWg4WlFDcXR5bFROWTNtbkI5K1A5aVBSVlBK?=
 =?utf-8?B?MHovTWQwNndEYmtCeTZDTWl4ekdKcmkvZlc2OEZGL3ZoOGtDdDNSTG9nT2Mz?=
 =?utf-8?B?aXorbm9ldjI4bjZpWG1melV5MUlnWVhGNUxHdmZJckIxSC9ISjJoYWlXZXpM?=
 =?utf-8?B?ZlB2YWg5MFdheGQ5Q1FMZXNEdW5wVlJpNnA3bWNrejN6K3ZTSkt0QjBtSDBH?=
 =?utf-8?B?MDQwRXlZMlRDSldHbnNsWHhDYXNBQ3luU2p1ZytnZ2R4K2JQMGI4MWMwMkVJ?=
 =?utf-8?B?Uk1iZmlFWWNlbmZleWJkSVZ4Q21mMU03UDRBaHo2UlpBb3BxVGJMM0VNaW4z?=
 =?utf-8?B?eCtIdG4zeEFqaHZleFdQRjNMWnpDcml2N3FjNTFFdjVBeUNPVHBhUDlobk5D?=
 =?utf-8?B?SlQycEVjWHZmbi9Nd25mc05NK1NKSkVsMm9HZW1PVlF2RkIySW9EOXc5OEpX?=
 =?utf-8?B?NmlEb05XU2dtMStWY0pKNDBnQ2N0YW1QQ2lBazhLQmF4RHFSZGZJUzRSaTQ2?=
 =?utf-8?B?SnVDVlhaM1dhWnBUK3VxRWlXM3BtbnV0R0Y1NjhjbDhGN1lxUnh4QzZ2bUJL?=
 =?utf-8?B?Q1BWMnVORm43VjV2aklaSVpqWmQxQS9vOUdXc0NydVQ4ZHVnZWtHZy9PWVRD?=
 =?utf-8?B?ZXVQMlZ5TWcxTHZwUTZHNWlVQ1BKUHU1eEtEUmpwcTU4Y3ExRDRiZjJzTTBw?=
 =?utf-8?B?U1FsUWFDbzRCM20xWWp0NXIxcU13anBQVFBDelNiWUpXRnhSb1cxZW9Xb1FD?=
 =?utf-8?B?YTNYQjUwSjgzVmFmSms3RHRodVY4ZG43SFpDL2NtWkFqWFFLNkpIMjBSclhI?=
 =?utf-8?B?aW90TWRRSWI0cFJ3VlV5ZkRKaUxQVkt6dlQ0M1hKb1lJbHBJYlJSTFJBM0xz?=
 =?utf-8?B?Ti9jMm1lNm8zb3VtNHlHOXRodUhtVkpuQkZ6MFNMR1ROYTlnajBtenVFOWo3?=
 =?utf-8?B?Ny96STBPQml1b2NjWDY0U0tIaXozUng5bGZoTEpYUTByVUh6akgrWDROZG9p?=
 =?utf-8?B?Y1Y3QUYrR21aQTA5WGpIejRaUlg3ZTAweHpBYWdJQ1RXeVBTRmpjMTNwLy9o?=
 =?utf-8?B?allsRTlCSGFENlpYMmtzMWJEZHhqRzc2SzcyMkV1Z0J3eDdKYk5CdTBXbyt3?=
 =?utf-8?B?L2pvZFh3TURsc0NOdEtaL29rRmx1NHE0eXBubkVFeTcxRGdwTDNTTjZPZm80?=
 =?utf-8?B?ZklnUmVEbzJXZEQydVlwTmdadlhoQ2QySTgzVFExUko4QUlOT3lNSDNLRVhx?=
 =?utf-8?B?dEs0MkJTRFhKUzJEM1NPdFUrMTduS21RL1lZUDdmTVRNV09LcHBMVzZ5S2lo?=
 =?utf-8?B?VUNZNTNJNVpsa0NyMWpwd1YxaFpaWS9HUXBYdFpkVFdKQWxHa3hyUUNnVU0r?=
 =?utf-8?B?NThmSWZQZ2tVZzFyZXJYbGFvb2tSUFh2TnR3eERibnhwVGdQaDhJcE83T1Qz?=
 =?utf-8?B?UkNVYXJwa2NTQUl6b3RVM3Q0Q2FEQ1BKb1hJQ3drREo3NFVxS3h1ZTlCc3hk?=
 =?utf-8?B?Ti84R1Fwc3BzVTlZSloxY0kwNjNqVnMzRGUzNVFXZnFuTUpLblZwcmdkSWVz?=
 =?utf-8?B?TFl6ME5mcmN2NDJCK3NFUGRkVFZ4by90aVNhV2VIR1ErbzdkZXNYOGUxa3hT?=
 =?utf-8?B?SGg1bUlGL3FiZ1hvL0dNNTlPUmlmNXZMZVBkU0VleXRtZGdxYmhVczRZakUx?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a90a9b-977a-4b90-a809-08dbf0b9597d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 08:58:26.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAxxnIVymq3bC5f5uv6RUnc1suDYSsrSvRfVX7WipB2ZvKC7T9fs0iWQ+sZr/Ryh3EX8JvXGqZ+rrj7PDShfXpyJVrZt2owxNeVDY3YIiEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 16.18, Przemek Kitszel wrote:
> Improve CamelCase recognition logic to avoid reporting on _Static_assert()
> and _Generic() use.
> 

_Generic I understand, because that can reasonably be used in new macros.

But is there ever any reason for introducing new uses of _Static_assert
when we already have the static_assert() wrapper? Shouldn't people use
that instead of the raw keyword?

> Other C keywords, such as _Bool, are intentionally omitted, as those
> should be rather avoided in new source code.

... in exactly the same way that we have 'typedef _Bool bool;' and then
prefer people to spell it 'bool'.

Rasmus

