Return-Path: <linux-kernel+bounces-92333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409CF871EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B83284D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EBE5A0FA;
	Tue,  5 Mar 2024 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QJTAqUq5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hl/iSeW3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QJTAqUq5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hl/iSeW3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF07484
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640769; cv=none; b=sMr8m5uUwebKZ4AxgY2mAVFeoVpD52FzURidNZ7+Lg2K73tIQOmHyrNSEnz4G7LmMftmG/0Uuy+ghriW3xAf439TXuTZJLHwsZDbBKG6H4aHccwyUp0mDqBE+izVK1ZQQfYM6+6w147rWmfeCliVK71UAu0c+fRfsO5/+K2wBxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640769; c=relaxed/simple;
	bh=OSO5xqgMe3R2MvP0rT0r4Pgw/OmoTckLw95Pje+PU6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ry77qOPxonuaqzIku8ph/Uh9reCbv0sra93U23rYG11d1GmfOB7wfnDMw/Ioat6guX2S/wFK9vKLRRZhS1eeu9FMEBzFMJCEaWC3S22Fj36Nam5WVod9PXQLYyDOQa+LGPo0m8UixluTibH/E+gayr8Plx+d4Nfc69LH03MZ95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QJTAqUq5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hl/iSeW3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QJTAqUq5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hl/iSeW3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FEFB6AF96;
	Tue,  5 Mar 2024 12:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709640764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OSO5xqgMe3R2MvP0rT0r4Pgw/OmoTckLw95Pje+PU6U=;
	b=QJTAqUq50AnMFQo8OubbJFsD8YwcNRVpFqlWE6oWWBnnStV7/GqHfA381O4mgJz0h+UhiZ
	Ds8aclOOK0mrbewGCoL7s/q0N91/E5cPo6mRGQXQzxpEgM1Tf3mtomup4I8fEnW0c8Pc0k
	2xkWNgcsCICTh8Uw7ZlRoakx8b4/N9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709640764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OSO5xqgMe3R2MvP0rT0r4Pgw/OmoTckLw95Pje+PU6U=;
	b=hl/iSeW3OBHV5KildwEIWLFmE34Bi71CZu+qJcy75l231sQ7cMqNdA9IIG+ywRcDr/qj8u
	xzL18HCJJSfHylBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709640764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OSO5xqgMe3R2MvP0rT0r4Pgw/OmoTckLw95Pje+PU6U=;
	b=QJTAqUq50AnMFQo8OubbJFsD8YwcNRVpFqlWE6oWWBnnStV7/GqHfA381O4mgJz0h+UhiZ
	Ds8aclOOK0mrbewGCoL7s/q0N91/E5cPo6mRGQXQzxpEgM1Tf3mtomup4I8fEnW0c8Pc0k
	2xkWNgcsCICTh8Uw7ZlRoakx8b4/N9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709640764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OSO5xqgMe3R2MvP0rT0r4Pgw/OmoTckLw95Pje+PU6U=;
	b=hl/iSeW3OBHV5KildwEIWLFmE34Bi71CZu+qJcy75l231sQ7cMqNdA9IIG+ywRcDr/qj8u
	xzL18HCJJSfHylBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BA3F13A5D;
	Tue,  5 Mar 2024 12:12:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id N9eSBDwM52UOJQAAn2gu4w
	(envelope-from <rfrohl@suse.de>); Tue, 05 Mar 2024 12:12:44 +0000
Message-ID: <2323c190-ed11-4723-bf96-4949c55c7ffa@suse.de>
Date: Tue, 5 Mar 2024 13:12:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()
Content-Language: en-US
To: Red Hat Product Security <secalert@redhat.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "security@suse.de" <security@suse.de>
References: <2024030256-CVE-2023-52572-2b92@gregkh>
 <ae3d431d-d93f-4fe4-99c9-7157bebaff79@suse.com>
 <2024030513-unburned-eggplant-a218@gregkh>
From: Robert Frohl <rfrohl@suse.de>
Autocrypt: addr=rfrohl@suse.de; keydata=
 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
