Return-Path: <linux-kernel+bounces-35606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C368393EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6F31F226B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C4612E3;
	Tue, 23 Jan 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tX8vMTM1";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fJG41TKS"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4892060BA6;
	Tue, 23 Jan 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025497; cv=fail; b=HKWOskcDTO3mFAxbrCGrYboNoFijX6NPgDku8WT6mvEV8ge+uprTcHpCQetX2KEeY6d81+THL4LWvM12s1CzopiK48ojmVEvoFxT6gHyWANnJe3Y5JNZbR0J1Tx84gyd+6Z16s2PXsTroBYnkwyzuhFq3pTFAh4m/UWSdx9m1uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025497; c=relaxed/simple;
	bh=ImOBPRuEZmEsy/he26AvHLVcSZk7cg2vGTnVG/EkmIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I5uBKyOvMLWKTAgAKeo3HLVzs6oBwWMSI3jsGeJDs5r/zClo0Ksu9RMau++lei8lXASMAlxrSnHnAe8WIfw80NS5yXUxT4wcsunoNWLrkNlpLmXzOPBd5Z+graFEOmmH5bn6CBpC2gkz15GIT8nAu4POpE9xUv0mn9dCbVQ5jCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tX8vMTM1; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fJG41TKS; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706025495; x=1737561495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ImOBPRuEZmEsy/he26AvHLVcSZk7cg2vGTnVG/EkmIM=;
  b=tX8vMTM1Vgd6arlOtvwSqn1enJ+VI7e9qzOzcrt9GtgF/yhsw60Km5sG
   /hOJlReTTta2++vz1qCoS0D50LvEgdGikLUCFtLinJ1W+9TWqpPn3Cpt3
   MBQjjDoyrs3iMCtwvV9EXESu3O7k7eRCC/2e0msFmNvINpr4B6X4FBIJl
   21lnPIe9YicAy3joZaSBxCSZxR7dd/ujfCnyVtJCRMgfDr+xtJ8n0j3JL
   ke85A7mWa/OMkSIiVYblok8iZiIN9tR92gpB9058ZjF8zrabOourD+6fa
   jZVUn/alDQOFcnv20Y68kMH8PvrLWFafzEJKNKiH+ZlmpYjf3RroM70u2
   A==;
X-CSE-ConnectionGUID: +PmCFk8SRhCAtYHC52/N9g==
X-CSE-MsgGUID: MMUHGGZLSkicRQJiUuo/jQ==
X-IronPort-AV: E=Sophos;i="6.05,214,1701154800"; 
   d="scan'208";a="15651732"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 08:58:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 08:58:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 08:58:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDXzku0vCqmDRZHCwZU5FxmCEeB4sgb0bkv043b5qbu0U24h9Gm1LYWGFzCJn4i7cQaWd8sQmTR5p+MT3DAIjtS1Ayu3KywBVRrFyhvDcOEo5Y6Lzk5f7cS1waEGnlyH58EO2NVOeI4DkSAtc+goIGEgyikp+oSniY1gPJBKgTEp8NIrMlNoL7hmm6yNN+BxKueicGkKYFxqxIUCA0wHCbYPsoEXTA0+6I1bIEecyUyl7F/WyQCVizdOD8S+DZYXv0jJZWXi7rj0V3gRIBAgP9wNQhSefEWpEP9HKiVlFKr5srz3WKYn74pCRafudc7tySscYJm1Ij7juAEvaE+vGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImOBPRuEZmEsy/he26AvHLVcSZk7cg2vGTnVG/EkmIM=;
 b=KZm6KEHbTEFj7kJxD9lgJ6lvpmVoMtUD3PiVTfHF2sTl7LSyj1Bl23ARauUj8Uq35qJKOwORxYQ2wmLwaNFTmG9hgfctdH97lxTvjqdn9eGnvH4YMP08RDcdrDV2M3KX/jE+z/TLnc99IG5f3qRgjQi3GX/0JG6WhSXy2+1JjyVsM2Wy1xtO2Zws/FX8tKwMpFCo0NpikJVMg+U3Hp3qPp1zOjpqiYNApBEm9sb47PNZ84EsDz2WWygg6i9c6gdyWxaee5oSAa+/SO7+hjkkfWvMIFtSv7Udeuq4rRePrBpCi8CKiIHcQNSkzVyzfKOJ/uWyMb0iRkjuuuiCRxJIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImOBPRuEZmEsy/he26AvHLVcSZk7cg2vGTnVG/EkmIM=;
 b=fJG41TKSc3KRQuVgYYgMgyWMhoaGKH0nvhvzohjp9tvW/pZAyv/Ztxrl8RCKyHr7GohCA+B5Ky7ALB0wGa8aY4VGu6Ii54cBLZVcqXC2c+Bj8t0TTIGv+depMk4qTC3TdcjavxnlZXjg8lkxMTVMyEPWuDCPNvxTe5AbOhIItEW2onjAZXzb+6i6zHJoB6tRIv4WTekuk8RvQS+BgfQRwWvn55kbpI0y6DQEZahcvvxODllxQHey69Ik/hfSjTMFW4Sb9N+kY573JfKcnZXY83FjkoQn1jNQ+K1eR8Bc9En2h1aJ6+LAJYOoXTsaETKEKTwWv69/LX6S4/B6XneScA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 15:58:00 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::18cb:134a:e51a:2ce4%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 15:58:00 +0000
