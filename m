Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FD77B2167
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjI1PdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI1PdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:33:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44014B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:33:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0B96218E6;
        Thu, 28 Sep 2023 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695915189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=R4vy0zU0Pr1f3U56GuNDaWODiU85Wy0KJE3fHb1+eWo=;
        b=em9roNfYcAkpdHg8RN8J4aS5lXXniLVeSqcg4TDUGnKLURMJEdPh7eUUdOMoonDbfVMlAI
        ++XAUtLrwdmvCjlJ+o/CmGQMdJGCaaqEflLLfL2yhlw6N1TPK1HzVFQWEWb0GrLLCqSPyU
        JHwy8itCmB/fEt0RHTONGRfvXWoffnc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96E44138E9;
        Thu, 28 Sep 2023 15:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tL2aI7WcFWUbMQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 28 Sep 2023 15:33:09 +0000
Message-ID: <8c0f3255-83ea-4108-847f-63b895997577@suse.com>
Date:   Thu, 28 Sep 2023 17:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xen: evtchn: Allow shared registration of IRQ handers
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <cover.1693311370.git.viresh.kumar@linaro.org>
 <fc6d47de76a8b77d0a1b4bc8204694c079715f2e.1693311370.git.viresh.kumar@linaro.org>
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
In-Reply-To: <fc6d47de76a8b77d0a1b4bc8204694c079715f2e.1693311370.git.viresh.kumar@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JVTR8m52YxNgV4MDl5HMuc3s"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JVTR8m52YxNgV4MDl5HMuc3s
Content-Type: multipart/mixed; boundary="------------fh0Fr5pHK4fHyrXGogPynGTi";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org, Erik Schilling <erik.schilling@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <8c0f3255-83ea-4108-847f-63b895997577@suse.com>
Subject: Re: [PATCH 1/2] xen: evtchn: Allow shared registration of IRQ handers
References: <cover.1693311370.git.viresh.kumar@linaro.org>
 <fc6d47de76a8b77d0a1b4bc8204694c079715f2e.1693311370.git.viresh.kumar@linaro.org>
In-Reply-To: <fc6d47de76a8b77d0a1b4bc8204694c079715f2e.1693311370.git.viresh.kumar@linaro.org>

--------------fh0Fr5pHK4fHyrXGogPynGTi
Content-Type: multipart/mixed; boundary="------------S0lyxxAH05x0JFhaooIfch0M"

