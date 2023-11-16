Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC907EDA99
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344721AbjKPEJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPEJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:09:27 -0500
Received: from m1313.mail.163.com (m1313.mail.163.com [220.181.13.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF606194;
        Wed, 15 Nov 2023 20:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=Lm+lGQ6cuTe+iguvJaCIfyWXgvW+qe8m5TXZ8O2Dx8g=; b=A
        hCVZXUdwDlLx4W6LruaAt1/ZFmVEnUjrKCLYBee356O8nEUIclNP7t0UdwF+ON8i
        Q4Yz6uoLRVLQBUx0s3+E9Tsi555rsaIc6Du49qeXjf5PIPYycQctlpTqIB6TF8BK
        RVXG5FfhIN+vaQ+hwlyJwTmp/qyrlsz7y9u7Bim4x0=
Received: from 00107082$163.com ( [111.35.186.243] ) by ajax-webmail-wmsvr13
 (Coremail) ; Thu, 16 Nov 2023 12:08:14 +0800 (CST)
X-Originating-IP: [111.35.186.243]
Date:   Thu, 16 Nov 2023 12:08:14 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Namhyung Kim" <namhyung@kernel.org>
Cc:     "Peter Zijlstra" <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [Regression or Fix]perf: profiling stats sigificantly
 changed for aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <CAM9d7cgjCKynoTC0L53pEXnCWHF7AZ8Gr2a0xQnes7L24KVNsA@mail.gmail.com>
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com>
 <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com>
 <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
 <1a1338d0.6b3a.18bd3c09056.Coremail.00107082@163.com>
 <CAM9d7cgjCKynoTC0L53pEXnCWHF7AZ8Gr2a0xQnes7L24KVNsA@mail.gmail.com>
X-NTES-SC: AL_Qu2bAv2buE4i4iCfZ+kZnEYQheY4XMKyuPkg1YJXOp80oCnX5x0xXHZ+L0Dc0NmkDwW8uRGlfzNf28ZCUqVKXrhHHyaxWExH7dqCJUN0zxoD
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <489ecb9e.28cc.18bd650affa.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: DcGowAD3n8WvlVVl9B8IAA--.64573W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiEB8qql8YMgdEUgAKsh
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMTEtMTYgMDA6MjY6MDYsICJOYW1oeXVuZyBLaW0iIDxuYW1oeXVuZ0BrZXJuZWwu
b3JnPiB3cm90ZToKPk9uIFdlZCwgTm92IDE1LCAyMDIzIGF0IDg6MTLigK9BTSBEYXZpZCBXYW5n
IDwwMDEwNzA4MkAxNjMuY29tPiB3cm90ZToKPj4KPj4KPj4g5ZyoIDIwMjMtMTEtMTUgMjM6NDg6
MzPvvIwiTmFtaHl1bmcgS2ltIiA8bmFtaHl1bmdAa2VybmVsLm9yZz4g5YaZ6YGT77yaCj4+ID5P
biBXZWQsIE5vdiAxNSwgMjAyMyBhdCAzOjAw4oCvQU0gRGF2aWQgV2FuZyA8MDAxMDcwODJAMTYz
LmNvbT4gd3JvdGU6Cj4+ID4+Cj4+ID4+Cj4+ID4+Cj4+ID4+IEF0IDIwMjMtMTEtMTUgMTg6MzI6
NDEsICJQZXRlciBaaWpsc3RyYSIgPHBldGVyekBpbmZyYWRlYWQub3JnPiB3cm90ZToKPj4gPj4g
Pgo+PiA+PiA+TmFtaHl1bmcsIGNvdWxkIHlvdSBwbGVhc2UgdGFrZSBhIGxvb2ssIHlvdSBrbm93
IGhvdyB0byBvcGVyYXRlIHRoaXMKPj4gPj4gPmNncm91cCBzdHVmZi4KPj4gPj4gPgo+PiA+Pgo+
PiA+PiBNb3JlIGluZm9ybWF0aW9uLCAgSSBydW4gdGhlIHByb2ZpbGluZyB3aXRoIDhjcHUgbWFj
aGluZSBvbiBhIFNTRCB3aXRoIGV4dDQgZmlsZXN5c3RlbSA6Cj4+ID4+Cj4+ID4+ICMgbWtkaXIg
L3N5cy9mcy9jZ3JvdXAvbXl0ZXN0Cj4+ID4+ICMgZWNobyAkJCA+IC9zeXMvZnMvY2dyb3VwL215
dGVzdC9jZ3JvdXAucHJvY3MKPj4gPj4gIyMgU3RhcnQgcHJvZmlsaW5nIHRhcmdldGluZyBjZ3Jv
dXAgL3N5cy9mcy9jZ3JvdXAvbXl0ZXN0ICAgb24gYW5vdGhlciB0ZXJtaW5hbAo+PiA+PiAjIGZp
byAtLXJhbmRyZXBlYXQ9MSAtLWlvZW5naW5lPWxpYmFpbyAtLWRpcmVjdD0xIC0tbmFtZT10ZXN0
ICAtLWJzPTRrIC0taW9kZXB0aD02NCAtLXNpemU9MUcgLS1yZWFkd3JpdGU9cmFuZHJ3ICAtLXJ1
bnRpbWU9NjAwIC0tbnVtam9icz00IC0tdGltZV9iYXNlZD0xCj4+ID4+Cj4+ID4+IEkgZ290IGEg
ZmVlbGluZyB0aGF0IGYwNmNjNjY3Zjc5OTAgd291bGQgZGVjcmVhc2UgdG90YWwgc2FtcGxlcyBi
eSAxMCV+MjAlIHdoZW4gcHJvZmlsaW5nIElPIGJlbmNobWFyayB3aXRoaW4gY2dyb3VwLgoKCj4K
PlRoZW4gd2hhdCBpcyB5b3VyIHByb2ZpbGluZyB0b29sPyAgV2hlcmUgZGlkIHlvdSBzZWUKPnRo
ZSAxMCV+MjAlIGRyb3AgaW4gc2FtcGxlcz8KPgoKSSB3cm90ZSBhIHNpbXBsZS9yYXcgdG9vbCBq
dXN0IGZvciBwcm9maWxpbmcgY2FsbGNoYWlucywgd2hpY2ggdXNlIHBlcmZfZXZlbnRfb3BlbiB3
aXRoIGZvbGxvd2luZyBhdHRyOgogICAgYXR0ci50eXBlID0gUEVSRl9UWVBFX1NPRlRXQVJFOwog
ICAgIGF0dHIuY29uZmlnID0gUEVSRl9DT1VOVF9TV19DUFVfQ0xPQ0s7CiAgICAgYXR0ci5zYW1w
bGVfZnJlcSA9IDc3NzsgLy8gYWRqdXN0IGl0CiAgICAgYXR0ci5mcmVxID0gMTsKICAgICBhdHRy
Lndha2V1cF9ldmVudHMgPSAxNjsKICAgICBhdHRyLnNhbXBsZV90eXBlID0gUEVSRl9TQU1QTEVf
VElEfFBFUkZfU0FNUExFX0NBTExDSEFJTjsKICAgICBhdHRyLnNhbXBsZV9tYXhfc3RhY2sgPSAz
MjsKClRoZSBzb3VyY2UgY29kZSBjb3VsZCBiZSBmb3VuZCBoZXJlOiBodHRwczovL2dpdGh1Yi5j
b20venEtZGF2aWQtd2FuZy9saW51eC10b29scy90cmVlL21haW4vcGVyZi9wcm9maWxlcgo+Pgo+
PiBJIGFtIG5vdCBleHBlcmllbmNlZCB3aXRoIHRoZSBwZXJmLXRvb2wgYXQgYWxsLCAgIHRvbyBj
b21wbGljYXRlZCBhIHRvb2wgZm9yIG1lLi4uLiBCdXQgSSB0aGluayBJIGNhbiB0cnkgaXQuCj4K
PkkgZmVlbCBzb3JyeSBhYm91dCB0aGF0LiAgSW4gbW9zdCBjYXNlcywganVzdCBgcGVyZiByZWNv
cmQgLWFgIGFuZAo+dGhlbiBgcGVyZiByZXBvcnRgIHdvdWxkIHdvcmsgd2VsbC4gOikKPgpUaGFu
a3MgZm9yIHRoZSBpbmZvcm1hdGlvbiwgIEkgdXNlIGZvbGxvd2luZyBjb21tYW5kIHRvIHByb2Zp
bGUgd2l0aCBwZXJmOgpgLi9wZXJmIHJlY29yZCAtYSAtZSBjcHUtY2xvY2sgLUcgbXl0ZXN0YApJ
IGhhdmUgcnVuIHNldmVyYWwgcm91bmQgb2YgdGVzdCwgYW5kIGJlZm9yZSBlYWNoIHRlc3QsIHRo
ZSBzeXN0ZW0gd2FzIHJlYm9vdGVkLCBhbmQgcGVyZiBvdXRwdXQgaXMKCk9uIDYuNy4wLXJjMToK
JCBzdWRvIC4vcGVyZiByZWNvcmQgLWEgLWUgY3B1LWNsb2NrIC1HIG15dGVzdAogIF5DWyBwZXJm
IHJlY29yZDogV29rZW4gdXAgNTI3IHRpbWVzIHRvIHdyaXRlIGRhdGEgXQogIFsgcGVyZiByZWNv
cmQ6IENhcHR1cmVkIGFuZCB3cm90ZSAxMzIuNjQ4IE1CIHBlcmYuZGF0YSAoMjQ3ODc0NSBzYW1w
bGVzKSBdICAKIC0tLXJlYm9vdAogICQgc3VkbyAuL3BlcmYgcmVjb3JkIC1hIC1lIGNwdS1jbG9j
ayAtRyBteXRlc3QKICBeQ1sgcGVyZiByZWNvcmQ6IFdva2VuIHVwIDQ3MyB0aW1lcyB0byB3cml0
ZSBkYXRhIF0KICBbIHBlcmYgcmVjb3JkOiBDYXB0dXJlZCBhbmQgd3JvdGUgMTE5LjIwNSBNQiBw
ZXJmLmRhdGEgKDIyMjY5OTQgc2FtcGxlcykgXQoKCk9uIDYuNy4wLXJjMSB3aXRoIGYwNmNjNjY3
Zjc5OTA5ZTkxNzU0NjBiMTY3YzI3N2I3YzY0ZDNkZjAgcmV2ZXJ0ZWQKCiQgc3VkbyAuL3BlcmYg
cmVjb3JkIC1hIC1lIGNwdS1jbG9jayAtRyBteXRlc3QKICBeQ1sgcGVyZiByZWNvcmQ6IFdva2Vu
IHVwIDU2NyB0aW1lcyB0byB3cml0ZSBkYXRhIF0KICBbIHBlcmYgcmVjb3JkOiBDYXB0dXJlZCBh
bmQgd3JvdGUgMTQyLjc3MSBNQiBwZXJmLmRhdGEgKDI2NjgyMjQgc2FtcGxlcykgXQogIC0tLXJl
Ym9vdAogICQgc3VkbyAuL3BlcmYgcmVjb3JkIC1hIC1lIGNwdS1jbG9jayAtRyBteXRlc3QKICBe
Q1sgcGVyZiByZWNvcmQ6IFdva2VuIHVwIDU1NyB0aW1lcyB0byB3cml0ZSBkYXRhIF0KICBbIHBl
cmYgcmVjb3JkOiBDYXB0dXJlZCBhbmQgd3JvdGUgMTQwLjYwNCBNQiBwZXJmLmRhdGEgKDI2Mjcx
Njcgc2FtcGxlcykgXQogIAoKSSBhbHNvIHJ1biB3aXRoIGAtRiA3NzdgLCB3aGljaCBpcyBzb21l
IHJhbmRvbSBudW1iZXIgSSB1c2VkIGluIG15IHRvb2wsICAgKGp1c3QgdG8gY29tcGFyZSB3aXRo
IG15IHRvb2wgKQoKT24gNi43LjAtcmMxCiQgc3VkbyAuL3BlcmYgcmVjb3JkIC1hIC1lIGNwdS1j
bG9jayAtRiA3NzcgLUcgbXl0ZXN0Cl5DWyBwZXJmIHJlY29yZDogV29rZW4gdXAgOTMgdGltZXMg
dG8gd3JpdGUgZGF0YSBdClsgcGVyZiByZWNvcmQ6IENhcHR1cmVkIGFuZCB3cm90ZSAyNC41NzUg
TUIgcGVyZi5kYXRhICg0NTUyMjIgc2FtcGxlcykgXSAoIE15IHRvb2wgaGF2ZSBvbmx5IH4zNTlL
IHNhbXBsZXMsIG5vdCBzdGFibGUpCgogIApPbiA2LjcuMC1yYzEgd2l0aCBmMDZjYzY2N2Y3OTkw
OWU5MTc1NDYwYjE2N2MyNzdiN2M2NGQzZGYwIHJldmVydGVkCiQgc3VkbyAuL3BlcmYgcmVjb3Jk
IC1hIC1lIGNwdS1jbG9jayAtRiA3NzcgLUcgbXl0ZXN0Cl5DWyBwZXJmIHJlY29yZDogV29rZW4g
dXAgOTggdGltZXMgdG8gd3JpdGUgZGF0YSBdClsgcGVyZiByZWNvcmQ6IENhcHR1cmVkIGFuZCB3
cm90ZSAyNS43MDMgTUIgcGVyZi5kYXRhICg0NzYzOTAgc2FtcGxlcykgXSAgKE15IHRvb2wgaGF2
ZSBhYm91dCB+NDQ2Sywgc3RhYmxlKQoKCkZyb20gdGhlIGRhdGEgSSBjb2xsZWN0ZWQsIEkgdGhp
bmsgdHdvIHByb2JsZW0gY291bGQgYmUgb2JzZXJ2ZWQgZm9yIGYwNmNjNjY3Zjc5OTA5ZTkxNzU0
NjBiMTY3YzI3N2I3YzY0ZDNkZjAKMS4gc2FtcGxlIG1pc3NpbmcuIAoyLiBzYW1wbGUgdW5zdGFi
bGUsIHRvdGFsIHNhbXBsZSBjb3VudCBkcmlmdCBhIGxvdCBiZXR3ZWVuIHRlc3RzLiAKClRoYW5r
cwpEYXZpZAoKCg==
