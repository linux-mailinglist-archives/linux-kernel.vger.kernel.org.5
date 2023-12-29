Return-Path: <linux-kernel+bounces-13017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB6481FE7B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4091C22D66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB9110A1C;
	Fri, 29 Dec 2023 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="KoIxRrYY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2013.outbound.protection.outlook.com [40.92.107.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F87410A00;
	Fri, 29 Dec 2023 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VujChWYOqMtN7Z0cFrkfkooU/jXc8tZ2DcBPylTzZPUNcjafsJ0ibKgO0qTjDfhGYmlDHd6kqdeMaA04KGwIBzBMPUUS4uz4RkiGAzmjHciBtYXry6E3TclLr4hcJb/eXZyapNUAk/EBr2mOhkGT+psN82H5me2g1I6hYHIr0g2uxApa9hPNz2jVobS0eHLPesTVh7qlnuNMaLsnDQ3kQW/MzbFOYwmi5Hw2V5h5Ydnh0CJGIk4PJFZV4OweHzLy+98qOSYC2zWSZVF4KFjThT7RKL9Kpt/PELZzEC7dNZD3an8A7CcfC0QDB2TNGcU3oSfaaeH4CQCh9avdPat9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYuhkeV/Lqtxfuo+6+a7mzQKn4HKrclB4oK/2U3G1fg=;
 b=eJ1U3Z6qm0FCUOcseCVKysr5hiKxaJFgchF8x8DTzVP2eQbgeal8Ci9VGBz9u90OfmEMtxeDvnVM29p1j5MJFBEwCBDeldQ6NJl+NbnvCRkyUzD8KrpfpskCBTiVb1aGKfm/Z+HYHW0eS1biw2bNJRQ9IYk2KjrDuicJh0XIZliv4qlNQ+zk2lfnrvG5R7etOyUbYISjedtSLRkaylAvgNkZZiZXVK06LOzpwesGP8SMEces8SBZS8W3zET+VyPcsdu+WVhhZAZfNOIrY9rVo1BtvvVS09x2JdLo6fjTFcLkpGK2nUgBPP2e1Ag4C5LPzdTMedu5qQ7WhAc8fJHQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYuhkeV/Lqtxfuo+6+a7mzQKn4HKrclB4oK/2U3G1fg=;
 b=KoIxRrYY1ZB3aCV8htAI01z5u3cssDaK7J9/8jTl4P+24/oK3e9g977yR60Oi7mPSXa5edbrriPso14Jk0JD7PHa5Gjj7q0Rl1khcLI5vDGK6+tf2QAghW5E1MnzFcBuyp34S2xgXJxdtspQWH7UzGcuzihUn72cGX+5mozFOGm3158ZAr6aJ2xCFw3Qs/au/iW/ByrHlENZo3ryZ6WM1D56tAClvmjkoQeUJAetO3Qzsknh6v9RYTZVOTpP5u6iPNOkPCIiNCHgoZnn5Oc1yFZ2vo5IkPI1RS3W7JDHOk0nqrF2HMsvLBSPf5ExS6Cfc/G6D4k2vszF7dp6tXI6vg==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by TYUPR06MB6052.apcprd06.prod.outlook.com (2603:1096:400:354::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Fri, 29 Dec
 2023 09:09:15 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::2925:f80d:d159:5e08]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::2925:f80d:d159:5e08%4]) with mapi id 15.20.7113.028; Fri, 29 Dec 2023
 09:09:15 +0000
X-Gm-Message-State: AOJu0YxX110+seslIgeKB55UGiPTNDiRcHbuyCVqSpzvZ0hw7Yp8lue0
	nlgJBdApwbvWQsgwidgqxWyTBun49XT7N+lszFk=
X-Google-Smtp-Source: AGHT+IEom+BhYMeoR9sWT6DtDhYHUvefLbL+S7H84MNZI+9eS/V5PV9ojmf1p96Lu9yaL8pByupFeEg+feM+WXCoO20=
X-Received: by 2002:a17:906:251:b0:a27:5ff2:121c with SMTP id
 17-20020a170906025100b00a275ff2121cmr1036455ejl.139.1703840951218; Fri, 29
 Dec 2023 01:09:11 -0800 (PST)
References: <20231227053509.894642-1-allencl_lin@hotmail.com>
 <SEZPR06MB56080820EE51CBAE9C6B6B3E9E9FA@SEZPR06MB5608.apcprd06.prod.outlook.com>
 <08623087-bf1c-411e-87de-d40ffab6e2bc@linaro.org>
