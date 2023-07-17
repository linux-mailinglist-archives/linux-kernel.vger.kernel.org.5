Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCC87569DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGQRIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQRIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:08:39 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF7138;
        Mon, 17 Jul 2023 10:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nt7Jaf7Spx5bCnjQnZeCpfusEGnpxAMuEv9FwljPci8QpHtStCAPxoSQioA1gg6vbijqRGmxnc+25uXIvqCH/g9m4Q9C+DuWQDwaeFXN/VuP9nw821OjIcG3EJTvp9BQpM1QI0p/HXA7iGUsNIDXfXvO49EXRPTLPHUSFVj0SM7s7XXDUQL75PUlilq9o5Xl9JKr4TDs3UFK0shJv6gYmniPaXJfl9sCahcwbvDW+Q4MYO3dMyJ3skFDYlT0BXnhFaZtpM3+cJZkfIftlcLPekrVOyN23oUcxJUZWuDaWzohQsIrOELc8xAraG3GDUBzNUC+59Ql0dGYGtii/7aNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LfpDK3BfomYl6+Xz/O2GvGCKFe96WBKfD0Q3s+HwZU=;
 b=aBn33RrcGupFDpzWudXQiqq6NdARiSj6Eh2//NaVUg12YkBtw6G52ANzhHftjk4ZSdAekx8Z4+0yf8LMQ8wGlZ8uA54gmC3u7tXToh4Iew3Uenz2h+eY6DShA0q3oV9TrBCt/+Naf6R4Z0SlP+N38OL2mIlckDJLCdsnq/jSIfvNmY/alePoGlYHTR8uljbh+bOBM/15v1ZIIAf3a0jqcx/CZGa0wIwDCh5MKERxfpWIN0efL6MAbSbuYsld1AFTUfDxAgSASUFKgZzRdttiDehKz6rmcGDfQi8xPFUmi7U2AD3WwYYQqtQxGTJXZOQeNoi2tdNqa7wqMUACrJW9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LfpDK3BfomYl6+Xz/O2GvGCKFe96WBKfD0Q3s+HwZU=;
 b=OXwjRw+YZkIZKD4Ww+ZFZFVSvdOmKaROi5Xri7V98dSo3ArKzz1A6chEgeaWghukfYX7vWLFmelw4J+kOL8+O7QQbxOsTFjFWHTf/ECBTFGFslo6bwj4rX1vZhSUvPAOIS+KHrDs7/sTr3QrlGlfvqsUPizIbSDwQYmRJaadE9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3875.eurprd04.prod.outlook.com (2603:10a6:208:9::33)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 17:08:32 +0000
