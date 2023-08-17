Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F0777F2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349259AbjHQJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbjHQJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:02:54 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F17E7C;
        Thu, 17 Aug 2023 02:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQzC1owVsep1jn16vPHA6rGh9HPSKRIFQP86R8mPf2j5AHArMQsGwOL+m4IFn5fnV8J0J4CiIikk4wVCwO5StWmA0VCstR8nYkjdr/PLlMMQge60bk2gv4mhsC0tt17pwUr8z+jpGeNdH0I9NGi09Tg/lAWj9Sg+pjCSlDqCa39ULgVokJXAcvv2lj4SbJCJe8Bkx63tmLY3eQQ7h1AHP6UhpEsYJXdswji/hJA2TWWvFys7GBTpQ2gSuhz8v5774ps/Gq23lfBH3ovH/WlOZuX2OG/ccEtm0bGAYfZYqJ0r3BxZjM+DlArV982ylJc0QAqZ5LkH35Bvcpdm6R9cfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgwSrPcX6mqv4Rmfhaew1TA64siftYS9J5yNqTkE8j0=;
 b=lUyo2OqHupy0kueI+3/chtfBMAlIPmPxc6uym4fikEGiE9eeiDpub+WqzfyYrT+m/4s6d6G5EUc4SZJ6F5jfy2tSe901VgNXD/jHSQuaovO86r/5EdbaXGUJxi4YKeO9mhFd5i+P6EA4uUNszH6yd3cLjXfdAD6ek/q3xMMTZDOcVo1+QfMOENeYi558SCrNE4p8DgoTI1UqQfBdwmU82vEJuUMvixcSxkc+ewGyUZDqOwbt61Nwa+a2FG6JyNC1zoa5lbTTa9XQwtsSWKmFNdAxiImVvJnVwjzc/hTGNjSgsIAbL1keuHIGUxu0bMZV2is8pTP+/AGMtjRTYr4FsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=bootlin.com smtp.mailfrom=topic.nl;
 dmarc=bestguesspass action=none header.from=topic.nl; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgwSrPcX6mqv4Rmfhaew1TA64siftYS9J5yNqTkE8j0=;
 b=wwmF04eAI5BMpwjyuze42bEnSfgHF2oFLdRUTSrtjW4RoBSt6mGyWpD23zIUCnXxbFhBpOhdA4BsbwATe3oRPRl+aOfHF+uVx9SlMtoTww42KvWrJN5Xo6hpE+J6TXGPubj03W5InH0HtOVlrUQidHvNadxoTQWwt3kbnPHQWRIJYWhLHPtkcR7SxuEUJQ+CrCWSPPGeMfq8+WxUZnRLtFbO/uWg5twiMQ3DImgmguZg2rvdLLbprxP/rzX7SxWiKH0A/P9rDxG60j1zcnALGaz+u/8kEjGKpfowvkHoNMXEeC0WsIwSRSDstxgtCztveHdDKfGqwXx1lfqBs/xtIA==
Received: from AM6PR01CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::29) by AS8PR04MB8497.eurprd04.prod.outlook.com
 (2603:10a6:20b:340::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 09:02:48 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:e0:cafe::b6) by AM6PR01CA0052.outlook.office365.com
 (2603:10a6:20b:e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 09:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 09:02:48 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.56) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 17 Aug 2023 09:02:47 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 09:02:45 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 09:02:44 +0000
Message-ID: <5113ab6e-881b-fa6b-00c4-118b32be4a4c@topic.nl>
Date:   Thu, 17 Aug 2023 11:02:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] rtc: pcf85363: Allow to wake up system without IRQ
Content-Language: nl, en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.eeedf5db-4013-4c3b-be1c-1121df58f897@emailsignatures365.codetwo.com>
 <20230502055458.11004-1-mike.looijmans@topic.nl>
 <202308162140170c067ce7@mail.local>
 <ec2d7ef3-3dcc-aebb-1a4f-c2e01a09f750@topic.nl>
 <202308170817599c17a369@mail.local>
Organization: TOPIC
In-Reply-To: <202308170817599c17a369@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0075.eurprd02.prod.outlook.com
 (2603:10a6:208:154::16) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|DU2PR04MB8583:EE_|AM1PEPF000252DA:EE_|AS8PR04MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 25787396-84db-4485-676f-08db9f00bad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MIyBqRvLNODEe9GGGdwC7Zc+DS7cNabWylDby2eNnVWcI7LcykvOaAXFBZANdlyKcMKoKv68vImdACq6fKk+0Mgt6mAt3KUVPFG12p1gaWNwOMQYn+JNqRrl473Pv0bx1XA6txZr0eyEDsBQwxXflvA0qtKP5uhC5bdyyLePkhPS4h7eK2NKQ3Jew53QefFANYYXMg0oZnAbeBvIxK34wmXYFFwNUEMuDbT+wH0sKQKcdsDBlwOt61qWhb+2hVDG5nfcDhagFl0Cc7n7XKE8P2d7DSSAm/ecXIbGuUqec+qj1ALr849++ll6RoV8oQu4AcRRBrT0upEQkltzZOU+z9SY1vVe/x5UpCQqBiuTNtz1eXcx8J8PKDcBNTreHJV36ZylslxyJKRu3Wdcud85XvbIyqG4WaQkMGRPqB8Du4NgzTC1zeP81Ne36prXit3QGRaBhvvq2VPShMzka0xQWJGD8dTbUd82/rGtT3aKMvGAYzF8Mc7GYKGctqYGjfXzOXxOSfyjrrrw3mAjz9NCbpRyNw2/haKhIVvqNx+ekZqf4v4+6VqFGbe+901sGXZ4L8gn8Y5v37ruUEfimavzqAJXTeUqWWLidnv8I5a56GLHskE44ZTipmt+PVSGYBk0VDsfS1ErHUi/6NfDxf/MNA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39830400003)(376002)(451199024)(1800799009)(186009)(31686004)(31696002)(86362001)(36756003)(38100700002)(478600001)(2616005)(5660300002)(44832011)(66946007)(66476007)(66556008)(6916009)(53546011)(316002)(36916002)(6506007)(6486002)(6512007)(26005)(41300700001)(4326008)(8676002)(8936002)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583
