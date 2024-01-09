Return-Path: <linux-kernel+bounces-21408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B16828EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B4A288476
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6F3DB88;
	Tue,  9 Jan 2024 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CKcmNWBr";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="B01Crwxh"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AF3D990;
	Tue,  9 Jan 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4097M7K2001700;
	Tue, 9 Jan 2024 15:08:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=PODMain02222019; bh=FdI6yG+EU6YRkqM98e8ABnuvtGY2RK5MSToGYev6H
	zg=; b=CKcmNWBrs4ZkgoCS9eNpcNXFE2CxIPgDB3Z3jhNudC+P/aOxyWiAJLaPX
	4D/nl6pRs1eKzNlaaK5vjPCyvOSUgj89fXhC0Yiw4+4I2xQDhWkNFKNhju4lfkYM
	1yBD1sYBXZAQSBebolhDue1FOlv8eRfIOhHUyYa5KUtZhDR7t+eo++06zrgalH7M
	FCKgZ/7dgekTUcCvmkxCnpqe+jxvbUXm6Tqyqcn4yqGAZppBNVPPpNoUiK64zRJG
	1iOzixW0GxjB66cHEcb0u9jNrjvC1INTtwLfqIQ56IoEHtR7aUbAgNa0TtDz6I2l
	QYV6/zbswE5gedG+O+kLnFZPjHNkQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vf45pmd5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 15:08:53 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekMnljU5ssFrx6PBiEc13O3qvJygjlHqhuPS3SEAZSPqEA7gc+yxYodWT8G6YhySeA+cJfpb+3jMMaG+d0SwUwqIrTfhnKuxCcezlNl+oi0SgrT99ZtkuqAPQfSTwmU2Lm9AjsLC97j3DjImBL9vq0HTSLZvvOO9pbAmntooPrE7baM7PbMBij2CGQHagVZjMy/jFbAEK9GvMpG2CXyCUXlfdtbKLvPyTf4IzE2xj7dCTo3D9aBwPL4as1jAJqgGLMj5yWdFu+sAhhr2zqeYgUQz/CesLS+sVZdCmVcx2mZImQIc2bX4GeOQorBL3RD/64RQOwNJKifHxcIf/2/YJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdI6yG+EU6YRkqM98e8ABnuvtGY2RK5MSToGYev6Hzg=;
 b=AYwscnc7k7IzqJLNjSu+xp9prM5ZnaroNMxRQSRxsqeTw3za4IATjHBdMdFlhUEBLOc9DXkZza/Qwzh0JYl75tVoW+UBY6EGYJOGjJodd2MO1koer2gDLXIg8ZbLUkYusT4t8PyZWXvvkUGt2WnMG4k1UxrMGtaAilTRpRAl5tWl1AQkjFnIov370dYuXw30Kqjzsm0V9IQox8cE+Lg4E0sXReKMlu7VQUltuCuq2YAt7PyYpnDoDN8NpN5R5RAIpxY01v9bJt43SSgmn0H6uA/mQGufCbKmE/s36jdfuc1CrNk4JUkaEMfkSyq1rNf5tF4nrWRzmkDwxz58oMsz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdI6yG+EU6YRkqM98e8ABnuvtGY2RK5MSToGYev6Hzg=;
 b=B01Crwxh88MzJpv1TCbHXJjsb6ehJhuccjCaGZ+HjI1B9MAzTzfoxCivaqtRq+m1F8YMDHLxGfBYE0r4QttzjKYIbsQAF3JZuGm8UUw0vtt7tdiqPky6or3RlaZOrqNHoEEERG4J4H09QSgH7RIO5dvsfOrO2XAEtjDLqbr1zT8=
