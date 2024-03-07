Return-Path: <linux-kernel+bounces-95034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7C874872
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0451C21662
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6043F1D54D;
	Thu,  7 Mar 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oSg/YLpq";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jliZ2GZR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62481F;
	Thu,  7 Mar 2024 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795070; cv=fail; b=BYLLU14wLeaWwgQKLgns8+2k3cVE4ksqHnAxOdJQ5cY9JnDaUvIBG3z+bqAgJhJ+joknmlOeVuCdRm3fk7hDZtOiSlL7Y1nZMjwqhamvIIbZ+q6lxC305ECjGItKbPICFJbSZ6MidnHRQ6Qq4zNCmRUsoxhPAGM+45Zy5OpyeWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795070; c=relaxed/simple;
	bh=TwUdieS037IKUrygB0XIuJCp2PkFhfBE28AXB7/Tq0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gx7/hJFCykr3CFjGHU4F6QM2hVWjoNtN0ePEMvcMpVlKxjcYlpFAA1sPkSJY9FCAAZrqQ/Xja7kasPHCINZkr053JpeIfHbjgQrqHtC0BuiGnG1R/Lf698Y52NHcLKenA4CNnyLIP6ii+JIq9VfEC5UXwKO3QhyrBTc0qyh7Mt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oSg/YLpq; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jliZ2GZR; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709795069; x=1741331069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TwUdieS037IKUrygB0XIuJCp2PkFhfBE28AXB7/Tq0g=;
  b=oSg/YLpquL/Eam1sVfYBcpPoGejeiC650DQ+E//MRfoFKwRDk0ZbiNhb
   ZQKfeCDm2z1iKSrNeOnWuf8ysc2EhNgMYDmTNoyFlctwSEqAMv/bahRDI
   HNr7FnvGEevVDdgTu+faO7+PHaKY1unx5HBVmqXgrkspPvClpiHnNfxSu
   DD248pQm9tpp9OpACJr+gt596pt2TtbI/OE4h+uPUrAblYBpCMRTyVQVz
   rSaKcgcQlSboHbZDGk35F0qE5wkW8IzzUxfc0/X7eNnHT4Q0wA+M3jTXJ
   6/pU/Hy6r9SDsKDbZkyBz3EXDBaPAuKEGZ6N27EyiotTlvWIIICRRa9uE
   Q==;
X-CSE-ConnectionGUID: Ch5hL+JWSY6CwOqGZaw1Zg==
X-CSE-MsgGUID: 3UtzOu5FSlSiFWKUmNJdyw==
X-IronPort-AV: E=Sophos;i="6.06,210,1705388400"; 
   d="scan'208";a="17334337"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2024 00:04:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 00:04:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 00:04:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bns6v8omDtswb79JA28UcC//vcCvvFkYY4JlH1xh9+cOgRTWT1spzml2cFnFQudexiWOqCMLDMopRIG1LG+K8RJlZRzn//7iB4NZk0LT3l2C/diEOduKt3YchIzZrK0pbtUMMaMFLqJrdRUrc3l2KUeWn8kQFybprlfDENsJOgkpqRONLsiSsvaDsuuecW5SmfTfPcTDKso0HYC9cO0zS0g2kSvQ/Rw0QMbzQ60OHRbEY5lryf9T1gCn+9jLgVOjkYX8C6LmJvyCW9hY3LdIcVvTQCqKxtN7vAcP9Q/SWvPvEPtvcmLkA3p42oRbnuM7FHVH3L4aNVTPDSzRuVGHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwUdieS037IKUrygB0XIuJCp2PkFhfBE28AXB7/Tq0g=;
 b=DKwb58VrDPkEvuv1XhIk/BAs/qzvubdvvmu1rxSAJvVpLLYr4h+2GCfCP/DSH88ZeNwahvscO1DlrSe8k2R7DvkxX9Ca44kc7wnLvPT9vdFWIWmi9APqkfOOI3jUAVqSuq1OEEhQSFHLLgvbrD6ejt9mwJmO94ZgivKlnoubksqX2SWWi1tSXtZO5AoFKiQCHzPR2S+APGDDOBHKiTFGNE28iadVk9yh3RqxkjLbrM/751j9iIKV/qLfCr/q/tOgYVC7bXWl1II5KqmAlVf2JxMFjquzwFuVgeSxjLUPU7Q7bIjTGl8MqiPqeCAXSm0JrZCf8zJ4xLd3ICBTyXctkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwUdieS037IKUrygB0XIuJCp2PkFhfBE28AXB7/Tq0g=;
 b=jliZ2GZROAXFdW9e2uSfLeVNxyBpwXYw+KF4YsJ0ZbOpY8hGrn6+3PpbSL6NlnOnWbbEU88FkWEJqcTDcvLAkv0S8Jw+DklzxlOje9PPvoM3f2ElOVl8rUpENHU/5K/wDir+31EoVjdmkMCuU/YT6llusUgn3FKYK3GJRO6Nlu2z2Ud6+G+eOt+elcIlxMQ/1ZEyvTAejKPhW/xZLutq1AMl1IoqZ69+apzjEoFk7s9gSqIac7nv/tyOoHVQ41UfbwAk1trHk19f61Hem93luT5JKS2E5HYt06qw1iSyFJNxg3bM+eWt10n/GLcLpgHF8FOhXqWQL0wkfdsTwPWIuw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 07:04:20 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 07:04:20 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, <Pier.Beruto@onsemi.com>,
	<Selvamani.Rajagopal@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v3 03/12] net: ethernet: oa_tc6: implement
 register read operation
