Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F54762BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjGZGlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGZGkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:40:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9A526BB;
        Tue, 25 Jul 2023 23:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVDivLZaezGZLhNTGFSLYBJ9OWulDSljBTH0qsXMi41hJHtaoeb68gov973s/0RAtPs4m86Sl6MsTaRaUp1BD/b1Qe/dcp41jle/gW64qQ28kfvgZ/uKI7u4HEWZvT7A+lzfNWulIG8KOMgOYKOS471rTaD0j5hrBKxB/0yk5NKiB+8sPblD+bH5AkbSdgdvoAXi7KXFG2M25rjMtYsUVnqiCf3jmyi/JHZAxoVInDwJEHDztGNkDig/LCVv8oY8o2gyxS7sD+DR5QekawDD/q4h+RTJAGraOZPLibgnyd42Rgpw/R+y9SkV/9KzE2VwL/3x/zahhS5cYYGPipcdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITsQEh7KyNdRuMbeMieSlIdW5dPhPA8bVA4Gs34/Ye4=;
 b=UGFTmXCjAqsxzb67J56+53i4SXVX6o1/FhXN3MNMbTS9jMXZ9Eycx6sZzXMlsxVEZQNb+qTrpzOYhhRzXl9GdHSEAw4ulqEoe+svjlImkkvHMmjI6RvA1B3QpMO/Mddae0yvmx+prMupWJv+l1BauBI4qCwMv3bC+zYV9kSWetP1JJHxTosyzYjUVtIEdGoJudA91NsIfkQVz/sPws3LpM7tcw9avy2gi+p6ZVxExfqVvdBYcrr+PQ3vrSmOxQVtJtvLabMAoikl3zYjzTsZmG78srXfcyiUykN8rD75ZTWE3CJm8LxnQdre8xS5xT/JbwhscZVknD9PAk4cN+xf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITsQEh7KyNdRuMbeMieSlIdW5dPhPA8bVA4Gs34/Ye4=;
 b=dzqB3iDDMjqvl6OCbsgMAW/B3sVZYhMJxHjMjV7/YTaQ70fk7aSn0CnZdQYLhUCYjPhm7Hjn/pvEsRiYyYzcWr1kM/Sjkbn1j1oOCzL6BGwRyIUyzkjJzkpgdpQocw5/e/c4MEXc4c/vXR18olBwLTk+sXPFORl9ZoBP1tCMi1IQga7vwSo9A4ChcQXXTQ5y2hCjW89dqhzm8rQV3TMGoNp2VX0TA7bsAwyqyhMzU4XTHsNf+lshNrThdZ2AxLoRJrods77XVc/QJ2ZEcY64QCVlTRhJSIfJEviXHa907osd8d/IHPPKjk0h0dmhkumnSET+DB2P3JT5ePDZmheRwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4265.apcprd06.prod.outlook.com (2603:1096:4:152::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 06:40:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 06:40:31 +0000
Message-ID: <c82f2143-05f2-c5fb-8d34-858f10fd4977@vivo.com>
Date:   Wed, 26 Jul 2023 14:40:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 09/61] mmc: sdhci-pic32: Convert to platform remove
 callback returning void
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-9-frank.li@vivo.com>
 <3ec97a7a-05fe-3a77-bde4-ec37419ce090@intel.com>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <3ec97a7a-05fe-3a77-bde4-ec37419ce090@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 249188e6-b457-46ec-8e81-08db8da334f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DD//Oa3/qschJ7yEdS3xrCwSFq5ycx5c8DPe6GVJDT9dmWtfhDlkmf1UoDOr2wS4x7T2tWjiKZxxyIp5Q6AZGsp4CgMBJs8hCJNe+eNGKLRRxrxqw04MCPfjn9vyEwtLvMZ/Jh1BFMVVvap3uw+DgAhJfRoVJ+zvjdr8ZnQtleuEwclD86Gp9pNmzoXcizmVglxGo3FADN/NGtK+wkXqOAD3WRRKsJGE4mwdEEvnxODnARd+OGh8goRNUOkKRL0BzfSXcPLZ/wi/YopHz9B1FdXFFhl0WzjimewCrbCtVLFO0ctoYi95Zx6fNm6OsG8YEfgqPSPru5KVHR9KLNp5wHTiiUtoTkTcRwXd9FCxFUSn+3NBrxU7f9e5JEA7Ae4pD/ik0oTGmIO16zsnPgJkrPPspUGQS9rRVkQbdEpny2u7vgI6aZdvHjG6ZPUjjC5rhr0SSLryNMA9tTKb7ofb6cdTmhHFwWei3UZMXDvR05YrxUDtNTYMCd0GGOZLGW+Be7681QNwBWTj7LE0u7dWGM2nXq63ewBi47z4PMkDCQFW7JHLiugFDJvA+JIayFYKNgR6N40RrLqH/pn70hkPwWDCEQH8b/JaWRzxS/hzCWfGRMXQFDD22Y2pZgOuXjRVMd8wIAfn4g9E7bCSiy3PzeRW2JK3h8LVnFjJ/lhF8v0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(110136005)(6666004)(6486002)(52116002)(2906002)(36756003)(478600001)(316002)(8676002)(8936002)(5660300002)(41300700001)(38100700002)(38350700002)(66946007)(4326008)(66556008)(66476007)(53546011)(26005)(6506007)(186003)(31696002)(86362001)(83380400001)(2616005)(31686004)(6512007)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0Nka05PWndHazFWSDczbG15c2J1TlI3TnEvaXdHMHA1Q2Q0SFY3MmVsUU9Q?=
 =?utf-8?B?a1hoOXZSV1g3S2IyaGowUGEwQ1JNek5tOUlYa0dmVTFUc2NhV0p4VDBKZUNO?=
 =?utf-8?B?U2tJQ1hJWTI1MjhiNDdsa3QzcUlSWFVXOFZ4cjRVWXQrU3NFS1VobkxuUlc3?=
 =?utf-8?B?cXBYSHYxVVQ4TERDa2VmQ25UYnNtd0Qwc0N1VjUyeHg0MDhsVXJjZ00wbEkr?=
 =?utf-8?B?aGhCdTBOc1BZdnhwZ0RlRE1JYmNITzNqNXN6UmZwYU5Rc0l6QUdCT2w5SDNJ?=
 =?utf-8?B?Q3NsTnJXQk5uQTJpRzNaVFpKekxZbWUrdkFsbTlKTTNHbjk3UmpnWXRKUnhN?=
 =?utf-8?B?MlMzVlp0TGZTSEdVZUgwaWk0RjhlVm1wVFE3V1BQamJhMFdicFZRNG1FOUc0?=
 =?utf-8?B?N01CVnF1TEtJM3VlNXQ3U093RjZ5Tjg2MTFpQXhvVE5tQjlnTGtTL0ZGemxl?=
 =?utf-8?B?cmZYUXhOYnI2RWVkNGlvbVJNQW5JY28vSy93RnFpaHRFNkJwcTRLeUptMXc5?=
 =?utf-8?B?NzNWRTFIbm5pR3U4bHI5TkNodVk1azdUUFpNZWFGUkwxdXMvRjA5a1ZGZ0NH?=
 =?utf-8?B?ZDVaYlNnL3JmWkNVcWZsbTFKL2JDTjhWNjFuUjRpQWw5ZGZ5TGlJTlZUeEpt?=
 =?utf-8?B?cmY4QlR0elVvRGxhT1FtOWhRb1Q1RmNkeUdHWG1FWWc4Wk51b1JzbUZwRGkz?=
 =?utf-8?B?bk9BQTN5TFlFanVRQ3RPTTM3RmdVR2F5a2lhSnVMeHVub3FwLzg2VE5Pb0pF?=
 =?utf-8?B?YkZrSmszOUR0eTd3Q0tXMk1wVVA4TE5TQ0lzQXIzOUhPaW9qWmt0NmNsT0Vw?=
 =?utf-8?B?dEFUZTR6ZE8za0wrWVBHc2RaTFdqWEsyVG5tMmxiS0pNUityaEo3WlRKUzFx?=
 =?utf-8?B?Mnc0dUU3TUFXdC9vckFhSXk2UG1XSndRODRBbGZaUXJ1NVJ6KzVIQVBSSzhD?=
 =?utf-8?B?QjBiaWdxTVhWVnhCb1pTdVI5NzRXZFJYd0pwdDlmS3JnRmNHZW8yYWRLNVBv?=
 =?utf-8?B?V08zc1M4Sjg2L1RRTGlnajJuWWt4eXpBWVZ1KzVuY0dRMVpIQzZpMGFrRVhU?=
 =?utf-8?B?cHV1TG9vZzJ3TDh2UlNNSUxJU0NwdmdnUERERUI3VWVseisyRXE3UTl0dzlR?=
 =?utf-8?B?c1Zpd1BycWhxTERtOGZ2dzNmVjJSOVRWTEFRRm8xZm5NWGNSQmRjUWV6VStW?=
 =?utf-8?B?ZDcxcmVMRVdzR3BObnllNEJFMTRBQ0JXUnJQeVQzUklWdlA3ZXBFUFMrK3kz?=
 =?utf-8?B?aUNUQlZiL0wxVG9iNVZjMjc2V2gzTVdyMGRWa2F1cnRqRjEwdkhvWW5LdzFi?=
 =?utf-8?B?MkdidFVpYjAzcGxpa1JGZThuNWJVeXkveVVwclczampmMW5wNkFVbzl6QjVU?=
 =?utf-8?B?enRicGczUlc1d1pqTUVmYnZjZ0JCallQZjFVUFl3bWt4WHV1ZTEwS2x4N0Qx?=
 =?utf-8?B?bi9KWnMwYWRaelJibExhckhxdHlyakorTWtZdkRKUm1hT2xpbXVzMTNCTzNr?=
 =?utf-8?B?WnQvaGpxbUFQQm5td3dKUW42WmUrWnVPdE1jWENCRk5WTnJ2M0M1Y2NCS2lp?=
 =?utf-8?B?bVBEQzJRalRBVlkrYXFQZURlbmdBK0RXMGthd2V4Vml4UFVpU2k2cGw4bkk0?=
 =?utf-8?B?NVV0ei8rdWVESGJwRlZOR0Q2eVd3RWdmenNUdXNVUVVRVTlRSmNQbVJnaVVQ?=
 =?utf-8?B?c3hITkRvOU5QK3EyM2g5Wk8xcU4rWmJNYTd0NjVrUmlVK20wY3R1amlQQjFC?=
 =?utf-8?B?TjlobW9ldjhBOVhWcmNPRm9jMXZFWjh5Z3c2QTVJcy9WVkI2MWJTNWRzME9T?=
 =?utf-8?B?TUJSMlJKbHpDdEQzR01qTGZwbkpNTU42cG8wWWZVaUJkWDQyS0tuSlNaS0Vw?=
 =?utf-8?B?NHUvSFc1VnViSEJtMkpJd0ZCejBIVWRHVzJ6SW0rOWRneTBleGJ2QjJ6ZzIz?=
 =?utf-8?B?czNJeEhneVdSN0pqbXVHU05VVVlXWU91RWt0bzlvV0FYNmdMQ3VjcDFPcFll?=
 =?utf-8?B?S3F2cFlkd1RTSEpYZnBTYWQ2TWJpN3hZdGo4QnRvMzVnZGN3T3RLdFB5enZh?=
 =?utf-8?B?YytITnF3UzBZVzJWUndHWHllejZnQ292YVdGbHBuTkZRY0l3dU1nbUV1TDE3?=
 =?utf-8?Q?Mgji0rfwY/WJRE/psZ0P5Hl0q?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249188e6-b457-46ec-8e81-08db8da334f0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 06:40:31.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJtIvjM6LmUHpc6Ulen+YW0FSkrwdwgJGDl2VpKbIBST9hqOqJDs85jWTeWVsVU3nE9LTeEcJeNxyNNJ8TS1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4265
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/26 14:20, Adrian Hunter wrote:

