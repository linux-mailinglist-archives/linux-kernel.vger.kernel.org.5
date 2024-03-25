Return-Path: <linux-kernel+bounces-116681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580388A28A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91011C38D90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4F084D22;
	Mon, 25 Mar 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qgR4bdnt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S1uF9v1L"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2EF18AC66;
	Mon, 25 Mar 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354083; cv=fail; b=cPKrn5yv91yD1CMw4BS/5rsVzZd3oyAXrVz1cOX4ixIzwuye7k69MpF6VZ/R+rhNoGnn10+Lhimxr0l7GArjMBlrf6Q+t6B8y7AX3+KSbCzYhxteyBxRDtEbFfN7RDWLF7ms8pI+sGAYbwg8Z3rdriaPBE7fZr6qOUWhlaD/wtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354083; c=relaxed/simple;
	bh=4ykdntTSUrbc30Sj5X8Ioew7q7zVF0ETNOwavUNijgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qgRx7Wj8RAx5MS/I/w3r4tEAl0dFJ4CnGGlJ+nzJHhdrFTuR9DQebWPEBdf7LOspbUil9eYUhY9kZe21tBI1Y0/msIK6awSkgYlUt1bYaDZVHTQtZscYqrqE2eYfZAmyUY/gFjQBb4E+VgfmP9lFy06TKOtBA8mXOxH77Ldshtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qgR4bdnt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=S1uF9v1L; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711354081; x=1742890081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4ykdntTSUrbc30Sj5X8Ioew7q7zVF0ETNOwavUNijgY=;
  b=qgR4bdntgUHCzx9OyZ3lNuUiG97nxgGKolYrOACL80vpEHXb72z5E6l8
   FmFxXyaOZBSJp4azp1NC/IcXEep7KI8UzxdIs+Th7Fksls2LAfpE2WaEx
   neeIyXd5IWNmbewV3FGxvH7OkorRtSxybuWtArA+tjsoQEYsF8NnmmpcC
   B3kDCEM6Dm8hN0rUJtvW+bnQkjbddzRU0eRpWGJi3Vx1cz6dbIFGeyU/v
   isF/Lug/scAKmjB+Rloau8Ny1XPM9JZCjefU9kcLunAbcqpcA7KEO84Au
   KAwgmcvc6sN8WF7TfRY05c1HnoWP5MsyFw5+qq51orQ0NdwGk+hUjwPB8
   g==;
X-CSE-ConnectionGUID: hfCPAqqcSn+kBsOgMFW83Q==
X-CSE-MsgGUID: UuV5pOGQTFaIzH4OCBOzUQ==
X-IronPort-AV: E=Sophos;i="6.07,152,1708358400"; 
   d="scan'208";a="12398476"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2024 16:07:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYMQhfeamMMDq86nuO8nLi7wyT2LKl7EhYL4HevRhvmbkp5MNa3f7qiWVuuo6n4gCCAW04UzABnP0RRo8SvE6CJcYuasD8E/oZXt6Lr/ZuWy0So9OpMLUWdYDRpxXBK1BKNmv8ri3ga4aqfBUc6/axAEnZiA0lVHV6WUl9jmLJcfmueayg6WTL/6Jqi4FVp1EhH3v1+UmZ5+L8TIOlTh8XAPFkpyWuSrltANEhA0Zs9MCPzDPo6dsxHvRTl8ROTLpGJkL58h455yJ1lTN6gW3V20YIglYRI0x7wso3rf83B5B+xIdg+IaaCD/Ev7VEVpQvYjitlNQtGj2v3WdW14BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ykdntTSUrbc30Sj5X8Ioew7q7zVF0ETNOwavUNijgY=;
 b=A8sM6ZumJSMbikEzqIYwoN6f7SAE9XJ+0lPhsPhJ/IsAQ9K7Gd5Pm4MdBcH7T4vyrM+U18yFepkGQdCUcrHUuI73UnsZ6sz/3/xc3uXZe3P5NW+OHPXptqdz/f84H0XiuTMcdsF748iXmMKIf+IwiKMHwkqkev3Aea8xfq7Cph6FTfW+vf+fBDIcZRIxl/5rOjkSA1X7VnuGP/wXaEg25zl4GLe2+YzDIU/H/VBTnZZfJJe/revFKIYExEXzx/V44fQk49N00eklOzkS9124fLEbSF2RuWMu/MTWxeDo5Zu9NVijhKZoG1XtXy2XZFocnOmwGCZm6JOqjxUrPleOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ykdntTSUrbc30Sj5X8Ioew7q7zVF0ETNOwavUNijgY=;
 b=S1uF9v1LQpwdBrdle+xpBRp50kcGg9+Ub3o51uJnbznInRIDM+lgic5s6ORicg/abRqa0xrdjVAjwBlATLCz5yJO7+BE+fH0ul4/lxAkA6UQvdfQgUZthI9ENv5Kz+IbMTx0FzyRZ1yIGXbr6u4IPDjlZQpEcw01DQbY2lPbn3w=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 08:07:49 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 08:07:49 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Jens Wiklander
	<jens.wiklander@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Shyam
 Saini <shyamsaini@linux.microsoft.com>, Jerome Forissier
	<jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHafHWUHYnDBx+cqkmeMEfcmLAlb7FIG1uA
