Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0337519A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjGMHUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjGMHUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:20:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F710E2;
        Thu, 13 Jul 2023 00:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R46w50G61/u6KK3e5J1m7jFyzCr0s2c82gU8dVjAUQ9TkyF9HN0iMHfmD+ueesuTOxF1c3s3LMLKV+MDdcop/1t+m56CbTYbaH0amn8rdctWkM1D0ZjX+avMj4sFAfL2V+mLtPJIiFBVIlpsIRdtMF7CqHlUwWnBO7GRyESAshmAcBZg4UmP94lrUpGE9+sPqkLBVGLgdF9wywNcXOxVO4A/cRk06WpzrLm0PGp7mX5qtGFI7CUNOkZOBdiUV7o14Hpsu4gorLW3Ehx6ath9EGg0rfT9otRN+EV/LEyhr0w71bbMBwVNikx1huEihFEDOJZkVzDK3xd2QJfKwXzu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIoPFdzsbquYctemBIgKtnz1P8vP3pti0jO9BDET0gk=;
 b=hlc2M4cJFLBrgjv6wBqQGWQhI6RtLk35A9reS0y98QDASMSw3BjrHCp2Ii+7Nq27O3aWPtC+jgxcz2Cf6Rkt94U1z8k7jIuzEyTTyyTIt4g96vHUJiFlwh8nG79nf9+2A/200Iz5e2SBE80J2Gz9TjknvGwLnEjId2g6qMHgHyWNQJGismGDk4W0mbtQ+QYOCi3oVFVSKqLAcD4Ix3lGGA08phuy9w3mNIYw1nNv/GZAU8C6q0YNIu5N4ZslhQaIncs8qCml9e9tmdvuCqAeSxxpV5mS71PkFwScC8K2AVciyrUsl6/9X/4KJFChBgj/6d9jmw/x8SZn+UkdRqBM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIoPFdzsbquYctemBIgKtnz1P8vP3pti0jO9BDET0gk=;
 b=bl9M6jmnIpUvj7yQQib8i1OaJxkrQjVXeSoQCc5eDaHYUZQeaQoi5c57ZDZGlBjfAGK5CNDvyxY+McuT9eAghn4I4SYdyLHikTZ7/Nf1ohd5Qcowjoq6CgqLoZkaAPfaM8RE8IUYHAagntXH/+tRmuU0fCNE9869oZWIFi1yYBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7286.eurprd04.prod.outlook.com (2603:10a6:10:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 07:20:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 07:20:39 +0000
Message-ID: <2198f2e1-4fa3-6303-6111-148f9e679dd1@oss.nxp.com>
Date:   Thu, 13 Jul 2023 15:20:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] arm64: dts: imx8qm: add cpu frequency table
To:     Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Chester Lin <clin@suse.com>, Zhou Peng <eagle.zhou@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
References: <20230712211755.1538847-1-Frank.Li@nxp.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230712211755.1538847-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cda48f1-1852-4d50-1cc2-08db8371a8c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HJ3kKUrC4ddPL7H8EaIyTeC4oyIfCHFjW0LvBZSw+E/y8eI1ijtZwN4UWFn6EAuvYWltrponvkJ881XZYLapyAQ5O38kPH132RTD6iE+v8XD4R6VCHe3kNSfnpb0hKU3UVWaQmj+1ttc0xbFQa0E1zs/BZUd55bjbIAdeRTZPrFjzh00JxZIMYl+vvvFzbGlJXvSKtDFrE791QAR04GDeE5BEMHnTAHimgEKmbnFoGqfXhml1RyasAg2IQXS9WEa3ThzHmhDhdzzhnjZH6zPdAS2GlJFHw4AiLExFw+3xL7LZ5MlGTQUpCVyWjDqbu1JvKNVN8QR33OpUnjCPjtZOmTQZTVjptgJ/kwUj2hL0WBqIfWN1Lgzt3F2cOgiwByHF8oSgP3ZSjikJLCa8XoocAOE7rVWPZ/gjFJXOrRJQ1I5+QMDhFIEdT86YUwKjBj611IvwhL3PKp3yBhYx9QKvxN/S2vMx3YB2sNax5mWBmUskr8TO071xHIdqWJx3Zafethe9NNUBq5kYNO9XF8gm/aUdXF0VMp/ezaMDfun/HNp0fQrQlkx8gMvjlDrlWvdw4rjto5sd5IB2K1UMKy0BWObyp/SGB6O4dF1y2dPcju9vrxAcz8KghWT4WqAQexwtitY2MCOozBvKxLLHYigi7V2FHcPtyMSaSK1wc20myAgvmxrXhT/q7PAgik6DC1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(31696002)(86362001)(2906002)(6506007)(53546011)(26005)(2616005)(558084003)(186003)(4326008)(316002)(38100700002)(66946007)(66556008)(66476007)(41300700001)(6486002)(6512007)(478600001)(110136005)(31686004)(921005)(6666004)(7416002)(44832011)(5660300002)(8676002)(8936002)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJVVnIvYlZmTXlraldmWmY0SERhVlhOSHhjOWpKWUJScVhIM3o1ZTA4Z2dG?=
 =?utf-8?B?MVZWMVk5WVl0SUVEdmYxYlhZZWJCUHhoNkorZXY3MXhnMjRpZ1p6QzRCa2Z1?=
 =?utf-8?B?T3Z5QVJidXdwNFprbUhJeHBoOVlPTHYyWUlqdmlEWU5KTVlWTExvOEZZOGcz?=
 =?utf-8?B?R2kyTFo0ZFBsNk8zcGk1eGJmNkt1ZTNkb2ozRzRLR1oxeEQwTXpWY29OSHFS?=
 =?utf-8?B?aXB2UDk0NVZoNlo0VnVEQ1l1d00vemJudERjK05oWDBBNlVHVVVrc2wrNS9q?=
 =?utf-8?B?akg3bFgwa0FueTRSNUhtb1MxZHE5TTBjYUpnY2NqemhNUklHVzBRZWlhVUpD?=
 =?utf-8?B?ZUFkU0pXMEQyQXNuYzVPbkNEZUtyMjF2M1dJY2JER1hMYlNDeW5BVmRLQlJy?=
 =?utf-8?B?bjlncW9hZDlvcTg2c2F0MllXVmpDdHA5eDFMWVllUEVlZ1FyZDBYUk41M1Qw?=
 =?utf-8?B?bmpnVHVrT3lNMytKRlVqb09rZDA1ekhyMmFRUUExY1ZqS0lvYlc2ZVc2RTE0?=
 =?utf-8?B?RGdWOUFJMVZVdlY5bmV0VmRtbnNSekVxaFBVdXllTzhYbHpQb2FqOTUycGsr?=
 =?utf-8?B?OEh0ZENnbkNqZ29mUFA1LzlmQUpqRUFZL1pnT0tLR2cvOTBQMEViL3NSckNP?=
 =?utf-8?B?YmZraVl4SXhaSmRtelBUQUdQY3hWSmRTSjVvNmd3ZlJld0dNM3hXN05pU2Jr?=
 =?utf-8?B?T0V4c3l3bHZOT05GSkRLV0RGSjBtT1lyVE1HNmRuajhoVXRqbE94QURYUlZU?=
 =?utf-8?B?aUQ4citPV2lwbDhNejdQV01nSkQ0R0hwOVpsV3FLQStQWE92VlRFVHM2b0FV?=
 =?utf-8?B?T3dTR0pqNGVCQ2RxaElwZGhRemRMUmoxRXM1eVV4c21JTlVxbTRHWGpjK3FW?=
 =?utf-8?B?eWF4b3RwN28vekNwN3RobkVKSU95cHlqQXNrVFliZkdmUTNHTHY3OEh4ZFpL?=
 =?utf-8?B?VXBIYnVOaUk2eGtBaXRpUWdyNmw5ZEhHeDJ3TXRpV2RsdlA2Q213ME1JeWlT?=
 =?utf-8?B?cjM0dGRSQmwyWk9kUFZLWURBaWZqbWJmbHhjMmhiMUR6STM5Ykszem00UmNU?=
 =?utf-8?B?aGp6eVJ2QTB2ektJbU1JMTl5aWNDd1h3aTJWOUhOOWMxdHVsdXBZNDRpZDlJ?=
 =?utf-8?B?OHhHZVNkd1NpZ0s0OU0rbnVKdE5tWGk0ZFJWSXl5RnY1dkpHRHZHdCtLTUNJ?=
 =?utf-8?B?OVhpR01rQUF0QndSWU54bHpYcjVFcHEzSmE0THF1ekRKTDdUNGRZNW1yVVM4?=
 =?utf-8?B?aXE0d0xqYy9Ub3RKakswMmtyd2hMRFJ5N094bjI3VDdRaGxnbDZqbGlpSnIr?=
 =?utf-8?B?WnNGQ2pWdTl5Um91cHh2RjNqM2VXSVN1ZGZGa25uZnZGUG5LcEFrSUtZemNx?=
 =?utf-8?B?dGdnZTdaSVJHdUwyY0kzcDFIWVN3RUN0bXloVEwzZ1k0a3J4dlNDSWsrRjBz?=
 =?utf-8?B?Z2kvdk1TUFJ1a3E0R250ZmRKRlBidHlSTDM5OCt5L3R6WmdYY2tOUi9xQ0dm?=
 =?utf-8?B?VTduTWxIZG9ncGZycys4WFU5Z0lqVXlBdEp0SGlTSHVxMzMxOHBkdnZDMHlQ?=
 =?utf-8?B?MWp5YWh4dVFIREwxZThRc0JjUGtuV2JVMmNjVUNtK0dWU1J2QURVOFliTXJH?=
 =?utf-8?B?QXE0UEZ0dUt2RThPN09Ja2dyUlo4bWg2WmxTNlhpTDVJZWl1MldLUm5HTFln?=
 =?utf-8?B?cFVNTWpqOEdRTm9Dc1lISHA5YldKeDdKZW5CeWRqNEpRaGtZdW1pRnZUdm9x?=
 =?utf-8?B?dUl1NVlkdFJyK0FBWCttZEw0b3lPYTVFaFBtMEE4RkJiSHY4NCtYTXlmei9I?=
 =?utf-8?B?MTFRbnVPbCtUdVk5ZGx4dVpWa2tpM0NISmRCRmZ6QUt1YWFzN2pING5LN1pp?=
 =?utf-8?B?S3dVcG5BbVcwREV2SVB0cis0RFZOOGZVV2h6THg5eEs2QVlVcG1JOHJ3K2li?=
 =?utf-8?B?RHpiazNtNE1XdjdJNlp1NkFNQ0dXVXcyTTFTQWMvVGZVMHdmQXhNZTFZdTJh?=
 =?utf-8?B?TnUwWVdVNm9XRDNiM29UT0dsZzIrL1NDSGNuZ0E4SkNRZTlrRE5aVEN3bnV4?=
 =?utf-8?B?MGdYcUtJS01TSVRXSktrb1dlRzcrYmo3V3V1Z3BJVTc2MjlNOEZ3dDU1S1ox?=
 =?utf-8?Q?rljD1MeOLfzZBRUr8E9mhx+jf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cda48f1-1852-4d50-1cc2-08db8371a8c5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:20:39.6288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7yHvvDJ3Ezaa8EOJkrSDubHfvu3gHqb5HvwChlhQikfhTWF4LAPwcAi4VxdEepKga+r0xsU6gHXWclL0GLPcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7286
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/2023 5:17 AM, Frank Li wrote:
> Add A53 and A72 opp_table.
> 
> Signed-off-by: Frank Li<Frank.Li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
