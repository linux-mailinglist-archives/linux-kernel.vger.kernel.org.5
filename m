Return-Path: <linux-kernel+bounces-15186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA9A822813
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D32B22C02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A241798F;
	Wed,  3 Jan 2024 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="Vzo9t6ux"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B3168DC;
	Wed,  3 Jan 2024 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZQNs+PRHpNb6eIpp7kL50gamJyg1TweioDIU7MXmUFyqc3DmxKyiXx7pF6zDPyAAlb4CdV7brZmK7R2bO++jLxbYRySF74jlW03wX0cCZyWURFpZAm3YnMbceVV85+xAMQgVwPtx70WPuLdN/R3LVCV1rJ0ChCvgK8xL67UIEoTO2v/IjFkPe/h4gfTp5qxPts60YDU5f4tq/eLSXr7ImqXXFJ+jF6ez8DL5wX4sBTA1n0AaoKpYFiU77a6XG76xt8nfs2VjwqJAcD9JUJslWHSU5KnBtboKinwngXhkB9AG404PRZ7jCs5uI2emrPZxjaeD4JOAUck/TsMDS98QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOATxj3gAn1ZUclxGASVU/0MgJ/v5O6R+ufHOv+3mk0=;
 b=JyK7V/5bLwNddH9lfVsLVF1tH0g/zkS43sBvxdj0DxSJXhCyLfN04OdSVtCBcodBJO+Fuk3ZTCKk89EEvd2+7hAhnkI2DvGu3yhVj54GK16Cr+EQCYWOCMVCe8GSA975AgGOG60JPIyAI3LKbd1VM0SoXGhioytutQ1+xrC+5O1pvccG0etIWoIydiSKcXU1pJTpC6nOTgEkfVbfghTwlecXcMsaQFm3WF3n+x2c/YUfoUi5MRVd6D+P5yi1/ph4haRBpWq9VX+YRI6eSVaf0iBH9likcF7nNGn99SgEzi1hw6xukrCl168Fwaqt7cxhXYrHwI3jZwFaMYa/62EUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOATxj3gAn1ZUclxGASVU/0MgJ/v5O6R+ufHOv+3mk0=;
 b=Vzo9t6uxUFNOBJW8MPtBoGsDlOHH3lVY2Q9QKTA3RKXrjo28m7C296IiutFuShSAo0Baz+SAV0QZzw177xZzxZkQIWJ7IwTh2yKvpB6r6JDVjGx3KCnOkAE58V/roR7n4esQ9jRd/eaGi8LtPnCy6XCOSsdTGbhwNNnzRwImegxLtrKxo4enrkzq3U0Mgbp/YKXQtuxDVzeNi4LC5UR572xGJn8hdRsNC+0DJt+Pk3wTk/QE0QfXA0hahOlsCCXEwWhXPnDMzoGGtrMLeCNRcUGP1J8X2i5Q44FaPYmed684K3R6l5+Af/TAaYBENp6zEPk5uF11WnBbemMq6jmOVQ==
Received: from PH0PR08MB7955.namprd08.prod.outlook.com (2603:10b6:510:11a::17)
 by DM6PR08MB6236.namprd08.prod.outlook.com (2603:10b6:5:1e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12; Wed, 3 Jan
 2024 05:26:32 +0000
Received: from PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::5049:9abf:ad65:9974]) by PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::5049:9abf:ad65:9974%3]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 05:26:32 +0000
From: Srinivasulu Thanneeru <sthanneeru@micron.com>
To: "Huang, Ying" <ying.huang@intel.com>, gregory.price
	<gregory.price@memverge.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "aneesh.kumar@linux.ibm.com"
	<aneesh.kumar@linux.ibm.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"tj@kernel.org" <tj@kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, Vinicius Tavares Petrucci
	<vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Wei Xu <weixugc@google.com>
Subject: RE: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Thread-Topic: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Thread-Index: AQHaLe1WCWEmLbBSRk2O5Sdey42WeLCpzLPHgADTuACAA/H6xIAZGhOA
Date: Wed, 3 Jan 2024 05:26:32 +0000
Message-ID:
 <PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
 <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=1871acef-68e6-4a74-bff7-df01830ee16b;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2024-01-03T05:17:36Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR08MB7955:EE_|DM6PR08MB6236:EE_
