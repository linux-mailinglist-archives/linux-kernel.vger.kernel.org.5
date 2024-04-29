Return-Path: <linux-kernel+bounces-162938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D238B626A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36D41F22E51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A8313B2AD;
	Mon, 29 Apr 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fqKkUfeT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zcBnGKH8"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4372839FD;
	Mon, 29 Apr 2024 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419477; cv=fail; b=IhvwRVBY3/bcNZypj4e56LgsrBblEZSLNgLHV9hQMYaPF+w6P0pMtSOFgIk8wAlBs6Bmatv68sthVgC1jGZGtPMz7tJf7NqmE3P4nf2Sd0wrVVJmtHEtkEGakjB+RxVwXOOt/oh2uBlG6DFlIB2zO0mTWhEhfSqw8pkOzhkhBcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419477; c=relaxed/simple;
	bh=86mQsfYJ30u8Tt1N6JKNurxz4i2hF7gOFyFzPXiMY3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvoAXcS7gfV/mcdDmesXiMwsmJlFMOyE9uGaJPvgoIUz8c4z/XyjEHHd8w19jTqJ1J3h6VutaniDXUkxvtK9tx/NwsHxZXjkmjeFx4wxC+IR0AUp0FyBtQxPX+kzulikV2vjF/19lvTk17XVnkXjAQBkiru/nJ3UBQV9ZsUNcHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fqKkUfeT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zcBnGKH8; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714419475; x=1745955475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=86mQsfYJ30u8Tt1N6JKNurxz4i2hF7gOFyFzPXiMY3g=;
  b=fqKkUfeTV8pz5gI/iFzjjHGQa8lJBy+KPRtFmvN2ISKbdJoWhlQQnJbq
   aMGzRoXfJ55ppBI6U9Q0BO+xM8ACIPoFHmqFFMEFWzKbNSVfxKNl3n3SC
   XFB+C1xDTcnRjE3EQm5tAQxpi3Gs5XHKdQbp5HOGOoLztl1CwTuFesn4A
   BRg3/d1u4l2D4Zk61OuFBxlFM5lNdr03W9YtsimsWQxk7H1YFqwx2uyZZ
   Xtd7lyuAKCO+yUJwxJ9I0YIP0DEMhfnJNxAD6STecU1GpHep2FzfyiKws
   QSozntIL7E/h4ce27jU4afUcpmsTZX67xCKuMPVQy0Jiie3r9qnTLdX6Z
   Q==;
