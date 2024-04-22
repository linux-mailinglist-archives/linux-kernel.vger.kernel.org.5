Return-Path: <linux-kernel+bounces-152877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01D08AC59E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF611F24AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DB24D108;
	Mon, 22 Apr 2024 07:30:53 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1801.securemx.jp [210.130.202.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB9495F0;
	Mon, 22 Apr 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771053; cv=fail; b=IaZKPjYgj8CI3W0wfkjUClyh9uSD9RCHA/t0P+DqX1nYwR21gRNA919NRrfmZosK5bZQqtAXfgYiEwROdvhU+VYhabX20oA9r+FTUPjvfDZBic9pGS0hKzwQQwGo8AJzGrd7V49MYpsPpmXFeOxwJCP7i0x9nfMbruhVabKZZLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771053; c=relaxed/simple;
	bh=Iy65Zlvg/uyUh48RI8AkLk2VNXnC1q1TO86hbVb3/dA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dxVdKBWWZO0evMQmsSN9Nf7dOjtV6UcTgHvyHV4r1fGh4zrdlg1nq7bv6hcyzfap6FwDL64mXnWZg2t34C9syXQuQdXOO5vCokqVlrT8G5GXm399nnW6n1ENaJpPWcCLmNHXfxU/kVeA4VGdATG3DgmvFFej73vf8jVidxIsM6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; arc=fail smtp.client-ip=210.130.202.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1801) id 43M6pNch784471; Mon, 22 Apr 2024 15:51:23 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 43M6oWtq2554810; Mon, 22 Apr 2024 15:50:32 +0900
X-Iguazu-Qid: 2yAbLYkr58FqArZVs8
X-Iguazu-QSIG: v=2; s=0; t=1713768631; q=2yAbLYkr58FqArZVs8; m=1+dzedikmuAUOIwBExoHk1emmtGvaVaszA0rfC/W+BM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 43M6oTb22618413
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:50:30 +0900
X-SA-MID: 20267228
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbcEVFAq2MGa7wU0/1GL4821X9soC8SmKiQOipOpzJcqXlePozVgADKuwlxz6zNuIf+g/4eoUFEGX/3/f4wNmmTMTHwyAm1ZyEdQPMWRlY/pS2lIiXJvADiC6jdIeCyDLkpwQT244/946JxsGARqdTPYwA5mKqzFauA0c6aeQbW1DIB8OX0TJufxignbzzEENfK/IjMgMN3PQicdVFJbW8JNigNfEOTraPp9SJEoa/AZzSmiOpBD9PCfpJomMx6FyJZGxVm8jq+h79YsWjxvRizZ3rJhsqSLKnsRuvDTEP1hB4oiTamD9moVda8sT7WoJAet2LSi7PkpVoOCfXWLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy65Zlvg/uyUh48RI8AkLk2VNXnC1q1TO86hbVb3/dA=;
 b=ZvFezb4L8IV0DkrFXEFFraEd1uogPO7sJjv1cag0StnskJibkSsmtNvyo0Aa+IbrKHTUcTSdOjnqU0XthruyBtmTNHgNbvGkJK59MkuBJlKvNY9ZZcEOcaHJiZLmh+8DB/pnDHUkmzyc5pgaO+ueVwu1hWhuL0cYlWhmdKWb9mMCE600RQTYPWTNYnyoS2zkbWvyY7L4JTJyUXtTB82l1KrIrl7PBAVRbdyX2mIzeXfAK+7xyfEwxKYB3r5Gi43BgswsmJLQt4238HriUlaSKMQNUNqUQ/fxRJhiSelJiUF/HYKjPl+3IUii9GEvN432kFdAxbyrK+wbTCTaKB03Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <yuji2.ishikawa@toshiba.co.jp>
To: <sakari.ailus@iki.fi>
CC: <hverkuil@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 4/5] documentation: media: add documentation for
 Toshiba Visconti Video Input Interface driver
Thread-Topic: [PATCH v9 4/5] documentation: media: add documentation for
 Toshiba Visconti Video Input Interface driver
