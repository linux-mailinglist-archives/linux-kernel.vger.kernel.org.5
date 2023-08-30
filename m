Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F8F78D854
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjH3SaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241409AbjH3Gyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:54:31 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF631194;
        Tue, 29 Aug 2023 23:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KD/HKk/CjoG470L+8DAwAP78L9vg2RW4Nt8DCUQ7C5wPUNqXJx1FwPN1JzuunwlDdSSEEavgZlDxDDpgsiSJN3yqAbOLrwfS9OFkck8E7f2jLxvyLXaNEtaQA0DhazWoSG+U2nGUkZux+YkEOmHR1FZwJHZom/D42F0fE5LndvtvqWoKAc0Oz+LWKJK1jwfxq9Q6CR8EGs/5PAdFb8wwTSXWp9qL5hZ4o8QwHqOqe/9eIWZYgEgMfK1L1XKSMGYQ3eJ7LjMlF+Fgb2jXLXtM6S1h1QAK/wrSU1DAaQM6sNBwuF8KZjBo+rGlakclwa//mnobskB5KdSxrN8Bi2GzUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moNvha9n8NKuRnXLmFtRO8CPcTytCV/jXETHhObgA/Y=;
 b=Otjhc+uv2YzwnjafhUAQiPdmlQYcJEfTWtPbTf0/ZZe65oEMdMuLaNivu+MliML9rHQMpkBYy2cB5g1pI+MI2hxQ8qdqqk+n74Ffp6HP0AVDYPpSvS0VClIOGDIFfv7NRBpfhcLZRLaUyYwa2BXzIwRFlbMTHfm9r/Regzq0/a62gJhHI1ESdmCTOyw3wcWEJhoydmGvakRC3tJ2sJZ0uv3mPPRBqpbcZoe7iQDlkL9hNG9CTlFG0z7HFfgfJ0KOeBp02g18+uqGhrmO/Ave3NzeS4dSfkU09MoumtJgOjWmqgapqenhTh0eJfTy4zA7Y+LYEaWCKmoyE6vWf3RHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moNvha9n8NKuRnXLmFtRO8CPcTytCV/jXETHhObgA/Y=;
 b=gJAk7jQBe2yPR+N2yR1+l+O9mhlVKcMshFUjzpNxDUmVXVpjLc+UEi90dWXQYew2k48XzIRQ/oVC/kn1sahmaY5mXdkt6CXRrgq4alH1Lqn6sBZ90VopS/vbOx7g5/e22DyDV5+ciT2rdP1YVtOMqDjIO/UiOuFyJNVg1XNUxgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB9834.eurprd08.prod.outlook.com (2603:10a6:20b:605::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Wed, 30 Aug
 2023 06:54:21 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::8c2e:9706:f4c0:e3f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::8c2e:9706:f4c0:e3f4%4]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 06:54:21 +0000
