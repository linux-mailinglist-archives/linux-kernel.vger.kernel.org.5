Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600EC8016E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441858AbjLAWul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAWuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:50:39 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97AC129;
        Fri,  1 Dec 2023 14:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkYeBt4sv1K1vM6P2fwD8Yzup0YT86EOe8m672kh6lKOXXKw30Giq4OHissyMKOelLCotCqGvbWFlCbDFCDL8nyLhuhu9KGEYRs6SKl5WdE03KEU561ukcZGrMshoOoREJjQ8OkFiLfVsftfQbcdrK1v/vNP0x5kOSEVY58iyWn+oHaIv3kgKsR3SfmtfDE6kghuyZV80IjHhhJdn2o8M0e5B+eu0YbZbFj9AgRv6JU7WaXdKYsRHDomfCVJQ30xzC9wb8yuizksNbPdcS4pKOkfSW78tTZo38wXuGHQmPZ7ODdbz2HBpWuwdRIAMtKS200sghjHf1ZYxNhCCJF/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH3JU8tiBQmZSqC56T8xYsWWaKj5HaI1inpVR2RCuuI=;
 b=lTbC9SMWIzbeD30lQbnb8SK9vKAXZrnA/i/y0KNphQ/HmVIiW7ozjIHaMCPl230MRLw/9rN25QvFIq+smHU7jakcESU33Xiui14eBh4MEyiL5YDpr9+Z/jisYZHQhUY0PirguvAF+JsIrxIi4LX0ObDQ1Sh+ZJ6xwYGQv6JAkeXpByqqozWp8TfzyIOjys/TLCWfvnGtrizX2vPfO98rT9PqE6rmO20Pa8bi2qUEyMRYhH/TvQqa6qhkX4vZZXEeqNlQ17dIPU3hDhycsdakW2hFGsd/JNQplC1KlKTiQLuwOMftuO3m8ztFVUatel5CS+8jMASGwVVs0kodbS1d/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH3JU8tiBQmZSqC56T8xYsWWaKj5HaI1inpVR2RCuuI=;
 b=GmfLb25NfmD3fsGhNtjLAxhIlRSNrD2IU5NanfoxxHzroTOdhlQFoVFHmYxgKWxmQradd9zApOWGcXfjVvCP7j0D5HnPRDtHuyAcltLbWs8uxuBGaL63+QWLm9Hq5CLYh/qusdQ7bj1acEslr+TPaYiVFlxDKTbt/iBWGAyjYBQ=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 22:50:42 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 22:50:42 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 06/12] wifi: mwifiex: added mac address for
 AP config.
Thread-Topic: [EXT] Re: [PATCH v7 06/12] wifi: mwifiex: added mac address for
 AP config.
Thread-Index: AQHaIdVb3X5HEcLVj0OYO8mIKNMhc7CUP0kAgADN3lA=
Date:   Fri, 1 Dec 2023 22:50:42 +0000
Message-ID: <PA4PR04MB963883143033EEF9880D3ECDD181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-7-yu-hao.lin@nxp.com>
 <ZWm15Nb4tZ5LfjFp@francesco-nb.int.toradex.com>
