Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C9876470F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjG0GlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjG0GlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:41:01 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9A30C7;
        Wed, 26 Jul 2023 23:40:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso763935a12.2;
        Wed, 26 Jul 2023 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690440032; x=1691044832;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EMDnPScKJKo854bqdiZqqPtQVKxSdc3IO3xG/RkoQEw=;
        b=nYm1FfEgjlHALmNsdCRIi60zsn5b6b3Xuuf2tVvxIWQ4OW7vrxde9ArxzzGu8voz2M
         MFx6PoQW5vt6l0y0lil8te5BHSM6E2tIN0/XYj9rC0VriOnefd4xm+n8pwDPNk8d9ImD
         RY4FihRN9fNqjkannPBPlbSylAJML5l6qqS31gFhZ4SKvd8Dj1MTxNwPIEj+R9Ex7ht2
         nnTtW2cEnTxoi9lxGHck6Sk7GCWLXqc0DUOQdH13YwUNJBaDc2uCuHJ+t3aszZWvR5rI
         g/nA4vTN+G0WNZCeJ6N0+3Dy1MX2ZDPc5C68qDgd6Dns16/f9mNWavrDwms1hMQXUPll
         D4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440032; x=1691044832;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMDnPScKJKo854bqdiZqqPtQVKxSdc3IO3xG/RkoQEw=;
        b=XrsubUd1eIZUDp8NE5sxLsvRsJUTGgOtlfyoLww0+NMFogB/2aTQaogNAFZfxwUh5+
         V88M9A1A4fo8IhrEziaHfLT6jrKUbjcl9bfTXoZb5mBydY2XK2zLJEYAY6bKRAoLnx2n
         N/W6/d5sRUy3RQE76oJpTk7qtEP1OaelW9bBrKLjYvwtT+SPAhHBoL3T3mIH6nmEnwA1
         gFMJB2mIqrqJp5sSqh1XpGQEcprgMtFsToXPRr3ReXep0Fi5noQGm6JRnSJ358EmJufP
         BTpUGSwkMTmgUngMBPWVLHQvNyBagoeokswMLQnpJFZc7JrJSmBmYZhukBcogvcVVxvH
         t1OA==
X-Gm-Message-State: ABy/qLZzS55tEY92QDfhWgHz8tFn1yG64ncBQ/pGi/8VgjlEpbzNdQ4U
        woHQkHvp+ryowiAQW93c0vc=
X-Google-Smtp-Source: APBJJlF+TKI/VLgmTDZiX+Mt+Hjehy+ylPoKJTH4kl/wgNdTOj4U8SUhSdzs1/XJUsRbjIvaQtiC6g==
X-Received: by 2002:aa7:c1d9:0:b0:521:d75d:ef69 with SMTP id d25-20020aa7c1d9000000b00521d75def69mr951017edp.31.1690440031889;
        Wed, 26 Jul 2023 23:40:31 -0700 (PDT)
Received: from ?IPv6:2001:a61:35be:1401:2331:c532:1717:d48c? ([2001:a61:35be:1401:2331:c532:1717:d48c])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7d055000000b0051e26c7a154sm278107edo.18.2023.07.26.23.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 23:40:30 -0700 (PDT)
Message-ID: <30b7dd4107285c33339e63478a100890de72d346.camel@gmail.com>
Subject: Re: [PATCH 2/2] drivers: misc: adi-axi-tdd: Add new TDD engine
 driver
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Eliza Balas <eliza.balas@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Thu, 27 Jul 2023 08:40:29 +0200
In-Reply-To: <0fc2ba5d-8357-6dfb-4aa4-26de6b497c13@linaro.org>
References: <20230726071103.12172-1-eliza.balas@analog.com>
         <20230726071103.12172-2-eliza.balas@analog.com>
         <0fc2ba5d-8357-6dfb-4aa4-26de6b497c13@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTI2IGF0IDIwOjM5ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IE9uIDI2LzA3LzIwMjMgMDk6MTEsIEVsaXphIEJhbGFzIHdyb3RlOgo+ID4gVGhpcyBw
