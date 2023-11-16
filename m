Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C637EDC1D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjKPHnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKPHnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:43:10 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E477192;
        Wed, 15 Nov 2023 23:43:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNfNi/WDQMDiZF/6Wbe7HF9gnab/oHPQSyyL3OyWd319T7GA+hjuMzW4cMt1dZLRTQNsHoj6EYflqVdo8nqYofgIc9DlOF3ZvAEgCEKeI5/cTecuCwvhEaq1dEWbpdBk+5FRonk2L0CTYxEe8nSgRweM0OPpDy5RVBXuJaCTu2F/51MhqtdMr/t5FufLr/Bcv5NH5exqiNaPfLGAdL2pA1tk+msWxKcHmG8udKsGKVSpMbyKp3Xk3SOqDqUaeQhxD5w7B0iuMxiVxJpYvQ8Ty/+YOvJ3QPbvWFc5qxtYhtK1ZhdJUtLf7UwNwC5UORmFqflKApp3gTMb8kWy852Eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qt7AVUVc7FMteAtR10OgYwtzCsSJtGI3snrpCj3dycY=;
 b=OLNwztrVE7TBsqOJ/r/yCc76bIbmeZORprlGQ47Q+MIw2ViWAfm6MGmCXEpl1MlbxfQA/W7fSgExTmCagXlvmgsnzGRmY2gbR+zKe4fV+YU4TXty9Rd9r/lnatGAYZeUFPYqiBpt0p805VE44sP+CQ6gICYTLa3mcnmntduNdLd8z107eK4m7vvK30z4rI4kY3yXHiervptcJen9xQwkgU+v4MOTprgVcMLvW/9WVLiCkqVmC/fM2mQxBM1Etihpi7/1OSB/8o/EJ0TG7nLZ1pLC2qQ1z5w6mAdALEFnuD8p1t6d1oIBNCVoVxFNX2+l23dzrvB3racFlZNSpKo7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt7AVUVc7FMteAtR10OgYwtzCsSJtGI3snrpCj3dycY=;
 b=N0C1CZ+3GjoxYOyX0Ke392lE5fCZCujU6i9MCI/OHlnRK0aevvCVci6g9nns8e6XvKF7O69ZLNggwTq8L6N6KPCNXv5DeXzxRtRjNplKz3sFWBSt6QgY9VS+dIMQY4fdhsow4RSgCMCGG7ZmJVbtjUYlFq2TrisBgHLUOlZjt7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from PAXPR02MB7263.eurprd02.prod.outlook.com (2603:10a6:102:1c5::18)
 by AS8PR02MB9412.eurprd02.prod.outlook.com (2603:10a6:20b:5a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 07:43:03 +0000
Received: from PAXPR02MB7263.eurprd02.prod.outlook.com
 ([fe80::dfa8:c276:ca2e:b053]) by PAXPR02MB7263.eurprd02.prod.outlook.com
 ([fe80::dfa8:c276:ca2e:b053%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 07:43:03 +0000
Message-ID: <f2df3ba6-76d2-4e2e-9c7e-54f6a84464b7@axis.com>
Date:   Thu, 16 Nov 2023 08:43:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] Input: cap11xx - remove unnecessary IRQ parsing
To:     Rob Herring <robh+dt@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
References: <20231108155647.1812835-1-jiriv@axis.com>
 <20231108155647.1812835-4-jiriv@axis.com>
 <CAL_JsqL3veRuuDqWnZ+eUTP5Mvz5WffYktrBh6HqyARRThzmYQ@mail.gmail.com>
Content-Language: en-US
From:   Jiri Valek - 2N <jiriv@axis.com>
In-Reply-To: <CAL_JsqL3veRuuDqWnZ+eUTP5Mvz5WffYktrBh6HqyARRThzmYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::17) To PAXPR02MB7263.eurprd02.prod.outlook.com
 (2603:10a6:102:1c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7263:EE_|AS8PR02MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 631b0f76-ce83-4609-3da7-08dbe677aa10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eM6hx8m/fz2LgX9GrK9ezo6nyhtJbnWCglIz90kf/CF6U2j7I0mY/RqJIXOPyT43FcfPLxLLFRDieLjUPWOqDDu9m+0YGc5jgAsro9pPPvOkZzF3ByjZ0j/j8PeIIAKzfVidWPPoShnuvYRn/OCyoq6zGfEDz+HYOBrnPP+fnHfH+UBcMEXYc2SfpirdJTpeCeRipFhKY3IYdMtxHj4fWdSpiBPnNlGfYdHzdcj4Ktum5d8iwWFQ9YMHUhDaBf/C2m9Kanxz6DUCPoPjD1bKh8gKLB88aQtW7d57SQnW1kNbqljk641v+X3eRpZHf6L5w6R3VWuOAoY6+NmF3YzilQfKerEbkRsqLP8VFVj+FT6x7y6srwrcaYNqO9+LEFpnf5R6awfqWNPMAMqdcbfW/4uNCXQPpvn4SqZkKI8wcdO/HT269vbl+Pk2yZcnbDs7AOkRVFpTDK3AXEJB/za3oxo3aTnR7mZE+COVdyN4OiKef51bAFizCe2bAE9FERDCSexcDVR6POAt99VbWi+KlbVkUwsz3oTJ+ab5XzfvKpgC0XKA6clZaM4N4XhUbMgL7p0oHnWzonjomSRimbAucZ0nSpj0x6anI+VubVeUFhgeWrHlxLwMq2/8AS7YCWqixzsTxFw9BUzmus0eD7vTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7263.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(41300700001)(316002)(66556008)(66476007)(8936002)(36756003)(8676002)(66946007)(4326008)(38100700002)(478600001)(5660300002)(31696002)(31686004)(83170400001)(6486002)(83380400001)(42882007)(26005)(6512007)(2616005)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHhiTVRCT1FFbkVUTk9EeS9YSDJPTUxLbm93TG0xT3dHYjlIaU9LSnNwNzFa?=
 =?utf-8?B?ekpTZXZCNlFoS0hNSGdaWHM4d2cwbWhhMTlWMkE3M0dIdkszNERGRk9jMUN3?=
 =?utf-8?B?cllaWUZsWW0rV0tKRXo5T3c3L2U0ZGJ0SFVGdVNNSTV1NkU3RUxEcTZJNDlL?=
 =?utf-8?B?Y1o5VkFOYThQdmJMZWlaR09nL0k1TnhwdXVaWC9rSHZGUTVUdDd5eVgrQkVS?=
 =?utf-8?B?bm1PTi9CSnZkZFlJWUw0NDlCUlU1ckVQZFh3ZTN0bm9SZnFWWGFzRXJIV0Fo?=
 =?utf-8?B?UnR6M2hGNSszYThCTFZFdy9rZ01pdTcxV1p3WDc5aTlwcndDcWEyUTZyWnp4?=
 =?utf-8?B?Rm56alVXSXd1TkUxbjNOcllldkZNKzVRK3dsR2p2bWd0VGNnVGhrYm15VW5T?=
 =?utf-8?B?UzdwNG05UUZRYmtBRUx3bXd3ZWt3MFh4VHJVVWV2UlRxc05kQmdRR2dHaGVj?=
 =?utf-8?B?ai85OGNpQXUyTTArTU1jZkdxTXM5SEM1c1lCUnlYOEVzMXJJWGlhNWlPWGpk?=
 =?utf-8?B?QUNEeVVaOXpEUzBoN2IxL09LQkR4YmdFd0Q1R3VQcEM3Z3YwbTRzUDV5N0FM?=
 =?utf-8?B?QzFldVQ4eGY5QllSdjczcTRPcW5vY2RUTXFleFo0UDRjR2dYbVhqaHdqcm15?=
 =?utf-8?B?M3hua04rakxzVFdiT01IR2RzdnhSeWFIWk5zYVNXVnpLbC8zK29GYzBUQ2FR?=
 =?utf-8?B?anpLV2VnaFVyNDJTa0tiTHlrbUx2NHhVd0wwWVIrdWc3ckJsbHNYWno4Vytj?=
 =?utf-8?B?N0s4UE40eEJ0bmtEWUUzVDFUZ1JGTzhoOVNPdTY0TmZlQmJRcmpCZCtPUkJV?=
 =?utf-8?B?UzR3YmpXNlR4S05kS3ZBbjJYOVZhSGxVakpmcjlxZUZweGdOSnM2V2hNb0Uy?=
 =?utf-8?B?VkZ6MmZqL3E0KzBiU0ZXUkFBSldUV3JCRHhBZ0lTcmtGRjJQUDNFa1BCT0xP?=
 =?utf-8?B?U0xjcXpoN2toRkxmQ1I2WWtrKzhCaXNKRzlYMEpOWVh6SXFlbk1vSUp2dWt3?=
 =?utf-8?B?U09ZYnY1ejN1YWhnVFpyZ1NtVm9IODdKTXMwM2tFUFRyQ2FuenQrcERhREVW?=
 =?utf-8?B?aFZZalRsY3kxWHlVanJyZ0VkZnJaQmJ4VG85NWZweVFrNnhIRkpnazhqcVpz?=
 =?utf-8?B?eksvemtzd3luNXduTVNCVVRKeVJ1Y0NrQ0FNbjFsb3h4NDJWMlZhSkdiVURG?=
 =?utf-8?B?UnB2QmU4R3J3clhwZ1B5dTd2dTUwa05uc0VwQTVKQmtnR3ptOGFjOE02QU85?=
 =?utf-8?B?RlAxakRsRExQalVMS2Evc0V5ekxUSEZIc3NSTnNDWVJpSm1pR2FCQ2xpRk0x?=
 =?utf-8?B?enRIOHo3WjF5U3grbHp5bnpYMnZ2ckM1YWlmQk52RTZMVW1DN04zd2Yyd1hz?=
 =?utf-8?B?WWV0NnNLQ0dQWTRIbnNublpuOFUzMVBlYnVKWUNybGE2V0dtc0h4TFhnVEt4?=
 =?utf-8?B?aDVKRTRCZnBCOVlIMS90QmUxK2xqSnYzK2pUQVhnaTcrN1M4NEp4VTlNTTRF?=
 =?utf-8?B?dU93ZGRESGdOQk5GYlBRZS9VTTkrR3pBc0VmaW1INWUwT0hMYU14MFdqRTBl?=
 =?utf-8?B?V3BRLzN5eG96T1lHdGJacVAxYVZBZFdmNjVVNzVsRTV5c09uVHNObDM4d0ls?=
 =?utf-8?B?dFZLaXgxZURVdmFwWXgzSkJweWdBbWhxcE5ZTyt3WndobUZuR0wwbzJEdStZ?=
 =?utf-8?B?Rmp2V2hpL3Z3aFVmeGE0ZGVuSmNTRm1uRHVwVy94a0hXV1N6UnlOV0t1SDRR?=
 =?utf-8?B?cVpzRXdaZDAwVkQ3L0F5aHgzUG8waXVFcFVwS1Q5aTFmTDVZWmIzczhaandt?=
 =?utf-8?B?cjdITnBjMUpiMmNjT3QvQnlSRWJlZDRmSkF0RDVzNHNvQmo5Qk45UlVxUjVN?=
 =?utf-8?B?YS8vNWhLSHYveE5ucmw3T2l0WUU0MWl4Y3dDdkw2NkxrRnFBV0JYYmFzRFE3?=
 =?utf-8?B?WktsaWhLZHlZWVZGelBCZnJOcVk1QnVmWjNaQjlVQVhnZks0bXpYZ3JORXdk?=
 =?utf-8?B?Rmo4VU11UWZKTHpXSExaV204K1NKeWlIWGxzYlpwNU5RdFF1K25rVS9GVU5h?=
 =?utf-8?B?bjVqbjNQVWkxVUJ1OWF0WUdvYVdZdU9NWUhhakhqOUhtdkVvNzZVaCtXVkVx?=
 =?utf-8?Q?vxGmLHprGHdieyyY3aKSsDlII?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631b0f76-ce83-4609-3da7-08dbe677aa10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7263.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 07:43:03.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDbhyx2v6tveHmxKk/iomthmsuThl0TDwIvDJCz0Pa/CNJiJncvS/EPk+41xlvqQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9412
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 20:53, Rob Herring wrote:
> On Wed, Nov 8, 2023 at 9:57 AM Jiri Valek - 2N <jiriv@axis.com> wrote:
>>
>> Separate IRQ parsing is not necessary, I2C core do the job.
>>
>> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
>> ---
>>  drivers/input/keyboard/cap11xx.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
>> index 4711ea985627..ccca9936ef25 100644
>> --- a/drivers/input/keyboard/cap11xx.c
>> +++ b/drivers/input/keyboard/cap11xx.c
>> @@ -518,7 +518,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>>         struct device *dev = &i2c_client->dev;
>>         struct cap11xx_priv *priv;
>>         const struct cap11xx_hw_model *cap;
>> -       int i, error, irq;
>> +       int i, error;
>>         unsigned int val, rev;
>>
>>         if (id->driver_data >= ARRAY_SIZE(cap11xx_devices)) {
>> @@ -624,13 +624,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
>>         if (error)
>>                 return error;
>>
>> -       irq = irq_of_parse_and_map(dev->of_node, 0);
> 
> Probably can drop the include of of_irq.h as well.
Ack. Thanks for notice!
