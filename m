Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF6751183
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjGLTuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjGLTuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:50:22 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A93419B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1689191415; bh=RWAkhT59zZM0AfIRKdW4h+zvOFYdEnDRJrBHYKcnTxc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=H7hNWhlGBkazO4KwCcPCf5NX6O+ItnAOS1kkPsx/K9jfr2B/Vxk9k3CZ4fcty4xK/snGPHD7NrRmAi8b7+F0lBi5lTcni9/CODrfwjqXNKxsGBwf1ccNPKsBqpsIaS09S6ARQ5M94ob8oVe6qaxi2SghSRmRokKn6c/UtmxLZt0UtENrhf3sMqskVyOgBFcGSXyMv5lnBe71Z1aqp75bjKe2djR830DWhPMCUdKqld3GJgZJxhI0Yn2WRh9b7ia/Qb7NX7fiR9q0Qm7dJ/p4pejNOd7NG9Xz3gv/I2LFZ2rxhjE6WCr4pI9XnY463zfHx4ca/gf09F3db0CtzTntjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689191415; bh=THHorsTaa2MP6suR4fxi9S6ZelrgpwGnQq4ICMK7tnE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=n5zVIvvJgk6F9L8BVOze0V7ytu+p3x22rafAjYaflyQCaUnRKGDIEt0R2kPys2TFYp2HO+Yc1VuaJ1WMAseF8V2uuMYv7NImW4saEtqv/v4Tg6WUCORlP+rXjeyxDd6xgXtdJm9QUnDytxonmQQfULwkGX8iYiVr2aR7IcHvbLJ6nniNQ9eiRDlOIWI9DNqjMdxKhhh7G+d9P9kG076j964jAzPI8q84FKU6RuDd6x6B09nU4o2H4QGnmjzBHSO1Jj0h0orVKaSkuVbN9TCQsdyIyJwQlE9ZrwbQiNaAfl0Kx+h65dlh/WL3H33kR9YA7hIzcTY292b9p3FENb/gcg==
X-YMail-OSG: qG6Nc_4VM1mLFs8qAvV_3_6TP6d54il25rPdfU6sjqginxCWIK0ZgcUKoSDQrlh
 tJbB83PTJq21Qd9717vagpunf_bUoVTBMC810ebsvniL03kFGi18NVKKqVWZiQC90PwGXa_.EqVo
 LX92bHwnge7RsAkc9VLNoIKZfzzx0IrKm1izqfYJDuGejnaZkqH2yhHdbmm_b2ugrYtKCi735KGE
 VZnIAboImERQl90iYBTryDC89o3La7Nj7K65TZSD9ajze0w809Xrmh6fd571qYsN7I4ZOBspr1It
 BKKzTTQ4Z7fivbYwOTJeaZPYnQvJ2QdYpW90Av9AzdCG7fUi2_A7Yz7wIqehLMpz0F2aeBtWltWw
 A1KacSoaMM3y4kBxQB7jL_1E2SaDRm2Mge.xqenitqxV47n8eP8PQXthj_LcipHdrb2AzAduiE9Q
 XU.GhrkJPQF9V22G_06TinTgJ.7_aPclvcmALBVRxqN7OUvimnaPhd64GMgpjz_NUHaokOU8QBu9
 qkGVb_fwJBksZ_sPeOe1SEseOoxuveqjhZJZ20aLv0TnXyc.TxlXQrJ0dbTzALyKdVhVRPWzcUxj
 EqUu3xeu0fbx1hLvbqhFSF1cW.9olau8rAGzlY1Az1ZuE6cLL9tXTEuzAiLcowlzwxA5z9IeLabO
 laPOLltC1Onako3uTcTyheZQ6FwrTtpbl4Lz907_2jplPAQUD.Zcd3poY3IeZf98lg_Q7Hn3NBpr
 juh_E70P20pah_BLCDs0aAFBelRNAxnfSq0QrsFhC9MWhVdBq_R9mc32MsPhfCz2mhxquNcjQR94
 An8LqymU_u719TuUYCgtEzkzC9h915aCpQ6Fsnt0urHg_i9AYQ_zeQvL6IDZEISOVRbpJK989lUa
 Slyb6dakvZ2LbXSK0z3J2OA_.KxADNDiRgxbgEOO_oGyv7ieeEoDWOBtb0UWaFTCfTheo5Hm9k3T
 u9_Elo3mzeaIFX4ZA89fJiSYZ3FfMfaqsARFCacJXJktLHG_VFd8QrHuIZGFOLLHgYrx0HfRl0zH
 xALfmwUlYU7EbUa_DOtCrUBhkrTtsIEWMhVaMoBHvdO.LMOD2MFbJRIn06fnYcQO4tu3kA28x8Fu
 WgUu4SCQZLL8RFQN0wCBauPqes8pD8aBE4jGPzhnCw2Vh1Nciam_V.qFZGEOI0LrTGUsajVWUUkB
 8Kzuh52vgcRhju6Wg.RwHV3XbLC._0W9zpSdz4ldU0jl4AAXpFku_hUL7jzfZh0ctWa.rx0qfTFf
 sXiMjQeecr0tKHacvO5ufywzEUPyqZ3MX91wWS3HX6Lijr56nLND8kLxHRj4vH0Jh9uayLhZMgQI
 QGrFOArC8J24gwa3p7QckD73qW_sOrp05.W_hplkfIKxbTmRf_7gwfleQI18aSlYQCJ5POKKULvz
 BMXNyCJ.sMh27cz1OYiHx.yFPpBxPpXgKUqJKQYseXosozxCEHViUoIQeOW4OsmPrigfIP7aaL8.
 yEOG8F3rLvX_TIB2wxUz11c2IilySDrFvKXgiANSBKNYM70RFcR4su9hS5ByKFJO69sDN.QOh.a8
 FQe5EsdfRWA7U4FWod9CM8xP3LEBptgwE1ldSkY_ZHr.SVqBa97esQGGD9p0scVtgAAWDX9VIB3w
 2ETBjkJu6gCeFp2tCt4zFWGARPHpMU79sdABPPfvSgO2uVpKH96VJvOPwZ5qI3uB9Czffz_vR7mw
 MQqkBD6FFr.ZiGFFK_.6.EXpvHMNjRq4ByHX2xI0_AFMq0kYvW9rD78WhNrW4.zyJpR9_KwjsMta
 Re8iH0IHFRJ2xjXadhWxHD4o0wPkaG33md7lu59KLkArXCUiJKCzRb_3rezdVIkFMXDfQft8i8WA
 RKJeLZgExLNb9Oy1GFF7I5S2OB4k4zbD5tE0lZT4UtxK7p.8nxw7n84gxyKUsSjaytC.yWfNb.Xt
 A2RH9A8scvpdFDmu.BMgqI120nHJ4nr5a9RhLmLZ6QzqCdVDrXC1BBiROKQ5W7JiasAq5Skunmtj
 b3cg.tLICYuE9ZZQbGOlOl2pD1H3iGXu_8cV2ADKx.OVqWc1s36SjBchQ.g0KA8FGx523YC9rBRx
 bnsEEtdXKl4lZ9s25t8HbEbAa_5waLUaG5xJpTJsCoIO9O8r5Th8Ed5KXt9J6C2aZVyTSAt5hF9J
 UCSYI6N5xDzPMfR8hkpbh80h7CrEK05.nQZNFXPNBZfXwRdFOx1XW6dyTOTgqrN3f0Lxwp2eFIO7
 FGHfs3pitFCEgy8pP8YSoYVxANoY2XnWYwv32IUbnPLRIP4tOPOoWaCZuPnnAU.71tm_.PAAlV9f
 NhxN4RY_pu.Fy2KOOOf75YQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: f03bcd76-0802-4e51-a492-99ad6d1058e2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Wed, 12 Jul 2023 19:50:15 +0000