Message-ID: <224f2a1b-f06b-73c2-364b-4b72cc26b2d8@wolfvision.net>
Date:   Wed, 30 Aug 2023 08:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] media: i2c: imx415: Use v4l2_subdev_get_fmt()
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Gerald Loacker <Gerald.Loacker@wolfvision.net>
References: <20230830045323.71768-1-umang.jain@ideasonboard.com>
 <20230830045323.71768-3-umang.jain@ideasonboard.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <20230830045323.71768-3-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0246.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::19) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb855a9-956a-49bd-6a84-08dba925f05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBwHBQUapLbyVBgg1OBMM3Z3GN6vg6VbMA5PGdGN87EqML9/VQAgq6JrkP848NGlo5YtYFmhLyGpeXaz7qqJwU/b88GSswDkMVECfzmSj2TI3SYQAnzHlpwIKYsBMe8NkIGqymoSP7lj/M3oswNcRXAAKsG6foYedXCapzEa7b9zr5eHzr5NUR71/FswRsPPVZEYxAbj6Rw5IK8XHJJ2F3qGiZneVjM1nGamwme8Ri76egm/uxL4sYMDkK7++JkFP7zRtKIHe0fp+kbAlbtdmfzvA0raS3PaKrvrBaGLXIowcwjxDJRD8Ub9KZ6j+/bHm/64+ERobtF7kM/QCM1ySK2jdAMs+T/ar/fhohJ9dFtcarV7NFT3RdJwLa8WhfwoKrNtO7faxDRTulFrrv+aUSB6x+rSPsh0wWN1o+JMM/14eOenzkAjUI2WxNKr2n//yRQawKOgmhxaNrjF2swuY8qCqFZ/1pmk0ZikAs1RLzYOELx71WuIzwrlVMtGw1OVLAHx/TRMd3/h3tWQk4kYRFKwrPLtrnK4wVDi/e9m5LO/o35C6879fBrGE9h0J1tE7WYJiRClWkSdfgzz1Yzt39HTYjCJDpmTchwY5pGMc1ImQUEQEj5CQeBycrNf2D7Sr1q3pIGighJ+L1Gy8TnfFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39850400004)(1800799009)(186009)(451199024)(8936002)(53546011)(478600001)(31686004)(66556008)(6506007)(66946007)(66476007)(54906003)(36916002)(6486002)(316002)(38100700002)(41300700001)(6512007)(26005)(44832011)(5660300002)(8676002)(36756003)(107886003)(83380400001)(2906002)(31696002)(2616005)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFkWWZxWS95R0l3RnVQYW4xeUc5dFp2Z1ZObDMrUmk2cDBsTUpzbksyUHlw?=
 =?utf-8?B?MHNEelNXN3FaWEtJM1BKMFNjZVA0bmgyNDBGM3ZMRWF3UFNyaVdVakFqR29a?=
 =?utf-8?B?YSthTExId1lqc2swZy9GZ3JtaCtRbTZ1OEJ5dUt1aGJjMjJDbGZvTmpudGxz?=
 =?utf-8?B?eWR5MmxLenhhbVc4RUJQdnkrb3lJakRFZjlLSE8wTVFVWlorVEZIcjQwTXlD?=
 =?utf-8?B?M2RhaVg0Yk5MQVlYNWM4WGxFUmE1QVl4UnlyaXdXbDV0Uk95NjRacFM4NDVQ?=
 =?utf-8?B?MlphN0R4dW4vQjViY090WGVrTnFGODBGc09nTU9abUpMNmxxNmdyU2pJRFMv?=
 =?utf-8?B?bVFkc0NpYmJ2RkNvMUhLaHB3MTljeUMyQVZyT1dFZUdjWkdXM1hBSjZWa2dh?=
 =?utf-8?B?OSsraGFiUlR2M3hoNjIvM2l6TTVJa2VLU0k0VG05R2FBWXBmQUZBVWZLMnpH?=
 =?utf-8?B?cTZUa2tSK3F1cGJTNENqSnBwdlF0Y214cGh3c29XemZodDFZSmZVRldNNjQw?=
 =?utf-8?B?cGl5WWRwOVZZRzMycUh6d09NbU93NjVadzZIclpzK1BZaDRGTXJLSjlPTjVq?=
 =?utf-8?B?MXVDTDhkTmxUbWJVSFJmQi9aMUpidkkzZXVNS2tGclEzSTI0ZHdvUmJnbGgw?=
 =?utf-8?B?Nmo4Tml1ZlJQVmdJdk9yQm9Yd0Y0SFFtNWRJY1B2L0NSMDhtOExhcllrT3FS?=
 =?utf-8?B?T2wzT1ZsOXJONXlocnN3L3pscmMyZEFDQ25JUEdQNnZkaFpLTFRkbHNtci9L?=
 =?utf-8?B?L1JlT3FTNHJwcFV5Z2F5c2Q4MThCZEVxaXRyQUVUUVJkYUNBQ0p3bWRzazBK?=
 =?utf-8?B?SitYZWRVNDBLc2ZFdHpvSTF6VVBiUlA3K0VvVjVhZWY5WTdTeC8reUJkaUdZ?=
 =?utf-8?B?VDYxRVdtY2l5WStUN1VzRElyYWxTcVMwaVNxbm9JRWpKaXhDMmlNUzhidUNh?=
 =?utf-8?B?bmlnbzRzaGpDSTBVZ2svc3E0TmoxcDd5aHh1ZDVrSWs4Zm5BV1VpT3ZtZG5t?=
 =?utf-8?B?QmFaT0lhakdPMlpKeEN6N1h3WUE4RUFNdVhLYlJ4dmRWZitYbU1LcW1BUjBG?=
 =?utf-8?B?N0RWQjdMZTRia3pJZi8zNGtkcEEvUjVUOHdDd0JHMWZtVHc4N0FVYkM5VWJz?=
 =?utf-8?B?UUY4NjRaWU5kcjdBVzZ1S0VBTEhFNEhCdlNHYklvazF6bTFlSnB1ZzBVTnFK?=
 =?utf-8?B?bkcrTVpBMVlEeHJhTFpNeGljZjQwRWZmakZWTkpDSEVTN25YNjVDRSs5a0Fr?=
 =?utf-8?B?OVd0NFk4aXZBcldndlV1Vm9MVTNxY0l1VURielFpQVNMbEc2MFlzQmtrUWZE?=
 =?utf-8?B?NlIwMFZLb3dad3RvNXd3akRoT3QwZTY2QlRWR2NKMjJxRUZjbHBDWU1WdzZt?=
 =?utf-8?B?c2cyZXYzam93cEpVL3Uzc3BCZCt3eFpyRlVucjdrTW5HWGxOYjVwMTA3Tm90?=
 =?utf-8?B?RVdSeU9oTFFueG9BMUdYUzkzSjVpcEVSdWZWTkoxWUMrR3o5RElRaGk5Z0dK?=
 =?utf-8?B?TEtaRm1ZRjZjdHhUSGF1UHdTVEVFVDBXTk5VY2J1V0RPUE9FaWUxMjBFR3ds?=
 =?utf-8?B?aGp3WDBSWVFWV2tCa2J3Z1JvT3hLNUEvRFVsSEplUk04TUVNd2xXM21nS2d0?=
 =?utf-8?B?RS9tVmJmbytZU3Zkb2d6Z3RqVjJtcVVZbGdwNkNPTXlTTVkwY1VUcWFPU1Nu?=
 =?utf-8?B?QWdJU004UktQeHhrNkZORlk0U3pneXJ4V0pVemdlM1RCSnlWbWU1TzlJaG10?=
 =?utf-8?B?ZnBzSVE1dEpXalFTVWVZdWVrdjcrZU1udXBFMmJtT0xzWTNXMy9CeEQ5NVB5?=
 =?utf-8?B?V2tDbWtrY05BOXN5Tjc2cnRMazd3MjZpWFltN21BV1ZJOXhoNWdzUVFuNkh0?=
 =?utf-8?B?WGZCOEJ6WU43aU9SVnJmcUR5dGwvaGJPeWE1MUZCaFdDb1FPTmxXQWQ5c0Nl?=
 =?utf-8?B?aGJaNk4yUVNsVXRYTkJhY2ladWd3TXQxWXptWURaNTJuQXZndjF6aDl2Z1RY?=
 =?utf-8?B?Z0R5Rkx0YVNxY2lQVDFMOXdXU09kYTdkd0FVQVZFUnVyNXVVUzhtK243VFo4?=
 =?utf-8?B?V2EyTENDZVAycmM1R09TNzJSV0Nod1gvWnZ1RWhUZGM2Q2M2YjV3TENsOExW?=
 =?utf-8?B?ck5XR1BJWTZacXUySTRBVURaNVJvUEtTaHdpWEhJOS8yZnZldHhtbWlxQS9G?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb855a9-956a-49bd-6a84-08dba925f05e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 06:54:21.6206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oKIy6mpKU1KDQjtijdChlA/DO1Z0yfJLt4z6BC3/FECZq4He3vizLEAsJQrapjWI7CBsLKDQeDCqOtXeS0RHJUnHQs2nITttOcuH7waG/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9834
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

