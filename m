Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B573780F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378330AbjHRPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378319AbjHRPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:52:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D03BD1;
        Fri, 18 Aug 2023 08:52:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bba6fc4339so16187301fa.2;
        Fri, 18 Aug 2023 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692373929; x=1692978729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FuLHdvC9evO/vBDsVnS/27i/KysraAnb1BCXYxYiXbI=;
        b=n4d/avJ4jGqR2wQ9QId7CL3JMWUXl4ZEp0214DWxpH/kfmxNxLkhsvJqqWCJZye7sq
         LQN0lgnBvK7FBb4kT9tyMTcbJ5kzRPlgbFQaVnesl7lLa/v+HQBbIc+gx4ygfR/LOBq2
         9YSCh55VxZGlcaEj8R0PCR1hRHIHmAtX2LuewerH02IlonvnZRJ80+9ikW8Uu9RVHt+g
         H8+ziwYJIfgPY38n+14rNs83XOuTmdFcwX6NiitNuX83sgFKtUyncvKxJFWBk1hRzpj3
         A8+87BT+GYzWS2h8B0hF+r3NCraSiAqzTJQrJCIsg6GMiYRkdCQtby50xYEfoAjfh5Nh
         6bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692373929; x=1692978729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FuLHdvC9evO/vBDsVnS/27i/KysraAnb1BCXYxYiXbI=;
        b=hjnEU3Pdf85v3Krqlp4ce1bnBVGUZVy3KTbfoESErqn22p/CczrGimI8lv/ikJB5Eo
         iHS0BGwbnroPrcLkokCzkaD6x0Cdrq/R2C5/fw3tp5HU8PZAE7oULwJw/iYPjLH1T4Wl
         aEBeXK3KJeP2j6mKoS1bA7ayxr+z6VC4YS83X/CiT1loAXVepkPoTSQEBy+8TOgYkNSz
         x5c6eeBANKn2NLjrEaHJNBJHws5INMjvsWQl71Pwq39v1UutlIGHNAok2yUxpSWYOvAs
         DjC4MA5oMjEI63ouGURLQKayB9rNqUIGjiJpWd3lOrAZDSIwgUuwcC9tqNB+2M01eikQ
         0bjA==
X-Gm-Message-State: AOJu0YwFd8z/RBNtNQEKkzOb88hXVl48Jx6BwbuWMtEMfE21XqwrJurr
        o0hmpg6kJX9XheStbdRvJgc=
X-Google-Smtp-Source: AGHT+IEZ6D55cFQksN30tY6egZAfQCUFA3JaH8Q78NCfXr7qywhUEpsHzSZoKl1ac4hKHuMQ8QWPsw==
X-Received: by 2002:a05:651c:9:b0:2b9:3684:165 with SMTP id n9-20020a05651c000900b002b936840165mr2241299lja.8.1692373928399;
        Fri, 18 Aug 2023 08:52:08 -0700 (PDT)
