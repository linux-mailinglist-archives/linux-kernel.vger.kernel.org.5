Return-Path: <linux-kernel+bounces-141593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C88A2071
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BBBAB21D37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D107A288D1;
	Thu, 11 Apr 2024 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Znc7worc";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="kSPl7WwG"
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D908374F6;
	Thu, 11 Apr 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868683; cv=fail; b=IDq6sTz38V7bXL7vDWmR2bSubxgv/ekADkZ77CN062N3bTJgCJmtZubaE55+aCayr8gpPlb2K8b1gQ6jnMWt0gorM+rOr8MgiH/qHGMwLBr610jwP0tKrjrriSnfI/N+DBAg0pjcbaDkiIlFS5FzideE73mzGFWdhaj6euf52xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868683; c=relaxed/simple;
	bh=MYlCALy4rlbEIcnHOELRR5kDbFteUxVz93290ARotE4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJFl/DstyzcRr0sL6PSbpGEGP2UQCAZFaSWxSsCJDcNSLwJW6YdfJ7EyO5QkJANmB/73pDD6PMfYPAQOJ/96X2VnSF7csX0LAbVd1u0OMlwQZ8dUZj+e3iZtTkNd4EyUMkLytmOLajo9yPXVh6toEoVj1fpjmXBR9WZ2yjuGKoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Znc7worc; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=kSPl7WwG; arc=fail smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2673; q=dns/txt; s=iport;
  t=1712868681; x=1714078281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0RHMYwMnliKkt0WIQjK6EZQNJerJxEVElXoJIN114L0=;
  b=Znc7worciYzzCALcOgKzUpigfo8p9+n7m0Za0OXSFycKiJsiMFXE9L8h
   ivOCNFpmA/NRCeyqGUd9kVe6tBoIr5ns8L0kW2L6OhbMl/Oy19FVPa80Y
   iX93jTQXhRgqClxt47Bcqk0Zmc+Cx7PYO+c9yvH/eO8KzpMIHMsjUg5aG
   w=;
X-CSE-ConnectionGUID: eZHHsDuvTkKYSRduwsf63A==
X-CSE-MsgGUID: wMSTIQnXSWCX/AMysNbvaA==
X-IPAS-Result: =?us-ascii?q?A0BdAAAlTBhm/5tdJa1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEXBgEBCwGBcVIHc4EZSIghA4UthkqCBR0DhXqMZ4sngSUDVg8BAQENAQFEB?=
 =?us-ascii?q?AEBhQYCiBYCJjUIDgECAgIBAQEBAwIDAQEBAQEBAQEBBQEBBQEBAQIBBwWBC?=
 =?us-ascii?q?hOFOwYsDYZZAQEBAQIBEigGAQE3AQQLAgEIGB4QECElAgQOIAeFGyMDAaVJA?=
 =?us-ascii?q?YFAAoooeIE0gQGCCgEBBgQF3XUJGIEwAYgrAYkYgR8nG4FJRIQ/PoJhAoFgh?=
 =?us-ascii?q?kOULoI4gXCIfFR9HANZIREBSwo0CToPDBoCLw0kIwIsSgoQAhYDHRgyEQkLJ?=
 =?us-ascii?q?gMqBjYCEgwGBgZbIBYJBCMDCAQDUAMgcBEDBBoECwc4PYF+gT0EE0eBQooXD?=
 =?us-ascii?q?IMzKYFQKYESgy1CcYQgdwNEHUADeD01FBsGIgGgMWiBVAKBDhUIEV86lXmuB?=
 =?us-ascii?q?YE8CoQTog2Dcox+mTGYYqM8hR8CBAIEBQIPAQEGgWYDN4FZcBWDIlIZD4dFh?=
 =?us-ascii?q?luDep5qeDsCBwsBAQMJimgBAQ?=
IronPort-PHdr: A9a23:rVPPcBKK4aIq3MRqstmcua0yDhhOgF28FhQe5pxijKpBbeH5uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1o2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gKu3zG4PWkM2f3OGp8JqVaAJN13KxZLpoJ
 0CupB7K/okO1JFvKKs61lPFo2AdfeNQyCIgKQeYng334YG7+5sLzg==
