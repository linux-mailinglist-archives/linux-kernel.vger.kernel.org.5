Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5375C090
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGUH5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGUH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:57:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58945272D;
        Fri, 21 Jul 2023 00:57:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9891c73e0fbso351454366b.1;
        Fri, 21 Jul 2023 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689926228; x=1690531028;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e0zBWA0NVDhnM9CNqFrp3Ce071wFVa/Nrr4Nyq3P2rI=;
        b=AbO4XSFWGc+VGxFBz1Sfy7P48ZyfgPe8lX+DyWVX8m7/C4VNn50dob7TZD+uvb6mAj
         9Wh/ZV0pB1sf3mKPKjDKTCPqB65CPRRiBNQx/5oCY52A3MwE//tgNgyMCm4osNF6/Wlc
         FHUvRCq+6oJyxGrJJJzRvCR7npCMOc6Qk5CGF5af14ZB5lBxIzsGdXT7W4nwUcCF5ACC
         YHlalj9kRRnBWuRkqOt2gqkZv1gWUS2rSViZvxZepxnNOESxk3ecrTQ7yrNCL4NPO9oU
         GCGNYAQ4miZ3FtIZE34hUkZihK5CFQh3YWksl6cXXM2W6QjiYOoDgln2jwCpNzWRS/JI
         h7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926228; x=1690531028;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0zBWA0NVDhnM9CNqFrp3Ce071wFVa/Nrr4Nyq3P2rI=;
        b=lQOFOI/p3/eCBccMm5CHp/1CcpSvdURdCM5CUIQk7XgV2XGgtYw2TMj9OdbTXDbZUN
         4lhanmOqk/lMWRX0to+8BtwHx85IDrWoz+2wFu8DGphLD0vY7T2qkIzACzI9Aq4MtVDz
         kAncVkQabkrFxzOyqi4nlO8igfL27bPT0jCgffFvNJeq7e4nxxkEAa9DiLHfHyBVkQUJ
         +xeyiGt0r+XoJig++GisqVi81rXlABNGRX0dQUCkpX+auvwUrav+RNssXikffruyF5IP
         lSMMk6R1i/YEC+fUnwM0QCNrvYSzKT4taZ6Kd5wGFFE6OXK+DvtRhHfD810xdtAq0+8t
         u2XA==
X-Gm-Message-State: ABy/qLbUVaq7J/KKSGQKDqgaWbBBf8NdYNAv76+qsSP4BnnwhOHcqCic
        bMweKoa7V11j335/v/KhUak=
X-Google-Smtp-Source: APBJJlHlzvxze6vLkZMHiXeLA9lan+3C4+r5sdyv0Dd7rGMzRwsbpKShWGUacmxyG6h6PfowSJtxbg==
X-Received: by 2002:a17:906:5d12:b0:993:e85c:4ad6 with SMTP id g18-20020a1709065d1200b00993e85c4ad6mr7895345ejt.7.1689926227507;
        Fri, 21 Jul 2023 00:57:07 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id kk7-20020a170907766700b0098df7d0e096sm1808001ejc.54.2023.07.21.00.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 00:57:07 -0700 (PDT)