Thread-Topic: [PATCH net-next v3 03/12] net: ethernet: oa_tc6: implement
 register read operation
Thread-Index: AQHab6N33BKSiButbU+b9vGzVOsXAbEraxEAgABw/QA=
Date: Thu, 7 Mar 2024 07:04:20 +0000
Message-ID: <83e0b340-521e-4d60-90bb-92d2ca6f5abe@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-4-Parthiban.Veerasooran@microchip.com>
 <48b65759-6e69-46ef-a2ed-857d04eadac8@lunn.ch>
In-Reply-To: <48b65759-6e69-46ef-a2ed-857d04eadac8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|SN7PR11MB8065:EE_
x-ms-office365-filtering-correlation-id: e771ddf8-3b08-42e3-5ceb-08dc3e74d016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4ysUgs0sqYR7iF4/Rri2o20hRzGUB9GvhIngf/LN0rd3symAmJef5gnRyZ97+YkJQ0pSpWMwi268wIt2U1EHxsnuVSSTAm/LSCB3BaJl7a6BTx7DgBGs8PbuYqqr7RoMALrD26If7QYuCSaL6NSG9PbcJSUqC5/7Eq1CUPG3503LYfeyOHhoBjCZQn3HaqL9UaqXdtyEbkWRIVXXF//MpoPijenImiUwD3D6TZJpNl02RH8Zuzo4YOIVL+kn74riij5iAtmZLaAjZxQ7PcbHWISVP9/tJ3xD4qFSEVFTKCcwKpNJAijObZEqg6zksri+j8C59ooHwSRA8bc+2Kl4ngBHXUm0XohxruKbYjPLvwSP/9ngdx6u4MA2QesYJ5Z4uJ2xC7BwhiD63dQWGdmjElmAeiefGRltq1N9d4Rs/K6oGcLIak78t4iVvV9bSNZQlzhVSb1bO2+FvahGOKuxRu00YshY+S+4e4Sq+WH5noK9YWZ1RUslONsQblcjq8dJ6/FiBnw0bh989Pe+yJC1rPR5GoLV6587BQt1jal91y44zf34Rqs5ZJGmD1qHOw34jDdlmcBBFnggnnH5UI4f/tp8tU6+PUJIefVJhRhJNfmpLeUjydu+O4mbPaEw2B28VCOvRjfKS4u+pjEGVKlth4uAxYJfDYMQb/ypHJrlVOal3EANsw7rSOeqpKwI8iaEuV+w/qW5FNBoKggIr0TBlEW6eRAwPYdeW/Lkb7m9Ik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXhIdmI2OFRFd2tBYlhHVGdVa2NtcC8vbm1aWTFIcWdkejFtSzVoaFdUcnc1?=
 =?utf-8?B?SjVrRzR5blhuZVZhcXhrQnFjem9lSjJ5eTFLTnUyd1JYaFBmb2ZXT1g0bXBa?=
 =?utf-8?B?RTdiNllVajM3b3FQNlk5b25WNkhYaW9XM0FOUUlNcm9pZUxLVlhsRjVnUzdO?=
 =?utf-8?B?Z1dLWmlKWHVFYUpkaUF1ODMycE92NnBBeU9sbnQ2cmF5QzlvUUI3ajBZMmpK?=
 =?utf-8?B?L1N5Yzc5ZTc5VE1JRWNwbmlRM0VkZ0RDb3RKM3dEVDZSVUpRM3EyeDJsUWJm?=
 =?utf-8?B?NDNZZlNadFpXSnZ5RlFVdXRDaEt4TkVVb2lhenFDbkpkQ2doa0RlYWNDSXJs?=
 =?utf-8?B?REcxTjZkQzdKRzJvYnZXZnpNbWIwTm9aelBBek1hajR6aUNHOWI0ZzdnQmFv?=
 =?utf-8?B?QUNuanA1YnFyUXZCUk1rbFQrZE4vV2d5dXN1WnVLZFl6UmlCSzRoSnN5QUc5?=
 =?utf-8?B?MW8rZUlUaXczOUxKcURVWHVMMCtPa3hmQWM3bGg5VXdOc2dWV0I0TkNjdmJk?=
 =?utf-8?B?RHdJU1U3eHZQaVpqLzUwZkt2WjJiVlV4cHE0RmJEWndWLzVaa25BQ3l1YzZq?=
 =?utf-8?B?OXpxRjF2dWVYMjBpOFVId2VYTDRTMVFnZEJTU2NzdDFNVDVEREFIK0NncVdB?=
 =?utf-8?B?Si9idzB6a0tUeEYvbk02OERQRXBOdkU5VzIzdzhWYzZjQU4vRVlFdWk1dmNI?=
 =?utf-8?B?N0tiRzFJQll3eUhzbEcybGE4NGR0TW5tNW5INU02aDJyNGtqdWY0QldZV2Mx?=
 =?utf-8?B?NmRGUWhDVlNGdlVtbDBRNUc5OFU3NHRnQXArQm9qaFJlU1BwZXRlMWhHY1do?=
 =?utf-8?B?enhlZFBZbGxMZGkwSXlBMFFQZlhQUkJoVkJzbWZPRkhXNEQ1WGVaNE1zTjM0?=
 =?utf-8?B?Qy9EOE9qMjJ5MzYzVVQ1Mk9zck5FM3c2bXc4OHlWUi9rcWdieFdhK2hyVkEx?=
 =?utf-8?B?YUE0aWFObVRQUVJlcHN6WlFLRGJScWxtbk82Z01BRFR4enRzSE8xQlh2STBV?=
 =?utf-8?B?ZlNDWnM1aTdsWXZOMXJiTkh3SWtwS2hOcnBtcmVTVEhHaDF4ekRWVFFXNStu?=
 =?utf-8?B?TE55ZHFUMmNvc095NW42bE1qVnlIK2Q4NWlQRTRDR1F0TzF5MUpzVXVreEF0?=
 =?utf-8?B?T2MyMEtxc05qWkVvcWpxMXpRQ1g3bVYvUjNIZnZrUmtoK2xmdzVmMXlwSHBm?=
 =?utf-8?B?MFVOd29XTW51Z3dFWFZSUFZJdE9ZclFFM0JBd1pGb2llZnZmSDlnbzdqeVJN?=
 =?utf-8?B?OENNbzBNdklvSlNMVzFGcEtaN0xERU5kQ3JaMHdCOUM4R2RKc1dYR2NxMFZa?=
 =?utf-8?B?UG01ZFlhVHdaYUpjbFFWSnJHU0pmdGV3OGZwOUh0eWNSbnNzSWgrQWYzV05Z?=
 =?utf-8?B?Y2FUbWZFVk00YjVLbDR2ZmNJeVd6U0tRbE1TZCt1Q0FBVFdnZEhRaWZVTVNy?=
 =?utf-8?B?dFJoeXNFUC9BUVlFditYVmdKVmZXSTlTMDR5ck5mTnpIc1M5Nm12eE9jcEtn?=
 =?utf-8?B?YjI2S1Z0R1dTa2wwKzdFM2p0VDNNNVpqdXRGNlcxWHRKQ2k1SnhsZmVVL3gx?=
 =?utf-8?B?VE1BbU9BYTNvY2RCa2FneG12ZXBtT0t4WEpUQWtlYUJTWUM0RlZnVFBiOEZh?=
 =?utf-8?B?eXpGMmg5eElEdEJ2ek9DejMybE85b2lxRm92S1V4WStzcFBWY3p5QjRBSkRq?=
 =?utf-8?B?czY4WUM5TUtzTGkyMktQN2tMUXlrSks1cFNTVXFxc1R4eVBHRWtVNkNzV2lr?=
 =?utf-8?B?Z0ZGNitlaGhQWUUyaGJLeXN5TExNd29iSHhBNEU5cFlQWnRoTFUzYjlTekF0?=
 =?utf-8?B?UkRadzU5MWxSbmVXWUJWdlBMVTdCTFNZbW1abk9HS2xGNDJscEE4ckc5SUpL?=
 =?utf-8?B?VTZqaDlXcERtcXhyVUVJM2pFSy9jNVU5V0dnRktTVU94MWd6b3kxdnBQV1kv?=
 =?utf-8?B?Z0pteERuRjdTQTlIVGV6M0NXdlJiN3hnbFpmcy9URUdINEpZeW5VYmdWUXh1?=
 =?utf-8?B?QlN3NFBWRHBKMnNBU2ppZHAvRDBOVDZHQkozUUViUFdZWFQ1cnhVZWdJQnUr?=
 =?utf-8?B?WFFJTWZ4a2l1WmVYUm1JZ3NmMkFlZEhMdlFOemJGVFdEQURZUExJL1dScFZu?=
 =?utf-8?B?UTlpQUFOa24xeTVxYTFQYjNKNnE3ejNhNGVmaUY1RWZ1WUtxV2Q2UjJpcUQ5?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78E906391D06F4478B99081A3FF43EFB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e771ddf8-3b08-42e3-5ceb-08dc3e74d016
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 07:04:20.7973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmNuSY91otswYbS4Y9dnl50/+EBa1s46X5ZUVXnmfOQxL9/W0qNNsKW5vpAIvnVdoC4nwTDKp2HV4jEUmnc6ITIDHRcBsng6d3UxHERSQvKU+DIW+RbGjdhu5emOGmXJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065

