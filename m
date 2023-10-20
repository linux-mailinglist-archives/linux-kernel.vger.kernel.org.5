Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA487D1196
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377569AbjJTO2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377496AbjJTO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:28:20 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2121.outbound.protection.outlook.com [40.107.13.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31719E;
        Fri, 20 Oct 2023 07:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR+iE7OHQGNVqJdZHt4HRujeHh5+XfJNBUPPT5jO2p9Hdzpx2MT2shdileTVKx4dewUwJf36Tsct0UiXIEekpMOfp3WwTtHkcOD0wA3Ayr+oId1wnCPJJaycyFDdio7hv8WfbMxSfYHljbInzzuEL2+tPQUKCRuA3jeeh/x0RYllMp6PKwfMZlaxzQsUsgzsz7aj078HdcjIsYWhy/cfRUrcVZcZnRDNPwAgnYd/BP7SENYOLZ9Ms+Ggx5PyPrrm/k89uj4qbdVgaI5scSDme6DybMPssXuDlQIKKJbIGIsNf5G+5NEv3yRIyVozI74vzeceg8DVm3pNkdPjYodEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL4eRdg4xMHMojCi0FCkG9sgp2hCUDmjMsQvpUeg0nc=;
 b=fmEfzUEpzHg9a7FpXWS1caXJRmvesFZ9Er//dlNl4nwcEWcqqOS4CPC7/LhplWEAgRnP29aIVu7c8WQskymiA7jTSngXJ9FGIJ9ufzrizl6gVUCYRbqTe7T637Ur27e02TGDhi9hl2mNKUuI9KKVPi0hJTO3QGX/r/cQIDy8Lp3sga/vE3nJNFsxSSYXInkYph976aVg99OT6ObObmiqmnZgzzR5iK8JwLu3xVwv/2an+aQYKlNsrgVvMNJRgyTJb05Nb2rcac4xM/cWqndsltUOO4On7lVBMZE1bIPGF+KB9P++wDF3e9pIlNeg7h2qWGb+/eepSZrtw1tAQDkwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL4eRdg4xMHMojCi0FCkG9sgp2hCUDmjMsQvpUeg0nc=;
 b=jMMXWXs1dKQxbdPfwQJ2uzAkzoqjIbySEubjVajdug3EW8gx6x24wVaOUWWtvUG2OylG7vQFm8fuRXmzkJxxHOxH0dfGRKNmVZC0zdskfrGZXF5QifU7nDgPl3sBNvYuPpM/JJPCa81+//7OXM0j0T+qh8WppLe65wJGb5CCZ1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DU2PR02MB10332.eurprd02.prod.outlook.com (2603:10a6:10:49b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 14:28:14 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 14:28:14 +0000
Message-ID: <0cb645c7-f3c5-e4bb-7686-2a83d32274bb@axentia.se>
Date:   Fri, 20 Oct 2023 16:28:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] mux: mmio: use reg property when parent device is not
 a syscon
