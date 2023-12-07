Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4436380847B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378728AbjLGJVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378696AbjLGJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:20:56 -0500
X-Greylist: delayed 922 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 01:19:56 PST
Received: from m133.mail.163.com (m133.mail.163.com [220.181.13.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17B4F1734;
        Thu,  7 Dec 2023 01:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=S0Dg85MYxbzWzz6JpvnPwr5bJdqD/IYGAk3vcMTo7A8=; b=N
        5Toopd71roA1NJeOJPGeSEWZLTtkCT+4BQDwf3O99weZvthzVdn6rqmjZPJNFYkh
        oFmU8YTz34KYzvlukAJM8HTxFTl8yN8mD5tGYeQzm2o53sIyhJYhgW8BfsgAuE9X
        R2mCrNFOqbHhe7PXfpkKD8QPysmMwVydPnwzSMr6uk=
Received: from andyshrk$163.com ( [58.22.7.114] ) by ajax-webmail-wmsvr3
 (Coremail) ; Thu, 7 Dec 2023 17:02:03 +0800 (CST)
X-Originating-IP: [58.22.7.114]
Date:   Thu, 7 Dec 2023 17:02:03 +0800 (CST)
From:   "Andy Yan" <andyshrk@163.com>
To:     "Keith Zhao" <keith.zhao@starfivetech.com>
Cc:     "Maxime Ripard" <mripard@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "William Qiu" <william.qiu@starfivetech.com>,
        "Xingyu Wu" <xingyu.wu@starfivetech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Shengyang Chen" <shengyang.chen@starfivetech.com>,
        "Jack Zhu" <jack.zhu@starfivetech.com>,
        "Changhuang Liang" <changhuang.liang@starfivetech.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "suijingfeng@loongson.cn" <suijingfeng@loongson.cn>
Subject: Re:Re: [v3 5/6] drm/vs: Add hdmi driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <40cdd3c7-174e-4611-9ea6-22cb56d1f62b@starfivetech.com>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
 <20231204123315.28456-6-keith.zhao@starfivetech.com>
 <esetsiqgqpk35zue4c6aq7l6zn4kezhxkqqa7ompaz2vhdy3lr@4d5awfqgs2ss>
 <94a1f9fc-82fb-4a04-a44b-f9b20c2bdfdd@starfivetech.com>
 <abdl6kmighvpwojvafq443q7grn6w3abwpvw7zwbna4jvtsvjf@fa42rv46n2wh>
 <40cdd3c7-174e-4611-9ea6-22cb56d1f62b@starfivetech.com>
X-NTES-SC: AL_Qu2bA/WYtk8p5SGYYOkXn0kXhec2W8Czvvgg34JRP5k0tinH2yYZXkdABEDs0s6MLC+JiCCtXCV+5sBIXqhZWbonSnjhy3zxeOPDLWRlKtSc
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <e90142d.44b1.18c43833b63.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: A8GowADnT74LinFlZaUtAA--.21688W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEhA-XmVOA0buTwABst
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

CgoKCkhpIEtlaXRo77yaCgoKCgoKCgoKCgoKQXQgMjAyMy0xMi0wNiAyMjoxMTozMywgIktlaXRo
IFpoYW8iIDxrZWl0aC56aGFvQHN0YXJmaXZldGVjaC5jb20+IHdyb3RlOgo+Cj4KPk9uIDIwMjMv
MTIvNiAyMDo1NiwgTWF4aW1lIFJpcGFyZCB3cm90ZToKPj4gT24gV2VkLCBEZWMgMDYsIDIwMjMg
YXQgMDg6MDI6NTVQTSArMDgwMCwgS2VpdGggWmhhbyB3cm90ZToKPj4+ID4+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBzdGFyZml2ZV9oZG1pX2R0X2lkc1tdID0gewo+Pj4gPj4g
Kwl7IC5jb21wYXRpYmxlID0gInN0YXJmaXZlLGpoNzExMC1pbm5vLWhkbWkiLH0sCj4+PiA+IAo+
Pj4gPiBTbyBpdCdzIGlubm8gaGRtaSwganVzdCBsaWtlIFJvY2tjaGlwIHRoZW4/Cj4+PiA+IAo+
Pj4gPiBUaGlzIHNob3VsZCBiZSBhIGNvbW1vbiBkcml2ZXIuCj4+Pgo+Pj4gUm9ja2NoaXAgaGFz
IGEgaW5ubyBoZG1pIElQLiBhbmQgU3RhcmZpdmUgaGFzIGEgaW5ubyBoZG1pIElQLgo+Pj4gYnV0
IHRoZSBoYXJld2F3cmUgZGlmZmVyZW5jZSBvZiB0aGVtIGlzIGJpZyAsIGl0IGlzIG5vdCBlYXN5
IHRvIHVzZSB0aGUgY29tbW9uIGRyaXZlcgo+Pj4gbWF5YmUgaSBuZWVkIHRoZSBpbm5vIGhkbWkg
dmVyc2lvbiBoZXJlIHRvIG1ha2UgYSBkaXN0aW5jdGlvbgo+PiAKPj4gSSBqdXN0IGhhZCBhIGxv
b2sgYXQgdGhlIHJvY2tjaGlwIGhlYWRlciBmaWxlOiBhbGwgdGhlIHJlZ2lzdGVycyBidXQgdGhl
Cj4+IFNUQVJGSVZFXyogb25lcyBhcmUgaWRlbnRpY2FsLgo+PiAKPj4gVGhlcmUncyBubyBuZWVk
IHRvIGhhdmUgdHdvIGlkZW50aWNhbCBkcml2ZXJzIHRoZW4sIHBsZWFzZSB1c2UgdGhlCj4+IHJv
Y2tjaGlwIGRyaXZlciBpbnN0ZWFkLgo+PiAKPj4gTWF4aW1lCj4KPm9rLCBoYXZlIGEgc2ltcGxl
IHRlc3QgLCBlZGlkIGNhbiBnZXQgLiBpIHdpbGwgY29udGludWUgCgpNYXliZSB5b3UgY2FuIHRh
a2UgZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1oZG1pIGFzIGEgcmVmZXJlbmNl
77yMIHRoaXMKaXMgYWxzbyBhIGhkbWkgaXAgdXNlZCBieSByb2NrY2hpcC9tZXNvbi9zdW54aS9q
ei9pbXjjgIIKV2UgZmluYWxseSBtYWtlIGl0IHNoYXJlIG9uZSBkcml2ZXLjgIIKPgo+Cj5fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+bGludXgtcmlzY3Yg
bWFpbGluZyBsaXN0Cj5saW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCj5odHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2Cg==
