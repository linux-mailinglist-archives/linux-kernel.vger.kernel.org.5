Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACA87D77AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJYWQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYWQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:16:31 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3693137;
        Wed, 25 Oct 2023 15:16:28 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PKqM8C021237;
        Wed, 25 Oct 2023 22:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=GVSaSWkIYr3yPWFoqG81IZra53YBoc01vqxMSSgjtas=;
 b=EoYLw1X/DWBlw7d9vOjl0ufOvl9PmVNosIvbDbDfGR3CMVgiakFQ1MG0BEDV/PmZRPru
 okxALq5uIq5CvYEKEGh70j+bZuIQxrLyC/wko6/7KqY2ML8NI4npxpR+QH6en376upS1
 uS+DHpzX+GIo5tb62M7EFkANZ72Ug9BBBsic3NNyl0daPmwq6Bm6FWxouwz5LA0Sq0JD
 VDiBqZmC/AVRrpnh1ELYxVbi0uZBPnpkyQD64bouOxmE2GMeBHUtPJsIlTmxzZg4W8jf
 rJptCqtypCg/ZW0s/4M3WeCr7Qj89CGDCNuGtM/IVRaUoU6FZdCfeye7dx1JukWkk8n5 4g== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3tyaeegkyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 22:16:16 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 0D516131AC;
        Wed, 25 Oct 2023 22:16:15 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 25 Oct 2023 10:14:53 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 25 Oct 2023 10:14:53 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 25 Oct 2023 10:14:52 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c62SHFjdBw9JPs5dwAYjpgyKVFzwH0zJB8Gd+yeIz4xkuBB59Ph9s3wA5Ibw+CE3aOb0UTXfY/rjR/JKCz2OpQWgSAw+0VARiZyQXqC+Xpm12izllqjgzD0yL3FaqkB8uHkNmK1SoKLCrnp6rl9elnwYIKkzHqpZxOhqVPk613CpIVtR2BzyoCk5HDXGbpQS0ny3cdmRFNSQNn4K0udwurTkqMSrmu+kGGaC3uZTY0Dt+8lta3eAw6Pl9gnXImDmfIbtcJG42Zg+8e46z+N0zh+EbRShuTs85QX4HgAUbJj+9Lshv/y4XomoiR2GbbxzT7D0TDuXg6ndS5jzpbD2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVSaSWkIYr3yPWFoqG81IZra53YBoc01vqxMSSgjtas=;
 b=QySRxLm+Rx7J+lb98ym310Y/l/J2DepoGm2t206Vk1WtpWC3FLm9LfsOIxP8POWghes/6U1mwrsi0ii3p9p4W2Q4zuS9IDlC8BSH52mORVPQ1FVqhyNK9GamX822VYJtez43GUicSRiFak6JYf27MVJJ8PtaaL+Ed5kT+DMmSx9T++mBpiFctD9N9MesbcFfp3moqbTnwX1cCmR5ystwi9ETandKdGuU0lC9x5j0V+hy+hHtDgA0nClrX7NRL2sWl+3QZED5EfvoUqbTm05UVUwsWQFzOOVNKoh1pH/PdXAYX7sD0a1FAA+c+5GCwZrx/5gMqjrfC8iw44rA488Vug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::14)
 by PH0PR84MB1525.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 22:14:50 +0000
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8e47:3053:dae:5c17]) by SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8e47:3053:dae:5c17%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 22:14:49 +0000
From:   "Yu, Richard" <richard.yu@hpe.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB HUB
 support
