Return-Path: <linux-kernel+bounces-57403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3084D7FA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563541F2319B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CB21CF9A;
	Thu,  8 Feb 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KXA0d2tw";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lBypEPvc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE191D522;
	Thu,  8 Feb 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360658; cv=fail; b=dQI4DLBTnVa9Q/ybILcHNdqBV/tNnqZr0snQVwx9qeA+gK+aXBkhsvG99of0/riYEJ/cabugESuKydIx+sJts2+g+p6uCwKqmA+CqoeKg5c+P5XBK2C0N/NKFYZSwS202ZQ4d/dG3sjxArKW+uyZqPEQ91E40jaPF4ULK6NBFUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360658; c=relaxed/simple;
	bh=ydRjAUpYVZMATkwnJK68ff6jERNvN9rEi0k/n+2Wd0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AvMlc86WhXakBbG8rBnXaLIQoCmHNB8C4wwrMaVgWKQuAXI8Wyt1NS0h308OyE+pyymkzI8FWa1euL1SwPdZS1+YAq/+rzSidOC35Vh6i3lXOO797/mkL9r4rHhzJZ12QeyF4/ee+0O/XV93P0W38YtnljAa33EiVd0KrSywZyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KXA0d2tw; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lBypEPvc; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707360656; x=1738896656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ydRjAUpYVZMATkwnJK68ff6jERNvN9rEi0k/n+2Wd0w=;
  b=KXA0d2tws9p3JTRFoM/LaS62g++q8awMWsNjc6u+wnj+ppx5bBq/b3sy
   xtyk4EkQ0gbODoZfFNyuwdwtOb06MF9f+6DDghtW26uSUsdeuyYtveNTo
   kBRbcVeiExMdbXmXReOupL9iUaYrKfmm3l4l4Byze/8k/HI5KlqWOHbdT
   MXNqSa6Rw1RYtck5yCQaDNl5DgPHoxjk1PaJPXiHVBBbGaMduDJFsl4DE
   VbKud9vCjvIr1tu2K4YbFjjDqK/0RshkP5PJ0SUBpe+Syl6OeuBCbPbZG
   B7NOxIV5MD4yvG63l1u++TCC9mFjvpCn4kv/bZchAjsQCOcA54/t9tiOb
   Q==;
X-CSE-ConnectionGUID: Wf9IsjAHQzGTqwSVA5RvLg==
X-CSE-MsgGUID: 8q6EnUtdT4G4BBQylc6krQ==
X-IronPort-AV: E=Sophos;i="6.05,252,1701154800"; 
   d="scan'208";a="15948605"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2024 19:50:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 19:49:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 19:49:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQTS5Ieywf3qjkuygQTT5h4L1IX00oFIq8lz7TX0oQjabFnComXb1JuCFJOKJJfPtEv5VelaVShYlotzKl/Pp25KO21CywcToFxGv32WedoWFHavXw8N99Bkmgi6LO/5FLvkF+jdZftyZBMKQQvTVa9uEWdrG5B9L+uSM6UU+8CsJtIg9fn1R/5/l4nGnSFZVzCcoOCwwFx8RbTTP+YE21qdM2H+XRvXy/2cRtXwgBZ/CXMHnk1CC7mjj263NdHlZrGOO2I3OYpVTKPcWhAACMmefw85bXbwsDWu10+PzJbgfEgZwT0wj6SYQXtxGnbuDq9LVQUPm/N80gT2Y9JnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydRjAUpYVZMATkwnJK68ff6jERNvN9rEi0k/n+2Wd0w=;
 b=j3RUrsna8KDqK5Rxz1rpHAXwprK+4acvAld2GRR/564dovFL8YhbtHsF7RoXAEJ3T1w91XtlBKgmHC+V5g2cvWQSWU4eYGUAUXqSAjo2oB02Ha0dwsSW2rUXPqj+A7yqzeVVqDYE+uWcsgprz/nHltMu9oBYoXGkZ5JbPF7x9DejZvYFq7g8oV+TZmKzZCjNtvn9AnShlTxYvlcEqI9YfT6YI16RujXQJPcu/NVrFSbvN8O6gqV6IlLvmHQO6zsQAT3oS5+JcLBQodWeihgtznbmT0X/l1wayKs3NarmxDVp9Ut2xmi2LT9E5sO6/9BdTUpIOeiNzszP05QKyVA2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydRjAUpYVZMATkwnJK68ff6jERNvN9rEi0k/n+2Wd0w=;
 b=lBypEPvcVqYnqzOYgFbc/TZPp6+ZyzrSFGDEGQtgDSDupCDiK1epV/d/izX9XzsIuSWDO7Nu70nyD8IHB0wcIY/b8up5Qs9ixeqNmMLhYoksWkmHV1FFY1HZQS2h9ZD6g+FU+n+mSQfKiwhbzOwPRj3Sj6I1dm2IZA/kBX215XwM2xfnN3+t8tgTuslhpys2hlDm6k4nmkFKxIZbTaUDdVAI9m7Iq2W6qDhogy3PRYuGWo9JsGwwNZCYvpKkJl+JUA2inIIHt/mWHydTKSk0/K9DhW2vzIjwNCUOA98f9gx8djTUcqW4HIECo8IDHVndgwfcYsSHs+7htR3ebAyApQ==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by BL1PR11MB5509.namprd11.prod.outlook.com (2603:10b6:208:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 02:49:57 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::db66:9b2b:5611:c30c]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::db66:9b2b:5611:c30c%7]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 02:49:57 +0000
