Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B50377CFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbjHOP5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbjHOP5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:57:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07701A6;
        Tue, 15 Aug 2023 08:57:02 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37FASWJu012164;
        Tue, 15 Aug 2023 10:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=/UYEttIaIU/O2icjqhNIMw1j+KJBTDtvtgRstZxPN
        HQ=; b=b6XwYyp9TgpHZWPqwHp1jvNjjgFLSaH6x/ka6daim+BfqFKd+KCpcGtV2
        BQAn8Dm9rGr6g6T94qeboogOosTg48zYiwtkmGZjN7LwEhqsntuDBNlz6hK1jXbl
        /iBOtL4bY573LpJeeL8Q3lIYp/yicWqubp4T/mWHrkIwlgSLYDoOg3I7K9PG55oR
        FmieZ9coEyxdhLdBDBiDjAnZcbmUSYE1i4oolMVkFxj2ToBQJQ3HYMhVyWIhf8ai
        aPVbeaEb83HdKg6S65Z85OhLeujwvrtAJ2foXgOalpW9ERpHBfg3pdiPVdIGkBBA
        Yc9L6qBhnpMI2GzIwiwFm/kHiGkCg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqurmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 10:56:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nm7/7Rc3ie953b3mqcTmoWNv+bboBunWSOs8fgSAfwdazChQ5oV88ntKwSw1lRgNsBXgrBI2KV40+4SI4jIX9zgtNUTZ6Hk/MCfgQ/USUGfrhLNFOnw0lqHAGuqRoQcJF1KTkZmtklgCQSOQoQ028kQkvA9o+K8ZkjeyHNs4Ulim25UHSImgTZWqr8x/Z6ChWJ/qrCb/nbQtnkgkyquwJ1aia0ct+QVBeks0BXHlum0THfqwEOJ5g06j/81Q1H6QJDoA4Jxo4x5SnHUWjToaFwMqGH/KZtMDp57lyj2ihGLSVLnx8t1VJIw5tzJ1pDxGSak5828rMOxLxva+dtdnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UYEttIaIU/O2icjqhNIMw1j+KJBTDtvtgRstZxPNHQ=;
 b=Vb6TPVXI4xEWdfk63haEfzLntscWCDkQdTp+R3yemD0MjF77it+30rYbcw2krmS0iF5gadiiyMInah/C/pKncx9CkXJ45C9EsJrtH6eTtaKdXdf80H7yVbp2I3UW9Yb06b02E3uyXHn5cqoRp9aO+2xu1iOW3YEdSjmGvahJx+0cbVwD2cQI3DdXQOfKJz6pt4zhck51f5xFaAUhgJocVjV5Z2qQuJ52IBK0x4G5jd7fCXrDwVu85210eynwoVcA7ELdah7Lk391q1vP7rYfKwkzBsqZSC1IqDx9X9KZJo2qwvMAi3KtkVgSUw5NuHeWuaSI6FiKxXadFQUhDqiBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UYEttIaIU/O2icjqhNIMw1j+KJBTDtvtgRstZxPNHQ=;
 b=Gjlz5ALfoh4XqNZk8eHNYluf3yFphuKcWoL8GU4bSPUhF4Br/7G0AEtDJaRhXYcjRTyYSJDm8Qp84g7j30eQCrTY2Buoilra8Puc8W6XM8MtAS5ToOSr3lOc2oyGiIOdB/0C4uzwTymCW7qKCtLuwVy72oiIyd79HuUvNUNQlbY=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by SN4PR19MB5440.namprd19.prod.outlook.com (2603:10b6:806:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:56:15 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:56:15 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, Joel Stanley <joel@jms.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Jacky Bai <ping.bai@nxp.com>,
        Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "patches@cirrus.com" <patches@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Thread-Topic: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Thread-Index: AQHZyvU2Ki66M1P/ZUe1/Vm0xGH7Cq/jDqoAgAh9Z4A=
Date:   Tue, 15 Aug 2023 15:56:14 +0000
Message-ID: <D4B53566-9F7D-46DA-8BAE-0572B9A8AA7A@cirrus.com>
References: <20230809191032.820271-1-james.ogletree@cirrus.com>
 <20230809191032.820271-3-james.ogletree@cirrus.com>
 <d1b9e063-54df-2dae-1487-c7c932fda145@linaro.org>
In-Reply-To: <d1b9e063-54df-2dae-1487-c7c932fda145@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|SN4PR19MB5440:EE_
x-ms-office365-filtering-correlation-id: d6a2d95d-66d3-4d42-b771-08db9da8277b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e9yJanam6pFDYtRUOo0INjkyX6f3S1zq50Tt4tFl4gmdNjyVLN7CBrXrkKZ32cSHTjCWIoBVWNp1utVZcG9cpA/YswH/kCAfW2lHjtKwvaQ1quIZMouHtevIJd3+DEGF4k8ubo7nZuLz6rc3mRVkUV6jI9oRK/Edq0k/I2oR6IPMryMBqZ+AAplxbxPcoQl9cCs+AMbOFvte37ktkbVodnM9zhZl0hxAfRd0e/uMXKfUly/bm3c8ZjKVzpU50e8DNp1nP+3ugHjGdKDWfs9t0vR0DhTT+wLOFE3xzUNo18v0EpBcshne6O9nu06bTVOOEIiVKjlMRv9BqmuBTzaaasitacMkwMeV+j81GdnOkY/lBk5hY6zobwFrN0L1vxOnrwOa/jiVWsqhGozN9jGnAiBUCmRT+HmMCIBxgVQlqZbDZelG3y1u7OSCFgvxra6p+lQ5qM2ge+I7RVOPRV6IaiOWDn0qCbjBaourFmZXP6tZx7zlkzTlNCZwRuoAW7nhoLbz4CBxxJV7xxUgKqpE7svNDyXdGt2gYMX4z6vB+w0BFxkR/N8GxglDg7b/7/DzG5epWLUtx1haY36XhymBjpTFZ0/MUFaMMaw+inQLgRX/nqbqL/csbxKBiT5gbLvEyEDOKeyGHBDFJd1MqW7fKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39850400004)(136003)(451199024)(1800799009)(186009)(86362001)(4326008)(41300700001)(6916009)(64756008)(38070700005)(2906002)(316002)(478600001)(71200400001)(5660300002)(2616005)(7416002)(38100700002)(33656002)(122000001)(83380400001)(66556008)(53546011)(8936002)(26005)(6506007)(8676002)(6512007)(6486002)(54906003)(76116006)(36756003)(66946007)(66446008)(66476007)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qGVIZw93dKIcts33YeUiejWE3tHZ6Oxr9NzZ1/jSH2MMzn1FrZAOzhYmSzSh?=
 =?us-ascii?Q?z7u0PvxU9BVARIosOH3wtPoXogGQcmDBEyZ2rsUAgCg3IEVBIEkzC3ywMD8a?=
 =?us-ascii?Q?+rUrnRRPSYGElii7zAJ6n6zlt/HohUC2Un9vSGKHVRsE816mKD7gZqclGdf1?=
 =?us-ascii?Q?ohOuTB+c2NFbHPWLGkU/pKUrrXn9HzcJSYfrvOdjgTObW+pCl40QpehfTRdc?=
 =?us-ascii?Q?N4KhBbxE0hQM0pkwy2GboVFx8icH3CDSmH7f2HgbsYjWXd6PryXpJZCfIc9W?=
 =?us-ascii?Q?c2ilwj8Mn046o13iA3ecQKsRqmq4sAqAUIVwHcBpEH12a0Est/ScCwhIyYkn?=
 =?us-ascii?Q?YzDwuIRirM+g2w7vBEPk9g+612tjcAv1es2OJuxv0s1eVrhdK9e/c/FdFzrB?=
 =?us-ascii?Q?zlLxEs7p2AGe9hGY2UMcsfqByVST3OH9FJy+hrN4J1SFp+q+df5qr+ozSJ8z?=
 =?us-ascii?Q?8R8OXe8+24VhnvjJi4U2Skj8eDe/KADGQlA6+n/8FanxCLybcSszr7UDj+Lb?=
 =?us-ascii?Q?Yo9isILSJo3fBbFi2d/pYbBvQa5HMsr7SzVYBnvh+aUIESEchpTkFH87Ks9f?=
 =?us-ascii?Q?a7I7c+/nYi85iipQXNj46N2YVpzgEEgTZsFgRHg5+CzwMR4U1nIvEeZXD8dR?=
 =?us-ascii?Q?p38+cgPEu7lW79kLo7ZGvWab9ReN6tDAc63D4/ExtccQ5N9A9KJ+QZLhHZ6m?=
 =?us-ascii?Q?JnWmAd2W0nMN+X56bnfJvVJ7eNsQzkEhcUENpujBD+EzWXB1dZqqrZTb/SJo?=
 =?us-ascii?Q?pLWbB3tFucm+hzGorcnxYBLG1pB+96WJlR99wMqay6OyWOEUn+LBPYS6yuW1?=
 =?us-ascii?Q?Vzs+GX8q0YhngA3GXdTnDCH2wbPHcV756aVdj9wvh+mDnaC0o4H3hSd2FwUZ?=
 =?us-ascii?Q?4YkcyeNg2IgpTTxwkdErhqiopr9dAk7WwGbF8yb+fMrMBuusEXL7YCST9m2d?=
 =?us-ascii?Q?ct5iLONgt1197T2QTLSR50Iklm6y4bGvzxt3boA9V6dS3teV7C7rAILHw0v7?=
 =?us-ascii?Q?1nxRBR/uRsYtUML8LWgDvwPxxD5Bkb71/6SzkbIGGjJ90E7n+SMcdBMdAAS/?=
 =?us-ascii?Q?qI97AH4ga618L5uyuWEDCy+tFB4nPq0xC2t/Yd6LDSvCUTClr1/9VaAyCO/p?=
 =?us-ascii?Q?nZUgM4WkUDI1xaZOraYyoR3R1d//QUINAvwchQGRPfUoiDR8Y9DVcveSYqjY?=
 =?us-ascii?Q?3tciovQpX9wvchRKVBCDfx+KA6QOn157wklFYKovVm3M3YI4M3a9EodbcHDl?=
 =?us-ascii?Q?wZ5aksyrySxz3yj8Lfcaz81X+vOyB7ZQh/fxI2LeyDiAng9xpci3eHHZ5NNL?=
 =?us-ascii?Q?eGo72jYEtwrspoS60iWcw5HSU1rtA2lHxuS9e/fauArb5L7Ui6A5Ps8feDG9?=
 =?us-ascii?Q?jyC9zkM12qsCvxzAshnS2hJCnTV8zd7Coo2zIO+YZTkgUrzDkJncJaZ8OtuA?=
 =?us-ascii?Q?hP4Eu1acOaVLL0k3CGzeGcYjjHM6Djb90hls7ZK5x5qDzoR2Mqr95TCl4Pw/?=
 =?us-ascii?Q?Qc2mKQRKXbYfJ+s63plKrUNCXWCeC8B9YoTdImFLwuLuzmI2xl0RFMjjo7fF?=
 =?us-ascii?Q?JQgddGYX2+CSwely6JRTc/n0oA7VyFWY74qatQqcwliBibSnNEn4xBWp7ND/?=
 =?us-ascii?Q?jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C495F279D63CA74F818BD6F4D47F4F59@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a2d95d-66d3-4d42-b771-08db9da8277b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 15:56:14.5075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwoUKEpHnGVTf1jd+FkjoVq1PhJIL0y/rp/siITd8zakUb/yk8yjFCVutzGEKUqOoyaEzjWGu0ogOcm49oEOUZ0ir658nKko/RAdiRMBmBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB5440
