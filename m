Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFA17B5400
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbjJBN0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjJBN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:26:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC90B3;
        Mon,  2 Oct 2023 06:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ap0Q0cHeNEjfd/KVcFBmq4JPbU/59FkTSAHRlepRhvxFmf6TWGjjVL7hptdGT9GzAG+FBptsWzsuRJF0KVphLQPheT6gY+D7d64MD9TR0QGZ0JDzti+NUTZI/27S6dCo46Dfv4AQh5WLvyXh50LQjNol11cWUPnObnXYPXn5fwXPtmnN6sVUdi7qTOXE8WpdyAT0sfc7YWXEyADBTgikRGjiGG4Mj+cWWOS9Ge1WP4mHPW8CLtEuQduMkZRTWuzi1m3JBp2urhV+AbqF0sZEktTaIOYkh3A16r/6+UqmdlbPk793YwX5T6AcniN3x+YTEszVB5G9uV3NKI1VSAabNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYSVcLuRXvZXTQ+HePQditm8rYKwTAOH2ZY/zcUAV5k=;
 b=GiZI7aUhgxS8vcMlq3xkZGqKNPUPpYumwGncy4eOh8SQRWfG6oIEl0Cpe2SmpnUSZm0o2H2UyAFy6McZPU6i+/IdEMVz3+PB60uowPX30oG66BH8GnG9/gaWF1HMmhhAPgwiPdXSqyVeKckSZxrmYfeOSmPKgGLaE/tBUNlkkquKghvwnU06SmnRAwwGPgmZsCsHP0CGijaVztyCcufDfFcdd2MA7bJonp2/59TbPDiyaWllBORNHp3O4fV0s9mP1UmmrTUuEajFhGsVHV3mQylhZ1Qjmxe8YDthVxjFdpNFk2S+1IBA0e2D5lJPUc3QGiBx/yn7MFglGnv5n7vjxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYSVcLuRXvZXTQ+HePQditm8rYKwTAOH2ZY/zcUAV5k=;
 b=fRkVpAB5j8gpNtFO6PkAJYJXVe1iuVvB2ItkmyTW5tF+DHydmYh/xzqqF7asr1FYnkISUO63hrTjv/832F/THzfQm6MxJVgpTs2B/LsIXcDl8NaVfj9RYbW6MgiJt3WKFuMaCXryYUfO/AbRQUzqkfkmY2/334MZO0VxOxvgHgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Mon, 2 Oct
 2023 13:25:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::2b54:7ddf:9e2e:751c%3]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 13:25:58 +0000
