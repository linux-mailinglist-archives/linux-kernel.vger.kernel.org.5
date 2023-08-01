Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07CF76AB8D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjHAI7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHAI7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:59:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27959E7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:59:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DB41821DAE;
        Tue,  1 Aug 2023 08:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690880372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XEEAlM7R3FGpCqDUYUAzzXUDimtVNm3ysYAFzsHH0qQ=;
        b=EZRajF4O8Lx3PwOI1YbG4oV11aqTdSE0Jp2dnMB0sa1X9v6+7lp/rNkvajOLpBQhiGSzvU
        PjlcDoDu83pcCvvRZVncQIW3+duBS6llwKWZvNcBJ30B3LrNxirfENXne7r1w1JbRUAlID
        nhkf42bjNwISU+3O+HM1JVVCMwJEUQU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 881F913919;
        Tue,  1 Aug 2023 08:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nyZvH3TJyGS8NAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 01 Aug 2023 08:59:32 +0000
Message-ID: <aa086365-fd02-210f-67c6-5c9175c0dfee@suse.com>
Date:   Tue, 1 Aug 2023 10:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx> <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
 <f0d5b71b-4344-2f35-03ee-3af6ebd038b2@suse.com> <87o7jrkyjf.ffs@tglx>
 <3af74b7a-be7f-3fdb-396e-e76b8ca1efaf@suse.com> <87il9zkw7h.ffs@tglx>
 <bd5a43b8-c07d-c906-c0ef-ac8b3ae537e2@suse.com> <87bkfrkurl.ffs@tglx>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <87bkfrkurl.ffs@tglx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mfg23V90OvWdxBvIuAX0Unzk"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mfg23V90OvWdxBvIuAX0Unzk
Content-Type: multipart/mixed; boundary="------------1mpDr0yC3Vb9oBgyZvIbxK1g";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <aa086365-fd02-210f-67c6-5c9175c0dfee@suse.com>
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx> <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
 <f0d5b71b-4344-2f35-03ee-3af6ebd038b2@suse.com> <87o7jrkyjf.ffs@tglx>
 <3af74b7a-be7f-3fdb-396e-e76b8ca1efaf@suse.com> <87il9zkw7h.ffs@tglx>
 <bd5a43b8-c07d-c906-c0ef-ac8b3ae537e2@suse.com> <87bkfrkurl.ffs@tglx>
In-Reply-To: <87bkfrkurl.ffs@tglx>

--------------1mpDr0yC3Vb9oBgyZvIbxK1g
Content-Type: multipart/mixed; boundary="------------0MP5iYDb24Q46qnFtKVW03jX"

