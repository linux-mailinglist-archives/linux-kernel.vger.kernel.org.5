Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302117DCCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbjJaM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjJaM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:27:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE9D97;
        Tue, 31 Oct 2023 05:27:31 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=IqQZninKB2vqGHEeBuomgvtjoOu2wXIjTdN8aK5yXkLN6/ZtXu9skSA83hC9cqyP9mLHMzRT/l+uZK3Cx1EFCvV4gRGrw18+1F93jylhO6QVcDbHeCXf3UgI8WFf03MWOF5pT7yWvmAeHVTWsiCCaGBzRV6msRaufif6sRpCGUeH3ud9BsBgQc45ou/NTiuqOWUi95om9qE87uuCrDLbg/Y04BO6Dzy4Xto0934Y3CU9bbqEKvg733Y6P8hvQpKW3dv7AJZGZ9kyPuITYBBpD3WXbRA00vGzsaMlhzigsAprhvg526F5uOE//CcFnd3DdsIfJG2LKwibBdRIAJixVw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mK4CcJp4+wmlvTuNwph8ardOz5tdSWbEZhLlMdtD1c=;
 b=nGnoXMqen6SCE17B7+j+n5Q9XoFmNX/0GSjLwcIq+z3lr4qHn6gjeb5Hkm1n5kdn2FCfjQG+tv0HNO4jHZtnt2mYeZJ6uTv609xWwHTR+dZge78FOP/OKE/1HwY8ER2N6qlmwm5H2pNUGGQiOtH4lWaYng7mw/bmJ2LcE2s7ZfHj69mIX84VuyBfZydW+/INcOEKImUZ0kWUOjhUXnKcZ58Qrwt4uFE8P93D4/Sz4OSexVTIjw7RCrQDzagNTMr6zgtmm++2WXAcp1fo5AdeYI+rLaGo4h5oF9scUP1+oTEPBxyiWll9Q9NtdxTZB24ZM17fBxEsbLv70wyjTPpvnw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=nfschina.com smtp.mailfrom=topic.nl;
 dmarc=bestguesspass action=none header.from=topic.nl; dkim=fail (signature
 did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mK4CcJp4+wmlvTuNwph8ardOz5tdSWbEZhLlMdtD1c=;
 b=Y+mHEaivWu9VK+DfA0r+184rLNIV7WYzl3jwrnbCgE7kSbo/ZgNF7KH+g/TBED07EQ3ZV2apgM4NAfBbZXYXqmRY3g9mP0BTxsc5EYRYxa7rCGKchojevWOKCongXeMdGrBt6lj9xcF7lThEs645H04cGsxVJgWnxCToFGcqUD/BOaVZ7Nnp82S2ubpcmLu2Va4DMenIKGDIC9GMGIiDGi7aQ/mzlJF2EImKmay3MwlaY22Ez5IvLJK7Sg6+uQRqzgX5ZEu0AfxR7J8c0MgdPsoBbBb7UiP2wurmfZzNwjeaa7iiqYwbyJq0tRMlFgcRjVlYQWMCkLIyGqmyXHZwEg==
Received: from AS8PR07CA0043.eurprd07.prod.outlook.com (2603:10a6:20b:459::12)
 by DU2PR04MB9099.eurprd04.prod.outlook.com (2603:10a6:10:2f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Tue, 31 Oct
 2023 12:27:28 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:459:cafe::b3) by AS8PR07CA0043.outlook.office365.com
 (2603:10a6:20b:459::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15 via Frontend
 Transport; Tue, 31 Oct 2023 12:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=bestguesspass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 12:27:26 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.233) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 31 Oct 2023 12:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUvAjiT/J11XEd6Na/T1FuD7wF8vxSW+6P5ohYfYKXa5NxygjVkaZVFsf7ty65J9Ra/q7xBouWwzy0PpDAH+FA/F4DkUs/dnCSteBXrvKlYgcqtF/QZwP+EQVBEOJZJv7vZvMQ0KZuu2P+ch/8C1VWMC2/1NMkYf0wC7Etjb5LyH4/4/NCrVtIdeh+wJ9GMiThRNe/fsBwbG6fRNUs+T9xDy2CdMuMQ2TtzOmDNPqGYZQd03P3FMEuvLKyTNQm3hTTSJKPwun6OV3H7qYn4HOV3FcqGmLE5lS6Ro+P4A6IfMNPyopxNWHmPMYvIx0Ia1lCS1LooU5cRBaZpnLWne8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAjAVGdx5QH3LxEkjOOgoV6ZqVizLXLnEfWGdPhjmS0=;
 b=oX3kvis1q3SImNv8I/2V4451bscMqBs41A2O7Mgz9oQ0oQNz+LshDI2igWy8swENrwLtIY0GpH9YVWLBRGg3vO8yBVLHvGqbwgZglxVpOAab5yjOpQJ36zBTXzAr4xVj/Q5b99xSFHLmmszUhyCtGgyLjme2CiMYKkggS+MikpXqsA4jSWmgbObK2y279teIIopPpZVtSbHTEz15wHw/seydX9nDau53sWRWEwZywWLsQnSCQLtmAJfJYfMehEv4bWR4YPfKzSF5BaGRs5yVTu1fnwCixGpfpBvmYPU/3qhnzMU7q5xBjCoPkeOBJsTDtCxKN/hL1rBSZystOQf4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAjAVGdx5QH3LxEkjOOgoV6ZqVizLXLnEfWGdPhjmS0=;
 b=uDIgxu0RDwlXw0+ywBuT4s3tEVvbqE6oZLzFzvbjsgC+fzgNyP9r8UAAlgB8vbldtuBhd2DlJWWRN+VY1tqRlqYsj0Y0fMQLtjvi9wZ/DPFAVtJZ5Q0AwszFzvqx4e2Jdf0PQmZu9JKZ77CS5prTYqVnEQm3R0I7F56/o/aillLGPQ/A8VwJ62cxT5gYyF6vyGeKmtFFWwuE2NeHMWMv6vaVA2kVutv82Om7v/+Dns4vLDFYbIg5c5BhcgXz5OUeN/JoGHuN1S3CUlDsvhVk3Bgdb1ndamO54BSEBKoWm/IU3QbNydrKqPxpwwNKBJnN9mTp8zCJFazu97esQmZsRQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11)
 by DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 12:27:23 +0000
