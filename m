Return-Path: <linux-kernel+bounces-27248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B55B82ECBE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49051F22850
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB8413FE6;
	Tue, 16 Jan 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dHoMOann"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6713AFD;
	Tue, 16 Jan 2024 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G6etJl020096;
	Tue, 16 Jan 2024 10:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=g6P2cMHM9kP9gUAdoVo4YHdDe5EaBqWTzFtrwDtnNWI=; b=dH
	oMOannwl4eN7Kv3OFmHsyOWprHkItBXB1+HJuoLvQV1x3TUwXoYwxV4ZjPZu0PWC
	yJex1iBndlToV2PMB9lESUCnrcMpqIc6JT6o4FZnDSo3XDOytM7nw7wf3ek30nyH
	6jFQ2u49/4y9spaX566KAf+QJNv1/NbpwxvEB/sCAI4UBnCWUYS6xaq3i77/ts1w
	h99ZeoRtWiIHAFleIyfwGumH5SotnvV0WjNP+bvACTPYYZR0Oua6MqyX98HEg96U
	Vgd6wjcKj3H+btMCpgz4U5brydH3fcLKWLzwtf1MS2+OPNj1Ico/YtgkbcgnnhpU
	IX06WxHMm9p1kavm2WNg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vngm58wbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 10:25:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GAPUtt007423
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 10:25:30 GMT
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Jan 2024 02:25:29 -0800
Received: from nasanex01a.na.qualcomm.com ([fe80::f03b:cbd0:26eb:aa37]) by
 nasanex01a.na.qualcomm.com ([fe80::f03b:cbd0:26eb:aa37%12]) with mapi id
 15.02.1118.040; Tue, 16 Jan 2024 02:25:29 -0800
From: "Ritesh Kumar (QUIC)" <quic_riteshk@quicinc.com>
To: "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>
CC: "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org"
	<konrad.dybcio@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Bjorn
 Andersson (QUIC)" <quic_bjorande@quicinc.com>,
        "geert+renesas@glider.be"
	<geert+renesas@glider.be>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "Abhinav Kumar (QUIC)"
	<quic_abhinavk@quicinc.com>,
        "Rajeev Nandan (QUIC)"
	<quic_rajeevny@quicinc.com>,
        "Vishnuvardhan Prodduturi (QUIC)"
	<quic_vproddut@quicinc.com>
Subject: RE: [PATCH 1/2] arm64: defconfig: enable Novatek NT36672E DSI Panel
 driver
Thread-Topic: [PATCH 1/2] arm64: defconfig: enable Novatek NT36672E DSI Panel
 driver
Thread-Index: AQHaSGFZHTqHMovipEeSl9V9RMpy6LDcus8A//9/cHA=
Date: Tue, 16 Jan 2024 10:25:29 +0000
Message-ID: <1d68485fd1574ff88047cef0d2d5e6f1@quicinc.com>
References: <20240116094935.9988-1-quic_riteshk@quicinc.com>
 <20240116094935.9988-2-quic_riteshk@quicinc.com>
 <CAA8EJpo3YS4EzfsLtovYKbLSGYX=RwUn9dpmCW=j257LnvPrgw@mail.gmail.com>
