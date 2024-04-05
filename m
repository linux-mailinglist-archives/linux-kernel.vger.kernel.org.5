Return-Path: <linux-kernel+bounces-132959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A669899C81
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9311C2095A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B874416C857;
	Fri,  5 Apr 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GAkCQLGG"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3212AACC;
	Fri,  5 Apr 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319145; cv=none; b=rl1WATnSOHWvlKOx4TL/UGKj6/tj7WkTR/ZPje57tjmSRpMleqlwNyey9428037Yo2uYdYya7xQiBJUklDBElBzSkSFb7elx5JFT21+ROyIjs+/2gbuPHoCQvXq4f7Cfoyqqpv5CRh+GwFsr5l7Ud6SePs3fB3MRNg2ryWGv79A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319145; c=relaxed/simple;
	bh=o5mEu5Kd5a4orlQIwiNSIchFEOFTYV7lAtQ710n+nlY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CWSast9gGSMccvzE357gDsOhmyUfZtxfVXYHUGFfxDheWejnsSuJ7ncMyCtIbuK+lhFVBacAbxcgXTzgPeZW1S4XXqpRxfOIVaT8y83bQWgmq6/x2pJ4nHIpWLqgzaXiHlgMgoOi32IGa4Breo0zuWobvkdEe2EUz4IWvbTrSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GAkCQLGG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712319143; x=1743855143;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=o5mEu5Kd5a4orlQIwiNSIchFEOFTYV7lAtQ710n+nlY=;
  b=GAkCQLGG2Ukipzj21zA1POSSZXSXyEP+Pgyvo/4+5kJORU2ajd8leUMC
   DqvdhmHP8ciIqmKE54LXDsWhkz+yDT3iilgtn0cGrTRdRmtxaUh3w8i8y
   dh5DjnCRDqaHHxQ1FvQTnUv/I+EEL7PHcTFtueS8RH30K1LnoeZa8y+k/
   kYilYUiprNQxFQ70kWCWwm9b5O6YF5j5yI3dBjDBYYmLObCEJT+DewzEh
   A/MUZ1AxTY4WcZUx7Yy53EOZdfQbaaE4FV5t6k1g3Yoq9wGK5O4D821Xz
   CHlzmrvwwyCD1oLXX2ADoRwNezxlk84kamvCbdL3uQM7zhG3uvF+mCW85
   A==;
X-CSE-ConnectionGUID: rtQWDoDbQ42RGvH0JL2JKA==
X-CSE-MsgGUID: SMCO29ftQeq1E554Gw6VNg==
X-IronPort-AV: E=Sophos;i="6.07,181,1708412400"; 
   d="scan'208";a="20178710"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 05:12:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 05:11:55 -0700
Received: from den-her-m31857h.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 05:11:52 -0700
Message-ID: <66872c085710223d5bf43cd601cfbc3e54425bbc.camel@microchip.com>
Subject: Re: [PATCH RFT 10/10] arm64: dts: microchip: sparx5_pcb135: drop
 duplicated NOR flash
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Lars Povlsen
	<lars.povlsen@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Date: Fri, 5 Apr 2024 14:11:51 +0200
In-Reply-To: <20240401153740.123978-10-krzk@kernel.org>
References: <20240401153740.123978-1-krzk@kernel.org>
	 <20240401153740.123978-10-krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgS3J6eXN6dG9mLAoKT24gTW9uLCAyMDI0LTA0LTAxIGF0IDE3OjM3ICswMjAwLCBLcnp5c3p0
