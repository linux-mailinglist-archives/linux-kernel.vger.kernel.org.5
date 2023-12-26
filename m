Return-Path: <linux-kernel+bounces-11541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8081E7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE641F229C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696434CB55;
	Tue, 26 Dec 2023 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="kp2VM6dT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7721E487
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
	t=1703602326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fEwnb5GWZbaZYbfYH2w/r+iK71DOGeg/leGNBmQMe+E=;
	b=kp2VM6dTxXq4eLCk/jsjq/h3TZNhT0HNucKfEQp/oRHgeiUQztg8YdjKCGkXQ7MKb6Xnrg
	a9kfwfVT8QY2lYCNdLBXiH0KevXPaiLV+qBhPTg3f7UfPM4uwivrZ3jSHn2Vw8hDWDqCUS
	AZt3pQew1BGAO4Z9SnsxSxcYe0XBruA=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-56-tvUb0xWYOx29mbo4m6VVJQ-1; Tue, 26 Dec 2023 15:50:57 +0100
X-MC-Unique: tvUb0xWYOx29mbo4m6VVJQ-1
Received: from ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::12)
 by GVAP278MB0072.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:21::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 14:50:55 +0000
Received: from ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9595:bbdb:420b:24bf]) by ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9595:bbdb:420b:24bf%5]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 14:50:55 +0000
From: =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?=
	<joao.goncalves@toradex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC: "l.sanfilippo@kunbus.com" <l.sanfilippo@kunbus.com>,
	"Alexander.Steffen@infineon.com" <Alexander.Steffen@infineon.com>
