Return-Path: <linux-kernel+bounces-16176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E09823A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D882C287EEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9CF1859;
	Thu,  4 Jan 2024 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="A8thkbif"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2042.outbound.protection.outlook.com [40.92.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B39817FF;
	Thu,  4 Jan 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbiIqSXa3jJ0dfNWpWfv1iycYLhDwpwc6/M/86o0IjaosJP/I865Ae2TghFNgx3776w71HStlfhh1zRa+nKxr1RaM2ZWGBC/GJf1nnX5maiDh6by2B7OEEtgYzt/HQR+b6cG4pxoWjW5axoRQzy0mQOetdd9EE2tAmvdKFeYH0AAEWtzJiKwGAVUFS/wuoXKv8xEpN9HtKXziStaPeHLHzQUTMmUhF7XZIAXrXWU0/pNd6WwTAyUbgtfrddkkbyS9WnrmTeYvkpaeZZG7wAlITqsh1Lb6o5hTFEX2CzrYpsHC+BpB2bxn34qoWoYZLG6uuHVbr0NLgvtAWyXYOH8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4SVdvKO4GDtSL1Ge81XBfQWz15H79ugPVzkDIKghUo=;
 b=nocwemmGTw8gniNG/YOJQmmEA4X0i9TFniTp5NisaTqKDgIN37nmmybXuXJGvU6hU6CZIb7+clx5vCMW6nvcWKuwEGAMEmETAGeaQMohkAzCqRLS00r7EhEj8KnFQ84GY1baEXfl0IDXOv1ADy/Zakvu3T920g74YJ8EAC9DaI6XUEVH0Y8Mh6gx5PtYB4A7NFp0eFlP3ORgs93Td3stUH+RHBzJjx/r4sv0BkTyiyqYvS9Z1TVVNXPWKhOW2tcksa5EPFTdqgBdlI9sVvTtfASkhaclel1+6Cs/cYLud3vK/bmO6hXInai+XW4CGXbCoFOkDX11ySzypHOZrQffWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4SVdvKO4GDtSL1Ge81XBfQWz15H79ugPVzkDIKghUo=;
 b=A8thkbifxPYMmlGeANWI7O55MragUBr2sqTQTHwsdptPnaq08yF1hGYIa9AoTVkoZVSqf46suC07PugsvXRtfcBwO0p48UAqIHU8mrWvz2BvaBZvYQxpiYe3crq6l3l8N8YtrFvVarzqGdu30QLkHQipN9CK7CjV7yDrVpNkeMyQ0WW435I9MMsKbyyY8agdQqbdXS/Ip+Xyk0d2ay9CuCkWXudGss2i89dbQsGKO9g464MdRJc6/Mi2su0cDqOnXffCGCBqcPVa64Qz1lx2JzFHHUNn3XHrd/ZtY467IbvMO35dre3AqEjDY8QScVSQhbPX61OyNZeEAuy/8+H1xw==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SEZPR06MB7412.apcprd06.prod.outlook.com (2603:1096:101:252::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 01:20:33 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::2925:f80d:d159:5e08]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::2925:f80d:d159:5e08%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 01:20:33 +0000
X-Gm-Message-State: AOJu0Ywkg01CHHE6HfwHMGFshhyG6XhW8rjMKHaHbgyOqNCq1VM0qSPz
	SSeEaUx1KBP+rB9Nm0Eeu36U0xkNmu6nsmj6BtE=
X-Google-Smtp-Source: AGHT+IFvhs1Udh0/qyCReUjmczeg1xy1PqWUksuWL1DiSlnRYuUXfS5VVIsZ1gz6pT6lZMZwD0+gs/hvSAlHuaNCT74=
X-Received: by 2002:a17:906:5:b0:9e5:df25:4b57 with SMTP id
 5-20020a170906000500b009e5df254b57mr7124359eja.23.1704330898408; Wed, 03 Jan
 2024 17:14:58 -0800 (PST)
References: <20231227053509.894642-1-allencl_lin@hotmail.com>
 <SEZPR06MB56080820EE51CBAE9C6B6B3E9E9FA@SEZPR06MB5608.apcprd06.prod.outlook.com>
 <08623087-bf1c-411e-87de-d40ffab6e2bc@linaro.org> <TY0PR06MB561188EBD127F8ECF4A7052B9E9DA@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <0a817121-620c-4630-93a3-5cf3173b924f@linaro.org>
In-Reply-To: <0a817121-620c-4630-93a3-5cf3173b924f@linaro.org>
From: Allen Lin <allencl_lin@hotmail.com>
Date: Thu, 4 Jan 2024 09:14:47 +0800
X-Gmail-Original-Message-ID: <CAEr79DW64Kow3KkgVX6Nk_UEp4qXp3=ENVQDjL2pDy-0x5mCMQ@mail.gmail.com>
Message-ID:
 <TY0PR06MB56119087B8D10E57F769BB379E67A@TY0PR06MB5611.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: input: Add Himax HX83102J touchscreen
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Allen Lin <allencl_lin@hotmail.com>, dmitry.torokhov@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-TMN: [XT8faHXj/izO5SVVM0n0VknWw+79Ma7E]
X-ClientProxiedBy: AM8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::25) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <CAEr79DW64Kow3KkgVX6Nk_UEp4qXp3=ENVQDjL2pDy-0x5mCMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SEZPR06MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: a78c3206-8f03-41c5-c212-08dc0cc358a1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	woTuQfGriMjg0fnuAGW1uT3/EwaxETC4Cd9fsGav6cHTE2+NjAXv6phRiNgaLlj0K6Ge+Zgcc6JA33PF3X5LOeYgBTP8DrA05lS1zQOW5bltzrdUEpPYzjchVKlcvG3XJxR0EEFbULKu6Zx185wzgwfDu+nPZkfj/NjDhdDRy1DqdRpre3+CBasYCMUDW9z0vcbRvutBxdOon3ESXMTzIBAeY04xNrfIJgFxRrI5Vw9YnwPkmNkDFbaG8ajTUkGht8tjuUUnzFGlfx4KlHh8xtPK5EHKJ924ay02GikcaIodya9/Aljj8hB+bInf2M1cHejFdP/hCOmyHaHIPLCTTydLyPmj/4NsTVKMnvsJdJBuNJq07kuLMz8qHiVc/4MG7aiW/0br0psPB9q0jv9uBdmIZd4zWH2gECxRlctSozlt2kklffD3HAEN4ZM17xEyBojbaTPMLkmVqKWUord8wEbXpKNG4nXAgYjDxtd5iCltEa3YeTU4nn0mzlXK+XLU2rfp6dOOIh81+XGc1YoAect9CelGc+Vi5l3NmVDFjEnhXqw5SxLCrdN/EvFck2MwlgAzAf4+0sIf+tUOPzDLE5ALgsAAENNWn5KIK1QnCNE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mi9oUG5RUXZScDhHelBQZXBJK2NHNEpWSjhJNnpPbmpjL2FaSFFwS0plZzlj?=
 =?utf-8?B?WVFzeFU5a0xoVlBYYldTQndoWTRPaDQ0cjlILzJZKzM1NEJQYUNxdlJodlVR?=
 =?utf-8?B?dDc3TUhyMWtZbXdjOW9McUY4Nk1HeVFXcjVWdWRMZmpTL2tGaHFkWlRYOCta?=
 =?utf-8?B?ZXFacFZ6L1RpQWc0MFc2aVRrUkl0amlmNEhpeVN3eVp0UVpnVkdXd3FtaGZt?=
 =?utf-8?B?Smh1Z0N2dzVPMFE4OTY5bW9SQVE3OXZ1aGVZMGN2dkF3VEU1a2REYnlpblhr?=
 =?utf-8?B?bjlxSVp4WEdsS1QyRm9XazFsNnNVWWNvK1lGSGVyTkI4YkoyMjRvd2RQb2Z3?=
 =?utf-8?B?bGh0eXlwRjNpR0FvazczamFpenQweG5DeUVYOFBmUEJkM0dLT0Z2MnFtbUc2?=
 =?utf-8?B?MlA2VzRjNlpVSXVObDRQc3FVZDIzWXpCb1p1U1JPSFVCckhndmZTZFpQMDJt?=
 =?utf-8?B?bnlpYmd1b0F6T0padlZZWVhJMmF6UDRRbGVrQzMwWVl0bGhuVTFIRjcwVlFu?=
 =?utf-8?B?UE9SOHVSa0NhSXhsUkNPSHFjeDNJYnpvdWw4KzdCSkoxbEFhZTczV2I3OW16?=
 =?utf-8?B?VjZEa3JhczlOeEtUaUJyd2hla3hoZHVMdUdQbHJYaFI0L01zOXFOeW12WmNG?=
 =?utf-8?B?aVE0V21ESGZicENLM2NvVldRdkpIaUFMSDdvYm4rK0E3RmpQNUpPOU55d1p5?=
 =?utf-8?B?Vm9LSStPbkd1M01ZRG9SRXdsZzFETHF3dFk3TFVCUndYT3ZrTjN1SldsNy9H?=
 =?utf-8?B?c1dYdHdScU45Zk9xQnBkdXBPcUlMNlI4OGNCVkc4Z3l0b0poRElzODA0WmdI?=
 =?utf-8?B?dGNDYWFkTStZQ0RNdXFKZUhHUGxLV0hUWE5yaGdGNmFTeDI4T2lrTzA5WVpO?=
 =?utf-8?B?L1VNNFZTeCs0RlBlRlhveUZvMFpudittbVk3aVdCb1o4SktCUWJHUkJac1Mz?=
 =?utf-8?B?TXIyRXd6MkdVNUdxVXVFMk9uVW1jQ0ZoaDVjL0ZFNHFzNmtEeGp3NkIwMnow?=
 =?utf-8?B?WUtIb3RSc012QitydTM1alNkdUQ2OE05cXQ3MmpiMFRjLzJwQ2lSUzlhaURh?=
 =?utf-8?B?bjlGS21hY2Z6bXlFMDZUNG5uMlcxcWxHczJ2Q3RCSXFhWVQ4b1dYMXV2dU1u?=
 =?utf-8?B?ejR2cGJLT0FZdnhmOXdBSS9BT01CTS9xdTRNZ2RlTGVPejhNV1hoblo2Q2ln?=
 =?utf-8?B?TjZISmxFV2VnZ1Z4c0JxVnF0L0tic0NQcGhUalowR05FNVpHMi82T2NUQ0xz?=
 =?utf-8?B?V0xZNUZjQm5ReE9jWG5sMGZMWm9VZUp4RTgwZlNVMUVKR09xY3J3UHFmSXpu?=
 =?utf-8?B?UkVObGZ5SW5LTm4vZW96eWVwS1BJbmhEUFE0a2ZpdjBQWmZpUjN5QjZ0Ti9n?=
 =?utf-8?B?YzhHam1BREpWSlVNNm4xeTFDQ2JObFpuaGRNc0xNZFc4aWpOUlRHQVR5VG9H?=
 =?utf-8?B?eE4xYTNWNXJFcklCbnpwVlltdXNDVDNRaGJnREJyMjJ5WjZST2ljam5oWnB0?=
 =?utf-8?B?dzNCdjhrcjEvV2dyNUh6VXozQ0ZxaEdRc1IraUFmNWNmdlJveU5IT2hnY0lN?=
 =?utf-8?B?VWFOWGJRY2ZkWFhTOGhnVWsyMmRqZkJKSVdFelUwaXF4dnh6YURTdXhqL2Fk?=
 =?utf-8?Q?7gU3mEisAe9jibpRT1uXLVbeVhzblfdpZ/RG6qbarvNs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a78c3206-8f03-41c5-c212-08dc0cc358a1
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 01:20:32.9022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7412

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=B9=
=B412=E6=9C=8830=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8810:19=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On 29/12/2023 10:08, Allen Lin wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=
=B9=B412=E6=9C=8828=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:36=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> On 27/12/2023 06:35, Allen_Lin wrote:
> >>> Add the HX83102j touchscreen device tree bindings documents.
> >>>
> >>> Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> >>> ---
> >>
> >> Where is the changelog? There is no cover letter attached, so changelo=
g
> >> is supposed to be here. There were several comments, so does it mean y=
ou
> >> ignored them?
> >>
> > Cover letter is not in this mail but in the mail with this title
> > "[PATCH v3 0/2] Add HX83102j driver for HIMAX HID touchscreen"
>
> There was no cover letter attached to this thread. Don't send cover
> letters in separate threads.
>
> >
> > Hi,
> > This driver implements for Himax HID touchscreen HX83102j.
> >
> > Using SPI interface to receive/send HID packets.
> >
> > Patchs notes as below
> > 1. Add the Maintainer and devicetree bindings document for driver
> > 2. Add the driver code and modify Kconfig/Makefile to support the drive=
r
> >
> > change in v2 :
> > - Fix kernel test robot build warnings.
> > change in v3 :
> > - Modify code according to review suggesions.
>
> Not detailed enough. What did you change exactly?
>
1. Remove function pointer coding style
2. Remove unused code/variable/structure
3. Use devm_kzalloc() to allocate memory
4. Use gpio descriptors to control gpio
5. All functions are changed to static
6. Drop all global variables.
>
> Best regards,
> Krzysztof
>
Best regards
Allen

