Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAB87DF3BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376447AbjKBN1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347433AbjKBN1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:27:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38A134
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:27:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 552121F8C8;
        Thu,  2 Nov 2023 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698931631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=EUI00kHk1pEASxWT/t77wlwkLtFNEEuI43H375AXWmw=;
        b=Um7SAAjieQspsawGq2+OgNadz/lwhbvrX6HDNwfjPcSTkt6waBTovRQEnrXSgFthnstyXf
        7CYJjv6CA/isIpEak84LW5jjQxL2JaGh9l2ZGhrSE0ug/uCP+GdP6dEsG9wowS7ucdGA3E
        hJiCCwOp/sdUm17HZLqurBPJfTv7uQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698931631;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=EUI00kHk1pEASxWT/t77wlwkLtFNEEuI43H375AXWmw=;
        b=nJ3kqwS/9enecldNucPTT5vcxYdCYNHpJkP/BFRv2MmbsmNznQsdicTVB+lZwcJYvZ57yn
        q7l1Y9pysYAnu9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEFA513584;
        Thu,  2 Nov 2023 13:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0uwqLq6jQ2WHawAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 02 Nov 2023 13:27:10 +0000
Message-ID: <40323b1b-b2de-45b2-88f2-d6b440e10f76@suse.de>
Date:   Thu, 2 Nov 2023 14:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu/drm/drm_framebuffer.c: Use Macro instead of actual
 number.
Content-Language: en-US
To:     Peng Hao <penghao@dingdao.com>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231102022946.115603-1-penghao@dingdao.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20231102022946.115603-1-penghao@dingdao.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qqtjeQaXN5AijMGUNtr0H76t"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qqtjeQaXN5AijMGUNtr0H76t
Content-Type: multipart/mixed; boundary="------------iF0PlNLh0PRUFJegCwKJqV0t";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Peng Hao <penghao@dingdao.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <40323b1b-b2de-45b2-88f2-d6b440e10f76@suse.de>
Subject: Re: [PATCH] gpu/drm/drm_framebuffer.c: Use Macro instead of actual
 number.
References: <20231102022946.115603-1-penghao@dingdao.com>
In-Reply-To: <20231102022946.115603-1-penghao@dingdao.com>

