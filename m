Return-Path: <linux-kernel+bounces-92120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E747871B5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA4B1F23DA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812A45C5E8;
	Tue,  5 Mar 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MPWyb76k"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B35C057
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634075; cv=none; b=PZfL9AcMRBt6c4vznBcJlnigH/3ylxwM87AJtfogVECxAe0gNNFnDw9zBgp3qaa49IyIqMU8dfMvd8W1DW8Mc6M+eHtJ9L4BJDcmIXrLgdExRShfHE66NnMdY0fWLGUfV8LLHOrTBK+74ZI56Yxv5YprXcDTRBz6SkEHzUcT5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634075; c=relaxed/simple;
	bh=BxEvxjk47/76zdsA1YUlbR7fGdOTYxlBDccqLjkzR9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmTxVdShivHqg5K7qB12/mssX19Bme4Ck52xohchxEMPIOHFF8/Ocxml15ystNhdyDu+FDIMS0rTOnWx3NDqAIC2rb8bn/QN1LrANxK9uji9DVSbtoNfNghzWc+Vs4CH4l8PHzYqTjm2s8EhdAhI3tR8yr1kcay//theg3EMtfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MPWyb76k; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709634072;
	bh=BxEvxjk47/76zdsA1YUlbR7fGdOTYxlBDccqLjkzR9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MPWyb76kidi82FkShoO/iVrDqtghoeezV6J6NySWo6wkZoa9ZU/UeYpS9OBbJdH/y
	 lPf6aEHVHXYZ1h8RAZ3E1ZS2xiLsZcMFcadiGXYSkwgtPySYAmhFyGBMbBFzKtEeDS
	 NWMnCMiFcHLMwMnihkamjWwiVFXIuT37Wahi8plhSbh7zEHd++F0/frU45IlEtqXl/
	 kH40jEh4Z7bKBJpqedtX+GVYE6Q3dkrFdlhNqBue6ebAvkiLLsYjOIV78MskegHt1T
	 8G8nK+WV8Vv3cmYBQsrXvvojhTswLO2V1Ke63OfQvxG/FcuazelRNAO3DB+jXTnxj9
	 L700EDWu8tpeg==
Received: from [100.90.4.95] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: david.heidelberg)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 743A23781FEF;
	Tue,  5 Mar 2024 10:21:11 +0000 (UTC)
Message-ID: <d6c5a3e3-62fd-4f59-8d43-b33881a98039@collabora.com>
Date: Tue, 5 Mar 2024 11:21:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] drm/ci: update device type for volteer devices
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com,
 daniel@ffwll.ch, sergi.blanch.torne@collabora.com,
 guilherme.gallo@collabora.com, robdclark@gmail.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240305101626.36357-1-vignesh.raman@collabora.com>
Content-Language: en-US
From: David Heidelberg <david.heidelberg@collabora.com>
Autocrypt: addr=david.heidelberg@collabora.com; keydata=
 xjMEYlvLOxYJKwYBBAHaRw8BAQdA5CoWEzz4igpwK4h6lK6ZformRk84+ymcfkGNPwqEeILN
 MURhdmlkIEhlaWRlbGJlcmcgPGRhdmlkLmhlaWRlbGJlcmdAY29sbGFib3JhLmNvbT7ClgQT
 FggAPhYhBEo7kSl22BK0F1Np/mn1Z4YcHsAUBQJiW8s7AhsDBQkFo5qABQsJCAcCBhUKCQgL
 AgQWAgMBAh4BAheAAAoJEGn1Z4YcHsAU84kBAK5YqSWAOuIumAqgWvke6BEsaIGWGQzXSuKj
 er/TXuFuAQCwc9ITSVXWWTSpdFt2+4z7Wch8tIGlbIFcS9dCFddwCc44BGJbyzsSCisGAQQB
 l1UBBQEBB0AEk7jXEwDApGOwMH/X0UAPBH8Y3isjxhNMjpyRcnl2CwMBCAfCfgQYFggAJhYh
 BEo7kSl22BK0F1Np/mn1Z4YcHsAUBQJiW8s7AhsMBQkFo5qAAAoJEGn1Z4YcHsAU0PEA/j0Y
 uAOKJCnnwrkf3ozPP0sutA5bojoARwcIaZKO/zvIAP9PwTC9DGLg+8LJm7m2Lyf0LxLA8FXD
 wueLHBdwHg6zAQ==
In-Reply-To: <20240305101626.36357-1-vignesh.raman@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rZiod2GXREeubTimgoI7WYNP"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rZiod2GXREeubTimgoI7WYNP
Content-Type: multipart/mixed; boundary="------------pHbxznB06gWrHjW6GsDe5viS";
 protected-headers="v1"
