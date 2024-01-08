Return-Path: <linux-kernel+bounces-19051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ECC82673D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C12A281CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87A79C2;
	Mon,  8 Jan 2024 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="tEvWE2fg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2098.outbound.protection.outlook.com [40.107.243.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78179DC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bayhubtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkWEA6xd2DvqzFX18pkmC7Ne1H6RnbbuDWvdFkfVds5X8RU/APNKTJZ081hG1qr5HBgbZ8/xWlHSDF7sv2VZdZIFe3J2Bc9Wq3ifv6OeK/j1cELXif6zXBTDIwdeJMnhj4r84Dgyg6MvEN+QHfAxQJj+Zjb6VpUn2PNdWqAPKv6BG3ifCl7W3yZrEAcB9smzVwwjCPoTVIVR1OsYqp+rhsdzlolMxjIOHp4RwxoDAYOgf4pGhEKMPvLAHYumQLQr74UjuIR/e44CL9kdiiuaVTcwdEpbvGPBPQvRHg7chviTTNSZBflw6N0UpMb7fzGbgSNMBftRnnnJ48GfAI6Rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXivTOHQYls/PNroBdfwDXuQukSyL4Opl7Tnf/LCQng=;
 b=YeVrdCG14c1+xBo7j6y0XZ/W5ojbUMBCArFGvXhhPJGgEdgX3KyJ3pC7wo4kiDMWnoc5VVTLD3hMBzyoYIJFc08nUK8Ml/LVbe+w6uUO2mN8U7szb9oNDsStFLZmJuXeUDWjMSVwgMV48qGUqbwE/AwnrncRZr+Vso+1NsYuz+y9o+GcPU7MtI0t5/bBVM/k9FkUel9xMv5s8hvAZ2BL8WEEXg7F24cqlayz7sY6rjezLcxB8WZUq0n0PehGulGHBaKJ1OL1lpirW6aq1fZGo3GIXy75u4DZxwMO/uggOYzftOOTWlvixhuA29SQW0VoLTFjCxl2KT/xbNXYebjHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXivTOHQYls/PNroBdfwDXuQukSyL4Opl7Tnf/LCQng=;
 b=tEvWE2fgVg4nqfn2oQKL/dOXz6T8H9E1S9bI0kM/HEN5Oz0RnLFN6hsENK1q1USZbvRBYin+0jhYCLe50PzlJr1X1ObPduGrFyTmWqWtvR4UA4zCECaJxoSeQRBp5g2d51Fovf6SQxV4ghEEWwFwDUehRJdhTh0B8s3djjFCcUE=
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by SA1PR16MB6485.namprd16.prod.outlook.com (2603:10b6:806:3dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 02:02:11 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::4cbb:1322:5c9d:1d30]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::4cbb:1322:5c9d:1d30%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 02:02:11 +0000
From: "Fred Ai(WH)" <fred.ai@bayhubtech.com>
To: Ben Mesman | Spark Narrowcasting <ben@sparknarrowcasting.nl>, Sean
 Christopherson <seanjc@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian
 Hunter <adrian.hunter@intel.com>, "Chevron Li (WH)"
	<chevron.li@bayhubtech.com>, "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBCdWc6IEFmdGVyIGEgJ3dhcm0nIHJlYm9vdCB0aGUgZGlzayBp?=
 =?utf-8?B?cyBtaXNzaW5nIChub3QgZGV0ZWN0ZWQgYnkgdGhlIGJpb3MpIG9uIGEgSFAg?=
 =?utf-8?Q?t640?=
Thread-Topic: Bug: After a 'warm' reboot the disk is missing (not detected by
 the bios) on a HP t640
Thread-Index: AQHaPaVg7ldpSgCwhEKGJ1PqyK+0ErDH8gTQgAGE+ICABbnEUA==
Date: Mon, 8 Jan 2024 02:02:11 +0000
Message-ID:
 <BL3PR16MB457082356327091E97765160996B2@BL3PR16MB4570.namprd16.prod.outlook.com>
