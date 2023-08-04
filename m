Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14E076FB9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjHDIEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjHDIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:04:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415751702;
        Fri,  4 Aug 2023 01:04:31 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37480Ct2003697;
        Fri, 4 Aug 2023 08:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=+g/bQcxfJfPGJtUW0iD3vuNjqik3P88E9v0zkn82kqU=;
 b=H9sTBKY6jL4RUoqmhi1X8Jqd40csZQ0/ij9J2hed+jJI5rKVzoyn1BAM9mVIOo4XF12j
 I/knfc1IiewLvhmYkmiupgFg/CVJwlNUzfz0RG0RGhrdclCj6Qqja9blaYUmAP1MhJEE
 9N9kM61B5le8stjrOIPal3KHdla5k7WOE7MKtNp7GNt5sOdtIo9SUmQ4Egv1nh2ot6ao
 Ygjua5dnsSx7VutkR2z2aSZZJzvOYOcWc5fyy6zdZ1oT3uA+k2iRLG3Oyp09tx8AHv4q
 stc/VJXIHyWdDOhhezFNFG4zjl5UY/FDFcNDfn9Wrmomy6PRpfXnxyZ1ECd/s31mJ8JS sg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s8kgh8y26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 08:04:19 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37484Iwa009501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 08:04:18 GMT
Received: from nasanex01a.na.qualcomm.com (10.52.223.231) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 4 Aug 2023 01:04:18 -0700
Received: from nasanex01a.na.qualcomm.com ([fe80::482d:250d:70b6:e1c5]) by
 nasanex01a.na.qualcomm.com ([fe80::482d:250d:70b6:e1c5%12]) with mapi id
 15.02.1118.030; Fri, 4 Aug 2023 01:04:18 -0700
From:   "Naveen Kumar Goud Arepalli (QUIC)" <quic_narepall@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
CC:     "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1] arm64: dts: qcom: sa8775p-ride: Remove min and max
 voltages for L8A
Thread-Topic: [PATCH V1] arm64: dts: qcom: sa8775p-ride: Remove min and max
 voltages for L8A
Thread-Index: AQHZvt7QYX0nSDdHt02LA98zFub0Fa/Le8CAgACAp6CAAH9UAIANWPwQ
Date:   Fri, 4 Aug 2023 08:04:18 +0000
Message-ID: <78e6233799f54428b6601896b8bd7b5c@quicinc.com>
References: <20230725100007.14775-1-quic_narepall@quicinc.com>
 <a3l7356miuuapf5dakgfchdjmxjp62ynvle4ta3hejd3tjvzd4@e2t2zm6jh7hb>
 <516a54da44724001895f7e50634ad884@quicinc.com>
 <33232e22-1014-2670-47f6-712b0acc929d@linaro.org>
