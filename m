Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5FB802C23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjLDHfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjLDHfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:35:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17189100
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 23:35:58 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DDE71FE4F;
        Mon,  4 Dec 2023 07:35:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 783A3139AA;
        Mon,  4 Dec 2023 07:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id WYwOHFyBbWUYFAAAD6G6ig
        (envelope-from <jgross@suse.com>); Mon, 04 Dec 2023 07:35:56 +0000
Message-ID: <75dcf0e7-e54d-48db-a420-3c731b6f77d8@suse.com>
Date:   Mon, 4 Dec 2023 08:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/xen/manage.c:337:60: warning: '%s' directive output may
 be truncated writing up to 95 bytes into a region of size 12
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paul Durrant <paul.durrant@citrix.com>
References: <202312040309.sACmAKoo-lkp@intel.com>
From:   Juergen Gross <jgross@suse.com>
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
In-Reply-To: <202312040309.sACmAKoo-lkp@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HUwxT4rxyu4FsVhLKGZE89za"
X-Spamd-Bar: +++++++++++++++++++++
X-Spam-Score: 21.40
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=fail (smtp-out2.suse.de: domain of jgross@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=jgross@suse.com;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 9DDE71FE4F
X-Spamd-Result: default: False [21.40 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         TO_DN_SOME(0.00)[];
         HAS_ATTACHMENT(0.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         MIME_BASE64_TEXT(0.10)[];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         BAYES_HAM(-3.00)[100.00%];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_UNKNOWN(0.10)[application/pgp-keys];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM_SHORT(2.90)[0.968];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         NEURAL_SPAM_LONG(3.50)[1.000];
         DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HUwxT4rxyu4FsVhLKGZE89za
Content-Type: multipart/mixed; boundary="------------9WrxEBpDATK2d71xcKZD91NR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Paul Durrant <paul.durrant@citrix.com>
Message-ID: <75dcf0e7-e54d-48db-a420-3c731b6f77d8@suse.com>
Subject: Re: drivers/xen/manage.c:337:60: warning: '%s' directive output may
 be truncated writing up to 95 bytes into a region of size 12
References: <202312040309.sACmAKoo-lkp@intel.com>
In-Reply-To: <202312040309.sACmAKoo-lkp@intel.com>

--------------9WrxEBpDATK2d71xcKZD91NR
Content-Type: multipart/mixed; boundary="------------ShG7FAAPXiK4CSnH4pv2dRaT"

--------------ShG7FAAPXiK4CSnH4pv2dRaT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMTIuMjMgMjA6NTUsIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOg0KPiBIaSBKdWVy
Z2VuLA0KPiANCj4gRllJLCB0aGUgZXJyb3Ivd2FybmluZyBzdGlsbCByZW1haW5zLg0KPiAN
Cj4gdHJlZTogICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQgbWFzdGVyDQo+IGhlYWQ6ICAgMzNjYzkzOGU2NWE5
OGYxZDI5ZDBhMTg0MDNkYmJlZTA1MGRjYWQ5YQ0KPiBjb21taXQ6IDQ0YjNjN2FmMDJjYTI3
MDFiNmI5MGVlMzBjOWQxZDljM2FlMDc2NTMgeGVuYnVzOiBhZHZlcnRpc2UgY29udHJvbCBm
ZWF0dXJlIGZsYWdzDQo+IGRhdGU6ICAgNyB5ZWFycyBhZ28NCj4gY29uZmlnOiB4ODZfNjQt
cmFuZGNvbmZpZy0wMTUtMjAyMzEwMDkgKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXkt
Y2kvYXJjaGl2ZS8yMDIzMTIwNC8yMDIzMTIwNDAzMDkuc0FDbUFLb28tbGtwQGludGVsLmNv
bS9jb25maWcpDQo+IGNvbXBpbGVyOiBnY2MtMTIgKERlYmlhbiAxMi4yLjAtMTQpIDEyLjIu
MA0KPiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOiAoaHR0cHM6Ly9kb3dubG9h
ZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjMxMjA0LzIwMjMxMjA0MDMwOS5zQUNtQUtv
by1sa3BAaW50ZWwuY29tL3JlcHJvZHVjZSkNCj4gDQo+IElmIHlvdSBmaXggdGhlIGlzc3Vl
IGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEgbmV3IHZlcnNp
b24gb2YNCj4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBmb2xsb3dpbmcg
dGFncw0KPiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNv
bT4NCj4gfCBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwv
MjAyMzEyMDQwMzA5LnNBQ21BS29vLWxrcEBpbnRlbC5jb20vDQo+IA0KPiBBbGwgd2Fybmlu
Z3MgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ICAgICBJbiBmaWxlIGluY2x1
ZGVkIGZyb20gaW5jbHVkZS9saW51eC9rb2JqZWN0Lmg6MjEsDQo+ICAgICAgICAgICAgICAg
ICAgICAgIGZyb20gaW5jbHVkZS9saW51eC9kZXZpY2UuaDoxNywNCj4gICAgICAgICAgICAg
ICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L25vZGUuaDoxNywNCj4gICAgICAgICAgICAg
ICAgICAgICAgZnJvbSBpbmNsdWRlL2xpbnV4L2NwdS5oOjE2LA0KPiAgICAgICAgICAgICAg
ICAgICAgICBmcm9tIGluY2x1ZGUvbGludXgvc3RvcF9tYWNoaW5lLmg6NCwNCj4gICAgICAg
ICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL3hlbi9tYW5hZ2UuYzoxMjoNCj4gICAgIGlu
Y2x1ZGUvbGludXgvc3lzZnMuaDogSW4gZnVuY3Rpb24gJ3N5c2ZzX2dldF9kaXJlbnQnOg0K
PiAgICAgaW5jbHVkZS9saW51eC9zeXNmcy5oOjUxNzo0NDogd2FybmluZzogcG9pbnRlciB0
YXJnZXRzIGluIHBhc3NpbmcgYXJndW1lbnQgMiBvZiAna2VybmZzX2ZpbmRfYW5kX2dldCcg
ZGlmZmVyIGluIHNpZ25lZG5lc3MgWy1XcG9pbnRlci1zaWduXQ0KPiAgICAgICA1MTcgfCAg
ICAgICAgIHJldHVybiBrZXJuZnNfZmluZF9hbmRfZ2V0KHBhcmVudCwgbmFtZSk7DQo+ICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+DQo+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8DQo+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCB1bnNpZ25lZCBjaGFyICoNCj4gICAgIEluIGZpbGUgaW5j
bHVkZWQgZnJvbSBpbmNsdWRlL2xpbnV4L3N5c2ZzLmg6MTU6DQo+ICAgICBpbmNsdWRlL2xp
bnV4L2tlcm5mcy5oOjQ0MDo1Nzogbm90ZTogZXhwZWN0ZWQgJ2NvbnN0IGNoYXIgKicgYnV0
IGFyZ3VtZW50IGlzIG9mIHR5cGUgJ2NvbnN0IHVuc2lnbmVkIGNoYXIgKicNCj4gICAgICAg
NDQwIHwga2VybmZzX2ZpbmRfYW5kX2dldChzdHJ1Y3Qga2VybmZzX25vZGUgKmtuLCBjb25z
dCBjaGFyICpuYW1lKQ0KPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fl5+fn4NCj4gICAgIGRyaXZlcnMveGVu
L21hbmFnZS5jOiBJbiBmdW5jdGlvbiAnc2h1dGRvd25fZXZlbnQnOg0KPj4+IGRyaXZlcnMv
eGVuL21hbmFnZS5jOjMzNzo2MDogd2FybmluZzogJyVzJyBkaXJlY3RpdmUgb3V0cHV0IG1h
eSBiZSB0cnVuY2F0ZWQgd3JpdGluZyB1cCB0byA5NSBieXRlcyBpbnRvIGEgcmVnaW9uIG9m
IHNpemUgMTIgWy1XZm9ybWF0LXRydW5jYXRpb249XQ0KPiAgICAgICAzMzcgfCAgICAgICAg
ICAgICAgICAgc25wcmludGYobm9kZSwgRkVBVFVSRV9QQVRIX1NJWkUsICJmZWF0dXJlLSVz
IiwNCj4gICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBefg0KPiAgICAgSW4gZnVuY3Rpb24gJ3NldHVwX3No
dXRkb3duX3dhdGNoZXInLA0KPiAgICAgICAgIGlubGluZWQgZnJvbSAnc2h1dGRvd25fZXZl
bnQnIGF0IGRyaXZlcnMveGVuL21hbmFnZS5jOjM0OToyOg0KPiAgICAgZHJpdmVycy94ZW4v
bWFuYWdlLmM6MzM3OjE3OiBub3RlOiAnc25wcmludGYnIG91dHB1dCBiZXR3ZWVuIDkgYW5k
IDEwNCBieXRlcyBpbnRvIGEgZGVzdGluYXRpb24gb2Ygc2l6ZSAyMA0KPiAgICAgICAzMzcg
fCAgICAgICAgICAgICAgICAgc25wcmludGYobm9kZSwgRkVBVFVSRV9QQVRIX1NJWkUsICJm
ZWF0dXJlLSVzIiwNCj4gICAgICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAgIDMzOCB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICBzaHV0ZG93bl9oYW5kbGVyc1tpZHhdLmNvbW1hbmQp
Ow0KPiAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fg0KDQpJTUhPIHRoaXMgaXMgYSBmYWxzZSBhbmFseXNpcy4N
Cg0Kc2h1dGRvd25faGFuZGxlcnNbXSBpczoNCg0Kc3RydWN0IHNodXRkb3duX2hhbmRsZXIg
ew0KI2RlZmluZSBTSFVURE9XTl9DTURfU0laRSAxMQ0KICAgICAgICAgY29uc3QgY2hhciBj
b21tYW5kW1NIVVRET1dOX0NNRF9TSVpFXTsNCiAgICAgICAgIGJvb2wgZmxhZzsNCiAgICAg
ICAgIHZvaWQgKCpjYikodm9pZCk7DQp9Ow0KDQpzdGF0aWMgc3RydWN0IHNodXRkb3duX2hh
bmRsZXIgc2h1dGRvd25faGFuZGxlcnNbXSA9IHsNCiAgICAgICAgIHsgInBvd2Vyb2ZmIiwg
ICB0cnVlLCAgIGRvX3Bvd2Vyb2ZmIH0sDQogICAgICAgICB7ICJoYWx0IiwgICAgICAgZmFs
c2UsICBkb19wb3dlcm9mZiB9LA0KICAgICAgICAgeyAicmVib290IiwgICAgIHRydWUsICAg
ZG9fcmVib290ICAgfSwNCiNpZmRlZiBDT05GSUdfSElCRVJOQVRFX0NBTExCQUNLUw0KICAg
ICAgICAgeyAic3VzcGVuZCIsICAgIHRydWUsICAgZG9fc3VzcGVuZCAgfSwNCiNlbmRpZg0K
fTsNCg0KQW5kIGl0IGlzIG5ldmVyIGNoYW5nZWQuDQoNCldlIGhhdmU6DQoNCiNkZWZpbmUg
RkVBVFVSRV9QQVRIX1NJWkUgKFNIVVRET1dOX0NNRF9TSVpFICsgc2l6ZW9mKCJmZWF0dXJl
LSIpKQ0KICAgICAgICAgY2hhciBub2RlW0ZFQVRVUkVfUEFUSF9TSVpFXTsNCg0KU28gaG93
IG9uIGVhcnRoIGNvdWxkIHRoZSBzbnByaW50ZigpIGRlc3RpbmF0aW9uIG5vdCBiZSBsYXJn
ZSBlbm91Z2g/DQoNCj4gdmltICszMzcgZHJpdmVycy94ZW4vbWFuYWdlLmMNCj4gDQo+ICAg
ICAzMzMJDQo+ICAgICAzMzQJCWZvciAoaWR4ID0gMDsgaWR4IDwgQVJSQVlfU0laRShzaHV0
ZG93bl9oYW5kbGVycyk7IGlkeCsrKSB7DQo+ICAgICAzMzUJCQlpZiAoIXNodXRkb3duX2hh
bmRsZXJzW2lkeF0uZmxhZykNCj4gICAgIDMzNgkJCQljb250aW51ZTsNCj4gICA+IDMzNwkJ
CXNucHJpbnRmKG5vZGUsIEZFQVRVUkVfUEFUSF9TSVpFLCAiZmVhdHVyZS0lcyIsDQo+ICAg
ICAzMzgJCQkJIHNodXRkb3duX2hhbmRsZXJzW2lkeF0uY29tbWFuZCk7DQo+ICAgICAzMzkJ
CQl4ZW5idXNfcHJpbnRmKFhCVF9OSUwsICJjb250cm9sIiwgbm9kZSwgIiV1IiwgMSk7DQo+
ICAgICAzNDAJCX0NCj4gICAgIDM0MQkNCj4gICAgIDM0MgkJcmV0dXJuIDA7DQo+ICAgICAz
NDMJfQ0KPiAgICAgMzQ0CQ0KPiANCg0KDQpKdWVyZ2VuDQo=
--------------ShG7FAAPXiK4CSnH4pv2dRaT
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------ShG7FAAPXiK4CSnH4pv2dRaT--

--------------9WrxEBpDATK2d71xcKZD91NR--

--------------HUwxT4rxyu4FsVhLKGZE89za
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVtgVwFAwAAAAAACgkQsN6d1ii/Ey+6
IAf+P4nLIVf9ovqszkHI3ubj5jlKhdorS7GUI75EGQThXng83TIWpRa/3wFgcLRUl4HAFTQrSrxs
ysp3IDJoslHfmntmjZTXP2gQRhXi8SYC6+QYAGTulA2UC+72cC6HemJL0knrRUT5S5he2fnRRNt1
eLJ3r5m88AyR2nPN80OxS6YvZWMtoW8YWRum74vrBImUp355E0THeb9y/ov3eSnECmDPW0TJa+dZ
7O312z38VsF7T9US0Jj4/XQn+LwfDlR0uzTVYMglNAJQRJ9pTw3qUCFTVcnCoOBtSW1yOhmbcl4W
NFUYSOaKO5gfNCMTBE1jWCItwblLp+tC6ySw2voSmw==
=MGth
-----END PGP SIGNATURE-----

--------------HUwxT4rxyu4FsVhLKGZE89za--
