Return-Path: <linux-kernel+bounces-91646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C204887149B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF13BB230F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C653D0B5;
	Tue,  5 Mar 2024 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T/c6Of/+";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YibDayMa"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6153C6AB;
	Tue,  5 Mar 2024 04:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612189; cv=fail; b=O/jcJ0GOhccG6LuXgfvfqmea/h9+aeRKvX6CM+s3MbeVtnfO8XI3hy09XQRWtkyW+E+8OKbwUpvqQ0htWaMgf502wNMLX9WtId9RmXv0A71ZBe8Qj7p6jz7fmCrwDm05nTGqHWTEo53PhRj8GGOpjYPoz+xTDRbV+iXgE+V5vQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612189; c=relaxed/simple;
	bh=73daA4Z6iftg4+phFtJdnME7MiTbYsS9ffnByqnAbNU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXmBKvRl/nfWkJvjnyaTgP43xYLQZEHzFqFulfDgl/j+Vt8zjVHGyHpYxjjrUtSdaK9V6hmvlbwgX4o7tt/j8qyzIhzHO1L+aYUiu0AHdVlWFSinZaXxVpvXSCXrILAayJ7gwMANcy3/myeJsGof5H5D1axl1CK8A2sZ4+JVmwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T/c6Of/+; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YibDayMa; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709612187; x=1741148187;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=73daA4Z6iftg4+phFtJdnME7MiTbYsS9ffnByqnAbNU=;
  b=T/c6Of/+I3BUlGw0b2EqXQjxfpXFq443zqDNyuWxk2c+No2lDQjfmtNk
   45figQFa2wuuwdo/Imq9Rs1qbIBPJMECShdMxkfzLF60s5WipedtVJOTR
   /qPwcaoUWq458gDUAx/GL6qYcTmDl1lb2tmJcnXmrkb3X0w8IeesHQRld
   xot+9QTTwovYlLA1yTmQwP0LIr619dVqsg8uHJ2MUQgJz1fpuJCLi1KW5
   60Ird3YXf+4XlM7glrjcHQiR2eMAvrz3M/lxkY9AARWzP9CwjurVGfPuc
   eSSNQ03Feu8pEnT2F8tSA654lrgXtVOCJYCe62ogfuc0XcitQTHEZcYz2
   A==;
X-CSE-ConnectionGUID: LJDStIxTRUKdyuOFd3gNFg==
X-CSE-MsgGUID: huL4w7P6SlSyiVmf+7GMBA==
X-IronPort-AV: E=Sophos;i="6.06,205,1705388400"; 
   d="scan'208";a="17204805"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 21:16:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 21:15:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 21:15:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6+l00Ck8WZ8C2nCtdE1SjXfXuxmZfrncw1hrm0sDgFXzhVtQAVHfICYJ10DawkQFg4IQ6HQKX/fbA57m4ifGnNBP7lOqJNwPQEXHrGMf+PHC8IF1bwUac0sRp+j8XydnNQpcwMU6anVVcU2JBJArqxxN/651VaLB65El2LAaXRYo1tG3bk2uD2BL4amI00Fmlij4Bj7aMvk4M8ERY5g5vAoFZ39NlMZiDV77I4cG8/cgNG0tDzEEKdGx2yr723jqbgu6xiz5Y4ZZpfXIznSh+7GJ2pk9E7Xn6AGCmZY7IIUupv4ITDTvTOTeXcWX+b606KbaADf5Z75o59gu/MdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73daA4Z6iftg4+phFtJdnME7MiTbYsS9ffnByqnAbNU=;
 b=kN8UPyaVi+I7Ht7JsSsUydxLNUMsLrM48DK1acRxPvLiIydO80uphEyrQ0myFaODX+6OQTJUXtJPpbH6EjHQ2to0/b55OzkEzvxeEL/VCqhshjZoEv+IJD52scZrVjtFT7X0W30RaqKHX6gJcZxe9C96gW/DZRifwNGJDmdkyhtjsFQAKPcvOz2oCtKbjWD1tSfdKHBRk49wZ0Y8RxynpNiLc+z+ZX1Lf289n2rhSUpULc/M82qhoof4Gz5PhAiNcmu48h2XABWhmILl2Nwt0476L5NTZWO3N8p4ZzovmBr8nhykP/gKxKaL9T6hkJUe2E6MbBoVACyZkbjTE5lW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73daA4Z6iftg4+phFtJdnME7MiTbYsS9ffnByqnAbNU=;
 b=YibDayMan2MY/LA7rnEcta4ajvgB8K8P3ccHN+cjB45EdHNNsas4GgRt3W5AsIrPTcgU1AxhwNsOyG4V+rf9asDTko/L4JzuaKCtTT6BM7v22Gpfw8omf78RC2VAup9Ql1IWJO/ZP4HHb05cUUKiJB8lWyt5kZg328QL19OxLdxrFc8Bcpa/uZkWqok6kUI/cgdbWtwsfhKWZZeEumQblwQ824M4LB7PwtjituzMycg0SDpDETytp8vpBpX/Y/XkagxfX9XF8CYAZ2Stoq5OcDtcFrFnmDegQHUkVivEd03trO+MRTiGCq1jMYn6ShTAiCoJuWHz5zL3/VIsFRgsNA==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 04:15:51 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::29:ed7f:de5a:55bb]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::29:ed7f:de5a:55bb%6]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 04:15:51 +0000