IronPort-Data: A9a23:hAYFY68t+PX1ubd87wReDrUDgX+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 GseCz2Ha/eIamTyKtB1bI7i/RgP75+BnYVlQFY4pC1EQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmB4E7rauC4xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4utyyHjEAX9gWIsbjtNs/nrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2k7D6044cpqH11N1
 s0jEjwQcQuN2bmflefTpulE3qzPLeHxN48Z/3pn1zycUbAtQIvIROPB4towMDUY358VW62BI
 ZtCL2MyMXwsYDUXUrsTIJ43mualgmb2WzZZs1mS46Ew5gA/ySQrjOiwb4CLK4ziqcN9gWOjm
 kP/+VTCPToqc/W62CGj+Gylr7qa9c/8cMdIfFGizdZugVuO1ikQBQcQWF+Tv/a0kAi9VshZJ
 khS/TAhxYA29Uq2XpzxWBaQvnGJpFgfVsBWHul87xuCooLQ4gCEFi0HRCNAbNAOqsA7X3op2
 0WPktevAiZg2IB5UlqH/buS6Di1IyVQcSkJZDQPSk0O5NyLTJwPsy8jh+1LScadptb0Ajr3h
 TuNqUADa3871KbnC43TEYj7vg+R
IronPort-HdrOrdr: A9a23:Z83XeK0d1R1bCec+77g2nQqjBcBxeYIsimQD101hICG9Lfbo9P
 xGzc566farslcssSkb6KG90cm7LU819fZOkPAs1S/LZnimhILaFvAT0WKE+UyhJ8SezJ8S6U
 4ESdkdNDSeNykGsS+X2njeLz9k+qj4zEnKv5ac854Od3AXV0gI1W4QYWjrdzwTeOAFP+tHKH
 P23Ls+m9PUQwVsUi3NPAh/YwGsnaysqHvOW291OzcXrCO1oXeD7rn8HxKE3hEYfQ9u7N4Zm1
 TtokjS3Inml+u05CP9+gbogqi+nuGP9vJzQOi3zuQFIDTljQilIK57XaeZgTwzqOazrH43jd
 jluX4bToFOwkKUWlvwjQrm2gHm3jprwWTl00WkjXzqptG8bC4mCvBGmZlSfnLimg4dVZBHoe
 V2NlCixsNq5CD77XzADh/zJkpXf3+P0DwfeCgo/iZiuMUlGeJsRMckjTBo+d87bVfHAcYcYa
 tT5AW23ocITbtcBEqp4lVH0ZiiWG8+EQyBRVVHssuJ0yJOlHQ81EcAwtcD901wua7VZqM0rN
 gsCJ4Y3o1mX4sTd+ZwFe0BScy4BijERg/NKnubJRDiGLscM3zAppbr6PFtjdvaN6Ag3d83gt
 DMQVlYvWk9dwbnDtCPxoRC9lTITH+mVTrgx8lC79xyu6H6RrDsLSqfIWpe3/eIsrEaGInWSv
 yzMJVZD7vqKnbvA59A20nkV5xbORAlIYUoUxYAKhuzS+7wW/vXX7bgAYLuzZLWYEEZZl8=