In-Reply-To: <ZWm15Nb4tZ5LfjFp@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB9PR04MB8218:EE_
x-ms-office365-filtering-correlation-id: 950e7bb2-4ebe-4f0b-61cc-08dbf2bff2a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+qm3JbEWpcbF50sJkmjpFnH+uwyJL2jSLVq8p0uKRC+2yX9proWifdoDNIMAJtWXPavVKl9Q5IJndA4R/pvpwytRArgXDiVKSaZZM/wp5iukJskLwSSHSwU0rQ8RyJ6Tqw5LUVW/2IrDS9UJobgjHTmq1MkKPMK8f1M2jnWlcIIwDAyb0oLx1ngnhY41pb7UUP61tE7ydfNxFaTVcL3aszUSBz2PkIUR0qt5VXsGQ6sm4ymZP+b9StWqDC4Om2jroYVX2PYy1NJbURK50qYrd45Kyk6NyKT+I2n5IRmyEuGtKQgk3/Rte6EFW0rBvpkZTiaAGbepGzcGMgr7vNBYB1b2pgGN5YTQ+tXeqkZWhViRjUATPJxyDca3N03DywDtZ5Fszjh+kCixcdMz5Hc3BvCnGBEjx1/6Z9JQ4usiFVmfBLhrjhrWdzGDiwWiRyLssbocRQKLkBhucxRrBUtKTtF9AlpPKxiYPd+DvRW9sQUQCWySrQx50iAlfKVjjlHgeFIs9a+b4BQScc7LqnRZPXQsQsPG+nAtGyViwNVb78gB4Dcj1DkLr/cIV+wmXZgTMwSdXDvP+3566hwBnndrRqmEe3zRUXE7f56tjpgEgCn3MR6mnLakUjAZPagLj7vWesI9lNNz0f5NMSgUzBlvWtPRIunbo7zFdVYZZ3OpCE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(33656002)(41300700001)(54906003)(66556008)(66946007)(64756008)(76116006)(66446008)(83380400001)(6916009)(66476007)(4326008)(38100700002)(478600001)(8676002)(52536014)(2906002)(5660300002)(316002)(55016003)(86362001)(8936002)(71200400001)(53546011)(7696005)(6506007)(9686003)(26005)(38070700009)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jO8IMbexq5vC/AZw4j/AX1xolpmMVCQ1czHCaF++Q3gbXU9gcw5cpNZr6CyR?=
 =?us-ascii?Q?oDkBnPP3ozxYwzAp4tNrGlV0ooVIY44kNCB1WSSoU2owKXIF6j6MP2f+/txb?=
 =?us-ascii?Q?LlOAnqt3o0VqE8Kp81qg5wQpY2wJdvDJwHrAqV229Kgx0FdCD6s4EQ0nrEiZ?=
 =?us-ascii?Q?MYDpPB2rN4GoCC8fhLPJRNGYBxMNUES277aJKiFVQGhMxytu4tLyNPXBWA1z?=
 =?us-ascii?Q?ogNkByEEgLpzOB8/irWtri5CFts9qLHPtNGjgO596bNZrYz5O4JXPK36HzZZ?=
 =?us-ascii?Q?bN+KrUbeMkjh7ThA7wMPbu649ubb+x7//SgQpXryE0ZYdkHTdc5abNOUGi43?=
 =?us-ascii?Q?bee94uG7iD3DPdmUIl/wwLfTjrxrli829Q1hH8lId+BDXGy7N4kJxqrMJQg6?=
 =?us-ascii?Q?3420P/Fb/q8nDywWgvEXvOIrBXdakgcA4Kk8Z/wA4gQpQO9fESKgM9SAVPNs?=
 =?us-ascii?Q?KsXrFeU8XhtqVce1LUXITLd9NLPfsyGOyUJ7W+OxcD6ECwQb/fT48Ru8HTtT?=
 =?us-ascii?Q?Jvk5fDBLdPn8HOwS1d4RBlxIPNuanYgNv7szJ0zIy2rQ46oTqkS8reX2FPJC?=
 =?us-ascii?Q?eQIMLauw9gbTasmq3N/lGxt4zSvs0np8Pvtr+x+U+lA9XWoYGDPgRtEj73Bm?=
 =?us-ascii?Q?KpZ08BtRBRrWeAHw7B4AbvckqUadgA7RRj0SpVx7vCe8Z8jzIkZbSrmSPYIQ?=
 =?us-ascii?Q?QrK23xrmfnmoAtJhE0dOgT/m0KgEmcLyVkv0+XCiyRQLagIShksqEo/wvVvZ?=
 =?us-ascii?Q?baispTPFQz8f1MFznq5Vm2TrX3kbJrEDRfYJiaF8mhtcRyxDlu8PrDdLX/dH?=
 =?us-ascii?Q?Bx21f5ksrGcqYIHERnG6QhxqqIjO/TuYK5s8woam1ANjbKfU4nj2cm6lG+jF?=
 =?us-ascii?Q?OBnIRvWn2hs/mx4mOen61+CTxiczhgywRDHE6bbffbzsuEcoLfrl9P6JC+2S?=
 =?us-ascii?Q?60wItTx6PQP2xfh8FhtlwlyN8AzqxP6O7tyFwxrPPuuMK8iNjBtgTtcmqynp?=
 =?us-ascii?Q?55cQ0PcpaMBY7dsiyoNSGN4hPE5nVgr7F1FjkRf1C/Tkfaa1C5gnSQcR9bOB?=
 =?us-ascii?Q?l+WdB797JOohMDJbj0N96xoqR9VDkljqwdE4W4NvuR0VoPW3k0YVwVbg0IlR?=
 =?us-ascii?Q?/pu06JBZOPQrLKmaV+v6FWRrtdGe5W46dQpMHQM7YQtW1H7sp1LARsbn+75O?=
 =?us-ascii?Q?VBE71I9AyR4eEmusAsylsP6lcRdgqpLKD0mQTLkt4GZzHXOVYO7oKAHqnB6A?=
 =?us-ascii?Q?iwv8PSzyhc8WBJx4H07GVNO1r7D0DwYNBQZ35zE6rDH1TlsDlQA3edF18/eR?=
 =?us-ascii?Q?fg4JpNbfSKt2LqqpUXkHGBDAHo3muxQJCqI4n4tPbb3Kl3lxBMS/nmIVY+02?=
 =?us-ascii?Q?ocsM6SLYkrYiUVA52MzNlXxNjW0kKvEPlx3MSnsqF1ivftsfAp5eCvAqjrRo?=
 =?us-ascii?Q?aJLThDqsOOCeFyiMjP3uw9kEnMjM8SccUDtHqrZJX9+yl6TFdDsCBvn7JEsg?=
 =?us-ascii?Q?MUp4ltjms5+XL1U3cZLlSk29jPh+96iOK+1juLYkLITDVi98/uhmolt9c4rX?=
 =?us-ascii?Q?UOd72xlRrZ+3t3IS9ipJ5E3QFV0BIKJ0K8NEbiy7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950e7bb2-4ebe-4f0b-61cc-08dbf2bff2a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 22:50:42.5864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wSyEnM3RT4lhoivk1f/A9BR2GG06JkK9Fc5rpxA1T2zFqqIkV6KamEqlmXXtYuDzUuAyatZAge4p1atGqZDOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, December 1, 2023 6:31 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v7 06/12] wifi: mwifiex: added mac address for =
AP
> config.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Nov 28, 2023 at 04:31:09PM +0800, David Lin wrote:
> > Added TLV command TLV_TYPE_UAP_MAC_ADDRESS for AP configuration.
> >
> > Without this TLV command, client can't connect to AP after restart of
> > hostapd.
>=20
> Do I understand correctly this is a fix for an existing issue that has no=
thing
> to do with the HOST MLE topic?
>=20

Yes.

> If so, that great to have this fixed (and it looks like something I am af=
fected
> by, I will try it in the coming days), but it should be:
>  - separate patch from this series
>  - fixes tag
>  - cc stable
>=20

I will sperate this patch from Patch v8 and let it as a single patch.

- fixes tag
- cc stable

I don't understand what does this mean?

> Francesco
>=20