Subject: TPM interrupt patch on LTS
Thread-Topic: TPM interrupt patch on LTS
Thread-Index: AQHaOArtCvLrSbJPrU+UZ7KChHuRew==
Date: Tue, 26 Dec 2023 14:50:55 +0000
Message-ID: <4fc16271420c578cdafea70e005a2b4381c555d3.camel@toradex.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0460:EE_|GVAP278MB0072:EE_
x-ms-office365-filtering-correlation-id: 56f1b8e0-433f-4a61-460c-08dc0622104e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: rgBp+2r9RNe7oh22I8tGodKpXoIhMl6ngYBiVH0mk4Kjkhy21uDpdBgH6e6YkxoX73oS9tabfH9F9AQUyl4Juo7Z/bXre5my+wpVthQuNvPG2wi5RZPG4+LWnCsLqexxznKq+sivAYqCEbAEN6A8rHks9xDllvt+ytEZhRmUG1v4Nju2YIo1KqpXWL5yrt+h3X0jDcQPTjMs/JtOc77ZRdmMfF4UTLXX52sWer8TmnizVWcsZuxU/QOV8WR+h51CP/jEp9RlQnKfnr4/sgNR1JAvtD4qYwTRLX+amnjbWl828D1DQ6dvns43PkQlgd+WlM7p09nwhiXWSWXDQX4SDSvHyvWlJ1A8+qb5QSA/KTvIxKT3/39XIUGcYc9ayEGsiegSEbNiyQjF/aERBnOl5DQOiueYjYMuCOJAW2n1MmXfW4j4D/XbRv3HeS/Bhu4WjmPiiSgbpnLT59N1VO7bhd5QMXZNsV0j2QZmt6XbVb2Vbcz3xABJbaEWaZ8VDCrHMAYG93ZDBir4uzNxkjtmZZjedGbBsK7oo0qKIrEgxepJ9O7RHsK1i/IF/yvprBJmxCiqYpWl0o6mQPh2CApeGhQbnyA4i7/PS/qEUKWHL7M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39840400004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(66476007)(66556008)(64756008)(66946007)(76116006)(66446008)(5660300002)(4744005)(4326008)(8676002)(8936002)(316002)(54906003)(110136005)(41300700001)(91956017)(38070700009)(85182001)(85202003)(36756003)(478600001)(6486002)(71200400001)(6506007)(2616005)(26005)(966005)(6512007)(86362001)(122000001)(38100700002)(83380400001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2FVU2NleE5vQzVsMFU0NzVSbGszUVZhdTU4RDB2cmpnOGpKeTFCVEVyMlBS?=
 =?utf-8?B?bXFjTTQxN3BBNkxWSHlDL0NWRWVaa1hzeXMyeDJkWWN4OFRDSTJzemJtUHZq?=
 =?utf-8?B?N0Z3VUw0WDl1aUZadlc4TkNLR0ViTVJTK2dmRUljUStDTXFwZ0FlZU9XZ0RK?=
 =?utf-8?B?NzBZQ3Q4RkttN09mZkFEQ3Jic2p4empBdnh4YUNLb3ZOSkgxVXM3YkViRWpw?=
 =?utf-8?B?czQyQk9aNFoyVFJLdVNMYk9iVGc0emVYelIwbFhySWlnYlVJdGRyZjd3WWgr?=
 =?utf-8?B?VVA3dVBNcXFqV0hRTS84ejZVUm5seHlIYWxMODBTSGU4ZzN4WEZMYTFnTnhy?=
 =?utf-8?B?RkFFQnlwT2dUOTdneUpGTlVmdVFZVDZuK3ErRHFUZFRmNVlwZWoxajREZXZr?=
 =?utf-8?B?YXJTK0dldjlENjZ3SFppRWp5VlF2SUptbk5yVU9keExSbjBCS1JZaU9zQ1Ex?=
 =?utf-8?B?NmtXVzNnd1YvQk1FU2tBK1VCOVFJWmxaQ2FYMjY5a245cnd0dTBicGdDZHB3?=
 =?utf-8?B?bE44RXE5ZWd2QmFrUi8yYW9uWjBsNE1IWHV0TXA3aXR6RE9zbjBlYjJWNEVQ?=
 =?utf-8?B?aWQ1ZjA3MVhPNm1JVDFpS1o3czAxdk1sVkdRMHpsTm01Z1dYNkVacm1zcXVa?=
 =?utf-8?B?b3FZU2xKNUJsSFlkZzNYTEtBTjF6NkJGZ2I5TXo4ZTk2bnE1b0VFc2ErV29M?=
 =?utf-8?B?dE94c0F3ZkdtR2tOekN5RGdwWFdkMGFSU2x1MWl1UktwQzZ5QjNPY2hDMkZS?=
 =?utf-8?B?bGszVVRwWlh6enBtVk5nZmZlSjZZQ3ZVMS9FVEo2R3VNWUZEWENVSy9RU1pW?=
 =?utf-8?B?NWpGbFJXa0V3Y1pYKzBaWVdlallnYXVSZnJDdkxYdUlWcW5GeWZ4QkYxUnVK?=
 =?utf-8?B?aXBPMUVhcHZMaGxmTWMxbSs0N04zRjJsckxUU1FSWldqdnhrM2VLMlJKeTBy?=
 =?utf-8?B?Mlk4N3pUYW1LOUZCbnlPY1Zmbnp3WUQvamhVNk5DUFI1bVpGcFJFUkpScUgz?=
 =?utf-8?B?MmVkWmVtTVR3cW9oU3FrZThJdGFpQis0UFA0N2lBaHA3N2NxRmQ2TW5ZOVE3?=
 =?utf-8?B?THBVNWpka0U1bzQ4WlN0Ujk2OEtUa2lueGhUdW01YnFlazhDRm44UXdoaEtk?=
 =?utf-8?B?K2JzaTZ0N1F6bGR1TjJEQ051Tk5ReGw0UUpSOU00VGJxbHRHWUM5bS9ZVUEz?=
 =?utf-8?B?ZExHTVN1bGZUcGxTU2xXR2owdlkvSTlTeEdqTUhWQXFWUWQwSWNLY3pLTUEy?=
 =?utf-8?B?QW5ObHdadlRTb2RiZUN5L1dwSzE4S01TL1BsU1hxUkpLelJ4bjNQclpCUDBU?=
 =?utf-8?B?U1hmYTkvd0R0QUxHNDI5ODRWQVZYSHgxZms1NWRYY29XUTNVSEl1eDlLZVpQ?=
 =?utf-8?B?MkZpRFlwYm1SenJOKzB3aFdlWnByN3JoRTBOZGp1R3A5Sis1SGNWeXVKaUlY?=
 =?utf-8?B?UEw4Nk4rcTNQQWF0bXA2YUdsbzdIWURwbW9Yc0lhUWp1SElpMEhsbitQd3RL?=
 =?utf-8?B?UHQrTGFVUmpqOUNjcmhYb28wS3lHSlk3aTB3UUhIaGpoT1Q5THk0eHRGZTQr?=
 =?utf-8?B?ZVNmZHdsWXErTkFWTm5mS2xMcnhuNHpxNUZpN2pzOFVpTXF1OTlxTm13cXNT?=
 =?utf-8?B?QWF4a1FSSG81R3l2U0ZTb2hPZ1FsUWhEaFZiU24zV1U4NFZsSXBoK2RRZWJK?=
 =?utf-8?B?d0wvMUJsckVOMHlocUdtUG02U3YxNTFvN0NyQVQ0dmJ3bE84eUNIcjN3N2xB?=
 =?utf-8?B?VDFmVmtCMFoyUEE4dEtXTk1pUHFSa2NiVy80ZmVrOEtDTnFBdGtkNnBsbUpv?=
 =?utf-8?B?ZmtiYkFmbjZwL2s1cmdyQmlMUE14L2ZSeXJIU1VNdEQ3dkJIYkVzUE1La3ZT?=
 =?utf-8?B?YWw3NzBUeU1oTVdYVlpOb3JLSS9vd2hRM21PUHZnWExxaytCU050ZTZSdk5Z?=
 =?utf-8?B?T3JIeHVIUWNXRXhtUGRZOGJvaHdwWnJVUW1XT09pUnlKUG8wQW1PNWlib2tP?=
 =?utf-8?B?N2Z2alFDV2UxMzJKYmw1dFRJbWJuUWRGRkhqQ1o5Z3RGM0E5MG1BZ2VsQ2Ns?=
 =?utf-8?B?dmdyRTlUYTBLdEl3TFJ1NTFpSmJ6eFcwanRHdmFKQzhmWFp2bURqdDJyZ0FR?=
 =?utf-8?B?QmlITXlsMEtWakNRbnd1R2tCb2NnL0FwTzZJa2p3OFA2QStsby9jaGdyZWhL?=
 =?utf-8?B?OFE9PQ==?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0460.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f1b8e0-433f-4a61-460c-08dc0622104e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 14:50:55.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYJY5wQ5iTXTwymMZXM78nAaguxJ3q7XXqpEpC24O62VWCQiu8jgrtWlkQLGaJUTFxxEkJeiBfYnf50m+4L5f/n/P3gnVWj1qoywnMDzraY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0072
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <A80A0B585546E04A8AB181D178CA6E04@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

SGVsbG8sIA0KDQpXZSBhcmUgaW50ZWdyYXRpbmcgYSBTUEkgVFBNIGZyb20gSW5maW5lb24gd2l0
aCA2LjEvNS4xNSBMVFMga2VybmVscyBmb3IgYW4gDQplbWJlZGRlZCBwbGF0Zm9ybSBhbmQgaXQg
aXMgZ2l2aW5nIGFuIGVycm9yIG1lc3NhZ2UgdGhhdCBpbnRlcnJ1cHRzIGFyZSBub3Qgd29ya2lu
Zy4gDQpUaGVyZSBpcyBhIGNvcnJlY3Rpb24gZnJvbSBbMV0gYWxyZWFkeSBvbiB1cHN0cmVhbSBi
dXQgdGhlIHBhdGNoIHRoYXQgbWFrZXMgDQppbnRlcnJ1cHRzIHdvcmssIGNvbW1pdCBlNjQ0YjJm
NDk4ZDIgKCJ0cG0sIHRwbV90aXM6IEVuYWJsZSBpbnRlcnJ1cHQgdGVzdCIpLCB3YXMgDQpub3Qg
YmFja3BvcnRlZCB0byBMVFMuIFRoaXMgc2VlbXMgdG8gYmUgdGhlIG9ubHkgcGF0Y2ggdGhhdCB3
YXMgbm8gYmFja3BvcnRlZCANCmZyb20gWzFdLiBJIHJlYWQgc29tZSBkaXNjdXNzaW9uIG9uIGxr
bWwgYWJvdXQgVFBNIGludGVycnVwdHMgcHJvYmxlbXMgYnV0IGRpZCANCm5vdCBnZXQgaWYgaXQg
aXMgcmVsYXRlZCBvciB0aGUgcmVhc29uIGZvciBub3QgYmFja3BvcnRpbmcgdGhlIHBhdGNoLiAN
Cg0KRG8geW91IGtub3cgdGhlIHJlYXNvbiB0aGlzIHNpbmdsZSBwYXRjaCB3YXMgbm90IGJhY2tw
b3J0ZWQ/ICANCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjExMjQxMzU1
MzguMzEwMjAtMS1MaW5vU2FuZmlsaXBwb0BnbXguZGUvDQoNClRoYW5rcyENCg0KUmVnYXJkcywN
CkpvYW8gUGF1bG8gR29uY2FsdmVzDQo=