SGkgQW5kcmV3LA0KDQpPbiAwNy8wMy8yNCA1OjQ5IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gICBlbnVtIG9hX3RjNl9y
ZWdpc3Rlcl9vcCB7DQo+PiArICAgICBPQV9UQzZfQ1RSTF9SRUdfUkVBRCA9IDAsDQo+PiAgICAg
ICAgT0FfVEM2X0NUUkxfUkVHX1dSSVRFID0gMSwNCj4+ICAgfTsNCj4gDQo+IEkgdGhvdWdodCBp
dCBsb29rZWQgYSBsaXR0bGUgb2RkIHdoZW4gdGhlIGVudW0gd2FzIGFkZGVkIGluIHRoZQ0KPiBw
cmV2aW91cyBwYXRjaCB3aXRoIHRoZSBmaXJzdCB2YWx1ZSBvZiAxLCBhbmQgb25seSBvbmUgdmFs
dWUuIE5vdyBpdA0KPiBtYWtlcyBtb3JlIHNlbnNlLg0KT2suDQo+IA0KPiBUaGUgYWN0dWFsIHZh
bHVlIGFwcGVhcnMgdG8gbm90IG1hdHRlcj8gSXQgaXMgYWx3YXlzDQo+IA0KPj4gKyAgICAgaWYg
KHJlZ19vcCA9PSBPQV9UQzZfQ1RSTF9SRUdfV1JJVEUpDQo+IA0KPiBTbyBpIHdvdWxkIGRyb3Ag
dGhlIG51bWJlcmluZywgYW5kIGxlYXZlIGl0IHRvIHRoZSBjb21waWxlci4gVGhlDQo+IHBhdGNo
ZXMgd2lsbCB0aGVuIGxvb2sgbGVzcyBvZGQuDQoiZHJvcCB0aGUgbnVtYmVyaW5nIiwgZG8geW91
IHJlZmVyIHRvIHRoaXMgcGF0Y2ggYWxvbmUgb3IgcHJldmlvdXMgcGF0Y2ggDQphbHNvPyBJZiBp
dCBpcyBmb3IgdGhpcyBwYXRjaCBhbG9uZSB0aGVuIGl0IG1ha2VzIHNlbnNlIGFzIHRoZXkgYXJl
IA0KZ29pbmcgdG8gYmUgMCBhbmQgMSBhbnl3YXkuIEJ1dCBpZiB3ZSBkcm9wIHRoZSBudW1iZXJp
bmcgaW4gdGhlIHByZXZpb3VzIA0KcGF0Y2ggaXQgd2lsbCBiZWNvbWUgMCB3aGljaCB3aWxsIGNy
ZWF0ZSBhbiBpc3N1ZSBpbiB0aGUgYmVsb3cgbGluZSBhcyANCml0IG5lZWRzIDEsDQoNCkZJRUxE
X1BSRVAoT0FfVEM2X0NUUkxfSEVBREVSX1dSSVRFLCByZWdfb3ApDQoNCkNvdWxkIHlvdSBjbGFy
aWZ5PyBvciBkbyBJIGhhdmUgYW55IG1pc3VuZGVyc3RhbmRpbmcgaGVyZT8NCj4gDQo+PiArc3Rh
dGljIGludCBvYV90YzZfY2hlY2tfY3RybF9yZWFkX3JlcGx5KHN0cnVjdCBvYV90YzYgKnRjNiwg
dTggc2l6ZSkNCj4+ICt7DQo+PiArICAgICB1MzIgKnR4X2J1ZiA9IHRjNi0+c3BpX2N0cmxfdHhf
YnVmOw0KPj4gKyAgICAgdTMyICpyeF9idWYgPSB0YzYtPnNwaV9jdHJsX3J4X2J1ZiArIE9BX1RD
Nl9DVFJMX0lHTk9SRURfU0laRTsNCj4+ICsNCj4+ICsgICAgIC8qIFRoZSBlY2hvZWQgY29udHJv
bCByZWFkIGhlYWRlciBtdXN0IG1hdGNoIHdpdGggdGhlIG9uZSB0aGF0IHdhcw0KPj4gKyAgICAg
ICogdHJhbnNtaXR0ZWQuDQo+PiArICAgICAgKi8NCj4+ICsgICAgIGlmICgqdHhfYnVmICE9ICpy
eF9idWYpDQo+PiArICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiANCj4gQW5vdGhlciBj
YXNlIHdoZXJlIC1FUFJPVE8gbWlnaHQgYmUgYmV0dGVyPw0KWWVzLCBJIHdpbGwgdXNlIC1FUFJP
VE8gaW4gdGhlIG5leHQgdmVyc2lvbiBhcyBpdCBpcyBsaWtlbHkgIlByb3RvY29sIGVycm9yIg0K
DQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgQW5kcmV3DQo+IA0K
DQo=