Content-Language: sv-SE, en-US
To:     Andrew Davis <afd@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230911151030.71100-1-afd@ti.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230911151030.71100-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::10) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DU2PR02MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: f73c996d-c4a5-4814-5388-08dbd178cb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlE1k2HXz2/Z2jdOZWiiPemJkTQUe+1/hLjwxiYtXF6IvWPot8AK5Oqcdq4pORvdrNnPsK1W5o6yVkB3XMape9911rRn2zdt3yKXZ8bvJD4BCChHqH9C17kwdBT0kbLmgy2ZiIARTuWw90fkmcyBth1SqluZwDV/XmfmESjOuqWdB7GA78D58BKMPFIBvQFWYa6V0SeteYHtxJg26+FPcOHCKlvD7H6RYTlxJk2bZEBKoi3LUP7UnChqruh6yKZtxDgfBcgsACEeQiI5nMdk37Z1tlDlZIrQZj8XNAwBGuR5nX6uLMczNrVvuBRJAAOgPmCFSb6J+VJoGai0Yn5y4m9h6WOCUTweXdnf8TyiRZAqV2/S0+9D/PfUDV/23p9R8jSWXJBzBzSdtpyKe4ZiVxbEv+lPA2uvv9GRsvEbhj3GDdBWTbQE8G/xJ7C6e6+oxDi8N2xA0I6t+RXNMk0V0lKTy15BUsotIKnHhcdO+pux81i6bVZXtKdxHiTxByyqlxHy7dDlw0fudovyY/2ZgnD0Rssv2EB42dUpvf+MthiD74vljihNwWBNRYdZf/4SrB4BTy/KQ0mvBu+3aGAogv6PAuE6tvsEE3tQMMX+2Mvg9rHTBh8RLus9Q3j+Aw5QfpNVqcAQUhn4o83GDVBV2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39830400003)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(41300700001)(38100700002)(6506007)(36756003)(5660300002)(4326008)(31696002)(86362001)(26005)(6512007)(2906002)(83380400001)(2616005)(8936002)(966005)(6486002)(8676002)(478600001)(66476007)(66556008)(110136005)(316002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZNR3BtU0RCV0Q1UksyM1NaNGJHSGY4SG40QVExVmMvTnNHVjV6b3c1T2ph?=
 =?utf-8?B?YlhLUnJzNWF3ZTk1REtVaU9IU1YyNks2U0lkT21xbGR2QlRyTDZTOXZLWmVz?=
 =?utf-8?B?V2s0TmE5ellHL0tVR3cwMmFOTk1UVlc5N2t3Tzdvd1FvbG1jQVMvYlFlWTdF?=
 =?utf-8?B?bGtYTWRpZ0NJbER2Um1WYTlRQiszL0xFRi80MlRlVGhjZUZESFdEanBwdTJQ?=
 =?utf-8?B?VFZHZktPMHVnN2RLVHNQbThYWFE4dTkyU0taZ0FjU3pocWVuTTZLQ2xjV0VG?=
 =?utf-8?B?T0luMVNyK2k5SVhUd0x5TFBPOWRzZ0YzT0g1am13WXFHTDJxcFdKUmNqYlJS?=
 =?utf-8?B?WHd4b1llRnIrOG9TaTBVVmZWS3Fva2ZlYWU5d0tUUmJ1aTdnb1BDdVI2ZTlX?=
 =?utf-8?B?eitabEZWRkxnOGdvem04U0pybmFLSi9rNUtGTGRpd1hmSGRhM3FPQ1pQYU5Z?=
 =?utf-8?B?bU5ISklyT0VXU2ltUkJ3bDhXUkxnU3lyWWNHNm1lbDFpV21wTmxmckh3dlYv?=
 =?utf-8?B?d2dvOFhUR0thV2RKQzYvM3hFNXJuOXVlL0FzakYvTnRXRC9FZ25nbkdNT090?=
 =?utf-8?B?dDRCUzhBZDJVZ0xXRG9lSjgyWVpWR1U2dlQ0aWlaN0ZwenVwSG5vY0JmUk9P?=
 =?utf-8?B?Qmh1OVVhMTZ3NXFCbUpMWHUxMzcwaWk5NUtwdHRYWDdGQk81TXBNSk5MT3NR?=
 =?utf-8?B?T2JybzZVc2FYRHhyMnA4L1VHVlNFWTZSRGRHeDlsc1k3cU54eWtXbzZhM1Nn?=
 =?utf-8?B?SzFFb2pwODQrWDI1eC9MWldOdkRyWmJjTXprb3Y2WmlBdVlMOWE0REc1elN1?=
 =?utf-8?B?RXdQdUoxb201clZOSEhMZUplM1BZVG5DdzAxL2lnazRIMnNBQmhaVndvR3pG?=
 =?utf-8?B?eWdWVE1WeENSQ0oxUmhROWNsR2JKdFcyMUZDRVpMY0FVMEp2bkxVQjJmUWh6?=
 =?utf-8?B?aDFXOGVOWG9EQlVjdVdkTkZUMXJjY05idW1xcWpEeHpwWGV3eEh1RnozWGRh?=
 =?utf-8?B?TWY2U3JnZWZCYlg0VnFLV3JLMXRsaGVVYjdOaGRwZkQ1Um1FQXV4WmRvbkcy?=
 =?utf-8?B?bEJMNDc5SnZEdmRSS0VnTGVkd2gxMWRUYlBWM2tQZjh0WTZkZ2tYVmtJTXUw?=
 =?utf-8?B?a0RzV2tXSis2WldPaHlFZ1FyRTlrclRFUGFxQ2hEc1JRR3JGUUp0UDEyNFU3?=
 =?utf-8?B?SWpQWlp6eDRmc2grUjFjV1JrYU5uODdzdGtWRWd3bG1xaWFhNFV6bEV6SFYy?=
 =?utf-8?B?SlhERFQwRVl1NTZ0Y2JuTmk1OGpQdkdmMVJQck8vdlpJU1ZKQ0VNemZEazcw?=
 =?utf-8?B?UHFHbnRwdnVDVXdNY3BWeDVORDRkZ2dsUHk5TkFKdUhLdkFFL2luNENjMkhT?=
 =?utf-8?B?N01waVJtR29pcGZlK3QvZFJrMVhSRDUxMlZRc3N6bVV4Ym5mSDZRczVPUEpI?=
 =?utf-8?B?cHdlNEg2cUp2dExOQXF3QVBqb2VnOUlWQ1k4TnI2dmhMVmY5bGdrWTBmUUc0?=
 =?utf-8?B?cGdXTnRIek1YM0VYcHFMa3JQUTlXUUhLY1JEK1RrbVZlTGp6dXZRZHhJbXBT?=
 =?utf-8?B?azUrR0pLL0hacDR1LzJ4c1pSWlYvbHNYTFNuaThlWHp3eno3L3hiSFdBY051?=
 =?utf-8?B?U1hlZURXVUNNZ1RraFpUNGpOT2d4UXZ6czVVOTRsamFZcjNleEdTS0hEcmsr?=
 =?utf-8?B?YVk0NXBmbnZWelV4UzZYVjd0ZXF6dExRMEc3NlFwbVp3L3owU3JzYUVpdkds?=
 =?utf-8?B?OHVhelQwMnF3Q083VjgrWlE3a2hWQUVHSGVsSVh6T1g5bnljVkNTd0VseEU0?=
 =?utf-8?B?SzltNGFTVXlVZThKRHB5OU9jMDdEL3Q1d0lzejIrUURUV0RzWk1mMys0V2tD?=
 =?utf-8?B?VGVDV2RKS3ZIYnp4SEpuYVdHUnpXT1NGZ2hHT2sxY1VsaWNvZTlTUU5ZcDVx?=
 =?utf-8?B?TVliVGp2VjIzRU8zWFRVR0dScmhWUEdHcVVlOGJocXZ3VEt0dXVaMnRWdG5P?=
 =?utf-8?B?Vmh4ekRBUUp5dWNWMmRWcnBqeE9laUtUd1d1RDNwenZYTFZGUzNqVFhUTXRv?=
 =?utf-8?B?ZkRac0syMW9ZZDBZWmVQbUkxUFNIOFNZdGt6VjNEblNnZEo1eFc1N2RTYkFw?=
 =?utf-8?Q?qEC/BU+ruBRjSufcTa0Z6VWbA?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f73c996d-c4a5-4814-5388-08dbd178cb7b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:28:14.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPAJQBc/VP3SdFrct/ruM++8nI75mhGZDjf9fuQTzoUqFIrpTLPC2ltWv28PibDs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10332
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-09-11 at 17:10, Andrew Davis wrote:
> The DT binding for the reg-mux compatible states it can be used when the
> "parent device of mux controller is not syscon device". It also allows
> for a reg property. When the reg property is provided, use that to
> identify the address space for this mux. If not provided fallback to
> using the parent device as a regmap provider.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Changes from v2:
>  - Rebased on v6.6-rc1
> 
> Changes from v1:
>  - Flip logic as suggested in v1[0]
> 
> [0] https://lore.kernel.org/lkml/1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com/T/
> 
>  drivers/mux/mmio.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> index fd1d121a584ba..b6095b7853ed2 100644
> --- a/drivers/mux/mmio.c
> +++ b/drivers/mux/mmio.c
> @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
>  	int ret;
>  	int i;
>  
> -	if (of_device_is_compatible(np, "mmio-mux"))
> +	if (of_device_is_compatible(np, "mmio-mux")) {
>  		regmap = syscon_node_to_regmap(np->parent);
> -	else
> -		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> +	} else {
> +		regmap = device_node_to_regmap(np);

I started digging in device_node_to_regmap() to try to find an error that
could be used to trigger if the failover to dev_get_regmap() should be
tried, instead of always doing the failover on error. I got lost fairly
quickly, but it seems device_node_to_regmap() can return -EDEFER_PROBE.
While I'm not certain that it is applicable, that case should probably
not fall back to dev_get_regmap()...

Are there other error cases that should prevent the failover? I would
guess that it's perhaps just a single error that should trigger trying
the failover path? But I don't know, and which error if that's the case?

How much badness can be caused if syscon_node_to_regmap() fails for some
random obscure reason and the failover path is taken inadvertently? It
certainly smells bad for -EDEFER_PROBE, but do you have any insight in
other cases?

And after getting to approx that point a while back, I had other things
to take care of, and this fell off the table. Sorry!

Cheers,
Peter

> +		if (IS_ERR(regmap))
> +			regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> +	}
>  	if (IS_ERR(regmap)) {
>  		ret = PTR_ERR(regmap);
>  		dev_err(dev, "failed to get regmap: %d\n", ret);
