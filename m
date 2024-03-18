Return-Path: <linux-kernel+bounces-105607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ABD87E166
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D8F1C20FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEFF12E5B;
	Mon, 18 Mar 2024 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QjmHT8gq"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515EAD23;
	Mon, 18 Mar 2024 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710722789; cv=fail; b=Rh0kW1x2DNpCtPWnp9MZ3e5YYT95LytHfbdlAYgUOpkLIihea711MWfl8ikp09RSddo3gN5TIOQxvZL8xbzK5Cuy37thfx4UBpT1h3/u1Hv0tmoyIkrYSY+jBxB98UESharRvWLUiYmM0n+5lb2zl+V62JBhclk2vISKuh1VDtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710722789; c=relaxed/simple;
	bh=w/KKRiOBrMmhc+RCFUiyuJw1ViDeeq5awCRLJ5zdkl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NHt9NwZ00uS4JBE/zmO7DWPcz0hM6jQAoMN4wzu8/ph16+BlXT07UxQj5aRXVyrntBNPOd+7u+KV/6IQvGPjSkZfp3oxSh6Pgun6nFQcQ3nsXLeiHMzrl4xZCO+uCSTjDX0g9OXIICHgGyatsVIHxjM69dZ3qeG2foSOIClnNuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QjmHT8gq; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42HM02Jo030419;
	Sun, 17 Mar 2024 17:46:08 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ww8skkfan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Mar 2024 17:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bultBWKEEdRDowBvxGXOCkzEOPb8YTpv1bIVXKUyNqlDHp0VBdh01NrBlWustVeDTOdkCebZ/3YgKaOXp6Hg5mHsOEBHG1AEtuy/Zl+O5IU9IBf2vblxqaHg9INY7lNWwbDU9UG5KuXfFslIWai5k5Q8qXb3uJ1YAnjKLdzf3jF5zQpVq4p73bDWl7wjRVwsBEDYtmBBtH+MPcvRf/voQy0n3I7JPYsXb2hR2/Kk5KvKlXw0WwyxNwyWpz2LkIXGWCY8vvJS0bL39+ai1P1c7fkFjnexl7KoGubF21Go40ut0/oCaxnDSWKYQHXLA7pjjQcml6PAuFsQiC1Z9CVdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/KKRiOBrMmhc+RCFUiyuJw1ViDeeq5awCRLJ5zdkl0=;
 b=Dj+Eh/k2mQhDXc4n4bM8w6JBXdhHuU2405/1AF2wAyLhlE2KMkwgOcLkcnYDXCh20OlcciV8dTm2TR/VDexWoEtaiQ4IhTFiHcGR03sWMpGirT2BzUREqBfPvyaSQZVZ6Rp6UVIAXdGBS0Az5/VxDyHCmC9BUTV6ymeb51OXoVvXkqz5+/3vvYM0fPiuLavOsyNDC11iLZqFAz6xkywH0w9DcpQbpsyabGPOOdf3k6D4TBwwqLFH/SiDGX516KIZsZYe7gVuxi2O5i78Sb7uOL6W2MeKW34B7i8/NCPwDaLLxcuLE56X0iKS48Tw7+jHLabAxhStrzyTTiEA1P1irA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/KKRiOBrMmhc+RCFUiyuJw1ViDeeq5awCRLJ5zdkl0=;
 b=QjmHT8gq1iVCyBrnrmGbJreagu2hu7XDWDESVhEvybfT9jl6/3AJVKDEO2OqNpGexCamGbwXs+xKVQHMSpdLfhxtQ6PgWW8mcUxbO9WUPn3dGj+HXJRZ6HyHz3PNKKu+lTcA5EjZWz0qK54+R2L+RmuN+THCebUlyIVU/IDovd8=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SJ0PR18MB4884.namprd18.prod.outlook.com (2603:10b6:a03:40b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 00:46:05 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::53cb:ffb5:18e2:5f63]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::53cb:ffb5:18e2:5f63%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 00:46:05 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Eric Dumazet <edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [v2 net PATCH] octeontx2-pf: Disable HW TSO for
 seg size < 16B