Thread-Topic: [PATCH v2 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB HUB
 support
Thread-Index: AQHZ4c+k4sD8rkOE10yCm8eHVE9HNrA2kkCAgBy9EGA=
Date:   Wed, 25 Oct 2023 22:14:49 +0000
Message-ID: <SJ0PR84MB20855ADDEE46D6A437D8E7C18DDEA@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230907210601.25284-1-richard.yu@hpe.com>
 <20230907210601.25284-3-richard.yu@hpe.com>
 <2023100212-hyperlink-prolonged-3e18@gregkh>
In-Reply-To: <2023100212-hyperlink-prolonged-3e18@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2085:EE_|PH0PR84MB1525:EE_
x-ms-office365-filtering-correlation-id: d6236060-d9b4-4956-959a-08dbd5a7ce23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6PE5+XmtgUiXQB6nIHxbjEV1PmZ/66vH6IOgEgK9m1ME63dVWwtaWUZ4DoP3qqYcm0skEbTnN6MN/NT22yK37yiuWktz8yGiltJVJVShjAgFDQu7rQB/mDQLEZG9NQqKiXzFvbxITOvmIGZetFQs3QmMzuc+tJmvRdctPQjVYEA/RNQo6bWKYpEreaFa0FCSTyFVdem6Z50Qfmd/tD39GyPMiz2YiKkdnO1v5jkMaUreBUhyffe9N4Mso6J97vkHrkHWieab9/K1TXXOTWNXQGGLAYQzwRuRsaNXzf992BXmNWABK3WcZhFcOwZHk4pBFflZGJP1F4G8T+R1iUILqkdHC4csFqmgtQ95vNm33GLXFAdQ35DrZbDmUP7JpOn9ReDE5/JHTPZbAIcEcrO5PtRYO8IAjTQNhtMPoZIg2wgW/7GShJAoKA3z6euTmIFYrLf1hwtPOA//mEjKFW8aNaTRdF083V2W48sJdvSi3OqulMoGUmuAjIEcLVQ0W2LJeIilKjJJ426c3r/wfIqUdbC8Z4NW8WTCksG4Ey29Rk3praEcxHguaxLpg6BEnbJfxsgKFvwxRQC8DC59p9brK+CmDuvFm+AkcpRTHThVkUG5TXlWYFBeYDEHtRGJcoD5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(55016003)(66476007)(2906002)(86362001)(38100700002)(41300700001)(64756008)(122000001)(6916009)(66556008)(54906003)(66446008)(76116006)(71200400001)(478600001)(7696005)(6506007)(316002)(66946007)(55236004)(9686003)(83380400001)(82960400001)(5660300002)(52536014)(33656002)(4326008)(8676002)(8936002)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rPrzuhrclG0WC82JP03wPQ8bWG+RjIERlUYomrCWsYHVczAFChnlZu9QO7Jl?=
 =?us-ascii?Q?O5IqYnMaiqtqn2LA4OkJ30DI2brOX6UHyRCRy21cccosD17vgKc7xGAQMiet?=
 =?us-ascii?Q?HTSiaVqjWTS6aoMG71fPC5UpLXJlbeC/IKxhF2GOCOpxKkx0DmOPYqzW0BOr?=
 =?us-ascii?Q?Ku4DndslJh3ih2i74PuPtJAKSXykfIVvxpKPbX+J1CDkth1GKMOrUgrqCwNc?=
 =?us-ascii?Q?5EsUSqttXFgYvZdcyLIxpTHSC6iuLuJ/tBjkGRQdNfrJnzigoHiS2OACYiAz?=
 =?us-ascii?Q?0iWM/rOSHjKvHUzlqepxmpOFwT3cz+uJisF44q5e5gpfuB8OHOeMB0vKFxaw?=
 =?us-ascii?Q?C2ltJdqmwZBJQElEivu+k/tFuPltljS0/XeH+JbOkWjvL+H0C8/GRj2GE7Fk?=
 =?us-ascii?Q?34IM4EHf/8kvDmd7jUsquBQE4i0JOvY2LzaUZK/I82yCaqV9NXY8jecrC+P9?=
 =?us-ascii?Q?OE4bA3jJe8lkQG0t2hB8+lV1EAxgIkuQzA6xX9ijd9bq/Q1a9sMaKv9FdKu3?=
 =?us-ascii?Q?kLsDKhAEJv5m4QKj3zY65adG1SjQzg7blX6cFgrtfmaVAJ3CRqDWPrzvWW57?=
 =?us-ascii?Q?pF43q4lLg/HaebvZS7qQffxqPjD6c2V8lSaCBzdRL90A2qbh8FPnXprxhHyi?=
 =?us-ascii?Q?DfoK/utEoPtSAbtLca+dXmmUt2ltRt6p1FJ3SAKND4qz0llGg0O0FMxQU43X?=
 =?us-ascii?Q?N7oRCnpXJzQccc6KVB9SI7mG1Yx7K5vUb4CXtJZWxs7SdRxfexmZMexfYG/+?=
 =?us-ascii?Q?/IQItvVUWlfdExSTaXFF4zNgHeQPbW8tbwrVn1MyK3YuCmCi/HqDbceaUM5o?=
 =?us-ascii?Q?DNMPwbAXTiMMnt5i1G6Yz948E0RSMccTpWqn4e0s4fpa6yjSCHGBJX/vPIR2?=
 =?us-ascii?Q?JTP4rByT1Sgf0ktgANB0yH0XrroJryQpiJhR9Hnj0hvolqNBAZk9HW/qvIDt?=
 =?us-ascii?Q?uEJF4RkTzyLYQ7ITfH0Ut67lg8mTsnhmFgu1YtHUqUMpByqJRvekNLgrf33k?=
 =?us-ascii?Q?/xtSb6qxfam0idtQXKyky3iJ4zmyroO8Ddo3McaSy48o+8NxrIpryROZ/XIu?=
 =?us-ascii?Q?ebuxm3uWIGlFD8uGRpL/vcFHnTAKcGYO/Wat8LMM1JukspRJVgOgxBb3jQms?=
 =?us-ascii?Q?agDzTGgb9KD+gZUg9dLY5W5xiGKZgM71Xadcw3xjsy5MXlbsHMGTU8F7B4lo?=
 =?us-ascii?Q?CjBjFF1Bqb9DeIX78CdHBmX+jzWyfctZHXgZHAC7ab+ASTxfBOYvPN6yuDyM?=
 =?us-ascii?Q?jMlLpqDDv/HTLq/q/rdl0Wc2bcd5Q7qKYrBJEh0bhhwBvqfG4nczKpyKMFC3?=
 =?us-ascii?Q?Yyz1IO7CVe9RU9a/CNn974G3MKZn64YfpW5MMN9sFWq7XIZ2Evh11sIBAN8a?=
 =?us-ascii?Q?6Z8Vq1aaJr7DuoyKNAxfpzlQJJqCb9FnF4DzYpAOq1GvCwP+GOOvl1M0HCKK?=
 =?us-ascii?Q?6iL8X1NsfEEEpIjoH1Vi+wF7tofASo8OiR/At9C4LWhdZyMm3wIOtaFFbu0N?=
 =?us-ascii?Q?+5G+6HdRWe3HmgqHamtrDh33G+rAz+OblkEk7FriObT8WJ0dkctCSfZZ0Mow?=
 =?us-ascii?Q?H2rx9d2LfNfwRFNcvAc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d6236060-d9b4-4956-959a-08dbd5a7ce23
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 22:14:49.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InWeq3+GO0i59xsAy2n+hlL/1rMJyYbHVAIoimbxt7VwzKbwWGDV+n1EBZqCvbCfOwYxENVrU5M88kizU3xEFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1525
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: ZT_v14FLbCuOAQdemG7tZdkW3fwX0CjC
X-Proofpoint-GUID: ZT_v14FLbCuOAQdemG7tZdkW3fwX0CjC
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_12,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=558 phishscore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250191
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg KH,

Thank you very much for the feedback and sorry for the late respond.

On Thu, Sep 07, 2023 at 04:06:00PM -0500, richard.yu@hpe.com wrote:
>> +struct gxp_udc_drvdata {
>> +	void __iomem *base;
>> +	struct platform_device *pdev;
>> +	struct regmap *udcg_map;
>> +	struct gxp_udc_ep ep[GXP_UDC_MAX_NUM_EP];
>> +
>> +	int irq;
>> +
>> +	/* sysfs enclosure for the gadget gunk */
>> +	struct device *port_dev;

> A "raw" struct device?  That's not ok.  It's also going to break things, =
how was this tested?  What does it look like in sysfs with this device?

I am using aspeed-vhub as example to write this gxp-hub driver. My struct g=
xp_udc_drvdata{}
Is similar to the struct ast_vhub_dev{} in drivers/usb/gadget/udc/aspeed-vh=
ub/vhub.h
The "struct device *port_dev;" is for the child device which is attached to=
 the hub device.

I tested this driver by modifying the create_usbhid.sh and ikvm_input.hpp i=
n the obmc-ikvm.
The modification is just changing the dev_name to be "80400800.usb-hub". I =
have made sure=20
that the KVM is working. (The virtual keyboard and virtual mouse are workin=
g).

The devices will be shown as=20
./sys/devices/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-h=
ub:p1
./sys/devices/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-h=
ub:p2
./sys/devices/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-h=
ub:p3
./sys/devices/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-h=
ub:p4

./sys/bus/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-hub:p=
1
./sys/bus/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-hub:p=
2
./sys/bus/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-hub:p=
3
./sys/bus/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-hub:p=
4


>> +	/*
>> +	 * The UDC core really needs us to have separate and uniquely
>> +	 * named "parent" devices for each port so we create a sub device
>> +	 * here for that purpose
>> +	 */
>> +	drvdata->port_dev =3D kzalloc(sizeof(*drvdata->port_dev), GFP_KERNEL);
>> +	if (!drvdata->port_dev) {
>> +		rc =3D -ENOMEM;
>> +		goto fail_alloc;
>> +	}
>> +	device_initialize(drvdata->port_dev);
>> +	drvdata->port_dev->release =3D gxp_udc_dev_release;
>> +	drvdata->port_dev->parent =3D parent;
>> +	dev_set_name(drvdata->port_dev, "%s:p%d", dev_name(parent), idx +=20
>> +1);
>> +
>> +	/* DMA setting */
>> +	drvdata->port_dev->dma_mask =3D parent->dma_mask;
>> +	drvdata->port_dev->coherent_dma_mask =3D parent->coherent_dma_mask;
>> +	drvdata->port_dev->bus_dma_limit =3D parent->bus_dma_limit;
>> +	drvdata->port_dev->dma_range_map =3D parent->dma_range_map;
>> +	drvdata->port_dev->dma_parms =3D parent->dma_parms;
>> +	drvdata->port_dev->dma_pools =3D parent->dma_pools;
>> +
>> +	rc =3D device_add(drvdata->port_dev);

> So you createad a "raw" device that does not belong to any bus or type an=
d add it to sysfs?=20
>  Why?  Shouldn't it be a "virtual" device if you really want/need one?

I am just following the aspeed-vhub driver here. I thought I have to build =
the following entries:
./sys/bus/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-hub:p=
1
./sys/bus/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-hub:p=
2
./sys/bus/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-hub:p=
3
./sys/bus/platform/devices/ahb@80000000/80400800.usb-hub/80400800.usb-hub:p=
4

In order for the ikvm application to get access the virtual devices.

>> +	if (rc)
>> +		goto fail_add;
>> +
>> +	/* Populate gadget */
>> +	gxp_udc_init(drvdata);
>> +
>> +	rc =3D usb_add_gadget_udc(drvdata->port_dev, &drvdata->gadget);
>> +	if (rc !=3D 0) {
>> +		dev_err(drvdata->port_dev, "add gadget failed\n");
>> +		goto fail_udc;
>> +	}
>> +	rc =3D devm_request_irq(drvdata->port_dev,
>> +			      drvdata->irq,
>> +			      gxp_udc_irq,
>> +			      IRQF_SHARED,
>> +			      gxp_udc_name[drvdata->vdevnum],
>> +			      drvdata);

> devm_request_irq() is _very_ tricky, are you _SURE_ you got it right here=
?  Why do you need to use it?

I thought this is to install my device interrupt handler. Again, I just fol=
lowed the aspeed-vhub driver. The=20
Aspeed-vhub driver is doing it at ast_vhub_probe() core.c file.

In previous review, Mr. Kolowski pointed out that this is very tricky using=
 "IRQF_SHARED". I tried all the=20
Available flag and none are working for me, except "IRQF_SHARED". I also co=
nfirmed that the Aspeed-vhub=20
driver is also using "IRQF_SHARED".


>> +	if (rc < 0) {
>> +		dev_err(drvdata->port_dev, "irq request failed\n");
>> +		goto fail_udc;
>> +	}
>> +
>> +	return 0;
>> +
>> +	/* ran code to simulate these three error exit, no double free */

> What does this comment mean?

I will remove this comment. I put it in there because it was pointed out th=
ere is potential double free in
the previous review. I ran through the error exit test cases and did not se=
e any problem.

>> +fail_udc:
>> +	device_del(drvdata->port_dev);
>> +fail_add:
>> +	put_device(drvdata->port_dev);
>> +fail_alloc:
>> +	devm_kfree(parent, drvdata);
>> +
>> +	return rc;
>> +}

> Where is the device removed from the system when done?
I will add the device removed routine in the next check-in.

> thanks,

> greg k-h

Thank you very much

Richard.