Received: from VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::e398:b6ba:35a9:cde0]) by VE1PR04MB7471.eurprd04.prod.outlook.com
 ([fe80::e398:b6ba:35a9:cde0%6]) with mapi id 15.20.6933.018; Tue, 31 Oct 2023
 12:27:23 +0000
Message-ID: <b5b3abbd-1551-34ac-65b4-4fb14e24d3f2@topic.nl>
Date:   Tue, 31 Oct 2023 13:27:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   <mike.looijmans@topic.nl>
Subject: Re: [PATCH] clk: si5341: fix an error code problem in
 si5341_output_clk_set_rate
Content-Language: en-US
To:     Su Hui <suhui@nfschina.com>, mturquette@baylibre.com,
        sboyd@kernel.org
CC:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20231031020159.587686-1-suhui@nfschina.com>
Organization: Topic
In-Reply-To: <20231031020159.587686-1-suhui@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::11) To VE1PR04MB7471.eurprd04.prod.outlook.com
 (2603:10a6:800:1a7::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VE1PR04MB7471:EE_|DBAPR04MB7368:EE_|AM2PEPF0001C70A:EE_|DU2PR04MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 4338eca5-4d78-4af9-607f-08dbda0cbe4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LwVPB9zk5oLmykwmRAbu3Q/9GIBrS8wbs4KcFV2JOxwLgnv1x/DSogOLOyb3/a7JuwkgOQ0OF7j6lUXsmof1zHMXo4WFfdabwKVQWLkHrWxFA0UXNcQQ2v34OGyJ1RFyZdlC7KwJXJggUOyQDrLUCUSyRfVxkA1qWqvIhfIwnmQYxF1rr0YsoGsDhD68SP4BvGYcg50/6WESElH4o2TI9gbPru1KbHou0DfxrRRW1R7/KaDH6CYD4olNv8uEmdK27NOzNlIWaCWoKktfoEtjYb806bc7/x2tMevT7mcMHkupC5HGpVVAZBURSb8ccOqS8vKej1i9uBNuD9/t55fBaTMaDaFR9TU/UODun5BbA9RLBGKKcbfPzwdroSThKVwdyM6JL/fhf3PHTLMBxFi4M1ARIoMdmf7jD+ctYesdayQprBbPUQRH4an7HIeiTF6g3s6gAQ983NDhHaWegd9xtplvlYB/Fv4dSbQ5sZ61KCo7+Jjn0E+yeEMRPLirlSB+3It9JGAc9OyNRr2j5T6yfNCnq2enrB1Ncrozs7ndgemsRoE7F6I8mOziws4Vhwia032SnTwpeHxwAqBjmnfBQH8orj0U12bYTp/gJDAcJlU4PzSJsyOZapxfLfjjwupWHMiIDXbVw5nRwEVXe5F1HQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7471.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39830400003)(366004)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(26005)(6506007)(2616005)(6512007)(53546011)(478600001)(9686003)(52116002)(83380400001)(36916002)(38100700002)(2906002)(6486002)(31696002)(86362001)(66476007)(66556008)(316002)(8936002)(4326008)(8676002)(36756003)(41300700001)(66946007)(15974865002)(5660300002)(38350700005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7368
X-CodeTwo-MessageID: 0bd4834c-02fa-4747-bae5-8da0e61484c3.20231031122725@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1b730248-a5d8-4c01-ea79-08dbda0cbbff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ephGz5ozVnNksIX87Sxi9fx2p7g2HJie59wndjAtJnMLYAnjPhu5Z9a4REj9FBuCTkkLD79GBSyKh1SzlGGFEBQrE3dBxFrct1+JzYRuyd7mkKj3uSOlxG9ggvwWtYefCzEmiNXOBgfCb0+WSocE74JJRd4BSwLP2JE7TMlOhPmJz79iJhzLhbocBn+2V3W2MMcEJRQtKulevupgxCqg/9pZndDsE7yLOmqdVj9IAHENCewVHKcoJzarQu5UvXdHZtl6ff78hwJWDr1LGGwVJFPrGAfTQlyZIQaQYq8+1o0ZL7Z9EtTH/gS9l6mXLr3QlEXN4/h0wouYHSz607cZNAs25hr87iA5GEv0odi/2N4M29DeO7WGDrTquwB7QKV+yD0B0Vc9l/lcTzicUt3g0ot1TKDzkcdFKfAiUtRNV3jgYXIHL7bFsN0nIaY4ctDRldfeHOErbn8EdGdWicyKMTcNbRl4MCDckH6F+N9aES423MiWP9zlRlsjVXJYfWUCumsvJTHO6Czo61oqMSzgN+JjsJE5njPZ/y/bmqsoFJtLlcEpgRaqL+Fbj4Jyp9YuSQdxMPxR3/XReIae5seiX4Z5055/bJF4PgBYJ+GJS+2r3wUbYr7tsp2GPShUIwSiN/AfR5FykTv+NfRBR0mU0VpSULeQr3ZG4suKQKPDNf73/M2lTK5Bwxm74Whusl2YcKY7STejwGhUtjRHGrVLq3XczGsEaNe+hlvtVap9OrCsqv1ejwohu3D5VAZCl1GJuLI/U1q96b5CWOjmYpJXg==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39830400003)(376002)(136003)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799009)(36840700001)(46966006)(356005)(7596003)(7636003)(6486002)(70586007)(70206006)(31686004)(47076005)(6512007)(53546011)(36916002)(6506007)(36756003)(478600001)(26005)(83380400001)(336012)(2616005)(4326008)(316002)(8676002)(8936002)(5660300002)(15974865002)(40480700001)(86362001)(2876002)(2906002)(41300700001)(36860700001)(31696002)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 12:27:26.9727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4338eca5-4d78-4af9-607f-08dbda0cbe4c
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9099
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, you have my gratitude...

Acked-By: Mike Looijmans <mike.looijmans@topic.nl>

One remark, maybe just "return regmap_...." straightaway and skip the=20
"err =3D " assignment.

M.

On 31-10-2023 03:02, Su Hui wrote:
> regmap_bulk_write() return zero or negative error code, return 'err'
> rather than '0'.
>
> Fixes: 3044a860fd09 ("clk: Add Si5341/Si5340 driver")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>   drivers/clk/clk-si5341.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
> index 9599857842c7..9b1cc5a83b5b 100644
> --- a/drivers/clk/clk-si5341.c
> +++ b/drivers/clk/clk-si5341.c
> @@ -898,7 +898,7 @@ static int si5341_output_clk_set_rate(struct clk_hw *=
hw, unsigned long rate,
>   	err =3D regmap_bulk_write(output->data->regmap,
>   			SI5341_OUT_R_REG(output), r, 3);
>  =20
> -	return 0;
> +	return err;
>   }
>  =20
>   static int si5341_output_reparent(struct clk_si5341_output *output, u8 =
index)


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



