Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4020576BCF4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjHASuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjHASuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:50:44 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B974C1708;
        Tue,  1 Aug 2023 11:50:42 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371IW9jZ020422;
        Tue, 1 Aug 2023 18:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ykka5B8Lp3VXl4+hqMU3/ET+bOw78yNk4K79FmKJqYo=;
 b=ZffFs6sy1Lf+wIRl+N0iyifKgipzzlfoCxoI7qv7s5UNyrTnzNOob3lVDQqO57dU7Jm8
 cPw8QNFMXPqgm3gr84nI41juPj+WqRLT37Cf8IoGpeczi/f0KvrryFhPRs1Ca+aKX+gE
 DB0uY1NczbtnbfYMTxEp+UtFeJ2OKSaqoQjeEeNOUinZ8z8yFWSeAgNalG14u58ZFvUV
 FR6fQ3C6sttgSZ5hLHU/KEQDzeomxr1a8t/zG7dEXOUnUJ9LjrPa7UMedS3cLx+RammN
 32u/HRAPM31Eo9nxsqZGvR6wfkrGQ6FU42aWsXsbYy/8TfLeNyHu83QKPXIj9gYzSPIY xg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s6wdvwtbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 18:50:30 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id DEFD2D2C4;
        Tue,  1 Aug 2023 18:50:28 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 1 Aug 2023 06:50:18 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 1 Aug 2023 06:50:18 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 1 Aug 2023 06:50:18 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG8KDublbZYZVp49L7FmYa5DqcN+QX+IbfSV1Mh+Th1pVsDJ0q5piLQjN6sNSrcbuXTcL90Agu9H1+A5NVzYAsSvXnfMxR9K2KGNHYrXAvwJvLOGlXE3U77rCrJVeqIiN005ZH4T44tW1K9QZGKxBbhVTMf9JSvn+EcZNi5VYg6bLD9eLAxUoh0owU3KxthTsbk5rKuEHXXxS/E8nev5FD7DkAjuTAc4sVX5LShhURzF1aD8D1VnwaxBKK3vqkd83RBGQuFP59y7Yu64PbmE+4Lp27ul4daTIjlIxFKB/xYUs9E331YctdqkVNKcwCr5D3HiJa5uvYNyeE4Bb3ayGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykka5B8Lp3VXl4+hqMU3/ET+bOw78yNk4K79FmKJqYo=;
 b=bb4ts7JMEiZgrhz77xpGr9uMJREMVEaeEYk9uLCm1bCQKT16rmWanehOTjg9vBjdikSbOjFd5VOnb3OldiFmYYr1JDrC1a+CQDeCra8Y05sLJtwvSUfhnB+FpD4aSCDYMEwsfouM7BrFrLt4p4TiQdXBWy6oSpwetcOWMR0cn3BpP9xWSJzWVrDWNKPKtpmH+OCrYyLwjVxGzCn/Sp/QGC48ikO/LifUI5M/AnmDSidaIUQS3UBH6ki7lLIy/6cZtfrd7SnUNLqZsyloL6EiFz15QTdIYk5PEtuCBh2AibA+Hr5stOVpF7Em0DIOJgz/NRHtSKdepRM7tJxXiOsRnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB2078.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:155::11)
 by LV3PR84MB3651.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 18:50:16 +0000