x-ms-office365-filtering-correlation-id: a1ca4657-39bf-4289-4b52-08dc0c1c8bbc
x-ld-processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 g1qOLgjpqCV+F+lzp5mMjM1N7nPA0ADx2SJgu1fkEomtCXRki0LphVuck3hhF/ejV8qIDezE448uu8Nnn2sfpl6xLdoJKFFdFy2PNVyopoc/Qy4M1B/W5dvxrFWdRqpsl4AesYcURUkJiLthRzdze3lyKbVKdgRoBvtkcwimwt1Qk+bOLUaV8OO+G6Gq2Nd/uagMgN7airZqlCFC48c+Jb65m1tRQTZXsKf9eKchVz5IdZVd5RHo39AE5I7zVDCiKRWw9WFznWzuMrQ6sK6fLQxzpT82fHY1Kr8Sk49jw+EQzGFE3mMYklaz5LLRA0cV2ikaHMmne6fcdqj8VqBx6BwGzZ8qLlcQlw7pgpTkg/ynpLJQx/IKf/v/ecFq2ZAak/YmKMlg0ZWOzWjz/HCIu/4oUIFmzOLGB1TwoD6sBQmGHRAFO8mEh4FHx27h5szkNi3KQXqimrxQWNTIzlvLnQuaHm2TdAXK6PP4cYWKvO50TxmpflpThVQEPX+l3zwnAukhx7XWe8TbCtvF3QhXkrFyPkrcrr0b3bbZoMhoY8ImSFm0cKZETQLb4S8uzWRRB6CMdyLdY34Ah+sqhs6doO3B6sSScic++rdAx4fHaTbYP11QnlbxCksxGF4qrO7Wpo5+knj9ZhmajmgNS/TFvA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7955.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(66446008)(76116006)(66946007)(64756008)(66556008)(4326008)(110136005)(8676002)(8936002)(54906003)(316002)(26005)(83380400001)(966005)(71200400001)(45080400002)(478600001)(9686003)(53546011)(7696005)(52536014)(2906002)(5660300002)(41300700001)(7416002)(6506007)(33656002)(38070700009)(122000001)(66899024)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?Wm1nUWtqOElRUURlcEdCc1RoUFNuSnZhb2VyUnpnVzZidXJ4R0E4cVpDdmdN?=
 =?utf-7?B?YzVuM0JESmVJZ3RtV3RFRDJBR3ZzbFhxd2ZhNldsOFhRTEJMZ1RhQmkrLVFt?=
 =?utf-7?B?azNRTWZ4TnpzWmk0L3Zzdm0xSmxGTUpueFFjdTVDRDQvbHhYUTdURGtMNFQ=?=
 =?utf-7?B?Ky1kQXJlUFI0bHRmQ2VJNHNPZGRocEtCTng4QkN5R3J4eE1icGVrVFVwbHJR?=
 =?utf-7?B?LzdaKy1tNE43Mjd0MTRLTlZTL2ZLa3ZNeGtEaDY1QXZxTWl3b2c0QlYvNFBY?=
 =?utf-7?B?THpCSEtjUVpCQ0VuV2NaYXdoY0cxa3dPcVF1L1RIYzlZcWtOak8xSzZoNDZJ?=
 =?utf-7?B?Z1diQnJoNCstU21RVmRNTGtyYzB2TmtQQUpSaXh2OTM5WEs4M3hHNDhmTTJp?=
 =?utf-7?B?THRXOGpEdnNvN1V1alJNSEdXVFN4ZnBIdEY2d3FRVjJ3bFN4amFEM3dPNTEv?=
 =?utf-7?B?SVRhNnJBeXVyZkJTMy82Wm9GZElJcWpkeUh6aDJweXBsR2VGTW1XeThYQVJT?=
 =?utf-7?B?Q0pNUVBtRlNHOUZLb2doZEh3cVh4RjBtQ2ZCZ0dxZkFLcUtjbHVHS0h4dVhY?=
 =?utf-7?B?NWlFY2NoSUpjTDRnTW5xTTVhR0syWmRZNjlOc2pCeFkzWi93RU9mL2p0MVNs?=
 =?utf-7?B?RVdYZTJnSGJwNnYxb3dKb0RzUEF0QVlOSnJxa0ZBdWV4Ulc1MW9NRCstSXc1?=
 =?utf-7?B?elRvM0MxRkZMZExscXpESEtYOFpHOHFzaHY0MkZock1oOVlDVSstSEd5UExY?=
 =?utf-7?B?d3JnMGpIMmEyRUs1NnhGWjluS2xNMnE0TjR3S0hYblBUTVNnQ04rLUczQzY=?=
 =?utf-7?B?ZystS2hyaHBSbE1oeW5xMlNqNFVpNG9jeW9BWWV2UjVydXcxRnRvVDV3dVhu?=
 =?utf-7?B?V0VJTUdqNzE1UUE5bUs4TG5oYzRENFMwYkVQdHk0VHBTTkpQeUQ1c3dPdTlT?=
 =?utf-7?B?aUozZmVKb3VsNi9EemZaTXpxMXJPZ3l0aFNTbmtlL3FINlVUeFJjQW9nUjB2?=
 =?utf-7?B?d3BCczJaT2RDS2c3SGdvYW5SZ1VtS3k0aXFYTnEvRWVHV21rbGl0M0d6L084?=
 =?utf-7?B?ZkJhM3Nzb2daTUdqTFE5T1N5ckF2V3NTS3UwMjdxeUNOMmNSR2Q1cEF6blNU?=
 =?utf-7?B?aW8rLW01Tk5uVDlrMFhicEVrNU05RlR6MXRDNUh0QVJPdmtmV1E5S2ZBSk43?=
 =?utf-7?B?bVZ5RXEwYkcyUjgrLVUvbUt1UE4xY1FUenY4cXRqOEtlVk1NWXdhOGZtb1V5?=
 =?utf-7?B?QTdhZU9OKy1DM25pM21Wc1hTOXRuQ1lld08xZmREejVFc255L3pBUEJoakdw?=
 =?utf-7?B?QUNsblNMYWthOE9RNks3YzRiYkE3ZFNzOUswZE9waGJsQ1VSeGRxT1QvMDNq?=
 =?utf-7?B?eG54NDhlcVFDYjdCeGN4UTZqd1dWNkhhYzY2SW1qaHRpZDRXQmlqa3NZWG1M?=
 =?utf-7?B?VVNsV3lPMDJMemRRbVNMZkpxYmFodzJ2MUtNNUp2bistTjQwTEUrLWFKU2xU?=
 =?utf-7?B?TmFKMUsvdGdCRTR2UnVqeEJrWng5ZXpEUXpvL2hHRHh4c1loWDVVNWFnL08=?=
 =?utf-7?B?Ky1wbDlkS1ZXbC9oL08vQmtZNHBDZjFmU3ZVZS9mNGw2ai9vOWI3NHBNR2pr?=
 =?utf-7?B?cCstNTc5REp5dkU0VkswMVhlYzE5ai9Qem1Rbnk3bDB5YlNwS2tycG5iVy83?=
 =?utf-7?B?eUY0Ly8zdThCcURTN0s0SkNpRnZEckVnYURWZ1lnSS9ySUFxVE1xRVZHSXRE?=
 =?utf-7?B?SmJnTjZqbVVsMjB1eGt1QVZMeDlQTWk0Um5leGJTR01vUWtvNjlMYkk0RU1X?=
 =?utf-7?B?NzlWS0xLQkhHNWxkSnNLbzNaTmIxM1o5SkhTQjJtMCstNTBMYmtueistVXFR?=
 =?utf-7?B?bjFlU3hvc25jKy05OTRkSFZNTGt4ZkJnakcxS0VJVEE2MTc2WC9JMHdlZXc4?=
 =?utf-7?B?TERUMUFYSUM2aGJXSystbXNiTEUzdDg1Ky1QUDAxOENzMmFqN0Q5R3NsczFw?=
 =?utf-7?B?elhRU2t2VlM3czYrLTJpVFcvSkF1bVdyTHg3TTlVZndBQUUrLVVZVkJLYkZh?=
 =?utf-7?B?SGpNSk4zeFhkbERqNnI2WFp1TGtEb2VnY2dOVWZXdURQNU1BelcvcEZ6UXk0?=
 =?utf-7?B?ZU53NFBldUhZKy1xbkdRZEJ5L0U3WU94MzVCbVA5ZjRZaWdYRWdhTnlEd0tn?=
 =?utf-7?B?MWFxcVlD?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7955.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ca4657-39bf-4289-4b52-08dc0c1c8bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 05:26:32.2648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mqks+FTcp1EK+GfVfObFbMWoa01uuO9iFkLu86mMHfjqhOlzcZIzaFBQO+BA12qvIQEF2Zu2NboKql28sGP/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB6236

