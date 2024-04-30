Return-Path: <linux-kernel+bounces-163875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E9E8B74FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448B31C2226E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465B913D272;
	Tue, 30 Apr 2024 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WtbLEAil";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WtbLEAil"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28313D25F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478154; cv=none; b=gBN7sIew2VhuLrxRZ3aV/fYTNAU8c1YWoCt1sDeyeX17xaBphugiZV73gK1xj2niWkOFKm3yxjTJ7Y1kuBgIX6o7N3S67AFEzR5Gksfs9nw7v4Qj48UFI8STdBTDyrWZ1v2ywMd18ErrcsYcw/rk6xIIQQEM3f4lGAQxktRCsHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478154; c=relaxed/simple;
	bh=AjBFrT49pJPHHPOcIJIQ+KvF9fs8I94HZ/RnZlwQuvc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VuMNI0HP8qaHUJHoqQGbXtwubNaG8ij/5yQFBHZlUBJdbp3el6tMuPF0JbKDdcnI5XQ49O1SMW86ZSXgDgwt3BaaR7Xexq2W/re42ZUqs7ULMnznW2CL52eQI0rYwUmHN4Ctld06jDQw+Ew3hwnzZ7K4wvZfu5INby40n6jL/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WtbLEAil; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WtbLEAil; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 431871F7D2;
	Tue, 30 Apr 2024 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714478150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AjBFrT49pJPHHPOcIJIQ+KvF9fs8I94HZ/RnZlwQuvc=;
	b=WtbLEAilMRD1PJCweFaTD7c6VLB/IrAhCBZfaQf0Tqog8eBMrSFaMSK2ABDgVEm90S1Dtj
	+f8/6nd+UYuulHD3cNyaLmxveYgHqVQnKxrDBBjDa1uWRc+CPJy1DytDI8MlMfA2wRvgsB
	IqRftqdpcYN+vNeKx0MlQr3+kB3G+5Q=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WtbLEAil
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714478150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AjBFrT49pJPHHPOcIJIQ+KvF9fs8I94HZ/RnZlwQuvc=;
	b=WtbLEAilMRD1PJCweFaTD7c6VLB/IrAhCBZfaQf0Tqog8eBMrSFaMSK2ABDgVEm90S1Dtj
	+f8/6nd+UYuulHD3cNyaLmxveYgHqVQnKxrDBBjDa1uWRc+CPJy1DytDI8MlMfA2wRvgsB
	IqRftqdpcYN+vNeKx0MlQr3+kB3G+5Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 006F1133A7;
	Tue, 30 Apr 2024 11:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yLEnOUXcMGbxEgAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 30 Apr 2024 11:55:49 +0000
Message-ID: <735bf906-7328-4561-923a-0340422c68d4@suse.com>
Date: Tue, 30 Apr 2024 13:55:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/cpu: fix BSP detection when running as Xen PV
 guest
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240405123434.24822-1-jgross@suse.com>
 <20240405123434.24822-2-jgross@suse.com>
 <6a0b7c20-a250-4542-b170-101c9663b2e5@suse.com>
Content-Language: en-US
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <6a0b7c20-a250-4542-b170-101c9663b2e5@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fe864Yik00aC00ImqIfV3xr6"
X-Spam-Flag: NO
X-Spam-Score: -6.40
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 431871F7D2
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.40 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_BASE64_TEXT(0.10)[];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.com:+];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fe864Yik00aC00ImqIfV3xr6
Content-Type: multipart/mixed; boundary="------------JBA1E01NbZXjAevh0NH5IVKr";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Message-ID: <735bf906-7328-4561-923a-0340422c68d4@suse.com>
Subject: Re: [PATCH 1/2] x86/cpu: fix BSP detection when running as Xen PV
 guest
References: <20240405123434.24822-1-jgross@suse.com>
 <20240405123434.24822-2-jgross@suse.com>
 <6a0b7c20-a250-4542-b170-101c9663b2e5@suse.com>
In-Reply-To: <6a0b7c20-a250-4542-b170-101c9663b2e5@suse.com>

--------------JBA1E01NbZXjAevh0NH5IVKr
Content-Type: multipart/mixed; boundary="------------JPXjeEfeyqZo71BCWCN0AMk9"

