Return-Path: <linux-kernel+bounces-92909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B0872800
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EA028E8D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6977764A;
	Tue,  5 Mar 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aOia/ZHn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YpzAPIRO"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6118639;
	Tue,  5 Mar 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668299; cv=fail; b=V89ooOaINzQbLanP3Q0lNV/kAQkTTIIo85c6LiEsgWhdcaboeCeObAlCHN4xL4saSsgU/I2CaAoBFKnL0hTugtHYFtuxzLx4XdRpZ0gIvmSYQmEXQE9V1SbT7o4qSKelfMBrdSmIuHV8A0K5rcy+0d0MGTIJwXTdxehsNIvOjHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668299; c=relaxed/simple;
	bh=WUdaGK0v0K93ax6UKOEwcDkqRb0Sgbg5LvCP6BdqZts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/sMZxFSDcVITBsuMMBxMP6EyEu+/MTgoHBx11bnxsW+hlbUF1sIR3ZYOB7dy8P561l6GpyEKj4hECYeC6JerXGd8OquiTPO+gBeCNWZ1grjxpIXW0BOt5CPJNQv1LAkxo6+0pwGKNREeOuIzV1ElwqrdlfD9djepOYYc6D5CqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aOia/ZHn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YpzAPIRO; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709668297; x=1741204297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WUdaGK0v0K93ax6UKOEwcDkqRb0Sgbg5LvCP6BdqZts=;
  b=aOia/ZHnpeI22SCkvaSA1JibFp7ZVR99f7wLVXmbQAOrFhU9yQ0O1bvA
   uPGPvYSNZo63jRuWoF4mPIcY9wpmS0gWeBItd4VGJbWkGNraZswcZ0cTX
   GMc55XQO1gRjTLZHvIfQFExbryn3SuUQy5wKfl+DLTAp3OFVJm29YqEjy
   BZELPHrsQpHwFYB1CMyysi1OnaL7WnDuM/UE6+f22DCNhUVSSJMK/U8zu
   N8nHtZVHSTPJlnkIKp9TC9Z1ZZxini2K9Rdrvh6O3vdoRH3z9D8XbOT0R
   Xa938BRfDC81fm0IV7NypBAoGfj/ATB3txf62IkqF9TOnkLH6+84SlHHL
   g==;
X-CSE-ConnectionGUID: S1zyJJMUQT6/sq6fMm7cqg==
X-CSE-MsgGUID: uWKUjujyRTKRUD4FPCVJTg==
X-IronPort-AV: E=Sophos;i="6.06,206,1705334400"; 
   d="scan'208";a="11116721"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2024 03:51:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/kxwUDVAU20LPqQhwTs7+ywTJYcsdHvcsfOQaEqnP0sjCXeyxqOE935LpSCO4RES58YkAsFT5b6Wsmshr3AD3kRFyDc1RicdIJFLv/KVz35T9Cb6MIriZPYjQgrhfuRJTV4LNzsSmwscYSz5S5CzdXn03X2v7qmKB8llcUgFd2GKC6aBZ8PbM3VvVebwTjW8YZm+7RoAcK2CNBl/SIaMu7LFYAwaDbgmP0XqhrRzF4QJqTaZf8nmZgoukC2IygWz/sRgYYUWdNw7UCdvqdVsAtNUBIzkIF9fH1xBx1v3k0DUG0DeGt0Rf23Wtfnuaje2ATcMpOiXlZQepj/gv/ZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUdaGK0v0K93ax6UKOEwcDkqRb0Sgbg5LvCP6BdqZts=;
 b=M68a6RMzA5NXpnorkJjBfxTTw0FzQtvFfnj+izf5afY90et7rD2EQe9f6bJsoT244guY6K3+A+JAeVIwKTawzikXb08CvxEtKSBl9bFuzbw8Yaxg2t416PcT1yQ6hR3Nm2rxXI8rFoL6Jcva4p1vyDqXcgPlWCzMyWp9Mbn9X/mevEj7ID/ell7fyHtIJ9btQiKRLIKFIA8yW86EtzMOoDb6JT3PtKJVsPmSaaNdCXnAwtldJYvO4/AGovRI1D68b6kAf65hoOxUibCmLDkI+HpfaTEPycusAGbYaoDA7xslu8Xp2YCOE+389qsZe70nisxfYjR6woAdBMRxdrGDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUdaGK0v0K93ax6UKOEwcDkqRb0Sgbg5LvCP6BdqZts=;
 b=YpzAPIROD5CePZRc42Jllf+BnIs/WTdZA6Nn8m18Mj3+M0OjZCmQLDUF5pwNzbCGoJdJeSsw4mWOK96eio0WAFVN1bPnCy3qX7pKvpbxiATSp64hOai6fXtFodKxTm03YKL6eNaPYeb959nOonndP1UvNyguxkE00H4TIyplXbk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ2PR04MB8582.namprd04.prod.outlook.com (2603:10b6:a03:4fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 19:51:33 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 19:51:33 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "James E . J . Bottomley"
	<jejb@linux.vnet.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: Bean Huo <beanhuo@micron.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] scsi: ufs: Re-use device management locking code