Micron Confidential

Hi Huang, Ying,

My apologies for wrong mail reply format, my mail client settings got chang=
ed on my PC.
Please find comments bellow inline.

Regards,
Srini


Micron Confidential
+AD4- -----Original Message-----
+AD4- From: Huang, Ying +ADw-ying.huang+AEA-intel.com+AD4-
+AD4- Sent: Monday, December 18, 2023 11:26 AM
+AD4- To: gregory.price +ADw-gregory.price+AEA-memverge.com+AD4-
+AD4- Cc: Srinivasulu Opensrc +ADw-sthanneeru.opensrc+AEA-micron.com+AD4AOw=
- linux-
+AD4- cxl+AEA-vger.kernel.org+ADs- linux-mm+AEA-kvack.org+ADs- Srinivasulu =
Thanneeru
+AD4- +ADw-sthanneeru+AEA-micron.com+AD4AOw- aneesh.kumar+AEA-linux.ibm.com=
+ADs-
+AD4- dan.j.williams+AEA-intel.com+ADs- mhocko+AEA-suse.com+ADs- tj+AEA-ker=
nel.org+ADs-
+AD4- john+AEA-jagalactic.com+ADs- Eishan Mirakhur +ADw-emirakhur+AEA-micro=
n.com+AD4AOw- Vinicius
+AD4- Tavares Petrucci +ADw-vtavarespetr+AEA-micron.com+AD4AOw- Ravis OpenS=
rc
+AD4- +ADw-Ravis.OpenSrc+AEA-micron.com+AD4AOw- Jonathan.Cameron+AEA-huawei=
.com+ADs- linux-
+AD4- kernel+AEA-vger.kernel.org+ADs- Johannes Weiner +ADw-hannes+AEA-cmpxc=
hg.org+AD4AOw- Wei Xu
+AD4- +ADw-weixugc+AEA-google.com+AD4-
+AD4- Subject: +AFs-EXT+AF0- Re: +AFs-RFC PATCH v2 0/2+AF0- Node migration =
between memory tiers
+AD4-
+AD4- CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unles=
s
+AD4- you recognize the sender and were expecting this message.
+AD4-
+AD4-
+AD4- Gregory Price +ADw-gregory.price+AEA-memverge.com+AD4- writes:
+AD4-
+AD4- +AD4- On Fri, Dec 15, 2023 at 01:02:59PM +-0800, Huang, Ying wrote:
+AD4- +AD4APg- +ADw-sthanneeru.opensrc+AEA-micron.com+AD4- writes:
+AD4- +AD4APg-
+AD4- +AD4APg- +AD4- +AD0APQA9AD0APQA9AD0APQA9AD0APQA9AD0-
+AD4- +AD4APg- +AD4- Version Notes:
+AD4- +AD4APg- +AD4-
+AD4- +AD4APg- +AD4- V2 : Changed interface to memtier+AF8-override from ad=
istance+AF8-offset.
+AD4- +AD4APg- +AD4- memtier+AF8-override was recommended by
+AD4- +AD4APg- +AD4- 1. John Groves +ADw-john+AEA-jagalactic.com+AD4-
+AD4- +AD4APg- +AD4- 2. Ravi Shankar +ADw-ravis.opensrc+AEA-micron.com+AD4-
+AD4- +AD4APg- +AD4- 3. Brice Goglin +ADw-Brice.Goglin+AEA-inria.fr+AD4-
+AD4- +AD4APg-
+AD4- +AD4APg- It appears that you ignored my comments for V1 as follows ..=
.
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- https://lore.k/
+AD4- ernel.org+ACU-2Flkml+ACU-2F87o7f62vur.fsf+ACU-40yhuang6-
+AD4- desk2.ccr.corp.intel.com+ACU-2F+ACY-data+AD0-05+ACU-7C02+ACU-7Csthann=
eeru+ACU-40micron.com
+AD4- +ACU-7C5e614e5f028342b6b59c08dbff8e3e37+ACU-7Cf38a5ecd28134862b11bac1=
d56
+AD4- 3c806f+ACU-7C0+ACU-7C0+ACU-7C638384758666895965+ACU-7CUnknown+ACU-7CT=
WFpbGZsb3d
+AD4- 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0+ACU-=
3
+AD4- D+ACU-7C3000+ACU-7C+ACU-7C+ACU-7C+ACY-sdata+AD0-OpMkYCar+ACU-2Fv8uHb7=
AvXbmaNltnXeTvcNUTi
+AD4- bLhwV12Fg+ACU-3D+ACY-reserved+AD0-0