YXRjaCBpbnRyb2R1Y2VzIHRoZSBkcml2ZXIgZm9yIHRoZSBuZXcgQURJIFRERCBlbmdpbmUgSERM
Lgo+ID4gVGhlIGdlbmVyaWMgVEREIGNvbnRyb2xsZXIgaXMgaW4gZXNzZW5jZSBhIHdhdmVmb3Jt
IGdlbmVyYXRvcgo+ID4gY2FwYWJsZSBvZiBhZGRyZXNzaW5nIFJGIGFwcGxpY2F0aW9ucyB3aGlj
aCByZXF1aXJlIFRpbWUgRGl2aXNpb24KPiA+IER1cGxleGluZywgYXMgd2VsbCBhcyBjb250cm9s
bGluZyBvdGhlciBtb2R1bGVzIG9mIGdlbmVyYWwKPiA+IGFwcGxpY2F0aW9ucyB0aHJvdWdoIGl0
cyBkZWRpY2F0ZWQgMzIgY2hhbm5lbCBvdXRwdXRzLgo+ID4gCj4gPiBUaGUgcmVhc29uIG9mIGNy
ZWF0aW5nIHRoZSBnZW5lcmljIFRERCBjb250cm9sbGVyIHdhcyB0byByZWR1Y2UKPiA+IHRoZSBu
YW1pbmcgY29uZnVzaW9uIGFyb3VuZCB0aGUgZXhpc3RpbmcgcmVwdXJwb3NlZCBUREQgY29yZQo+
ID4gYnVpbHQgZm9yIEFEOTM2MSwgYXMgd2VsbCBhcyBleHBhbmRpbmcgaXRzIG51bWJlciBvZiBv
dXRwdXQKPiA+IGNoYW5uZWxzIGZvciBzeXN0ZW1zIHdoaWNoIHJlcXVpcmUgbW9yZSB0aGFuIHNp
eCBjb250cm9sbGluZyBzaWduYWxzLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbGl6YSBCYWxh
cyA8ZWxpemEuYmFsYXNAYW5hbG9nLmNvbT4KPiA+IC0tLQo+ID4gwqAuLi4vc3lzZnMtYnVzLXBs
YXRmb3JtLWRyaXZlcnMtYWRpLWF4aS10ZGTCoMKgwqAgfCAxNTggKysrKwo+ID4gwqBNQUlOVEFJ
TkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKwo+ID4gwqBkcml2ZXJzL21pc2MvS2NvbmZpZ8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMCArCj4g
PiDCoGRyaXZlcnMvbWlzYy9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiA+IMKgZHJpdmVycy9taXNjL2FkaS1heGktdGRk
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDc1MyArKysrKysrKysr
KysrKysrKysKPiA+IMKgNSBmaWxlcyBjaGFuZ2VkLCA5MjQgaW5zZXJ0aW9ucygrKQo+ID4gwqBj
cmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtcGxh
dGZvcm0tZHJpdmVycy1hZGktYXhpLQo+ID4gdGRkCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL21pc2MvYWRpLWF4aS10ZGQuYwo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtcGxhdGZvcm0tZHJpdmVycy1hZGktYXhpLXRkZAo+
ID4gYi9Eb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1wbGF0Zm9ybS1kcml2ZXJz
LWFkaS1heGktdGRkCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4gaW5kZXggMDAwMDAwMDAw
MDAwLi5lYjVmM2RiN2QwY2IKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsrKyBiL0RvY3VtZW50YXRp
b24vQUJJL3Rlc3Rpbmcvc3lzZnMtYnVzLXBsYXRmb3JtLWRyaXZlcnMtYWRpLWF4aS10ZGQKPiA+
IEBAIC0wLDAgKzEsMTU4IEBACj4gPiArV2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoCAvc3lzL2J1
cy9wbGF0Zm9ybS9kcml2ZXJzL2FkaS1heGktdGRkLyovYnVyc3RfY291bnQKPiA+ICtEYXRlOsKg
wqDCoMKgwqDCoMKgwqDCoMKgIEp1bHkgMjAyMwo+ID4gK0tlcm5lbFZlcnNpb246wqAgNi41Cj4g
Cj4gV2UgYXJlIGluIDYuNSBub3csIHNvIHRoZXJlIGlzIG5vIHdheSB5b3VyIGRyaXZlciB3aWxs
IGJlIGluIDYuNS4gVGFyZ2V0Cj4gNi42IGFuZCB1c2UgcGhiIGNyeXN0YWxsIGJhbGwgZm9yIG5l
eHQgcmVsZWFzZSBkYXRlIChTZXB0ZW1iZXIpLgo+IAo+IC4uLgo+IAo+ID4gKwo+ID4gK2VudW0g
YWRpX2F4aV90ZGRfYXR0cmlidXRlX2lkIHsKPiA+ICvCoMKgwqDCoMKgwqDCoEFESV9URERfQVRU
Ul9WRVJTSU9OLAo+ID4gK8KgwqDCoMKgwqDCoMKgQURJX1RERF9BVFRSX0NPUkVfSUQsCj4gPiAr
wqDCoMKgwqDCoMKgwqBBRElfVEREX0FUVFJfU0NSQVRDSCwKPiA+ICvCoMKgwqDCoMKgwqDCoEFE
SV9URERfQVRUUl9NQUdJQywKPiA+ICsKPiAKPiAuLi4KPiAKPiA+ICsKPiA+ICtzdGF0aWMgaW50
IGFkaV9heGlfdGRkX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiArewo+
ID4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IGV4cGVjdGVkX3ZlcnNpb24sIHZlcnNpb24s
IGRhdGE7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYWRpX2F4aV90ZGRfc3RhdGUgKnN0Owo+
ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGNsayAqYWNsazsKPiA+ICvCoMKgwqDCoMKgwqDCoGlu
dCByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBzdCA9IGRldm1fa3phbGxvYygmcGRldi0+
ZGV2LCBzaXplb2YoKnN0KSwgR0ZQX0tFUk5FTCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIXN0
KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgc3QtPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVz
b3VyY2UocGRldiwgMCk7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHN0LT5iYXNlKSkK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gUFRSX0VSUihzdC0+YmFz
ZSk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBz
dCk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBhY2xrID0gZGV2bV9jbGtfZ2V0X2VuYWJsZWQo
JnBkZXYtPmRldiwgInNfYXhpX2FjbGsiKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIo
YWNsaykpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIFBUUl9FUlIo
YWNsayk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBkZXZtX2FkZF9hY3Rpb25fb3Jf
cmVzZXQoJnBkZXYtPmRldiwgYWRpX2F4aV90ZGRfY2xrX2Rpc2FibGUsCj4gPiBhY2xrKTsKPiAK
PiBMb29rcyB5b3UgaGF2ZSBoZXJlIGRvdWJsZSBkaXNhYmxlLgo+IAo+ID4gK8KgwqDCoMKgwqDC
oMKgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0
Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgc3QtPmNsay5jbGsgPSBkZXZtX2Nsa19nZXQoJnBk
ZXYtPmRldiwgImludGZfY2xrIik7Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHN0LT5j
bGsuY2xrKSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gUFRSX0VS
UihzdC0+Y2xrLmNsayk7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXQgPSBjbGtfcHJlcGFy
ZV9lbmFibGUoc3QtPmNsay5jbGspOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ID4gKwo+ID4gK8KgwqDC
oMKgwqDCoMKgcmV0ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KCZwZGV2LT5kZXYsIGFkaV9h
eGlfdGRkX2Nsa19kaXNhYmxlLCBzdC0KPiA+ID5jbGsuY2xrKTsKPiAKPiBMb29rcyB5b3UgaGF2
ZSBoZXJlIGRvdWJsZSBkaXNhYmxlLgo+IAoKTm90IGluIGhlcmUgYnV0IGl0IHNob3VsZCBhY3R1
YWxseSBkcm9wIHRoZSBhY3Rpb24gYW5kIHVzZSBkZXZtX2Nsa19nZXRfZW5hYmxlZCgpCgotIE51
bm8gU8OhCgoK

