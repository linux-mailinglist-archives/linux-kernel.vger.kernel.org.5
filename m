Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7583A7F9E78
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjK0LXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjK0LXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:23:36 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2099.outbound.protection.outlook.com [40.107.13.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCC810A;
        Mon, 27 Nov 2023 03:23:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTA9+gKAWq4CFDbK86X8oQEOF6cErA0eiCaQ08UcAaeFviHDuqbXoht1NmK2OEUMgEk2vHHWPexnG+rVjI9gVd+Kk7riycvwkEepqZtlA7qpaqu9wfI80KlueLo9PXB+7HUpFEy+mx9n/gV+Y4+4+MBzPDeUknjZbzJmpvGhh5/Z/irZOxXFmuEGIFbJGoj4auZUxADYXhFWH5HP+1My9T7cbx6Pf/w8bK1ouc1fzrzYQQwkTZODe+wPD8d87NopozabkKgCZT9z8bfSMB+fUSV8Fe1x2ZuqBCjYVhwfMfX5Nm1FaaIp6aCdcBAi2/o1EMQmhLb+vRKeIe061E32Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTYXQS0qnDLglDKCa3AxY43B02Lnnajd9Qc6SBzbvhQ=;
 b=VK4tn0Nk3yoyDGBY1FXc7zfNhhv6ccapqYX4PX7fP1B7CTiKvGXbCZoWv1NC2dBVOx476eC3zgjVogm8KGcKqmO0szMoE3mxtP5z7/cQ15pNTeIWlYFNDcfOiqowsaS+bc2jnrsKIA6+UlQNwl/zwFFrhLWzPaIqI81M5/AaBeEcOQqCMTJ632lRNqB1/mfCPSh2/hfuitFvBfK/9Er9WEJlGFyd9mHEQaEbcwgaFIJf6rdd5cWApbRUvEA/hc0CPNc/qAEyrtlDf6F1QNX6RploSrND4VdqvTiojprRpZUBrFfUEQJ5aeXHftHjDfN+fcpAfG9whDbM82xFhQ8BQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTYXQS0qnDLglDKCa3AxY43B02Lnnajd9Qc6SBzbvhQ=;
 b=NbrY72nNVcZDpX6uZTD31uzMPytVTGgzPQ36/VhpyDoLhJI2uvptNbJBL1MPCDIszKRe8SEDGa5JPg9REXa1tP6BdeeGgpWn2ueylBT/S2qqYeMNaNZWMJh3w8HKIaKpyzvQbzJLT7R1YOOFuCh9vAINj/aQFbxy6q4jlkOQQ3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB8198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 11:23:38 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 11:23:38 +0000
Message-ID: <18b2ad8e-6b06-407a-a141-91a90ee7cffd@kontron.de>
Date:   Mon, 27 Nov 2023 12:23:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] usb: misc: onboard_usb_hub: Print symbolic error
 names