--------------0MP5iYDb24Q46qnFtKVW03jX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDguMjMgMTA6NTQsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gVHVlLCBB
dWcgMDEgMjAyMyBhdCAxMDoyNSwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IE9uIDAxLjA4
LjIzIDEwOjIzLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+Pj4gT24gVHVlLCBBdWcgMDEg
MjAyMyBhdCAwOTozNywgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+Pj4gT24gMDEuMDguMjMg
MDk6MzIsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+Pj4+IE9uIFR1ZSwgQXVnIDAxIDIw
MjMgYXQgMDk6MDgsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+Pj4gT24gMDEuMDguMjMg
MDg6NDksIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+Pj4gICAgICB2b2lkIF9faW5pdCB4
ZW5faW5pdF9hcGljKHZvaWQpDQo+Pj4+Pj4gICAgICB7DQo+Pj4+Pj4gICAgICAgICAgICAg
eDg2X2FwaWNfb3BzLmlvX2FwaWNfcmVhZCA9IHhlbl9pb19hcGljX3JlYWQ7DQo+Pj4+Pj4g
LSAgICAgICAvKiBPbiBQViBndWVzdHMgdGhlIEFQSUMgQ1BVSUQgYml0IGlzIGRpc2FibGVk
IHNvIG5vbmUgb2YgdGhlDQo+Pj4+Pj4gLSAgICAgICAgKiByb3V0aW5lcyBlbmQgdXAgZXhl
Y3V0aW5nLiAqLw0KPj4+Pj4+IC0gICAgICAgaWYgKCF4ZW5faW5pdGlhbF9kb21haW4oKSkN
Cj4+Pj4+PiAtICAgICAgICAgICAgICAgYXBpY19pbnN0YWxsX2RyaXZlcigmeGVuX3B2X2Fw
aWMpOw0KPj4+Pj4+IC0NCj4+Pj4+PiAgICAgICAgICAgICB4ODZfcGxhdGZvcm0uYXBpY19w
b3N0X2luaXQgPSB4ZW5fYXBpY19jaGVjazsNCj4+Pj4+DQo+Pj4+PiBJIGRvbid0IHRoaW5r
IHRoaXMgb25lIGlzIG5lZWRlZC4NCj4+Pj4NCj4+Pj4gSW5kZWVkLg0KPj4+DQo+Pj4gQ2Fu
IHlvdSBzZW5kIGEgcmVhbCBwYXRjaCBwbGVhc2Ugd2hpY2ggSSBjYW4gYWRkIHRvIHRoYXQg
cGlsZSBhdCB0aGUNCj4+PiByaWdodCBwbGFjZT8NCj4+DQo+PiBJIHRoaW5rIGFkZGluZyBp
dCByaWdodCBhZnRlciBwYXRjaCA1MCBzaG91bGQgYmUgZmluZT8NCj4+DQo+PiBUaGUgV0FS
TigpIHdpbGwgYmUgaXNzdWVkIG9ubHkgd2l0aCBwYXRjaCA1OC4NCj4gDQo+IENvcnJlY3Qu
DQoNCkhlcmUgaXQgaXMuDQoNCg0KSnVlcmdlbg0K
--------------0MP5iYDb24Q46qnFtKVW03jX
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-xen-apic-Use-standard-apic-driver-mechanism-for-.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-xen-apic-Use-standard-apic-driver-mechanism-for-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2NTIwZDFkMjIyNTExZTY3NTg2MmQ1NmZjMDdiMDIwYzFjMzM0ZWJmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
CkRhdGU6IFR1ZSwgMSBBdWcgMjAyMyAxMDo1MDo0MiArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IHg4Ni94ZW4vYXBpYzogVXNlIHN0YW5kYXJkIGFwaWMgZHJpdmVyIG1lY2hhbmlzbSBmb3Ig
WGVuCgpJbnN0ZWFkIG9mIHNldHRpbmcgdGhlIFhlbiBQViBhcGljIGRyaXZlciB2ZXJ5IGVh
cmx5IGR1cmluZyBib290LApqdXN0IHVzZSB0aGUgc3RhbmRhcmQgYXBpYyBkcml2ZXIgcHJv
YmluZyBieSBzZXR0aW5nIGFuIGFwcHJvcHJpYXRlCng4Nl9pbml0LmlycXMuaW50cl9tb2Rl
X2luaXQgY2FsbGJhY2suCgpBdCB0aGUgc2FtZSB0aW1lIGVsaW1pbmF0ZSB4ZW5fYXBpY19j
aGVjaygpIHdoaWNoIGhhcyBuZXZlciBiZWVuIHVzZWQuCgpUaGUgI2lmZGVmIENPTkZJR19Y
ODZfTE9DQUxfQVBJQyBhcm91bmQgdGhlIGNhbGwgb2YgeGVuX2luaXRfYXBpYygpCmNhbiBi
ZSByZW1vdmVkLCB0b28sIGFzIENPTkZJR19YRU4gZGVwZW5kcyBvbiBDT05GSUdfWDg2X0xP
Q0FMX0FQSUMuCgpTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5j
b20+Ci0tLQogYXJjaC94ODYveGVuL2FwaWMuYyAgICAgICAgIHwgMTEgLS0tLS0tLS0tLS0K
IGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYyB8ICA0ICstLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L3hlbi9hcGljLmMgYi9hcmNoL3g4Ni94ZW4vYXBpYy5jCmluZGV4IDE4MzhhZWZjNjMy
Zi4uMzE1ZmZkOGQzNzdmIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni94ZW4vYXBpYy5jCisrKyBi
L2FyY2gveDg2L3hlbi9hcGljLmMKQEAgLTE1OCwxOSArMTU4LDggQEAgc3RhdGljIHN0cnVj
dCBhcGljIHhlbl9wdl9hcGljID0gewogCS5pY3Jfd3JpdGUgCQkJPSB4ZW5fYXBpY19pY3Jf
d3JpdGUsCiB9OwogCi1zdGF0aWMgdm9pZCBfX2luaXQgeGVuX2FwaWNfY2hlY2sodm9pZCkK
LXsKLQlhcGljX2luc3RhbGxfZHJpdmVyKCZ4ZW5fcHZfYXBpYyk7Ci19Ci0KIHZvaWQgX19p
bml0IHhlbl9pbml0X2FwaWModm9pZCkKIHsKIAl4ODZfYXBpY19vcHMuaW9fYXBpY19yZWFk
ID0geGVuX2lvX2FwaWNfcmVhZDsKLQkvKiBPbiBQViBndWVzdHMgdGhlIEFQSUMgQ1BVSUQg
Yml0IGlzIGRpc2FibGVkIHNvIG5vbmUgb2YgdGhlCi0JICogcm91dGluZXMgZW5kIHVwIGV4
ZWN1dGluZy4gKi8KLQlpZiAoIXhlbl9pbml0aWFsX2RvbWFpbigpKQotCQlhcGljX2luc3Rh
bGxfZHJpdmVyKCZ4ZW5fcHZfYXBpYyk7Ci0KLQl4ODZfcGxhdGZvcm0uYXBpY19wb3N0X2lu
aXQgPSB4ZW5fYXBpY19jaGVjazsKIH0KIGFwaWNfZHJpdmVyKHhlbl9wdl9hcGljKTsKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYyBiL2FyY2gveDg2L3hlbi9l
bmxpZ2h0ZW5fcHYuYwppbmRleCA5M2I2NTgyNDhkMDEuLmMzOTNjNDQ4OTJhYyAxMDA2NDQK
LS0tIGEvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdi5jCisrKyBiL2FyY2gveDg2L3hlbi9l
bmxpZ2h0ZW5fcHYuYwpAQCAtMTMyNiw3ICsxMzI2LDcgQEAgYXNtbGlua2FnZSBfX3Zpc2li
bGUgdm9pZCBfX2luaXQgeGVuX3N0YXJ0X2tlcm5lbChzdHJ1Y3Qgc3RhcnRfaW5mbyAqc2kp
CiAKIAl4ODZfaW5pdC5yZXNvdXJjZXMubWVtb3J5X3NldHVwID0geGVuX21lbW9yeV9zZXR1
cDsKIAl4ODZfaW5pdC5pcnFzLmludHJfbW9kZV9zZWxlY3QJPSB4ODZfaW5pdF9ub29wOwot
CXg4Nl9pbml0LmlycXMuaW50cl9tb2RlX2luaXQJPSB4ODZfaW5pdF9ub29wOworCXg4Nl9p
bml0LmlycXMuaW50cl9tb2RlX2luaXQJPSB4ODZfNjRfcHJvYmVfYXBpYzsKIAl4ODZfaW5p
dC5vZW0uYXJjaF9zZXR1cCA9IHhlbl9hcmNoX3NldHVwOwogCXg4Nl9pbml0Lm9lbS5iYW5u
ZXIgPSB4ZW5fYmFubmVyOwogCXg4Nl9pbml0Lmh5cGVyLmluaXRfcGxhdGZvcm0gPSB4ZW5f
cHZfaW5pdF9wbGF0Zm9ybTsKQEAgLTEzNjYsMTIgKzEzNjYsMTAgQEAgYXNtbGlua2FnZSBf
X3Zpc2libGUgdm9pZCBfX2luaXQgeGVuX3N0YXJ0X2tlcm5lbChzdHJ1Y3Qgc3RhcnRfaW5m
byAqc2kpCiAKIAl4ZW5faW5pdF9jYXBhYmlsaXRpZXMoKTsKIAotI2lmZGVmIENPTkZJR19Y
ODZfTE9DQUxfQVBJQwogCS8qCiAJICogc2V0IHVwIHRoZSBiYXNpYyBhcGljIG9wcy4KIAkg
Ki8KIAl4ZW5faW5pdF9hcGljKCk7Ci0jZW5kaWYKIAogCW1hY2hpbmVfb3BzID0geGVuX21h
Y2hpbmVfb3BzOwogCi0tIAoyLjM1LjMKCg==
--------------0MP5iYDb24Q46qnFtKVW03jX
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------0MP5iYDb24Q46qnFtKVW03jX--

--------------1mpDr0yC3Vb9oBgyZvIbxK1g--

--------------mfg23V90OvWdxBvIuAX0Unzk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTIyXMFAwAAAAAACgkQsN6d1ii/Ey/q
FAf/cG+lq5ELk0lDbxD5NgY+EgBquf42Q2lG6O2OVx4Ayb/F/AoMgCmvogWUfKqLTOaVu2w96kjI
GslTefFdYZlIzBWe6joXUMDckI5mat1RbJFPjcNi5b4yKaQpJENXwNO08azGkmfIrfsFYVYr7fdr
KotQ3cnjm1f2vF+iuUkPsRBJalsJP7M+EY+rf73tov2IcDnAMzPoMrtkXmUtWxSQTZ4jdWsK+7dL
2OKRT1ywFSwFFFGl5sqsI2C9jrOUQZSyMrFAg9/NLgAGREnuuoGrHaUV2wO/2xD93dcmuImYZAtI
9YrxBQA+FNZn4Yga9bzzNSZ4zDHboV8xPkZHtOmc4Q==
=d26w
-----END PGP SIGNATURE-----

--------------mfg23V90OvWdxBvIuAX0Unzk--
