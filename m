Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD797B4D9A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjJBIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbjJBIua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:50:30 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEF0E8;
        Mon,  2 Oct 2023 01:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCuBcnzbZHjrlQe30IlUVXqWC8g0VuM4NieZLRxTxaFVF9jZMCYxobpHZ6XMfiT+KC/H+tS+ment5Xh87MW/NS9fdbNtjnHzqgI7PbKRy30WcNEaHt4cmSt5bshspWaVltPCd4uZDAN4oOrj0OOFhCPhABmsCJVjQNJ7QE27MblviUR6W7ICYPGjdtgP1xqPXQsQ9Vlb/giHeszpTmtQCwXAuxbBmSZm0JWYcUBXf2mAFw2Z/m9sD7Sq2yke+2zfgxMR46hK4b3abWvpXXszCkQpv15lIHTcQbK/0n1Zr8TPC5ahVD5k3xXF/F1SR7i+YhY+UlUBv1F+Ay3Gwi6ppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtYtc9slMBEQF5aTAtCo9QRJDx0W9qngA0a40lmNXfc=;
 b=BKzpjUQFuYV11PBw/vNTZomQOorihxOd8eApp8qKHxmGQtRRNfAtRfuDqRcClzNFP2kN0lnWhTO1qnc87UBvAgBIUmn0E/B5GASMq2ti6WySrgMnUvOvWdekPU4XdVWuN1dEDfNvTcKtmPqSYPVbaoUglG2zJiB8F1wcSm4NgmCwPk/c6f7M7qHBZEcaC/m2YUy1EbtJvFfW5wOXsoV7A3AaP5UVKKa8HG+0spoXlDLLQEmJmpIMwaBZjY89EQbILG4AFRdbHG6teoaPgHuXDun9Sy0ivkkxIWePbjG/Msc1pLLct1ByvohKNvt8NR7tmDMMHnuSh/aosuOQ8TRgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtYtc9slMBEQF5aTAtCo9QRJDx0W9qngA0a40lmNXfc=;
 b=UcioL1K9mgNKxyNp/YADJ5XLfByUO7yKoLdmWE01Bv/HgL6A6SH4IsnzM6JJAfZnL1ZUJflQgJ5SNaKtOlMC0cq5GQiKedaInXi1g0DAMZZCf0uhHMaJwZ1CU58WJg717Nw449VjDBRGuYIX9ganIT+1XhUT3va8iRRmbeQ8no6pY4+3HtGXRKAc8YJWAdSEUKWT0+2adKFmqJRgUJ7AiQQCNqliLO//ogB3oDAy/S4mBRk2YIZcK3ozl+PIiAJEUpmxDQVSKda60TbhKv/nj0Ggz27el4mY6xak6IxDD65hOIgAJ9ibvBfx/jO1xQj6/37VqDsRS5JmUAo61wS5yw==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 2 Oct 2023 08:50:22 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e%5]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 08:50:22 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        "jic23@kernel.org" <jic23@kernel.org>,
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
Thread-Index: AQHZ74jrjlOSMsUvo0yNgHQbGiIz5LAviZQAgAamlbQ=
Date:   Mon, 2 Oct 2023 08:50:21 +0000
Message-ID: <SG2PR06MB336555C2C52E24FCCDE72C748BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
 <a310aba3-0f04-4549-a776-36ff8cef736e@app.fastmail.com>