Thank you, Huang, Ying for pointing to this.
https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Live+A=
CU-20In+ACU-20a+ACU-20World+ACU-20With+ACU-20Multiple+ACU-20Memory+ACU-20Ty=
pes.pdf

In the presentation above, the adistance+AF8-offsets are per memtype.
We believe that adistance+AF8-offset per node is more suitable and flexible=
.
since we can change it per node. If we keep adistance+AF8-offset per memtyp=
e,
then we cannot change it for a specific node of a given memtype.

+AD4- +AD4APg-
+AD4- https://lore.k/
+AD4- ernel.org+ACU-2Flkml+ACU-2F87jzpt2ft5.fsf+ACU-40yhuang6-
+AD4- desk2.ccr.corp.intel.com+ACU-2F+ACY-data+AD0-05+ACU-7C02+ACU-7Csthann=
eeru+ACU-40micron.com
+AD4- +ACU-7C5e614e5f028342b6b59c08dbff8e3e37+ACU-7Cf38a5ecd28134862b11bac1=
d56
+AD4- 3c806f+ACU-7C0+ACU-7C0+ACU-7C638384758666895965+ACU-7CUnknown+ACU-7CT=
WFpbGZsb3d
+AD4- 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0+ACU-=
3
+AD4- D+ACU-7C3000+ACU-7C+ACU-7C+ACU-7C+ACY-sdata+AD0-O0+ACU-2B6T+ACU-2FgU0=
TicCEYBac+ACU-2FAyjOLwAeouh
+AD4- D+ACU-2BcMI+ACU-2BflOsI1M+ACU-3D+ACY-reserved+AD0-0