> On 26/07/23 06:59, Yangtao Li wrote:
>> The .remove() callback for a platform driver returns an int which makes
>> many driver authors wrongly assume it's possible to do error handling by
>> returning an error code. However the value returned is (mostly) ignored
>> and this typically results in resource leaks. To improve here there is a
>> quest to make the remove callback return void. In the first step of this
>> quest all drivers are converted to .remove_new() which already returns
>> void.
>>
>> Trivially convert this driver from always returning zero in the remove
>> callback to the void returning variant.
>>
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> I already acked a number of patches:
>
> https://lore.kernel.org/linux-mmc/af01d060-dbaa-aa54-8203-3da5fcbc0a79@intel.com/
>
> Also there do not seem to be any changelogs?


Why do I remember adding these just now, even though it was not sent out 
in the end. . .

Ulf, do I need to resend v3?


Thx,

Yangtao


>
>> ---
>>   drivers/mmc/host/sdhci-pic32.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
>> index 6696b6bdd88e..7a0351a9c74e 100644
>> --- a/drivers/mmc/host/sdhci-pic32.c
>> +++ b/drivers/mmc/host/sdhci-pic32.c
>> @@ -210,7 +210,7 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
>>   	return ret;
>>   }
>>   
>> -static int pic32_sdhci_remove(struct platform_device *pdev)
>> +static void pic32_sdhci_remove(struct platform_device *pdev)
>>   {
>>   	struct sdhci_host *host = platform_get_drvdata(pdev);
>>   	struct pic32_sdhci_priv *sdhci_pdata = sdhci_priv(host);
>> @@ -221,8 +221,6 @@ static int pic32_sdhci_remove(struct platform_device *pdev)
>>   	clk_disable_unprepare(sdhci_pdata->base_clk);
>>   	clk_disable_unprepare(sdhci_pdata->sys_clk);
>>   	sdhci_pltfm_free(pdev);
>> -
>> -	return 0;
>>   }
>>   
>>   static const struct of_device_id pic32_sdhci_id_table[] = {
>> @@ -238,7 +236,7 @@ static struct platform_driver pic32_sdhci_driver = {
>>   		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
>>   	},
>>   	.probe		= pic32_sdhci_probe,
>> -	.remove		= pic32_sdhci_remove,
>> +	.remove_new	= pic32_sdhci_remove,
>>   };
>>   
>>   module_platform_driver(pic32_sdhci_driver);