X-CSE-ConnectionGUID: +fr0igQaTE+L0cgEfcTZpA==
X-CSE-MsgGUID: S3v4u69sQmqm8I4+7gMt6w==
X-IronPort-AV: E=Sophos;i="6.07,240,1708358400"; 
   d="scan'208";a="14530778"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2024 03:36:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azvbLiCMnTDFqy1WUJqVv4ewOowVUBQvjp6+j6E8/SqbHsUItFFkA0uTAj9rSus/9sa427nEolI8s4tnOXMz937nJK40g78VsyOucOpfxdl7AzwVu7Xi2M0zzFSc06Vo5S/Vwlql1i/Hl09Duw8Co9Y0boE3OEgQ42GlIkWdZGYKpFX6wp8hQipObUX2fhu4MmIbWej82LkDuRagBSV950F782jDnA8FNAQXWyzPegvfDV2k2/zPi5K3RkdMbDkdj37he5r2n44m2/xIMM308r1d5XQEcgDD8kNuiUCjrh5Cnt7YF2KBn27uKn6ZgFpR38cWt2K6/Pgwxcya2GeGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86mQsfYJ30u8Tt1N6JKNurxz4i2hF7gOFyFzPXiMY3g=;
 b=exWIs4EqtbYmR2GlGx8x/n0BHmawv15ic0/Bz0Y4nWTx5bPxz63oBxh5eEPVvSby201pmvj+zj4t0STUU+oZ/VZ3giKJ0lbpz7T+7dB1ZM4+ywTUnxfJkWYbbbHqpU9uZ307olXwL379JWmOVG3l1rHbVbIOLrRL1EQIEwOVD0jH8ghaQkfX3TdBPlQg6IPWjFXkDY7FEbMNomcP2RWimGmCEyT4bL9TDF6LTPxhdb6AISZvtoCpogGZ0nDVvqs1B1C9ENN5pBJVnj7rmYhNyPI8dd/Pfe1i06jGw1ED2fXrTmQ1AUzg2Ov/6OZAZRPZcP4aPqFyN0MLRp6/w1ERNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86mQsfYJ30u8Tt1N6JKNurxz4i2hF7gOFyFzPXiMY3g=;
 b=zcBnGKH89+HBEfD50lLJIjATpJKAXNMlJXGdNo7llnFhEBDAzFaM/kCeiJrX006WW0l4dnXFBwBPm7X+tTrwiqIuMsGX3g1ppQM7cBi6b2UIy0e6WWI3a4B1aIEmNri21w41/8Vt6T0bacTVVOuj2I6vsQW45+cynesBHpTqA5c=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6372.namprd04.prod.outlook.com (2603:10b6:408:dd::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Mon, 29 Apr 2024 19:36:44 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7519.035; Mon, 29 Apr 2024
 19:36:44 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, Manuel Traut <manut@mecka.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Shyam
 Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier
	<jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: RE: [PATCH v5 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Thread-Topic: [PATCH v5 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Thread-Index: AQHalJZBAWmedfkP9UyAX8ZNIG7ZZrF4r/kAgAHg8oCABHiXgIAAB8KAgACeLfA=
Date: Mon, 29 Apr 2024 19:36:44 +0000
Message-ID:
 <DM6PR04MB6575AC5DEB3A46D1AE11705FFC1B2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240422091936.3714381-1-jens.wiklander@linaro.org>
 <20240422091936.3714381-3-jens.wiklander@linaro.org>
 <ZioXkvnIw5V5MXBU@mecka.net>
 <CAHUa44Fojanryuc+ciJrVZUopRLcTt2teS_pC4BBjt1Wmy240A@mail.gmail.com>
 <Zi9rKzz8u8z7cIy0@mecka.net>
 <CAHUa44HHtcaYXhcWg5zL5EQ8pEP7aEDKS+yjpaMJH8vTtF3xFw@mail.gmail.com>
In-Reply-To:
 <CAHUa44HHtcaYXhcWg5zL5EQ8pEP7aEDKS+yjpaMJH8vTtF3xFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB6372:EE_
x-ms-office365-filtering-correlation-id: f0fec506-e8f8-4fb1-5a91-08dc6883b3bf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXNaTktuT1dYK3FJV0UxSnhXZHhzekQ1SHdwV0FSdURsZDYyUXlTamZjTUhN?=
 =?utf-8?B?TGlma00xazV2Q3kwOE4wWDJaakl0QWRHRDhNSUpySklwV29UelBSTVhjWlI2?=
 =?utf-8?B?VGhkMklBU2RqSFp6ZDBNQ2dkODFoSGJBMFpqditYZFFENUlNSWdiMnh5cXhT?=
 =?utf-8?B?dGdaZWpHNEJlbzl4TTUvNVJvT01SZTN2NnhmZUtiVk5ualJVOW5hTGhrKzRl?=
 =?utf-8?B?endBOVRhUW5qQlNyRnlZMEdMUnVyaGV0UXRYUURPR1lDaisrN3YvQUJvKzJo?=
 =?utf-8?B?dzBUN3hzcElEUngyV1NxcmEzY2xqSzRpZzltYk51SWc3eWNFS1Q0OWhKRlFv?=
 =?utf-8?B?dk9MVWZsbjl6bm5TSmhqQ2lXWHdVU3hvY1JYNHlubHN2NVNxamhQYktJcmlC?=
 =?utf-8?B?THVSdlc1UTBubHRLUmJVQTM0ZmVZU2tZb1RZbXNKancyWS90SzdwUkhhWlE1?=
 =?utf-8?B?M05HSjI0OFBVeTkySnFBWmtEamtqb0pTaktPRWl4TEtjUGdpd0JRTEkzZUox?=
 =?utf-8?B?c0IrUXROenhCNlJKeEF0ZnpQMXhhaDM2WGlGaCtUbXJaOTV2SnBvL3NqZlN5?=
 =?utf-8?B?bnZRbmlDeTQvcitXSFBPRVFqdUVvRjQ4MFF0cURzN1c5T2l0NmNQWXR5NXNJ?=
 =?utf-8?B?bFF0QTVJT2ExUkh2czZtMFFFMlJjWEc3QVI1QS9rQzRwTExRTU9sdlVraHZh?=
 =?utf-8?B?bTZodUVSemFXanM4ckcxVVZDNjR6Z08zR01lWEp5U0k3QjQraS8wTHIrZFNR?=
 =?utf-8?B?YllVRkZYTFh1VFIzWkZKNDJWMG9CNjdKdFhOOVlHenk4V3lzQWZNaU96Qkxz?=
 =?utf-8?B?bzN4QkV5bkR5ekVnVnRIQ1BhNXlwcHNnS3VRZGtxUUpaWWFhVFdiNG1xdHU1?=
 =?utf-8?B?TGFaV3Fua0RFWVJpWkdmL1c2dy9oaDhyR05MYTc5dHpJK1ZDS3IxZlhFRlRN?=
 =?utf-8?B?bGJFR0N2NTBnM2RLYUFMSXJjUklKTE90bzUwdzJWNUVJQ2Vlc3J1TWJpdTRi?=
 =?utf-8?B?cmxvVGhnSnlBbVJLWno4dmJvV1JzcXUwWFAvRzdESHlqVlJNWW1hUkY3NkpS?=
 =?utf-8?B?ZmVKdXlCQngxS2NKYTFNTHJoeDlTVFFRUXFPL0hsTkx3NmxYVW5aQVRuQ1pn?=
 =?utf-8?B?WFZBYk9FOWtmaVpRZURqU2llWVF5R3lBa1lVSGlYb1E2bGsrUUVYK1hUeFVs?=
 =?utf-8?B?eVBIT3g5Rm5zUXFvbXJTcHIrYWpuMEFCTHNYTDFqVTlmemVidmIveWY0dGtT?=
 =?utf-8?B?bWpTNUo2a2ZuRndiSnNuZW44WFduL0U4SG0wZThqNzhkQjRYcHFjZWdNNTZP?=
 =?utf-8?B?elF5L3pCNWcvdUVqKzNZMGZkM1hSNE12cWd3MDIyeVlpTk5naFBHZzErUW0z?=
 =?utf-8?B?WHN3eFZ2QkhOS3NGKzlUTkZEOW1ZQ3RzMHdIclBkZGljbVRBTTdKUWxESG95?=
 =?utf-8?B?U0dHQTArYlgrVXZ3SkJXNFQrR21uWi9OS2JYT1k4emp6UkE5TE4vZXRwOWNy?=
 =?utf-8?B?NHh0WU12ZlJmeWtKVjZEMHRvTUpacWVRd3dIb0RBRlVQaWpZT2U2dlNFak9x?=
 =?utf-8?B?S2hLYnp1L1J4WkRWUTdFRWdYOWx0VG9iWC9JbFZTdUdCMXNrZEhicXRoTXFS?=
 =?utf-8?B?RVU5emlReGxleTBkekVES09HZjEremluL0lqSmk3QUg0Y3NyQmZaR0JzUEdZ?=
 =?utf-8?B?SWhkZWxHZG93WFBQL05rT3BvckxTUXFhQmNaZWFxMnZXZllLRnNnb1ZFdVdm?=
 =?utf-8?B?QnR0bzR3MWpycUxZMGFIYzVTSmY2ay9nR05hNmJ0OFhtSmNXYVpRT3d0ck45?=
 =?utf-8?B?dTR1Q1JKOENxeEw4ZEVvZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkRkcGpZcVpqUTVabU16eVV2RnZhSEVJRktTaHlaMzdaalUyb3FYcVVTaXlT?=
 =?utf-8?B?WWwyN3B5QmZaekx0cWgwbnR2SVJ4bXF3cXdNNjFtbDF3NTRHaGVwazIxYnhy?=
 =?utf-8?B?bkpva1dlV0gvSnNEc3VFejY0UzNyczY0bFJETU9lWDRrbkgzVUJqWSticFhr?=
 =?utf-8?B?cUJ4NXREWGU1NEhkTkVtNXFsSTFaU0xLMHZ4RW41WlkxUDNjNTZsQUlNZ3ZJ?=
 =?utf-8?B?U1FqV3lHUWtWd21zY2NHYTJYK2Zuemh4Yi9kOW50L2FzQ0tsNDBheDNPejJU?=
 =?utf-8?B?THhka2p0OW1mSUdmNFR3Zmg2b0Y4c1E4Sk9hM1pkQUtvN1M1RFJ3cEtCRzFo?=
 =?utf-8?B?K0lEdGhXS0hCazdSSUZqaGpnbkVqblNzRmJwU1hoL0NtUFd5RkxablFVZHJT?=
 =?utf-8?B?dXdTWk81ZDdqclJkejNEU1ZpSHh1aTZDdVVsN0E4aWtWYk0xalNqTDM1N3Vm?=
 =?utf-8?B?VkxUYkVlVVVIT3BYKzVLT2Jyem55VDI2OUlMZ1h2cEYvMmlRc2t2N3VYR0ha?=
 =?utf-8?B?am9wVWFUUzRRQ0oyaEhDd3NlWWplZHB1ZVBNd3I1THVaVjUrSmhGWndRUjVL?=
 =?utf-8?B?WnNuNnlJTUw0ejY4NUdTZGdGMURSb1ROejJGT3JscnZEMkw5aE93VjQrTFo4?=
 =?utf-8?B?YStxSEtWdEFVRDQwczFhditicmFmemJWVEhNTEJSUE9RNTJpWWFPdTM2ck5o?=
 =?utf-8?B?cGhpdlhFWWkxZVc2L29tblA5M2lsT2NrMGgrNXUxK1pSUkVaNGEvRDJkSTkr?=
 =?utf-8?B?VWdrRklwTnVYNUN0eUR5NmhoYytNaGJoVTZFNWtiU3BtVFMxV3BPamN2eWVO?=
 =?utf-8?B?bGtPTUNWb3F3eXlHcVU2NlhtQlpLaEVReXZ4SlcrN3d2NFJ3cnUyNWVoU2pC?=
 =?utf-8?B?TlFHazdwbitSaldiNU5VM1hDU0pScnR2OE9IL1FWd3RXa1hDTUR6M1lKNWV5?=
 =?utf-8?B?YTJPQlFuZ3p2UnJaZGx3OHpXSW1td3BwaFVSejBYSlpBTHgyZzBSdWpVcXRG?=
 =?utf-8?B?NWRaR3ZWVVYrcU8xOG5BSnZlWS9ualNEU2wzcjJjNmxZcmF4Ty9sMjRYbnFW?=
 =?utf-8?B?cTNmbEt3ZGZtU2Z2VWpxdDE5d2NrMGJHQk96RHdDdjd6bmxmZzlWUlRPaUdW?=
 =?utf-8?B?dFQ5RUFBRi9sc2NRTUdyd2tkaUNRT2JDSkVmT1Y2Nll0akNHNXNwdEtRRmox?=
 =?utf-8?B?bjcrcmdESXNJRE92MC85SUZneW9HT0FCTTlDbzJrR21ndHNsRkZZc0FLdTVO?=
 =?utf-8?B?aGdONTFweElzTHUzRmdrVTViaDhaK2lyTlNwMXF4aUp4OXBEK1VFT01oY0w0?=
 =?utf-8?B?SWR6djd0MWhObG9ueS9hS01ud0ZzY1A1Z1ZlL2d4d1dYT2Z4ODdiV3NtWmdI?=
 =?utf-8?B?YlFxL0hJSS92R3R0eUc0Qkg4My9GdmZtdEtUS0JyY0dRU2huT2VUYTQwQjRq?=
 =?utf-8?B?bWtXc0Q3V29ESGNOaTZvQnR5ZkdMaFg5bEV3YS81cGFsSUdoWHZBbUxScVNM?=
 =?utf-8?B?T2RaM25tbVhucFM3Sm9uRkJPZmM0cjFTMkZTSGg3dDhua3dac21qdjQ4MW5J?=
 =?utf-8?B?bnlaZkVGeUVBc1A4clU2QXROM3ZISFB6T3BIUFBYUjhidlpHMUxiTllKekJF?=
 =?utf-8?B?UngrRmlJSjZkclk0bVkxZHlhbytrOHFrODlKZTZwMzZWNm13MUVua0p5YWVK?=
 =?utf-8?B?bHJ6Q0ZmMERRbGg3V3RnKzNLRGp1VE1xYkQ5anAvdVFNSTFtZ1hUZVdaMmpn?=
 =?utf-8?B?bFZ6K3NqMjVHY1c2ZURMeExBcndhemZtaFBkRzVkVWYyVlpCeW1DUW5FN0t3?=
 =?utf-8?B?Q1VWMkYxSFZDMTF3WENsM0ZpK2MxWG9TdFlGNnVCNjVjTGpOWjhuU2h4OW5S?=
 =?utf-8?B?RTlsSE1vWGlsYlJIRG01aHViblhTRjBia0ZsLzlGZkppQ212Q3B2Tzc5cm45?=
 =?utf-8?B?Vlo2WnI1SEs4YkxYS2hZbFVWOU5nOUo2dWQ5bm1IVGpIZS9xMFZteDRZbGY2?=
 =?utf-8?B?NWFuRmNCVmltQ3ptbElKSndFU2ZGSGJhc3BFVm5EM2dsM0lDNmkvM1YzWmpo?=
 =?utf-8?B?Q3JKMzJtTTFoNHN3bFhjUHV0aEpUNk5IRzZ1Ti9Ma1FlWGFiSnM5cThCN283?=
 =?utf-8?Q?pgl0zE0U9neLjTaHiDYFrOFaU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IDRcuM86Z5sM5wrA7r1B9f7UgtAlAQA5ahj+MsHWOISx47SFs5/CSHUXe0sHLR5QiVI4jbh9stmdGvfD3Pm41n+PQ6NKnJ5M9QJizNNoWde8dAwuVl9cGzn1rEVmkpuuKv+V8S3UGhun/Q1heeEolv/hvnKTcw+OaXIWrrXnKgr4lzQ9MeSMncL+GVDf8xEet2qmYkyyju6eKeHReZJJaAFPSQlq9YaG7pO9VSggzTnyC+tsT+cv0KJgRNhoBNUODUeRTqWqw3oKIdvymnN292WYtCE9qm2bO8dAu2tCDasj6NK60skrTDPamLjxR6GgrE7TFh/xZqT/PZhqfkZrCD+vLWu1M4YAJ1jbYr30UueJ9muoeFd8MSbVV2dMoibg3julCQA35V2PKvLxgvdoxh2By/kDmf6VG/iMMHVznZeV7e5AvH+rM1oXze3CWPEjVfcJyIMQe3+zwBdygC29plzy2EjLUA4P2ipmpT+kGUyk8pbSpv12e7K77Kc8gMX+FRcGeFNccTAhgRNdHpbZ4PkPM5RtU+NO0du+CMWGEipkes2XEaA0+aRuKhEeRo+UPOOc8tRPNpD2wyMdwBgEeYnNfn3C373/aZwL9kH1+o9kSwd5uVOmtKXU+H8E6W4g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fec506-e8f8-4fb1-5a91-08dc6883b3bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 19:36:44.5027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3a3eZFfQFPaLjH4IVIO10v3HClLMTG3fEG/JCdYKRa0jH4L65unpvsn3I+9+shWjBT/IfTY7RdGG2lfiSUo5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6372

PiA+ID4gPg0KPiA+ID4gPiBJcyBpdCBwb3NzaWJsZSB0aGF0IGlkYXRhLT5idWYgaXMgbm90IERN
QSBjYXBhYmxlPyBBbnkgb3RoZXIgaWRlYXM/DQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB0ZXN0
aW5nLiBJIGRvbid0IGtub3csIHRoZSBpZGF0YS0+YnVmIGlzIGFsbG9jYXRlZCB1c2luZw0KPiA+
ID4gYWxsb2NfcGFnZXNfZXhhY3QobnJfcGFnZXMgKiBQQUdFX1NJWkUsIEdGUF9LRVJORUwgfCBf
X0dGUF9aRVJPKTsgaW4NCj4gPiA+IG9wdGVlX3Bvb2xfb3BfYWxsb2NfaGVscGVyKCkuDQo+ID4N
Cj4gPiBJcyB0aGlzIHJlYWxseSB0cnVlIGZvciBpZGF0YS0+YnVmIG9yIGlzbnQgdGhlIGNvbXBs
ZXRlIFJQTUIgZnJhbWUNCj4gPiBtZW1vcnkgYWxsb2NhdGVkIGxpa2UgdGhpcyBhbmQgdGhlcmVm
b3JlIGlkYXRhLT5idWYgbm90IHBhZ2UgYWxpZ25lZD8NCj4gDQo+IFlvdSdyZSByaWdodC4NCk1h
eWJlIGFkZCBhbiBhc3NlcnQgb2YgUEFHRV9BTElHTkVEKGlkYXRhLT5idWYpPw0KDQpUaGFua3Ms
DQpBdnJpDQoNCj4gDQo+ID4NCj4gPiBGb3IgUlBNQiB2aWEgdGVlLXN1cHBsaWNhbnQgdGhlIGlk
YXRhLT5idWYgaXMgYWxsb2NhdGVkIHdpdGhpbg0KPiA+IG1lbWR1cF91c2VyIGFuZCB0aGVyZWZv
cmUgcGFnZSBhbGlnbmVkLg0KPiANCj4gWWVzLCB0aGF0J3MgYSBkaWZmZXJlbmNlLiBIYXZlIHlv
dSB0ZXN0ZWQgd2l0aCBwYWdlLWFsaWduZWQgYnVmZmVycyB0byBzZWUgaWYgaXQNCj4gaGVscHM/
DQo=