References:
 <DB3PR0502MB999347F512ECFDBE3BFA9941B697A@DB3PR0502MB9993.eurprd05.prod.outlook.com>
 <ZYMator0DDfq_moN@google.com>
 <AS1PR05MB939337F702FDD79AFDF18F56B69EA@AS1PR05MB9393.eurprd05.prod.outlook.com>
 <ZZRO4Y41UTNm88eg@google.com>
 <BL3PR16MB45703C79606C6A12CB4B24759960A@BL3PR16MB4570.namprd16.prod.outlook.com>
 <AS1PR05MB93931538EE9A569728EFA724B667A@AS1PR05MB9393.eurprd05.prod.outlook.com>
In-Reply-To:
 <AS1PR05MB93931538EE9A569728EFA724B667A@AS1PR05MB9393.eurprd05.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR16MB4570:EE_|SA1PR16MB6485:EE_
x-ms-office365-filtering-correlation-id: 0e9b2691-ede5-423a-eef4-08dc0fedd3b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z8VckJ013V25wslZA7MYfxqqTl4OYtyT6pTk3iRC/xNb3etyri9qtbpdXnJPk15aDqYODtMoyToHNPWNEdkMj0wNzL1GAugmTK6O6SgzhMlcz0phZTmsJC0qCnaTXFKfNKZ4UyLhUcGEJPePg0ox/Bz44bHHWr080YZzRrOKamsf/qtmjunHbl2dCUEVgwaTH+H8uBadSd2Li5KBKCDrxoB4CP0/E2awLf9D+dUzjtp6ywu4fzXyJKmpowvqdW8teEkbZ2gjzQixQt9cMV8fvS6uACAoGBpJLTDPYZbhMN0wsmY36ov85IEpX4VxGcYBkiXiG5d8oCn1yNkMc2rZX19VEKdlLdR88m2qJcCVlB5/D/5l+ySlWEawBw3BufNWRYNEdvp9nSKzVT8Gfd/D9uHy7S7tAwq3qe6+V8CvuXRmyWpacZX2ulgjWOS4Pr6ipQUJZQswlrwFIk+u9zMOJwirbxOrQQebwZNUobta38HKlvcZrdySFa96ujgfvmkqmjTLIOFdMyB+wVvyGaBmQmkl4nf00QviZoNRcxbR1y4GbxXG/ZQM2+6LmG5oukTEt+9HcbA9p9TmzcIrM8QTxiw8WqCtHGgT4O5uSVaeBx08f4Nw/4qvEGgYKv7L8TU0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(2906002)(7416002)(38070700009)(41300700001)(224303003)(33656002)(86362001)(38100700002)(122000001)(8936002)(52536014)(4326008)(478600001)(66946007)(76116006)(55016003)(66556008)(9686003)(71200400001)(64756008)(66446008)(66476007)(7696005)(6506007)(54906003)(110136005)(316002)(83380400001)(26005)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXlteEpYVzUyUmxiQ1FERjFkMm9qMXRvcjZic2xpV1I4Z1pCQXU5Y1hlSVhT?=
 =?utf-8?B?TUplR1pVNFlBSENRdEJRM0lSakU4bi90MEVMNWNsdWFRWnE1WjM4b1lYaFdD?=
 =?utf-8?B?WW52YnRpTWVzZEJLbDBmRklORzM1SXE4QXJKT1pNZG1xZHMzdmVQTnRObDZv?=
 =?utf-8?B?NTdsek43L3NQVU9BL2EzWVd2MFl2cVhNd05KYmJQSGo1eUtwRXpNUnRoRGo3?=
 =?utf-8?B?b3pwMy9vRGo3elBCR0c0K3JDbUpOZkxPMU4xekpqVXp5aTlYbWgwSXRjZmhH?=
 =?utf-8?B?d0JDK28xdlUvSUFzd1NUbkpIZ3NmdVBITFVkODFFZVdaUUJHRTlkOEkvbFFS?=
 =?utf-8?B?SERaMGdxbUNlTDBNek8yUW1BekhXeEk3UkEzT2ZkL2hBRnladDV2NnVGRVkz?=
 =?utf-8?B?WkVNMU9EUGNFWS9BWENBallJYjg0QkhsR3FxV3k2emZidi9NOEhMaXFlKy90?=
 =?utf-8?B?eGsrMzBIZ2ZCVzltbWdiVTVSMFFuSEJOcThieEpuYWpCbXQ3a0M3K3QwQ01S?=
 =?utf-8?B?V3pTMitUUXF1cHpDNTZLWlFta1d5bVVmbjIrV28vOVd6OVFyU3JwbXhtSEtH?=
 =?utf-8?B?dVlaTURnTW04Wk1nb1JxQ0ZOQXZWZ1VtZWRKYVhpQUNoMk1MZnA0NFBIZy9F?=
 =?utf-8?B?cW5JRGM1ejB6TzFXc0NHTThHemgxZEMvSzBQY2lYVHdiSWxPUjBrTVNWNjEz?=
 =?utf-8?B?cFRKS21ZOXJEUFEvd3lVWE1KZzB4aVQ2alA5aTNaaUVWcnJwN0laSkR6MGp2?=
 =?utf-8?B?eEN0VXY1OWVzSjlkY1VNeUE1ajh3VCtGVDVzc1VQQ3dGWXlvRHFNR3QrT3Bp?=
 =?utf-8?B?akxnMEI4Q1hzYk5ic3hRRHFqV0RKVDRLNE1RRGIvT1p5MzBGaHBzM1o2ZHVZ?=
 =?utf-8?B?YzBta244d2xlOWZmN3NZcTJjWUhWZFlJMW1UQ0oyTmFtUUwrUWFGY0EveVVn?=
 =?utf-8?B?d2ZmUk1FcllOWks0UkZNK3dWYjdmVmplRmdWQ3FsV3draml0MjBXSGhPaVQ2?=
 =?utf-8?B?dUpReXQzN2dJM1IxenlHWjZEdzFON2lwZ0pYWXgyQkJrbVlTL0pqNzk3c1Iv?=
 =?utf-8?B?YVpNRkU0cEkzRnNMck5YSG9VRWVidTJOY2ZXNFVUYU1qeEZzT1F0NDg5Wm5V?=
 =?utf-8?B?OWpTU1dkRWNhbnhFNzdvcjBwcCtvODNLN1pVSTMzL2hIeHh6VXZWNm5uamtO?=
 =?utf-8?B?WHIza1FKclBEY3V6UFJkUlRVUk5lb0JXYXdxcVkzaWlsMEZ0N21rSUFra1Qy?=
 =?utf-8?B?NS9oR1k0N3FoYllPbXBCWnJEVHVMMkZzbDlIRlV5bERFTkVuUlU1TjZOVUcw?=
 =?utf-8?B?ZzIrVDFEMHRseGlDUFZLb3dpNXRQREtJM3lzSlBGVTFsdTd6WklpeVNVRUVa?=
 =?utf-8?B?YjJsbXJTN3I2SlkzTGlrbXM3SmFqOXg2Wm51OG5lRkFUVU90SC90U0JTRHR2?=
 =?utf-8?B?cEtVRkpic29Ka1p4dDZKQ2pXaVlXNVFCVEplbUNaWnhmSGtkSDR2NjR4R3ZY?=
 =?utf-8?B?djZOU1B3cFpIcE5qNFJNTWdjWUN2c3A1SW9pcTMyMVVjL2VtMUl2TWNwSzYy?=
 =?utf-8?B?L2wrbmRkYUpaN0l6RE1SSnp3TW9kdGhMcHlmVHZmQmF0V0R2blFpRlYzYVFO?=
 =?utf-8?B?dWpQZzNNd1NVYzRzQStvWjNlL1FjZEhZbnEwVzMxNjlPMVRxbGdHcE44bjRG?=
 =?utf-8?B?NGo3L0xjWWFnSTBKRWtHalNlYWtXN1JKVFlIdTB4REUwQTJ5bTF0bFF4OUVB?=
 =?utf-8?B?RjlJWVdHTVlkcTVhTktYMmJoRFZ0VURKNkQzS0grNS9GTWg3SW80TXY4Yllw?=
 =?utf-8?B?SFBUMWJ0RlJFbTM2TDBkbStGVjlPbEpEUzlGYVpUL1ljRktaYXE2OUtOblNJ?=
 =?utf-8?B?RDFlNGVCRE5RMFdyeTNPQVpkdmJZZG14R1pHOUdQblFuVlBSRUJMNlpNK3Fl?=
 =?utf-8?B?cGNhUjRSa3lFa1VaYUdJelNuVEhrMDNxTWV5MEdtSGpCYUR3YUtSZHFwbUty?=
 =?utf-8?B?T1dvbEtSYjJYanJMeGRENWRDTjNZQ2lkVHpKaXVVTGRIUkVZQzRZR3ZIOWxy?=
 =?utf-8?B?Z29TZWRoUWltM0RtUjZjRSsxTVJzZjhXWFJZdGVKYWhRajZ5ZzdkV3RSRFh4?=
 =?utf-8?Q?fQE/UxwZDCzpPQ+FF6HjIZtti?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9b2691-ede5-423a-eef4-08dc0fedd3b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 02:02:11.2656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kzm3cfmZRvpPbV3wDNc4CoGHU8znopoLrc6VHKLlq5bjykuMAR6fymbVL4gpeILaG+q8OjJqrM7fWMqWtXVbag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6485

