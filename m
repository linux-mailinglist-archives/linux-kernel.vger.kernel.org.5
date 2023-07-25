Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D07621AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGYSlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGYSl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:41:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C822119A1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:41:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5021621C0A;
        Tue, 25 Jul 2023 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690310484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szFmNSH9AHpy5nRMogZQI3LiZRrngSuHJFUGza4yt0c=;
        b=YIPjhxIQ2QLAx5O1c+9JA6EGq7OGACGqAzCkD+3l9F4wT/Szlb1sh7UjWzQy39EbZoNiP0
        VFsfmdwKh9jIj/iU7jBnxDkuDvDk9d/0G7Yw1lRp2gPEbXVt2mhvHWHrR2spWwMLtm7DPL
        hOCa+biIX53zXioLLTWSMn2MFo24cig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690310484;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szFmNSH9AHpy5nRMogZQI3LiZRrngSuHJFUGza4yt0c=;
        b=fIcdSpEAasBvBUskGgdoPaFodZLpJ4ft5desLbyPwS2wPPaTbVva1ifuQ1OkrXmZh6PQTS
        xIAmaoT2wQ9FvUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2653913487;
        Tue, 25 Jul 2023 18:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dd0UCFQXwGSTegAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 25 Jul 2023 18:41:24 +0000
Message-ID: <afbc2058-f25e-200a-8b6f-c0db8d0d735f@suse.de>
Date:   Tue, 25 Jul 2023 20:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 -next] drm/fb-helper: Remove unused inline function
 drm_fb_helper_defio_init()
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230725021317.8080-1-yuehaibing@huawei.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230725021317.8080-1-yuehaibing@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TpZnqdr0oiezQ0awiOlH0Zo6"
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
--------------TpZnqdr0oiezQ0awiOlH0Zo6
Content-Type: multipart/mixed; boundary="------------hLpWRsStu0ywfVnKBVaBFam9";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: YueHaibing <yuehaibing@huawei.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <afbc2058-f25e-200a-8b6f-c0db8d0d735f@suse.de>
Subject: Re: [PATCH v2 -next] drm/fb-helper: Remove unused inline function
 drm_fb_helper_defio_init()
References: <20230725021317.8080-1-yuehaibing@huawei.com>
In-Reply-To: <20230725021317.8080-1-yuehaibing@huawei.com>

--------------hLpWRsStu0ywfVnKBVaBFam9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjUuMDcuMjMgdW0gMDQ6MTMgc2NocmllYiBZdWVIYWliaW5nOg0KPiBTaW5j
ZSBjb21taXQgOGU4NmRlZTAyMjUzICgiZHJtL2ZiLWhlbHBlcjogUmVtb3ZlIGRybV9mYl9o
ZWxwZXJfZGVmaW9faW5pdCgpIGFuZCB1cGRhdGUgZG9jcyIpDQo+IHRoaXMgaW5saW5lIGhl
bHBlciBub3QgdXNlZCBhbnltb3JlLg0KPiANCj4gRml4ZXM6IDhlODZkZWUwMjI1MyAoImRy
bS9mYi1oZWxwZXI6IFJlbW92ZSBkcm1fZmJfaGVscGVyX2RlZmlvX2luaXQoKSBhbmQgdXBk
YXRlIGRvY3MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+DQo+IFJldmlld2VkLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1h
bm5Ac3VzZS5kZT4NCj4gLS0tDQo+IHYyOiBBZGQgRml4ZXMgdGFnDQoNCk1lcmdlZCBpbnRv
IGRybS1taXNjLWZpeGVzLiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guDQoNCkJlc3QgcmVn
YXJkcw0KVGhvbWFzDQoNCj4gLS0tDQo+ICAgaW5jbHVkZS9kcm0vZHJtX2ZiX2hlbHBlci5o
IHwgNSAtLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9mYl9oZWxwZXIuaCBiL2luY2x1ZGUvZHJt
L2RybV9mYl9oZWxwZXIuaA0KPiBpbmRleCA0ODYzYjBmODI5OWUuLjM3NTczN2ZkNmMzNiAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9kcm0vZHJtX2ZiX2hlbHBlci5oDQo+ICsrKyBiL2lu
Y2x1ZGUvZHJtL2RybV9mYl9oZWxwZXIuaA0KPiBAQCAtMzY4LDExICszNjgsNiBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgZHJtX2ZiX2hlbHBlcl9kZWZlcnJlZF9pbyhzdHJ1Y3QgZmJfaW5m
byAqaW5mbywNCj4gICB7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGlubGluZSBpbnQgZHJt
X2ZiX2hlbHBlcl9kZWZpb19pbml0KHN0cnVjdCBkcm1fZmJfaGVscGVyICpmYl9oZWxwZXIp
DQo+IC17DQo+IC0JcmV0dXJuIC1FTk9ERVY7DQo+IC19DQo+IC0NCj4gICBzdGF0aWMgaW5s
aW5lIHZvaWQgZHJtX2ZiX2hlbHBlcl9zZXRfc3VzcGVuZChzdHJ1Y3QgZHJtX2ZiX2hlbHBl
ciAqZmJfaGVscGVyLA0KPiAgIAkJCQkJICAgICBib29sIHN1c3BlbmQpDQo+ICAgew0KDQot
LSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0Niwg
OTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMs
IEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBNb2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJu
YmVyZykNCg==

--------------hLpWRsStu0ywfVnKBVaBFam9--

--------------TpZnqdr0oiezQ0awiOlH0Zo6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmTAF1MFAwAAAAAACgkQlh/E3EQov+Aj
Ew/+LN+Rg8hgslzyVoJj/E4V4gbG7uRyHKVW/rCwic1RtBqCmuwDsFrXWSmtLAtKGgyfvV/kJDOR
NeaTOQ7xxYTtul46jSbTe5Nmd/irzOUZO93QGlWQWSC5T4hOY1FMTLgz9fB2odmfzUD5pzYpbfv4
AiJZPXErKBccOr5QRFpCydsJeApzz84py0VzuV0uBtaEV2jzHl2G5bhmKQRezkF/paNJONTKIyUq
gM6FtVtu3wRuygWISUL8NMDtA6gChPPDrP+WIWFwiUrn5yM1PgJIwfhcz0cLZBrSqrF91F7vltyI
HYG6VG5NZcNnrXYUHvoclEeZHjSfeY1hR3RoUnfvb+ySlZpwzDhwb/y5a3VzYIYN5a7SDY8dhxm4
NUyJJ1vqXaMJ5/Ffy809U2+MumxyJ8TFE7V8OhFtrpm6ZhCvJfgu2xOmZJdbLC4skT8mS6JImc2s
TZ44vAZ+QRe3+rz6dc2t3gxxOW18u17XdL/KOV50S2novHj5nEvKK1p5pBAUY7ebqIr8DIeQBBz9
6dUz4NijUOJiOiK5h3JgJ5L6Ikz0bgy+9TlBD5UEJgw7ndBSDTnAnATPnciGkIWkL+AYqaaiftPV
7q3Xd2sPgC82sIQUNz1XID1YZbNvas2lUprSozjVOeqD/DhaSx/xic8cLvwId5HWL55y5afrQ6S8
c4c=
=1kzK
-----END PGP SIGNATURE-----

--------------TpZnqdr0oiezQ0awiOlH0Zo6--