Date: Mon, 25 Mar 2024 08:07:49 +0000
Message-ID:
 <DM6PR04MB65755A95AA492565F7576D10FC362@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org>
 <CAPDyKFp5j+L=oE1uVyUdu7rVLxRcueWwP0XcNTTMMrFQgmeZiw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFp5j+L=oE1uVyUdu7rVLxRcueWwP0XcNTTMMrFQgmeZiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BY5PR04MB6549:EE_
x-ms-office365-filtering-correlation-id: 78b8e88a-eb84-40d4-6210-08dc4ca2a9af
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /nVmTgt1lqC6nqaQfYrxy+az/gUBVeQL6wTOEpxuUmJsZgd3tISKJDsWJ2lmpUDibmvWZCYaYmu2Q3TUpOe2zWoR2RTd3NEO4nh6zsjNNSgewnA20Y32MCXHIl6ISW9bu6aEsBwytuYEUs1Q1LfWOZWlqGTpQRI8RwaWNRuj95Le+aC4x319jAA+Bb9A3pgQ5NMW10+1/5EagoxY2dAoosB0qm0HgBqmFMdFA1qMD63AowwiqlkcYiQtRB02cCJPdQRAKzgTewQ2lUMAsHQv/NRRNH391UX0fBTZV3s8i8679GIDDRMym1TZH+oLmDFcpWKwkMR+ZV7Yt1JezJKoeSgyJmuOVowavDGoUHQPHVu9IGWG495PyPTTyL8Ud5NDv6rMTv/WSl8fXCzynQkaYC0clF/dTa2Taewp8dywshB6sDtRvdZLN4XRhPhcczz8Y40LE/UtUZFOrb2qgmuBZkPS2KLyDPHXvhBULuHcnd4y4WJ6VHMTTGiguLhJFcV7xWyEYtaBh4Hy8k0lixCiGBJrSNGpEx6VzTLwt+PFhKmeDqhalNeTz0ENwrmOCArWbkFGpigOxVCdkujVKF/lb4Fpg7zA3cO7sPUW4IY7M9BTJVAThXELYbWNmSQqpVjAfz/wizGFJlScgV6xNZwHBSTGIFbRm7Ns/U5vPx0ZfzGg/54QhSWnaTF/jeykK++gLR4rEgeeYEnZVFol7kkM0Cfo4k/70csAjFnWhalpqaE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b01JSU9LcHVBTkF5TDI0SXFIMTlLeU14K3dFRmNBZjBIbmcydGtJQURTOERJ?=
 =?utf-8?B?dkNJSVErV2RyNDNKeUNvdkxURi9OQWd6ZjhkNDh5MUl3YkVKVHJ5eGxibWxK?=
 =?utf-8?B?cGpmVWs3MHZWeHBRbS91WEUxRkVvZEVVVEphRjVJSU1vdHpzTVBKYS9GejBR?=
 =?utf-8?B?OFVRcU8ydmtBbVF5T3ZWekQ0N1BUQUFHdkRmbjV0WHhRY3pNVFVZQ0pMSDRW?=
 =?utf-8?B?UThFVjRnNjN6YjR2WW85QUF2d1hWU01JU2kwcm5Sb2NrOEh4a28reVptNGVZ?=
 =?utf-8?B?L3FXNjBrOXlkSWFtaTh3UEJ3OWtCSjlReEJjbjlka2w5TlpJRU9hZ0cyVnBW?=
 =?utf-8?B?YjZVZmowUXdMQlBOUGljcm1laTdPbWlibDd2WWlVQXlQWlR5bFE2a24rWk1P?=
 =?utf-8?B?Q0x3S0JKeVl4anl2dWRVMDBLbFhUY0dwLzRWM0NUckgrZHAzN2d4VWNTbEkr?=
 =?utf-8?B?SDF5TTNJMittNjhZNjJuUWd3Y0VNc1F5NHRZNnBVRFkxMGxNVy9XcVB5N2l2?=
 =?utf-8?B?YU1qNDMzUk9naFBlNkIzb0ZBdkVldnc5WWQxUEZxdDFzdmRkblV6QTV2aGEv?=
 =?utf-8?B?MjlHWlYwNlAwOGxCVy96dU9qcUFTYVAvaDRGTSt5ZjdSZ1hTUnhYSnRxdHhV?=
 =?utf-8?B?YmI1QVRBVE56ZnVYNFZWS2Z4MEJ2enZCd0U1TFIyVUowdkJKeFIxNk5sMlU2?=
 =?utf-8?B?bGZ0MkNNOWhGeVprREJSbW9OL1ViL2ZhOVlvWnBnb2lqWHhHZ1N4eC9HZE9Q?=
 =?utf-8?B?UmlIRURXZ1lLK3Q0dW1IMzVYeVF2K2ZETno0ekJ1aGpITjBCUzlmWnF3djBG?=
 =?utf-8?B?ZFhYQnNCV0FaR2t2NzMvYTVKV0tsbWdoRWZXeWZEVFBlMndFRFNYQXgvVDIy?=
 =?utf-8?B?TW94NW1KMDRhcTRtd0tZazZJd3FWOFlHRVBHRzNuMlEvVHUrOVVMSFhzNWRT?=
 =?utf-8?B?NThCN09XazVmbWpFMlkzUk43dk9naWRnKzhUY3JFYy84NEJyQ2loYUU3bzlL?=
 =?utf-8?B?VGhMcUVzQmZDT05uUFlUNkswZlo1aDFOc3NMMW1wbmNFY2RVYi92eS96UlNw?=
 =?utf-8?B?cFI3K05ocXdkSmZIdllLakovQzdVbDN3STRsN3JaU2JQVkNKY3NsQjlGTmJn?=
 =?utf-8?B?SVp1N3lQSlpqbHRNQjBCMWU2RExJVklEdzNlMnV2OTA3K3V6SzRuY3l5azF4?=
 =?utf-8?B?QWYyVUo3UzNwRlY3c0MwZStyMVh4RFQwWjJyc0JDNHBoSDlBMEpFZ2wxbEVw?=
 =?utf-8?B?WGF1YzU3ejJGK0loSzQ4S0M3Zks1N29QTmlha09lME8vODJtdHY2NkY2ZEk0?=
 =?utf-8?B?a0plaGg0a29pcjZCVzRwdElWdWdhZ0QwaXZkbXFpczQ4RnpBWGJPK0hzN0Fm?=
 =?utf-8?B?bmI2b1htbUZQbjdncGo5UzY4TDdaeEkwNk9JZkJDRWo0S2RNRnBJUHB4SGxi?=
 =?utf-8?B?eGVXb0pLcVVtSkUwTjJEcWM5Qlh3Z0hldnk0OUVIRzBETHVWMGFQMVJ1ME9I?=
 =?utf-8?B?WGM1bUpDS3JSN1I1K3dKSUFTck1QNXdjaENkRDB0SlBYdGxSa1FPM1dTaGhz?=
 =?utf-8?B?K2tqQWdxaGxCUmlkK1JZMldVVmI3VVRjSlVwcklUWnowVkJuYitTTk1VbjF2?=
 =?utf-8?B?eWd4cmR0Y0U2Szd1dGVsZlY5ZThZZEROMzYrQWFMaVdGbHpRWHBCZDdzRVdK?=
 =?utf-8?B?RDE5dTdCOExmdUxic3hmOEh1czFFVGlSZ241SlZvNmNXdzBZS2wySEYxL0lx?=
 =?utf-8?B?UGcvalk4TU01WUhsV0k0NWFmb05JcUMrWHh6TFExckN2dEc0eGZwYXhwS0NC?=
 =?utf-8?B?N2RPU0VCN0MzeGd6OUxMZ0Z1OHE2VGdQN2N3VXhlSXdYRll1TERMVXpQT2NN?=
 =?utf-8?B?a0dEMHZCMjVHWktWRnJWT2V0U2tRTGtjUEV3WWpueUhsR2J6SFlGZnJBSGt6?=
 =?utf-8?B?MTVLQ1pZRWh1bXdoWjR5V1BvakZ2cVBUdUlFZU5qY1VWcmdGS2E5Y3RaeTdn?=
 =?utf-8?B?L2IxVWh5WGpTT3locXhRNjV6YkVTanVWaklaTmZkS0o3SGhFVVlsYk91YmlE?=
 =?utf-8?B?cFB6bnVmTk9WRkxGckVROEpyWGUzczFPdWJpcmJOM3U5N2c3bVBIQjgxZVFZ?=
 =?utf-8?Q?EKkuS1Ir0g/U/rNaKiPn1ISec?=
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
	nrTQ5SJ52ePR2wF1BNDFLc4x5s8kRDePJLKcs5ml27v5z+gpn7RNshsfVrEUYfMGKX0scH2gb9bbaB/at1j+1KIaND8qzvcbGLoPy5xkRGicTGyfFjGSQtj3w7AeX2ltZvKMe/F3Kj8u76npQnQJlZrNDuEPq/t6MKGYUxAp/m38E1mRUjGsM95Tn1a9N22j8k/q3K8VxCJDy9rSy86UsRFLkT1c3CPqfFNrEV1wsfjsx3Zjge2DxDBaodWOBWE/nVIrXD9G3Nyohqxe53mK4TSBnx2c6QPRcXOEpmMPXG2ISbn1uLujh0OaoVuz3TtgwNHp82N1yf68+bOWQjqJjTflygc/xB/jyLmKLNIyONFtcVN89+X0zdQoBPOB9kvRrBzImoDrrF7lEg5O3yvbpUiQ5SH58KdKxbeg8jC4Pt927VLwmib9jBQG2I5j/BEWlUZAsIH99Q4PnBQcHWVAZjSxY2yjDTcaOfK9ecjuzC7fivx8p5Mou0bHJ/xTnWfZ3ul70wvkBSDlb9kXyp4i7qHgFw0TPuP/SrioCEBK7t+0oI9FbG8ZE00/8JwxMR9izhtNFn5B+qbfNk3PFoY/jl2OMSQ746hTIzyo9r6BQVWj8sAqeFFF8slwfeF2ugoI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b8e88a-eb84-40d4-6210-08dc4ca2a9af
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 08:07:49.4887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wkfk+CJdh1zl4ugxuAS/bEQ6q673ZF5pDLqQQPnumnye/xKUkfGf6ZQRb21boiHR1uInxwDIbX8nMrvXHBgyFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549

