Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D6877F045
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 07:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348125AbjHQFmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 01:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbjHQFmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 01:42:35 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5322D2102;
        Wed, 16 Aug 2023 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jXySV3AbjJvMsAE/NZUcKZILS2+C54HWElsR/ThDn8=;
 b=xFOYOFqNJOPmmzmND01ypc0bHoNAYAbHl4GRnGi6CDNm7Jf9n81NL0MFQ+AbUgMEGfOkvACHOIpWIpBwN4/VKC0BsJbsPrWVMTXkpSJY44aaByf7wJf6F9VrEoYgXzRkx3bEJNmfHsHoqcFRtDCVjBpo6qVYAlWORMETKmRBCdOGw3YzTj9x5VNKnNtVNHcobthfWh58kiDMC0cbhW9gwNOdKjxlPaXJs0cskAekjs/5OXqR2Qf3dWyqMP0ZDHyR8HeeNvOTKJu7ueylcuL4welkWfPj+X0sIMiBXwvm0xwrNxFv7Oqf4dKpidYJxku8+AqNa3I9quwaaB1Sh5axuA==
Received: from DBBPR09CA0003.eurprd09.prod.outlook.com (2603:10a6:10:c0::15)
 by DB8PR04MB7131.eurprd04.prod.outlook.com (2603:10a6:10:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 05:42:30 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:c0:cafe::27) by DBBPR09CA0003.outlook.office365.com
 (2603:10a6:10:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Thu, 17 Aug 2023 05:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=bestguesspass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 05:42:29 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.108) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 17 Aug 2023 05:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkgjF/WX53bY2YlIgzBUYlCD0WJTqOis3pWJqKjCZdFEEupbR6Ysnq6bSqlJETWP9ERwGeyoezK6XnL1/ez9UgtOTCPkXz6gx1sxNBkBez1lrY8CXMbGlWgFWzBsmTFQ+dvrP+BjTi6Sq4rDCEB6OCA7zUkA72FScJhL8/4Py3vlL0HwrPHmF5A9SqumpXdPLBFECVnHZk8t+Bbst3KM7lHdRWvYIAIQChdBr8IZBYp4j7+wOcCoNN55t1qXq2zY72yJ5v2xJnjUHz7IO1fZrRKPxPd/Le+Kr/tCQztjOokMupDQC7lM5M8Uavrm7G3XyFtoOdtpA+m9FZZC4dTM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29iDZZm8dqOfX6OKT2IeR60KHZ8+DPUaTet/44putQk=;
 b=b0KQG3P7N2iIwcsljn89QzPPnrpgkLnRpt4cfSJM3vdyypRNq3wMF2op2jQlDBadn6M+pDdjUweAWvmTXmO3R+8OZV6HFBrVm0GhDmfp/7vbx3t3oc6DMODybZDsUoBc+ltQVj/aiWFj0i8uiahlmXFXMTSo60T2MJw81VrIU/SdDUqmTR+x13PfnO2aJScHpv1r42BX0dFgUS9GSvt5zG2VjDLxhfAHzlKsFxCa8a/+8Da53iFf40NnfViP1kzfFNar9kos5MiQLOaOxGsM3nBO8yxB07Rl2AEHHmwmJHh6KMuD74RLAtU3IGMinqM8t8wzeOMUKpsLTFvbexk5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29iDZZm8dqOfX6OKT2IeR60KHZ8+DPUaTet/44putQk=;
 b=bBOZ4QJ4iRABxei0E89Hc7i3TqmLoGD/bPEcMe0Njtk8kb7CJcv97TJRjaz5aR9KpJhubMrtSwveZFNmqrfZWqWz6WyrEXWNN9n0ETQc4XASJjvCEgjw406CsdGqw4p/ndSdW/rMUWH06H/ioLUj3KS8w4T2kMLyX82HLbGUMkDdSHb0DywWLdlwKPm91X31zU7rjVKZ3aZ4Ot76/NNJVHwIoycSuxma9hVFfUBVB2TL2QXFcI5dBXN4BNgxMyphCjdowSXWbQHTTji8ASMYs5HA8VN6+/233PBKcfWLKDfwQ7lOba+0P0+HlT8UV9iCTMXXudhlylrXrTfmWBwaXQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by AM8PR04MB7377.eurprd04.prod.outlook.com (2603:10a6:20b:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 05:42:26 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 05:42:26 +0000
Message-ID: <ec2d7ef3-3dcc-aebb-1a4f-c2e01a09f750@topic.nl>
Date:   Thu, 17 Aug 2023 07:42:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] rtc: pcf85363: Allow to wake up system without IRQ
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.eeedf5db-4013-4c3b-be1c-1121df58f897@emailsignatures365.codetwo.com>
 <20230502055458.11004-1-mike.looijmans@topic.nl>
 <202308162140170c067ce7@mail.local>
