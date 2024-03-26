Return-Path: <linux-kernel+bounces-118384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1AC88BA00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9BE1C30C89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02D612AAF9;
	Tue, 26 Mar 2024 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Qn20K9Ii"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazolkn19011002.outbound.protection.outlook.com [52.103.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DAC128374;
	Tue, 26 Mar 2024 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432449; cv=fail; b=gPQQ5lYCcJHlWucCRPB3TtOac0OHXAJmjlA7U2n46ZgLfKpwVtrVI9fP2qqHHXrWOXkxu5dzAHl2/Be4gMZwfZLD483euH7xkRYGu+GIAC2+tfYjfdO/y4nRkpNnzZzsqo/rVevJCVHjjDtUkWy6PsKD5cFolgYyP3VPMjFcRsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432449; c=relaxed/simple;
	bh=HHSU3X0Qq/w+o6K+8PyZrUfilHzaw12lrFFWuMEjjGw=;
	h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:MIME-Version; b=eT71kYaVEz/AmZghfviPchAOd3uy/1AeYYR62VPaJ3gAkITEJfa1KpAfG00/HflzANzf2UuDZM4CIAFCfHVtAs/Iz2bWqtknXCFqTr7YRmVwOe2l4K0qCt0J49xxfd7p5Ss4zF+JrAmgBNtoTYCbvhFh9oAs9qSEH1qKpiY75Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Qn20K9Ii; arc=fail smtp.client-ip=52.103.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du7N4w/ufCYDdEoBYzQ9EnnYeRYdCZ3w/N7mIM+HR18xjWgBKxK+z3fxFQSEO9oY7mPHi0/ab6CVhDZBBdpKz1Bn6ZjHiqLYD7zVsokxdnGf2FdVyqPmwwWGeM2JyyzK9iI8crffUJNj/ZNGEovxmOQsytcMsaYYiqwR18sBg8vY/EFZ7nE0iYSKeF38djxjBfjbqD8ImlFf+ew2rkU9x5Xem67tybtPrh3VxP7a8ke1sC7YTfBJkx1q/Ha6v15wg49W+v22DfMk9vFIbllu7d8GlhjpgfKVFGUhSH0PbbtJiPIEwOWkJOa4AEI9fZQYfU/qbzjhwYdyEqS6eKiDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHSU3X0Qq/w+o6K+8PyZrUfilHzaw12lrFFWuMEjjGw=;
 b=OKFf3V0D/I9f6HP1VFexD9RPop5CKcFUDglYLjjXyIO2ZU5alFuvouM/SYvb1TWGEkc7fSM11eMBfEod/a0KobpwnhB0Z1sp4jGEkNcnUuaUw9YvgwPcIhcNA/6fFGrRaG0FQNk/TeW1P/c/m5ENGYPaqk5Wwnxux0LnCALsDUA/3ParX4kj+1BoMnD3oZ+22UEvwG5JRebnu/6byMdo6AtqXmxYMAzo0g5rylb4PmmmoH5Htoaxr97uwflb1YYNqwgL1GTSzb8KcktI4Jt5OF+8fi6iR4RWnDHZMJ4v2LUtXHFHS1nWw3S6uM26tdWv5ziu0tAAHl5CZtTxuuY/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHSU3X0Qq/w+o6K+8PyZrUfilHzaw12lrFFWuMEjjGw=;
 b=Qn20K9IiwB2tPTNSFoJm4l5JKIreRjiH+C/t5bC5h3rSIgTiIZHJ7P5jJqFXh/0bzdlqHZ/MeZB/ED10dEHXd6rsKRab8zt1u7glYB+OUiGuWTMGS2SxOATikJIyqN4oAnP4bt2q+8wOo/oql5CWU7B51fVsgV+fkae8ZRCE/3nBkTzUvBisZykWlT1K4u2Bv1fBx/IIbz7mnvBxWHsTmzrltEWIyVBz3Pb9aowR9H1vds/HdpQX6Mz5y8XhIZ15DGpVlSAS8JwCa0Z3vPb5gA460Pn56cHP6+tndMSbgJs9ssEcpxB7CZ585AptRbDoYU8p+Ro34m75HWZQCk82AQ==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 05:54:04 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 05:54:03 +0000