From: <Arun.Ramadoss@microchip.com>
To: <dev@pschenker.ch>, <netdev@vger.kernel.org>
CC: <olteanv@gmail.com>, <andrew@lunn.ch>,
	<krzysztof.kozlowski+dt@linaro.org>, <Woojung.Huh@microchip.com>,
	<davem@davemloft.net>, <philippe.schenker@impulsing.ch>, <marex@denx.de>,
	<pabeni@redhat.com>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <robh+dt@kernel.org>,
	<f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v1 2/2] net: dsa: Add KSZ8567 switch support
Thread-Topic: [PATCH net-next v1 2/2] net: dsa: Add KSZ8567 switch support
Thread-Index: AQHaTgMsflnxEOU4Y0yCNyYf2jg+G7DnjhYA
Date: Tue, 23 Jan 2024 15:58:00 +0000
Message-ID: <605c219739760b1f4ef5fa47216fc3d5d8bc8c46.camel@microchip.com>
References: <20240123135014.614858-1-dev@pschenker.ch>
	 <20240123135014.614858-2-dev@pschenker.ch>
In-Reply-To: <20240123135014.614858-2-dev@pschenker.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SN7PR11MB6825:EE_
x-ms-office365-filtering-correlation-id: d13c0f3c-a81a-435b-b634-08dc1c2c1323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdzbSpXd7YqE+siC1pPnkk8i6cHKxthvdoEyF5bLWkY6T/96R311/sko2pXcy5nOMFVzBEGiPtyceq0GqfLy1TvHvZgNDZxUGnrbDAO3Fj6aAzIkzK0YajKsDT7j93ABAXOWIknSxEOZImnOMM+pnH9l9bKWVzzjT89Nkc4KBC7z17g2pKZrC8yMa/kVLghDpFmhLim+AEl6cSD7eb0GKjRLOwpNDa9td9xAWQr3SrBPX9SJ95zmc549AZdZue1xNtBQ1BssgumVVi5jYxcBW3dkUJ6OEi0VXwGkUvHB/CDyrP/7G/vjy9CmHoFpxZPGoawzzcqFF+FeXRFpY8dmVMZAZjOsXVq0ONcG/RjG4dcqInbrPDH2apW/XKLPM8IPGrdwD8H7h/OpTIWYJ4FVRdr7j0N5X8qeYgF2EnofbZfmOl9i2Ft8zZ8FzTDZQxwjhOH3eti+Krkh869xBltR+DATk815c5QGzZrQ8VaJVaaMR6NBY5j6YE5v6m5OTqEiVM9UJiPG5f3qVtzcpKhTsIhf0SGea0IwxGtt5QHBAzYW9a4DmvL0SaatDqOgGRV8YNqRiykztd8OTr4PS/o7QRtqsEW4v/uhsHfUVoj8DJFEF1afi9Yi29J4KRBobtElb+Pq3ooHdkhTYH3SsZqV5t4pNbiO5Qk4n/aU8SkEznQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(6512007)(66476007)(54906003)(64756008)(76116006)(66556008)(66446008)(66946007)(91956017)(110136005)(2616005)(316002)(5660300002)(478600001)(26005)(6506007)(6486002)(71200400001)(83380400001)(38070700009)(36756003)(2906002)(4744005)(41300700001)(122000001)(38100700002)(86362001)(8936002)(8676002)(4326008)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlltYU9HRFJMVUlqb3QxK0tsckRvWGkvZ1ZoUGRFa3B3YXNENWRHZDR5UTlj?=
 =?utf-8?B?Yll5UThFLzFCN2NTd1RwRzVpcE0zSXpnaDNSU2xQRGpRTTVYV05teEtNVGth?=
 =?utf-8?B?WXA1YXFjWDBFTTZiSGhpMlNzRjRIR2VzK0ErdXhHS1l5RDFxMzlnMno5OFBH?=
 =?utf-8?B?ZlNMZUkwSkdnRXNoQmFPL05LTkF6SjJ4U25taExjbXl6eDNnMHhtYzR0V0xG?=
 =?utf-8?B?MXFtNk9kQTlqajhxK0hka2NzS2RTRFZaVFhMeGlBNXdlaGdha1BpbWd1Q1pI?=
 =?utf-8?B?dmZzMWhIOWV3RU1TYmlIQm5RUFhGRUlqRkNmTU1DdUs2Tlk2SnI1R1Nialp6?=
 =?utf-8?B?bGJmNEZrcXQyNVpKWnZJRGtlekRIRjZqc3h2MFR4Sk1TQlZYUFRyQW9UWG1z?=
 =?utf-8?B?OXNhTkhRT0ZQNEttVVgyOHJLckxrRW80MWJUN3RiVTBCWlZWeVR3QjRxU3FF?=
 =?utf-8?B?V0d2V2ZDRHlYSDhmWDkycjBnMU4zMGJMeVFsSHZsVkJMcGRkYktVbzNJalhU?=
 =?utf-8?B?RFB1QWsvQWZKVFhIOFI4ZEVEMU5CV0RwZ1dDUlRVOXlYS0YxVmQ0WDYrc2Fq?=
 =?utf-8?B?bSt5c2dMMVhnVG5HbExUQ05oTzBPQTJWWUNpMGRjOStuKzAybW01UnF3QndD?=
 =?utf-8?B?cTRheU5zRldhcGVEbko2amtML3FhcVEwYllucElsZlF0RmsyQmp1SFNwU2t4?=
 =?utf-8?B?ZUxBaXhrNStWMXUxWkM3cGJFMVNxdzhUM1lSRnYzbTdIS24zVFlUbmh4aHJC?=
 =?utf-8?B?Ulk1aWVaL1RBb1pNZlU5dTU0NkRnd0VEYkVvQXpobVo0c3NxZ3h4Q0FiekU0?=
 =?utf-8?B?VEgrdWFLN3JlSkJ5ZlJ6UmEyVGlONXZtRlhCalhmMVh4eVZUc1MwOXNpdGRH?=
 =?utf-8?B?MjE0NjRKbUVSSTRUek5WYlFOY3NZZVhlRWtyRzdidUswL0U1ZmhRRU1WZ2tS?=
 =?utf-8?B?M3JxN3VWcUxYRTM4WCtkYjZ0R3JkQXlJYWZ1YVJsZVBiaEZka0hJa0hsV24w?=
 =?utf-8?B?QmdveHBINVF1dVU5L1VDTnY5WGR0YlJ5dGNFdGNQQzJJZEFZVU9VVGVvaEo4?=
 =?utf-8?B?bnNEeUJmOVQyNHNwa2lvTTNEZ0tvTmMzWWgvelRNZW1LZTl4WDIvMjVkNWEr?=
 =?utf-8?B?RVhjY3B4cVZXTVVlZTFLRFZNYnVFb2lZMGhGSEtEZWRhZjBIL0hXL1pHVUZy?=
 =?utf-8?B?K2F5S3N5eWs4VXMvWWZLMit2LzVPYnVXWExQMVpzdnNmY3JZVkRJaC8yZEJX?=
 =?utf-8?B?OTgrYWFZWWczL3kralk2SlFobldleU5ONzFEamJDTnRNSDBTa08wTWc2SmpD?=
 =?utf-8?B?NlNzbXhZdzJMVFo2VnBhcTJCenM4czJlcWFxTm1SdVh1azNFWkt3L1NERVNq?=
 =?utf-8?B?NExhUXFHbitGUmduZWo1WlQ3Zm1JckJnVVIrWVowZHVzMjdJZC8xanVQVStF?=
 =?utf-8?B?SEFXTjlYTDYxRXA1dW1id3BuY2hVYkdNK055VkFsTnVrVW5IcDdyYk5hNlU3?=
 =?utf-8?B?S2pja05YTG9DMyt6WVIvN0FGS1ByUkxyOGo4TlBnQVRiYklUVEE4UEZXZzhp?=
 =?utf-8?B?Nk1jZ1RWSXNPNzhQb05aQlMvOGZQclU2L2dzTXFhcFJXSU9nMm44RHBpZXAv?=
 =?utf-8?B?aFNPQXRhMmtUcmZjTkxaVGhST3JmWW9yaTNXSHlvWDE1SlBQakt3dnpOOVJO?=
 =?utf-8?B?RnNhSWNWOE1xQUIwYzJLMmRMR2IwenY5OFhoeWdlTmx0S1VUVCs3TTA1OXRY?=
 =?utf-8?B?UHVHWXVjdXhOUFcrR3cyOE9nUEs1K3Q0a3JnRTJ5YTlhK29TM0xhUHJ2S05W?=
 =?utf-8?B?ZjBiekdZa0c5V1lwcEZZeG56Y3NCcFhrYlJCUmtsOHNuWlpGdDl5U05sQXo1?=
 =?utf-8?B?UnFwRWhtbzNxWnliVkp3OVRBSDZnRFFnREVEM3BwYVJDREEyazdOak1kS1lp?=
 =?utf-8?B?RVlqaHpjYmxtTU1YbUVQenMvaVMwS0lTampIazFPaldSSEY5WTlBRS96dkhY?=
 =?utf-8?B?TXNPem5HUXhvMlgzOWZJazAwaGFqS204UTA0WWxCVVM0Mjc3ZUFpbnQ4Q0tq?=
 =?utf-8?B?QXROUFkvZnN6V1F2alFsVzRYcmtjMGxDRC9zRTBwM0RkSW1XWjRMdE5GTEVs?=
 =?utf-8?B?VHZpWGJ1MG95V2t2ZG14aTNYVUc4UjRoOFlIMVgwOFk5bDd3eUdNOU02Q21x?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAB79411C3D027448A314C394776BB47@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13c0f3c-a81a-435b-b634-08dc1c2c1323
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 15:58:00.4584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDUWaXqX/A69wrRgODNtMifShdfx9X+BWQucjAOlcBdsby79gqPdZJ4qtAhrefxoXS1q7xTk9lnNsZUDvcVOtGwO9IoR3Wd3st7S3KOMSoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825

