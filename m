Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7B75C507
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGUKv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGUKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:51:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6B7E6F;
        Fri, 21 Jul 2023 03:51:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992e22c09edso257279866b.2;
        Fri, 21 Jul 2023 03:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689936683; x=1690541483;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXarL5+Q/EKBjLS/p+OLGJM4uvh5VwiYGlmzc+O3HZ4=;
        b=desLjfO+CSScMBmxGQim93le7NgAU59DJSjqee+19mooevM3+xsylSY2FbXwcpbmUj
         BSLHzHgTVeCCov0Pk+4fya82oiY8E3OkjDUZwxLSLnvjPYTeAg4as0SkpsFZq8BJr7Ce
         TDr7mIoZNQBp/bhzmjaspLc50r+jLYQdCcg/uokOWcsc5Mg8OgRCwbLNYy1pj2m3OlOv
         NHt4Hd6g6Of05B56+yg5cXJ340U54XBo7CKIct0ergvNIgKPyy97YoMNgIwX2HyZeoym
         zihLXSUD7EgE2xey3KGESedigybMYvl1T+boN/lyaWvxqexX8uYqxh3oUQGVCLrkoeVu
         04eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689936683; x=1690541483;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXarL5+Q/EKBjLS/p+OLGJM4uvh5VwiYGlmzc+O3HZ4=;
        b=cCvet4EDkXETIm+jEBHiYiMmkYiHnuTqkjxB1JKo62W8mcM0cQvQxGFUsz51FIuILQ
         xCMQoKs8++ZOYsmdsOzKugexPdxl5IKhoNXWmEeXz5TleM4HUbd0fIkbNkBhWDRSIgD+
         fEbItAEMiK7pNYasDlWcghvBJbrayElzbB9U2JgiYmbLtfocDnuum1w8e9kJgvRoVfL8
         Ksa178JamfoGGjUyuNxPQKYI/RjRwAOUd2ZxKpdxWxnaVhcGHGlEDaz/s0LeFE0BQ/XM
         oRKgizIuqEBeX7A9nD4qk7de8YO5xYBre407SrG4TsL5YhWlUrt1G0I3PRfOraVSZFbY
         jELg==
X-Gm-Message-State: ABy/qLZFyETJAkyWmObXqiNjOhwXeYILdAasj/Oxxhrz6f3ma2gmQTd2
        AE767NlEBTtBaKRjZrQ1+kFqtuVumbhr7FNB
X-Google-Smtp-Source: APBJJlEycbVotMEd4RmH6gZnzZtJa/DSk1uPuT0bJq+OhISX4MnUGqtts3NwrWqAUgWqvtWuIxncFg==
X-Received: by 2002:a17:906:3147:b0:994:1844:c7d1 with SMTP id e7-20020a170906314700b009941844c7d1mr1353840eje.13.1689936683044;
        Fri, 21 Jul 2023 03:51:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id dk14-20020a170906f0ce00b009930308425csm2002667ejb.31.2023.07.21.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 03:51:22 -0700 (PDT)
Message-ID: <f565b705ba6656ae1c8b34740aa176ccfe260f60.camel@gmail.com>
Subject: Re: [PATCH v1 3/8] iio: core: Switch to krealloc_array()
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri, 21 Jul 2023 12:53:53 +0200
In-Reply-To: <ZLpaeHlJujd8l0DS@smile.fi.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
         <20230720205324.58702-4-andriy.shevchenko@linux.intel.com>
         <65dbc603062018e1cd968caf983512c2cb2039e5.camel@gmail.com>
         <ZLpaeHlJujd8l0DS@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
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

