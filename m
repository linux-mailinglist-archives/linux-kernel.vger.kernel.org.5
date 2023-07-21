Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9642875C0A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjGUIBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjGUIBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:01:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1EA2704;
        Fri, 21 Jul 2023 01:01:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977e0fbd742so258560466b.2;
        Fri, 21 Jul 2023 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689926462; x=1690531262;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z4t/JRyriN0FMhD/NauVTCFPsZukVPAxA5hvJ462aAk=;
        b=GlLJh8X5gaj7ctLtJhuRMms1wHJ+JVkRViYqK+kbVg0C8iAuiBeB5n4eaNagszoPLr
         EPGiydBdJRTjw4n6MrRsLbfZ+GxeG8ZXt7XtlVanj5VV7HaL2DPYVrhXGWk5dSJveW/6
         xJ7azmNk66p4Z1/m5fOr83JTot7vuevnmCLZvMaPF518dBFmjST+owadb5MChd0T/hWw
         WbiLy6riqGACzOmffnTGbcDTXSerzdhBJe/RXuRxglbCkkZCrou6CCx/Cljxz0A1Oj+5
         xrZANY38p36MnBZCYchlZEoZ1p9WCT7wWTPzFwiBKLjNdgtGc4gwNAZmyxM8rYM3jL9a
         wPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926462; x=1690531262;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4t/JRyriN0FMhD/NauVTCFPsZukVPAxA5hvJ462aAk=;
        b=AngdYv5+6B+xQfMrGg/IIPRxFgXtfcCaIq9SN5X81QDcRRtRGvLk2/VEtvupqHbowB
         vaeIsYxxszQ/ubYGhmF7CuzlIVOLKYbxejS22GT+biieQZtsZLDl9ZNl84zT85y0+FZZ
         A6c+CKIfssop9hMHIvYh+KFmEfrOphHPpx12LEbddIRq+qyzIZL00T1XO54EDpmJmIqK
         hKo5W7frkfSW1JRyZUEeY1STROuqb6Ek3Xk8hjIlFX239ANUcMTGmxSfCFfs8WHwY4U6
         UsYtwQeobXblNOvF4AwnGhqP6ualvhM2WzjgsGmERkKnqIkizMfUx5cXSjJQQqOFm2hd
         VSkw==
X-Gm-Message-State: ABy/qLb1sZnuRr6vgfLvwmvakFSNAmidOqXbpcNg4IKwe/Z6oP0yIYP/
        awfb+hXV6t/vJq+t58owQMc=
X-Google-Smtp-Source: APBJJlEXwH1GG0OIb96bLCp9gSoLTGODenyuUwZOuFKjvZ+knf468Kx6r9Ng8TcBSFwoXpn5oKGofQ==
X-Received: by 2002:a17:907:b0e:b0:992:bc8:58e4 with SMTP id h14-20020a1709070b0e00b009920bc858e4mr947294ejl.20.1689926461944;
        Fri, 21 Jul 2023 01:01:01 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090635da00b00986211f35bdsm1784750ejb.80.2023.07.21.01.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:01:01 -0700 (PDT)
Message-ID: <e216e27592e50bb9786c6bae106762fc7cb97109.camel@gmail.com>
Subject: Re: [PATCH v1 2/8] iio: core: Use sysfs_match_string() helper
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri, 21 Jul 2023 10:03:32 +0200
In-Reply-To: <20230720205324.58702-3-andriy.shevchenko@linux.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
         <20230720205324.58702-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTIwIGF0IDIzOjUzICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gVXNlIHN5c2ZzX21hdGNoX3N0cmluZygpIGhlbHBlciBpbnN0ZWFkIG9mIG9wZW4gY29kZWQg