Message-ID: <ce28c892-adeb-96dc-bb3c-f1244ab1ea25@amd.com>
Date:   Mon, 2 Oct 2023 08:25:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] crypto: Move akcipher_request_cast helper to crypto
 header
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, andrew@aj.id.au,
        davem@davemloft.net, herbert@gondor.apana.org.au, joel@jms.id.au,
        john.allen@amd.com, neal_liu@aspeedtech.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231001201357.2052949-1-clabbe@baylibre.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20231001201357.2052949-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c38483-03e9-4fd1-a51f-08dbc34b1cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GqQczUB8rdOMmxwbl8/MnoLmfXmizgIGv++7jhmw88OgokPCe3x1Zx9WF5w7f31WtEnlMZxjjb8GzPgNJY/CD5sozgDMoNB1/Jqx6ILWnzXFcEtBWNlQ4wEir9nqKkZGJYcbytmCSg6KrFWBTW0EIkBuwK2+B2EkORDyQkFZWPBcBzNchroE1rrW7QJ2Tf+c8d3r2aOM+onNoOQPt1OLlcbwleZiq16PiVwNjqTb9rXBsWRaslM+5hcefX5++JSV3Gwda/jddkXFxIF01p/+rOGZpji7uwexhBFNgAGioRUk5ev0iHfWerUo5qnbZ/ulY67Sag+TV/CXCRuskiIAhTkZYdgY7gFBX+Z3BXgcAIYfDI48BcuirlNYRNUfZym1CWCGEyMNkLf6VBx5Y2KthM7CNlPA3n5o9avj6JkCpXDi59RP0LoS2hlyaXIYs8lbdLUqzGQa3lksxGNtsQtIscMAJJVRsR+CH/binwyMti6PjmgAUc/Ys2H1v9CMq3eiWC/YKZLS17l+mhBepXAEYcoOsEmKl2zbxV23sQqeZkdzVw0MPiEsL+NZtKLmAEj3iGdShZWZQVZFPZ3Cae3zm34IQhwEgXRGvl5GodpuM52ndYyr2hLyjlnSZLPoWQDzY+z4ug+JRKzONTcf7Ld6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(53546011)(26005)(2616005)(6512007)(86362001)(31686004)(478600001)(6486002)(83380400001)(6506007)(66946007)(66476007)(316002)(66556008)(41300700001)(4326008)(7416002)(5660300002)(2906002)(36756003)(31696002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulg3VjFjNzV2Vkl3ZnJVZDdPMEdwUk9JRDlBQXhXOVhiNE5BamJxY1VHSHVp?=
 =?utf-8?B?dmpsY0dhamVvUjB3cEpMdFJHb2Y5NnZzRkFqUmp3UHh0UG9jWlo0RDJxeXV6?=
 =?utf-8?B?ZG14aHdUV3pMekFIVnp6anRhY2F0cXg1TlNsSFBZMzRkc0FwWTZMa1VBY01Z?=
 =?utf-8?B?NFpkUFhPM2xIMmU3NzdSeTZxMUxNZ0ZEaXZtZ3BEbC94ZURud2REaVpMdW1l?=
 =?utf-8?B?d2J1anRVRE1tdHJ1ZHBBQ0FycmRZRmp0Y09YQVFVWkpjK0tkQmRvT2tkSnNJ?=
 =?utf-8?B?U3h6K294VmlNVWIxdnpLRXNGQ1FlWlpPUVowUnR0enpXL3YvcU4ySld6bkhL?=
 =?utf-8?B?dUVTY0ROTnA0VTdtSDRzVENVQjE4a0JoY0dUSHVtWGljUFN4SVJJbjVpTUs2?=
 =?utf-8?B?cFZaT0t0UHBpSDAya0l0T3htWnA0OWNhdXNiWjNEcmJjREszUzhvTW1Ja3F0?=
 =?utf-8?B?RlJXdVlQZUxNOFdCTlZhYWNGbjhpQXpNT0pDSVo1WXVMVzFtSXNGeUtBbTRG?=
 =?utf-8?B?QU9yaC9td1pxVGo5eUJqcCtPL0FKemx6cVU2NTJsUitiejlQaG1Nak9IRkNo?=
 =?utf-8?B?MWpDMW9qSEhiT3hQajQveFRsM1NwUEp6UHhETjdHVTJKR1RnMSt3UUk3SEow?=
 =?utf-8?B?ZWpaY1JERk84RmVWYk9zanhKNWk5RlJGNStRQ2tmQkJlR1hXM3NuWG5iQmx1?=
 =?utf-8?B?YlNyVm1RNXpDYmFjU2xvSVVpWDdqUFVQU2R1a1ZMVFprbURiN3NZc0o5NFVj?=
 =?utf-8?B?ZFVJZEtUbWJWK1RyZVA5REJDREtST1I0U2o5U0wwQmFvb2lWR3BhTVJWcXpw?=
 =?utf-8?B?UEhFTzJ1QVFvS2RFeGo4eHFWdEpyQTJKT0FralpuNmxsQjA3eGZIUWZyZmtt?=
 =?utf-8?B?MkRWMDFqRDRnTmxFb2drNTdPTy9vTGxsTFRlVzhkNVU4dDl1cCtFR1AvVXRq?=
 =?utf-8?B?anRzWVZFblZ6UVZCMi84bzM0eGZzZVlLNVRmMTJhaHBnSmo2QlA0Rk5aSklF?=
 =?utf-8?B?RVErMGI1MzFvZ0dwMWlFcDFyWkVseC9LWjc4dVdZWHBGWFQrMVp3eHhndHlN?=
 =?utf-8?B?aE1DWXFJc05hK1YvaW54NzZXc0FNbENpanpxUjVWMmN4YmZzSHY3OFhhN3pJ?=
 =?utf-8?B?NHFMM3VSWXdHdW5XSzNVbHlBRTZXbExGU011VDBzLzk0dXlGNzkzYlY4V2hI?=
 =?utf-8?B?bE4wYzVnakZhYVFCM2g3YXBEbzhYalNUY2diNnZCclg3QVZZaUI2c0kxTVdK?=
 =?utf-8?B?WlFmWno4SThodVhMbE4wdVJaRk50dlRsVTRMRDdYSVFWaUZvRFhBNmNLem5R?=
 =?utf-8?B?di9pV0Q3QWpGOHl4dE01VzJrNVNjZzY3MDcwNUhXM2w2TzZTNG1VOUhpM3Q2?=
 =?utf-8?B?VDZ0bXdvNTZRY05RYmxlSnJlbVhlazh2RDI0SW1rNnB2NTNPV2RlM1JLUGVM?=
 =?utf-8?B?YXNiWFJPR3UrN0hoWGFmT1V6WUZCci9PZG9QTDA2TUtnZ1RqRkJXcTQzTkhY?=
 =?utf-8?B?MU0rbDk5QjJFbklXTHZ6Y1hsWFNoTFJIdDMrVUtxY0lGOC9odkJ3QjhxUVdH?=
 =?utf-8?B?bDRqZjFzM2UrdlQ1Wmk3b0t0Qm5TUERUSndIRlZWRC9WTWFWdHhINDFBTlVF?=
 =?utf-8?B?d3hUWi9nSUJrcG9DclJzQjlkOENraEovVG8vdWw4RTVHc1J6bVZBMTZ3VGlG?=
 =?utf-8?B?UFdWRGlpTk5Vd0NRbFhlNk1RK2hMWmc5eUw0WElpR1g2YkRLWGRwMkZRS1BF?=
 =?utf-8?B?RThkUUUrdEU3QzhzN2hveFIzUXphRHc3ZHlkR1lFZEZTNzlaVUxYQnoyUFNB?=
 =?utf-8?B?UUUyYkNKVDl4M1BQTjZzQmU5dWxBc2ozeUVqdnprVUdXRXJVU1B0elh5SWVz?=
 =?utf-8?B?cDluTjRteWFsMHBHMEpQWnh1QnA2aDl3eVZCTnBIYndpYmVORkZJUk11QVg0?=
 =?utf-8?B?QlgrUngxRysxc1Fkdis5QllnYnMyeml5eEFmSkcvK3RubllJTE9HSjNhOHhm?=
 =?utf-8?B?MmVoS3g1S0dVYXhrZGpJTVVXaTdaSVhtWFRTRDhDYnhPM0xZdnlvZGFacUFU?=
 =?utf-8?B?ZU5NVXg4TURnNWV2Z3pTakN4UlVteENkSkpCNm42eFZPZFFXWFEwWWxqWG45?=
 =?utf-8?Q?8JMcX+6WabeILhsfRp38gYrQW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c38483-03e9-4fd1-a51f-08dbc34b1cf3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 13:25:57.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oc5nxvX2QotJjGpXp83bv4QHen5jOO4QyQMxX8LeE7MatXXKUZ1hHT9E8XTp3/XXGjF4TPIRbIB3VwsbytrlyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/23 15:13, Corentin Labbe wrote:
> There is already 2 driver implementing their own akcipher_request_cast.
> In the future there will be also rockchip and allwinner driver that will
> need this.
> This is sufficient to move it in crypto headers.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

Minor style question below...

> ---
>   drivers/crypto/aspeed/aspeed-acry.c | 6 ------
>   drivers/crypto/ccp/ccp-crypto-rsa.c | 6 ------
>   include/crypto/akcipher.h           | 7 +++++++
>   3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
> index 247c568aa8df..ecb6e984367b 100644
> --- a/drivers/crypto/aspeed/aspeed-acry.c
> +++ b/drivers/crypto/aspeed/aspeed-acry.c
> @@ -137,12 +137,6 @@ enum aspeed_rsa_key_mode {
>   	ASPEED_RSA_DATA_MODE,
>   };
>   
> -static inline struct akcipher_request *
> -	akcipher_request_cast(struct crypto_async_request *req)
> -{
> -	return container_of(req, struct akcipher_request, base);
> -}
> -
>   static int aspeed_acry_do_fallback(struct akcipher_request *req)
>   {
>   	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
> diff --git a/drivers/crypto/ccp/ccp-crypto-rsa.c b/drivers/crypto/ccp/ccp-crypto-rsa.c
> index a14f85512cf4..32c9f524f3d5 100644
> --- a/drivers/crypto/ccp/ccp-crypto-rsa.c
> +++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
> @@ -19,12 +19,6 @@
>   
>   #include "ccp-crypto.h"
>   
> -static inline struct akcipher_request *akcipher_request_cast(
> -	struct crypto_async_request *req)
> -{
> -	return container_of(req, struct akcipher_request, base);
> -}
> -
>   static inline int ccp_copy_and_save_keypart(u8 **kpbuf, unsigned int *kplen,
>   					    const u8 *buf, size_t sz)
>   {
> diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
> index 670508f1dca1..4b6e610db18d 100644
> --- a/include/crypto/akcipher.h
> +++ b/include/crypto/akcipher.h
> @@ -498,4 +498,11 @@ static inline int crypto_akcipher_set_priv_key(struct crypto_akcipher *tfm,
>   
>   	return alg->set_priv_key(tfm, key, keylen);
>   }
> +
> +static inline struct akcipher_request *
> +	akcipher_request_cast(struct crypto_async_request *req)

Should this really be indented since it is the function name? I would 
think it should look like:

static inline struct akcipher_request *
akcipher_request_cast(struct crypto_async_request *req)
{

Thanks,
Tom

> +{
> +	return container_of(req, struct akcipher_request, base);
> +}
> +
>   #endif