SGkgUGhpbGlwcGUsDQoNCk9uIFR1ZSwgMjAyNC0wMS0yMyBhdCAxNDo1MCArMDEwMCwgUGhpbGlw
cGUgU2NoZW5rZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZQ0KPiANCj4gRnJvbTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQGltcHVs
c2luZy5jaD4NCj4gDQo+IFRoaXMgY29tbWl0IGludHJvZHVjZXMgc3VwcG9ydCBmb3IgdGhlIEtT
Wjg1NjcsIGEgcm9idXN0IDctcG9ydA0KPiBFdGhlcm5ldCBzd2l0Y2guIFRoZSBLU1o4NTY3IGZl
YXR1cmVzIHR3byBSR01JSS9NSUkvUk1JSSBpbnRlcmZhY2VzLA0KPiBlYWNoIGNhcGFibGUgb2Yg
Z2lnYWJpdCBzcGVlZHMsIGNvbXBsZW1lbnRlZCBieSBmaXZlIDEwLzEwMCBNYnBzDQo+IE1BQy9Q
SFlzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNj
aGVua2VyQGltcHVsc2luZy5jaD4NCg0KS1NaODU2NyBzd2l0Y2ggaXMgc2ltaWxhciB0byBLU1o5
ODk3L0tTWjk1NjcgZXhjZXB0IHRoYXQgaW50ZXJuYWwgcGh5cw0KYXJlIHdpdGhvdXQgZ2lnYWJp
dCBjYXBhYmlsaXR5Lg0KU28gYWRkIEtTWjg1NjcgcmVsYXRlZCB1cGRhdGVzIGFkamFjZW50IHRv
IEtTWjk1NjcuIFNvIGl0IHdpbGwgYmUNCmdyb3VwZWQgdG9nZXRoZXIgYW5kIGVhc2llciB0byB1
cGRhdGUgaW4gY2FzZSBuZXcgZmVhdHVyZXMgYXJlIGFkZGVkIHRvDQp0aGlzIHN3aXRjaCBmYW1p
bHkuDQoNCg0K