Thread-Index: AQHZ/NvaHbXU7u9nIUCLRWdm6z8y6rCGd6iAgBJieMCAXnQjAIB9uHig
Date: Mon, 22 Apr 2024 06:45:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB10196F6969BDAE599FF536E4F92122@TYCPR01MB10196.jpnprd01.prod.outlook.com>
References: <20231012071329.2542003-1-yuji2.ishikawa@toshiba.co.jp>
 <20231012071329.2542003-5-yuji2.ishikawa@toshiba.co.jp>
 <ZV3oq0szH8JjSNsc@valkosipuli.retiisi.eu>
 <TYAPR01MB620180FF82B8993B45FF6E0A9286A@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <ZbyQgkGicrnP-XZL@valkosipuli.retiisi.eu>
In-Reply-To: <ZbyQgkGicrnP-XZL@valkosipuli.retiisi.eu>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10196:EE_|TYCPR01MB8549:EE_
x-ms-office365-filtering-correlation-id: 7f8605a5-0dd4-4805-683a-08dc6297c7ad
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SHRxdVlEMDdKRHRxamdzcFB4L2hHL2VYVHVab3dqa0JQbmJNTzN2cGlD?=
 =?iso-2022-jp?B?VU9WTEtXZTRkWEZtWHlhL205QU9qKyt4bUp1Vi9iUXNtYkFlOVQrUFQv?=
 =?iso-2022-jp?B?Zk1BZUd6bXRUM1FkT3c4eGxncXpTZGVvSHJRbGJ1WE1ZWUptazkvYlIy?=
 =?iso-2022-jp?B?ZUZlTk1nNEg5QU1tNk9rQjlBVEN6M0cyYTRGSEdGWUNwRlBGMWxER1RC?=
 =?iso-2022-jp?B?RTlzK2RUTHNUS0ZEQktKRC8rSFpFVlg5TXVqb085blRDRUE4SkZwSXNG?=
 =?iso-2022-jp?B?YndPWFM2RjkrdDcyQXk3cHhrNnVFczlLaGQ5NlhQZFBiVmtRU0grY1A0?=
 =?iso-2022-jp?B?MHI2cXVKRkNyb0haWjFXRCt6blFxaWFsazhjZ0g0T3l3clVaeUY1ak1h?=
 =?iso-2022-jp?B?UUorRlYrbVY5VWkrN1l6UDhPdDlJRCs1RXE1dS95cXVOMmhONTlxeEkw?=
 =?iso-2022-jp?B?R1BtWllqdm8ybTh4NXA3OGNYRUVBQk1DbmdMUSs3VldTNzFsVEV3ejVS?=
 =?iso-2022-jp?B?d2pJZUt0cFFkT1dXU3RxRlFyMkRiTENEaUY0cUFyWEM3OFl2VGZHUFFF?=
 =?iso-2022-jp?B?S2pPQmNaVmczOUl1TlVna3J5SVl6TE12NFhQTStuUk5YWUhFbGY4YTJH?=
 =?iso-2022-jp?B?bGY4L2RrRHpCMjdmclZ2NHN1Um11Mk9hdmtjVk5IL3VEdEI5SG1obklM?=
 =?iso-2022-jp?B?aFpDZTk2eEk0OTBqY1JHMzBHcnhOTFhnZjZ6UWhiSENKamk3RjFkVTFC?=
 =?iso-2022-jp?B?Zy9YdDlBZ0RQUzI2d0liQWt4QUxIT0pmaCt1U2pCcmpMWUIrV2MzRVB0?=
 =?iso-2022-jp?B?UTJKa0ZkckpEUmNnZHR4cFhlOEs0M295K3hzcW9SQlJrY3FxSUhONjh4?=
 =?iso-2022-jp?B?OVU1cW03SzNMUkNzek9GTU1YSCtJdU9YZVEra2QzQVE3ZHJMdlZsZnZi?=
 =?iso-2022-jp?B?bG1HWVpMU29hcnhsWWR0OUE2K1RXbTltdWVKSEhydEUxSzdkUFR6VDRm?=
 =?iso-2022-jp?B?eVRnaTlPM2V1czVaVHcwbm5sdGdMUXI2bEpBL1owd1Z1TEN0RmJySzdO?=
 =?iso-2022-jp?B?K0loajFiV3krV1NNV1hHOW5abUo3Z1FKQUF3Vk5LbWlTd3dUNnZ0TEds?=
 =?iso-2022-jp?B?dmNtUnEzNktwdC9tVHlsNmtPWlRseXM4aVdhd2VVb0dXaHUxVFdNUnFL?=
 =?iso-2022-jp?B?RVZLM3huV2JCZDFPb0o1a1FVSlBtZVhlN2FUdmJqWndsM3lleVV3bXQ3?=
 =?iso-2022-jp?B?SFZ4MDM5Ny9nZWFnbkVmSTNFRzhWTmxTUUNoNFkrYVR0QlgxWE9ub0p4?=
 =?iso-2022-jp?B?czlhVEF3L09PaW9HVmJackZEM2hHN3JiTkxwZUVlNkh1cmN5M3RFNyt0?=
 =?iso-2022-jp?B?N1dzUUlLL3RTekJRNUNHdTQvdGNNdkJpM3BadzAvQWZBUUgwdzlIZGJL?=
 =?iso-2022-jp?B?WFZCT1R1OHZiMDlsYkJFNEVvTEJmQkI5RWVsY0s2Znljdms5Rzl3cW5L?=
 =?iso-2022-jp?B?bUZkUnlvYmdLS3FzbkxhbjhoaUMzK2RNdVBRR3RtOGZ4bnFBZFVRZ1V4?=
 =?iso-2022-jp?B?N2RYdmEwaGxjSkl0Zm50eVpuMWdHNGtrdTZ5dTQvOGJ4bUtrZjdUQnNp?=
 =?iso-2022-jp?B?QWJSTmxFaXZ2N2lUZWd1MUtnV2RZSUdFR3k5R1B1ZThuR1p1QUJBQnRk?=
 =?iso-2022-jp?B?a3hCWm5Zdzg5L3RuN3dETkRjc0xwU1dpUmVjT1VJenFQRTBSZUdBK3hW?=
 =?iso-2022-jp?B?VmxLeW9ickpiZFlZQ0dMS3pyOHdLSDE4ODYvd0U1YSs3Mmhwa2tXT0h0?=
 =?iso-2022-jp?B?THlVVmdvL0tzUXVDNDZsWURYUGhadVF5WlpQRVJXak1VRXkyVmhiZVhl?=
 =?iso-2022-jp?B?UjFxWmVKbk9IU0IvaWthdjZHb3RmU0NzRVhVL2lzYmx6cVNDelZ4NGJS?=
 =?iso-2022-jp?B?K2hUTTJqdm5sN1l0OFZ3akpZZGN4UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10196.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NUw5R1M3Vmc1QUhMSmYrdzFSOTY5Q3JzMUxRZmlWaXNjU1hKZkt3ZFEx?=
 =?iso-2022-jp?B?YWpLZUsvS1JjK0gzcVJEQXU4bEpZS1JyZ2l5UWhjaVNLY1Z4S0dhZmM0?=
 =?iso-2022-jp?B?bWRoMjV0T09wbWZERUgzNzZCVUtKUjRrQkJnMWxxZktJdEtRTUpQMDkv?=
 =?iso-2022-jp?B?WTJ4cE5ma0NWOXRMVEtJZ0dCNyt2TXphZ3dybUFhZUtpNS8vUytHc1lz?=
 =?iso-2022-jp?B?cnVtLzlob3FEZU5XL2h5SjdBMHp4WHZmL0I1WkxTMGd3VWw2VGNvUm9y?=
 =?iso-2022-jp?B?cGFnd2pvQ3JhaTdhQVQwYXJWaURNS3NUVWkyT3hFdmhRMG4wNmVzYWFZ?=
 =?iso-2022-jp?B?WHY2MDZlVnNkQnRzWTZJTTI0YmxMVHdWdVpaWko5Wm9DV3ZmbFJUeGJs?=
 =?iso-2022-jp?B?Zm5vQUlkSDkxRmM3VlovRFV4RWg3Rno5U21oRTlXazBuZStHeVVSdGZk?=
 =?iso-2022-jp?B?OVlMQlJZREpjTm8zdnNhVVdPWVJucnFVR05BSFdPYk80Sll1YUF2MGsz?=
 =?iso-2022-jp?B?WStUb3JsL2FXYmxHWVltbWc2TFB3NkpkeEE4NkZrUjNHLzByN3R5R1hr?=
 =?iso-2022-jp?B?bjFwZ3ZYWG5iNGk1VVFjZVlyN3BXZW5abDI5eHpCL0l3bGRyb0grT05P?=
 =?iso-2022-jp?B?WlU3dWYvU2oyemR3Q01MUlQzaHBrclQ1bVQ1U0pJV2x1ekRZVjdIbVl6?=
 =?iso-2022-jp?B?aE5ZMzB6RjRFd3o2TFZzb2kwbEx6ODVuM2p1NFdyOHcwYkVYTGZnb084?=
 =?iso-2022-jp?B?K0ZsdE5pQXVNWHB5R1UyRTR5eThZYVpyZFJISFlIb091UDhxWkdyUFoy?=
 =?iso-2022-jp?B?ZldrTHRNa0RUSkdWU2QxNEJXRmltOUovaFR6MlBSYzQyOWRmUnR3UVlQ?=
 =?iso-2022-jp?B?VEk1dFdVWjBKZTJOa0FUVTVSK2VyZDIreWZBcE4rekRwckNkK2lYZWp1?=
 =?iso-2022-jp?B?UHpoOHgzOUk4Qm5DTUgvNXZBdm5zbGNtZWdEdjRGQVkxQTZFRDB1NFg0?=
 =?iso-2022-jp?B?VWprZ0xMandaNGtRMkYxdzBiWmlwcktYR29lMVdjdEFyMEpjZkVnUmZr?=
 =?iso-2022-jp?B?eGNXMms5YlpRdlpPeEg4VkVTYW12UnR4QmpXaEl1NnRlUUtzVVVVblFv?=
 =?iso-2022-jp?B?V1ZLZk9xaFdrZmUwRnRjSW56UnJhb1NmZXlCSng4b1p0NWdvSndmRWNX?=
 =?iso-2022-jp?B?Wmc0aENBc2NhQzEvSnFTRzdjbnFTTFR3eEZPbkpqSXBPZXgwMUNvaGJW?=
 =?iso-2022-jp?B?NkRHZVJjb050VUdNSFBjSWIwQ1d6eDVQNzRQVXZ0NDJaNm4wZE5iNHVa?=
 =?iso-2022-jp?B?amtNQmtzYzRkQkd0Nk5MdlNsUFU3azJ2UUt4ZVRNTVg4Z2Zpakg0M3g5?=
 =?iso-2022-jp?B?c3pZazQ0OXBSd2tGYTFrSUNUUklyRWpaTGJ3SGh3U0FCV1p3TjlUT1Vu?=
 =?iso-2022-jp?B?emlKOUxhb3FPeVJyVE9HenhtYTdDNDl4ZXpEczU0KzBVaWFLVCtUOFdB?=
 =?iso-2022-jp?B?djJyNnIxWmdPcTNIRHpKdXdQZUtCeXg5RGtGQXdXVjFJNXFUMzZrRFFr?=
 =?iso-2022-jp?B?OGVVTUZoN0twZHR4TlZNZUlWOW5LSk9vS3dkMEI1aytKeFRWeWpJcFhH?=
 =?iso-2022-jp?B?bnhVZTJoTGhiUFpBaWhoUTJNRWprWUpjZ01qRGcxUy82cUpxRzhqSDZl?=
 =?iso-2022-jp?B?OWp4YkJzbnhYOS9NUFc1RnVqTzNaZGx6bE1EZjhlVk4xbEd1L3AvdmNs?=
 =?iso-2022-jp?B?NStGS0tQSEVua2IrQkNmeEErSnQzc1p3UFhjSjROZ1pIUEJCdVh1MlR2?=
 =?iso-2022-jp?B?WEdWL3lubHdnQXowS2F4VXVkckwxQTdPQjAyK05aZG5GanFlbnBHQW9r?=
 =?iso-2022-jp?B?S0FhUGFjQmRNOEZuR082RGpyZDBjNWhTK2lyK1BXcG8rdXl0eFVhMkN1?=
 =?iso-2022-jp?B?dEJreWV4cEhTSUNzY0Y5cFJwM2JwcStQUlNyR01KQis5bHB4clgySFVL?=
 =?iso-2022-jp?B?ejB6cktmOVRneE9UQWhZNnBnZEYzOFRCNTB2WDdCYkNDZFpYRkpkUkJ6?=
 =?iso-2022-jp?B?Q2FWV3kvMHgrNmxidDJQV1MzdkFyL25aY0FNSEI3NDk4N0lCd3R2UVVN?=
 =?iso-2022-jp?B?eVZ1WVExdmNIdVB4MG5YbnRSVU5hYW12RmhUa3RMK2NTUnkzTHBWK1p5?=
 =?iso-2022-jp?B?cjQxNi9wbVRXL0NrOVJrMlJSSzZTOUp1NGtDSkMyOElIMC85cGdaU25s?=
 =?iso-2022-jp?B?Z1QzVDNFTCtXSXNicTBZVHBjenQ1ajZQNC92dkZmZUhGOW9IN0c1TVY4?=
 =?iso-2022-jp?B?ejNOeTF1SFJOUXlqNkdYajJ5WGMwbGQ1UXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10196.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8605a5-0dd4-4805-683a-08dc6297c7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 06:45:20.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nziLOOFZ4RCqwE+yKY0lTJ8MHiV6pHNgDS8u/+k4DLup7O2NNIPZ+L8N3dwT4R0W3645wd4EyU0Eh4CVNHxCC7a/f1kzXlHcL6HKUZsUG1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8549

