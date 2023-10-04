Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348267B86B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjJDRiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjJDRiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:38:20 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5586A9E;
        Wed,  4 Oct 2023 10:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCf7KqA3Plqwi35HcDP7+WhjLG7BSS6yACJPI9Sjcc7Bdb3DAeWxWrtIeUvZim0QUo1+BmgOVw2keF4GT+xTw2LuFUYAU0S1gmyaELO++0n0nfqcjV48awz+MZjEcY0xSj1LzlyxgM93w7jIZspiKYgr/k8X5kIM014MfStUbjNitxh1mX/aDmJ9ocYJV8xmFKyKHpJROCfr2rh1qqM6XHDxY5IK/Am/OcotOKbba+2ZU+8XLihxmJZ+Xte+cAXWlJNbpP6cLpehZVAwem2pfzTkO6n54+/muDs55KfzBDieaPX54uexOIEcNKvl4wxb8YzZUamlw70b2svm5DoR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1zKpbOMgTFjrShxExyPxn77pL6ED+iD6dck9i/WKEs=;
 b=DsqoE3XpoXOWh00UD1j/yW0KMyROFMHlKqzldXHSzC1JbsQPM9cq509qlHMrWuWS0Ggb7ceg/9Ss9KhtRM/VZ+pUrP+Vs9VT8ZZfMM3aVBRQJy5uZWroE90Y0UJUCkTTftLT02V2uT+EsJqOrL39KaFN6ashsxQBr8MrArPic3T9tYkTYauFEz6CVBrFYobIIPgywv0aINknqOLF9+v0VI4qFzMal0BomkJus6YES0KsjwfDGRDZj5ZAsK1gyQczOLwnkgYA98ypJBO3+J4MUTl1gAMsOnE8fu6twPNWSMihKXprNmkqmhSjoKRHRb0ILyHydQtu5MJVyxURYpOSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1zKpbOMgTFjrShxExyPxn77pL6ED+iD6dck9i/WKEs=;
 b=i8wlMLpUI3eyOBDl6k6R/4FvtTciCTYOc7qb1bO4zgEsgP1H09cmk6I19kT32RtUPwaGctkdwERNkF+2Y1PTLOAujyrhitUPJvVzK7v7sh5uczVBt/hBtV/ZuN6gUBbVzCNRJyTNhb+cXX/6uOVYk29dObCssOe/PdfRjpwh9Ae2hUzaQR9fWPgVybSWhf7Du6rbpCu9RnqHKiIk1FR0Hxd0jn3yaIplRgGT6hX6vvvbCBVQW6o0rC9GqgOMIvjPrQjACsrdGuHSFEOCPVO8KecLWZEwePmdih7xrv2MVyKGu4RlsuhGTXPdHjUZcwWZmV96VB/4KH6NW44N/JBi0g==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 17:38:10 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::956c:2f06:be93:fc3e%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 17:38:10 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Potin.Lai@quantatw.com" <Potin.Lai@quantatw.com>,
        "patrickw3@meta.com" <patrickw3@meta.com>
Subject: Re: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Thread-Topic: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
Thread-Index: AQHZ74jrjlOSMsUvo0yNgHQbGiIz5LAzm9aAgAIo4C+AAITzAIADoo/0
Date:   Wed, 4 Oct 2023 17:38:10 +0000
Message-ID: <SG2PR06MB336557EDAAE2950D192E40838BCBA@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
        <20230930174501.039095da@jic23-huawei>
        <SG2PR06MB3365E89B1543B770AC2EE7E78BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
 <20231002103940.00001dbd@Huawei.com>
