Return-Path: <linux-kernel+bounces-884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F62814772
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9691C23298
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355C25566;
	Fri, 15 Dec 2023 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VJsG4X6s";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VJsG4X6s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC425112
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97295220BB;
	Fri, 15 Dec 2023 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702641400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=LRMQqVrZ6GARetn79IuzTK+ZJbxCgecJDKfpgXerAnA=;
	b=VJsG4X6sgw1MGJnKTekVz+InOJNR+WtKCZtrphNcQx5la13R1R58GuwHZsWGmRglDayToA
	n1BNORfX/527aa9tkppMJmwE6wha2Bcswih8E7uddmWFW3fczrWn3+2zzOAejVno6ZHi5J
	3KuUbnjbEfogNHlR34NOw82jxBTCy2Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702641400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
	bh=LRMQqVrZ6GARetn79IuzTK+ZJbxCgecJDKfpgXerAnA=;
	b=VJsG4X6sgw1MGJnKTekVz+InOJNR+WtKCZtrphNcQx5la13R1R58GuwHZsWGmRglDayToA
	n1BNORfX/527aa9tkppMJmwE6wha2Bcswih8E7uddmWFW3fczrWn3+2zzOAejVno6ZHi5J
	3KuUbnjbEfogNHlR34NOw82jxBTCy2Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F72413726;
	Fri, 15 Dec 2023 11:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IGmPFfg+fGXneQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 15 Dec 2023 11:56:40 +0000