X-Forwarded-Encrypted: i=1; AJvYcCWiFTwsO9wFMtWz4tWWY/kK+63+mDk8E3gQaL8FPPnfHdpo3UtxUu/ewYpI2baxTG9frfP1UkuXG8jJVemowZ+HdAoW/n2LvMpykpbZCfAImTLcTOIsQBJxsZIwkp82p0N5Jy9oEh7G2DwrfmutPZbGDE3L3Sz0aMo8XdK2OH+H2fd0qRhc
X-Gm-Message-State: AOJu0Yz0/2mT4P8K6uNGUG74NFkFqZf1m+m395saNAsBwMbP++U/R9Nz
	4UhsNhYU/hfp1R/oTtZhtMEjp45+KLZp8DbPhC5u1Eg5zJE/wjSYgVHwvzsOvYBCJV/csxM1v6c
	OdI0QrPA7lh8JfOVxenbdx6OgSz8=
X-Google-Smtp-Source: AGHT+IGZb2mFOSGUoq8nUHTiVYP4+d3OjE0yEOFDYWjs2N3sfvGuZXepVJ5+Ep0plg3NdGQSUWQJMRJwQ9oZVkvV9CI=
X-Received: by 2002:a19:8c42:0:b0:513:c61b:f207 with SMTP id
 i2-20020a198c42000000b00513c61bf207mr6238609lfj.9.1711432028645; Mon, 25 Mar
 2024 22:47:08 -0700 (PDT)
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240322-mammary-boil-f9a4c347fba1@spud> <20240322183009.GA1227164-robh@kernel.org>
 <20240322-rectified-udder-fef9102f58da@spud>
In-Reply-To: <20240322-rectified-udder-fef9102f58da@spud>
From: Allen Lin <allencl_lin@hotmail.com>
Date: Tue, 26 Mar 2024 13:46:56 +0800
X-Gmail-Original-Message-ID: <CAEr79DWArMUA9_qyxVK0dzrwx4m9nKASn8=ZXAHuc9=1zG_fjw@mail.gmail.com>
Message-ID:
 <TY0PR06MB56110ADEA805B68BE2B887069E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, dmitry.torokhov@gmail.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-TMN: [JH6xze97NJZ/qKU3zCI/ktZ89AzyzBBI]