X-Proofpoint-ORIG-GUID: j_4ke46KbF93qWMHXMz-bosJYIt_MinE
X-Proofpoint-GUID: j_4ke46KbF93qWMHXMz-bosJYIt_MinE
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 10, 2023, at 1:17 AM, Krzysztof Kozlowski <krzysztof.kozlowski@lin=
aro.org> wrote:
>=20
> On 09/08/2023 21:10, James Ogletree wrote:
>=20
>> +
>> +static int cs40l50_cs_dsp_init(struct cs40l50_private *cs40l50)
>> +{
>> + cs40l50->dsp.num =3D 1;
>> + cs40l50->dsp.type =3D WMFW_HALO;
>> + cs40l50->dsp.dev =3D cs40l50->dev;
>> + cs40l50->dsp.regmap =3D cs40l50->regmap;
>> + cs40l50->dsp.base =3D CS40L50_DSP1_CORE_BASE;
>> + cs40l50->dsp.base_sysinfo =3D CS40L50_DSP1_SYS_INFO_ID;
>> + cs40l50->dsp.mem =3D cs40l50_dsp_regions;
>> + cs40l50->dsp.num_mems =3D ARRAY_SIZE(cs40l50_dsp_regions);
>> + cs40l50->dsp.lock_regions =3D 0xFFFFFFFF;
>> + cs40l50->dsp.no_core_startstop =3D true;
>> + cs40l50->dsp.client_ops =3D &cs40l50_cs_dsp_client_ops;
>> +
>> + return cs_dsp_halo_init(&cs40l50->dsp);
>> +}
>> +
>> +int cs40l50_probe(struct cs40l50_private *cs40l50)
>> +{
>> + int error, i, irq;
>> + u32 val;
>> +
>> + mutex_init(&cs40l50->lock);
>> +
>> + error =3D devm_regulator_bulk_get(cs40l50->dev, ARRAY_SIZE(cs40l50_sup=
plies),
>> + cs40l50_supplies);
>> + if (error)
>> + return dev_err_probe(cs40l50->dev, error, "Failed to request supplies\=
n");
>> +
>> + error =3D regulator_bulk_enable(ARRAY_SIZE(cs40l50_supplies), cs40l50_=
supplies);
>> + if (error)
>> + return dev_err_probe(cs40l50->dev, error, "Failed to enable supplies\n=
");
>> +
>> + cs40l50->reset_gpio =3D devm_gpiod_get_optional(cs40l50->dev, "reset",=
 GPIOD_OUT_HIGH);
>=20
> None of the lines above or below seem to be wrapped according to Linux
> coding style (80).

This patch abides by the 100-column line length limit which checkpatch.pl e=
nforces.
However, I can see how some of the lines might be less jarring to the eyes =
if wrapped.
That will be addressed in V4.

>=20
>> + if (IS_ERR(cs40l50->reset_gpio)) {
>> + error =3D PTR_ERR(cs40l50->reset_gpio);
>> + goto err;
>=20
> Why do you disable IRQ now?
>=20
> I asked to test this. Your entire cleanup path is:
> 1. not tested.
> 2. buggy.
> 3. done differently than Linux style. Use proper cleanup calls and
> multiple goto labels.

Disabling IRQ there is a mistake. The probe error path will be tightened up=
 and made
to utilize multiple goto labels instead in V4.

Regards,
James Ogletree

