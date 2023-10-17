Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC25B7CC56B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbjJQOAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjJQOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:00:31 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2104.outbound.protection.outlook.com [40.107.8.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD18EA;
        Tue, 17 Oct 2023 07:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oub+7NI5vqcbQ5OPbCJuSdrempazfbSCygSRueM/LezeCloEFshipWRuT6Q/rMcbcCvM5R/0gZJ3ZxUOoOY+HwSjSUNdLyAafujMF5z+MUznxXHPaAuMw9nzdniBnV2zQlcRqNdcisQYJpr2h0FZaxN7PEfLV8dzDHMUtBheZk1cZZeHYWxtNwueaTly9W+F0lNIdeCITJXBnHMBvL+2LyP32I/GcYd/c24+ibeBUjjCaot5vZUIpmkqBWcDCNY0/5C2xKDcAguaKjrMhIsYZi4OkyoXRgMfj/rWb809Ai+KsaaVoJuPbP5xpEfrpOHMzqmjZS/Fza95HBdxjJyEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjB8uISRMWk4FfqcBl3HypRqBm4OzBBTo9YBxvOW0Ec=;
 b=fIUGUD8G9NHfwF7244tFD1Jfd6vksLRBZfe6na98WNmxb3N2+yA1j6NhM/gjSjX4JR4ZYTgrD5C4FaDqPvRNkmogVVp1ErPYx155cQe3TpnQU2CfMzppYYnquO4XkMQqUKNrJ4A42apjoxsFGndro+z//PvSW0MKttJxO+9UXzP9y95ZFkDZvc+pSAoelrbK4ahAEYCEF3eiADATnGY6ohIM9x7rXBoIy8ENoWz209yI5D9VjJgLvPHm64JneTq085b9GCHe0U99CwqzmH8n9NkwWW9viTNA7r1vOWacjXqdoJIpNZ6b2fDLIKof3io3pdCv0JJKltpOQCziCKsp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjB8uISRMWk4FfqcBl3HypRqBm4OzBBTo9YBxvOW0Ec=;
 b=BarKxROIbQycLFxFK/9wNQ7705x5KMRs72S+p2QoQK6ownVjK/NMLaFyHb8L1RfzEs+4L4lBbcE3bsShYZcsg4NzpXluLRJeKp/uRXHzeGoMlpxGTE+Rv+RlsU/Dh6i0ZMQLsl1snxH2bViBwjOTnq/F72uzKmD/XSRv3TFk2XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PR3PR02MB6299.eurprd02.prod.outlook.com (2603:10a6:102:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 14:00:25 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d%7]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 14:00:24 +0000
Message-ID: <2a15c359-2a04-9a45-f30a-c7a0e4b67871@axentia.se>
Date:   Tue, 17 Oct 2023 16:00:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: afe: rescale: Accept only offset channels
Content-Language: sv-SE
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
 <a0a55276-297b-e2b7-79b3-e4aadd39b400@axentia.se>
 <CACRpkdaMj2XFcwqaSiRSA2A41zYsW=AG_Fi7v7AjbuLBByxVaQ@mail.gmail.com>
 <948548a0-d132-4f5c-819e-40bacb367be4@axentia.se>
 <20231017100539.000039b0@Huawei.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20231017100539.000039b0@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0116.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3c::18) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PR3PR02MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: b63acd8e-e4a1-4d74-5432-08dbcf1968fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kz+7BBLuyGludtOZbPjMCc7djLGZCpLcPOuPS6J+7K8j3y4X9iZ+PLMyMXqPJKAyHSa/c9DfGGuK6m7IxSb6kdJ330DuIKf6WUQzuRQYE3xgTn3Gzm4+yMdtXqywd3+1tHrhCdp24MHHhcKjKFBZDpUJWN/psl5M9D4iXdWtbTWcHAE+NWvHOpSDUi8WdEu3/iPccnFrZtt4j8TX7uwq67PMjl4hWoZfzBFyfoQMMmz0FZxz8dr/Pbz73d/YBqKautrTPSB+DCE0mhyzrZU5ifDXrJuIw5oOSLsoofTnDl4hKdYZR5DkBLSOj8wSABRQDb/Sebo6wStW75mzGLkVPxTWrPDv/Dvhrf2FtpOMhyUOYmUCjrg9ZS6/ocOJpp5dRihYd58y6sOPpmMm5o43bRyLfkBLN2z275oI28BMWSFLfLd+CD7WehWJq7IcqBsMKfbYYlB+zeHRaqMQzsnjvYaiqNDz2/2WdU07amOQUQ7f81Qg7caHOakI014QMLco3lb8doVJhtBz17LQraACPrcsn4XfnWFlEkIjvOMyXGL7dsJsaohqq7YFi65/xk2lqkaSJEQGyNPeSqxpLVssBVXKhrG3FA02wg2vzzffEtRBp1VDNrQH8alfvzWXQ4hdPjG2Nt993xa0Wbn4rqaiow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39840400004)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(316002)(6486002)(66556008)(66946007)(54906003)(66476007)(6916009)(2616005)(26005)(38100700002)(31696002)(86362001)(36756003)(478600001)(6512007)(6506007)(31686004)(2906002)(4001150100001)(41300700001)(5660300002)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzNjdW9kaVBPY2tQVmdkWnNCL3ZtdHNNSFlzOWpvUWo2alRYZlIra2dpcC9K?=
 =?utf-8?B?cmM1bkRHdWRSeHpzSExRQkJHcE5QbjlhTlJEMUExYWdPb0JEWDlacXJaaTlY?=
 =?utf-8?B?OWxmZTVDUWJSclM0bnd4SU8zMG1lWDlWTldWaUkzKzRMRWJ1cmNra3pDbEFh?=
 =?utf-8?B?cTVyZWFQVVp1OVNFWXVpK1N3NCt2aHhDTzhNQjd1ZFdsODdqU1BEeUhrZWR1?=
 =?utf-8?B?WkMwY2RMS2R1TlVha2VML28yQnRzNjdQNS9iNVJPRFpFdVVpdzZNUnhXME5o?=
 =?utf-8?B?clM0RE5NNGJSdi9pRUJDU0FSRWRwZUtTWlNNSmNnWUNzSDdCU2ZFYWM1U1Fq?=
 =?utf-8?B?UGNRM3hUeVJRSUJ2QitnWS9HQXJHaEJiYjVaUmY5SDRTK2tTMTlzMDZzTkFw?=
 =?utf-8?B?dzBhVThDR3YxYUhGaU94UEdseXBFNDNYMGYrY0JOUHVTbEx4KzR3WGZrMEN5?=
 =?utf-8?B?aTRDNVN5ZUJIOTA2SU40bVY0WTJLYng1OHJXenBCRG90UHRBcEk3ZDcxYXhn?=
 =?utf-8?B?NVNkTGNNek9LcEdiNklHNjRLUWVRZEEyR0t0WmNLOGwydWprR040S3lxaFZt?=
 =?utf-8?B?djFManZYWWROQWZ6ejlYb2FkQTNOY0RlNnVLR2U5aUx0aFpwNThmRFluWjFt?=
 =?utf-8?B?Zk81VWkwblgrOUtwVUJCc05oNEkrWGtURCtWaGVkTXo2RmtsMzNqekU2S2pL?=
 =?utf-8?B?cmNVZTM2ejMvWkpaT29vZDVzZVNYZVpwZ2Y2RWZMYU03NVlrMUxyVmJ5LzYz?=
 =?utf-8?B?NDB3SW5ES3VvS1IrOThaMVcySGdtempEL0Roc29BblJneEZ6TFVXZnZTTUw5?=
 =?utf-8?B?alNhYjIrQUUxdVRsTE9MQWp3VWxKZUlXa1oxNnpYRW5YMW1wdE9JcjlFMmd1?=
 =?utf-8?B?cytiMmdscVVyNUthUzFETFdFN0VmSmVUaHFrQkZod2x2S2FFbWZsSzdwZktG?=
 =?utf-8?B?Umt4WUpHMWpPLzJaQnJuYkk1eDZFTzhHZnE1S1dPUkhYVVJNTndQVzErZVB5?=
 =?utf-8?B?MVA0emRicmhTdUNtVU0rdkltQ3lRVnhIMHpjV3FUemFtV1hublFlVStBZ0Q2?=
 =?utf-8?B?ZjZsdURXNXlqM3RBR1ZwSlh5VHFpdWFwUVRnbHlnWmhtblJUZVZidEpUMlhN?=
 =?utf-8?B?ZUlySDkrblhKRzZPOVBLS3R0ZS9Obld3ci9weFJ6TDhOZzdtY2hnL2w3MVRX?=
 =?utf-8?B?OXgzZEdLSlpBUU4rM1VwNHMwTGh1c0FMQm9vYnJqOFYveVMwMDZsZTFuS01i?=
 =?utf-8?B?M0prdXBxbUpZWjhacVhwbGpSUEFWc1VKMExtMlJCeGF3QmF0RnNLMVJvTFJX?=
 =?utf-8?B?VXdmcUIybnpRR3JUZkNBYWlsYzhhQ2hIWTBWdC9lOWNHSENIaEs0eXhONlZF?=
 =?utf-8?B?bGtSQmV2VlVpNXJlNW01SEtYVzJtdVdaMk5mMTdRakgweEk1VjM2V0NYbnov?=
 =?utf-8?B?ejFjZElTRVZZbDFCbmp0eW9kdnVPU0hkbmNhRWFhQjVhUW9MMGhWK3lnR0xQ?=
 =?utf-8?B?eUJ5MCtCNzc3WkU2SzdaS29lRFhUOElJeSsvdnVMRWhyV1pqa2kvMmdVMm9F?=
 =?utf-8?B?ME9ETVhma1lhR1hMZ3Q5Z0ZzRWVFMXZab29tMDFMc2cvMlpjMDNLaTNIRTJj?=
 =?utf-8?B?eU5uWHcrZzBzdDhNdTdPNDFCTmhKNUZkVm9JQ0cra0JqRlovR1JXUEFWcUpx?=
 =?utf-8?B?TTZJbk03UGZaSFFlbU13cEFSdVRJOFRXZWtGWGgvVGlVb1A0Zkw5YTIvc2JH?=
 =?utf-8?B?MzBReUh6SVJ2WFN2d1VaRTB6TXZMVjV5cUVGOTlIME0wbFVLbDlyRVFJUmRQ?=
 =?utf-8?B?bGZWR1plZ0Y3bDFlU0l0dC84Y1lhZmgyb2Fzem1aajl4ZFFaRTBENkd3MlZK?=
 =?utf-8?B?Ly9QeHV1a3lSR2pUWHJ5YllsaWkreisyb2RxQWduUHI5UU13UnlUbllvQUlm?=
 =?utf-8?B?SGRjcjMweGlUSUxQYms3emJMbGJqTSs4aFB3R1lWR1owWElKeklGUkhONnRX?=
 =?utf-8?B?MWJrSFZ1L3NoZFZ5cmE5c2NkUHBUalVXZERhcjN5c2RUaHkyMyttWUUzVlJN?=
 =?utf-8?B?WnAzRzQrMWszREl5WUFndGhNNU5rNityU3NuZTZISXF0ZE9ld1luc1VQdGg2?=
 =?utf-8?Q?jqEAUBRBKYo+5U0PMZzzJ22dt?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b63acd8e-e4a1-4d74-5432-08dbcf1968fd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 14:00:24.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9k0DrbFx2n5LiZy4zm49PyrwFaBLKER0Jr5+HweH5GsK9t72bRxfn0Qp/RipvTw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6299
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

