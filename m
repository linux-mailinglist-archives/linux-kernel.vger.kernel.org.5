Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E556377C15D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjHNUP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjHNUPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:15:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2115.outbound.protection.outlook.com [40.107.21.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C7413E;
        Mon, 14 Aug 2023 13:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFVOccUkCavMhyqmeqeUNAsu/1+hUSRIBgcA6MuQR98UzLRFxzWGLylgHnF0Yte0EXKxlULq9BGSz8IyTpwsMvfvbJNtg7t482ePj4u7mVQw1qvUQTzNRbz+vFnv4bGQATMebNFMj4APVSMkH1TrWdB2KEd70VwPcUXZRI0qf2R1eOa0QlTHtiIWRX7hXmBktVl9eM5qtDA/31kwWuvCgMw1n3OfLZVTlzi/06+HFxPxb61iSzvPUoN123K20lkbzJqCUhzSX6xGuvRW3G/uBudS0xib6F5dXWu8KgX6GipGhsWsVTtL6avbYcIg011Q03sIS/z4EeFFnBpK5WYaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYpDmt5lMiGJza1HWZSllBW/WdotWIO0mRxXq3PU1Xs=;
 b=JZP5Q5VUu343Q60QMD2IBzNU6Sz5+ebwwxJU94sJUuEqbdMOF1XXhMOXtxiXQ4+gXwEyaa3anNpwuOzob0cHcfQIv0moihG+K4TCdbf/lQZ357Vn3NzihxZAzdTI4V2R5R8LmQZa7HLHPPiFCrvU1Bw8K09nnVrosJVpP69/F9ZwxIeMjmrRyhK+2T1u4QllpW2eSQE0whb49WSPAelt+PvGRQmC+ORrpoQg8RP9teLCo3MWNOCoRW1j/rak+3mNaBfyVA8oapKbbU9Jp1zJUCkJmYESr9nlkNTqgusfOCXbQci+wZyikBMmggEIyTSVQI++eZ+2/CRIzN9D7w1NzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYpDmt5lMiGJza1HWZSllBW/WdotWIO0mRxXq3PU1Xs=;
 b=EqwqtcCafta3L1CtEl4jQJUutMQvUnqN4+ay2Wp3i6/Q8qYnujMMU6LvjQw+BwJnZtg7QB9QdfzR56+XrEYneAr+SVbDXmD5Vxo1ikgcaZTTxaideM4aAYtZasCu5CxahxAuoauxJyCN8U3XNHwU0mfTqimGAIk/fW5KfS0uRxcZfK2728UvacArMKNI/cneMYKngEh5LKUJu4I7YxMBJs2ckqcDK9i9NhkXHdJ5nitBMdK+AKv6MSWyLCwFt6H45n+XVKymil9ck6FYrDq5eonBhv5+Q7iSuj4Yt8pqWawZrpJcId1JPNKWZYlZHzScGowJkQ6DGLgdtAMJ6J/NDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com (2603:10a6:10:2c2::11)
 by DB3PR0302MB9064.eurprd03.prod.outlook.com (2603:10a6:10:428::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 20:14:55 +0000
Received: from DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf]) by DB9PR03MB7689.eurprd03.prod.outlook.com
 ([fe80::8303:13bd:7736:34cf%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 20:14:55 +0000
Message-ID: <dffa41e5-cde3-5b88-9539-9c03d9e10807@uclouvain.be>
Date:   Mon, 14 Aug 2023 22:14:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH net-next 2/3] [PATCH 2/3] netem: allow using a seeded PRNG
 for generating random losses
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230814023147.1389074-1-francois.michel@uclouvain.be>
 <20230814023147.1389074-3-francois.michel@uclouvain.be>
 <20230814084907.18c339c2@hermes.local>
Content-Language: en-US
From:   =?UTF-8?Q?Fran=c3=a7ois_Michel?= <francois.michel@uclouvain.be>
In-Reply-To: <20230814084907.18c339c2@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR08CA0005.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::18) To DB9PR03MB7689.eurprd03.prod.outlook.com
 (2603:10a6:10:2c2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7689:EE_|DB3PR0302MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a1113e-c2bd-43ee-53c0-08db9d031fe3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NhQQIK687GwttQOA1KFCDAu3be0iif+AHBv5CFfXUfKtO9gRd9DcUvO+lDAQ60kj2i0K00INqTtu4LdiaYEMAfOZmCvWPLk3JQSvwL2le4cujUQXvGoe0OnyONsUWowlw7hPI0ZPzWkttXzZxPoUrzptHxVaxJEydELdEXJQWWh2Ctq7FrWdY7Vv8httqOeZ94vlODi164ejpOaT1pZoFNjy4WHu6+9FfO0r+gUwj3JAVlHtwcPWu66MG6AJ/bBMio9BJLvVROa68cuHJbnHjxbFS0Y5KJvwGpjwso06SFyZydoC9oZ4nRm6XMpEjzDTfB/XKd58IxoAxUfpsegP2wCCZKXAn0D8MNbUeI9DM71U4E2rOdXSG/qK0uT5rX3REpYY/Dn/yF9eW2o1Vmv4lXgPjSJgICI2Xob3yioOB6U5YRjrNShL4UeXk9dg3SgsBQXpiLoEexHQGu8bEHZ8bAygOO8ISWyDYO8h5CQhs3W8rPlqCCr8S6jgHGUln638Ls9mJp+MmAzipDfsd6LE3yvXBZ/s5wuLJlmrR60XORpjOlobhsFKGXlNgHRGxTi9NPaZdYQ2eMeRfuO1WC9FsEzlr/m0BAJkVkDVPDPmqPrD9KQly+OazM0X/nvCLyEN4knnTzLKLggjalkF9zdLsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7689.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(39860400002)(396003)(1800799006)(186006)(451199021)(6486002)(478600001)(6506007)(26005)(6512007)(2616005)(66946007)(2906002)(7416002)(66476007)(6916009)(8676002)(66556008)(54906003)(316002)(4326008)(5660300002)(41300700001)(8936002)(786003)(38100700002)(36756003)(31696002)(86362001)(83380400001)(66574015)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnp3c2hqTXNobHpiaytWM1dzZkR0eHEzZkJiSnVxbGloWGI5V1NKdndjZjl2?=
 =?utf-8?B?TElrVjIvbXhtOWJEQTF0UFV0WFBmVDVDM1A1T0JsUjVZQ3VUck0vdmZidmdG?=
 =?utf-8?B?TUJjd2wvcjYzQUNBNnZyaHRoMGZ0dmdaVUYyUDhRRHVoZkhyY3JLdkdzWG1B?=
 =?utf-8?B?QndaOENTNFo3MEY2cUdsMzZmVG9rejV4V1pkRkJkeDg2VXJ0TURtdGJWVG0w?=
 =?utf-8?B?ZTRaMVY1OElHVXNEZ29FMEhaQXRjV3FaUG9aTlVFOTdBRUpPemZZeTZxNnJm?=
 =?utf-8?B?b1l0MHBEVnpwdWJFZHlEa2ZqKzBRcGM4ejhtUWRNbXFVaXZjY0VKc1NYdStV?=
 =?utf-8?B?c1NQOW5oSUp1TytPZ1ZmWHdJQ295TU9TUCtLSWlTTDIvNFpia1Jwd243YVlx?=
 =?utf-8?B?Z2JVZ1lKK09tcmd4bFI5bTlXV05qU1VxZVc2eVpHY3FqdkZ1QjJWcGZ2YjN4?=
 =?utf-8?B?YXZLenhkME9sRGp0SjlTazFpZFV2czh3SFhZRUMrU1QxMithTG9kMlBXV2Fv?=
 =?utf-8?B?NE9HSS90QVdCblZZbFU2Uk1KdUhobGRZUFRrYUdhUTJmdDJNVlJabktUbUVF?=
 =?utf-8?B?Mnh0Ym9nQXJvUFp2TDNEWWFNSkFTdC8ySlBJaDZOUCtFOFJYNmN2WmhuUDhk?=
 =?utf-8?B?Z293MUUvLzBxakRhbHo4bC9NdGIzbnFiTFc2ZmZ3V0pRR01OalBTTzdxcThV?=
 =?utf-8?B?U1B1emJHQnVKQlZLaG5hL09UT3J4Q1FjREJ0OTNCYy9xcUpJWjEzMzhaNjlC?=
 =?utf-8?B?dVZBcGJhaEdNb2lVdXp2RFhLaENlUUhsMHNDNXlzNnpsV0hXOXN5Um9yWDQ4?=
 =?utf-8?B?SDJWZ1ZBbFpmaVhrV29IZURzbkFzT1hOUHREaGRTUThXNmxvUTBnek9Fa25X?=
 =?utf-8?B?OWJoSjd1b05WdVhDd2JPMy9NRFd2TFNuRGFUSTZBa2JVQytKSjVvc2lhdzF1?=
 =?utf-8?B?V1ltZklGK2JnTzFpM2grcFZjSFhCenZkaXJrYmV1bG1QanRpMHNXS3NBM05Q?=
 =?utf-8?B?ZFRQYVhPMkJFUGI0T3lZZWNOb1FDZXh0YlgxK282U2gyOWVwNkNrelhSVHBK?=
 =?utf-8?B?L3huendpTXM4UlZIcXZJcFdNUE9YOERVN1VyT2NBWi9HZXMvbFM1bjBoNEZs?=
 =?utf-8?B?b0pYaUFSLzNCQkxORzZQOGsyNTlUMCtTclNLWnhQNDZTSlVnVlVlU2dVRmk3?=
 =?utf-8?B?djVrbDRiWVhtSDZIaFhraUJtaExZdTVmM2dPaTVVekhqb0lqLzVJZjgrc0tC?=
 =?utf-8?B?aFhhMEhkUkYzOGtYOS9mc2tVQlN3RGlKTXdaeHNtWHM3WVNnL1dIMWErVjhD?=
 =?utf-8?B?aHEvcUY4aEpnSEoyM2xLZ3NDSjk1YUlJdHNJb2ZNTjJNMlR2T0ROOWVuVTZx?=
 =?utf-8?B?YXlBaTJOcFMvTUlPbm1aNEd3a3hsczlUcEFESG9jQ1NxRDl5MUZnSTludnNn?=
 =?utf-8?B?cjF0TE9rNXEwUXdJWWRWdit0YUVtVXRXek90VnV1MnNKeVJLd2FjclZ2N2xY?=
 =?utf-8?B?aFRwSDNYSmtkcnI2NUxMSkNSbVBJaHhlY2s2VHVkZnJtTFZBeG5BWEE4MkFJ?=
 =?utf-8?B?by9GVGhRMzBuMy8xRjlSVkcrY3ptaWNPaGN5a1I2NWs0b3ZJbnhyWndCaytw?=
 =?utf-8?B?UURYRjZiY3gxZStCbmlRM2tocGxhRHNaSW9nTU1IVkpBWFh2cENtN3lSamFt?=
 =?utf-8?B?bVEyNlk0aVpGNVR2SkprbTZOOTJlc0pTRTZsQTdsTXVha3daK3dPZ3JlVlVx?=
 =?utf-8?B?bkVzRnRxTjRkWlNmYUlrNWFuSFNpNkdua2RxalpMd21BRXVyZUJBNGQ5VHlJ?=
 =?utf-8?B?eEF4NlBxWFJBRWZiVmhYZHJuRzJUbC9NMWNCWkt0N011TGJZRzVFU0N4N1V2?=
 =?utf-8?B?YVM1cVFnbERWNnRPazU4Tlh3blQ2azNKb3BqZXU2Q3NrUWZoNmFHb0d6UWRh?=
 =?utf-8?B?SzRnUHJxU0Jkck1JdlRqZjVtcVZsV0xVbnNXN01TeHVGWmtyM2tCT0RVY2pR?=
 =?utf-8?B?Y05ZQ1J5am0wZ2pnWkx3RXBIUnZPSnhjU3MvNEZ5anpQMU9QVVFDV2Zjbm95?=
 =?utf-8?B?VllWcXV5ZU9GZnFEVFNGM3orSU1KL1pIZ3VqWG1HYnRCSlQwRXpPc2R2aGNn?=
 =?utf-8?B?NVUzRmJDWEFCdkkvb0NpZHArNE1BZk9Yd3NWZ0NTc1huckpmd3NKTTJ4WWd0?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a1113e-c2bd-43ee-53c0-08db9d031fe3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 20:14:55.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9nkY93PfrzuYgprAtlus4XP28hpLqpFnOnPE6gQvaBtfnH7dxiOxvCh7oFP8xyuMBa/CfZaD9b6Gco2TIuCVfjQGrnZ7BOj4NjF88aVHYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9064
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 14/08/23 à 17:49, Stephen Hemminger a écrit :
> On Mon, 14 Aug 2023 04:31:39 +0200
> Francois Michel <francois.michel@uclouvain.be> wrote:
> 
>> +/* netem_get_random_u32 - polls a new random 32-bits integer from
>> + * the prng.
>> + * Uses a deterministic seeded prng if p->deterministic_rng is true.
>> + * Uses get_random_u32() underneath if p is NULL or if p->deterministic_rng
>> + * is false.
>> + */
>> +static u32 netem_get_random_u32(struct prng *p)
> 
> Overall I am fine with this patch, but the function name is getting excessively
> long. It is a local function, so no need for netem_ prefix.
> 
> Checking for p == NULL is redundant, all callers are passing a valid pointer.
> 
> For logical consistency, put the new wrapper before init_crandom() and after netem_skb_cb().
> 
> Since this is not security related, the change could also be simplified to just
> always prandom_u32_state() and initialize the state on first use with either
> get_random or provided seed.  This would also simplify the code around storing
> original seed and boolean.

Thank you very much for your comment.

I do not use prandom_u32_state() directly in order to ensure
that the original netem behaviour is preserved when no seed is specified.

But I agree that it would be cleaner to directly use prandom_u32_state() 
instead of get_random_u32(), if we are sure that we won't have problems 
(e.g. short prng cycles) with the randomly generated seeds when no seed 
is explicitly provided. If it is okay, then
I don't see a reason to not use prandom_u32_state() directly.

I'll make an update of the patch taking these comments into account and 
simplifying the patch.

Thank you !

François

> 
> Reminds me of the quote attributed to Mark Twain:
> “I apologize for such a long letter - I didn't have time to write a short one.”
