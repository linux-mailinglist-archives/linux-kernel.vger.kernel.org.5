Return-Path: <linux-kernel+bounces-110971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 357BB886677
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39751F2338F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9D4D26D;
	Fri, 22 Mar 2024 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1k04yuC2";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LlnJgn/C"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195ABA27;
	Fri, 22 Mar 2024 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086748; cv=fail; b=OSc02fhcw7/wg1mGJSECfIYQX1A4bMvN25ksuyfercj5KYVb7uqM5vIMJ+xwb3vuO9BIa6E3dzU4baUaiHnG0W5fCDrUTK9TwjjvFqZdKxDeCxdp8HojI2KL7Mtnp+m/HufBE6CqOQxHDuI/VN212sc5BeWKwHzPOPtFtoowZgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086748; c=relaxed/simple;
	bh=UPYb2SopZQhiH6LJC68Hf2aqwNf7D7x7aorJkDj/RMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qoVxZYYfFg2506NoADVvq5QGfBm17cRVBXKqmDqJiZ+nNBD5E0IhT99IzpEZ7176/Tbvb17cEFuz2XNvv/YOjl8Q6PnMgJ+Ytp78RhJIIRCLzXkv1tXHy+7U943Fbv5gXtxGaiA8DhJLJWcCqmZhFiHNtS3NByR0rkI3uUgE2j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1k04yuC2; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LlnJgn/C; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1711086746; x=1742622746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UPYb2SopZQhiH6LJC68Hf2aqwNf7D7x7aorJkDj/RMU=;
  b=1k04yuC2+e3P/9t7Vu03wxTk3KmxZR/Nv7JUOVVCCn6hQCaezsjZdXeO
   ndPiwvt7oORu2OCqAlpiT0IB8NG3HNeSpg0AI7Wl8z3/0Zn1RVzJ1dB/P
   foYsDEy4ZtHXelXh5tp3dLydIKKIxur6gPcbp4RUflRuKgxS8VCvURhx4
   U5vRwr7tElGGzQhTdOFrdXEQu1FK/plciqJ+uAWqAukkBAYa7+S9623LG
   A95xqNIVKO/ltTjHWPxoRBJL8mv+Y6MZhT2KaE9kgWey7zfOj+ZdVg6Qm
   lpyFg/S5eRUHYLlzzULnXfhWF+ZQNeVmiXgsCC5xHevHT1w+nqP1QFAv2
   A==;
X-CSE-ConnectionGUID: cr4MeOGeRLOJsUCNqyjZxg==
X-CSE-MsgGUID: lrL2rJ/8QH6J0anz8urNaQ==
X-IronPort-AV: E=Sophos;i="6.07,145,1708412400"; 
   d="scan'208";a="248778057"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Mar 2024 22:52:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 22:50:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 22:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0teNTHkTITc8LsJN2Qt/fc08TGHPalxV54E0BrMmWaSGGb3RAPrvkpOIRBGjn+WLpRUZbVske5UxXATSap5Ea3UACNnKQ6Jfvg5UMD7woCjioIpvv7OGzCW3pB/0kjCMCuQPJPxumnZDCwT1BxXMwCKm40Fgsy35HLm4h1rQWgZ6Hf+MO5CJgWiir+N1PJ5PjqnprHXfxIjCv3OwEH+1U9MMpjavQzAn78Z+ZAvGpAn2u/ukhVa0hi11wx2J95DkKqFusL+wHb5hNQfSbSUkrBf3/wd7aHUVARGNwgO/ZB/YgSeq5QOFaSdAi69SAJp+gbIHs8vJilqRFXQmg2QAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPYb2SopZQhiH6LJC68Hf2aqwNf7D7x7aorJkDj/RMU=;
 b=Mv8hVJj4i/OB8UZQmTcwubbo88yv9KfK7bhN27wgHKNCSM1eYPLjapxfuVC+ElZS8gV6G5ssRAuSQjKeseJO8HYLMgmoQbCzSf+enUGzhdLdLf6PqsZTLIv44pV19DddK4zOVZjs3/Nz+20EXhd3ZJRnsPKU5mSU2NHD6Fqj3gUzTFwH8yOp0CNMk/3Y7ES42kur5myzryWUF1p4AGKk3lJMA2vj3e0QqHTmHFqYuB6VlC772dOwfT+uVoCxymRiuBtbnyTPlHGUPDzgDx6Ky8psAJAeJLBVEx9GN7Qhz5PzwdkvH9E9fpX7ZBz5NYOniOYedMuqAgVk06zULv1ZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPYb2SopZQhiH6LJC68Hf2aqwNf7D7x7aorJkDj/RMU=;
 b=LlnJgn/Cutd52IMOpLoNDvIwk6dIh4hz7YR+uFSkxL4JQaU+uOaNA8GziOb8s972N1BlmUvPrrDqnrYap6KUValSwstnMac8cRZ5gYDrZ3W4k+ssTwVLf4UyBsaHe1Qi9VN7Nox4pnuhlHm9+eZUVd3aBTE6jhyn5HViab/0so9Ui2X69Jeyp2jUDcXmnf8g2MdI0YOwVl4i2gsz4M+BbffqAYPTyAPWNXI4bQbMqeXRgCvqJdF0AOHsWbW8eyCQcg8CyLdNmt9l+uxYM/bXIk7kQlDtdUGXkde/LmHNbOHJ01tCS0c6qeaBntHV3NSZ4BEgCiOjG271I0FKVu/DHg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 05:50:55 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::f633:b9d4:f539:177d%6]) with mapi id 15.20.7386.015; Fri, 22 Mar 2024
 05:50:55 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <Selvamani.Rajagopal@onsemi.com>
