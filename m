Return-Path: <linux-kernel+bounces-157941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B158B1901
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C21E28584E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AF1862A;
	Thu, 25 Apr 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G8260QRp"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2071.outbound.protection.outlook.com [40.107.14.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAF17BA6;
	Thu, 25 Apr 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012833; cv=fail; b=fvKdD0wZmzvpMjb26aHGGWsof57gWzWh81hVOO6I8VyrfmtLrQNDIF4sTKqFWHpZ04pTV/g0xGfA0/JH9+rwencj48BYYdoJV7a+3juQc0mjGlrErap+t9UPizsVmS/Ew8ldKYjVCBJpSW9nqYLOCVvW/IWwuKLOx3oz2P8f+sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012833; c=relaxed/simple;
	bh=4ZT6Abrv7Dy/AcYG5FtvqKco/HvsXDfb6HJcAACavac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XtKdEIZjL4Ezr0A4F6W8FXy5idGT5dZg4DkrLfGd0CFHJ0QV9daLh6pg7R2TrLz2TOLLgmP/bd0Urg79Mrf88UKSh4W5ja3SyEQKwbQXU/nqHTOOLI8fZvHADBWu6J/DtfEcvJkMVWTg17JGjkVhS3zLFBAlorLDgbY85MVfvis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G8260QRp; arc=fail smtp.client-ip=40.107.14.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxk5aOBHQUFHwXjV8b+D63DEnZkqD8WtyDY0M0ggdSlDg1nF91Pg/lpDtaP2AIDAODelSE3Se3kDS/BzUI6FPUwpXjAgIOuc3Ooi2+vLu2uM5wq2Zhcs/gSfq49mSiNl0AYkRuWwYvZvQPW9XmyeLYZYy3PwrB8dhyxC59v40VPLkhGPGn0o/J+Iw8W0wHAWcywFgZxj+rfZMWgZYAAL+pZjNXWfrn0uXmQhckMRNIWrlT2GsBHInOJxv8OAMShx7GMeYBa3E5dSs6HJPs1b93TiFAaapqYgDE4oTLHIFPKo+r26+Fgql06x3dQPXQH6rkgNVT/oGjxwOUJoJRBKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZT6Abrv7Dy/AcYG5FtvqKco/HvsXDfb6HJcAACavac=;
 b=A2F0vE0n/0hsXuMwEXKtfvFnjx6QQJCj9jRTMBIWQapZneanzy6+UqsPXdSvHSin8OWsDt74esEejS41pFOSCrZy0Tq4aLm5EA8U1MyNQep5JVL5FofeE1GNfSDtj7wKkAtWHsX5r1RZT6gX9M8y9AC/aa4+OKCeb1WT+0oQ0nGPnt1KPf/NzkPzDsCTOek9kjNX4hYcJycDVFvnY3kirxYU2fn2qd6ce2jJ5dNuWt0jSP1cvQlPKDZqXtUhzWoEi9IcP6y848Q+bTFH6I6sNPAxw7wkPe8wPleXOhUtQi3/Ry9Rg3sYO92F/fn9ILdSpLX5MzAj1ZbfGP7QLeX33Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZT6Abrv7Dy/AcYG5FtvqKco/HvsXDfb6HJcAACavac=;
 b=G8260QRpK016QX8ogfdho48SefyNf/kqYF461+UlkKceWymyyisnQ6V9S6BBLcscnag8vcAZWjGdDbUl1J1VtDY6sT/FV8ON2beD8lEAHWm3iOYJXcUY8kcPHZmRQThpJq0oK1/Yg6A+5xU16c0mMZPl1Bhb2wwNRh6kAX1WykI=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB7758.eurprd04.prod.outlook.com (2603:10a6:102:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 02:40:28 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 02:40:28 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Brian Norris <briannorris@chromium.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kalle
 Valo <kvalo@kernel.org>, "francesco@dolcini.it" <francesco@dolcini.it>, Pete
 Hsieh <tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHakXD8ZSzvjLENHE+cjdiIi3WD9LFu+PhwgAEpDwCAA9ThQIABL2MAgAH0wQCAATIZwA==
Date: Thu, 25 Apr 2024 02:40:28 +0000
Message-ID:
 <PA4PR04MB9638670FD6768AD8A69F5125D1172@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com>
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <C8F76484-1359-437B-85BF-C646A21F7BCE@holtmann.org>
In-Reply-To: <C8F76484-1359-437B-85BF-C646A21F7BCE@holtmann.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB7758:EE_
x-ms-office365-filtering-correlation-id: 2f723513-b3c0-4a0c-bd5f-08dc64d1115d
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2FOMnJwajFydGNCMXNyMDNMdkF6Qm85QjRCYjR1SDBab0txOEVTc3ZaTTdZ?=
 =?utf-8?B?SjFvSjkwQU10T3dlbUN0Q3M2VkJFSUc3N0M1WVArRWVpVWNCSXB4SDFNZXFL?=
 =?utf-8?B?bHJxcjd6Zzg4T2ZxcXNoVHdoM2JBWENBQkZqSVNxbzV0dlk5QmEwblQ0TW1y?=
 =?utf-8?B?bVhPZS9NMmRxd3A3b1pwRjZXZkE5WEVxWHh6c2dvTzRJTWlsMjl3Y1RFbzdw?=
 =?utf-8?B?SXhQZWl3RVBqTzZJOXFpeWQ2R1NsZTBPaU1mK2ZtdG42T09sdXFvT2RoQi92?=
 =?utf-8?B?d05CZEc3TDRYdU9jZ1k4OGF2NnFmWWNuUDBLT3dOOTdmQ2dZNGE2Q2JBTWpM?=
 =?utf-8?B?aTBUbWUxU0RzSnhvS2kzWm9NSFZUYmdQVmkvWTY2T2ovNzE4RmxXaTBRNE4r?=
 =?utf-8?B?bThHN1FEZ2p1WkJNN01ORnhRUzZUWks4Qm1PRFdBb0ZDdGM5Qk9DVDBKT25R?=
 =?utf-8?B?NnJBZVpWYUlDSVFGZEwvclpoWWViWmRTczFQcjlJeld2akx1OCsyWkFtSXR6?=
 =?utf-8?B?Y3JNRStBR3R6ZXN6cU1iY3dzTzUxNnBCZitwc3hsMk0wSWltbUs2WHE5L3hO?=
 =?utf-8?B?TjFweS9TcjdMSjhIYmx3V1BkTzY0Mmc2c3F4TXN2WUR6eTc5dU1SM0haSVFu?=
 =?utf-8?B?cDJuUkg0NHVkMjFHS0FKU3RGTkZVeXZxWGFLNjMyYVBRbkN6MC9Gd0NrcEtD?=
 =?utf-8?B?OWVJZlRVZTBxMXhTY1UwZi8rQUpwdjRHYUFLRSt6ZXM2eUVwd0VsUVBESy8v?=
 =?utf-8?B?NzVoSW04Tk9oTTQzVGU0NVNGcDlxdlV2MFRWNUFHQmkrMjNYL25KSkhnelY2?=
 =?utf-8?B?aXVBRkViRTJWR3haMjBRSEI2QXo2emFCYmNwT1Bqakl4T0Zsb3FScCtHN3p2?=
 =?utf-8?B?V1JNck02TU1TZUZLcGNsT0hTcmZUZFR6eDJuUUdGaEROckYvMHk4ZVhjOERK?=
 =?utf-8?B?QWhCQlBTb0Q0UVB1SDkzL3pmeEdvb2NFdGMzcnFLZzJOYzVGVWZxeTNMZ1E1?=
 =?utf-8?B?WHZFL0RDUndPK25SVFovZHRKSUg4YmZXWjJ5MU84UXVjSFVjb2NTbGU0aGVi?=
 =?utf-8?B?Qy9CdVlkdlVUL2JvaEsrREZtdUhjQk8ySEdMdE93NHB3UnNvSXl0VEJTb0JX?=
 =?utf-8?B?bVozdTljOEpNeGpzWWdCZ3A1bFFkcE1zT3BzNGZjNnlGY1U2aVRSRk1ncmdO?=
 =?utf-8?B?eWRVZmpKZ0VpRWpMWXZaSXBlR21HT2VTZ2tjZWNnanVNVjlJS2g5N0ppc3hj?=
 =?utf-8?B?Ym9XQkZIdWtDK0tPWXVMQXpWUDl4RG5UVm90ZjNHMHV0WElDcHpYbkd2ZDZh?=
 =?utf-8?B?MTdqTEdWT3BYbXJOb1NZdDA3L0xPcUVDQzhaVzRHVllBT1VrQWkxSm5tWkNu?=
 =?utf-8?B?ZVJBNFdScTB4bzF2MzhiYXVuTDY3ZWxPZS81VWYwWUhtcGt5VHlkT2ZUdm1E?=
 =?utf-8?B?Sk92SndnTzdNanIzNkJwalljclZZTnpPUmphVE1QYW5jV1hpYW9qcU9VVVhI?=
 =?utf-8?B?RnlHUGxTa0xUZlJieXRubTFQdnBHM3ZXOVlKclNnRk5oTEU1NGtEWW9UNU1M?=
 =?utf-8?B?dm91MDVNc1BBS0tGT2p1Z2YwMjNxcUp3K3hETmZhZVFQa29hclZTOFZPVnJX?=
 =?utf-8?B?UUlKUXZ1b2s3MlJURnFmbTcyMWpld3B1em1WWEhuSmdpWU4ybGdyZW5xdFV2?=
 =?utf-8?B?SVBTcmZxdFUwaHlsZnJWMzBGM0lJTldIRDhXT3ZvcG9FeXNsUFl3aUtPQysw?=
 =?utf-8?B?aVROQzAxZ1JJQ1lCOXZEcTNPeVgrUlZnWVQ3Y0tPWlRZLzFlRlZjY0tPL0ZS?=
 =?utf-8?B?NTdCeCtZZmJIS3A1Sy9pZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGJ1VS9WTGEyUzBoQ1NvL0ROSkJISzFzdUdDSTYwS0xkWDFiYnFvakR1L0s1?=
 =?utf-8?B?cU5Qc0ZySUN6UU5QUklsalA3MURKYXM0czNETGdDV05sNU50S0pFV05FV2Zh?=
 =?utf-8?B?N3VCczlZSFpEdTA1UlpEbTFNQmg4dlhiS2VCbU92ZngyUVlmdWEvbVE2WjBE?=
 =?utf-8?B?WXNnK1FTM0tvbWtIQ2dXOUltSkFTeUJ3THBaWVFlbnFDcFdia2FvRURBVWp0?=
 =?utf-8?B?dFBsZE9HWUIxUlB1bnIxMTEzTkhGWGNBbjlPMmpzWkZQRGE1czJZRElHMlFJ?=
 =?utf-8?B?aWJYdFIyQ2E3aWhkWXBRcEhrK0ZlcTNyekZjdHNKTzNaVkpUZzFzRjlCMnlB?=
 =?utf-8?B?cjBDM01RSTcxb2pGOVNyWDFhVElCUDlQUlBoUkVCSld0QmU2bUJoaXNmWFpI?=
 =?utf-8?B?Y3NlY1Zmc0w2SytlUk1JSnp6alBkblJrTlo2RnhCTTd5azlwZFd0VVFJbUpQ?=
 =?utf-8?B?Wkt3bjlaQkFoTXJuVGZyTXF0S1Z3UVZjSUg3MEEwR09wSnFJYldicUNjczRK?=
 =?utf-8?B?SS9SbzhrVFNLNHBvN0U4c0Z6MVJZNW1CcTFKUXJ5b242RlJpOE8wdWoybjZJ?=
 =?utf-8?B?Tng1bWhTRkx1dTk3QmZka2E2Wm9vbUR2NXJENXBkcFAzV2d1cWhWQnVEQ3Fp?=
 =?utf-8?B?TnpVdVUwVDh1K1Bab2srR01IeEZvYlhRWUZEeExhdkkyckdlUlZsSTJ5UVlQ?=
 =?utf-8?B?dkZsakYvY0JlNXFJbURQdGlIUG5FKzRsR3hKdXhYcFVsc1lraVd1Zk81SktE?=
 =?utf-8?B?R3ErZDZvdXhLOUx1SGt5V0U4YlVIYVAxNC9MSmxwblhMVFRmRURNWXB4eCtz?=
 =?utf-8?B?UnYxZFBjSjgxQTcwamZOTUlreC9ucjlFVzlRMmhkMWk4ZW9Ud0lKVmlnRUYv?=
 =?utf-8?B?ak0yc05pL2hCeGVESEkxSlR1Nk5Hd2d5bVRPWGZ2bDRKYkwyYmh0aFpDQ1J0?=
 =?utf-8?B?YkNncFoveHE5a0REejlyU2Y2ZDgwQWY4TlBkM1hlREV0dnc5YW4xNHNuYlpp?=
 =?utf-8?B?SWpQanJWYkQ3WHJKZmQrdVlqVHNQQWc2eWxqY1dwVnV3Qnc5L3ZXTmttM1pn?=
 =?utf-8?B?ellaZVkrOG5JalpxenBtYTZYQzZyVnQ4QnJlcXh2VUNOcXBlcGVORVI4VXg0?=
 =?utf-8?B?RVQ3ZTFobk1uVmlIZlhxL29ldVFYWHQrZUFGZzZsT1U0Q1dpS05rWWwyakZK?=
 =?utf-8?B?V1RLSnNFVytHRDIxdjhuSVc2NUt0aGVXV0l3TmRlWmQ2RjB5ZmM4dCtBWUpo?=
 =?utf-8?B?M2ZTSzVUM3lmaHVib01vSUkveTBFM2ZjdE5hSjRqU05DYWZwZ3NiVHl6RVlS?=
 =?utf-8?B?eVlkbGZSL29HR0E0VXRWVzBTVUJDWEVlTDE0OXVWc3E3TkdHZjNOaERIVVYr?=
 =?utf-8?B?RTBVeGJWVmp1bnF4dThkM1VoZHFaNGJsN3h1VDRuaVVpS0RRZ2FGVElyVFBW?=
 =?utf-8?B?NWRidEhpSFFGVWV0OVJwakhDcWgrQWNUWTRkcUZaeldCTTE5N1VabHdkQlBG?=
 =?utf-8?B?d0ZPdVRaejNTZmhFM1BpSTNsTjdGWUZCZEpIQWZrd29SVVN2V1B1TXNiSFgx?=
 =?utf-8?B?ZWZHM056NVNoT0VHMFRYdnloSkU2TXZ0V01HWGtua1htWVQ0RVRVU0ttMWtz?=
 =?utf-8?B?ZVNCbFhucmhRVUhVcjlTOTNNWDNoUjJEVGJXcDRmKzgyZDQwbjZtYUdKR0ZX?=
 =?utf-8?B?Q2Z3MTlsNzkwdkVNMVhvczFRSFNVcTNxOVdhamJtVlFEejZrNGhSUVdFQmRl?=
 =?utf-8?B?Qld3OGZjdWo5RjY3KzJDNHorZ08yb005K0hxT2dHT1JyKytJc3VmYUN0N1RX?=
 =?utf-8?B?UEV4Y1A5VmRDT054VW9vaWFvc2xnYkhmbEhsTktoS1AwKzBxVTFQUDgxZ1Mz?=
 =?utf-8?B?WDBrU2FxdGNvZmx0QnhxRElZdVZUMGRaenY2dGtvTnF6YUNHb3VmblJZcWFG?=
 =?utf-8?B?RXpVV0NHTkUyWkE0cnA1OUZRRTZkdUlwQ0RjMzZpMDVKZDB6c0hwa0lZZFBp?=
 =?utf-8?B?V2RwT0orSVY1OCszZTNjTEovZHdDVkpSd1QvNnpSL0lodEJHbit4NHBwbU5K?=
 =?utf-8?B?dDZhV3FoQUYydGhMRUZ3Z29BVjNIVUFQV2JVeWpUaWZ3dkp0U3hCQllmeEF4?=
 =?utf-8?Q?bRtQLD1UUJa8k6r0WwzVU5Ml4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f723513-b3c0-4a0c-bd5f-08dc64d1115d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 02:40:28.1535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fF8KKNCFa7gVodNOz8EOpd9dHxx40xhTNkVAPfzUn5uvJruMAxhf1HGVzmIK6uwZjhRtm85I5gZgBEdCp9DWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7758

PiBGcm9tOiBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgQXByaWwgMjQsIDIwMjQgNDoxMSBQTQ0KPiBUbzogRGF2aWQgTGluIDx5dS1oYW8u
bGluQG54cC5jb20+DQo+IENjOiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9y
Zz47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsNCj4gTEtNTCA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+Ow0KPiBmcmFu
Y2VzY29AZG9sY2luaS5pdDsgUGV0ZSBIc2llaCA8dHN1bmctaHNpZW4uaHNpZWhAbnhwLmNvbT47
IHJhZmFlbC5iZWltcw0KPiA8cmFmYWVsLmJlaW1zQHRvcmFkZXguY29tPjsgRnJhbmNlc2NvIERv
bGNpbmkNCj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBTdWJqZWN0OiBSZTog
W0VYVF0gW1BBVENIIHYxMCAwLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBjb2RlIHRvIHN1cHBvcnQg
aG9zdA0KPiBtbG1lDQo+IA0KPiBIaSBEYXZpZCwNCj4gDQo+ID4gSm9oYW5uZXMgYWdyZWVkIHRo
YXQgY2ZnODAyMTEgaXMgdGhlIGNvcnJlY3Qgd2F5IGZvciB0aGUgZGV2ZWxvcG1lbnQNCj4gPiBv
ZiBtd2lmaWV4DQo+ID4gKG1hYzgwMjExIGNhbid0IG9mZmxvYWQgYXNzb2NpYXRpb24gcHJvY2Vz
cyB0byBkcml2ZXIvRlcpLg0KPiANCj4gdGhhdCB3YXMgbmV2ZXIgbXkgcXVlc3Rpb24gaGVyZS4N
Cj4NCg0KVGhpcyBpcyBwcmV2aW91cyB0b3BpYyBkaXNjdXNzZWQgd2l0aCBKb2hhbm5lcyB0byBj
b25maXJtIGNmZzgwMjExIGlzIGNvcnJlY3QgZGVjaXNpb24gZm9yIE5YUCBGVy4NCiANCj4gPiBU
aGlzIHBhdGNoIGlzIHVzZWQgdG8gZnVsbHkgbGV2ZXJhZ2UgU01FIG9mIHdwYV9zdXBwbGljYW50
IGFuZCBob3N0YXBkDQo+IHdoaWNoIGNhbiBjb21wbGV0ZSB0aGUgbWlzc2luZyBXUEEzIGZlYXR1
cmUgb2YgbXdpZmlleC4NCj4gPiBUaGUgcGF0Y2ggc2VyaWVzIGhhZCBiZWVuIHJldmlld2VkIGFu
ZCBkaXNjdXNzZWQuIEl0IGxvb2tzIGxpa2UgdGhlcmUgaXMgbm8NCj4gbW9yZSBjb21tZW50cyBm
b3IgcGF0Y2ggdjEwLg0KPiA+IEkgd29uZGVyIGNhbiBwYXRjaCB2MTAgYmUgYWNjZXB0ZWQgYnkg
eW91Pw0KPiANCj4gSWYgeW91ciBoYXJkd2FyZSBpcyBhIEZ1bGxNYWMgaGFyZHdhcmUgdGhlbiB3
aGF0IGlzIHRoZSBwb2ludCBpbiBub3cNCj4gc2VwYXJhdGluZyBhdXRoL2Fzc29jIG91dC4gSXMg
dGhpcyBkb25lIGp1c3QgZm9yIFdQQTMgb3IgYWxzbyBmb3IgV1BBMi9XUEExLg0KDQpZZXMuIE91
ciBGVyBjYW4ncyBzdXBwb3J0IFdQQTMsIHNvIHRoaXMgcGF0Y2ggaXMgdXNlZCB0byBob29rIHNl
cGFyYXRpbmcgYXV0aC9hc3NvYyB0bw0KbGV2ZXJhZ2UgU01FIG9mIHdwYV9zdXBwbGljYW50IGFu
ZCBob3N0YXBkLiBXUEEyIGlzIGFsc28gaGFuZGxlZCBieSBTTUUgb2YNCndwYV9zdXBwbGljYW50
IGFuZCBob3N0YXBkLg0KDQo+IEFyZSB5b3Ugbm8gbG9uZ2VyIGEgRnVsbE1hYyBoYXJkd2FyZT8N
Cg0KWW91IGNhbiBjaGVjayBwcmV2aW91cyBkaXNjdXNzaW9uIHdpdGggSm9oYW5uZXMsIEZXIHN0
aWxsIG5lZWRzIHRvIGludm9sdmUgYXNzb2NpYXRpb24NCnByb2Nlc3MsIHNvIG1hYzgwMjExIGlz
IG5vdCBzdWl0YWJsZSBmb3IgTlhQIEZXLg0KPiANCj4gWW91IGtlZXAgc2F5aW5nIHRoYXQgeW91
IGp1c3Qgd2FudCB0byBzdXBwb3J0IFdQQTMgYW5kIGlmIHByZXZpb3VzbHkgdGhlIEhXDQo+IHdv
cmtlZCBhcyBGdWxsTWFjIGhhcmR3YXJlLCB0aGVuIGV4dGVybmFsX2F1dGggc2hvdWxkIGJlIHRo
ZSB3YXkgdG8gZ28gZm9yDQo+IGhhdmluZyBTQUUgaGFuZGxlZCBieSB3cGFfc3VwcGxpY2FudCAo
b3IgaXdkIGZvciB0aGF0IG1hdHRlcikuDQoNCkFsdGhvdWdoIGV4dGVybmFsX2F1dGggaXMgb25l
IHdheSB0byBzdXBwb3J0IFNBRSwgYnV0IHdlIHRoaW5rIGhvb2sgc2VwYXJhdGluZyBhdXRoL2Fz
c29jIHdpbGwNCmJlIHRoZSBiZXR0ZXIgd2F5IHRvIHJlc29sdmUgdGhpcyBpc3N1ZS4gSW4gdGhp
cyB3YXksIG9mZmxvYWRpbmcgU01FIHRvIHdwYV9zdXBwbGljYW50L2hvc3RwYWQgd2lsbA0KbGV0
IGFueSBmdXR1cmUgY2hhbmdlcyBiZSBlYXN5IHRvIHN1cHBvcnQgKHdlIG9ubHkgbmVlZCB0byBj
aGVjayBpZiB0aGVyZSBpcyBhbnl0aGluZyB0aGF0IHdlIHNob3VsZA0KZG8gd2hlbiBjb252ZXJ0
aW5nIGFzc29jaWF0aW9uIHJlcXVlc3QgdG8gdGhlIGFzc29jaWF0aW9uIGNvbW1hbmQgc3VwcG9y
dGVkIGJ5IEZXKS4NCj4gDQo+IE5vdyBpZiB5b3UgYXJlIGZ1bGx5IGVtYnJhY2luZyB0byBhdXRo
L2Fzc29jIGFuZCB3ZSBjYW4gcmVtb3ZlIHRoZSBzdXBwb3J0DQo+IGZvciB0aGUgY29ubmVjdCBv
cHMsIHRoZW4gbGV0cyBkbyBpdC4gSG93ZXZlciBJIGRvbuKAmXQgc2VlIGFueXRoaW5nIHByb3Bl
cmx5DQo+IGRlc2NyaWJlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuIFlvdSBrZWVwIHNheWluZyBX
UEEzIHN1cHBvcnQgYW5kIG5vdGhpbmcNCj4gZWxzZSBleHBsYWluIHdoYXQgdGhlIG5ldyBLZXkg
VjIgQVBJIG9mIHRoZSBmaXJtd2FyZSB3b3VsZCBkby4NCg0KV2UgZ2l2ZSBhIGZsYWcgdG8gbGV0
IHVzZXIgdG8gZGVjaWRlIHRvIHVzZSBjb25uZWN0IG9wcyBvciBzZXBhcmF0aW5nIGF1dGgvYXNz
b2MuIFdlIHdpbGwgcmVtb3ZlDQpjb25uZWN0IG9wcyBmb3Igb3VyIG5ldyBueHB3aWZpIGRyaXZl
ci4gTmV3IGtleSBWMiBBUEkgc3VwcG9ydHMgbW9yZSBrZXkgc29sdXRpb25zLg0KDQo+IA0KPiBS
ZWdhcmRzDQo+IA0KPiBNYXJjZWwNCg0KVGhhbmtzLA0KRGF2aWQNCg0K

