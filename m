Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8EE7B86E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbjJDRoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjJDRoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:44:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A99E;
        Wed,  4 Oct 2023 10:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=og5MLHGzfIYM3dv8LZr5vhJ8JhEpV4SykQ/bg6eovLnOzDfQtSfMBDNMXWdpXZy8BEX/2Gnx9Ri+EUrvHT/xIW0bdIPoj/SGyJ3Dwi1BoCns3TFiAxEC+MeeMkJ4flFjSYUZZJwqbleqn+3VsrB1+wNRpG7gNRA8Q7t8SIYxVMxS4gB0wlVCMBsFizkQW+qwXPl+xBinmofMwVmDJKRz7AF6YI7xmr/uEbxAxt9upc1aBZRcYNte+Nx/Wh7Eqwbf0sKEp4coTXKJy05P0OZEMsP/+V7R2XQojaPDmWO7cqI7p/uuGA5frTyR0ZpQWCvPWyAPyThRJ2ThJpMZoJElGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4uCV0Ovb7N+7wi/8SyQvoFF7WeQA9Xp3erO6oIHoms=;
 b=h3SzZqxbYwvOBjOm2qEV4Vklrqgef7e5Zbi6h68JZTq0J3cWYrI5GSw37reun2epxmFYzV1/FFZoj4EDTmoIEbs7Ccs/AMHOUPmPNA/Ux8+8QyuwO0iXkRsLejbjs4rcSBp1MP7jBAgnlg2idw6h3It3Rj6VaTB1VsTRwL2eCswwJnHk+Rs+dDDZGMbG1wzbhNxmNvS73UiV273A/hfB8pqAU35ipGcv07JvRHaME0bGxXIMBjFNwVR8rNMbDiP8Zi5+/B2ycZbVgPQIP31l94mkqvVtZ2sn97E1yxB+NCcP/yWGlIG77vx17AnsRhKfgkNlNrEkOmvNU0shEPRVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4uCV0Ovb7N+7wi/8SyQvoFF7WeQA9Xp3erO6oIHoms=;
 b=kmac0+Y46JSPoGXxg7mXdgWkxW7MrCMGfOOOUN8Qc0eI1+EhO8UOmeMorDQtai1cITL8yK4IOJ8ytdSeqo1xgN//xylCvg9y9QC0f/Dj0VyNK2wj3r04ewF6AS5IjGlVaEOfGQq1PUp+ZRtXVkIsN9gobFsJBkh7KpZxv/i0Z/02nl1xsNHoY5+Z6Pl+iVMK9cTywnEK/Sl76H+KqItp+X7PqD0YVqgiYWNaqkMSsx76xSGXOEioqxyuUL9eCTlBiVHvulobR5hWqmC119r6BajsvF1cdxooScfwbYDDRo3h5eIdR0iOZkE22eceJcNrFzMHcbzZ8eimmYKJmK7UFg==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 PUZPR06MB5452.apcprd06.prod.outlook.com (2603:1096:301:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 17:44:14 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 17:44:13 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>, Joel Stanley <joel@jms.id.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Potin Lai <Potin.Lai@quantatw.com>,
        "patrickw3@meta.com" <patrickw3@meta.com>
Subject: Re: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Thread-Topic: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Thread-Index: AQHZ74jrjlOSMsUvo0yNgHQbGiIz5LAviZQAgAamlbSAAX0ygIACRq65
Date:   Wed, 4 Oct 2023 17:44:12 +0000
Message-ID: <SG2PR06MB3365F684ED71DB0CB90246318BCBA@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
 <a310aba3-0f04-4549-a776-36ff8cef736e@app.fastmail.com>
 <SG2PR06MB336555C2C52E24FCCDE72C748BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <4bee3205-212b-4032-a105-9b8f1fb1fa22@app.fastmail.com>