dmFyaWFudC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2
Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KPiAtLS0KPiDCoGRyaXZlcnMvaWlvL2luZHVzdHJpYWxp
by1jb3JlLmMgfCA4MSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYyBiL2RyaXZlcnMvaWlvL2luZHVz
dHJpYWxpby1jb3JlLmMKPiBpbmRleCA2Y2NhODZmZDBlZjkuLjkwZTU5MjIzYjE3OCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jCj4gKysrIGIvZHJpdmVycy9p
aW8vaW5kdXN0cmlhbGlvLWNvcmUuYwo+IEBAIC0xNDAwLDUwICsxNDAwLDMyIEBAIHN0YXRpYyBz
c2l6ZV90IGxhYmVsX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QKPiBkZXZpY2VfYXR0
cmlidXRlICphdHRyLAo+IMKgCj4gwqBzdGF0aWMgREVWSUNFX0FUVFJfUk8obGFiZWwpOwo+IMKg
Cj4gK3N0YXRpYyBjb25zdCBjaGFyICogY29uc3QgY2xvY2tfbmFtZXNbXSA9IHsKPiArwqDCoMKg
wqDCoMKgwqBbQ0xPQ0tfUkVBTFRJTUVdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9
ICJyZWFsdGltZSIsCj4gK8KgwqDCoMKgwqDCoMKgW0NMT0NLX01PTk9UT05JQ13CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqA9ICJtb25vdG9uaWMiLAo+ICvCoMKgwqDCoMKgwqDCoFtDTE9D
S19QUk9DRVNTX0NQVVRJTUVfSURdwqDCoMKgwqDCoMKgPSAicHJvY2Vzc19jcHV0aW1lX2lkIiwK
PiArwqDCoMKgwqDCoMKgwqBbQ0xPQ0tfVEhSRUFEX0NQVVRJTUVfSURdwqDCoMKgwqDCoMKgwqA9
ICJ0aHJlYWRfY3B1dGltZV9pZCIsCj4gK8KgwqDCoMKgwqDCoMKgW0NMT0NLX01PTk9UT05JQ19S
QVddwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gIm1vbm90b25pY19yYXciLAo+ICvCoMKgwqDCoMKg
wqDCoFtDTE9DS19SRUFMVElNRV9DT0FSU0VdwqDCoMKgwqDCoMKgwqDCoMKgPSAicmVhbHRpbWVf
Y29hcnNlIiwKPiArwqDCoMKgwqDCoMKgwqBbQ0xPQ0tfTU9OT1RPTklDX0NPQVJTRV3CoMKgwqDC
oMKgwqDCoMKgPSAibW9ub3RvbmljX2NvYXJzZSIsCj4gK8KgwqDCoMKgwqDCoMKgW0NMT0NLX0JP
T1RUSU1FXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPSAiYm9vdHRpbWUiLAo+ICvC
oMKgwqDCoMKgwqDCoFtDTE9DS19SRUFMVElNRV9BTEFSTV3CoMKgwqDCoMKgwqDCoMKgwqDCoD0g
InJlYWx0aW1lX2FsYXJtIiwKPiArwqDCoMKgwqDCoMKgwqBbQ0xPQ0tfQk9PVFRJTUVfQUxBUk1d
wqDCoMKgwqDCoMKgwqDCoMKgwqA9ICJib290dGltZV9hbGFybSIsCj4gK8KgwqDCoMKgwqDCoMKg
W0NMT0NLX1NHSV9DWUNMRV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9ICJzZ2lfY3lj
bGUiLAo+ICvCoMKgwqDCoMKgwqDCoFtDTE9DS19UQUldwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgPSAidGFpIiwKPiArfTsKPiArCj4gwqBzdGF0aWMgc3NpemVfdCBj
dXJyZW50X3RpbWVzdGFtcF9jbG9ja19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFyICpidWYpCj4gwqB7Cj4gwqDCoMKgwqDC
oMKgwqDCoGNvbnN0IHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBkZXZfdG9faWlvX2Rldihk
ZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqBjb25zdCBjbG9ja2lkX3QgY2xrID0gaWlvX2RldmljZV9n
ZXRfY2xvY2soaW5kaW9fZGV2KTsKPiAtwqDCoMKgwqDCoMKgwqBjb25zdCBjaGFyICpuYW1lOwo+
IC3CoMKgwqDCoMKgwqDCoHNzaXplX3Qgc3o7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBzd2l0Y2gg
KGNsaykgewo+IC3CoMKgwqDCoMKgwqDCoGNhc2UgQ0xPQ0tfUkVBTFRJTUU6Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5hbWUgPSAicmVhbHRpbWVcbiI7Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHN6ID0gc2l6ZW9mKCJyZWFsdGltZVxuIik7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoGNhc2UgQ0xPQ0tf
TU9OT1RPTklDOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuYW1lID0gIm1vbm90
b25pY1xuIjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3ogPSBzaXplb2YoIm1v
bm90b25pY1xuIik7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IC3C
oMKgwqDCoMKgwqDCoGNhc2UgQ0xPQ0tfTU9OT1RPTklDX1JBVzoKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbmFtZSA9ICJtb25vdG9uaWNfcmF3XG4iOwo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBzeiA9IHNpemVvZigibW9ub3RvbmljX3Jhd1xuIik7Cj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoGNhc2UgQ0xP
Q0tfUkVBTFRJTUVfQ09BUlNFOgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuYW1l
ID0gInJlYWx0aW1lX2NvYXJzZVxuIjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
c3ogPSBzaXplb2YoInJlYWx0aW1lX2NvYXJzZVxuIik7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoGNhc2UgQ0xPQ0tfTU9OT1RPTklDX0NP
QVJTRToKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbmFtZSA9ICJtb25vdG9uaWNf
Y29hcnNlXG4iOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzeiA9IHNpemVvZigi
bW9ub3RvbmljX2NvYXJzZVxuIik7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJy
ZWFrOwo+IC3CoMKgwqDCoMKgwqDCoGNhc2UgQ0xPQ0tfQk9PVFRJTUU6Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG5hbWUgPSAiYm9vdHRpbWVcbiI7Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHN6ID0gc2l6ZW9mKCJib290dGltZVxuIik7Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoGNhc2UgQ0xPQ0tfVEFJ
Ogo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBuYW1lID0gInRhaVxuIjsKPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3ogPSBzaXplb2YoInRhaVxuIik7Cj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IC3CoMKgwqDCoMKgwqDCoGRlZmF1bHQ6
Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGNsayA8IDAgJiYgY2xrID49IEFSUkFZX1NJWkUoY2xvY2tf
bmFtZXMpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQlVHKCk7Cj4gLcKgwqDC
oMKgwqDCoMKgfQo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgbWVtY3B5KGJ1ZiwgbmFtZSwgc3opOwo+
IC3CoMKgwqDCoMKgwqDCoHJldHVybiBzejsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gc3ByaW50
ZihidWYsICIlc1xuIiwgY2xvY2tfbmFtZXNbY2xrXSk7CgpzeWZzX2VtaXQoKS4uLgoKLSBOdW5v
IFPDoQoK

