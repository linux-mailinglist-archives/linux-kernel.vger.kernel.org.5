Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F6A812F71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444253AbjLNLvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444321AbjLNLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:51:36 -0500
Received: from m1313.mail.163.com (m1313.mail.163.com [220.181.13.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08045132;
        Thu, 14 Dec 2023 03:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=wess2wbrbtdrqaABh3H3tzhNBOpg8+gOWbQqutaVXbM=; b=c
        YL8Q2ZMBW2bQgiijPru22vIUR67V/DjpAbvWlpsvfrOQ3JAUqgjUQcnYhJlYHvqx
        5EH5dGekbj/YAOb/D5Mtt1DLE9ytdej6ezSZcIA4wn8Mh7rEIWo0y0qEScyoTUjW
        c5CTiWlPLoZw7ukk2D0HTZOSNIsBJ4PP2U1NF6/g6Y=
Received: from andyshrk$163.com ( [58.22.7.114] ) by ajax-webmail-wmsvr13
 (Coremail) ; Thu, 14 Dec 2023 19:50:41 +0800 (CST)
X-Originating-IP: [58.22.7.114]
Date:   Thu, 14 Dec 2023 19:50:41 +0800 (CST)
From:   "Andy Yan" <andyshrk@163.com>
To:     "Maxime Ripard" <mripard@kernel.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Alex Bee" <knaerzche@gmail.com>,
        "Sandy Huang" <hjc@rock-chips.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "David Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH 04/11] drm/rockchip: inno_hdmi: Correctly setup HDMI
 quantization range
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <qr7if2k76wdqgevdcwqxj2dkcbga72owjqlk3qaazujhejjloo@cnvmuq27qqns>
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <w7cj24se5gjomfynp5yindnh3s2pea4p3f46u6y7lcci7hri32@62i6hg26pheb>
 <5f4fc919-681f-44ec-bd44-5788e5b718ca@gmail.com> <3053311.k3LOHGUjKi@diego>
 <qr7if2k76wdqgevdcwqxj2dkcbga72owjqlk3qaazujhejjloo@cnvmuq27qqns>
X-NTES-SC: AL_Qu2bAPmeu04v5yCQZekZnEobh+Y5UcK2s/ki2YFXN5k0oCnVyCwrXHZKMGf/0NmEFDq1uRG9cQJO2MBkWpFadLsRfr4bwVZIJ0eSlM9rzoWw
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <aba9149.493d.18c682a22bc.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: DcGowADnz8kR7Hplf24TAA--.9726W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEBZGXmVOA8tAYgACsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ckhp77yaCgrlnKggMjAyMy0xMi0xNCAxOTozNjowNe+8jCJNYXhpbWUgUmlwYXJkIiA8bXJpcGFy
ZEBrZXJuZWwub3JnPiDlhpnpgZPvvJoKPk9uIFRodSwgRGVjIDE0LCAyMDIzIGF0IDEyOjE3OjM0
UE0gKzAxMDAsIEhlaWtvIFN0w7xibmVyIHdyb3RlOgo+PiBBbSBEb25uZXJzdGFnLCAxNC4gRGV6
ZW1iZXIgMjAyMywgMTI6MTI6MDggQ0VUIHNjaHJpZWIgQWxleCBCZWU6Cj4+ID4gSGkgTWF4aW1l
Cj4+ID4gCj4+ID4gQW0gMTQuMTIuMjMgdW0gMDg6NTYgc2NocmllYiBNYXhpbWUgUmlwYXJkOgo+
PiA+ID4gSGkgQWxleCwKPj4gPiA+Cj4+ID4gPiBUaGFua3MgZm9yIHdvcmtpbmcgb24gdGhpcyEK
Pj4gPiA+Cj4+ID4gPiBPbiBXZWQsIERlYyAxMywgMjAyMyBhdCAwODo1MToxOFBNICswMTAwLCBB
bGV4IEJlZSB3cm90ZToKPj4gPiA+PiBUaGUgZGlzcGxheSBjb250cm9sbGVyIHdpbGwgYWx3YXlz
IGdpdmUgZnVsbCByYW5nZSBSR0IgcmVnYXJkbGVzcyBvZiB0aGUKPj4gPiA+PiBtb2RlIHNldCwg
YnV0IEhETUkgcmVxdWlyZXMgY2VydGFpbiBtb2RlcyB0byBiZSB0cmFuc21pdHRlZCBpbiBsaW1p
dGVkCj4+ID4gPj4gcmFuZ2UgUkdCLiBUaGlzIGlzIGVzcGVjaWFsbHkgcmVxdWlyZWQgZm9yIEhE
TUkgc2lua3Mgd2hpY2ggZG8gbm90IHN1cHBvcnQKPj4gPiA+PiBub24tc3RhbmRhcmQgcXVhbnRp
emF0aW9uIHJhbmdlcy4KPj4gPiA+Pgo+PiA+ID4+IFRoaXMgZW5hYmxlcyBjb2xvciBzcGFjZSBj
b252ZXJzaW9uIGZvciB0aG9zZSBtb2RlcyBhbmQgc2V0cyB0aGUKPj4gPiA+PiBxdWFudGl6YXRp
b24gcmFuZ2UgYWNjb3JkaW5nbHkgaW4gdGhlIEFWSSBpbmZvZnJhbWUuCj4+ID4gPj4KPj4gPiA+
PiBGaXhlczogNDEyZDRhZTZiN2E1ICgiZHJtL3JvY2tjaGlwOiBoZG1pOiBhZGQgSW5ub3NpbGlj
b24gSERNSSBzdXBwb3J0IikKPj4gPiA+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlZSA8a25hZXJ6
Y2hlQGdtYWlsLmNvbT4KPj4gPiA+PiAtLS0KPj4gPiA+PiAgIGRyaXZlcnMvZ3B1L2RybS9yb2Nr
Y2hpcC9pbm5vX2hkbWkuYyB8IDQwICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPj4gPiA+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQo+PiA+
ID4+Cj4+ID4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9pbm5vX2hk
bWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9pbm5vX2hkbWkuYwo+PiA+ID4+IGluZGV4
IDM0NTI1M2UwMzNjNS4uMzI2MjZhNzU3MjNjIDEwMDY0NAo+PiA+ID4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9yb2NrY2hpcC9pbm5vX2hkbWkuYwo+PiA+ID4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yb2NrY2hpcC9pbm5vX2hkbWkuYwo+PiA+ID4+IEBAIC0zMyw2ICszMyw3IEBAIHN0cnVjdCBo
ZG1pX2RhdGFfaW5mbyB7Cj4+ID4gPj4gICAJdW5zaWduZWQgaW50IGVuY19pbl9mb3JtYXQ7Cj4+
ID4gPj4gICAJdW5zaWduZWQgaW50IGVuY19vdXRfZm9ybWF0Owo+PiA+ID4+ICAgCXVuc2lnbmVk
IGludCBjb2xvcmltZXRyeTsKPj4gPiA+PiArCWJvb2wgcmdiX2xpbWl0ZWRfcmFuZ2U7Cj4+ID4g
Pj4gICB9Owo+PiA+ID4+ICAgCj4+ID4gPj4gICBzdHJ1Y3QgaW5ub19oZG1pX2kyYyB7Cj4+ID4g
Pj4gQEAgLTMwOCw2ICszMDksMTggQEAgc3RhdGljIGludCBpbm5vX2hkbWlfY29uZmlnX3ZpZGVv
X2F2aShzdHJ1Y3QgaW5ub19oZG1pICpoZG1pLAo+PiA+ID4+ICAgCWVsc2UKPj4gPiA+PiAgIAkJ
ZnJhbWUuYXZpLmNvbG9yc3BhY2UgPSBIRE1JX0NPTE9SU1BBQ0VfUkdCOwo+PiA+ID4+ICAgCj4+
ID4gPj4gKwlpZiAoaGRtaS0+aGRtaV9kYXRhLmVuY19vdXRfZm9ybWF0ID09IEhETUlfQ09MT1JT
UEFDRV9SR0IpIHsKPj4gPiA+PiArCQlkcm1faGRtaV9hdmlfaW5mb2ZyYW1lX3F1YW50X3Jhbmdl
KCZmcmFtZS5hdmksCj4+ID4gPj4gKwkJCQkJCSAgICZoZG1pLT5jb25uZWN0b3IsIG1vZGUsCj4+
ID4gPj4gKwkJCQkJCSAgIGhkbWktPmhkbWlfZGF0YS5yZ2JfbGltaXRlZF9yYW5nZSA/Cj4+ID4g
Pj4gKwkJCQkJCSAgIEhETUlfUVVBTlRJWkFUSU9OX1JBTkdFX0xJTUlURUQgOgo+PiA+ID4+ICsJ
CQkJCQkgICBIRE1JX1FVQU5USVpBVElPTl9SQU5HRV9GVUxMKTsKPj4gPiA+PiArCX0gZWxzZSB7
Cj4+ID4gPj4gKwkJZnJhbWUuYXZpLnF1YW50aXphdGlvbl9yYW5nZSA9IEhETUlfUVVBTlRJWkFU
SU9OX1JBTkdFX0RFRkFVTFQ7Cj4+ID4gPj4gKwkJZnJhbWUuYXZpLnljY19xdWFudGl6YXRpb25f
cmFuZ2UgPQo+PiA+ID4+ICsJCQlIRE1JX1lDQ19RVUFOVElaQVRJT05fUkFOR0VfTElNSVRFRDsK
Pj4gPiA+PiArCX0KPj4gPiA+PiArCj4+ID4gPj4gICAJcmV0dXJuIGlubm9faGRtaV91cGxvYWRf
ZnJhbWUoaGRtaSwgcmMsICZmcmFtZSwgSU5GT0ZSQU1FX0FWSSwgMCwgMCwgMCk7Cj4+ID4gPj4g
ICB9Cj4+ID4gPj4gICAKPj4gPiA+PiBAQCAtMzM0LDE0ICszNDcsMjIgQEAgc3RhdGljIGludCBp
bm5vX2hkbWlfY29uZmlnX3ZpZGVvX2NzYyhzdHJ1Y3QgaW5ub19oZG1pICpoZG1pKQo+PiA+ID4+
ICAgCWlmIChkYXRhLT5lbmNfaW5fZm9ybWF0ID09IGRhdGEtPmVuY19vdXRfZm9ybWF0KSB7Cj4+
ID4gPj4gICAJCWlmICgoZGF0YS0+ZW5jX2luX2Zvcm1hdCA9PSBIRE1JX0NPTE9SU1BBQ0VfUkdC
KSB8fAo+PiA+ID4+ICAgCQkgICAgKGRhdGEtPmVuY19pbl9mb3JtYXQgPj0gSERNSV9DT0xPUlNQ
QUNFX1lVVjQ0NCkpIHsKPj4gPiA+PiAtCQkJdmFsdWUgPSB2X1NPRl9ESVNBQkxFIHwgdl9DT0xP
Ul9ERVBUSF9OT1RfSU5ESUNBVEVEKDEpOwo+PiA+ID4+IC0JCQloZG1pX3dyaXRlYihoZG1pLCBI
RE1JX1ZJREVPX0NPTlRSTDMsIHZhbHVlKTsKPj4gPiA+PiAtCj4+ID4gPj4gLQkJCWhkbWlfbW9k
YihoZG1pLCBIRE1JX1ZJREVPX0NPTlRSTCwKPj4gPiA+PiAtCQkJCSAgbV9WSURFT19BVVRPX0NT
QyB8IG1fVklERU9fQzBfQzJfU1dBUCwKPj4gPiA+PiAtCQkJCSAgdl9WSURFT19BVVRPX0NTQyhB
VVRPX0NTQ19ESVNBQkxFKSB8Cj4+ID4gPj4gLQkJCQkgIHZfVklERU9fQzBfQzJfU1dBUChDMF9D
Ml9DSEFOR0VfRElTQUJMRSkpOwo+PiA+ID4+IC0JCQlyZXR1cm4gMDsKPj4gPiA+PiArCQkJaWYg
KGRhdGEtPmVuY19pbl9mb3JtYXQgPT0gSERNSV9DT0xPUlNQQUNFX1JHQiAmJgo+PiA+ID4+ICsJ
CQkgICAgZGF0YS0+ZW5jX291dF9mb3JtYXQgPT0gSERNSV9DT0xPUlNQQUNFX1JHQiAmJgo+PiA+
ID4+ICsJCQkgICAgaGRtaS0+aGRtaV9kYXRhLnJnYl9saW1pdGVkX3JhbmdlKSB7Cj4+ID4gPj4g
KwkJCQljc2NfbW9kZSA9IENTQ19SR0JfMF8yNTVfVE9fUkdCXzE2XzIzNV84QklUOwo+PiA+ID4+
ICsJCQkJYXV0b19jc2MgPSBBVVRPX0NTQ19ESVNBQkxFOwo+PiA+ID4+ICsJCQkJYzBfYzJfY2hh
bmdlID0gQzBfQzJfQ0hBTkdFX0RJU0FCTEU7Cj4+ID4gPj4gKwkJCQljc2NfZW5hYmxlID0gdl9D
U0NfRU5BQkxFOwo+PiA+ID4+ICsJCQl9IGVsc2Ugewo+PiA+ID4+ICsJCQkJdmFsdWUgPSB2X1NP
Rl9ESVNBQkxFIHwgdl9DT0xPUl9ERVBUSF9OT1RfSU5ESUNBVEVEKDEpOwo+PiA+ID4+ICsJCQkJ
aGRtaV93cml0ZWIoaGRtaSwgSERNSV9WSURFT19DT05UUkwzLCB2YWx1ZSk7Cj4+ID4gPj4gKwkJ
CQloZG1pX21vZGIoaGRtaSwgSERNSV9WSURFT19DT05UUkwsCj4+ID4gPj4gKwkJCQkJICBtX1ZJ
REVPX0FVVE9fQ1NDIHwgbV9WSURFT19DMF9DMl9TV0FQLAo+PiA+ID4+ICsJCQkJCSAgdl9WSURF
T19BVVRPX0NTQyhBVVRPX0NTQ19ESVNBQkxFKSB8Cj4+ID4gPj4gKwkJCQkJICB2X1ZJREVPX0Mw
X0MyX1NXQVAoQzBfQzJfQ0hBTkdFX0RJU0FCTEUpKTsKPj4gPiA+PiArCQkJCXJldHVybiAwOwo+
PiA+ID4+ICsJCQl9Cj4+ID4gPj4gICAJCX0KPj4gPiA+PiAgIAl9Cj4+ID4gPj4gICAKPj4gPiA+
PiBAQCAtNDU4LDYgKzQ3OSw5IEBAIHN0YXRpYyBpbnQgaW5ub19oZG1pX3NldHVwKHN0cnVjdCBp
bm5vX2hkbWkgKmhkbWksCj4+ID4gPj4gICAJZWxzZQo+PiA+ID4+ICAgCQloZG1pLT5oZG1pX2Rh
dGEuY29sb3JpbWV0cnkgPSBIRE1JX0NPTE9SSU1FVFJZX0lUVV83MDk7Cj4+ID4gPj4gICAKPj4g
PiA+PiArCWhkbWktPmhkbWlfZGF0YS5yZ2JfbGltaXRlZF9yYW5nZSA9Cj4+ID4gPj4gKwkJZHJt
X2RlZmF1bHRfcmdiX3F1YW50X3JhbmdlKG1vZGUpID09IEhETUlfUVVBTlRJWkFUSU9OX1JBTkdF
X0xJTUlURUQ7Cj4+ID4gPj4gKwo+PiA+ID4gVGhpcyBwYXRjaCBjb25mbGljdHMgaGVhdmlseSB3
aXRoIG15IGlubm9faGRtaSBwYXRjaGVzIGhlcmUgKHBhdGNoZXMgMjIgdG8gMzgpOgo+PiA+ID4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZHJpLWRldmVsLzIwMjMxMjA3LWttcy1oZG1pLWNvbm5l
Y3Rvci1zdGF0ZS12NS0wLTY1MzhlMTlkNjM0ZEBrZXJuZWwub3JnLwo+PiA+IEknbSBhd2FyZSBv
ZiB0aGF0IGFuZCBJIG1lbnRpb25lZCBpdCBpbiB0aGUgY292ZXIgbGV0dGVyLiBZb3VyIHNlcmll
cyBpcyAKPj4gPiBub3QgbWVyZ2VkIHlldCBhbmQgaXQgZGlkbid0IGdldCBtdWNoIGZlZWRiYWNr
IHNvIGZhci4gV2hhdCBpcyB0aGUgCj4+ID4gc3RhdHVzIHRoZXJlPyBFc3BlY2lhbGx5IGJlY2F1
c2UgeW91IGFyZSByZW1vdmluZyB0aGluZ3MgZnJvbSBpbm5vLWhkbWkgCj4+ID4gZHJpdmVyICh3
aGljaCBhcmVuJ3QgcmVhbGx5IHJlcXVpcmVkIHRvIHJlbW92ZSB0aGVyZSkgd2hpY2ggd2lsbCBJ
IGhhdmUgCj4+ID4gdG8gcmVpbnRyb2R1Y2UuCj4+IAo+PiBTYWRseSBJIGhhdmVuJ3QgZm91bmQg
dGhlIHRpbWUgdG8gbG9vayBjbG9zZXIgYXQgTWF4aW1lJ3Mgc2VyaWVzIHNvIGZhciwKPj4gYnV0
IEkgZ290IHRoZSBpbXByZXNzaW9uIHRoYXQgaXQgc2VwYXJhdGVzIGludG8gbXVsdGlwbGUgY2xl
YW51cCBzdGVwcwo+PiBmb3IgYSBudW1iZXIgb2YgY29udHJvbGxlcnMuCj4KPlllYWgsIG9uZSBv
ZiB0aGUgcHJldmlvdXMgdmVyc2lvbiBjb21tZW50IHdhcyB0byBzdXBwb3J0IG1vcmUKPmNvbnRy
b2xsZXJzIHRoYW4gdmM0LCB3aGljaCBpcyBmYWlyLiBTbyBJIGVuZGVkIHVwIHJld29ya2luZyBh
bmQKPmNvbnZlcnRpbmcgbXVsdGlwbGUgY29udHJvbGxlcnMsIGJ1dCBtb3N0IG9mIHRoZSBjbGVh
biB1cCBjaGFuZ2VzIGNhbiBiZQo+YXBwbGllZCBvdXRzaWRlIG9mIHRoYXQgc2VyaWVzIGp1c3Qg
ZmluZS4KPgo+SSBqdXN0IGRpZG4ndCBmaW5kIHNvbWVvbmUgdG8gdGVzdCAvIHJldmlldyB0aGVt
IHlldCA6KQoKSSB3aWxsIHRyeSB0byBicmluZyB1cCBteSByazMwMzYga3lsaW4gYm9hcmQgd2hp
dGggbWFpbmxpbmUga2VybmVsIHRoaXMgd2Vla2VuZO+8jCB0aGVuIEkgY2FuIGRvIHNvbWUgdGVz
dHMuCgo+Cj5NYXhpbWUK