In-Reply-To: <20231002103940.00001dbd@Huawei.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|SI2PR06MB4140:EE_
x-ms-office365-filtering-correlation-id: 1ec2da6f-2582-4f83-f15a-08dbc500ad76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmSLaDFemZhU22UQ2RDbcVKLj8lbgHi+/Dt+QCre0PTXelNg4BDsqwfXfmf+A9Qc2liNL7lL7ynUwDvYndOnL894IOeinRlvrLpLTPB9vHlV1BrnbIAJnY90LpZfsF6Ap4I21aYz66FKS7yphCFGAjWzTnnYDmf5ef9LyNWOhHt4qCBpyHTkh35CCJgpq5O47zjZi2YGweu01KwT86x90KjHdyXRtejNSiMXEJHY8eljEHn9aXWR2VrMoZkJY61vqnymEPnt1t1xDNZyXVW3zAObg2QnOAKaTtxYvrZ+xjDNpw6kQaxo5UjCwaq7czWDjlGpMesmduqN5PbreGdM9IkNTiMQF1zXxeW07L0QjnOwPU8vgvMV12vAKMRoNlPiyREbmbikMmJAFGMKMa+2YSjvJHc05Jze50TXr5p+zBlbqG9p3xAWYMuA1H8V2U2F/MI+AUOdLMjwGmi/0rGahA5Id4ZZ3wIRD0P4I8o2tDdrn+EjrhbvGZGWAhtjjrCVfFFqkNlw+weKN+VaaNwsjZOZ3Qb7agaQXcbbCKJKAJSXBEfl7j4GuGXBh3n1Xv+Uxc/9a9ACRqDw0YPTQvpq56Nn3xdeJil6WwSOuSjUGpu8+UcpYqg6BLZ0jUi2scNp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(71200400001)(478600001)(7696005)(6506007)(91956017)(66556008)(66899024)(66476007)(7416002)(55016003)(9686003)(2906002)(33656002)(6916009)(54906003)(66446008)(64756008)(38100700002)(86362001)(76116006)(66946007)(8676002)(5660300002)(26005)(41300700001)(83380400001)(8936002)(316002)(38070700005)(4326008)(52536014)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WzbdX8Z/6KtBQTngWwDHhwXKcs0l5ZGGss8HyWoscFHbkTeqg1WVencMnz?=
 =?iso-8859-1?Q?pNk9aPYIzXEmkSNIIzIey+x/EDM2s2iyw+a1ltJ8B0BDxi9vnMkCw22Wx+?=
 =?iso-8859-1?Q?U0KZ8RNFTwfdGXGEApWCmAuKntnuLKVlxLzOo0+cAlsSL/FwdWO2j4QvAd?=
 =?iso-8859-1?Q?vR0L4yTYAH1QnAJS4/g4wRZHSpvOFztzU9S85xox1qgtKue5WWTTjBgHhY?=
 =?iso-8859-1?Q?CnDMEF65z7wF8JWS1N+SN0fqg9zK/xMs9+4pDaRBfg58VeXYUoqOldf37J?=
 =?iso-8859-1?Q?CaNwBs8uQLlkoqDabi6e+iwN+pcCLgXaSj1ZP26bafGcaD0f76CoSN6euy?=
 =?iso-8859-1?Q?Nktlmppimt1RR6uFM/gOn3QGve0veAzbNCaZ23RK2IYfh7tI8l8o43kCLM?=
 =?iso-8859-1?Q?AuwPyz+zie6aqxtNAK5Aa7ZBLlu1e7P2r5KixvMQwQU7QCO49eOXQ2C9A2?=
 =?iso-8859-1?Q?INZdn8ngB3uYZoz/26EK6N4SZmaSKK9w12DL/3/qWNRSPKmtgAobacS9EZ?=
 =?iso-8859-1?Q?wyJp64Unfts5UhTnbt3WH2jFBiply5CqROR5aHzDhEpde0h5/7KBgAqyTu?=
 =?iso-8859-1?Q?X6rGMoQLt/bItD5DwJ2dgJowUspv/Oo814FwZoBfnz9K9f4iPAscRo4C64?=
 =?iso-8859-1?Q?jzHTI7CLMY3/XIH59jrtVb94oBNQfKCaEnynRE2i3EYpWmS5bhERL/qWzt?=
 =?iso-8859-1?Q?9tO34n8yJtoc9uIxhmJd8z3LxpG384i0KtErgbVPqEkjYnmrWADlMUihWc?=
 =?iso-8859-1?Q?+h4doQj3QaQ2eQIePX1eZW6qvVB66j+mJIDqEpnw8a5/W6MgGPjCpi1LVy?=
 =?iso-8859-1?Q?91KQ4fUXvN0efVDFFcbCwWME5stKnruJ2nkRCqQPBsQPyB4gutJR2TEwor?=
 =?iso-8859-1?Q?gOd9ogCUWMeClijTBmnyKXYi8T+MevjsAUSWKpNSZ1bsQXFR87ikvxR6m8?=
 =?iso-8859-1?Q?BkMXY1nleGd9L4eFUmbcVa69JnoPwo6Cz1TNJxz8A7/jnlzOym+nBiZkqC?=
 =?iso-8859-1?Q?b2cV9EvOmSvSFexnrz+I4F1xgYIrFpGBKJrDgGu4a8pps/brnL1rbYPI4Y?=
 =?iso-8859-1?Q?Dm4i2nn/JGk/AeUK2n3ullgbmIT92RXrcBpdEbg8ziSPgYnt0HmpbEYCZS?=
 =?iso-8859-1?Q?8vpz50yXfS55sezlPK0pOpVpafNrB9ij49LobeyIUZJ3o1eO8pahNN0oHR?=
 =?iso-8859-1?Q?F+VRKEciMgTI5TUWzM2IQ2OJm22dJJpT87eF/0Gt9tDJphGsVSWVhXBwA3?=
 =?iso-8859-1?Q?uMv/79saPojoFgFLev9KXux27U65WtXcOwAj5DgfWIP1bbhU+US/9ejlqa?=
 =?iso-8859-1?Q?9FdOgU/nyxVDFnNLLMPlyGJW0pfdZx+VTCf5i8yHoHG8riY6qunjJkdP4x?=
 =?iso-8859-1?Q?jLt5ocgoXjn/mMOcd3Z+kjBvt68bFwNCTxhSktDtkDvsV64VN9HB+ENJ4s?=
 =?iso-8859-1?Q?YT+vAh2pokRHGyyUk4Qb76AyDGAqEZ0vqtF6SmhDKCvJStKOpAXLVWGQGm?=
 =?iso-8859-1?Q?U/3eSLT+Aj2KPv8udROYO3mcICstlyXmI4I05YC9TBa25mGCTmH1qaYvwR?=
 =?iso-8859-1?Q?ISQpdbJGBROHwhyIsWL55+ewC+sMKas225ePPtZRxHVI6ToDnt73LX8c1K?=
 =?iso-8859-1?Q?Lx772JZ6Uv1iLIZR4lF4hHrJIcsR5U0RFK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec2da6f-2582-4f83-f15a-08dbc500ad76
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 17:38:10.3549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/i7Xw3s1fzrnnkVa9IvBPHbi4pQ2T7m/es7KsaVpoZQRm524Z9lxkPEmkWjpWMobA4fnjOxM+su+Hs/1j9MajpxupvkpWCu8fMPeunF+hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4140
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
> > > > Create event sysfs for applying the deglitch condition. When=0A=
> > > > in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set t=
o true,=0A=
> > > > the driver will use the in_voltageY_thresh_rising_value and=0A=
> > > > in_voltageY_thresh_falling_value as threshold values. If the ADC va=
lue=0A=
> > > > falls outside this threshold, the driver will wait for the ADC samp=
ling=0A=
> > > > period and perform an additional read once to achieve the deglitchi=
ng=0A=
> > > > purpose.=0A=
> > > >=0A=
> > > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>=0A=
> >=0A=
> > > Hi Billy=0A=
> >=0A=
> > > This is pushing the meaning of the events interface too far.=0A=
> > > You can't use it to hide a value you don't like from userspace.=0A=
> >=0A=
> > > If you can explain what the condition is that you are seeing=0A=
> > > and what you need to prevent happening if it is seen that would help=
=0A=
> > > us figure out if there is another way to do this.=0A=
> >=0A=
> > > Jonathan=0A=
> >=0A=
> > Hi Jonathan,=0A=
> >=0A=
> > Currently, we are experiencing some voltage glitches while reading from=
 our=0A=
> > controller, but we do not wish to report these false alarms to the user=
 space.=0A=
> > Instead, we want to retry the operation as soon as possible. This is wh=
y the=0A=
> > driver requires this patch to handle retries internally, rather than re=
lying on user=0A=
> > space which could introduce unpredictable timing for retrying the readi=
ng process.=0A=
> > This software approach aims to minimize the possibility of false alarms=
 as much as possible.=0A=
=0A=
> Thanks for the extra detail. Perhaps share more of that in the cover lett=
er for v2.=0A=
=0A=
Okay, I will incorporate more details into my commit message for v2.=0A=
=0A=
> >=0A=
> > If you have any suggestions or recommendations regarding this situation=
, please feel free to=0A=
> > share them with me.=0A=
=0A=
> Why do you need userspace control for the thresholds?=0A=
> Perhaps this is something that belongs in DT for a particular board desig=
n?=0A=
=0A=
If the input voltage remains constant, these settings can be incorporated i=
nto the DTS properties for configuring the threshold. However, if the input=
 voltage is subject to change, adding user-space control may offer more fle=
xibility.=0A=
=0A=
Thanks=
