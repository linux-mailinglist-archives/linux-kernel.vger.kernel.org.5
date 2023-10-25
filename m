Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BF27D670D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJYJii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjJYJid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:38:33 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CC8A6;
        Wed, 25 Oct 2023 02:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKu6pKlXLwzLHirUTniUFZ6b3/80+RibH3yXVZHt7h+Ccc0cP/rnKoWePtyUnEaTxlXBzQbILFBo4n3NK5XY2g4nNBsZ+XmhzWLfUsFy2Jnq9EeSwjqhMdgZW/tUoGXDb/4VBOT5gUg309Gb/JNds91CxiEpTmWiE9N9RM4Vh/qyFOesq2f2KxMS7RSJm3UI1a9VyFEvcoXhzm+TCnr1N6VVx8q6ktevv8rMIKLx5YtgRyhnKr23rIvY+OcuHdJhjM6gZ8fwvtplXgDn9y6UdnqeirASC/fH/+9vy/9dA1XhW2zlcHSOaLckHFgSaP6+nyAbqixgHmFX5zkPJ8I7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmMtWpsXZGVhkZ1Icss0nqZjYD9VYYx1WEav7k7iTpE=;
 b=Zc5brme+7nfH/K5d1IASp2VQIePFnL+sEn6IMh9oTAM1hEWfnGTtBuwCgUdISEv1tsQJE8MNu6CddM3gwf/Lr2n1OpMhuq9NIyuAl6kSPM3Hph6YWdqO4YSsJnW1yBjysthzxqGgBXbN9JPMkYV6NWiDh2dtyjojI/7BSl+1hH7VgKGhl0qgrH3bIqFJlnM7dSRqvmEcgYk6cZsbtRO2f6iESyChA5GFym3c8wKLSDzUS8HwrC2cOj+xEn1ezur0x5/BjXdcC/N9UbvMLmpFFNemwmdOUi+lt9Uidg1HmRz3shx9p1Q2QM3ktiTCik0b5eirLVBdU64foYRvXcz3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmMtWpsXZGVhkZ1Icss0nqZjYD9VYYx1WEav7k7iTpE=;
 b=iGe2nmXJTxte5sdEnu2fj7vtLx39uDLBIlxAHCzkR/mnr5aW5mrUw1yOuv0tJQGCNZFXbDgPb1liQZ0P3zkyLMe1ab5zlFa+3yWDqU8EMC415zIz99WHDVuQ1Xuzpki7Kn1LZGWFF70DZ+9vyi0UOtpFMlVG++L37fpgflEwbHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by PAWPR08MB8790.eurprd08.prod.outlook.com (2603:10a6:102:333::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 09:38:27 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::87b4:3635:b89d:c07c%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 09:38:27 +0000
Message-ID: <a57db26a-704f-4859-a528-26d87c555576@wolfvision.net>
Date:   Wed, 25 Oct 2023 11:38:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] media: rockchip: Add a driver for Rockhip's camera
 interface
