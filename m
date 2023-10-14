Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA137C9714
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjJNWjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJNWjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:39:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC5EC9;
        Sat, 14 Oct 2023 15:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOJLDTRaH7mB5PvLCmguUlglwW5FtqiuQmXtlr79eF5szESuHhrRs7N4QIyL2Z58AEyl6Nm5JAi8RwrTU+x9DlvP5aksCxQUJcc94FRcRH99iNWGDoGqRcsJpTUwADmWjxhmbCAitxFNEB1rY8UDPNNDZNoKnoWC06VJMKmV6ZSDGXhiTt8lppN3gX1FDZHWZRab/xbqMnIfo1OpGJ4WGEhNI9OFxw2GOWnc4zvk5NllQWLdiBTmLLXjo/Mc7uUrjzZJGTaFqjncD3tY27PNrVwt4ouBBU1/zoCU1NKHTEw1SDLUVDyJjkaEI3wrT71aQOkODxOpAevuNnvvxmrZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhKzYoq0gxiI0VvhLVjm0O6WizMFS4S+Bfc4XlJYinY=;
 b=KLxtPrb3aii5pwwgM3jpiRE6CKcQawFpZFqxIM915FFDdFf0aif8nR6axpLMYvYSuwjAJRVKObSH/3Z6W6KlweUor8qL1H1K4LIAkVYoPZCJcMyyHJK8cozt48XZBzd5I44tH6yg/3wagvM4fo0t3JUu+PKv6MAQcahGlVmcgWH/uj+NqjyR42zxo1EcMqpBJ9Zy1wp0P0ZLIWVODfXFseRShLzJRFpFcVIvVNXHgRPdwCnwq7BgXj7dfA0W+k6FmmlwTnnweB5EpTm9+9h46WiAne8nshsiPR8MYaEOJXM2zoeocKR2LxiF6+U0CyUW48r86/fFTA/Itqg+7qxf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhKzYoq0gxiI0VvhLVjm0O6WizMFS4S+Bfc4XlJYinY=;
 b=G+8otvaPnW6Hh8EMZrZhcVbZgw4eADCmRb31ORUqgV1CXATWr+zB4e3FUcynp/H7W67b+6vXREuMUD2ZXlC/2gH//HAkDRvoD3IEiE7BflDhepVxIuXYEQa/lVZ0ZlyRAAGFh0TYVzmFcdM0CJjwUPff1L1aJF77yuzpXUoIjNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by GV2PR02MB8845.eurprd02.prod.outlook.com (2603:10a6:150:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sat, 14 Oct
 2023 22:38:53 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d%7]) with mapi id 15.20.6886.034; Sat, 14 Oct 2023
 22:38:53 +0000
