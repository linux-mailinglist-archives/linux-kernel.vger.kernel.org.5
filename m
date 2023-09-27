Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62D7B0F78
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 01:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjI0XIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 19:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI0XIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 19:08:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2116.outbound.protection.outlook.com [40.107.20.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCF0F5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 16:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIoTqUtfPVkDhKz0ZuKxiNC9oZf230F9siw/WGp6uhTiJJcOFY2ZONP+QX1DXJxXIKHWTeZvUoWDU5YxczRm6LDsBz08UhdZoN4To9q9PwvjMvnNQ3t4XvCp+yTxN16lFyJyygKOjAcUoawEwzrzprP3KJz6WePjDlhJsYNrCbZMYpsO3lbTKxMJxZMcXWbeQ0opO65vtyuFObiJwhIa47vZnLzOes9BYN7E0RemjRWlsMlycvpCzRBnYbrON/VSTIf25VgdoxOY9DRqoujEWiLx50gV7C5SX4eKgcFu4HllKtF+TcDBD6S7BBXsK0era5sJW5h2Ngro2hwCgM4QBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyxvtX2ce53hpZ8UQtOMQLc+US73nX3ZKpumVZVXcbk=;
 b=SGx+Q8+R7dzd4h5XJAQ90cM8Xn/+E833oITU0qkuA+9K8psA8ayMf3FyUnJqxi4G5xrPEMgDBE9SADHa92zparzV2tKSUBigCTn920bpAdSusYZ7OGRxsFghmzIVkbRW3852Vo5CLvZqnOpr6+5yQpuoYZVAPjiO98EQUwiiQ79RqQXLdhvAAY3nMw+HwqGTtjqkSSwfl8+dvio94Buosdxq6JL7DxH1zuWLY7HFJHKsKzHuKiDI4SRvqvBL7YwlddZNEzQBmHcQ3LjVErKg0ZH/UJ6Ta2xaO9Jve2mZNANUYPlot+MLpC+2sc1+6AxC150vAQQRM1P2ZpYoviGMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyxvtX2ce53hpZ8UQtOMQLc+US73nX3ZKpumVZVXcbk=;
 b=M5YlJxLn2gOfltWcsyS9IJaMuO2Qzu6+j6UO4Nzo+02nR7tQbHjCelotHQEQfb5LAdUeUCTFz/bJ+mMoQhNWuKVYhC9hcItWW55rmLrj953OEx6WEebVUQdOfBT7d01L1pn8faoETzwjyHFWyUe4hJj2UKjNmwstz8ozCeky0gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PA4PR02MB6846.eurprd02.prod.outlook.com (2603:10a6:102:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.34; Wed, 27 Sep
 2023 23:08:28 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7b40:7a7d:595e:623c]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7b40:7a7d:595e:623c%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 23:08:28 +0000
Message-ID: <aa4591dd-b558-3401-4a19-362780ec321f@axentia.se>
Date:   Thu, 28 Sep 2023 01:08:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mux: Make it possible to select MULTIPLEXER if EXPERT
To:     "William A. Kennington III" <william@wkennington.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230926230712.516709-1-william@wkennington.com>
Content-Language: sv-SE
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230926230712.516709-1-william@wkennington.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::25) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PA4PR02MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: b6305d9d-7643-4bd9-e40d-08dbbfaea88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cHqSzHqOnEwvth8nvSy6pxKj8nw2ltcj3xBtTSkVnA1dCCAs2UtFwi75hTKp6mhNeM37NveTHiEXd/VX9KS10ieUqU+xuAM4D2alJ27GTj5DW+cCzptIh8vGvs0WpW4B7ZkY7vBErduKIx8xG+2sCARPxtFNArpGmtsIukrQv98zSlHmO4Tu+jZUcF1+M82ovaSezysM+nA6UO1Er5ilffcZUDPsCkKjgdAqBuE221eGwpAWyaQmzMguxJcd0ILfKACeYUoGqNvqW3TkzqkagqtKJa3QwIhk+Mh94/8gJ56jl9NKEmFc4mz9NsZ18vpOCgsVmgV1kfsANjrSbkeOLXQkj52Xo6G50/35J7VpQSJfgUvGbAJ6fia5U5SB1C8/SzmkKS7oq5zl73lfpFBNdtt77kmMSTbODCmILxocxyLeLxU416pCSXajsdVfrvkZo+RnCdped+jnYyEndAMLhPqUQIOsUyQQjffMDEGPB1gT6L8DpMx/JmosLejsJU5fgrWYqXnTKmiTz0YC3WUAvRyUBjtJqZc4EL8dhaxPDSQawMaRDStOX1kkMjjUEhoCj0DN7BgJdL/v6cTaTogAJVXB1QEtTvYy/jlNmPQCLh7cpKvLH0mjKNRLiHKO/4lOPjsrF0JepAZe7KLBk4VQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(83380400001)(4326008)(2906002)(36756003)(4744005)(31696002)(86362001)(38100700002)(66476007)(6916009)(316002)(478600001)(66556008)(66946007)(8936002)(5660300002)(8676002)(41300700001)(26005)(6666004)(2616005)(6486002)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1VYY2RsWWFEdlZQRG1xOFBVekVHNmZFU0E2aFA1Q0h3eUZOZWxmWUhIRVV0?=
 =?utf-8?B?YWhRMnFMVkVUSW8rYWlhc0FJaUhwVkNyTWFpSXE3Tm9MbCtydDZPWXlKZVN0?=
 =?utf-8?B?dUFOU3l6L2ZtY1lJQXpzZWtaNEZ4MmhuV0Z6WFNYeVJvN0VSMUx3SUdzQ1d4?=
 =?utf-8?B?ejVlSXJIY014blE2OTltUUpqTEFoWXNROGRkaUFjU1FWNVJVZVI5TUtkN0hl?=
 =?utf-8?B?SXFqd0lTelZFMm1MNUt6QTZYaURHZGtRLzFSTllzSStMVm8wU0dsNG03cThs?=
 =?utf-8?B?VE5HU0JiZDBQbDd5S2x3R2ZwRmNrSHkxMmc5ZXlHTENVQkVoZUtmbktPTnZD?=
 =?utf-8?B?aVB1alhLMXFxVXRweHBoaTQ0alhkandXOHdsV3RySTh4MHNkeDlxRDl0MXBD?=
 =?utf-8?B?WlRHZjBldDhlRDBXU21DRDZIV3VLM2IwVkdWbzh5Tjg1NmxpVjZXb3hSZUJO?=
 =?utf-8?B?Q2pIT3BMR1BKaFRCa2xnNllKVnNiaUhtMkl5b3dhenRMa3dlZS9HaWVVMnlI?=
 =?utf-8?B?STdOUU1RUXhESktXcG9OdzJIQjVnMzBQdW44aUlLekpNUFlNRnd5cjMySnRR?=
 =?utf-8?B?VGVEcCtUeXBMMUFPWVAvM05ZZTNNMVJ4UFAzeHV4MlZWMng0T0N4LzVvSEpK?=
 =?utf-8?B?SFlNN0t2YUZ4c0FpOVBxZkhidE9vQ1EyZVJQaWVmL0swMUhvUElzbE41ekRB?=
 =?utf-8?B?dTJCUXdRUVdhWW8yajI1cy82QlVqQzAyS1ZpNkpBSE9TZllCQzJnTUhxZWN4?=
 =?utf-8?B?OTNvWm82ZUQwY0tOZ0ltN3U1MDRONnJHb2sxUmgrWnVWNGIwdjFRY1J3aFpz?=
 =?utf-8?B?SzE0emdEeGNFTU1FTTJOMUh3cTNSU3pCZWcyRGMrb1FNVWNIKzBJTU5LeDFo?=
 =?utf-8?B?UVZlQ2piSjBNbkpvbGxYRHpHcURQUFVIaU5hQVRhQ0xIdjJWaER6K1BLK0lt?=
 =?utf-8?B?SGJIb3RNMU45b09FSXAwWm9ZNDZEcnB5bVU4WjF3dWJTNXNsMEpBaTMxM3JH?=
 =?utf-8?B?U1EzWDJvZC82dURaMlpHdGpvNDVLS2dTbnhEc0psMkFZN2JkekxZd2pMcHpk?=
 =?utf-8?B?MFlocjYvL3dEUEFkd01nTTlCeFJGcmp6T0E1K0tlRHgzbVl0VXdLRHlQV1ZW?=
 =?utf-8?B?ZHNBODY1cjJnaVdhclNMaXhEekZMZHJiYThManFvRk9yVU5hSGRvYTJDTDFz?=
 =?utf-8?B?OHlLNlpXODI2dm5ONzBrTjFOR1dYM1dVRzhTZldEMENwbVhGR0tUVjQ0bzdq?=
 =?utf-8?B?RFdzTStudVRxOUlQNnJwNDU0RUwvYTBtaUJidUh1WDRHZDBsc2pMSlhJQ1V0?=
 =?utf-8?B?MVBOcDdSaFV4MTg5OTdxRmRzc2gxdytVSzg1c05JTDA0K0hXeEVHUmpTamhO?=
 =?utf-8?B?V2lDOXdSbW9FZU1LSDNTN3k4WXRySHJUOEJTbWFNMUhTNnRZY1p5NDhuY1R2?=
 =?utf-8?B?U3hoZGJYVG10YVY2ZWVncDRmak1zZ0NRUEpCUnZ4Nm5UVXJDL0tPaHRrK1BE?=
 =?utf-8?B?bjNrZUZ5VnJ2eE4zU0JBM091a0xUd0lTQjJVWTJTZm9IbFVXdGdlc0NNQkFN?=
 =?utf-8?B?S1ZJMnU1UEdBUXhuTHFPREVvUWM3d3RxdjZDWFUvT3diM3JibHlEa2RBUHlN?=
 =?utf-8?B?MDVINmJpRGNoNkkrZGU0TlFxa3NxNHpMMUl3ZjdYTHQ5U3RKS3VBb0c3TUl2?=
 =?utf-8?B?N1RPTVZHS21sdi83ZXRka0lwYUpFd1pucWEvSWVnMVJ5M1ZMaGNHNW05Q21Q?=
 =?utf-8?B?YW5QOVFCRytLOFU1a0JEalU4YVk2WEw1Y2xSUFZXVm1JeFdrSDhTTUVKSnd3?=
 =?utf-8?B?RVQ5dzh1Q2dzUytkc0puYkwxYk5DOHEvUFNiZXdQTUt6SE4waXYvS2NmZzc5?=
 =?utf-8?B?WEt6RG13NUJVQkxTL1RoRWhPTWg1UXVtNWVxVDB2UHBwMnpXVHRCM0lHcHBj?=
 =?utf-8?B?dEtIWnFJV3R4Z1p1K0FqZTJqaENEc3VRSk8yM3RCUDdycGlSK084eFBVVUdE?=
 =?utf-8?B?YXJXaVd3RithUzVSQnZuSkVLR0E4QytndmVSN085ckpYdzAyUDlvOC9McU5S?=
 =?utf-8?B?VlNjNklYUnRDMnRDUE1GRjQ5QXVGd2t5RmdWSkRtUnhsVnk2VWx2cnlJdi8z?=
 =?utf-8?Q?esIJcm+k41K6Q15PJcd45RJ4B?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b6305d9d-7643-4bd9-e40d-08dbbfaea88b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 23:08:27.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoIOYg1+VvHDdaAT4YQyVkKgI6OpgIPnISwJFDIpzAZQ6w0xVhcnrluXQugJ5iZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6846
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-09-27 at 01:07, William A. Kennington III wrote:
> Right now, there is no way to enable multiplexer support unless another
> config option selects it. When using `allnoconfig` with CONFIG_EXPERT,
> this is deselected with no way to enable it.

I fail to see how that would be useful? Why would you want the mux
core if there are no users?

Cheers,
Peter

> Signed-off-by: William A. Kennington III <william@wkennington.com>
> ---
>  drivers/mux/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index 80f015cf6e54..5d585d778312 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  
>  config MULTIPLEXER
> -	tristate
> +	tristate "Multiplexer"
>  
>  menu "Multiplexer drivers"
>  	depends on MULTIPLEXER
