Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E498C7911C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350391AbjIDHIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjIDHIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:08:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6FB99;
        Mon,  4 Sep 2023 00:08:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 395A01F38C;
        Mon,  4 Sep 2023 07:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693811312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HN6EAXiXtxK53ELliZ/I3OObmsbbWxvsDpEmf4FSyjU=;
        b=C+VzKQDYxjyawOvW1ggxm7yIeLPbg0BX6lCqXY1qmrrPNs2W14R6zBMJLcKpE9cJZyx1Xv
        wJeACv1PfyGTIFZQNl2RgbjsreGrNm7Ja1mjOr2MZfVlJ+8HxY+smO9Ej+Zs+RmfBVeAA2
        rosP2wh3bQDyvyz6hnrfe/K4Ls6PCpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693811312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HN6EAXiXtxK53ELliZ/I3OObmsbbWxvsDpEmf4FSyjU=;
        b=uwsbNLZ3pgi+98w2jq5XTseCiBHyErsJt9uH01IuglfrGET3ORoJPmcRRNTdb08XXTAQGw
        l8bD6vouoqJA3EAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17FE313425;
        Mon,  4 Sep 2023 07:08:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4cn6BHCC9WTVMAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 04 Sep 2023 07:08:32 +0000
Message-ID: <a0f9f34f-0c4f-9fc8-83ef-899a8f368529@suse.de>
Date:   Mon, 4 Sep 2023 09:08:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/7] fbdev/core: Build fb_logo iff CONFIG_LOGO has been
 selected
To:     Helge Deller <deller@gmx.de>, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-6-tzimmermann@suse.de>
 <bf8e8402-2def-a365-18be-3b426cb1830a@gmx.de>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <bf8e8402-2def-a365-18be-3b426cb1830a@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pd7PqXGGEaPC0OKsNZHAlKzn"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pd7PqXGGEaPC0OKsNZHAlKzn
Content-Type: multipart/mixed; boundary="------------ghjLI64S1U5t0AqW2MfxJkbE";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Helge Deller <deller@gmx.de>, daniel@ffwll.ch, javierm@redhat.com,
 sam@ravnborg.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <a0f9f34f-0c4f-9fc8-83ef-899a8f368529@suse.de>
Subject: Re: [PATCH 5/7] fbdev/core: Build fb_logo iff CONFIG_LOGO has been
 selected
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-6-tzimmermann@suse.de>
 <bf8e8402-2def-a365-18be-3b426cb1830a@gmx.de>
In-Reply-To: <bf8e8402-2def-a365-18be-3b426cb1830a@gmx.de>

