Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0064F7AEAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjIZKsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIZKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:48:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF9C95;
        Tue, 26 Sep 2023 03:47:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so9769885a12.0;
        Tue, 26 Sep 2023 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695725273; x=1696330073; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah8q1KKs4HXvdvUyMFtnXRhDtB0B9RFZPiCQ8k7YLtU=;
        b=TqJk0OYKtgwAw8Mx/DCOv+RaP5DH1iViWN0qt+yR3TC/aqFXnc8ruU6PbWHi9NWvfC
         mwmVp57jRn1A4O6KUqamXJzBWBTLzFgB0a+bipH0X5PDuy943e30oZZneEO50Cxu+PCf
         A3NYdpZzrZ4dQU8s5aX2AuXEUdHcHlxLncD24Iw8xw4MHJXXwO8sESH7oTYIUQ+ifSe5
         jqZ1XkdAIU9eBE3I9jXq46V/I9VUAnlcFUQcigTYVMDoNaRprYr3gXvbesja0jaYBciX
         B5llNskZl7Ok5rdvLix2n9A2CyYSAwQQMWyPxOXppWahWZbafpwxfzOZCZ6oZNGwejd9
         zOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725273; x=1696330073;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ah8q1KKs4HXvdvUyMFtnXRhDtB0B9RFZPiCQ8k7YLtU=;
        b=lEGtLdPSvObNUnFs5MU7xkWPEKJ6wKAP8sbXMXN8KH+9lJUXRHjUHhP4xIChQApNRY
         KQBsuXD95XqUas7T/NbtgUFBkUevtH89NosO++l52EH172c11Y4xYbfeURGdSS7Dksqq
         wzW+LXO8V5L6IloajuDGNOhPeJH0Vm4+ABSDUbRLXPKqw2ODh4ExdzqBq0XNDit4Iny2
         iMtbpvrBBkYbCdvQ91wqZ+GJr8VpWDog9wRNTxy58P3s3aYb3YN1Jh6+j4p8tXqAdpCQ
         qtDlp5BpRBbusIcC6V4QJQrBINi0U9DgP6UE+rf0L2t+Y0cIFrkbLPNiZYZOlM2qpJSP
         TddQ==
X-Gm-Message-State: AOJu0YzxbGqxpk3zI5dENnvvMsKa3PzRMwBmkfBvHJXTwqG32teGJdft
        PG82ahMdKLcsZTZ0Lx7ZJl0=
X-Google-Smtp-Source: AGHT+IFWQfqaVrdjgbYs3idbfr+HhqyCCeO56y2CaUh8EWKspFLKOPRz8g/gq2Rc3I4aCpW+1vRD/A==
X-Received: by 2002:aa7:d491:0:b0:52f:34b3:7c4 with SMTP id b17-20020aa7d491000000b0052f34b307c4mr7832596edr.39.1695725273396;
        Tue, 26 Sep 2023 03:47:53 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef34:6000:bd39:43a2:571c:1c76? (p200300f6ef346000bd3943a2571c1c76.dip0.t-ipconnect.de. [2003:f6:ef34:6000:bd39:43a2:571c:1c76])
        by smtp.gmail.com with ESMTPSA id g4-20020aa7c584000000b0052e2472f884sm6684112edq.21.2023.09.26.03.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:47:52 -0700 (PDT)
Message-ID: <d1c7ce3085ad30e568181852df07fed3a0427d8c.camel@gmail.com>
Subject: Re: [PATCH 1/1] iio: imu: adis16475.c: Add buffer padding after
 temp channel
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ramona Gradinariu <ramona.gradinariu@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Sep 2023 12:50:38 +0200
In-Reply-To: <20230926085721.645687-2-ramona.gradinariu@analog.com>
References: <20230926085721.645687-1-ramona.gradinariu@analog.com>
         <20230926085721.645687-2-ramona.gradinariu@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
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