X-Talos-CUID: 9a23:/f+9PWOKlqpHbe5DVRtH1FU4B94ZcV7s903cPlCjBzgyYejA
X-Talos-MUID: =?us-ascii?q?9a23=3AkAFC1w6UdNHs0zPZosuLT2qyxox3xp+SKXkLoa4?=
 =?us-ascii?q?5kPnDHAlhIBGXkj2eF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by alln-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:50:12 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 43BKoCMf017551
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 20:50:12 GMT
X-CSE-ConnectionGUID: iCldI+7MSlObFcuUkv1rVg==
X-CSE-MsgGUID: PlQBTivDSmiqD1/L50ARXg==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,194,1708387200"; 
   d="scan'208";a="12154484"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:50:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuQ+YCDVIIJvQ71Lw23Fueo9YAMALFJL2IjretyY23B11B7yaq4ZnQ7wTDQPkpXygN5Ipy7qIXiJYYWgvGLul2+ugQKg3k2scTGYNWTN9MVFf0Nua1cr1cOzioOk2nZcyKnPEjZPp/WPhxgyL6LWHwS7n5SZM36tSF5Agh9EccDH1+DvRoAL1GeGlhBagaw621ttqhrCT1XYfuTvdBo/3YKJ3YwbAoyohFx9gAcYPc8WsjlfCqV3YN3X217z6vf3OhXo3exGXO+Wg+p6cKFbNo5Q4CongVLMb7XaoU589vCs/KOYeG6R5jRzEpx67ycEZC4zo67M4apzK55uTx/bEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RHMYwMnliKkt0WIQjK6EZQNJerJxEVElXoJIN114L0=;
 b=HcVAFfLYzGKYB0OkniBJetE/gJLx1g2Ib5Wtnhgbf6XUUOuA3fS9c9ZAy4Rux2Q9h1jgg77V2Jel+XwsrBO4/KDnZdgKNh8I2tSDT3Gw/vl+WDH0KH4nTvONkFkqO6LVQpwZzMYvtFIpyAU4WELidi9EtQ90JwI2fX4p5znR5I9/LAvQg8iw8WjXfgZUvxwAq3dVViLGgw1kxfJAiculc2eTOUO8HgK6q1AoTs9nQJUKdmCGyk++vRnjfpnmNyrmZu1dhAEKGO3zRuf38yu14Wj7AYW/3v6p4sTVhrq9VAY2oQ98iUKFDqnbamz6O4sq3Yq6y2pQTpaOguf7NKMfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RHMYwMnliKkt0WIQjK6EZQNJerJxEVElXoJIN114L0=;
 b=kSPl7WwGb9azTYuuBKZATGXV4oy+ilsc6ZEZB8F/ZWCATogmgyts9LCCynNcG+9AZ2O1pw68NJQg6eroHaZPtGrb1stEY5iWDxKx4UYvbWAMjR6x2PHj+sSdmZCttcCm8+FDxxilzy5eDo/UEJ7ycTecpmT3T3zb99x4iuESa2Y=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by CY8PR11MB7033.namprd11.prod.outlook.com (2603:10b6:930:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 11 Apr
 2024 20:50:10 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::22f4:4617:117:7a44%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 20:50:10 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Nicolas Schier <nicolas@fjasle.eu>
CC: Nicolas Schier <n.schier@avm.de>,
        "Valerii Chernous -X (vchernou -
 GLOBALLOGIC INC at Cisco)" <vchernou@cisco.com>,
        Masahiro Yamada
	<masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        "linux-kbuild@vger.kernel.org"
	<linux-kbuild@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Thread-Topic: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Thread-Index: AQHajDWPNw0w9AAG+kK+xjeBwf3pzA==
Date: Thu, 11 Apr 2024 20:50:10 +0000
Message-ID: <ZhhNAQtV3StbaA4z@goliath>
References: <20240405165610.1537698-1-vchernou@cisco.com>
 <ZhfLrGrED-ls6i5V@buildd.core.avm.de> <ZhgdjpE+yl3IYSzl@goliath>
 <Zhg5L2xO_lT4lLwp@fjasle.eu>
