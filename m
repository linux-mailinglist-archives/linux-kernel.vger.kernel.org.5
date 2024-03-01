Return-Path: <linux-kernel+bounces-88136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF5B86DDC7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5161C20B64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E26A32A;
	Fri,  1 Mar 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FQshSu64";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Kan20sAv"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E36A03E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283708; cv=fail; b=ZnZtwdvCeJtFbMjxuuca6nrVDFsV98zWgyY48Nvxj/+RHVw0aTOqYCnA2RkSnMjoOa2n+qBAIjacPEWtNi/ZUFmwvljdvI1ltaU9/ZsSwJo77yu4TuyGsFINlS36o4NytpoUcRgooxzAGPH+f9Ovt2P4A83XjNEExEv7QOB1Ih8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283708; c=relaxed/simple;
	bh=PYh94f3ceMR4NbL7GGlR5bnRh4a6lP5iUC6Nk4IMxHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUYY0zZ0eBP1SyeyCAYAN8YVGVLXlEUZK1u1c5ZuoyTFcFEzz2p++LWUom3DWDeexYsxOAtJntLnrRrl3mNA6KeWMNq5z9QjZA5RUhyPNDL8omNe4F7sqR5KXqhmEYNOgdMtUTXvCGkasCewTDahM99qLhABSlioYs/G7GkjMqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FQshSu64; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Kan20sAv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4f81475cd7aa11ee935d6952f98a51a9-20240301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PYh94f3ceMR4NbL7GGlR5bnRh4a6lP5iUC6Nk4IMxHA=;
	b=FQshSu64MF7xXwoPk71wRrO93rdAAukRSYR5YLEQ9dum6m87xmrlrkD99/zC7bUFqH8BnHCYtRHolWfKygYOsIoSsGKMdbTSsG4VurANbdLjhh3dviGFnBBTpTYo0dwgxGlDIlpTBQYYKtrq+o6ST0O2RapbAADHKPqZbK/8+XM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:371fb92c-9a3d-4f68-874e-e4ac7d6b3a0c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:4cd1e58f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4f81475cd7aa11ee935d6952f98a51a9-20240301
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2017060028; Fri, 01 Mar 2024 17:01:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Mar 2024 17:01:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Mar 2024 17:01:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5TS1Qoido0kvEmpl13O4cFBbF24faDHTFTVkWKw/qRxPKWuzIvf4sDoA25OwiMawVI0Q56G1E/c3KviapxIQ1/zeYgibKbGspzGW2lFL2IaQIww7xYbxzeeryAuWkhnz6jjAf0Jt0LmEFNcr6a0tojtBo4cgC+0pJLENUIqa5ayv9AD44mB3xFofXlnFHfQuavRmw7lSybE0u27ELqTk/7RlXwAujYl0tRV6NG/k9uK5EYuAwmuv/7pRVAoDE4NCx2Kqn3UAXFS3YF2r746HL8Xvu07F6N8G49wWdx8xXsgW4xOAnShed+/OIE5vqdmkvNaMdewSCqXYN4TQCsr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYh94f3ceMR4NbL7GGlR5bnRh4a6lP5iUC6Nk4IMxHA=;
 b=XlN2gFLlTVy9UT5zeGa5U82hq5aM5f4STfN8AHmQCjbv2QHxAd4IKN2uPYnrbBwtmTNDaeVFt+VJOHri1k+CPOi+7nn+tkXTLbfTtYMVsr4hzMigy07kxOFSTasK7hggBbPstmx54W2qT6swd4Qorv6pa5ogtjDV4MkdMDj+TDGF8XKTjT0GInx5GRueOzlAqNK6TLyjgVLpm/t1Sn6v/S24Xv/UlWk4VethQQn87Spu0ZgogPv6HFw5xm+Tllzp255J1hfdwRD8j1BbLrXx+b0aOrbezj5pW39fnn0XCUKHcnHqq6klEoQKtsWrXgJuNDxL5l+hAP1xhGrALXHc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYh94f3ceMR4NbL7GGlR5bnRh4a6lP5iUC6Nk4IMxHA=;
 b=Kan20sAvygt1Kk8l3BE8/jmKQpnBeDrVnYBvVIo+gTG4qFXe1CB8xz1YpWbpzci7QcisY9M38007Dhvzj7KhYmYnYNyJa+GLFy0WxtvJx+BW5jyfvYO//HQ+P/GEQqGhvI7nUUa+CsdCZXG2WHt73y6qT3yUMbMoqf6XppbvB08=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB8177.apcprd03.prod.outlook.com (2603:1096:101:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 09:01:33 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::b705:ea58:46d:e98d%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 09:01:33 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "seanpaul@chromium.org" <seanpaul@chromium.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH v5 08/13] drm/mediatek: Support alpha blending in OVL