Thread-Topic: [EXTERNAL] Re: [v2 net PATCH] octeontx2-pf: Disable HW TSO for
 seg size < 16B
Thread-Index: AQHadRBUKDqOJ0qGxE2aEe+2MImyFrE1TikAgAdiNFA=
Date: Mon, 18 Mar 2024 00:46:05 +0000
Message-ID: 
 <CH0PR18MB4339C5BB21DB7E440A4E5362CD2D2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240313063306.32571-1-gakula@marvell.com>
 <CANn89i++jodT8mzqY82LuxL2WXA4DF6XD5nCmHcsAyKe22Jxbw@mail.gmail.com>
In-Reply-To: 
 <CANn89i++jodT8mzqY82LuxL2WXA4DF6XD5nCmHcsAyKe22Jxbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SJ0PR18MB4884:EE_
x-ms-office365-filtering-correlation-id: 0951b1a7-22e8-46df-34b1-08dc46e4cb4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XzIh54NX+HM7Ee7o/BMeiOYI4z4Q/QNws4D5e8C40yMET6i8gcgERKRMZHdOh7RR7Wbq/iMuzKjkL1N93osGcTTuEy5aFn+6Jj8oVaZsQ82WKowtPaQBCyjSpGhl4Q5xMu/sNHyczsUCQep3ahKxCKDGnU5B82tcqSU1DwQn1529ITX8lZD65rE3sYy9dEUJTe2fA24Pw2+nUVN5Wv7eciJ/nc+VwiuihmWsp0ZFeRj/rihZZdFXdC/LGKL6IZ0LvjhldlJce2ywF9vRUiZnqSfF3o7QGK/3VA8T447ZRdjuEEQPt4CNpV+K9Pq8lqkqkB5pGtO7/he2wHY4cdYuKrx6oFsdpvZwc/rfAem6XzNu/MbN9JamU8VWO5qYdVqVddq8eX/l3A0winuWNEAYhVZ9GZ8KAhMo3b1MO4+/kX2FxjMQeMIe/OOf0MdVR14uSklOB0N05e4xZP4gOM7bJxTOi78k6xkNcknL6bQ2pcR9Xm0FGRfgrgaEg1CU4KPRpO6eokNpxvl7Jcahx+z8CWtD6Qi82aAqBijO9xNoBgTiFgOUn4f90OOG4HlVXSpPjCfyHOALT3UlPNa3eiZQV8oI1fSDxgsHpV+n6UlBwWspUum3bsHFu/JrL/IFDPG6ZdY9bn8nlY66/cirvsuah+WnuHFx0tajCtncapwYH0cgl1CmmGbVuR5//+Rq6ukY7xVEXyvThrJgMPXLYyq0YGd4/8/ZnAB8uoJvNK520JE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QXZ3dDk4ZXYyV1VvcFRyNHRiQ2tJeUpNV09ZT2hUcUF6T3FYb1RQbXR6SEtR?=
 =?utf-8?B?V3VWMTBGaGNQem5RZEgxNHlPT0dNcG44TzBGblByVklEWFNYMTE5WHd1VDdD?=
 =?utf-8?B?c3Y4Sm1UUmFyc05ZV01aS2pTdHRha09jaDZLcHZlWkxjSVl0NEl3OXFYblF3?=
 =?utf-8?B?QmVzckdobHU2VW5zeDIzQitMSzJwY2JvZnV0YjJrRGVSajFQMUtWRVdIQ011?=
 =?utf-8?B?OFNQWmt2bDMvWG9LaklnVytKYlVIT1FaUWlZZHVNMm8rWTRMNTFTV1d0TCtU?=
 =?utf-8?B?OWFSejFvb3pOeUJLUzVCUmpVQkpDR0thbVNNM1U5Q0RIN0RFT1YzMUpydndE?=
 =?utf-8?B?YWlzRm8rdm1LL21wbFczdER1UkVyKzloN05aVFhSTWJVdmIyK2gzWEdkTjFp?=
 =?utf-8?B?SnQwbDNCbklHMmF3M3hWdnF2L0JicEtDTzJsaXJQS3NWYkFDaWF0OForSEYv?=
 =?utf-8?B?WnVueG1nZU5KbVpTWndxcTF6WXU3RGFoRWdhajdVbUpQMnlybmZyaFlDRUtX?=
 =?utf-8?B?TXF1TFV1dE1JMHVUc3lQcXZwSmJMdmtaQ21hV0J2U1d1a3gxbU0rcnU1VThL?=
 =?utf-8?B?TGtUSGlqa2lOaEVpdDNtZlVvbUFyMnlDYTdRajN2TGY4eW9SVkpRU0dmODBo?=
 =?utf-8?B?dVlmQXNRaXFhNWRuUDV5amxXaXptRzExb0F5amZhbWk0bTliMGhCSUN1OTkr?=
 =?utf-8?B?VkF0NTVlaTFjTElRV1FGVzlZdzhzMERqZWRIT0FuL0N0QnQ0TFVsTVBHWXVB?=
 =?utf-8?B?NTVLd25TUjFNam0vKytBcUZ3Q2U0SHlRVEFjNnhrUUYxL1lCTlRhZXFRZ0c2?=
 =?utf-8?B?NE9ORUxsckM3MFdPRjZRZE9MWDZaZTh4aDY5QjZZaWdqeVFEQUZyeTFTc1Np?=
 =?utf-8?B?N0hWMHhDZThpWEU4c1VIOXpwZXc5QzRIYS85LzVodk05blF3UWg2aWh0K2RC?=
 =?utf-8?B?ZWNBMGtmQWNGNytxaWU1bktBeU9icHdwcW5ZcTFhNUx6QVZvVHdUQ25jdnk3?=
 =?utf-8?B?OHRRQU9qWFJxS09tSllGZFNPMW0remFkTnlvK2s5LzBBUXBqL2lpZElhM3Vy?=
 =?utf-8?B?MUN0ajJDYVc0WXlaYUlhY0NmYnlxSDYyMGpDQjVZV0paYTdmTGFETFBENTl1?=
 =?utf-8?B?anNKcVFUa0RrMVZQRlpzOU1Td3Vld0hZTzNGeUFidmJjSXR0NHVSR3M4Skl2?=
 =?utf-8?B?bFZVNnlhS3lBRlJaZnpSbHFvWjFTZU5Kbm9NR2M2Q1IwNndWMjBsSmVUeUxU?=
 =?utf-8?B?dUY3cHpwZ0xQR3V1c2pMTHc5MHV2cThkVmErQ3BFSFFFU0ZhN0hnUG1ZeUZm?=
 =?utf-8?B?aUpEYldudGhoS3lIUGJqVHpNZk1md2ZVRFNndlB4NnpNdTlCMkY2Zko3Ylpx?=
 =?utf-8?B?U0NUY3RmMlVmaTI5OTBTMng4VU9FOS9qalorN0tjYmNEL2R6ZWFyOHlieUZL?=
 =?utf-8?B?NkUrclhSdUtlS1kwTGVvdGdmT3Z4L0grdTNjdkgrM0t5bFpnY3VjZy9FWnYy?=
 =?utf-8?B?dGZublZpeCtHRG1KUmRZamV0UGxjTitkcUtScXVtNVhFdkc5blFnQnA5UExT?=
 =?utf-8?B?VU05eTdiSkwxTzVIdXFrSGZwV3Q3VlpOdCtZVVM3cEhUcWV6cEhUSThBK0Fp?=
 =?utf-8?B?TWRSa1ZMM29HVExIWFVMR0JMV29QcU5KQXA3bHp1U1g3RThZZUR0ZDY4QWdQ?=
 =?utf-8?B?ei94NHFhUUV5MVp0dUc1QTRVRWtHT0JlZWR4ZmJQdXBmazdKQVJyeXNQUEth?=
 =?utf-8?B?MGhrQmhhOHZGU2VWTkt2Nm12SUZtMVdoMGZNeGNoS0hmRHdzaVdvNDR1dyt1?=
 =?utf-8?B?NkdITGw4QTBIVjFqS25qSjJmMW9GS3ZhZDJzaFFBVUp1cE5zOEhIeFM5Q2JU?=
 =?utf-8?B?RUZDQU9sZTc3Z2pCUWtFZXdidktoRWhZallyL2VsSWVEZG9QR1MxQzNnR0FU?=
 =?utf-8?B?ZHNlTVhKNGVIcEpkUVN3L0w3UFp5ZDEzUUpJRFNhaXdLc0xDeXVrVnNUR2Jn?=
 =?utf-8?B?OTdMK0RZRlRiWnI4Y256ZHhRVzRQdmVrdWdGeUVjY1ZHc2FMd0ZkWDMrWmtv?=
 =?utf-8?B?eEY2K1JwNWJXUFMvdWR3WlhrZWI1aFdvWnBBZHQ3NlVIbGtDdE9pVkNneGkw?=
 =?utf-8?Q?whIE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0951b1a7-22e8-46df-34b1-08dc46e4cb4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 00:46:05.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4f1WRkSEPaF4b2JYyuJDRbRQugJAXAaZN46So4mYgAFjEW4JanikytmzPxY4vk4Jtb/4E4XH2j6TyNT4rZtjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4884
