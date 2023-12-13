Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1E281186F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442439AbjLMPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442399AbjLMPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:55:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D9E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:55:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk7airRUiW47T8VqgGgAvKGf6gtJtylYzt0Ef6J+P6hiHUH40WKIhA7b3YBxo4CVyp/77vkDIks4LHp1SiWjMvJ+aYcUL2Hxych8csFAkwt5RG2dZi1i7HujOyr4HpWcN6oxhSFgZC8FWEdjAITYJ61Ri/mh85RL32Lsw7EYgKY/pF3Tkq4NA5/YoOYMjSQLT13GWZIdookxFOJ7aenenNlhuw/b0J6moOWtMdk9yEPwLzfqDVGCAHmMN9KxFp01biQcoMFWy/pxO6FPyRNYdrN/ri/I0x7tBQMi62ULuSDCKwqpf7RtlDwYLUKbl/v8svkSarcElIbe1mK+uP1f4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj8/wqBswacsJ6CzeVyCdk/t2FGoVsPLGqbHgyikTIc=;
 b=JOWxBUwxx78PmPLqMkbZtmx9uKFrm/rc3XKtpWCI9N6gRvlPKdrZYbgL/LZ6Zpli7hgqaYWRbegJZxzoWOonW8IyDDz7VXEHAoJZX0nMo/wO7jLR+Bh0XNrgdJtDTssdfOflc0c6BWo36lBI3izwZSjRPoDrKC8fWzJk2pFzjeWg7vrRfBg79SQN4GuJjjTokESL81fargghBQ5+LBdVVyILA5zB9uI0paR+QLCqnrf0gIuzUJDn0XhsWB1fA+dAH1DD3eegCgCER2qrPjdDyMIrYZHAwz2ggWCxNvmXtG5ldyV2mwgAwz8dzc39q21gWj3sov7ihJpW+6Kfbn2ivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj8/wqBswacsJ6CzeVyCdk/t2FGoVsPLGqbHgyikTIc=;
 b=ZO/b64sneUbd5CPmpw7sY17Ihlri/CFMTR5MCPFMHSgcXr/ygE63D08pVbvWg7qrM/p+DCU/pjMiRyIrrZVuQVzCCerQLeaWrJ+xD4P8YaNh2B5mrHrangr1hOFCzw17Hcrb5w3D1CzketSEnBBzlrP7SbvAxiPUNRQUHVmG5v0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:55:17 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:55:16 +0000
