Return-Path: <linux-kernel+bounces-24615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDF82BF30
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE511C22EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266867E7B;
	Fri, 12 Jan 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="Hys4RrtU"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2041.outbound.protection.outlook.com [40.107.114.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C567E74;
	Fri, 12 Jan 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EORi3uxMNPorIm5jYKsmwrDC4gPYT72VnxiP91OxaCaletaJzxKRWPiLRN2/RU9EMuUhkdRMS4WqDsoC3AcZlGmIW/AmNtR8Kd3kTrxsFzMhgeWZ43ZkWeVcs0e/RWsNfxlymC2ByJOQOj/8M+GrDcnBt0io38T5WACNkaO/z4iKppamNgYAk3vqIIz6Rfam7iPwoqyUC0vIFApHLGWlAgh3Xl85djdeKi+60qsIQ/YiBaamctxj4VbljEqRtQPwB8rDnnNBScUgOKDDX4SSPz6e+6DycFp7ZUzYHpGMpBaEP5yXsJ9zbtyAtpetrFbAwrNuzaF+BskVYMRctdb7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9z4py1TEqctWJ31Mgc7rRYPo6UMioUajJ7MZTtuYVc=;
 b=GUo5j5X8qkOd3AeK+qJhgswWSuylLW6ZApf60f2vEQcJeyLNr8weeTPBgJuOMF0Yd5Y9mXELGHCAfYIph4dUrD9wy5X12OYtROkTZAV1jy1q0A0X1nwhpSHGeNE4wBsXVcyESzwbvy4RiJBfI7hI0Mv3r56gTR34LOQiUhkbPIw17gA5XdkaicfGON7HvOWBdqsld2OMsgR6zzGrSFa2bMoTW09u733S0bdvJHbSTSOdpLreEcSilWejp3CSoosgfABc+D451200ghoYEdhmgCkyKvEyaiEBxbFCatq+HN9HGNr5hIXyUz1w3/j2aUfmi2foVO9QGBVn8J1fithERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9z4py1TEqctWJ31Mgc7rRYPo6UMioUajJ7MZTtuYVc=;
 b=Hys4RrtUI5D2IoKHLaDurC1MNF9kJ8TP/EWSu9hk9es2lnug1Fh5HNcDnyE2XtD8ARNDeCl2TtZInPB7MqUvj6yjrbQm2pOKtMt356ujU1W95EuFrTSNNjD2jm4gO69NheMYXw1UcJxyd293ngUQL6kmIXpSUPskeeM3doQESNOoXTg38fxGXV1r7+7Vk1BrHx58wDvwVWSEMjul6c4p6n5YNrReHj5E4xiS39/oFYM0paiptVZwDiFmgNBzYRqSV7TXwUOKsZChpK/3WVwQjuTF9V2Q8Dw4pq2P7UukvJ3LyZ8gDADoY1dEp+y0AsXkp8ynvz1ny6ttASurZeuYCg==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by TY3PR01MB10060.jpnprd01.prod.outlook.com (2603:1096:400:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14; Fri, 12 Jan
 2024 11:25:18 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230%3]) with mapi id 15.20.7202.014; Fri, 12 Jan 2024
 11:25:18 +0000
From: =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?=
	<junichi.nomura@nec.com>
To: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	Derek Barbosa <debarbos@redhat.com>, Kees Cook <keescook@chromium.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: RE: [tip: x86/boot] x86/boot: Ignore NMIs during very early boot
Thread-Topic: [tip: x86/boot] x86/boot: Ignore NMIs during very early boot
Thread-Index: AQHaI2uaswWtxdJdRk2imQ4QifdYgrCSqoWAgD1UjoCAASrP8IAFIjlg
Date: Fri, 12 Jan 2024 11:25:18 +0000
Message-ID:
 <TYCPR01MB83897C240167E5F8E2C01521836F2@TYCPR01MB8389.jpnprd01.prod.outlook.com>
References: <170133478498.398.5261666675868615202.tip-bot2@tip-bot2>
 <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>
 <ZZvXlyW8Khmr805c@gmail.com>
 <TYCPR01MB83893DE956B1BF965231F27C836A2@TYCPR01MB8389.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB83893DE956B1BF965231F27C836A2@TYCPR01MB8389.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|TY3PR01MB10060:EE_