--------------JPXjeEfeyqZo71BCWCN0AMk9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UElORyEhISENCg0KVGhpcyBwYXRjaCBmaXhlcyBhIHJlZ3Jlc3Npb24gaW50cm9kdWNlZCBp
biA2LjktcmMxLg0KDQpQbGVhc2UgY29uc2lkZXIgdGFraW5nIHRoZSBwYXRjaCBpbiB0aGUg
Ni45IGN5Y2xlIQ0KDQojcmVnemJvdCBeaW50cm9kdWNlZDogNWM1NjgyYjlmODdhDQoNCg0K
SnVlcmdlbg0KDQpPbiAxOS4wNC4yNCAxMzo1MiwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4g
UGluZz8NCj4gDQo+IE9uIDA1LjA0LjI0IDE0OjM0LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
Pj4gV2hlbiBib290aW5nIGFzIGEgWGVuIFBWIGd1ZXN0IHRoZSBib290IHByb2Nlc3NvciBp
c24ndCBkZXRlY3RlZA0KPj4gY29ycmVjdGx5IGFuZCB0aGUgZm9sbG93aW5nIG1lc3NhZ2Ug
aXMgc2hvd246DQo+Pg0KPj4gwqDCoCBDUFUgdG9wbzogQm9vdCBDUFUgQVBJQyBJRCBub3Qg
dGhlIGZpcnN0IGVudW1lcmF0ZWQgQVBJQyBJRDogMCA+IDENCj4+DQo+PiBBZGRpdGlvbmFs
bHkgdGhpcyByZXN1bHRzIGluIG9uZSBDUFUgYmVpbmcgaWdub3JlZC4NCj4+DQo+PiBGaXgg
dGhhdCBieSBjYWxsaW5nIHRoZSBCU1AgZGV0ZWN0aW9uIGxvZ2ljIHdoZW4gcmVnaXN0ZXJp
bmcgdGhlIGJvb3QNCj4+IENQVSdzIEFQSUMsIHRvby4NCj4+DQo+PiBGaXhlczogNWM1Njgy
YjlmODdhICgieDg2L2NwdTogRGV0ZWN0IHJlYWwgQlNQIG9uIGNyYXNoIGtlcm5lbHMiKQ0K
Pj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPj4g
LS0tDQo+PiDCoCBhcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9sb2d5LmMgfCAyICstDQo+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS90b3BvbG9neS5jIGIvYXJjaC94
ODYva2VybmVsL2NwdS90b3BvbG9neS5jDQo+PiBpbmRleCBhYWNhOGQyMzVkYzIuLjIzYzNk
YjVlNjM5NiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvdG9wb2xvZ3ku
Yw0KPj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS90b3BvbG9neS5jDQo+PiBAQCAtMjU1
LDcgKzI1NSw3IEBAIHZvaWQgX19pbml0IHRvcG9sb2d5X3JlZ2lzdGVyX2Jvb3RfYXBpYyh1
MzIgYXBpY19pZCkNCj4+IMKgwqDCoMKgwqAgV0FSTl9PTl9PTkNFKHRvcG9faW5mby5ib290
X2NwdV9hcGljX2lkICE9IEJBRF9BUElDSUQpOw0KPj4gwqDCoMKgwqDCoCB0b3BvX2luZm8u
Ym9vdF9jcHVfYXBpY19pZCA9IGFwaWNfaWQ7DQo+PiAtwqDCoMKgIHRvcG9fcmVnaXN0ZXJf
YXBpYyhhcGljX2lkLCBDUFVfQUNQSUlEX0lOVkFMSUQsIHRydWUpOw0KPj4gK8KgwqDCoCB0
b3BvbG9neV9yZWdpc3Rlcl9hcGljKGFwaWNfaWQsIENQVV9BQ1BJSURfSU5WQUxJRCwgdHJ1
ZSk7DQo+PiDCoCB9DQo+PiDCoCAvKioNCj4gDQoNCg==
--------------JPXjeEfeyqZo71BCWCN0AMk9
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------JPXjeEfeyqZo71BCWCN0AMk9--

--------------JBA1E01NbZXjAevh0NH5IVKr--

--------------fe864Yik00aC00ImqIfV3xr6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmYw3EUFAwAAAAAACgkQsN6d1ii/Ey9P
vAf8Cmk4UpBk8TkXnKXmEeL7VJrcCcXZ08qgREjN0jW9qNcelxClBKPzStn6wKP3snTGi2o3dYKO
y8jGgfBQew1P8XU+lbgzx13SbCxcxtMIfMR+nKS7ptpHyVHB/A/guKk07hqzYJHl6GnqER1s97OZ
Nn4IF3fxNgiytod83A4gcp55hqkwySErhygCUfBYXIdZ1rmdhEgb9VlxLZtsEhP4EBTxLoYlgj3R
0H4qj1ffr2BhK86bl/P2JyQNmTs7cENdcykekhGjyhrKcnMxEna1k3M0Ac6GXUEJ2l06kPlZwKxy
JFD6Ux6biRaJfaYZhaV7slPDebJLzZ6LfpJXgs4YiA==
=IuPd
-----END PGP SIGNATURE-----

--------------fe864Yik00aC00ImqIfV3xr6--