In-Reply-To: <33232e22-1014-2670-47f6-712b0acc929d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.15.104]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z_4lixndT4G59EaijlU5OkaswvosSDxd
X-Proofpoint-ORIG-GUID: z_4lixndT4G59EaijlU5OkaswvosSDxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDcvMjAyMyAxNDozMiwgTmF2ZWVuIEt1bWFyIEdvdWQgQXJlcGFsbGkgKFFVSUMpIHdy
b3RlOg0KPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAwMzozMDowN1BNICswNTMwLCBOYXZlZW4g
S3VtYXIgR291ZCBBcmVwYWxsaSB3cm90ZToNCj4+IEw4QSBpcyB0aGUgc3VwcGx5IGZvciBVRlMg
VkNDLCBVRlMgc3BlY2lmaWNhdGlvbiBhbGxvd3MgZGlmZmVyZW50IFZDQyANCj4+IGNvbmZpZ3Vy
YXRpb25zIGZvciBVRlMgZGV2aWNlcy4NCj4+IC1VRlMgMi54IGRldmljZXM6IDIuNzBWIC0gMy42
MFYNCj4+IC1VRlMgMy54IGRldmljZXM6IDIuNDBWIC0gMi43MFYNCj4+DQo+PiBBcyBzYTg3NzVw
LXJpZGUgc3VwcG9ydHMgYm90aCB1ZnMgMi54IGFuZCB1ZnMgMy54IGRldmljZXMsIHJlbW92ZSAN
Cj4+IG1pbi9tYXggdm9sdGFnZXMgZm9yIEw4QSByZWd1bGF0b3IuIEluaXRpYWwgdm9sdGFnZSBv
ZiBMOEEgd2lsbCBiZSANCj4+IHNldCB0byAyLjUwNHYgb3IgMi45NTJ2IGR1cmluZyBQT04gZGVw
ZW5kaW5nIG9uIHRoZSBVRlMgZGV2aWNlIHR5cGUuIA0KPj4gT24gc2E4Nzc1LCBVRlMgaXMgdGhl
IG9ubHkgY2xpZW50IGluIExpbnV4IGZvciBMOEEgYW5kIHRoaXMgcmVndWxhdG9yIA0KPj4gd2ls
bCBiZSB2b3RlZCBvbmx5IGZvciBlbmFibGluZy9kaXNhYmxpbmcuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogTmF2ZWVuIEt1bWFyIEdvdWQgQXJlcGFsbGkgPHF1aWNfbmFyZXBhbGxAcXVpY2luYy5j
b20+DQo+PiAtLS0NCj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2E4Nzc1cC1yaWRlLmR0
cyB8IDIgLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NhODc3NXAtcmlkZS5kdHMNCj4+IGIv
YXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NhODc3NXAtcmlkZS5kdHMNCj4+IGluZGV4IGVkNzY2
ODA0MTBiNC4uNmYzODkxYTA5ZTU5IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9xY29tL3NhODc3NXAtcmlkZS5kdHMNCj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNv
bS9zYTg3NzVwLXJpZGUuZHRzDQo+PiBAQCAtOTgsOCArOTgsNiBAQA0KPj4gIA0KPj4gIAkJdnJl
Z19sOGE6IGxkbzggew0KPj4gIAkJCXJlZ3VsYXRvci1uYW1lID0gInZyZWdfbDhhIjsNCj4+IC0J
CQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyNTA0MDAwPjsNCj4+IC0JCQlyZWd1bGF0b3It
bWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4+ICAJCQlyZWd1bGF0b3ItaW5pdGlhbC1tb2Rl
ID0gPFJQTUhfUkVHVUxBVE9SX01PREVfSFBNPjsNCj4+ICAJCQlyZWd1bGF0b3ItYWxsb3ctc2V0
LWxvYWQ7DQo+PiAgCQkJcmVndWxhdG9yLWFsbG93ZWQtbW9kZXMgPSA8UlBNSF9SRUdVTEFUT1Jf
TU9ERV9MUE0NCj4+IC0tDQo+PiAyLjE3LjENCj4+DQo+IA0KPiBSZXZpZXdpbmcgd2l0aCB2ZXJ5
IGxpdHRsZSBleHBlcnRpc2UgaW4gdGhlIGFyZWEuLi4uDQo+IEEgZmV3IHF1ZXN0aW9ucyBiZWxv
dyB0aGF0IHdvdWxkIGhlbHAgbWUgdW5kZXJzdGFuZCB0aGlzIGEgYml0IGJldHRlci4NCj4gDQo+
IERvZXMgaXQgbWFrZSBzZW5zZSB0byAqbm90KiBzZXQgdGhlIHJhbmdlIG9mIHRoZSByZWd1bGF0
b3IgYXQgYWxsPzoNCj4+Pj4gWWVzLCB3ZSBhcmUgcmVtb3ZpbmcgdGhlIHJhbmdlIG9mIHRoZSBy
ZWd1bGF0b3IuDQo+IA0KPiAgICAgMS4gQSBib2FyZCBkdHMga25vd3MgaXRzIFVGUyBkZXZpY2UN
Cj4gICAgIDIuIElzIFVGUyBiYWNrd2FyZHMgY29tcGF0aWJsZSB3aXRoIHJlc3BlY3QgdG8gVUZT
Mi9VRlMzPw0KPiAgICAgICAgSSBkb24ndCBrbm93IGhvdyB0aGUgdmVyc2lvbiBpcyBkZXRlcm1p
bmVkLCBidXQgaWYgaXQncyBhDQo+ICAgICAgICAic3RhcnQgYXQgVUZTMiwgZ28gdG8gVUZTMyIg
c2hvdWxkIGl0IGJlIHNjYWxlZCBhcyB0aGF0IGdvZXM/DQo+ICAgICAgICA+Pj4+IEZvciBhIFVG
UyBkZXZpY2UgMy54LCB3ZSBjYW5ub3Qgc3RhcnQgYXMgVUZTIDIuMC4gdmNjIGhhcyB0byBiZSBh
cyBwZXIgVUZTIDMueCByZWNvbW1lbmRhdGlvbnMuDQo+IA0KPiBSZWx5aW5nIG9uIHRoZSBib290
bG9hZGVyIHRvIHNldCB1cCB0aGUgZGV2aWNlIGJlZm9yZSB0aGUga2VybmVsIA0KPiBzdGFydHMg
c2VlbXMgbGlrZSBhIGRpcmVjdGlvbiB0aGF0IHNob3VsZCBiZSBhY3RpdmVseSBhdm9pZGVkIGlu
c3RlYWQgDQo+IG9mIGRlcGVuZGVkIG9uIGluIG15IG9waW5pb24uDQoNCkkgaGF2ZSB0cm91Ymxl
IGZpbmRpbmcgd2hpY2ggcGFydCBpcyB5b3VyIHJlcGx5IGFuZCB3aGljaCBpcyBxdW90ZSBvZiBB
bmRyZXcuIFBsZWFzZSByZWNvbmZpZ3VyZSB5b3VyIG1haWwgY2xpZW50Lg0KDQo+Pj4+PiBBcyBw
ZXIgdXBzdHJlYW0gVUZTIGRyaXZlciwgIHZvbHRhZ2Ugdm90aW5nIGlzIG5vdCB0aGVyZSBhbmQg
d2Ugdm90ZSBvbmx5IGZvciBlbmFibGUvZGlzYWJsZSAuIA0KPiBTaW5jZSBVRlMgaXMgdGhlIG9u
bHkgY2xpZW50IGluIExpbnV4IGZvciB0aGlzIHJhaWwgKEw4QSApLCB3ZSBkb24ndCANCj4gbmVl
ZCBtaW4gYW5kIG1heCByYW5nZSB0byBzdXBwb3J0IFVGUyAyLnggYW5kIDMueCBjYXJkcy4NCg0K
SSB3b3VsZCBhc3N1bWUgc29tZSByZWFzb25hYmxlIHJhbmdlIGlzIGFsd2F5cyBkZXNpcmVkLiBX
aHkgaXQgY2Fubm90IGJlIHRoZSB3aWRlciByYW5nZSBmcm9tIGJvdGg/IDIuNCAtIDMuNj8NCg0K
V2lkZXIgcmFuZ2UgY2Fubm90IGJlIG1lbnRpb25lZCBpbiBEVCwgRm9yIFVGUyAyLnggcmFuZ2Ug
aXMgMi43IFYgdG8gMy42IFYgYW5kIGZvciBVRlMgMy54IHJhbmdlIGlzIDIuNFYgdG8gMi43Vi4N
CkdpdmluZyB0aGUgd2lkZXIgcmFuZ2Ugd2lsbCBub3Qgc2V0IHRoZSBjb3JyZWN0IHZvbHRhZ2Uu
DQoNCkZvciBleGFtcGxlOiANCklmIHRoZSByYW5nZSBpcyBtZW50aW9uZWQgYXMgMi40ViB0byAz
LjZWIGluIERUIGFuZCB3ZSBoYXZlIGNvbm5lY3RlZCBVRlMgMi54IGRldmljZSwgIFNpbmNlIFVG
UyBkcml2ZXIgaXMgdm90aW5nIG9ubHkgZm9yDQpyZWd1bGF0b3JfZW5hYmxlKHZvbHRhZ2UgaXMg
bm90IGJlaW5nIHNldCkgdGhlIHZvbHRhZ2Ugd2lsbCBiZSAyLjRWKG1pbiB2b2x0YWdlKSBmcm9t
IHBtaWMgZHJpdmVyIHdoaWNoIGlzIHdyb25nIHZvbHRhZ2UgZm9yDQpVRlMgMi54IGRldmljZXMs
IHdoaWNoIGlzIHZpb2xhdGlvbiBvZiBzcGVjLg0KDQpSZWdhcmRzDQpOYXZlZW4NCg==
