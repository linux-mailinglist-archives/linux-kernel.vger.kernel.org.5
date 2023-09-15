Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8A7A228C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjIOPhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbjIOPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:37:16 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF996F3;
        Fri, 15 Sep 2023 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgY3gjjD1qyZSeD75xswxMbqADvNXeHSPKZ3r6f76LQ=;
 b=SL3366TyJfyV7mIj9AYASWrA3f+qAyHciwdIYFSOeCpRwmgg6x+RReh0FHcuNYRDVJ963RPs+ahB60XV0vT8DwYG2cv+jD1vsYoOoUpQE0yhu9VhudOOT6PMoBzy2AyxDCyg6daR9N7ORhBiu+cZRqS/ouP/o5HuOJ/Wuzom6+8T6DINLj7onzpbJVH1W+nZ11rSIDEfGblMMkVvBbdYTzCxt7ov4A4iWpNZp9N2mXoea+I04L8naj9WL7qfl0Ehtrho2ir4FWNevboV2tQz+uovNGFaB2fJ9P4dVN8fMVULG5oETJoQyDoei60z3jdFz5N24z8CsIs4ZbzZD5+4gQ==
Received: from AS9PR06CA0102.eurprd06.prod.outlook.com (2603:10a6:20b:465::19)
 by VI1PR03MB6368.eurprd03.prod.outlook.com (2603:10a6:800:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 15:37:05 +0000
Received: from AM6EUR05FT065.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:465:cafe::53) by AS9PR06CA0102.outlook.office365.com
 (2603:10a6:20b:465::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 15:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.84) by
 AM6EUR05FT065.mail.protection.outlook.com (10.233.240.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.9 via Frontend Transport; Fri, 15 Sep 2023 15:37:04 +0000
Received: from outmta (unknown [192.168.82.132])
        by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id E9154200813AA;
        Fri, 15 Sep 2023 15:37:03 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (unknown [104.47.11.110])
        by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 407C42008006E;
        Fri, 15 Sep 2023 15:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJDNrrdOgYd8u3acBD4fa0twZfL6CvJtIO+sVYrIcDGbe1iOih6KLQ+bMAt9PTzdrTqo1PfZcgTRd/ojUlxgHalgkVqwOofmybxQTYqoGCGuSB+mJiVmjyliebBKifzFEwNKKYmn3Z+7sjR91DhMislAxeX7yjXvm/JdnPe3Ye21QvcpFVznsJcAspJITjJIVu6fIJxf8nh9hdDDBTcVCb1MT6UiLR2xqWeEdHOsJFnir5sHqOalOaDmeWsx37ate7NuCZrww2fWYPS2IYYtVFUP8l84d5/+Frsat/tGf2QmgKGjx6CHEoSnOf6wGUnJ6Wu0l4UNGIjGiSdVjv8k9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgY3gjjD1qyZSeD75xswxMbqADvNXeHSPKZ3r6f76LQ=;
 b=Y6qOvBN4ibc0v8Eec/e1EJKZK8qsjNeqbMY8yJvEUyOYLi1bksjINXRktr28S5TaYyj152SsA7AAoLHbTp09K2HIKQuFQocQdKCKrBm/wPAbKPYQpoBkQn6h9e4p8ot7eNf8AOvy2dbVhJM40K41KtK7Ji6HQsblCrEoip6WDrVPdv/T2xljuhXy9Nd7Gpc9ADpqWz8BaGPlLvK3GgSH/priP1ldEqIxP6BJZXTfggO/BR4b74BXt7xXVb4EJ+w+0MlfKSxq2S5C97QyWXwGLRW/M+t/GsSvyZYOXLBDcbw02Jeyf3iBDXiPapT+H5OhxcvdN9Sm6SgDAz5QSq7lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgY3gjjD1qyZSeD75xswxMbqADvNXeHSPKZ3r6f76LQ=;
 b=SL3366TyJfyV7mIj9AYASWrA3f+qAyHciwdIYFSOeCpRwmgg6x+RReh0FHcuNYRDVJ963RPs+ahB60XV0vT8DwYG2cv+jD1vsYoOoUpQE0yhu9VhudOOT6PMoBzy2AyxDCyg6daR9N7ORhBiu+cZRqS/ouP/o5HuOJ/Wuzom6+8T6DINLj7onzpbJVH1W+nZ11rSIDEfGblMMkVvBbdYTzCxt7ov4A4iWpNZp9N2mXoea+I04L8naj9WL7qfl0Ehtrho2ir4FWNevboV2tQz+uovNGFaB2fJ9P4dVN8fMVULG5oETJoQyDoei60z3jdFz5N24z8CsIs4ZbzZD5+4gQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM7PR03MB6248.eurprd03.prod.outlook.com (2603:10a6:20b:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 15:36:55 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::bf95:eda3:be0f:a340%5]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 15:36:55 +0000
Message-ID: <a94e6fc8-4f08-7877-2ba0-29b9c2780136@seco.com>
Date:   Fri, 15 Sep 2023 11:36:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 5/6] can: tcan4x5x: Add support for tcan4552/4553
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
References: <20230721135009.1120562-1-msp@baylibre.com>
 <20230721135009.1120562-6-msp@baylibre.com>