Yes, memory+AF8-type would be grouping the related memories together as sin=
gle tier.
We should also have a flexibility to move nodes between tiers, to address t=
he issues.
described in use cases above.

+AD4- +AD4APg-
+AD4- https://lore.k/
+AD4- ernel.org+ACU-2Flkml+ACU-2F87a5qp2et0.fsf+ACU-40yhuang6-
+AD4- desk2.ccr.corp.intel.com+ACU-2F+ACY-data+AD0-05+ACU-7C02+ACU-7Csthann=
eeru+ACU-40micron.com
+AD4- +ACU-7C5e614e5f028342b6b59c08dbff8e3e37+ACU-7Cf38a5ecd28134862b11bac1=
d56
+AD4- 3c806f+ACU-7C0+ACU-7C0+ACU-7C638384758666895965+ACU-7CUnknown+ACU-7CT=
WFpbGZsb3d
+AD4- 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0+ACU-=
3
+AD4- D+ACU-7C3000+ACU-7C+ACU-7C+ACU-7C+ACY-sdata+AD0-W+ACU-2FWcAD4b9od+ACU=
-2BS0zIak+ACU-2Bv5hkjFG1Xcf
+AD4- 6p8q3xwmspUiI+ACU-3D+ACY-reserved+AD0-0

This patch provides a way to move a node to the correct tier.
We observed in test setups where DRAM and CXL are put under the same.
tier (memory+AF8-tier4).
By using this patch, we can move the CXL node away from the DRAM-linked (me=
mory+AF8-tier4)
and put it in the desired tier.