In-Reply-To: <2024030513-unburned-eggplant-a218@gregkh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------nCo60dVik7aBU7Jbp1qiE6nQ"
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.19
X-Spamd-Result: default: False [-6.19 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	 HAS_ATTACHMENT(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MIME_BASE64_TEXT(0.10)[];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 MIME_UNKNOWN(0.10)[application/pgp-keys]
X-Spam-Flag: NO

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------nCo60dVik7aBU7Jbp1qiE6nQ
Content-Type: multipart/mixed; boundary="------------Q3q2X02wf6HvDpSltpEYOKwz";
 protected-headers="v1"
From: Robert Frohl <rfrohl@suse.de>
To: Red Hat Product Security <secalert@redhat.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "security@suse.de" <security@suse.de>
Message-ID: <2323c190-ed11-4723-bf96-4949c55c7ffa@suse.de>
Subject: Re: CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()
References: <2024030256-CVE-2023-52572-2b92@gregkh>
 <ae3d431d-d93f-4fe4-99c9-7157bebaff79@suse.com>
 <2024030513-unburned-eggplant-a218@gregkh>
In-Reply-To: <2024030513-unburned-eggplant-a218@gregkh>

--------------Q3q2X02wf6HvDpSltpEYOKwz
Content-Type: multipart/mixed; boundary="------------Hri04u3lpPeO7vSzIN1f0VXx"

--------------Hri04u3lpPeO7vSzIN1f0VXx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgUmVkaGF0IFNlY3VyaXR5LA0KDQpjb3VsZCB5b3UgaGF2ZSBhIGxvb2sgYW5kIHVwZGF0
ZSB0aGUgZW50cnkgZm9yIENWRS0yMDIzLTExOTIsIGlmIHlvdSANCmFncmVlIHRoYXQgQ1ZF
LTIwMjMtNTI1NzIgaXMgYSBkdXBsaWNhdGUgYW5kIHRoZSByZWZlcmVuY2VkIHBhdGNoIGZv
ciANCkNWRS0yMDIzLTExOTIgaXMgaW5jb3JyZWN0ID8NCg0KVGhhbmtzLA0KUm9iZXJ0DQoN
Ck9uIDA1LjAzLjI0IDEyOjA4LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+IE9uIFR1
ZSwgTWFyIDA1LCAyMDI0IGF0IDExOjM4OjQ5QU0gKzAxMDAsIFJvYmVydCBGcm9obCB3cm90
ZToNCj4+IEhpIGFsbCwNCj4+DQo+PiB0aGlzIHNlZW1zIHRvIGJlIGEgZHVwbGljYXRlIG9m
IENWRS0yMDIzLTExOTIgWzBdLCBldmVuIHRob3VnaCBOVkQgbGlzdHMNCj4+IGFub3RoZXIs
IHdyb25nIHBhdGNoLiBUaGUgUkggYnVnIGhhcyBtb3JlIGRldGFpbHMgWzFdLg0KPj4NCj4+
IENoZWVycywNCj4+IFJvYmVydA0KPj4NCj4+DQo+PiBbMF0gaHR0cHM6Ly9udmQubmlzdC5n
b3YvdnVsbi9kZXRhaWwvQ1ZFLTIwMjMtMTE5Mg0KPj4gWzFdIGh0dHBzOi8vYnVnemlsbGEu
cmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MjE1NDE3OCNjMjgNCj4gDQo+IFRoYXQncyBh
IG1lc3MuICBQbGVhc2UgaGF2ZSBSSCB1cGRhdGUgdGhlIGpzb24gZW50cnkgd2l0aCBDVkUg
d2l0aCB0aGUNCj4gY29ycmVjdCBnaXQgY29tbWl0IGlkIGFuZCB0aGVuIEknbGwgYmUgZ2xh
ZCB0byByZXZva2UgdGhpcy4gIFRoZQ0KPiBpbmZvcm1hdGlvbiBpbiBOVkQgaXMgbm90ICJy
ZWFsIiBmcm9tIHRoZSBwb2ludCBvZiB2aWV3IG9mIHRoZSBDVkUNCj4gZGF0YWJhc2UsIHNv
IEkgY2FuJ3QgdGFrZSBpbmZvcm1hdGlvbiB0aGVyZSBhcyBiZWluZyBjb3JyZWN0LCBvciBu
b3QuDQo+IEFzIHlvdSBrbm93LCBOVkQgaXMganVzdCBhbiBhZGQtb24gZm9yIENWRSBlbnRy
aWVzLCBvbmUgb2YgbWFueSBjcmVhdGVkDQo+IGJ5IG1hbnkgZGlmZmVyZW50IGdyb3Vwcy9n
b3Zlcm5tZW50cy4NCj4gDQo+IFVudGlsIGl0J3MgZml4ZWQgaW4gdGhlIENWRSBkYXRhYmFz
ZSwgdGhpcyBDVkUgc2hvdWxkIHN0YW5kIGFzIGl0IHJlZmVycw0KPiB0byB0aGUgY29ycmVj
dCBmaXggdGhhdCBwZW9wbGUgbmVlZCB0byBrbm93IGFib3V0LCBub3QgdGhlIGluY29ycmVj
dCBvbmUNCj4gaW4gdGhlIFJILWFzc2lnbmVkIENWRS4NCj4gDQo+IHRoYW5rcywNCj4gDQo+
IGdyZWcgay1oDQoNCi0tIA0KU2VjdXJpdHkgRW5naW5lZXIsIFNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdlcm1hbnkgR21iSCwgRnJhbmtlbnN0cmHDn2UgDQoxNDYsIDkwNDYxIE7DvHJu
YmVyZywgR2VybWFueSwgR0Y6IEl2byBUb3RldiwgQW5kcmV3IE1jRG9uYWxkLCBXZXJuZXIg
DQpLbm9ibGljaCAoSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpDQpHUEc6IEQyOUYgODJBQSA5
RkQ1IDlENkUgNzRCMSAgNjM3MCAwODlFIERCM0QgMjMwQSAyNDA0DQo=
--------------Hri04u3lpPeO7vSzIN1f0VXx
Content-Type: application/pgp-keys; name="OpenPGP_0x089EDB3D230A2404.asc"
Content-Disposition: attachment; filename="OpenPGP_0x089EDB3D230A2404.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFuyOM4BEADRsWp3mN/bsO6TcQPpb2tLx3kgt83N3uhNVPUdr6JeQK0eAWWj
ZQUSm3JlUBkQYOncMwqarzI+sI8mcZE97VKUy8XX0CFG0veq3J0jZIo2oc0QiJhr
uW7uBWOBe5RaD3Z8ysyEJGZgHHBtjZqJYqJcovp701GOzxbi9YKd9qeYL0iVvaL8
60gt5za0s8foBVnNsgmPv0R4snrHK9s+BnPKX1/rHZQCKzLjawrTsgEtUHB7M9NH
eO92RX0+ifmJUQ3uTglCh1lg0HPWJNunzz82eroteBUB93+mbzq7yzTUCsbjZukD
J4okTZ7a2G6m751uhf5aeeomkWmbb0GY680HxTEUVEM4dXVI8HTSxVfj7yrAlIKO
9kgV8/Za34kCxlb43GSRupCgD0nbyjbAaiSkYSyRrdaJHqEbbZU8VDfYVtZrOKtn
Geq0DgTq+Ck/ceNTAY9XliUGdxrasRoQh+AtGE+1u/E9e7r9DRdhs4PntpKQtgsF
KwQ7c59aCwX5J4ZCcq0vQx5vUeqyaADPki2uzw6Pwgh+e6e4L9Hs5GUtY04anvL5
nmiyS9X1b1unUIUyQTRKvhlT4f9y2aOrlhT498huaVuHOOAqgII0z+FIxd0ssRoe
6meBgKtZDUfHNb+vBdbgzsMMa9gQ6ui+fGpo5cd3kKTq10eEjsvtCmPDTQARAQAB
zR1Sb2JlcnQgRnJvaGwgPHJmcm9obEBzdXNlLmRlPsLBlAQTAQoAPhYhBNKfgqqf
1Z1udLFjcAie2z0jCiQEBQJbsyumAhsDBQkFo5qABQsJCAcDBRUKCQgLBRYCAwEA
Ah4BAheAAAoJEAie2z0jCiQE9noQAIi1CnRP0vHQes5/Xau4E9IwbFjrqvlPwP21
3C82qILuG0iLyOy1ka2UUZleFJ5o/a8z+ORGVTftzDKQFBJvQiD+XlBbBO/MD/x2
KxyFUPdM8HiHJ5nGukBOdFiO1e4LiFA291frqAYf/cH+pqV1PzQ2E/N69kaYVeaS
1L35rwsmJKKH31ojMBDzuJoX3OO/JRTXn6A7o9Iueh+U4PDkdCOLmeiZ5ZFi9kiY
MY5GNeaztosgXPWAT4BGCZPb7s6P4Ft1a4+3Og8DcrjnLlYLFMIhkS0REX8d/KEd
lCOAiYYKKwOrZjw5u/emEt9K2SHJTP+m68UMRo7l2PxBq/gry7nzZrqsTxjGXAn/
2NNeDI5Xy7wQHCvc2ReTpVHBfWzjfRaWAlJmohel/6VWU+uUL12ZX3UprIRHNwD/
eb8Xsw77k+gFZwb1H810GZATDXXZjOjugtzaue969ZzLYtLrHafQw1RGyCoIECoc
l5u8K3HMZYuq+o/5rx52DPzTEL0EigpW+zIsta5JqO/Yqta4pSt9MgxpJxq3kNSC
X8/nseyRfQOtWbedVGqEbKoPlhx97qqenTsZjA4LAv6VUB0lD8egHEb4O0WO7aOl
4MlFqFr3l9xCXSxsrp7v+qUs9CVrAk886UHGTnoaSv9C8D0RY92vuTmeRflbde3m
9v5Pw8NewsGUBBMBCgA+AhsDBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAFiEE0p+C
qp/VnW50sWNwCJ7bPSMKJAQFAmEvKV4FCQk/V5AACgkQCJ7bPSMKJATX2xAAlOYO
gJ01mnKLMBTLOyZEWa9+igbLpAQAsraZrwxR6zSHkdArXOFeleov0gxYHZsOqnEH
2CvWcmDO3lUrPatY4MuxFg/+dsN3hkpVfKToAmXLk5najit7QVW70eX/vbuJsLkP
8iCPK1tJUH7wAyC74x87r/MwdcIeZMUUJSNWo00lKG5xzlT3cy1nDbEcQh7F3KXm
F6TYvOfzeLXeI+ZK7hHSs4GZhK+OhNlaCBk28RI5zhUb8hDzGwrBWg2p6o/G9h9A
V9rGG8m1G6V9QVeOkN0cFbDlpQ+N74vZjDWAQeLNVJT1p4vAIVOlTZAyVIAe2me0
YT+6FgThPrWvLVybW3poRnItucq7fF1BgqMivcGGwBoxoSvkQ7earxYV5EEItV5Q
PT5hbNK2nsjmvC7LpPz8vXrn/oXSLMiWT5k9KsMWTrK+oR8XYAB7LJdPJFi3qCds
1Xr0UK/zRG2i/ek/ozz5XY4onY5yIwXNtZCVnBDTpb5UQI/m37KP76Kh+02ubzZl
B7758nWaMsLT0zZRcLxwnNkNMLnwth2w+xjzgvDmS/GuFhW51h9abJ5kpXsKnIij
pxTNb8ffFriCcbxwDBDRJ42/afWbiePwPqBOgwylt1A7OlONOL5uKqiQQpDcMjyN
+133s2bVStL7bghnhGgLNngCMM9ocUbpnvb2CE3CwZQEEwEKAD4CGwMFCwkIBwMF
FQoJCAsFFgIDAQACHgECF4AWIQTSn4Kqn9WdbnSxY3AInts9IwokBAUCZPG6cwUJ
DQHopQAKCRAInts9IwokBJ1gD/9s/Xq/HydXSqq9nz4m69HuQK0FVLKIxOuvzCK4
l7bR+xUYGinl/roJUEfhpQmUxEzqrnVa0aBlH3S342t76tW0uSYKKfmAzPMFp/FF
Sl98mlyPzy01at5/5hBsIthTYh0A1wslGZr6q7HHPYDt8NNHr6fqBDHk50tTQrMV
RRx5pca01WuTiEkIEsuS0r1m4JjO34KPmYxP1QCLuxsQh6SNU6rk4el8biMQsGy4
f0Tt1AkBSi98tr+nRgKQKwG3B3R4z7J1jO9zPoVLwWbSXhlRrg0jpvkBPvkk/A0B
Au0CHvEA6ItfLbUMgYiJ/M/f0ycqSs7vOeXFGwDYic+1dmq2kFu2Xt05ii+LReUu
KTFHzxn/Rut/hgrKMWVJFVLul19oNvvOMRQ/wha9lye716HkomTo6sMxgKAIvjus
K54W0453v1K5nHcG0PtuPRX9NpeXyKIYkZXWcDbijeoCQsO1vPGym6h+XiNwj/pr
g/1WUQ2CjFRSpvDzGNadkUeQHOhCFBFMBm0zgCyqN5ZRc9C53+kRWkpaOkjPKviy
+Kj05RDVc16E5VCTeL6f2WcjNsjCFtQ6RuJp3aNfvj8AvBmuyKXTpMlUE7Q0KcQ1
Y+U9zjEU4TAaI+ORvLTSqFAgpT05R8vaLjNzVhSv5QFkMehS++oNfbmvB9wuAaLe
wpD17c0eUm9iZXJ0IEZyb2hsIDxyZnJvaGxAc3VzZS5jb20+wsGUBBMBCgA+FiEE
0p+Cqp/VnW50sWNwCJ7bPSMKJAQFAluyOM4CGwMFCQWjmoAFCwkIBwMFFQoJCAsF
FgIDAQACHgECF4AACgkQCJ7bPSMKJAT+NRAApdnoQMNWcIXfR18d8M1QvTsLQtWt
LSbywwgcYlCfDIjHL+BUFHQb20Kp/J1WkBehtKfH6b+bK/jt6BCdoctjlP35isDR
IyxRhs0Y6iTrwLVUYwnn7LgwwjfxiTKb1+NoDw5DOS0/lxeRG1mmZNXq2v2sEM9/
W9oWANFRyp5ciejW2NPnw0bZoW0gXms13KiMONx84ikc1zokGk/mltOKJFlSivp2
FIlBjU8ciuPRtRVUvuCXJIABKic72BMkvzqyDpgvRYOvGnmK+iJBXaUmb7nLUhNm
4Mu9Hgv10KXnurhvl1IOMbqhF0RHQWfKI5VRmzVdAd5KljXKm6zp8c+2h4xMTkGy
tB0u74dZbBSQjcOi1QY2xeehlPe67UPgrVqGqh/COBF6zVyqPTLIVNVjV1ogHfDb
PL0f31GJJa9kTj6Xrn5rY/8d4/vsH+rpxmAzrKKahZqW5SUFUM2qEb/W3QCzJirQ
J6e1I5YPjrImzDvs4DBEnRBCso13RJnEWtIFjVelC9QOFyCnGYGk0ceyeyyxxcPT
nso4wCgXjdql7RHaORBH+shIsWVzPP6J2Cci8FhtB9Bw0dYyzeX8wXSrUCF0Tf8M
dWltV2dGnkM6n8tPBY3AqHI9YyXIfFoenRIOOqs7vLmOVK7/GiKBvHeAs16uleYs
qrehc3SXXuCOCWfCwZQEEwEKAD4CGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AW
IQTSn4Kqn9WdbnSxY3AInts9IwokBAUCYS8pXgUJCT9XkAAKCRAInts9IwokBLHy
EACIU0Dt3a8RVsLowJxpv7tVGLXLRmORUDc/OeMlJkKifg8Oi6200h033Jaqu+f2
7SZyI1b9y53URIdJtb3DD0yxR0SoHuZRR6zjcFyTR7iYtBQ68Zj9OCLvFKqWWpHc
JUEyaCoLF0QHTOLdm9vQ4uLLfapaFCUEb/qLk90DrXp6YvDHUy1fcL/1NCSqxULG
CUhjtWAkJ4hA08N4RLcdA5fbfnsL8Mfz95n+Qi5vJZZe24EgU4WL/uU34RvfX0O7
9mRpmXqiQ7jEljuYd3LvU3EpJ1jKR3QwQhFluzDsumWEDfJ/e3J2u3NH8leoRD7R
xRoFcV9qiCfCOUeSzDHsqX08cLQsAOSYPIm4LhjlgIECHgennLtikTF29k+chplh
Nd4UTLhrAPXABoFRB6Wt0H4mxw59h4HlYclzbP6OCNwz2TucWhX1wINYKdlKcwoe
vZNBpLboeUw+x+0GBrkdkDQtsjJNK2ZeEP5Fd58dZeBQ7ht9wWQXQ3HGjASpaIs1
cXWm2SdQ7k4X0qTg8NuF8QBygaaWXPxqu8iK9eMRlV2lqxkXW+3k6gLy4mWZqzIW
mdiA+lPiGuKO+DcuPSTJvVcGsWhzSpEt6j3ynwbggWYesvo3Cda2p5h2Y0hPv7e4
QeMF1x2q+OXAHDsUIgewhrx/A0WMguUqq6MwmVvOS+fBG8LBlAQTAQoAPgIbAwUL
CQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBNKfgqqf1Z1udLFjcAie2z0jCiQEBQJk
8bpzBQkNAeilAAoJEAie2z0jCiQErVcP/jZXyID27sINnvt8BAymwomcdCCq6fv1
Fi8VpSUSu/tOD48VRiFoBEgnofd7y7qltR46oH+6U2Ju4mkZnj/9JEvvspD2Xn5B
45ciNDc871vJT8KdP77JJ49neZCdfzhLA7FUZLDFiY1Hm8NHj0P3Zuf9d4vK/e0D
95UqerZfEHft0EiTv4azPYjPONmSYyYEfrVTMyMgSdZnpbMvL4LsXUsxN3JOxdpp
I9ZD19Tgleyh9y/+XEEAzqxkoRHQCCKnvsj9cFGMITXAbNNQQUia7T0LVV5AAD7L
oC3wCpHL1C9zmXn771n0nrqw3KVC26ZxUPWqhXGRLSpHcyxXyxW8CSu8yqKqEn4n
2dTF1QOolyAEax8NTQC+39RH5ALjKYZSHvqF9nZwHfgO3v665efcisDnev0ASaPY
RdrVM9wupLjUEeQsx6NwLNXYK0QYAumBhBc7I/SdytxD4b2fHSVuYrBFgOT5FiRr
RuE31LlsSSodnKcNzc/TuDf/QghMeEeL4RNRU4UPqT/inS/SEtNYynlF2gF7rpJc
A8iiEfD1ZvIue5llML34Eu/NO+Sca4HpNuOyRAXOHNsmLawUUeQh0nADjjgnHlkH
lQAofO9LUdkK/OwYdMKalSnfVE9eK1XFbYyNB/nz4cI9yNvE5RzBwXhb6DiRYIew
sMLzUS6wIlyLzsFNBFuyOM4BEADmLsbNUvnCGfBP52cRv8UJdvrmcUeSGG4qlhAv
SJpXXPu0Jv4JCsFnUhBq1y609hSIfZLnMElBcmXcZXcRm1dtWsDto+XhoXgCIcqT
zym75/mcX6MeN0tk5cRY4NqST6ureE6p3UHs5nFHRtqnPOTPzjaW96iToLe6hPvO
1Wulsru45bbrB5SXb1wBE3I599BIE6Ur/38WNUIVT+jDxqVm2It0G4baNdgaN3/M
y9xViZIJB3he3XznrxIjMX+h6QExYSe41AyVEL7CAMV67aiJXjlMIR8MOQ/RLjd5
s2YrOSm55iazDiSkH8Kruc24W6iR6L+RxLK+jWTKLYE9qMESEqPY99FSGeQPJBk+
XZ7LGYEMLzcS+EE7DpXKfHbsbKQbPof8lzWEDOxi8BQcygLGYF7+zwsSr+b1cIJN
JIZsbsxmo5WT97JkQfw6HyHNBkDwAiHlEOKKkud+bGs8Qb0IiOw+tKDQDW/EVoL9
NGy/FOvD0mZyHjZo40JdMfXd8z6c1gqqIw0IPV3/Bfl7ZrCD1g35I/KqRyNUFFnM
60tguQXlKOihF08/911Z6dsZW/flfccTUU/tuTRMlHD8QgpAHLijy/VF9FqGKhoe
TWeo4vOpp3TbTD4AfXi1fqo1nIZ+EwizYidTPVieYuy5EWd24hhiQKrmHJwFbsu0
lJPwuwARAQABwsF8BBgBCgAmFiEE0p+Cqp/VnW50sWNwCJ7bPSMKJAQFAluyOM4C
GwwFCQWjmoAACgkQCJ7bPSMKJATu3hAAmmKw2LVGq1pftyZlvsqtMhUUDOORiLLX
IyQovpLtj0IZznt3kzNwuFVbgESPOGRrt9l3jI8dpSKWd9Pg5oJt5/2jPNj2F7GN
xHPkYTG1K6zAHlLBIwBBYWSX+rcz2RW8jeylrKafA5itwOtFq1Rwo+onerZllf48
+En8/9En7SAU9xbr3MREh9ErFoDnnMUKw8IyxWw1MAWVi5fbjKDwFqLsf3A96u+E
Fvc9cume7+NSwa5w1aOKa7JZ+g/VK8iKIVushY0NpKUXzvbogxhgsL6RelU4RN5h
WarmFZTFK9Ppwzf7ropwl4YoRpaiwfzSudXMmvrjKm+5dwGy539WaKy+SjY1Ir2n
mB4ACl/skmjoXWUyvKEmRSkWoAz3GJpb6ZXxpCvIPXLMn4PdGRVPQJT/brQgNUHJ
cIa4BbRHdyT4dgAvRxQZvHRi+cm35REETGugQL+SyOHPQz3oKOzcW0ROyC3z1tKF
4RSsH5hQUGP8P9xPaGGn3Nb9MO3Gu41Vp3c2FqszlFDtkMKXkDI0G+LIXSMvtl04
PVXLKNBGTwpmBJb1+XPCXU7cuEXKJcNYOytc/4zR3Okj5S81AWtoLngE68lNYMQn
85bNNUuuR+x6/B2f1kS4eF4cwCBCejGwZMBHxkxHcdX42VfsEd1v+NBy2bsLQVyC
m5KLNBGBbwHCwXwEGAEKACYCGwwWIQTSn4Kqn9WdbnSxY3AInts9IwokBAUCYS8p
3QUJCT9YDwAKCRAInts9IwokBFbqD/0QLhVSaP03p/ttL2wYdXNg9YztM7xwXV+x
i7aNtwdzGiKwazAKNMMObMq1jNR1ymDTfpM8C5C+2/SKcy7SG4yt5K2fwlq5xy80
l8iwguCH8rupzRa0UXm6M/6kjC8XWELjEGL9DYCG4jfuYY/zypRSTf2YWv7G7hpY
xLjvYGHc+G1jZruLpZkD8aT+0knXECxDRiY8secJ6ML6ZfWXgsCNbngcY3hx8xtO
I8q6cNGMrzg3fb48iaHiBRu3LVb+4qsBgwnb0caIdkGAlGQ9tLpdo7d1uYs0oQsS
S2kUhyH1PZY0ahZjoLHsjLiKHJ/WU5vvaWF2rEpN+cvpzJzQ4rrFRUCmNzeqRVcJ
h7b9HC3sxlpfmh6x0PoI4v5/ALdIxZ9RXhMpawM9xlsSsAYtUrhKejL5JiLgBBck
sfiDiEOPL62nj9GB4hq9vTOkNmxb7+1IPIdpjhPX4DnVPeM8+FCKXtRRGw/Z74MX
GJLAIiSpeu5Qs2j7C3AxEE1/PxIUQbnNtUiQyYT8GwlNvenHyvQg/TilVIX5ML2Y
E+SmOVZABVFQxVPwP+kg+KtXqDpCRNUjDgToZaHcT5YdjnoAaeG4x6SwVpeDPfKD
MZtZh3jeFOedajN4+/2mUkmmZuXMxxs/EQW4OoldEtBB9mDpOkBTwtG1fULB49Yn
6Xvs01uaPMLBfAQYAQoAJgIbDBYhBNKfgqqf1Z1udLFjcAie2z0jCiQEBQJk904i
BQkNB3xUAAoJEAie2z0jCiQE7qAP/iMiMXsoiQNwFkn1mPJtgn8dHZF7AfuaI5HW
y/17weHRJaXQJOqeG94eASqQKaQEmc1vqkkVBz8TSEAchdReafR11+vZSdlIy9tY
bAKguhzNihS+/2c9q6DM+1op+1vnH1/Ry49bDOhOGMPRMJqIdBY93hKiu3X/pil1
tJZ2QZBBHunTCsnRWjDQGwBJ47DKp8M49S/RdnD6Vbiu/NghAy94I4TBYH9YGHvA
5jyjTZLwpBwc7VBhUn6Suf8OWmNgp0IzN5hGW1NDiSX+k7TMAO3cLxBgq7d2i61a
EUmT2Syaxcv3Y1Li+VD38nXUYFr7UsotfmgZVou5mdWx3WRox31vZ6oc4muSycBm
X4R53hugwkCwbIsUsj5U3cvXHVCNxyffh+sw+aILkoLjr5QBJkU5z3nh0uHvgg5o
2COBAKbdSz2vYI/3giG50TZ0KiqKzZa6cM2ICAbLro3yq/l4vhQxK8RNURZwMaMU
/VGcP1CDYin7pltxY4RSxtjNhWBeOrozM1mQUIW4wHGHWfMSKs1IB2kcjHmNPc4F
n4X0cI2YlOOYr4PO6v4QsdbyTqQOrY8xCwHO2ZLJbzdGTD9Vh1ve4rEzJVhh7UAP
LizgRqpeyACZt4FezQkJ2mvoObsKx18jl5ooB7ygK70ykX3bNlvA3JxuVaUiEUsj
/3ZLahBszsFNBFv5lKsBEAC7ks2QRHFElJH2NK9UBJvpLPfz8j1YmNbKxZ/gAc+k
ja8ubq4s3Yvmq66CMH0vaBACs+u3KeeFXKPKhuXa1LakXj1VZphgDpQmqSKzC4QH
/ngZnReBDbsYU3PL0xW8OpYIQ48PxAM5/TzLjCSHV1UlaEqR44jxZQnenns23qi9
dPnSqY4uKTSSDLyrXfH/aIVU6MB3HrOPN/rwe7e8vqjMtgefz23n2naSVa0YjZ8O
x5Z2JCKA8H8/myAIiDyuM61PgtSbG2I+72Ly9l4ZhWa2jxp8O/9+5N0V/eJAPQOP
zU6iKukVJlnQOoSkX4bBASbLfyx9BWJs4K7b+VmSI+A+omKdnjPUMarb/Pmmnn0j
ZDSlc5C07GyS/+1I5C+cpKE+C3U2Q8D/BPZ6xMMFqxonMZH/WRPwqewzERNg8dkL
dvqANJLXVH/8D/REo3skMQcidykKizwfh3xabh26n1IrJx9QG8NcXse+tNMjQSgS
EGPTzN7ZSgzY91Ps6y+RloubBjrxSxl8h7b9MRaL8CrpqMNo4rZ1vnnnbpmJ95Th
EFAfu2KtH7uyjBDu8wwetE0PSJeR1AY9l7+rOzIL/yhPIt1p2reOfJeJyhDN05cz
FQBvqn2YF9i1rIWQdE6sZKiMWEsFmW/DXH6JYMnAim7xS1LgJ4+CONIl/GRUuUaX
HQARAQABwsF8BBgBCgAmFiEE0p+Cqp/VnW50sWNwCJ7bPSMKJAQFAlv5lKsCGyAF
CQWjmoAACgkQCJ7bPSMKJATELxAAgAxyKLWSUCrXqODoboejorZpxv68lXh9sBIN
xRWH/7JjZdAJM1tzIifrVxaQif/7JHBvdBtFm2A8A1Bc6gkyKerfsLBsoRPgpV/K
xa53qgmOEFh0hvaq8VTj9oqvVdlzcwcYZ6Eb32JIxtvS0Nj5amBXZHwluIc7EYti
OlnSRLB87ej84gdcfa23JzT4/K5fu6a1Qs1sD9cb0oFtWy12ngNj1+UizL09ToBK
eWDlL4NJgTce4hhn296rNeF/8rM+jlOo504DNcTqZf8Beiro1WB4ErTK5Il3GK8c
Tre7SAtP0lpGwe7sef5N47WJYI5lq6aTNuvkAZ2KkPWz+P8x5qLnM3uAfHu9VdRY
P24ARvNKFMCAfF7hpoIhEd+eyK1gBrFJP1NV1iAlB/P9MK6E+oOivMOSMVDx6Rw7
cd/dipfMWIoPcilGMC1Bqy30u275rF1vJvwl9aQxzhPZSm1TUJXEUNUE/gqllB39
PPaVZzmB6NZhuY1QU/NUxdkj1Jv1f7T/P1WuMEodM5bKT/ZuBE8ydRaH6mg+3WOE
ce6hGEziho5FMG7ikmTMud3ikhbkjGUFvg2ARVf4GrAtdyHWl9zZIyo69NcHwnOr
17p3ogtihQS32QvpMQ5nGZQCCg0K7N+/Hst8Ouqq67Dg9cg/JzL72Bv+ixMlS7hK
0vsyklbCwXwEGAEKACYCGyAWIQTSn4Kqn9WdbnSxY3AInts9IwokBAUCYS8p3QUJ
CPf8MgAKCRAInts9IwokBK8AD/9TXhdM+QPwSYO63QssAc7hD5WLnfCvP7ZifPuf
RV/p8mZdIbJavNQpfCZYXzKm52NnVyv2Lyr63DJ2gB8jVj8pVB1kyZFzQUv5kA7t
PjMtqt6c2Szf7xWJ9KiddXqmaoio3281vejFMYHkb1FFqJoGHsgEjthe+XXS/gXP
uM/+vHDpeG49cjFstneyO2IfUEUIgs5DbLLyx3y7a+LhVzG+PI9NDuO9hD4JlWMk
+3XaeDbm2EcaS0lor4E0F4/jr5+K+w8DiUaW2YZMFZAwPccm/LDTqRKDuEk3hBos
Y5uTlKFpaUskuJfa7KL4VMgFQyCrfXrA/nWYecDXbiOW7noOfNP6eB2nQF6jl2Y5
stdKiKaGYURkAt0mzw+/UcRLjC+eL7Ku0QAgbUPgODXsExl0z1L5BtBW1LTBTgvy
NuberjwLb6J4Ytwv+n/VKb2uQ0w2czISBSXkC9/Yccc03Ztx25s6fvJbkkKYIkIv
1N2vV2TVr1Dq/NO76N6WWrQ1zU4PFBcW1yIFyNHpagyNve/v81g+fXt7SONnvOSh
lacqG+/v7rG7hPJVKYTFUXeIS5RGBey1MFYbl5syu5AY0jSHEsV8SenGB6TTynj4
dNor2X7E16IzEc7R/OANslwZbHFCqRN+vMf/DbAyPVBsjt05TAM5oiAI6TVoChVB
2m6zJsLBfAQYAQoAJgIbIBYhBNKfgqqf1Z1udLFjcAie2z0jCiQEBQJk904iBQkM
wCB3AAoJEAie2z0jCiQEVG0P/RR8EoldJeUkIoDfokspN1CVOCKRPYBmAROhR/tb
q5MnPkM72mKvazLc0nozbXp5DfAsUMOUvbvH0woaDNYGomdWoD3J0UMpB1mAsTzd
YygZ0h80psBQjpw3Kk6TuT+GO/aFxZ13VVDJ+d5HJ7vGhl6Fjahqua95jMXfHZk2
Kry2emZD1HUmbErDiqFiqXXgmrXJIV/pE6uCtUgdKX/uSUJDl20MyINBbD2gTmSN
svww1eoutX+WeuLLYD6x/mahDOZraegGVnTao+soXPYj/HCnMWRTgzD8sA4JYHc4
fAHYtcL2L1wE94B87+FN4kKergciZYDLkGjJDhLNDn+obJn6Ig7Yb/1UpGq9ohxw
TZOZ896pv5Ty7G+dyonJAMLMYCg8KCQt0dMwmOZdNcJtQTngXaCzYWrrbBA1TfWn
7rl8Q5JXTwzB+T88AgT1ZtLveXCylsurzRyt+x0yxYLBW2IzzmlKVUjGLaBryqQX
RO197peeuYeIfMCSPot0sjrce0Iq+i9oY9Dg8jUfWbI8nNq8nAube57Mr51SQ7yd
g/uXk49lH2QJHYLLlVmb8R8AxJz86G0pG/19p4+V8Wgf1tuHAHOr/JDE5qwUBWrC
IQxnLTwcpewhYAcr7C+eUYfPbpJGtLRjZ8A6ZDDSGBl/RW9l8nLvGeAGluktNty+
Vqe5
=3DyU6p
-----END PGP PUBLIC KEY BLOCK-----

--------------Hri04u3lpPeO7vSzIN1f0VXx--

--------------Q3q2X02wf6HvDpSltpEYOKwz--

--------------nCo60dVik7aBU7Jbp1qiE6nQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE0p+Cqp/VnW50sWNwCJ7bPSMKJAQFAmXnDDsFAwAAAAAACgkQCJ7bPSMKJARz
XQ//Y0cCn4pBTOhliubQH9n5dnjN63xpMFHesZ4ljXqrOoesl1/sjQaiAgGURJDSAPO5edJPP5to
dtNXM2qb9PLuZg0fRomc7dr2gvqO7Nm19aZrWLDMSyAR3i7rplCCjrqnefrsX3q0eTxzeXSi3nVj
oEmMaUP67XiXxJe8sHHrmnzrHbA/k5AWqwGFo5zJ+qV3Xf68/J4+8kKix1l4Jy7XaUWC3/fYXTi+
EM0RmJQ1E+VRnOsbBau+6DGkLGJqzw0tn9RCDmtnwuo4exQICUgpPmKUQKPX+ni/2XkBbj0sy5uS
16fcpgSW3YpfjTsUq6uedm8i0f08cziFqgRVgkzs6bSjUoNFBTBmbjPQQjwHfLNzPq4H8uTZgF7g
hWq6KYdAQhR5hpZRgKMZmNmjqWvZKh1LY8SPi/SWUJ9RFM9trNJrjq/f32V85dbnWhF+X1RfwQZL
oGkQf6fSiPz6XP8LmrN33Zuhc+j4seowgYjD/oN112DKQzt+I8YPX2+z7u9Te3SrT1XIDBFOt4cM
alMTI7+L/INMB746nM/uVpXuWMWh5HDctswidetrtC5OmNDkc734INGrcOp/VbX3sLzD/NSVuHa2
ZNc7maElKTX5t0G03hwy80eqHhugx95gv6+i4zZEPr2aJVstgGY89DwXy2AG3U/KNi2IMXOdx4UF
u70=
=W63/
-----END PGP SIGNATURE-----

--------------nCo60dVik7aBU7Jbp1qiE6nQ--

