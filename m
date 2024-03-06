Return-Path: <linux-kernel+bounces-93470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2CE873044
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9F61C22D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A184E5D495;
	Wed,  6 Mar 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bXMA23n6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FwwsGA9A"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC835C8F9;
	Wed,  6 Mar 2024 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712491; cv=fail; b=ZbcUoZBd0Cnr+oDQLO9IfZq65pJJtsjc5A5HRAAiVA51qKyapkjISKN2Q0la9joQzkpjsvwJ1DK8qqN8fVmCASkIzfvLprA5XtSZ4mnu/2xoftwCMPaDTsz/dNLg9h/ujcHwkvFNbu0+e9wpXqkQHp33/teBnA2giJtggsjItWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712491; c=relaxed/simple;
	bh=t/ZPVMZXD6y5M0jruRy73ObNEM2nkuiII75rrLVzyPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RAql9a8bXhZA6QV/LByWKtWxpSOB44Tv9ZqKKImeCGLc5uflgdDfWZ+FGMXXhnzEgdRuDGnPuLKaejMQ4cA7h0q+LPDQAPZ9WdLzPfcX5vX/4K6ZZAepmijOmGZU0QZ11cqlVZAbLglQzmXkHMTLapWLCMHVO0g4sMirE6p1v+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bXMA23n6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FwwsGA9A; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a72ded9adb9011ee935d6952f98a51a9-20240306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=t/ZPVMZXD6y5M0jruRy73ObNEM2nkuiII75rrLVzyPU=;
	b=bXMA23n6qrmFrh3H/wHwkS4bym496XH3VEvycOYMeCd0Qvp5ICpoDBDJybqL277H55FEu9YOZbFRyRh4cx39TYwysDdy+LQThgm6tUp674TjGZRnnJ+9x/7V9/LY23AJLVb78BruynuxjHbeCvfGNAk0b6cMIa97Zoee9XA4N34=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d6d35919-290a-4891-8f48-721b0934dbad,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:28202d81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a72ded9adb9011ee935d6952f98a51a9-20240306
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <yunfei.dong@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1932936904; Wed, 06 Mar 2024 16:08:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Mar 2024 16:08:00 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Mar 2024 16:08:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1J7+RI+Upk4+s+jF89JjWr0TqMIp/risduqYObiIVPV8oIfnM09ilFRDCU6Uuqhzr9RvbPLRwkUH/0Z2k3ILkL0OymavxO19aDkp4ZSIOiGXmXVgU5S1l/IcnYLg2cmppM7goJZgfMhQTqUSe88Ryk/F2zjWFP+Zesh1TesRzw8MtBe8fM7P58nAmt0CmkahRTkzvyG4kUMqtXdQQAP7CzYCeintzLh/IHN5di97444SrNqvWNuInknFob7RCjqEyngkA9ht4/1r+cv25UQkUEp/UdkRVTaSIDDCE0XI1kTOAPvhNVMf/+IBzoxVT/hTeNbuUL6/hnRgeBv5l4pZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/ZPVMZXD6y5M0jruRy73ObNEM2nkuiII75rrLVzyPU=;
 b=Xaz4ywCLm34hpvrNzY1c1jhYk5w9fNe2Qwq+0kY38ZobTnRCFCQUPJJWlhDPD7vn1nLlynPh8MsqzBqi/96zehEJw5BFwW0uFw8976vhEEPBQJk27h1kypUD3PPJYlnP1gdOwr62rAzSrwju+SU1umARtuPfbLNaRV1OBjaPF98vzGk1eezs/y2t2ecTPdcq9ZB/rVOORvtVv2rQu3ch861NsJg5I0M2RIgA3eMry5AeL6jdHQdutpXCnIb3WFD8y/Sm0wEhpHnJUZ7IH2QU2N7lTHr+oU6Sm5AX06ex4aWaXiP5CBDnKuW7IatxynyjkF3xg8vFPiiRuY9aUaLvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/ZPVMZXD6y5M0jruRy73ObNEM2nkuiII75rrLVzyPU=;
 b=FwwsGA9A1URKIi+Fuq2B7RVKilfgVtkGhz3GsM0f8ekizW1RihmrCxm83hzNJqszAH3+txJmWGY1daYNXz6hNmkYULdWTcawISNy9Xgmb3Fz4FysNz6ffYfk9VccSR6v5PbbEFu13qwhgQ6O95UJStRrh53cy/R4jyD3X/ljKUk=