Content-Language: en-US
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <3790470ff7606fc075ec742d43254e52dde5d120.1697446303.git.mehdi.djait@bootlin.com>
 <ee4034b9-85f6-42cc-abca-d61004aa0a6c@wolfvision.net>
 <ZTjWsf69QdXoJNKj@aptenodytes>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZTjWsf69QdXoJNKj@aptenodytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0151.eurprd07.prod.outlook.com
 (2603:10a6:802:16::38) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|PAWPR08MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: de555c5c-05b0-4e59-e6e5-08dbd53e23fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLvTbQoxvlowS6dYWCi2WSrGnBosNQnelFc7n0RlTZ6GTfyi1q78yQs955dcLktJ0GslTnG0aYtlu0ATx6lNQCrmcTYxYc0t87Fl11PUAJe9K4Z76HD3XEHt/+T1Nd41hw1ixdUCqSXxYD/MlymOlDNLZlZKA2zjcu+RjzlE+Zpz+2FUu/IUVJ2KkZ2kZp5Zeyb99DeSOIR9JcASAKZrQ1pJSgrBOcW3d85oCJFJvEN2sizLtFsdGgEL5IDLDtqPZTqOgUKCw7kgQZE3DpDOzOcdfO8Ojn1LvgA0u/MaG54s+J/rtp+R4DnnidIpeE+07mbOKyqCgMYv7oCCxTbDK+k/ZAgXzjN1Yn3NNfj1u/Hc4vB9dZirk1Cp182O5mLGO0xmOCSYmlk/DQeZ+YukBJzfGLjsD+LI+lTx/zx/Ev4qFmXGX9e9mQsBaMXOjhU4PAnfVyeazqklugtqWIg/oNSiWa6X5NZXEDKYPrSFo5NO88Jxd446qkjM41y4YTjjR2liZSWKg9L7pwnNB5e0ifllX4exdiQrM5lR9S6Kj0AGWTEs9gdXWuFbrZaF7FGjlKCunz2iq+F6wtCMD42DFZspQByn1crNCMmmhZtwb259GB4jF+jVlzwV3AGIQatI/rNJ+GZSW5gT8+8SRJgIHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39850400004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(38100700002)(36756003)(2616005)(66476007)(66556008)(6916009)(66946007)(36916002)(6506007)(478600001)(6486002)(53546011)(6512007)(83380400001)(4326008)(86362001)(44832011)(41300700001)(5660300002)(7416002)(31696002)(8676002)(316002)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnNSTkxJWU5VaWYzWXJrb3hUZ0VNdzhidmNjVmRWZGZobW4wRFduK1FVRVZs?=
 =?utf-8?B?L1JWaThXUnJOTjRNVzkvcE9tYkVxS3lrOTNNZjBIOG8rcWt5bUVGNTBtZnlu?=
 =?utf-8?B?MUhzaDRLQ2tZcENaN2RLdE41Z3hvQ21YMGQ3QmlXYzlXdytuTGVhb0RBNGZC?=
 =?utf-8?B?bVoxUSsrSnBrV1I4Z25XSHdwNGhxSkwzcURRL2FtYzU5Q25jOGdGVWZDc1Ja?=
 =?utf-8?B?ams4YTBQUnREdnJ6YU42YUkwLzRJa0Y5b2hWYWRRcEM1RDlWYk5LMGdmd004?=
 =?utf-8?B?Y0RwaHQ5OTh5ZGFwODc5MG9DMzFhVHdzR1c5cnpvUVJqNnNLNkV0Tm80bzlB?=
 =?utf-8?B?QkVZell3bjRNS3VSQmEwS0tqRUZmcVhmNHhLZ1NlbThLUkRKWm01M1ZnTHVj?=
 =?utf-8?B?dUp0RzFxR3lmTXlQZDFqQnVpdzMzbXAwUHpvcjFZZlJOVFg5akNMMjVtZUpa?=
 =?utf-8?B?L09WajVzQ2JlY2dlMWN6SERheUFuSEZjanB1VXF4d1ZrSlEvelp2d280UFdO?=
 =?utf-8?B?SmpLdi9IbHpTa2xpeWptS2s3cGJwam0rMGlKMHBZYlZzWkxicmNVUjc2QlAw?=
 =?utf-8?B?OGNiS1BFNEdySkNxd2ZpTGpjZmVMMjNxVHJWUUI3KzB2ZUJtL2pieGt3UStp?=
 =?utf-8?B?MXJaMHk4V1ZiS050Tk9sWXFlRlhOM3orSWliR3cyR2l4QXRiYWV5MWJrNW1u?=
 =?utf-8?B?eTB5c2tCYU5URjJKeEFlV1BBcFhMdFA4Q1BPeXY1T2lPN09PVzBLRWhqUkpm?=
 =?utf-8?B?Z2ZubmVld2x2SVpOeWxUaWFRMTdRUzNnb2ozUkNSbHBrVmtJOGF4SU9sZFlC?=
 =?utf-8?B?ZlNkOEV0dG9RQXdzVTN0OXo3c0VTdXl1Z2xub29jVjZJeGdrSVluREQ3VWMw?=
 =?utf-8?B?ODFlMm0xR3FaN0pzOXZHUjRoRlJxT2dVL21iMUlscng3UGRadWQ4YUV1aERH?=
 =?utf-8?B?MEMwQk44alR4TUdHVnpBbXZkT0JZQjJVbXdQVm5qbWxQWlNNYUFLRThhb0lt?=
 =?utf-8?B?OEVkNUtLRFhhdXUvRExEc25vY09MQnlxS2dud3Q5WmhpS09PVXRkV2VWWkho?=
 =?utf-8?B?SUZhaEFiR09kK2JWS3BZZzFvMnFrdEl2RE1KdHdYa092bk4rVmczOFRVaThy?=
 =?utf-8?B?NFRtTHp5RXl2eFFNRk03b0RkWnRvUFRxc1VJWWtoOGUrUmF4RnIrSlhZQTda?=
 =?utf-8?B?Zzk2Ymg5OHZDWm5acU44UG83YjR4c3pzN3dMNzhaRUd2by9JNDhCRzRwN2or?=
 =?utf-8?B?U0ZrbUlxWkhadmt2ck9rdWlsL0kwaUpmUFVYdjVtTnZ5di9RRDc3a1QvUTVk?=
 =?utf-8?B?cUJrMFkvQlNrU1F5N0M4aHN5bmhnMW1RMU9QOEFPZ0M2ZjlpTWZwcnluY1Ru?=
 =?utf-8?B?V0lRZHZrVlJBT0ExMlhuK1NteWkyRVMwZzBiZzFvSXpocXBSOTFDckU5VnIr?=
 =?utf-8?B?cCtwRE55UFZHYld6VDMwUHV3amJuMUMzL09NbTRUaGo4bEtBVVlsMi9GdVFw?=
 =?utf-8?B?UkloeFZwSlRTMXVhZTNNQ2FxNjI2UjhEREMyM0dlSmZ6ckFVaS84Y3huVVI1?=
 =?utf-8?B?Tjdoa3JwRHUzM09WQXlndFZybVhDMDAvR3BLVWk3SkRqVFh6bzRqM2ZJNCtV?=
 =?utf-8?B?bjlTd3BIZ3RUQWtNa01CMXlEMGx3WnBNUVcycStZanRZZTVTSjRod3hTc2cz?=
 =?utf-8?B?MEcxMFUvTTNoejdVdTI2Z0xZc2h0NjR6bW9rSngvY3RTWnc0cTI3WHRaMXY5?=
 =?utf-8?B?SVM2OEU2elcrWUgrd29MUWI5QVRZeTRNc0JramYyM0R5NFFsYlZGMmdSMW9o?=
 =?utf-8?B?bEIwa3N2L2RhSGNpcjBWR2ZQbEhCeVhmdkhTR1dVZDQ0aUNqOHg0VEc0RFpz?=
 =?utf-8?B?SW5Yc0hibmxTT3pTTU1HRVVBcUFVZkE2Tjd4TkxuZ3JmZjBqNWxhWG51OENu?=
 =?utf-8?B?OUJWb2tUNktPNWxHMGt0alJWM0JNS0NTODNnMUlMUUtpbnlodjlVN29vY1l2?=
 =?utf-8?B?dDBnK3IxT0Q2NldpZGIwS2Z5ZGt0SEk3c21aMEtlTlQxTmY3b3NaZTRaaXNt?=
 =?utf-8?B?VkwzT0JDWkM5Z1dJeEprMjE3OUoza3dGRkJWd3FlMzYxZnRWZlZpT0NJMEpy?=
 =?utf-8?B?WUl0bTBHK05YQmFTVXpKQWsxRHlrWXlGN29ibmhTZ0g1ejNIdUxZMG1aKzhm?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: de555c5c-05b0-4e59-e6e5-08dbd53e23fb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:38:27.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQpZHE4vLyLJoYJ8omJffucdExGARvFV5euet2YaQs6uBPqK33u1Y8ZwTeROU6p/FhNhMJ0FTNrKHeIWvOghKXDv8hSRIRnjqgv+JHhDl38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 10/25/23 10:49, Paul Kocialkowski wrote:
