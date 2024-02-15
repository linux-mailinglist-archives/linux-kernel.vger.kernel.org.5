Return-Path: <linux-kernel+bounces-66294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78508559DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F44290460
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966018833;
	Thu, 15 Feb 2024 04:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nuFNJeuQ";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UqBueQ0P"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A11C0F;
	Thu, 15 Feb 2024 04:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707971787; cv=fail; b=AQFnW17wnlsk9gtR2GRpclt7D5hw7ccBIbb1Cc0aEFlSbZXMwIDjApIHb1aUMZSJcoD5VQYsPrC+yPU44vrav08s98/hurEczp5+JJBfNCAB21Afo689L2YSImCqa/Q6cqp3Td7IbxuWSpVDUUCubopG/M6H5dqA+KW8P+dybQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707971787; c=relaxed/simple;
	bh=WYWDcH5PfyNlYZrQQO1eSvpskKwL4j+9byQBjxBXE6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=efqPfRpOkrF1Ap8M1X3W0P2UIrAOtNB7Pf/1Guoq6yr8aX4Rkqj9lpAJIcPz1hiMktwBZ+dfUI2W0tJp1kFTAu53qhlazppK8cBkGEgtpyi9FI9fA1E/Ckr7x1rJSUepHvofwms1eWvMaqwtm8cSNOsyVtgVorClQm2o0Xw9R5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nuFNJeuQ; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UqBueQ0P; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707971785; x=1739507785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WYWDcH5PfyNlYZrQQO1eSvpskKwL4j+9byQBjxBXE6s=;
  b=nuFNJeuQGRTo4BOj3zlyIwFmMZB4JkCYioIFFDv1DlpdxnG6UO9tbaHH
   9H/UYnSi6pyT8XwvhCKc2U+5twtAtM9DHevRlhkV8wHBdbWBysJ+G52fl
   WR1Vd3YyLWAJsQOMba6mdC46jlJDe92wGz3lkeoMilneVQmuBlF9WX3ls
   K0fHqDea/a7CT+UAkYJ4wo26AtcOEMpz1UVCemE2cwdS5DNntzLOBGAf7
   yzS4k8enDnRWsjn7ARz0AdMBmZD7Vk6X2pMGtEo7hptLA1SYNcgJyGdPG
   OMIGF4BHBMHe8TpgTY7ZC5d6l08/paibU6KckfSJBqMP4wM4Eh+nTWqzP
   A==;
X-CSE-ConnectionGUID: 5aQSV/iQRHiBuBtrRw2wgg==
X-CSE-MsgGUID: H1g0rT6ES5qu/Aw1YPhClQ==
X-IronPort-AV: E=Sophos;i="6.06,161,1705388400"; 
   d="scan'208";a="17734496"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 21:36:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 21:35:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 21:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dksf33Q+KNbXIip++6GGsKCntAZ2yWyI5GKZ0gc1N5C1OucjsCneOAwBRJMDarTXJQq1P82wjoDJfLs4C4kQzPgQ8vvwUMGPp5kV+bdQObjh1ij/V90E3ZrV9i+lsu2mHGN8cL3WR+lXD+ohpV/15qGWjnjLeGW+qEkxG1yJ/k/Kp2hGEh0OmKqw6LWISSXNMOfbyazs73pk3jphHq3amPLGLvvv/KXHVL2IvpSro0JoI6lWg+0/Z/0/L3OqwwXF+HZWt4+qOhZPVFkjsdXuNX7bMzPS+6D7xM22y8vgDewM+aukJV+IExI5W0SGaVkzN1CeUJjoI3vIrbVlOgyeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYWDcH5PfyNlYZrQQO1eSvpskKwL4j+9byQBjxBXE6s=;
 b=jIAUnWFHSB1AM3jNWPU6QSRLQ3R1ixeiY6EhIo7l0yMhV6+AH8Vzv0n8eH7P3kNSoanV7KqNJELGLdiqLHVFkJ1C2++wj12X+EcknOGg/9SMLZi6tMMG5JPY8f5Zl9hsHzTbr0pE0VRko9GsS+GUGuGXiUrFQuBk77xvpigbr9QfsCOMryszVWMGULf0ziZkPk4Qk84h7ELmIPat4sXcYsg9q8As4PdiO8RYpIGgNa9hZjfKNEIg8pVFYRmp1rLOFyQfdOhLiTREPnAOe+/1QIVFYKqG6fQWa82Kmed1Y1aQWXsrBHDFU1OTbuyJrXVC+2AHpagr2E3fX8L7Q/fvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYWDcH5PfyNlYZrQQO1eSvpskKwL4j+9byQBjxBXE6s=;
 b=UqBueQ0PdYJfIQNzH3oFpRHn5ah5FTg3jSwlFpNkBxQKuAtaEgHEO+yVeIP988/wBunhR3CELaQculnkuqs7DEX5aDIYU/JbS5QtwA+tA0/OnEze6Mm467KX5DU/yQjvLGBqdwQR13o1ZpsPTR37n3bSTfVfM8tSr72xFNN1xWDhQ2bACH71QGSS9lVc5L9QyL+2nRwbSRNvj8Yl8f8mT4l//aTCJwSX35h7IKO1oZH0tDDU7LXGGL4Il31phXRNmm/dS8LJse4r1OXVeUuSh5Y+6GJMoP6xNPF80n08f5T9M6OEnC+vkT/Y76ChDv1MfAR9UR/uz19fdWA5KHNNeg==
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ1PR11MB6225.namprd11.prod.outlook.com (2603:10b6:a03:45c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 04:35:46 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::613:fb5:737:dae8%7]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 04:35:46 +0000
From: <Ajay.Kathat@microchip.com>
To: <alexis.lothore@bootlin.com>, <davidm@egauge.net>,
	<linux-wireless@vger.kernel.org>