Received: from PH7PR84MB2078.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9d09:a85:f15a:6035]) by PH7PR84MB2078.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9d09:a85:f15a:6035%5]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:50:16 +0000
From:   "Yu, Richard" <richard.yu@hpe.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB support
Thread-Topic: [PATCH v1 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB
 support
Thread-Index: AQHZsFXCbdwZ6+IdWk2JqVh7Iq8M5K+tkYMAgChUK5A=
Date:   Tue, 1 Aug 2023 18:50:16 +0000
Message-ID: <PH7PR84MB207885AAF21466E6FCE26C0B8D0AA@PH7PR84MB2078.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-3-richard.yu@hpe.com>
 <9171a00d-9ce5-4aca-8f81-2ad2b6961e17@rowland.harvard.edu>
In-Reply-To: <9171a00d-9ce5-4aca-8f81-2ad2b6961e17@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB2078:EE_|LV3PR84MB3651:EE_
x-ms-office365-filtering-correlation-id: cddcf8d3-0ef6-4d20-567f-08db92c0258a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yptHmGKIE/CouDF5u7Ax0zTHXeAaeZzxa6jpxe1R+zOaMJhM0mCYwD+pgMy3tAI9ReU9rKUozU7hFaTD1izMV5QPyNUVh7d8lleWS9SZGvADjJm93CkE7uhSbFlOQItjE6kMK1Dq+mHK+A11xkKuXw7+esKE247i0/p/OoCSMozvPDUAMpSGdIEMSKaiGNnz9sQ/rQxhQL/clBt7W4abig8fVinAK1VALm20sxb/NmBoLet39PGbWhAu/cfoqF5M5Dslgbtb/xfS4qM1vsKXJoi2Rd9NmtQoDWX9/VRruo0mXU0CR4pUJ/QNWs0P8xWeTCsm6QrvLBImGrZFGbCGEjhGaHLPlClf+zpRBz7vPKU6pw1aPYH6003q4zZO8XLdX419J+swjLs034/eWjXMCqNlLRtt2C5YvRwehsfMk6xIsrz9O4kZpHGApd2Qu/EzrbqmDTPO+ki8+sNQdg54Zv9VIGC44/zqOwPtaJLZ39r7lc7XM+9Co7j2KD/siZb1YnwTky/fNf2YlAEeMAMrJw/Pcr4b7zY5Ot0KTLfdJ7FTHxb2WA4zBbFvxedWyfYeUtJGf48AHTHKEbQ7a/7XzEh8QvElIAwLMjIgt7huu6WATE5+BugNApX7b2aP70/L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB2078.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199021)(9686003)(71200400001)(52536014)(5660300002)(55016003)(186003)(33656002)(6916009)(66946007)(76116006)(66556008)(66446008)(66476007)(4326008)(64756008)(478600001)(54906003)(7696005)(316002)(38070700005)(41300700001)(8936002)(8676002)(122000001)(82960400001)(26005)(38100700002)(86362001)(55236004)(53546011)(2906002)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ugx+lF0AgLhmc+YPp9MUiMdYk45oKeSeVElD7vZBL/fBOVH9HofWVOHx6mTm?=
 =?us-ascii?Q?raaqS9j+8gudBjdcRVG5DwTjYi/zRzHmciVJuLk9/R7JHWejcAhiPyHUZVCK?=
 =?us-ascii?Q?0nKkNqOAFjkgCHWFx/rSh+lJubtFAQziL6ChhCgcx4Hy4JQ9o8gK0iT4wUfK?=
 =?us-ascii?Q?jrslil2ZMTiOICZHsMK8gw62ht9P2i/PuYWA0HnPRcUg51kdyV34tx+8EKD5?=
 =?us-ascii?Q?PrQ1AMmxNm3tvvoR/kUkF4A+bauQ9FSRtOmOz5ewrD49TsyAYOk+kigLiKuR?=
 =?us-ascii?Q?uhyFzDjF5vD2yITggeEYf76Fi3X4zmEqMIWX/M2wZvSGfx/vR4Q9qyQGu82+?=
 =?us-ascii?Q?vAfjWPmHQnVOPAzE9vEApVJOmFnJMg5xXVlQn1X+7sGSArKbh02GpGXGY95h?=
 =?us-ascii?Q?hoJefnGrqUBpXFGNSta2ZzXBuHF91sOCjauyWm8LbO6ka20HfUzy2givfPpf?=
 =?us-ascii?Q?NfFrBEp+8nH+pEyg/30Dz7SXPrHSZsrq3iPB2oIHUcZc/gZkJ3x3ZcyhQE4m?=
 =?us-ascii?Q?GG828nTZE6akE0Qj1KMC9hqmpypMgUHitnhL7PwQRxdgEAW+2QLxpa7Wj1Sj?=
 =?us-ascii?Q?kdppDAkoySTbUqCUsGytATDu0Ck+M9t2Ub9jpuXYAxtgGdgjJcbnGfK4LJnZ?=
 =?us-ascii?Q?r0mZlK5FIqKx759EX9ff4LMYCDc+KLIESmCo1WBjPKQMNMelIMd2IqFwtGki?=
 =?us-ascii?Q?Md59CYkQ0BiTqMeiP5x3Uq8FCnqIAkJTIRXmcdAT/UcR+z+VUOTvi8o+9ih0?=
 =?us-ascii?Q?mig6nULqhFv1KU+5UxhbsMftThVQ6MbCJe0lmDJdCFmZsnfaajVn7aDWBkX4?=
 =?us-ascii?Q?OLDGyrjjwGu4StASe7Wj6JD/e2WXXG1c2Btl22kawOzHgN0YhQ+PKUPzz+zV?=
 =?us-ascii?Q?kAUtxslCkd2eSPWPA6GYgYhC8+VSurdkx2EDEeqpQdi81kdOp5PCY9t2cOAv?=
 =?us-ascii?Q?thRHattmfYBsnqiU7pfWb0ilWbLeuXRPNgEOZpyIAHVZ3+tZ9e4RsDBFbl0B?=
 =?us-ascii?Q?e3c8h+DMWz1UsEeCSJZ14E2AbUMIbN84NemHbH27lrSED9cAHc9BQTtQ7yfb?=
 =?us-ascii?Q?zyte1oKhNxi6OfESs346c0JGhad9wAuB2IQp86EkprAhr9fMoNAhg3AjJiX8?=
 =?us-ascii?Q?7BLY0Fb3ODwa6p0xK1VzdRrPDEsa3BZyRj5Rkzr5ub7MX7BI0Zcbo3FYzluW?=
 =?us-ascii?Q?uzUFKr3g/Q/4NiLYX8i5IXYXzE+DuuhPKwvZ33qEGap4gHvXjhgJdY4/UeHu?=
 =?us-ascii?Q?K0g/EebwHtNqCqkg431lH3BKamXt9bptwe+ZHyngd/tps7zUgX+wjdnhwwDT?=
 =?us-ascii?Q?Zt0EQ2dCypnCT4fZALcngu4boiOG3Z+6Z8m8KsDAQ1R7MNZgemk5BjiFFEtL?=
 =?us-ascii?Q?a+JyAxXypLTaIuzIZ00HkbB4rEoKRw++r46RzGP8eRmjixmSzdJrM4+5ZsM3?=
 =?us-ascii?Q?QwiOcSCeqMjWJV8QNUzSEmnI0YB75Q9zxcOu3pDWcT1m5DE4ykuI1YWUlfTa?=
 =?us-ascii?Q?5dXrIey6lXKAmU4tik6raN4X1/UxZ39I41HZd5Xl6NJvIU3cZPTBDnCPQrZx?=
 =?us-ascii?Q?/sAJOOWVQUkVo6r1YEH0de5xh41ej7Ypx45Otk4l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB2078.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cddcf8d3-0ef6-4d20-567f-08db92c0258a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 18:50:16.3712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRtyrmnbdc/EWieuUevVyqQiTpI82o+cchrSzPbrphRAuXr6zqQf29LPziA9ZfXApQKDmTzOKiUr/TOR5vg2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3651
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: RM-OMxLWspfCBbHeMp-JrGYoQbm7NctE
X-Proofpoint-ORIG-GUID: RM-OMxLWspfCBbHeMp-JrGYoQbm7NctE
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=570 mlxscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Alan Stern <stern@rowland.harvard.edu>=20
Sent: Thursday, July 6, 2023 9:17 PM
To: Yu, Richard <richard.yu@hpe.com>
Cc: Verdun, Jean-Marie <verdun@hpe.com>; Hawkins, Nick <nick.hawkins@hpe.co=
m>; gregkh@linuxfoundation.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@=
linaro.org; conor+dt@kernel.org; linux-usb@vger.kernel.org; devicetree@vger=
.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB supp=
ort

