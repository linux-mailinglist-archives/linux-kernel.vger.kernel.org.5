Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D528E7A7392
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjITHBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjITHB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:01:27 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5AEB9;
        Wed, 20 Sep 2023 00:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIFWpwCehvJrJB43shcv1Np2Ck5HALOD3MdUOGGQIk8A/DQkJJctm4XT8ZUX8XGnywBmX4tqGn+fgdjUjqNZXOYBHvNd0BCdnddBKfS57oqmtTDlLq832dzgM3ReU5U9OaqNwKhpNFtXOfp+c8aqsj9cHUNqfL6pk6TPS6fgWTG+IOBEA3n6WicVDxknGoX2UiYTwNUvF8sAaIYHYuLwCeR9PrwTHQnY0qaWLQHMuWIhFCalHMVgA7YFfaJ8K3f9TpiS/jDA90iWLSbkT+focqff0iLm6BnKIjIhkQw/xR+t+uCX1y50yJ/+pl94ObCOh7eLtlWK61N4pl2pR3rCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTsZWd9GSe6iYlYmqnhZ63IGCRGjiwaV7XEWxztu/3w=;
 b=Te+1/j8fZ2DERLekPt6HVBghp2R455oWDGU7ZT3jI+EkUHOQ7iuXltDwQI/vT1Pa2wimpA15Mj02Wy85DHCwVZy9CPpfLASsyU2zCx+sAfJG3L4njcdfcu6Ri/84SjUyvgYTh0Un5fRsuhqbnSkqotQoL/WweFFDp3zsyVqkeB9Y6DyAe14gDTBWsNlenlEQUmv9NOpqgXrqt1BkDd22C70T2RtbgwiAGk8r4tHE6MYs87J0xzwq2bTgAByWSWVL4qm5ZxzWwS9y1w9I6UlCzgiYUcAOgAA5Dq05Fkzaq2Nx98PWEbLQiIJEqRCZHAodwMJPzTB0qMKWAQWG4ty6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTsZWd9GSe6iYlYmqnhZ63IGCRGjiwaV7XEWxztu/3w=;
 b=DyNJvlo9EbHtePmEO4KpSY3uCNEgOowyZ6wSJ3XCKNdfaujiZwAyxQ/mQpf9rxD/EsNCWoqHqEqKQFSkkrygXLer0cP4U2mkrf9k1O3Rebs1QELtoB6ewNNeNyOP8E1gamLFAYAnowsOdI8nhEe7aBAvMvaibbCVSzXMc3nqoL3jnsOgTjpep/8V3OROUThgx+RW1NPcZa3BBxZXr/rv9NQGeXfNVP8yqW8QbLg5vTiDB5jlURWfaOphs1Xd+AcH28BHUjgjnNuaAyVn5sMOUEn5JGVudlxWw95ZdOrkphrbPuZBBvDkDs8F959+RPyPyhnEQKu7jp8B923X1iSGAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6432.eurprd04.prod.outlook.com (2603:10a6:803:122::21)
 by AS8PR04MB7927.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 07:01:17 +0000
