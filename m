Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED587FDDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjK2Q7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjK2Q7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:59:40 -0500
Received: from outbound.mail.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492DF8E;
        Wed, 29 Nov 2023 08:59:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRDQFa6Eo9lQA2aDJyPpjlJnI/U8uMsXrbEfGBAH2P5p3KUzYyn4jxA/TkmSDSIlUO7cwuTFh1aedm0KJ1gKgE4EQ2P+dq8B3c4Iy2K1OoXIIKH2WhW5ShViPuJN1dp06I/VYPvobm5vNjqwOPLGh8epaPctvCb4ubfI7+V8tdJhRI38xEUOY7WXI9oDdZn1ioYjfj48k3eukz1cwZgPgMY/7gfz/GA3XMjhJkG8kq0GoxvdqKwj9ha4qnArPJEozVi7vZSVxL4he3aME4p+5yK9AL4MyCI2oLPUr2hd7fvf+zOj9r6tlIzaKHHRKwHKhu5ZfYQ0UNnC6Oh6VoW10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr2qbv4BxNahfi/sO4DUapzZ02iRnP5BN7600Q9k88g=;
 b=aHsv3ieHMYlKZu9tPCAbPvqrrNnM2d40KdfxB8mGSzZxeQjCk5x1VoQwokAT16d7De9Mr88HPBMvodTI9JosYWOnQJq84uXtCoZ5Cq+3/AvgjUrgJsd/0JU/WDO8S7s2gZ2S2TYJpOMf8W7iOwPk/GHdolI7d0L4+XKDvBnKPlAZYXQPmUwRASOwgKiFjHT+JZKDR9/t7gO+4AeiwdRbJoEIJEcGQ2rpjjE4ivkS//zHZ4ajWbW9Jmjztnddf3ict0k0139LLt9IZp9ATOAmhNfVMJClrY1Zv06KbMSasG1m/+5lRXkNre2cIsf2YKmGI7wzmnGfYL2UMlTXHutR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr2qbv4BxNahfi/sO4DUapzZ02iRnP5BN7600Q9k88g=;
 b=TtSHTWMe4ZRNGFkDwG5EIa3SAtu6LuM2GJvOFihvkIREKE+cnki/UXzEn/rRqcszGCCZl1OWRuzHbANdDYU9eVRvnHkfc1nktVOr5F/39x794NnuVBX426BTJ96yLjBdUbTZn0W4/WPUU3hNRa1EOBMSyXb2icNNjiPkvHYJemw=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by TYWPR01MB11342.jpnprd01.prod.outlook.com (2603:1096:400:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 16:59:41 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::74da:640b:b793:14df]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::74da:640b:b793:14df%4]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 16:59:38 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Jakub Kicinski <kuba@kernel.org>, Min Li <lnimi@hotmail.com>
CC:     "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for
 the measured external offset
Thread-Topic: [PATCH net-next 1/2] ptp: introduce PTP_CLOCK_EXTOFF event for
 the measured external offset
Thread-Index: AQHaIWyQveJbeWs2hEyyQBk1KXKTxrCQrbCAgADY6EA=
Date:   Wed, 29 Nov 2023 16:59:38 +0000
Message-ID: <OS3PR01MB65932F46E55E38E3DDB938C9BA83A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <PH7PR03MB706497752B942B2C33C45E58A0BDA@PH7PR03MB7064.namprd03.prod.outlook.com>
 <20231128195811.06bd301d@kernel.org>