On Thu, Jul 06, 2023 at 04:59:09PM -0500, richard.yu@hpe.com wrote:
>> From: Richard Yu <richard.yu@hpe.com>
>>=20
>> The HPE GXP vEHCI controller presents a four port EHCI compatible PCI=20
>> function to host software. Each vEHCI port is logically connected to a=20
>> corresponding set of virtual device registers.

> What makes the vEHCI controller virtual?  Presenting a "PCI function"
> certainly seems to indicate it is a physical device, indeed, a PCI device=
.

To the host and system OS, GXP is indeed to present a physical standard=20
EHCI controller. The standard Linux EHCI driver will be used. What virtual
Here are the ports. We will remove references to EHCI in code and
Documentation. It has been modeled to following ASPEEDs v-hub approach.

>> +config USB_GXP_UDC
>> +        bool "GXP UDC Driver"
>> +        depends on ARCH_HPE_GXP || COMPILE_TEST
>> +        help
>> +          Say "y" to add support for GXP UDC driver

> Now hang on a second.  What sort of driver is this patch adding support
> for: a GXP vEHCI controller driver or a GXP UDC controller driver? =20
> The patch description says the first, but the code says the second.

I will modify the patch description as a GXP virtual UDC driver.

> It sounds like this thing actually is a PCI device that appears to the OS=
 as=20
> an actual EHCI controller, but with virtual (rather than physical) downst=
ream ports,=20
> and it includes a virtual UDC for each port.  As such, it requires a driv=
er for the virtual UDCs,=20
> which is what this patch provides.  (No new driver is needed for the EHCI=
 controller part,=20
> since the kernel already has an EHCI driver.)

> Is that a correct description?  And if it is, what is the purpose of this=
 device? =20
> To act as a testing ground for gadget drivers?

That is a correct description. The purpose of this device is for us to crea=
te virtual USB devices,
such as virtual keyboard/ mouse using in OpenBmc KVM, virtual CD, virtual N=
IC...

> Alan Stern

Thank you very much for your feedback.

Richard.
