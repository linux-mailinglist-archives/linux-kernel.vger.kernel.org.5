Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E578838B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244253AbjHYJaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbjHYJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:30:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3C1FC4;
        Fri, 25 Aug 2023 02:30:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500a398cda5so1079338e87.0;
        Fri, 25 Aug 2023 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692955830; x=1693560630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XpR21X7lWwbnIiUo6vjprSHYD8ABf5WZ2M/zml0uBLc=;
        b=c1qAjLB/3fCexj37Ktlb30MYLrMZlMujs0UxXlG5D5YNiPUQaPgXaJqrNmML8wwRLI
         fuN7oqTjF7mIosuS/WdZ5baOGMNxykmieVEFM/ipUtzUz70MS3/cliszc6P5Prl4V2mW
         UhrV7N4Cnz0ECjBBOLUXj8qGV0aG3evmTkqy3SeRzS1Hib+zRnhOai6dI0n21CrWgDdN
         OLkDoPegAIePm9P6vSuCEbeNbBxmwxeykZoiJuhZ2Ew0DeBBLjM0eN5OVqaqm13e1Ytw
         zQ1csaEXklmAYJBmr/M3U7shUFmebSdge1znT/TUQGgcgolvzqHxN993pHlssxGIlKc2
         ultg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692955830; x=1693560630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpR21X7lWwbnIiUo6vjprSHYD8ABf5WZ2M/zml0uBLc=;
        b=QKgkpmSin29WT0kYApKaOU9eS43Ei2y+UJffegddNOoF/llW614nxdD+ID/d3uwbGC
         xVc+LpS+JGfRcaThmIAF7jlF7i11qyViWxNmlLhxezow4K3e5kb4/4QaZGtOkSG9UNFK
         cWfsO2qsIE1SrtgpTbKdhw+UR5jO0zI4n2IZ+DaEAfyylv0L5Hp3ldeZZ1D+4hopn4bv
         LMK4ZNGOR7/nq7P8cmGbu3Ye9zgTl5n4wOu+6UF+fRVAm34aEP3PI3a5xm6w4z12/ekx
         J0BWCc2SuAC0hT8f6SuL0JrdHn+cNUv/Eh9efW/X156GoDlMLOaedCg/6iFhxbiiPiX+
         fLjg==
X-Gm-Message-State: AOJu0YxYz5yBylZ0wC2BLYjwDyrs/Q6mMIWQ9Xs3oWemrYl8RkPiIqb4
        GfBUY3DKg8glpktXQvjr+llTpL+0zX0=
X-Google-Smtp-Source: AGHT+IG5A9rItNACAIudiVxzA575ANj+jbWChsgCEHKi/4HSux0gLeZOpX7ynFeF5dXDJRMorY9fHQ==
X-Received: by 2002:a05:6512:3ca9:b0:4fd:fac4:2016 with SMTP id h41-20020a0565123ca900b004fdfac42016mr17718800lfv.31.1692955829261;
        Fri, 25 Aug 2023 02:30:29 -0700 (PDT)