X-CodeTwo-MessageID: 56d9f81c-3cd4-4dce-9e0e-229f74424932.20230817090247@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3cd81988-15ac-41ba-6dbf-08db9f00b87f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anikciTu66OLayhiaTOS3UgI8b40OwWyCPG54heErJh+sfBaOJOcgy3jy4YEvbUPu2CClBMx6HiDKWG+QxCZCSQRRPu5CtCq4co5XwekC9DMoHLIuFTC1fYT5a684bWS6dHSGFn++3c/zw+Gu5207mM2Qet4INk2r31C09DjkB9aMwcPwXDe2rT3QXVYW/Zg/UTHMpMbI2iEWfFqzEtbU3PpMWTu0zFzwogNx9E9VoN0SApuvnxJpCKGJs1Fb61o2+Fm4AEQ+1o972urnoGg5NPs6WeZXBvhxGkn3z7E6wLdGtW1+CD/EDND2hjMIAxtlZsT5Y1AnafpHwtwOqJPXI8O7u93LRjabqNMHXJtZvqexgDeI4jc4zDJQsYkyBcO/gpY5lkw24o+wIEW8POCKg086wMTfxAd4uX/9hejfaew9Jr4CVjKCsk27jLA4FF5RUkWuxEno9ja8bHo0dCYuwgAU3uioBCAm9fEUBg+B2/MH2WEaNfwJkObuiV6bnE6WD3RZMDVPAS3yJwg6k83npB0xd++dxVaS3k7S/8Gs7a3yTNUmJRO9tNueY4A4EnhnCGhO9Fh06pJasGk9t1f2GeebEhI4YQ9XIXyrP5qsP2TrN10UVstruTczFJ1ZClQiL9cp9gOKdAUX6YA+cuFZ1zkVIztAW0c5XIsqu56v8xx5DA9ysbXGLTBMZC6MlGdCManoKIbekPnYZ0QX0fge58JvisLj4lWfnnpkSzvzLY=
X-Forefront-Antispam-Report: CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(39840400004)(346002)(396003)(376002)(136003)(451199024)(1800799009)(82310400011)(186009)(36840700001)(46966006)(31686004)(31696002)(86362001)(15974865002)(36756003)(7596003)(356005)(7636003)(40480700001)(5660300002)(2616005)(44832011)(478600001)(70206006)(70586007)(6916009)(53546011)(316002)(36916002)(6506007)(6486002)(6512007)(26005)(41300700001)(4326008)(8936002)(8676002)(336012)(36860700001)(47076005)(2906002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 09:02:48.5846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25787396-84db-4485-676f-08db9f00bad1
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8497
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 17-08-2023 10:17, Alexandre Belloni wrote:
> On 17/08/2023 07:42:25+0200, Mike Looijmans wrote:
>> On 16-08-2023 23:40, Alexandre Belloni wrote:
>>> Hello Mike,
>>>
>>> Sorry for the very late review, there is a small change that is needed:
>>
>> Better late than never
>>
>>>
>>> On 02/05/2023 07:54:58+0200, Mike Looijmans wrote:
>>>> When wakeup-source is set in the devicetree, set up the device for
>>>> using the output as interrupt instead of clock. This is similar to
>>>> how other RTC devices handle this.
>>>>
>>>> This allows the clock chip to turn on the board when wired to do
>>>> so in hardware.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>>
>>>> ---
>>>>
>>>>    drivers/rtc/rtc-pcf85363.c | 17 ++++++++++-------
>>>>    1 file changed, 10 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
>>>> index 8958eadf1c3e..b1543bcdc530 100644
>>>> --- a/drivers/rtc/rtc-pcf85363.c
>>>> +++ b/drivers/rtc/rtc-pcf85363.c
>>>> @@ -434,23 +434,26 @@ static int pcf85363_probe(struct i2c_client *cli=
ent)
>>>>    	pcf85363->rtc->range_max =3D RTC_TIMESTAMP_END_2099;
>>>>    	clear_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
>>>> +	if (client->irq > 0 || device_property_read_bool(&client->dev,
>>>> +							 "wakeup-source")) {
>>>> +		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
>>>> +		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
>>>> +				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
>>>> +		device_init_wakeup(&client->dev, true);
>>>> +		set_bit(RTC_FEATURE_ALARM, pcf85363->rtc->features);
>>>
>>> This should not be done when devm_request_threaded_irq fails.
>>
>> Yeah, easiest would be to just clear the feature flag when that happens.
>=20
> My comment was also for device_init_wakeup(&client->dev, true);. I think
> the easiest would be to move this block later on and set client->irq to
> 0 when devm_request_threaded_irq fails.
>=20

Ah, clear. That also properly handles things when IRQ fails but wakeup-sour=
ce=20
was present. In table form:

IRQ   wakeup-source   Call "device_init_wakeup" etc.
N/A   No              No
N/A   Yes             Yes
OK    No              Yes
OK    Yes             Yes
FAIL  No              No
FAIL  Yes             Yes

We still have to program the registers before registering the IRQ I think.


