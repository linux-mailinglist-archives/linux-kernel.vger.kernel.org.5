Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E5380A21B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjLHLY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHLYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:24:54 -0500
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E035610CA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:24:59 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:6111:0:640:fa53:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id ACD5460B5D;
        Fri,  8 Dec 2023 14:24:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qOcdk5dOquQ0-Kw9vcsYY;
        Fri, 08 Dec 2023 14:24:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
        t=1702034696; bh=dovtLz24oQKf7XZ4iAe8YtYbcL2wQcZRDAQKkvZh2bI=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=buOQDShPsf99FeUMkdsEwKAXRZ7NprOWTx1S/cRn8vCdKWqqtTcddyBKi2jXxQ/Ti
         gU9d27ySTzTXXHPcrydYYemWfKQOl+hNnKpTuqVsuDllrBwrUHnQ313ihpOL7PpPmW
         icdZunOVSnwG/0uF0TLTF8IzzSD85+KYW4NtxUZg=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <6bc0cf7ea58fae2e6a3765f673a777788d465984.camel@maquefel.me>
Subject: Re: [PATCH v5 19/39] mtd: rawnand: add support for ts72xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Jean Delvare <jdelvare@suse.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date:   Fri, 08 Dec 2023 14:24:52 +0300
In-Reply-To: <ZV3y-IJ7JSD3fJeI@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
         <20231122-ep93xx-v5-19-d59a76d5df29@maquefel.me>
         <ZV3y-IJ7JSD3fJeI@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQW5keSEKCk9uIFdlZCwgMjAyMy0xMS0yMiBhdCAxNDoyNCArMDIwMCwgQW5keSBTaGV2
Y2hlbmtvIHdyb3RlOgo+IE9uIFdlZCwgTm92IDIyLCAyMDIzIGF0IDExOjU5OjU3QU0gKzAzMDAs
IE5pa2l0YSBTaHViaW4gd3JvdGU6Cj4gPiBUZWNobm9sb2dpYyBTeXN0ZW1zIGhhcyBpdCdzIG93
biBuYW5kIGNvbnRyb2xsZXIgaW1wbGVtZW50YXRpb24gaW4KPiA+IENQTEQuCj4gCj4gLi4uCj4g
Cj4gPiArc3RhdGljIGludCB0czcyeHhfbmFuZF9hdHRhY2hfY2hpcChzdHJ1Y3QgbmFuZF9jaGlw
ICpjaGlwKQo+ID4gK3sKPiA+ICvCoMKgwqDCoMKgwqDCoHN3aXRjaCAoY2hpcC0+ZWNjLmVuZ2lu
ZV90eXBlKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIE5BTkRfRUNDX0VOR0lORV9UWVBFX1NP
RlQ6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNoaXAtPmVjYy5hbGdv
ID09IE5BTkRfRUNDX0FMR09fVU5LTk9XTikKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgY2hpcC0+ZWNjLmFsZ28gPSBOQU5EX0VDQ19BTEdPX0hBTU1J
Tkc7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2hpcC0+ZWNjLmFsZ28gPSBO
QU5EX0VDQ19BTEdPX0hBTU1JTkc7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
YnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqBjYXNlIE5BTkRfRUNDX0VOR0lORV9UWVBFX09OX0hP
U1Q6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7Cj4g
Cj4gPiArwqDCoMKgwqDCoMKgwqBkZWZhdWx0Ogo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDC
oMKgcmV0dXJuIDA7Cj4gCj4gTW92ZSB0aGlzIHRvIGRlZmF1bHQuCj4gCj4gPiArfQo+IAo+IC4u
Lgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBp
bnN0ci0+Y3R4LmFkZHIubmFkZHJzOyBpKyspCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlvd3JpdGU4KGluc3RyLT5jdHguYWRkci5hZGRyc1tpXSwg
ZGF0YS0KPiA+ID5iYXNlKTsKPiAKPiBpb3dyaXRlOF9yZXAoKSA/Cj4gCj4gPiArwqDCoMKgwqDC
oMKgwqBjYXNlIE5BTkRfT1BfREFUQV9JTl9JTlNUUjoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBpb3JlYWQ4X3JlcChkYXRhLT5iYXNlLCBpbnN0ci0+Y3R4LmRhdGEuYnVmLmlu
LAo+ID4gaW5zdHItPmN0eC5kYXRhLmxlbik7Cj4gCj4gSGVoZSwgeW91IGFyZSBldmVuIHVzaW5n
IGl0Li4uCj4gCj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoaW5zdHItPmRlbGF5X25z
KQo+IAo+IFdoYXQgd2lsbCBoYXBwZW4gaWYgeW91IGRyb3AgdGhpcyBjaGVjaz8KPiAKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuZGVsYXkoaW5zdHItPmRlbGF5X25zKTsKCk5v
IGlkZWEhIEkgd2FzIGFza2VkIHRvIGtlZXAgaXQgYnkgTWlxdWVsOgoKaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC84YmJlNjZhMjNlYjVjOGEyNDA0YjcyZDc1NGIxYmNiNmY0ZDIzODY3LmNh
bWVsQG1hcXVlZmVsLm1lL1QvCgpCdXQgaXQgbG9va3Mgc29tZSBvbmUgY2FuIGF0IGxlYXN0IHN0
aWxsIGRvIHNvbWUgY2FsY3VsYXRpb24gbGlrZToKCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29t
L2xpbnV4L2xhdGVzdC9zb3VyY2UvaW5jbHVkZS9saW51eC9kZWxheS5oI0w1MAoKQXQgd29yc3Qg
dHJ5IHRvIGRpdmlkZSBzb21ldGhpbmcuCgpEbyB5b3UgdGhpbmsgbmRlbGF5KGluc3RyLT5kZWxh
eV9ucykgaXMgc2FmZSBlbm91Z2ggPwoKCj4gCj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBp
bnQgcmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gbXRkX2RldmljZV91bnJlZ2lz
dGVyKG5hbmRfdG9fbXRkKGNoaXApKTsKPiA+ICvCoMKgwqDCoMKgwqDCoFdBUk5fT04ocmV0KTsK
PiAKPiBJcyB0aGlzIGEgcmVxdWlyZW1lbnQgYnkgTVREIHRvIGhhdmUgcmV0dXJuIHZhbHVlIGJl
aW5nIGNoZWNrZWQ/Cj4gCgpBc3dlcmVkIGJ5IE1pcXVlbC4KCg==