In-Reply-To: <Zhg5L2xO_lT4lLwp@fjasle.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|CY8PR11MB7033:EE_
x-ms-office365-filtering-correlation-id: 00b69a47-698b-44f6-7794-08dc5a68fa3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pv4sNlvlHtqk3UW6cxdi1/WKEejkAz3ry9a8CRYyDH1csTXK0LCtqhk66IuiEj4ocFQIQfBzZ0nBcQ4fs4e2ay46mv31xKe656/EiJLZClvnleiqVstY/gbPKsc6xZEgrtd0iLELwPbGY/s2f8iaFIXscuJBzoPLVLJ+Vclj8NSTCtE3na0VkvHsL05zKp4GkMkpkFPKfcndKiplRUlDuwrxSvTXL+//QMUMBMeFTcQJCU6PofM2TTfZ/MkoA71L68EQdQV06Zqq9IsfdcVM76dwbOvRb5JqhC3jLFy8RcX/JJ6yu2eVuhijjL/8YsTX0JAc6RsAX+FTZoSay51SPxrZtLrNY0WeWlr5Xs+CwVEPbq7wqfJcNp/BxvXKM4JfguPAk5dw+UsY7t738+h/f5aWIwKMpmJr9kfmw4OFrJssmdcOAFl+JgGPWwI4XqsLKe4Y2stiRNtaRCU2Ei2FbpXNN4YX0HQf0IwSnCc+09orTrjyOK1Y9zAL4UFkbe45eOmTgR5htROFKd/06ttdU2iJhuQmG3qSDVqIephAQ/kZm/euhwpxHFxM7YpYBGf7Ks6FLSGCHKP8YYi+2yERkNc9NIwmh4SHXyiOBas55+E5ay+InLWPtGDhdSfcDHxiB0giSd4pryEt/9OomRJDYjJtHL6t//h6vOQL+jIshb+HS/HxiXQdevJyf3I5Eytl/JCazLjI8fOOKOvYRPhRx2qq1twcbuDVCVPH31DxEQI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GL9ZhypGj6V8keMO7MCOPFitegp1Z8LIViGdgr6PBxwIU+lYXWlQbtMNhgxd?=
 =?us-ascii?Q?RzMnoO16S58LYj4RmmkBAGfPGX0cvv3Gc+Zxcd5VWMwivR7OGrJnnIJhpjoP?=
 =?us-ascii?Q?lOQUTv0Qu0chAlZ4VK3meeKOsVd5d+yu8bF0zp0UQFp/tkf6UOY3AXuGdy0m?=
 =?us-ascii?Q?iyzYb3J6oIrU/xM51SO1uC6GWBXcAN6Wr3NDNR8fbwc5leIIv6DkSY+2Rg7J?=
 =?us-ascii?Q?KboXYnBbOvy0gO/OGTkFapeq73S0FpC9yRWlNE/+SGtcvIEN9ApmDAgVfiEO?=
 =?us-ascii?Q?rdlfPABYsK3gNMUT64BdUf/c87BALFf7SdFfHy+6+sSE3R9qQDUILnEKpdCH?=
 =?us-ascii?Q?cBFzeJF10+/dv5JiFnKYYtC4Oq4tLRDB2D26otsjWG0KUAmtli7PDp9rzvG/?=
 =?us-ascii?Q?VrWyaspn47sos9xt8grfQEnrN42jeJIwlkYaxxuQfB1bbTYWTwlZWYT9TwsN?=
 =?us-ascii?Q?UI+5nwfx164zSayI5Vywyv7lb1pdj5+mnnXqXGF9I3A/fvX2fMU962jp7L/n?=
 =?us-ascii?Q?4KZec0NKEWGsdrlrV766CAKV1nnfW3ybcU0dapkj+2qrDOCZbCQSM9Q8JT+g?=
 =?us-ascii?Q?Rxd/GjSTyWVixxXimyFjxdCLpZcAeKSV1bD5OCW9IlutBzA6+gzep7NTszlZ?=
 =?us-ascii?Q?fDh9zFzXxXNYrpT7LbEQzyy7T09P4aeMqz+rKXrHVpbZC+KH9+zlyU0CqlLK?=
 =?us-ascii?Q?LPQgaKkD+RoLEesqXcO4VCXLo46tSS7q9R3mxm9Pw5Ud1xp/9GWd+KzU4agX?=
 =?us-ascii?Q?7PbPctSwA9JrvwJwlmjVK/1fUvLH/xGAC7TnhmVOrRu5NqEYUuWc5Gpt7/LB?=
 =?us-ascii?Q?v6NTGug7uKS3q4g3DGw+E7tyyEhKg5KyYO/w4lEQOjVmq96ugysBDm2sIBYI?=
 =?us-ascii?Q?pkiffXB/ePgP9zpWFreCM07tBLeftw01lPkNYJgwXCwH82W39Qgr4kye+QJa?=
 =?us-ascii?Q?PBCPtqSlAzeE7iC4WM4RvocbyEfMsS0GA3UCF7BVClHyRx2nCCeHVLbo8tAU?=
 =?us-ascii?Q?aS8tX7bXVDbe9mDGvsW6XTzxoqngbjQI9n+sGi6SmvUWhk7v94S+lE3Djkv1?=
 =?us-ascii?Q?zqjf+E2vEaTU+FRaH0XCDX3amRw7nmRd7eLAps42yTT9i9t+kgXMPAuYMQBR?=
 =?us-ascii?Q?aIqtwjDDZWPiV1jKBF77C/NRNOF44ycuElJ9vQt8AfGX6My0IVY4WDi1HENQ?=
 =?us-ascii?Q?xl4nwfTZUXcEVTQxs3kJLpNQtZ2KT/4wljkK5g8cdNeZTMtqt3G0SlhRUqy/?=
 =?us-ascii?Q?I1ND5qfKHqVtAwMqAj6RivbRQmvy4U2wnFZVG5+MWQo5PPPOctpi3ttZ9wU4?=
 =?us-ascii?Q?bKOny2SAKO3gC49YkiVRifkmFu3mufPAzhnza4BkVU5oN8LVXU3yno5GEM03?=
 =?us-ascii?Q?ZiHuJmux5Gf6WJvl0ozyFUT7+6Q/5O6jQv8ZH3tkjbvdgUVcIA0cg/d7Y/mS?=
 =?us-ascii?Q?trIw/VFiFW90N65QUb03eyZQa3U1EIo4sdsnpcNaiXffWDjjGRRMRpDsMbe8?=
 =?us-ascii?Q?ncFWleQGufRBhagheg7rSEjMDSPM862msdH3dus+Jj3iKIJZSxyRqLG0KFr7?=
 =?us-ascii?Q?0cm1xGx3+k6uyEmCF2+f3tDrmuOX55QQUzUCmigUHg23ZLCiQOn1PvLxCEej?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EEFFCE411ECB6A4C95B20C89C9C0B45B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b69a47-698b-44f6-7794-08dc5a68fa3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 20:50:10.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luyQLWHg0w/4OMPiMbTk5m1yJ4BeJIKmCuqpx3mINmqzIjSRwcBgcbvPRELGeR0r9vBjPB9YkuaAT92NWc0M7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7033
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com