From: <Rengarajan.S@microchip.com>
To: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <Kumaravel.Thiagarajan@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <Tharunkumar.Pasumarthi@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Topic: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Index: AQHaZZZL0nj0fFzSz0iXzZOI5AQ+c7EXclSAgAA2nwCAAACkAIAPZ0qAgAAbsICAAXCsAA==
Date: Tue, 5 Mar 2024 04:15:51 +0000
Message-ID: <f3b627f1d03c8db3d09f56a836e8733004b2287b.camel@microchip.com>
References: <20240222134944.1131952-1-rengarajan.s@microchip.com>
	 <5bf4ba6d-d8e3-4ba6-a889-cfae8c3ddabe@kernel.org>
	 <e93048e64c3f8aa2731575d4b296c473e8dadb82.camel@microchip.com>
	 <254db026-5f9d-497f-ac44-c81d9d5947cf@kernel.org>
	 <53dd0d89466f0f06dfd2d63ab1ff29462a09aabb.camel@microchip.com>
	 <e8b49c34-90a1-4610-b7cd-8eff1b1a312a@kernel.org>
In-Reply-To: <e8b49c34-90a1-4610-b7cd-8eff1b1a312a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|PH7PR11MB8570:EE_
x-ms-office365-filtering-correlation-id: cdae064d-3a5a-4699-c2c4-08dc3ccaf178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGkuuWK8OcGlkoknwTr9tekUR8tnAV3GsM0qRRPq67VqwYPh6pjrd8BIJDRNzbFJaugmcEhE56ZIheSuI5lMVG4J/TdkgjXmzuDq+Fzl7Ust0HrnJ8IBYhv8lB70gn9RJgcVGFKEPMrcXMn+OV+StJGnXmFyZAdB4oSGOJBJHney/mkJTjOWgQxSbs+unQD8RJM0RVNICI/6/6rJwRr47AkRT2rXbKw/d2K4GIarstLePToTeEx+If/ioUGFESsdPGmBszg1l1Vtb842qUBjCBABVnRwhq7JDdluDKKfqQ++InxsBrZkasRYZSWmaEiTmD+rwo3G3wOMAujzwA8JW39rQrqr/Hj48jCRkO/JMs5mK1J4KgxMnmXgxLKcee8aovowor40FvS64Rhe9CUSNEqYyk4TCmZqAdJ04pnuUcZOE7CzolIaDfWefboR4r+Db0gay/SSN+skl6/psDcfEDgU1G+qmzTS2YciMwubdhS7S3I7PfTlTA674scF2oEipitzXkZtbrP9V0gNUaqKr6uz6zXf1rqbwjDZKoHAXBQK37R02pTITRvhbHMPt25cRx3PZZbaZFNQnpFzXx166cih0Z0+RZZu2j6b6zHRKlMQ/Df8VZS/nNBh3lcb9NVrNI/fs78arx0Ugnv5Nrv8xcrNyU/JcyXuZL6dexm8Na0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzhnMEpqTndJdE56N0lGMXVEUUtlOWRtOFZKZGpocnloeFpvWDdWcEhsbm1I?=
 =?utf-8?B?azkwNEpqRHZrVnlpZUo0R1IzR1JDYWZVZHhOYVoyVkdNNjFleFZ2eDlCaitO?=
 =?utf-8?B?MEczMGtXbWhINm85dHBycGxqb0RqcWx3bC8xWU1WMlliTkNKN05tUnFPeVZT?=
 =?utf-8?B?K242dTlHaEg3bU40VWJwdlhxM05IbHhLN0RTYXBCNDRjNjRqU3RKUWhUNFF4?=
 =?utf-8?B?UzFtL2NXV0dQaldCSCttWVNxanNyOWNBclNQcWdzUmR5ak9QUGUrVVEwdTVR?=
 =?utf-8?B?Zko4M3dkMG1VdzhUUkdTT3FRTzYvdFB0VjQrWEJPc0xuZkU0T0hPOXZjc0lU?=
 =?utf-8?B?NkU2UzlLYTN5dXpxWG10cWZ6aWdocW5GT0MxRzFkSVRzS25RaWFZS2VtMWlG?=
 =?utf-8?B?ZjMyaStLbTlSZ1ZjcmV2ZElQSXdZWnM3aHQrZGI3NkRDL1BDNnNTV1AzQ1J2?=
 =?utf-8?B?WDFPR01WdnF0cis1WHh5L3NSU01MT0wyeGhXOTdNcDIvYmhVdWhrQUFzN0lt?=
 =?utf-8?B?MlZSeU44RjBMUTFYeHVqZnluY3kyeGpjb3JrRkQ2bm9mMFNXRXFpbDRzKzVx?=
 =?utf-8?B?a1VlL1lxNHF2azhVUHhRdEJjNXE0dEd5RHR2QmtCbzdUaFBGWkNHRWFBMDQ1?=
 =?utf-8?B?MEdhWGNMQmZBYzUyeEJSOTlGK0VXdFdjWkt1M3BJWTRvRml5bU42VzMxWThP?=
 =?utf-8?B?eHpJY3BxVVlsVFRibkJIMG5VUFJraVdDTTZrM2YzSkwwdVorWFB2VWxDWWNz?=
 =?utf-8?B?cXlTREc5QVlxUnI0c1hGbzBCN0NmWUx2UzErVFVkRVRMSHRHWnYxTFdXb0JX?=
 =?utf-8?B?WllDc21UK25LZGg4U0h4cDlLSnF5WnU5VTRXNUVoU1hNWTU4V1JlOUtSYWFF?=
 =?utf-8?B?TTBtczZuVGh2d2k3TysyUWE0N0hHL3FsT3FmNjFzQjdSQWdZT3k2dHd2MVdP?=
 =?utf-8?B?MXFlYlArM2JOd2FMRkxjcG9EYldNSXlrWmxiaHU5WEJ4dUErM1cyU1N5dVJi?=
 =?utf-8?B?STA4YzFzangrV0xGbmpJZUJ2ZzFGZms3YzJ5Mkg5Rk0rTVB2QmMrT1REcXhZ?=
 =?utf-8?B?N0ZxM05ON0NLV3V3NkttdGlVdU1hemNJUG1NZlk4T3lJbGk1U0dXbVdMd0JF?=
 =?utf-8?B?ZnBEcUdVWE1vQ2FQeWxiSTBrNDVUVk9NV1NEZXFWMmpXL094cDlITUNNa01C?=
 =?utf-8?B?RVc1UjdoS3QxbzZvOGFNUHJIYWt2MklNNjFYOEJnL0lLT2N4bUtUc28vd0lJ?=
 =?utf-8?B?Z2FHdURwZlhBN0RzNzdmUDFuV2NBbGZCZXBmTVBjWjFTVldjTjh6NkhrWVc1?=
 =?utf-8?B?eTYrdDAwTFJ4bHFzemJoS0RTUmxjVWVuMFlUVW9vM25xNlFMakVPTzZTcVVP?=
 =?utf-8?B?bDJKMEsxTGlUNXlVdldFam5TbzlJbXdHemxXYzJudmp1cVZtL29ROStRS1FJ?=
 =?utf-8?B?TFRLY1gycGtKSmhEWjduVld2a0dkbEllZzRJcUh6WjRFR3ROTDlJYWhGL3dK?=
 =?utf-8?B?bWgrY3E3S01Mc09aUktndFZZRjhqQmhGeG83ek1iTDU2b3hlWVFRS2QwOElL?=
 =?utf-8?B?S2kyV2tNb3k3SjVBUDJaVy82dGV2dTh2Q1Y2eDJhNzZkRERuU0ZXOVlnTndG?=
 =?utf-8?B?QWxLUnB4R2xmU3BCOURqTFdhRGYxb0xOdWxUVFVFdkM3alpIbEN5TnNEaDNt?=
 =?utf-8?B?N0ExNU5EejcxNFZ3RDZNT1ZkcE1Gd3FKZzU5d0lkWlo2cmhEU3diQ3VaWDRT?=
 =?utf-8?B?VjlncGVCZmxIbnE5UGZyZVMzTE40czZUTnB1WnorVGRiZWFqdnpqTXdHSUhT?=
 =?utf-8?B?QnNTUVJ2cGxRaTFkYkJpMkFzc3JHcHFTNjJpaEh3YU9ZREVjT0pBZy9oQWFC?=
 =?utf-8?B?UjJIbkc5UUVnRzRpN2dpaCtSYWxNTHJsdHhrVUtXakw1VjRydDNtSGJLdlVI?=
 =?utf-8?B?VzEySW9tb1NZbWk0TEE3ME1PQUh2TlREa2JVSnBGdFk0d243NDRJMU5yUkNy?=
 =?utf-8?B?NDZUaG9xM0hsbDQrV2kxTkRFOW11bjVHcUJOUjZwVnd3Y0Y3dkR4SzhuV0d1?=
 =?utf-8?B?S0V5NDB5cUx0Y1JlM1IwdzdYSDlwdVp5SlRxRTFWRDBnVGlsL0VaQmcvN0U0?=
 =?utf-8?B?dDdrRXc0c3Rib1htb1VKTFBSMEh1cG9KOEwxeENhYU1wQnhWbzB0emM0cGdU?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A1DC535D5E4A24E9E8B2E0A3AD13359@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdae064d-3a5a-4699-c2c4-08dc3ccaf178
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 04:15:51.1919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLcZqcZ5XQu3kVpoco22tFpYboe/e1KArk578jhVUuvM0epfANFyEAyWEY19hgnwQbtoGgLZwdQF7qWazcMcJXyEIPt/047Ptn8H/Ycf5hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570