CC: <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Nicolas.Ferre@microchip.com>,
	<benjamin.bigler@bernformulastudent.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <saeedm@nvidia.com>, <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <Steen.Hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Topic: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Thread-Index: AQHab6OHj5kLkYW7WEGlK1Xe+8KWTLFCoaYAgAC47wA=
Date: Fri, 22 Mar 2024 05:50:55 +0000
Message-ID: <03e81cee-7f23-45c4-9a2d-343d13a1c59c@microchip.com>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <BYAPR02MB59589FFEAB8BB9578A61B39083322@BYAPR02MB5958.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB59589FFEAB8BB9578A61B39083322@BYAPR02MB5958.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|MW3PR11MB4556:EE_
x-ms-office365-filtering-correlation-id: 7df9274d-29cd-44fd-faad-08dc4a340ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TTZVw9QiRqQLdoBQuRTeUnLyiqcH/FALa/zNglUrGI9Ad4TwGhRcKVectwBw+tozLiO1/Na69zDgieXE4yfU+xHAdC4l+HLA2vHi6mIo4UZdy7Fec89WzKPEz4qS6pIu339c+inym0HNy/notp4Jpy7FSR1XIoTBfCDn46vCTK/4epxbD9OkEplBREW2LII6OU/CMn1XHYKMyjr4YydSdYCiZJ4pPc+NpjFRSzfGsMfSL7kPkw3KgFykbP7kWZdFFwliLONza983rj+F7anpXcaGTbvbyohqTvMM8iVBtQzH+O4bq6CwkjP/RmGJID34R9I2M34GP0jtW8OLrmSe3gMx2Pm2qhTk9IVMZk6V1LOP+YpBntN1H5wO00sYV+rGh7FMEd+6Q3Wugr/2r9M69YWMhBRqTiBmcc+wYwTysKYGcBQz9zz+smWdsF/9wpPEq377sNUbMpSFc+tIK+3S6USDiBl1x828YxEj3ZCh9nJlJFbKSYJC8sS0+k6suDhDtDrlCiB/ISzwhvnq16TIJEpDkpABnX+3u7qofKUT5zJXUxED4kjjocx1xgI5QhrTnth3elPkQymc/24YAxQXLkzzcxK9zmyxuO0IUQZsMsm4kfPyrhXSduEWmEJTahw9KSzb2Lc7D6sk0GWXzGWLlgFqkcRv7dSyM0Q4UD/ZELG4CpMrDufp11CiksKKaBkOtfZNmWKzC66GNm4mC5pfR74C9wthC7GCDRx3CMIijSc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWg1UmlLVG8yRmxmdWZ4WVVXUVdHM2JNK1NEeG9CeVVPalhERGk2dm1LQldu?=
 =?utf-8?B?N2JaSjBSSERKMDN6WVUrTlg4cUR3N2NISDRpNllNb2wrNStnWTJqS213RmU0?=
 =?utf-8?B?ZGlqdWF6anFHRXJzZjBRUEJvMTEyZEg5VllYZkhNR1lBWDZjV3JxNW92bUp6?=
 =?utf-8?B?eHdYSUg0a1RoMmkyV2V1WDNTa1ZpTzM0aFArQXZqNTJUR2Z5b3hNaVoxdHBt?=
 =?utf-8?B?enQ0TGYrQjZFRXBjTGVMaHJTaTV6dmorSkM3cFQ3MnF4c0t4QlVabHhGSUJN?=
 =?utf-8?B?enBrTGM3eWZybDRLNUgwa1BidU80UFpRNU1CNEpZdDVkRGpCV1BEMVhIdkU2?=
 =?utf-8?B?eHRORGVpVDdvdUVSNk95K1hKZy9SUzJ0amhFUWp5V1ZFWlhjSDV2Y1BINnd0?=
 =?utf-8?B?aXJjaVdxNWp4dStrR1Z3ZEdqS3U0cnJFeitNRnllMk5DblBwOEZNZEEzY085?=
 =?utf-8?B?aWRkQmZmNTNDSWVEVS82Z2lHNzhpaTEwS2xvOFRmTmd1SEo4SWZPclh1OWd3?=
 =?utf-8?B?bWhCblc4ZDFRVDA1ZWhNeDFQTnZpL3pjdXFXMVNlellYNFVBVEYvNzhFQUZ2?=
 =?utf-8?B?OWRaTTV6YVFrczBIVE5MdVFWRGRxSzBpWkRZSXlEelIwczRuUlUwT0NEUmhM?=
 =?utf-8?B?OW44OU83enZZWjlsU2ZvK1ZhY1JQZ0s4NkkxWVhCbytoY25WMWoyTEMyS2Z4?=
 =?utf-8?B?Nzk3TVRDTWR1R1ZqVmtSdVZnSC8zVi9qdDdrUzlMakJ6MzFSZW80d3haUFcr?=
 =?utf-8?B?VytoTEpPTjVVUTRGWTZuSUM3bmhCVkM5Q2drNnF4UDFnVmU2R2l5M09IMDQ2?=
 =?utf-8?B?VmNzaVF6MkFOUUxyd1BBR3JKdjIzTGozdVdMWHg4bW1ZclBHLzF0eHE4VHZE?=
 =?utf-8?B?cmdIVXBuR3Nla3JxNEhUU2s2alpTN2dTVTVEQ2JETCtQaUlvN0l5UGkwc3ox?=
 =?utf-8?B?K2haRXJBQnlvR1E3TVhoWlhXN2FQaWFOWnBuVUR2TEdWNmZ2cGxzOGRRUHZh?=
 =?utf-8?B?WmhxcWdHajZaa0Y3UVpPTll2a2Qvc3F1aUxFcmd3YkhHUDl2c3ovT1NTOXhh?=
 =?utf-8?B?NmlsMmlMNGVqN084KzRQeTBIUzR5NUlVQ2VVd1QwTlkxVzcrSzhJTVZVVERq?=
 =?utf-8?B?dWk0VkZFQ0psTjZPemxETkVjL0lvQzBUR1Q2K25Ud3RQQmNLNER1bzh1SElK?=
 =?utf-8?B?aXpubjlhVnZnSVFpNXhOOEVLeU9aMUw5QmVjWTgyZTcxQnFmZ3hCUVU5cG44?=
 =?utf-8?B?UEhwUkNFZTFocTZqdjZQOXRxZlErMTNzYjJTb2IxWW90ek1veUhoTENsTjIv?=
 =?utf-8?B?TVk0TlZqbXZhWjF6U0tFQ2k5OWhsQjRFbENqY0pudUhVSTB3eXZMbk5CNGw1?=
 =?utf-8?B?K2F4UCtUc2ZIZTErQVJkWmRRMzh1RStOOXZrRFVNT3VsbTJzakJYd2p1aUlx?=
 =?utf-8?B?S1lib3NiSmVkdzJTS29qc2JpbEhYZDlRRTdPNXZmSXN1eUNxRXRobzJvOXFz?=
 =?utf-8?B?N0NjTlZOZE4wbnJKdjdxVlMrRGtyWlZPaHdFYjhWbjlkcUxIeDdBTkRTaENB?=
 =?utf-8?B?OUQyYUJuMm4xNEJScFc5SGcycnBSMElmTGFNNi9iRURsSkk0N2JSazhaYnFE?=
 =?utf-8?B?RmUrWS81NGhrTWprSE5ZNVRmc0NBNkRqTHg2NkpNWkVndUUrRDRTc3czUkZV?=
 =?utf-8?B?eHhJSGxOaXZ5RW50dnM0cFhoT0JDTUFzNm56TmUyUXJlYjdpYXdmVVpiSThn?=
 =?utf-8?B?R3A5c3Z6SW1jK3RIeHp1R1hPakpRL0xXUEJZS3FGbnFpREhVQ3kvOS9pcmRl?=
 =?utf-8?B?VkN3aHdlb1FvdlcwTUNieVhqSlNBMGdVYXZHbjZieWNOMEZSazh5R0ZGdHo4?=
 =?utf-8?B?NUNZTENSdDdtV0F3cUF4bTY1V25QWU5rWGMzWGlsUHM4bE5WK2pObUx3ZmhR?=
 =?utf-8?B?SS9Bd3lOTnppTFVWRkZtVkxRODlnNWxSTmhXd0dZNXNXZEZ2ZktzZkhaNjJM?=
 =?utf-8?B?d1J6NG1ib2hNQThBZUZ2SXRTMnBSTG5yb09QdU5iK2JlY212QjZpclFrL05N?=
 =?utf-8?B?S2hTczRYRTk3dTNkeVlaSHBCeTlITlBaS3pweTR6OWhQV01wUTB2M0xYTW5z?=
 =?utf-8?B?T1JnQUFnZklaak5wSTNmdHVnVnh5dUxqRVVkTkoxK25rb1FKOUtHOGNaaVpC?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9EA92F981A5A8409737014AC3333E83@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df9274d-29cd-44fd-faad-08dc4a340ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 05:50:55.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3QtgPV2mYbdEFiBjIx9Wnj3y3NbWrd4Xny9SU0wkJO2y99FfyGZa7pV6FtX0kRESN2nB8NWYbDzZBujMcessADJOhZDm6ycEgt1oAjk99qKEC1wb562BAK1JyNA6932
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556

