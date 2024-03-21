Return-Path: <linux-kernel+bounces-110695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEAD886288
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4302D284808
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3913665B;
	Thu, 21 Mar 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b="IKTEuI68";
	dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b="B/h5y+tq"
Received: from mx0a-00183b01.pphosted.com (mx0a-00183b01.pphosted.com [67.231.149.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8E13475F;
	Thu, 21 Mar 2024 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711056437; cv=fail; b=FeUfDqEXHkFxcuUVKc9fIoyz67E1af6/oflLHTDKj6qB2eNySGfJx+MX3TCcgA7K6zcmfTDuN6zIZZiuAiyjMcs09tXOqHX+obTSeW7F1BFmemS6n1UHjEqwEBnlj/WaLKLpoCO3XZZ2zDtv/zel6dJrNYp9PA5pb/gfMS7lcr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711056437; c=relaxed/simple;
	bh=h7R8RKFuv6IFEOuqVSGiWfTob3Y66IJ6osTp7tX4hgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SoESkvQP8koY9rtwkKuM+E+W7AUitDjsRyDiHhOIWTNVqJH5elh+fus1ST6BhaToJpkQWAjVGo84UiF/lr1ZAczAKELvj6ZpWgdGcIh8S8CdwUUa7f8mpfScYRoTB+vAg7dZtjBBBaoF0lhbwZsSdO56fUk/shrkW4Lif2NQ2LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com; spf=pass smtp.mailfrom=onsemi.com; dkim=pass (2048-bit key) header.d=onsemi.com header.i=@onsemi.com header.b=IKTEuI68; dkim=pass (1024-bit key) header.d=onsemi.onmicrosoft.com header.i=@onsemi.onmicrosoft.com header.b=B/h5y+tq; arc=fail smtp.client-ip=67.231.149.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
	by mx0a-00183b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LCoTdP018782;
	Thu, 21 Mar 2024 13:04:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	pphosted-onsemi; bh=h7R8RKFuv6IFEOuqVSGiWfTob3Y66IJ6osTp7tX4hgc=; b=
	IKTEuI6865mWhekd6/INp8yi1XjN+lSBcECONQLlJH7v+3BTqWsQrbIVFHc+7tXK
	o/Vw0ZHp0VZNY1gtGXOf3NVmldUfLZ4ktC3a/BSlhHtiSQe3U2VYeJpDAissIdCE
	bNzS4WERZcQD5IxVuHjMC51BdPItf6t05zQgLFKMeS92GVUM3GBdaknv8dUbm32b
	mx33JJEXZ/Zf2oe3DLeIKvC/uYSOVMM5kj6hSIwvCQ9Z2CxOfE0C7Jvm+UReXT3d
	Y/ngZYOtWK9VDjM8GQVh4PPflvoCbxt7M463pZbilKpXKW6U+J44PoRLQsCF7Kox
	9dtaKISkZ7tmKZlwQoc7Pw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0a-00183b01.pphosted.com (PPS) with ESMTPS id 3wyj8gnrqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 13:04:27 -0600 (MDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHrz7W9gH6SEs5kVqKooNN2BON+ZQ0vqESICvhomtal9+NG6qNFVAPz9YQN/Fwu/WOfncPyzIczRT02e30T5DKbG2JekX1etUAUsVofN5kIti+l8rpIwh+YvSNSDt5BH3Xyx+f4z+CmC8FrQoKN72mrtvsOTds+IXrN3QnIiogeTZOZntIKAz5Fcn3E9c46WQN5OJiRt/+D6bsUMPWIwR/GX4eF7UfYwgDF5rarQrAsshPpWnmsMbP2MH1+W5BWaARg+QC0fkJotnzEH/7d8FX1cfVH/o3H/2xk/afRQfkCnkRBplq/MJjSZtf8/0XYe1ee92jSYcfMRSglloSJlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7R8RKFuv6IFEOuqVSGiWfTob3Y66IJ6osTp7tX4hgc=;
 b=TVegXIqfcMITW2pvWJdb2xwC4mFZDSxGkQpLqCWvmBUszekOORkWMJDqCs8ZGZKJw0jhpvu4OoMwDXWUFHr/DCBsNMtfNyVNrUXuOSJ0PoBVvBoaXBkxvpU9TGgmqUjISTI6WFPcHcrrzlcA+rvSlVwbQMIhYZeKg3q52XyDsFsLJMQ7rr9h/ZEOss7PPeSDjjO7GnRE7TfcMc5RbWVNP69x+KnHqz2fKRWv4cHJWKuUG2MUKCNzzGEckprBm3Bar/XIDpjxOCnI3zmYtRtLR92mMofBS1GJSHopmqNYC0fEid1LHA5lhIMH0noOB6p9JFINGupZmGobPmru5tdLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=onsemi.com; dmarc=pass action=none header.from=onsemi.com;
 dkim=pass header.d=onsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onsemi.onmicrosoft.com; s=selector2-onsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7R8RKFuv6IFEOuqVSGiWfTob3Y66IJ6osTp7tX4hgc=;
 b=B/h5y+tqUHHfggMltk+4XYQw+FQhflhtWnemJ7KIboh7VJCMVuzXgAYQP2feVkmxaEdmp3bFIr5zNayYkK7pQCADA73PqrpSb9UHMkjoL60JcVK2QT/BW9tolrPn1E0lI8xuENgzLS34/CO0YbaBHRTSZsY8ntJOiPNfWas9RLY=
Received: from BYAPR02MB5958.namprd02.prod.outlook.com (2603:10b6:a03:125::18)
 by CO6PR02MB7731.namprd02.prod.outlook.com (2603:10b6:303:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 19:04:24 +0000
Received: from BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::644a:cc48:bf3e:9a0b]) by BYAPR02MB5958.namprd02.prod.outlook.com
 ([fe80::644a:cc48:bf3e:9a0b%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 19:04:24 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "Parthiban.Veerasooran@microchip.com"
	<Parthiban.Veerasooran@microchip.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Horatiu.Vultur@microchip.com"
	<Horatiu.Vultur@microchip.com>,
        "ruanjinjie@huawei.com"
	<ruanjinjie@huawei.com>,
        "Steen.Hegelund@microchip.com"
	<Steen.Hegelund@microchip.com>,
        "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "Thorsten.Kummermehr@microchip.com"
	<Thorsten.Kummermehr@microchip.com>,
        Piergiorgio Beruto
	<Pier.Beruto@onsemi.com>,
        "Nicolas.Ferre@microchip.com"
	<Nicolas.Ferre@microchip.com>,
        "benjamin.bigler@bernformulastudent.ch"
	<benjamin.bigler@bernformulastudent.ch>
Subject: RE: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Topic: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Thread-Index: AQHab6OUNkEIC/2nOEKl31mx3SAVeLEshPoAgBKU6ACAAAbvgIABZr4AgAIaygA=
Date: Thu, 21 Mar 2024 19:04:24 +0000
Message-ID: 
 <BYAPR02MB5958A04EF61FF6B7512CE7EE83322@BYAPR02MB5958.namprd02.prod.outlook.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-9-Parthiban.Veerasooran@microchip.com>
 <208fb61b-4740-46bf-8c70-29ab59cbb965@lunn.ch>
 <f9d8a18c-b1fe-450c-a5ca-d91f96793a04@microchip.com>
 <96dd422f-0bf9-411d-8cc2-5755c1e60e27@lunn.ch>
 <53b090b1-d7bb-4a81-9f0b-9979db8dec59@microchip.com>
In-Reply-To: <53b090b1-d7bb-4a81-9f0b-9979db8dec59@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5958:EE_|CO6PR02MB7731:EE_
x-ms-office365-filtering-correlation-id: a0e59f9e-b278-4f70-4804-08dc49d9b917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 wRjbS6xoRJkSyzv3adwJgqJRefwdbGhbg2KuQey/n5HBlbpbGFAcPIsJoKw8a71UcmgRd6s4+Z5appkEw3rgb/jmL4ThRQNRU9bBbVVMSu6MlpnFNcSKb9t9FYHKjBEP4CejY6Dcvq9lL8SZ4Ukd6y+LX85wTJUYpyl8m6na+OkHZnK+3zPCsI5r0YXRmo7JizU91YOrIOGp8AI3Hmklcd4EewimrcJvsFHGzcC5UeoPPzOYdimDJbg0E6++D/KpfjXVFurN+hz7lAU4WTigEXkf8xg81qEzK7ClZo/bQ71BfGntjSY/QM3qHZo+2s0+xKPb86iZH8OuPZBOXcXtOwVYypzlt43Xty8L9KZtgApBW/y2mlWjqQADEqrHArtd3b05a788Cyb7OjnvE6eEvS+GY3DMFskmBw1/oT51k/H3C4ssu5EL3NisTSXADsFrQITVFRkgpUwhxk0n4vVA3N73+YWiId9obPz7GpEu6OPgrcRQteE6+esqJOnvT1kRS6Vlt8kIoLNk65LP13x+qFR053E+luchY7jTiY9uicIsliEkLrZeFPeJa6SsQb8h/HsFcYrhjN9qZOCbo6ameDEbhjEOFHAoztXZ7meMi6MlH6NJCHYJue/kL/uSBb6R/IKpJZQkTViKZaQglEWOUFKykqRtBpkWvig/cfGpJ/f3jHMC7wF+9BspUXwm0Q73tZ0h+5oQRndY0dSifiuVC/TJI50XeafVM9WmwUOStZA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5958.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Um9tRldRcThJVmVnU2RvbE54QmMwUVVSbXZscUZZMUtXSm5XMG5XbHV6VnMw?=
 =?utf-8?B?UmtJbjNOQ21EeTVZSmFIbjh6elRIMGE4Yk1YMm5zVi9hN3FnWUtYcm1peUln?=
 =?utf-8?B?T0ZmdE9jbGtvbjJkOGN5dCtQaVh5MFJnRE52WXVuUlAvcDQydFJBeDJhUzRk?=
 =?utf-8?B?ajJnbVkxajVLR2hxY1AxRnNWVlp1Sm05VXZIVkQwT1k0WE9ndXg4bWhxbXBK?=
 =?utf-8?B?c2RMT2RTT2poamRJYnZZS1Jsa0JWMmxzNjUyKzJIVzNweW81ZXVoaUlkMktC?=
 =?utf-8?B?TUREV0F1a0piVUhBTGR5b3hkQk5CNmJRT0VXUkRtMjZYb05kM2hWYVR0RVI2?=
 =?utf-8?B?VFEyMUJQRzBMWUY1bklBSnBpUlAweEJHSElRR2NNR2VES3ZOTDhLRUNaVnVo?=
 =?utf-8?B?T3FaV3pEajVtS003Z0ZjdTNCZDRFbStkVlNBNERNSTZ4QkNoTEo4MmVBeTJ5?=
 =?utf-8?B?OEt6Q3RKYlZhT0ppTEVqcWxqa1JjdGJQNmJuNkNPZDFicXZtVGEvdWxZUjNT?=
 =?utf-8?B?dlRTS2RNRWdMby9XaFdiUXBPRWNSY2pIdXk2bmlDZ0hrQ1VJWWFPQ3doMUJT?=
 =?utf-8?B?UXZqVjBKWnNhaGY5UzlSUHJpSWdIMjQ1Qjl5UG0zUVkvK0hNdFNRK1R1UWJw?=
 =?utf-8?B?MWQwUnZhcUt6eXAyMkRtWlRiWkNqcjE0NVZtYXJNdmNVRVd0bGZnUmpKd252?=
 =?utf-8?B?UXdwUURaeFFjSkNsR000UE5WOEhpVnNKenB6eFY4NSs1RkNQMEdNSW4rOUNk?=
 =?utf-8?B?RTI5MlkwNXFqL05tQzJiZjhPd0I3bWxCUmd0dVhKTG9NdnJjOHFDZ1VuT1o4?=
 =?utf-8?B?Yjk0bnIxM0sxQ3Jjd2w3cXZCUURJd2JKWWZneGJ1TWh5N1NwVElMRlBWYmZq?=
 =?utf-8?B?aHZNeTJsd21WOUFVY0Y0UkZSWlMzV29mRXdKV0l6K3FBK2prZHhmQ3R4ZkNO?=
 =?utf-8?B?ZWc1UHFJODlUMklnUnowbGxveVVKT3I1ZUZmcmhMWXVMQ1Y0V3J1VHJBSFlo?=
 =?utf-8?B?VFQzZXFxZXJzZGdqejVUdWwyY1RnbWxidWI1OFhTWFZ0ZkxZZEU4THpmU0do?=
 =?utf-8?B?UVpxdDRvYnFpanlQTWNWaituTlZyanBubnJld0Q2aStRa1Q1c3dwdkZyOXBp?=
 =?utf-8?B?RjM5a0ozNzNhKytEYmFMTWpIZU14dEFNTkhnSHNCbWQwWGRqL1N6WjNGRGhv?=
 =?utf-8?B?cWdmbzRJVGxxMHNZV2JzSWVqTUF1aldUaFl3WlR1WStrMHhSaG1abEordGhH?=
 =?utf-8?B?L3FwNzJadjJ6OURac25kQWF4WktON2tKRDBidXZLaEZLNm9uZnFKNTF1eHEr?=
 =?utf-8?B?T2tkK09HUERrTkU0YTRQS2xqVGZzcmdTcUllKyt0V21pb1ZLd3YvUnRVejNG?=
 =?utf-8?B?V1hOQ21lVERYTXdoQ2hyR0R3dGlqTzJ0M1dXUlN6S2tSNnVodyt4dmlQMncz?=
 =?utf-8?B?Q1psQ0pZajdyaFo0aHkvdytuOU5NWVp6YjFkbjQ0RVNkSDNXeTdxY0dPQmxP?=
 =?utf-8?B?WE0yeHJuY3RlNHlLWnY3b24rZWVzRnRYV0x5UUNoQ3pvdW9KYW0zd2J6MTZC?=
 =?utf-8?B?QVhtTjYwOE1QaWNpWS9Gd1N1Y0xXeHM3VTZUY1cvMklacXcyVS9aY2lHNWFQ?=
 =?utf-8?B?RzgwZzI4SVlZL05pcDArblZ3RFpqSDUyTjUrTkdyc3F5RDNoUHdGSnNOZ1N0?=
 =?utf-8?B?Y3c5OVRNR042ZmdMZHcyckVmYXh3Vnc5bm5YRTBLZjk5VXplOGVTREUzU1A2?=
 =?utf-8?B?eTlXK25BYi9XcS81YUl0NW4vYzUrd0pwZEhsQkljdGd1S2lmVXlCVGl3ZWlZ?=
 =?utf-8?B?M2I3WnVaZy9JeEpuUTUreVcxSW96SERMZWMrb1FJSWxEZGN3MG16TFlySUtV?=
 =?utf-8?B?Y2NoVlRCamxoWFZvNWJoMkxNSEpSVjU0cVJ0L0JIeHdZelRsVkJaaFFwbk5y?=
 =?utf-8?B?cFlUOHhhZnQyTEp5RmZjVWZSNzBaYXI2L1haVm9XdWF2WW5aVHo1NkY4MzNE?=
 =?utf-8?B?clR4R0xCNElKYmxEY3o5TTEyNEozOVlySER6YTVGL1YxczBOYVd5Z1RvNlVP?=
 =?utf-8?B?QlVyRlR6cUpBWmt0bHFtbzFxRVJ5SExPREgvM3p1UzZEZ0hTNlNzc1pYK2hH?=
 =?utf-8?B?K0RDNks1eE1HZGdlRVdPK1lhdklnUDBncGhma3NYNHpXNDdPS3crZE1hOXVn?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5958.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e59f9e-b278-4f70-4804-08dc49d9b917
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 19:04:24.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eahHp7yfCZ9mbiD+LBmfQbMQXuWV6cmV8qOvsaMGx0sf7dryDyNQcia00NvIZdZly2OdR1mPGsNKI2AgXVMYiy/dl2EX2MI5BwwpG0MwILE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7731
X-Proofpoint-GUID: hrKW7ukQqKYuPb50GSwIU-9_lV1NYyxO
X-Proofpoint-ORIG-GUID: hrKW7ukQqKYuPb50GSwIU-9_lV1NYyxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210141

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFydGhpYmFuLlZlZXJh
c29vcmFuQG1pY3JvY2hpcC5jb20NCj4gPFBhcnRoaWJhbi5WZWVyYXNvb3JhbkBtaWNyb2NoaXAu
Y29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDIwLCAyMDI0IDM6NDMgQU0NCj4gVG86IGFu
ZHJld0BsdW5uLmNoDQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUu
Y29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyBob3Jtc0BrZXJuZWwu
b3JnOyBzYWVlZG1AbnZpZGlhLmNvbTsNCj4gYW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb207IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBj
b3JiZXRAbHduLm5ldDsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJu
ZWwub3JnOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBIb3JhdGl1LlZ1bHR1ckBt
aWNyb2NoaXAuY29tOyBydWFuamluamllQGh1YXdlaS5jb207DQo+IFN0ZWVuLkhlZ2VsdW5kQG1p
Y3JvY2hpcC5jb207IHZsYWRpbWlyLm9sdGVhbkBueHAuY29tOw0KPiBVTkdMaW51eERyaXZlckBt
aWNyb2NoaXAuY29tOyBUaG9yc3Rlbi5LdW1tZXJtZWhyQG1pY3JvY2hpcC5jb207DQo+IFBpZXJn
aW9yZ2lvIEJlcnV0byA8UGllci5CZXJ1dG9Ab25zZW1pLmNvbT47IFNlbHZhbWFuaSBSYWphZ29w
YWwNCj4gPFNlbHZhbWFuaS5SYWphZ29wYWxAb25zZW1pLmNvbT47IE5pY29sYXMuRmVycmVAbWlj
cm9jaGlwLmNvbTsNCj4gYmVuamFtaW4uYmlnbGVyQGJlcm5mb3JtdWxhc3R1ZGVudC5jaA0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYzIDA4LzEyXSBuZXQ6IGV0aGVybmV0OiBvYV90
YzY6IGltcGxlbWVudA0KPiB0cmFuc21pdCBwYXRoIHRvIHRyYW5zZmVyIHR4IGV0aGVybmV0IGZy
YW1lcw0KPiANCj4gW0V4dGVybmFsIEVtYWlsXTogVGhpcyBlbWFpbCBhcnJpdmVkIGZyb20gYW4g
ZXh0ZXJuYWwgc291cmNlIC0gUGxlYXNlIGV4ZXJjaXNlDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5n
IGFueSBhdHRhY2htZW50cyBvciBjbGlja2luZyBvbiBsaW5rcy4NCj4gDQo+IEhpIEFuZHJldywN
Cj4gDQo+IE9uIDE5LzAzLzI0IDY6NDkgcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPiA+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cNCj4gPiB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4NCj4gPiBPbiBUdWUsIE1hciAx
OSwgMjAyNCBhdCAxMjo1NDozMFBNICswMDAwLA0KPiBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWlj
cm9jaGlwLmNvbSB3cm90ZToNCj4gPj4gSGkgQW5kcmV3LA0KPiA+Pg0KPiA+PiBPbiAwNy8wMy8y
NCAxMDozOCBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+ID4+PiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiA+Pj4ga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4+Pg0KPiA+Pj4+IEBAIC01NSw2ICs3NywxNCBAQA0K
PiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChP
QV9UQzZfQ1RSTF9NQVhfUkVHSVNURVJTICpcDQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgT0FfVEM2X0NUUkxfUkVHX1ZBTFVFX1NJWkUpICtc
DQo+ID4+Pj4NCj4gPj4+PiBPQV9UQzZfQ1RSTF9JR05PUkVEX1NJWkUpDQo+ID4+Pj4gKyNkZWZp
bmUgT0FfVEM2X0NIVU5LX1BBWUxPQURfU0laRSAgICAgICAgICAgIDY0DQo+ID4+Pj4gKyNkZWZp
bmUgT0FfVEM2X0RBVEFfSEVBREVSX1NJWkUgICAgICAgICAgICAgICAgICAgICAgNA0KPiA+Pj4+
ICsjZGVmaW5lIE9BX1RDNl9DSFVOS19TSVpFICAgICAgICAgICAgICAgICAgICAoT0FfVEM2X0RB
VEFfSEVBREVSX1NJWkUNCj4gK1wNCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgT0FfVEM2X0NIVU5LX1BBWUxPQURfU0laRSkNCj4gPj4+PiArI2Rl
ZmluZSBPQV9UQzZfVFhfU0tCX1FVRVVFX1NJWkUgICAgICAgICAgICAgMTAwDQo+ID4+Pg0KPiA+
Pj4gU28geW91IGtlZXAgdXAgdG8gMTAwIHBhY2tldHMgaW4gYSBxdWV1ZS4gSWYgdXNlIGFzc3Vt
ZSB0eXBpY2FsIE1UVQ0KPiA+Pj4gc2l6ZSBwYWNrZXRzLCB0aGF0IGlzIDEsMjM4LDQwMCBiaXRz
LiBBdCAxME1icHMsIHRoYXQgaXMgMTIwbXMgb2YNCj4gPj4+IHRyYWZmaWMuIFRoYXQgaXMgcXVp
dGUgYSBsb3Qgb2YgbGF0ZW5jeSB3aGVuIGEgaGlnaCBwcmlvcml0eSBwYWNrZXQNCj4gPj4+IGlz
IGFkZGVkIHRvIHRoZSB0YWlsIG9mIHRoZSBxdWV1ZSBhbmQgbmVlZHMgdG8gd2FpdCBmb3IgYWxs
IHRoZQ0KPiA+Pj4gb3RoZXIgcGFja2V0cyB0byBiZSBzZW50IGZpcnN0Lg0KPiA+Pj4NCj4gPj4+
IENodW5rcyBhcmUgNjQgYnl0ZXMuIFNvIGluIHByYWN0aWNlLCB5b3Ugb25seSBldmVyIG5lZWQg
dHdvIHBhY2tldHMuDQo+ID4+PiBZb3UgbmVlZCB0byBiZSBhYmxlIHRvIGZpbGwgYSBjaHVuayB3
aXRoIHRoZSBmaW5hbCBwYXJ0IG9mIG9uZQ0KPiA+Pj4gcGFja2V0LCBhbmQgdGhlIGJlZ2lubmlu
ZyBvZiB0aGUgbmV4dC4gU28gaSB3b3VsZCB0cnkgdXNpbmcgYSBtdWNoDQo+ID4+PiBzbWFsbGVy
IHF1ZXVlIHNpemUuIFRoYXQgd2lsbCBhbGxvdyBMaW51eCBxdWV1ZSBkaXNjaXBsaW5lcyB0byBn
aXZlDQo+ID4+PiB5b3UgdGhlIGhpZ2ggcHJpb3JpdHkgcGFja2V0cyBmaXJzdCB3aGljaCB5b3Ug
c2VuZCB3aXRoIGxvdyBsYXRlbmN5Lg0KPiA+PiBUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBs
YW5hdGlvbi4gSWYgSSB1bmRlcnN0YW5kIHlvdSBjb3JyZWN0bHksDQo+ID4+DQo+ID4+IDEuIFRo
ZSB0eCBza2IgcXVldWUgc2l6ZSAoT0FfVEM2X1RYX1NLQl9RVUVVRV9TSVpFKSBzaG91bGQgYmUg
MiB0bw0KPiA+PiBhdm9pZCB0aGUgbGF0ZW5jeSB3aGVuIGEgaGlnaCBwcmlvcml0eSBwYWNrZXQg
YWRkZWQuDQo+ID4+DQo+ID4+IDIuIE5lZWQgdG8gaW1wbGVtZW50IHRoZSBoYW5kbGluZyBwYXJ0
IG9mIHRoZSBiZWxvdyBjYXNlLCBJbiBjYXNlIGlmDQo+ID4+IG9uZSBwYWNrZXQgZW5kcyBpbiBh
IGNodW5rIGFuZCB0aGF0IGNodW5rIHN0aWxsIGhhdmluZyBzb21lIHNwYWNlDQo+ID4+IGxlZnQg
dG8gYWNjb21tb2RhdGUgc29tZSBieXRlcyBmcm9tIHRoZSBuZXh0IHBhY2tldCBpZiBhdmFpbGFi
bGUgZnJvbQ0KPiA+PiBuZXR3b3JrIGxheWVyLg0KPiA+DQo+ID4gVGhpcyBzZWNvbmQgcGFydCBp
cyBjbGVhcmx5IGFuIG9wdGltaXNhdGlvbi4gSWYgeW91IGhhdmUgbG90cyBvZiBmdWxsDQo+ID4g
TVRVIHBhY2tldHMsIDE1MTQgYnl0ZXMsIHRoZXkgdGFrZSBhcm91bmQgMjQgY2h1bmtzLiBIYXZp
bmcgdGhlIGxhc3QNCj4gPiBjaHVuayBvbmx5IDEvMiBmdWxsIGRvZXMgbm90IHdhc3RlIHRvbyBt
dWNoIGJhbmR3aWR0aC4gQnV0IGlmIHlvdSBhcmUNCj4gPiBjYXJyeWluZyBsb3RzIG9mIHNtYWxs
IHBhY2tldHMsIHNheSB2b2ljZSwgMTMwIGJ5dGVzLCB0aGUgd2FzdGVkDQo+ID4gYmFuZHdpZHRo
IHN0YXJ0cyB0byBhZGQgdXAuIEJ1dCBpcyB0aGVyZSBhIHVzZSBjYXNlIGZvciAxME1icHMgb2YN
Cj4gPiBzbWFsbCBwYWNrZXRzPyBJIGRvdWJ0IGl0Lg0KPiBZZXMsIGZvciBzdXJlIHRoZXJlIGlz
IGEgcG9zc2liaWxpdHkgdG8gZ2V0IGludG8gdGhpcyBzY2VuYXJpbyBhbmQgdGhlIHByb3RvY29s
IGFsc28NCj4gc3VwcG9ydHMgdGhhdC4gQnV0IGFzIHByb3Bvc2VkIGJ5IHlvdSBiZWxvdywgbGV0
J3MgaW1wbGVtZW50IGl0IGFzIHBhcnQgb2YNCj4gb3B0aW1pemF0aW9uIGxhdGVyLg0KPiA+DQo+
ID4gU28gaWYgeW91IGRvbid0IGhhdmUgdGhlIGFiaWxpdHkgdG8gY29tYmluZSB0d28gcGFja2V0
cyBpbnRvIG9uZQ0KPiA+IGNodW5rLCBpIHdvdWxkIGRvIHRoYXQgbGF0ZXIuIExldHMgZ2V0IHRo
ZSBiYXNpY3MgbWVyZ2VkIGZpcnN0LCBpdCBjYW4NCj4gPiBiZSBvcHRpbWlzZWQgbGF0ZXIuDQo+
IFllcywgSSBhZ3JlZSB3aXRoIHRoaXMgcHJvcG9zYWwgdG8gZ2V0IHRoZSBiYXNpYyB2ZXJzaW9u
IG1lcmdlZCBmaXJzdC4NCg0KV2hpbGUgbGF0ZW5jeSBpcyBpbXBvcnRhbnQsIHNvIGlzIHVzaW5n
IHRoZSBhdmFpbGFibGUgYmFuZHdpZHRoIGVmZmljaWVudGx5LiBIZXJlIGlzIGEgc3VnZ2VzdGlv
bi4gIFdlIGtub3cgdGhhdCB0aGUgdHggY3JlZGl0IGF2YWlsYWJsZSBiYXNpY2FsbHkgdGVsbHMg
dXMsDQpob3cgbWFueSBjaHVua3MgY291bGQgYmUgdHJhbnNtaXR0ZWQgd2l0aG91dCBvdmVyZmxv
dy4gSW5zdGVhZCBvZiBzdG9wcGluZyB0aGUgbmV0aWYgcXVldWUgYmFzZWQgb24gbnVtYmVyIG9m
IHNrYnMgcXVldWVkLCB3aHkgbm90IHN0b3AgdGhlIHF1ZXVlIGJhc2VkIG9uDQpudW1iZXIgb2Yg
Ynl0ZXMgYWNjdW11bGF0ZWQ/IEJhc2ljYWxseSwgYXQgYW55IGdpdmVuIHBvaW50IG9mIHRpbWUs
IHdlIGVucXVldWUgdGhlIHR4X3NrYl9xIHVudGlsIHdlIGFyZSBoYXZlIGVub3VnaCBieXRlcyB0
byBjcm9zcyB0aGUgdGhyZXNob2xkIG9mICh0YzYtPnRjX2NyZWRpdCAqIE9BX1RDNl9DSFVOS19Q
QVlMT0FEX1NJWkUpLg0KVGhpcyB3YXksIGR1cmluZyB0aGUgbmV4dCB0cmFuc21pdCwgd2UgY291
bGQgdXRpbGl6ZSB0aGUgd2hvbGUgYXZhaWxhYmxlIGNyZWRpdHMuIEJhbmR3aWR0aCB1dGlsaXph
dGlvbiBiZXR3ZWVuIGJpZ2dlciBmcmFtZXMgYW5kIHNtYWxsZXIgZnJhbWVzIHdvdWxkIGJlIG5v
dCBiZSB2YXN0bHkgZGlmZmVyZW50Lg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IFBhcnRoaWJh
biBWDQo+ID4NCj4gPiAgICAgICAgICBBbmRyZXcNCg0K