SGkgQmVuIE1lc21hbiwNCg0KPiBJIHRyaWVkIHRoZSBwYXRjaCwgYnV0IGl0IGRpZG4ndCBzb2x2
ZSB0aGUgaXNzdWUsIHNvcnJ5Lg0KDQo+IERvIHlvdSBuZWVkIGFueSBleHRyYSBpbmZvPyBBbnkg
b3RoZXIgaGVscCBJIGNhbiBnaXZlIHRvIHNvbHZlIHRoaXMgcHJvYmxlbT8NCg0KUGxlYXNlIG1h
a2Ugc3VyZSB5b3UgY29tcGlsZSBpbiBhIHdheSB0aGF0IGFsbG93cyBvdXIgcGF0Y2ggdG8gdGFr
ZSBlZmZlY3QsIG9yIHlvdSBjYW4gYWRkIGRlYnVnZ2luZyBpbmZvcm1hdGlvbiB0byBlbnN1cmUg
dGhhdCBvdXIgcGF0Y2ggd29ya3MuDQoNClRoYW5rcw0KRnJlZA0KDQotLS0tLemCruS7tuWOn+S7
ti0tLS0tDQrlj5Hku7bkuro6IEJlbiBNZXNtYW4gfCBTcGFyayBOYXJyb3djYXN0aW5nIDxiZW5A
c3BhcmtuYXJyb3djYXN0aW5nLm5sPiANCuWPkemAgeaXtumXtDogMjAyNOW5tDHmnIg05pelIDE4
OjMxDQrmlLbku7bkuro6IEZyZWQgQWkoV0gpIDxmcmVkLmFpQGJheWh1YnRlY2guY29tPjsgU2Vh
biBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQrmioTpgIE6IFRob21hcyBHbGVp
eG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+
OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNl
bkBsaW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBBZHJpYW4gSHVu
dGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IENoZXZyb24gTGkgKFdIKSA8Y2hldnJvbi5s
aUBiYXlodWJ0ZWNoLmNvbT47IFNoYXBlciBMaXUgKFdIKSA8c2hhcGVyLmxpdUBiYXlodWJ0ZWNo
LmNvbT4NCuS4u+mimDogUmU6IEJ1ZzogQWZ0ZXIgYSAnd2FybScgcmVib290IHRoZSBkaXNrIGlz
IG1pc3NpbmcgKG5vdCBkZXRlY3RlZCBieSB0aGUgYmlvcykgb24gYSBIUCB0NjQwDQoNCkhpIEZy
ZWQgQWksDQoNCj4gSGkgU2VhbiBDaHJpc3RvcGhlcnNvbg0KPiBJIGFtIG1haW50YWluZXIgb2Yg
bW9kdWxlIOKAnHNkaGNpLXBjaS1vMm1pY3Jv4oCdLiBJIHByb3ZpZGUgdGhlIGF0dGFjaG1lbnQg
Y29kZSB0byBmaXggdGhpcyBpc3N1ZSwgYnV0IEkgZGlkbid0IHRlc3QgdGhpcyBwYXRoIGNvZGUu
IFlvdSBjYW4gdGVzdCBhdHRhY2htZW50IHBhdGNoIGNvZGUgYW5kIGdpdmUgdGhlIGZlZWRiYWNr
IHRvIG1lLg0KPiBJZiB0aGlzIGlzc3VlIGNhbiBiZSBmaXhlZCBieSB0aGlzIHBhdGNoLCBJIHdp
bGwgY29uc2lkZXIgY29tbWl0dGluZyB0aGUgbmV3IHBhdGNoIHRvIGZpeCB0aGlzIGlzc3VlIGF0
IGxpbnV4IG1hc3RlciBicmFuY2guDQoNCkkgdHJpZWQgdGhlIHBhdGNoLCBidXQgaXQgZGlkbid0
IHNvbHZlIHRoZSBpc3N1ZSwgc29ycnkuDQoNCkRvIHlvdSBuZWVkIGFueSBleHRyYSBpbmZvPyBB
bnkgb3RoZXIgaGVscCBJIGNhbiBnaXZlIHRvIHNvbHZlIHRoaXMgcHJvYmxlbT8NCg0KVGhhbmtz
LA0KQmVuIE1lc21hbi4NCg0KLS0gDQo+IERpZmYgcGF0Y2ggaW4gImxpbnV4L2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYyIgYXMgYmVsb3c6DQo+IA0KPiBkaWZmIC0tZ2l0IGEv
c2RoY2ktcGNpLW8ybWljcm8uYyBiL3NkaGNpLXBjaS1vMm1pY3JvLmMgaW5kZXggDQo+IDYyMGY1
MmEuLmQ1MjAzNjkgMTAwNjQ0DQo+IC0tLSBhL3NkaGNpLXBjaS1vMm1pY3JvLmMNCj4gKysrIGIv
c2RoY2ktcGNpLW8ybWljcm8uYw0KPiBAQCAtNjAzLDYgKzYwMywzMSBAQCBzdGF0aWMgdm9pZCBz
ZGhjaV9wY2lfbzJfc2V0X2Nsb2NrKHN0cnVjdCANCj4gc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWdu
ZWQgaW50IGNsb2NrKQ0KPiAgwqDCoMKgwqDCoMKgIHNkaGNpX28yX2VuYWJsZV9jbGsoaG9zdCwg
Y2xrKTsNCj4gwqB9DQo+IA0KPiArc3RhdGljIHZvaWQgc2RoY2lfcGNpX28yX3JlbW92ZV9zbG90
KHN0cnVjdCBzZGhjaV9wY2lfc2xvdCAqc2xvdCwgaW50IA0KPiArZGVhZCkgew0KPiArwqDCoMKg
wqDCoMKgIHU4IHNjcmF0Y2hfOCA9IDA7DQo+ICvCoMKgwqDCoMKgwqAgdTMyIHJlZ192YWwgPSAw
Ow0KPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBzZGhjaV9wY2lfY2hpcCAqY2hpcDsNCj4gKw0KPiAr
wqDCoMKgwqDCoMKgIGNoaXAgPSBzbG90LT5jaGlwOw0KPiArDQo+ICvCoMKgwqDCoMKgwqAgLyog
VW5Mb2NrIFdQICovDQo+ICvCoMKgwqDCoMKgwqAgcGNpX3JlYWRfY29uZmlnX2J5dGUoY2hpcC0+
cGRldiwgTzJfU0RfTE9DS19XUCwgJnNjcmF0Y2hfOCk7DQo+ICvCoMKgwqDCoMKgwqAgc2NyYXRj
aF84ICY9IDB4N2Y7DQo+ICvCoMKgwqDCoMKgwqAgcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAt
PnBkZXYsIE8yX1NEX0xPQ0tfV1AsIHNjcmF0Y2hfOCk7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoCAv
KiBTZXQgcGNyIDB4MzU0WzE2XSB0byBzd2l0Y2ggQ2xvY2sgU291cmNlIGJhY2sgdG8gT1BFIENs
b2NrIA0KPiArKi8NCj4gK8KgwqDCoMKgwqDCoCBwY2lfcmVhZF9jb25maWdfZHdvcmQoY2hpcC0+
cGRldiwgDQo+ICtPMl9TRF9PVVRQVVRfQ0xLX1NPVVJDRV9TV0lUQ0gsICZyZWdfdmFsKTsNCj4g
K8KgwqDCoMKgwqDCoCByZWdfdmFsICY9IH4oTzJfU0RfU0VMX0RMTCk7DQo+ICvCoMKgwqDCoMKg
wqAgcGNpX3dyaXRlX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LCANCj4gK08yX1NEX09VVFBVVF9D
TEtfU09VUkNFX1NXSVRDSCwgcmVnX3ZhbCk7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoCAvKiBMb2Nr
IFdQICovDQo+ICvCoMKgwqDCoMKgwqAgcGNpX3JlYWRfY29uZmlnX2J5dGUoY2hpcC0+cGRldiwg
TzJfU0RfTE9DS19XUCwgJnNjcmF0Y2hfOCk7DQo+ICvCoMKgwqDCoMKgwqAgc2NyYXRjaF84IHw9
IDB4ODA7DQo+ICvCoMKgwqDCoMKgwqAgcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYs
IE8yX1NEX0xPQ0tfV1AsIHNjcmF0Y2hfOCk7DQo+ICsNCj4gK30NCj4gKw0KPiDCoHN0YXRpYyBp
bnQgc2RoY2lfcGNpX28yX3Byb2JlX3Nsb3Qoc3RydWN0IHNkaGNpX3BjaV9zbG90ICpzbG90KQ0K
PiDCoHsNCj4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNkaGNpX3BjaV9jaGlwICpjaGlwOw0KPiBA
QCAtOTI0LDQgKzk0OSw1IEBAIGNvbnN0IHN0cnVjdCBzZGhjaV9wY2lfZml4ZXMgc2RoY2lfbzIg
PSB7DQo+IMKgI2VuZGlmDQo+IMKgwqDCoMKgwqDCoMKgIC5vcHMgPSAmc2RoY2lfcGNpX28yX29w
cywNCj4gwqDCoMKgwqDCoMKgwqAgLnByaXZfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgbzJfaG9zdCks
DQo+ICvCoMKgwqDCoMKgwqAgLnJlbW92ZV9zbG90PSBzZGhjaV9wY2lfbzJfcmVtb3ZlX3Nsb3Qs
DQo+IMKgfTsNCj4gDQo+IA0KPiBUaGFua3MNCj4gRnJlZA0K