b2YgS296bG93c2tpIHdyb3RlOgo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+
IAo+IFNpbmNlIGJlZ2lubmluZyB0aGUgRFRTIGV4dGVuZGVkIHRoZSBTUEkwIGluIHR3byBwbGFj
ZXMgYWRkaW5nIHR3byBTUEkKPiBtdXhlcywgZWFjaCB3aXRoIHNhbWUgU1BJIE5PUiBmbGFzaC7C
oCBCb3RoIHVzZWQgZXhhY3RseSB0aGUgc2FtZQo+IGNoaXAtc2VsZWN0cywgc28gdGhpcyB3YXMg
Y2xlYXJseSBidWdneSBjb2RlLsKgIFdpdGhvdXQgY2hlY2tpbmcgaW4KPiBkYXRhc2hlZXQsIGFz
c3VtZSBkZXZpY2UgaGFzIG9ubHkgb25lIFNQSSBOT1IgZmxhc2gsIHNvIGNvZGUgd2FzCj4gZHVw
bGljYXRlZC4KPiAKPiBGaXhlcyBkdGMgVz0xIHdhcm5pbmdzOgo+IAo+IMKgIHNwYXJ4NV9wY2Ix
MzVfYm9hcmQuZHRzaTo5Mi4xMC05Ni40OiBXYXJuaW5nICh1bmlxdWVfdW5pdF9hZGRyZXNzX2lm
X2VuYWJsZWQpOgo+IC9heGlANjAwMDAwMDAwL3NwaUA2MDAxMDQwMDAvZmxhc2hAMDogZHVwbGlj
YXRlIHVuaXQtYWRkcmVzcyAoYWxzbyB1c2VkIGluIG5vZGUKPiAvYXhpQDYwMDAwMDAwMC9zcGlA
NjAwMTA0MDAwL3NwaUAwKQo+IAo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kg
PGtyemtAa2VybmVsLm9yZz4KPiAKPiAtLS0KPiAKPiBOb3QgdGVzdGVkIG9uIGhhcmR3YXJlCj4g
LS0tCj4gwqAuLi4vYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NV9wY2IxMzVfYm9hcmQuZHRzacKg
IHwgMTYgLS0tLS0tLS0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE2IGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21pY3JvY2hpcC9zcGFyeDVf
cGNiMTM1X2JvYXJkLmR0c2kKPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4
NV9wY2IxMzVfYm9hcmQuZHRzaQo+IGluZGV4IDIwMDE2ZWZiMzY1Ni4uZDY0ZTY0MmUzODczIDEw
MDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NV9wY2IxMzVf
Ym9hcmQuZHRzaQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9jaGlwL3NwYXJ4NV9w
Y2IxMzVfYm9hcmQuZHRzaQo+IEBAIC05NiwyMiArOTYsNiBAQCBmbGFzaEAwIHsKPiDCoMKgwqDC
oMKgwqDCoCB9Owo+IMKgfTsKPiAKPiAtJnNwaTAgewo+IC3CoMKgwqDCoMKgwqAgc3RhdHVzID0g
Im9rYXkiOwo+IC3CoMKgwqDCoMKgwqAgc3BpQDAgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbXBhdGlibGUgPSAic3BpLW11eCI7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbXV4LWNvbnRyb2xzID0gPCZtdXg+Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICNzaXplLWNlbGxzID0gPDA+Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9
IDwwPjsgLyogQ1MwICovCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhc2hAOSB7
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGli
bGUgPSAiamVkZWMsc3BpLW5vciI7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDgwMDAwMDA+Owo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHg5PjsgLyogU1BJICov
Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiAtwqDCoMKgwqDCoMKgIH07Cj4g
LX07Cj4gLQoKSSBhbHNvIHRlc3RlZCB0aGlzLCBhbmQgbm8gc3VycHJpc2U6IHNhbWUgY29tbWVu
dCBhcyBmb3IgdGhlIHBjYjEzNCBwYXRjaC4uLgoKPiDCoCZzZ3BpbzEgewo+IMKgwqDCoMKgwqDC
oMKgIHN0YXR1cyA9ICJva2F5IjsKPiDCoMKgwqDCoMKgwqDCoCBtaWNyb2NoaXAsc2dwaW8tcG9y
dC1yYW5nZXMgPSA8MjQgMzE+Owo+IC0tCj4gMi4zNC4xCj4gCgpCZXN0IFJlZ2FyZHMKU3RlZW4K