Received: from OSQPR03MB8697.apcprd03.prod.outlook.com (2603:1096:604:292::8)
 by SEYPR03MB7628.apcprd03.prod.outlook.com (2603:1096:101:13d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 08:07:58 +0000
Received: from OSQPR03MB8697.apcprd03.prod.outlook.com
 ([fe80::9e99:12:7cbe:1294]) by OSQPR03MB8697.apcprd03.prod.outlook.com
 ([fe80::9e99:12:7cbe:1294%3]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 08:07:58 +0000
From: =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= <Yunfei.Dong@mediatek.com>
To: "sebastian.fricke@collabora.com" <sebastian.fricke@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"frkoenig@chromium.org" <frkoenig@chromium.org>, "stevecho@chromium.org"
	<stevecho@chromium.org>, "nhebert@chromium.org" <nhebert@chromium.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "hsinyi@chromium.org"
	<hsinyi@chromium.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>
Subject: Re: [PATCH] media: mediatek: vcodec: support 36bit physical address
Thread-Topic: [PATCH] media: mediatek: vcodec: support 36bit physical address
Thread-Index: AQHaa3xzr7P+z/OFNEClVpf2N0kmjbEipVGAgAe+gYA=
Date: Wed, 6 Mar 2024 08:07:58 +0000
Message-ID: <a8c9ec95ace5b6749d28b7e81151b371700bcc03.camel@mediatek.com>
References: <20240301020126.11539-1-yunfei.dong@mediatek.com>
	 <20240301095217.bmsnizobpb736fgg@basti-XPS-13-9310>
In-Reply-To: <20240301095217.bmsnizobpb736fgg@basti-XPS-13-9310>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR03MB8697:EE_|SEYPR03MB7628:EE_
x-ms-office365-filtering-correlation-id: eb0c5781-a65a-4996-9343-08dc3db4893d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y/bfKMqYsdc0PlBBC4SEM27/h0C90y6j/TdxvDa0NEYyQd/GuisBFF/iq2A5eZpv03CfIGJEFrRO+AxgLQJC4zNPEkQNSBBSgNsGs2chv5Sdf5hxIKTyvem2HjUkNGk4e/4enraeBbmnBW6pGOQLtf/+C1eYUMYkByKP4ldjaD9bObA8oZrTI3TNA+hUUe7nReK5d4b0FQvJtfhIJEtixauvkYkkdTrdpq0kBefrA2Vx4j5I2nMup3NFkc2MXD4tFO3+va3Ledpeb3UDTyiVhTprpUA2IbKoxvHS/FkvrC3FyCsWG25OvPwlxBtWov4n3k1/R37ro7adMarrj/NlUDtVLeT0fLdPSuUiwkoJ9o5TuEnUDEcx/CBGg+OMf2DTRLdGoZmgLDQ0AfwwxHbOxFM/s+1uyZ+x5LOZUVKmJSbMfQEQL+RvkTr5iWOF3zStbpyuKRSPHPL6J9uJx8tUVqoARCvrJ9tn1kS8gNWJls78AKU/A4WmvrHc0LJvRkd5T1Ah9bGULzy2oIzgaj7oGhXk6mFhubkfHHTiFLt8BO/gvY0o+CUydHfqJP9P8R+103n1ZlefisllC7pxQPsn1Jmzy5xSiZAaZ6L79+83nUlskqCISOyBhYBlHBZci41XL9NebJdgZxMAXH9vmgKrqr6ovmwE9GvZh5+AS0AZvW5jZDpOeo1Ab+HH4/Z1r+mcihhPyJSjqC7LQg6e/MOzFIcy4gS1bRMy0r37K/5XD+w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR03MB8697.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzdWdFFRQ3ExeUlUZ0FnY1lLRnl4MmExNW9oK3lhRHh5emNFSS9HcEFkelVj?=
 =?utf-8?B?N0s1eGhRQ3lnQXNrYW5TR0dCcnBHOUFITWlxVEtQaGpMQ056akpTTHppdllm?=
 =?utf-8?B?cWtsM2hNakVrWjczV0o1TXVlcElPd1ZoZC9ERG9BWkp5MThYSzZ4bkQ5aWNE?=
 =?utf-8?B?cGM1cUNXbkJOdkQ5c3ZhYzcyenYzTlJDMkhNUDlpT3BuTEtSMGw5K3FGcFFE?=
 =?utf-8?B?TWRsK0tGa1B4OTE5K2U2b1I0QW9NRERPV0V3ejUwaEhVa0hneUd3bzRqTTFE?=
 =?utf-8?B?dkNBMU9zS0lueDNKQ0FEcHgwaXhqY0VLRVhaQ2Q3a3hDekJNcm9hT1cxTGJH?=
 =?utf-8?B?aG5hWWFIdWwwc2dzWDV2YTlGQU5xalN6bXJlZ205NDh6NVVHVWNKeGsyeVVH?=
 =?utf-8?B?MEYzM29NYm1OY1JERUNYSm5wYVZzdkVOTXQwVVBCKzBBbEFvNklLa3Zla29U?=
 =?utf-8?B?aW9idmVRZnNkUVEyOGg4dnBDUXlvaWRaTWRxWmcvUy91bmswdHVwWWtYSnk0?=
 =?utf-8?B?RGhkT1JtTk1hQVpBcFp5alRsQzFNelVrejdDYUhjUjY0UFFTL01XcjlzTCtO?=
 =?utf-8?B?YTVBQmNRZnNMbThRUkdhbVJaMFRvZ0JzVEVCRStEUWM3dXEvZ1BtNloyeTU2?=
 =?utf-8?B?Z1JWaHcxK0pHeCtnRUVLKzFxaHZGRDg3NzRhKzY3MEVrbXJjejdqNU53aXBh?=
 =?utf-8?B?czAyUjRvMXhGWmZOS28yWEJWRXBBd0hOUlhPV3d1TEVGQ0NQQW1IWUlVbFZp?=
 =?utf-8?B?QUZFVEY5WmNDYlFsc1hYZVpLc3dMTS82YndVQkRmNmNNeE9zRExsMmdBUitH?=
 =?utf-8?B?Z2VxSURwbUFwQ2NvKzRyQmE1WjR3YTgzbmlhZzZlamMrN1lCU1JSWDArM1Qr?=
 =?utf-8?B?dkdmeTA2eWdRcnByQW1FRnVGd1VHbGIyWU1uak45U0FKYy9vUkFtaVhrblJ0?=
 =?utf-8?B?Zk5OZjZ6MHdMaVIzb0tXZWhBZkluNHpYZFZBRm1NZ0NTREpIbnJONWh3OEQ3?=
 =?utf-8?B?MGMrMFNVMjRLWTZ5eUNManpzQi9ET2x1WHFlOUU4cVh4QXp6R082Q0ZrTldj?=
 =?utf-8?B?T3l0aE90Uzk4NmpTczJheFNlRmhCUkQ5Y0U4TVc2bUhiZFVKOTRFZExPci9p?=
 =?utf-8?B?ZkU5U3lQQ0ZKM1ZldmxGZDh6SVNaRkdacmltVjZNQ1dhaUpoS29pZmR2b1Jr?=
 =?utf-8?B?M1orS3grYkdKTjFEMUl2eWIxdDRXSGc5L2hZTlJLbStvYS81N2dQQzRRTkpi?=
 =?utf-8?B?Um56V3c5WWQzZTB6Tndhd1VPbjBnOU8vR2pMcEMweDQzc1I0ZDBzNHc0YTFS?=
 =?utf-8?B?Z1p6dE1JOTA3WlNwNnZvMlZVOTZEVFJScXhhcnU2UnZVWCtDSmJERjdtU2hL?=
 =?utf-8?B?RkRiNWlMYkhCQ0RFWE4rNjdYbmlkOVBYSFhiT2poSWtCeDR3MHRLeTBpa3FX?=
 =?utf-8?B?R3FJUFhTUnFDb21rTDYxbk5OeC95NnFEWEdheEtPRUJDRTZMV1BYTEdmNzY5?=
 =?utf-8?B?a0ZicTRLNHBUSys5Nm5ZaFY2cUZacittM0JaU3BxYXhDdHU2ZTR3TmN5Qy9W?=
 =?utf-8?B?M2hWd3REWVNKVmw0eVJVdGl1aVJXRWQvcUt1VzU3aWl0OWpiM1BlSlg0dERW?=
 =?utf-8?B?MFMxdllybzJCQ3F3cU1MWitsOWJMWENxekViS1BPMWNwYWlaU0V0UHlSSlY2?=
 =?utf-8?B?dHhNekh5T2JIcVRSZlZ2UFYwM0hGci9BMkh6dlVCdmVxb3ZKZUZNdmIzOWh2?=
 =?utf-8?B?STM3OUJzV2IyUlRiQXJhSFViRXk1NVRTclVpY3Q2bmxSdVpVb2RmeDJwUHV0?=
 =?utf-8?B?WU9PZk9QcUh0bUloSGwxVUx4eGdmUVFPcGpzbENIRkZvTWs4Y3RWdkNXTFo0?=
 =?utf-8?B?cFdqZ3pSSnZWTkNqTHB4dGRPSTZuR3NGMjBrY3U5akJwc25TSjZzZGxDeVRJ?=
 =?utf-8?B?K25rRzFFSkR2K05iV2tNT0tiRTU4ZUpKRWpDdEZtUEtLUG8zNjZOWmVFQ3Bw?=
 =?utf-8?B?Rm9zTmJaNWF5ZnFuRjU2bzExR2dMMTkyRy9JRnk0SGhteEd0dlZsZ3VYVWxD?=
 =?utf-8?B?SXgwNkJNM2g1UEdJQkl6cHR1QU9hMEZPYVBETHo4djBNVXFkWktzUzJDTzBU?=
 =?utf-8?B?azJlNjIwdXhMemZCdTdyV2RSYmJzZm5BZXBnUG5kM3MxaWQzOVlvTDhxVGRn?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B1D9A9C37C3EC44AC53BBC103E4AAA3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR03MB8697.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0c5781-a65a-4996-9343-08dc3db4893d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 08:07:58.5336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2h3HLuf+NlA1recicpjRE9UIwoLxElfUH8CrOYlJbSKpokcVDqiLsi0PUkVH0t4b0y587yb9iq2Ma2Vt0s2fPBBLnVDPpWRpMr1VUx5GEB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7628
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--23.328100-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2q5lTsHJBA0keYAh37ZsBDC1kqyrcMalqUNcckEPxfz2D6h
	VXnKDh9XtdqVep+vHB6TnOeejF/wC3976qbiQKm/EdFsavUQKAdt3qsaFY4DBKkWpjwkfPsw+Vi
	hXqn9xLE8VyRVdn8owLh2A/eCGwbIr1U+m35BVv6Pnpohp8ng0V87n+gjBxQbLBJYfEYh1PU8a1
	q4OK4oC5bemgZX71GBH5VvilZUGGS+7XBcDCQqkF6VRCJSU7j9ndls9F9zmi2bKItl61J/yfmS+
	aPr0Ve8oTCA5Efyn8CNo+PRbWqfRJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.328100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1DCB63F52D174889DADE7BB7D6005A8A72728AD6F54915787CEBF7C086D792D32000:8
X-MTK: N

SGkgU2ViYXN0aWFuLA0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLg0KT24gRnJpLCAyMDI0LTAz
LTAxIGF0IDEwOjUyICswMTAwLCBTZWJhc3RpYW4gRnJpY2tlIHdyb3RlOg0KPiBIZXkgWXVuZmVp
LA0KPiANCj4gT24gMDEuMDMuMjAyNCAxMDowMSwgWXVuZmVpIERvbmcgd3JvdGU6DQo+ID4gVGhl
IHBoeXNpY2FsIGFkZHJlc3MgaXMgYmV5b25kIDMyYml0IGZvciBtdDgxODggcGxhdGZvcm0sIG5l
ZWQNCj4gPiB0byBjaGFuZ2UgdGhlIHR5cGUgZnJvbSB1bnNpZ25lZCBpbnQgdG8gdW5zaWduZWQg
bG9uZyBpbiBjYXNlIG9mDQo+ID4gdGhlIGhpZ2ggYml0IG1pc3NpbmcuDQo+IA0KPiBJIHdvdWxk
IHJld29yZCB0aGlzIGEgYml0LCB0aGUgYWRkcmVzcyBpcyBub3QgYmV5b25kIDMyIGJpdCwgd2hp
Y2gNCj4gd291bGQNCj4gY291bGQgYmUgaW50ZXJwcmV0IGFzIGlmIHRoZSBhZGRyZXNzIHN0YXJ0
cyBhZnRlciAzMm5kIGJpdCwgaW5zdGVhZA0KPiBpdA0KPiBpcyBsYXJnZXIgdGhhbiAzMmJpdHMu
IFNlY29uZGx5LCB3ZSBkb24ndCBjaGFuZ2UgdGhlIHR5cGUgaW4gY2FzZSB0aGUNCj4gaGlnaCBi
aXQgaXMgbWlzc2luZywgd2UgY2hhbmdlIHRoZSB0eXBlIHVuY29uZGl0aW9uYWxseSwgd2UgZG8g
Y2hhbmdlDQo+IHRoZSB0eXBlIHNvIHRoYXQgdGhlIGhpZ2ggYml0IGlzbid0IG1pc3NpbmcuDQo+
IA0KPiBNeSBzdWdnZXN0aW9uOg0KPiANCj4gVGhlIHBoeXNpY2FsIGFkZHJlc3Mgb24gdGhlIE1U
ODE4OCBwbGF0Zm9ybSBpcyBsYXJnZXIgdGhhbiAzMiBiaXRzLA0KPiBjaGFuZ2UgdGhlIHR5cGUg
ZnJvbSB1bnNpZ25lZCBpbnQgdG8gdW5zaWduZWQgbG9uZyB0byBiZSBhYmxlIHRvDQo+IGFjY2Vz
cw0KPiB0aGUgaGlnaCBiaXRzIG9mIHRoZSBhZGRyZXNzLg0KPiANCkkgd2lsbCByZXdyaXRlIHRo
ZSBjb21taXQgbWVzc2FnZSBhY2NvcmRpbmcgdG8geW91ciBhZHZpY2UuDQo+IE9uZSBtb3JlIHF1
ZXN0aW9uIGJlbG93Li4uDQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25n
IDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gLi4uL21lZGlhdGVrL3Zj
b2RlYy9kZWNvZGVyL3ZkZWMvdmRlY192cDlfcmVxX2xhdF9pZi5jICAgICAgICB8IDQNCj4gPiAr
Ky0tDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlh
dGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRlY192cDlfcmVxXw0KPiA+IGxhdF9pZi5jDQo+ID4g
Yi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRl
Y192cDlfcmVxXw0KPiA+IGxhdF9pZi5jDQo+ID4gaW5kZXggY2Y0OGQwOWI3OGQ3Li44NWRmM2U3
YzI5ODMgMTAwNjQ0DQo+ID4gLS0tDQo+ID4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlh
dGVrL3Zjb2RlYy9kZWNvZGVyL3ZkZWMvdmRlY192cDlfcmVxXw0KPiA+IGxhdF9pZi5jDQo+ID4g
KysrDQo+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9kZWNvZGVy
L3ZkZWMvdmRlY192cDlfcmVxXw0KPiA+IGxhdF9pZi5jDQo+ID4gQEAgLTEwNzQsNyArMTA3NCw3
IEBAIHN0YXRpYyBpbnQNCj4gPiB2ZGVjX3ZwOV9zbGljZV9zZXR1cF90aWxlX2J1ZmZlcihzdHJ1
Y3QgdmRlY192cDlfc2xpY2VfaW5zdGFuY2UNCj4gPiAqaW5zdA0KPiA+IAl1bnNpZ25lZCBpbnQg
bWlfcm93Ow0KPiA+IAl1bnNpZ25lZCBpbnQgbWlfY29sOw0KPiA+IAl1bnNpZ25lZCBpbnQgb2Zm
c2V0Ow0KPiA+IC0JdW5zaWduZWQgaW50IHBhOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBwYTsNCj4g
PiAJdW5zaWduZWQgaW50IHNpemU7DQo+ID4gCXN0cnVjdCB2ZGVjX3ZwOV9zbGljZV90aWxlcyAq
dGlsZXM7DQo+ID4gCXVuc2lnbmVkIGNoYXIgKnBvczsNCj4gPiBAQCAtMTEwOSw3ICsxMTA5LDcg
QEAgc3RhdGljIGludA0KPiA+IHZkZWNfdnA5X3NsaWNlX3NldHVwX3RpbGVfYnVmZmVyKHN0cnVj
dCB2ZGVjX3ZwOV9zbGljZV9pbnN0YW5jZQ0KPiA+ICppbnN0DQo+ID4gCXBvcyA9IHZhICsgb2Zm
c2V0Ow0KPiA+IAllbmQgPSB2YSArIGJzLT5zaXplOw0KPiA+IAkvKiB0cnVuY2F0ZWQgKi8NCj4g
PiAtCXBhID0gKHVuc2lnbmVkIGludClicy0+ZG1hX2FkZHIgKyBvZmZzZXQ7DQo+ID4gKwlwYSA9
ICh1bnNpZ25lZCBsb25nKWJzLT5kbWFfYWRkciArIG9mZnNldDsNCj4gDQo+IEkgY2FuIHNlZSBp
biBvdGhlciBwYXJ0cyBvZiB0aGUgZHJpdmVyIHRoYXQgYnMtPmRtYV9hZGRyIGlzIGNvbnZlcnRl
ZA0KPiB0bw0KPiB1NjQgb3IgdWludDY0X3QuIElzIHVuc2lnbmVkIGxvbmcgYWx3YXlzIDY0LWJp
dCBvbiB0aGUgZGlmZmVyZW50DQo+IE1lZGlhdGVrIHBsYXRmb3Jtcz8gSWYgc28sIHdoeSBkbyB5
b3UgcHJlZmVyIHVuc2lnbmVkIGxvbmcgb3ZlciB1NjQ/DQo+IChXaGljaCBkZXNjcmliZXMgdGhl
IHR5cGUgbW9yZSBwcmVjaXNlbHkpDQo+IA0KRm9yIDY0LWJpdCBzeXN0ZW0sIHVuc2lnbmVkIGxv
bmcgaXMgdTY0IG9yIHVpbnQ2NF90Lg0KVGhlIHBhIGlzIG92ZXIgMzJiaXQgZm9yIG10ODE4OCg2
NGJpdCBzeXN0ZW0pLg0KVGhlIHBhIGlzIDMyYml0IGZvciBtdDgxOTUvbXQ4MTkyL210ODE4NiBl
dGMoNjRiaXQgc3lzdGVtKS4NCg0KcGEgPSAodW5zaWduZWQgbG9uZylicy0+ZG1hX2FkZHIgKyBv
ZmZzZXQ7DQoNCi0+IEkgbmVlZCB0byByZW1vdmUgJ3Vuc2lnbmVkIGxvbmcnIGJlZm9yZSBicy0+
ZG1hX2FkZHIuDQpGb3IgMzJiaXQgcGEsIHRoZSBoaWdoIGJpdCBpcyB6ZXJvLCB3b24ndCBpbmZs
dWVuY2UgdGhlIGhhcmR3YXJlDQpkZWNvZGVyLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9u
Zw0KPiAoU2FtZSBhcHBsaWVzIGZvcjoNCj4gZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRl
ay92Y29kZWMvZGVjb2Rlci92ZGVjL3ZkZWNfdnA4X2lmLmM6NDUyDQo+ICkNCj4gDQpPaywgSSB3
aWxsIGNoYW5nZSBpdCBpbiBuZXh0IHBhdGNoLg0KPiBHcmVldGluZ3MsDQo+IFNlYmFzdGlhbg0K
PiANCj4gPiAJdGIgPSBpbnN0YW5jZS0+dGlsZS52YTsNCj4gPiAJZm9yIChpID0gMDsgaSA8IHJv
d3M7IGkrKykgew0KPiA+IAkJZm9yIChqID0gMDsgaiA8IGNvbHM7IGorKykgew0KPiA+IC0tIA0K
PiA+IDIuMTguMA0KPiA+IA0KPiA+IA0K