In-Reply-To: <20231128195811.06bd301d@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|TYWPR01MB11342:EE_
x-ms-office365-filtering-correlation-id: 92226e55-9c55-45a3-2398-08dbf0fc926f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e64C9lfrXjGc+/XVkxAOA+YbyjjCFTV7v5KK2ybK+CyDliUf5JlCnx4JNOyriPyevII+bWLEh0mDbB33SuvJwzfVnn4RJsdvNG56HimFZLfHgC2FR/gV29G0ZIIZhk/jaL4MRHnpmH3+gFt2XHGt293d8kh357S2cs8T+moCJ72TEJmafhde2SjeGmi0Gtrwgp5oKtmMXJ721U8s/9ehjCZCQxIwAGLOKJAr7soKMMB3p+idTFB6KbT4tSU4GD9R12LucQTPJD4HQJugwJWG/05LUNDFIjYKEqUAof1w1pbFmXRwFdpmxgap11I4NfYq6Gi6s5t5ZAf1FBOzm8FIZpKrIVFa2y5UNi8GtOAOVgVjbnazfYIKoSTwVdIpm5nwRJ9fpROaFiF+7Jg8f5ustRFZr86VMAwBwQdunLIbdPIOAuxq84NiuDljqXb9HRQaseB8vSdusGxqJWlX94X3jlF8VWW6i08jhZnT3ptepL3pWhbHr8YfjP4N7srwXhhRq3R/EMNslA7ezIm04XxpVO7hv7fzpW357YqpDmduHwgcLV3kZ+cvjyn+NeR1bUehT0CJcdyTU19yUDiEL1kvtnx4snnboAJ4v5V2Q8hZqUnKhTJK8BCu0ujiXvNulFjnxQJK7a++L5V2koDCx0i2yFRRyJc9cUKgXA7x/iuIMKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(71200400001)(9686003)(26005)(478600001)(7696005)(55236004)(5660300002)(2906002)(83380400001)(53546011)(110136005)(8676002)(52536014)(76116006)(8936002)(66946007)(6506007)(54906003)(64756008)(66446008)(66476007)(66556008)(4326008)(316002)(122000001)(38100700002)(33656002)(86362001)(41300700001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?efa0NDWp2M2NbreGYVIbsr4RP39moDTlyxTbVDPA16Rs9XgysbpF0CvBqgZy?=
 =?us-ascii?Q?yffSCZKB2aW/5G19dKnAGJBRriyR4w1l72rjw3udd5iSfdVc+jTpqaeQXUp8?=
 =?us-ascii?Q?9y9SZrHj34iukrohb81CMkbr+3oioyFAY08hTAtFqvAUqffR3hQ1FCrd+/Ig?=
 =?us-ascii?Q?1/yaL7LZOzgmJNyPla4WWmWf853Z9pr/Z9MduUdX+8By9jUPKVjGb0O+g9P+?=
 =?us-ascii?Q?b03XSjRz6bYK4Zt2a1WVsQqtqZMkIayvAmxBScY2OnNdO4raNs+F7EiFK8ED?=
 =?us-ascii?Q?ykb1WTdhIfrVgHczfgnn4UDNPDp3rFj+ZNOariohTShHhXNdu+QJIISE9K0F?=
 =?us-ascii?Q?FiAlu2hoybMvkFdVDihG7WfBwijszMlsYTfqM/sdcvRkquAEFYtr7uA5neeO?=
 =?us-ascii?Q?o0b6FjNNSMMjU2O6tfTQdYSMFxy1P5DgZ2aZxHeYwf6goAV6+wsv1/qCUAO6?=
 =?us-ascii?Q?QLQzlgjREFY7z/tWuTj/6/rl9QAotzhHTWGx5rnxrTwcd+LeWgiLzIP3A5IH?=
 =?us-ascii?Q?denkbgxgojZYNHXxnZEqpLZqY0Y7iIzV7SzC/TIdMZ/3L6wRZD6kBdwSv5zV?=
 =?us-ascii?Q?hFj3GBET7df/X6vZmjG/op7rPZy+fNnxZ1jxRikfZ/tBlaosh1MN+Yhixt86?=
 =?us-ascii?Q?oAF8i//MrJuFmwyOX9eeBZ5AIekgMfgsVFr1gjuE+cSMXgPivZhCIpThKLLr?=
 =?us-ascii?Q?2wKLBvZp6CuugTB1jkSEv50D/y9mBxz88OnztN1ooC2DyeaZ0GesrnPpA051?=
 =?us-ascii?Q?GpDY4ZW5XD7Yu8H41zEuWAh+16eTYUPUrWPTHU7dc4JypNuE2Ug+JEd91Mdg?=
 =?us-ascii?Q?70Zukz0oTVVjwM/zndgh3rXl9UocqYPtf2Ofy0VJaVJn6g4e5x9vsviyddjo?=
 =?us-ascii?Q?KV5kmirnOF/RkoduQfTfmeJUGId3p6X+/KeETPQRGKeuaXfM9j1bqwMXyG7w?=
 =?us-ascii?Q?oUaI7B9fLsp7C99cOm+kEO/Ykxd+QyTtJNL33SmzsFrUSSZcc0r2TA8uBIJX?=
 =?us-ascii?Q?jfzjm6e4EAr2swlIA+pOPDYybxd0jiCLpzAtsXC3h2Is7WZjZv/xsVqs9X73?=
 =?us-ascii?Q?RAhaMSyiwzxeOL1ALdMm34Gxkd426+Ly6W+nOfPOz44U7ZKiTKlKynBrxB4f?=
 =?us-ascii?Q?rVmq5COhvhv2HXkTRO+MNibjwKJi2L7BWx4g/RmCnTTHv+aK45vcHaMSUaQ3?=
 =?us-ascii?Q?+h4En/4Pd64Zfe2iuUGEidHzp/cU1zbyzmwifeC/pWAOawf4eWB/Qp340JUl?=
 =?us-ascii?Q?qwdaIp+WBNc6gtEH9J/KO2yFq32iNSaS+k4WmH0PN7/Dtt5gU/N0G3hKV0Ut?=
 =?us-ascii?Q?SiL8bcux6iRqxSOAGKm2w/rW7pMiXVBewwVQKjWHJx54zlHH9W3zsqKjgAxc?=
 =?us-ascii?Q?ERegpthsg1aEKwfhQHZQOd5xLuouoHIxCgPfoNgiSNVhod7Gn3jwcUwMHwCY?=
 =?us-ascii?Q?l/U6v6sG9/CHFfFDGx9XyiK7cMoXejpl9GYlyS/cZTJuLUig4t6YpW+y8vsZ?=
 =?us-ascii?Q?5uWN8muEioflE79CN9ohvv5Q8EeoXibd7XOyXGiIFMCDFEBe6Q9iMMRkOpc2?=
 =?us-ascii?Q?u4Bm91gU3qUI/gDTP/lN0+69t5ElyFIE+kQgLw/E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92226e55-9c55-45a3-2398-08dbf0fc926f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 16:59:38.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/i1eipRNlp490ZFD0+kVLSMwQVah3iI45GHM4/8cZBLg2Y6swbO1Rq8HM9/BuTigWxzyQNfL5Vu6PB5qHJsyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: November 28, 2023 10:58 PM
> To: Min Li <lnimi@hotmail.com>
> Cc: richardcochran@gmail.com; lee@kernel.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; Min Li
> <min.li.xe@renesas.com>
> Subject: Re: [PATCH net-next 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
> for the measured external offset
>=20
> On Mon, 27 Nov 2023 15:01:29 -0500 Min Li wrote:
> > This change is for the PHC devices that can measure the phase offset
> > between PHC signal and the external signal, such as the 1PPS signal of
> > GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
> > the existing ptp_extts_event so that application such as ts2phc can
> > poll the external offset the same way as extts. Hence, ts2phc can use
> > the offset to achieve the alignment between PHC and the external
> > signal by the help of either SW or HW filters.
>=20
> Does not apply to net-next.

Hi Jakub

I submitted an RFC last week and Richard was asking me to submit it togethe=
r with a driver change as an example to implement it. Below is
Richard's quote

"Yes, the new option must wait for a driver that implements it.  Can you ma=
ke a patch series where the driver change appears in the second patch?"

But the driver that I submitted is a brand new PHC driver. So I don't know =
if it is appropriate to separate them to net and net-next? Because the driv=
er
change depends on the this patch.

Min