PiA+ICtzdHJ1Y3QgcnBtYl9mcmFtZSB7DQo+ID4gKyAgICAgICB1OCAgICAgc3R1ZmZbMTk2XTsN
Cj4gPiArICAgICAgIHU4ICAgICBrZXlfbWFjWzMyXTsNCj4gPiArICAgICAgIHU4ICAgICBkYXRh
WzI1Nl07DQo+ID4gKyAgICAgICB1OCAgICAgbm9uY2VbMTZdOw0KPiA+ICsgICAgICAgX19iZTMy
IHdyaXRlX2NvdW50ZXI7DQo+ID4gKyAgICAgICBfX2JlMTYgYWRkcjsNCj4gPiArICAgICAgIF9f
YmUxNiBibG9ja19jb3VudDsNCj4gPiArICAgICAgIF9fYmUxNiByZXN1bHQ7DQo+ID4gKyAgICAg
ICBfX2JlMTYgcmVxX3Jlc3A7DQo+ID4gK30gX19wYWNrZWQ7DQo+IA0KPiBJIGhhdmVuJ3QgbG9v
a2VkIGF0IHRoZSBOVk1FIG9yIHRoZSBVRlMgc3BlYyBpbiBkZXRhaWwuIEFsdGhvdWdoLCBJIGFz
c3VtZSB0aGUNCj4gYWJvdmUgZnJhbWUgbWFrZXMgc2Vuc2UgZm9yIHRob3NlIHR5cGVzIG9mIGlu
dGVyZmFjZXMvcHJvdG9jb2xzIHRvbz8NClRoZSBycG1iIGltcGxlbWVudGF0aW9uIGluIHVmcywg
aGFzIGRyaWZ0ZWQgYXBhcnQgZnJvbSBlTU1DLiBFLmcuIGluIFVGUzQuMDoNCiAtICB0aGUgZnJh
bWUgaXMgZGlmZmVyZW50IC0gc2VlIHN0cnVjdCB1ZnNfYXJwbWJfbWV0YSBpbiBpbmNsdWRlL3Vh
cGkvc2NzaS9zY3NpX2JzZ191ZnMuaCwNCiAtIEFkZGl0aW9uYWwgZXh0ZW5kZWQgaGVhZGVyIHdh
cyBhZGRlZCwNCiAtIHRoZSBmcmFtZSBzaXplIGlzIG5vIGxvbmdlciA1MTJCeXRlcyAoMjU2Qnl0
ZXMgbWV0YSBpbmZvICsgMjU2Qnl0ZXMgZGF0YSkgYnV0IDRrLA0KIC0gdGhlcmUgYXJlIDkgcnBt
YiBvcGVyYXRpb25zIGluc3RlYWQgb2YgNywgDQogLSBUaGUgYXRvbWljaXR5IHJlcXVpcmVtZW50
IG9mIHRoZSBjb21tYW5kIHNlcXVlbmNlIHdhcyB3YXZlZCwNCkFuZCBwcm9iYWJseSBtb3JlIGRp
ZmZlcmVuY2VzIHRoYXQgSSBmb3Jnb3QuDQpUaGlzIGlzIHdoeSBpdCBpcyBiZXR0ZXIgdG8gZGVz
aWduYXRlZCB0aGlzIGFzIGFuIGVNTUMtb25seSBpbXBsZW1lbnRhdGlvbj8NCg0KVGhhbmtzLA0K
QXZyaQ0KDQo=