From: David Heidelberg <david.heidelberg@collabora.com>
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com,
 daniel@ffwll.ch, sergi.blanch.torne@collabora.com,
 guilherme.gallo@collabora.com, robdclark@gmail.com,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <d6c5a3e3-62fd-4f59-8d43-b33881a98039@collabora.com>
Subject: Re: [PATCH] drm/ci: update device type for volteer devices
References: <20240305101626.36357-1-vignesh.raman@collabora.com>
In-Reply-To: <20240305101626.36357-1-vignesh.raman@collabora.com>
Autocrypt-Gossip: addr=sergi.blanch.torne@collabora.com; keydata=
 xjMEYl+2IBYJKwYBBAHaRw8BAQdAGtDWXnvbyLk13igbHNV+4xl0LqgoXtwFTZd7zuf+i43N
 NlNlcmdpIEJsYW5jaCBUb3Juw6kgPHNlcmdpLmJsYW5jaC50b3JuZUBjb2xsYWJvcmEuY29t
 PsKPBBMWCAA3AhsDBAsJCAcFFQgJCgsFFgIDAQAWIQQwWRK68l+taJfhwqAto5bHyTm9RwUC
 ZEEcXwUJA8KZvwAKCRAto5bHyTm9R3pwAQDJRHp8BeXN7o3JOjvJgrYMc17moo3MOJKpoL+N
 N63FhQEAonDZDMF6+/A9L3WgkUn8kpQSlvXqItnmllEI6XjYgwjOOARiX7YgEgorBgEEAZdV
 AQUBAQdAr+LtIQtZCMvW6deAnfpWftbogPIZ8ST2m1qfFeSvg2oDAQgHwn4EGBYIACYCGwwW
 IQQwWRK68l+taJfhwqAto5bHyTm9RwUCZEEcUAUJA8KZsAAKCRAto5bHyTm9R2j/AQDSQiuy
 W2lKZOYpY2FIiBnVfCZct51qMeJEMSmF10B1nQD/XbmDXWJbgPxOHe7t2nbs2ZqaRRN+XtKQ
 UVFjFOEZxw8=

--------------pHbxznB06gWrHjW6GsDe5viS
Content-Type: multipart/mixed; boundary="------------9Jatr3e1pWiQEeBDrsNehH2Z"

