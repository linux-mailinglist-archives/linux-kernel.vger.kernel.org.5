Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F357E19DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjKFGB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFGBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:01:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F6112
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:01:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 387E11F38A;
        Mon,  6 Nov 2023 06:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699250510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=59AgskFfJ8ZDRPe+nQZ2XM1bfbKYKiz35XjQTuOu/Zw=;
        b=MXJFkreefWbeg/7dVomv8ynJTGiELxW2PTqU/zoIffSwkqYUyAUBaYt2e2H2w3NLaWSVkw
        FRUolBcw83bDfTvO8fqmNRi1fOyeDZ+61oZVT69x97OO1XqmsHI+GU3RB3m/4hTP0aJtws
        msRbk9+9FD/+aM9FMJ3tijj0b0QcrwI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F31CD138E5;
        Mon,  6 Nov 2023 06:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMJ/OU2BSGUwGwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 06 Nov 2023 06:01:49 +0000
Message-ID: <d1e40b11-e585-4df7-aecf-ca5c862338ae@suse.com>
Date:   Mon, 6 Nov 2023 07:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/shbuf: eliminate 17 kernel-doc warnings
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
References: <20231106055631.21520-1-rdunlap@infradead.org>
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
In-Reply-To: <20231106055631.21520-1-rdunlap@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UUpw9yy9c4JGcQKVp2RbrEDO"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UUpw9yy9c4JGcQKVp2RbrEDO
Content-Type: multipart/mixed; boundary="------------N0DbgYE4B0YGZ36ABGARpjtb";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org
Message-ID: <d1e40b11-e585-4df7-aecf-ca5c862338ae@suse.com>
Subject: Re: [PATCH] xen/shbuf: eliminate 17 kernel-doc warnings
References: <20231106055631.21520-1-rdunlap@infradead.org>
In-Reply-To: <20231106055631.21520-1-rdunlap@infradead.org>

--------------N0DbgYE4B0YGZ36ABGARpjtb
Content-Type: multipart/mixed; boundary="------------60Cv0cm9ZBk9hDt0b9Pj0UoR"