Hello Sakari,

> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@iki.fi>
> Sent: Friday, February 2, 2024 3:50 PM
> To: ishikawa yuji(=1B$B@P@n=1B(B =1B$BM*;J=1B(B =1B$B!{#R#D#C""#A#I#T#C!{=
#E#A3+=1B(B)
> <yuji2.ishikawa@toshiba.co.jp>
> Cc: hverkuil@xs4all.nl; laurent.pinchart@ideasonboard.com;
> mchehab@kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org=
;
> conor+dt@kernel.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$=
B!{#D#I#T#C""#D#I#T!{#O=1B(B
> =1B$B#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; linux-media@vger.kern=
el.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v9 4/5] documentation: media: add documentation for
> Toshiba Visconti Video Input Interface driver
>=20
> Hi Yuji,
>=20
> On Mon, Dec 04, 2023 at 04:32:40AM +0000, yuji2.ishikawa@toshiba.co.jp
> wrote:
> > > > +Vendor specific v4l2 controls
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > +
> > > > +.. _V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE:
> > > > +
> > > > +V4L2_CID_VISCONTI_VIIF_MAIN_SET_RAWPACK_MODE
> > > > +--------------------------------------------
> > > > +
> > > > +This control sets the format to pack multiple RAW pixel values int=
o a
> word.
> > > > +
> > > > +This control accepts a __u32 value defined as `enum
> viif_rawpack_mode`.
> > > > +
> > > > +This control should be set before ioctl(S_FMT) and should not be
> > > > +changed
> > > after that.
> > >
> > > Why do you need this? Doesn't the V4L2 pixelformat already
> > > explicitly define the format, including packing?
> > >
> >
> > This control value affects the unpacker between CSI2 receiver and ISP.
> > The rawpack mode is an option to receive from Wide-Dynamic-Range image
> > sensors, whose output bit width is larger than standard format (RAW20,
> > RAW24). For example, some WDR image sensors split 20 bit value into
> > upper/lower 10bit values, then put them into consective pixels to make
> > a double-width RAW10 format image.
>=20
> Do you have a sensor that really does this? Which one is it?

Our HW specialist has indicated that the VIIF HDR input expects some SONY H=
DR sensors as its source.

Because the VIIF was developed prior to the official release of RAW20 and R=
AW24 formats in the MIPI CSI2 specification,
its HDR RAW input feature is controlled by a vendor specific "rawpack" regi=
ster.
Also, the proprietary software stack has "rawpack" flag.
The expected bitstream formats associated with "rawpack" align with the off=
icial RAW20 and RAW24 formats.

I now understand that rawpack flag is not used for non-standard pixel forma=
ts.
I'll remove rawpack flag in the v10 patch of the driver.=20
HDR RAW input feature should be controlled by V4L2 pixelformat or media bus=
 format.
However, RAW20, RAW24 support will be dropped in the v10 patch because modi=
fied part is not fully tested.

>=20
> >
> > This option is only related to the interpretation of CSI2 input data.
> > Therefore, I think V4L2 pixel format (for resulting image) is not
> > related to it. The media bus format seems more relevant, but there is
> > no corresponding definition to this case.
>=20
> --
> Regards,
>=20
> Sakari Ailus

Regards,

Yuji Ishikawa


