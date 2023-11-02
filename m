Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517767DF50F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjKBObN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKBObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:31:11 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 07:29:49 PDT
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B748D1A4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1698935388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aER6q6rtiwhh5dQYUbsUMzQwD//MtXDX/wQRpCpJUU=;
        b=PwFKjIn1o3AwzYGfeoMDUvpgU2BvYACYer7+CNGtq6HSYQ+xI1wT1LQIXYNaWmY5+hnFgZ
        p/jL0ZHBffuj9mRkZ3rUETgle+3mWl2VkTwD/6PSlhh15MWuo5gV34c9W6X4HhLa1+M2qO
        FT1q0GCvJkEPZnY2ALl2scFnXe9qbkg=
Received: from CO1PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp17011018.outbound.protection.outlook.com [40.93.10.18]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-PphUikrdMjyCad9h5v_ihg-1; Thu, 02 Nov 2023 10:28:42 -0400
X-MC-Unique: PphUikrdMjyCad9h5v_ihg-1
Received: from BYAPR05MB4424.namprd05.prod.outlook.com (2603:10b6:a02:f4::10)
 by PH7PR05MB10394.namprd05.prod.outlook.com (2603:10b6:510:2e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 14:28:36 +0000
Received: from BYAPR05MB4424.namprd05.prod.outlook.com
 ([fe80::afbc:19dc:7dfd:f048]) by BYAPR05MB4424.namprd05.prod.outlook.com
 ([fe80::afbc:19dc:7dfd:f048%4]) with mapi id 15.20.6933.028; Thu, 2 Nov 2023
 14:28:36 +0000
From:   Robin Getz <rgetz@mathworks.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "marius.cristea@microchip.com" <marius.cristea@microchip.com>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iio: adc: adding support for pac193x
Thread-Topic: [PATCH v2 2/2] iio: adc: adding support for pac193x
Thread-Index: AQHaB0mtGa1Cq1s1TU+Mw+PCEyAktLBdwweAgAlbMjA=
Date:   Thu, 2 Nov 2023 14:28:36 +0000
Message-ID: <BYAPR05MB4424FBC5CFF90F55198C4351A9A6A@BYAPR05MB4424.namprd05.prod.outlook.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
        <20231025134404.131485-3-marius.cristea@microchip.com>
 <20231027161813.7bff8866@jic23-huawei>
In-Reply-To: <20231027161813.7bff8866@jic23-huawei>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB4424:EE_|PH7PR05MB10394:EE_
x-ms-office365-filtering-correlation-id: 5167a114-7173-40ac-ee02-08dbdbafffd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 3HLXLHuoGX1ioyB6ysm6uIiRjYzaMmoqV+0neIqoieGeGsyYXI7He6J8uEJRwhyKRTDgh4f23omnBdJreYwzVBaIAooo2JKvvnXYc/SkY8WZZJUSXHMXmNZSccFmZOVxwkc7mjxlg4En3wZjOI1w/YKeejCMPmXcQoQXSYHV1/IKrHJhoiCrH/Sz0qz8B2noGcQwQvFFSYX9fIvMsBZICvDUIewg5cVAtBw9B9cK+ZXI8lb3JhC5mK8pa9Ieb6HlbAgyegvupvXIDr1sS7eOoJOoPknhzcW4Rj7Znz8M1oRDyVSM0Wja0obIQveAJ4OyJ+zCXCXCxTH+U/RSCgzty8M5HhRGygq+BvlNn6otno4YrGvuf20/E9sGNJxoCJe4MsQ0igpLICCgYzBF97i9JFUavhNy31+IT7AmbAT+DGzh+F7Jg5+oiv1zWsHI5j48Wk0pRct8W+xrK2/01X6VzQ9Ny9MXCjT42KNu45cIuqFjnkOTjDkETExuC+MLn25tUOKQXTcXutxiHUppH/WqVMBRDpMDeAVtnfD4iaCoOqJAU8VUN04p9rFIi89jgoIcOO3zhhF42zsyZJPYRt0qKDfiAQLFSM2wdqJfaVPoM5K5vMMBLyCPy+RUxYvDxnW0H8LWU9WkhuQ3E7x5Jn8Lnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4424.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(26005)(9686003)(38070700009)(86362001)(38100700002)(71200400001)(33656002)(122000001)(52536014)(5660300002)(2906002)(83380400001)(6506007)(7696005)(66946007)(4326008)(8936002)(66446008)(64756008)(66476007)(316002)(66556008)(76116006)(54906003)(41300700001)(8676002)(110136005)(966005)(53546011)(478600001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hFCWU7jcwOZUAfXVLiEgjaH+DPr6K8OPqo6wWENRnpnxgW0g6uESD/gsK8Kr?=
 =?us-ascii?Q?Bq1YXK7r+uNx6aq+0iYyBRiqyb5Q8GZlAA2w9ge14GZU9H+Y2kNp9aQ8H6Kn?=
 =?us-ascii?Q?GmMGSM15hgmctImo9vA1G48i6gnSwpJ79BmAIshxfPo9hkF/y9c0BqjG9RId?=
 =?us-ascii?Q?hDXcFBwKkHvns7ds7fccL7hsKEiMH/ERl/Jx9znxxlJtwBOxDJoNl1Ly/ERl?=
 =?us-ascii?Q?YoU/pz9uzYDiLFYOQACmZCtisS92WLreH6/KhWsOCDpHuuf+IEzdkVrbYR7b?=
 =?us-ascii?Q?2adZvBUTtWYolPtP5YVbksy6Uhm6Iz3VHgTKQCk77ZElgXZB88TDYWxqXmN4?=
 =?us-ascii?Q?h3/eGpo4qkU8fpJTt0aguXd9C7ANyBu/rAmvGOhl1qZKWJGnKkahZummPMht?=
 =?us-ascii?Q?DEyh/e6q9CUjUJsrh/ynSmI3g6/EakVf4D4OLtAU/bNzxdPcH2iL8a4uis/3?=
 =?us-ascii?Q?BTD87+oHrIG2bYQ293O80nTlyPMOJeXruWlhEmQFkIEprcm2iwz1fKNPZq1N?=
 =?us-ascii?Q?ljDRVtUFb7xEVTl4LZUlYchClNJnxxL/iW9iy4r87f+nxl4GNOcPJzjP+qRj?=
 =?us-ascii?Q?UOkO4nbRGEGowBgopWreHuFKi3VDG4wHjmGWnyo4zJPR3pRRekOscbYHw8aO?=
 =?us-ascii?Q?ePfpxbG+ZuV6KvKdfIpdjeda+ZQG7DZtYHZIZn7K0d3vewPdEGg5qtMYgOvM?=
 =?us-ascii?Q?tjaU13zRAj7+BjFNJ3ztdN6KRm43H6LLle5d487K5WYloMjLAnG4ElSe9H0L?=
 =?us-ascii?Q?olq2Zq63XsE7Qyfi/9W4jY1IWP8e7YfkocqZ0B1FYJ/1gzk2qhF8VBwQ6S4p?=
 =?us-ascii?Q?ukSlGaZ7tiyT1HA2fot7EAyZAxn4iHs4FI2PhED3c49eiigsQL7Z0zQhBTEL?=
 =?us-ascii?Q?+i2CW0HHOCMDTfCLGD0wkAJE+OQnbAwStx2xeK4FDoteNTlC+I/ilq82RC/0?=
 =?us-ascii?Q?zVL4nurgygB+lIvjQqPaDprlSJnQlNvFxqxY8UwI2EEwbKqd1Els19CMJX7E?=
 =?us-ascii?Q?e7NkIYoKupjSgS5In5nlZbo4pZRtWxFxucKShLFYoFfzp4RCf0Hl1+Q8KwkH?=
 =?us-ascii?Q?5g+O0UHOMExCpeBkB84IIzD+WOgQx6hUt/0n3Pe3olkJODM0126m5bm31O9i?=
 =?us-ascii?Q?BO/VOJNP7aBEyTyMU6BZY02DqnuxV0G/RwpXwBjnOrBkQSgIHwzA3Lzsf0FV?=
 =?us-ascii?Q?psGV5tVlgkmSb67tDoTv3c0T0skQM6zdI+HMqJaq7x60uloDYtcVHuLDF85I?=
 =?us-ascii?Q?OinRdppDR0I0gALXbGCmSjZCrq4AXCds0U2CSpwE0PJhW9RK/NaW8KmOswns?=
 =?us-ascii?Q?vmmKvDwpybAgjxVPHmAmOPmwxm88RUD30esoo68Sq9HtnCNKxQGWtiIDOyxJ?=
 =?us-ascii?Q?E0FqB6lTiJlmtD9qzrYTGDv4+ABCwYYEG0Qb48SFXfyFEq2mEPCJWsIWDwL1?=
 =?us-ascii?Q?mUCiLdXCcHUaoFUgYsG4MDPzukVvfus2Ap8ZPndSkL5+BeDCSmJznaTiIJxy?=
 =?us-ascii?Q?PYiO0YUC1Es9Xg0nSDfelqKV6PyP/9nJuvLejqZnA85S+QUlRmFtmToydmpz?=
 =?us-ascii?Q?TD9BQ1d9ccLswODjzWC4mwDEj4gGcY4cP+lE4s7+?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oIZcPAs2N0zmMssfJXANRJBXC6NZygtSNBPBvcsxP63mIO+AHC4lAtQfIkGSm9Gqphtx56PbUhId+HffzOUyv6q/J1CpXci/jB9Yzh4eN6H7gBWUx69XJVYbKmF+Kgl/CduEEDjQIGumR81uxIg8/ILqwRAh7Ie9Tsxsn+eHHWQv/t3atmamTuV2+2lDp2/Gzqi2qXKn60woW1ZpT5DYeKuHKuw7W6w4ujZx59ilwDDLoGry4zCfxYdHqyHYwhTDJuxQl0YgIzKKGArC5ZFTtIEhTu8RFMdcYGZllBMi5XN584PkQr2uj4LJH+baGmQ1dHRPjpu8D1nqolGpi8xctp9vp9t0jvGsFUeC8Mxjcqvn+42roY4McgxTJ7rF7P3SiK5GkiS24dlAHjD7jxaP+yAc3WnSiJdg38BwdrzUwTN2FDKfB/f0MTX8gwO5bvnOMh/+jXYeThIAYV7tVq84z40MSk+tNIxCj4P8FXG7L3qO46ZkIDoP92yLWj5mSdEyaR1AR3XIlQSJ2VXeVwAEZlmAkmuvfO91JIUaLGw6xtgNoFGXsUhNH9uXeOP1617aC+SnzJMMLq8+SHjau5MrTbVKz+kGQ8UGn8rVNcNy3s5dd4SCIg4BjpjsCYlL4OlybmB93wg+w+Gt2c0BPbhdJFjJoI/ta4aKD0PAgKDGI4rKvIGR+vvffx5RrWMvW3um8r/USIme8H/NRg/VSgtio+sdDwTyco8fsqPUQAWU0GwQjnZnd1Iz+BWL9BIYOTtjtKR0bH91QPNhNdQW5aP1zs6Xzq6I31b+tugRsioXCYqc48rSDNh+uoBu4zPF95sETsWsx2G7kjTf7BbOxPBY9ZwCqHaPab+gdWFydCkA63ydrCEktMRKDwl8sNlSQUvnZrUFiGgD9N4erSIIdt58Ww==
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4424.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5167a114-7173-40ac-ee02-08dbdbafffd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 14:28:36.0783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1+20wm2qDq0D4fXL02jY4umvEHfECe0GbVtDb8ctcGfQdr2dCXIbnb5GS650ys/k3H0bK3v/r/Qa65u7jO95g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB10394
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 27, 2023 11:18 AM=20
Jonathan Cameron <jic23@kernel.org> wrote:

>On Wed, 25 Oct 2023 16:44:04 +0300
><mailto:marius.cristea@microchip.com> wrote:
>
>> From: Marius Cristea <mailto:marius.cristea@microchip.com>
>>=20
>> This is the iio driver for Microchip
>> PAC193X series of Power Monitor with Accumulator chip family.
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934 b/Docum=
entation/ABI/testing/sysfs-bus-iio-adc-pac1934
>> new file mode 100644
>> index 000000000000..ea43df292b9c
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
>> @@ -0,0 +1,15 @@
>> +What: /sys/bus/iio/devices/iio:deviceX/in_shunt_resistor_X
>> +KernelVersion: 6.6
>> +Contact: mailto:linux-iio@vger.kernel.org
>> +Description:
>> + The value of the shunt resistor may be known only at runtime and set
>> + by a client application.

What? End users (people with access to userspace) don't whip out their sold=
ering iron to add/change shunt resistors.

OEMs do this during PCB design. This is fixed per board in the wild (apart =
from device evaluation boards)
and is typically managed via device tree. (Allowing it to be changed by OEM=
s, but not end users).

>> This attribute allows to set its value
>> + in micro-ohms. X is the IIO index of the device. The value is
>> + used to calculate current, power and accumulated energy.
>
>How common is it that this isn't known?

I would say zero.

The ADM1177 (which is different, but also requires a shunt resistor),=20
hwmon driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/hwmon/adm1177.c
iio driver:
https://github.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/adm11=
77.c

uses device tree to manage the value of the shunt resistor.

> I'm not sure we've found it necessary to
> support userspace control of this for any other device and there are quit=
e a few
> where this could in theory be known only at runtime...

Not run time, but at PCB manufacturing time, when the device tree is compil=
ed by the OEM.=20
The assumption is - who ever controls the BOM - controls the device tree. T=
his has been pretty true in my history.

It allows OEMs (who manage the hardware) to change it as they want, but kee=
ps the complexity away from end users.

- Robin