In-Reply-To: <a310aba3-0f04-4549-a776-36ff8cef736e@app.fastmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|TYZPR06MB6144:EE_
x-ms-office365-filtering-correlation-id: 1b1c010f-51f4-413b-5118-08dbc3249cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLF6tO2N58ewh5FW+fSe/cx3xUXBOPE0Ce63LkTyhmcq87cZiKEKAUr15eBf0rkqGY1dNPf4y5nim4JLKIsuVI03oB2NOjDgLI6CF8sMSgc//HgqPTfX1wWqkyB79KmjtUXmfM0VISR6f9PcfpfL4hs9jJKMmJ7yUwY7ITpDGFv8FCuT40WXikc+39WujRlLFla6/PJu1aEAXSbniKPLifXIeBv5VkzbY3Uij4V9YyCAGkcgcy//EODZMLMYquIlUgfuLuev07QU7LW4A6qErOCaCu0V0a7osE21jObfGnQH4zGkKqXCBjopk4oAi54NkLnSjaOKU/FDzq1Cse0Rv/GzqcX/SRM+tjE2yBvh8ehauyMKWcYrzUSotjeHFoDPenw08IZ+7Q56wO2oFHwXvEimoLmems4Bxq6/TOxX0xO80/2YtDXgHzAfnZimoesrwUK9vBBXOmw8Uljsic9GnnOY+1duiygi4EfSv1BVP2l6fzPwgVSNNyQ9PlQMFwHXtT6s3ZE74ltlY6VYU7ExGIUfKijR2DI0zMaqpyRyJYeCRBxeZeIrtzGfuottjjL96stHsOdVMVEiGTLrdyoplON6/m9pEpZOAf2ZB8cGpBqeyMcW8aiqGYZVzv/r1d7IX/+LIZ/mkBs3Yme9V/NFGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39840400004)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(86362001)(66476007)(66556008)(52536014)(110136005)(91956017)(64756008)(76116006)(5660300002)(66446008)(41300700001)(8936002)(66946007)(8676002)(316002)(55016003)(7416002)(921005)(2906002)(30864003)(38070700005)(478600001)(122000001)(33656002)(83380400001)(26005)(71200400001)(7696005)(6506007)(38100700002)(9686003)(55236004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YMX2CRislqbN7rtGNSgPlEYEk9pj23JyMlhIt/hEzNQ9pG4Ta2MOT9LjuA?=
 =?iso-8859-1?Q?7AiYySkVv7tlcjoInEokQYRPG5IV4c54Fy7582SnhFuJB/HYzDI9Ln1jG6?=
 =?iso-8859-1?Q?QggDA4OabmBaJAX/VAVPD+Z6D57J5W94lwaHc0Wi8IO+VgYBLHMaV1FZ0+?=
 =?iso-8859-1?Q?uVYWyEX/JcCKkR1r04L6DxolaczzMQduSEno1lD8ImIYKQJOpqVDo0/yW7?=
 =?iso-8859-1?Q?aiUyBQIl6X82XVw52xjv/pX71VJOax2A/ulzseEkrypPEaqGvMgGtsy0N+?=
 =?iso-8859-1?Q?LkVbvXqbJQgrqA2APVrT/eYAjBAL555h+oYPyV3p8NTBmijizEo4TGKyCy?=
 =?iso-8859-1?Q?skgx07ZrI6RtGhEuCUgnXbMDKnuy6BRBzbZWjWTmV8nNgTJ2M1TraHuLP8?=
 =?iso-8859-1?Q?CQ1oIOSsUKYy5boz0NEyqEaKfUzskSzQ1zYFMolDLmKqDtb938RpEf1mWz?=
 =?iso-8859-1?Q?Fxpxp9sHGEjAddtwksC54GSY9xomP4DsTRImBJX5ciOMxhJHg384fg/7kl?=
 =?iso-8859-1?Q?Zj32Uq6aNWUoMPrrj1GbzukMnKYz3hQZcyni6wxxt/szTHXLWiGodsjyu2?=
 =?iso-8859-1?Q?UaUWKv1dhfKLAQBxwSDPPTljo6Fzl0o7lAl8RuuWZIbuvdIdzF3pJ+ZQ9A?=
 =?iso-8859-1?Q?2Vn8OooL1HajnuxB7ERYLs9XbrQn9BbUiBq0Ji3aCqdIshZ4qOjF3BI5n6?=
 =?iso-8859-1?Q?EZ+gfy4FC3sYVC3R664pHM0/m4GUMaY/g7EzARrIGmyEFrSh7Da6BqPPja?=
 =?iso-8859-1?Q?YVGUpnH2/UEE2HlUsik2PNNvLW2Uu0bTq1TA2M2P16WWPV9GPk4/i7p15G?=
 =?iso-8859-1?Q?eKAtE/KOUKsoEvByJdq0Kj1+Wvv3FkQfH8hzwEh7j0Z12OwEJxz0pK5BOi?=
 =?iso-8859-1?Q?gku9gPQtasRWyom+WHDFd8vLbODspLB9ROErcYZwCzeiSWLL+6vltvvRQ4?=
 =?iso-8859-1?Q?M5YsusxhowJM1kr3saMQ0j+LRCob9P2GVS/14dpaBQDhhQsAlZXqtvQj39?=
 =?iso-8859-1?Q?kmPChG+sE5qtCGxVq2u8PTH5cKIzuCiRuthkiDnAgi5hEXMTIZXYUYTCML?=
 =?iso-8859-1?Q?quaJ4kalkhZpngv/vsfDbjUurWVg/6Qb3htD3i4vmhfoFodYej9xoa37Vt?=
 =?iso-8859-1?Q?WVld76syY7hbjUfM0chZlya0rbDsEPDcfqPEFvNrOvQG2QKaDw+MpoQLQ2?=
 =?iso-8859-1?Q?0TcL1QDJU9pP0mqLTItBQm4+4UwB5DSoGXsSsxWyJgDSJseTKy4/cDUTY2?=
 =?iso-8859-1?Q?tFfyelg4AL4cVUjJXHzpXmB4PXHWMAkR+S+N5nopJVOCrscLnA2N8duYit?=
 =?iso-8859-1?Q?NdxpAaapVuw8oV4YgOXJqZ07Lz7QQRQ0E4WReAXRl4aPEJqood8CU4pkhW?=
 =?iso-8859-1?Q?LUDiBkfv6Wp5USw61pJ6gpt98rOif9XYUodH1pd1Mmbouz0PPKjByakGqz?=
 =?iso-8859-1?Q?K0WX//BnSdovyzLGPcfNJOZxzIgS09jFAHZKwE5q0UVADvK3tkREzb1w0k?=
 =?iso-8859-1?Q?IMbvs9IQfoDsRjGMseuw1MCCzEzdr2ch2qyrAtXrzo9DsUjH1VqdiNTBE7?=
 =?iso-8859-1?Q?rN7Ql6wtT9LmEGZtxDuAaHkdNWCNsn8TI6ULhqEfpxxHNZJwsMuHKdsI67?=
 =?iso-8859-1?Q?G3+3Ne09MGtm35t7Uhp5ezEXlNA/q8C5+6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1c010f-51f4-413b-5118-08dbc3249cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 08:50:22.0030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AtP/ueygbD87OyqbWaKZ0p26NgUTJB8zc1dGp0nNUQ7XLXl26AQWZBe5ocDUiz0S3Jyc3J4T4H84wRD7W2O2RU5QXe1Qt6/qZPtL8sbc0Tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023, at 17:48, Billy Tsai wrote:=0A=