X-ClientProxiedBy: SV0P279CA0046.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:f10:13::15) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <CAEr79DWArMUA9_qyxVK0dzrwx4m9nKASn8=ZXAHuc9=1zG_fjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SI2PR06MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4d2eaa-cfa0-4525-d292-08dc4d592414
X-MS-Exchange-SLBlob-MailProps:
	Z68gl6A5j2+di5YwL2kzS6NfVWp1s0uFEvQ9o4Suyg01dynp8LUgS36DXFIrsp8LuVYXTTuMRdYXy+Cz0XMvExIfwRuC014PiTAi5Olq5cLEf338jbtoeO7f8RH6MMH5KVhGIVcg2K6c0fWE6HdYzvCtZxoN15BnGleT1URW169ROos0MkKUi5XFX/CfWXzpkz4wu7k47Ed7ttUuXI1bzDECjDNyBiSGmn35XQotQ/mV/modIQ89LjqXGvL77hL/Em16y/pxQhrKZY0bedX/oIazkmkdbuAXWaVqerC18lKYQ2snu5ppbRHzgV0rATtVlyIeUzlXSbUOzai0LeAv0jgDZwlcFqtjlbBGSeqVuvcVnPVX7qqk49cWqkRkUTuCYgRkVjqlludcdcagTwRC6IyfBqz9wUUNueL6t7D3qu22FvttWue2ndugkVbRuz9nffu/XJXr8Yn6Di0D+UAHZG6PNQmnvBjRJ7gC3D/Byv+p/01kNnysM5HdUNivZ3R4XKDeuhVIU59o5Cpx9kKre1StZvujn7wXcC+7PptnBZaj5ixlANcJ9Z0TEKmw0SlgIE/1dUE4tBEAwXK2L1m324RVps60w7irfjCgbIwf0NCTRgCsmSi/XwgCspFeDodEMi1XrVHQ2YE5VDhK5wlFLls/vCXRTwytV4UlnPORWzJP2BXf3CVylBznwJmFLFkzrCxRJGWj4tzBAiWBV9CwCDZgL4Et3fEX/etYDvwfqQGWmKuWl0UitSQl375l96pXP0YOGKX97o3lC+90IJ5Ff/H1cuindmc7nQDxP0stH3GX5mK6xnLTd2WGFO0POYZS
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sODpT5BvUGp0oWZ5CyiZka56eSaRHGwsEM/9EB7QLcvGmcwDZrMnrxGRsmfBMHZtDPx3OA4Q1Sq6SFW3cqvdMiUj4VTj1B22qcrxKKoB0/633PKi9Pj996hBjXIeoBDnxlsMLiIn1OVS9jc5BBRuJpAlxtpJ/Yt7YMMVlEaknvuYMDMZLNEx3w2m674VV1ZTVk0/KQR4NpmcgAkxjV0idXAvX5LlT2MdpbWboBLKgjf5r2RGBqJkbTEG5iz19A2fyuvFfiz7C+tQlcAcOTJafMOXxDyF1xQnUgLavUneSvkUtspCD4LqGLhu9+kPOry/MhNEMLnbI4efBF614mfPk6QFEXjDabq7VyuIl8Xu5X3VvMDA4iAMy0wiADhf7PeykFG3NrG0kW+q5Z76GdOPyv9XgefA/DhcHeQG5b5I1NwFW+VBKj4dzQH0OuVOQ9pSbpWvhekcURYbrtXuQPrUxdErtuow4pGy/BfhuBNowezNdfpWBKPkhKOFTPxE396uefMyhAF0t4zJV8xiWEG7vnYeTGJdQ0UGqeRCd/JNQZKCHb+PdiKLoOPXsidpCN5+emjiajVjz4XtQZcg/ybqvBy1yfBjqX/iu8Rq9F9UXqn7s3aqd4ONMtDqYieJm7FSdpQ/qoKFWI211OK62m5ZBdkEBAzmJ7sExPyyY1SF3Uo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjgrQmlTL2NwN2hSR0tnQXUzQWkwUThJMTBxMFhLWmpZbkZLcWRNaU1BTGVF?=
 =?utf-8?B?RHlxYmwveUFIT1FoeWhjOVlBemZTbWUvSnQyVnZ6di9JR2tNVVpNZjl1OWE5?=
 =?utf-8?B?a0V0a0dJMm56Q2dFTVpGZjNwWUxNcjhYbFBYT0Eya1VlSjdpOWVIUC9LZUgx?=
 =?utf-8?B?bGFmRWVqbHR5aHVmTHZOVk5nVTJkL3RtQXY4NnIxYUJhWEFNUzhoYnBiVFo4?=
 =?utf-8?B?NjZRVjlJOGdlTFJzemp6UHJoS043UjE1VWdMSzVibFhIZ2NKc1pBWWJUeHl1?=
 =?utf-8?B?c0MzNTBCbHNMdWwvU25rclErRTMrTmhGenhmbGlTa3pRKzZGb21temVBVnFv?=
 =?utf-8?B?VDdPVG5kd3dJRzR4bmlJSjVoTkxOK0ErTFBEbXhaT05MekpiajlMa3kxTWth?=
 =?utf-8?B?UXE2UzZBczlLQ1F3UDhaQUFiUU8zUVlCbWQ2dDJZUHI3ZHNzVGVwbFd2MXZr?=
 =?utf-8?B?L2FEbDJWVHdVUEtoRm1zOTJtVzBKajdBcm9kNUZJcXhnZExuVVdGbHlwUktW?=
 =?utf-8?B?N1dEblZKZkY3OU1QNEQ3R0dCQlFENzVzbWEzSkNyUC9haXZNemxrWS9tOEE4?=
 =?utf-8?B?Snl2SmgxSkF0b0djajREa3FHU2xsczgrQWVSeTZFTWVwZk5OazgzaEpTUWZa?=
 =?utf-8?B?ZjVqYVdvcGxwL0dKR05jcHBsZ3VRaU1MYkRsbjl1MjdMdXRiMVBUeVVCSmFq?=
 =?utf-8?B?Mzh4cDhseTkwbm5BVlJnc0V3NW9WU3BjamJoNjNnZkFTcDBaeXBFSk1peUVD?=
 =?utf-8?B?RkIvaFV6KzFJdHVTYTNGaWtvTTVTakUyeXBaaEJKZzhaSEg3OHd3VW45NW5F?=
 =?utf-8?B?L284YlB1YVdxR3hkdlBJVTZsKy9BTW1CZmNMMmtwTHNreCtMN2MraFNhSE1s?=
 =?utf-8?B?TWlTTHFwaXhtalMwWnJmYnZEdXdLcmJJSVA0N0k4Z2lkYlpKVXg1WjI3cE90?=
 =?utf-8?B?ZUt3R2llZjhYc2lnVk1XZ0xJK1czSEJCSlFJcHBhMDRObFBEMGNVY2hSUG5r?=
 =?utf-8?B?TVBLYUtMNkJSVU40cmxtUURpZTRjSC8vVWxwZGs2RmpVcEp6QmlKc01BT25H?=
 =?utf-8?B?S1N5QXlUMlFKVHpFUDhjaTQ3bFJNQklNUEtFcGdLOXRRV1pCVFhXZzBSZDBO?=
 =?utf-8?B?MGJ6TmY1VGtLZFhoRTY5Y25OMGdSaG94RHJvaDk0ODU4ZVFabW9JK1RpQitz?=
 =?utf-8?B?ci9ndU0zaktXb3AyTHNxcVhuS0ROOFExd0xLVllOcUlJUW16QzhXb1A2MXVV?=
 =?utf-8?B?bk93RFpRN3VqRVVmaDJMWWYyYXBSQm1PaTFzMTV0eVNmcXF4TjJhaXZWZDZy?=
 =?utf-8?B?RTJzUXFOQkFUMDdXcWZzanpDbFlCcWxZT2EzMDFjb2tqVXhrdTBZaDFERnFn?=
 =?utf-8?B?THlIK1JoSUZWRW5NUjYyZjBXWjZFaWNBSnZPUzFyd1BzNzNyOTlUWFlTM2xF?=
 =?utf-8?B?eHJOQ2xONmc4ekR4SVZ2U2NOQlNjSEFaTWc2bXo5dFdwSlhGeFptRkpzMWY1?=
 =?utf-8?B?RENvR1owcEtmaU5GVUNackZ0UEJjM0dHL0JxREdta0Jyejh6b0R0ekJvZ2ww?=
 =?utf-8?B?S1FOeE02eU0zWlhyMTZWZ0ZoTFZISU1yOVQwcXdwQityc0tQT1ZQZ3d6c2Ru?=
 =?utf-8?B?dUxFV2cwVG45S1dmSiszNXFSVHdObUljK21MNythOERPY3U5L1RnT25tTEZF?=
 =?utf-8?Q?FiLhUstBwFl5N16FCKYk?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4d2eaa-cfa0-4525-d292-08dc4d592414
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 05:54:03.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5140

Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=8823=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Mar 22, 2024 at 01:30:09PM -0500, Rob Herring wrote:
> > On Fri, Mar 22, 2024 at 05:54:08PM +0000, Conor Dooley wrote:
> > > On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote:
> > > > Add the HX83102j touchscreen device tree bindings documents.
> > > > HX83102j is a Himax TDDI touchscreen controller.
> > > > It's power sequence should be bound with a lcm driver, thus it
> > > > needs to be a panel follower. Others are the same as normal SPI
> > > > touchscreen controller.
> > > >
> > > > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> > >
> > > note to self/Krzysztof/Rob:
> > > There was a previous attempt at this kind of device. This version loo=
ks
> > > better but might be incomplete given there's a bunch more properties =
in
> > > that patchset:
> > > https://lore.kernel.org/all/20231017091900.801989-1-tylor_yang@himax.=
corp-partner.google.com/
> >
> > Those don't look like properties we want coming back.
>
> Oh, I don't want most of them coming back either. There are some
> supplies in there though that I think we would like to come back, no?
> Maybe this particular device doesn't have any supplies, but that doesn't
> really seem credible.

We will use Firmware-name in Device Tree.
For power supply settings, because there may be other device using
same regulator.
We plan to define it as an optional property for user to control in
next release.