Message-ID: <29ceab65-4790-4015-b83c-241c35dfff08@suse.com>
Date: Fri, 15 Dec 2023 12:56:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
From: Juergen Gross <jgross@suse.com>
Subject: Crashes under Xen with Radeon graphics card
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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------p0vLCb7WsYvA2vtXtEkJRHBC"
X-Spam-Flag: NO
X-Spamd-Result: default: False [2.90 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 HAS_ATTACHMENT(0.00)[];
	 MIME_BASE64_TEXT_BOGUS(1.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MIME_BASE64_TEXT(0.10)[];
	 MX_GOOD(-0.01)[];
	 SIGNED_PGP(-2.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	 MID_RHS_MATCH_FROM(0.00)[];
	 MIME_UNKNOWN(0.10)[application/pgp-keys];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 2.90
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 97295220BB
X-Spam-Level: **
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VJsG4X6s
X-Spamd-Bar: ++

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------p0vLCb7WsYvA2vtXtEkJRHBC
Content-Type: multipart/mixed; boundary="------------ORrOahqAO9gzzHbVxO77YjGX";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: lkml <linux-kernel@vger.kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Message-ID: <29ceab65-4790-4015-b83c-241c35dfff08@suse.com>
Subject: Crashes under Xen with Radeon graphics card

--------------ORrOahqAO9gzzHbVxO77YjGX
Content-Type: multipart/mixed; boundary="------------PmkiSJ5jAAIl0MvSACFfnbck"

--------------PmkiSJ5jAAIl0MvSACFfnbck
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgcmVjZW50bHkgc3R1bWJsZWQgb3ZlciBhIHRlc3Qgc3lzdGVtIHdoaWNoIHNo
b3dlZCBjcmFzaGVzIHByb2JhYmx5IHJlc3VsdGluZw0KZnJvbSBtZW1vcnkgYmVpbmcgb3Zl
cndyaXR0ZW4gcmFuZG9tbHkuDQoNClRoZSBwcm9ibGVtIGlzIG9jY3VycmluZyBvbmx5IGlu
IERvbTAgd2hlbiBydW5uaW5nIHVuZGVyIFhlbi4gSXQgc2VlbXMgdG8gYmUNCnByZXNlbnQg
c2luY2UgYXQgbGVhc3Qga2VybmVsIDYuMyAoSSBkaWRuJ3QgZ28gYmFjayBmdXJ0aGVyIHll
dCksIGFuZCBpdCBzZWVtcw0KTk9UIHRvIGJlIHByZXNlbnQgaW4ga2VybmVsIDUuMTQuDQoN
CkkgdHJhY2tlZCB0aGUgcHJvYmxlbSBkb3duIHRvIHRoZSBpbml0aWFsaXphdGlvbiBvZiB0
aGUgZ3JhcGhpY3MgY2FyZCAodGhlDQpwcm9ibGVtIG1pZ2h0IHN1cmZhY2Ugb25seSBsYXRl
ciwgYnV0IGF0IGxlYXN0IGFuIGVhcmx5IGluaXRpYWxpemF0aW9uDQpmYWlsdXJlIG1hZGUg
dGhlIHByb2JsZW0gZ28gYXdheSkuDQoNCiMgbHNwY2kNCjAxOjAwLjAgVkdBIGNvbXBhdGli
bGUgY29udHJvbGxlcjogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EL0FUSV0g
Q2FpY29zIA0KWFRYIFtSYWRlb24gSEQgODQ5MCAvIFI1IDIzNVggT0VNXQ0KMDE6MDAuMSBB
dWRpbyBkZXZpY2U6IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRC9BVEldIENh
aWNvcyBIRE1JIEF1ZGlvIA0KW1JhZGVvbiBIRCA2NDUwIC8gNzQ1MC84NDUwLzg0OTAgT0VN
IC8gUjUgMjMwLzIzNS8yMzVYIE9FTV0NCg0KSSBoYWQgYSB3b3JraW5nIC5jb25maWcgYW5k
IG9uZSB3aGljaCBkaWQgcHJvZHVjZSB0aGUgY3Jhc2hlcywgc28gSSBuYXJyb3dlZA0KdGhl
IHByb2JsZW0gZG93biB0byBkZXRlY3QgdGhhdCB0aGUgaW1wb3J0YW50IGRpZmZlcmVuY2Ug
d2FzIGluIHRoZSBhcmVhIG9mDQpmaXJtd2FyZSBsb2FkaW5nICh0aGUgd29ya2luZyAuY29u
ZmlnIGRpZG4ndCBoYXZlIENPTkZJR19GV19MT0FERVJfQ09NUFJFU1NfWFoNCnNldCwgY2F1
c2luZyBmaXJtd2FyZSBsb2FkaW5nIGZvciB0aGUgY2FyZCB0byBmYWlsKS4gVGhpcyB3YXMg
b2YgY291cnNlIG5vdA0KdGhlIHJlYWwgcHJvYmxlbSwgYnV0IGl0IGNhdXNlZCB0aGUgY2Fy
ZCBpbml0aWFsaXphdGlvbiB0byBmYWlsLg0KDQpJIG1hbnVhbGx5IGRlY29tcHJlc3NlZCB0
aGUgZmlybXdhcmUgZmlsZXMgb25lIGJ5IG9uZSB0byBzZWUgd2hldGhlciB0aGUNCnByb2Js
ZW0gd291bGQgYmUgaW4gdGhlIGRlY29tcHJlc3NvciBvciBwcm9iYWJseSBpbiB0aGUgZHJp
dmVyIG9mIHRoZSBjYXJkLg0KDQpUaGUgbGFzdCBzdGVwIHdpdGhvdXQgY3Jhc2ggd2FzOg0K
DQojIGRtZXNnIHwgZ3JlcCByYWRlb24NClsgICAxMC4xMDY0MDVdIFtkcm1dIHJhZGVvbiBr
ZXJuZWwgbW9kZXNldHRpbmcgZW5hYmxlZC4NClsgICAxMC4xMDY0NTVdIHJhZGVvbiAwMDAw
OjAxOjAwLjA6IHZnYWFyYjogZGVhY3RpdmF0ZSB2Z2EgY29uc29sZQ0KWyAgIDEwLjIyMjk0
NF0gcmFkZW9uIDAwMDA6MDE6MDAuMDogVlJBTTogMTAyNE0gMHgwMDAwMDAwMDAwMDAwMDAw
IC0gDQoweDAwMDAwMDAwM0ZGRkZGRkYgKDEwMjRNIHVzZWQpDQpbICAgMTAuMjUyOTIxXSBy
YWRlb24gMDAwMDowMTowMC4wOiBHVFQ6IDEwMjRNIDB4MDAwMDAwMDA0MDAwMDAwMCAtIA0K
MHgwMDAwMDAwMDdGRkZGRkZGDQpbICAgMTAuMjc4MjU1XSBbZHJtXSByYWRlb246IDEwMjRN
IG9mIFZSQU0gbWVtb3J5IHJlYWR5DQpbICAgMTAuMjk1ODI4XSBbZHJtXSByYWRlb246IDEw
MjRNIG9mIEdUVCBtZW1vcnkgcmVhZHkuDQpbICAgMTAuMjk1ODY3XSByYWRlb24gMDAwMDow
MTowMC4wOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3IgDQpyYWRlb24vQ0FJQ09TX3BmcC5i
aW4gc3VjY2VlZGVkDQpbICAgMTAuMzMwODQ2XSByYWRlb24gMDAwMDowMTowMC4wOiBEaXJl
Y3QgZmlybXdhcmUgbG9hZCBmb3IgDQpyYWRlb24vQ0FJQ09TX21lLmJpbiBzdWNjZWVkZWQN
ClsgICAxMC4zMzA4NThdIHJhZGVvbiAwMDAwOjAxOjAwLjA6IERpcmVjdCBmaXJtd2FyZSBs
b2FkIGZvciByYWRlb24vQlRDX3JsYy5iaW4gDQpzdWNjZWVkZWQNClsgICAxMC4zMzA4NzBd
IHJhZGVvbiAwMDAwOjAxOjAwLjA6IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvciANCnJhZGVv
bi9DQUlDT1NfbWMuYmluIGZhaWxlZCB3aXRoIGVycm9yIC0yDQpbICAgMTAuMzgwOTc5XSBu
aV9jcDogRmFpbGVkIHRvIGxvYWQgZmlybXdhcmUgInJhZGVvbi9DQUlDT1NfbWMuYmluIg0K
WyAgIDEwLjM4MTAwNl0gW2RybTpldmVyZ3JlZW5faW5pdCBbcmFkZW9uXV0gKkVSUk9SKiBG
YWlsZWQgdG8gbG9hZCBmaXJtd2FyZSENClsgICAxMC40MDU3NjVdIHJhZGVvbiAwMDAwOjAx
OjAwLjA6IEZhdGFsIGVycm9yIGR1cmluZyBHUFUgaW5pdA0KWyAgIDEwLjQzMjEwN10gW2Ry
bV0gcmFkZW9uOiBmaW5pc2hpbmcgZGV2aWNlLg0KWyAgIDEwLjQzOTE3OV0gW2RybV0gcmFk
ZW9uOiB0dG0gZmluYWxpemVkDQpbICAgMTAuNDYzMjAzXSByYWRlb246IHByb2JlIG9mIDAw
MDA6MDE6MDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMg0KDQpBbmQgd2l0aCBkZWNvbXByZXNz
aW5nIHJhZGVvbi9DQUlDT1NfbWMuYmluIEkgZ290Og0KDQojIGRtZXNnIHwgZ3JlcCByYWRl
b24NClsgICAxMC4yNjY0OTFdIFtkcm1dIHJhZGVvbiBrZXJuZWwgbW9kZXNldHRpbmcgZW5h
YmxlZC4NClsgICAxMC4yNjY1NTJdIHJhZGVvbiAwMDAwOjAxOjAwLjA6IHZnYWFyYjogZGVh
Y3RpdmF0ZSB2Z2EgY29uc29sZQ0KWyAgIDEwLjQ1NjA0N10gcmFkZW9uIDAwMDA6MDE6MDAu
MDogVlJBTTogMTAyNE0gMHgwMDAwMDAwMDAwMDAwMDAwIC0gDQoweDAwMDAwMDAwM0ZGRkZG
RkYgKDEwMjRNIHVzZWQpDQpbICAgMTAuNDcwMjcwXSByYWRlb24gMDAwMDowMTowMC4wOiBH
VFQ6IDEwMjRNIDB4MDAwMDAwMDA0MDAwMDAwMCAtIA0KMHgwMDAwMDAwMDdGRkZGRkZGDQpb
ICAgMTAuNTY2OTQ2XSBbZHJtXSByYWRlb246IDEwMjRNIG9mIFZSQU0gbWVtb3J5IHJlYWR5
DQpbICAgMTAuNTc2ODkxXSBbZHJtXSByYWRlb246IDEwMjRNIG9mIEdUVCBtZW1vcnkgcmVh
ZHkuDQpbICAgMTAuNTg2OTcxXSByYWRlb24gMDAwMDowMTowMC4wOiBEaXJlY3QgZmlybXdh
cmUgbG9hZCBmb3IgDQpyYWRlb24vQ0FJQ09TX3BmcC5iaW4gc3VjY2VlZGVkDQpbICAgMTAu
NjExODg2XSByYWRlb24gMDAwMDowMTowMC4wOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3Ig
DQpyYWRlb24vQ0FJQ09TX21lLmJpbiBzdWNjZWVkZWQNClsgICAxMC42MTE5MDldIHJhZGVv
biAwMDAwOjAxOjAwLjA6IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvciByYWRlb24vQlRDX3Js
Yy5iaW4gDQpzdWNjZWVkZWQNClsgICAxMC42MTE5MzhdIHJhZGVvbiAwMDAwOjAxOjAwLjA6
IERpcmVjdCBmaXJtd2FyZSBsb2FkIGZvciANCnJhZGVvbi9DQUlDT1NfbWMuYmluIHN1Y2Nl
ZWRlZA0KWyAgIDEwLjY2MDU5OV0gcmFkZW9uIDAwMDA6MDE6MDAuMDogRGlyZWN0IGZpcm13
YXJlIGxvYWQgZm9yIA0KcmFkZW9uL0NBSUNPU19zbWMuYmluIGZhaWxlZCB3aXRoIGVycm9y
IC0yDQpbICAgMTAuNjYwNjAxXSBzbWM6IGVycm9yIGxvYWRpbmcgZmlybXdhcmUgInJhZGVv
bi9DQUlDT1Nfc21jLmJpbiINClsgICAxMC42NjE2NzZdIFtkcm1dIHJhZGVvbjogcG93ZXIg
bWFuYWdlbWVudCBpbml0aWFsaXplZA0KWyAgIDEwLjcxMzY2Nl0gcmFkZW9uIDAwMDA6MDE6
MDAuMDogRGlyZWN0IGZpcm13YXJlIGxvYWQgZm9yIHJhZGVvbi9TVU1PX3V2ZC5iaW4gDQpm
YWlsZWQgd2l0aCBlcnJvciAtMg0KWyAgIDEwLjcxMzY2OF0gcmFkZW9uIDAwMDA6MDE6MDAu
MDogcmFkZW9uX3V2ZDogQ2FuJ3QgbG9hZCBmaXJtd2FyZSANCiJyYWRlb24vU1VNT191dmQu
YmluIg0KWyAgIDEwLjcxMzY2OV0gcmFkZW9uIDAwMDA6MDE6MDAuMDogZmFpbGVkIFVWRCAo
LTIpIGluaXQuDQpbICAgMTAuNzE0Nzg3XSBbZHJtXSBlbmFibGluZyBQQ0lFIGdlbiAyIGxp
bmsgc3BlZWRzLCBkaXNhYmxlIHdpdGggDQpyYWRlb24ucGNpZV9nZW4yPTANClsgICAxMC44
MDkyMTNdIHJhZGVvbiAwMDAwOjAxOjAwLjA6IFdCIGVuYWJsZWQNClsgICAxMC44MTc1Mjhd
IHJhZGVvbiAwMDAwOjAxOjAwLjA6IGZlbmNlIGRyaXZlciBvbiByaW5nIDAgdXNlIGdwdSBh
ZGRyIA0KMHgwMDAwMDAwMDQwMDAwYzAwDQpbICAgMTAuODMzNzU1XSByYWRlb24gMDAwMDow
MTowMC4wOiBmZW5jZSBkcml2ZXIgb24gcmluZyAzIHVzZSBncHUgYWRkciANCjB4MDAwMDAw
MDA0MDAwMGMwYw0KWyAgIDEwLjg1MDMzMF0gcmFkZW9uIDAwMDA6MDE6MDAuMDogcmFkZW9u
OiBNU0kgbGltaXRlZCB0byAzMi1iaXQNClsgICAxMC44NjIxNTRdIHJhZGVvbiAwMDAwOjAx
OjAwLjA6IHJhZGVvbjogdXNpbmcgTVNJLg0KWyAgIDEwLjg3MTkzMF0gW2RybV0gcmFkZW9u
OiBpcnEgaW5pdGlhbGl6ZWQuDQpbICAgMTEuMDYyMDI4XSBbZHJtXSBJbml0aWFsaXplZCBy
YWRlb24gMi41MC4wIDIwMDgwNTI4IGZvciAwMDAwOjAxOjAwLjAgb24gbWlub3IgMA0KWyAg
IDExLjExOTcyM10gW2RybTpyYWRlb25fZHZpX2RldGVjdCBbcmFkZW9uXV0gKkVSUk9SKiBE
VkktSS0xOiBwcm9iZWQgYSANCm1vbml0b3IgYnV0IG5vfGludmFsaWQgRURJRA0KWyAgIDEx
LjQxMTM3MF0gZmJjb246IHJhZGVvbmRybWZiIChmYjApIGlzIHByaW1hcnkgZGV2aWNlDQpb
ICAgMTEuNTA3MjUyXSByYWRlb24gMDAwMDowMTowMC4wOiBbZHJtXSBmYjA6IHJhZGVvbmRy
bWZiIGZyYW1lIGJ1ZmZlciBkZXZpY2UNClsgICAxMS42NzQwMjhdIFtkcm06cmFkZW9uX2R2
aV9kZXRlY3QgW3JhZGVvbl1dICpFUlJPUiogRFZJLUktMTogcHJvYmVkIGEgDQptb25pdG9y
IGJ1dCBub3xpbnZhbGlkIEVESUQNClsgICAxMS44MzQzMTddIFtkcm06cmFkZW9uX2R2aV9k
ZXRlY3QgW3JhZGVvbl1dICpFUlJPUiogRFZJLUktMTogcHJvYmVkIGEgDQptb25pdG9yIGJ1
dCBub3xpbnZhbGlkIEVESUQNClsgICAyOC4zMTMwNDFdIHNuZF9oZGFfaW50ZWwgMDAwMDow
MTowMC4xOiBib3VuZCAwMDAwOjAxOjAwLjAgKG9wcyANCnJhZGVvbl9hdWRpb19jb21wb25l
bnRfYmluZF9vcHMgW3JhZGVvbl0pDQpbICAgNDQuMzcxOTkxXSBbZHJtOnJhZGVvbl9kdmlf
ZGV0ZWN0IFtyYWRlb25dXSAqRVJST1IqIERWSS1JLTE6IHByb2JlZCBhIA0KbW9uaXRvciBi
dXQgbm98aW52YWxpZCBFRElEDQpbICAgNDQuNDI4MDY4XSBbZHJtOnJhZGVvbl9kdmlfZGV0
ZWN0IFtyYWRlb25dXSAqRVJST1IqIERWSS1JLTE6IHByb2JlZCBhIA0KbW9uaXRvciBidXQg
bm98aW52YWxpZCBFRElEDQoNCmZvbGxvd2VkIGJ5IGEgY3Jhc2ggc29tZSBzZWNvbmRzIGFm
dGVyIHRoZSBzeXN0ZW0gd2FzIHVwLg0KDQpUaGUgY3Jhc2hlcyB2YXJ5LCBidXQgb2Z0ZW4g
dGhlIGtlcm5lbCBhY2Nlc3NlcyBub24tY2Fub25pY2FsIGFkZHJlc3NlcyBvcg0KdHJpZXMg
dG8gbWFwIGlsbGVnYWwgcGh5c2ljYWwgYWRkcmVzc2VzLiBTb21ldGltZXMgdGhlIHN5c3Rl
bSBpcyBqdXN0DQpoYW5naW5nLCBlaXRoZXIgd2l0aCBzb2Z0bG9ja3VwcyBvciB3aXRob3V0
IGFueSBmdXJ0aGVyIHNpZ25zIG9mIGJlaW5nDQphbGl2ZS4NCg0KSSBjYW4gZWFzaWx5IHJl
cHJvZHVjZSB0aGUgcHJvYmxlbSwgc28gYW55IGRlYnVnIHBhdGNoZXMgdG8gbmFycm93IGRv
d24gdGhlDQpwcm9ibGVtIGFyZSB3ZWxjb21lLg0KDQoNCkp1ZXJnZW4NCg==
--------------PmkiSJ5jAAIl0MvSACFfnbck
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------PmkiSJ5jAAIl0MvSACFfnbck--

--------------ORrOahqAO9gzzHbVxO77YjGX--

--------------p0vLCb7WsYvA2vtXtEkJRHBC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmV8PvcFAwAAAAAACgkQsN6d1ii/Ey+7
nQgAjfqww6/GbcZNEkEmnge1wTmdHmhRgP9iVqj639M4n0Y7jSXycYTCucrC4UOVrb7tgoa4nz/i
rlp9yzMvp/Bi4bnlsrZEPuVkhLmMAUA0hASuJN1mMx9RKQhC12FICN4nL7FTAEfz4p9PN1T+yp3z
E7mg2Q+X+IPzUrD6OkvuUGzf77turh0b0AdrIZnme1ZdTdnhuuVCN6ur8Fk+rHXYTXi/qsKazxpQ
WuaBuK8WJ9p6RCGZvmOmPgE7KsOwHoaY3uMnPFF5ctFusslHKHpDRKQgc/uHtpg2UEBXOQGD1MWK
z/t1I8rlrqWEzVGbG98HC/zlrEXkPROdKPzJpdj/Hw==
=a/5G
-----END PGP SIGNATURE-----

--------------p0vLCb7WsYvA2vtXtEkJRHBC--

