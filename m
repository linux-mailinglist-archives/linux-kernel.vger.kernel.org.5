Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592BD78DDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbjH3Sy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbjH3JLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:11:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2130.outbound.protection.outlook.com [40.107.6.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC202D2;
        Wed, 30 Aug 2023 02:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBu7MHYsxdxUwCyKBRFb6+sWmytHCVVNWieNs7Lv6d1GzQeRtVwi6WPG1iuRSrf7ZHbyXiOf1E7OiXx2CFNBkzYFYxuzyDe+XdmPs3aCpdI9+43WczpPXNMhsXTPwqHrUXFREBMH/mmNW7XWMU8S1h7ibrebVRBXzBHneEO1nAlcXBtulI3m91mfJk8yDrpt1DKADYjz4NV/m0swYOkCVRNfLm/s4XiOZZhzSJindR6dOXFZ+3iYTKccUM3b8bmzTOIcneN/10VhvGUbgNk6E99UvfT8S7vQE1U66PPzm/Zf9pOUhiEliUN6MXc0ESjBnbWwHnQcb9vVs6ZjPhLIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvgtR5/IMdD5JAMsq4on5dys8m7plz9QforTQ03W62U=;
 b=Rd83YWW2AsRROFriZVyPYL+T9RZh+6JrrTcxFNaD6SYCWfXrjrTyn+8yKQ9cB2cCXvocOt5wRJIHLRi4BRoumW+dZNZk0YzmMDtAbJroI73E+P9O/xtTTS/YsxpV9JRcPHr8mjn9OZZykHcPv+USI/0kzLKuP7PXIADIYjDppaMonzVbLZwBIXevVUC0Q3VUTwSejSVZBA+UaNgJFIVwjOkeeFfrHfUftYh0riXZtG7ZJ5MfbOkvDMu6eMnG0rheGnkr7WmMUUNtMprPrDMua5xZpt//avDEEUjCzHBGR1iebR958vgG8Rog6RZ3MYL/7P20CFgZRE5evrCFEkpYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvgtR5/IMdD5JAMsq4on5dys8m7plz9QforTQ03W62U=;
 b=GH91SDM4hU6vQXuZixKAgJkzlPswlcV9tf4fLnGFoxXblCGWO+GkNJbqwtYpvbL2k5I+UFB/hHLeaMkrZMDC5lREerghtAiFFQj0X5x6k8O61RuYSDPJqun0TiX2M08v++v4Unx9y2DfcQi/5VA+PXs1S5viV4XYPwv3xQMHOCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB8PR02MB5899.eurprd02.prod.outlook.com (2603:10a6:10:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 30 Aug
 2023 09:11:22 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7b40:7a7d:595e:623c]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::7b40:7a7d:595e:623c%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 09:11:22 +0000
Message-ID: <39d52aef-d775-7e5c-95a3-52172326f5e4@axentia.se>
Date:   Wed, 30 Aug 2023 11:11:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: afe: rescale: Accept only offset channels
Content-Language: sv-SE
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230830-iio-rescale-only-offset-v1-1-40ab9f4436c7@linaro.org>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230830-iio-rescale-only-offset-v1-1-40ab9f4436c7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::28) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DB8PR02MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: a37c5acf-1fe6-4872-de4f-08dba939144e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SgHFuJMYYxm68GI3f00SaWJGT+CXHwDiVtvVY/xVBpd+Rc8gkqkxx7zJ+wgVNvYKBE3hdxRjPOjIskrC7ZGGgmY8mwMGypPuoEgjd2Ay4VV60ShUd0OM7balRygrQeEXPHE5U6ezEhNPWNMSzjGr0uX14Ig0ywhRZMrrL6bI1hWXW/0HR7qbgfgxg1kWvSJnwnVmGZ4nHifl6xp2kJ7zsXNMrp2/JEP+kSNqykNBfMtsB1ZFe3STDt+gvGlYy1NIqX/aUby8T+XD4k38s+XrUXdA7P0GCUPH2bdJQttY8KyejJNH/UHI08qkQmNXoNtIxPApuOjoGL+jbG48MwBgTSo42S4YFIO7R7lm178ObJ9hIG2UW2UFw2mIc7Th2FzqWIsTakb8reXUcHobDED1ncIzakr6N4urCvwCKJsMUttlrXmvVqLmi94p+9gJHS9YLcMlH7hJIHRQqPg6Ecoqsdl009LzLWjRG8AWNRby/UK0oxX0tLww/MNQsqIuz+vBDloeimIo3COU/ppp5W2LoOFMCsuCdxZNQ+oolVKUrpFHUKEk3Oj6svVMIxX/RQdRPWarXap4CU8fXBgN0NamwA5Z4+chd3vm9oLCzmRTz0lQymHyCP17jIEkJ94ysoWcaudEpZaUymXiXJAyH2t/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39840400004)(451199024)(186009)(1800799009)(83380400001)(8676002)(8936002)(6506007)(41300700001)(26005)(36756003)(2616005)(2906002)(5660300002)(31696002)(38100700002)(6512007)(110136005)(6486002)(66556008)(966005)(86362001)(478600001)(31686004)(4326008)(66476007)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2o1NzNldkpBSE1QSUdIVEY1RUozcmFjOTZzT3JtelhRQ1JHVVNobkxndG54?=
 =?utf-8?B?RHJFMjN1bStKNGFZQU5TektWa0huL21JNm4vaE1OUGJla05HWUpvZTc2a2c5?=
 =?utf-8?B?aDJkTzVMRU85bWZVb1ovUW53KzNwL0pHOGg4c2JZNXg5UnJDV1dqMXJzUnZy?=
 =?utf-8?B?dWtWcnkxU2ZaY3p4YlpyU2xwMG9wSHJveTkwQUxPQ3R0UWpTVmszN0dhdFJk?=
 =?utf-8?B?ekRkb2lQSCtxUU5YSzA5UUZCeEkvM0o2alh6NTYxUHYwN3FiWjNoRjI2VC80?=
 =?utf-8?B?NzEvcnAraFVuMmR3azBYSms4bFZLaWxKODJGZC8zR3NSeE1SdC9nMGYwMmtF?=
 =?utf-8?B?MXVIQjlDMFh3OXhiSXRETVB6VHkzbWdKM2U3cDBqWTdLRXlSUkplNmNXK0Uw?=
 =?utf-8?B?QnQraEs1QkhzWVJpdDBPeURSMHNSUmcwRDRDMUkraC92MFlYUDEvajMyVEVz?=
 =?utf-8?B?eWt1VEQ4ZnFmZnRKb2FwaTRzZFpXUVdNb0pRLzByUVppS1Nwd1RRODNlVTE1?=
 =?utf-8?B?NWEwV0tmZCtpS2tTVDNMcHZmZTNHQVE0WFV3SHZHUWRjR0lvam1RaFluaUJC?=
 =?utf-8?B?WW4vVUdwaUlsazVNVCs3SFBKcno4TXlRdGFyM1RUS0lJYVF6TVNvTmhaQTZP?=
 =?utf-8?B?T3ovZklhTWVnNTRUTWZRcEdpLzJQeFlaWHFzSUpIZ2NjUzJmUjgyamRyRmpu?=
 =?utf-8?B?Z2QrM2dYeU8yaGJvUzRHSU54WVVEem93bS8zSVBqcEEwRlpNNVFqYWl4RU93?=
 =?utf-8?B?a2tpSVFoMVdROVF2VFRrV3RuRXFTR1BXN3pOZDU1Ym1nU2RkbTYvcElLa2Ey?=
 =?utf-8?B?dVdxVGpRVng3cTA3NE8wWm9qbzZ3dDNTUDVQVEpqTFZpbE9Ob2d0VVRyVkpX?=
 =?utf-8?B?QVVEdnlvV2dDeElwaG1mTWhwcWNKK3Q1QlI2M0xPMVN1SmRBZW1CM3M0cjhU?=
 =?utf-8?B?cmV2Z1ZXaE5SQ0pacGdGQk8wOXZGei9GTjlRcEY1ZTRJL2o0Vzh1RmVFbUhv?=
 =?utf-8?B?Y1NucHFXSWZnVDhBd0RHYm10NmI5aFEvNW5FM3p6MHdLSE5uQXBVcmhiYXZI?=
 =?utf-8?B?Tk1qSzlLVDlSMld4K282bXVsTWtWUWRxTzFIemJNanNhbWNFZ0VJb0JZM3RD?=
 =?utf-8?B?cDV1a25xZHpPMTkxRjVLQUR6cjFYcHJSYzlEbnorOE0zdDNiS080V2FOTTBJ?=
 =?utf-8?B?TkdzSmxWUjlZZDBWMUh6cncxT1ZVR3dHN2dHRENVWTNZNHJBanhNSGxhSXY3?=
 =?utf-8?B?eUxUeHE2WVBWbDZ4allBN2FMaWZaako3VXhndjhOVmhVT0NlMmovUXBteGxK?=
 =?utf-8?B?eVIweFI2RkFjeFB0UEZnc0x2MjVLSnFhOU01OGZOUUZQTk1pend0T09sNm9t?=
 =?utf-8?B?QUVuamkxRnlwdjJWWkk1TlRtOWIvV1NFb2x0emFpWURrQUVLbVkzUWZaY3V6?=
 =?utf-8?B?cFJyeXJaTERkejZKZ0w0dTZ3Yk0wSHdXVWxqcWRJZWl5amVWVFhmWFFSTTBO?=
 =?utf-8?B?UExaRzhIN1hoc3VVaDJiaXpQMnhiQUZIbTVqK0RZeHRYWlBTMnVCMVJ5QzRy?=
 =?utf-8?B?MzExa3JNd0NKQ2FqTUtjc0dwNTB2TmRxbmg4OFd3b3lKLzl3V0FUZ0drNFFV?=
 =?utf-8?B?MExhUXp4ZzI1TnNJUnhxeHJRUUpSUUpGWWZXdWVHdEpEclJNK2NOaDZHbDU2?=
 =?utf-8?B?RkMxTXV2WVJQejRQVDRHTGVqNVJBYmpCMnkzdndhMWxralp4MUxCZnpUWUhG?=
 =?utf-8?B?L2gveGd4UHFyZFFvOEJZQkhtbDF5S1c0ZzJBYkJtblU5UGpNYVdLSjVtMysx?=
 =?utf-8?B?MWhtR2VGOWFOeWJhNlJEemtNTCt5cUJNVldSYXIyaUJUcndiQjkyRFh2MXFk?=
 =?utf-8?B?UlRNaXhnVm1pV290RWM0WVhMZDIzbm1ad2VZb2lPVXNNUlhIcDZYWmNxcWxV?=
 =?utf-8?B?Z1JsQTQwckI1NkNwL0lIcExIZno4SHNWTE1OR1hTWnBGUkx3elRQZFp4WkRm?=
 =?utf-8?B?eWNLZGJhTXNLU2t2eVZqMDAydDlwbHVIUVk0eU9uZG9TUXlIckFtaU9VNUNv?=
 =?utf-8?B?NzhUSW85RHh1M3doQjVITGlWUnNUK2IwZHIvMGtXSVNDcWg1dkR4NGRkTFFB?=
 =?utf-8?Q?cJgKWfvvk1YJ8ZpngL1KqCRKm?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a37c5acf-1fe6-4872-de4f-08dba939144e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 09:11:22.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbYFigY1tr7QUXhqIQyRYrhcAETidEDoTCZ4UFijiQkf0ggnvSkKbWiZjDJuSvc6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5899
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-08-30 at 10:52, Linus Walleij wrote:
> As noted by Jonathan Cameron: it is perfectly legal for a channel
> to have an offset but no scale in addition to the raw interface.
> The conversion will imply that scale is 1:1.
> 
> Make rescale_configure_channel() accept just scale, or just offset
> to process a channel.
> 
> The code to handle channels with just offset is already there.
> 
> Link: https://lore.kernel.org/linux-iio/CACRpkdZXBjHU4t-GVOCFxRO-AHGxKnxMeHD2s4Y4PuC29gBq6g@mail.gmail.com/
> Fixes: 53ebee949980 ("iio: afe: iio-rescale: Support processed channels")
> Fixes: 9decacd8b3a4 ("iio: afe: rescale: Fix boolean logic bug")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/afe/iio-rescale.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 1f280c360701..18aafb4bdda0 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -280,8 +280,9 @@ static int rescale_configure_channel(struct device *dev,
>  	chan->type = rescale->cfg->type;
>  
>  	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
> -	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> -		dev_info(dev, "using raw+scale source channel\n");
> +	    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
> +	     iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
> +		dev_info(dev, "using raw+scale/offset source channel\n");

I do not think it's that simple. The rescale_read_raw function, when asked
for IIO_CHAN_INFO_OFFSET, must know the scale of the source channel in
order to rescale the offset. After this patch, trying to get the rescaled
scale/offset when the source channel has an offset but lacks a scale will
simply return -EOPNOTSUPP.

Which is not what you intended, I think?

Cheers,
Peter

>  	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
>  		dev_info(dev, "using processed channel\n");
>  		rescale->chan_processed = true;
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230830-iio-rescale-only-offset-f28e05bd2deb
> 
> Best regards,