--------------9Jatr3e1pWiQEeBDrsNehH2Z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UmV2aWV3ZWQtYnk6IERhdmlkIEhlaWRlbGJlcmcgPGRhdmlkLmhlaWRlbGJlcmdAY29sbGFi
b3JhLmNvbT4NCg0KSWYgcG9zc2libGUsIHBsZWFzZSBtZXJnZSB0aGlzIEFTQVAsIGJlY2F1
c2UgbWFqb3IgbW92ZSBvZiBtb3N0IG9mIHRoZSANCmRldmljZXMNCnRvIHR5cGUgYWNlci1j
cDUxNC0yaC0xMTMwZzctdm9sdGVlciB3aWxsIGhhcHBlbiB0b21vcnJvdy4NCg0KVGhhbmsg
eW91DQoNCk9uIDA1LzAzLzIwMjQgMTE6MTYsIFZpZ25lc2ggUmFtYW4gd3JvdGU6DQoNCj4g
Vm9sdGVlciBkZXZpY2VzIGluIHRoZSBjb2xsYWJvcmEgbGFiIGFyZSBjYXRlZ29yaXplZCB1
bmRlciB0aGUNCj4gYXN1cy1jeDk0MDAtdm9sdGVlciBkZXZpY2UgdHlwZS4gVGhlIG1ham9y
aXR5IG9mIHRoZXNlIHVuaXRzDQo+IGhhcyBhbiBJbnRlbCBDb3JlIGk1LTExMzBHNyBDUFUs
IHdoaWxlIHNvbWUgb2YgdGhlbSBoYXZlIGENCj4gSW50ZWwgQ29yZSBpNy0xMTYwRzcgQ1BV
IGluc3RlYWQuIFNvIGR1ZSB0byB0aGlzIGRpZmZlcmVuY2UsDQo+IG5ldyBkZXZpY2UgdHlw
ZSB0ZW1wbGF0ZSBpcyBhZGRlZCBmb3IgdGhlIEludGVsIENvcmUgaTUtMTEzMEc3DQo+IGFu
ZCBpNy0xMTYwRzcgdmFyaWFudHMgb2YgdGhlIEFjZXIgQ2hyb21lYm9vayBTcGluIDUxNCAo
Q1A1MTQtMkgpDQo+IHZvbHRlZXIgQ2hyb21lYm9va3MuIFNvIHVwZGF0ZSB0aGUgc2FtZSBp
biBkcm0tY2kuDQo+DQo+IGh0dHBzOi8vZ2l0bGFiLmNvbGxhYm9yYS5jb20vbGF2YS9sYXZh
Ly0vbWVyZ2VfcmVxdWVzdHMvMTQ5DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFZpZ25lc2ggUmFt
YW4gPHZpZ25lc2gucmFtYW5AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2NpL3Rlc3QueW1sIHwgNiArKystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2NpL3Rlc3QueW1sIGIvZHJpdmVycy9ncHUvZHJtL2NpL3Rlc3QueW1sDQo+
IGluZGV4IDA4NTc3NzNlNWM1Zi4uOGJjNjM5MTJmZGRiIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vY2kvdGVzdC55bWwNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2NpL3Rl
c3QueW1sDQo+IEBAIC0yNTIsMTEgKzI1MiwxMSBAQCBpOTE1OmNtbDoNCj4gICBpOTE1OnRn
bDoNCj4gICAgIGV4dGVuZHM6DQo+ICAgICAgIC0gLmk5MTUNCj4gLSAgcGFyYWxsZWw6IDgN
Cj4gKyAgcGFyYWxsZWw6IDUNCj4gICAgIHZhcmlhYmxlczoNCj4gLSAgICBERVZJQ0VfVFlQ
RTogYXN1cy1jeDk0MDAtdm9sdGVlcg0KPiArICAgIERFVklDRV9UWVBFOiBhY2VyLWNwNTE0
LTJoLTExMzBnNy12b2x0ZWVyDQo+ICAgICAgIEdQVV9WRVJTSU9OOiB0Z2wNCj4gLSAgICBS
VU5ORVJfVEFHOiBtZXNhLWNpLXg4Ni02NC1sYXZhLWFzdXMtY3g5NDAwLXZvbHRlZXINCj4g
KyAgICBSVU5ORVJfVEFHOiBtZXNhLWNpLXg4Ni02NC1sYXZhLWFjZXItY3A1MTQtMmgtMTEz
MGc3LXZvbHRlZXINCj4gICANCj4gICAuYW1kZ3B1Og0KPiAgICAgZXh0ZW5kczoNCg0KLS0g
DQpEYXZpZCBIZWlkZWxiZXJnDQpDb25zdWx0YW50IFNvZnR3YXJlIEVuZ2luZWVyDQoNCkNv
bGxhYm9yYSBMdGQuDQpQbGF0aW51bSBCdWlsZGluZywgU3QgSm9obidzIElubm92YXRpb24g
UGFyaywgQ2FtYnJpZGdlIENCNCAwRFMsIFVLDQpSZWdpc3RlcmVkIGluIEVuZ2xhbmQgJiBX
YWxlcywgbm8uIDU1MTM3MTgNCg0K
--------------9Jatr3e1pWiQEeBDrsNehH2Z
Content-Type: application/pgp-keys; name="OpenPGP_0x69F567861C1EC014.asc"
Content-Disposition: attachment; filename="OpenPGP_0x69F567861C1EC014.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEYlvLOxYJKwYBBAHaRw8BAQdA5CoWEzz4igpwK4h6lK6ZformRk84+ymcfkGN
PwqEeILNMURhdmlkIEhlaWRlbGJlcmcgPGRhdmlkLmhlaWRlbGJlcmdAY29sbGFi
b3JhLmNvbT7ClgQTFggAPhYhBEo7kSl22BK0F1Np/mn1Z4YcHsAUBQJiW8s7AhsD
BQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGn1Z4YcHsAU84kBAK5Y
qSWAOuIumAqgWvke6BEsaIGWGQzXSuKjer/TXuFuAQCwc9ITSVXWWTSpdFt2+4z7
Wch8tIGlbIFcS9dCFddwCc44BGJbyzsSCisGAQQBl1UBBQEBB0AEk7jXEwDApGOw
MH/X0UAPBH8Y3isjxhNMjpyRcnl2CwMBCAfCfgQYFggAJhYhBEo7kSl22BK0F1Np
/mn1Z4YcHsAUBQJiW8s7AhsMBQkFo5qAAAoJEGn1Z4YcHsAU0PEA/j0YuAOKJCnn
wrkf3ozPP0sutA5bojoARwcIaZKO/zvIAP9PwTC9DGLg+8LJm7m2Lyf0LxLA8FXD
wueLHBdwHg6zAQ=3D=3D
=3DOQS+
-----END PGP PUBLIC KEY BLOCK-----

--------------9Jatr3e1pWiQEeBDrsNehH2Z--

--------------pHbxznB06gWrHjW6GsDe5viS--

--------------rZiod2GXREeubTimgoI7WYNP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRKO5EpdtgStBdTaf5p9WeGHB7AFAUCZebyFQAKCRBp9WeGHB7A
FOPDAP9K1BPqWUkNIG7MbQhzonsxWvnKzAJTZAY8NQ4XqYgrjgD/Vq9OX1+60MAD
VyVhhxyji1WKAZrbG3+YEc9/Y2U8gg4=
=D7je
-----END PGP SIGNATURE-----

--------------rZiod2GXREeubTimgoI7WYNP--