Message-ID: <65dbc603062018e1cd968caf983512c2cb2039e5.camel@gmail.com>
Subject: Re: [PATCH v1 3/8] iio: core: Switch to krealloc_array()
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri, 21 Jul 2023 09:59:37 +0200
In-Reply-To: <20230720205324.58702-4-andriy.shevchenko@linux.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
         <20230720205324.58702-4-andriy.shevchenko@linux.intel.com>
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
Cj4gTGV0IHRoZSBrcmVhbGxvY19hcnJheSgpIGNvcHkgdGhlIG9yaWdpbmFsIGRhdGEgYW5kCj4g
Y2hlY2sgZm9yIGEgbXVsdGlwbGljYXRpb24gb3ZlcmZsb3cuCj4gCj4gU2lnbmVkLW9mZi1ieTog
QW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+Cj4gLS0t
Cj4gwqBkcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jIHwgMjAgKysrKysrKy0tLS0tLS0t
LS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jIGIvZHJp
dmVycy9paW8vaW5kdXN0cmlhbGlvLWNvcmUuYwo+IGluZGV4IDkwZTU5MjIzYjE3OC4uYmUxNTQ4
Nzk5ODNlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1jb3JlLmMKPiAr
KysgYi9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tY29yZS5jCj4gQEAgLTE0NjUsNyArMTQ2NSw3
IEBAIGludCBpaW9fZGV2aWNlX3JlZ2lzdGVyX3N5c2ZzX2dyb3VwKHN0cnVjdCBpaW9fZGV2Cj4g
KmluZGlvX2RldiwKPiDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91
cCAqKm5ldywgKipvbGQgPSBpaW9fZGV2X29wYXF1ZS0+Z3JvdXBzOwo+IMKgwqDCoMKgwqDCoMKg
wqB1bnNpZ25lZCBpbnQgY250ID0gaWlvX2Rldl9vcGFxdWUtPmdyb3VwY291bnRlcjsKPiDCoAo+
IC3CoMKgwqDCoMKgwqDCoG5ldyA9IGtyZWFsbG9jKG9sZCwgc2l6ZW9mKCpuZXcpICogKGNudCAr
IDIpLCBHRlBfS0VSTkVMKTsKPiArwqDCoMKgwqDCoMKgwqBuZXcgPSBrcmVhbGxvY19hcnJheShv
bGQsIGNudCArIDIsIHNpemVvZigqbmV3KSwgR0ZQX0tFUk5FTCk7Cj4gwqDCoMKgwqDCoMKgwqDC
oGlmICghbmV3KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9N
RU07Cj4gwqAKPiBAQCAtMTQ4MywxMyArMTQ4MywxMyBAQCBzdGF0aWMgaW50IGlpb19kZXZpY2Vf
cmVnaXN0ZXJfc3lzZnMoc3RydWN0IGlpb19kZXYKPiAqaW5kaW9fZGV2KQo+IMKgewo+IMKgwqDC
oMKgwqDCoMKgwqBzdHJ1Y3QgaWlvX2Rldl9vcGFxdWUgKmlpb19kZXZfb3BhcXVlID0gdG9faWlv
X2Rldl9vcGFxdWUoaW5kaW9fZGV2KTsKPiDCoMKgwqDCoMKgwqDCoMKgaW50IGksIHJldCA9IDAs
IGF0dHJjb3VudCwgYXR0cm4sIGF0dHJjb3VudF9vcmlnID0gMDsKPiArwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgYXR0cmlidXRlICoqYXR0cnMsICoqYXR0ciwgKmNsayA9IE5VTEw7Cj4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBpaW9fZGV2X2F0dHIgKnA7Cj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGF0
dHJpYnV0ZSAqKmF0dHIsICpjbGsgPSBOVUxMOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoC8qIEZp
cnN0IGNvdW50IGVsZW1lbnRzIGluIGFueSBleGlzdGluZyBncm91cCAqLwo+IC3CoMKgwqDCoMKg
wqDCoGlmIChpbmRpb19kZXYtPmluZm8tPmF0dHJzKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGF0dHIgPSBpbmRpb19kZXYtPmluZm8tPmF0dHJzLT5hdHRyczsKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2hpbGUgKCphdHRyKysgIT0gTlVMTCkKPiArwqDCoMKg
wqDCoMKgwqBhdHRycyA9IGluZGlvX2Rldi0+aW5mby0+YXR0cnMgPyBpbmRpb19kZXYtPmluZm8t
PmF0dHJzLT5hdHRycyA6IE5VTEw7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGF0dHJzKSB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZvciAoYXR0ciA9IGF0dHJzOyAqYXR0cjsgYXR0
cisrKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGF0
dHJjb3VudF9vcmlnKys7Cgpub3QgcmVhbGx5IHJlbGF0ZWQgd2l0aCB0aGUgY2hhbmdlLi4uIG1h
eWJlIGp1c3QgbWVudGlvbiBpdCBpbiB0aGUgY29tbWl0PwoKPiDCoMKgwqDCoMKgwqDCoMKgfQo+
IMKgwqDCoMKgwqDCoMKgwqBhdHRyY291bnQgPSBhdHRyY291bnRfb3JpZzsKPiBAQCAtMTUyMSwy
MCArMTUyMSwxNCBAQCBzdGF0aWMgaW50IGlpb19kZXZpY2VfcmVnaXN0ZXJfc3lzZnMoc3RydWN0
IGlpb19kZXYKPiAqaW5kaW9fZGV2KQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoY2xrKQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXR0cmNvdW50Kys7Cj4gwqAKPiArwqDCoMKgwqDC
oMKgwqAvKiBDb3B5IGFjcm9zcyBvcmlnaW5hbCBhdHRyaWJ1dGVzLCBhbmQgcG9pbnQgdG8gb3Jp
Z2luYWwgYmluYXJ5Cj4gYXR0cmlidXRlcyAqLwo+IMKgwqDCoMKgwqDCoMKgwqBpaW9fZGV2X29w
YXF1ZS0+Y2hhbl9hdHRyX2dyb3VwLmF0dHJzID0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKga2NhbGxvYyhhdHRyY291bnQgKyAxLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZW9mKGlpb19kZXZfb3BhcXVlLT5jaGFuX2F0dHJfZ3Jv
dXAuYXR0cnNbMF0pLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgR0ZQX0tFUk5FTCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtyZWFs
bG9jX2FycmF5KGF0dHJzLCBhdHRyY291bnQgKyAxLCBzaXplb2YoKmF0dHJzKSwKPiBHRlBfS0VS
TkVMKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGlpb19kZXZfb3BhcXVlLT5jaGFuX2F0dHJfZ3Jv
dXAuYXR0cnMgPT0gTlVMTCkgewoKc2luY2UgeW91J3JlIGhlcmUgYW5kIHlvdSBhbHNvIGFscmVh
ZHkgZGlkIHNvbWUgc3R5bGUgY2xlYW51cHMgYWJvdmUsIG1heWJlCmNoYW5nZSBpdCB0byAnaWYg
KCFpaW9fZGV2X29wYXF1ZS0+Y2hhbl9hdHRyX2dyb3VwLmF0dHJzKSc/CgotIE51bm8gU8OhCgo=