Content-Language: nl
Organization: TOPIC
In-Reply-To: <202308162140170c067ce7@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM8P251CA0005.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::10) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|AM8PR04MB7377:EE_|DB5PEPF00014B95:EE_|DB8PR04MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: ede2deea-85d2-481d-25ca-08db9ee4bf26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4/np+tjU/X676t6CFrSpgKGt2SJmJUOgemqDuZbBoFsxoMQFY8vDJE1/iYvYj1zMxyfDkXlDOcTX6scIc+aclBQSaZ2bYm99dNZWkPwdhT0rCvGFW6LukVXBIvVmltMU9CHxy10+RwZwt6mk2epqu59jn2muOpBmsINulwkkATC64sGD+bfzETW14tqZ3TU+M9UgS86ZlRGFe0DxFHVSyLfXL3wq8Q+9CsI3qoukt/dmFauaVllJGUC7ubFubG//o+Ph8aSwttmBH98swQUPvwLgcczmpO/Rz3Y++1vSLuKVCcMJxaOzX2wcfYSKFiM4dooA8/G2gLHlDn6SW6JP3jvtwkxJGFaWVa0gQp87fMUNSRh2ES7MSNiVeNp9tAgLuYLGcprZe6y+EV/czkek8c8qCW4ALmTG6mopj6+xO/68aJ8h7urzSTYESijD3uMhLKNi1pIiynh78hcPpmp92ac9B35gf+e6OOI9FkERzg9ptn64vxTG7neGWqT53TckkBklK6LCqisqHUs6DNw2jO9d2Gqr6tt/kQd/HS0Kfe/gRrMlSsi9FcH83Hl53IwH+TU0KcUE6yoXzwjM9a/ylRBepCBNp2FMW18dJ9fbxJLiTjxpt5Tgun2fCZFHA0K+vThC2iPVvoJxTaXA7hM2Og==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39840400004)(376002)(451199024)(1800799009)(186009)(31686004)(31696002)(86362001)(15974865002)(36756003)(38100700002)(2616005)(5660300002)(44832011)(66476007)(66556008)(66946007)(478600001)(6916009)(53546011)(316002)(36916002)(6506007)(6486002)(6512007)(26005)(41300700001)(4326008)(8936002)(8676002)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7377
X-CodeTwo-MessageID: e9e5814c-db7d-441f-a609-0af98c3ab77b.20230817054228@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 95c8eb05-4738-415b-40d0-08db9ee4bcf0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESHgtKy4T/qw4Wcn/1ziZCAbTrdURx8EtQEnGHHoBIB24DLfAGnw/E9/z5JeucMIOsYhqTvG/8FwKW9Oxki+hy1MsLHCdjj0I5pKCuEZfLi1O0v2FzUvITJqyO1uGDskg+DssrV4sMRBdtgbKGd6/XXHYy3mQZFMovE8vh7S182etJUq/WlMbPGvDtvrdYBOqzB4JW9dFMXl9Lxssz2UWSfgzZqrcJhBxMObDcKekirz9sU1zrVMWtk5CxvkO9z/DKnTa7iXX/G9pRA95TMVcUO6L8ZZDASbdxDOmaxh25C/14+T2I0kX8acTt1W3ABJYZsbdY9nxJ3QwP7hXRwwfUXHWGiZFzsdvuc6FKEjjqCq9VFd8uqkJYy0DPd2jGvylXfw0Zrmyw29ndyw3rLjdWaydLA16nqW7Lud7+v4YkDtxtBY0QBC+bAnFDJysPv/MV+3lSwhISiEnSzEEt1o/IM0HGfOcqABVozyyCUas5k1thECy1GMoJRXfCByudJjeAYOYDvvXpY1rVRSbCfHHrVvWAJtoZd7G6QoOVLpSF3klDyjAdanZqxuuQ9BjIdocRVqkMUdSJ2HmPmaqHVkjumUe2u756nAoC6ddf1T8C3eZut/rJp9nri76k8KVYP/46cx4ovrpKfXPUlM1XC1HoY5MGcYywehwIvcnXRNC9zupuhjqJXAVsY7OFrvjpoH785IGL8tQe2Afkh2zXA+4Dk7cBkOshsYIZI+eaajce+WljqxNY0vKlr6xb1U+bY1K2YzD18lBWtUGIKQa7pGDA==
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39840400004)(346002)(376002)(1800799009)(451199024)(186009)(82310400011)(36840700001)(46966006)(2906002)(83380400001)(26005)(15974865002)(86362001)(40480700001)(336012)(478600001)(6506007)(36756003)(36916002)(2616005)(6486002)(6512007)(53546011)(31696002)(44832011)(5660300002)(36860700001)(41300700001)(356005)(7596003)(7636003)(316002)(70586007)(70206006)(6916009)(31686004)(4326008)(8676002)(8936002)(47076005)(43740500002)(18886075002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 05:42:29.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ede2deea-85d2-481d-25ca-08db9ee4bf26
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7131
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-08-2023 23:40, Alexandre Belloni wrote:
> Hello Mike,
>=20
> Sorry for the very late review, there is a small change that is needed:

Better late than never

>=20
> On 02/05/2023 07:54:58+0200, Mike Looijmans wrote:
>> When wakeup-source is set in the devicetree, set up the device for
>> using the output as interrupt instead of clock. This is similar to
>> how other RTC devices handle this.
>>
>> This allows the clock chip to turn on the board when wired to do
>> so in hardware.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>>   drivers/rtc/rtc-pcf85363.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
>> index 8958eadf1c3e..b1543bcdc530 100644
>> --- a/drivers/rtc/rtc-pcf85363.c
>> +++ b/drivers/rtc/rtc-pcf85363.c
>> @@ -434,23 +434,26 @@ static int pcf85363_probe(struct i2c_client *clien=
t)
>>   	pcf85363->rtc->range_max =3D RTC_TIMESTAMP_END_2099;
>>   	clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
>>  =20
>> +	if (client->irq > 0 || device_property_read_bool(&client->dev,
>> +							 "wakeup-source")) {
>> +		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
>> +		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
>> +				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
>> +		device_init_wakeup(&client->dev, true);
>> +		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
>=20
> This should not be done when devm_request_threaded_irq fails.

Yeah, easiest would be to just clear the feature flag when that happens.

>=20
>> +	}
>> +
>>   	if (client->irq > 0) {
>>   		unsigned long irqflags =3D IRQF_TRIGGER_LOW;
>>  =20
>>   		if (dev_fwnode(&client->dev))
>>   			irqflags =3D 0;
>> -
>> -		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
>> -		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
>> -				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
>>   		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>>   						NULL, pcf85363_rtc_handle_irq,
>>   						irqflags | IRQF_ONESHOT,
>>   						"pcf85363", client);
>>   		if (ret)
>> -			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
>> -		else
>> -			set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
>> +			dev_warn(&client->dev, "unable to request IRQ, alarm not functional\=
n");
>>   	}
>>  =20
>>   	ret =3D devm_rtc_register_device(pcf85363->rtc);
>> --=20
>> 2.17.1
>>
>>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl


