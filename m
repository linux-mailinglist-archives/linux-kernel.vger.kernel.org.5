Return-Path: <linux-kernel+bounces-16362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0B3823D54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C6DB2256B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB5C2030E;
	Thu,  4 Jan 2024 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tXAWZVZJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7320309;
	Thu,  4 Jan 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K77rFugtyXwGPPVKHt8Mgc7noRU6Dmdrtaqh9H+93h8=;
	t=1704356541; x=1705566141; b=tXAWZVZJPccNGFAUImClUBBozvty6sVc1JgWZ5WlGS/sEO1
	rWXow+fc3O0YyNbuIA0PnMxt+aLIt3uh3CM00s5jsCjDzOY8FmLsjT3TKltzPtkaiPkxyDVC529x9
	JVwo+J6bNcaRVpXtLV0E0g/ceC/NYVQYVHTRcspyCnn36JWclMgsL72N55LguEU5sz7xZjMVVxpQr
	dzY/vDbhNiTLF2QYfTHGN2EQl9oizP39hceqa586Re6aaI41Epmc4cJf2PkmSx9ND8A9SdFvzy2O0
	vUq4dvBSboWGlxeESMlQucQyddEov0IjZJi1aoJ1XeoRKViFQ1344ujzMmRkwXtA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rLIzA-00000004Q7E-0b9l;
	Thu, 04 Jan 2024 09:21:52 +0100
Message-ID: <661af1ebb62b25e75c32933143469855abb1242b.camel@sipsolutions.net>
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel
	=?ISO-8859-1?Q?D=EDaz?=
	 <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com,  leo@leolam.fr
Date: Thu, 04 Jan 2024 09:21:50 +0100
In-Reply-To: <2024010427-kisser-canopy-763c@gregkh>
References: <20240103164834.970234661@linuxfoundation.org>
	 <99fe3993-51b5-4284-8a22-869764f393d8@linaro.org>
	 <32ebe3f1-49b7-4ad3-9ea5-ed2adbbd78da@linaro.org>
	 <2024010427-kisser-canopy-763c@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

T24gVGh1LCAyMDI0LTAxLTA0IGF0IDA4OjU4ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6Cj4gPiA+IAo+ID4gPiBXZSdyZSBzZWVpbmcgYSBidWlsZCByZWdyZXNzaW9uIHdpdGggeDg2
L0dDQy04IGFuZCBhbGxtb2Rjb25maWc6Cj4gPiA+IAo+ID4gPiAtLS0tLTg8LS0tLS0KPiA+ID4g
IMKgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvYnVpbGRzL2xpbnV4L2luY2x1ZGUvbGludXgvc3Ry
aW5nLmg6Mjk0LAo+ID4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZy
b20gL2J1aWxkcy9saW51eC9pbmNsdWRlL2xpbnV4L2JpdG1hcC5oOjExLAo+ID4gPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gL2J1aWxkcy9saW51eC9pbmNsdWRl
L2xpbnV4L2NwdW1hc2suaDoxMiwKPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBmcm9tIC9idWlsZHMvbGludXgvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQu
aDoxNywKPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC9i
dWlsZHMvbGludXgvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1aWQuaDo2MiwKPiA+ID4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tIC9idWlsZHMvbGludXgvYXJjaC94
ODYvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmg6MTksCj4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAvYnVpbGRzL2xpbnV4L2FyY2gveDg2L2luY2x1ZGUvYXNt
L2NwdWZlYXR1cmUuaDo1LAo+ID4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGZyb20gL2J1aWxkcy9saW51eC9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5o
OjUzLAo+ID4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gL2J1
aWxkcy9saW51eC9pbmNsdWRlL2xpbnV4L3RocmVhZF9pbmZvLmg6NjAsCj4gPiA+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnJvbSAvYnVpbGRzL2xpbnV4L2luY2x1ZGUv
bGludXgvdWlvLmg6OSwKPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmcm9tIC9idWlsZHMvbGludXgvaW5jbHVkZS9saW51eC9zb2NrZXQuaDo4LAo+ID4gPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gL2J1aWxkcy9saW51eC9pbmNs
dWRlL3VhcGkvbGludXgvaWYuaDoyNSwKPiA+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBmcm9tIC9idWlsZHMvbGludXgvbmV0L3dpcmVsZXNzL25sODAyMTEuYzoxMToK
PiA+ID4gIMKgIEluIGZ1bmN0aW9uICdubDgwMjExX3NldF9jcW1fcnNzaS5pc3JhLjQ0JywKPiA+
ID4gIMKgwqDCoMKgwqAgaW5saW5lZCBmcm9tICdubDgwMjExX3NldF9jcW0nIGF0IC9idWlsZHMv
bGludXgvbmV0L3dpcmVsZXNzL25sODAyMTEuYzoxMzAwMDoxMDoKPiA+ID4gIMKgIC9idWlsZHMv
bGludXgvaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmluZy5oOjU3OjI5OiBlcnJvcjogJ19fYnVp
bHRpbl9tZW1jcHknIHBvaW50ZXIgb3ZlcmZsb3cgYmV0d2VlbiBvZmZzZXQgMzYgYW5kIHNpemUg
Wy0xLCA5MjIzMzcyMDM2ODU0Nzc1ODA3XSBbLVdlcnJvcj1hcnJheS1ib3VuZHNdCgpUaGlzIHBh
cnRpYWxseSBzaG93ZWQgdXAgdXBzdHJlYW0gYXMgd2VsbCwgYnV0IGl0IHdhcyBwcmV0dHkgaGFy
ZCB0bwpzZWUsIHNvIEkgdGhpbmsgY29uZmlnIGFuZCB0aGlzIHZlcnkgc3BlY2lmaWMgY29tcGls
ZXIgdmVyc2lvbiBtYXkgYmUKYWZmZWN0aW5nIGl0IGFzIHdlbGwuCgo+IFZlcnkgb2RkLCA2LjEg
d29ya3MgZmluZSB3aXRoIHRoaXMgc2FtZSBjb21waWxlcj8gIFRoZXNlIGNoYW5nZXMgd2VyZSBp
bgo+IHRoZSA2LjEuNzAgcmVsZWFzZSAoYW5kIHRoZSA2LjEuNjYgcmVsZWFzZSkgYmVmb3JlLgo+
IAo+IEl0IHdhcyBhbHNvIGluIDYuNi41LCBiZWZvcmUgYmVpbmcgcmV2ZXJ0ZWQgaW4gNi42LjYs
IHNvIHdoeSBpcyB0aGlzCj4gY2F1c2luZyBhIHByb2JsZW0gbm93PwoKWWVhaCwgaXQncyBhbGwg
YSBiaXQgd2VpcmQuCgpLZWVzIGVuZGVkIHVwIGZpeGluZyBpdCB1cHN0cmVhbSB3aXRoIGNvbW1p
dCAxNzJkYjU2ZDkwZDIgKCJuZXRsaW5rOgpSZXR1cm4gdW5zaWduZWQgdmFsdWUgZm9yIG5sYV9s
ZW4oKSIpIChpbiBuZXQtbmV4dCksIGJ1dCBJIGNhbm5vdAphY3R1YWxseSBzYXkgdGhhdCBJIHVu
ZGVyc3RhbmQgYWxsIHdoYXQncyBnb2luZyBvbiBoZXJlLgoKam9oYW5uZXMK


