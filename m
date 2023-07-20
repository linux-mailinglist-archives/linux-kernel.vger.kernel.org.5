Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D2975A7EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjGTHhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGTHhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:37:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44489270C;
        Thu, 20 Jul 2023 00:36:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso543564a12.3;
        Thu, 20 Jul 2023 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689838616; x=1690443416;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qZwMtxgR24ffVzoknfQ/q2ATGXoER3/4MloiA6E2QA=;
        b=UqUfLPVvOzR0QUcX3cHeyso0h74BPjo2kY5a/VmeXpH413em3icaIykI4fXiMlRP6o
         cJtTpdfFiE3jLRr7+DNcSdsACqr1eTZXndPSKiJLyKRqIQCFG70x2xyDR5aI50jmx0dN
         X8tCHVQoNP8fdbox4QIpF0O6Qoh6ZZRdJWExkctP50fBquEpim8y7CRxT7ZcWBaEoyKs
         VTe0V6JI3X/KHOEIZlqTC8DkjZc4borNy1Mwa1XXln2OAnzuSET7OnfVD0dwK8n4r/uZ
         vI4W4qzeSDJudRpcx51gAakfYf/D+RVMhEC0eQU6zeBnQi4rp8nMsrGiFcpnLKAW0Z8b
         Szew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689838616; x=1690443416;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qZwMtxgR24ffVzoknfQ/q2ATGXoER3/4MloiA6E2QA=;
        b=jrB2UYQeem0VVZ7+kGEtpYSRY2USywojSchTgPeARXerZrhZ01PZwGQGYSUZ4ZQPjd
         vWYb/eDr0zTIAG2eIlvBPV9gi/rzzwz5d4yiT2NWYCE2J/s15+IkSR47YH39IvVlzT0+
         J1cTu8+0L/nXXcplNjPaKMjjyBnWimNPWIsvxAdlvcUYYoGxUajSIdh0df/laODfPhtk
         TN86wwbyNetQIaXuMb0umxWe3pOIaAboI3F2PM3J7fh9gqRPvERPt0fTrE79mA0jRHpH
         +RZeVmz3TMf5plmeL6DqJ3Kkru9QJ+/GFXhEGFyIxa9cl3RE/bcin7nl6doatu2iiNZw
         V5Sw==
X-Gm-Message-State: ABy/qLatkbCowHiGizlm0bNU8H4rugeYdE38sDu+fLArzsLQeTin0CvB
        3WBbov8E1WhF37m8S97JF9N45g03yKXVhg==
X-Google-Smtp-Source: APBJJlHHT2doglvzYSOvcOqT5o5T1PQEtjXjBKQGd6NH6kqb6tc0LxcWNtxYdD7xuYiiIs2yaQf+mw==
X-Received: by 2002:a17:907:c0a:b0:991:b613:9b65 with SMTP id ga10-20020a1709070c0a00b00991b6139b65mr4893318ejc.37.1689838616542;
        Thu, 20 Jul 2023 00:36:56 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906925a00b00982be08a9besm277871ejx.172.2023.07.20.00.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:36:56 -0700 (PDT)
Message-ID: <810d290b629e2d40550a2b375229fe2e4dd58085.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: imu: adis16475.c: Add has_burst32 flag to
 adis16477 devices
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>, jic23@kernel.org,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 20 Jul 2023 09:39:27 +0200
In-Reply-To: <20230719123152.309624-3-ramona.bolboaca@analog.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
         <20230719123152.309624-3-ramona.bolboaca@analog.com>
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

T24gV2VkLCAyMDIzLTA3LTE5IGF0IDE1OjMxICswMzAwLCBSYW1vbmEgQm9sYm9hY2Egd3JvdGU6
Cj4gYWRpczE2NDc3IGRldmljZXMgc3VwcG9ydCBidXJzdDMyIGZ1bmN0aW9uLCB0aHVzIGhhc19i
dXJzdDMyCj4gZmxhZyBzaG91bGQgYmUgc2V0IHRvIHRydWUuCj4gCj4gU2lnbmVkLW9mZi1ieTog
UmFtb25hIEJvbGJvYWNhIDxyYW1vbmEuYm9sYm9hY2FAYW5hbG9nLmNvbT4KPiAtLS0KClVwcy4u
LgoKUmV2aWV3ZWQtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT4KCj4gwqBkcml2ZXJz
L2lpby9pbXUvYWRpczE2NDc1LmMgfCAzICsrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMgYi9k
cml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMKPiBpbmRleCAyNDNmMGE5MWZkZjkuLjE3Mjc1YTUz
Y2EyYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMKPiArKysgYi9k
cml2ZXJzL2lpby9pbXUvYWRpczE2NDc1LmMKPiBAQCAtNzI2LDYgKzcyNiw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYWRpczE2NDc1X2NoaXBfaW5mbwo+IGFkaXMxNjQ3NV9jaGlwX2luZm9bXSA9
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5tYXhfZGVjID0gMTk5OSwKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zeW5jID0gYWRpczE2NDc1X3N5bmNfbW9k
ZSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5udW1fc3luYyA9IEFSUkFZX1NJ
WkUoYWRpczE2NDc1X3N5bmNfbW9kZSksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC5oYXNfYnVyc3QzMiA9IHRydWUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
YWRpc19kYXRhID0gQURJUzE2NDc1X0RBVEEoMTY0NzcsICZhZGlzMTY0NzVfdGltZW91dHMpLAo+
IMKgwqDCoMKgwqDCoMKgwqB9LAo+IMKgwqDCoMKgwqDCoMKgwqBbQURJUzE2NDc3XzJdID0gewo+
IEBAIC03NDEsNiArNzQyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZGlzMTY0NzVfY2hpcF9p
bmZvCj4gYWRpczE2NDc1X2NoaXBfaW5mb1tdID0gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLm1heF9kZWMgPSAxOTk5LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLnN5bmMgPSBhZGlzMTY0NzVfc3luY19tb2RlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgLm51bV9zeW5jID0gQVJSQVlfU0laRShhZGlzMTY0NzVfc3luY19tb2RlKSwKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmhhc19idXJzdDMyID0gdHJ1ZSwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5hZGlzX2RhdGEgPSBBRElTMTY0NzVfREFUQSgx
NjQ3NywgJmFkaXMxNjQ3NV90aW1lb3V0cyksCj4gwqDCoMKgwqDCoMKgwqDCoH0sCj4gwqDCoMKg
wqDCoMKgwqDCoFtBRElTMTY0NzdfM10gPSB7Cj4gQEAgLTc1Niw2ICs3NTgsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGFkaXMxNjQ3NV9jaGlwX2luZm8KPiBhZGlzMTY0NzVfY2hpcF9pbmZvW10g
PSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubWF4X2RlYyA9IDE5OTksCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuc3luYyA9IGFkaXMxNjQ3NV9zeW5jX21v
ZGUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubnVtX3N5bmMgPSBBUlJBWV9T
SVpFKGFkaXMxNjQ3NV9zeW5jX21vZGUpLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAuaGFzX2J1cnN0MzIgPSB0cnVlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LmFkaXNfZGF0YSA9IEFESVMxNjQ3NV9EQVRBKDE2NDc3LCAmYWRpczE2NDc1X3RpbWVvdXRzKSwK
PiDCoMKgwqDCoMKgwqDCoMKgfSwKPiDCoMKgwqDCoMKgwqDCoMKgW0FESVMxNjQ2NV8xXSA9IHsK
Cg==