From:   Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20230721135009.1120562-6-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:208:d4::38) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AM7PR03MB6248:EE_|AM6EUR05FT065:EE_|VI1PR03MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d54e89-dbf1-4b2e-5510-08dbb6019c8f
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7H56qJfUBavGAh4QOLJaTaMEZ8qj82FpZbDwRf4FYLAEMePBsHV9fnXq0xAVy66dEJP59U3Z0PLsVHS1+/qtKTXPiJNXzyxzNpgft3ZECdJ+Z7g19HTPeDB4WNnoj/VXxZpeu3wvClwqpeCUXLQGm2fsWrhKB7ZPI/HNHONmnAVNOmJ3g+I1Eno9a41/VxrjjYlnHWSRqtE7VJuPweuggdCQiPODI94gHfuUF4LZRLQ2Y4lisvniMnDsWMdCbw8/aqakDpMnBMP+Xs/NUrqFOOVIODLmpPrANrw8cIFrPkabgHQjIAPBsqlu+glh8zTAacFJ92tYYvy3IcI+Qfi89otPTZsgpk/w/1QWZ9utngzMf5k5FuRNyFlFPhe2PGuDcJkgMBVa4SZr9gkXwB5FM8fdLH9q+MbDpoIkk3q3qIyWciP3wqYNv3QWXjDqLy8I01IAinrs2NSo9rMf8wOdk68Hj+uBd9hthwQgcZiJBmP6YEchXWOmUffny3TX9QBHW2SWA4E9io8yVWX60wqSrJOiaQtrVHp8296yf4kRWJVbfhh7EDNTu+HAcWoNcveKa6Hl7AMG1Yi8up7kvAKxu8u9U4uceDT/E50q1jMGLGhe7OlCEtOk5NPRmxutgcx5LjTNtUaSHYFU0ZSqBiutzK6fqaYzOkRkTP6hziJE2H6shkap0BC49b4gZNPVMCh9
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39850400004)(136003)(376002)(396003)(186009)(451199024)(1800799009)(38100700002)(2616005)(6666004)(478600001)(26005)(36756003)(6486002)(6512007)(53546011)(6506007)(52116002)(66556008)(66946007)(110136005)(41300700001)(66476007)(316002)(54906003)(31686004)(38350700002)(5660300002)(44832011)(2906002)(8676002)(8936002)(4326008)(4744005)(31696002)(86362001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6248
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT065.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3ab34520-c284-4119-8045-08dbb6019760
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nf4pFu6JiHWZIuw4fErCH+RcjhVj88DSft0foEkADv94axB84tL3pklRnpVsJVRJHFvhyci+WuXoPMc8KbLiFNIzNHSYfeOLva9JaJWIA6gjVI7Q862/MutC0eiTL8QPWCuEu8khv7CqyGlLLV3Pw1Fy1c3N/vQ5u0YJvP0lpDd5Pm3bxwwSNloJBEvqRpYMrSb8Q9mAamuAMmk25/0BdF5t39iktVy/mIZPCMWI3bxJTm6VJfJRvpmW+do3p9U+2UiSHhCBYyVhzc9uYRhblYg4+60pW1Rx6y0TNeIvSz+78kk+gMn9cjtYbrf7EbCwr3NMcCaIvIzS6FhsBpoesGXzHL7Ns8ZVzaCycb4/OtxknZFOdDQwpcj/jhQXbW7v4L/FKmr7KrTMk9a3bhs5ddxLUwyO9qg/HCanANEAh1cwQb8ypA5/pC6yzIk46ESTpA2pbPWG5cGPpY7g1nILZnyHdaQfRkwJeNDcVUfLDb0bdZLnCZ2dwvm1vWhfR7bmbcOeoLT82MfH7g8JC26l84/+6oMbPARlPOmRBQ6VyC9ThgN/8k71YIfDqoz/ihI3Gv6OzDqop8uveY4KgriDSDauY+5khJYBdkCXvuc7Pl9JGNlrQd+63Lqp0G7jgL5ta04BmenAFkKN7ve5YbPBt7yZ3KVHQQEueE0ZYy4/glybLswZQvIPnNSBOo+XUYYS4artOUeY4XqS7Jf1OPRyLf6DGNdtsBfTFGfJ6Ak5M7qcNfmdggReRDc2RlF9le3MACl3aMMxpsJKPAEh+dWGVQ==
X-Forefront-Antispam-Report: CIP:20.160.56.84;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:inpost-eu.tmcas.trendmicro.com;PTR:inpost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(376002)(82310400011)(186009)(451199024)(1800799009)(46966006)(36840700001)(5660300002)(26005)(8676002)(8936002)(4326008)(2906002)(4744005)(7416002)(86362001)(31696002)(36756003)(7636003)(356005)(7596003)(82740400003)(36860700001)(47076005)(34020700004)(336012)(44832011)(40480700001)(6506007)(6486002)(6666004)(2616005)(110136005)(54906003)(70586007)(70206006)(53546011)(478600001)(31686004)(41300700001)(6512007)(316002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 15:37:04.0450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d54e89-dbf1-4b2e-5510-08dbb6019c8f
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.84];Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT065.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6368
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 09:50, Markus Schneider-Pargmann wrote:
> +static const struct tcan4x5x_version_info tcan4x5x_versions[] = {
> +	[TCAN4552] = {
> +		.name = "4552",
> +		.id2_register = 0x32353534,
> +	},
> +	[TCAN4553] = {
> +		.name = "4553",
> +		.id2_register = 0x32353534,

Should this be 0x33353534?

> +	},
> +	/* generic version with no id2_register at the end */
> +	[TCAN4X5X] = {
> +		.name = "generic",
> +		.has_wake_pin = true,
> +		.has_state_pin = true,
> +	},
> +};

--Sean
