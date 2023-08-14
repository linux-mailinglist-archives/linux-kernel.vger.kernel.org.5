Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3E77B8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjHNMqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjHNMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:46:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2111.outbound.protection.outlook.com [40.107.94.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD61E4A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm14H6ovmsJuyRkqn9UyY7Klx5Fx6VNJfopQ10Bcv28XKgXZ73PCqnmZTKZRHnrYgcvxYUPNurDDXhYk3KP85aqUydnnpU0aMcKFiP0iuW8ZjU6LAsMJBX1Fhv6FlXTc6N7YvJfMZJGkRQpC0kgSRQYTbF8kgxC5WJh/kBKD4hoy/8vtSqGkVneEvlr5eflmFI7RTuveyAuiaozM4lkN9jXRnQu/JG4idO/APdxfZbO5cChll92jGZbNeGNcXgemVkSiwW03WVy479j4JJBuJRHW6lVi1YUeC7gFPi+q7R773ZBpCx0zDSoCZd8zPvb4gJVI6EBmgD8JiwtQG7fRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAOMqKbm7G7uE4wYQzTPVx+AznoJXvVEN8wvrvF5KE0=;
 b=PuyK5lFlOTD8gb8mge3UIPlzM608O1PhO/ZLUNPFfDF8vCdpd1GHWSxQX5Y4xgM9/UMBJqftu7oW3g05Aq+RmVxj3elG23osHErFDLQGvdi6+87s5nXxCzMJmA2JmZQ+YVB42b/PSozBKy480/FyOZlZKRE1Ykz9YbVvZxCKoIwhVtDRbXEauzVaox9fVVZ6ttzxBq9rG/sl1Ms3VCu/VbA5Gn5+XobFgVy6rEjXjAh50teY9/pF+z0hWzA3Mw/54rc7qdb9tQk6gy946gN+Em5f4YCM4pSZw7Rw9t/fmSyUmfsZ43s61uuBLqi15th4i9yDqmD6eCr8Sk/+Mwhg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uga.edu; dmarc=pass action=none header.from=uga.edu; dkim=pass
 header.d=uga.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uga.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAOMqKbm7G7uE4wYQzTPVx+AznoJXvVEN8wvrvF5KE0=;
 b=V+CQYHWCThFiIolecIFUDKtg7lXBwZ+SSq/NX4FeJzLvVC4gTcwZnJfZfhAk3RtSwBFAHiBEtiikocuUY5nOu1kE6CjrFxy4sIvkb1PPN3s80MZbtQGZ4YrRnzbQZ9rY8IZg6s3+wJayjP00oqtVSIhwyPPSKaAOCVLXnmdZCNqeIWPxA4uYCpA0J2DrUY4TE0u3PNKmcGR/fmazJ2QCEkMwCBcAbzO8N0TfBsTTiOou27oQ1ijMcm9+q+s1KZ40pzsHtQjOU8WUF76ilehK9SJHsurq5QcfZdfjoZlPB98RnD5YgrDTjCreKFxckEGSk06dXqhHbHnqAg0nGVePMg==
Received: from CH2PR02MB7014.namprd02.prod.outlook.com (2603:10b6:610:8e::16)
 by SJ0PR02MB7806.namprd02.prod.outlook.com (2603:10b6:a03:322::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.13; Mon, 14 Aug
 2023 12:45:57 +0000
Received: from CH2PR02MB7014.namprd02.prod.outlook.com
 ([fe80::245e:ac98:7b9d:c0b8]) by CH2PR02MB7014.namprd02.prod.outlook.com
 ([fe80::245e:ac98:7b9d:c0b8%6]) with mapi id 15.20.6699.013; Mon, 14 Aug 2023
 12:45:57 +0000
From:   Joseph Vance Reilly <Joseph.Reilly@uga.edu>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AF_XDP bug
Thread-Topic: AF_XDP bug
Thread-Index: AQHZzq0Fu7ItPhHIsEKTTu5fxQuIeg==
Date:   Mon, 14 Aug 2023 12:45:57 +0000
Message-ID: <CH2PR02MB701415DEC996810D20D2EB60F117A@CH2PR02MB7014.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uga.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR02MB7014:EE_|SJ0PR02MB7806:EE_
x-ms-office365-filtering-correlation-id: 77b20090-a144-4df2-ec21-08db9cc46813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJbbd2ZlNaHMc9MhcUwgVqvekzzf0v1PBaC3n6CWDz+AkP5lp5/2ar2gmtYDMfXxkLSvGPneZuVIitiSt9l6QOUuLi/Wo+puNrFrK+MNlbFiHEKso5R9roYdMmIeAYDuz8nDHv6RAT+hN3S1UT1TubJuRGtaSu3s5MkYoN8hcBVqNy3E03xyywA0YkQ3HaehHsVDIoPmwWMlbFbORG4+7UWLw3Yzo0CYP2JhMj/tgtwtfJbjdaKvIeX0NFDp+Bi5YZFvuiadeiALfUCVkNA67N1x0IPmkoFyUNUuM5UDNO17JBkTlqNNpGlXnwhkIf9HT+ZPME9m/ntxJsDsoQ8gWD+ALg3/UVtSYDCOhCbkH8hvCmHwtgxWnacyaHRY6kHfXoPBPEmfGn4DBt7KEPXWPR4kn4SiSPZkY8SIGLDaT5nFq/SDbs6uSCLnkT7m/AGy74phVwdss8Eii6BSmk3YanZBhHje8mt41p2dLRlzsJpPW9CRsnhyTo+KJaF3tAUojiE3dx3WZKVbgs79TjGtUsilHHEXKXEAR2qxE+iJUbAmGTB3S3gyUbpalV8h1aZOLetoEk6PbmOdOBC4Ze/PVg1CZjn1I1f/6AxBo5LK8GM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR02MB7014.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(346002)(136003)(186006)(1800799006)(451199021)(33656002)(83380400001)(55016003)(38070700005)(91956017)(38100700002)(41300700001)(478600001)(66946007)(966005)(64756008)(66446008)(66476007)(66556008)(76116006)(316002)(122000001)(786003)(6916009)(7116003)(8676002)(8936002)(52536014)(9686003)(5660300002)(75432002)(86362001)(26005)(6506007)(7696005)(71200400001)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DnRv3xDoH6nhSNXbiJUv2dgusvVhzIL9lrgyYQTFm+URuNjRQSjplsOb70?=
 =?iso-8859-1?Q?AA6kTsaPR/yV92y/brga+8C9DQUQh1/e739GjX/cmvDzSy/FWV8cBUmV3C?=
 =?iso-8859-1?Q?GWZwf1vH4BtP+Afqnj32HyyxRgBr1spRd2oNUB0mXdv2NZFvd8dsMsRU9z?=
 =?iso-8859-1?Q?VADkW82l/GBKR9/3BDxZV551a03mFzWTY4WgKJiK52GQ8+3n0igak9YUDS?=
 =?iso-8859-1?Q?zcdsQbRP6wfCpBfQ666nO+VZQeCyjY2ApRfxTZhr+yrnHtHaT3zUaM2FVA?=
 =?iso-8859-1?Q?c2o0i7KDumttpRupiTdQtYKQDu4Tk5Znakd8YN2Ps92s1JWVFks6trAKlq?=
 =?iso-8859-1?Q?Z8IDjdE0RQ6krozkIkaSU4Om6w2hxViXFczzqmKRxIjujNPWB/Y2UvqF3J?=
 =?iso-8859-1?Q?5EnptPKV6yjohOH5rt1TqQHxQQge9T/cQlCOu0g2sgr/vIpgV0oXvBv+K6?=
 =?iso-8859-1?Q?3+MCnrWosli5vdIqO9JfLkVQiyNmtoMBQAxD++aFjjlKo8xDiTFl2V0aT8?=
 =?iso-8859-1?Q?KXQyzbuAUAm5wm5Rsr9+A7el8R2DF1nRmuUOHiODp1wUr9FKea8A1sHKiz?=
 =?iso-8859-1?Q?HzO03cgbfVOKj/kNpgKDhhfDWKghRK5s6lY87nF/JqrTsLAICn3wMa3Bn3?=
 =?iso-8859-1?Q?gUO8ZtNhGfE9T48ypLr8tc0R2mvfhs971OPrwJ5p6wCoBk8A1ar+FRX4LL?=
 =?iso-8859-1?Q?XNOYls4PDnW99BILWtDWCqpzcrenkjnUjsiOHP8wdr2JaG/xy5hgV4FxBU?=
 =?iso-8859-1?Q?rsLrsMSHleumF8wmFcb175U77Bsk1s1NODRI4sizkakQU9F0qdL0zVVhO7?=
 =?iso-8859-1?Q?3bE3oBOF7JHyrt5P7rD89jZO0u4VUSZcMwLi3F1++FXYjE47rJ58ZvUASo?=
 =?iso-8859-1?Q?5rsBUapfZExErEqk01XOtFpDLO4xZHdGw0h68n06UvZWj5CL8ixKbsdd2u?=
 =?iso-8859-1?Q?7Pgjwa47w5G5WD6RPNS0vDSxr8BBifIdHPexvQI+HKZFaCZPXSmsMgI7gK?=
 =?iso-8859-1?Q?eTIm7klZeDq8xih6hOOKq5GrQp6S6M5krGRRRKHS+wtXGH9Q0FkzXNsiaM?=
 =?iso-8859-1?Q?rXZ0Leod+Wip/imDQhiVDRemWdHL44iUpEYHolJffZLASWKQyS8FCXIysu?=
 =?iso-8859-1?Q?W2PkDH+3dofal1aRkXb0bHgjHY+0+7j2z8VPW0valVO8EMhyoo/jnRidJL?=
 =?iso-8859-1?Q?VlKpprGBc8so66rEC3ENjxHfi0w2+o7e4IzHY0mp5IEhwlxR9yi4RhhFyW?=
 =?iso-8859-1?Q?jqyCig3UsYn5eRGVgAtZW3NXbaqp9ahyz9W7u7EdlpyRv4qxBZ/f58jDp0?=
 =?iso-8859-1?Q?Vw2UG6Dm50DWH86PSRZbdjX/uEOyPFRo6zO8bHGGl7ERGG6Bv8ZXHPWpOI?=
 =?iso-8859-1?Q?FVDLPVFpnrDCdScNe8j22IQXuOwUtIf3cD+0yJELj+UGmpUVY5qV2Ysmix?=
 =?iso-8859-1?Q?4MMeibyY/KOkOFH/kdmm6ODDm/fVwZOvKpiKvNnBC707YmAoMX7X8sKPcB?=
 =?iso-8859-1?Q?Cw3vffGLMmuqFHHtPfDO0DhFRUX4y5WPrTX6qusOrBmsDehXGlu3ALko2t?=
 =?iso-8859-1?Q?RX0ccwmb0vgZubEoxRK5bBB5dIYGq//bWqV5Fw4aCm2oVb/AY2i86vhyBy?=
 =?iso-8859-1?Q?yMYixZtnTkkpA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: uga.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB7014.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b20090-a144-4df2-ec21-08db9cc46813
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 12:45:57.6454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a8216c1e-4d63-4352-8c3b-50fa1f1475b1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mxC/lwCQFCvrV3/c+FQsXRwDibrkOKgHUzc6hdZiSE5BFVNYzRcqi26rvaLj0CXR6F1oHUhaxiM6sss/j8XWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7806
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=
=0A=
My name is Joseph Reilly and I recently created a bug report on the bugzill=
a page for the linux kernel. This is a bug that causes an IO_PAGEFAULT when=
 receiving high amounts=A0of traffic on an interface running an XDP program=
. This problem has been observed with a Mellanox networking card and AMD CP=
U but may also be present in more configurations. The bugzilla report is he=
re:=A0https://bugzilla.kernel.org/show_bug.cgi?id=3D217712=0A=
=0A=
For reference, the bug is #217712 in the networking product listed under th=
e component "other"=0A=
=0A=
Best,=0A=
Joseph Reilly=