Received: from DreamMachine2.lan (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id s17-20020a7bc391000000b003fd2e89620asm6737607wmj.40.2023.08.18.08.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:52:08 -0700 (PDT)
Message-ID: <b209214a80c98f92db57be30883ec78dfc116ab0.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: pressure: bmp280: Allow multiple chips id per
 family of devices
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri, 18 Aug 2023 17:52:07 +0200
In-Reply-To: <ZN9TyGjr/pqLQUpT@smile.fi.intel.com>
References: <cover.1692305434.git.ang.iglesiasg@gmail.com>
         <8856287079b5dc1099f5b98a0168f008fbb8debd.1692305434.git.ang.iglesiasg@gmail.com>
         <ZN9TyGjr/pqLQUpT@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTE4IGF0IDE0OjE5ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gVGh1LCBBdWcgMTcsIDIwMjMgYXQgMTE6MDU6MjFQTSArMDIwMCwgQW5nZWwgSWdsZXNp
YXMgd3JvdGU6Cj4gPiBJbXByb3ZlIGRldmljZSBkZXRlY3Rpb24gaW4gY2VydGFpbiBjaGlwIGZh
bWlsaWVzIGtub3duIHRvIGhhdmUgdmFyaW91cwo+ID4gY2hpcCBpZHMuCj4gCj4gLi4uCj4gCj4g
PiArwqDCoMKgwqDCoMKgwqByZXQgPSAtRUlOVkFMOwo+IAo+IFdoeSBkbyB5b3UgbmVlZCB0aGlz
Li4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgZGF0YS0+Y2hpcF9pbmZv
LT5udW1fY2hpcF9pZDsgaSsrKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKGNoaXBfaWQgPT0gZGF0YS0+Y2hpcF9pbmZvLT5jaGlwX2lkW2ldKSB7Cj4gCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IDA7Cj4gCj4g
Li5hbmQgdGhpcy4uLgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBicmVhazsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4g
PiArwqDCoMKgwqDCoMKgwqB9Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KSB7Cj4gCj4g
Li4uYW5kIHRoaXM/Cj4gCj4gWW91IGNhbiBzaW1wbHkgZG8KPiAKPiDCoMKgwqDCoMKgwqDCoMKg
Zm9yIChpID0gMDsgaSA8IGRhdGEtPmNoaXBfaW5mby0+bnVtX2NoaXBfaWQ7IGkrKykgewo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGNoaXBfaWQgPT0gZGF0YS0+Y2hpcF9p
bmZvLT5jaGlwX2lkW2ldKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGJyZWFrOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoGlm
IChpIDwgZGF0YS0+Y2hpcF9pbmZvLT5udW1fY2hpcF9pZCkgewo+IAoKR290IGl0LCBtdWNoIGNs
ZWFuZXIgYWxzby4KCj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Ly8gMHg8aWQ+LCBzbyBmb3VyIGNoYXJzIHBlciBudW1iZXIgcGx1cyBvbmUgc3BhY2UgKyBFTkRM
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZV90IG5idWYgPSA1KmRhdGEt
PmNoaXBfaW5mby0+bnVtX2NoaXBfaWQqc2l6ZW9mKGNoYXIpOwo+IAo+IEJlc2lkZXMgbGFjayBv
ZiBzcGFjZXMuLi4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjaGFyICpi
dWYgPSBrbWFsbG9jKG5idWYsIEdGUF9LRVJORUwpOwo+IAo+IC4uLnRoaXMgYXQgbGVhc3Qgc2hv
dWxkIGJlIGttYWxsb2NfYXJyYXkoKSBhbmQgb24gdG9wIG1heWJlIHNvbWV0aGluZyBmcm9tCj4g
b3ZlcmZsb3cuaCB3aWxsIGJlIG5lZWRlZC4KClN1cmUsIEknbGwgZ2l2ZSBhIGxvb2suIEkgZGlk
bid0IHdhbnQgdG8gZG8gc3RyaW5nIG1hbmlwdWxhdGlvbnMgb24gYSBrZXJuZWwKZHJpdmVyIGJ1
dCBjb3VsZG4ndCBmb3VuZCBhIHdheSB0byBsb2cgdGhlIGVycm9yIG1lYW5pbmdmdWxseSBpbiBv
bmUgZW50cnkuCgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghYnVmKQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
cmV0Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7
IGkgPCBkYXRhLT5jaGlwX2luZm8tPm51bV9jaGlwX2lkOyBpKyspCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNucHJpbnRmKCZidWZbaSo1XSwgbmJ1
ZiwgIjB4JXggIiwgZGF0YS0+Y2hpcF9pbmZvLQo+ID4gPmNoaXBfaWRbaV0pOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ1ZltuYnVmLTFdID0gJ1wwJzsKPiA+ICsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgImJhZCBjaGlwIGlkOiBl
eHBlY3RlZCBbICVzIF0gZ290IDB4JXhcbiIsIGJ1ZiwKPiA+IGNoaXBfaWQpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtmcmVlKGJ1Zik7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gCj4gLi4u
Cj4gCj4gPiAtwqDCoMKgwqDCoMKgwqBjb25zdCB1bnNpZ25lZCBpbnQgY2hpcF9pZDsKPiAKPiBZ
ZWFoLCB0aGlzIGNvbnN0IG1ha2VzIGEgbGl0dGxlIHNlbnNlLi4uCj4gCj4gPiArwqDCoMKgwqDC
oMKgwqBjb25zdCB1bnNpZ25lZCBpbnQgKmNoaXBfaWQ7Cj4gCj4gLi4uYnV0IG5vdCB0aGlzIDot
KQoKSXNuJ3QgdGhlIHNhbWUgY2FzZSBhcyAiY29uc3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgKmNo
YW5uZWxzIiBvciAiY29uc3QgaW50CipvdmVyc2FtcGxpbmdfdGVtcF9hdmFpbCIuIEkgdGhvZ2h0
IHRoYXQgdGhpcyBtZWFudCBhIHBvaW50ZXIgdG8gYSBjb25zdGFudAppbnRlZ2VyLiBPbiBibXAy
ODAtY29yZSBJIGRlY2xhcmUgdGhlIGFycmF5cyB3aXRoIHRoZSBtb2RpZmllcnMgc3RhdGljIGNv
bnN0LgoKPiBXaGF0IEknbSB3b25kZXJpbmcgaXMgd2h5IGl0J3MgaW50IGFuZCBub3QgdTggLyB1
MTYKPiAoYXMgaXQgc2VlbXMgb25seSBhIGJ5dGUgdmFsdWUgdGhlcmUpLgoKWWVhaCwgY2FuIGJl
IHU4LCBhcyB0aGUgcmVnIHdpZHRoIGlzIDEgYnl0ZSBhbmQgdGhpcyBJRHMgYXJlIHN0b3JlZCBv
biBvbmUgcmVnLgpJIGp1c3QgY2FycmllZCBvdmVyIHRoZSBpbnQgdHlwZSBmcm9tIHByZXZpb3Vz
IHZlcnNpb25zLCBidXQgaXQncyBqdXN0IHdhc3RpbmcKc3BhY2UgOi8KCj4gCj4gPiArwqDCoMKg
wqDCoMKgwqBpbnQgbnVtX2NoaXBfaWQ7Cj4gCj4gdW5zaWduZWQuCj4gClRoYW5rcyBmb3IgeW91
ciB0aW1lIQoKS2luZCByZWdhcmRzLApBbmdlbAo=