Received: from DS7PR19MB5688.namprd19.prod.outlook.com (2603:10b6:8:73::14) by
 SJ0PR19MB6891.namprd19.prod.outlook.com (2603:10b6:a03:448::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 21:08:41 +0000
Received: from DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::1dd9:275d:e53e:5cb]) by DS7PR19MB5688.namprd19.prod.outlook.com
 ([fe80::1dd9:275d:e53e:5cb%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 21:08:40 +0000
From: James Ogletree <James.Ogletree@cirrus.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
CC: James Ogletree <jogletre@opensource.cirrus.com>,
        Fred Treven
	<Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard
 Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman
	<James.Schulman@cirrus.com>,
        David Rhodes <David.Rhodes@cirrus.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jacky Bai
	<ping.bai@nxp.com>, Jeff LaBundy <jeff@labundy.com>,
        Peng Fan
	<peng.fan@nxp.com>, Weidong Wang <wangweidong.a@awinic.com>,
        Herve Codina
	<herve.codina@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Shenghao Ding
	<13916275206@139.com>,
        Ryan Lee <ryans.lee@analog.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Shuming Fan
	<shumingf@realtek.com>,
        "open list:CIRRUS LOGIC HAPTIC DRIVERS"
	<patches@opensource.cirrus.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK,
 TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>,
        "moderated list:CIRRUS LOGIC
 AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 3/5] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Topic: [PATCH v5 3/5] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Index: AQHaP168ighr5EhGj0KHpyfGBV7m37DLQVqAgAa/5gA=
Date: Tue, 9 Jan 2024 21:08:40 +0000
Message-ID: <AC98C1E6-C1A4-46DA-8964-3319CFC821FD@cirrus.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-4-jogletre@opensource.cirrus.com>
 <20240105140407.GG14858@ediswmail.ad.cirrus.com>
In-Reply-To: <20240105140407.GG14858@ediswmail.ad.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5688:EE_|SJ0PR19MB6891:EE_
x-ms-office365-filtering-correlation-id: 3a78c868-b776-4070-402c-08dc115727c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bmJGqo4xaw8Y8iuOPximW+V3SAN+mYsm+u8Mxk9yEoX+4XTPMKatuMuGWecohkwdN2VGc6uOA50zlohehTnX9yJOPMrr6FLIC4VnEAUE1RMEkVAXlGr0KwShki1zUdK7lQT5Z9HMVEr52iTbRBA/yzjcO41M00EILEQjB/KHOk25I0qgSx5UfO2MfUm+MI70Hf4DN15PfPMgLK9an3uJdBebOSbZMmzdhDH8QLhAM0n7dKasvnRVS4iiiqyJ3L+t30psdRV8ZRfjNXvO7PxA2ydDKCQBFulgILmo/cLobshnRFCmE9NE1WXoyWonLRxhE8afU7AMbuGyZYOO2SsvRYEdvRA7pnuCl7CPsitz0y/hmeHZj9YFebjOVTXfzVszZs1nEsLcRQlZ6PIrfe8fhbKh60d+zD7fnNiAAGn6wW89XYoA8d1KOQRzDIv67YQaxXH2JS3DqRhOLdwdEna1MkUDbhEDjiFHQCvNh/nv5x+k4egHzfOuK23QpkBD3o/z9HM0JXlyZOvwBmcR5XWIcTo2yz3VTxUzqG9AGGzMPnQ3RpkwXF1ID0JLcAHjSQhBU6BCdJjCv0/JGMrerlsUCKN+eIbDMg6X2KBQpebvJeR7As+vFCMQ2swXRqurBSJW3FPOBVF75B3txE5xMd5J6g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5688.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39850400004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66556008)(66476007)(76116006)(316002)(6862004)(4326008)(8676002)(83380400001)(26005)(478600001)(2616005)(64756008)(66446008)(71200400001)(2906002)(5660300002)(38070700009)(41300700001)(38100700002)(7416002)(8936002)(122000001)(86362001)(6512007)(6506007)(6486002)(54906003)(33656002)(53546011)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tgO/kjJebvPO21Wd5ije9K3eQM7spDehzUo/Tk1tPxxH/djYX5VxWXPD3zgf?=
 =?us-ascii?Q?DzO9yLMVI/fEO9W2QGyXnqQG5Eks8hFOzRG9N6O1KvfvnO74Tag6Xu2gBg60?=
 =?us-ascii?Q?O/5+RKkc2Pdm7qkHfOME5cx6LKxqaG4FpN9okaY/fSqj1no8F2EPfvCj1eSA?=
 =?us-ascii?Q?Fo3HwX6prvelyye4R/4OYfrpVcaA5e54QZzh2D+x8ZNAeCb+QkbWbqV6eEmH?=
 =?us-ascii?Q?OWVX2RrOrQIARDj0M4FyHBWswgNOgfPvEroWayoOzEtOAYOCWfzpQLR8S3wE?=
 =?us-ascii?Q?obGwlXo7XC6D/Rr97dOWhLwjXPPN2+e7EcrA+J+dVi6IiiNVb5Zr9UZm4vYt?=
 =?us-ascii?Q?mAtGlqX1ub8hGWfIWL64jm2U3kaW4eZxzI4ghdpPkVigp0BlU/3McPW7lfQx?=
 =?us-ascii?Q?iJ/MtfYyLtAfuLC+hrE2hMKg+TzJ54YaHwsLrHYfLC8P4ZYUqzxfIhF5UPF5?=
 =?us-ascii?Q?DCpKIF6yQQpvAt4+ENGKi5YElqBa/3rTxV8WWvFPRDbs4XJr2izln+LgL2X6?=
 =?us-ascii?Q?n6V3e8Ml127+VGNw1Wg9ytCzWxypY2YvVE4G3785t0uC6oUsyCdOK6mZa0aw?=
 =?us-ascii?Q?XLbNzFD4njQyRf/CodhT8lw10xW58wP5CViJk45Dh/r9EnisYrvZYAbVzvo1?=
 =?us-ascii?Q?UErfL2Qujy8O6YfLE0PTXvvPXWRFTjInADbVUP/XpgDaQN0jquUcc+c36nks?=
 =?us-ascii?Q?SYIQBAnKprTIeNZqEJAnktTK5qhvwd6CQbdga6WfOzHuEbinaNQFHNjpmh+J?=
 =?us-ascii?Q?lXe9mwA8sNPgu33ApdQPWf0rvTIo8Ja36KA3N8nO1uU6ILcDDeuwUYWajMg6?=
 =?us-ascii?Q?KyrMiRzRLoHXrESuK6gI8Zm1B9Ctny4/FpoN+WPhTMW+Mooxz6n/hf6Z0FvO?=
 =?us-ascii?Q?c+A9h5Jmn/m/o5AUvCmp3Yv0KqCxLIEfcUk14EDT0zQfQ/CY2qR/X1jqCheN?=
 =?us-ascii?Q?8ry4An++nzlb+MrQ98tM5EHcRy1ouRtD0U7U5V2Ly5rWdTk86vOqI5paukpd?=
 =?us-ascii?Q?30x54KDaHpecETbIzwxBNTgbJbI/Mhc8UG6eu62VNt/GS5Tfcc29eL+voD2H?=
 =?us-ascii?Q?8zzPX0G9UwoeWYJNwj8gUk0QUttALDPh1LR3+Cwb3yg0M3cka8AkyfUUczzu?=
 =?us-ascii?Q?6arsdfZv7TKPTjVHWYHPofwiMCxZdmh0v+gaL9jL2+TfloU/xmAnA5QXNcqU?=
 =?us-ascii?Q?OPzXV6bfLLYzm0M47Czdi5SAGB+kVM8OFjFeMlB2uZCsqR4tGgFG1fynnUJW?=
 =?us-ascii?Q?l0WD7+2sqNA6IsDpG13/HQl7YdAo6Qv4n3Iq0Ci6rzJ4RgTBwmtWzoTruTtS?=
 =?us-ascii?Q?p9DQX4PHpC5HzFbb/7OwGdnfe2phLcVdZFA2TcrhHN2ITw8L8U3scH+iE4Wa?=
 =?us-ascii?Q?3U/PmrAXjnxlgHkdaUeIBTY/zzagThGS7R8sE0n1UyU+CDwNcfM7mt2GMV/i?=
 =?us-ascii?Q?gTdzOXon8mLmMpvXiy5Y2EZszAJX/pxkdnwGhZeG28O7RKxo6R9WRAbJp+mr?=
 =?us-ascii?Q?k5/EiD894W6qe8/WlEipUvPvXFJG79BMq5U869DsrQwheIPJb0iVzftDs43D?=
 =?us-ascii?Q?Y3rJCwkOA4Gy1k3QEM9d9GOJezanEeKKDRdlc8CncF0ggcw5IZKZmEiPcF8Q?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB5F5974BAC31C42B8A6526C02630EBB@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5688.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a78c868-b776-4070-402c-08dc115727c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 21:08:40.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VY5kzEZuzpOi2p1cSLc3JcyBU2gDfofjA5KrYcpXadOJ/F8Vc8GGNdkxqfRuDjL5lzoBV9bCmEBrSnWfI9lOa4Gq8APjwReYgPfPXqQLuKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6891