In-Reply-To: <08623087-bf1c-411e-87de-d40ffab6e2bc@linaro.org>
From: Allen Lin <allencl_lin@hotmail.com>
Date: Fri, 29 Dec 2023 17:08:59 +0800
X-Gmail-Original-Message-ID: <CAEr79DVMwZ46WSgC4P5f8rp9ej+psivEcp0+zXKEot+jXhM-4A@mail.gmail.com>
Message-ID:
 <TY0PR06MB56114444CCF08BAA6EE340DF9E9DA@TY0PR06MB5611.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Add Himax HX83102J touchscreen
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-TMN: [7uDYR5cLFBv0MnOS19PSb4D2usYp4rhT]
X-ClientProxiedBy: AS4P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::7) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <CAEr79DVMwZ46WSgC4P5f8rp9ej+psivEcp0+zXKEot+jXhM-4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|TYUPR06MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 849f37b9-4767-4cba-eafd-08dc084dd411
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FPD1JIpTekBITaHGZb9oP+AYee9mAjcBsgZOMOer4+c5oDf+EMPN4oMAbrv2XEe6sBAmHrPy4gGJBnnypROP+0SScfAX87uHydcxuSmWkTVAod16YRR+bG7/ZmP0nrhW0U4EXOwSfJQsebBV/016gQaCLG3p4oP8SVs0cN3YCSCnGqQcahL//2HfM4khtknWGHPfZbgsOL9qlhy3oLVukVJl7PrPlmmqYprtxyqSNDqxlyQMmY/o7fO7jHktculHtp2NwLVNDKbIqZGq/UoRbSuC/tv29DK+ci4x+hWVscSyhnQLnoFMf1vRuy6JxExrTqZDjZYKmhZBf/YB/5+Z1lb3wc7fVBFPgZNVWwy+ie1ryzQ+y7edaBrks97bUk1NPN59pG4GMo2cKfEhawBYvPR7I/ktpl/jbGOM++BhJQ93ySyWHLt9n5LGLtlwak0Kueb16VPC+GIUSeFvjWoX++U4EVaugK7QZ1rHfQ6hO3XSV283fnfxijMAUgvDiVHvC15jVqr3CQKGAa9hr+rUYH2PsBnUaCzJlXXYOdkDyGv7m3nLpow85JcxAc2Ec8mcz1gIZ/uiZPt97MDXcjtNB0I4tRvnmsv65+IRUEk1gGw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVA3V25sVGdZdmdkOC94aFEvSXMrdWtjWjZmd09ieStqR2pNdVlNeWxBcktL?=
 =?utf-8?B?NzczTjZqK1VYM0xCWnZVUHV2M1l4a2dIdzJ5MVh2V21qdzVIWlBVUWg1N3Ni?=
 =?utf-8?B?QWFjTXhyTCtGN3ZwYjN5ZjhFV1RjNE9mMkxqWnZYTkRSWDNNUGlMYWFuZkhl?=
 =?utf-8?B?WGVQc1VKajVZRDlhaTcybTUyMmUrZVRKckpkdmtmR0lDR1V1bUZveXJ4a2VZ?=
 =?utf-8?B?emU1QmdMV0EyQjRMbm41ZTNCMDMvSlJ3eWNNbGdNQ0lqVHJKWGt3NFhaMEZQ?=
 =?utf-8?B?TXRkN0hpNlhRRlYrWVdKNFM3R1pkbmhjSUY3ZFptSzFwR0lGblNBY3JpOVZs?=
 =?utf-8?B?OVdHNjdVaG04c3VwV0xIZVBVYWtMUG43ZHpSOTh4R3MzMk9haE9UU0JMUGhN?=
 =?utf-8?B?Q21VSjBsUFpMTGFkRW9idmNZQTlvZ2NNazdOUzc4YU1RYkQ0MDVKQ0VvSkVh?=
 =?utf-8?B?WHRtNWFPdER3U2ludUowTkFwaVRjdTR3NHgwZVdjZmRTZ2RlRjRya2I4c3VM?=
 =?utf-8?B?bXFZRWdUa3RCTnExUk9UZ0N4RjV3NG5jUWRKVHhuZXVUU0wwVndvRmJ2Z3Br?=
 =?utf-8?B?T0xkcnExNVdHN3dTeEVRaUNXQUY2cGQvMXl5V2g2QWdSa1lONCtXbWl3ZzJF?=
 =?utf-8?B?N0x5NjJJUHY4WTVEaGdUb2ZhOWNoVEd2UVJsOEtYWXV2MGUrMWZrOTJMYXp0?=
 =?utf-8?B?emNqaWNTVzlDVWhOT3pxZWVLNVBJdEVISXdNRlNsZXJvK3k3SWQ4WEZqTmtV?=
 =?utf-8?B?MG5leWFYazdCaVMwVTlUVkJuR0tyYlpwMVUrRnFXV2dJMkZkWi9CQnY5azFZ?=
 =?utf-8?B?b2JFYjltVG5jUVZWdzN4UlFTbmQ3ak9paityQkdxc2dkUU9LVm1HT3Q2N0xI?=
 =?utf-8?B?MGZhazNGQVpNanJqN0hQSDBrY0NQN2J3di9ES0taZ0ZQV1UyUm83U0J1OHlQ?=
 =?utf-8?B?dEJBQ0Q3UEkyVis0ZHFBTFp6M25mUmlnVzJnZXViOUlwYUhkbTdheTBlTk5Y?=
 =?utf-8?B?QnJ4NUQwV1lKaHpNUXR5VnlXdzZybG15aGI2cHYwMGtnQ2RuQW5KNUdqSkJk?=
 =?utf-8?B?V0lWZHQzSUQwTVluOTY3SFBXVksrcE5COEd3RHVlbDhVZk15OFQ2R0R4SXpk?=
 =?utf-8?B?eXhzWVdnVVN0d1dCandTdzNVUWErV0xJRzRYYSsvcFYwbUJCREhXOURBbUJq?=
 =?utf-8?B?VmpEM3VZYUVWdUtTSUhkYnVmTHlyWG4zb1NyMnBxc1l6ZlRoWldmYlV5RUFZ?=
 =?utf-8?B?M0lvdGZJRnhRRjJ0QzlwbTg4aVBNZEp4V09YK0V4RnhLQ09Pc1hZOXhiNm9o?=
 =?utf-8?B?SjdvWUxxcmQ0RVZJR3NmeWFXckFWa3pSb0xnRXRUUTRHeUZrTVBiQm0yRUZw?=
 =?utf-8?B?cWw5M25Uc21vOHAvMm4zWHlqaFB4ejhDcDRqRXd0VG14blBRdy93VmwyanFk?=
 =?utf-8?B?Ty9xWlpmZ1ZlTU94QldreG0yOHMwaktWOUhRc2wwb1FFdXNoNUtaU0dVbkth?=
 =?utf-8?B?QmNYclF2RFo0bkJvVlV3aXIvMThzTVNRTVhERjF1MkczOFNqWndnVkRSOGxV?=
 =?utf-8?B?dk9iV05xMVgzanFWeW1VRkxJZVM0cy9VZDBGeHdscEJic09iTGp0dDI2c1JC?=
 =?utf-8?Q?fvs5+6q+LVZvYsIF/5KbJjbDUQ9XSIVPT5HOZ3nYCQTY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 849f37b9-4767-4cba-eafd-08dc084dd411
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 09:09:14.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6052

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=B9=
=B412=E6=9C=8828=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:36=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On 27/12/2023 06:35, Allen_Lin wrote:
> > Add the HX83102j touchscreen device tree bindings documents.
> >
> > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> > ---
>
> Where is the changelog? There is no cover letter attached, so changelog
> is supposed to be here. There were several comments, so does it mean you
> ignored them?
>
Cover letter is not in this mail but in the mail with this title
"[PATCH v3 0/2] Add HX83102j driver for HIMAX HID touchscreen"

