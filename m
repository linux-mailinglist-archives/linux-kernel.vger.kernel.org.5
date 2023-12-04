Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4644C8029FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjLDB4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 20:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDB4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 20:56:13 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA66A8;
        Sun,  3 Dec 2023 17:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeucsQxcz/kHFnrnwA8eEHlJcgPqFwlpZRbInNT+5R8It26Xo+EZGYQ2rxsNdFwSGnNuyafkEhEHjWYdjcDrPtabu2UmQDm81WRUkT0ZYMEGnZKUw2irQj4ToP/BiEna/2wN61vKAAOzOOst5nA64Ii1d3IX7/PrDx6Igncq/AIT6zGzZdlTJHizHExkULK1MgWdgUQ8YhfvPlHlEU3q75Eqvs4S1EW12kUH5kDHjYD5kNCRJ0aXB8iuRZyjWXJj/6h2/wotJ6944WgJRRuGcSfVwGbLYPKsrm1PmwLwDK+bYSTy/57TT+w41h8hZNcA3wwa7dVF4GErGn6DOMJi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KDXfzpNGyMb/PBoMaJy+ElqiuI9R9Vgqp5kH6pKNJ0=;
 b=DHarq04S1/5PrSfC9TtgZV5wpJFiHThjZavJ9bK5HkpybESOdDfVF2hpeQaciKDc/5eH/hTmj5iVlj32PQ/eZR+fYQCmqLmTHSxs/86TI0pqSnrGMwP426IsDe9rKfumA5pAh6LZCU5ePc772HXE48wiK8W3fAM4NUgMxvzpkH3U7A/EaY8YJMjnS40d0CT3WaVxjU/GxEEh1svZ6yactGGNaIKEEKo7+aGGgEH9MlCZw9uXXugzGpTMP0ujfM+hkBHNpyymIsiU1fdvfQvDbevXASf/cq2aPGYt0bcXaTP0xBFSV1iI8Zmaq9sh/o8LnOS2SU08fJuCgeGq7zBA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KDXfzpNGyMb/PBoMaJy+ElqiuI9R9Vgqp5kH6pKNJ0=;
 b=sL5C0lmoJ47X5WP0j5n4iIOPMjdO0HoqdA/yQZRuIQbg+1PzXv4jSlA4HTzROiog65UVSqltVN0WUvbHGm+Qem2mPGy+p/fQGnwIZ3KXkfKMencG+dkz/jorWeLpWds+blkZxcgDI+dKkuCA0tXO8CmE5NxjYdsFHcQgEBmwZf0=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.21; Mon, 4 Dec
 2023 01:56:17 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 01:56:16 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 06/12] wifi: mwifiex: added mac address for
 AP config.
Thread-Topic: [EXT] Re: [PATCH v7 06/12] wifi: mwifiex: added mac address for
 AP config.
Thread-Index: AQHaIdVb3X5HEcLVj0OYO8mIKNMhc7CUP0kAgADN3lCAArZqAIAAoo5A
Date:   Mon, 4 Dec 2023 01:56:16 +0000
Message-ID: <PA4PR04MB96388677C8756C937534063BD186A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-7-yu-hao.lin@nxp.com>
 <ZWm15Nb4tZ5LfjFp@francesco-nb.int.toradex.com>
 <PA4PR04MB963883143033EEF9880D3ECDD181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <16fea36e-a831-47e6-8983-da205ff7a8ab@quicinc.com>