In-Reply-To: <CAA8EJpo3YS4EzfsLtovYKbLSGYX=RwUn9dpmCW=j257LnvPrgw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qluij26HZK-rZelrN0TyQ3jdmlvc8VpQ
X-Proofpoint-ORIG-GUID: Qluij26HZK-rZelrN0TyQ3jdmlvc8VpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=914 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160082

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBEbWl0cnkgQmFyeXNoa292IDxk
bWl0cnkuYmFyeXNoa292QGxpbmFyby5vcmc+DQo+U2VudDogVHVlc2RheSwgSmFudWFyeSAxNiwg
MjAyNCAzOjMwIFBNDQo+VG86IFJpdGVzaCBLdW1hciAoUVVJQykgPHF1aWNfcml0ZXNoa0BxdWlj
aW5jLmNvbT4NCj5DYzogYW5kZXJzc29uQGtlcm5lbC5vcmc7IGtvbnJhZC5keWJjaW9AbGluYXJv
Lm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPmtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj5jYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2ls
bEBrZXJuZWwub3JnOyBCam9ybiBBbmRlcnNzb24gKFFVSUMpDQo+PHF1aWNfYmpvcmFuZGVAcXVp
Y2luYy5jb20+OyBnZWVydCtyZW5lc2FzQGdsaWRlci5iZTsgYXJuZEBhcm5kYi5kZTsNCj5uZWls
LmFybXN0cm9uZ0BsaW5hcm8ub3JnOyBuZnJhcHJhZG9AY29sbGFib3JhLmNvbTsNCj5tLnN6eXBy
b3dza2lAc2Ftc3VuZy5jb207IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOw0KPmRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0tDQo+a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IEFiaGluYXYgS3VtYXIgKFFVSUMp
DQo+PHF1aWNfYWJoaW5hdmtAcXVpY2luYy5jb20+OyBSYWplZXYgTmFuZGFuIChRVUlDKQ0KPjxx
dWljX3JhamVldm55QHF1aWNpbmMuY29tPjsgVmlzaG51dmFyZGhhbiBQcm9kZHV0dXJpIChRVUlD
KQ0KPjxxdWljX3Zwcm9kZHV0QHF1aWNpbmMuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBhcm02NDogZGVmY29uZmlnOiBlbmFibGUgTm92YXRlayBOVDM2NjcyRSBEU0kNCj5QYW5lbCBk
cml2ZXINCj4NCj5PbiBUdWUsIDE2IEphbiAyMDI0IGF0IDExOjQ5LCBSaXRlc2ggS3VtYXIgPHF1
aWNfcml0ZXNoa0BxdWljaW5jLmNvbT4NCj53cm90ZToNCj4+DQo+PiBCdWlsZCB0aGUgTm92YXRl
ayBOVDM2NjcyRSBEU0kgUGFuZWwgZHJpdmVyIGFzIG1vZHVsZS4NCj4NCj4uLi4gYmVjYXVzZSBp
dCBpcyB1c2VkIG9uIC4uLi4NCj4NCg0KVGhhbmtzLCB3aWxsIHVwZGF0ZSBpbiBuZXh0IHZlcnNp
b24uDQoNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSaXRlc2ggS3VtYXIgPHF1aWNfcml0ZXNoa0Bx
dWljaW5jLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgfCAx
ICsNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPj4gYi9hcmNoL2FybTY0L2NvbmZpZ3Mv
ZGVmY29uZmlnIGluZGV4IDM2MWMzMWI1ZDA2NC4uMDI4ZDgwYmU5NWY2DQo+MTAwNjQ0DQo+PiAt
LS0gYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+PiArKysgYi9hcmNoL2FybTY0L2Nv
bmZpZ3MvZGVmY29uZmlnDQo+PiBAQCAtODU5LDYgKzg1OSw3IEBAIENPTkZJR19EUk1fUEFORUxf
TFZEUz1tDQo+Q09ORklHX0RSTV9QQU5FTF9TSU1QTEU9bQ0KPj4gQ09ORklHX0RSTV9QQU5FTF9F
RFA9bSAgQ09ORklHX0RSTV9QQU5FTF9JTElURUtfSUxJOTg4MlQ9bQ0KPj4gK0NPTkZJR19EUk1f
UEFORUxfTk9WQVRFS19OVDM2NjcyRT1tDQo+PiAgQ09ORklHX0RSTV9QQU5FTF9NQU5USVhfTUxB
RjA1N1dFNTE9bQ0KPj4gIENPTkZJR19EUk1fUEFORUxfUkFZRElVTV9STTY3MTkxPW0NCj4+ICBD
T05GSUdfRFJNX1BBTkVMX1NJVFJPTklYX1NUNzcwMz1tDQo+PiAtLQ0KPj4gMi4xNy4xDQo+Pg0K
DQpUaGFua3MsDQpSaXRlc2gNCg==