Thread-Topic: [PATCH 1/4] scsi: ufs: Re-use device management locking code
Thread-Index: AQHabhW4Urdi3m0hRkG95EHx68mR+rEpg7yAgAANAvA=
Date: Tue, 5 Mar 2024 19:51:32 +0000
Message-ID:
 <DM6PR04MB65756CFC4DDEDC31BA4ED715FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240304092346.654-1-avri.altman@wdc.com>
 <20240304092346.654-2-avri.altman@wdc.com>
 <f6045888-bb53-4ba2-90a9-98fc6a5254ad@acm.org>
In-Reply-To: <f6045888-bb53-4ba2-90a9-98fc6a5254ad@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ2PR04MB8582:EE_
x-ms-office365-filtering-correlation-id: a768c8ca-4e7f-44be-c04b-08dc3d4da89f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TXIrE2Cjqv54k6mPx0ZPHumCYCNZPnbrbA+ewckIkmlVk12jXfN43lOGtpTZH26Svtp4tCUVgclwiWArzzgOs8AZ7VJl9dRwHLRQN1364qvSCiXrngHecy/1QqlU6wpXVcdi7bhwTKRpub74t5TLc7zwj7deykiTTuBD4iuYHScdrSEgG3oaCK+l2BNesrlPeS4+OCfshPTiYtBT2n/nU37T6u/uTSW0W/ydS/N6jMcKlgIMxT941x9Pd3hyy/cdkftxiinqtXO4spk/tSPhT7KNuq/ibnvMQC+0ZJKCK4aDPSncO3Q6NQcT9zGK/0VvBR2kLW16bjqQ3CR77/Q9omleS6cBovka5wEXqExtZT8ZUMd0toLkrVFQcQ2GTG2WSkeTrGMp+aJToQ/TDl3mAlqCs0nvPn6IbgcYlaFld/Q3oPJWL2saBsW9EQF433OGisQ5knlD6PgMSUqF8a/02ui/fNH2Xic9c+tbjDEFfLZQuina/5OcIX1aN5Z2fVeHfYwUELvrNzSf2gP20MIBskjWHJn5mzcZF6a2DrFhPIJ2K/3b7bSTOguxd8UHVEIUxekorM32mVjvYzytlgQ3MmQW/B2U6+JhwC4JokvoM1Kvq0dKYQBJy/ms3zdMVszvJXmHmmuSRMMJBQq88Bz6UK568lftY9myxTLjK6SddgzRYBGpwXVrMbGeVZi2TtutHE3zjGvHz6tN0U6XN7EHvJ647qTzexJ7xZpxBKoMuzE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vzd1dDhvKzhmRTBwV205cmlMSG1Xa2cyWDYzcTBPZnQxMS9SaUc3c0FYQ3Jx?=
 =?utf-8?B?L2Vpc0VPL20xSGdWdkdrMjFZdWt6TkNiMmIyZnI2TkFuVEs4bi9Ga2IxdVIz?=
 =?utf-8?B?OEQ0a0l5ejBYamg5ZnUvaVA0UjZ6WGlLcU8zemRXaXJORHBZT2V1UW1aSTVF?=
 =?utf-8?B?OC9IYzJheFZSTVJwT1lXaldjNUY1cElGNEw4OHB4dnpGanpTVWI3bi9wcFZF?=
 =?utf-8?B?NkdOeXNSeUhKSmYzdk9BaldsU0oycWZQTEZKdlVMcGRic1JzYUg1V0QxNUlW?=
 =?utf-8?B?TS9pMlNDNmxPcFJla2FvQjNVem1qMXRHNjlGOHFvaFFBQjVvZ3BwWXkySzhQ?=
 =?utf-8?B?V2JxMTBhTTlxUUlrVW1qc0VFUHNLSFpVdFFWRkphNFFzNGF5dENNdmZJeEln?=
 =?utf-8?B?MFRKSFplZHhVeEs2V2N5YXBPK3lEQVVEMmhPTk9JV3BWdVVCR1hHSm5TZjVB?=
 =?utf-8?B?MnQ5U3ozN3F3QnZDb1Q3N0xYZjJGRlZIdjhFZUJQRG8xQUZuK0lTYkpVdEF6?=
 =?utf-8?B?VHpuRzNDVC9XUjl2Ujg4eDdOdzB4NU5kM0JFWDRnTUNnYUhwTUR3eDZIekhM?=
 =?utf-8?B?OWRDUlhlM25VenZNV2hCSjRGYkROTTBzSDBYSU1mTVBoczNWSkkrS0NLc1hO?=
 =?utf-8?B?cU9uM3Zhd3NzWlZ5Tkh5RkdLeFRXVVJqSGdHekJlUXpyZm5peXEwYTVJS3Zo?=
 =?utf-8?B?aWpaYkVjWGloSmRTUWp2Vzcwa0RBdC95M0hheEtIRzVrOGtVRmJEQ25vQlNy?=
 =?utf-8?B?elBTTzFSK3FWOWt1VERNMGtkSTZFNFhPc0tLeitYTFJkeFUrMHRxM0ZuOWd1?=
 =?utf-8?B?aWdldkhhN3NLUEMyY21GZUtSTDh4NHluYVVwT2psR0podkpmV0ZkblJqMHpJ?=
 =?utf-8?B?ZVdLUzJzZlBqOEg3RjdIN1YwK1BEeWZCc0dUR2RTa0lBL0dpaW9qbWhEcTJF?=
 =?utf-8?B?dE5jMFEyUVJXTEw5Q1NweklxYXZJc2psYjQvUW9rc2ladWQxVG9UeFBGMXVC?=
 =?utf-8?B?emVlQ2g4WjVVL0lqenVwS2dxN1BNYmNyNnRiMS8xdWQrbWtDNWwyMGliMWUv?=
 =?utf-8?B?MDRLQ1U0TUpkbDlRUzI2TlZoNFJBWVd6V0JTM1BCUEhwbjNZMjRMSWZrdVpI?=
 =?utf-8?B?WEI5WmpWMEpnenFJOEpSNzZMdWJ5T0hic3ZaM0ZnUldIbUQ4OURWdVRzZ2VB?=
 =?utf-8?B?b01ncnh2aVNwdDd2RTlrK2JqWldOcnM0RU1rYmZ1QmhYeFlkMjRpVGtTbUdO?=
 =?utf-8?B?Q3FJMHRxV3poaEluUXIxd3ZZT1ZUVDRmazlUZ1hWblB0RXRnWS9RcFhLd3or?=
 =?utf-8?B?QVMyNXREYVNVcHF2YTVYY0VlLytFeUJrVGovOWV1OWplbEg5cnk2b2J0QXVj?=
 =?utf-8?B?d0UwOTdvdWd6TW5XM01PeVRwTTAybkxiM2Fjd2pBekJ0ZmZrQnBwZHluWHdI?=
 =?utf-8?B?RkdpRlJ5d3doSDZSWWFQSExmZWZXb3J0Z29kU2RJTyt4QWJDZFFKbFcyUDFR?=
 =?utf-8?B?L3JtTExOSUQ2THVTTm5KU2VnV3NMSW1YdDBGV0JwTHRTNWthb2hla2RNamJG?=
 =?utf-8?B?aitRelRNOGo1VFdEQXpSY3dxeUx5K1ZUNjlPTEFSaytDbzdoSmpzeVcwaXk3?=
 =?utf-8?B?VkxWM0k2Q1o5d3k2ZGdMWncyTGhQTk11S3NhTHNMWlBqVHF3R1A5K2ZOdUdu?=
 =?utf-8?B?dFZndWZGNTRBQThYUU9BbG9BcVAvS1lsbnBLVlo4Qm90T2tMbjNjVTFBbFFr?=
 =?utf-8?B?enVvWGpyQ0J0S3JkNWRIZmFmK3AveVVtUTJQK05ydEZzNFFLMDNkdlBXTndS?=
 =?utf-8?B?VTF6KzZWZ1hjNjJuZk1aUXBMYkN4MUhKV29idVd6Q3dydHczbTF2d2VZSFR1?=
 =?utf-8?B?VUhTRDBlNFpPcTN5ZGQzdFdVYkFsK2ZsNjJuSzd0NDVIL2xmcExNazNsUXcr?=
 =?utf-8?B?YXRWVFFTSElVL0dLeDFKVlFWbWVkalFUcUowTVdUSC9tOGlYWFJIZlVCcElN?=
 =?utf-8?B?aHJpYUN1eURBSWw4TGZVaWFTU1E1RC8rNUVDWWJxQXhyV1BzUFZNMWpnSExF?=
 =?utf-8?B?eUV5K0lzcFdqeVdIcktZZlVuWWNXRzQ5UUpldk5ZTFRjaWJZWk45anZCVU9q?=
 =?utf-8?Q?HVKDEp8rnVf4MU6h3oRKu3c7G?=
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
	a2dsspXALYPb+lrBJ1cLf4ewu1sXfO7h1aAKwNvRm8zB9Nu3KTowp/PP+KuxD5f8kNINQ24oA7I6wzp84NDt0s16AHAPwY9cTY10jWr0TiSHaYTm0tN4AxRCvCghKTgobW64QT9koh6swSwySx1l5iNKBUe8NQUMYkLQB7PxQMcxIq0RvLV6/HjKX13Ft/tUHn4UwZ8XWqiSzMof7p7d+uRaBC1/Jx4h7klyS/gpT069uotAqs1BL1SPZonuOme0h4nPAwpSakdT0SJMF3X353lzDUM02ej54Omr1QmwMKN4V2Mzz5Ex/4vOCc1IkjMRx06aBViSQnAP9S1/Jvk8kwQv1nYm5KplHg4bKVihk4bEwO3f92LkEybrz5rPEwyn1Eukq7jH/t+xm0blLdRO9DHEPoRilIfeyEkKcUw3Y9ZGuayGn8aBYiwXwupXOOxZXp8gUC17O+KJDIzerK6kUEByB6Q08Wq3GOlaxUqYVy7FMrwy5wLeAFkzXERLG1umnCiNzPsAd6Mq2f7amdngv84JK8gLQFqUjrACxY0o3zABMw3g0g/jK8wlB/Qmu7AkGIlPDpYxYL04Mwz2V+tcge+wToiJm8Ctlth72ZCsTgIb1L7sqno0NHCQt1GCNskG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a768c8ca-4e7f-44be-c04b-08dc3d4da89f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 19:51:33.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqyU42tWxZuWEb9GAOSaxNqEKLUM39AmPVVQ/BnUcJSVa2p1N3LTJHfHHAhVYxOHqLEQzP/GEUIobMIGR0M6AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8582