Received: by hermes--production-ir2-7858d959bd-hmv8h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca8b1e30b4f74ff6f1793e599fa400fa;
          Wed, 12 Jul 2023 19:50:14 +0000 (UTC)
Message-ID: <3376e14a-4fc7-160e-509e-8dcbe627ef62@rocketmail.com>
Date:   Wed, 12 Jul 2023 21:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-serranove: Add
 RT5033 PMIC with charger
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230619203743.8136-1-jahau.ref@rocketmail.com>
 <20230619203743.8136-1-jahau@rocketmail.com>
 <02fe7c1e-cb6a-14bc-73fc-04956a2b8396@kernel.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <02fe7c1e-cb6a-14bc-73fc-04956a2b8396@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Mailer: WebService/1.1.21638 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpDYzogUm9iLCBDaGFud29vICYgTXl1bmdKb28NCg0KT24gMTEu
MDcuMjMgMDg6MTMsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQouLi4NCj4gVGhpcyBh
cHBlYXJlZCBpbiB0b2RheSdzIG5leHQgbmV4dC0yMDIzMDcxMSBhbmQgY2F1c2VzIG5ldyB3
YXJuaW5ncw0KPiANCj4gbXNtODkxNi1zYW1zdW5nLXNlcnJhbm92ZS5kdGI6IGV4dGNvbkAx
NDogJ2Nvbm5lY3RvcicgZG9lcyBub3QgbWF0Y2ggYW55DQo+IG9mIHRoZSByZWdleGVzOiAn
cGluY3RybC1bMC05XSsnDQo+IGh0dHBzOi8va3J6ay5ldS8jL2J1aWxkZXJzLzkwL2J1aWxk
cy80MC9zdGVwcy8xNy9sb2dzL3N0ZGlvDQo+IA0KPiBUaGUgY29tbWl0IG1lbnRpb25zIHJ0
NTAzMywgYnV0IHRoYXQgaXMgbm90IHRoZSBzY2hlbWEgYmVpbmcgaGVyZQ0KPiB0ZXN0ZWQs
IHNvIGNsZWFybHkgdGhpcyBpcyB3cm9uZyBvciBiaW5kaW5ncyB3ZXJlIG5vdCB1cGRhdGVk
Lg0KPiANCj4gUGxlYXNlIGZpeCAoYW5kIHRlc3QgeW91ciBmdXR1cmUgcGF0Y2hlcykuDQoN
ClRoZSBpbXBsZW1lbnRhdGlvbiB5b3Ugc2VlIGluIHRoaXMgcGF0Y2ggZm9sbG93cyB0aGUg
Z3VpZGFuY2Ugb2YgeW91cnMgDQphbmQgUm9i4oCZcy4gSSBhbHJlYWR5IGV4cHJlc3NlZCBt
eSBkaXNjb250ZW50IGFib3V0IGl0IGJlZm9yZS4NCg0KVG8gc29sdmUgdGhlIG1lc3NhZ2Us
IHRoZSBkdC1iaW5kaW5ncyBvZiBleHRjb24gZGV2aWNlIHNtNTUwMi1tdWljIFsxXSANCndv
dWxkIG5lZWQgdG8gYmUgY2hhbmdlZCB0byBhbGxvdyBhICJjb25uZWN0b3IiIHN1Yi1ub2Rl
LiBUaGF04oCZcyBub3QgdGhlIA0KcmlnaHQgYXBwcm9hY2guDQoNCkkgc3RpbGwgaGF2ZSB0
aGUgaW1wcmVzc2lvbiB0aGF0IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlzIGJhc2Vk
IG9uIA0KbWlzdW5kZXJzdGFuZGluZ3MuIEkgZG8gdGhpbmsgUm9i4oCZcyBjb21tZW50IHRo
YXQgZXhjb24gcGhhbmRsZSBiZWluZyANCmRlcHJlY2F0ZWQgWzJdIGlzIHZhbGlkIGZvciB0
aGUgVVNCIHN1YnN5c3RlbS4gWW91ciBzdWdnZXN0aW9uIHRvIGNoZWNrIA0KInBvcnRzIGdy
YXBoIiwgIm9yaWVudGF0aW9uIiBhbmQgInVzYi1yb2xlLXN3aXRjaCIgYXBwbGllcyB0byBV
U0IgDQpzdWJzeXN0ZW0gYXMgd2VsbCBbM10uIFJvYiB0b29rIHRoZSB0aW1lIHRvIGFkZCBt
b3JlIGV4cGxhbmF0aW9uIFs0XSBidXQgDQppdOKAmXMgc3RpbGwgYWJvdXQgaGFuZGxpbmcg
Y29ubmVjdG9ycyBpbiB0aGUgbW9yZSBzdHJpY3Qgc2Vuc2UsIHdoaWNoIGlzIA0KY2lyY2xp
bmcgYXJvdW5kIFVCUyBzdWJzeXN0ZW0uDQoNClRoZXNlIGRpc2N1c3Npb25zIGxlZCB0byBh
IHN0cmFuZ2VseSBtaXhlZC11cCByZXN1bHQuIEkgd2FzIHB1c2hlZCB0byANCmltcGxlbWVu
dCB0aGUgVVNCIHN1YnN5c3RlbSBjb25uZWN0b3IgYXBwcm9hY2ggdXBvbiBhbiBleGN0b24g
c3Vic3lzdGVtIA0KZGV2aWNlLiBBcyB0aGUgc3RhbmRhcmQgVVNCIGNvbm5lY3RvciBhcHBy
b2FjaCBkaWRu4oCZdCBmaXQsIHdlIHN3aXRjaGVkIA0KdG8gYSB2ZW5kb3Itc3BlY2lmaWMg
Y29ubmVjdG9yIHBoYW5kbGUgWzVdLiBJbiBmYWN0IGl04oCZcyBraW5kIG9mIGEgDQp3b3Jr
YXJvdW5kIGZvciB0aGUgZXh0Y29uIHBoYW5kbGUuDQoNClRoZSBleHRjb24gZGV2aWNlIHNt
NTUwNCBpcyBhIHJlYWwgcGllY2Ugb2YgaGFyZHdhcmUuIEl04oCZcyBub3QgaGFuZGxlZCAN
CmJ5IFVTQiBzdWJzeXN0ZW0gYnV0IGJ5IGV4dGNvbiBzdWJzeXN0ZW0uIFRoZSBleGN0b24g
c3Vic3lzdGVtIGhhcyBhIA0KbWV0aG9kIGltcGxlbWVudGVkIHRvIGdldCB0aGUgZGV2aWNl
IGJ5IHBoYW5kbGUgWzZdLg0KDQpJIHRoZXJlZm9yZSBwcm9wb3NlIHRvIHVzZSB0aGUgcGhh
bmRsZSBvZiB0aGUgZXh0Y29uIHN1YnN5c3RlbS4gSSBtZWFuIA0KZXh0Y29uIHN1YnN5c3Rl
bSwgbm90IFVTQiBzdWJzeXN0ZW0uIEluIGNhc2UgeW91IGRpc2FncmVlLCBJIGtpbmRseSBh
c2sgDQp5b3UgdG8gdGFrZSBtb3JlIHRpbWUgdG8gYW5zd2VyIGluIG1vcmUgZGV0YWlsIGFu
ZCBlc3BlY2lhbGx5IA0KY2FzZS1yZWxhdGVkLiBBbmQgc3BlY2lmaWNhbGx5IHRvIEtyenlz
enRvZiBJIGFzayBmb3IgbW9yZSBwb2xpdGVuZXNzIGluIA0KeW91ciB3YXkgb2YgY29tbXVu
aWNhdGluZy4gSSB1bmRlcnN0YW5kIHlvdeKAmXJlIGFuc3dlcmluZyBodW5kcmVkcyBvZiAN
CnJlcXVlc3RzIGEgZGF5IGJ1dCB0aGUgY29tbXVuaWNhdGlvbiB3ZSBoYWQgaW4gdGhlIHBh
c3Qgd2Vla3MgaXMgcmVhbGx5IA0KZnJ1c3RyYXRpbmcuDQoNClsxXSANCmh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC90cmVlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9leHRjb24vc2lsaWNv
bm1pdHVzLHNtNTUwMi1tdWljLnlhbWw/aD12Ni41LXJjMQ0KWzJdIA0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtcG0vY292ZXIuMTY3NzYyMDY3Ny5naXQuamFoYXVAcm9ja2V0
bWFpbC5jb20vVC8jbTFmNTdhMzZkNTM0ZTY3N2Y4NDE1OGU2ODg2YzEzNDBlMDM2YWI1YzYN
ClszXSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBtL2NvdmVyLjE2ODI2MzY5
MjkuZ2l0LmphaGF1QHJvY2tldG1haWwuY29tL1QvI203NjcyYWQwNTU5MGU0MTIzYmE1NjIy
YmM1OWE5YjRkY2MwZjcwZTNhDQpbNF0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1wbS9jb3Zlci4xNjgyNjM2OTI5LmdpdC5qYWhhdUByb2NrZXRtYWlsLmNvbS9ULyNtNjVk
YjA3MDlmMGFkM2ZlYWM2YzI4OWY2NWJlNWEzNTFjYWNkMjgzNQ0KWzVdIA0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtcG0vMjAyMzA1MDYxNTU0MzUuMzAwNS0xLWphaGF1QHJv
Y2tldG1haWwuY29tL1QvI20yYWE2NTJjNDFiYWQ5M2Q2MDA0MmQ4MzFjNjM5N2U3ODM4ZDNj
YmZjDQpbNl0gDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2V4dGNvbi9leHRjb24uYz9o
PXY2LjUtcmMxI24xNDE3DQoNCktpbmQgcmVnYXJkcywNCkpha29iDQo=