+AD4- +AD4APg-
+AD4- +AD4-
+AD4- +AD4- Not speaking for the group, just chiming in because i'd discuss=
ed it
+AD4- +AD4- with them.
+AD4- +AD4-
+AD4- +AD4- +ACI-Memory Type+ACI- is a bit nebulous.  Is a Micron Type-3 wi=
th performance X
+AD4- +AD4- and an SK Hynix Type-3 with performance Y a +ACI-Different type=
+ACI-, or are
+AD4- +AD4- they the +ACI-Same Type+ACI- given that they're both Type 3 bac=
ked by some form
+AD4- +AD4- of DDR?  Is socket placement of those devices relevant for dete=
rmining
+AD4- +AD4- +ACI-Type+ACI-?  Is whether they are behind a switch relevant f=
or determining
+AD4- +AD4- +ACI-Type+ACI-? +ACI-Type+ACI- is frustrating when everything w=
e're talking about
+AD4- +AD4- managing is +ACI-Type-3+ACI- with difference performance.
+AD4- +AD4-
+AD4- +AD4- A concrete example:
+AD4- +AD4- To the system, a Multi-Headed Single Logical Device (MH-SLD) lo=
oks
+AD4- +AD4- exactly the same as an standard SLD.  I may want to have some
+AD4- +AD4- combination of local memory expansion devices on the majority o=
f my
+AD4- +AD4- expansion slots, but reserve 1 slot on each socket for a connec=
tion to
+AD4- +AD4- the MH-SLD.   As of right now: There is no good way to differen=
tiate the
+AD4- +AD4- devices in terms of +ACI-Type+ACI- - and even if you had that, =
the tiering
+AD4- +AD4- system would still lump them together.
+AD4- +AD4-
+AD4- +AD4- Similarly, an initial run of switches may or may not allow enum=
eration
+AD4- +AD4- of devices behind it (depends on the configuration), so you may=
 end up
+AD4- +AD4- with a static numa node that +ACI-looks like+ACI- another SLD -=
 despite it being
+AD4- +AD4- some definition of +ACI-GFAM+ACI-.  Do number of hops matter in=
 determining
+AD4- +AD4- +ACI-Type+ACI-?
+AD4-
+AD4- In the original design, the memory devices of same memory type are
+AD4- managed by the same device driver, linked with system in same way
+AD4- (including switches), built with same media.  So, the performance is
+AD4- same too.  And, same as memory tiers, memory types are orthogonal to
+AD4- sockets.  Do you think the definition itself is clear enough?
+AD4-
+AD4- I admit +ACI-memory type+ACI- is a confusing name.  Do you have some =
better
+AD4- suggestion?
+AD4-
+AD4- +AD4- So I really don't think +ACI-Type+ACI- is useful for determinin=
g tier placement.
+AD4- +AD4-
+AD4- +AD4- As of right now, the system lumps DRAM nodes as one tier, and p=
retty
+AD4- +AD4- much everything else as +ACI-the other tier+ACI-. To me, this p=
atch set is an
+AD4- +AD4- initial pass meant to allow user-control over tier composition =
while
+AD4- +AD4- the internal mechanism is sussed out and the environment develo=
ps.
+AD4-
+AD4- The patchset to identify the performance of memory devices and put th=
em
+AD4- in proper +ACI-memory types+ACI- and memory tiers via HMAT has been m=
erged by
+AD4- v6.7-rc1.
+AD4-
+AD4-       07a8bdd4120c (memory tiering: add abstract distance calculation
+AD4- algorithms management, 2023-09-26)
+AD4-       d0376aac59a1 (acpi, hmat: refactor hmat+AF8-register+AF8-target=
+AF8-initiators(),
+AD4- 2023-09-26)
+AD4-       3718c02dbd4c (acpi, hmat: calculate abstract distance with HMAT=
, 2023-09-
+AD4- 26)
+AD4-       6bc2cfdf82d5 (dax, kmem: calculate abstract distance with gener=
al
+AD4- interface, 2023-09-26)
+AD4-
+AD4- +AD4- In general, a release valve that lets you redefine tiers is ver=
y welcome
+AD4- +AD4- for testing and validation of different setups while the indust=
ry evolves.
+AD4- +AD4-
+AD4- +AD4- Just my two cents.
+AD4-
+AD4- --
+AD4- Best Regards,
+AD4- Huang, Ying