> Hi,
> 
> On Mon 23 Oct 23, 15:28, Michael Riesch wrote:
>> Typo in the subject: "Rockhip's" -> "Rockchip's"
>> I think this typo has been in there for a while now ;-)
> 
> Great hips make for great dancing!

...to rock music, obviously.

> [...]
>>> +#define write_vip_reg(base, addr, val)  writel(val, (addr) + (base))
>>> +#define read_vip_reg(base, addr) readl((addr) + (base))
>>
>> Please provide those helpers as proper inline functions. As to the
>> naming, the "_reg" suffix seems unnecessary.
>>
>> Alternatively, you could consider converting the driver to use regmap.
> 
> Come to think of it, I feel like it would make more sense to have an inline
> function which is given a struct rk_vip_device instead of having to dereference
> it every time in the caller to access the base address.

Indeed. Either using regmap, e.g.,

int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);

or something equivalant

static inline int cif_write(struct cif_device *device, unsigned int reg,
unsigned int val);

Not sure what you agreed on in terms of a method prefix. The Rockchip
RGA driver uses "rga_something", the Rockchip ISP driver uses
"rkisp1_something". This would mean either "cif_something" or
"rkcif_something", right?

> [...]
>>> +	struct rk_vip_sensor_info	sensor;
>>
>> Using "sensor" as name does not seem correct. As pointed out above it
>> could be a video decoder just as well. Something with "subdevice" maybe?
> 
> Agreed. I suggest renaming the struct "rk_vip_sensor_info" -> "rk_cif_remote"
> and just calling the member "remote".

"remote" sounds reasonable. Prefix to be bikeshedded, see comment above.

In the future, we may add an array with mipi_remotes that represents the
subdevices attached wia MIPI CSI-2.

Best regards,
Michael

> Cheers,
> 
> Paul
> 
