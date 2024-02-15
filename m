Return-Path: <linux-kernel+bounces-66532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC15855DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DBB1F22115
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51B417584;
	Thu, 15 Feb 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lRp0089Q";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oJKSKHxI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68701A58E;
	Thu, 15 Feb 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989209; cv=fail; b=GbmIr+mdp3CySPjksvQ7MUIdIfKj5w4VIdzv7LmeCH/QA/JBmzHcjSqSEPfhflhaATL5SVGMWaZdhNROlAxmJPjWv+FW7Q5lJHWmq0IrvNN5/BU1xg7AFZ26/mR7EtzoudftYxL8RqUcefJ4E/Db+kKso2iyrSzt2lLMDNa9wy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989209; c=relaxed/simple;
	bh=ZautPkO0D24b8RKDRha1v/TGl0FkGuJv+IsVldaJzOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qx3dTYzr4RYYmq4ycsjPcchRWu/J207L0N/QEx4ZgZk+KogQ9ZtU4IWNVVyJIFlGlRncV9YQAuEa4k240hsGq0/8WaETQips0v0epOTzTPcgu9JsVpKlAEUlqvT1WZrRf9R2W/axME3pCl3cGYgLahe/gg1hrmLavs9sjQWxdpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lRp0089Q; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oJKSKHxI; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707989206; x=1739525206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZautPkO0D24b8RKDRha1v/TGl0FkGuJv+IsVldaJzOw=;
  b=lRp0089QDiS1OhCP0oVPB1gpgMteZwiO3pkd+0BNnTllkC3nx614MQJ+
   q8EPSOlpJfA5PGaD3U0OIMpcl9PvK5HW84PyPMhn794ZzMlRvMzQ62+t1
   KC/0cyD9+k5bew7I8yQSWUeYTSz9V5YqvYqxoQ9fKEt7XIz3PTO5EQrsX
   InDF8oswjXkwfh7Bolt9RPLN9YpgaVj4LiVHFSrICpMKk1g/hzg35JtrA
   aukRhVPGnktpUl5FlrqRjnqnT7CCK9QSFbvgdZwr2vCqltFv1J9MEgAHX
   kFnZPLUOYNH+YLE2kUxP0M1KZ104RuFUuSafIT4DKj7EcheB7KAAb4ycb
   A==;
X-CSE-ConnectionGUID: q00nFAy0Roar9CCHZpqdbg==
X-CSE-MsgGUID: 6BmeVFErTjWqKiTVBF8Zjg==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="17744742"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 02:26:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 02:26:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 02:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY+w+8zdlVKSkx9nDl9skDAu8Ar7D7Yxx2AF7ugiPeor3+OTiht2NOMP6140K0vvlCXiwQ10iRuxm8Xi3YRkdVOFuzAF7CDWoSaxJlMYhR4oYZOsKmxD/Sf616NcPEAYUXQ/pqrL/INNsHMVLvE7k4T+l9m2U2t8GkG8VCd6t/iPDgmdwKhv7GuVW2MLUumpRuy2LRQcOK2pZ7EbaMNc81oc0J/Gm9CuDtAbd4DMTc1X93AqQJFxHdee+SNqDso043kLamSKZCOOeGa0OvZrUY1NAk8BL0WmF520O/ttWLHsHcgViq37B9M84TDjjtdAFO1pntOmM0aplAlA+phbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZautPkO0D24b8RKDRha1v/TGl0FkGuJv+IsVldaJzOw=;
 b=Vk3AQ+QOyjF6jEl/fYvin9ui/naiiz6+KE3mQ5U9dJkum3DngDc5mNROVafAHY6vUF6j/IJ+PiVTqBp4MwL+aI2iritOZHBqRI3SUvBIKA2SLTY+BEMvGbOJvegYzK483/N28M747qj1GOflZGckJ8ddaIawn4frO/WdsUQIt943HuXxUiXnByJraxcIYR7cNXxVvm2DDzWihh2b/KoezXs64sUqntjYA4xpz8rhMFh96h16Bpgty2+QiQy4B0fqmPdDaZwFMSapA/nZL+iBo3sXO9Ml658NnJtdD4gAWmYnrQwVa+tAsHL/7UaxbYNhy6GW1MQWFFOrpSWmL7H6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZautPkO0D24b8RKDRha1v/TGl0FkGuJv+IsVldaJzOw=;
 b=oJKSKHxIjgGL7LIX6AkliJz7mwG0ZLx4d9w4C5eERPHcG7qq6CXD/qzzAXliKTe7PcrcP/tv/uXOWfYkR1G+xHjqPK/3qavGOBvAYgmbenndsR57pau/X+61uvxODD++u/FH+3DOVnBZnTBFmYXqU/rA7kl26jZ64w0R+mrwQn2Caj0+NfItOVQLPLEDF8RS/kqS9m1Fi8CPUKeD0PMMlgywOmVdZ+1qLwV/GUrDpBrMMnpc02eCcVMOfdwE14n7FXBI0hbf5v6NRo8ijLfkJOBkIn6uZdmbZWZEkmVinvMv72vOYIZJ7nJlOeZCXLMf5aq/i1WWtn+WqP84RmN+IQ==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by DS7PR11MB7835.namprd11.prod.outlook.com (2603:10b6:8:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Thu, 15 Feb
 2024 09:26:21 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b%3]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 09:26:21 +0000
