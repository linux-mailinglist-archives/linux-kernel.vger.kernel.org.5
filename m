Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5247B7AFF20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjI0I44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjI0I4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:56:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F1BC0;
        Wed, 27 Sep 2023 01:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695805007; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Zm8GLrU1MNxBC9aF361aFkvIjSR93Vx3faqOS/N2/i2AGkbci3kjDMpfMSMpNy6FES
    KjhoBVegONov855zGp3b/BVKeCirj9qx5VvyNotXEZsfYibyVwxbZjtVzuN7j5yvBFck
    xG2OR7VJ7vAFNzeacsuw2f8Tu7kQ12pfBiIwRvKylNw9n/vij24sd3n+Y3Gt6LuVBMI/
    0NabU9eF/da9JloHlMGxqEyGI5Yipbxos2bAxQYmBD5k4Crr+loZ2XwZNnMvqaGLeD1V
    QktjklpVF45LR9b1olBfcg3BHCLbD+E3/4Sg4b/w9rBE/Q7fwWMkcdu/9yewyQTGmKPg
    UAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695805007;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fJGuq0tYyIItm5bwn7BBQ+jTzSYvqd6+c+LxPdUShVc=;
    b=eyyaAZ77IRjQ7qzkFsUbheA9Va1IMPdbGI6JDO17eR/IFk8+Lk36zHSRC02uFWV8Rk
    eqLpjUP435gaiOi0im+WV5aJuzGloEap0HPQjYeVg3rIHD9XSTE4YqaCpBkVOMc+V0lZ
    Iv8jIYBpw7Weceejpyix1FFVknyKZ04u6dHKAQJulzCxSVFZFh1nELfwionCVWN7MQjp
    w/PWqYeqN16Hn2yTIx/0HOvnW5BQosCA6uSNlbu8g9/bh3zFrWasvlxBavJQI26oTWti
    4XEcUdLWyCcMDWuBjvUV0P0RspXznS61CZVx3EZgxtAVtKrRX3/CAbeh26AJb2YW42r0
    yS+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695805007;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fJGuq0tYyIItm5bwn7BBQ+jTzSYvqd6+c+LxPdUShVc=;
    b=hPkRkOoi03QoC3/imS5wTjm0VKN6SeJqU3kOd1E+U0XRB2HxWGeXf+3sHp1iUb4qB4
    jviH3RIjq9CxziJI4lku1c7r0WZPq6afA4kq71+MTX9nDClM75Yg3ZKhRDgA2MPsTb+2
    WE4rtzFtmNJYjTWfZQnm0SvGuSvRkFfxLaoX0sKMfah2Kqmh7uElJldMSb4GdsKNY3oL
    z5VWiRyTpua47kkI/eavlLD7SneHi7aSzqXES635s2Qa8PbkN1l24PzAgXjQ8Zpar//C
    4ce/R5zCCY4Dbed0Ug1cefLu2656wsunsEW+kFUt/y9GEM6kTKuM2vgh7hazpgDdCfpV
    AoXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695805007;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fJGuq0tYyIItm5bwn7BBQ+jTzSYvqd6+c+LxPdUShVc=;
    b=yDxOPX7ielhp5KAyqKUg2LKcHtrq8q5u3IuFISRNQMuy1pzRVvz4p40HtejYctDvJ7
    e8Wl1YDMXtphoHffpcDw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JyILymw+xm3V4eLp8OT0"
Received: from Munilab01-lab.fritz.box
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id V04024z8R8uklsm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 27 Sep 2023 10:56:46 +0200 (CEST)
Message-ID: <ef69122bc6aa64bd8df6c5a2d0ec6d82380d5560.camel@iokpp.de>
Subject: Re: [PATCH v3] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for
 Micron eMMC Q2J54A
From:   Bean Huo <beanhuo@iokpp.de>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Wed, 27 Sep 2023 10:56:36 +0200
In-Reply-To: <ZQ3IWOpcSfjVqNYC@francesco-nb.int.toradex.com>
References: <20230921203426.638262-1-beanhuo@iokpp.de>
         <ZQ3IWOpcSfjVqNYC@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDE5OjAxICswMjAwLCBGcmFuY2VzY28gRG9sY2luaSB3cm90
ZToKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaWYgKGhvc3QtPmNhcmQtPnF1aXJrcyAmCj4gPiBNTUNfUVVJUktfQlJPS0VOX0NBQ0hFX0ZM
VVNIICYmCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAhaG9zdC0+Y2FyZC0+d3JpdHRlbl9mbGFnICYmICFyZXQpCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBob3N0
LT5jYXJkLT53cml0dGVuX2ZsYWcgPSB0cnVlOwo+IAo+IEZyb20gd2hhdCBJIGNhbiBzZWUgdGhp
cyBicmFuY2ggaXMgZm9sbG93ZWQgZm9yIGJvdGggUkVRX09QX1JFQUQgYW5kCj4gUkVRX09QX1dS
SVRFLCBhbmQgSSB3b3VsZCBzYXkgd2Ugd2FudCB0byBzZXQgdGhpcyBmbGFnIG9ubHkgZm9yCj4g
UkVRX09QX1dSSVRFLgo+IAo+IEFtIEkgd3Jvbmc/Cj4gCj4gRnJhbmNlc2NvCgp5b3UgYXJlIHJp
Z2h0LCB3ZSBvbmx5IGNhcmUgYWJvdXQgd3JpdGUsIEkgd2lsbCB1cGRhdGUgaXQgaW4gdGhlIG5l
eHQKdmVyc2lvbiwgdGhhbmtzIGZvciB5b3VyIHJldmlldyEKCktpbmQgcmVnYXJkcywKQmVhbiAK