From: <Rengarajan.S@microchip.com>
To: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <Kumaravel.Thiagarajan@microchip.com>,
	<linux-kernel@vger.kernel.org>, <Tharunkumar.Pasumarthi@microchip.com>
CC: <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Add Burst mode
 transmission support in uart driver for reading from FIFO
Thread-Topic: [PATCH v1 tty] 8250: microchip: pci1xxxx: Add Burst mode
 transmission support in uart driver for reading from FIFO
Thread-Index: AQHaT3WLRumdtnKnSkmf4pJi4f+h0bD7cs6AgARh+YA=
Date: Thu, 8 Feb 2024 02:49:57 +0000
Message-ID: <e7f29dd64829b597f3881abcf4da653156c1fe59.camel@microchip.com>
References: <20240125100006.153342-1-rengarajan.s@microchip.com>
	 <b8325c3f-bf5b-4c55-8dce-ef395edce251@kernel.org>
In-Reply-To: <b8325c3f-bf5b-4c55-8dce-ef395edce251@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|BL1PR11MB5509:EE_
x-ms-office365-filtering-correlation-id: b70fd0ba-0b28-4822-7433-08dc2850a2fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 72SaSPAcMc9+SsuFMRsiMvaHJGbG9DTxhmi4PAvj5fnEntpt7OppphQ9UiaNOtDI3V77Z1eUM3eArjK7QaYTvWSIPbBk8PBP1CMGzls2NIeyw8VRynA7JaqJJRUl34RjggtZPLDNYig4K9bAJx6kRBw3K/7Cq2+OWCPeAbQbCGt+iwYY/yYAq6UtGPWkPPJycikCtwJW3ZITKdy5CLYbgFTvjN2Y2cPJQKxXd+OcOw0kY1qTLiXK8AR9HbTSNMd3ec1X2wEJhRP88Bfj17y60ZdbkHbvDQtWzfYs8m/Uf/jesT8kCPHCz2uH/ilLLnEWzEq52oKzPjx3pGvujNy1d8cIhzC3RdMQo6UIEGkea3967sSnG0ehruGn2p4YMFgYgtceu2UCzAMXffWY3KbOuxQg9uxef88zBVyNrqvKV23Bkj0hFIaJsfedMEbnY+ClOXuGYdrXlqkIrcNg8m7Guhb4u+f1bW+fNtTiT1tqb823K0qQ+6jJTYoTj6yMNpg4tKMoEjvHkKSbRA8ZrfqztEC8q5/AdNDAW841Suk/tgOgzH+5cPXW2di6lcVuy5tBnP3MHeLN/wnCQ9wLWMrM+F6TRskhlToY1nQE9JQie74agFHutmJsOGfLydnTAUcO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(86362001)(38100700002)(122000001)(966005)(6486002)(478600001)(64756008)(316002)(6636002)(66446008)(66556008)(66946007)(110136005)(66476007)(76116006)(26005)(107886003)(2616005)(71200400001)(6506007)(6512007)(38070700009)(36756003)(8936002)(8676002)(4326008)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1BKWXVPYlJHaW9NQldhbEtoZmJ3d2Q3YnJVT0pVSEpzcHNiS1RQN2czZDZo?=
 =?utf-8?B?aUdEMDRkVWFOT21GUGxZYnU3bEt4cDU3RGxqWmlzek5OM2RNd24vcU5iRTFU?=
 =?utf-8?B?RDhobFdnZVdEL1paK0gvcHRpajlITUZZaW1Ocll5SHh6dzYvRURRMFFFbUtY?=
 =?utf-8?B?ZTNGc3pEaEQ1TFhRWUkwL21mNDZWZ0h0WWlHalZXQzd5OVZIZWJJWkhvZk5J?=
 =?utf-8?B?QkdyRHVNODZNWHJaWWFSWXdSY09QdmNUQTI2MXRrK0JXdnZ0TS81L1dObUcw?=
 =?utf-8?B?RllXcWZQcUIwS1JXRnZvOGV4Y0dmQ0tYUldxNEhaeGpVK1M3TVhJcTMzcG5W?=
 =?utf-8?B?cWYydE1RM04vajY2d1ozV1R6TkR2N3Bnd0JZQkhNcmpKc1NKdDRLZDhSNXZy?=
 =?utf-8?B?NGZGNFBjeC9TdDRjOHNmeUZNR3lUWExHaS9BZWVmdWdVSVVxYTR2aEthME9C?=
 =?utf-8?B?elBrdUtGR3R5cmx0dkVLWUhBcGFMd1lRWDFLUkdVVDdpc3k2UHJmOGJNSVpB?=
 =?utf-8?B?ejRmejNLQnUyaWVBb1lKWWR1N1c4YWEyZUZaRnVyd2RNUkJCN2taS1dxNGtC?=
 =?utf-8?B?bkhEazlRK2sybDlvdThGN3RRRmVZci9qOGRUTGRQYk1jSFFmdkRjVVJPdzhS?=
 =?utf-8?B?cWtyYnUxMzRVeW1uaUJYeXErTGZqa21kMHNjdktCajlDOVlreVBCY3ZKd0lS?=
 =?utf-8?B?dlU1bGZTVWJTZGpPamxlb05FTGJEQUlrQ1lFK3hUME9SazBlaFhjMjdMSUlz?=
 =?utf-8?B?cktQUnhiMVErQXNwOFU5dFcydkl2TWwvSlVMZmluekpnOXdGQ1hNTWcvcG9P?=
 =?utf-8?B?Qys1VFRqSlFyQ1dNd2FSTEFQM0M1MFQwV3BZUTNoMngxTUNuelZvdnBZT0Vw?=
 =?utf-8?B?N0MraUk3Skg1WStNS0FSQXVYQ2xuOVlBajEwVEZPemxZcU1hN3lQUnlIdURG?=
 =?utf-8?B?VFAxWFZxTWhIbkVpeFhFeHVKZ2JsU0F3OWhMQWJPTHo0ck8yRWZCT3crR2Jv?=
 =?utf-8?B?L1lFemNZUEowWkJnTDFkNE1nYy9xVHBmTWsxQmxkN2U3aUJJUXhFMkZzL2Z4?=
 =?utf-8?B?NkRkRTQ5OEpEbkRiTUpuc1RubDhBeVBVQ1lnbGhXdm1NMW54SVVSS3VXV052?=
 =?utf-8?B?TFVOSmxCQTRtZjM4MTNTY01xR2xPR3JhUXFsMGRPR29xTTVEalpRejFWdmlK?=
 =?utf-8?B?aHMwRmR3U1hXY2JpMTFLclFKdTVxM2VRY0VVVnQweU1RdkkwQTd6bDQyVmp4?=
 =?utf-8?B?bU5ERzk3cU44cjRYb1V2aCt1SlFCWDdrckMrNUh6UWQrbGgwMjZEODZXeUdT?=
 =?utf-8?B?WVBiTmNLdFkrSFJPVlNiV2ZYRDcxVW1HRkxHaHJDYlY4bVJLRlRDK2tGZUpV?=
 =?utf-8?B?OU1BL2xmV2FETlZkOHBXMk15SUZlbFB0cHVvQTF6UVRiTGZkc0czc09UOFVw?=
 =?utf-8?B?bkF5Z0NGaEFUUUxQWUE2cHVjODVmVEtBVUk3empXemcyc1hKMHJKVEtBU2hY?=
 =?utf-8?B?d2cvV0ZlYUpjRmdxZGJlWDdHMDRqS2xYQ0U5eHhDRUlZQkpVeEpyaE5CR1Vy?=
 =?utf-8?B?MlFSUmo0THIxWjJSWmJaUkNuYncxOFc2UnNuZDlGNlZyRFFQV0haSExVYmQr?=
 =?utf-8?B?b0pYUEdIRENkaTE1dHkwbDY5M1pnQ2NMZUEwMWFZd0FINE5ONitwdkZVd3FS?=
 =?utf-8?B?bmFZbU8veEtPWVNTTVVBc3lHYWpzWXdOTlllajZUL1NFcEd2emlYdDFSdnlN?=
 =?utf-8?B?WU5ZcWcxeDdReDltZkM2aFFqWnhRY1QrdDBSNllyejJHVHdBMkxkNEpHai9Z?=
 =?utf-8?B?S3lLc3cwUEpEZ25ZUjczTzlnQWY1Z0FZbnNDN1FEWTJwOGtqYTUvdEJVb01W?=
 =?utf-8?B?OWYyUytFQy9xR1ZOcHlJSmV5a3RnaFlOV2RCYzZoT0ZwMExVdzF0UDFjSjdq?=
 =?utf-8?B?THUrZzFZSlpJc3lIOXpFRUo5NUNXNWR6VkduWXZ3U0lsRjg5VFRZQWFLdjhB?=
 =?utf-8?B?VVYyQk1ZNnl0VnA4RDhNalh2RnVFdkdJSjFwdDBORGhIK0J2R1RheFhtY1dn?=
 =?utf-8?B?cDlESCt6ZUpZOWdUZzJZSmZRRytpZExBbmVmWWpGbi9hQUpuR3NiM0E3bWNF?=
 =?utf-8?B?VVZuVzdGTHVFajVvWnR3NEdsb0dwTFlsYWZ4SVYvMFJkVklOak1pQkI1dlJk?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D0101F101E4D943B2B1361EADE415DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70fd0ba-0b28-4822-7433-08dc2850a2fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 02:49:57.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fn8Md49h7V7yL58U2UsQoEnGIk/T3M8ayg4/EULSTSLD47zm6KSUrXnJ4FAZ/bf8StEQETt2Ef27WWMqu7PJmNxFCZWSyln3HuuAd2tamA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5509

SGkgSmlyaSBTbGFieSwKClRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4gV2lsbCBhZGRy
ZXNzIHRoZSBjb21tZW50cyBpbiB0aGUgbmV4dApwYXRjaCByZXZpc2lvbi4KCk9uIE1vbiwgMjAy
NC0wMi0wNSBhdCAwODo1NiArMDEwMCwgSmlyaSBTbGFieSB3cm90ZToKPiBbU29tZSBwZW9wbGUg
d2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbQo+IGpp
cmlzbGFieUBrZXJuZWwub3JnLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQKPiBodHRw
czovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0KPiAKPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+IAo+IE9uIDI1LiAwMS4gMjQsIDExOjAwLCBS
ZW5nYXJhamFuIFMgd3JvdGU6Cj4gPiBwY2kxeHh4eF9oYW5kbGVfaXJxIHJlYWRzIHRoZSBidXJz
dCBzdGF0dXMgYW5kIGNoZWNrcyBpZiB0aGUgRklGTwo+ID4gaXMgZW1wdHkgYW5kIGlzIHJlYWR5
IHRvIGFjY2VwdCB0aGUgaW5jb21pbmcgZGF0YS4gVGhlIGhhbmRsaW5nIGlzCj4gPiBkb25lIGlu
IHBjaTF4eHh4X3R4X2J1cnN0IHdoZXJlIGVhY2ggdHJhbnNhY3Rpb24gcHJvY2Vzc2VzIGRhdGEg
aW4KPiA+IGJsb2NrIG9mIERXT1JEcywgd2hpbGUgYW55IHJlbWFpbmluZyBieXRlcyBhcmUgcHJv
Y2Vzc2VkCj4gPiBpbmRpdmlkdWFsbHksCj4gPiBvbmUgYnl0ZSBhdCBhIHRpbWUuCj4gPiAKPiA+
IFNpZ25lZC1vZmYtYnk6IFJlbmdhcmFqYW4gUyA8cmVuZ2FyYWphbi5zQG1pY3JvY2hpcC5jb20+
Cj4gPiAtLS0KPiA+IMKgIGRyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfcGNpMXh4eHguYyB8
IDEwNgo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwg
MTA2IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfcGNpMXh4eHguYwo+ID4gYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUw
X3BjaTF4eHh4LmMKPiA+IGluZGV4IDU1OGM0YzdmMzEwNC4uZDUzNjA1YmY5MDhkIDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wY2kxeHh4eC5jCj4gPiArKysg
Yi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BjaTF4eHh4LmMKPiAuLi4KPiA+IEBAIC0z
NDQsNiArMzQ4LDEwNSBAQCBzdGF0aWMgdm9pZCBwY2kxeHh4eF9yeF9idXJzdChzdHJ1Y3QKPiA+
IHVhcnRfcG9ydCAqcG9ydCwgdTMyIHVhcnRfc3RhdHVzKQo+ID4gwqDCoMKgwqDCoCB9Cj4gPiDC
oCB9Cj4gPiAKPiA+ICtzdGF0aWMgdm9pZCBwY2kxeHh4eF9wcm9jZXNzX3dyaXRlX2RhdGEoc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGNpcmNfYnVm
ICp4bWl0LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgKmRhdGFfZW1wdHlfY291bnQsCj4gCj4g
Y291bnQgaXMgdW5zaWduZWQsIHJpZ2h0Pwo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgKnZh
bGlkX2J5dGVfY291bnQpCj4gPiArewo+ID4gK8KgwqDCoMKgIHUzMiB2YWxpZF9idXJzdF9jb3Vu
dCA9ICp2YWxpZF9ieXRlX2NvdW50IC8gVUFSVF9CVVJTVF9TSVpFOwo+ID4gKwo+ID4gK8KgwqDC
oMKgIC8qCj4gPiArwqDCoMKgwqDCoCAqIEVhY2ggdHJhbnNhY3Rpb24gdHJhbnNmZXJzIGRhdGEg
aW4gRFdPUkRzLiBJZiB0aGVyZSBhcmUKPiA+IGxlc3MgdGhhbgo+ID4gK8KgwqDCoMKgwqAgKiBm
b3VyIHJlbWFpbmluZyB2YWxpZF9ieXRlX2NvdW50IHRvIHRyYW5zZmVyIG9yIGlmIHRoZQo+ID4g
Y2lyY3VsYXIKPiA+ICvCoMKgwqDCoMKgICogYnVmZmVyIGhhcyBpbnN1ZmZpY2llbnQgc3BhY2Ug
Zm9yIGEgRFdPUkQsIHRoZSBkYXRhIGlzCj4gPiB0cmFuc2ZlcnJlZAo+ID4gK8KgwqDCoMKgwqAg
KiBvbmUgYnl0ZSBhdCBhIHRpbWUuCj4gPiArwqDCoMKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgIHdo
aWxlICh2YWxpZF9idXJzdF9jb3VudCkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoKmRhdGFfZW1wdHlfY291bnQgLSBVQVJUX0JVUlNUX1NJWkUgPCAwKQo+IAo+IEh1aD8KPiAK
PiAqZGF0YV9lbXB0eV9jb3VudCA8IFVBUlRfQlVSU1RfU0laRQo+IAo+IGluc3RlYWQ/Cj4gCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHhtaXQtPnRhaWwgPiAoVUFSVF9YTUlUX1NJWkUg
LSBVQVJUX0JVUlNUX1NJWkUpKQo+IAo+IElzIHRoaXMgdGhlIHNhbWUgYXMgZWFzeSB0byB1bmRl
cnN0YW5kOgo+IAo+IENJUkNfQ05UX1RPX0VORCh4bWl0LT5oZWFkLCB4bWl0LT50YWlsLCBVQVJU
X1hNSVRfU0laRSkgPAo+IFVBUlRfQlVSU1RfU0laRQo+IAo+ID8KPiAKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB3cml0ZWwoKih1bnNpZ25lZCBpbnQgKikmeG1pdC0+YnVmW3htaXQtPnRhaWxd
LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBvcnQtPm1lbWJh
c2UgKyBVQVJUX1RYX0JVUlNUX0ZJRk8pOwo+IAo+IFdoYXQgYWJvdXQgdW5hbGlnbmVkIGFjY2Vz
c2VzPwo+IAo+IEFuZCB5b3UgcmVhbGx5IHdhbnRlZCB0byBzcGVsbCB1MzIgZXhwbGljaXRseSwg
bm90IHVpbnQuCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICp2YWxpZF9ieXRlX2Nv
dW50IC09IFVBUlRfQlVSU1RfU0laRTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmRh
dGFfZW1wdHlfY291bnQgLT0gVUFSVF9CVVJTVF9TSVpFOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB2YWxpZF9idXJzdF9jb3VudCAtPSBVQVJUX0JZVEVfU0laRTsKPiA+ICsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeG1pdC0+dGFpbCA9ICh4bWl0LT50YWlsICsgVUFSVF9C
VVJTVF9TSVpFKSAmCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKFVBUlRfWE1JVF9TSVpFIC0gMSk7Cj4gCj4gdWFydF94bWl0X2FkdmFuY2Uo
KQo+IAo+ID4gK8KgwqDCoMKgIH0KPiA+ICsKPiA+ICvCoMKgwqDCoCB3aGlsZSAoKnZhbGlkX2J5
dGVfY291bnQpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCpkYXRhX2VtcHR5
X2NvdW50IC0gVUFSVF9CWVRFX1NJWkUgPCAwKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdy
aXRlYih4bWl0LT5idWZbeG1pdC0+dGFpbF0sIHBvcnQtPm1lbWJhc2UgKwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVBUlRfVFhfQllURV9GSUZPKTsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmRhdGFfZW1wdHlfY291bnQgLT0gVUFSVF9CWVRFX1NJ
WkU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICp2YWxpZF9ieXRlX2NvdW50IC09IFVB
UlRfQllURV9TSVpFOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogV2hlbiB0aGUgdGFpbCBvZiB0aGUgY2lyY3Vs
YXIgYnVmZmVyIGlzIHJlYWNoZWQsCj4gPiB0aGUgbmV4dAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICogYnl0ZSBpcyB0cmFuc2ZlcnJlZCB0byB0aGUgYmVnaW5uaW5nIG9mIHRoZQo+
ID4gYnVmZmVyLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHhtaXQtPnRhaWwgPSAoeG1pdC0+dGFpbCArIFVBUlRfQllURV9T
SVpFKSAmCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKFVBUlRfWE1JVF9TSVpFIC0gMSk7Cj4gCj4gdWFydF94bWl0X2FkdmFuY2UoKQo+IAo+
ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogSWYgdGhlcmUgYXJlIGFueSBwZW5kaW5nIGJ1cnN0IGNvdW50LCBkYXRh
IGlzCj4gPiBoYW5kbGVkIGJ5Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0cmFu
c21pdHRpbmcgRFdPUkRzIGF0IGEgdGltZS4KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodmFsaWRfYnVyc3RfY291bnQg
JiYgKHhtaXQtPnRhaWwgPAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoVUFS
VF9YTUlUX1NJWkUgLSBVQVJUX0JVUlNUX1NJWkUpKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gK8KgwqDCoMKgIH0KPiA+ICt9Cj4gCj4g
VGhpcyBuZXN0ZWQgZG91YmxlIGxvb3AgaXMgX3JlYWxseV8gaGFyZCB0byBmb2xsb3cuIEl0J3Mg
YWN0dWFsbHkKPiB0ZXJyaWJsZSB3aXRoIGN1dCAmIHBhc3RlIG1pc3Rha2VzLgo+IAo+IENvdWxk
IHRoZXNlIGFsbCBsb29wcyBiZSBzaW1wbHkgcmVwbGFjZWQgYnkgc29tZXRoaW5nIGxpa2UgdGhp
cwo+IHBzZXVkbwo+IGNvZGUgKGEgc2luZ2xlIGxvb3ApOgo+IAo+IHdoaWxlIChkYXRhX2VtcHR5
X2NvdW50KSB7Cj4gwqDCoCBjbnQgPSBDSVJDX0NOVF9UT19FTkQoKTsKPiDCoMKgIGlmICghY250
KQo+IMKgwqDCoMKgIGJyZWFrOwo+IMKgwqAgaWYgKGNudCA8IFVBUlRfQlVSU1RfU0laRSB8fCAo
dGFpbCAmIDMpKSB7IC8vIGlzX3VuYWxpZ25lZCgpCj4gwqDCoMKgwqAgd3JpdGViKCk7Cj4gwqDC
oMKgwqAgY250ID0gMTsKPiDCoMKgIH0gZWxzZSB7Cj4gwqDCoMKgwqAgd3JpdGVsKCkKPiDCoMKg
wqDCoCBjbnQgPSBVQVJUX0JVUlNUX1NJWkU7Cj4gwqDCoCB9Cj4gwqDCoCB1YXJ0X3htaXRfYWR2
YW5jZShjbnQpOwo+IMKgwqAgZGF0YV9lbXB0eV9jb3VudCAtPSBjbnQ7Cj4gfQo+IAo+ID8KPiAK
PiAKPiA+ICtzdGF0aWMgdm9pZCBwY2kxeHh4eF90eF9idXJzdChzdHJ1Y3QgdWFydF9wb3J0ICpw
b3J0LCB1MzIKPiA+IHVhcnRfc3RhdHVzKQo+ID4gK3sKPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgdWFy
dF84MjUwX3BvcnQgKnVwID0gdXBfdG9fdTgyNTBwKHBvcnQpOwo+ID4gK8KgwqDCoMKgIHUzMiB2
YWxpZF9ieXRlX2NvdW50Owo+ID4gK8KgwqDCoMKgIGludCBkYXRhX2VtcHR5X2NvdW50Owo+ID4g
K8KgwqDCoMKgIHN0cnVjdCBjaXJjX2J1ZiAqeG1pdDsKPiA+ICsKPiA+ICvCoMKgwqDCoCB4bWl0
ID0gJnBvcnQtPnN0YXRlLT54bWl0Owo+ID4gKwo+ID4gK8KgwqDCoMKgIGlmIChwb3J0LT54X2No
YXIpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGViKHBvcnQtPnhfY2hhciwg
cG9ydC0+bWVtYmFzZSArIFVBUlRfVFgpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBw
b3J0LT5pY291bnQudHgrKzsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9ydC0+eF9j
aGFyID0gMDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ID4gK8KgwqDC
oMKgIH0KPiA+ICsKPiA+ICvCoMKgwqDCoCBpZiAoKHVhcnRfdHhfc3RvcHBlZChwb3J0KSkgfHwg
KHVhcnRfY2lyY19lbXB0eSh4bWl0KSkpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cG9ydC0+b3BzLT5zdG9wX3R4KHBvcnQpOwo+IAo+IFRoaXMgbG9va3Mgd2VpcmQgc3RhbmRpbmcg
aGVyZS4gWW91IHNob3VsZCBoYW5kbGUgdGhpcyBiZWxvdyBhbG9uZwo+IHdpdGggUlBNLgo+IAo+
ID4gK8KgwqDCoMKgIH0gZWxzZSB7Cj4gCj4gVGhlIGNvbmRpdGlvbiBzaG91bGQgYmUgSU1PIGlu
dmVydGVkIHdpdGggdGhpcyBibG9jayBpbiBpdHMgYm9keToKPiAKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGF0YV9lbXB0eV9jb3VudCA9IChwY2kxeHh4eF9yZWFkX2J1cnN0X3N0YXR1
cyhwb3J0KQo+ID4gJgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVUFSVF9CU1RfU1RBVF9UWF9DT1VOVF9NQVNLKSA+
Pgo+ID4gODsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG8gewo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsaWRfYnl0ZV9jb3VudCA9Cj4gPiB1
YXJ0X2NpcmNfY2hhcnNfcGVuZGluZyh4bWl0KTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBjaTF4eHh4X3Byb2Nlc3Nfd3JpdGVfZGF0YShwb3J0
LCB4bWl0LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4g
JmRhdGFfZW1wdHlfY291bnQsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgCj4gPiAmdmFsaWRfYnl0ZV9jb3VudCk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwb3J0LT5pY291bnQudHgrKzsKPiAKPiBXaHkgZG8g
eW91IGluY3JlYXNlIHRoZSBzdGF0cyBvbmx5IG9uY2UgcGVyIGJ1cnN0PyAoU29sdmVkIGJ5Cj4g
dWFydF94bWl0X2FkdmFuY2UoKSBhYm92ZS4pCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodWFydF9jaXJjX2VtcHR5KHhtaXQpKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9IHdoaWxlIChkYXRhX2VtcHR5X2NvdW50
ICYmIHZhbGlkX2J5dGVfY291bnQpOwo+ID4gK8KgwqDCoMKgIH0KPiA+ICsKPiA+ICvCoMKgwqDC
oCBpZiAodWFydF9jaXJjX2NoYXJzX3BlbmRpbmcoeG1pdCkgPCBXQUtFVVBfQ0hBUlMpCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVhcnRfd3JpdGVfd2FrZXVwKHBvcnQpOwo+ID4gKwo+
ID4gK8KgwqDCoMKgwqAgLyoKPiA+ICvCoMKgwqDCoMKgwqAgKiBXaXRoIFJQTSBlbmFibGVkLCB3
ZSBoYXZlIHRvIHdhaXQgdW50aWwgdGhlIEZJRk8gaXMgZW1wdHkKPiA+IGJlZm9yZQo+ID4gK8Kg
wqDCoMKgwqDCoCAqIHRoZSBIVyBjYW4gZ28gaWRsZS4gU28gd2UgZ2V0IGhlcmUgb25jZSBhZ2Fp
biB3aXRoIGVtcHR5Cj4gPiBGSUZPIGFuZAo+ID4gK8KgwqDCoMKgwqDCoCAqIGRpc2FibGUgdGhl
IGludGVycnVwdCBhbmQgUlBNIGluIF9fc3RvcF90eCgpCj4gPiArwqDCoMKgwqDCoMKgICovCj4g
PiArwqDCoMKgwqAgaWYgKHVhcnRfY2lyY19lbXB0eSh4bWl0KSAmJiAhKHVwLT5jYXBhYmlsaXRp
ZXMgJgo+ID4gVUFSVF9DQVBfUlBNKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9y
dC0+b3BzLT5zdG9wX3R4KHBvcnQpOwo+IAo+IEkgd29uZGVyIHdoeSB0aGlzIGRyaXZlciBuZWVk
cyB0aGlzIGFuZCBvdGhlcnMgZG9uJ3Q/IFNob3VsZCB0aGV5IGJlCj4gZml4ZWQgdG9vPwo+IAo+
ID4gK30KPiA+ICsKPiA+IMKgIHN0YXRpYyBpbnQgcGNpMXh4eHhfaGFuZGxlX2lycShzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0KQo+ID4gwqAgewo+ID4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZs
YWdzOwo+ID4gQEAgLTM1OSw2ICs0NjIsOSBAQCBzdGF0aWMgaW50IHBjaTF4eHh4X2hhbmRsZV9p
cnEoc3RydWN0IHVhcnRfcG9ydAo+ID4gKnBvcnQpCj4gPiDCoMKgwqDCoMKgIGlmIChzdGF0dXMg
JiBVQVJUX0JTVF9TVEFUX0xTUl9SWF9NQVNLKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcGNpMXh4eHhfcnhfYnVyc3QocG9ydCwgc3RhdHVzKTsKPiA+IAo+ID4gK8KgwqDCoMKgIGlm
IChzdGF0dXMgJiBVQVJUX0JTVF9TVEFUX0xTUl9USFJFKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwY2kxeHh4eF90eF9idXJzdChwb3J0LCBzdGF0dXMpOwo+ID4gKwo+ID4gwqDCoMKg
wqDCoCBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwb3J0LT5sb2NrLCBmbGFncyk7Cj4gPiAKPiA+
IMKgwqDCoMKgwqAgcmV0dXJuIDE7Cj4gCj4gLS0KPiBqcwo+IHN1c2UgbGFicwo+IAoK