On 8/30/23 06:53, Umang Jain wrote:
> The imx415 driver uses the subdev active state, there's
> no need to implement the .get_fmt() operation manually. Use
> the v4l2_subdev_get_fmt() helper instead.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>

Thanks for the patch, we'll try to give it a test. Due to time
constraints this might take a bit, though :-/

Cc: Gerald

That said, without having it tested the patch LGTM:

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>

Best regards,
Michael

> ---
>  drivers/media/i2c/imx415.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
> index 3f00172df3cc..9a7ac81edc28 100644
> --- a/drivers/media/i2c/imx415.c
> +++ b/drivers/media/i2c/imx415.c
> @@ -842,15 +842,6 @@ static int imx415_enum_frame_size(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> -static int imx415_get_format(struct v4l2_subdev *sd,
> -			     struct v4l2_subdev_state *state,
> -			     struct v4l2_subdev_format *fmt)
> -{
> -	fmt->format = *v4l2_subdev_get_pad_format(sd, state, fmt->pad);
> -
> -	return 0;
> -}
> -
>  static int imx415_set_format(struct v4l2_subdev *sd,
>  			     struct v4l2_subdev_state *state,
>  			     struct v4l2_subdev_format *fmt)
> @@ -913,7 +904,7 @@ static const struct v4l2_subdev_video_ops imx415_subdev_video_ops = {
>  static const struct v4l2_subdev_pad_ops imx415_subdev_pad_ops = {
>  	.enum_mbus_code = imx415_enum_mbus_code,
>  	.enum_frame_size = imx415_enum_frame_size,
> -	.get_fmt = imx415_get_format,
> +	.get_fmt = v4l2_subdev_get_fmt,
>  	.set_fmt = imx415_set_format,
>  	.get_selection = imx415_get_selection,
>  	.init_cfg = imx415_init_cfg,