Received: from AM0PR0402MB3875.eurprd04.prod.outlook.com
 ([fe80::4589:8294:101a:39a8]) by AM0PR0402MB3875.eurprd04.prod.outlook.com
 ([fe80::4589:8294:101a:39a8%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 17:08:32 +0000
Message-ID: <06bbe95c-118a-0e19-3480-49fc42f3dcb0@nxp.com>
Date:   Mon, 17 Jul 2023 20:08:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] caam: init-clk based on caam-page0-access
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230710053418.2406915-1-pankaj.gupta@nxp.com>
Content-Language: en-US
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
In-Reply-To: <20230710053418.2406915-1-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0110.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::7) To AM0PR0402MB3875.eurprd04.prod.outlook.com
 (2603:10a6:208:9::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3875:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fdf632-1a25-453f-648b-08db86e872f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVEwuOwGdChYYzP7Nam4z3GWl0AK+7yU+EnUQNzkhsI2V/5FQzWj4zVSHBM1yCPoR5LX3pFHe+kn3nu4pnS2Ml3pgn5pagEEM8TyBFrZ8BcOKVedO2ULCSVKqHqizih7MLAjiyF0hdX139Coc9CmkXHQp1TfGcARfcaRJdpQT+WqKvHeP6/SZ8e9+meUCTvZP/zZFVrqoogYQV0FmwTRNbk5WV1/j0N2HzZsYDIsPrDGXcRbYecHiOgb2FTOGW8FOs9hw2US8vA5Ixm9eZRpweZNwEZTI80GsgKdk+SWy/xfEJZQvgaeA1LkKNjB2kkzWL7TkcFSDYW6uOgzoNuHjXi10IKgc4m3WLnwFK1uOQQn2I5KZlG0pVuu90XvocduJ9awWQjDb2Pzh6aWNTvvroEjZsDBbWEGoc0KZzr3GjjtZrR9WC0dTaTEe1DGX9NzIvCeWh1jLUOyPeYHovdaw0ZXgxub2aG93WIVaNSEPDy/JY4eEgB3EWZh1KbX6PM6dpPsM1G5fHVruk31c8W2T23atmr5hMxIZAGbhYhOimfDemHPMXzhjYr6JVgaQiVscBo9NieDOBm6fHyC1hQCKS38slJ1QdwraI6Hw5kg1cFx36Zunjn31ju8qHzSSaMMozC1imPGHtn6qB7ODgFVAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3875.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(478600001)(66556008)(66946007)(66476007)(54906003)(4326008)(5660300002)(6636002)(316002)(8936002)(2906002)(41300700001)(4744005)(8676002)(31686004)(110136005)(6512007)(966005)(26005)(6506007)(53546011)(6486002)(38100700002)(186003)(2616005)(83380400001)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJ5RnlGWFI3OHBWVlp3SGN6OXY2STJqSmR2M1ZOSkdVZmxFaTBKc2lVY3VH?=
 =?utf-8?B?R2JMSkJDblovY2pPdnpsYWRoNjdxZVl1TThwRGxMVDVJUDdoRXpTekM5czQ4?=
 =?utf-8?B?OStkWnhGYVg5ZWhmVWVZb0JQSHhaWTFHcHVEMThvMXI2KzJjb2xhVWYyQy9j?=
 =?utf-8?B?ZXNFbStrWjFDSW9Pcmc1RWVUazNhWjdsS3JtbjlvVlRndUdqeERLayt2L0F1?=
 =?utf-8?B?TUZ4Rkk3WUNQMzZzWFBNUE95YjJ1KzdNMnVZZmdsUVhNT0FVcWVqZWdXeTZZ?=
 =?utf-8?B?TllCZkVJVXFsS2txdG1BRG1ERy94YzBDaXEwdTAwZDk4UEdnRmFGVjdiT0E4?=
 =?utf-8?B?YTZFMGQvNFY5cERBZGl0VVNyVWwwQWtXcVVJWFNsVUhka3pWRXhJUDllcG5s?=
 =?utf-8?B?ZFlwZXB6blBma1p2aWYxaWpwWWt3TDNQMGRkNFhBejBDTXFXY280dTF3OFlu?=
 =?utf-8?B?dlZYWGMrNmJvVTNJUzhLOFBZWXZOSDdlN1R5MGNvbTZuNUhPZkRkWm0vak1l?=
 =?utf-8?B?NEE2TGRXeCtBNm1MT3lEVU1mUFhoQUNHZ3NnRmM2dVYyRVg2MFNkc2ZSL0tk?=
 =?utf-8?B?cTRpNEVEQUU3VGErTWhMWkNvUWJ3YTN4M1UreWM3TzZMOVlZZFdDUjFjZnpW?=
 =?utf-8?B?OGNCelhhWW5mVUVWODRXM0dJTGV0S2Y4dUhQMmhOcldQRklJd1hiT1Z3YzBI?=
 =?utf-8?B?eEhLbHlYVHNmT3NqWi9jZVN2QlBxNkQ3dEkrWnFsL2cyRnlwYys2RVRQUnhL?=
 =?utf-8?B?MW9Ea1ZVMWs0QndtYythL3RSakszRWY4UkhVV1BUdzkyYng4cm5UemFOaGZx?=
 =?utf-8?B?RGxUckdwRXFvem5XNXJPUEVIRENkZ3J1cmN4UTJuRVRLUnVvSzY1NmN5eGNZ?=
 =?utf-8?B?TWJCaitzQXJzc3dNVjNXdXVaWGZGTWZTUGF1bTMrajlRNmlvRDZIUTlOY1Y3?=
 =?utf-8?B?RFNHWXdoTmt3cytWMUUrcWdKTkpaQWh6aHdLUVV0VG1SbVZKcHdidTFEZVdx?=
 =?utf-8?B?N1RwdzZFQTlJTFJoQWtXZkdsUVNZUHBKQVJVbDFNVEpqMXhQOXhPN2lZZmR6?=
 =?utf-8?B?T1gxVHA3aGU4WWtNbW9uWXhjVzJmUUFLdnRxV3N3MWtrNk1lTklRUGRETHdv?=
 =?utf-8?B?VmNQbllrZVNJMTNsWnNmZVVqa3V5M1lWUnovYzZsc3MxK1p4dVJyNFd4Mkh6?=
 =?utf-8?B?Vlk1SXNZbVl6bDAwOFBGbG5KRXdzblZIQzdhUC8wclZkN2k1c3h2aVpvVHla?=
 =?utf-8?B?RE1NMEUrSW5QRHAzVWJYckRUZ1NSRy8xWFZvNmdROUZ0SDJPaWx6Slp6R2t2?=
 =?utf-8?B?WW9WQmpOZDRlaDNEa3hOc0trWjhtWXBhUnNhZWI1dngwbWZUZVEvZi9uVUJh?=
 =?utf-8?B?Vlk1S0lucXlrYTFmaHkvelFML0FESzdSWDVFU0NCOVBXZHJaUVY1cGZWd0hi?=
 =?utf-8?B?T090WkJWSVhvMElmRTVaTWNoRWJyWGk2Mk9IdUUxZ2xJYmtIcUNmeEpiZjNm?=
 =?utf-8?B?UTdwUUpaMVc2SFhDRTNOK1RyRjk0TlJrTXcyZUNqQnJOTk1GbzJJUGlDM01v?=
 =?utf-8?B?UHI4bmk0Z3FSVXpRSVFWR2cyekJvNXhneE1FNGFrS1RBU0xuWEduV3RZZ2Fh?=
 =?utf-8?B?K042a3dpZmpHMnZUZUZvOE5WbmVnQ3pPMmtOdmY0UGFYeVpVQkZQQWdaNFAv?=
 =?utf-8?B?aWF4RFowWUt0SHEvd2lxRzBrWTA1YmRhYTEwcWVaQVpodFZHZlovYzlDMlpX?=
 =?utf-8?B?QzFSemNIM3pCS2pZVi9HejJ1Qmp6MkVKR052QjgwZEljUEk1RzNmTEd5U0p0?=
 =?utf-8?B?Y2hFYXlKUm9VU1Z4dnA5YktGbVkxc2x2aHVMTmpKTWlDVExXUUZaZ0ROVkFQ?=
 =?utf-8?B?Z3kwSW91b0ZBTk5pL3NWTE90ZUIrdzVXRXBHUTR2Si93SWVkSElvZFJFOWQ1?=
 =?utf-8?B?S2Jzeis4SmhFWEM5SWlmVU1JTHpHalluOVg0WklFaDJpNjRoTUM5VzZoeEU5?=
 =?utf-8?B?YjJnU3Nxdm1Tb2VmSWxEa0NDSk02WGR6bDNVM0pITU4rWkZGVEpJRVpRREZm?=
 =?utf-8?B?em5wb1REWVg5U1RGNkpqSUtabnRtdHVPMUlhU0NpZjFsWGxHSXdvSUlUZlo3?=
 =?utf-8?Q?Jhw+8IFvkfGH/paIbyhODaqWk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fdf632-1a25-453f-648b-08db86e872f8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3875.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 17:08:32.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CibVioUCfKAMbcVqSGdB6gVlj7vZR+vJcWC8hE8Yp/P2pRJFzgFxSt8eeAPm+2GKvtNOJVoidV25LBfS5WOX/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2023 8:34 AM, Pankaj Gupta wrote:
> CAAM clock initialization to be done based on, soc specific
> info stored in struct caam_imx_data:
> - caam-page0-access flag
> - num_clks
> 
Any specific reason for deviating from downstream implementation
(based on DT)?
https://github.com/nxp-imx/linux-imx/blob/lf-6.1.1-1.0.1/drivers/crypto/caam/ctrl.c#L911

Thanks,
Horia