SGkgSmlyaSwNCg0KT24gTW9uLCAyMDI0LTAzLTA0IGF0IDA3OjE5ICswMTAwLCBKaXJpIFNsYWJ5
IHdyb3RlOg0KPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBv
ZnRlbiBnZXQgZW1haWwgZnJvbQ0KPiBqaXJpc2xhYnlAa2VybmVsLm9yZy4gTGVhcm4gd2h5IHRo
aXMgaXMgaW1wb3J0YW50IGF0DQo+IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVu
dGlmaWNhdGlvbsKgXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+IA0KPiBPbiAwNC4gMDMuIDI0LCA1OjM3LCBSZW5nYXJhamFuLlNAbWljcm9jaGlwLmNvbcKg
d3JvdGU6DQo+ID4gSGkgSmlyaSwNCj4gPiANCj4gPiBPbiBGcmksIDIwMjQtMDItMjMgYXQgMTA6
MjYgKzAxMDAsIEppcmkgU2xhYnkgd3JvdGU6DQo+ID4gPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiA+ID4ga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+ID4gPiANCj4gPiA+IE9uIDIzLiAwMi4gMjQsIDEwOjIxLCBS
ZW5nYXJhamFuLlNAbWljcm9jaGlwLmNvbcKgd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgMjAyNC0w
Mi0yMyBhdCAwNzowOCArMDEwMCwgSmlyaSBTbGFieSB3cm90ZToNCj4gPiA+ID4gPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzDQo+
ID4gPiA+ID4geW91DQo+ID4gPiA+ID4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gT24gMjIuIDAyLiAyNCwgMTQ6NDksIFJlbmdhcmFqYW4gUyB3cm90ZToN
Cj4gPiA+ID4gPiA+IFVwZGF0ZWQgdGhlIFRYIEJ1cnN0IGltcGxlbWVudGF0aW9uIGJ5IGNoYW5n
aW5nIHRoZQ0KPiA+ID4gPiA+ID4gY2lyY3VsYXINCj4gPiA+ID4gPiA+IGJ1ZmZlcg0KPiA+ID4g
PiA+ID4gcHJvY2Vzc2luZyB3aXRoIHRoZSBwcmUtZXhpc3RpbmcgQVBJcyBpbiBrZXJuZWwuIEFs
c28NCj4gPiA+ID4gPiA+IHVwZGF0ZWQNCj4gPiA+ID4gPiA+IGNvbmRpdGlvbmFsDQo+ID4gPiA+
ID4gPiBzdGF0ZW1lbnRzIGFuZCBhbGlnbm1lbnQgaXNzdWVzIGZvciBiZXR0ZXIgcmVhZGFiaWxp
dHkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gc28g
d2h5IGFyZSB5b3Uga2VlcGluZyB0aGUgbmVzdGVkIGRvdWJsZSBsb29wPw0KPiA+ID4gPiA+IA0K
PiA+ID4gPiANCj4gPiA+ID4gSGksIGluIG9yZGVyIHRvIGRpZmZlcmVudGlhdGUgQnVyc3QgbW9k
ZSBoYW5kbGluZyB3aXRoIGJ5dGUNCj4gPiA+ID4gbW9kZQ0KPiA+ID4gPiBoYWQNCj4gPiA+ID4g
c2VwZXJhdGUgbG9vcHMgZm9yIGJvdGguIFNpbmNlLCBoYXZpbmcgc2luZ2xlIHdoaWxlIGxvb3Ag
YWxzbw0KPiA+ID4gPiBkb2VzDQo+ID4gPiA+IG5vdA0KPiA+ID4gPiBhbGlnbiB3aXRoIHJ4IGlt
cGxlbWVudGF0aW9uICh3aGVyZSB3ZSBoYXZlIHNlcGVyYXRlIGhhbmRsaW5nDQo+ID4gPiA+IGZv
cg0KPiA+ID4gPiBidXJzdA0KPiA+ID4gPiBhbmQgYnl0ZSkgaGF2ZSByZXRhaW5lZCB0aGUgZG91
YmxlIGxvb3AuDQo+ID4gPiANCj4gPiA+IFNvIG9idmlvdXNseSwgYWxpZ24gUlggdG8gYSBzaW5n
bGUgbG9vcCBpZiBwb3NzaWJsZS4gVGhlIGN1cnJlbnQNCj4gPiA+IFRYDQo+ID4gPiBjb2RlDQo+
ID4gPiBpcyB2ZXJ5IGhhcmQgdG8gZm9sbG93IGFuZCBzb3J0IG9mIHVubWFpbnRhaW5hYmxlIChh
bmQgYnVnZ3kpLg0KPiA+ID4gQW5kDQo+ID4gPiBJTU8NCj4gPiA+IGl0J3MgdW5uZWNlc3Nhcnkg
YXMgSSBwcm9wb3NlZCBbMV0uIEFuZCBldmVuIGlmIFJYIGNhbm5vdCBiZSBvbmUNCj4gPiA+IGxv
b3AsDQo+ID4gPiB5b3Ugc3RpbGwgY2FuIG1ha2UgVFggZWFzeSB0byByZWFkIGFzIHRoZSB0d28g
bmVlZCBub3QgYmUgdGhlDQo+ID4gPiBzYW1lLg0KPiA+ID4gDQo+ID4gPiBbMV0NCj4gPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9iODMyNWMzZi1iZjViLTRjNTUtOGRjZS1lZjM5NWVk
Y2UyNTFAa2VybmVsLm9yZy8NCj4gPiANCj4gPiANCj4gPiB3aGlsZSAoZGF0YV9lbXB0eV9jb3Vu
dCkgew0KPiA+IMKgwqDCoCBjbnQgPSBDSVJDX0NOVF9UT19FTkQoKTsNCj4gPiDCoMKgwqAgaWYg
KCFjbnQpDQo+ID4gwqDCoMKgwqDCoCBicmVhazsNCj4gPiDCoMKgwqAgaWYgKGNudCA8IFVBUlRf
QlVSU1RfU0laRSB8fCAodGFpbCAmIDMpKSB7IC8vIGlzX3VuYWxpZ25lZCgpDQo+ID4gwqDCoMKg
wqDCoCB3cml0ZWIoKTsNCj4gPiDCoMKgwqDCoMKgIGNudCA9IDE7DQo+ID4gwqDCoMKgIH0gZWxz
ZSB7DQo+ID4gwqDCoMKgwqDCoCB3cml0ZWwoKQ0KPiA+IMKgwqDCoMKgwqAgY250ID0gVUFSVF9C
VVJTVF9TSVpFOw0KPiA+IMKgwqDCoCB9DQo+ID4gwqDCoMKgIHVhcnRfeG1pdF9hZHZhbmNlKGNu
dCk7DQo+ID4gwqDCoMKgIGRhdGFfZW1wdHlfY291bnQgLT0gY250Ow0KPiA+IH0NCj4gPiANCj4g
PiBXaXRoIHRoZSBhYm92ZSBpbXBsZW1lbnRhdGlvbiB3ZSBhcmUgb2JzZXJ2aW5nIHBlcmZvcm1h
bmNlIGRyb3Agb2YNCj4gPiAyDQo+ID4gTWJwcyBhdCBiYXVkIHJhdGUgb2YgNCBNYnBzLiBUaGUg
cmVhc29uIGZvciB0aGlzIGlzIHRoZSBmYWN0IHRoYXQNCj4gPiBmb3INCj4gPiBlYWNoIGl0ZXJh
dGlvbiB3ZSBhcmUgY2hlY2tpbmcgaWYgdGhlIHRoZSBkYXRhIG5lZWQgdG8gYmUgcHJvY2Vzc2Vk
DQo+ID4gdmlhDQo+ID4gRFdPUkRzIG9yIEJ5dGVzLiBUaGUgY29uZGl0aW9uIGNoZWNrIGZvciBl
YWNoIGl0ZXJhdGlvbiBpcyBjYXVzaW5nDQo+ID4gdGhlDQo+ID4gZHJvcCBpbiBwZXJmb3JtYW5j
ZS4NCj4gDQo+IEhpLA0KPiANCj4gdGhlIGNoZWNrIGlzIGJ5IHNldmVyYWwgb3JkZXJzIG9mIG1h
Z25pdHVkZSBmYXN0ZXIgdGhhbiB0aGUgSS9PDQo+IHByb3Blci4NCj4gU28gSSBkb24ndCB0aGlu
ayB0aGF0J3MgdGhlIHJvb3QgY2F1c2UuDQo+IA0KPiA+IFdpdGggdGhlIHByZXZpb3VzIGltcGxl
bWVudGF0aW9uKHdpdGggbmVzdGVkIGxvb3BzKSB0aGUgcGVyZm9ybWFuY2UNCj4gPiBpcw0KPiA+
IGZvdW5kIHRvIGJlIGFyb3VuZCA0IE1icHMgYXQgYmF1ZCByYXRlIG9mIDQgTWJwcy4gSW4gdGhh
dA0KPiA+IGltcGxlbWVudGF0aW9uIHdlIGhhbmRsZSBzZW5kaW5nIERXT1JEcyBjb250aW51b3Ns
eSB1bnRpbCB0aGUNCj4gPiB0cmFuc2Zlcg0KPiA+IHNpemUgPCA0LiBDYW4geW91IGxldCB1cyBr
bm93IGFueSBvdGhlciBhbHRlcm5hdGl2ZXMgZm9yIHRoZSBhYm92ZQ0KPiA+IHBlcmZvcm1hbmNl
IGRyb3AuDQo+IA0KPiBDb3VsZCB5b3UgYXR0YWNoIHRoZSBwYXRjaCB5b3UgYXJlIHRlc3Rpbmc/
DQoNClBsZWFzZSBmaW5kIHRoZSB1cGRhdGVkIHBjaTF4eHh4X3Byb2Nlc3Nfd3JpdGVfZGF0YQ0K
DQoJdTMyIHhmZXJfY250Ow0KDQogICAgICAgIHdoaWxlICgqdmFsaWRfYnl0ZV9jb3VudCkgew0K
ICAgICAgICAgICAgICAgIHhmZXJfY250ID0gQ0lSQ19DTlRfVE9fRU5EKHhtaXQtPmhlYWQsIHht
aXQtPnRhaWwsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVUFS
VF9YTUlUX1NJWkUpOw0KDQogICAgICAgICAgICAgICAgaWYgKCF4ZmVyX2NudCkNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOw0KDQogICAgICAgICAgICAgICAgaWYgKHhmZXJfY250IDwg
VUFSVF9CVVJTVF9TSVpFIHx8ICh4bWl0LT50YWlsICYgMykpIHsNCiAgICAgICAgICAgICAgICAg
ICAgICAgIHdyaXRlYih4bWl0LT5idWZbeG1pdC0+dGFpbF0sIHBvcnQtPm1lbWJhc2UgKw0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFVBUlRfVFhfQllURV9GSUZPKTsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIHhmZXJfY250ID0gVUFSVF9CWVRFX1NJWkU7DQogICAgICAgICAgICAg
ICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIHdyaXRlbCgqKHUzMiAqKSZ4bWl0
LT5idWZbeG1pdC0+dGFpbF0sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcG9ydC0+
bWVtYmFzZSArIFVBUlRfVFhfQlVSU1RfRklGTyk7DQogICAgICAgICAgICAgICAgICAgICAgICB4
ZmVyX2NudCA9IFVBUlRfQlVSU1RfU0laRTsNCiAgICAgICAgICAgICAgICB9DQoNCiAgICAgICAg
ICAgICAgICB1YXJ0X3htaXRfYWR2YW5jZShwb3J0LCB4ZmVyX2NudCk7DQogICAgICAgICAgICAg
ICAgKmRhdGFfZW1wdHlfY291bnQgLT0geGZlcl9jbnQ7DQogICAgICAgICAgICAgICAgKnZhbGlk
X2J5dGVfY291bnQgLT0geGZlcl9jbnQ7DQogICAgICAgIH0NCg0KVGVzdGluZyBpcyBkb25lIHZp
YSBtaW5pY29tIGJ5IHRyYW5zZmVycmluZyBhIDEwIE1CIGZpbGUgYXQgNCBNYnBzLA0KDQpBZnRl
ciB0aGUgbWluaWNvbSB0cmFuc2ZlciB3aXRoIHNpbmdsZSBpbnN0YW5jZToNCg0KUHJldmlvdXMg
aW1wbGVtZW50YXRpb24oTmVzdGVkIFdoaWxlIExvb3BzKToNClRyYW5zZmVycmVkIDEwIE1CIGF0
IDM5MDAwMDAgQ1BTDQoNCkN1cnJlbnQgaW1wbGVtZW50YXRpb246DQpUcmFuc2ZlcnJlZCAxMCBN
QiBhdCAyNDU5OTk5IENQUw0KDQpUaGFua3MsDQpSZW5nYXJhamFuIFMNCg0KPiANCj4gdGhhbmtz
LA0KPiAtLQ0KPiBqcw0KPiBzdXNlIGxhYnMNCj4gDQoNCg==

