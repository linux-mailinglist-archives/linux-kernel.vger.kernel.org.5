Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC837D7EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjJZIkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjJZIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:40:44 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F31A128;
        Thu, 26 Oct 2023 01:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk5q/kjXBn588gtVeA9uc0g9ZrLLnbJ/7/IqObyvWm7VHgIcxe5aCZpIZas9Iro8xa+X+LvBM6WlKWCoQBliQwi78yTI5HZ0n+xiS+j9B5DkD0aFgr3YAg4RinGliE2B2B1rwSYHmqvLME8vRZZ6GYJVugu42RwOuQd8y5haliFdDfDV+8DI3EzKvSABDUHpKf1ouxeThHKvYG+VdMTtEzIeN6cslpdmDtrP6oxFpCzdbpxbwzyuzh4l6DBoxf+U7OaeTradeY5qptHaUdn0RgjagnMjxp2XuKm9JE9NtsyrteHBZGIc0yWNKHrIMNSQXGziBgJeLaWA1ox8pc4hxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3Wzmfa3FPhq95kNxmMFgkzTc7dBXdgouuiVxIeh0kQ=;
 b=c8ShyuHZcr9Espp7JmciLn7elAd76/LQuShfTVa2G2T+FYJ2IAPS8IEIDBDSvKi3o46K0E3XJvC6CHvq1tit680yDmQsDSTKEP9ZMpJRo9GhfBzbI92nTGBHLTWgdHpHvInY7g7EqcemOKurXPDft+ivcSvcMJdzE9ovRiE2HEmN8zHMYNoYidGAjhvqoiAswjBmK0GklEayhjbqVbpBOkzbOmbgf0FzAjBzsJpFSCBxwgxV0QpW690U3RG1i+VreuZHLAIwgVYrW6USjSnKuZNvsbj6wIUl6s7ziiWT1a9P2KFbK7gHcl3m1eQCaBRMegfvQTgBrLpdimPCokgWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3Wzmfa3FPhq95kNxmMFgkzTc7dBXdgouuiVxIeh0kQ=;
 b=hK4MoytfhrvMCzB1+B1HK3K4XfeASDgB1HaKmP4axHyqUmrlnsQKxYF3P0+jWnHQHGS9rFis9rzM6hG9pDPKhuvEYbe6ImhHmGdxnkiAXHn/eje93VgT3SRscYX1FEUp/VQmR5lZQcqNYZ/75Kq7nqCMu+g1+VQrNjg0+fb7SxxOsxgiaG/EjUn564B72qvfcSYVsfEl5e+ZqDSrEFoW1RR4dBDwoD6wxd/Eo6Lbq/UIgrW0PAu1/Y+HnAPDNOUg3+tEgOKx39XIu01uvywWTiDYkZ+SLUpDLzKqFfIEBTTc+PV5D7sKzYU7UsivOly5isBr7Sad+KZj5WwQGqQScQ==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AS8PR10MB5855.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:524::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:40:39 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4880:f83a:7de4:ac92]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4880:f83a:7de4:ac92%5]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:40:39 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] tty: n_gsm: add partial copyright Siemens Mobility
 GmbH
Thread-Topic: [PATCH 2/2] tty: n_gsm: add partial copyright Siemens Mobility
 GmbH
Thread-Index: AQHaB+aZok0E+pm100q+8bmlaY29LrBbwGMw
Date:   Thu, 26 Oct 2023 08:40:39 +0000
Message-ID: <DB9PR10MB5881CB4D0C0607507373B824E0DDA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20231026055844.3127-1-daniel.starke@siemens.com>
 <20231026055844.3127-2-daniel.starke@siemens.com>
 <2023102649-batch-turbojet-11cb@gregkh>
