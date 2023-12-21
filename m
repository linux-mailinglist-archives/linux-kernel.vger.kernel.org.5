Return-Path: <linux-kernel+bounces-8052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEFB81B1A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353A1B25D53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9EA52758;
	Thu, 21 Dec 2023 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gYrapmPm";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qoGwM8Rd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23347524DF;
	Thu, 21 Dec 2023 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 73aa74d09fdf11eea5db2bebc7c28f94-20231221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eA/SFC7TPyA1ZGZW8uDxSkMN3/uqGhMomODCoWGdNT4=;
	b=gYrapmPmyA3R8ef3197aTz8Wj9xhDDTqKVZnxc5WXV6wMYqJUWY4penbqGGUYXxmresKgPbEpIkV8OEeIKdGikorP4ctqKkyn3OL7rV3uMDbChDW/GSM+cc6bvO6C4KMzMGHvLN+sVxVBkQbifnQllJVsFoCTpSX7g31nwKRw4o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5b791442-7b09-4bb5-9b43-9a1e0b595d05,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:63ae6b8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 73aa74d09fdf11eea5db2bebc7c28f94-20231221
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mengqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 835178316; Thu, 21 Dec 2023 17:00:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Dec 2023 17:00:54 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Dec 2023 17:00:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/T1nN9eXyLnnPfuPoaRt0Eno1o1XpwJOqR8pMTgJOoc1PgSTQU2kh2qEgIFQ9K8rLiBaSjBTPsBVYQDBahuaeTh8EjNR45VOLRnh/Ad93GUfihTdk82KvR7owY3DB9hDPlrJf/Kg3TiV8rtoEbyRMPyfpUWldY0KtQSEU8IwUtBGpTiCIPAL2+iXq8ArUTyGqYQCF404tpmCvzacaAKsWjDtAT7GgfINJ/hnl8Juk4lwT8OSLi8OHY/XMkBx2WBO7kvnBeNbBduPz2AAvj9juLnNzV1CJ98ok7IRqAuhf9Y0jUBAOaJ4HOFlKynRiD20YtkohE4WwAFOCRRIiQuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eA/SFC7TPyA1ZGZW8uDxSkMN3/uqGhMomODCoWGdNT4=;
 b=Oatf4EcGum7VtLOMoGGMRcI7fo4w1I0q3itEE86PIPykgxr8G0dna/OBoj0ocZVR7V5HMVMXgPpXiuGvoM01zb/ht70aGYP9y2VUsTL/HsuY5ze5SrF4vmhF3tpus1dL5wMnyEXLJGtkla5+9FwTySAW5UE1+4BJJXNWbbFJvVTZSLN2qKd2isOT3JEhed23f4RfeLv/VO0AYaQvJg+k110Ztj/g9S/vEZEyeWRjhoxNdSG6cK7kJGu9jHfJ7MrIDxVNLI00K5DHIC1h2KuII3540vuCYQnki8H/yQ6rw58J/EkQU7KcRZ8BJ0E/5cE8T/1XE5zRKktV9zC7E9n53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eA/SFC7TPyA1ZGZW8uDxSkMN3/uqGhMomODCoWGdNT4=;
 b=qoGwM8Rdg5722WHg+8+7PcRiBuL7yfugk76TSNjALAN1xEDiZ/Dbo1Mie7DgL9UikiSX9b8j8NL6Q9YJjR+vsp0cnDQiO+nL7BLDk/kKVV9SmMzVzbspXNgACyOwZ6B068eYlwU0ubz54/oHxXq/IYA61VzjhinDIUvKUPbYsVk=
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com (2603:1096:4:175::12)
 by TYZPR03MB8293.apcprd03.prod.outlook.com (2603:1096:405:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.40; Thu, 21 Dec
 2023 09:00:52 +0000
Received: from SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::1bf3:b219:1d80:80a6]) by SG2PR03MB6261.apcprd03.prod.outlook.com
 ([fe80::1bf3:b219:1d80:80a6%5]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 09:00:51 +0000
From: =?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?= <Mengqi.Zhang@mediatek.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	"avri.altman@wdc.com" <avri.altman@wdc.com>,
	=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
	<Chaotian.Jing@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "vincent.whitchurch@axis.com"
	<vincent.whitchurch@axis.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "yangyingliang@huawei.com"
	<yangyingliang@huawei.com>
Subject: Re: [v1,1/1] mmc: core: Add HS400es support in retune and
 initialization flow
Thread-Topic: [v1,1/1] mmc: core: Add HS400es support in retune and
 initialization flow
Thread-Index: AQHaJANO5PQN3+oPHkmGCQYY2KL/3bCd3SaAgBWzN4A=
Date: Thu, 21 Dec 2023 09:00:51 +0000
Message-ID: <62ea1a73aab2d58fb0ca610cc92db9e18920f022.camel@mediatek.com>
References: <20231201030547.11553-1-mengqi.zhang@mediatek.com>
	 <CAPDyKFqhGULWp3P2EpxUMLvdiijqu7qxPrY40GU2m3FM7XVCVQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqhGULWp3P2EpxUMLvdiijqu7qxPrY40GU2m3FM7XVCVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6261:EE_|TYZPR03MB8293:EE_
x-ms-office365-filtering-correlation-id: f23f9fa1-572e-4436-80d4-08dc0203554c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVVfZwV/orQqmNQFZW6jVfZW6Mp4xN3IgxRYQ+CFIQwfyeIbPS4RftV/A8Y4luXYnCkeenAwCb5WWipEWCDEqY12cePzwL894jJFy1WxDAN7tAf8wS+jjeStZEi67Q3OBmmUoq7HGQCUHqvJCGXkkEWk2YPrIWfiiXfuUatRinQ73mj+i94AkolBe0An1coUK0CQvv5+ZuxlMZd5CGnZHa5uwPkwFwpyoXXZKDlnJLLxMZXx0pGsJAq3N9CE/n4H6rd0dtazmvielNhNW0haWSXu8M8xup7YDXqHGuj+OzxRmSSM4wVrE4psWwjVGwYUN24vUVwadx9wHjsDYqf/ynHWinrpEXgnvz1VEKcHw7lHfFMzKNabyHZqqwKZ/4uv9PEPbf63T9oBcH3v9H2y9FhMpyfm4/k1IukfuCXUfwSOAU0nI4F97csxJCq9aYY5h8xu9eQgbMV1keC4wxoJ3f8R6Y2LHOwy6xqqauwmmhiZhKOvRh8ekU3WjLq0lmLROyflkAICaL+ljsHBJWMvUvB3vy4MFo3YQ1urLRL/HN2qwYRujfZK2dc1G78m0O/IFeZFACVf5AH+qvjPHmQRkux63CUywCipycAWv6c18jpSFIvAwiOFuybWyeEHO6A+yqtW9K+nEMPLfXuLnImZ2RaRfhven4UKc+0s1XcOgkWbTeojipvVrn2fCN1wXcIlJKMlb+i1dALYC05ljw1feQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6261.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230173577357003)(230922051799003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(6506007)(6512007)(26005)(2616005)(122000001)(38100700002)(4326008)(8936002)(8676002)(316002)(66476007)(66556008)(66946007)(76116006)(66446008)(64756008)(6916009)(54906003)(478600001)(71200400001)(6486002)(86362001)(2906002)(38070700009)(85182001)(5660300002)(7416002)(41300700001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlEvd0hCWFNIWjdqQmY1ajBCbzk2Zkc1SzdkQmpYendSd2VVMTdwSDg2T3I5?=
 =?utf-8?B?NXB0M0VHUXdWTTFkQTBUQWF5MzRXakpzVmgyOEVwWXBybkZZbE0yeWpYS05G?=
 =?utf-8?B?eWdHOFdHNmtGUm5WU0U4UWhJelFRbWF0Z0g5Rks5SGxDM1gxWERnQWhiM0po?=
 =?utf-8?B?aVpOalRqZk1sQi9aZ1lGUTd3VkRURTJUY1FYS0FMSVk1MUNhc3B0MDV2STU0?=
 =?utf-8?B?T2xOOXVQUS9DcEFjMHA3ZW5kc2ZYNWRSV0xaaVBxVWp1RVFEQmdteVRNU2JJ?=
 =?utf-8?B?VzNMOXV5WFk0bzRMZDlHZnd4bnFSMDl0U09SVHZLQXJXTS9yT2IrbmlvTVNx?=
 =?utf-8?B?ei9yZXpZS3BVV3QrZEVvTlJyRE1XaytGN1JtQmgvaGpnOFE3QUJlMG9VOUN2?=
 =?utf-8?B?N0ZhUGJiK0VJNVM0RnE3U1kzeEh5STZvTnY1QlhiNnBvWVowS05rU3g2dmZY?=
 =?utf-8?B?aDRQMFlMSjEwd251ZWkzNmZRdlZWTm9vSW9CSE8yN3ZaS0U4b000ajJzMktv?=
 =?utf-8?B?ZjBxdDQ2SUNzc3dob0VTWmF6WWx1cTRDMG5CQnRON0I2R3JwbkFLaThKZFcx?=
 =?utf-8?B?K3VBMjlKaTV0bDJHa21pMVJIRzZkZEphV0MrSkl0aXl2eG93UmF4aVN5cXB5?=
 =?utf-8?B?UytES0xVd2tlVy80M3FxSElDWDRWQ1pWeFhrMXZUZWc1dklHNkZ4UFkvUkdY?=
 =?utf-8?B?eU5CYkJnRVBZcTd5SGFKYi9EWFVIcUNubW1JQUcraTFON2JzVzNySG55V1NS?=
 =?utf-8?B?N2dhTlNYTmxZQ2pia3ZqWkZRUU9XVTEyclJzcXBCNWoxbjhtYk5sK2tJdDFh?=
 =?utf-8?B?cUNEaW1zSUdSanZvcHdTN3dNYjc3VURNOU9YZ1pzbXplbG1Pa05JOHpHdmhp?=
 =?utf-8?B?cVpSM3hzRFNuL0xqV3dpVHp0UVlvcXhaRWtIWDcxb1ZvTGhlSS8xYWJ4RzRS?=
 =?utf-8?B?aHRJcks2T0Y0VldVRmpVNmFOV0Y1bE53bFBVWlNxNzVOUGZGbmhZL2hjZDJp?=
 =?utf-8?B?ZnJTTzNTNGtMM0p3VVBmS1FTb05HdkJrSk84Y0tYMUpXRjZYSWdvYUh0TlVK?=
 =?utf-8?B?Q3BLRFRFNjdnWng2Y256VHl1WkhHOVUyVGtWRGYrTGRySUVwR2RsZ0Q4dlBH?=
 =?utf-8?B?ZjVaNW1rNkY0aVErYW9HZGZtbDdwM0Q0UDZ3VnpzZzhhbVI2WHFUZlp4QTFQ?=
 =?utf-8?B?NXV5K29KV1FYb2xVV0c2T3BXS1g1eWZJZUVyeFJGT1cwWnp0ckg2YnRHMVFh?=
 =?utf-8?B?ZGUxWllkamJoY3hlQWxmdFRLRlRXejRTM1VXMHRDZEEwMFFiajQzbUdTQ3ZB?=
 =?utf-8?B?bzJ3aVNCRGVLSVY3Wi9Vd2pPL3Zvd1U1OUc3MXJNUStyTUR0c2lyZzJRT2w0?=
 =?utf-8?B?ZG51WHVqdEw4cWRncUkxRk9yczRkcFlDRGtMdlJqVVFiQ1hPOHBuM0lTRXNh?=
 =?utf-8?B?dE5tV2p1Smpxb2gzWE4vSXMzZ3RRSmxzbUJjaEZPQnNyUHlsQms3cUVFZmpI?=
 =?utf-8?B?WUJSQUY4bnVMdE1CcmtNUEg5VmdhUWZ3TTQxckVhYVRPNjh5K0FsN0pjMjJ2?=
 =?utf-8?B?R3l5OTJBY2pqeGMvYjZPZlpxSk1LdUphZTJ2OWdOQVBEOFlJQW1EQ2cwLzl4?=
 =?utf-8?B?MUd2WDRmL2g1TG40WFIwRlNlbEtkTUE1R0JrUFNTNDROTmZ2S2hjOERDODRT?=
 =?utf-8?B?M3gwRTVCeCtKWUwyQlY0VEJtTjQweFlJWGE0K0F1bHVxbS9hNUdjbkZ0aXM5?=
 =?utf-8?B?Tm4yTUxqSkZNMU80MHNrbkFlWW9XMUd5ZStML1NQUHl3SndzYVZJbTdiN2ZI?=
 =?utf-8?B?bXc1clRyai85YTB5bVNKSFUvaElkN2dDdHZXUEdOaUZUK0wrQ1lSZ3JQaDVi?=
 =?utf-8?B?aGg0TGRtaGp1MGR1SzZqVThjeVUrQ0JuY3plSDNVNnVPdVJxWExNK0xPV0xL?=
 =?utf-8?B?MzV3S3NraDFyQlROVktFb0NMWG5aek5CVHRoNzhTRFE0K2hUd1FDTWk0YTZX?=
 =?utf-8?B?VEJkRkQyazY1M2h5NWNSL0JLalRFWEFNUlhzWloxL0tUVHp2TEhZU2NZdlgx?=
 =?utf-8?B?STViWStIdTZzQmk3VmlyMzhaQWtSQlZTb3J2a0tWRzVqT3dmT0ZZUlFFTkdD?=
 =?utf-8?B?VWJLczQweEtmTWphbWxJN0MxcThNbGFWaXIxaVdESFBjQUhOdGxUYTdNNHNk?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23C31EEFA00276459F73551A7BB81CCF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6261.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23f9fa1-572e-4436-80d4-08dc0203554c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 09:00:51.8723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85wTrmEhzk6sNghOc6L56yAm55v+8fJ3TsosK2L54NBC1D5se8z73LInAuy6gjqbL1qZz5QbK5uKKDdo9F8aSMu6rgWH4t4I3jYBEBHwTXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8293
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.824500-8.000000
X-TMASE-MatchedRID: GBgFBUqwD4HUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2t7spMO3HwKCArHkgIan9a0VwpnAAvAwazIj2
	aWIyIXE4vXg8b+phJFgu3xPaRrT4TiNCj8jDazVLtMsi+dai/0SGi0ftsSkQyLP7lAJOsT+wjqq
	r3E+xdiMz8wpsGXYut5Te2WB3OZkrB1tTdqQfkDM36paW7ZnFo2+EpBnZEzfU7do7qSy1svKPFj
	JEFr+olFUew0Fl/1pE9wJeM2pSaRSAHAopEd76vjsQQiOS7Ty+bkPfV153xHJqhL398fzeuN5oU
	5bmCEOrre2ZT0EYC7g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.824500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2F7A5EFE59BEF04BC427293AA0A5959F8B7A713B0E12811F989258C3FDEB8D2F2000:8

T24gVGh1LCAyMDIzLTEyLTA3IGF0IDE0OjM3ICswMTAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBGcmksIDEgRGVjIDIwMjMgYXQgMDQ6MDYsIE1lbmdxaSBaaGFuZyA8
bWVuZ3FpLnpoYW5nQG1lZGlhdGVrLmNvbQ0KPiA+IHdyb3RlOg0KPiA+DQo+ID4gSW4gSFM0MDBl
cyBtb2RlLCB3aGVuIHdlIGVudGVyIG1tY19yZXR1bmUoKSwgd2Ugd2lsbCBiZSBmb3JjZWQgdG8N
Cj4gPiB0aGUgSFM0MDAgbW9kZSBpbnN0ZWFkIG9mIEhTNDAwZXMgbW9kZS4gU28gd2UgZGVjaWRl
ZCB0byBhZGQNCj4gc3VwcG9ydA0KPiA+IGZvciBIUzQwMGVzIGluIHRoZSBtbWNfcmV0dW5lKCkg
cHJvY2Vzcy4NCj4gDQo+IEhtbSwgSSB3YXMgdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCB3ZSBy
ZWFsbHkgZG9uJ3QgbmVlZCB0byBkbw0KPiByZS10dW5pbmcgYXQgYWxsLCB3aGVuIHVzaW5nIEhT
NDAwZXMgbW9kZS4NCj4gDQo+IEFyZSB3ZSBjYWxsaW5nIG1tY19yZXR1bmVfZW5hYmxlKCkgZnJv
bSBhIHBsYWNlIHRoYXQgd2Ugc2hvdWxkbid0Pw0KPiANCj4gPg0KPiA+IEFkZGl0aW9uYWxseSwg
ZHVyaW5nIHRoZSBpbml0aWFsaXphdGlvbiB0byB0aGUgSFM0MDBlcyBzdGFnZSwgYWRkDQo+ID4g
aHM0MDAgdHVuaW5nIGFzIGFuIG9wdGlvbmFsIHByb2Nlc3MuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBNZW5ncWkgWmhhbmcgPG1lbmdxaS56aGFuZ0BtZWRpYXRlay5jb20+DQo+IA0KPiBLaW5k
IHJlZ2FyZHMNCj4gVWZmZQ0KPiANClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQpJIHdpbGwgZm9s
bG93IHlvdXIgY29tbWVudCBpbiBuZXh0IGNoYW5nZS4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9t
bWMvY29yZS9ob3N0LmMgfCAxMSArKysrKysrKysrLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL21t
Yy5jICB8IDEwICsrKysrKysrKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2Nv
cmUvaG9zdC5jIGIvZHJpdmVycy9tbWMvY29yZS9ob3N0LmMNCj4gPiBpbmRleCAwOTYwOTNmN2Jl
MDAuLjRiZGRiYmIzZDUzOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2hvc3Qu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvaG9zdC5jDQo+ID4gQEAgLTE3OSw3ICsxNzks
NyBAQCBFWFBPUlRfU1lNQk9MKG1tY19yZXR1bmVfcmVsZWFzZSk7DQo+ID4gIGludCBtbWNfcmV0
dW5lKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkNCj4gPiAgew0KPiA+ICAgICAgICAgYm9vbCByZXR1
cm5fdG9faHM0MDAgPSBmYWxzZTsNCj4gPiAtICAgICAgIGludCBlcnI7DQo+ID4gKyAgICAgICBp
bnQgZXJyID0gMDsNCj4gPg0KPiA+ICAgICAgICAgaWYgKGhvc3QtPnJldHVuZV9ub3cpDQo+ID4g
ICAgICAgICAgICAgICAgIGhvc3QtPnJldHVuZV9ub3cgPSAwOw0KPiA+IEBAIC0xOTQsNiArMTk0
LDE1IEBAIGludCBtbWNfcmV0dW5lKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCkNCj4gPiAgICAgICAg
IGhvc3QtPmRvaW5nX3JldHVuZSA9IDE7DQo+ID4NCj4gPiAgICAgICAgIGlmIChob3N0LT5pb3Mu
dGltaW5nID09IE1NQ19USU1JTkdfTU1DX0hTNDAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlm
IChob3N0LT5pb3MuZW5oYW5jZWRfc3Ryb2JlKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKGhvc3QtPm9wcy0+ZXhlY3V0ZV9oczQwMF90dW5pbmcpIHsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG1tY19yZXR1bmVfZGlzYWJsZShob3N0KTsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IGhvc3QtPm9wcy0NCj4gPmV4ZWN1dGVf
aHM0MDBfdHVuaW5nKGhvc3QsIGhvc3QtPmNhcmQpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbW1jX3JldHVuZV9lbmFibGUoaG9zdCk7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsg
ICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICBlcnIgPSBtbWNfaHM0
MDBfdG9faHMyMDAoaG9zdC0+Y2FyZCk7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChlcnIpDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jDQo+ID4gaW5kZXgg
NzA1OTQyZWRhY2M2Li45NzYwZWVhMmMxMDQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMv
Y29yZS9tbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gPiBAQCAtMTgy
Myw3ICsxODIzLDE1IEBAIHN0YXRpYyBpbnQgbW1jX2luaXRfY2FyZChzdHJ1Y3QgbW1jX2hvc3QN
Cj4gKmhvc3QsIHUzMiBvY3IsDQo+ID4gICAgICAgICAgICAgICAgIGlmIChlcnIpDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgZ290byBmcmVlX2NhcmQ7DQo+ID4NCj4gPiAtICAgICAgIH0g
ZWxzZSBpZiAoIW1tY19jYXJkX2hzNDAwZXMoY2FyZCkpIHsNCj4gPiArICAgICAgIH0gZWxzZSBp
ZiAobW1jX2NhcmRfaHM0MDBlcyhjYXJkKSkgew0KPiA+ICsgICAgICAgICAgICAgICBpZiAoaG9z
dC0+b3BzLT5leGVjdXRlX2hzNDAwX3R1bmluZykgew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIG1tY19yZXR1bmVfZGlzYWJsZShob3N0KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBlcnIgPSBob3N0LT5vcHMtPmV4ZWN1dGVfaHM0MDBfdHVuaW5nKGhvc3QsIA0KPiBjYXJkKTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBtbWNfcmV0dW5lX2VuYWJsZShob3N0KTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoZXJyKQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBmcmVlX2NhcmQ7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4g
PiArICAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgICAgICAgIC8qIFNlbGVjdCB0aGUgZGVz
aXJlZCBidXMgd2lkdGggb3B0aW9uYWxseSAqLw0KPiA+ICAgICAgICAgICAgICAgICBlcnIgPSBt
bWNfc2VsZWN0X2J1c193aWR0aChjYXJkKTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKGVyciA+
IDAgJiYgbW1jX2NhcmRfaHMoY2FyZCkpIHsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=

