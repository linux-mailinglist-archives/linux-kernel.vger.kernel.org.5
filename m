Return-Path: <linux-kernel+bounces-52194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217AB849530
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42AD31C23E1F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48737111BA;
	Mon,  5 Feb 2024 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="nAofy2Ux"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2113.outbound.protection.outlook.com [40.107.104.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB311706;
	Mon,  5 Feb 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121013; cv=fail; b=kTiKbfuC4kZ2vhq9jjXCQvxeCY1d8nnrGJ373SAaSCU+Z7d+qqm6XVeQZEQ57kOJ0ehUZSJYs7m0DlWmFygEnK7bYBu7GI1WzefvheHHW1vrtVHB3XUSPrda7Dzd7KyWkTeK0IA+mnxWvrtFlKh2pDlGcCpQuvlTjY870E0qkYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121013; c=relaxed/simple;
	bh=47tDSMiHozao9VZFZx4qbLW8KS72ywJCKsCQpfEzRGQ=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HJzc13HUNGXTbuE9nY3UQvXBVQ1bppmYJFF4NUtXdbYhPJyhEUEG9bjDfZrcFms+7a0rSNrvDMXSNdzRpLugCGGKqRFzWiS2vCl5M/2c0Kmka9p1Jhf/3x0wmNW4aQlk2oeoBLA3pBjeX7z4EbloNzEWDT5DK3WG1vwPRLSQ8Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=nAofy2Ux; arc=fail smtp.client-ip=40.107.104.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Igg38VQlOF8x5zQnnrd75gilXRXtMHnYXF6cN3zaEI0JqnhaK4kYdQ7uIQGDOnBHZLscEMfFDF+PP04xHyR4LroyorUOwsFhpmzl4aIz1yhMsDWpfMmka1fvBUXeJSkUPkugj/o9GS0J/d8lwhf/W0WIZ2W1rYgDvQ0kSJaHKCroN4ck99AOA1JbQX02zhe8MLnqj2O5l93mGiOMWJTi4eJdPA3v1yW88vw97xVg2/F8w0R6FfUi2JvwFTXLkIaiKPKQFKM8E22HWwL5IMaKSXMhq3rUx5kTVZHqY7eZg0mzsoZJ3V1RNIfR0s+vQa8z/KQzfLZ6sjMQxypI6SZZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja75HcOTEVYNiUc8S0DHkLjyokiH8y7Bmk2+LtcYBOQ=;
 b=hXLsb/Ch6mq+us3sJRPNRaXDCge76Q60fbw/rApP5HOWksnN4nDBoecTEpUpjibeyJjaQonRu3Z359g3eRfb+EkRLA3C1i9+KS8h4FEl1/xySmL76vV72mlW8Hm8h4iC/qSyXBr/j/iLgDilRGwJe9hiMt8lmlVM2UZm/z4lx0soHHIUYQDWy9XeRyiSX50SjFHL0cBunZhQUHUusuyBXLM18ob7mrykGxkj6pRuGVJMcs1wHjBce3AChjR0/Que0XiUtWpkGzzD2afidnbnVZlwLsxQk++YCjVW1yobj4PHTNujnH2it1AK3/eBYb9C0/AE4DSkc13mQcO/+gspZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja75HcOTEVYNiUc8S0DHkLjyokiH8y7Bmk2+LtcYBOQ=;
 b=nAofy2UxLu/AwSYSTiPtDfGQUO7M/ootJHOYtasLmLRr6IqVI+JHbOWolEmKXvxynjZDslP4KNfS2Qt0+ocVpt6yaYskjD9idWjD1QcuOPDj4NIN3EEXoNZbffUDUrJAqdbPvzY5Mi72lgggne6JLpgXVqXsBr5AX3PZkaRT8v7lrOKSLaCupE5oK7lfw4fj/RnYvYBWHxgvCUazK+GDMDdg8nwN2Py1ktskgV9VBVimPaFhP9JT0gGbbgUyHOdKkjLWqNIcSVwAQ+MOsO3OW7lpyopWw65bgLmFz9VWwCxeuZppLvEk7Ic0VzIZnAizf43MUb4rM+nH+1bRQBNDVQ==
Received: from DU2PR04CA0021.eurprd04.prod.outlook.com (2603:10a6:10:3b::26)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 08:16:46 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::bb) by DU2PR04CA0021.outlook.office365.com
 (2603:10a6:10:3b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 08:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 08:16:45 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.105) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 05 Feb 2024 08:15:57 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM7PR04MB6949.eurprd04.prod.outlook.com (2603:10a6:20b:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 08:15:55 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::651a:dedd:945a:d1dd%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 08:15:55 +0000
Message-ID: <9eb85f99-d9a2-4e40-9b15-8a3145350904@topic.nl>
Date: Mon, 5 Feb 2024 09:15:54 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1298: Add driver
To: Jonathan Cameron <jic23@kernel.org>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Beguin <liambeguin@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Mark Brown <broonie@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
References: <20240202105901.925875-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.6274d473-fd3f-439a-bf61-89eea8028afa@emailsignatures365.codetwo.com>
 <20240202105901.925875-2-mike.looijmans@topic.nl>
 <20240204155422.5ae03e4c@jic23-huawei>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <20240204155422.5ae03e4c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::17) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM7PR04MB6949:EE_|DB1PEPF0003922F:EE_|DB9PR04MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: cfeb3c9f-613f-409e-924b-08dc2622cb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 5D1ALNHNovelBXEkPPpZl5cTzPqtZ+x7L1+VrnQXuqdtJJ/G0+r2anEB59rr6YtcxWXwsU/30VwnKt2nTp3G9QyU6639PYt/5Fm5hJ8+u/hWCsxqC7b4apK0Tyy1OX5ZO7pMN7q4N+IBYy426SlAYO7nCaEuRE9FQPlGKYHsfbUv7Ecs4BegZFiDqkTk3MDJlWJxIbzS/UL76p6nKPRUtRHycsaZIQhh5DmTke43dDR0DALeTlr69Jtt7cv6vdyhjrHE2c977BlpeZ0DhHUFLcKeB+9QtQdsq/RE+dHFW25+eoBV7EemJW3npnt4yUT6QSNQaVvpsi+DgTMtA2ncXJDxj5bJA08OFA2L62K2fCjST08UqDd/nP+thoSqU2h/gY8YZYa62DCd7j3vbPS/YtbIzifLnoiDtSwv2fIkkykLuYlYJM+Y8voWuLw2glupoeqdPePJwMI8pcxdlxf2JBxkRBH8OK7XlILZlssI5ELjWDrgT0tCyj5TmTLq504w7cKTQ2Q8af4rvlqWtDF7tVht9nKWD0XcC9eodP2n4GhK9Va+bmU5IKkgn3+iyshu92iN3CmCyDYSkrG9GoGYcDKwBk+Cfp1wg1U+iOmaePwlbiJd41bWW+56rTpY3L9yYYz6TYOEfBg9Qcv0sgX0JtcFHdiSbPn/Dv2Sl36D4MU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(5660300002)(44832011)(2906002)(7416002)(316002)(66556008)(6916009)(66476007)(54906003)(66946007)(4326008)(8676002)(8936002)(38350700005)(36756003)(26005)(478600001)(86362001)(52116002)(36916002)(53546011)(6506007)(6512007)(31696002)(38100700002)(2616005)(83380400001)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6949