Content-Language: en-US, de-DE
To:     Frieder Schrempf <frieder@fris.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20231127111332.107640-1-frieder@fris.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231127111332.107640-1-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: ef827cfe-8bf9-4543-83c4-08dbef3b4d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0J+LqqJRC1zUv3zbhPrCS3YT2BCEJkFnjbP7X6QncJ7A0A4PMvFeksCCrSAIqU3lfvjJ09y1eckIMvBPKcyNMw/1Cw5ncedLRiNKqBmhEbzDcSn0jO/h2xDZIROSxCs6wFTti5qAk3D3wRKASJB/l5bychyBDYj+DNf21pcb0EaItcDbuLTZCq/jXBdtd9VJA/qv+t4uapvRC77TYmsm7vjUZdWz7d88JD/l7/Q/XrXrE9aM503pMh9q5eoJHGy/1bJasinmtwmlBQnA5SvQRuYLgu6W1eQqHqt8YaiM9M4yiwy9Ei6UwELb0Al7S4P4rCuvJBu1+kHteZarENMFljp/I1j4h28HV0wMYkpEyggKyex00IdUzBGbrYx/dZzQEJGlTh6mUBJI/8jBIR89T/3v/vFCmQ2YFJ3/NQbxZLl5BRvq21Sx9Cg4VaevK/L1UZ3e6/5Y2X/Xlw1PBiiCXDQe+QVwwclSU5YlQDaTYADj9kHnKSRY5sar9NNWrM1zpIvGfg9GcH8ohTKeUFhhzght+WvzRMz1t9HhL+rbo9sUxHTL9ObgCmKV/54JWWrieyX1WoJuWjosTXiQ3CVeUscIheedVTTVCxUx5lCJ17QDRcknflHlv0XuV4rdWspReNPJ2u1oVWIz8TgkNwitQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(6506007)(6512007)(53546011)(8676002)(8936002)(4326008)(44832011)(86362001)(6486002)(5660300002)(478600001)(54906003)(316002)(110136005)(66476007)(66556008)(66946007)(31696002)(38100700002)(83380400001)(31686004)(7416002)(2906002)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxiQlBzUXV1eUZFNmlFY0xyL09kOWZLQ1poS1R4bXpEbXZJU0dNOFFKcGRz?=
 =?utf-8?B?QkNmRDVmaGdONU9vbmtoQzZYQ1JvMFd3ZkNFd2VKdC81Q1Fidlh6dVA1RnZQ?=
 =?utf-8?B?dHl2M09pK0Fub29OKy9mQms2RFRJczk4Q1dqQzZ3WE9RWFMwMkRJclB5QnJz?=
 =?utf-8?B?Qi9WbEtML0RWazA5UXlMVnlGTjl2ekpuLzE1VDY4c1orWnY1OXJHMW81UGxO?=
 =?utf-8?B?WGhHTEtxVE5hd3V6VGkwRG5JUlM5MDYrcmR1dHlZdzRwZVgyMnVUak1RblA1?=
 =?utf-8?B?cUhZWVZ4NndNeTBwS3JTTXpUQnF2MmZXMHMrck9QK2VLVTloT1E1dG5sMEM0?=
 =?utf-8?B?cmVkSzN0b3FmM3ZsbFIyc2FBM1YwRVBRVUxWRWlQdmVzVTJHU0Z0SlZISEE5?=
 =?utf-8?B?ek9PQWMyaEFFMklYeENVUDhOZDFYUnJQZC9DUnF5MUY0WnA5bEF0cE80WENn?=
 =?utf-8?B?dlpZaVFENm9UcDZHQjVqYXRZOVd0SmJ4UjhhZE5FSTRJRDFXQ204Z0lFRnk5?=
 =?utf-8?B?blVzOE1ZMElqQkxJY1VNRlFqZmJlVWVSVDE1UWRFa1NWUW1qOEl5VkFoWWhh?=
 =?utf-8?B?dkFGTVliMFV2UzRicG9PcDlSZ3lGYnhPaFE4T0JTaFBVcEtrNDcxaWwvU1V3?=
 =?utf-8?B?NDdjY20xRWtkZjNicWU3TTZuK2dTSS8vSmI0eEV4Nld4d3JValBTcHZ0b0VT?=
 =?utf-8?B?eG1CUGhuZ3RTZmZXSnJ2Z3FjQWNrc2xTeGRCT1FNaFd2Y0kyYmNaSWJSR2pO?=
 =?utf-8?B?citRZXovRHFOOXBkKzNCL01jUnFGTytiNnhRNnJiUmpqcnpTSmlDLzZDWEZz?=
 =?utf-8?B?WHBSRFpnWlkvcHkxeTlocExoTndLSWtGazFha3pTTU1EVzFsV2dMOC82Umgy?=
 =?utf-8?B?M3lsVy85RDBYbG8xRGdpQnpHSTBnc3VPVlQ4SkQxVkFER2xDR2FmQk5oaXFk?=
 =?utf-8?B?Z2srRDBJT1U1YmFJdm8xR042T1doVnlUNytXSjNUUytpZDY3bWdFVzBmUXN6?=
 =?utf-8?B?Z2YvZzY3LyszLzZpUUUxL0oxRjhmekFmWmVKWnhkUTBHbzVSYUp6M2htQ1pn?=
 =?utf-8?B?R3JuSVd3VHRjb2tMMFA4QTI2WUFTSDJnWS8rbnVHNFFQU3c1SWR6N1NUNm9H?=
 =?utf-8?B?dEs3ekNIUWNBQTN3Zzd6K1F3TzdBb2JSOVhsZGI1T09EeFFZT0txZWNTOFYy?=
 =?utf-8?B?MEYyR1Z5d2tKS3llVFZxWkJiL2ZuZGZEUmU5N2I2TmV5SjR4ZG1GL21Ya2VW?=
 =?utf-8?B?cE1oSWQyTkdyVnFYS0ZEOUF6cUR4NHdyM1VGL3grSHZBUEVxdWE2K3p3V1Zn?=
 =?utf-8?B?b0IwK0ZFWjFsR1o3RjlKUFQzalJrUHUySU11U0YvNXlhSFRPZWhFdmtzK3E3?=
 =?utf-8?B?cGJZYllTYmJjQjhVU2QvT0VaSTlMNUJoblk0WUh3Y3JKVjZaQ0ZZdml1L3dk?=
 =?utf-8?B?VzZsQXBXdndDWWd4QWVHSGlZRkl2Mno1ZUIxdlpVWVhySS9SWW1taERJL1Z3?=
 =?utf-8?B?S1NBeWFSQ2hHVmlaSEREQjMzejV0MDNqSVA4NUkrTzlCM25HUmVvL2FmbGda?=
 =?utf-8?B?eU10VGYzYWU0UGNpZGdSNTJaTlo2T1RpQnlRbXBSUU9jZzV5VmxZMXZUOTNo?=
 =?utf-8?B?Wi93U2NpV1lVT2R5c2JYamk4U3l6L0tKMUhMQTV2d2N1a2ZhaExKeHA4cHR4?=
 =?utf-8?B?eFdrTFMvL1MvQmEyRm5jVEFUaEVXaVhYRGNNM3lwWS9YZXlCNFE5aUJnMTNR?=
 =?utf-8?B?MEg3TDR3TEprVDk2SVlid3c3QVhMZDByMExUN1dncXdNUUswM0NtM2pXQkVB?=
 =?utf-8?B?R0cwYlpiRE8ySnB0Qkd3WXFVMkVoSGtqbmpDRFh5dHh5ZlpZTmd2ak1hbzRG?=
 =?utf-8?B?ZXZBMDgxKzFCUXJYVlRIQkpmaE1GaWpTNDRXTEJBZVB1VTFqQlQrdktyTmZJ?=
 =?utf-8?B?aEpYWDkydDl6emttOEVaUWtGaC9XS3hoYllMTGszaXN1ZVVFOWR5RnZhUWJp?=
 =?utf-8?B?UzlLMTZqNnZwd2VUN0sxcXY0K09lbVBnOThlOFJIa3labFdybmM0YjJDc00w?=
 =?utf-8?B?MEZHUDNjbk5kZ212RUpCSVdkdWNTNFdsYzJtbnc0ZDVpVkNITFIzUnJFV0Np?=
 =?utf-8?B?K3BTNnN1MVFCTE5EOUVad29WUVRzNTV3QlZMcHRyUUtDVVF3V0w2N3VtTEkw?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ef827cfe-8bf9-4543-83c4-08dbef3b4d14
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 11:23:37.9572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9QYDyZ7Sxk4+i+0qCVwmFS02QyBk1ZsSA42FbfJLfohyX0IydsEIL5dN7SVUrn8HDJlqQCp/QR3iin/+F+UhW+V1C1+UJ8Eqh6dcw2JXto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8198
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot to add the correct version prefix v2 in this series. I
will resend.