Thread-Topic: [PATCH v5 08/13] drm/mediatek: Support alpha blending in OVL
Thread-Index: AQHaX/dw+6jgE8RwzEyDstn5tQCgv7Eiri0A
Date: Fri, 1 Mar 2024 09:01:33 +0000
Message-ID: <c45ab60ed348cce0a4b696fcc9dd3cd996fcf2ff.camel@mediatek.com>
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
	 <20240215101119.12629-9-shawn.sung@mediatek.com>
In-Reply-To: <20240215101119.12629-9-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB8177:EE_
x-ms-office365-filtering-correlation-id: 31f6783c-b766-45a6-6678-08dc39ce3138
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MNeykoBWXGSZ+oV+4OiJm/jKoKO5ktaM85/H/ywSsXwUsTwDuAZM9suVGHRz6G+IiV7/+xVwekXjHA+6gwt+dO6HM6BxPUiFl09NK9lG76f7RZ0kUhMgoc9Rn5jFHPjLHyZBdO6kiSqbcoiHhSzC3qBWJnU2iFevNrzQ1xKr0phcrFQswVGp5niTFp56iKU2b0JurV8DDbcQg7I3hQ0bfCVYL7cc8qtIXrB0mNb1JvtEwbhs8E9IuJBNz4N/Glfc+x+qihqds48F9D9uuXCxBYnAoYBsfSqvye0VhiC0UVQSkbdlk+y4lnVQZauWaxNTxwacccLiJWG9iy+jMziaCDUKN0iEPoIs/tXRYxqGVj56yOnZX+CtjshWFOV3nJtIr48ISj4ZNQKZ+dwNdkcirwxKvw4BA0l7/yea50wc4I5UzYMyt2HLeTDgNKU97GLddrtVS72z4AOmIY0n74c9v65FCSODNiyJiGe+sTF0Nza6ASFsXZFDov6vVlH/u2ias8VOnLAPh/cn9cySCgRMf6jEqIEk35hCXiWR7yvff5tD/urLe33vtGX0/SgOIFpAkGNXjzB64Y5Ry90O0cZhMjp4Vb0unLxcPmGdkiqxnWzPfoB8l1Vpg/9vwpTx/4mqgV/lXvsPk5aDkQcBEPLpSDdV2HrG6fLQMBdx5bM3JQTknW81IVAtZik8x02x/h9soUs5+O80Ea86naV47fpaw9q/I9Gfi0hbhGjk0kTeb2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZC8xREdKcnZrbFhuUlV4VlVDZzg5aE1vN2oxRityZ2NaSHdmdDZSa216R3BL?=
 =?utf-8?B?bFN4YVN3T2xrMVhtaWt3bFFwOTdrdWF6Mm1FR25DUHpBM0xKd0N4TVJDZmRM?=
 =?utf-8?B?QWdOaDE0T3UwbW5wN3poZ09YWTkzQUV2VTU3bFNUdVNoYWFoTVBnTVpkTWRM?=
 =?utf-8?B?RkE2MlNKZjNLVXRvRTB5dTM1YmJjUmJDWW1obC9lZVRkOXJvQzlxRGZ2SEwz?=
 =?utf-8?B?ZE1PQ0cwOE1NZUR2YjBTWmNGaE45MGtuc0JrblFpWCtEblNsaXE0bDhnOGVv?=
 =?utf-8?B?YjNpMDJCOFhPMVlGZWxRV3JOU3JxV1VTYmlscFFmWXk2M3JPdFZKUUJ4Y2RC?=
 =?utf-8?B?SkU1TlVlUUpmTE9WTHllR21VWWQ4cjNxV3NPeDl6SmZ4TmlxWTl6YW9tMkZF?=
 =?utf-8?B?S01xc1VuSHgwUEVBSitMSnVxYjBFSk1GT2xTaEJ4SFhlem9oOVpDM21yQU9U?=
 =?utf-8?B?QktMaGRBYllEVGxnbi9ONWxoN0I5UTMxZGU2QXEwVDFKaThoSi9XQUtjR0RC?=
 =?utf-8?B?dk84SEVWMUNrRy80bXNaSWthajlMdEl4ZGx0QjV4TEJrS1pXT1lnd1dBclA3?=
 =?utf-8?B?VmgrRjRCNnNBR0czK1NBWXpDSkxZOG0vRS9DWkNrTnFwZDFyV1MwR2t6WDhY?=
 =?utf-8?B?Rm5xbDk5K0tCaHFvTXlxeUNpcWdGUDdzazlWUEx2eGJtSnhSM2ptMnBVZVpM?=
 =?utf-8?B?K3AxVDdEK04vN0xva21JVUlPU2lHQ2hITmpIM1lYMmZ4cm83dnFKNHRadDJq?=
 =?utf-8?B?NDB5Tkk5RWZtY1FpdFlZaWsreVl2OVE3TGd2U085VnQwZFAxY2lOdUk1WlRz?=
 =?utf-8?B?QVFYRTB2dGV4a09oUzZzT3pWNXAzT0FpWlp5OTROS3lZRG5ZK1ZWcXZtUDl2?=
 =?utf-8?B?WlJTM1VpN1RIWmtiOVJBWEZWK29ubW9RWXEyZHBteXljZHg1a1hDL0NsSEc2?=
 =?utf-8?B?eTljUlJ5T1g4Y1BvYlhBTVMwZXZZZVF0RGxYZVYwQThFVG40Rno3WGd1dFNJ?=
 =?utf-8?B?Sm1Ma0NkTjdubWo0eHB6ay9aRFhUbG55b2syVDZYektNekFCbEN1SVZRM1JX?=
 =?utf-8?B?ZTA5Q1FlUGZRanorVXAvbjJOazFpODdsbkk2dzRhbWtsTXJDYjFmQi8ycjJJ?=
 =?utf-8?B?UmtuYVFVNEhUelF2d0FGUlVCZXAyajBxY2pGVkNRTjA4eFRnUjlBWDladFZy?=
 =?utf-8?B?QUpNV2xmaG1ONnplMFBVaFl4dTV5SkdGSjdKUFV3aUxxRDEzNXk3aUVCWU0z?=
 =?utf-8?B?NU5sM1hBWTJ5VTZXaE5rcDJZWWFsNUxaWTBtUURqMmt0elA2TzBtQ0pXekVK?=
 =?utf-8?B?dGd4bE9QNFIzN2NyQXpyNEVOWUlPbHJ4V25IU0JpR1kyRm5tenVSeGk3UVhF?=
 =?utf-8?B?ZDQ5M1UxUGFSTk92OHVpNzhDMmg0TWZqRkVJMFVjYlhkQXAyeExvK0RvWnVy?=
 =?utf-8?B?b3pFaXB5dVBFTDhQeW1nMkRKQU14NXAwZ204MmcvSnRLQjc3aHEwcW94djZE?=
 =?utf-8?B?SEh4REN6SmRnUzJGOVJaVDFRc01vMW5nS0RaOThSZ1dPYzIxOGwvZmtkQXlj?=
 =?utf-8?B?RURicTM0Uy85ZStsa21NM0lybVZ3WXk5K2FYUlp5aUhyb1VQOEVrQmk2bGtq?=
 =?utf-8?B?a3JpYWRBTUE5Q21GOElXVUpkSHdmNU9rd1dRbExiMDA1amIzVjV4b2gvVEhP?=
 =?utf-8?B?cG9NeU5WenhlenczclcxamlKemJ4aVo0Ui9ZcmU0RUhwVExialc0T0tBUkpD?=
 =?utf-8?B?UG1yczVTdGJLY1NRbUFGakRRL3Exb1AxOGFuRXNBTVZHdU1qd2lWVGw3NWE5?=
 =?utf-8?B?UmpUV0NkcmJTRndRMzlrdmNNdmo4MzdPekJOUXZnZXlwSUNkcFFNR0JveU51?=
 =?utf-8?B?b2tBQ2xCczJBWDNIVi81Q1FTRWI2TFZ1VGo1eFB1YzBpd1F6c2pYTzA4WUZV?=
 =?utf-8?B?WUJOeWJzRExPQnRDQzNBZldBb1Z6SzZWUk9FaDlJMElKTjRIYVhhZVU2Zm4r?=
 =?utf-8?B?Z01oMzIxQWJxN1Z1RlJNYnBGQ0VsaTVCeGFhYXI3YmkrMUR4a3YwRkVORzRy?=
 =?utf-8?B?MllyUnJ4WHh1Q3JsTTJEM1ZBUnZvcENWV291T3dIK2IxS3d0c1ZOTGpsMjBw?=
 =?utf-8?Q?rus4kxCXlSoLEUncPkfdvi+F1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FC0A245E1651B4EBF30ED1B0CBEBA73@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f6783c-b766-45a6-6678-08dc39ce3138
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 09:01:33.1548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akgHRgN+l95+yBQq49alQ3nUvh6Jba0STgJztviEBIHfdk00Trf1mVONmt8wq7UeVucJoAqdnn1kRa7YyEjFTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8177

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUaHUsIDIwMjQtMDItMTUgYXQgMTg6MTEgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFN1cHBvcnQgIlByZS1tdWx0aXBsaWVkIiBhbmQgIk5v
bmUiIGJsZW5kIG1vZGUgb24gTWVkaWFUZWsncyBjaGlwcy4NCj4gQmVmb3JlIHRoaXMgcGF0Y2gs
IG9ubHkgdGhlICJDb3ZlcmFnZSIgbW9kZSBpcyBzdXBwb3J0ZWQuDQo+IA0KPiBQbGVhc2UgcmVm
ZXIgdG8gdGhlIGRlc2NyaXB0aW9uIG9mIHRoZSBjb21taXQNCj4gImRybS9tZWRpYXRlazogU3Vw
cG9ydCBhbHBoYSBibGVuZGluZyBpbiBkaXNwbGF5IGRyaXZlciINCj4gZm9yIG1vcmUgaW5mb3Jt
YXRpb24uDQoNClNlcGFyYXRlIHRoaXMgcGF0Y2ggaW50byBwcmUtbXVsdGlwbGllZCBwYXRjaCBh
bmQgbm9uZSBwYXRjaC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhz
aWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyB8IDgzICsrKysrKysrKysrKysrKysr
KysrKw0KPiAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5j
DQo+IGluZGV4IGM0MmZjZTM4YTM1ZWIuLjk4Yzk4OWZkZGNjMDggMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTM5LDYgKzM5LDcgQEANCj4gICNk
ZWZpbmUgRElTUF9SRUdfT1ZMX1BJVENIX01TQihuKQkJKDB4MDA0MCArIDB4MjAgKiAobikpDQo+
ICAjZGVmaW5lIE9WTF9QSVRDSF9NU0JfMk5EX1NVQkJVRgkJCUJJVCgxNikNCj4gICNkZWZpbmUg
RElTUF9SRUdfT1ZMX1BJVENIKG4pCQkJKDB4MDA0NCArIDB4MjANCj4gKiAobikpDQo+ICsjZGVm
aW5lIE9WTF9DT05TVF9CTEVORAkJCQkJQklUKDI4KQ0KPiAgI2RlZmluZSBESVNQX1JFR19PVkxf
UkRNQV9DVFJMKG4pCQkoMHgwMGMwICsgMHgyMCAqIChuKSkNCj4gICNkZWZpbmUgRElTUF9SRUdf
T1ZMX1JETUFfR01DKG4pCQkoMHgwMGM4ICsgMHgyMCAqIChuKSkNCj4gICNkZWZpbmUgRElTUF9S
RUdfT1ZMX0FERFJfTVQyNzAxCQkweDAwNDANCj4gQEAgLTUyLDEzICs1MywxNiBAQA0KPiAgI2Rl
ZmluZSBHTUNfVEhSRVNIT0xEX0hJR0gJKCgxIDw8IEdNQ19USFJFU0hPTERfQklUUykgLyA0KQ0K
PiAgI2RlZmluZSBHTUNfVEhSRVNIT0xEX0xPVwkoKDEgPDwgR01DX1RIUkVTSE9MRF9CSVRTKSAv
IDgpDQo+ICANCj4gKyNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfTUFOCUJJVCgyMykNCj4gICNkZWZp
bmUgT1ZMX0NPTl9CWVRFX1NXQVAJQklUKDI0KQ0KPiAtI2RlZmluZSBPVkxfQ09OX01UWF9ZVVZf
VE9fUkdCCSg2IDw8IDE2KQ0KPiArI2RlZmluZSBPVkxfQ09OX1JHQl9TV0FQCUJJVCgyNSkNCj4g
ICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUkdCCSgxIDw8IDEyKQ0KPiAgI2RlZmluZSBPVkxfQ09O
X0NMUkZNVF9SR0JBODg4OAkoMiA8PCAxMikNCj4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfQVJH
Qjg4ODgJKDMgPDwgMTIpDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1VZVlkJKDQgPDwgMTIp
DQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1lVWVYJKDUgPDwgMTIpDQo+ICsjZGVmaW5lIE9W
TF9DT05fTVRYX1lVVl9UT19SR0IJKDYgPDwgMTYpDQo+ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1U
X1BBUkdCODg4OAkoT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODggfA0KPiBPVkxfQ09OX0NMUkZNVF9N
QU4pDQo+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQjU2NShvdmwpCSgob3ZsKS0+ZGF0YS0+
Zm10X3JnYjU2NV9pc18wID8NCj4gXA0KPiAgCQkJCQkwIDogT1ZMX0NPTl9DTFJGTVRfUkdCKQ0K
PiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9SR0I4ODgob3ZsKQkoKG92bCktPmRhdGEtPmZtdF9y
Z2I1NjVfaXNfMCA/DQo+IFwNCj4gQEAgLTcyLDYgKzc2LDIyIEBADQo+ICAjZGVmaW5lCU9WTF9D
T05fVklSVF9GTElQCUJJVCg5KQ0KPiAgI2RlZmluZQlPVkxfQ09OX0hPUlpfRkxJUAlCSVQoMTAp
DQo+ICANCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBpc18xMGJpdF9yZ2IodTMyIGZtdCkNCj4gK3sN
Cj4gKwlzd2l0Y2ggKGZtdCkgew0KPiArCWNhc2UgRFJNX0ZPUk1BVF9YUkdCMjEwMTAxMDoNCj4g
KwljYXNlIERSTV9GT1JNQVRfQVJHQjIxMDEwMTA6DQo+ICsJY2FzZSBEUk1fRk9STUFUX1JHQlgx
MDEwMTAyOg0KPiArCWNhc2UgRFJNX0ZPUk1BVF9SR0JBMTAxMDEwMjoNCj4gKwljYXNlIERSTV9G
T1JNQVRfWEJHUjIxMDEwMTA6DQo+ICsJY2FzZSBEUk1fRk9STUFUX0FCR1IyMTAxMDEwOg0KPiAr
CWNhc2UgRFJNX0ZPUk1BVF9CR1JYMTAxMDEwMjoNCj4gKwljYXNlIERSTV9GT1JNQVRfQkdSQTEw
MTAxMDI6DQo+ICsJCXJldHVybiB0cnVlOw0KPiArCX0NCj4gKwlyZXR1cm4gZmFsc2U7DQo+ICt9
DQo+ICsNCj4gIHN0YXRpYyBjb25zdCB1MzIgbXQ4MTczX2Zvcm1hdHNbXSA9IHsNCj4gIAlEUk1f
Rk9STUFUX1hSR0I4ODg4LA0KPiAgCURSTV9GT1JNQVRfQVJHQjg4ODgsDQo+IEBAIC04OSwxMiAr
MTA5LDIwIEBAIHN0YXRpYyBjb25zdCB1MzIgbXQ4MTczX2Zvcm1hdHNbXSA9IHsNCj4gIHN0YXRp
YyBjb25zdCB1MzIgbXQ4MTk1X2Zvcm1hdHNbXSA9IHsNCj4gIAlEUk1fRk9STUFUX1hSR0I4ODg4
LA0KPiAgCURSTV9GT1JNQVRfQVJHQjg4ODgsDQo+ICsJRFJNX0ZPUk1BVF9YUkdCMjEwMTAxMCwN
Cj4gIAlEUk1fRk9STUFUX0FSR0IyMTAxMDEwLA0KPiAgCURSTV9GT1JNQVRfQkdSWDg4ODgsDQo+
ICAJRFJNX0ZPUk1BVF9CR1JBODg4OCwNCj4gKwlEUk1fRk9STUFUX0JHUlgxMDEwMTAyLA0KPiAg
CURSTV9GT1JNQVRfQkdSQTEwMTAxMDIsDQo+ICAJRFJNX0ZPUk1BVF9BQkdSODg4OCwNCj4gIAlE
Uk1fRk9STUFUX1hCR1I4ODg4LA0KPiArCURSTV9GT1JNQVRfWEJHUjIxMDEwMTAsDQo+ICsJRFJN
X0ZPUk1BVF9BQkdSMjEwMTAxMCwNCj4gKwlEUk1fRk9STUFUX1JHQlg4ODg4LA0KPiArCURSTV9G
T1JNQVRfUkdCQTg4ODgsDQo+ICsJRFJNX0ZPUk1BVF9SR0JYMTAxMDEwMiwNCj4gKwlEUk1fRk9S
TUFUX1JHQkExMDEwMTAyLA0KPiAgCURSTV9GT1JNQVRfUkdCODg4LA0KPiAgCURSTV9GT1JNQVRf
QkdSODg4LA0KPiAgCURSTV9GT1JNQVRfUkdCNTY1LA0KPiBAQCAtMjU0LDkgKzI4Miw3IEBAIHN0
YXRpYyB2b2lkIG10a19vdmxfc2V0X2JpdF9kZXB0aChzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYsIGlu
dCBpZHgsIHUzMiBmb3JtYXQsDQo+ICAJcmVnID0gcmVhZGwob3ZsLT5yZWdzICsgRElTUF9SRUdf
T1ZMX0NMUkZNVF9FWFQpOw0KPiAgCXJlZyAmPSB+T1ZMX0NPTl9DTFJGTVRfQklUX0RFUFRIX01B
U0soaWR4KTsNCj4gIA0KPiAtCWlmIChmb3JtYXQgPT0gRFJNX0ZPUk1BVF9SR0JBMTAxMDEwMiB8
fA0KPiAtCSAgICBmb3JtYXQgPT0gRFJNX0ZPUk1BVF9CR1JBMTAxMDEwMiB8fA0KPiAtCSAgICBm
b3JtYXQgPT0gRFJNX0ZPUk1BVF9BUkdCMjEwMTAxMCkNCj4gKwlpZiAoaXNfMTBiaXRfcmdiKGZv
cm1hdCkpDQo+ICAJCWJpdF9kZXB0aCA9IE9WTF9DT05fQ0xSRk1UXzEwX0JJVDsNCj4gIA0KPiAg
CXJlZyB8PSBPVkxfQ09OX0NMUkZNVF9CSVRfREVQVEgoYml0X2RlcHRoLCBpZHgpOw0KPiBAQCAt
Mjc0LDcgKzMwMCwxMyBAQCB2b2lkIG10a19vdmxfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwg
dW5zaWduZWQNCj4gaW50IHcsDQo+ICAJaWYgKHcgIT0gMCAmJiBoICE9IDApDQo+ICAJCW10a19k
ZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgaCA8PCAxNiB8IHcsICZvdmwtDQo+ID5jbWRxX3Jl
Zywgb3ZsLT5yZWdzLA0KPiAgCQkJCSAgICAgIERJU1BfUkVHX09WTF9ST0lfU0laRSk7DQo+IC0J
bXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCAweDAsICZvdmwtPmNtZHFfcmVnLCBvdmwt
PnJlZ3MsIA0KPiBESVNQX1JFR19PVkxfUk9JX0JHQ0xSKTsNCj4gKw0KPiArCS8qDQo+ICsJICog
VGhlIGJhY2tncm91bmQgY29sb3Igc2hvdWxkIGJlIG9wYXF1ZSBibGFjayAoQVJHQiksDQo+ICsJ
ICogb3RoZXJ3aXNlIHRoZXJlIHdpbGwgYmUgbm8gZWZmZWN0IHdpdGggYWxwaGEgYmxlbmQNCj4g
KwkgKi8NCj4gKwltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIDB4ZmYwMDAwMDAsICZv
dmwtPmNtZHFfcmVnLA0KPiArCQkJICAgICAgb3ZsLT5yZWdzLCBESVNQX1JFR19PVkxfUk9JX0JH
Q0xSKTsNCj4gIA0KPiAgCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIDB4MSwgJm92bC0+Y21kcV9y
ZWcsIG92bC0+cmVncywNCj4gRElTUF9SRUdfT1ZMX1JTVCk7DQo+ICAJbXRrX2RkcF93cml0ZShj
bWRxX3BrdCwgMHgwLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiBESVNQX1JFR19PVkxf
UlNUKTsNCj4gQEAgLTM1Miw3ICszODQsOCBAQCB2b2lkIG10a19vdmxfbGF5ZXJfb2ZmKHN0cnVj
dCBkZXZpY2UgKmRldiwNCj4gdW5zaWduZWQgaW50IGlkeCwNCj4gIAkJICAgICAgRElTUF9SRUdf
T1ZMX1JETUFfQ1RSTChpZHgpKTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHVuc2lnbmVkIGludCBv
dmxfZm10X2NvbnZlcnQoc3RydWN0IG10a19kaXNwX292bCAqb3ZsLA0KPiB1bnNpZ25lZCBpbnQg
Zm10KQ0KPiArc3RhdGljIHVuc2lnbmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3RydWN0IG10a19k
aXNwX292bCAqb3ZsLA0KPiB1bnNpZ25lZCBpbnQgZm10LA0KPiArCQkJCSAgICB1bnNpZ25lZCBp
bnQgYmxlbmRfbW9kZSkNCj4gIHsNCj4gIAkvKiBUaGUgcmV0dXJuIHZhbHVlIGluIHN3aXRjaCAi
TUVNX01PREVfSU5QVVRfRk9STUFUX1hYWCINCj4gIAkgKiBpcyBkZWZpbmVkIGluIG1lZGlhdGVr
IEhXIGRhdGEgc2hlZXQuDQo+IEBAIC0zNzEsMTcgKzQwNCwzNyBAQCBzdGF0aWMgdW5zaWduZWQg
aW50IG92bF9mbXRfY29udmVydChzdHJ1Y3QNCj4gbXRrX2Rpc3Bfb3ZsICpvdmwsIHVuc2lnbmVk
IGludCBmbXQpDQo+ICAJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9SR0I4ODgob3ZsKSB8IE9WTF9D
T05fQllURV9TV0FQOw0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9SR0JYODg4ODoNCj4gIAljYXNlIERS
TV9GT1JNQVRfUkdCQTg4ODg6DQo+ICsJCXJldHVybiBibGVuZF9tb2RlID09IERSTV9NT0RFX0JM
RU5EX0NPVkVSQUdFID8NCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4IDoNCj4g
KwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4ODsNCj4gKwljYXNlIERSTV9GT1JNQVRf
UkdCWDEwMTAxMDI6DQo+ICsJY2FzZSBEUk1fRk9STUFUX1JHQkExMDEwMTAyOg0KPiAgCQlyZXR1
cm4gT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODg7DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUlg4ODg4
Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JBODg4ODoNCj4gKwkJcmV0dXJuIE9WTF9DT05fQllU
RV9TV0FQIHwNCj4gKwkJICAgICAgIChibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX0NPVkVS
QUdFID8NCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4IDoNCj4gKwkJICAgICAg
IE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCk7DQo+ICsJY2FzZSBEUk1fRk9STUFUX0JHUlgxMDEw
MTAyOg0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JBMTAxMDEwMjoNCj4gIAkJcmV0dXJuIE9WTF9D
T05fQ0xSRk1UX0FSR0I4ODg4IHwgT1ZMX0NPTl9CWVRFX1NXQVA7DQo+ICAJY2FzZSBEUk1fRk9S
TUFUX1hSR0I4ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9BUkdCODg4ODoNCj4gKwkJcmV0dXJu
IGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0UgPw0KPiArCQkgICAgICAgT1ZM
X0NPTl9DTFJGTVRfUkdCQTg4ODggOg0KPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4
ODg4Ow0KPiArCWNhc2UgRFJNX0ZPUk1BVF9YUkdCMjEwMTAxMDoNCj4gIAljYXNlIERSTV9GT1JN
QVRfQVJHQjIxMDEwMTA6DQo+ICAJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9SR0JBODg4ODsNCj4g
IAljYXNlIERSTV9GT1JNQVRfWEJHUjg4ODg6DQo+ICAJY2FzZSBEUk1fRk9STUFUX0FCR1I4ODg4
Og0KPiArCQlyZXR1cm4gT1ZMX0NPTl9SR0JfU1dBUCB8DQo+ICsJCSAgICAgICAoYmxlbmRfbW9k
ZSA9PSBEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSA/DQo+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZN
VF9SR0JBODg4OCA6DQo+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODgpOw0KPiAr
CWNhc2UgRFJNX0ZPUk1BVF9YQkdSMjEwMTAxMDoNCj4gKwljYXNlIERSTV9GT1JNQVRfQUJHUjIx
MDEwMTA6DQo+ICAJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9SR0JBODg4OCB8IE9WTF9DT05fQllU
RV9TV0FQOw0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9VWVZZOg0KPiAgCQlyZXR1cm4gT1ZMX0NPTl9D
TFJGTVRfVVlWWSB8IE9WTF9DT05fTVRYX1lVVl9UT19SR0I7DQo+IEBAIC00MDMsNiArNDU2LDgg
QEAgdm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHVuc2ln
bmVkIGludCBpZHgsDQo+ICAJdW5zaWduZWQgaW50IGZtdCA9IHBlbmRpbmctPmZvcm1hdDsNCj4g
IAl1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gKHBlbmRpbmctPnkgPDwgMTYpIHwgcGVuZGluZy0+eDsN
Cj4gIAl1bnNpZ25lZCBpbnQgc3JjX3NpemUgPSAocGVuZGluZy0+aGVpZ2h0IDw8IDE2KSB8IHBl
bmRpbmctDQo+ID53aWR0aDsNCj4gKwl1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSA9IHN0YXRlLT5i
YXNlLnBpeGVsX2JsZW5kX21vZGU7DQo+ICsJdW5zaWduZWQgaW50IGlnbm9yZV9waXhlbF9hbHBo
YSA9IDA7DQo+ICAJdW5zaWduZWQgaW50IGNvbjsNCj4gIAlib29sIGlzX2FmYmMgPSBwZW5kaW5n
LT5tb2RpZmllciAhPSBEUk1fRk9STUFUX01PRF9MSU5FQVI7DQo+ICAJdW5pb24gb3ZlcmxheV9w
aXRjaCB7DQo+IEBAIC00MjAsOSArNDc1LDE1IEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWco
c3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQlyZXR1cm47DQo+
ICAJfQ0KPiAgDQo+IC0JY29uID0gb3ZsX2ZtdF9jb252ZXJ0KG92bCwgZm10KTsNCj4gLQlpZiAo
c3RhdGUtPmJhc2UuZmIgJiYgc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KPiAt
CQljb24gfD0gT1ZMX0NPTl9BRU4gfCBPVkxfQ09OX0FMUEhBOw0KPiArCWNvbiA9IG92bF9mbXRf
Y29udmVydChvdmwsIGZtdCwgYmxlbmRfbW9kZSk7DQo+ICsJaWYgKHN0YXRlLT5iYXNlLmZiKSB7
DQo+ICsJCWNvbiB8PSBPVkxfQ09OX0FFTjsNCj4gKwkJY29uIHw9IHN0YXRlLT5iYXNlLmFscGhh
ICYgT1ZMX0NPTl9BTFBIQTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoYmxlbmRfbW9kZSA9PSBEUk1f
TU9ERV9CTEVORF9QSVhFTF9OT05FIHx8DQo+ICsJICAgIChzdGF0ZS0+YmFzZS5mYiAmJiAhc3Rh
dGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKSkNCj4gKwkJaWdub3JlX3BpeGVsX2FscGhh
ID0gT1ZMX0NPTlNUX0JMRU5EOw0KPiAgDQo+ICAJaWYgKHBlbmRpbmctPnJvdGF0aW9uICYgRFJN
X01PREVfUkVGTEVDVF9ZKSB7DQo+ICAJCWNvbiB8PSBPVkxfQ09OX1ZJUlRfRkxJUDsNCj4gQEAg
LTQzOSw4ICs1MDAsOCBAQCB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gdW5zaWduZWQgaW50IGlkeCwNCj4gIA0KPiAgCW10a19kZHBfd3JpdGVfcmVsYXhl
ZChjbWRxX3BrdCwgY29uLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiAgCQkJICAgICAg
RElTUF9SRUdfT1ZMX0NPTihpZHgpKTsNCj4gLQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9w
a3QsIG92ZXJsYXlfcGl0Y2guc3BsaXRfcGl0Y2gubHNiLA0KPiAmb3ZsLT5jbWRxX3JlZywgb3Zs
LT5yZWdzLA0KPiAtCQkJICAgICAgRElTUF9SRUdfT1ZMX1BJVENIKGlkeCkpOw0KPiArCW10a19k
ZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgb3ZlcmxheV9waXRjaC5zcGxpdF9waXRjaC5sc2Ig
fA0KPiBpZ25vcmVfcGl4ZWxfYWxwaGEsDQo+ICsJCQkgICAgICAmb3ZsLT5jbWRxX3JlZywgb3Zs
LT5yZWdzLA0KPiBESVNQX1JFR19PVkxfUElUQ0goaWR4KSk7DQo+ICAJbXRrX2RkcF93cml0ZV9y
ZWxheGVkKGNtZHFfcGt0LCBzcmNfc2l6ZSwgJm92bC0+Y21kcV9yZWcsIG92bC0NCj4gPnJlZ3Ms
DQo+ICAJCQkgICAgICBESVNQX1JFR19PVkxfU1JDX1NJWkUoaWR4KSk7DQo+ICAJbXRrX2RkcF93
cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBvZmZzZXQsICZvdmwtPmNtZHFfcmVnLCBvdmwtDQo+ID5y
ZWdzLA0K