Message-ID: <325f7135-305b-4fdc-8912-acf257b86d22@amd.com>
Date:   Wed, 13 Dec 2023 16:54:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: xilinx: Add error message for invalid payload
 received from IPI callback.
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh@kernel.org>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <85749bde3e71148533d31ea2092f4514ec347768.1701962639.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <85749bde3e71148533d31ea2092f4514ec347768.1701962639.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0125.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 258a7d37-2214-471f-19ad-08dbfbf3e676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHIcNurahqE5WvQKlA0DyN0Kl2Egsi6HmLvZpZLnYqbIq38ReR60icYBpvVcjj+ubcX2ZQHtx9TQ0Xy8C0amILGGulrD/uTpw4wHUNGiPq0bg+72zfzfe2CQhjkybOxHq6dSszP5l/DfdUlIYFSyvKLoe0kwDc4RwDsPgwRIReBtJjSsYLngElxYV3yljsxs+Q+Edb0Us9CZf423jGsj4T8nxY77ch9N1TLbNjmPGvLLUsC1wyWIAPE8bDo7g1KmEwVAOIwdhCaiHDO0SuYfBTfNQkDrRgIjy7GzrHNNvrtcwNjPme3o9yHQ0dsGdHX3Em6ac5V0YmmcJW0/27/NVaKAWTDhFkFPosBV+q0LO6W2A9ok6W0ylo31WpRMb/nNdYAwMgwERGn2RP/QHvGmDHsRKZ85qUCNcXx6IqDKTLvbEdEB8AFJ10Zj5fh2TLWFu5X3KEdvcSEFrzNKJ94WqfbP3NYlWF/HlzU9UhMsFrhfPNXWaiT0dhCa8gqOR41PHAHJLfVV7UKZdKRp/LsXF7TWBxnwgzyc8Q6YJNyLuXqtiaIUu50rR+h8fTC0sfGpfpgfawlO49XIpEKYmB6s3O77bcCVl0aCaewrtI4EIbRvyVrKh/5lmMWzmIhBxJF1dPE/paifpvUnQSjXX2fD4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(478600001)(83380400001)(53546011)(6512007)(2616005)(6506007)(26005)(44832011)(5660300002)(4326008)(8936002)(8676002)(41300700001)(316002)(2906002)(15650500001)(6486002)(6666004)(38100700002)(66556008)(54906003)(66476007)(66946007)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0Zic3d2ZUc3UThKM0hVQmFwZy9ycTdZMzZ6a0NIM25udTJUTElRekFFNnh4?=
 =?utf-8?B?ajMybU5CT0tZMFNtenpOSmxHV0tod1N6cnRuL0ZFMXNxMjlrTzM1dW9qSXNV?=
 =?utf-8?B?NnF2S0JXdVV4blRsM0U3eEJFek84U3RWVUFyTU1XR3lmcThCRUVGa0ZLbElB?=
 =?utf-8?B?WXJRZlFkUVdWWCtWNzdOb2Q4cEdCdzJycWZSU0FVNENSZ0w4M1pBR00yaWU1?=
 =?utf-8?B?dnlUd0lDSGNlcW9qZTQzcmoxb0tJRlBYbXllK2FZWFpmZFB1UzlFWW43a29z?=
 =?utf-8?B?TGpiMm41Q3djOUw0aHlPb2hPbUpCVXZ1Nm5CbnVvTzBYV0xZZWlXNW1CNzVB?=
 =?utf-8?B?ZG9yZWo0R0xqczE4cGE0T0JYcHlkMi90a3BsRHEwVU9MdjVOVzVwVk12a3A0?=
 =?utf-8?B?MFg0aDUveG9JQTVyRFVsK1RwWThZVm0vTHFrUlE2b3hzWUhINmlFdnA5NTZr?=
 =?utf-8?B?aWJzSFFFZU53ZGw4NHBaRndzeFhSWTJVT2NYUnl0bW9MaGhuUkZtbW5qd3VV?=
 =?utf-8?B?ZUw3eWV5U2JydVdqd1pPZDBUd0l2QXpLeTFmVE1IaHFwdE41Z0Z0UmVTMTdi?=
 =?utf-8?B?RkhMb0RMY2xFVDgvNGFwdUJHMHhBeGhpL3REOHlFRVFqbW9WdCs3OU4yNDRy?=
 =?utf-8?B?K1NqamZLaDRCeWN5cTV0d3d1Y0M2WWljV1grK2ViclR5NUZDTkVTWmVIMXZM?=
 =?utf-8?B?ZmRDQWlXY1pOcGlqTmw4UkdacTUrMzdMZTUzMS9HaEpsMEF5aUJJS1BVa1FX?=
 =?utf-8?B?YmNmdmpPcHMzSFZMZlo3WktqQWtWZVl1ei9Oc1dZd2NwTVNtQ0FHT3R3RmFX?=
 =?utf-8?B?YjhZaXd1T0FVWEtLMjlXUTJHVnphQjlFbVdJak5lTWNoTEVoejBxL0ltMmtx?=
 =?utf-8?B?U3B0NE5KejVMc3FjYjY5VjEySkRJTjdNblR0MmordnpMN0Y4TDdDVSs2bVVo?=
 =?utf-8?B?NTRCRW9PcTRmT0tLS2lPbVBFdG1aNnVGZnM2di9HRmU0ZFFQaFlWcXdwMEJ4?=
 =?utf-8?B?OXhZTWdHbEdneWQ1U3c4bkR5MzkvcVVwNTNKa2xuUjdxKzlzTU9aR2tiYVV6?=
 =?utf-8?B?ckRXdllVQVc4UTBEdDRENitBcXFSa1JJWXBTOTRza0NicTFJd28xUmxHM1FM?=
 =?utf-8?B?Z09GYVBFYSt3eit6NmtvYWd1MFFhWnFjT2VLYkR1UDI3akxXR3NNY01TMXl6?=
 =?utf-8?B?TFlGbVluMjNkbnBPd05KUXpsd2NmcXpDbUYxYndreTNoczZDTjFkWkpZWHZO?=
 =?utf-8?B?b1VPQzRZVEpnK2ZxRW05NkdhOHI4ZWE0ZVg0OWRLV3hndHZuV2JBL2dnUVA0?=
 =?utf-8?B?czZBQ0hCNENTYlVodCszZXFvTWQ0NmhIYVdDZnkxMmZQdmc5dDR3dEJsZmxq?=
 =?utf-8?B?Qmh0MFVCQmo4dzRyQnFreHY0aUNheWVRVmxKM3o4S21sYUVsNC9RVnVYVUxi?=
 =?utf-8?B?ZjZuR1FwM3hocmk3dlBSckdoSTY4ZGZ1SDhRRkhxKzhmZWh3Um1Gbm82b3I5?=
 =?utf-8?B?c3U3VldkMTJ1aWUrWmlDK0RvVXlyZGdsREozUGNoQ3A2amtMOFptL2hZeGkx?=
 =?utf-8?B?QVBCSnlNMEdIVUhoMHlTUzcvZzBMZmhTRlZzc2xMam5oTkdXRU1DNm9MU0FO?=
 =?utf-8?B?S0pUaVBTMHBiVXJZVnAzcytEVTNFOS84VEV2RVFGQ3VUMXVZc09Rbk1vcFRK?=
 =?utf-8?B?bXlUalBGbDIzOU5kU2ZUVGtveldaenpzKzRzaS9ZaytYMDUyRFh0V1A0UTdR?=
 =?utf-8?B?eHZsSHJRYTg5eGJNOEJRejNNVGtZV2g3L3ZVRVhLenc0bGZraXp0R0tRbE1K?=
 =?utf-8?B?TWw4U2ZORDdxMEpmb0JzaERPd0VqNU9kL09TblN1SzJFdEI5NFUxMzNTTTVq?=
 =?utf-8?B?WEp5Ymdia0wxTzJzU2oveTQwZ0FHeXRNU3JwdUh5UXFsSlMreWlyUUllZGU0?=
 =?utf-8?B?QnJUUnlNeW1BcitnazkrQVZlcFRNbSswdnByTmdmcGhDeDJ3NE5mSTJYRHYw?=
 =?utf-8?B?bVB3ODRFc2JqNzdESVhiSm9YZ01IRlNDeWtQVWpDSW1jbUhmQVNhQ00xM2Ro?=
 =?utf-8?B?ZG1BU1ZtcEZWOGoxT2NHSG1vMUc4Wk04aUVIMFozdnQ0UDRPM3E3RjZ1d2tj?=
 =?utf-8?Q?5Q5uw9XV0dNZ2gbtdqSzoRCkL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258a7d37-2214-471f-19ad-08dbfbf3e676
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:55:16.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGOF4oqfRkRaCe1kNI+24Gm1U9y+30uLG26gcrcy8s2QZQTkZn+sofZUoykpxBpW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/23 16:24, Michal Simek wrote:
> From: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
> 
> payload[0] of response buffer of zynqmp_pm_get_callback_data()
> contains valid payload or error code in case of error.
> 
> Added error message to inform user about the error code received in
> payload[0].
> 
> Signed-off-by: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/soc/xilinx/zynqmp_power.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index abcf7e883279..07d735b38b49 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -86,6 +86,8 @@ static irqreturn_t zynqmp_pm_isr(int irq, void *data)
>   			pr_err("%s Unsupported InitSuspendCb reason code %d\n",
>   			       __func__, payload[1]);
>   		}
> +	} else {
> +		pr_err("%s() Unsupported Callback %d\n", __func__, payload[0]);
>   	}
>   
>   	return IRQ_HANDLED;

Applied.
M