X-CodeTwo-MessageID: 56c0f98d-50ae-4c8f-885d-6e03c0c95c53.20240205081557@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fc3220b5-de14-4571-f424-08dc2622ad00
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GBf5jUOheLPOwV+3Ig7w5nVGBHEnT83kxT4TtXKvW3WfmuTjxGYKPnSKVJ5r+xSpMO8VzL3o6Qs9Sg8b0mnIeDTmwFQItGczN7JMKs3kN4Hfk1Jc9Ll592aUqViDEITFGsn42857gb36oF5NDxxPR0gB9pWn0bwl3f/HFOWYNcihsobkMjAKYwtmwaxFojdgnaRoa5z3GBkWISkkgOEfUeP2PSWIqXfdDtKWAN+XtaFNrlIHDHNJkkNtggOJPaUNk4seROdCP6ymaQy2Dsw0UGu6uQFeed8P7oZ9QGQmTGBwoXV6bmRV4ja3iVC8zN4J7eWd37q9/9edTS7KobwklvqFGvliQ9KvI8LvzH6XQNSW9UZgWk/h0RMMLVNhmRv0/VUpI18qusYCggAUMscg4gGs0F5BNSIr+dc1Z3iqWufZTFYfjGZUjeoEUphchNM3KLLl495Ek1+hAzWqJq2xm3J2dPCFIadDtlYHlEdIgRICttjKb497ziZ6hlBPOvGTkP+hk0oFMOrg+qqIVIYYywz/y2cBqU5NfmIZX+7MkDGaIOG3m4YM07JD7d8x1BcnWhK8DMH06wTYoo0PtI5qPwJBBqWhD/idpd3iVoiEKbT6magmLyxLGrn1GUsONiSlzil1ZQTuG53BJIz53FkU01r+IUSfMi/T2MllDhvzQIGc71BfdH9Jyu4oQlHxNyCHjiZiNaAygXr1sUC5gfts4zxhySihoCJ52mj0poLZtGI=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(4636009)(39840400004)(396003)(346002)(376002)(136003)(230922051799003)(82310400011)(186009)(1800799012)(451199024)(64100799003)(46966006)(36840700001)(7596003)(7416002)(44832011)(4326008)(5660300002)(7636003)(36756003)(8676002)(31686004)(15974865002)(316002)(6916009)(8936002)(54906003)(70206006)(356005)(70586007)(2906002)(6486002)(31696002)(40480700001)(36860700001)(478600001)(86362001)(83380400001)(53546011)(41300700001)(2616005)(26005)(36916002)(6506007)(336012)(47076005)(6512007)(43740500002);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 08:16:45.9339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfeb3c9f-613f-409e-924b-08dc2622cb6c
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675


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
On 04-02-2024 16:54, Jonathan Cameron wrote:
> On Fri, 2 Feb 2024 11:59:01 +0100
> Mike Looijmans<mike.looijmans@topic.nl>  wrote:
>
>> Skeleton driver for the TI ADS1298 medical ADC. This device is
>> typically used for ECG and similar measurements. Supports data
>> acquisition at configurable scale and sampling frequency.
>>
>> Signed-off-by: Mike Looijmans<mike.looijmans@topic.nl>
>>
> Hi Mike,
>
> A few minor things I'd missed before.
>
> I'm still interested in why more standard interrupt handling isn't
> good enough here (see reply to v1 thread) but if we can't get to the bott=
om
> of that (or do figure it out and we can't fix it) then this doesn't look
> too bad so I'll accept the complex handling.

I think one of the key elements was the IRQF_ONESHOT usage. The DRDY=20
signal on this chip isn't a "level" signal as most chips have, it will=20
de-assert at any rising edge of the SPI clock, without regarding=20
chip-select. There's no other indication of "data ready", so the only=20
way is to keep the interrupt active on edge detect.

Keeping things in hard IRQ handlers reduces the number of context=20
switches, and the amount of work done is minimal. A worker thread would=20
wake at every DRDY signal, and after the corresponding SPI transaction.=20
This doesn't account for much overhead, but the interrupt rate is double=20
the sampling frequency. Most importantly, the device doesn't have to=20
compete with other threads in the system.

If I have time and hardware available, I try to get some timing info=20
with an oscilloscope...

Assume "yes" to all other suggestions...

>> +	ret =3D devm_request_irq(dev, spi->irq, &ads1298_interrupt,
>> +			       IRQF_TRIGGER_FALLING, indio_dev->name,
> I missed this before (and we've gotten it wrong a bunch of times in the p=
ast
> so plenty of bad examples to copy that we can't fix without possible
> regressions) but we generally now leave irq direction to the firmware des=
cription.
> People have an annoying habit of putting not gates and similar in the pat=
h
> to interrupt pins.  Fine to have the binding state the expected form thou=
gh
> (as you do).  So basically not flags here.

I'd be happy to leave the IRQ direction to firmware (indeed, inverters=20
happen...), but afaik that wasn't possible with interrupts. I'll dig=20
into the docs to see if that has changed recently.


> I'm still curious to understand more of where the delays that lead to
> needing to do this complex handling came from, but I guess it's not too b=
ad
> if we can't get to the bottom of that so I'll take the driver anyway
> (after a little more time on list for others to review!)
>
>> +			       indio_dev);

(PS - sorry for sending HTML, consider me appropriately punisched for that)

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E:mike.looijmans@topic.nl
W:www.topic.nl