IA0KPiBPbiAzLzQvMjQgMDE6MjMsIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+ICAgLyoqDQo+ID4g
ICAgKiB1ZnNoY2RfZXhlY19kZXZfY21kIC0gQVBJIGZvciBzZW5kaW5nIGRldmljZSBtYW5hZ2Vt
ZW50IHJlcXVlc3RzDQo+ID4gICAgKiBAaGJhOiBVRlMgaGJhDQo+ID4gQEAgLTMyOTEsMTEgKzMz
MDUsNiBAQCBzdGF0aWMgaW50IHVmc2hjZF9leGVjX2Rldl9jbWQoc3RydWN0IHVmc19oYmENCj4g
KmhiYSwNCj4gPiAgICAgICBzdHJ1Y3QgdWZzaGNkX2xyYiAqbHJicDsNCj4gPiAgICAgICBpbnQg
ZXJyOw0KPiA+DQo+ID4gLSAgICAgLyogUHJvdGVjdHMgdXNlIG9mIGhiYS0+cmVzZXJ2ZWRfc2xv
dC4gKi8NCj4gPiAtICAgICBsb2NrZGVwX2Fzc2VydF9oZWxkKCZoYmEtPmRldl9jbWQubG9jayk7
DQo+ID4gLQ0KPiA+IC0gICAgIGRvd25fcmVhZCgmaGJhLT5jbGtfc2NhbGluZ19sb2NrKTsNCj4g
PiAtDQo+ID4gICAgICAgbHJicCA9ICZoYmEtPmxyYlt0YWddOw0KPiA+ICAgICAgIGxyYnAtPmNt
ZCA9IE5VTEw7DQo+ID4gICAgICAgZXJyID0gdWZzaGNkX2NvbXBvc2VfZGV2X2NtZChoYmEsIGxy
YnAsIGNtZF90eXBlLCB0YWcpOw0KPiANCj4gUGxlYXNlIHJlc3RvcmUgdGhlIGxvY2tkZXBfYXNz
ZXJ0X2hlbGQoKSBjYWxsLg0KRG9uZS4NCg0KPiANCj4gPiAtICAgICAvKiBQcm90ZWN0cyB1c2Ug
b2YgaGJhLT5yZXNlcnZlZF9zbG90LiAqLw0KPiA+IC0gICAgIGxvY2tkZXBfYXNzZXJ0X2hlbGQo
JmhiYS0+ZGV2X2NtZC5sb2NrKTsNCj4gPiAtDQo+ID4gLSAgICAgZG93bl9yZWFkKCZoYmEtPmNs
a19zY2FsaW5nX2xvY2spOw0KPiA+IC0NCj4gPiAgICAgICBscmJwID0gJmhiYS0+bHJiW3RhZ107
DQo+ID4gICAgICAgbHJicC0+Y21kID0gTlVMTDsNCj4gPiAgICAgICBscmJwLT50YXNrX3RhZyA9
IHRhZzsNCj4gDQo+IFNhbWUgY29tbWVudCBoZXJlIC0gcGxlYXNlIHJlc3RvcmUgdGhlIGxvY2tk
ZXBfYXNzZXJ0X2hlbGQoKSBjYWxsLg0KRG9uZS4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBP
dGhlcndpc2UgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLg0KPiANCj4gVGhhbmtzLA0KPiAN
Cj4gQmFydC4NCg==