In-Reply-To: <4bee3205-212b-4032-a105-9b8f1fb1fa22@app.fastmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|PUZPR06MB5452:EE_
x-ms-office365-filtering-correlation-id: c0050666-ff44-49a0-99a6-08dbc5018580
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrgLgjHcRFcvihxVZeCuM1Ea6gVp/eL4SG7ORyX14+oQkBPxP+8sl0d6l3g6r/hnkG0tq40rkGHLAmI/BgxQxcUyr2rcshUrcUYGOQ4Sr87qS7bpglFoU8+NcL7JgIpMSP6s5RHUCxWGE+IN5Oavr589Khas4jT6KOY1nxOswAkCKFrn/MNpDTWjK7S3HEe/Z53Sg0LjQZUgZQOYEfxq6bIaof6agG5nFNty1uhheSIOv4UxqJby+rsMn/bHaEXu/QWIY7EspU81QQSwLI/6dpU6iyPrR/JQ0W4CQSaJvD7ScValUcd0HnZZQZVW2QcD8A7PCaHWfmwxqOGJyGmcYdCkUrsmTpGVVovxkEc1I4wg/fGljqwlZjQKfk2PZeevhZS+1WIKuafIF5+8D2efOyz1+YZ1IG7RPXL0ZgRaLUtETK8FzXcIJZmUKSbN/lMOe5oOnRz1gOIeFr0FBvMNSDmPOrFgb9J+n3OFcK/E+bZMR606iXs/5H0xEVVnZDKMy/FOQ6xAQt+i+PCgg3EkpRrNxnFGy3/9TH+hYvGEGXRHIqdEH9UaFOjlQHWGfJo+al4zSwkYhQbIWxXE8I1UR8o5b47mvARwMak6xMZgZbZv6gHmiG5XSfQkCnXt4Cuebv9IarWwOAUWPx1k/No6Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(7696005)(9686003)(478600001)(83380400001)(26005)(71200400001)(2906002)(7416002)(316002)(64756008)(66446008)(110136005)(91956017)(66476007)(66556008)(66946007)(76116006)(8676002)(8936002)(41300700001)(5660300002)(52536014)(38100700002)(38070700005)(86362001)(33656002)(122000001)(921005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H7LOkZ5+sKiMnrO0aMHYpLQYYM1eDdmniD/0kP/PoFSn0LiBrZc/QkOE3m?=
 =?iso-8859-1?Q?+XSWE5L4yUL0cDhdNWPkellmdv39QqFD09RMbobSqDzjkSHVOziY5jTyGz?=
 =?iso-8859-1?Q?je5Z65nLRFPxiiHufmbS4YiccLdtdYWdNgBEhDuBiZ/4PUR40eNsjCUEIP?=
 =?iso-8859-1?Q?xFmd1ZGl6D9qkRDv9gm4Jp0yJzU6A18oPDZyC4X8KnQ6xMKGx/NZjqEHSN?=
 =?iso-8859-1?Q?7c6cSp0RmZSaLFs28XkDEQO08EO/dsZH9/2f1ZKVx2vc/mU80tQc9B7zSa?=
 =?iso-8859-1?Q?oTjm4VLE8GB9ncNazrKZcr6dHnIh+cWIizpm5aXJlxj+H3fytMrnTYGLuY?=
 =?iso-8859-1?Q?064xAqP71Ee3th+XxwrwEUnlTtEJek/KQmPXYSHFQ+TvUbHd8KxUmX/WLB?=
 =?iso-8859-1?Q?hjVuMCS+TE1VG5wpXWfge7fMd24X9EyJtHeIR2VXAw/ybJpOdOFiEjfCfN?=
 =?iso-8859-1?Q?BZgcr4Ld6A/hzOu7QgxYiZ7vlCInICvNYMkxqoMUflAGtJU3uLkwH57Qcq?=
 =?iso-8859-1?Q?3t77LQOcpDtSQQB8+uXTdGzy4SPvnno2ZOff2wwBk5wUXtLMTEW7O3r2R5?=
 =?iso-8859-1?Q?JTOqkR1gNf4WPg4zJjg3UlbyvdFnCjbFuEEtgFPRQaSuG6CKsTtR0n1U3F?=
 =?iso-8859-1?Q?vbo7hiYLlB/SJvAEfDp2UhvMr+HRZMbMjWtdDMdLDknFT77YDzBN1lpZym?=
 =?iso-8859-1?Q?ApYPA0ibs8eoyCEx2KLlcHIaKvtkhLaTS6O4J6nwnFXBFOUhguHHK//Qxj?=
 =?iso-8859-1?Q?6pvuKiDSrJwK+X+fPAfxlftSR9qoeS3pq2KbIanka6T/ccyYK+ZaPA1qXX?=
 =?iso-8859-1?Q?/7k9XWWJaN3aug6lNh3GlA2O3WEqbuohoKjwAsNrT9iiZKpSzH3vX1xmAe?=
 =?iso-8859-1?Q?c4Gwzy4Qoya4TPTKJDPS5j5CgY7o4L3KIAROfCxseuhS3BSM/A1Nb0DcPg?=
 =?iso-8859-1?Q?6ebV5yKqjmzB41du+fcdfZVFkltfLXAuGNbFsqZNtcm1oIrpu1j+9STW4E?=
 =?iso-8859-1?Q?z+F8rISyr0cKpuhxF0Vm/r5EyvyGrkMDAzK3QfE7JCvhT452vtIQudM1Fo?=
 =?iso-8859-1?Q?OHwjZzIfARbTTzyFfqtlBh+a7vrlR3kNKLFzCq+7J1UvxfoszFZlpGCxHw?=
 =?iso-8859-1?Q?+jeqQokHjDOs7fKHobrhDr4YKuYU+gCsPfpHYeUkouNbeAt0rLWcOwffhw?=
 =?iso-8859-1?Q?CeawKVXNYlZR+sHmHwCBciKwf1UTnvBn9Vghj3c740y3A4W3ZVxGL/1i4P?=
 =?iso-8859-1?Q?hxg6quGv3ebpGhkPi2XUuyqyOkOcFTul+wWWizvxh9Ac7Oi+t3lLHmQs8h?=
 =?iso-8859-1?Q?sGujvB5zCed28+62owz2UbjKUh2l2PPLwcDPLmoWZWPidyfRVwaVghrmzq?=
 =?iso-8859-1?Q?SrFAAVmmq1K4mdtbgNHynwNiYtUhm6XXbq+tdsyfdG1g18W7r3DyDdK27o?=
 =?iso-8859-1?Q?1lGV2NKVXqshaQjglHPiWc8BfQPPv1qwE/4Yr6YyzKS2LaUo+Taj8vzGSe?=
 =?iso-8859-1?Q?c2zsvg4SEYKxO9Ug9MfJ/FyofgI3i7jC3S7EYnZm4n4tVvPq/Xl0esitln?=
 =?iso-8859-1?Q?B9t30kFqRVahygvosF57FMF4/R8LQjkkTE7F80tjIw3bewqBs6bnN6wvLK?=
 =?iso-8859-1?Q?fVCsguW43QHJkur7ADVzQFCKgd6pQZnNHP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0050666-ff44-49a0-99a6-08dbc5018580
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 17:44:12.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itYipPRBRtQqAHa8aldh84oTmR4RjUsQmxm9c7I6jsSFE6v4AlEbamGf5jRrhZ497TI0bgCrLSwFkZqt6IG2RTNxVvBl3iXP6g3JN0VIqFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5452
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
>>> > Create event sysfs for applying the deglitch condition. When=0A=
>>> > in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set to =
true,=0A=
>>> > the driver will use the in_voltageY_thresh_rising_value and=0A=
>>> > in_voltageY_thresh_falling_value as threshold values. If the ADC valu=
e=0A=
>>> > falls outside this threshold, the driver will wait for the ADC sampli=
ng=0A=
>>> > period and perform an additional read once to achieve the deglitching=
=0A=
>>> > purpose.=0A=
>>> >=0A=
>>> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
>>> > ---=0A=
>>> >  drivers/iio/adc/aspeed_adc.c | 193 +++++++++++++++++++++++++++++++++=
+-=0A=
>>> >  1 file changed, 189 insertions(+), 4 deletions(-)=0A=
>>> >=0A=
>>> > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_ad=
c.c=0A=
>>> > index 998e8bcc06e1..9e746c81d916 100644=0A=
>>> > --- a/drivers/iio/adc/aspeed_adc.c=0A=
>>> > +++ b/drivers/iio/adc/aspeed_adc.c=0A=
>>> > @@ -95,6 +95,7 @@ struct aspeed_adc_model_data {=0A=
>>> >       bool wait_init_sequence;=0A=
>>> >       bool need_prescaler;=0A=
>>> >       bool bat_sense_sup;=0A=
>>> > +     bool require_extra_eoc;=0A=
>>=0A=
>>> What is "eoc"? Can we use a better name or add an explanatory comment?=
=0A=
>>=0A=
>> Hi Andrew,=0A=
>> This is the signal name for our ADC controller, it means "End Of=0A=
>> Conversion".=0A=
>> The appearance of this signal period indicates that the ADC value is=0A=
>> valid and being updated to the register.=0A=
=0A=
> Okay, searching for "conversion" in the datasheet didn't turn up anything=
 like this. It seems I wasn't off-track with asking. If you go forward with=
 the patch in some manner, can you add a comment to the code documenting th=
e meaning of 'eoc'?=0A=
=0A=
Okay, I will add the comment for the meaning of eoc.=0A=
=0A=
>=0A=
>> >       /* Register ADC clock prescaler with source specified by device =
tree.=0A=
>> > */=0A=
>> >       spin_lock_init(&data->clk_lock);=0A=
>> >       snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",=0A=
>> > @@ -632,7 +806,14 @@ static int aspeed_adc_probe(struct platform_devic=
e=0A=
>> > *pdev)=0A=
>> >       adc_engine_control_reg_val |=3D ASPEED_ADC_CTRL_CHANNEL;=0A=
>> >       writel(adc_engine_control_reg_val,=0A=
>> >              data->base + ASPEED_REG_ENGINE_CONTROL);=0A=
>> > -=0A=
>> > +     adc_engine_control_reg_val =3D=0A=
>> > +             FIELD_GET(ASPEED_ADC_CTRL_CHANNEL,=0A=
>> > +                       readl(data->base + ASPEED_REG_ENGINE_CONTROL))=
;=0A=
>> > +     data->required_eoc_num =3D hweight_long(adc_engine_control_reg_v=
al);=0A=
>> > +     if (data->model_data->require_extra_eoc &&=0A=
>> > +         (adc_engine_control_reg_val &=0A=
>> > +          BIT(data->model_data->num_channels - 1)))=0A=
>> > +             data->required_eoc_num +=3D 12;=0A=
>=0A=
>> Why 12? Why add a value to the number of engines enabled? Have I misunde=
rstood?=0A=
>=0A=
> This behavior is specified by the hardware. In our ADC, it requires 12=0A=
> dummy sampling=0A=
> periods to switch the sampling channel from CH7 to CH0. Hence, this=0A=
> condition checks=0A=
> the enable status of channel 7 to determine the necessary delay period=0A=
> for obtaining the=0A=
> updated ADC values for each channel.=0A=
=0A=
> Okay, I feel using a magic value '12' with what you wrote above as an exp=
lanation is asking a bit much of the reader. Again, if you go forward with =
this patch in some fashion, can you document the meaning of 12 in a comment=
 (and possibly use a macro to name it)?=0A=
=0A=
Okay, I will include comments and use meaningful macro to name it.=0A=
=0A=
Thanks=