--------------60Cv0cm9ZBk9hDt0b9Pj0UoR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMTEuMjMgMDY6NTYsIFJhbmR5IER1bmxhcCB3cm90ZToNCj4gRG9uJ3QgdXNlIGtl
cm5lbC1kb2MgbWFya2VycyAoIi8qKiIpIGZvciBjb21tZW50cyB0aGF0IGFyZSBub3QgaW4N
Cj4ga2VybmVsLWRvYyBmb3JtYXQuIFRoaXMgcHJldmVudHMgbXVsdGlwbGUga2VybmVsLWRv
YyB3YXJuaW5nczoNCj4gDQo+IHhlbi1mcm9udC1wZ2Rpci1zaGJ1Zi5jOjI1OiB3YXJuaW5n
OiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKicsIGJ1dCBpc24ndCBhIGtlcm5lbC1k
b2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2MtZ3VpZGUva2VybmVsLWRvYy5y
c3QNCj4gICAqIFRoaXMgc3RydWN0dXJlIHJlcHJlc2VudHMgdGhlIHN0cnVjdHVyZSBvZiBh
IHNoYXJlZCBwYWdlDQo+IHhlbi1mcm9udC1wZ2Rpci1zaGJ1Zi5jOjM3OiB3YXJuaW5nOiBU
aGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKicsIGJ1dCBpc24ndCBhIGtlcm5lbC1kb2Mg
Y29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2MtZ3VpZGUva2VybmVsLWRvYy5yc3QN
Cj4gICAqIFNoYXJlZCBidWZmZXIgb3BzIHdoaWNoIGFyZSBkaWZmZXJlbnRseSBpbXBsZW1l
bnRlZA0KPiB4ZW4tZnJvbnQtcGdkaXItc2hidWYuYzo2NTogd2FybmluZzogVGhpcyBjb21t
ZW50IHN0YXJ0cyB3aXRoICcvKionLCBidXQgaXNuJ3QgYSBrZXJuZWwtZG9jIGNvbW1lbnQu
IFJlZmVyIERvY3VtZW50YXRpb24vZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0DQo+ICAgKiBH
ZXQgZ3JhbnRlZCByZWZlcmVuY2UgdG8gdGhlIHZlcnkgZmlyc3QgcGFnZSBvZiB0aGUNCj4g
eGVuLWZyb250LXBnZGlyLXNoYnVmLmM6ODU6IHdhcm5pbmc6IFRoaXMgY29tbWVudCBzdGFy
dHMgd2l0aCAnLyoqJywgYnV0IGlzbid0IGEga2VybmVsLWRvYyBjb21tZW50LiBSZWZlciBE
b2N1bWVudGF0aW9uL2RvYy1ndWlkZS9rZXJuZWwtZG9jLnJzdA0KPiAgICogTWFwIGdyYW50
ZWQgcmVmZXJlbmNlcyBvZiB0aGUgc2hhcmVkIGJ1ZmZlci4NCj4geGVuLWZyb250LXBnZGly
LXNoYnVmLmM6MTA2OiB3YXJuaW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKics
IGJ1dCBpc24ndCBhIGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9k
b2MtZ3VpZGUva2VybmVsLWRvYy5yc3QNCj4gICAqIFVubWFwIGdyYW50ZWQgcmVmZXJlbmNl
cyBvZiB0aGUgc2hhcmVkIGJ1ZmZlci4NCj4geGVuLWZyb250LXBnZGlyLXNoYnVmLmM6MTI3
OiB3YXJuaW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKicsIGJ1dCBpc24ndCBh
IGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2MtZ3VpZGUva2Vy
bmVsLWRvYy5yc3QNCj4gICAqIEZyZWUgYWxsIHRoZSByZXNvdXJjZXMgb2YgdGhlIHNoYXJl
ZCBidWZmZXIuDQo+IHhlbi1mcm9udC1wZ2Rpci1zaGJ1Zi5jOjE1NDogd2FybmluZzogVGhp
cyBjb21tZW50IHN0YXJ0cyB3aXRoICcvKionLCBidXQgaXNuJ3QgYSBrZXJuZWwtZG9jIGNv
bW1lbnQuIFJlZmVyIERvY3VtZW50YXRpb24vZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0DQo+
ICAgKiBHZXQgdGhlIG51bWJlciBvZiBwYWdlcyB0aGUgcGFnZSBkaXJlY3RvcnkgY29uc3Vt
ZXMgaXRzZWxmLg0KPiB4ZW4tZnJvbnQtcGdkaXItc2hidWYuYzoxNjQ6IHdhcm5pbmc6IFRo
aXMgY29tbWVudCBzdGFydHMgd2l0aCAnLyoqJywgYnV0IGlzbid0IGEga2VybmVsLWRvYyBj
b21tZW50LiBSZWZlciBEb2N1bWVudGF0aW9uL2RvYy1ndWlkZS9rZXJuZWwtZG9jLnJzdA0K
PiAgICogQ2FsY3VsYXRlIHRoZSBudW1iZXIgb2YgZ3JhbnQgcmVmZXJlbmNlcyBuZWVkZWQg
dG8gc2hhcmUgdGhlIGJ1ZmZlcg0KPiB4ZW4tZnJvbnQtcGdkaXItc2hidWYuYzoxNzY6IHdh
cm5pbmc6IFRoaXMgY29tbWVudCBzdGFydHMgd2l0aCAnLyoqJywgYnV0IGlzbid0IGEga2Vy
bmVsLWRvYyBjb21tZW50LiBSZWZlciBEb2N1bWVudGF0aW9uL2RvYy1ndWlkZS9rZXJuZWwt
ZG9jLnJzdA0KPiAgICogQ2FsY3VsYXRlIHRoZSBudW1iZXIgb2YgZ3JhbnQgcmVmZXJlbmNl
cyBuZWVkZWQgdG8gc2hhcmUgdGhlIGJ1ZmZlcg0KPiB4ZW4tZnJvbnQtcGdkaXItc2hidWYu
YzoxOTQ6IHdhcm5pbmc6IFRoaXMgY29tbWVudCBzdGFydHMgd2l0aCAnLyoqJywgYnV0IGlz
bid0IGEga2VybmVsLWRvYyBjb21tZW50LiBSZWZlciBEb2N1bWVudGF0aW9uL2RvYy1ndWlk
ZS9rZXJuZWwtZG9jLnJzdA0KPiAgICogVW5tYXAgdGhlIGJ1ZmZlciBwcmV2aW91c2x5IG1h
cHBlZCB3aXRoIGdyYW50IHJlZmVyZW5jZXMNCj4geGVuLWZyb250LXBnZGlyLXNoYnVmLmM6
MjQyOiB3YXJuaW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKicsIGJ1dCBpc24n
dCBhIGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2MtZ3VpZGUv
a2VybmVsLWRvYy5yc3QNCj4gICAqIE1hcCB0aGUgYnVmZmVyIHdpdGggZ3JhbnQgcmVmZXJl
bmNlcyBwcm92aWRlZCBieSB0aGUgYmFja2VuZC4NCj4geGVuLWZyb250LXBnZGlyLXNoYnVm
LmM6MzI0OiB3YXJuaW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKicsIGJ1dCBp
c24ndCBhIGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2MtZ3Vp
ZGUva2VybmVsLWRvYy5yc3QNCj4gICAqIEZpbGwgcGFnZSBkaXJlY3Rvcnkgd2l0aCBncmFu
dCByZWZlcmVuY2VzIHRvIHRoZSBwYWdlcyBvZiB0aGUNCj4geGVuLWZyb250LXBnZGlyLXNo
YnVmLmM6MzU0OiB3YXJuaW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKicsIGJ1
dCBpc24ndCBhIGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2Mt
Z3VpZGUva2VybmVsLWRvYy5yc3QNCj4gICAqIEZpbGwgcGFnZSBkaXJlY3Rvcnkgd2l0aCBn
cmFudCByZWZlcmVuY2VzIHRvIHRoZSBwYWdlcyBvZiB0aGUNCj4geGVuLWZyb250LXBnZGly
LXNoYnVmLmM6MzkzOiB3YXJuaW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKics
IGJ1dCBpc24ndCBhIGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9k
b2MtZ3VpZGUva2VybmVsLWRvYy5yc3QNCj4gICAqIEdyYW50IHJlZmVyZW5jZXMgdG8gdGhl
IGZyb250ZW5kJ3MgYnVmZmVyIHBhZ2VzLg0KPiB4ZW4tZnJvbnQtcGdkaXItc2hidWYuYzo0
MjI6IHdhcm5pbmc6IFRoaXMgY29tbWVudCBzdGFydHMgd2l0aCAnLyoqJywgYnV0IGlzbid0
IGEga2VybmVsLWRvYyBjb21tZW50LiBSZWZlciBEb2N1bWVudGF0aW9uL2RvYy1ndWlkZS9r
ZXJuZWwtZG9jLnJzdA0KPiAgICogR3JhbnQgYWxsIHRoZSByZWZlcmVuY2VzIG5lZWRlZCB0
byBzaGFyZSB0aGUgYnVmZmVyLg0KPiB4ZW4tZnJvbnQtcGdkaXItc2hidWYuYzo0NzA6IHdh
cm5pbmc6IFRoaXMgY29tbWVudCBzdGFydHMgd2l0aCAnLyoqJywgYnV0IGlzbid0IGEga2Vy
bmVsLWRvYyBjb21tZW50LiBSZWZlciBEb2N1bWVudGF0aW9uL2RvYy1ndWlkZS9rZXJuZWwt
ZG9jLnJzdA0KPiAgICogQWxsb2NhdGUgYWxsIHJlcXVpcmVkIHN0cnVjdHVyZXMgdG8gbWFu
Z2Ugc2hhcmVkIGJ1ZmZlci4NCj4geGVuLWZyb250LXBnZGlyLXNoYnVmLmM6NTEwOiB3YXJu
aW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKicsIGJ1dCBpc24ndCBhIGtlcm5l
bC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2MtZ3VpZGUva2VybmVsLWRv
Yy5yc3QNCj4gICAqIEFsbG9jYXRlIGEgbmV3IGluc3RhbmNlIG9mIGEgc2hhcmVkIGJ1ZmZl
ci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRl
YWQub3JnPg0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5j
b20+DQo+IENsb3NlczogbG9yZS5rZXJuZWwub3JnL3IvMjAyMzExMDYwMjAzLnlRcnBQWmht
LWxrcEBpbnRlbC5jb20NCj4gQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4N
Cj4gQ2M6IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4NCj4g
Q2M6IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNv
bT4NCj4gQ2M6IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZw0KDQpBY2tlZC1ieTog
SnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg0K
--------------60Cv0cm9ZBk9hDt0b9Pj0UoR
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------60Cv0cm9ZBk9hDt0b9Pj0UoR--

--------------N0DbgYE4B0YGZ36ABGARpjtb--

--------------UUpw9yy9c4JGcQKVp2RbrEDO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVIgU0FAwAAAAAACgkQsN6d1ii/Ey+i
WQf/THFpWAJlimlbD2vVGFcxCTmUxGz4pEZqI1sWzovjT9tK7XA8irY3PNiCWqmDbgZ9HUxHCgVY
v4aXHovhXjkUC3xSVgzqLM/QRHh0rrKvxy+KJEN06O7TGzBf1UYgAxrkVtvOZAZmojdocWV3MLWf
Zi+UqkmQBGBJOoC48o90/ebSl+B6qVT2w99uSEKEajqYMWFfrzlnPqspt6XgfWrAsA6KnQMHrz5d
6WzQmUkpan4WbaKocskW0gyNwK5up+sqKb6Qd4LNlIXPueu2UJQadN7JysStoQbx3outhdSs14/g
RRu7rB5pi/dHXBALR1tmI01G7c4PlwwlG5I4zTw9Hg==
=1NYV
-----END PGP SIGNATURE-----

--------------UUpw9yy9c4JGcQKVp2RbrEDO--