> > Create event sysfs for applying the deglitch condition. When=0A=
> > in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set to tr=
ue,=0A=
> > the driver will use the in_voltageY_thresh_rising_value and=0A=
> > in_voltageY_thresh_falling_value as threshold values. If the ADC value=
=0A=
> > falls outside this threshold, the driver will wait for the ADC sampling=
=0A=
> > period and perform an additional read once to achieve the deglitching=
=0A=
> > purpose.=0A=
> >=0A=
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> > ---=0A=
> >  drivers/iio/adc/aspeed_adc.c | 193 ++++++++++++++++++++++++++++++++++-=
=0A=
> >  1 file changed, 189 insertions(+), 4 deletions(-)=0A=
> >=0A=
> > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.=
c=0A=
> > index 998e8bcc06e1..9e746c81d916 100644=0A=
> > --- a/drivers/iio/adc/aspeed_adc.c=0A=
> > +++ b/drivers/iio/adc/aspeed_adc.c=0A=
> > @@ -95,6 +95,7 @@ struct aspeed_adc_model_data {=0A=
> >       bool wait_init_sequence;=0A=
> >       bool need_prescaler;=0A=
> >       bool bat_sense_sup;=0A=
> > +     bool require_extra_eoc;=0A=
=0A=
> What is "eoc"? Can we use a better name or add an explanatory comment?=0A=
=0A=
Hi Andrew,=0A=
This is the signal name for our ADC controller, it means "End Of Conversion=
".=0A=
The appearance of this signal period indicates that the ADC value is valid =
and being updated to the register.=0A=
=0A=
> >       u8 scaler_bit_width;=0A=
> >       unsigned int num_channels;=0A=
> >       const struct aspeed_adc_trim_locate *trim_locate;=0A=
> > @@ -120,6 +121,26 @@ struct aspeed_adc_data {=0A=
> >       int                     cv;=0A=
> >       bool                    battery_sensing;=0A=
> >       struct adc_gain         battery_mode_gain;=0A=
> > +     unsigned int            required_eoc_num;=0A=
> > +     u16                     *upper_bound;=0A=
> > +     u16                     *lower_bound;=0A=
> > +     bool                    *upper_en;=0A=
> > +     bool                    *lower_en;=0A=
=0A=
> I wonder whether we should instead embed enough memory for these new prop=
erties directly into the struct. Take the upper bound on the number of chan=
nels across the supported SoCs (`#define ASPEED_ADC_MAX_CHANNELS 16`, from =
the values defined across the `struct aspeed_adc_model_data` instances down=
 below). From there we could have `u16 upper_bound[ASPEED_ADC_MAX_CHANNELS]=
` etc instead of the extra allocations in probe(), which get a bit tedious.=
 Also the channel `{upper,lower}_en` values can be bit-masked out of a u16,=
 avoiding the dynamic allocations for those as well.=0A=
=0A=
OK, I will modify it to an array with a size of ASPEED_ADC_MAX_CHANNELS (16=
) and use bit-mask for *_en.=0A=
=0A=
> > +};=0A=
> > +=0A=
> > +static const struct iio_event_spec aspeed_adc_events[] =3D {=0A=
> > +     {=0A=
> > +             .type =3D IIO_EV_TYPE_THRESH,=0A=
> > +             .dir =3D IIO_EV_DIR_RISING,=0A=
> > +             .mask_separate =3D=0A=
> > +                     BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),=
=0A=
> > +     },=0A=
> > +     {=0A=
> > +             .type =3D IIO_EV_TYPE_THRESH,=0A=
> > +             .dir =3D IIO_EV_DIR_FALLING,=0A=
> > +             .mask_separate =3D=0A=
> > +                     BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),=
=0A=
> > +     },=0A=
> >  };=0A=
> >=0A=
> >  #define ASPEED_CHAN(_idx, _data_reg_addr) {                  \=0A=
> > @@ -131,6 +152,8 @@ struct aspeed_adc_data {=0A=
> >       .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |  \=0A=
> >                               BIT(IIO_CHAN_INFO_SAMP_FREQ) |  \=0A=
> >                               BIT(IIO_CHAN_INFO_OFFSET),      \=0A=
> > +     .event_spec =3D aspeed_adc_events,                        \=0A=
> > +     .num_event_specs =3D ARRAY_SIZE(aspeed_adc_events),       \=0A=
> >  }=0A=
> >=0A=
> >  static const struct iio_chan_spec aspeed_adc_iio_channels[] =3D {=0A=
> > @@ -277,6 +300,35 @@ static int aspeed_adc_set_sampling_rate(struct=0A=
> > iio_dev *indio_dev, u32 rate)=0A=
> >       return 0;=0A=
> >  }=0A=
> >=0A=
> > +static int aspeed_adc_get_voltage_raw(struct aspeed_adc_data *data,=0A=
> > +                                   struct iio_chan_spec const *chan)=
=0A=
> > +{=0A=
> > +     int val;=0A=
> > +=0A=
> > +     val =3D readw(data->base + chan->address);=0A=
> > +     dev_dbg(data->dev,=0A=
> > +             "%d upper_bound: %d %x, lower_bound: %d %x, delay: %d * %=
d ns",=0A=
> > +             chan->channel, data->upper_en[chan->channel],=0A=
> > +             data->upper_bound[chan->channel], data->lower_en[chan->ch=
annel],=0A=
> > +             data->lower_bound[chan->channel], data->sample_period_ns,=
=0A=
> > +             data->required_eoc_num);=0A=
> > +     if (data->upper_en[chan->channel]) {=0A=
> > +             if (val >=3D data->upper_bound[chan->channel]) {=0A=
> > +                     ndelay(data->sample_period_ns *=0A=
> > +                            data->required_eoc_num);=0A=
> > +                     val =3D readw(data->base + chan->address);=0A=
> > +             }=0A=
> > +     }=0A=
> > +     if (data->lower_en[chan->channel]) {=0A=
> > +             if (val <=3D data->lower_bound[chan->channel]) {=0A=
> > +                     ndelay(data->sample_period_ns *=0A=
> > +                            data->required_eoc_num);=0A=
> > +                     val =3D readw(data->base + chan->address);=0A=
> > +             }=0A=
> > +     }=0A=
=0A=
> Is the potential for a double delay if `data->lower_bound[chan->channel] =
>=3D data->upper_bound[chan->channel]` desirable?=0A=
=0A=
I will utilize the "else" condition to prevent the double delay.=0A=
=0A=
> > +     return val;=0A=
> > +}=0A=
> > +=0A=
> >  static int aspeed_adc_read_raw(struct iio_dev *indio_dev,=0A=
> >                              struct iio_chan_spec const *chan,=0A=
> >                              int *val, int *val2, long mask)=0A=
> > @@ -299,14 +351,15 @@ static int aspeed_adc_read_raw(struct iio_dev *in=
dio_dev,=0A=
> >                        * Experiment result is 1ms.=0A=
> >                        */=0A=
> >                       mdelay(1);=0A=
> > -                     *val =3D readw(data->base + chan->address);=0A=
> > +                     *val =3D aspeed_adc_get_voltage_raw(data, chan);=
=0A=
> >                       *val =3D (*val * data->battery_mode_gain.mult) /=
=0A=
> >                              data->battery_mode_gain.div;=0A=
> >                       /* Restore control register value */=0A=
> >                       writel(adc_engine_control_reg_val,=0A=
> >                              data->base + ASPEED_REG_ENGINE_CONTROL);=
=0A=
> > -             } else=0A=
> > -                     *val =3D readw(data->base + chan->address);=0A=
> > +             } else {=0A=
> > +                     *val =3D aspeed_adc_get_voltage_raw(data, chan);=
=0A=
> > +             }=0A=
> >               return IIO_VAL_INT;=0A=
> >=0A=
> >       case IIO_CHAN_INFO_OFFSET:=0A=
> > @@ -369,9 +422,106 @@ static int aspeed_adc_reg_access(struct iio_dev=
=0A=
> > *indio_dev,=0A=
> >       return 0;=0A=
> >  }=0A=
> >=0A=
> > +static int aspeed_adc_read_event_config(struct iio_dev *indio_dev,=0A=
> > +                                     const struct iio_chan_spec *chan,=
=0A=
> > +                                     enum iio_event_type type,=0A=
> > +                                     enum iio_event_direction dir)=0A=
> > +{=0A=
> > +     struct aspeed_adc_data *data =3D iio_priv(indio_dev);=0A=
> > +=0A=
> > +     switch (dir) {=0A=
> > +     case IIO_EV_DIR_RISING:=0A=
> > +             return data->upper_en[chan->channel];=0A=
> > +     case IIO_EV_DIR_FALLING:=0A=
> > +             return data->lower_en[chan->channel];=0A=
> > +     default:=0A=
> > +             return -EINVAL;=0A=
> > +     }=0A=
> > +}=0A=
> > +=0A=
> > +static int aspeed_adc_write_event_config(struct iio_dev *indio_dev,=0A=
> > +                                      const struct iio_chan_spec *chan=
,=0A=
> > +                                      enum iio_event_type type,=0A=
> > +                                      enum iio_event_direction dir,=0A=
> > +                                      int state)=0A=
> > +{=0A=
> > +     struct aspeed_adc_data *data =3D iio_priv(indio_dev);=0A=
> > +=0A=
> > +     switch (dir) {=0A=
> > +     case IIO_EV_DIR_RISING:=0A=
> > +             data->upper_en[chan->channel] =3D state ? 1 : 0;=0A=
> > +             break;=0A=
> > +     case IIO_EV_DIR_FALLING:=0A=
> > +             data->lower_en[chan->channel] =3D state ? 1 : 0;=0A=
> > +             break;=0A=
> > +     default:=0A=
> > +             return -EINVAL;=0A=
> > +     }=0A=
> > +=0A=
> > +     return 0;=0A=
> > +}=0A=
> > +=0A=
> > +static int aspeed_adc_write_event_value(struct iio_dev *indio_dev,=0A=
> > +                                     const struct iio_chan_spec *chan,=
=0A=
> > +                                     enum iio_event_type type,=0A=
> > +                                     enum iio_event_direction dir,=0A=
> > +                                     enum iio_event_info info, int val=
,=0A=
> > +                                     int val2)=0A=
> > +{=0A=
> > +     struct aspeed_adc_data *data =3D iio_priv(indio_dev);=0A=
> > +=0A=
> > +     if (info !=3D IIO_EV_INFO_VALUE)=0A=
> > +             return -EINVAL;=0A=
> > +=0A=
> > +     switch (dir) {=0A=
> > +     case IIO_EV_DIR_RISING:=0A=
> > +             if (val >=3D BIT(ASPEED_RESOLUTION_BITS))=0A=
> > +                     return -EINVAL;=0A=
> > +             data->upper_bound[chan->channel] =3D val;=0A=
> > +             break;=0A=
> > +     case IIO_EV_DIR_FALLING:=0A=
> > +             data->lower_bound[chan->channel] =3D val;=0A=
=0A=
> Shouldn't we require the same test against BIT(ASPEED_RESOLUTION_BITS) he=
re? Just because it should be low it doesn't mean that someone won't write =
a high value. If it is required then you could hoist the test in the IIO_EV=
_DIR_RISING case above the switch statement to cover both cases.=0A=
=0A=
Thanks, I will move the test above the switch statement.=0A=
=0A=
> > +             break;=0A=
> > +     default:=0A=
> > +             return -EINVAL;=0A=
> > +     }=0A=
> > +=0A=
> > +     return 0;=0A=
> > +}=0A=
> > +=0A=
> > +static int aspeed_adc_read_event_value(struct iio_dev *indio_dev,=0A=
> > +                                    const struct iio_chan_spec *chan,=
=0A=
> > +                                    enum iio_event_type type,=0A=
> > +                                    enum iio_event_direction dir,=0A=
> > +                                    enum iio_event_info info, int *val=
,=0A=
> > +                                    int *val2)=0A=
> > +{=0A=
> > +     struct aspeed_adc_data *data =3D iio_priv(indio_dev);=0A=
> > +=0A=
> > +     if (info !=3D IIO_EV_INFO_VALUE)=0A=
> > +             return -EINVAL;=0A=
> > +=0A=
> > +     switch (dir) {=0A=
> > +     case IIO_EV_DIR_RISING:=0A=
> > +             *val =3D data->upper_bound[chan->channel];=0A=
> > +             break;=0A=
> > +     case IIO_EV_DIR_FALLING:=0A=
> > +             *val =3D data->lower_bound[chan->channel];=0A=
> > +             break;=0A=
> > +     default:=0A=
> > +             return -EINVAL;=0A=
> > +     }=0A=
> > +=0A=
> > +     return IIO_VAL_INT;=0A=
> > +}=0A=
> > +=0A=
> >  static const struct iio_info aspeed_adc_iio_info =3D {=0A=
> >       .read_raw =3D aspeed_adc_read_raw,=0A=
> >       .write_raw =3D aspeed_adc_write_raw,=0A=
> > +     .read_event_config =3D &aspeed_adc_read_event_config,=0A=
> > +     .write_event_config =3D &aspeed_adc_write_event_config,=0A=
> > +     .read_event_value =3D &aspeed_adc_read_event_value,=0A=
> > +     .write_event_value =3D &aspeed_adc_write_event_value,=0A=
> >       .debugfs_reg_access =3D aspeed_adc_reg_access,=0A=
> >  };=0A=
> >=0A=
> > @@ -502,6 +652,30 @@ static int aspeed_adc_probe(struct platform_device=
 *pdev)=0A=