On 27.11.23 12:13, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Instead of printing the decimal error codes, let's use the more
> human-readable symbolic error names provided by the %pe printk
> format specifier.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes in v2:
> * new patch
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index a341b2fbb7b44..077824beffa01 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -68,7 +69,7 @@ static int onboard_hub_power_on(struct onboard_hub *hub)
>  
>  	err = regulator_bulk_enable(hub->pdata->num_supplies, hub->supplies);
>  	if (err) {
> -		dev_err(hub->dev, "failed to enable supplies: %d\n", err);
> +		dev_err(hub->dev, "failed to enable supplies: %pe\n", ERR_PTR(err));
>  		return err;
>  	}
>  
> @@ -88,7 +89,7 @@ static int onboard_hub_power_off(struct onboard_hub *hub)
>  
>  	err = regulator_bulk_disable(hub->pdata->num_supplies, hub->supplies);
>  	if (err) {
> -		dev_err(hub->dev, "failed to disable supplies: %d\n", err);
> +		dev_err(hub->dev, "failed to disable supplies: %pe\n", ERR_PTR(err));
>  		return err;
>  	}
>  
> @@ -235,7 +236,7 @@ static void onboard_hub_attach_usb_driver(struct work_struct *work)
>  
>  	err = driver_attach(&onboard_hub_usbdev_driver.drvwrap.driver);
>  	if (err)
> -		pr_err("Failed to attach USB driver: %d\n", err);
> +		pr_err("Failed to attach USB driver: %pe\n", ERR_PTR(err));
>  }
>  
>  static int onboard_hub_probe(struct platform_device *pdev)
> @@ -262,7 +263,7 @@ static int onboard_hub_probe(struct platform_device *pdev)
>  
>  	err = devm_regulator_bulk_get(dev, hub->pdata->num_supplies, hub->supplies);
>  	if (err) {
> -		dev_err(dev, "Failed to get regulator supplies: %d\n", err);
> +		dev_err(dev, "Failed to get regulator supplies: %pe\n", ERR_PTR(err));
>  		return err;
>  	}
>  
