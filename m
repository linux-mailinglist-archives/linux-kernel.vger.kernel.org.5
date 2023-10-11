Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5F7C5D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjJKSzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjJKSy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:54:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560794
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:54:56 -0700 (PDT)
Received: from [10.0.0.200] (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: david.heidelberg)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF4E96607331;
        Wed, 11 Oct 2023 19:54:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697050495;
        bh=hqTOeLvgEjncmx/NVuuoG0K9iLTm8/BJMu98YdlyIV4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y/jvuHHKwVUM6HQjJRdcb+SIV1l0Z4DWHjgDXjPUnNiwym5xmP5tDrI6FKRxhF3pg
         r994bUQ1wcEgQD5Y8ujekkI0BO9dmu6okyi4ajw9BT8t+3JOPvemEPuyyr4kdTG7L9
         Z6m/JeuItQIlAiq01Q3fM+2i8C3uwTksba7nWNpSZGf/lVHn0Ggqjn+XCozDF/UW3U
         THZDIrBpjAZYdev17/qi9tLziERF1+Oq8BctCQdep2viMUv/9YwuGbM06GhOapu4ON
         ZD7lhlWdJNlwsB46yy19uAMleWXV6jCSDNFUipmlzNjPfsw+wAstU/wveWltJ27Vue
         SJ0E3uwzXlwHw==
Message-ID: <0231fe84-96c6-4c10-bd77-2cdcea49b8d2@collabora.com>
Date:   Wed, 11 Oct 2023 20:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] drm/ci: fixes and improvements
Content-Language: en-US
To:     Helen Koike <helen.koike@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robdclark@chromium.org, dmitry.baryshkov@linaro.org,
        vignesh.raman@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231009004953.203576-1-helen.koike@collabora.com>
From:   David Heidelberg <david.heidelberg@collabora.com>
Autocrypt: addr=david.heidelberg@collabora.com; keydata=
 xjMEYlvLOxYJKwYBBAHaRw8BAQdA5CoWEzz4igpwK4h6lK6ZformRk84+ymcfkGNPwqEeILN
 MURhdmlkIEhlaWRlbGJlcmcgPGRhdmlkLmhlaWRlbGJlcmdAY29sbGFib3JhLmNvbT7ClgQT
 FggAPhYhBEo7kSl22BK0F1Np/mn1Z4YcHsAUBQJiW8s7AhsDBQkFo5qABQsJCAcCBhUKCQgL
 AgQWAgMBAh4BAheAAAoJEGn1Z4YcHsAU84kBAK5YqSWAOuIumAqgWvke6BEsaIGWGQzXSuKj
 er/TXuFuAQCwc9ITSVXWWTSpdFt2+4z7Wch8tIGlbIFcS9dCFddwCc44BGJbyzsSCisGAQQB
 l1UBBQEBB0AEk7jXEwDApGOwMH/X0UAPBH8Y3isjxhNMjpyRcnl2CwMBCAfCfgQYFggAJhYh
 BEo7kSl22BK0F1Np/mn1Z4YcHsAUBQJiW8s7AhsMBQkFo5qAAAoJEGn1Z4YcHsAU0PEA/j0Y
 uAOKJCnnwrkf3ozPP0sutA5bojoARwcIaZKO/zvIAP9PwTC9DGLg+8LJm7m2Lyf0LxLA8FXD
 wueLHBdwHg6zAQ==
In-Reply-To: <20231009004953.203576-1-helen.koike@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VcQS5LnegmfhnnjtAH3e88YN"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VcQS5LnegmfhnnjtAH3e88YN
Content-Type: multipart/mixed; boundary="------------2msBekilzJjwjS0F2c1BGd7A";
 protected-headers="v1"
From: David Heidelberg <david.heidelberg@collabora.com>
To: Helen Koike <helen.koike@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robdclark@chromium.org, dmitry.baryshkov@linaro.org,
 vignesh.raman@collabora.com, sergi.blanch.torne@collabora.com,
 guilherme.gallo@collabora.com, quic_abhinavk@quicinc.com,
 quic_jesszhan@quicinc.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Message-ID: <0231fe84-96c6-4c10-bd77-2cdcea49b8d2@collabora.com>