CC: <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>,
	<thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
Thread-Topic: [PATCH RFC] wifi: wilc1000: fix reset line assert/deassert
 polarity
Thread-Index: AQHaXpDVeUNEJsQx1Uu1SAoo0Dj95LEIegQAgAAEeACAAlVDgA==
Date: Thu, 15 Feb 2024 04:35:46 +0000
Message-ID: <aac398e4-d870-4ba2-8877-b98afecb8d1b@microchip.com>
References: <20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com>
 <2ff1c701f3443e1c612a81f4077b0280850f57c6.camel@egauge.net>
 <081bce96-f485-414c-8051-e1c14271f8cc@bootlin.com>
In-Reply-To: <081bce96-f485-414c-8051-e1c14271f8cc@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SJ1PR11MB6225:EE_
x-ms-office365-filtering-correlation-id: 15fde729-02fc-4c88-c254-08dc2ddf941d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UIDWNkDZFxRa/eJOW1BiX4jiCJ7W0TOY6FORzQRyaDmpEhhNiQMZQNfzwiGOXdwec9dO9qPV/oZ/AEQcSu6LTog5meLIFQA+1BWGGLINWV30eSMXbxzPAGu9bH7BHEH97i+hxNhz1RzKvuDyVszPYo9QKFJTBu+Np7/qAJNImZ951Eo1bbQMDF3AzJzB9uV8/dMwFGrzQhAyVobHdOG1yXryzJa9t0W3Syg1y9x8whPYa3O7lXJvPkq3gjNMu6KblN8JM3ABomnepFLSCU4nVyqyrkPYUcUNZFgtiVPqAi7Kd/afQrMygkmEr/KC9HA+xFiYb8gi2Mj5rZbIRmfY0acL+5DERX00pu9cgb5voyj4o6EmS0Zr3kMvuEavfjQIb8K2ACVhaA3Rcn9YvTtomFlJXDIuVz2DxGdD12yaz+39vdWSmBhHlvegzgV8EpGjw87syCK4tkRL0q1rnuSG5y0hsmJTjYePuF+ESsoQ4r2w3MZVPZYUR/kfRPexWlP9nX0o+Z2oGY1jbA9GBzon/cWca0wdvbsm97BthqkryBWZ0W+CBAxUlKufFojJTZVjxlSYeL29m7t2QxAn9EDRx06JLvLQTidtv1doq/4NVv8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(54906003)(110136005)(71200400001)(478600001)(6486002)(6506007)(6512007)(53546011)(966005)(66446008)(8676002)(8936002)(64756008)(66476007)(66556008)(66946007)(76116006)(41300700001)(4326008)(316002)(122000001)(38100700002)(31696002)(86362001)(83380400001)(2616005)(38070700009)(36756003)(26005)(5660300002)(31686004)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azNSTXdXb0VUYUpyTTVEU29uVjA0dFNVdGQwamlaZnJzL2IybFRGSU50YlVh?=
 =?utf-8?B?Zm9sMW9RS1lMMThZY0dLQVJUL1BqYVQvWkpPZEV3VVJXaEJxajRhbC9maXp1?=
 =?utf-8?B?Tm8vS3huclhjOGtZSGRZRnNzU0gxQ25aTDdWcXpBUy95Vk9iellDTDU5bTN5?=
 =?utf-8?B?MWF5SmVCVVVGaXdXK2tvdWowZUV0OVBqcWoyeDRaRG5KYy9hTWR3L2V4cEJo?=
 =?utf-8?B?UnIvaHh4aThtVkNKRW9yVlNrYlZicHBTTjl1ekNyVmVXaDV2NVZDVWlPdUFJ?=
 =?utf-8?B?N0ROVU1CdHBtMjVaZEdMSEV6MmIrekc2Z3B3dnlJY2hQUS9lVmVFUEtuMll6?=
 =?utf-8?B?R0Y2dkFxYytGWTFXTHhNbHh0ZksweFJzaWdIUzFKanNsZ05YaWpreExrR3ph?=
 =?utf-8?B?UWxWc2RPSHB6YStnaDI4WVFLUEhaWmVxVzU3a0VtV3R3OTdUdFNiWTZ4eDJy?=
 =?utf-8?B?M3QvRUU1VVJ0Y0o2cSt6bkNkMmJnalZlaFRuWGllenhyY0xsQ2FOOTZrOUh1?=
 =?utf-8?B?SnpHT0x1TjI4WTB1TlVpUGhTYitSc3RsdG9EbUMxa0dlWFY3SjREbHl6NFhu?=
 =?utf-8?B?Ui9BZVVGZ3FoUlByeE42RVVSUDZVUStoVUV4UGJuTytiNnJISU1rdHNKYS9M?=
 =?utf-8?B?N0xnV2Irakt2V2hjaStGRU9IZUlFNzcrMXoxS0lhaEtZVy9Ob1hGcGgwWWw3?=
 =?utf-8?B?S2d2NUVSMS9LY3RBYWNlNWEyRzhZSDhuUDNLb0N6cW9QTFdoa0FZL2tMTXdI?=
 =?utf-8?B?VStFTzVwZVA2ZXgvYzZtd0plNTVWL21lUlJkWFI1UVFEeldaUEJFeWlVcTl0?=
 =?utf-8?B?bWtpeU5oVjJNOVFSZlBqSFp1cWhwQUliajJLV0k2UVdXcHFQWENDTFhlY1Nh?=
 =?utf-8?B?NXBpZHRKLy96bU1EM2hqYVh6SHdnN3BkL3NsNGRBb3AxeXJjTlVaVGFBc1ly?=
 =?utf-8?B?RDVQVkpjaElRcEJ2Nlo5Y2pQTmRSeHNCakZpSmZoRDdCNkUzaFA2N29zOWtH?=
 =?utf-8?B?cmpXWW9EMWk5MjJGS3V2YjBtR3NJQzMyYjIrYmpoc0kvdk13T3BETW1UTjdY?=
 =?utf-8?B?RFhMVWtrYUVjeDBoejQxSXRFSVBVaHBxcUp5MFZNRGE1d1hLcW8zeWZVNk8y?=
 =?utf-8?B?ano4UjA1M3JjS3RDODNKR2dWWGphbmFwck5mSUFEdnJRdE5YZ3FUZ1BMNVpi?=
 =?utf-8?B?LzFIWFlvVjFZTko3Y1RzektTdWFNUC9zcVNCdmxJOXE0R3Y1Sml3aU5iSTVJ?=
 =?utf-8?B?NGhCMG55ZG0rZ3VXc1V1a2h5akpFYWVHR202aW9UWWk3ZlhhTWprYmhQMEYr?=
 =?utf-8?B?a3U4Qzc3UDN4OFluVzVvemg2NlFRaFVFcjVBczNTZmVGUEs3eEhOMWNMMUVt?=
 =?utf-8?B?NHhtTjF4YnNzcE00YVU0czBnaHNLSkdjQmNmM0VkN0lSYnpPd2tkUUdwS083?=
 =?utf-8?B?UWlnSGZMd0xXRzFkbDJLSGVhbHFvS1NlNFIrOGJEby82dWIyaDZ4Wm5JUENP?=
 =?utf-8?B?TEg5TDE0ajVFdG8xbmRvOWEvYWVWZEhSd3d6THc0VkFuM0VtYWNpWFFGaDZv?=
 =?utf-8?B?K1V5Wm1VU0I1dFhoaFRaL2lxaXcxRTRhZzhzQ0lDK1Z5UzRFdmltUjFjM0FN?=
 =?utf-8?B?Y2RGQzZ1VXVSa3lzSDZVNzNTYVh6ZTdKancycU1MdTVYYjB1dWhtWERydjNG?=
 =?utf-8?B?WFJvNEFXdlZCTWFUQUNXSDFGSzhPbkZUY25RdStIUjFHVk9FMDIzT2NSdzdw?=
 =?utf-8?B?dm9melZ2cno0UWJJZDI5aG5NQk9FaW9QcU1wNTNtYlNOVjVRMkFucGdFZDZj?=
 =?utf-8?B?eTI4S0JCeWl1VTJLWE1uQXowamhuUTVhM2NKU01mdmkrRFJ1SXVTTysvSndw?=
 =?utf-8?B?VnNiRlA2YzFJM1pwb0lOUFdOQ1BybHhuWVZCWTBxSEx6MkUzLysrakR2eEFs?=
 =?utf-8?B?ak5oODJZZ3hUR3IvWHZzai9TcFdRbzB4THppUlI5SHBxR3U2UyszVWJHck55?=
 =?utf-8?B?TWxQN3cxSk5MV1Q3b1VVdnZ2TmJWNmlsQmFsbTBXNk1BVzc0UEROdjRnZkk0?=
 =?utf-8?B?a2RXUCt1TU8xV0pMZVlnZ0RwRWVSZUplaUpZMGZUMUh2aDM3bGdtLyt0NVQz?=
 =?utf-8?Q?Kr7AlD5oU3limjKbWouX5Lf9o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F0D94BE616AE24DB1AE027B259AA2AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fde729-02fc-4c88-c254-08dc2ddf941d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 04:35:46.5132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNeAyKERPMovYe68Yv5xPgtzV2/+Y7qclp+im7exlAbNVHGlwijNl5qozkmDMbwrysuzFI/86UfFHWHLVDexk7NkIWvovpylofUHFbsF36g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6225

