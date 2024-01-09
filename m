Return-Path: <linux-kernel+bounces-20402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D958827E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0801D1F245E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE715A7;
	Tue,  9 Jan 2024 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="l+YIjFc7"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2040.outbound.protection.outlook.com [40.107.113.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83B639;
	Tue,  9 Jan 2024 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6SdoqOyxiCVZkkYu2tMRnEteN3wC5cJBysJzfuLYDsvJ9VgSekKyiqxugERKZqoZbblckp0ICdoeVKn82Of5mVWL3ht8iZ8Crubgz1xL9Rk56rvskzm6Pr3QiUEbV+JBpy3g7OgfYgThyvIOTo2a6Kul/G8VXqKmv8fKbAXc5V8rxyo7nRfrmOd4AMS1d6MTqkn8Bid9YAVZ9Qog1jKQ0djKvxVT5GKIOYa4+1a8quZoWMuls4v6yIUkRbAs+YWSGcuB+h5N7qTdf1rqAzsdBoNTosZ/I4+8O1dKBRTSm4qkN8mXoyqurY9ueptsdLsPjGD7zMj+RxhAreb9L+klQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxxfbKodtvstHH3Prsaxk6tO3wzT7o1XqQK4fU0eoRk=;
 b=JPD9FskA0t3vdzwf30EGdecyteloClAa4hmHIgoLe4vi9uvJW1060rZ2xw3eDAJFmvRXAjZJx8wZDWycgs9P3SMRIx8LFtgo/HcvukKe20OH0YRob4UTeW/Xj+OKrkjbQxtg++CDrDSZeuP9j8EB0xMu5ODG/LJcr+WYRztZG+yKscllKSaPNvwb8C3o35ssc0ApFam5CFhGfHiX1e8Ps5taY7JR+VznIZlZNINhVO5T4NW7D5sWS6fgShoLYnPD0LHw8R05v0mgSbXpA9fdALOqCR4V5jbxQPlYBAsStVluXrU0pDGg0E3xWCNo7uYehBL9uEFir8EKGaZDNwKj1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxxfbKodtvstHH3Prsaxk6tO3wzT7o1XqQK4fU0eoRk=;
 b=l+YIjFc7wMfC0IzaS/Z1QURNYMuFo1Ds09LeLRC3/d39Ai+R0URwpedmSXcMUbIjlNjJAuxBq/5ZEEJKaS6OF2wAiCGMW+WwLOXL1VWfUp06qBuldxvZgnyAgBVqKrkBfN58JdxUJNuXzUuECyO5U2uXUnm4L+/13detjOmT30Qur/wwUhQvmJ/utkXLbyeEHdx7MgUEabM+ZGH+rZAoWFxceo0eyHs2Vwx8XTTfAwXqUUQC7spLZi2xw6uERu2OB1xVLxVArRK9cY6VZ6iv5qdI3rDyhHTRvru74kC3DVYjHpWgeVIXRrZnCY6JG5KuJ/QadF7/xqe9aNSwix9fXw==
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com (2603:1096:400:15f::5)
 by TYWPR01MB10082.jpnprd01.prod.outlook.com (2603:1096:400:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15; Tue, 9 Jan
 2024 05:17:43 +0000
Received: from TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230]) by TYCPR01MB8389.jpnprd01.prod.outlook.com
 ([fe80::97b4:ef67:3174:a230%3]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 05:17:42 +0000
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
Thread-Index: AQHaI2uaswWtxdJdRk2imQ4QifdYgrCSqoWAgD1UjoCAASrP8A==
Date: Tue, 9 Jan 2024 05:17:42 +0000
Message-ID:
 <TYCPR01MB83893DE956B1BF965231F27C836A2@TYCPR01MB8389.jpnprd01.prod.outlook.com>
References: <170133478498.398.5261666675868615202.tip-bot2@tip-bot2>
 <20231130103339.GCZWhlA196uRklTMNF@fat_crate.local>
 <ZZvXlyW8Khmr805c@gmail.com>
In-Reply-To: <ZZvXlyW8Khmr805c@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8389:EE_|TYWPR01MB10082:EE_
x-ms-office365-filtering-correlation-id: 7d7ca756-3406-4121-f457-08dc10d24e75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3FuE+6oPXFa6jLwxA8fKoRS71q2PSRPeZcaBEqzZi2mQB6Hr22UYKGdfi9I1131XCH5OjONOLFXUp8D27EOmJXITRnLfnIRzDLxfFrujZklhVsuzVhTPLRq5jVsQaEZ9M4t4Y2KK8WDo8qXl2UR63nUofXa6dahYuN6pxhYoUUK7fMaDCKnT86y3rJz7dPlLpe6U6sjDQT4ZX23Fy8cEzzFgQL/6x1bkoRll6yfg7xeow9Bn6TsqcnwXW5CG9K1yVTgV5JgAvhv4VLqxWPdBOQLL48XZJCnaEs6W76R5FSJMt7eSraXygMBS9Rzgqq4axjJx+1qDtHNsAVeFBHM1QUmD90fO/3vb1XCDXg7qyTf2M3KbJDa4LZvnhMG5LHUm4XOmCpIiWtmttEpxppE4nKmYjKEx17d0eIMWU1uSQYXt470DBfzwl9kvHVvltsJzR0TK7J396W80KGPPFkZ7zJzOkkGOB7tBp83pQIIzWNTtwWlqbSKMErblPBBeGHlc2u6zIJub6R6UtWYlA8btCvp2Qa1E32JAJR8TmXLCXW29prqnkx8wn6c/6MaY3JKneNlPFS4p3FBj6SD+M9Jyr4xQDPS4A3+kPhVJnD09SQY3S+OKdUVHNDzqU87zkFRW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(71200400001)(26005)(9686003)(6506007)(7696005)(478600001)(83380400001)(4744005)(7416002)(2906002)(41300700001)(66946007)(66446008)(76116006)(66476007)(54906003)(66556008)(316002)(64756008)(110136005)(52536014)(8936002)(8676002)(4326008)(38070700009)(5660300002)(38100700002)(122000001)(85182001)(33656002)(86362001)(99936003)(82960400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aW5yek8raGNpUm1nd1pDZ2FQdlBCc2tKTzk5RnNFek9jNjVLdUplQjM0?=
 =?iso-2022-jp?B?bytQWXowM0pDbEdFQkdIL1J3Tm1HdE1BK3hNbUxxcnR2aUJUNmZnNm10?=
 =?iso-2022-jp?B?NVhrN3l6TFpPV0lQa2xUNlJFWVpPL3lLelRObktLTjRpUnhTdmpJb1NU?=
 =?iso-2022-jp?B?S0U2OUlmMnZjWWhzY3RHclVRbTVZN1dpUllybFQ2c0NjZU1aWjh5UXRF?=
 =?iso-2022-jp?B?c285M1dVMmR1anl1QzcvTzVuZW8rNXJIL1FqTjlyZmpTZzhlUWxkTXJG?=
 =?iso-2022-jp?B?OHN1bXZ6RzNvZVF1WmR0VkEwRjQyVy9mTVhLWk5wdTBtTFdhcWlFa01Y?=
 =?iso-2022-jp?B?bVZPK05hUmtKVW8xREROaFIvOGgyd09Da2tQazAvYUhKeUdtWG92Wmcw?=
 =?iso-2022-jp?B?aVMzbEZKZlRyZ0ZIdDhQb2dmeXV5SEZyV011YXp2RkFEeTlITC9oZ3do?=
 =?iso-2022-jp?B?OW1SemlsZ1hKTkc3dFBGZVROMWtnOTk5Ry80d3JtdXQ2dEpCR3RXdUNZ?=
 =?iso-2022-jp?B?RHhvQW0yN0wrcnNiYmJUQi9FekhVRDhnOGRtZExkS0VlSlJHRjB4bUFK?=
 =?iso-2022-jp?B?NVNsdTlLUkd6d3JOZlVNOFpBQkJJNENIM09tK01NT1hnK2NWTnJJZXBr?=
 =?iso-2022-jp?B?ZWN6aVZNUFhhY2JlOFRFZGxUbjRlTTRqajRGb3dQQXByL0UwMnB5Ynho?=
 =?iso-2022-jp?B?TktEWGZlSS80K05BeHFQY1pteG9oUXc2ZkcvY2IySVRKNmgrcUswY0tm?=
 =?iso-2022-jp?B?TUsyQjhPcGVpUkNwUVVWVXFwQkVCcU9CRzUreWFBYmt1bFhnYVk1UzBs?=
 =?iso-2022-jp?B?WGhIUUwwWFhzb1kxTkF5dm5EVzlkSjBWZStSbUxlamJPL2d5b085RVlN?=
 =?iso-2022-jp?B?a2MvaHZqVk5ZbzBNQWlYelJxTUowQVRlemtsSThIeU1oU1hIS3pOVjVo?=
 =?iso-2022-jp?B?dWpvMmJtYkhJR05pYlA3d3lBWk4ydDRsSTUxVVA1VjBmN2VZNmsyeUZG?=
 =?iso-2022-jp?B?ejkzUEhDaWdLOFlLR0FjQURXM3VpQnJwUld3eEFvZGtSdlJXQUV6YXlY?=
 =?iso-2022-jp?B?UGZBVmNLa1hZcFJEQjl5cW51ZzlCY2VFTklJd2QyZDloM0t5eUZ3YkVZ?=
 =?iso-2022-jp?B?OE9ad1h0LzZCOENlbDhOU0JOOXZreTJ4UUYvMitGcnl5WTJhTFcrVEFK?=
 =?iso-2022-jp?B?UjlFMmtmWk9xTXlZSUZySlA3Y2loZEdTSk5XbE12WHZkZEVKbHdTWmly?=
 =?iso-2022-jp?B?a05ESGFLRW9Fb2ZFTzdUWUYvN095ME9kd2JzOE1iQjI1QTIyckZuOU9l?=
 =?iso-2022-jp?B?Y0VRcCszYTFDWGsxZDlVajRvN3RzL2E0NDE0bXpUQXA1L1lhVGp1TG5K?=
 =?iso-2022-jp?B?TkNNMTRtRmtidzF6NS9aWFpUNjd3YU9CUXRWSDJMemxUVjZlbE9GNjd0?=
 =?iso-2022-jp?B?L2JSNDM4My9xdC9lbkJrZ01lUFNJL1JwNnBwZFBER09jWFlrNTJuNndy?=
 =?iso-2022-jp?B?TzFZWmpDK2JxSld3SFhDSmFzSjFXdmQwWC9yNUo0bFIyUW5wOVZXZkxY?=
 =?iso-2022-jp?B?Zmo3bnR6LytMcjJSY0hYVlEwUzVHQ0dhbDF2bEpoanQ1Y01VM0tDUmVa?=
 =?iso-2022-jp?B?clNPcVhjMTJDQ3RDNW02UFRjbWNkSWlhTDNCbHhJVW9rck5pM2I1c3lh?=
 =?iso-2022-jp?B?UkNwT2lMUHF0Q0xUMWVGZ1R2MjAzaGVTaklYVWdLVjBVUGRsOGo0TFF5?=
 =?iso-2022-jp?B?L29wTjJINEVwTWtreFllejU3bG1ORWxBdUxjaGtwMzhIMmNhUGRFQnFI?=
 =?iso-2022-jp?B?czgvZDZKUkFUYkJqR2FnY2lDYndjMXNJVUdTQ29BK3pZcitjRi8xVS9W?=
 =?iso-2022-jp?B?R1dwMHQ1VWsrRmUwcjlHYWZCdllyRnRQOUtXMFp3Q2gvT2toaVhUWGFy?=
 =?iso-2022-jp?B?d0dFQVJmZE5qRzMwUjRBdzV4REFFTExVYjNmenhaMW9xTnZ3ZDNaOXpZ?=
 =?iso-2022-jp?B?QTBPQjlLRlE4Z3ZzMW9xRkh4RXo3Y0U0WFlPR05NcHk5dWd1Sk5KUjdX?=
 =?iso-2022-jp?B?TWtpdUh5Y0RwZFBxeTlzMlJsVDdIY01MVnh1Qkk5c2M0cThKNHpFcHcx?=
 =?iso-2022-jp?B?c2ltZW44QkZHUVpvUVg5dG13YmZGSFQvQVdBZllMWWh5Y21YWVBtNEtF?=
 =?iso-2022-jp?B?bGVEQ21aakF6N0dhMHFGbFJWazZrS244K2J0MWJPRmRyODJwUSsxYVlC?=
 =?iso-2022-jp?B?ZXFkQS80aHQycG51bWxocDVPK0FLcE02NlNocjhscW5PNkFPcm5jY0dL?=
 =?iso-2022-jp?B?YnFudg==?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_016E_01DA4306.9AD64790"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7ca756-3406-4121-f457-08dc10d24e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 05:17:42.4973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvLHTQqQCTuhNJP5bLAvcHu4ScWmCcImhlAfrdmCHyXloWMLkGCDkz3SkFVn40hGJrKiyky2AOPV+N3UMX3aIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10082

------=_NextPart_000_016E_01DA4306.9AD64790
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_016F_01DA4306.9AD64790"


------=_NextPart_001_016F_01DA4306.9AD64790
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

> From: Ingo Molnar <mingo.kernel.org@gmail.com>
> * Borislav Petkov <bp@alien8.de> wrote:
> > On Thu, Nov 30, 2023 at 08:59:44AM -0000, tip-bot2 for Jun'ichi Nomura wrote:
> > > +void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
> > > +{
> > > +	/* Empty handler to ignore NMI during early boot */
> >
> > It might be good to issue something here to say that a spurious NMI got
> > ignored.
> >
> > Something ala
> >
> > 	error_putstr("Spurious early NMI ignored.\n");
> >
> > so that we at least say that we ignored an NMI and not have it disappear
> > unnoticed.
> 
> That makes sense. Jun'ichi-san, could you please send a patch for this?

Thank you for comments.  I currently don't have an environment to send a
patch without white space damage.  Could it be possible for you to apply
the attached one?

--
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

------=_NextPart_001_016F_01DA4306.9AD64790
Content-Type: application/octet-stream;
	name="x86-early-nmi-add-msg.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="x86-early-nmi-add-msg.patch"

x86/boot: Add a message to early NMI handler=0A=
=0A=
Add a message to help diagnosis for the case if someone wants to know=0A=
what happened to NMIs during very early boot.=0A=
=0A=
Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>=0A=
Suggested-by: Borislav Petkov <bp@alien8.de>=0A=
Link: =
https://lore.kernel.org/lkml/20231130103339.GCZWhlA196uRklTMNF@fat_crate.=
local/=0A=
=0A=
diff --git a/arch/x86/boot/compressed/ident_map_64.c =
b/arch/x86/boot/compressed/ident_map_64.c=0A=
index d040080d7edb..f2858a373099 100644=0A=
--- a/arch/x86/boot/compressed/ident_map_64.c=0A=
+++ b/arch/x86/boot/compressed/ident_map_64.c=0A=
@@ -390,4 +390,5 @@ void do_boot_page_fault(struct pt_regs *regs, =
unsigned long error_code)=0A=
 void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)=0A=
 {=0A=
 	/* Empty handler to ignore NMI during early boot */=0A=
+	error_putstr("Spurious early NMI ignored.\n");=0A=
 }=0A=

------=_NextPart_001_016F_01DA4306.9AD64790--

------=_NextPart_000_016E_01DA4306.9AD64790
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIS7TCCBYMw
ggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsTF0dsb2Jh
bFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxT
aWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2ln
biBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24w
ggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEULLIK0SMbr
Wzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDKRN5zlE7z
p4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEGxb7ibTIG
ph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDqjDyqtKT2
85VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MYvms2sjnk
rCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptOTloLR/MG
Nkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4LsgizYWYJ
arEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiDD9H/3zAR
+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPpDW+4Ltxn
bsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8EBAMCAQYw
DwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYDVR0jBBgw
FoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVSzZ7ABKCR
aeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSWtJVewHuO
mXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x362AczdlQA
Iiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARcphXveOB5
/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8ga907E48S
jOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQddI2aZzm
ewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/07kwIwdM
jxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yLSqGQdCWn
sz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsfrSQ3y0Va
TqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqDCCBJCgAwIBAgIQ
fofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJv
b3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0y
MzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzMIIC
IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn26Zn9VtoE/xBvzYmNW29bW1p
JZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlchatYqyORVBeHlv5V0QRSXY4f
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
GgUAoIIB2zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDAxMDkw
NTE3NDBaMCMGCSqGSIb3DQEJBDEWBBTecwbCDVtpu3DyMWvHlxoJadkLHzBxBgkrBgEEAYI3EAQx
ZDBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9H
bG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxGh7K+G7dEZyfDiXswcwYLKoZIhvcNAQkQ
AgsxZKBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQD
Ex9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxGh7K+G7dEZyfDiXswgZMGCSqGSIb3
DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFl
AwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhowCwYJYIZIAWUDBAID
MAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAfw18FYBSKNZEyUBx
4c9q1d+rbBAwOTqvXZ/NE/XkgPO2YOyTSE0+mkBVCXJV2WrfL9XYzwp61AsvZx/bVm8qCso9cf3E
KS73Qwlh73XIyY2nudosVurRo2rqdfEIvA2bw9Yd2KiFgVT2A+mkYC6TcVzZnlZifqqpdXNvW2Ap
JEd3Ld58mpgXlymQwadwmKP056x21KzuV4H0smHsKoRlpaPjS3SyD4hYtcKWXyVbBk4xDh9CClO+
iU4KnXFvYrkJLtdnzNte6gLGlfE+JsguJwqPtZ9RCWPNhl78MPdkkEw5FsAm6YMZbH9gyDISyvHW
R7OMv4iA+Ypohedc4uZXUgAAAAAAAA==

------=_NextPart_000_016E_01DA4306.9AD64790--