Subject: Re: [PATCH 0/9] drm/ci: fixes and improvements
References: <20231009004953.203576-1-helen.koike@collabora.com>
In-Reply-To: <20231009004953.203576-1-helen.koike@collabora.com>

--------------2msBekilzJjwjS0F2c1BGd7A
Content-Type: multipart/mixed; boundary="------------V0gK0iDbmzaQlZDwu5rkIymK"

--------------V0gK0iDbmzaQlZDwu5rkIymK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Zm9yIHRoZSBzZXJpZXM6DQoNClJldmlld2VkLWJ5OiBEYXZpZCBIZWlkZWxiZXJnIDxkYXZp
ZC5oZWlkZWxiZXJnQGNvbGxhYm9yYS5jb20+DQoNCk9uIDA5LzEwLzIwMjMgMDI6NDksIEhl
bGVuIEtvaWtlIHdyb3RlOg0KPiBUaGlzIHNlcmllcyBjb250YWlucyB0aGUgZm9sbG93aW5n
IHNldmVyYWwgZml4ZXMsIG1ha2luZyBkcm0vY2kgbXVjaA0KPiBtb3JlIHJlbGlhYmxlIGFu
ZCB1c2VmdWwuDQo+DQo+IFRvIHdvcmsgcHJvcGVybHksIHRoZSBmb2xsb3dpbmcgcGF0Y2hl
cyBhcmUgYWxzbyByZXF1aXJlZDoNCj4NCj4gW1BBVENIIDIvMl0gZHJtL2NpOiBmb3JjZS1l
bmFibGUgQ09ORklHX01TTV9NTUNDXzg5OTYgYXMgYnVpbHQtaW4NCj4gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWFybS1tc20vcGF0Y2gvMjAyMzEwMDgx
MzIzMjAuNzYyNTQyLTItZG1pdHJ5LmJhcnlzaGtvdkBsaW5hcm8ub3JnLw0KPg0KPiBbUEFU
Q0hdIGRybS9jaTogRW5hYmxlIENPTkZJR19CQUNLTElHSFRfQ0xBU1NfREVWSUNFDQo+IGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9kcmktZGV2ZWwvcGF0Y2gvMjAy
MzEwMDIxNjQ3MTUuMTU3Mjk4LTEtcm9iZGNsYXJrQGdtYWlsLmNvbS8NCj4NCj4gSGVsZW4g
S29pa2UgKDkpOg0KPiAgICBkcm0vY2k6IHVwcmV2IG1lc2EgdmVyc2lvbiAtIGZpeCBjb250
YWluZXIgYnVpbGQNCj4gICAgZHJtL2NpOiBmaXggREVCSUFOX0FSQ0ggYW5kIGdldCBhbWRn
cHUgcHJvYmluZw0KPiAgICBkcm0vY2k6IGFkZCBoZWxwZXIgc2NyaXB0IHVwZGF0ZS14ZmFp
bHMucHkNCj4gICAgZHJtL2NpOiB1cHJldiBJR1QgYW5kIG1ha2Ugc3VyZSBjb3JlX2dldHZl
cnNpb24gaXMgcnVuDQo+ICAgIGRybS9jaTogY2xlYW4gdXAgeGZhaWxzIChzcGVjaWFsbHkg
Zmxha2VzIGxpc3QpDQo+ICAgIGRybS9jaTogYWRqdXN0IHRoZSBudW1iZXIgb2Ygc2hhcmRz
DQo+ICAgIGRybS9jaTogZXhwb3J0IGtlcm5lbCBjb25maWcNCj4gICAgZHJtL2NpOiBkbyBu
b3QgYXV0b21hdGljYWxseSByZXRyeSBvbiBlcnJvcg0KPiAgICBkcm0vY2k6IGRvY3M6IGFk
ZCBzdGVwIGFib3V0IGhvdyB0byByZXF1ZXN0IHByaXZpbGVkZ2VzDQo+DQo+ICAgRG9jdW1l
bnRhdGlvbi9ncHUvYXV0b21hdGVkX3Rlc3RpbmcucnN0ICAgICAgIHwgICA3ICstDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2NpL2J1aWxkLnNoICAgICAgICAgICAgICAgICAgIHwgICAzICst
DQo+ICAgZHJpdmVycy9ncHUvZHJtL2NpL2dpdGxhYi1jaS55bWwgICAgICAgICAgICAgIHwg
IDMxICsrLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9jaS9pZ3RfcnVubmVyLnNoICAgICAgICAg
ICAgICB8ICAzMSArKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vY2kvaW1hZ2UtdGFncy55bWwg
ICAgICAgICAgICAgfCAgIDQgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vY2kvbGF2YS1zdWJt
aXQuc2ggICAgICAgICAgICAgfCAgIDYgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vY2kvdGVz
dC55bWwgICAgICAgICAgICAgICAgICAgfCAgMjEgKy0NCj4gICAuLi4vZ3B1L2RybS9jaS94
ZmFpbHMvYW1kZ3B1LXN0b25leS1mYWlscy50eHQgfCAgMTMgKy0NCj4gICAuLi4vZHJtL2Np
L3hmYWlscy9hbWRncHUtc3RvbmV5LWZsYWtlcy50eHQgICAgfCAgMjAgLS0NCj4gICBkcml2
ZXJzL2dwdS9kcm0vY2kveGZhaWxzL2k5MTUtYW1seS1mYWlscy50eHQgfCAgIDkgKw0KPiAg
IC4uLi9ncHUvZHJtL2NpL3hmYWlscy9pOTE1LWFtbHktZmxha2VzLnR4dCAgICB8ICAzMiAt
LS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vY2kveGZhaWxzL2k5MTUtYXBsLWZhaWxzLnR4dCAg
fCAgMTEgLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9jaS94ZmFpbHMvaTkxNS1hcGwtZmxha2Vz
LnR4dCB8ICAgMSAtDQo+ICAgZHJpdmVycy9ncHUvZHJtL2NpL3hmYWlscy9pOTE1LWNtbC1m
YWlscy50eHQgIHwgIDE1ICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL2NpL3hmYWlscy9pOTE1
LWNtbC1mbGFrZXMudHh0IHwgIDM4IC0tLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vY2kveGZh
aWxzL2k5MTUtZ2xrLWZhaWxzLnR4dCAgfCAgMTcgKysNCj4gICBkcml2ZXJzL2dwdS9kcm0v
Y2kveGZhaWxzL2k5MTUtZ2xrLWZsYWtlcy50eHQgfCAgNDEgLS0tLQ0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9jaS94ZmFpbHMvaTkxNS1rYmwtZmFpbHMudHh0ICB8ICAgNyArDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2NpL3hmYWlscy9pOTE1LWtibC1mbGFrZXMudHh0IHwgIDI2IC0tLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9jaS94ZmFpbHMvaTkxNS10Z2wtZmFpbHMudHh0ICB8ICAg
MSAtDQo+ICAgZHJpdmVycy9ncHUvZHJtL2NpL3hmYWlscy9pOTE1LXRnbC1mbGFrZXMudHh0
IHwgICA1IC0NCj4gICBkcml2ZXJzL2dwdS9kcm0vY2kveGZhaWxzL2k5MTUtd2hsLWZsYWtl
cy50eHQgfCAgIDEgLQ0KPiAgIC4uLi9kcm0vY2kveGZhaWxzL21lZGlhdGVrLW10ODE3My1m
bGFrZXMudHh0ICB8ICAgMA0KPiAgIC4uLi9kcm0vY2kveGZhaWxzL21lZGlhdGVrLW10ODE4
My1mYWlscy50eHQgICB8ICAgNSArLQ0KPiAgIC4uLi9kcm0vY2kveGZhaWxzL21lZGlhdGVr
LW10ODE4My1mbGFrZXMudHh0ICB8ICAxNCAtLQ0KPiAgIC4uLi9ncHUvZHJtL2NpL3hmYWls
cy9tZXNvbi1nMTJiLWZhaWxzLnR4dCAgICB8ICAxNCArLQ0KPiAgIC4uLi9ncHUvZHJtL2Np
L3hmYWlscy9tZXNvbi1nMTJiLWZsYWtlcy50eHQgICB8ICAgNCAtDQo+ICAgLi4uL2dwdS9k
cm0vY2kveGZhaWxzL21zbS1hcHE4MDE2LWZsYWtlcy50eHQgIHwgICA0IC0NCj4gICAuLi4v
Z3B1L2RybS9jaS94ZmFpbHMvbXNtLWFwcTgwOTYtZmFpbHMudHh0ICAgfCAgIDIgKw0KPiAg
IC4uLi9ncHUvZHJtL2NpL3hmYWlscy9tc20tYXBxODA5Ni1mbGFrZXMudHh0ICB8ICAgNCAt
DQo+ICAgLi4uL2dwdS9kcm0vY2kveGZhaWxzL21zbS1zYzcxODAtZmFpbHMudHh0ICAgIHwg
IDE1ICstDQo+ICAgLi4uL2dwdS9kcm0vY2kveGZhaWxzL21zbS1zYzcxODAtZmxha2VzLnR4
dCAgIHwgIDI0ICsrLQ0KPiAgIC4uLi9ncHUvZHJtL2NpL3hmYWlscy9tc20tc2M3MTgwLXNr
aXBzLnR4dCAgICB8ICAxOCArLQ0KPiAgIC4uLi9ncHUvZHJtL2NpL3hmYWlscy9tc20tc2Rt
ODQ1LWZhaWxzLnR4dCAgICB8ICAgOSArLQ0KPiAgIC4uLi9ncHUvZHJtL2NpL3hmYWlscy9t
c20tc2RtODQ1LWZsYWtlcy50eHQgICB8ICAyMCArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9j
aS94ZmFpbHMvcmVxdWlyZW1lbnRzLnR4dCAgICB8ICAxNyArKw0KPiAgIC4uLi9kcm0vY2kv
eGZhaWxzL3JvY2tjaGlwLXJrMzI4OC1mYWlscy50eHQgICB8ICAgNiArDQo+ICAgLi4uL2Ry
bS9jaS94ZmFpbHMvcm9ja2NoaXAtcmszMjg4LWZsYWtlcy50eHQgIHwgICA5IC0NCj4gICAu
Li4vZHJtL2NpL3hmYWlscy9yb2NrY2hpcC1yazMzOTktZmFpbHMudHh0ICAgfCAgNDAgKysr
LQ0KPiAgIC4uLi9kcm0vY2kveGZhaWxzL3JvY2tjaGlwLXJrMzM5OS1mbGFrZXMudHh0ICB8
ICAyOCArLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vY2kveGZhaWxzL3VwZGF0ZS14ZmFpbHMu
cHkgICAgfCAyMDMgKysrKysrKysrKysrKysrKysrDQo+ICAgLi4uL2RybS9jaS94ZmFpbHMv
dmlydGlvX2dwdS1ub25lLWZsYWtlcy50eHQgIHwgICAwDQo+ICAgNDIgZmlsZXMgY2hhbmdl
ZCwgNDQ1IGluc2VydGlvbnMoKyksIDMzMSBkZWxldGlvbnMoLSkNCj4gICBkZWxldGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2NpL3hmYWlscy9pOTE1LWFtbHktZmxha2VzLnR4
dA0KPiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vY2kveGZhaWxzL2k5
MTUtYXBsLWZsYWtlcy50eHQNCj4gICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUv
ZHJtL2NpL3hmYWlscy9pOTE1LWNtbC1mbGFrZXMudHh0DQo+ICAgZGVsZXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvZ3B1L2RybS9jaS94ZmFpbHMvaTkxNS1nbGstZmxha2VzLnR4dA0KPiAg
IGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vY2kveGZhaWxzL2k5MTUta2Js
LWZsYWtlcy50eHQNCj4gICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2Np
L3hmYWlscy9pOTE1LXRnbC1mbGFrZXMudHh0DQo+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvZ3B1L2RybS9jaS94ZmFpbHMvaTkxNS13aGwtZmxha2VzLnR4dA0KPiAgIGRlbGV0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vY2kveGZhaWxzL21lZGlhdGVrLW10ODE3
My1mbGFrZXMudHh0DQo+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9j
aS94ZmFpbHMvbWVkaWF0ZWstbXQ4MTgzLWZsYWtlcy50eHQNCj4gICBkZWxldGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9ncHUvZHJtL2NpL3hmYWlscy9tZXNvbi1nMTJiLWZsYWtlcy50eHQN
Cj4gICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2NpL3hmYWlscy9tc20t
YXBxODAxNi1mbGFrZXMudHh0DQo+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1
L2RybS9jaS94ZmFpbHMvbXNtLWFwcTgwOTYtZmxha2VzLnR4dA0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vY2kveGZhaWxzL3JlcXVpcmVtZW50cy50eHQNCj4g
ICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2NpL3hmYWlscy9yb2NrY2hp
cC1yazMyODgtZmxha2VzLnR4dA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSBkcml2ZXJzL2dw
dS9kcm0vY2kveGZhaWxzL3VwZGF0ZS14ZmFpbHMucHkNCj4gICBkZWxldGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9ncHUvZHJtL2NpL3hmYWlscy92aXJ0aW9fZ3B1LW5vbmUtZmxha2VzLnR4
dA0KPg0KLS0gDQpEYXZpZCBIZWlkZWxiZXJnDQpDb25zdWx0YW50IFNvZnR3YXJlIEVuZ2lu
ZWVyDQoNCkNvbGxhYm9yYSBMdGQuDQpQbGF0aW51bSBCdWlsZGluZywgU3QgSm9obidzIElu
bm92YXRpb24gUGFyaywgQ2FtYnJpZGdlIENCNCAwRFMsIFVLDQpSZWdpc3RlcmVkIGluIEVu
Z2xhbmQgJiBXYWxlcywgbm8uIDU1MTM3MTgNCg0K
--------------V0gK0iDbmzaQlZDwu5rkIymK
Content-Type: application/pgp-keys; name="OpenPGP_0x69F567861C1EC014.asc"
Content-Disposition: attachment; filename="OpenPGP_0x69F567861C1EC014.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEYlvLOxYJKwYBBAHaRw8BAQdA5CoWEzz4igpwK4h6lK6ZformRk84+ymcfkGN
PwqEeILNMURhdmlkIEhlaWRlbGJlcmcgPGRhdmlkLmhlaWRlbGJlcmdAY29sbGFi
b3JhLmNvbT7ClgQTFggAPhYhBEo7kSl22BK0F1Np/mn1Z4YcHsAUBQJiW8s7AhsD
BQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGn1Z4YcHsAU84kBAK5Y
qSWAOuIumAqgWvke6BEsaIGWGQzXSuKjer/TXuFuAQCwc9ITSVXWWTSpdFt2+4z7
Wch8tIGlbIFcS9dCFddwCc44BGJbyzsSCisGAQQBl1UBBQEBB0AEk7jXEwDApGOw
MH/X0UAPBH8Y3isjxhNMjpyRcnl2CwMBCAfCfgQYFggAJhYhBEo7kSl22BK0F1Np
/mn1Z4YcHsAUBQJiW8s7AhsMBQkFo5qAAAoJEGn1Z4YcHsAU0PEA/j0YuAOKJCnn
wrkf3ozPP0sutA5bojoARwcIaZKO/zvIAP9PwTC9DGLg+8LJm7m2Lyf0LxLA8FXD
wueLHBdwHg6zAQ=3D=3D
=3DOQS+
-----END PGP PUBLIC KEY BLOCK-----

--------------V0gK0iDbmzaQlZDwu5rkIymK--

--------------2msBekilzJjwjS0F2c1BGd7A--

--------------VcQS5LnegmfhnnjtAH3e88YN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRKO5EpdtgStBdTaf5p9WeGHB7AFAUCZSbvfAAKCRBp9WeGHB7A
FNSlAQCKp2ttkaul/mamT/IXogJoJcSv9h87VhGeDomDqnN9JwEA32Np6SV+hXBb
QMCdjxucplfRAxFVGQsQecm5Y/a/uQ8=
=xdXp
-----END PGP SIGNATURE-----

--------------VcQS5LnegmfhnnjtAH3e88YN--