X-Proofpoint-GUID: utK7TKBzX2H1rdOcT1l3JPxYywfWKeqT
X-Proofpoint-ORIG-GUID: utK7TKBzX2H1rdOcT1l3JPxYywfWKeqT
X-Proofpoint-Spam-Reason: safe

Hi Charles,

Thank you for your excellent review. Anything not replied to will be
adopted as-is in the next version.

> On Jan 5, 2024, at 8:04 AM, Charles Keepax <ckeepax@opensource.cirrus.com=
> wrote:
>=20
> On Thu, Jan 04, 2024 at 10:36:36PM +0000, James Ogletree wrote
>=20
>> +static int cs40l50_dsp_init(struct cs40l50 *cs40l50)
>> +{
>> + int err;
>> +
>> + cs40l50->dsp.num =3D 1;
>> + cs40l50->dsp.type =3D WMFW_HALO;
>> + cs40l50->dsp.dev =3D cs40l50->dev;
>> + cs40l50->dsp.regmap =3D cs40l50->regmap;
>> + cs40l50->dsp.base =3D CS40L50_CORE_BASE;
>> + cs40l50->dsp.base_sysinfo =3D CS40L50_SYS_INFO_ID;
>> + cs40l50->dsp.mem =3D cs40l50_dsp_regions;
>> + cs40l50->dsp.num_mems =3D ARRAY_SIZE(cs40l50_dsp_regions);
>> + cs40l50->dsp.no_core_startstop =3D true;
>> +
>> + err =3D cs_dsp_halo_init(&cs40l50->dsp);
>> + if (err)
>> + return err;
>> +
>> + return devm_add_action_or_reset(cs40l50->dev, cs40l50_dsp_remove,
>> + &cs40l50->dsp);
>=20
> Hmm... I notice you use this for both dsp_remove and
> dsp_power_down. Are you sure devm will guarantee those are called
> in the right order? Its not immediately clear to me that would be
> have to be the case.

On my inspection of the devm code, actions are always added to the
tail, and played back from head to tail on driver detach.

>=20
>> +static int cs40l50_power_up_dsp(struct cs40l50 *cs40l50)
>> +{
>> + int err;
>> +
>> + mutex_lock(&cs40l50->lock);
>> +
>> + if (cs40l50->patch) {
>> + /* Stop core if loading patch file */
>> + err =3D regmap_multi_reg_write(cs40l50->regmap, cs40l50_stop_core,
>> +     ARRAY_SIZE(cs40l50_stop_core));
>> + if (err)
>> + goto err_mutex;
>> + }
>> +
>> + err =3D cs_dsp_power_up(&cs40l50->dsp, cs40l50->patch, "cs40l50.wmfw",
>> +      cs40l50->bin, "cs40l50.bin", "cs40l50");
>> + if (err)
>> + goto err_mutex;
>> +
>> + err =3D devm_add_action_or_reset(cs40l50->dev, cs40l50_dsp_power_down,
>> +       &cs40l50->dsp);
>> + if (err)
>> + goto err_mutex;
>> +
>> + if (cs40l50->patch) {
>> + /* Resume core after loading patch file */
>> + err =3D regmap_write(cs40l50->regmap, CS40L50_CCM_CORE_CONTROL,
>> +   CS40L50_CLOCK_ENABLE);
>=20
> This feels like this needs a comment, why are we skipping the
> normal DSP init and doing it manually (this appears to be the
> same writes start_core would have done)? I assume its something to
> do with what you are really doing is you don't want lock_memory
> to run?

The dsp struct uses cs_dsp_halo_ao_ops, made for self-booting
DSPs, which has none of the ops used in cs_dsp_run(). The
manual stop is because it is self-booting (already running you could
say) but we need to stop the clock to patch the firmware. Please
correct me if that is not right.

>> +static int cs40l50_configure_dsp(struct cs40l50 *cs40l50)
>> +{
>> + u32 nwaves;
>> + int err;
>> +
>> + if (cs40l50->bin) {
>> + /* Log number of effects if wavetable was loaded */
>> + err =3D regmap_read(cs40l50->regmap, CS40L50_NUM_WAVES, &nwaves);
>> + if (err)
>> + return err;
>> +
>> + dev_info(cs40l50->dev, "Loaded with %u RAM waveforms\n", nwaves);
>=20
> Kinda nervous about the fact we access all these DSP controls
> directly through address, rather than using the DSP control
> accessors, we have the accessors for a reason. They manage things
> like access permissions etc. and historically, the firmware
> guys have not been able to guarantee these remain in consistent
> locations between firmware versions.
>=20
> I guess this is so you can access them even in the case of the
> ROM firmware, but you could have a meta-data only firmware file
> that you load in that case to give you the controls.  I don't
> feel the need to NAK the driver based on this but please think
> about this very carefully it's a strange way to use the DSP
> controls, and feels likely to cause problems to me. It is also
> quite hostile to fixing it in the future since as you are not
> using the controls no one will be checking that things like the
> access flags in the firmware are set correctly, which is annoying
> if the decision has to be reversed later since there will likely
> be a bunch of broken firmwares already in the field.

Noting here that we discussed this offline. The driver is going to
stay with a static register design for now, but the write sequence
interface is being modified to be control based.

Best,
James