Message-ID: <a0a55276-297b-e2b7-79b3-e4aadd39b400@axentia.se>
Date:   Sun, 15 Oct 2023 00:38:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: afe: rescale: Accept only offset channels
Content-Language: sv-SE
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0016.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::21) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|GV2PR02MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 836f76f4-1827-40b5-eb5e-08dbcd0657a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uIVtAjXJzUzkOWmD8yClCpyUCL7+faJu92Qoi/l8HVhjfylFU+AiZbSHNur2uPGtlbkJDa9HGBs92URVhHFrvc/hBUaK5DSay678iLrdkgtApL2oPuPXz8i/sHe/W6YHFPpDNDIk079CNiKe0LkXiHnrOO1YiFOtLBc8Ue9JT8QS+jNAu3FRusUHNKMxACbDuDKy1XJPMxW92uhpSgPEpxkofaQw44PoQJLm+1XjM0ll3LgGeXhNmnRySIWVCrUth7arOFm24MqsZl92G5ElHV7DKJujupS8VNcpcM3W84E4KiP7vRVtusNg+9+p0RFvEmLPXaogC0Kg/1Rh8Y5Or0sLb4GNNSqBO0HHuNPedvQkcONBUw707qaRZApn+XhwXO92iK8mQZW/+VB6sulpvcT19dgr/JHxQBFrDuqK2RlcH0VFa0S3RcxKPmlqbS6loElxvdsN8k+6W1If/VbJRXb5MLqOBXYWdGzXWSKDp/hhMDmMf2htPyv4FVYPkE+mGOAHLnEbSEPgh0dC0/JFKe3ur2tAsb62yTOAltPuVnjktjea7g7gViU7MFvdU6LUjZ1BQeC5uQKPa4R4cN99nWRtpy8d8Gx92+eXg0tD1dX9kK1hvc7jPRZpgbbSrSYsgLaEo5oPmYHO7qzzqsHug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(376002)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(110136005)(316002)(66946007)(66556008)(66476007)(26005)(83380400001)(36756003)(2616005)(6512007)(38100700002)(86362001)(31696002)(6486002)(966005)(478600001)(6506007)(41300700001)(5660300002)(31686004)(2906002)(66899024)(8676002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25mbXBKWWo0NjdwNFpBR0J5RGF0aUk1UG5QRVMyNXlDbkJjQitmdDV2blN4?=
 =?utf-8?B?NkpTRXdlMThKS1Mvd1YvYU42SlpWVHJScXRScjBCdm1lV0RaNHJkeTFkdjJl?=
 =?utf-8?B?SFpzU285aE1TUi9vVjlqUFVMYWFhREZ2NUEyY1Flc1F1YWlWODVLSXQyOFZE?=
 =?utf-8?B?bHo0Z2RnWkN3N05tQUN1NEFSeTFzSkVuRmlMdUhhS1VBYkk4YlJIWW5qZUEz?=
 =?utf-8?B?R09zbjJNU053Z0NkMm9Ma1N4WmUvdG85azQ5YUNUeWR0cWxCc2MvZmY1bWRL?=
 =?utf-8?B?OENIcGFXUVQrWEFibXF1aWU5aWFHM2ZtV0RrYjhYQTF4end2TlROYmhld1lJ?=
 =?utf-8?B?aXdHa3BkVDB2dmRZcDJXc2pwUUpSUWIzOGF4THFLcjN5Wm4rYnJVUDJWTTlm?=
 =?utf-8?B?L1F5QkZ1R1R2bFdzQ0x2Mm10ZTVybUdlZDNFZWhqaHREQ09ZQlpBNE5Bd3Bn?=
 =?utf-8?B?a1VTa21WVU9ZMFBHcTlQeEpNbTNxUDQ4ZnI5MVVVc1VZOUxlSGhEMEkyaWNu?=
 =?utf-8?B?ZVR6Q201MFduMFgwYnVscFZPbTZWSUdXWHA4Q3Q0Y0o5QWM2azMyTGErUjMy?=
 =?utf-8?B?NXJSOFZlZjlQZEc3V0xzU29uS2JOak4ybW55ZVkyNjFGTWhKRiswRXZiNHFG?=
 =?utf-8?B?Q0diZlMxZnk4OXVVeFM4U0xCKzY2bmZwNU5Lck5KOWo1dlcwTDB6d0RpdEtp?=
 =?utf-8?B?STJaZzNacDlzT0l2MmxmcENDdjlLcFhwdjVuWHRLejdVcUt2eUNDVi9DU3JB?=
 =?utf-8?B?YlZHU1lJSUIyTGlqNHNBdGViTHJvYUIwNU8wVS9sODg1dUM0WmhZYk5BaUl0?=
 =?utf-8?B?WEpORjE1bUZEME9IMmIrQ3BvL2hiVlZsNS9DVTVpVnpoTGd0bEs2WFBpN2ZI?=
 =?utf-8?B?NFZzS1hWSHRWSzdvZmxZczNjR2c4eS8yT3M1dnUzbnROSjNCdVhqUGg1dlZs?=
 =?utf-8?B?NllnNW91NkE1VnpiL1NIcng5Q1RMT0kxYzh3T05FSnpxWmM1ZzNkb2lpRDlE?=
 =?utf-8?B?OU1QNjFSZWRaRlZ3YVRlSDVTMnF1czN0NnhhM1VOMVV1aEZYRVJ5N2RRc29Z?=
 =?utf-8?B?eTI1R05XUGlBU2s0cXhySnNnY3JjTmZSVkNRN04zTUlEeHJOcDAyaTZpZXFn?=
 =?utf-8?B?N0lRZHlkT0JWV0VUYlAxRjRwRFhVYXk0cjJZNU1LRDFjQTQvMVZtZTkrS1Vy?=
 =?utf-8?B?d0xHTmZrc2dwZ1NvdUFiMXpiUms1c2NaeUpscG43aWRhN0k3Wm1PVEZlOFBv?=
 =?utf-8?B?RmgrRXFsbzc3Q3FQQ0U0Y1UrZFpiQ1lGOHQ3aWdKWHdiZHpIT04vZXlnWkJU?=
 =?utf-8?B?Z0lvVGJiUVk3S2tXcG96RGYxbXI1VGxZZnJTTVNiN29keEJqcEdsbm85MnRN?=
 =?utf-8?B?eHlQb0VCa2JueW1iRk5WOG9PU1l2Kzg0ZGYxRE8xbko2anYwL3BaZytxdE9N?=
 =?utf-8?B?em5OOHFLMENXNWZzZWRKa3loNUtnTDd2UFBBQnlObmNubmQ3T1UrdHZKK3BL?=
 =?utf-8?B?RWEvRzV4TXhiL25ucEJjcU4zbTZJMDI4VmNSayt2dDZYZWZDRjJqOVBkazJF?=
 =?utf-8?B?WW9JRHUwN1FKY2xYS0dlVlVBTTJpUStYbjN6MTVLbmxoZldVMHpZRDZlUjlH?=
 =?utf-8?B?RHJvNitFK0Z4SW5BY05HUExpN3QwTUo3eEFtQVhxZkJ3bXZ1Wjl6VHArVXVu?=
 =?utf-8?B?TnR6ZHFYaXFFUk56STRFSmNoc3ZBQlJmbkxkLzRrWWdYYlFCMlE2UDBZQnRp?=
 =?utf-8?B?TC9qZUFSN096WVA3cXlwUE5vSkRadVBMdWZEMTBMSmlPWUszcDJjK3Z3dzM5?=
 =?utf-8?B?V2NCM3FHK0pRc0FJVGFYcy9MdDRvSmIxMzUwUFpyLy9oM3dPSDJ3d0ZBR3Fl?=
 =?utf-8?B?ei9qeXd2OFFKK2ZxdVJaSTdYR2QyTHBuNUwrM3MwQzRmV0V0dWtmUjYwUFpa?=
 =?utf-8?B?TjdBM2lHT0ZXWnQvdnZPTmJlUVdJeWl0alhvVWI3dEwrdkhHa3J0WHRqM3RP?=
 =?utf-8?B?UjBRaTkxckFma0VlMHlPdUZZaGZFVlpKKzIraFhHdnFReXdhVkI3ZXpwdW9X?=
 =?utf-8?B?ZUpQbFlZOWpRcmxmeHo3dkR1T253cHpVZjF5eTdDUU1wMG04ZHVVa2I3WWdD?=
 =?utf-8?Q?vJzQAvIOVXpCSppyKLewL+xtu?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 836f76f4-1827-40b5-eb5e-08dbcd0657a0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 22:38:52.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMoAqts39tCPXIFYTbvdq7wqQe670cPE0R+v0GobnJk9TZOxfjPX3irH+IDLNxZT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8845
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry for the delay, and thank you Jonathan for the reminder.

2023-09-02 at 21:46, Linus Walleij wrote:
> As noted by Jonathan Cameron: it is perfectly legal for a channel
> to have an offset but no scale in addition to the raw interface.
> The conversion will imply that scale is 1:1.
> 
> Make rescale_configure_channel() accept just scale, or just offset
> to process a channel.
> 
> When a user asks for IIO_CHAN_INFO_OFFSET in rescale_read_raw()
> we now have to deal with the fact that OFFSET could be present
> but SCALE missing. Add code to simply scale 1:1 in this case.
> 
> Link: https://lore.kernel.org/linux-iio/CACRpkdZXBjHU4t-GVOCFxRO-AHGxKnxMeHD2s4Y4PuC29gBq6g@mail.gmail.com/
> Fixes: 53ebee949980 ("iio: afe: iio-rescale: Support processed channels")
> Fixes: 9decacd8b3a4 ("iio: afe: rescale: Fix boolean logic bug")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Fix rescale_read_raw() handle channels with offset but no scale.
> - Link to v1: https://lore.kernel.org/r/20230830-iio-rescale-only-offset-v1-1-40ab9f4436c7@linaro.org
> ---
>  drivers/iio/afe/iio-rescale.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 1f280c360701..56e5913ab82d 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -214,8 +214,18 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  				return ret < 0 ? ret : -EOPNOTSUPP;
>  		}
>  
> -		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
> -		return rescale_process_offset(rescale, ret, scale, scale2,
> +		if (iio_channel_has_info(rescale->source->channel,
> +					 IIO_CHAN_INFO_SCALE)) {
> +			ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
> +			return rescale_process_offset(rescale, ret, scale, scale2,
> +						      schan_off, val, val2);
> +		}
> +
> +		/*
> +		 * If we get here we have no scale so scale 1:1 but apply
> +		 * rescaler and offset, if any.
> +		 */
> +		return rescale_process_offset(rescale, IIO_VAL_FRACTIONAL, 1, 1,
>  					      schan_off, val, val2);
>  	default:
>  		return -EINVAL;
> @@ -280,8 +290,9 @@ static int rescale_configure_channel(struct device *dev,
>  	chan->type = rescale->cfg->type;
>  
>  	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
> -	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> -		dev_info(dev, "using raw+scale source channel\n");
> +	    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
> +	     iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
> +		dev_info(dev, "using raw+scale/offset source channel\n");

If the rules really are that when not provided scale is 1 and offset 0
(reasonable of course) then the above still looks suspect to me. Should
this part not simply be

  	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW)) {
		dev_info(dev, "using raw source channel\n");

in that case?

Or was "raw + processed" some kind of special case that we want to handle
as processed? If that's the case then we need to have more complex logic.

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