T24gRnJpLCAyMDIzLTA3LTIxIGF0IDEzOjE0ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMDk6NTk6MzdBTSArMDIwMCwgTnVubyBTw6Egd3Jv
dGU6Cj4gPiBPbiBUaHUsIDIwMjMtMDctMjAgYXQgMjM6NTMgKzAzMDAsIEFuZHkgU2hldmNoZW5r
byB3cm90ZToKPiAKPiAuLi4KPiAKPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGF0dHJpYnV0
ZSAqKmF0dHJzLCAqKmF0dHIsICpjbGsgPSBOVUxMOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgc3Ry
dWN0IGlpb19kZXZfYXR0ciAqcDsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGF0dHJpYnV0
ZSAqKmF0dHIsICpjbGsgPSBOVUxMOwo+ID4gPiDCoAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgLyog
Rmlyc3QgY291bnQgZWxlbWVudHMgaW4gYW55IGV4aXN0aW5nIGdyb3VwICovCj4gPiA+IC3CoMKg
wqDCoMKgwqDCoGlmIChpbmRpb19kZXYtPmluZm8tPmF0dHJzKSB7Cj4gPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBhdHRyID0gaW5kaW9fZGV2LT5pbmZvLT5hdHRycy0+YXR0cnM7
Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3aGlsZSAoKmF0dHIrKyAhPSBO
VUxMKQo+ID4gPiArwqDCoMKgwqDCoMKgwqBhdHRycyA9IGluZGlvX2Rldi0+aW5mby0+YXR0cnMg
PyBpbmRpb19kZXYtPmluZm8tPmF0dHJzLT5hdHRycyA6Cj4gPiA+IE5VTEw7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoGlmIChhdHRycykgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZm9yIChhdHRyID0gYXR0cnM7ICphdHRyOyBhdHRyKyspCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGF0dHJjb3VudF9vcmlnKys7Cj4gCj4g
PiBub3QgcmVhbGx5IHJlbGF0ZWQgd2l0aCB0aGUgY2hhbmdlLi4uIG1heWJlIGp1c3QgbWVudGlv
biBpdCBpbiB0aGUgY29tbWl0Pwo+IAo+IEhtbS4uLiBJdCdzIHJlbGF0ZWQgdG8gbWFrZSBrcmVh
bGxvY19hcnJheSgpIHRvIHdvcmsgYXMgZXhwZWN0ZWQuCj4gCgpIbW0sIEkgdGhpbmsgaXQncyBh
cmd1YWJsZSA6KS4gd2hpbGUoKSAtPiBmb3IoKSBpdCdzIG5vdCByZWFsbHkgbmVlZGVkIHVubGVz
cwpJJ20gbWlzc2luZyBzb21ldGhpbmcuIFlvdSBjb3VsZCBldmVuIGluaXRpYWxpemUgJ2F0dHJz
JyB0byBOVUxMIGF0IGRlY2xhcmF0aW9uCmFuZCBrZWVwIHRoZSBhYm92ZSBkaWZmIG1pbmltdW0u
CgpUaGF0IHNhaWQsIEkgYWN0dWFsbHkgcHJlZmVyIHRoaXMgc3R5bGUgKGV2ZW4gdGhvdWdoIHNv
bWUgcGVvcGxlIGRvbid0IGxpa2UgbXVjaAp0aGUgdGVybmFyeSBvcGVyYXRvcikuCgo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgfQo+IAo+IC4uLgo+IAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWlvX2Rl
dl9vcGFxdWUtPmNoYW5fYXR0cl9ncm91cC5hdHRycyA9Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBrY2FsbG9jKGF0dHJjb3VudCArIDEsCj4gPiA+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZW9mKGlpb19kZXZfb3BhcXVlLT5j
aGFuX2F0dHJfZ3JvdXAuYXR0cnNbMF0pLAo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoEdGUF9LRVJORUwpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKga3JlYWxsb2NfYXJyYXkoYXR0cnMsIGF0dHJjb3VudCArIDEsIHNpemVv
ZigqYXR0cnMpLAo+ID4gPiBHRlBfS0VSTkVMKTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChp
aW9fZGV2X29wYXF1ZS0+Y2hhbl9hdHRyX2dyb3VwLmF0dHJzID09IE5VTEwpIHsKPiA+IAo+ID4g
c2luY2UgeW91J3JlIGhlcmUgYW5kIHlvdSBhbHNvIGFscmVhZHkgZGlkIHNvbWUgc3R5bGUgY2xl
YW51cHMgYWJvdmUsIG1heWJlCj4gPiBjaGFuZ2UgaXQgdG8gJ2lmICghaWlvX2Rldl9vcGFxdWUt
PmNoYW5fYXR0cl9ncm91cC5hdHRycyknPwo+IAo+IEkgZG9uJ3QgdGhpbmsgaXQncyByZWxhdGVk
IChidXQgeW91IGNhbiB0ZWxsIHRoYXQgdGhpcyBjaGVjayByZWxhdGVkIHRvCj4gdGhlIGFsbG9j
YXRvciwgYW5kIHNpbmNlIHdlIHRvdWNoIGl0LCB3ZSBtYXkgdG91Y2ggdGhpcyksIGlmIEpvbmF0
aGFuCj4gd2FudHMgdGhpcywgSSBkZWZpbml0ZWx5IGRvLgoKRmFpciBlbm91Z2guLi4KCgotIE51
bm8gU8OhCg==