--------------S0lyxxAH05x0JFhaooIfch0M
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDguMjMgMTQ6MjksIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gQ3VycmVudGx5IHRo
ZSBoYW5kbGluZyBvZiBldmVudHMgaXMgc3VwcG9ydGVkIGVpdGhlciBpbiB0aGUga2VybmVs
IG9yDQo+IHVzZXJzcGFjZSwgYnV0IG5vdCBib3RoLg0KPiANCj4gSW4gb3JkZXIgdG8gc3Vw
cG9ydCBmYXN0IGRlbGl2ZXJ5IG9mIGludGVycnVwdHMgZnJvbSB0aGUgZ3Vlc3QgdG8gdGhl
DQo+IGJhY2tlbmQsIHdlIG5lZWQgdG8gaGFuZGxlIHRoZSBRdWV1ZSBub3RpZnkgcGFydCBv
ZiBWaXJ0aW8gcHJvdG9jb2wgaW4NCj4ga2VybmVsIGFuZCB0aGUgcmVzdCBpbiB1c2Vyc3Bh
Y2UuDQo+IA0KPiBVcGRhdGUgdGhlIGludGVycnVwdCBoYW5kbGVyIHJlZ2lzdHJhdGlvbiBm
bGFnIHRvIElSUUZfU0hBUkVEIGZvciBldmVudA0KPiBjaGFubmVscywgd2hpY2ggd291bGQg
YWxsb3cgbXVsdGlwbGUgZW50aXRpZXMgdG8gYmluZCB0aGVpciBpbnRlcnJ1cHQNCj4gaGFu
ZGxlciBmb3IgdGhlIHNhbWUgZXZlbnQgY2hhbm5lbCBwb3J0Lg0KPiANCj4gQWxzbyBpbmNy
ZW1lbnQgdGhlIHJlZmVyZW5jZSBjb3VudCBvZiBpcnFfaW5mbyB3aGVuIG11bHRpcGxlIGVu
dGl0aWVzDQo+IHRyeSB0byBiaW5kIGV2ZW50IGNoYW5uZWwgdG8gaXJxY2hpcCwgc28gdGhl
IHVuYmluZGluZyBoYXBwZW5zIG9ubHkNCj4gYWZ0ZXIgYWxsIHRoZSB1c2VycyBhcmUgZ29u
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxp
bmFyby5vcmc+DQo+IC0tLQ0KPiAgIGRyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5j
IHwgMSArDQo+ICAgZHJpdmVycy94ZW4vZXZ0Y2huLmMgICAgICAgICAgICAgfCAyICstDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyBiL2Ry
aXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+IGluZGV4IGM3NzE1ZjhiZDQ1Mi4u
MDE4MjY4MGRhYjNhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRz
X2Jhc2UuYw0KPiArKysgYi9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPiBA
QCAtMTIzOSw2ICsxMjM5LDcgQEAgc3RhdGljIGludCBiaW5kX2V2dGNobl90b19pcnFfY2hp
cChldnRjaG5fcG9ydF90IGV2dGNobiwgc3RydWN0IGlycV9jaGlwICpjaGlwLA0KPiAgIAl9
IGVsc2Ugew0KPiAgIAkJc3RydWN0IGlycV9pbmZvICppbmZvID0gaW5mb19mb3JfaXJxKGly
cSk7DQo+ICAgCQlXQVJOX09OKGluZm8gPT0gTlVMTCB8fCBpbmZvLT50eXBlICE9IElSUVRf
RVZUQ0hOKTsNCj4gKwkJaW5mby0+cmVmY250Kys7DQoNClRoaXMgc2hvdWxkIGJlIGNvbmRp
dGlvbmFsIG9uIHRoZSBXQVJOX09OKCkgbm90IHRyaWdnZXJpbmcuDQoNCj4gICAJfQ0KPiAg
IA0KPiAgIG91dDoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2V2dGNobi5jIGIvZHJp
dmVycy94ZW4vZXZ0Y2huLmMNCj4gaW5kZXggYzk5NDE1YTcwMDUxLi40M2Y3NzkxNWZlYjUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMveGVuL2V2dGNobi5jDQo+ICsrKyBiL2RyaXZlcnMv
eGVuL2V2dGNobi5jDQo+IEBAIC0zOTcsNyArMzk3LDcgQEAgc3RhdGljIGludCBldnRjaG5f
YmluZF90b191c2VyKHN0cnVjdCBwZXJfdXNlcl9kYXRhICp1LCBldnRjaG5fcG9ydF90IHBv
cnQpDQo+ICAgCWlmIChyYyA8IDApDQo+ICAgCQlnb3RvIGVycjsNCj4gICANCj4gLQlyYyA9
IGJpbmRfZXZ0Y2huX3RvX2lycWhhbmRsZXJfbGF0ZWVvaShwb3J0LCBldnRjaG5faW50ZXJy
dXB0LCAwLA0KPiArCXJjID0gYmluZF9ldnRjaG5fdG9faXJxaGFuZGxlcl9sYXRlZW9pKHBv
cnQsIGV2dGNobl9pbnRlcnJ1cHQsIElSUUZfU0hBUkVELA0KPiAgIAkJCQkJICAgICAgIHUt
Pm5hbWUsIGV2dGNobik7DQo+ICAgCWlmIChyYyA8IDApDQo+ICAgCQlnb3RvIGVycjsNCg0K
DQpKdWVyZ2VuDQo=
--------------S0lyxxAH05x0JFhaooIfch0M
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------S0lyxxAH05x0JFhaooIfch0M--

--------------fh0Fr5pHK4fHyrXGogPynGTi--

--------------JVTR8m52YxNgV4MDl5HMuc3s
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmUVnLUFAwAAAAAACgkQsN6d1ii/Ey/3
KQf+IET6cM4Bo9o34kH8hoFxRF9K2Dbi0YZXC7NdlDK9OVrbqJ9SruSDaoo/z65Jaz3HGdX6uyXC
eGC8JwcRUyrc+SWUTb6sm776y83CykA9SPXY3FizGjBv97X1t87Xdez4fudFELKSljdhU1IQimDz
aAi6ekhfGP2iCV1r/jDqCRnQb9Rv/FZ8VDVDnURV3HrudhNmWeL2q9hYww/ZovU4YcDJNUoTJz+9
PnXMwuLuZVq9BguAkiQevecjs+OXfFEgZN8CcnoqvE6SZlCoqKbrudaajYZwzniyHPihI1ZOVFzx
OXGaMiGVUQLB3HKbb+u/IL0VEs5xVGZGTIMkRcNllA==
=H/n6
-----END PGP SIGNATURE-----

--------------JVTR8m52YxNgV4MDl5HMuc3s--