Received: from thinkpad-work.lan (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003fe61c33df5sm4957703wml.3.2023.08.25.02.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 02:30:28 -0700 (PDT)
Message-ID: <e3a73cfff0e91e22859ebdd671067ac06cfd9adf.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Allow multiple chips id
 per family of devices
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri, 25 Aug 2023 11:30:28 +0200
In-Reply-To: <ZOYzIvrvZGjQldDe@smile.fi.intel.com>
References: <cover.1692805377.git.ang.iglesiasg@gmail.com>
         <7bdfbfeb106acc5560e6cb090131f105b2d2e418.1692805377.git.ang.iglesiasg@gmail.com>
         <ZOYzIvrvZGjQldDe@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTIzIGF0IDE5OjI2ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gV2VkLCBBdWcgMjMsIDIwMjMgYXQgMDU6NTg6MDZQTSArMDIwMCwgQW5nZWwgSWdsZXNp
YXMgd3JvdGU6Cj4gPiBJbXByb3ZlIGRldmljZSBkZXRlY3Rpb24gaW4gY2VydGFpbiBjaGlwIGZh
bWlsaWVzIGtub3duIHRvIGhhdmUgdmFyaW91cwo+ID4gY2hpcCBpZHMuCj4gCj4gSURzCj4gCj4g
Li4uCj4gCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9jb21wbGV0aW9uLmg+Cj4gPiDCoCNpbmNsdWRl
IDxsaW51eC9wbV9ydW50aW1lLmg+Cj4gPiDCoCNpbmNsdWRlIDxsaW51eC9yYW5kb20uaD4KPiA+
ICsjaW5jbHVkZSA8bGludXgvb3ZlcmZsb3cuaD4KPiAKPiBQbGVhc2UsIHByZXNlcnZlIG9yZGVy
aW5nLgo+IAo+IC4uLgo+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBibXAyODBfZGF0YSAq
ZGF0YTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZ3Bpb19kZXNjICpncGlvZDsKPiA+IMKg
wqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgY2hpcF9pZDsKPiA+IC3CoMKgwqDCoMKgwqDCoGlu
dCByZXQ7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgcmV0LCBpOwo+IAo+IMKgwqDCoMKgwqDCoMKg
wqB1bnNpZ25lZCBpbnQgaTsKPiAKPiAuLi4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChpID09
IGRhdGEtPmNoaXBfaW5mby0+bnVtX2NoaXBfaWQpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBzaXplX3QgbmJ1ZjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjaGFyICpidWY7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLy8g
MHg8aWQ+LCBzbyBmb3VyIGNoYXJzIHBlciBudW1iZXIgcGx1cyBvbmUgc3BhY2UgKyBFTkRMCj4g
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNoZWNrX211bF9vdmVyZmxv
dyg1LCBkYXRhLT5jaGlwX2luZm8tPm51bV9jaGlwX2lkLAo+ID4gJm5idWYpKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ1ZiA9IGttYWxsb2NfYXJyYXko
bmJ1Ziwgc2l6ZW9mKGNoYXIpLCBHRlBfS0VSTkVMKTsKPiAKPiBXZSBhbG1vc3QgbmV2ZXIgZG8g
YSBhcnJheSBhbGxvY2F0aW9uIGZvciBieXRlIHNpemVzLiBJbnN0ZWFkIG9mIHRoZSBhYm92ZSB5
b3UKPiBuZWVkIHRvIHVzZQo+IAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVm
ID0ga21hbGxvY19hcnJheShkYXRhLT5jaGlwX2luZm8tPm51bV9jaGlwX2lkLCA1LAo+IEdGUF9L
RVJORUwpOwo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghYnVmKQo+
IAo+IFRoaXMgY2hlY2sgYXNzdW1lcyB0aGF0IG51bV9jaGlwX2lkIGlzIG5ldmVyIDAsIHNvLi4u
Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiByZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZm9yIChp
ID0gMDsgaSA8IGRhdGEtPmNoaXBfaW5mby0+bnVtX2NoaXBfaWQ7IGkrKykKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc25wcmludGYoJmJ1ZltpKjVd
LCBuYnVmLCAiMHgleCAiLCBkYXRhLT5jaGlwX2luZm8tCj4gPiA+Y2hpcF9pZFtpXSk7Cj4gCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVmW25idWYtMV0gPSAnXDAnOwo+IAo+
IC4uLnRoaXMgaXMgcmVkdW5kYW50IGFzc2lnbm1lbnQuIHNwcmludGYoKSBndWFyYW50ZWVzIHRo
ZSBOVUwgdGVybWluYXRpb24uCj4gCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGV2X2VycihkZXYsICJiYWQgY2hpcCBpZDogZXhwZWN0ZWQgWyAlcyBdIGdvdCAweCV4
XG4iLCBidWYsCj4gPiBjaGlwX2lkKTsKPiAKPiAiLi4uZXhwZWN0ZWQgb25lIG9mLi4uIgo+IAo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtmcmVlKGJ1Zik7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiAKPiBPaCwgSSBkaWRuJ3QgZ2V0
IHRoYXQgeW91IGFsbG9jYXRlZCBtZW1vcnkgb25seSB0byBwcmludCBhIG1lc3NhZ2UuLi4KClll
cywgSSBqdXN0IHdhbnRlZCB0byBwcmludCB0aGUga25vd24gSURzIGxpa2UgYmVmb3JlIGluIGEg
cmVhZGFibGUgbWFubmVyLiBJZgppdCBpcyBvdmVya2lsbCwgSSdsbCBjaGFuZ2UgaXQgZm9yIGEg
bW9yZSBnZW5lcmljIGVycm9yIG1lc3NhZ2UuCgo+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiAK
S2luZCByZWdhcmRzLApBbmdlbAo=

