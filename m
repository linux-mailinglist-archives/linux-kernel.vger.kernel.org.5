Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E340751E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjGMKHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjGMKHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:07:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3522D7B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:06:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 96AF022190;
        Thu, 13 Jul 2023 10:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689242808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mk56FONtOowVALN0q21XBKEQINE8MoiVbx53HrUlPjU=;
        b=TEADc15/9oH2caOSex97zxH9ktqYsbZ2wFXgQz0Q6IxEpgUqmqpGEa1ar1iEuf5qc+YOAt
        WrrlrPT2fJTPkBrwQYm0+0a+Hoeraz9Owk/wdysYNs/ziw3qqeiiNnPXwgwj4wOuiYyDhl
        f+BTZwRmU1AUqVkzr7JN8oKaIRR35L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689242808;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mk56FONtOowVALN0q21XBKEQINE8MoiVbx53HrUlPjU=;
        b=kwqXlxu+JQc2kTNAsX3PVteoF4/HE2c0tkvaAX4qjsMfJoP9omU8WS8nPyjlGjO0U+33mC
        gTKGqcACJu0Wt+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B4DE133D6;
        Thu, 13 Jul 2023 10:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JmULHbjMr2TWYAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 13 Jul 2023 10:06:48 +0000
Message-ID: <340afb94-9c08-46ef-0514-9da52162b45c@suse.de>
Date:   Thu, 13 Jul 2023 12:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/ssd130x: Change pixel format used to compute the
 buffer size
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20230713085859.907127-1-javierm@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230713085859.907127-1-javierm@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GUEY8WDKKNuJNWEUMZsZV4cn"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GUEY8WDKKNuJNWEUMZsZV4cn
Content-Type: multipart/mixed; boundary="------------rY40G7UYCo0b9nL9RwG30f0W";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <340afb94-9c08-46ef-0514-9da52162b45c@suse.de>
Subject: Re: [PATCH] drm/ssd130x: Change pixel format used to compute the
 buffer size
References: <20230713085859.907127-1-javierm@redhat.com>
In-Reply-To: <20230713085859.907127-1-javierm@redhat.com>