X-Proofpoint-ORIG-GUID: MzsvO1YkTpr8A3IGKhqSAgWmHPeTIJfZ
X-Proofpoint-GUID: MzsvO1YkTpr8A3IGKhqSAgWmHPeTIJfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBEdW1hemV0IDxl
ZHVtYXpldEBnb29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDEzLCAyMDI0IDE6
MjggUE0NCj4gVG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+
IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBrdWJhQGtlcm5lbC5vcmc7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IHBhYmVuaUByZWRoYXQu
Y29tOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0NCj4gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgU3Vi
YmFyYXlhIFN1bmRlZXAgQmhhdHRhDQo+IDxzYmhhdHRhQG1hcnZlbGwuY29tPjsgSGFyaXByYXNh
ZCBLZWxhbSA8aGtlbGFtQG1hcnZlbGwuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBb
djIgbmV0IFBBVENIXSBvY3Rlb250eDItcGY6IERpc2FibGUgSFcgVFNPIGZvciBzZWcNCj4gc2l6
ZSA8IDE2Qg0KPiBPbiBXZWQsIE1hciAxMywgMjAyNCBhdCA3OjMz4oCvQU0gR2VldGhhIHNvd2ph
bnlhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gQ3VycmVudCBOSVgg
aGFyZHdhcmUgZG8gbm90IHN1cHBvcnQgVFNPIGZvciB0aGUgc2VnbWVudCBzaXplIGxlc3MgMTYN
Cj4gPiBieXRlcy4gVGhpcyBwYXRjaCBkaXNhYmxlIGh3IFRTTyBmb3Igc3VjaCBwYWNrZXRzLg0K
PiA+DQo+ID4gRml4ZXM6IDg2ZDc0NzYwNzhiOCAoIm9jdGVvbnR4Mi1wZjogVENQIHNlZ21lbnRh
dGlvbiBvZmZsb2FkIHN1cHBvcnQiKS4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHZWV0aGEgc293amFu
eWEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IHYxLXYyOg0KPiA+ICAt
IEFzIHN1Z2dlc3RlZCBieSBFcmljIER1bWF6ZXQgdXNlZCBuZG9fZmVhdHVyZXNfY2hlY2soKS4N
Cj4gPiAgLSBNb3ZlZCB0aGUgbWF4IGZhcmdtZW50cyBzdXBwb3J0IGNoZWNrIHRvIG5kb19mZWF0
dXJlc19jaGVjay4NCj4gPg0KPiA+ICAuLi4vbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfY29t
bW9uLmMgICAgICAgIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9tYXJ2ZWxsL29j
dGVvbnR4Mi9uaWMvb3R4Ml9jb21tb24uaCAgICAgICAgfCAgMyArKysNCj4gPiAgLi4uL2V0aGVy
bmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMgICB8ICAxICsNCj4gPiAgLi4uL2V0
aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3R4cnguYyB8IDExIC0tLS0tLS0tLS0t
DQo+ID4gIC4uLi9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml92Zi5jICAgfCAg
MSArDQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9v
Y3Rlb250eDIvbmljL290eDJfY29tbW9uLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21h
cnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX2NvbW1vbi5jDQo+ID4gaW5kZXggMDJkMGI3MDdhZWE1
Li5kZTYxYzY5MzcwYmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFy
dmVsbC9vY3Rlb250eDIvbmljL290eDJfY29tbW9uLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9jb21tb24uYw0KPiA+IEBAIC0yMjEs
NiArMjIxLDI0IEBAIGludCBvdHgyX3NldF9tYWNfYWRkcmVzcyhzdHJ1Y3QgbmV0X2RldmljZQ0K
PiA+ICpuZXRkZXYsIHZvaWQgKnApICB9ICBFWFBPUlRfU1lNQk9MKG90eDJfc2V0X21hY19hZGRy
ZXNzKTsNCj4gPg0KPiA+ICtuZXRkZXZfZmVhdHVyZXNfdA0KPiA+ICtvdHgyX2ZlYXR1cmVzX2No
ZWNrKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICBuZXRkZXZfZmVhdHVyZXNfdCBmZWF0dXJlcykgew0KPiA+ICsgICAg
ICAgLyogRHVlIHRvIGh3IGlzc3VlIHNlZ21lbnQgc2l6ZSBsZXNzIHRoYW4gMTYgYnl0ZXMNCj4g
PiArICAgICAgICAqIGFyZSBub3Qgc3VwcG9ydGVkLiBIZW5jZSBkbyBub3Qgb2ZmbG9hZCBzdWNo
IFRTTw0KPiA+ICsgICAgICAgICogc2VnbWVudHMuDQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAg
ICAgIGlmIChza2JfaXNfZ3NvKHNrYikgJiYgc2tiX3NoaW5mbyhza2IpLT5nc29fc2l6ZSA8IDE2
KQ0KPiA+ICsgICAgICAgICAgICAgICBmZWF0dXJlcyAmPSB+TkVUSUZfRl9HU09fTUFTSzsNCj4g
PiArDQo+ID4gKyAgICAgICBpZiAoc2tiX3NoaW5mbyhza2IpLT5ucl9mcmFncyArIDEgPiBPVFgy
X01BWF9GUkFHU19JTl9TUUUpDQo+ID4gKyAgICAgICAgICAgICAgIGZlYXR1cmVzICY9IH5ORVRJ
Rl9GX1NHOw0KPiA+ICsNCj4gDQo+IFRoaXMgaXMgYSBiaXQgZXh0cmVtZS4gSSB3b3VsZCBhdHRl
bXB0IHRvIHJlbW92ZSBORVRJRl9GX0dTT19NQVNLIGluc3RlYWQuDQo+IA0KPiBpZiAoc2tiX2lz
X2dzbyhza2IpKSB7DQo+ICAgICAgaWYgKHNrYl9zaGluZm8oc2tiKS0+Z3NvX3NpemUgPCAxNiB8
fA0KPiAgICAgICAgICBza2Jfc2hpbmZvKHNrYiktPm5yX2ZyYWdzICsgMSA+IE9UWDJfTUFYX0ZS
QUdTX0lOX1NRRSkpDQo+ICAgICAgICAgICAgZmVhdHVyZXMgJj0gfk5FVElGX0ZfR1NPX01BU0s7
IH0NCj4gDQo+IFRoaXMgd291bGQgdmVyeSBvZnRlbiBlbmQgdXAgd2l0aCAxLU1TUyBwYWNrZXRz
IHdpdGggZmV3ZXIgZnJhZ21lbnRzLg0KPiANCj4gLT4gTm8gY29weSBpbnZvbHZlZCwgYW5kIG5v
IGhpZ2ggb3JkZXIgcGFnZSBhbGxvY2F0aW9ucy4NCj4gDQo+ID4gKyAgICAgICByZXR1cm4gZmVh
dHVyZXM7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChvdHgyX2ZlYXR1cmVzX2NoZWNrKTsN
Cj4gPiArDQo+ID4gIGludCBvdHgyX2h3X3NldF9tdHUoc3RydWN0IG90eDJfbmljICpwZnZmLCBp
bnQgbXR1KSAgew0KPiA+ICAgICAgICAgc3RydWN0IG5peF9mcnNfY2ZnICpyZXE7DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgy
X2NvbW1vbi5oDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9u
aWMvb3R4Ml9jb21tb24uaA0KPiA+IGluZGV4IDA2OTEwMzA3MDg1ZS4uNmE0YmY0M2JjNzdlIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25p
Yy9vdHgyX2NvbW1vbi5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9v
Y3Rlb250eDIvbmljL290eDJfY29tbW9uLmgNCj4gPiBAQCAtOTYxLDYgKzk2MSw5IEBAIHZvaWQg
b3R4Ml9nZXRfbWFjX2Zyb21fYWYoc3RydWN0IG5ldF9kZXZpY2UNCj4gPiAqbmV0ZGV2KTsgIHZv
aWQgb3R4Ml9jb25maWdfaXJxX2NvYWxlc2Npbmcoc3RydWN0IG90eDJfbmljICpwZnZmLCBpbnQN
Cj4gPiBxaWR4KTsgIGludCBvdHgyX2NvbmZpZ19wYXVzZV9mcm0oc3RydWN0IG90eDJfbmljICpw
ZnZmKTsgIHZvaWQNCj4gPiBvdHgyX3NldHVwX3NlZ21lbnRhdGlvbihzdHJ1Y3Qgb3R4Ml9uaWMg
KnBmdmYpOw0KPiA+ICtuZXRkZXZfZmVhdHVyZXNfdCBvdHgyX2ZlYXR1cmVzX2NoZWNrKHN0cnVj
dCBza19idWZmICpza2IsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbmV0ZGV2X2ZlYXR1cmVzX3QgZmVhdHVyZXMpOw0KPiA+DQo+ID4gIC8qIFJW
VSBibG9jayByZWxhdGVkIEFQSXMgKi8NCj4gPiAgaW50IG90eDJfYXR0YWNoX25wYV9uaXgoc3Ry
dWN0IG90eDJfbmljICpwZnZmKTsgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfcGYuYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfcGYuYw0KPiA+IGluZGV4IGU1ZmU2N2U3
Mzg2NS4uMjM2NGViOGQ2NzMyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvb2N0ZW9udHgyL25pYy9vdHgyX3BmLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5jDQo+ID4gQEAgLTI3MzcsNiAr
MjczNyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMNCj4gb3R4Ml9uZXRk
ZXZfb3BzID0gew0KPiA+ICAgICAgICAgLm5kb194ZHBfeG1pdCAgICAgICAgICAgPSBvdHgyX3hk
cF94bWl0LA0KPiA+ICAgICAgICAgLm5kb19zZXR1cF90YyAgICAgICAgICAgPSBvdHgyX3NldHVw
X3RjLA0KPiA+ICAgICAgICAgLm5kb19zZXRfdmZfdHJ1c3QgICAgICAgPSBvdHgyX25kb19zZXRf
dmZfdHJ1c3QsDQo+ID4gKyAgICAgICAubmRvX2ZlYXR1cmVzX2NoZWNrICAgICA9IG90eDJfZmVh
dHVyZXNfY2hlY2ssDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGludCBvdHgyX3dxX2luaXQo
c3RydWN0IG90eDJfbmljICpwZikgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdHhyeC5jDQo+ID4gYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4gPiBpbmRleCBmODI4
ZDMyNzM3YWYuLjliODlhZmY0MmViMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4gPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml90eHJ4LmMNCj4gPiBAQCAt
MTE1OCwxNyArMTE1OCw2IEBAIGJvb2wgb3R4Ml9zcV9hcHBlbmRfc2tiKHN0cnVjdCBuZXRfZGV2
aWNlDQo+ID4gKm5ldGRldiwgc3RydWN0IG90eDJfc25kX3F1ZXVlICpzcSwNCj4gPg0KPiA+ICAg
ICAgICAgbnVtX3NlZ3MgPSBza2Jfc2hpbmZvKHNrYiktPm5yX2ZyYWdzICsgMTsNCj4gPg0KPiA+
IC0gICAgICAgLyogSWYgU0tCIGRvZXNuJ3QgZml0IGluIGEgc2luZ2xlIFNRRSwgbGluZWFyaXpl
IGl0Lg0KPiA+IC0gICAgICAgICogVE9ETzogQ29uc2lkZXIgYWRkaW5nIEpVTVAgZGVzY3JpcHRv
ciBpbnN0ZWFkLg0KPiA+IC0gICAgICAgICovDQo+ID4gLSAgICAgICBpZiAodW5saWtlbHkobnVt
X3NlZ3MgPiBPVFgyX01BWF9GUkFHU19JTl9TUUUpKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGlm
IChfX3NrYl9saW5lYXJpemUoc2tiKSkgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGRl
dl9rZnJlZV9za2JfYW55KHNrYik7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IHRydWU7DQo+ID4gLSAgICAgICAgICAgICAgIH0NCj4gPiAtICAgICAgICAgICAgICAgbnVtX3Nl
Z3MgPSBza2Jfc2hpbmZvKHNrYiktPm5yX2ZyYWdzICsgMTsNCj4gPiAtICAgICAgIH0NCj4gDQo+
IFRoZW4geW91IG5lZWQgdG8ga2VlcCB0aGlzIGNoZWNrIGZvciAgbm9uIEdTTyBwYWNrZXRzLg0K
PiANCj4gT25lIHdheSB0byB0cmlnZ2VyIHRoaXMgaXMgdG8gcnVuIG5ldHBlcmYgd2l0aCB0aW55
IGZyYWdtZW50cy4NCj4gVENQIGlzIHVuYWJsZSB0byBjb29rIEdTTyBwYWNrZXRzLCBiZWNhdXNl
IHdlIGhpdCBNQVhfU0tCX0ZSQUdTIGJlZm9yZQ0KPiBldmVuIGZpbGxpbmcgYSBzaW5nbGUgTVNT
Lg0KPiANCj4gbmV0cGVyZiAtSCAkcmVtb3RlIC10IFRDUF9TRU5ERklMRSAtLSAtbSAxMA0KPiAN
CldpbGwgcmVwb3N0IHRoZSBwYXRjaCB3aXRoIHN1Z2dlc3RlZCBjaGFuZ2VzIGFuZCB0ZXN0aW5n
Lg0KPiANCj4gDQo+ID4gLQ0KPiA+ICAgICAgICAgaWYgKHNrYl9zaGluZm8oc2tiKS0+Z3NvX3Np
emUgJiYgIWlzX2h3X3Rzb19zdXBwb3J0ZWQocGZ2Ziwgc2tiKSkgew0KPiA+ICAgICAgICAgICAg
ICAgICAvKiBJbnNlcnQgdmxhbiB0YWcgYmVmb3JlIGdpdmluZyBwa3QgdG8gdHNvICovDQo+ID4g
ICAgICAgICAgICAgICAgIGlmIChza2Jfdmxhbl90YWdfcHJlc2VudChza2IpKSBkaWZmIC0tZ2l0
DQo+ID4gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml92
Zi5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4
Ml92Zi5jDQo+ID4gaW5kZXggMzVlMDYwNDgzNTZmLi4wNGFhYjA0ZTRiYTIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9vY3Rlb250eDIvbmljL290eDJfdmYu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZlbGwvb2N0ZW9udHgyL25pYy9v
dHgyX3ZmLmMNCj4gPiBAQCAtNDgzLDYgKzQ4Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmV0
X2RldmljZV9vcHMNCj4gb3R4MnZmX25ldGRldl9vcHMgPSB7DQo+ID4gICAgICAgICAubmRvX3R4
X3RpbWVvdXQgPSBvdHgyX3R4X3RpbWVvdXQsDQo+ID4gICAgICAgICAubmRvX2V0aF9pb2N0bCAg
PSBvdHgyX2lvY3RsLA0KPiA+ICAgICAgICAgLm5kb19zZXR1cF90YyA9IG90eDJfc2V0dXBfdGMs
DQo+ID4gKyAgICAgICAubmRvX2ZlYXR1cmVzX2NoZWNrICAgICA9IG90eDJfZmVhdHVyZXNfY2hl
Y2ssDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGludCBvdHgyX3dxX2luaXQoc3RydWN0IG90
eDJfbmljICp2ZikNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=