T24gVHVlLCAyMDIzLTA5LTI2IGF0IDExOjU3ICswMzAwLCBSYW1vbmEgR3JhZGluYXJpdSB3cm90
ZToKPiBUaGUgdGVtcGVyYXR1cmUgY2hhbm5lbCBoYXMgMTYtYml0IHN0b3JhZ2Ugc2l6ZS4gV2Ug
bmVlZCB0byBwZXJmb3JtCj4gdGhlIHBhZGRpbmcgdG8gaGF2ZSB0aGUgYnVmZmVyIGVsZW1lbnRz
IG5hdHVyYWxseSBhbGlnbmVkIGluIGNhc2UKPiB0aGUgdGVtcGVyYXR1cmUgY2hhbm5lbCBpcyBl
bmFibGVkIGFuZCB0aGVyZSBhcmUgYW55IDMyLWJpdCBzdG9yYWdlCj4gc2l6ZSBjaGFubmVscyBl
bmFibGVkIHdoaWNoIGhhdmUgYSBzY2FuIGluZGV4IGhpZ2hlciB0aGFuIHRoZQo+IHRlbXBlcmF0
dXJlIGNoYW5uZWwgc2NhbiBpbmRleC4KPiAKPiBGaXhlczogOGY2YmM4N2Q2N2MwICgiaWlvOiBp
bXU6IGFkaXMxNjQ3NS5jOiBBZGQgZGVsdGEgYW5nbGUgYW5kIGRlbHRhCj4gdmVsb2NpdHkgY2hh
bm5lbHMiKQo+IFNpZ25lZC1vZmYtYnk6IFJhbW9uYSBHcmFkaW5hcml1IDxyYW1vbmEuZ3JhZGlu
YXJpdUBhbmFsb2cuY29tPgo+IC0tLQoKUmV2aWV3ZWQtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5h
bG9nLmNvbT4KCj4gwqBkcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMgfCAxMCArKysrKysrKysr
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMgYi9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMK
PiBpbmRleCAwMGU0ZTA5Y2RhZmIuLjlhZjA3ZmVjMGQ4OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2lpby9pbXUvYWRpczE2NDc1LmMKPiArKysgYi9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMK
PiBAQCAtMTE5Nyw2ICsxMTk3LDE2IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBhZGlzMTY0NzVfdHJp
Z2dlcl9oYW5kbGVyKGludCBpcnEsCj4gdm9pZCAqcCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHN3aXRjaCAoYml0KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjYXNlIEFESVMxNjQ3NV9TQ0FOX1RFTVA6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgc3QtPmRhdGFbaSsrXSA9IGJ1ZmZlcltvZmZzZXRdOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyoKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSB0ZW1wZXJhdHVy
ZSBjaGFubmVsIGhhcyAxNi1iaXQgc3RvcmFnZSBzaXplLgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogV2UgbmVlZCB0byBwZXJmb3JtIHRoZSBwYWRk
aW5nIHRvIGhhdmUgdGhlIGJ1ZmZlcgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogZWxlbWVudHMgbmF0dXJhbGx5IGFsaWduZWQgaW4gY2FzZSB0aGVy
ZSBhcmUgYW55Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiAzMi1iaXQgc3RvcmFnZSBzaXplIGNoYW5uZWxzIGVuYWJsZWQgd2hpY2ggaGF2ZSBhCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBzY2FuIGlu
ZGV4IGhpZ2hlciB0aGFuIHRoZSB0ZW1wZXJhdHVyZSBjaGFubmVsIHNjYW4KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGluZGV4Lgo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoKmluZGlvX2Rldi0+YWN0aXZl
X3NjYW5fbWFzayAmCj4gR0VOTUFTSyhBRElTMTY0NzVfU0NBTl9ERUxUVkVMX1osIEFESVMxNjQ3
NV9TQ0FOX0RFTFRBTkdfWCkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3QtPmRhdGFbaSsrXSA9IDA7CgpZb3UgY291bGQg
dXNlIEFESVMxNjUwMF9CVVJTVF9EQVRBX1NFTF8xX0NITl9NQVNLIGJ1dCBJIGtpbmQgb2YgYWdy
ZWUgbGlrZSB0aGlzCmlzIG1vcmUgb2J2aW91cyB3aGF0J3MgZ29pbmcgb24uLi4KCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjYXNlIEFESVMxNjQ3NV9TQ0FOX0RFTFRBTkdfWCAu
Li4gQURJUzE2NDc1X1NDQU5fREVMVFZFTF9aOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ1ZmZfb2Zmc2V0ID0gQURJUzE2NDc1X1NDQU5fREVMVEFO
R19YOwoK