T24gMjIvMDMvMjQgMTI6MTkgYW0sIFNlbHZhbWFuaSBSYWphZ29wYWwgd3JvdGU6DQo+IFtTb21l
IHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBm
cm9tIHNlbHZhbWFuaS5yYWphZ29wYWxAb25zZW1pLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1w
b3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBd
DQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+PiArc3RhdGlj
IGludCBvYV90YzZfbWRpb2J1c19yZWdpc3RlcihzdHJ1Y3Qgb2FfdGM2ICp0YzYpIHsNCj4+ICsg
ICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgICB0YzYtPm1kaW9idXMgPSBtZGlvYnVzX2FsbG9j
KCk7DQo+PiArICAgICBpZiAoIXRjNi0+bWRpb2J1cykgew0KPj4gKyAgICAgICAgICAgICBuZXRk
ZXZfZXJyKHRjNi0+bmV0ZGV2LCAiTURJTyBidXMgYWxsb2MgZmFpbGVkXG4iKTsNCj4+ICsgICAg
ICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+PiArICAgICB9DQo+IA0KPiBTaG91bGRuJ3QgaXQg
YmUgYXBwcm9wcmlhdGUgdG8gcmV0dXJuIC1FTk9NRU0gaGVyZT8NClllcywgd2lsbCBjaGFuZ2Ug
aXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4g
DQo+PiArDQo+PiArICAgICB0YzYtPm1kaW9idXMtPnByaXYgPSB0YzY7DQo+PiArICAgICB0YzYt
Pm1kaW9idXMtPnJlYWQgPSBvYV90YzZfbWRpb2J1c19kaXJlY3RfcmVhZDsNCj4+ICsgICAgIHRj
Ni0+bWRpb2J1cy0+d3JpdGUgPSBvYV90YzZfbWRpb2J1c19kaXJlY3Rfd3JpdGU7DQo+PiArICAg
ICB0YzYtPm1kaW9idXMtPm5hbWUgPSAib2EtdGM2LW1kaW9idXMiOw0KPj4gKyAgICAgdGM2LT5t
ZGlvYnVzLT5wYXJlbnQgPSB0YzYtPmRldjsNCj4+ICsNCj4gDQoNCg==