x-ms-office365-filtering-correlation-id: 8c642bed-7f35-4c92-632e-08dc136127e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z4fBHMEWjwNOzHzFpkdm6dXYyqfsYBm0Ao9M0Kd5f2ysrZDxe9Uv3fgL/Z+7AbJMhlYfy/iGLA5SVpT3K07/z2GoMbJlfCqgDXlNyX36CEZ6eO6Ex7ZKxUFzup0BJSKZ/xeft3X3ipZdeVZMVd3kx5GpUejwac3+oekBcPSpWBR4pvB9fSV7/QP/8xCxI/PlWg+B+oYoOKY7Nt02KqMBo6zsRAVWmxq/gEpgDDzXKe0SmyC606cqz8TU9n9YOpnBtsvAimg/wqziF58nJnJWSoOTRQfB/K1LwBn7ArFfSl4qqkBualCX4a2Eu8jeerVV98NWGSPNEdVBUcVn3kft/7K7mopjMi2YoMBeCLzDzI1PFBozzOnxenEVQSXDYe5MPCkTwe0RRd1DKYI98/vvWY8ZS7C88r0SNaEt+BDRr1g4KOffD7vt5wVrQlCoECBGHfArL6p2BI/o/5JFvb8NWJdRPoyDP/nIBGH3K+BVsMblIXKH7GKa9Vp98bvdL03nbQIe3V6vZ5sh5wKjrOeyYDYn7WZFd8JvB5UHmsXNQjMoDGirpEAliEl31m+jittdEsfi4RTgVqgShJFVBVR9QOgKF/KMsshW4rTw6jeSSZo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38070700009)(55016003)(26005)(2906002)(9686003)(5660300002)(478600001)(7696005)(71200400001)(966005)(64756008)(76116006)(54906003)(66446008)(316002)(110136005)(66946007)(66556008)(52536014)(8676002)(66476007)(8936002)(7416002)(6506007)(83380400001)(38100700002)(99936003)(122000001)(4326008)(41300700001)(86362001)(33656002)(85182001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?YjRkM0pBVWhvVld6dUFOckY3ZEpvOFVnNGliRjZhM3JpRzlxcGdscjRx?=
 =?iso-2022-jp?B?VTlteXkrUmtjcjA1UmVxcGZwSlVadW5FNlZJK3RZVVpvWC9ia0g2QXky?=
 =?iso-2022-jp?B?WnVBb1lSNUJCV0IvYTkrZ3FFV3B3Y3JHaGNCRVk2Z21ZV0cvY0huYWFl?=
 =?iso-2022-jp?B?RGZSellhaW9tMW80TDJJRi9ndmNnUlIxd24wTDdwOWtWM0NtRmZKNHkr?=
 =?iso-2022-jp?B?MjdnOGhLenJGZ1lpWGQzL0ZHUm1yUC9qa2M4cSttcElBUEJ2eUJmYU5C?=
 =?iso-2022-jp?B?bVJ0RHczNGJCYTFXVU54V01ZYXB1ejNqdUhSdTRCd1dMWktQckpBQ2Jy?=
 =?iso-2022-jp?B?TmZta2pnUHFRaUpBS3pwL1ZwaUJ1Z0ZxbUhud1Bvbk5vQXNiS1JNdFVj?=
 =?iso-2022-jp?B?NkFOS3pKYngxeStVQWp6ZE1KbnVKdXlKMC9YZVNlWk1qY0FRN1RibWh6?=
 =?iso-2022-jp?B?ZDdGL2JGNWhQbXlPTFJ3Y0Z1d1pGRzR5RlRmcnpHWmt6YldrTFNFTlJR?=
 =?iso-2022-jp?B?SzZZcnA4Vi9aTWdXOTcxUlNtam9jRTNyK1dNcUNFa0g0cmxhU3M1dVQ5?=
 =?iso-2022-jp?B?UXQxN0VMcGx4MWZodUFkczhnUC82dVY2bVV0T3p0aTFiL1g4LzVtUXdy?=
 =?iso-2022-jp?B?SldlMEMzYk9KZHhaZTFqYVhPUGo5Q25wT2pxaGFEWkE3ZGlOWVRCdkdS?=
 =?iso-2022-jp?B?ZXpUZXJsdytta1NYS3U2Wm5nbktKNlJDWjdxUzlURnV4WW5RTWJQUlZU?=
 =?iso-2022-jp?B?OE1HZWp4ZkFhNmo4Y3pOWHV3ZEhCTklRbmdlWWE2cFllcVFsNkhPTzl2?=
 =?iso-2022-jp?B?MWRzeHVweXNuT3NKNEdzT0JxOStKTnorVWszYjIrc3dmc01TTGptallM?=
 =?iso-2022-jp?B?V3l3UG8zTHdBTE95RzZaUHpSQmQyc01tWUgyeW83MnZNeld0YXRodDFl?=
 =?iso-2022-jp?B?U2tWTTlhaitPYmh6aUl0T0NiK0w1aWVKanE4Sysvc2NGL2hLSTgvckJZ?=
 =?iso-2022-jp?B?WDA5VkNRd1dFTUp1c09yQlczVHpubFJkVUt3QlNudzlpbTkvTWhYbG1i?=
 =?iso-2022-jp?B?Y0VXVm9QcC80aXRzcFUrZ1ZENkp1QlNXcXNYMCtCbEw2NUdDQUc1c1Q3?=
 =?iso-2022-jp?B?NE9vaHo5NXdxa3A5dlVCVDJMc0hybmJwenZZeUpIVlFqZitWbHdlVXBn?=
 =?iso-2022-jp?B?N2Q4Ri9BalRNMzZZblh3VEFTeEFaUG8zTmhKZDdLNUp3ZFdnaVhOaTVj?=
 =?iso-2022-jp?B?UFQrV1NOZU5lUGVMV2ZqN1Y4V3oyVzBkdXZzbHU3dm5hY3JMWDdnd2kz?=
 =?iso-2022-jp?B?NUUzMXpyd3BDL2F5ZTA2TXRiNkZaUG93SmdhSkN1VytnRFFLU1NDdHYz?=
 =?iso-2022-jp?B?SStZYUtqc01IR1NUZmh4ZHQ4WlJYdVo5TzkzOG12cUhsS3o3TVRyR0Fj?=
 =?iso-2022-jp?B?aEx4ZU9vVEtKRXRKNGl4OHNVVmVWeHdSK2RyVkRHdkJVRmNMd2dWR2tk?=
 =?iso-2022-jp?B?bFRPV1FxUU5xcys4R0x2TmVVWmU5Sm5rVHlRZU9PeDFYNnlYK1l6bGha?=
 =?iso-2022-jp?B?eU9VRzAyaXUzNDJTbE1YbkZWbzFsRG1DakRPa2dPK2NCNisrVys0ZFZU?=
 =?iso-2022-jp?B?Zzh3YWlQNUJXT1RFdXppS3FIS3BDUitGK05EM2NuRUhwNlo3Y2g0UWhh?=
 =?iso-2022-jp?B?eXplRHd3WVlVbERJM3BxblVXMXVVKzlTNkY2Z1Vuc1ZhVFp1d0Y0QTZO?=
 =?iso-2022-jp?B?cll5VXEraExIRmd0eU5jM3lMREVKUHM1cWp6cmx3c2VoeUFydjhFUWtY?=
 =?iso-2022-jp?B?TythK09OV2F2Z29TeU9ESVNiajZReVBocmY1RWJoeDZPcHA4UHlEdERY?=
 =?iso-2022-jp?B?MnA0RFZpeFVPOWlBeHh5aU5KNjdKL2RJVjVldWd3Q2d0MnZPZjFxYVAw?=
 =?iso-2022-jp?B?cDFnQ3BXc09YYW55Q1pVY2pMZDVhQ2Y2cmZkT0k2VC8xRXpRS2JjYmFx?=
 =?iso-2022-jp?B?RUdWcENCeDNPTHhEdmdISmRzYlpkREVoY2VzRHZra1NwMXcvMFNvbzZD?=
 =?iso-2022-jp?B?clJtdnhscld4emY2OTlMT3NXRFlLZmF6aFpoZ1JPb2l1cjRVbnk2ZXRi?=
 =?iso-2022-jp?B?djBUNzZrYXJQZnM4TjNSVzhFYytKL1pKTk5TYlpaTEhrbzZPR3lFa1hN?=
 =?iso-2022-jp?B?S0trUXRjYWhtMXR2SlU0bjQ0U2hhNmZ2V0M3dnZqZk12Vy82NkI2Z2dw?=
 =?iso-2022-jp?B?RThnRHRYUkppRFZHMFM3NG5rQ25XTHUwT1ZhWGR5aXJpVXZnMnJ6czVM?=
 =?iso-2022-jp?B?aDM0OQ==?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_01E3_01DA4595.746990D0"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c642bed-7f35-4c92-632e-08dc136127e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 11:25:18.1486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGjk20sLNjLYLfhac2sNB4eCkjpX+oeRarTMXB+wXvEH72/wVzuQEnVMYKIItOVGpamm/z7MkFhkj31TuVB4wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10060

------=_NextPart_000_01E3_01DA4595.746990D0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

> > From: Ingo Molnar <mingo.kernel.org@gmail.com>
> > * Borislav Petkov <bp@alien8.de> wrote:
> > > On Thu, Nov 30, 2023 at 08:59:44AM -0000, tip-bot2 for Jun'ichi Nomura wrote:
> > > > +void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
> > > > +{
> > > > +	/* Empty handler to ignore NMI during early boot */
> > >
> > > It might be good to issue something here to say that a spurious NMI got
> > > ignored.
> > >
> > > Something ala
> > >
> > > 	error_putstr("Spurious early NMI ignored.\n");
> > >
> > > so that we at least say that we ignored an NMI and not have it disappear
> > > unnoticed.
> >
> > That makes sense. Jun'ichi-san, could you please send a patch for this?
> 
> Thank you for comments.  I currently don't have an environment to send a
> patch without white space damage.  Could it be possible for you to apply
> the attached one?

Sorry for the noise.  Finally I could send it out here without broken tabs.
https://lore.kernel.org/lkml/ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp/

--
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

------=_NextPart_000_01E3_01DA4595.746990D0
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
aR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYjytEdvfkxz1WtX3SjtecZR+9w
LJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0rpD8KkPj96sy9axzegLbzte7w
gTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG71gpLdB1ZhP9IcNYyeTKXIgf
Mh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyfG8lUzpUNZonGVrUjhG5+MdY1
6/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mvSa0te5Q5tchm4m9K0Pe9LlIK
Bk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc4pgkQE5ShxYMmKbPvNRPa5YF
zbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0x3FFTnmhU+5t6+CnkKMlrmzy
aoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4wggF6MA4GA1UdDwEB/wQEAwIB
hjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCisGAQQBgjcKAwwG
CisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBQAKTae
XHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi1xzWx/B/yGdToDB7BggrBgEF
BQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjYw
OwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L3Jvb3QtcjYu
Y3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vcm9vdC1yNi5j
cmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4ICAQCRkUdr1aIDRmkNI5jx5gga
pGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcnbHUStur2/nt1tP3ee8KyNhYx
zv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79YIgbYWATB158tvEh5UO8kpGpj
Y95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1Q3BTNKSrHrZngadofHglG5W3
TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXrdJPKadpl4vqYphH7+P40nzBR
cxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERgnz6SLCjLKcDXbMbKcRXgNhFB
lzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75AI2v8qwFWXNclO8qW2VXoq6k
ihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4mEPq9GsPPQq1UmwkcYFJ/Z4I
93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb5CYPnt2LeiIiEnh8Uuh8tawq
SjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7ZcnuCzCCBrYwggSeoAMCAQICDEaH
sr4bt0RnJ8OJezANBgkqhkiG9w0BAQsFADBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFs
U2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMzAeFw0y
MzEwMTMwNjQ1NDdaFw0yNDEwMTMwNjQ1NDdaMIHSMQswCQYDVQQGEwJKUDEZMBcGA1UEDBMQTkVD
IEdyb3VwIE1lbWJlcjEOMAwGA1UECBMFVG9reW8xDzANBgNVBAcTBk1pbmF0bzEcMBoGA1UEYRMT
VkFUSlAtNzAxMDQwMTAyMjkxNjEYMBYGA1UEChMPTkVDIENvcnBvcmF0aW9uMSgwJgYDVQQDEx9D
Qy0yMzQwNVIyMzYyMTAsIE5PTVVSQSBKVU5JQ0hJMSUwIwYJKoZIhvcNAQkBFhZqdW5pY2hpLm5v
bXVyYUBuZWMuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3A3JDZBygNMzTo6i
Ssk4sfKLVAS+Qmaa9jvJJnkKWFfS7EAhqsY3q8bxISaFka2EVo0ZWa5ERQf/WzD75WnSPpI1Gr/V
IPUos8DmB9a8SoPqf9/eRSOqG9vpk8aA1I+6UgvdAe/qeeGDW0lHxsdAZ6/HwAmclwMreKyZ7thE
O7DsknbqYvk3Xmv7JhyfsxQ/PTd/Q2SUzdNtftGl+n9QTvJZ9S1tN/R+rqPDIJey0Gw41yZ2F9ib
sGvlWc+1pUULr670xx8WAEN3FZAZsbB/ogMtyCL1eH/abqiTllfiAZZjQWUeXvT1q+3cEMr+Gap9
BuX8n1+ylZByb7wXQ8myCQIDAQABo4ICCTCCAgUwDgYDVR0PAQH/BAQDAgWgMIGTBggrBgEFBQcB
AQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQv
Z3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2ln
bi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDATALBgkrBgEEAaAy
ASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jcmwuZ2xv
YmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzLmNybDBJBgNVHREEQjBAgRZqdW5pY2hpLm5v
bXVyYUBuZWMuY29toCYGCisGAQQBgjcUAgOgGAwWanVuaWNoaS5ub211cmFAbmVjLmNvbTAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiw
oJIwHQYDVR0OBBYEFGt3hQiwRuOVQpsnbpZxYwip1PsnMA0GCSqGSIb3DQEBCwUAA4ICAQCfb3uN
tiplDwGA5LL5G6h4ZMVNEgETMOeR9pX7gXekL8iiDnqRk/lJi1aPEUQKu0kq56rvQS/SWFb03jU4
Wj7dcOlQ+wS/wdMnuYk4XsD37r0skdDN1Vmk4ZJTpPAS8OHjhnpAByLe3pXKka9JVb4J8ldoUTaa
Z09i5qmNzQiaKp5eoHPKu/p6O5i0kIkpI+831iYNk5/FgMKt37IcNf6EnxYKIbv2KYF1SrveMPOC
KmZrM6Ta5wllsi2TNwUGN3/9t4bHmz3fxdT9zZu4Fwewt1/MRyXHSGVFHZg1/h3k8Ap7DlZRgLQa
WJnS0JIpRw8DYK5uY/AY8noxGkcbor1Zlp2yr1uoHejAEOILvJFoOxWjvfCI7J06oAPXhKs+KrMZ
1cV1PrjORjU1pl3U+8Q61akqJhYi0h/aC6M9otXYvtNPgJv3rH6IuEJiPM+Dvy+9Xj3H6pKgMy8p
tmSGcwOZcdYp8dRP5fe5rK/h86jR1JfOVHpl9vFMeNHYqINESzPrLZ7p1Pp7lxoarmJWrpLT+pn2
t9W917wbVKHHHQ/9ol/8UZRSfAYxdc3Alz7DI4EoZJd4qBTGLHKXTHEJei0Is6mrIB1HmkF0CZse
bfTogx6Xd86TPTqCuGNKscLQJKAGbWehsA4CPNwDfjq1ipaSf22MXtgrI/eCogGOcN/+7jGCA2gw
ggNkAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNV
BAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDEaHsr4bt0RnJ8OJezAJBgUrDgMC
GgUAoIIB2zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDAxMTIx
MTI1MTZaMCMGCSqGSIb3DQEJBDEWBBRYfDUlv+b3U/uYaw+kclLkMqaNHTBxBgkrBgEEAYI3EAQx
ZDBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9H
bG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxGh7K+G7dEZyfDiXswcwYLKoZIhvcNAQkQ
AgsxZKBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQD
Ex9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxGh7K+G7dEZyfDiXswgZMGCSqGSIb3
DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFl
AwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAID
MAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAbDTOAi137riMwyme
62dIc27VM9PLTOe9e3vKGar9RzBcJpbna8JNellzD6qZvXDzNje+de8zR7spQJVoXmpiuFHblNVd
mZLxnpKKxlZit0IK9JAnjtklgLdtnSKN/hngKXPh8pjZzmTyJF7HWX0dMgsdFC5l0lSVM17LgH+t
mo8EFFrClJB+9gh+cIoHaXbm0XmULDGYCYcXg7VpgTZVYaRfV1hojvlZUBmWZHJAoruJlWpoWhRU
Tk/xf2b61n69ezila2u5BkBdAqlfIuZD6XlAQ6P3CzwAIRs8r13nRPMu11WGeBHOYBV36ofenELt
p1ffQ74zDy3U4l6oJsw30QAAAAAAAA==

------=_NextPart_000_01E3_01DA4595.746990D0--