--------------rY40G7UYCo0b9nL9RwG30f0W
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQoNCkFtIDEzLjA3LjIzIHVtIDEwOjU4IHNjaHJpZWIgSmF2aWVyIE1hcnRpbmV6IENhbmls
bGFzOg0KPiBUaGUgY29tbWl0IGUyNTRiNTg0ZGJjMCAoImRybS9zc2QxMzB4OiBSZW1vdmUg
aGFyZGNvZGVkIGJpdHMtcGVyLXBpeGVsIGluDQo+IHNzZDEzMHhfYnVmX2FsbG9jKCkiKSB1
c2VkIGEgcGl4ZWwgZm9ybWF0IGluZm8gaW5zdGVhZCBvZiBhIGhhcmRjb2RlZCBicHANCj4g
dG8gY2FsY3VsYXRlIHRoZSBzaXplIG9mIHRoZSBidWZmZXIgYWxsb2NhdGVkIHRvIHN0b3Jl
IHRoZSBuYXRpdmUgcGl4ZWxzLg0KPiANCj4gQnV0IHRoYXQgd3JvbmdseSB1c2VkIHRoZSBE
Uk1fRk9STUFUX0MxIGZvdXJjYyBwaXhlbCBmb3JtYXQsIHdoaWNoIGlzIGZvcg0KPiBjb2xv
ci1pbmRleGVkIGZyYW1lIGJ1ZmZlciBmb3JtYXRzLiBXaGlsZSB0aGUgc3NkMTAzeCBjb250
cm9sbGVycyBkb24ndA0KPiBzdXBwb3J0IGRpZmZlcmVudCBzaW5nbGUtY2hhbm5lbCBjb2xv
cnMgbm9yIGEgQ29sb3IgTG9va3VwIFRhYmxlIChDTFVUKS4NCg0KTWFrZXMgc2Vuc2UgdG8g
bWUuDQoNClJldmlld2VkLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3Vz
ZS5kZT4NCg0KPiANCj4gQm90aCBmb3JtYXRzIHVzZSBlaWdodCBwaXhlbHMvYnl0ZSwgc28g
aW4gcHJhY3RpY2UgdGhlcmUgaXMgbm8gZnVuY3Rpb25hbA0KPiBjaGFuZ2VzIGluIHRoaXMg
cGF0Y2guIEJ1dCBzdGlsbCB0aGUgY29ycmVjdCBwaXhlbCBmb3JtYXQgc2hvdWxkIGJlIHVz
ZWQuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGlu
dXgtbTY4ay5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEphdmllciBNYXJ0aW5leiBDYW5pbGxh
cyA8amF2aWVybUByZWRoYXQuY29tPg0KPiAtLS0NCj4gDQo+ICAgZHJpdmVycy9ncHUvZHJt
L3NvbG9tb24vc3NkMTMweC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9zb2xvbW9uL3NzZDEzMHguYyBiL2RyaXZlcnMvZ3B1L2RybS9zb2xvbW9uL3NzZDEz
MHguYw0KPiBpbmRleCBiM2RjMWNhOWRjMTAuLmFmYjA4YThhYTlmYyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL3NvbG9tb24vc3NkMTMweC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9zb2xvbW9uL3NzZDEzMHguYw0KPiBAQCAtMTUzLDcgKzE1Myw3IEBAIHN0YXRp
YyBpbnQgc3NkMTMweF9idWZfYWxsb2Moc3RydWN0IHNzZDEzMHhfZGV2aWNlICpzc2QxMzB4
KQ0KPiAgIAljb25zdCBzdHJ1Y3QgZHJtX2Zvcm1hdF9pbmZvICpmaTsNCj4gICAJdW5zaWdu
ZWQgaW50IHBpdGNoOw0KPiAgIA0KPiAtCWZpID0gZHJtX2Zvcm1hdF9pbmZvKERSTV9GT1JN
QVRfQzEpOw0KPiArCWZpID0gZHJtX2Zvcm1hdF9pbmZvKERSTV9GT1JNQVRfUjEpOw0KPiAg
IAlpZiAoIWZpKQ0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgDQoNCi0tIA0KVGhvbWFz
IFppbW1lcm1hbm4NCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdlcm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVy
bmJlcmcsIEdlcm1hbnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1j
RG9uYWxkLCBCb3VkaWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------rY40G7UYCo0b9nL9RwG30f0W--

--------------GUEY8WDKKNuJNWEUMZsZV4cn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmSvzLcFAwAAAAAACgkQlh/E3EQov+C2
kw//dNy31ZIyF5ZLCm8ZWvlyDralfrHhgmI+96z6bwouUwZxr1Tcm81aPBMF83sq3UMBZqy05+jo
P31AXYVNnLE8+PhFUMKjKr1Dc0/xD043qAju3CJ7xTH82NwE1duBZIqbpUc0tHjxImFvWCjrkAYQ
j8glIC9D9XZY2XG/g2Qag9PYF7Kzf2jLKge6l1UddNiHTsGJkpP4gJ1dNzLhAHdAAMPwBVjkp7dN
AZQFZipK43Qe7gOcN6ORGKDc9kb+L3YRUTgZjqceP2QWEL+YHeUhOOt1lxvIoiQhRUF/mvjgojkb
JYWgO+qzwFuZ4nActcV6AFoHVTv7b/PA6b56qY4Og8bbwdxLIP49vJZDrRC9JqZS45t5oJJ4LRTb
K0in7M10RcX715sRLGmePtR40ynZbHl4mloBue2Wn/c6Yr7RMCinxLBNv4cqseqZ3UKbGOMUbDTl
w8xfdbPldy1BLuB8f2Jwutbf8rOz+OSwp2vCQhXJJGkqQ0fEgilp4n2pkAXXPYPBioOJ6rYpsuLi
HBQ/P2hDZJXf3kSYXlrUGtIFU1pkkdCX7W45G29Ny8tBzmLFQCYRJ4nPqcYutjDbgcaQSu5JHPte
2xyFRN0IYs65agiaJuF8LTjZ2AqB2U2w4sSunDjQGBB+Iur7y0sWQB9ARCH1kRysNxgdb57uy/w2
PQg=
=J7qb
-----END PGP SIGNATURE-----

--------------GUEY8WDKKNuJNWEUMZsZV4cn--