--------------iF0PlNLh0PRUFJegCwKJqV0t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMDIuMTEuMjMgdW0gMDM6Mjkgc2NocmllYiBQZW5nIEhhbzoNCj4gVXNlIE1h
Y3JvIERSTV9GT1JNQVRfTUFYX1BMQU5FUyBpbnN0ZWFkIG9mIDQsIHRvIGltcHJvdmUgbW9k
aWZpYWJpbGl0eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBlbmcgSGFvIDxwZW5naGFvQGRp
bmdkYW8uY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vZHJtX2ZyYW1lYnVmZmVy
LmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9mcmFtZWJ1
ZmZlci5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9mcmFtZWJ1ZmZlci5jDQo+IGluZGV4IDJk
ZDk3NDczY2ExMC4uYmYyODNkYWU5MDkwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vZHJtX2ZyYW1lYnVmZmVyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9mcmFt
ZWJ1ZmZlci5jDQo+IEBAIC0yNTQsNyArMjU0LDcgQEAgc3RhdGljIGludCBmcmFtZWJ1ZmZl
cl9jaGVjayhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiAgIAkJfQ0KPiAgIAl9DQo+ICAg
DQo+IC0JZm9yIChpID0gaW5mby0+bnVtX3BsYW5lczsgaSA8IDQ7IGkrKykgew0KPiArCWZv
ciAoaSA9IGluZm8tPm51bV9wbGFuZXM7IGkgPCBEUk1fRk9STUFUX01BWF9QTEFORVM7IGkr
Kykgew0KDQpUaGlzIGNoYW5nZSBtYWtlcyB0aGUgY29kZSBtb3JlIGZyYWdpbGUuICc0JyBp
cyBhIGZpeGVkIGNvbnN0YW50IGluIHRoZSANClVBUEkgc3RydWN0LCB3aGlsZSBEUk1fRk9S
TUFUX01BWF9QTEFORVMgaXMgYW4gaW50ZXJuYWwgY29uc3RhbnQuIEkgDQphZ3JlZSB0aGF0
IGJvdGggc2hvdWxkIHJlYXNvbmFibHkgaGF2ZSB0aGUgc2FtZSB2YWx1ZS4gQnV0IChwb3Rl
bnRpYWxseSkgDQpjaGFuZ2luZyB0aGUgdmFsdWUgb2YgRFJNX0ZPUk1BVF9NQVhfUExBTkVT
IHdpbGwgYnJlYWsgdGhlc2UgbG9vcHMgd2l0aCANCmEgcG9zc2libGUgT09CIGFjY2Vzcy4N
Cg0KVG8gbWFrZSBtYWtlIHRoaXMgY29kZSBtb3JlIHJvYnVzdCwgaXQgbWlnaHQgYmUgYmV0
dGVyIHRvIHJld3JpdGUgdGhlIA0KdGVzdHMgbGlrZSB0aGlzDQoNCmZvciAoaSA9IG51bV9w
bGFuZXM7IGkgPCBBUlJBWV9TSVpFKHItPm1vZGlmaWVyKTsgK2kpIHsNCgkvLyB0aGUgdGVz
dCBmb3IgbW9kaWZpZXJbaV0NCn0NCg0KaWYgKHItPmZsYWdzICYgRFJNX01PREVfRkJfTU9E
SUZJRVJTKSB7DQogIAlmb3IgKGkgPCBBUlJBWV9TSVpFKGhhbmRsZXMpKSB7DQoJCS8vIHRl
c3QgZm9yIGhhbmRsZXNbaV0NCgl9DQogIAlmb3IgKGkgPCBBUlJBWV9TSVpFKHBpdGNoZXMp
KSB7DQoJCS8vIHRlc3QgZm9yIHBpdGNoZXNbaV0NCgl9DQogIAlmb3IgKGkgPCBBUlJBWV9T
SVpFKG9mZnNldHMpKSB7DQoJCS8vIHRlc3QgZm9yIG9mZnNldHNbaV0NCgl9DQp9DQoNCkJl
c3QgcmVnYXJkcw0KVGhvbWFzDQoNCj4gICAJCWlmIChyLT5tb2RpZmllcltpXSkgew0KPiAg
IAkJCWRybV9kYmdfa21zKGRldiwgIm5vbi16ZXJvIG1vZGlmaWVyIGZvciB1bnVzZWQgcGxh
bmUgJWRcbiIsIGkpOw0KPiAgIAkJCXJldHVybiAtRUlOVkFMOw0KDQotLSANClRob21hcyBa
aW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5i
ZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0Rv
bmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------iF0PlNLh0PRUFJegCwKJqV0t--

--------------qqtjeQaXN5AijMGUNtr0H76t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmVDo64FAwAAAAAACgkQlh/E3EQov+Db
MBAAxo3Qo0LlXJMv7Q36dHMS3aGRd6jbCnjBfruE59ijsidTakdNkbeipTXdMi5ZbJfZ82I5vwJ2
EYSB4l2Kz6sylwYfBSGDUcAN/mZ6V/7cBOx/TWF68cHWqTW1MtkmA/KiMJX/gsDjBoYW6eQT/zVy
hawtAycBxuHrAavINEm9gPJKA+FqAvnJeU+smOa8P97YFUgke5re/A3tzqWD9PO9b/QrnMThzNG6
t6Hw7O3y68erl3cgAoKALBwWlAOmcGEnKEdA+M6UuD+ee9k/YxAbKwwEgEs2eUSsf9ywOimvZ/rK
Ar09OMAd3+jW++iqcJ1lhBqZPCgdFfXaWxE2s4Nc5Oq36WdloOhjqQTeCV3tJD4HzQV3wzGlwhk0
OiI0FjWrMnQ5fO18pj1bB8OybCnbH6TIWR37KAxav/nMmNvGaWtgWp61ELpHXPlXnpoxJ3PVcQnn
vpblhhE630d/Jz32A1gTkl4m++m9gV2M82wDGHfF6GQUtAKLORjSXw2AWP7fnSQ5ywpKbtAFW+oG
mlU/nBRVzn1azYw6MxLO9yrZPSouK2mz8usYMYOmV8QoZDlKviX11ZDZ+T+QIFfRx0vI1b/lifKE
5hYnNsdy/lntFQMBJX8UN5pnbAofz519+1mQn1JBqVuQ4g9E9jeF4XEQuNO4th1unlwPi68oS7ME
28U=
=5ARr
-----END PGP SIGNATURE-----

--------------qqtjeQaXN5AijMGUNtr0H76t--