From: <Rengarajan.S@microchip.com>
To: <linux-serial@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC: <jirislaby@kernel.org>, <Kumaravel.Thiagarajan@microchip.com>,
	<Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_pci1xxxx: Drop quirk from 8250_port
Thread-Topic: [PATCH v1 1/1] serial: 8250_pci1xxxx: Drop quirk from 8250_port
Thread-Index: AQHaX0zJptU08UpfekCFV+f1gwbHA7ELJEGA
Date: Thu, 15 Feb 2024 09:26:21 +0000
Message-ID: <063a1804732c619bc4a5c801c9881fedd92ad745.camel@microchip.com>
References: <20240214135009.3299940-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240214135009.3299940-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|DS7PR11MB7835:EE_
x-ms-office365-filtering-correlation-id: b726e78f-aeb9-40a9-6f09-08dc2e082c09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VJqd43fozxxzmzm+uKeTb0fDgAxa6llZRD2ETeh142G3tzABSQNQxZa/bVVHq5U1ikSj1ZUZUkXnYQNxmFXf5yJ/WrDViCAaOFAw3ttAAS/py/PaCW9X33+lJMH2Jn+RlKZn1BIEaa/8EZYUF7gn1A/tIVLFZlHEoraZtJS0yjzh2W9zYZCeoJZVA+4dBCc4I21JwHA4moe3ei2SNlK6QfzeITyHhQ84k5Xf+RfSG6QjB0Nm6C0ecYjzLDb0Y9dzf5rkDqYCbTIS0Z2wZ9Stki2B1iAnQsE39h+hQWOczqPKDTb9JcVTQ8hQ30CsAGNP1TxM+AmqAmc5OxF6ZKI7b8zzGt7lyczg9uhBoK5WOdLGb895EXOgJ4OFsshthidulCy7DT1seXKhbt0LTcLEoxBptARqVpfESG6djcl2vzl3JDy9ecJv+pikdqjbJx60NPOfwIGCyXlJVpVRF3uEiHlgGdiHdDJsYD0SB8zV7Nn57d0K3OOAHPkcgF+YdjmLAzZS4JgUbG4+gilmMCZha7atOhffBr0dBkRni3wKnCYF7Ibp6V4TC34wg7/VQSl0vBlQ0VZZMG5M3TyY9aUUT9rN7zYaOjQ5lgfj7HF8bP75Fzr6Wpz2oTtsx0mjKcCK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(8676002)(41300700001)(26005)(71200400001)(122000001)(6506007)(38100700002)(36756003)(110136005)(76116006)(2906002)(4326008)(38070700009)(316002)(66946007)(5660300002)(8936002)(66476007)(66446008)(66556008)(54906003)(64756008)(478600001)(2616005)(83380400001)(6486002)(107886003)(6512007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wnd0T3dKNUVoOVUza3k0MmVPa1JzbHRJY1QwZmtCMFI3RElhMjlrZjZOSysv?=
 =?utf-8?B?cnlmZGVXaWpiY2s1MnFDa1RMYmlwUzFVU3JudFlDU1N0ZDFOdGFvTUVIWm0y?=
 =?utf-8?B?c0NGWGtRbWVLZWZ0U1ExTk1JRDA5ejd3anFrK3luVXFTOW1FUVpOM203dGRJ?=
 =?utf-8?B?cTBoSk55UnVqL3lMMi9kTDJDRGU4U3hOQ05HbUtlYkQ3L3dhZmRkbVBzZkZY?=
 =?utf-8?B?UU1nVEhMRWZsMm1wclBTaDZKdUk2amsyazhxMFcyd0JqanlNYUNzOFhpV1Vv?=
 =?utf-8?B?eXQzVW5XVUFMTzZGcWFDeDViQXloVTJSYS9zdXgxek1GdjJ4aGJzOWF2OTEy?=
 =?utf-8?B?T0orcEVPMkxIemd6azd4aVhkR3RHVVJYY2RCR0RneFJkb3VVbG9ZK2k2SWxJ?=
 =?utf-8?B?QmIzRGdlT1ZSb1hzQks0UmRxNEdRYXFXN3dORzgrRTlLNWZsYmY4OXlsV1pM?=
 =?utf-8?B?QTFQY2lJWEx2UHRjeVQvQXdUd2Jvb2xEY0toWG1VenhrSkFsVmtNNG9acTNE?=
 =?utf-8?B?a1h2VU9rZVBSMzgyRWFnTW9lVnFSMHZrcmZqc0h4WDVvSlAwWDIxa21oVEVi?=
 =?utf-8?B?b0I3Qk5hbmllbzhaU2hPRVFzYmRXSEh5a0lOc2k1QkdoNDczRWRhc1N2OXFN?=
 =?utf-8?B?M1VMWWN3NExhbjlDQWlaYzd5ZUc4a3BiSUVueU1MWWt3Y1lvSkNBajJDRTc0?=
 =?utf-8?B?UU5UYzYrZ2IrRzVsOXlUY3JGNFkvb0s0dlJ6QlFHSmxQVFBlZk9FSFJEaVAv?=
 =?utf-8?B?S1UzVUIrMmVwbm41c29oNVFmTFU2ajNDbyswQXV0RlZ2bDFkTlhEei93WEln?=
 =?utf-8?B?cDZPS0s1WXcwRW1aNjdWNTRpaWtnNnNPTlprNzQ1TE1uWlE0ZnIrQnE4VHR1?=
 =?utf-8?B?Q2JrWE41anM4Ui9YcGhZTCt5VUFQclJ4Ni9qWEpZRFhGanllcGFiMm9qeE1V?=
 =?utf-8?B?TU5wMFZKQzF1YTU0eko0V21IdGdzZEtNeDh1clN0Rjl0TXNibWJsZjFvM1dV?=
 =?utf-8?B?VzVGelVZdHpEVlFQbXJmTGdJczJ2RzdXaDB5TFFJNDhwWk1zbW1DRkhEOWdE?=
 =?utf-8?B?TTAyZHZJQ3pjU2ZyQjBzb05uTjNNdVZQWjB5NE1pTXR6bG1OZG1VOTBoV0pZ?=
 =?utf-8?B?cDdPWm9TdVQvVktTWjlLWFVnQUZzSkZGR1FVbzd4RlpDWnpjY0VsSHMvbHhE?=
 =?utf-8?B?cHdUVFJacURsRmYwb2h0SDdLYlNpUHc2cmpHeVpma09ZbVdsWHJUQndZcEpj?=
 =?utf-8?B?K3VuRkI3MWExQ1JKNVdpS1JmdkZMK05TNXZCdTBHMW5tM1FzR0xXb0Z4cCtJ?=
 =?utf-8?B?ck9tMG5oVCs3aUdkNy9RUTdzdG1JTTdBeUhNUHFHNEkzZXpnRkEzQzBIWTN5?=
 =?utf-8?B?dEhFbWdIVGo4TW1oT1BUQlJYY2M2K2JUTzlST3JkMmM1MW1icXlKUXZXenVQ?=
 =?utf-8?B?SDRGc2FqRzJySll2ZHZSczZ2YllyOU16cmU4ZmgySGpyUnREMVdHR25IU1RO?=
 =?utf-8?B?c1JnbU5hQVU1VWE5NXBBYWdLTzV5aGpoUDJUL285Q1g4YTBKeUtTdms3c1ll?=
 =?utf-8?B?RkQ5YVR2L0FYa25PeGFLOWVYNVM4WUhwcjhJOEhZOVdFbnUxdUR4RGVkUExl?=
 =?utf-8?B?cW9vVlVucWR0YlJ1Nmc0bzNGVTd4K3gwWDllK0kvSFN3aytSRUQvd2g1MmZI?=
 =?utf-8?B?eHhEQUZRdzlQSXplbCtUeUpyYWRyam1pd2ZaVXlmRDNwQWd3NC9TSm45MkJX?=
 =?utf-8?B?aDFSSTc0L0tHVlZ1aWhET2wrV2ZOamRTOG9sVldCak1IL2twelZmQVNCMVM5?=
 =?utf-8?B?cWs5TURsSTlIWStXd2NGVDA2c0EybWhia3AxdkJzelhCMjRkUlh3SEZmRGtu?=
 =?utf-8?B?Y2ZGMDkrZ0trdjhHbFMrV2xVd1lOQkRhZFVZL20yakdXcksrZE1xODJLdXZG?=
 =?utf-8?B?VzFXM3g1VSs4K05RcXh6QmN1OTVMSzZhcGg1YW9LckNvQkZnVStVMlM2SHhi?=
 =?utf-8?B?ZFBxYXhXVlZaanVKM01BZXFxbGVCR2I3QkoxZFAzV1BRUDJ2VnZ0V3dPd3hC?=
 =?utf-8?B?NjFyUWFIZGduRzF5N2lIbzA4VU16Y2pBQ3NPTnBySzRDRGRyb0FWeEpqaE1C?=
 =?utf-8?B?WWltOTNvWDIxcnNpdlc0dGYwR0dPbjJoUGplRXFzR2NjUWlKUm84czlmQm16?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72619FA5656051438DBEB492E6D50C92@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b726e78f-aeb9-40a9-6f09-08dc2e082c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 09:26:21.3153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4pM+YYg77u0TXs71EPOQDNoC7qvmuOnU8kMU59Dy5pP41JM0YWyFArYS9VUhqoUW6udNfcD5KZemizLbxyuwpvp+r8zRYchxE+fHytKFqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7835

SGkgQW5keSwKCk9uIFdlZCwgMjAyNC0wMi0xNCBhdCAxNTo1MCArMDIwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOgo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlCj4gCj4gV2Ug
YXJlIG5vdCBzdXBwb3NlZCB0byBzcHJlYWQgcXVpcmtzIGluIDgyNTBfcG9ydCBtb2R1bGUgZXNw
ZWNpYWxseQo+IHdoZW4gd2UgaGF2ZSBhIHNlcGFyYXRlIGRyaXZlciBmb3IgdGhlIGhhcmR3YXJl
IGluIHF1ZXN0aW9uLgo+IAo+IE1vdmUgcXVpcmsgZnJvbSBnZW5lcmljIG1vZHVsZSB0byB0aGUg
ZHJpdmVyIHRoYXQgdXNlcyBpdC4KPiAKPiBXaGlsZSBhdCBpdCwgbW92ZSBJTyB0byAtPnNldF9k
aXZpc29yKCkgY2FsbGJhY2sgYXMgaXQgaGFzIHRvIGJlIGZyb20KPiBkYXkgMS4gLT5nZXRfZGl2
aXNvcigpIGlzIG5vdCBzdXBwb3NlZCB0byBwZXJmb3JtIGFueSBJTyBhcyBVQVJUCj4gcG9ydDoK
PiAtIG1pZ2h0IG5vdCBiZSBwb3dlcmVkIG9uCj4gLSBpcyBub3QgbG9ja2VkIGJ5IGEgc3BpbiBs
b2NrCj4gCj4gRml4ZXM6IDFlZDY3ZWNkMTM0OSAoIjgyNTA6IG1pY3JvY2hpcDogQWRkIDQgTWJw
cyBzdXBwb3J0IGluIFBDSTFYWFhYCj4gVUFSVCIpCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2
Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+Cj4gLS0tCj4gwqBkcml2
ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaTF4eHh4LmMgfCAyNSArKysrKysrKysrKysrKysr
KystLS0tLQo+IC0tCj4gwqBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuY8KgwqDC
oMKgIHzCoCA2IC0tLS0tLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAx
MyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAv
ODI1MF9wY2kxeHh4eC5jCj4gYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaTF4eHh4
LmMKPiBpbmRleCA1NWVhZGExZGJhNTYuLjJmYmI1ODUxZjc4OCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaTF4eHh4LmMKPiArKysgYi9kcml2ZXJzL3R0eS9z
ZXJpYWwvODI1MC84MjUwX3BjaTF4eHh4LmMKPiBAQCAtOTQsNyArOTQsNiBAQAo+IMKgI2RlZmlu
ZSBVQVJUX0JJVF9TQU1QTEVfQ05UXzE2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MTYKPiDCoCNkZWZpbmUgQkFVRF9DTE9DS19ESVZfSU5UX01TS8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEdFTk1BU0soMzEsIDgpCj4gwqAjZGVmaW5lIEFEQ0xfQ0ZHX1JUU19ERUxB
WV9NQVNLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBHRU5N
QVNLKDExLAo+IDgpCj4gLSNkZWZpbmUgVUFSVF9DTE9DS19ERUZBVUxUwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoNjI1MDAgKiBIWl9QRVJfS0haKQo+IAo+IMKgI2Rl
ZmluZSBVQVJUX1dBS0VfUkVHwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMHg4Qwo+IMKgI2RlZmluZSBVQVJUX1dBS0VfTUFTS19SRUfCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4OTAKPiBAQCAtMjI3LDEzICsyMjYsMTAg
QEAgc3RhdGljIHVuc2lnbmVkIGludCBwY2kxeHh4eF9nZXRfZGl2aXNvcihzdHJ1Y3QKPiB1YXJ0
X3BvcnQgKnBvcnQsCj4gwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IHVhcnRfc2FtcGxlX2Nu
dDsKPiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgcXVvdDsKPiAKPiAtwqDCoMKgwqDCoMKg
IGlmIChiYXVkID49IFVBUlRfQkFVRF80TUJQUykgewo+ICvCoMKgwqDCoMKgwqAgaWYgKGJhdWQg
Pj0gVUFSVF9CQVVEXzRNQlBTKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1YXJ0
X3NhbXBsZV9jbnQgPSBVQVJUX0JJVF9TQU1QTEVfQ05UXzg7Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgd3JpdGVsKFVBUlRfQklUX0RJVklTT1JfOCwgKHBvcnQtPm1lbWJhc2UgKwo+
IEZSQUNfRElWX0NGR19SRUcpKTsKPiAtwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gK8KgwqDCoMKg
wqDCoCBlbHNlCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVhcnRfc2FtcGxlX2Nu
dCA9IFVBUlRfQklUX1NBTVBMRV9DTlRfMTY7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgd3JpdGVsKFVBUlRfQklUX0RJVklTT1JfMTYsIChwb3J0LT5tZW1iYXNlICsKPiBGUkFDX0RJ
Vl9DRkdfUkVHKSk7Cj4gLcKgwqDCoMKgwqDCoCB9Cj4gCj4gwqDCoMKgwqDCoMKgwqAgLyoKPiDC
oMKgwqDCoMKgwqDCoMKgICogQ2FsY3VsYXRlIGJhdWQgcmF0ZSBzYW1wbGluZyBwZXJpb2QgaW4g
bmFub3NlY29uZHMuCj4gQEAgLTI0OSw2ICsyNDUsMTEgQEAgc3RhdGljIHVuc2lnbmVkIGludCBw
Y2kxeHh4eF9nZXRfZGl2aXNvcihzdHJ1Y3QKPiB1YXJ0X3BvcnQgKnBvcnQsCj4gwqBzdGF0aWMg
dm9pZCBwY2kxeHh4eF9zZXRfZGl2aXNvcihzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCB1bnNpZ25l
ZAo+IGludCBiYXVkLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IHF1b3QsIHVuc2lnbmVkIGludAo+
IGZyYWMpCj4gwqB7Cj4gK8KgwqDCoMKgwqDCoCBpZiAoYmF1ZCA+PSBVQVJUX0JBVURfNE1CUFMp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVsKFVBUlRfQklUX0RJVklTT1Jf
OCwgcG9ydC0+bWVtYmFzZSArCj4gRlJBQ19ESVZfQ0ZHX1JFRyk7Cj4gK8KgwqDCoMKgwqDCoCBl
bHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVsKFVBUlRfQklUX0RJVklT
T1JfMTYsIHBvcnQtPm1lbWJhc2UgKwo+IEZSQUNfRElWX0NGR19SRUcpOwo+ICsKPiDCoMKgwqDC
oMKgwqDCoCB3cml0ZWwoRklFTERfUFJFUChCQVVEX0NMT0NLX0RJVl9JTlRfTVNLLCBxdW90KSB8
IGZyYWMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb3J0LT5tZW1iYXNlICsgVUFS
VF9CQVVEX0NMS19ESVZJU09SX1JFRyk7Cj4gwqB9Cj4gQEAgLTYxOSw2ICs2MjAsMTcgQEAgc3Rh
dGljIGludCBwY2kxeHh4eF9zZXR1cChzdHJ1Y3QgcGNpX2RldiAqcGRldiwKPiAKPiDCoMKgwqDC
oMKgwqDCoCBwb3J0LT5wb3J0LmZsYWdzIHw9IFVQRl9GSVhFRF9UWVBFIHwgVVBGX1NLSVBfVEVT
VDsKPiDCoMKgwqDCoMKgwqDCoCBwb3J0LT5wb3J0LnR5cGUgPSBQT1JUX01DSFAxNjU1MEE7Cj4g
K8KgwqDCoMKgwqDCoCAvKgo+ICvCoMKgwqDCoMKgwqDCoCAqIDgyNTAgY29yZSBjb25zaWRlcnMg
cHJlc2NhbGxlciB2YWx1ZSB0byBiZSBhbHdheXMgMTYuCj4gK8KgwqDCoMKgwqDCoMKgICogVGhl
IE1DSFAgcG9ydHMgc3VwcG9ydCBkb3duc2NhbGVkIG1vZGUgYW5kIGhlbmNlIHRoZQo+ICvCoMKg
wqDCoMKgwqDCoCAqIGZ1bmN0aW9uYWwgVUFSVCBjbG9jayBjYW4gYmUgbG93ZXIsIGkuZS4gNjIu
NU1IeiwgdGhhbgo+ICvCoMKgwqDCoMKgwqDCoCAqIHNvZnR3YXJlIGV4cGVjdHMgaW4gb3JkZXIg
dG8gc3VwcG9ydCBoaWdoZXIgYmF1ZCByYXRlcy4KPiArwqDCoMKgwqDCoMKgwqAgKiBBc3NpZ24g
aGVyZSA2NE1IeiB0byBzdXBwb3J0IDRNYnBzLgo+ICvCoMKgwqDCoMKgwqDCoCAqCj4gK8KgwqDC
oMKgwqDCoMKgICogVGhlIHZhbHVlIGl0c2VsZiBpcyBub3QgcmVhbGx5IHVzZWQgYW55d2hlcmUg
ZXhjZXB0IGJhdWQKPiArwqDCoMKgwqDCoMKgwqAgKiByYXRlIGNhbGN1bGF0aW9ucywgc28gd2Ug
Y2FuIG1hbmdsZSBpdCBhcyB3ZSB3aXNoLgo+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDC
oMKgwqAgcG9ydC0+cG9ydC51YXJ0Y2xrID0gNjQgKiBIWl9QRVJfTUhaOwoKQXMgcGVyIGludGVy
bmFsIE1DSFAgRE9TLCBQQ0kxWFhYWCBkcml2ZXIgdXNlcyBhIHNpbXBsZSBtZXRob2Qgb2YKY29u
dmVydGluZyAibGVnYWN5IDE2IGJpdCBiYXVkIHJhdGUgZ2VuZXJhdG9yIiB0byBhICIzMiBiaXQg
ZnJhY3Rpb25hbApiYXVkIHJhdGUgZ2VuZXJhdG9yIiB3aGljaCBlbmFibGVzIGdlbmVyYXRpb24g
b2YgYW4gYWNjZXB0YWJsZSBiYXVkCnJhdGUgZnJvbSBhbnkgdmFsdWFibGUgZnJlcXVlbmN5LgoK
VGhpcyBpcyBhcHBsaWNhYmxlIG9ubHkgd2hlbiB0aGUgYmF1ZCBjbG9jayBzZWxlY3RlZCBpcyA2
Mi41IE1Ieiwgc28Kd2hlbiB3ZSBjb25maWd1cmUgdGhlIGJhdWQgY2xvY2sgdG8gNjQgTUh6KGFz
IGFib3ZlKSB3aWxsIGl0IGJlCmRvd25zY2FsZWQgdG8gNjIuNSBNSHosIHRodXMgc3VwcG9ydGlu
ZyB0aGUgYWJvdmUgZmVhdHVyZT8gCgpPdGhlciBjaGFuZ2VzIGxvb2tzIGdvb2QgdG8gbWUuCgo+
IMKgwqDCoMKgwqDCoMKgIHBvcnQtPnBvcnQuc2V0X3Rlcm1pb3MgPSBzZXJpYWw4MjUwX2RvX3Nl
dF90ZXJtaW9zOwo+IMKgwqDCoMKgwqDCoMKgIHBvcnQtPnBvcnQuZ2V0X2Rpdmlzb3IgPSBwY2kx
eHh4eF9nZXRfZGl2aXNvcjsKPiDCoMKgwqDCoMKgwqDCoCBwb3J0LT5wb3J0LnNldF9kaXZpc29y
ID0gcGNpMXh4eHhfc2V0X2Rpdmlzb3I7Cj4gQEAgLTczMiw3ICs3NDQsNiBAQCBzdGF0aWMgaW50
IHBjaTF4eHh4X3NlcmlhbF9wcm9iZShzdHJ1Y3QgcGNpX2Rldgo+ICpwZGV2LAo+IAo+IMKgwqDC
oMKgwqDCoMKgIG1lbXNldCgmdWFydCwgMCwgc2l6ZW9mKHVhcnQpKTsKPiDCoMKgwqDCoMKgwqDC
oCB1YXJ0LnBvcnQuZmxhZ3MgPSBVUEZfU0hBUkVfSVJRIHwgVVBGX0ZJWEVEX1BPUlQ7Cj4gLcKg
wqDCoMKgwqDCoCB1YXJ0LnBvcnQudWFydGNsayA9IFVBUlRfQ0xPQ0tfREVGQVVMVDsKPiDCoMKg
wqDCoMKgwqDCoCB1YXJ0LnBvcnQuZGV2ID0gZGV2Owo+IAo+IMKgwqDCoMKgwqDCoMKgIGlmIChu
dW1fdmVjdG9ycyA9PSBtYXhfdmVjX3JlcWQpCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC84MjUwLzgyNTBfcG9ydC5jCj4gYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3Bv
cnQuYwo+IGluZGV4IGMzNzkwNWVhM2NhZS4uZDU5ZGMyMTljODk5IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcG9ydC5jCj4gKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsLzgyNTAvODI1MF9wb3J0LmMKPiBAQCAtMjY5OSwxMiArMjY5OSw2IEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQKPiBzZXJpYWw4MjUwX2dldF9iYXVkX3JhdGUoc3RydWN0IHVhcnRfcG9ydCAqcG9y
dCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF4ID0gKHBvcnQtPnVhcnRjbGsg
KyB0b2xlcmFuY2UpIC8gMTY7Cj4gwqDCoMKgwqDCoMKgwqAgfQo+IAo+IC3CoMKgwqDCoMKgwqAg
LyoKPiAtwqDCoMKgwqDCoMKgwqAgKiBNaWNyb2NoaXAgUENJMVhYWFggVUFSVCBzdXBwb3J0cyBt
YXhpbXVtIGJhdWQgcmF0ZSB1cCB0byA0Cj4gTWJwcwo+IC3CoMKgwqDCoMKgwqDCoCAqLwo+IC3C
oMKgwqDCoMKgwqAgaWYgKHVwLT5wb3J0LnR5cGUgPT0gUE9SVF9NQ0hQMTY1NTBBKQo+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1heCA9IDQwMDAwMDA7Cj4gLQo+IMKgwqDCoMKgwqDC
oMKgIC8qCj4gwqDCoMKgwqDCoMKgwqDCoCAqIEFzayB0aGUgY29yZSB0byBjYWxjdWxhdGUgdGhl
IGRpdmlzb3IgZm9yIHVzLgo+IMKgwqDCoMKgwqDCoMKgwqAgKiBBbGxvdyAxJSB0b2xlcmFuY2Ug
YXQgdGhlIHVwcGVyIGxpbWl0IHNvIHVhcnQgY2xrcwo+IG1hcmdpbmFsbHkKPiAtLQo+IDIuNDMu
MC5yYzEuMS5nYmVjNDQ0OTFmMDk2Cj4gCgoKQWNrZWQtYnk6IFJlbmdhcmFqYW4gUyA8cmVuZ2Fy
YWphbi5zQG1pY3JvY2hpcC5jb20+Cg==

