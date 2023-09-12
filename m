Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3424D79C6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjILGc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjILGcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:32:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A6CAF;
        Mon, 11 Sep 2023 23:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtYGKtx34gS04wU0ffWX3ZFbTce0cEvHGck/Ces7BDUKE9XHU3cCvEPikBWKzBY7R4XgbJ0WOAfyg/BauhpXTWqj/hL9yxAhE5IVRyP9xupfwBHgQW5Nx8qnSAQfbMu5ct5i0ruUoRfIjYZcTtPbvEuvh6mm/qrMNM9khi1nrddem6Zr60gM//Qws3Axv/rI8fNxHydMAIWKTQ5jF4N6orlTkjvaRwGz5/a2OjelErX6ioSJAFVWL2c/c2DD0JvPTC7XR61dsHisHaNzCdPh3BI2eQdHWjXZtFrhM2QfpPs/I7DgnvjReBMiALf5g1VLMLSPrTZx05zVmQOy9dVgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8/7TbSDxd8+YZDnc6cKxAqjNxGRCAWQoKRxG/Ixvo8=;
 b=hYKmjFb0VpR5bfgl1T6D4VFkhZaJSVePARYVYXnDSR2q5aD440cSQ4uKWAcYL++2ioT6U/yFwYxoP1I3swa082AoikoS4xOvjy6oPYP4WT3z9WPJvCbM9diWDq6+v4B0+5jq/hqJV5fJ09V+kyOcckGGFGQAzw8czWw2WV5NmaAkLa+1MjjV8UiM9bifSUy8+9ceg9S6v0TrNQYoFF2ZwTVYy/IBjAprtMZNfzEC0fidGyvMVc8OV9gW6cSY7QznYGoCBadR1mxrrajIpa6DX2hkVWusyvde+gt9bX8NJV1+Rp7vdvkarfmwJd9qdmChFi1/x56R0IeQ1faSC9N1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8/7TbSDxd8+YZDnc6cKxAqjNxGRCAWQoKRxG/Ixvo8=;
 b=F+e8JwCC4rlQrpaO9nvdPgrZw+ryMPD3YpYun53IUSzEhsSw3kCmv9T8mlGwyK0aUBzNWoTIUILHBkf+LcwJ+ygFv5+F2aFe4oe99brYpkG4FWkWqQVro6AOdVFeAptda94gY2thPQMLXz8B8nxuqOE6UpVcMovw9fRlhJeVy80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8521.eurprd04.prod.outlook.com (2603:10a6:20b:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 06:32:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 06:32:45 +0000
Message-ID: <2059cb67-241b-e236-9a97-195a327828d6@oss.nxp.com>
Date:   Tue, 12 Sep 2023 14:32:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/5] clk: imx: imx8: Fix some error handling paths
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a9b1b4-d08d-4518-da8c-08dbb35a12a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQ2qRddylfLmazD+uHWqUIrSbIzwKhlFjXjUt7NWz9obb7elGiv9p5OVFldlphsF7MGrttrv/IP8GEOMTTY1mHFJUjVJoLWDyWRVxap1YOzztnIzo9DcKzfJ/SHkSCXAd1HcJLe6hzEu236GzZG+BLGFOLTyS0h/EL8301g/pzC5pvPDLqwvLsLz4CoeHYR97h8F4V18GQjb0HoJUgJO0cJPswv2IPPpDftXRXtcPRHa8O6saWCG6mqABxTsserOCP40YlT37IuLdfZAIbWsHINgUCNP3v53GfoMtBEEBVRodZ0EiukzJylVu/HSyLp5bnnZtQH+isWky/2ZqtgR19S/is7YqB/me+6Duz7rUelQhAf1rW3hvRUGMt2PBPAkgWeR5bXy6WhAoQymFroqKuzAbv9AJYaJYrAjDfWcvFHsW+Jcj7SG6wCQ4rRA0pdRReZabZ/GgdH8l07fCN2WbmeCbgz0QLXhS+3T0ZyJDp8X3SdySoajq0CNntcgXpsZvSs0/mhrTwuHPSmWMJXNhrMZOqFbR9ly0oHsY8aFEeGZGh/hR84tqoggyofGAeiJx8DidxTww90KQkqpUrEXAVxtp6trgs05/+OaPh/mzjWpMmzllV3deLy7cup3mMETlY5D+8K69PoRZPK7OwlhLD7Hr6yhHCXZ8rMBC0taJ74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(186009)(1800799009)(451199024)(53546011)(6506007)(6486002)(6512007)(6666004)(83380400001)(921005)(38100700002)(31696002)(86362001)(2616005)(26005)(66476007)(2906002)(66556008)(7416002)(66946007)(316002)(41300700001)(44832011)(5660300002)(8936002)(4326008)(8676002)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXdZYlIwK0loMDFQQkVrU2dkR1RhNTA3VmVoNW04VU00Tk13cVNQRVRsaVh5?=
 =?utf-8?B?RXdTcmVVZkZZNG1RTWJBd3UvazVML1pOQXlMUnhYQkc0cFR3UHdYeERxY0hQ?=
 =?utf-8?B?TDYyN2ZCZkRLRTNLMnJWVWVtMktlZFk1bVI3OG9BRlc4bGd5dlluOVVCSkR6?=
 =?utf-8?B?SXg2K1Rwb24wZkVZdW9MemZNQXRIeUJvTWlIOXBTS0FiZWxoWnJTTkxzZHla?=
 =?utf-8?B?RlJWZ3k2cU13d1F0Y1BIbmR2SDlRWXlLSUIyS0VoaDk2SThNK1pnMjlpazFy?=
 =?utf-8?B?VFgxaVE3Y0lmOUVzZWVGZ2ZtUGtzR1ZaM0xHdnlZTGJNMHJsWlR6NFRFYVgr?=
 =?utf-8?B?Q0JvNkl0ZkdocXZKM0dyWmpkOCtpZzh3Q1RVbm52WTFRQTJhM3J6cUN4K1d0?=
 =?utf-8?B?Njh2YVViWHJDNm1Ya2phR1BCTnI4SktWN2ZIYzJkem1WdkFyTWtEZ1YvQlZJ?=
 =?utf-8?B?clZlVklTMnFNb0k1QXBqN25wZjdXV2FiUGlNcThNWkNkQWhOMWhFcDJVWHN0?=
 =?utf-8?B?WXVmRmM4UUVyMThkM0s0ckFLM1NFT2VjeXBacnNPd2xNeDBzRzFTN0g2bVpl?=
 =?utf-8?B?MVBsVlN6ZEo5Vm5jc2h3OExReE1NejVVUkNLNmVYeUl3Y0g2eVJkVTh3K2JD?=
 =?utf-8?B?ZHdqTi9sY09tY2h1bnBEOFZBbXY0OGhWSXVObXpyRDhEVGNVMDlWcDEwanps?=
 =?utf-8?B?ZmpCYTk1T3NwL3o3UmNsdG1nVmx6YlZqcjB5azVaTXZiMDFRM3JMbCtBNEt6?=
 =?utf-8?B?T0hCRU9YLytDV2NYd1ZZQkJNNnRGMUpJVU41VjRaTCtDbTFpMXZFb3pMZ0pu?=
 =?utf-8?B?cEpTUmF2VERueHRkQjZ2TWF3OUJqNStoZlIzSDB5RjRLNmt3N2JhcDErb2Jt?=
 =?utf-8?B?MzIrdGhyMElJbU1hZEVUOFU2ZXJvSzBxUklEMmk4Tm5qczV0U0hVTXA2RXUr?=
 =?utf-8?B?SGtleVp3YXNEM1RDQ2VqS29ONlJmQ2ZGMmloR3ozK2hPR0pOU0w5bEpyQnQz?=
 =?utf-8?B?dDdUZG56OWJGOG9VTlp0bnF0TEZCM1NpYkNRQlE4M2ZsUFQ5UzFCcVZDQmVF?=
 =?utf-8?B?a0Flc2xEM0toRU4rSHlXamd1MFBaQllKN2FLLzFBL1ZCL2M3aDIvOXpVMVUy?=
 =?utf-8?B?YjEvTGpxNWxTSzVIMGtDdEpxT3IvTTcyQXBUejl4WjNVMW41WTBzeWxaYmha?=
 =?utf-8?B?MUFaVFg4aUtMdEVSdmRuWWFhejkrdVZsbEZPU0crdnZmWTJzdUVGaS90Umdp?=
 =?utf-8?B?eXVmY291b2NlWTJ3RkRRbU5Gc1ljVVlFRU5lOEQyU0lreTBDNVA0U2s1eFNu?=
 =?utf-8?B?QjJFUnNrME9XWCtFTXFUYkx4c3gxVXU1SU4zSS95YlBJUndNTDYva2lZVGZ5?=
 =?utf-8?B?TUlkMjRGNVV6NHB4eTBBaG9tTjJzcC8rVzNTUGdsVWMzMEhVTmZaU1JwaCtr?=
 =?utf-8?B?WkttOXJydExoUjR6MVo3ZURBaE0zb0NVcXh4TmZYNzFGd3ZTdzNsOTI1ckor?=
 =?utf-8?B?TXduOHlXQko2TTA0RUt2SXdpcTdoQlJ4NFNjUXd5blI1RFNIcXYxRFVRNXgv?=
 =?utf-8?B?cVhMaTA0SFpVWHZrUTRXYkRJeXVVelBTc0JMYWtkanVBZUMvb3c2cTFXTGJE?=
 =?utf-8?B?T1FocmpiUldsOXZhUW5xSExzMFFtR1UvSGt5RElKYUg0WGV6VlEzbW9mc2Rp?=
 =?utf-8?B?OVVCMW05VWE0SVd1T25WM3lyYWlJQ0hBQWRBMURXYlZZWkhDdjBFaFF1cnIw?=
 =?utf-8?B?QnVDS1hqU3FVcklLVnNIYWxOQUJRY1hQZ0p5NGkwMko3NlRFVHFjZjlUQ2dz?=
 =?utf-8?B?WGh5eGQ1bFdXdkphcWs5Qmo5L0ZIWFdsVHZ3ZUovUFFwZHErZ0t0UE93Qmhw?=
 =?utf-8?B?YlE2UHRiL2lyWnlseXhKbjFRcGxiK3dRYXRnVlFSMGNHSGRrNUdSN1dPaXRD?=
 =?utf-8?B?eThoUUoyWVRDdkVFS1hNUy82RlhyYlJwcGQ5UTcwaG4reEUzSVhEenJOdzda?=
 =?utf-8?B?emlsSXZ2bVh4cVBIOFYxVXIxQzJhZFNHeFQ5TWFmRW9qRllKV3k5bjlTNU15?=
 =?utf-8?B?ZmN2VDh5YjRqaEpSNHN3ejhCbUZyV3ZwdGhXa2VTcjAzeUZEcldEbmxtbUMx?=
 =?utf-8?Q?gw9Sl2tDdE0S1YJV7EqtCQQno?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a9b1b4-d08d-4518-da8c-08dbb35a12a5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:32:44.9468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1Cfq9Oxi9MHj7Tv9h3OqG6Wg3kCVCXXKtZd3dB/zfqL2OYshtj/isazkR81MyEGIPy6oz6D1kysbzhMlR37Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8521
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/2023 5:37 PM, Christophe JAILLET wrote:
> This serie fix some error handling paths. It is split in different patches to
> ease review because the issues are unrelated and the proposed fixes are maybe
> wrong (I don't have the hardware to test anything)
> 
> Patch 2 and 3 are more speculative than the 3 oher ones. Review with care.
> 
> 
> Finally, I got some problem when generating the serie, and some patches have
> been hand-modified afterwards.
> They look good to me, but I hope have not screwed up things...
> 
> Christophe JAILLET (5):
>    clk: imx: imx8: Fix an error handling path in
>      clk_imx_acm_attach_pm_domains()
>    clk: imx: imx8: Fix an error handling path if
>      devm_clk_hw_register_mux_parent_data_table() fails
>    clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
>    clk: imx: imx8: Add a message in case of
>      devm_clk_hw_register_mux_parent_data_table() error
>    clk: imx: imx8: Simplify clk_imx_acm_detach_pm_domains()
> 
>   drivers/clk/imx/clk-imx8-acm.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 

LGTM, for the patchset

Reviewed-by: Peng Fan <peng.fan@nxp.com>