On Thu, Apr 11, 2024 at 09:25:35PM +0200, Nicolas Schier wrote:
> On Thu, Apr 11, 2024 at 05:27:42PM +0000 Daniel Walker (danielwa) wrote:
> > On Thu, Apr 11, 2024 at 01:38:20PM +0200, Nicolas Schier wrote:
> > > Hi Valerii,
> > >=20
> > > thanks for your patch.  I know several non-upstream kernel developers
> > > that would like to see support for out-of-source builds of external
> > > kmods (and we developed several work-arounds at AVM as well); but ple=
ase
> > > be aware that patches that don't fix or enhance the in-tree kernel/km=
od
> > > build but only add feature for out-of-tree stuff, are rarely accepted=
.
>=20
> "out-of-tree stuff" was meant to be "out-of-tree kernel modules".  "Rarel=
y" was
> chosen in explicit contrast to "never", but to hint on my personal expect=
ation
> regarding the probability of acceptance.
>=20
> > If that were true we would not have driver/uio/ for example. It seems l=
ike
> > Cisco and NVM should work together produce a solution.
> >=20
> > You could run into this issue even with entirely in tree modules. For e=
xample,
> > we may have a v6.6 kernel but we need some modules from v5.15 for some =
incompatibility
> > reason in v6.6. Then we may build the v5.15 modules as out of tree modu=
les
> > against the v6.6 kernel.
=20
All problems should be fixed or worked around. One bit of code maybe isn't
the best choice or maybe another is, but not fixing or working around the
problem is not really an option.

> If your in-tree module in question does compile and run properly in v5.15=
 and
> in v6.6: why don't you just compile it in-tree in v6.6?  Which driver/mod=
ule do
> you refer to?

I believe it was this driver drivers/crypto/marvell/octeontx2 . I don't rec=
all
every aspect of the issues but it has to do with what Marvell supported in =
their
SDK and the exact hardware we were using and the bootloader we had on the
product.

> > You also have just normal developers making kernel modules which always=
 start as
> > out of tree modules before they are upstreamed. Those modules could be =
any level
> > of complexity.
>=20
> I do not agree, but there is no need to convince me as I am not in the po=
sition
> to decide between acceptance or denial.  I just thought it might be fair =
to
> warn that I do not expect acceptance.

I think it's incorrect, unhealthy even, to look at it that way. If your usi=
ng
Linux to make a product and you have an issue, it should be consider as a r=
eal
issue. Not something maintainer can just discard. Unless the maintainer has
a suggestion to do what is needed or different code to do it.

Daniel=