Hi,
This driver implements for Himax HID touchscreen HX83102j.

Using SPI interface to receive/send HID packets.

Patchs notes as below
1. Add the Maintainer and devicetree bindings document for driver
2. Add the driver code and modify Kconfig/Makefile to support the driver

change in v2 :
- Fix kernel test robot build warnings.
change in v3 :
- Modify code according to review suggesions.

Thanks.


Allen_Lin (2):
  dt-bindings: input: Add Himax HX83102J touchscreen
  Input: Add Himax HX83102J touchscreen driver

 .../bindings/input/himax,hx83102j.yaml        |   65 +
 MAINTAINERS                                   |    7 +
 drivers/hid/Kconfig                           |    8 +
 drivers/hid/Makefile                          |    2 +
 drivers/hid/hid-himax-83102j.c                | 1096 +++++++++++++++++
 drivers/hid/hid-himax-83102j.h                |  202 +++
 6 files changed, 1380 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/himax,hx83102j.=
yaml
 create mode 100644 drivers/hid/hid-himax-83102j.c
 create mode 100644 drivers/hid/hid-himax-83102j.h

--
2.34.1
>
> >  .../bindings/input/himax,hx83102j.yaml        | 65 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  2 files changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/himax,hx831=
02j.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/input/himax,hx83102j.yam=
l b/Documentation/devicetree/bindings/input/himax,hx83102j.yaml
> > new file mode 100644
> > index 000000000000..872b478c5753
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/himax,hx83102j.yaml
> > @@ -0,0 +1,65 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/himax,hx83102j.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Himax hx83102j touchscreen
> > +
>
> ...
>
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      hid-himax-spi@0 {
>
> Still not the name I asked - it should be generic, like touchscreen.
>
I will fix it, thanks for your review. if driver code needs to be
modified, i will fix it together.
> Best regards,
> Krzysztof
>

Best regards
Allen