SGksDQoNCk9uIDIvMTMvMjQgMDk6NTgsIEFsZXhpcyBMb3Rob3LDqSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyLzEzLzI0IDE3OjQyLCBEYXZp
ZCBNb3NiZXJnZXItVGFuZyB3cm90ZToNCj4+IE9uIFR1ZSwgMjAyNC0wMi0xMyBhdCAxNjoyMiAr
MDEwMCwgQWxleGlzIExvdGhvcsOpIHdyb3RlOg0KPj4+IFdoZW4gdXNpbmcgYSB3aWxjMTAwMCBj
aGlwIG92ZXIgYSBzcGkgYnVzLCB1c2VycyBjYW4gb3B0aW9uYWxseSBkZWZpbmUgYQ0KPj4+IHJl
c2V0IGdwaW8gYW5kIGEgY2hpcCBlbmFibGUgZ3Bpby4gVGhlIHJlc2V0IGxpbmUgb2Ygd2lsYzEw
MDAgaXMgYWN0aXZlDQo+Pj4gbG93LCBzbyB0byBob2xkIHRoZSBjaGlwIGluIHJlc2V0LCBhIGxv
dyAocGh5c2ljYWwpIHZhbHVlIG11c3QgYmUgYXBwbGllZC4NCj4+Pg0KPj4+IFRoZSBjb3JyZXNw
b25kaW5nIGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiB3YXMgaW50cm9kdWNlZCBi
eQ0KPj4+IGNvbW1pdCBmMzFlZTNjMGE1NTUgKCJ3aWxjMTAwMDogRG9jdW1lbnQgZW5hYmxlLWdw
aW9zIGFuZCByZXNldC1ncGlvcw0KPj4+IHByb3BlcnRpZXMiKSBhbmQgY29ycmVjdGx5IGluZGlj
YXRlcyB0aGF0IHRoZSByZXNldCBsaW5lIGlzIGFuIGFjdGl2ZS1sb3cNCj4+PiBzaWduYWwuIEhv
d2V2ZXIsIHRoZSBjb3JyZXNwb25kaW5nIGRyaXZlciBwYXJ0LCBicm91Z2h0IGJ5IGNvbW1pdA0K
Pj4+IGVjMDMxYWM0NzkyYyAoIndpbGMxMDAwOiBBZGQgcmVzZXQvZW5hYmxlIEdQSU8gc3VwcG9y
dCB0byBTUEkgZHJpdmVyIiksIGlzDQo+Pj4gbWlzdXNpbmcgdGhlIGdwaW9kIEFQSXMgYW5kIGFw
cGx5IGFuIGludmVydGVkIGxvZ2ljIHdoZW4gcG93ZXJpbmcgdXAvZG93bg0KPj4+IHRoZSBjaGlw
IChmb3IgZXhhbXBsZSwgc2V0dGluZyB0aGUgcmVzZXQgbGluZSB0byBhIGxvZ2ljICIxIiBkdXJp
bmcgcG93ZXINCj4+PiB1cCwgd2hpY2ggaW4gZmFjdCBhc3NlcnRzIHRoZSByZXNldCBsaW5lIHdo
ZW4gZGV2aWNlIHRyZWUgZGVzY3JpYmVzIHRoZQ0KPj4+IHJlc2V0IGxpbmUgYXMgR1BJT19BQ1RJ
VkVfTE9XKS4NCj4+DQo+PiBOb3RlIHRoYXQgY29tbWl0IGVjMDMxYWM0NzkyYyBpcyBkb2luZyB0
aGUgcmlnaHQgdGhpbmcgaW4gcmVnYXJkcyB0byBhbg0KPj4gQUNUSVZFX0xPVyBSRVNFVCBwaW4g
YW5kIHRoZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gaXMgY29uc2lzdGVudCB3aXRoIHRoYXQgY29k
ZS4NCj4+DQo+PiBJdCB3YXMgbGF0ZXIgb24gdGhhdCBjb21taXQgZmNmNjkwYjAgZmxpcHBlZCB0
aGUgUkVTRVQgbGluZSBwb2xhcml0eSB0byB0cmVhdCBpdA0KPj4gYXMgR1BJT19BQ1RJVkVfSElH
SC4gIEkgbmV2ZXIgdW5kZXJzdG9vZCB3aHkgdGhhdCB3YXMgZG9uZSBhbmQsIGFzIHlvdSBub3Rl
ZCwgaXQNCj4+IGludHJvZHVjZWQgaW4gaW5jb25zaXN0ZW5jeSB3aXRoIHRoZSBiaW5kaW5nIGRv
Y3VtZW50YXRpb24uDQo+IA0KPiBBaCwgeW91IGFyZSByaWdodCwgYW5kIEkgd2FzIHdyb25nIGNp
dGluZyB5b3VyIEdQSU9zIHBhdGNoIGFzIGZhdWx0eQ0KPiAoZ2l0LWJsYW1pbmcgdG9vIGZhc3Qg
ISksIHRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uIEkgbWlzc2VkIHRoaXMgcGF0Y2ggZnJv
bQ0KPiBBamF5IChmY2Y2OTBiMCkgZmxpcHBpbmcgdGhlIHJlc2V0IGxvZ2ljLiBNYXliZSBoZSBo
YWQgaXNzdWVzIHdoaWxlIG1pc3NpbmcNCj4gcHJvcGVyIGRldmljZSB0cmVlIGNvbmZpZ3VyYXRp
b24gYW5kIHRoZW4gc3VibWl0dGVkIHRoaXMgZmxpcCA/DQoNCkluZGVlZCwgaXQgd2FzIGRvbmUg
dG8gYWxpZ24gdGhlIGNvZGUgYXMgcGVyIHRoZSBEVCBlbnRyeSBzdWdnZXN0ZWQgaW4NCldJTEMx
MDAwLzMwMDAgcG9ydGluZyBndWlkZVsxIC1wYWdlIDE4XSwgd2hpY2ggaXMgYWxyZWFkeSB1c2Vk
IGJ5IG1vc3QNCm9mIHRoZSBleGlzdGluZyB1c2Vycy4gVGhpcyBjaGFuZ2UgaGFzIGltcGFjdCBv
biB0aGUgdXNlcnMgd2hvIGFyZSB1c2luZw0KRFQgZW50cnkgZnJvbSBwb3J0aW5nIGd1aWRlLiBP
bmUgYXBwcm9hY2ggaXMgdG8gcmV0YWluIHRoZSBjdXJyZW50IGNvZGUNCmFuZCBkb2N1bWVudCB0
aGlzIGlmIG5lZWRlZC4NCg0KMS4NCmh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRz
L2VuL0RldmljZURvYy9BVFdJTEMxMDAwLUFUV0lMQzMwMDAtQVRXSUxDLURldmljZXMtTGludXgt
UG9ydGluZy1HdWlkZS1Vc2VyLUd1aWRlLURTNzAwMDUzMjlDLnBkZg0KDQoNClJlZ2FyZHMsDQpB
amF5DQo=