--------------ghjLI64S1U5t0AqW2MfxJkbE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDEuMDkuMjMgdW0gMTA6MjIgc2NocmllYiBIZWxnZSBEZWxsZXI6DQo+IE9u
IDgvMjkvMjMgMTY6MTUsIFRob21hcyBaaW1tZXJtYW5uIHdyb3RlOg0KPj4gT25seSBidWls
ZCBmYl9sb2dvLmMgaWYgQ09ORklHX0xPR08gaGFzIGJlZW4gc2VsZWN0ZWQuIE90aGVyd2lz
ZQ0KPj4gcHJvdmlkZSBlbXB0eSBpbXBsZW1lbnRhdGlvbnMgb2YgdGhlIGNvbnRhaW5lZCBp
bnRlcmZhY2VzIGFuZCBhdm9pZA0KPj4gdXNpbmcgdGhlIGV4cG9ydGVkIHZhcmlhYmxlcy4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4NCj4gLi4uDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9j
b3JlL2ZiY29uLmMgDQo+PiBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYmNvbi5jDQo+
PiBpbmRleCBmMTU3YTVhMWRmZmMuLjI0YjAzODUxMGE3MSAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvdmlkZW8vZmJkZXYvY29yZS9mYmNvbi5jDQo+PiArKysgYi9kcml2ZXJzL3ZpZGVv
L2ZiZGV2L2NvcmUvZmJjb24uYw0KPj4gQEAgLTQ3NCwxNSArNDc0LDE5IEBAIHN0YXRpYyBp
bnQgX19pbml0IGZiX2NvbnNvbGVfc2V0dXAoY2hhciAqdGhpc19vcHQpDQo+Pg0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIGlmICghc3RybmNtcChvcHRpb25zLCAibG9nby1wb3M6IiwgOSkp
IHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wdGlvbnMgKz0gOTsNCj4+ICsj
aWZkZWYgQ09ORklHX0xPR08NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICgh
c3RyY21wKG9wdGlvbnMsICJjZW50ZXIiKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZmJfY2VudGVyX2xvZ28gPSB0cnVlOw0KPj4gKyNlbmRpZg0KPiANCj4g
SU1ITywgKnNvbWV0aW1lcyogaXQgbWFrZXMgc2Vuc2UgdG8gbm90IHVzZSAjaWZkZWYgYW5k
IGNvZGUgaXQgaW5zdGVhZCANCj4gbGlrZSB0aGlzOg0KPiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKElTX0VOQUJMRUQoQ09ORklHX0xPR08pICYmDQo+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgIXN0cmNtcChvcHRpb25zLCAiY2VudGVyIikpDQo+IC4u
Lg0KPiBUaGF0IHdheSB0aGUgY29tcGlsZXIgd2lsbCBvcHRpbWl6ZSB0aGF0IGNvZGUgYXdh
eSBhcyB3ZWxsLCBidXQgaW4NCj4gYWRkaXRpb24gaXQgd2lsbCBjb21waWxlLWNoZWNrIHRo
YXQgeW91IGhhdmUgY29ycmVjdCBjb2RpbmcgaW5kZXBlbmRlbmQNCj4gaWYgQ09ORklHX0xP
R08gaXMgc2V0IG9yIG5vdC4NCg0KR29vZCBpZGVhLiBJJ2xsIGNoYW5nZSBpdC4gVGhlIElT
X0VOQUJMRUQgY29kZSBpcyBhbHNvIGVhc2llciB0byByZWFkIElNSE8uDQoNCkJlc3QgcmVn
YXJkcw0KVGhvbWFzDQoNCj4gDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250
aW51ZTsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pg0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGlmICghc3RybmNtcChvcHRpb25zLCAibG9nby1jb3VudDoiLCAxMSkpIHsNCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wdGlvbnMgKz0gMTE7DQo+PiArI2lmZGVmIENP
TkZJR19MT0dPDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoKm9wdGlvbnMp
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZiX2xvZ29fY291bnQg
PSBzaW1wbGVfc3RydG9sKG9wdGlvbnMsICZvcHRpb25zLCAwKTsNCj4+ICsjZW5kaWYNCj4g
DQo+IHNhbWUgaGVyZS4NCj4gDQo+IEhlbGdlDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4N
CkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdl
cm1hbnkgR21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1h
bnkNCkdGOiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3Vk
aWVuIE1vZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------ghjLI64S1U5t0AqW2MfxJkbE--

--------------pd7PqXGGEaPC0OKsNZHAlKzn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmT1gm8FAwAAAAAACgkQlh/E3EQov+AA
sA/7BmZgzg4zEsZIrzwSDLSZMbSbQt+CJ+JI8scnW2vK+ENdlfUXtZJI1uTfKE4NICaN7MkKW+9y
+sl/71+3HhsDrX2vH+4BxCMDg69lPVT35tHqWuvST6GW1sJ0A+/M7Zhm58cYvBznyeCBX2S7se72
TeaTH89hrc7WJUPErUYoggcDLZ+0IXKZ9I1/xp2s2BzZ1pxxbx5Z9nPbG0Bgb7mSREaZ6hni77OY
AM752o6LN0D+qVIZcUqjkjWziNy37/bkVfGWpCiEAC7G1gT4JLMgMQ5tLsu+tfYabEEgDRMY6L6a
hamJazgYwx8LcnlP7KdJtC8rzy7LESdRaOVxRWyG3QINcfVFqOoW+DXJhSqqRHOwNe3y9/ctnbXc
hrNBI0RfjDkKZOX5fOI8G7Xk+eVDESQYTNjO87nRYvB0lWk/YQnV5Lde3hkIbnc6d5z9CtWdEBwe
mnuw55md7oJkjVtqSnTo8P8nyfToh0U0nmbYWL7OfY+yEiDdKFHt7+DK4XvGAfZnlasrai3qvGsO
buiuo5PXXXJvKkT/RVeygdXqwg1tQKSis2SENlbokumsQNXcztDKfAj6IWv/kMOVlmO/mFPoNyEZ
MZC68CpdOQ3u0kGaqNt7nqb5aSHGeah6oYIFNc8h3dOzvRVybfhvQVtMWznjaFZVqffVpCtgvea1
qAI=
=nZE3
-----END PGP SIGNATURE-----

--------------pd7PqXGGEaPC0OKsNZHAlKzn--