In-Reply-To: <16fea36e-a831-47e6-8983-da205ff7a8ab@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PAXPR04MB8669:EE_
x-ms-office365-filtering-correlation-id: 72195946-51cc-4991-0fcb-08dbf46c33ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zampH9+phY6aIVGXx2V/GEx7ngq38O6Jf8mmCp8GNFdK2yYOhQtnQz25IHeLGpjfT7hUz7Cgj+J6U/UPhgVKj8sj+SZ3v3XlO7NZMM+oSc9Wmicpw1swzjrGCFff4psN5gIlADjCom/lvNP0BegwjffVBUd/yPLVtRCpzt02yssquy31rbACqZOBb9D6FVPGMSfH8CJGIwuu59IcizSSFy4roPlAlfwRBUKaQSyIlPGFLSzvzePdkdzZZ7fjLzNLhHfG7HMMWYBRVubf172FEv00pbrpBJ5Wy2Nn+IolTCIO0L2eDK4RIG0kDO+/ndYx7eXrEBDrnP9Z90ftTtGfeAYSbyIW7Bsadl6bE7mvPmGl/3j35fydqIQnQHiB3oa+niaa8/CBPGz9kbqg/cV4jpF9inyAwRxpkppvKFQYZ9SgaHS6XMuEC/Um7l8cFioizSlB/MLKf2Sv940GpFvBRedVCtilZQj/ejTu0m0nPoA/b1Sog9kDICLOW9yEUogsfMmbV6JT61VF+w9Cd9/qPVR4jHQDluEoyBH2wWi0qoLfsI+XkVWduIv//b+sQMhL4cFl15sGcuvW9YzpFZ10RSVaVN2UiY7rwkzunjvz286rVAYg4My43jzhPaGsWNFHP6FP5MwD/g+nvPZfqwSF0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66476007)(66556008)(76116006)(66946007)(64756008)(66446008)(316002)(54906003)(110136005)(4326008)(52536014)(8936002)(8676002)(86362001)(7696005)(33656002)(9686003)(122000001)(53546011)(6506007)(478600001)(71200400001)(38070700009)(2906002)(26005)(83380400001)(38100700002)(41300700001)(5660300002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Acbt39mWKi8EOzXiSgE99qsNrTv4pt9Ic0/HTMuLyrmQhky0lWoZmBCKavV8?=
 =?us-ascii?Q?LmE5GGjz2fFcaxO5UavqdOfYmtyZkW2EOGnimzWPGJm760RGNyleyvo4Bhwn?=
 =?us-ascii?Q?qk8l3vJY5hU88eqaJ1RYpbPQ/+N7bKjnAa6taHVGtvIDgklQhrFU/YBxSH9W?=
 =?us-ascii?Q?q8Q/pH18RBwG958JmDOAg5vbl+7XhozC9T7RIqhatLuTyoOHJ9UPPtSh/Fzz?=
 =?us-ascii?Q?WV7Cfgo+KYHYpyJCMYIvBwPLq7v1stvefgp5wSmO3Z5x1VKtjP7XkW78bVvy?=
 =?us-ascii?Q?IBku13yZ9c8n81OjbO5YrOgQ9hN2WoQZMiwcjY9wiwCM2EQzRXVQLcmUcwDE?=
 =?us-ascii?Q?32q+/yn2CwlV3/wZ0gIoaaDGHrV52cjWCdufRSzDO/mnDLX6ABuxkU7FOMaO?=
 =?us-ascii?Q?S3rDbUnMe9QsS8n66SyRrvMb3Zd32LVsI7tb/nY4Yh6rRhKMLbo8zgeluVlZ?=
 =?us-ascii?Q?bjGm+BD4/nUH1TVDVHdbuSZwYMZas9wqjbOpY7c0U0sUlsBonRICispAbdK/?=
 =?us-ascii?Q?MXhZVoEjj4UgVCvUSKai0agUGvANxlkd0yy2iB6HXJ6hU+DLBx8XOPIRi67z?=
 =?us-ascii?Q?fQlOtCwYf+Ko3jqtsCo3tpST5IMCCv5ENMTkPajuwzPbmIryUusSV6orfm7z?=
 =?us-ascii?Q?84Cbcerql95IuJW0BM/H8TURzE++S60ao+gSSavlriqeh+nXbi6AaOXAsWq/?=
 =?us-ascii?Q?QHJxbR4MfUo6v9/CQpFIhIxi3P5Uk1mldVGu0tWSGg+TBq+evJFunBOooi9S?=
 =?us-ascii?Q?UPEicLMYBWAfTP941QrGInjp9XIQeBarsb7TQMWYivXv5GnvkJdaPkOdeKpm?=
 =?us-ascii?Q?T1RLXwnxDgWVi/jB6v9pjvbR/M2Fn1uVMPxZ85QDXyDO1ht3Qws6j1tLgGGx?=
 =?us-ascii?Q?H76x6CYHQOJsiLpGxlB21dswhWzsztzYQoTpJN6M1CeXTcHHHyf06nCAT5MI?=
 =?us-ascii?Q?Ijr5w/WUUk9e/zB8LUqCNwhKu0ouZGdPVc0xR7V5NB/JwWLDr5g+/MKI8CI0?=
 =?us-ascii?Q?aWHPQxTxinQpJtJJV/MjErjWqPzOanPS/CixmKXxMaxbtfEtD2uk//RRe1uc?=
 =?us-ascii?Q?BYixhWca/2b1kqZSc08kDLrW/AxQMpfDwFJtyJ57h9R6YGx/A8PLdGahei9b?=
 =?us-ascii?Q?gh4bOC9o92/yptj9mWsV/bGdqW2LqWmTBBiBZblm+bhKhZuPbR15HTRkXUwS?=
 =?us-ascii?Q?XwvpnHi7LpRKBeT4XCg8FECa71pGQMlkWwN1463EJ93CPl9lkg6YqRzFbEbl?=
 =?us-ascii?Q?5ZeL2qZm3A5QHWl2Q/4oOKp8UN1QFtHsBCO/KqZRX1pWM7lzg6ERwZbPuut6?=
 =?us-ascii?Q?xm5Eio4RrO0CGSG7kYrx7RKYzg/n4UyWvimdjdEt0P5jhFlx4NrIxT5TA1WZ?=
 =?us-ascii?Q?oqv/Sy7kCw/Jf7wtqCQCUCWGKJBduc/DhsBN1QVdy9Z/Ab7fRORHn6CpAEAi?=
 =?us-ascii?Q?qXj4ye9SRE32/IlKjH0nefGIoz7rPFfacDmCT56gJgQtoMuWcEToRjYzBl+0?=
 =?us-ascii?Q?nkcsJMdXCYlswcYMIICFokbk3c8kZxdWCsR+EuumjTDXUxreBHCJNv7R7Zuz?=
 =?us-ascii?Q?vYntDjZSDuiLv8WWhWMkrApknKrkNXfDsaIsm6NH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72195946-51cc-4991-0fcb-08dbf46c33ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 01:56:16.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgeIsU9FjOA1bB0GNu6JK88660rpf0TK4hvL96uuwAIToRPuwtB6pyn7SFdgcBRabQs2p4FEKGWFEdffIh+7vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jeff Johnson <quic_jjohnson@quicinc.com>
> Sent: Monday, December 4, 2023 12:13 AM
> To: David Lin <yu-hao.lin@nxp.com>; Francesco Dolcini
> <francesco@dolcini.it>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v7 06/12] wifi: mwifiex: added mac address =
for
> AP config.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 12/1/2023 2:50 PM, David Lin wrote:
> > - fixes tag
> > - cc stable
> >
> > I don't understand what does this mean?
>=20
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fsubmitting-patches.html%
> 23using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes&data=3D0=
5
> %7C01%7Cyu-hao.lin%40nxp.com%7Cb1c2bb38d9024e40659c08dbf41acb78
> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63837216815151639
> 0%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DD2ZPx9Fxcm
> %2FYZimLDD9Qj%2BXtwvzoKWjpGbruB9zF4K8%3D&reserved=3D0>
>=20
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fstable-kernel-rules.html%
> 23option-1&data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7Cb1c2bb38d9024e4
> 0659c08dbf41acb78%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
> 638372168151516390%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3Dr6va5Ynyztm57GwGYEk0zGFV8oBWdr8Iuspns%2BynrnM%3D&reserv
> ed=3D0>

Thanks for your information. I will base on Francesco's comment and your in=
formation to separate this commit to a single patch.
