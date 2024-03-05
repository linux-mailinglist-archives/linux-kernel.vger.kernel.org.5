Return-Path: <linux-kernel+bounces-91496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6742887125C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4911C212BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE317C69;
	Tue,  5 Mar 2024 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pQM7qfo1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rmXuabF2"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689E17BAE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602393; cv=fail; b=Hv4TKIUYw5TXE79tImP1aszB/klb5b++f/v7q7IWlOSJtTn98KV7Doz9GiBmKMxGAgPRBVn2CCGCIQGbxcUIs318mtUdGXv7ZNCknQ7fPlFtOdwSpCbrBw77UFvay7bFuYinxXIBCrYDmV1fgAqQlQubbvJlMymVr72JpEdzD8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602393; c=relaxed/simple;
	bh=9XSpNCXnSVQYCT6I5/t2f6WkNaTAODWBHjXrF6pMaaU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TzVkQSBL5fwdh0dYTYNm7906Qi4sGLo1Ii3y6gRwPhzt7yuQcAq42PxOCW4xSgAUc3GgfSfFPAZ2aHX1kzINZeOcjZuLgfqjUz2Ow8Ts6EqhqxTi0FoSpaXRXu8FgRkNYfavXtR6dMKfKtw2oTwc6dbHWcosUoSau2R4cWhhjyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pQM7qfo1; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rmXuabF2; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4e7db942da9011eeb8927bc1f75efef4-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9XSpNCXnSVQYCT6I5/t2f6WkNaTAODWBHjXrF6pMaaU=;
	b=pQM7qfo1nYBtqpAPPbGeZdHinoTpFygmWsHLW3rsxzZHavmtklM87vVbBtBKq0s5J9cNqpvwJB5GmwBmQQaM+ZAdyvFUJBHeSRKauJ5R7jmpM2x2h220u4RxReKYP+yHh7DfxETaSzxpLgJW/++kKnPeAYQJSu0rkyH9xZvLhEE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a3bc5b1c-0141-43f0-a735-19ef83fe650f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:7d799c84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4e7db942da9011eeb8927bc1f75efef4-20240305
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1249908836; Tue, 05 Mar 2024 09:33:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 09:33:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 09:33:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd/Yvln+UnZEHYMsZuNhKHt2m9Q9LxdisEXRrN5mYKFRU78K8/xMuhKQvATKuyn4oi7A5WgUNUfbJbwiBr+NwHX1V6Ml7RMkGaeUqMVzB+gAgF0MdygXpwDcOWNxhN8ZiXopTdU26VW0igLjEOIaReNWcmdqYOruRyv8h+da54179okI/VyC37hOaQNCloeUmVD0YqYVda3ZTYOMHN4mTDPIk+NLf3pD/A0d6wDJqWoPDXv3lTQ44a3omEgR+89Els/cIN80td7l1OecFCwKMAm3mnA5ScfzZv0evobdqRF5kkXom4ZylQbNHzG0CXksgXt1giwJnvEtdsmgG+wrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XSpNCXnSVQYCT6I5/t2f6WkNaTAODWBHjXrF6pMaaU=;
 b=lbRKYnusXEHP3d/Eoq8kPifEzTdY16rc4PFrmA+i2pR3Q+6nIznl3JX3lHSDs1uLMCBDw+LRHiad+YRzewflo7vhg1vC/26CkGNGha5ExgsScOy7+O5bFQFZyGYr/5gEse5Sgj7a+XmroGMmVlsBif3pNuv7xEtWrjy58F07MRtPH8z5042b2utkZd5LUip/b2+K95jIl0rtfLeEAXdkLDg+U7FcUvsdC3fd80TJkQkTjzRBxJk3h8L5ZJkDpiIm/QrZekLGt3bv8SwMbtVZqKoiArcRCyFmwsLwUXZ7QxV/jeGQ+syNnmHUfwSMGIIpqUP8wFcQI0Z67mKUZTksiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XSpNCXnSVQYCT6I5/t2f6WkNaTAODWBHjXrF6pMaaU=;
 b=rmXuabF2ucUaAoJw3Ii34ygumu4YMCjf11wiqJIiwVaOq0DvoZyHg36VV1kqQNvJlHCVTTbf7YTjiNUyF/CrH7WU40STRqqChu4ZsNFLMCKfY59eEAgLZblUKCfVb3upUufp5f1WRuS3YNKBOYlS6o31RsE8y+ok2zzdQRukerg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB7502.apcprd03.prod.outlook.com (2603:1096:820:e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 01:32:56 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 01:32:56 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_poll_addr()
 function
Thread-Topic: [PATCH 3/5] soc: mediatek: mtk-cmdq: Add cmdq_pkt_poll_addr()
 function
Thread-Index: AQHaa8lb4thC2cBwFkiYYHfwQ1M70LEnX4EAgAEDAgA=
Date: Tue, 5 Mar 2024 01:32:56 +0000
Message-ID: <480e5b574f8fd0a1d25ad882f76042cb358ebac5.camel@mediatek.com>
References: <20240301111126.22035-1-jason-jh.lin@mediatek.com>
	 <20240301111126.22035-4-jason-jh.lin@mediatek.com>
	 <e0843692-d317-43ec-b8c8-1bdea37447dc@collabora.com>
In-Reply-To: <e0843692-d317-43ec-b8c8-1bdea37447dc@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB7502:EE_
x-ms-office365-filtering-correlation-id: 01d83648-96a1-4f59-3f09-08dc3cb42f0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVnQruQqoc/50pJfMC19SW7xhGHwfeZKZPCcTAypRKMUoiCHFQ6lEJ/eRAf1VG8U4KH73JS9ehpHOe6qpQ0zpRrhOIPBVl22xTkhibpJVwi9nSSn9JKoBMJPtMkWqka2xQDgTRs4u2vnQ38EWsrDOvmLucMHtomQMkfD1dYKqD/UrOOdddUSNVS6+ZKLR7JsobSiFfJEAwSR6NI4SDbaGrIPgp4qGq28F6X5Q3kZ/O4gcCoQi6A5WOau4rWawplSUBaafUsUx1hTniU7UqTVbTI4ABQyvGb4il6/6fphLCIoNNAUxGgnNU+576yHH8vQQXgPUfG3UfkaDiEx/084u3H+92Q6eN+zGLNCweYciSQ2rtgAxN+mCKsWOMMlDzXstLT48E9j1D15d8h6iE2F9Cm2fP1RssXnrgHdKNtftEKE6C+RnpKM8Ic+NsMikBYgfR5Rrv+ajTOLYsepMxkwg2Qaelje7hoyooHPOsrzQLMZYtaq6Jnum+heCs2ojw0NRR924TInV6tXoPjEwIzKMVf//5e5pkzuUACMOYEJhQFMyyx2kHvYQAEuPQGg2JKEjyImA3k6Lr/uq4vQ/xGjFpAG3vm8zmk3QRqHlBXz72ZxSTIjaGG/hbzGjj1PckpES51ZlPSXypwAvVf9S9WSae55qTYbQv3Ydb4N0EL2vRDK648BS3oh/Eq38J/6iu2QiqhTCVTZIB2C/OyxxYYxPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0M4RDRJT1VWd085N0J5QS9sU3ZOR284NGk2T05pWk50Mk4yOTBTbnViUGNT?=
 =?utf-8?B?VHJZUkV1dDdKZnJGb0MxK015anJ1ZERrQXk0TERnUjhoZXBPQmpldUd3Q0ly?=
 =?utf-8?B?VzdFdHpEdCtBUm5lT0haTjBHZVFYZmQramZpL0VoWEdMRHQxU2RrOU9aVmw0?=
 =?utf-8?B?NURSN1VLMEU2bFYvSFl0eDRJWlhnNkk1V0liVm80ME9paGczNndqa3Y4Z1hy?=
 =?utf-8?B?Sm02cW1QK29NeWFBNmxZL2w5eTE4MjNLMUUreWNaekpiTHcwdWx4bkx4QXYx?=
 =?utf-8?B?dE95OFlSVjJsbmcyQ2RLUGJvN3BVSnlZc1hNSFAvcE4wWkFCcUxQOWlHcENT?=
 =?utf-8?B?bDF4VnpmdFJpWFRZeW1QTW1WbFR0QTZlcHZ3aE41RVJDODJ2S3dHMUtidStj?=
 =?utf-8?B?eVozY0FZSWNmcTI1eGsyUU5CNVFDMFpYbjBaa1ZDblo3ZGJMZzhlUXo4Z1RL?=
 =?utf-8?B?Y1ZnL01MQnV5N0xzMkh6Nms5TWV1TU9YVFpzQ2ZrckVlcHlkdjNGWUhUZ3Ur?=
 =?utf-8?B?cU4zN1F0VkloNkZING12RldZaHJMdmd0eklJZTFSRm5FNWVWT1pZSHF0L243?=
 =?utf-8?B?V2pzaUpsR1dDdUx0c0FZQU9jc2sxakc3NyttaXNZczlLVWxYcEUvNGp0dTh3?=
 =?utf-8?B?VXM2OGIxV25mWnoreElqRVJ5eVAzdzEyTVVXRFJTZjZhVzFBQjh4ay9CMU80?=
 =?utf-8?B?bk5tOWhjbXBNMklQeXQxenN0R1VLNlgraXhTN1UxUHNyU0Fnb1FJZ1RWOEF4?=
 =?utf-8?B?UFlWR1NTSHNMcURSa1pYVVdqUTZmTjJvb01iVmk4ZlhHZ0pleDdwUVArdzVP?=
 =?utf-8?B?a0NXNi9OUzhIbzh4RTFXaWtIRVBzTHIxYmRZM0RxWGNRenlRYTVUaEhsNlF6?=
 =?utf-8?B?bjhiVmhQK0w2cVJvLzgrRDN3ZUVMY0N1ZlB2QTVZUndlZkhkK0dQODB5Tity?=
 =?utf-8?B?d0dzbVdrRGYyKzRLT2hGMDlpc0dDQWNJYTNwL0ZLWkhVRkVmNWo0QmFiYWlV?=
 =?utf-8?B?UEtSdWhsVUZtRjRESVUvWW5mOW1Ga3lkeDUvOEI3MlVhMjFYWlMwdzVLT1cz?=
 =?utf-8?B?K2NtTDljT1hralAzQ2hYZ0Z0NW9Vd2d1c29RejNZVTllWlN5T2IvWUQyQnlL?=
 =?utf-8?B?eTl2WTd2RzFSbUlSWjZ4UU5RZm1MeDB1eEhMbkViYytoZGRTQms3dU1DaUh5?=
 =?utf-8?B?UzR4SUEzeWMraVRGcmZGQlJyS25aQVJKdlVWOFVZQzJFcDdGNHl6ek1tK002?=
 =?utf-8?B?ZmtVYnQ2cEo3K2ZaMklNK0d6ZlRPOGRDQzlQejhVU1NidzZxZWRnYkZFNERz?=
 =?utf-8?B?WFQxV3VZbHdIMVY3U1BlcFhHUmR5S2R3VktsNEExT1p3OHJvRDR2eW1Ja2M3?=
 =?utf-8?B?MU4xc3gyQzJSN2pKZER5OHFoUHZRWjVMQ09FTTBoUWtKdDAzTTFTOHVIWW1o?=
 =?utf-8?B?M2hHazJNZnhKYVIvYUk1eE9ZQ0NvK09XQUhrVXdnRFcwU1lkSHVUbjRJVjZM?=
 =?utf-8?B?d1NNeUZSbCtaUHhtS2JrSEhndjNuVEg1Ynptb0VCK0JjT2lhejZ2Q1dqdmdy?=
 =?utf-8?B?d3JXTk5GQ0h1TTN4YzZ2QzVRVUI3Z3ZUVkZOcW9yaDYwemo4Z3dYY2NIdTh3?=
 =?utf-8?B?SG8rbDFwaVpPOERBZVVlRW9MN1lqalpDbUNaRldjWVczd3ZKb29SN0UrT2R5?=
 =?utf-8?B?Y0duVVdSa1I0dzJERVlSNmUwZWI1UHZpV2pUa0t3VndpN3QvK0lQMFRCZ2F5?=
 =?utf-8?B?dmlpeDlON1o1YStUbjVWUXpGYjhBekwrRWx6TkRsaHYzTXBQVitSaEwyV1lw?=
 =?utf-8?B?cXh6dVhIZ1cyRS9TSFZaVTNiSDZNVWphNHg2b1VuUGtxVlZSRjhJU2gwanhZ?=
 =?utf-8?B?Q0JiZEJsa1BORDZoWW1DdVVuaU5uM1hvMUZrOU14c1hsQUlrZ3psSFpFRUZT?=
 =?utf-8?B?QTRwNHhHd0JtZldPRnJsa1I4Smg3SElxRnhKR0MxRVlBUERTTmF6QWhoekxx?=
 =?utf-8?B?WEx6NHBldXBaRVU0RzgrTUw2QXhxOGR5d0lUZ2QvR2RxaVlhMmVpT3lXK201?=
 =?utf-8?B?NCthdWJaelVHcGdwMWRWb1pJbEppTEZnQmowZkxIZ2szcnJJZmFDZEVObXA3?=
 =?utf-8?B?UjZDUWlDbi9rQnZEeE1tc0VPbklkVE9mTENTMzZ5NHN2UStJQkh3cFlvWjVt?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97DF934B21566E4783FA493CBC865577@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d83648-96a1-4f59-3f09-08dc3cb42f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 01:32:56.0608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fkgDN34nRuVCRyNoCqRV8DrdQrRvBdj/ZiKZSk9V8GVluDiinM6cAScCdNcfRrMcOdaPmqCJiM6h6u3l0Gie0/hxLvZnHPJwbzuL+WlNu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7502

SGkgQW5nZWxvLCANCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCg0KT24gTW9uLCAyMDI0LTAz
LTA0IGF0IDExOjA1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4g
SWwgMDEvMDMvMjQgMTI6MTEsIEphc29uLUpILkxpbiBoYSBzY3JpdHRvOg0KPiA+IEFkZCBjbWRx
X3BrdF9wb2xsX2FkZHIgZnVuY3Rpb24gdG8gc3VwcG9ydCBDTURRIHVzZXIgbWFraW5nDQo+ID4g
YW4gaW5zdHJ1Y3Rpb24gZm9yIHBvbGxpbmcgYSBzcGVjaWZpYyBhZGRyZXNzIG9mIGhhcmR3YXJl
IHJpZ3N0ZXINCj4gPiB0byBjaGVjayB0aGUgdmFsdWUgd2l0aCBvciB3aXRob3V0IG1hc2suDQo+
ID4gDQo+ID4gUE9MTCBpcyBhbiBvbGQgb3BlcmF0aW9uIGluIEdDRSwgc28gaXQgZG9lcyBub3Qg
c3VwcG9ydCBTUFIgYW5kDQo+IA0KPiBQT0xMIGlzIGEgbGVnYWN5IG9wZXJhdGlvbiBpbiBHQ0Us
IHNvIGl0IGRvZXMgbm90IHN1cHBvcnQgLi4uLi4NCj4gDQpPSywgSSdsbCBjaGFuZ2UgdGhhdC4N
Cg0KPiA+IENNRFFfQ09ERV9MT0dJQy4gQ01EUSB1c2VycyBuZWVkIHRvIHVzZSBHUFIgYW5kIENN
RFFfQ09ERV9NQVNLDQo+ID4gdG8gbW92ZSBwb2xsaW5nIHJlZ2lzdGVyIGFkZHJlc3MgdG8gR1BS
IHRvIG1ha2UgYW4gaW5zdHJ1Y3Rpb24uDQo+ID4gVGhpcyB3aWxsIGJlIGRvbmUgaW4gY21kcV9w
a3RfcG9sbF9hZGRyKCkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxq
YXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IENoYW5nZS1JZDogSTkxZmY5OGUwNjU3MGRj
NDUwMTE4N2ViMjlkZTY0YWFhNjViMWNmMTMNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMzgNCj4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCAxNiAr
KysrKysrKysrKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQo+ID4gYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IGluZGV4
IDNhMWU0N2FkOGE0MS4uMmU5ZmM5YmIxMTgzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBAQCAtMTIsNiArMTIsNyBAQA0KPiA+ICAgDQo+ID4g
ICAjZGVmaW5lIENNRFFfV1JJVEVfRU5BQkxFX01BU0sJQklUKDApDQo+ID4gICAjZGVmaW5lIENN
RFFfUE9MTF9FTkFCTEVfTUFTSwlCSVQoMCkNCj4gPiArI2RlZmluZSBDTURRX1BPTExfSElHSF9B
RERSX0dQUgkoMTQpDQo+ID4gICAjZGVmaW5lIENNRFFfRU9DX0lSUV9FTgkJQklUKDApDQo+ID4g
ICAjZGVmaW5lIENNRFFfUkVHX1RZUEUJCTENCj4gPiAgICNkZWZpbmUgQ01EUV9KVU1QX1JFTEFU
SVZFCTENCj4gPiBAQCAtNDA2LDYgKzQwNyw0MyBAQCBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LA0KPiA+IHU4IHN1YnN5cywNCj4gPiAgIH0NCj4gPiAgIEVYUE9S
VF9TWU1CT0woY21kcV9wa3RfcG9sbF9tYXNrKTsNCj4gPiAgIA0KPiA+ICtpbnQgY21kcV9wa3Rf
cG9sbF9hZGRyKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90IGFkZHIsIHUzMg0KPiA+
IHZhbHVlLCB1MzIgbWFzaykNCj4gPiArew0KPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24g
aW5zdCA9IHsgezB9IH07DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsJdTggdXNlX21hc2sgPSAwOw0K
PiA+ICsNCj4gPiArCWlmIChtYXNrICE9IFUzMl9NQVgpIHsNCj4gDQo+IGluc3Qub3AgPSBDTURR
X0NPREVfTUFTSzsNCj4gDQo+IC8qIERlc2NyaWJlIHdoYXQgeW91J3JlIGRvaW5nIGhlcmUgYXMg
YSBjb21tZW50IHBsZWFzZSAqLw0KPiBpZiAobWFzayA8IEdFTk1BU0soMzEsIDApKSB7DQo+IAlp
bnN0Lm1hc2sgPSB+bWFzazsNCj4gCWVyciA9IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kIC4uLg0K
PiAJdXNlX21hc2sgLi4uDQo+IH0NCk9LLCBJJ2xsIGNoYW5nZSB0aGUgVTMyX01BWCB0byBHRU5N
QVNLKDMxLCAwKS4NCg0KPiANCj4gLyogUE9MTCBpcyBhIGxlZ2FjeSBvcGVyYXRpb24gaW4gR0NF
IGFuZCAuLi4gZXRjIGV0YyAqLw0KPiBpbnN0Lm1hc2sgPSBhZGRyOw0KPiBpbnN0LmRzdF90ID0g
Li4uDQo+IGluc3Quc29wID0gLi4uDQo+IGVyciA9IGNtZHFfcGt0X2FwcGVuZC4uLiBldGMgZXRj
IGV0Yw0KPiANCk9LLCBJJ2xsIGNoYW5nZSBsaWtlIHRoaXMgYW5kIEknbGwgdXNlIGluc3QudmFs
dWUgPSBhZGRyOw0KYmVjYXVzZSBhZGRyIGlzIG5vdCBtYXNrLg0KDQo+IA0KPiA+ICsJCWluc3Qu
b3AgPSBDTURRX0NPREVfTUFTSzsNCj4gPiArCQlpbnN0Lm1hc2sgPSB+bWFzazsNCj4gPiArCQll
cnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+ICsJCWlmIChlcnIg
IT0gMCkNCj4gPiArCQkJcmV0dXJuIGVycjsNCj4gPiArCQl1c2VfbWFzayA9IENNRFFfUE9MTF9F
TkFCTEVfTUFTSzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogUE9MTCBpcyBh
biBvbGQgb3BlcmF0aW9uIGluIEdDRSBhbmQgaXQgZG9lcyBub3Qgc3VwcG9ydCBTUFINCj4gPiBh
bmQgQ01EUV9DT0RFX0xPR0lDLA0KPiA+ICsJICogc28gaXQgY2FuIG5vdCB1c2UgY21kcV9wa3Rf
YXNzaWduIHRvIGtlZXAgcG9sbGluZyByZWdpc3Rlcg0KPiA+IGFkZHJlc3MgdG8gU1BSLg0KPiA+
ICsJICogSXQgbmVlZHMgdG8gdXNlIEdQUiBhbmQgQ01EUV9DT0RFX01BU0sgdG8gbW92ZSBwb2xs
aW5nDQo+ID4gcmVnaXN0ZXIgYWRkcmVzcyB0byBHUFIuDQo+ID4gKwkgKi8NCj4gPiArCWluc3Qu
b3AgPSBDTURRX0NPREVfTUFTSzsNCj4gPiArCWluc3QuZHN0X3QgPSBDTURRX1JFR19UWVBFOw0K
PiA+ICsJaW5zdC5zb3AgPSBDTURRX1BPTExfSElHSF9BRERSX0dQUjsNCj4gPiArCWluc3QubWFz
ayA9IGFkZHI7DQo+ID4gKwllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3Qp
Ow0KPiA+ICsJaWYgKGVyciA8IDApDQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKwlp
bnN0Lm9wID0gQ01EUV9DT0RFX1BPTEw7DQo+ID4gKwlpbnN0LmRzdF90ID0gQ01EUV9SRUdfVFlQ
RTsNCj4gPiArCWluc3Quc29wID0gQ01EUV9QT0xMX0hJR0hfQUREUl9HUFI7DQo+IA0KPiBUaGlz
IGlzIGEgcmVhc3NpZ25tZW50IG9mIHRoZSBzYW1lIHZhbHVlLiBZb3UgY2FuIGRvIGl0IGxpa2UN
Cj4gDQo+IC8qIGRzdF90IGFuZCBzb3AgbXVzdCBiZSBDTURRX1JFR19UWVBFLCBDTURRX1BPTExf
SElHSF9BRERSX0dQUiAqLw0KPiBpbnN0Lm9wID0gQ01EUV9DT0RFX1BPTEw7DQo+IGluc3Qub2Zm
c2V0IC4uLg0KPiBpbnN0LnZhbHVlIC4uLi4NCj4gDQppbnN0IGlzIHVzZWQgdG8gZ2VuZXJhdGUg
YW4gaW5zdHJ1Y3Rpb24gZm9yIEdDRSwgc28gaXQgd2lsbCBiZQ0KcmVhc3NpZ25lZCBldmVyeSB0
aW1lIGFmdGVyIGNhbGxpbmcgY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCnRv
IGFwcGVuZCBhIGdlbmVyYXRlZCBpbnN0IGludG8gdGhlIGNtZCBidWZmZXIuDQoNCj4gKGJ1dCB5
b3UncmUgYWxzbyBpbmhlcml0aW5nIHRoZSBzYW1lIGBpbnN0Lm1hc2tgLCB3YXMgdGhhdCBpbnRl
bmRlZD8pDQo+IA0KVGhlIGRlZmluaXRpb24gb2YgY21kcV9pbnN0cnVjdGlvbiBpczoNCg0Kc3Ry
dWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0KCXVuaW9uIHsNCgkJdTMyIHZhbHVlOw0KCQl1MzIgbWFz
azsNCgkJc3RydWN0IHsNCgkJCXUxNiBhcmdfYzsNCgkJCXUxNiBzcmNfcmVnOw0KCQl9Ow0KCX07
DQoJdW5pb24gew0KCQl1MTYgb2Zmc2V0Ow0KCQl1MTYgZXZlbnQ7DQoJCXUxNiByZWdfZHN0Ow0K
CX07DQoJLi4uDQp9Ow0KDQpzbyBpbnN0Lm1hc2sgYW5kIGluc3QudmFsdWUgYXJlIHRoZSBzYW1l
IHUzMiBpbiBpbnN0Lg0KVGhhdCBtZWFucyBpbnN0Lm1hc2sgaGFzIGJlZW4gcmVhc3NpZ25lZCBh
cyB0aGUgaW5zdC52YWx1ZSBoZXJlLg0KDQo+IGVyciA9IGNtZHFfcGt0X2FwcGVuZCAuLi4uDQo+
IGlmIChlcnIgPCAwKQ0KPiAJcmV0dXJuIGVycjsNCj4gDQo+IHJldHVybiAwDQo+IH0NCg0KT0ss
IEknbGwgY2hhbmdlIGl0IHRvIHJldHVybiAwLg0KDQo+IA0KPiA+ICsJaW5zdC5vZmZzZXQgPSB1
c2VfbWFzazsNCj4gPiArCWluc3QudmFsdWUgPSB2YWx1ZTsNCj4gPiArCXJldHVybiBjbWRxX3Br
dF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0wo
Y21kcV9wa3RfcG9sbF9hZGRyKTsNCj4gPiArDQo+ID4gICBpbnQgY21kcV9wa3RfYXNzaWduKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0KPiA+ICAgew0KPiA+
ICAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7fTsNCj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGIvaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4IGI2ZGJlMmQ4ZjE2YS4uMmZlOWJl
MjQwZmJjIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+
ID4gQEAgLTI1Myw2ICsyNTMsMjIgQEAgaW50IGNtZHFfcGt0X3BvbGwoc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHU4DQo+ID4gc3Vic3lzLA0KPiA+ICAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1
Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiA+ICAgCQkgICAgICAgdTE2IG9mZnNldCwg
dTMyIHZhbHVlLCB1MzIgbWFzayk7DQo+ID4gICANCj4gPiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0
X3BvbGxfYWRkcigpIC0gQXBwZW5kIHBvbGxpbmcgY29tbWFuZCB0byB0aGUgQ01EUQ0KPiA+IHBh
Y2tldCwgYXNrIEdDRSB0bw0KPiA+ICsgKgkJCSBleGVjdXRlIGFuIGluc3RydWN0aW9uIHRoYXQg
d2FpdCBmb3IgYQ0KPiA+IHNwZWNpZmllZA0KPiA+ICsgKgkJCSBhZGRyZXNzIG9mIGhhcmR3YXJl
IHJlZ2lzdGVyIHRvIGNoZWNrIGZvciB0aGUNCj4gPiB2YWx1ZQ0KPiA+ICsgKgkJCSB3LyBvciB3
L28gbWFzay4NCj4gPiArICoJCQkgQWxsIEdDRSBoYXJkd2FyZSB0aHJlYWRzIHdpbGwgYmUgYmxv
Y2tlZCBieQ0KPiA+IHRoaXMNCj4gPiArICoJCQkgaW5zdHJ1Y3Rpb24uDQo+IA0KPiAvKioNCj4g
ICAqIGNtZHFfcGt0X3BvbGxfYWRkcigpIC0gQXBwZW5kIGJsb2NraW5nIFBPTEwgY29tbWFuZCB0
byBDTURRDQo+IHBhY2tldA0KPiAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ICAgKiBAYWRk
cjoJdGhlIGhhcmR3YXJlIHJlZ2lzdGVyIGFkZHJlc3MNCj4gICAqIEB2YWx1ZToJdGhlIHNwZWNp
ZmllZCB0YXJnZXQgcmVnaXN0ZXIgdmFsdWUNCj4gICAqIEBtYXNrOgl0aGUgc3BlY2lmaWVkIHRh
cmdldCByZWdpc3RlciBtYXNrDQo+ICAgKg0KPiAgICogQXBwZW5kcyBhIHBvbGxpbmcgKFBPTEwp
IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0IGFuZCBhc2tzIHRoZQ0KPiBHQ0UNCj4gICAqIHRv
IGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCBjaGVja3MgZm9yIHRoZSBzcGVjaWZpZWQgYHZh
bHVlYA0KPiAod2l0aA0KPiAgICogb3Igd2l0aG91dCBgbWFza2ApIHRvIGFwcGVhciBpbiB0aGUg
c3BlY2lmaWVkIGhhcmR3YXJlIHJlZ2lzdGVyDQo+IGBhZGRyYC4NCj4gICAqIEFsbCBHQ0UgdGhy
ZWFkcyB3aWxsIGJlIGJsb2NrZWQgYnkgdGhpcyBpbnN0cnVjdGlvbi4NCj4gICAqDQo+ICAgKiBS
ZXR1cm46IDAgZm9yIHN1Y2Nlc3Mgb3IgbmVnYXRpdmUgZXJyb3IgY29kZQ0KPiAgICovDQo+IA0K
PiBUaGF0J3MgYmV0dGVyLCBpc24ndCBpdD8gOi0pDQo+IA0KT0ssIEknbGwgY2hhbmdlIHRoYXQu
IFRoYW5rcyBmb3IgbWFraW5nIHRoZSBlbnRpcmUgc2FtcGxlLg0KDQpSZWdhcmRzLA0KSmFzb24t
SkguTGluDQoNCj4gQ2hlZXJzLA0KPiBBbmdlbG8NCj4gDQo+IA0K