2023-10-17 at 11:05, Jonathan Cameron wrote:
> On Mon, 16 Oct 2023 12:05:32 +0200
> Peter Rosin <peda@axentia.se> wrote:
>> 2023-10-16 at 10:39, Linus Walleij wrote:



>>> Just raw (with neither offset or rescale) doesn't make sense, since  
>>
>> And I don't see why not. That's the crux.
>>
>>> the AFE rescaler does just offsetting and rescaling, in that case the
>>> user should just use the raw channel. Also it would then take
>>> precedence over a processed channel (which applies rescale and
>>> offset internally) which doesn't make sense to me.  
>>
>> Why isn't it perfectly fine for a device to provide only a raw
>> channel and then expect that to be interpreted as the real unit?
>> Why would it need a processed channel when no processing is
>> going on? E.g. a device reporting the temp in the expected unit
>> in one of its registers. Or whatever with such a friendly
>> register.
> 
> In that case it should report a processed value to indicate that.
> It's admittedly a bit of a corner case given it's not processed by
> the kernel - there is an argument that this (more or less) only
> happens when someone has processed a raw ADC count but in theory
> that's not necessarily true.
> 
> There are a few examples of drivers passing through the register value
> as processed in tree - normally when there
> is a microprocessor doing some fusion of signals or similar.
> 
> Raw gets reported on it's own in a few other cases, such as when
> there are no known units - that happens for things like light intensity,
> proximity (which is often reflected light intensity).
> For those I'm not sure the rescaler is useful.

Excellent, thanks for the clarification!

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