> >       if (IS_ERR(data->base))=0A=
> >               return PTR_ERR(data->base);=0A=
> >=0A=
> > +     data->upper_bound =3D devm_kzalloc(&pdev->dev,=0A=
> > +                                      sizeof(data->upper_bound) *=0A=
> > +                                              data->model_data->num_ch=
annels,=0A=
> > +                                      GFP_KERNEL);=0A=
> > +     if (!data->upper_bound)=0A=
> > +             return -ENOMEM;=0A=
> > +     data->upper_en =3D devm_kzalloc(&pdev->dev,=0A=
> > +                                   sizeof(data->upper_en) *=0A=
> > +                                           data->model_data->num_chann=
els,=0A=
> > +                                   GFP_KERNEL);=0A=
> > +     if (!data->upper_en)=0A=
> > +             return -ENOMEM;=0A=
> > +     data->lower_bound =3D devm_kzalloc(&pdev->dev,=0A=
> > +                                      sizeof(data->lower_bound) *=0A=
> > +                                              data->model_data->num_ch=
annels,=0A=
> > +                                      GFP_KERNEL);=0A=
> > +     if (!data->lower_bound)=0A=
> > +             return -ENOMEM;=0A=
> > +     data->lower_en =3D devm_kzalloc(&pdev->dev,=0A=
> > +                                   sizeof(data->lower_en) *=0A=
> > +                                           data->model_data->num_chann=
els,=0A=
> > +                                   GFP_KERNEL);=0A=
> > +     if (!data->lower_en)=0A=
> > +             return -ENOMEM;=0A=
=0A=
> See the commentary on the struct definition about potentially avoiding th=
ese extra dynamic allocations.=0A=
=0A=
> >       /* Register ADC clock prescaler with source specified by device t=
ree.=0A=
> > */=0A=
> >       spin_lock_init(&data->clk_lock);=0A=
> >       snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",=0A=
> > @@ -632,7 +806,14 @@ static int aspeed_adc_probe(struct platform_device=
=0A=
> > *pdev)=0A=
> >       adc_engine_control_reg_val |=3D ASPEED_ADC_CTRL_CHANNEL;=0A=
> >       writel(adc_engine_control_reg_val,=0A=
> >              data->base + ASPEED_REG_ENGINE_CONTROL);=0A=
> > -=0A=
> > +     adc_engine_control_reg_val =3D=0A=
> > +             FIELD_GET(ASPEED_ADC_CTRL_CHANNEL,=0A=
> > +                       readl(data->base + ASPEED_REG_ENGINE_CONTROL));=
=0A=
> > +     data->required_eoc_num =3D hweight_long(adc_engine_control_reg_va=
l);=0A=
> > +     if (data->model_data->require_extra_eoc &&=0A=
> > +         (adc_engine_control_reg_val &=0A=
> > +          BIT(data->model_data->num_channels - 1)))=0A=
> > +             data->required_eoc_num +=3D 12;=0A=
=0A=
> Why 12? Why add a value to the number of engines enabled? Have I misunder=
stood?=0A=
=0A=
This behavior is specified by the hardware. In our ADC, it requires 12 dumm=
y sampling=0A=
periods to switch the sampling channel from CH7 to CH0. Hence, this conditi=
on checks=0A=
the enable status of channel 7 to determine the necessary delay period for =
obtaining the=0A=
updated ADC values for each channel.=0A=
=0A=
Best Regards,=0A=
Billy Tsai=0A=
=0A=