Received: from VE1PR04MB6432.eurprd04.prod.outlook.com
 ([fe80::8066:2981:a2d7:e654]) by VE1PR04MB6432.eurprd04.prod.outlook.com
 ([fe80::8066:2981:a2d7:e654%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:01:17 +0000
Message-ID: <3698c731-34fe-b6bf-46be-15146ae209bb@suse.com>
Date:   Wed, 20 Sep 2023 09:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] wifi: brcmfmac: firmware: Annotate struct
 brcmf_fw_request with __counted_by
Content-Language: en-US, ca-ES, es-ES
To:     Kees Cook <keescook@chromium.org>,
        Arend van Spriel <aspriel@gmail.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230915200552.never.642-kees@kernel.org>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20230915200552.never.642-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To VE1PR04MB6432.eurprd04.prod.outlook.com
 (2603:10a6:803:122::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6432:EE_|AS8PR04MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4aea40-514e-4af7-cc9b-08dbb9a76277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oP5Jm8bOrLzdh7oz3CH8Uqy1EX75i3frelX8Yrcq61lPkhk/qDJ0oEbuEzugTbmC52e2I1sAffrY3WFT0Oakge0GRy4XR7VbKej56izIT4aj6vm9m3sgtlcImrhWfs1H4cKY2hiCRIKvxLP4ePKktI01Cdc9oIh9rHj6jRpAcNQiBpT11NJtuMA5uz1k3NYqCPtcu9nOJbfdiE9TmvPqOjxg6NxjH1zsLLKLMqGNZEGHLfFMTLDJS0gC22cQbP8OdbdknUcl8Y/KlzYpim56O/7eSG47bDQMiXjX2u0zUiVXUgaR8tcp66WxJdesHscZNO2oo2coPKF/SdG8lp8xRFr8qHBUV/AGyJeNCpvKsfGXmdgW6tv1TS+zgV+sRNY6SvcabONmKUu+2cuP5gmoBJAzvXLxmoSA3gOYucNKr8fB/VlMk7u/hE/ZOFtbrO99ciFz53Q2php23qPO5vHcBp48/VddaFdn/2EerqXR/0cERORpVs2Y3vokFUIwzisrY88gNgysi97zmsXaUxMIsL6ksPfnkn9teeijY8svOFCwkn6aSuPPg1Ikh0ObFLi1DnDhiyYorpzUWfxdMQgRVQDDQ9epiQn7cPlSefPDiUKzkrgk5oVgae7U3TIvGCUk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6432.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199024)(1800799009)(186009)(26005)(2616005)(31686004)(83380400001)(66574015)(5660300002)(110136005)(66946007)(66476007)(66556008)(31696002)(8936002)(7416002)(316002)(41300700001)(8676002)(2906002)(4326008)(86362001)(38100700002)(478600001)(966005)(36756003)(54906003)(6486002)(6506007)(53546011)(6512007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE9oY3FTQUowZ1dObkxza2o5aUI4SXJJWVlQRk5PRW9SOWtRY1lPWG9lUWt1?=
 =?utf-8?B?MHNaM1VRQUUwMjRCamN3RG5oUER6MHI3blcrS1NPV2RhVllQZ2FhRWVybm8x?=
 =?utf-8?B?WlBuMGYzaGdiMkU1R09rOXlHR0hUMVdRUGJ0U29aL2d0T2FybkR5T3Vrd2hK?=
 =?utf-8?B?am52S3ZmOTRFOUthM2paVFNHd2RDb1ppdHhkbFZyL3lxTjlJaWk1azFhVGgy?=
 =?utf-8?B?WFBpNHFwbWR1VUF1TEZpQ0tRQ3Bpcnp3MHczQmFCK3lQZjVDSFoxQzVtVkVh?=
 =?utf-8?B?R2VyU0lrOHpvdDNCQndCbWlRU3hKN01wYkl6c2ZyNzFDczNDbXd3SjZtYTU4?=
 =?utf-8?B?Y0hUVGRnMUhLMVNoSUlhSnVTaERtL3gvaHBNc1M4eTlPbU9XZmZkSmhIZENL?=
 =?utf-8?B?b1FHUE8xMjdnWWtXc0lDS05HNnFVK2N4RlFGZ01UbEF1TGxiS2NHVC9WN0ht?=
 =?utf-8?B?ek40S1I2NjhLUDlJZ2hUV2JhY01Ncjh3c0c5dXBjeStGMElzU2hCc0ZJZmN2?=
 =?utf-8?B?MlR2U0hxc2RTdHlqQ29SQ3ZsNkxUYms5M0l1cU5vRUZsV0tPU05McFhOZ3ZE?=
 =?utf-8?B?eVBTQzZ3NER3V2ZkSVFFcGIxeHQxVkdWSGJZZ0RiRzdrSy9jL2djZU8rRTIz?=
 =?utf-8?B?MERCSG5DMGNEQktCNWtEWGcvRlR0YlNITkVsZjd6U0NrYzRPNXNXZmZHZlBQ?=
 =?utf-8?B?V1NhWS9VMmIrUEZqTDJwbVBrNDFHenVhWmV6dVVzbHdxVkN6N2NzcSs1Y3h2?=
 =?utf-8?B?c0FQaThOKysyNFhjZzlqM2l1OC8zeUlpWHVWenY0azkrdUZ5SWRlSEZ1aGty?=
 =?utf-8?B?VlFuTnNyN0w2VEpwOWkzeEFPQU9qM0xHNXJteFYwVXl6MTNyNlR1eXpOZm00?=
 =?utf-8?B?WitDdTNkRGNWTS9DSEUwcjc3aTh3QStQaFZhanJuNHJsQ3l3dWxnaUQrUWgy?=
 =?utf-8?B?cVkyUDZvejQ2eGhnZzlRelEvbWJQNW9BZVZmNFZGd285ZGU5MmJsK3h5dDZy?=
 =?utf-8?B?R3ZrWklYL3hsZXByQjhNcWNvb0NCbkROdDBsMFBoQ2hVUU42V2NORmlQdFJr?=
 =?utf-8?B?WEJMK3FhQzNMKzFNTDNjb1R2UlhLajR1NWxiN0dCc0ZVL0NvU2o3QWRBMEZv?=
 =?utf-8?B?M2R1SDAxaGdFUXV3emNNNXhiYTNzVDBFQ01TUUlMTjVJT3VoQm44MGNka0lC?=
 =?utf-8?B?VHAycFZVazd6dHR2a0Q2eW12aCsxaDkzZWd6c0ZNTmNQM0hUUU9VZ0Z4bFJB?=
 =?utf-8?B?RGN0WTRoOFN0cTNsSWtNelYxeHJuZTBaK1NjblB6bTY4cEViaERqenp6cCt0?=
 =?utf-8?B?eWdKMFdBUllEa0l4UUwxV0FkNkRnYTd0dXdTZnNlZjNzWTYybVprVlp3S0Y0?=
 =?utf-8?B?MmtjZkduKzc0Nk5qdlpxMjJodk1JVEZIUDc0UDdZQ0VkOWpXWXNheUhGeTVV?=
 =?utf-8?B?N2ZVMU4xTFR0NFFid05KQURVQ1N1NUJiVTVSbzlZTlUraTNBRGwrRldRV0JS?=
 =?utf-8?B?c2d2MWxvY1pZNzE3M2VpdVpMcVlIUlUrN0lwei9FTEo0ZVRDOG8xakZ5VUdl?=
 =?utf-8?B?M1dSZWhvK2hnUkhDakpjbWJtTjVHNko3LzlZdXcvUEJEcUY2TlRrOHQzcXlF?=
 =?utf-8?B?eHJxWTk1QjZ2elIyT0M3VXR5MG1XdE10N3VXLzBWTlhSYnNUMTl4c3VNVXRM?=
 =?utf-8?B?RzNoaTJoeURZZzd0LzFYSHBpQUVobm9vTm9Tcll0S2kxT3JodWJOd3k4UTFF?=
 =?utf-8?B?ZmpaOFQ0Z2Nyazd4anI2cVN4SzVFL2hKTGNtNUZSV2xnREpEQ0wwN3VpTlVR?=
 =?utf-8?B?WkRrM2NiK05UNjF6WHM5d2QzQm92QVdNTEptL3NQcXI3V0xoN2xYRFMwQVdV?=
 =?utf-8?B?bjVKSjNLRXFBcXVhMDhJWUJCeXdLMnhPSVlqZGpCbXdHbmwwSE40S1pQcGZi?=
 =?utf-8?B?c2tPU0k2Qy9SY3pLOExQWmN4eHAvQkhTb2tSM2FTdEgvTGJEYlMxaVdvRDla?=
 =?utf-8?B?RHVIMDVaam8rcVMzaTBabWRQd094NGlMczJmd2ZiK1NDZzNDT1RsKzJvVksr?=
 =?utf-8?B?WVhlV1l3TWUwYmhxeW1wS2xMS0ZRRmV1TmlGcHM4aUltNW5QbE1VSDQ1M1dU?=
 =?utf-8?Q?Yw9YUXEZlOikG/ExwDt2IgfH6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4aea40-514e-4af7-cc9b-08dbb9a76277
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6432.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 07:01:17.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lF4MSzCSHkXBFMaSVDJ7x7ZYuMuPH4pK8U//EUpWps3Wzp5P49eeCf4LPN9RMd0k/7vkGGzjMMzfbGtQ3Vkb0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7927
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/09/2023 22:05, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct brcmf_fw_request.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: "Alvin Šipraga" <alsi@bang-olufsen.dk>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: SHA-cyfmac-dev-list@infineon.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
> index 1266cbaee072..4002d326fd21 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
> @@ -69,7 +69,7 @@ struct brcmf_fw_request {
>   	u16 bus_nr;
>   	u32 n_items;
>   	const char *board_types[BRCMF_FW_MAX_BOARD_TYPES];
> -	struct brcmf_fw_item items[];
> +	struct brcmf_fw_item items[] __counted_by(n_items);
>   };
>   
>   struct brcmf_fw_name {