In-Reply-To: <2023102649-batch-turbojet-11cb@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=00015988-e8b6-4b7f-86e8-2a278419aba8;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-10-26T08:36:14Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|AS8PR10MB5855:EE_
x-ms-office365-filtering-correlation-id: 0b99ba1e-c223-4530-f5cd-08dbd5ff3b70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vVDFk7W0LZ9tRq8swXuPjvWcB/34QlxflcoJQ2uqTfotrDpf5V3924Ngp0TVIonGLZtggV0IIUkVjADeuAmipeO3UbCHeL+nl2Nr1kRZ8Qm1VvJb6lhFtxiYhFxa7waEXbog8hj5rHTBPq6S5pMVNWWOicVXjDlZDPEbDqXbE2eF4arvekM2d8BpBLe3KYr3G9kM9RiumdT4jLeKFTE3t+YZow1iCbCysK+crBOYoeLfraz+E6lXZk1jZVHR7Vl+GATi7ApRl4Rj4YfN2sNVhS1KNZiOeK4n1oKCqHeJ2k6SGaIsAjyRsMDaD6X69C7vUBpf4aB9FJnhaWI1ZgyAiIvuKYg+5nsCJUa9YXL2Gpare+MJwV/gBJRtMsJm/kn8U1wT1PVUPQb2eqzL5FcDJs6foULO6jQtTphhhQkpMNKRISDeXGtEXegxiTCv+duRn1xEXUQUQ3iCs7pk0fiQ1UbqiGPEXECT9YFxpuYVulcHU+KFwGBuWFeG+nHmOK3/vveDAX0fZjESmNFdIgu1Xw9KnCGF28mLWbocdFgGMxUHxIOrAyjKwdZiXbn9WfhG2Bq6jRQxqP2l4h6En00RJ8exZB2BfjQmrf9s7yBFIcALr6uOKrFrA9XuMuT35dAQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(26005)(41300700001)(38100700002)(2906002)(6506007)(4744005)(55016003)(52536014)(5660300002)(4326008)(86362001)(8676002)(8936002)(478600001)(33656002)(6916009)(66556008)(71200400001)(9686003)(122000001)(64756008)(54906003)(76116006)(66446008)(66946007)(66476007)(82960400001)(316002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vyy2tM/btAYMjmmI+hY9ipuaWina2DVEqTqynv1r2vCsoJivw32Kb0O8tL1Y?=
 =?us-ascii?Q?1vFQYv/FlVw9ZEZgj8xUKuu8hhVV6Vpaxl7FZ5zgoNkbe/q3h3YzjorP56q9?=
 =?us-ascii?Q?zSZT5DR/DgzQA6RksE4J29SsYtl1aXCO31lMRivWKOaS9ICfXarudtxSovqm?=
 =?us-ascii?Q?zHoCn/bodH9DMJGRt+AjzuRVKxUbjPj77BBaptbg3xSSwBNrDKpKL5e1UuZ9?=
 =?us-ascii?Q?E1r+lJ+b8tUirK3w/RXyedY78/woZepcscQYuFlm2PMr52zOXwhDPIWA8wzO?=
 =?us-ascii?Q?/yA1cQvu2171Yql5fKd8OS4RKAnbAqvGWZRdQWISMTIJ/jnSKj308Ic/8EGp?=
 =?us-ascii?Q?fyVgaSjZkBfccEppFZtpx/IiTe0mony8g0W3JVfyXPIgs0rIHj+hAMRjInHK?=
 =?us-ascii?Q?rvvT0b7fgbANNi9JOq8w9uMEh4IVFebJqg0vKZNICxJ3+pamMMbtKEr44XFs?=
 =?us-ascii?Q?3lM4oqdq2t1ardRnh3wcnGHfBzgLvA+S83A6Dn7OSQzkOVI2okxO8sKDpuam?=
 =?us-ascii?Q?6ubcbyUV6g/k7cYTVuDwDcwSkRjYnnydtBBAyGAVEosJllBv9JH3QnwKUXFs?=
 =?us-ascii?Q?puQBIiFK4lqQhRoYRqrZRHU/w+WjiQ+/7qQ7di2WijR2uYOcbmE4uOkiAiyQ?=
 =?us-ascii?Q?v9r/aBaaUe3RMdBx+Qlg6Jyym5XLq4gkrrXmfzT5v169r6pdr1QmZosEVEOc?=
 =?us-ascii?Q?yVWU7Zrg5IJsTul7s+4iiI9EbKlt4G1s2fnCre/a9xWMY8gEO+G3qmRixyZ+?=
 =?us-ascii?Q?Rstt0RwlyPHnet7tTV0d6mDmpcbNOit7pvMBlvehE7jCoj6Xz5UBe32YQfJR?=
 =?us-ascii?Q?3fRCSzoXeHAYFFeTwUerHbi7HSdySioPidZjbWwsn4oB8JsocaZejCar10uL?=
 =?us-ascii?Q?pzwr5Vy70SEhX3meLRX0I0J1jSYBmx8Gdz8of9FHTNVkN8aQGoP+sF2lYOJz?=
 =?us-ascii?Q?WamBnslaNcmBrzhky8f1GgHEaDtM2Jp+3Es8artmT3yOCsFm+M6Oih/lJ0XZ?=
 =?us-ascii?Q?wHYYzXchb0FjoWFgKoXW1Tnw5YfWtSc5H/nfXl/1Cy3OUi3+B40YUo8DVC1y?=
 =?us-ascii?Q?Fd+aACp/95mI6h1jzZgOIBPaEzocP4KYRoyOUAr02ty4Au5EC3zorLUaGLeI?=
 =?us-ascii?Q?7C4X1J9HpupdPRBTynWX9iNIWHgjyV5n8lfkPfrWwRqvk4A6PabKfva6oL0g?=
 =?us-ascii?Q?XKt0rc+nTpfgU93rNJv/3cmSi+xs6+FQtC6dja7YDsPzOi4M4M/h7h156qtt?=
 =?us-ascii?Q?4co0UJRL/PEzkJi079BYDWqhIh/XMHs/AfidGzSD1dk94R4covc4JtXw3YBC?=
 =?us-ascii?Q?9kp6FFsPsJRpLqf66GI9fHKGrkbBQPO8pSwQSb1rlAgg/Ixd17Y8E54EznNH?=
 =?us-ascii?Q?u8Hokq+9fLEklrBS6c6YzdTgeIVAt/SGK7dw/G3SDhWi7DJceOv0/Msl+iHJ?=
 =?us-ascii?Q?HwNrtyrzbsNO8LlYLXJrCDN5W1acTER689Sauo0MOhhD0nw6G2QwJKkqMEKu?=
 =?us-ascii?Q?/NyNurbgO/36hLx2HUkjGe40UwACjXrbQ+QXwhWD9pPZhLBcX5LKj4UtNzjU?=
 =?us-ascii?Q?POeFrXw6m2Wdr+F0z644ykUxYK34uM1bH2/tBxOpbaca+2OqBVSIKxt+g429?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b99ba1e-c223-4530-f5cd-08dbd5ff3b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:40:39.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mnABzeVlohKCtHVIY+iKTG82rIfE9UyChlVM2ZAN8blU8TV/pOSODBPzOZ5qPx5RrHEP70Vq/o1f1Ow6gR+2e1aunp4o5O+IqS9/uSQtM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5855
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > + * Portions Copyright (c) 2022/23 Siemens Mobility GmbH
>=20
> I have no objection to you adding your copyright, you all have done a
> ton of great work here and it is correct to add.  But the "Portions"
> line is odd, and isn't something we generally use.  Can you just resend
> this with that word removed?
>=20
> >   *
> >   *	* THIS IS A DEVELOPMENT SNAPSHOT IT IS NOT A FINAL RELEASE *
> >   *
> > diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> > index 4c878d84dbda..101ebd15954e 100644
> > --- a/include/uapi/linux/gsmmux.h
> > +++ b/include/uapi/linux/gsmmux.h
> > @@ -1,4 +1,5 @@
> >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/* Portions Copyright (c) 2022/23 Siemens Mobility GmbH */
>=20
> Same here, just drop the "Portions"?

This was something suggested by our IP department. But sure, I will resend
this patch without the word included.

Best regards,
Daniel Starke
