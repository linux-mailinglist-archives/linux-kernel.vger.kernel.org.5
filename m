Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1A77B468
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjHNImA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjHNIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997BD12E;
        Mon, 14 Aug 2023 01:41:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe85fd3d27so6625930e87.0;
        Mon, 14 Aug 2023 01:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692002482; x=1692607282;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KGBSPUpiLgVTtyzIweMSaMran7abtJLxOeZ2Kx9Oc08=;
        b=UZDxH1cMhWSM7tfUX22y9EPjq4qfYHR/nUFiv4+IzW5+DV6KgcOrwB0k6uuPon9j/B
         H+u6UuXwu0jsTB6Sp0W2wZha8bSbPhRAosak1SS57Kc5/ZeCWJC6SFpXsXbDTUDDgSnh
         dqtSpKi5FcrGJ8Bp1MhrPoibw+2VWtoHvDK6uIPejs9/BSms8uZHa+wwCYYGBoYEAvGd
         JH4/pjk+fi1Jws1kqAIdToezSAxmZnsmLX3CsJ0BEiahXuW33TPMIgnTs0Z9yvbZjeAi
         3QrioZcrl5upUHUQnQpdEDIkIyueksYbTiUp8KZ6IM1Di+KFVu0hOygWnm9iw0wT9m/f
         k9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692002482; x=1692607282;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGBSPUpiLgVTtyzIweMSaMran7abtJLxOeZ2Kx9Oc08=;
        b=kzMve6OtI2yvKvqY3LIxzffWF1jZsLMXw4iVU14KZJ1Ry5j54YdnI+E4RhT6Y3pesR
         /gPRblfxcYUJdXSH7Tt60C8kEr7U9Q16RYUDhLUMMpSNnC5/ktnpP4dNaN/+GKvG6mko
         275g4YLJYbLqfo4+QgHu19NOKJPGN979PXbFMvo6L1oUBiuAcMoLU1RkDg4xkA+uVPLP
         A1OGPEw24KLWWsuL4Y/VHEEJ3VgX2YcuKtBI7+RCWUG7Ts9wdWngE+MsOzUzZ5y+qtH3
         ievLH6qzKCDN20XFeDKtfU5qvO1H3HiVxzm/zF032meVNxO2YHX44SG8kl0e3Kx8vyr0
         Kpiw==
X-Gm-Message-State: AOJu0YxWXJVxVRNtJpAZNplNwVnhp+WCm4laCfsVaAJN7InPhAqzT+H2
        1m8v11dmdufnaaR4pGHTAdU=
X-Google-Smtp-Source: AGHT+IFdq9uwDTrEPKApILPtjuaGN+XE2RAcBiApxliguARfNgdsoA/hL+YPeA+cmOvnnpCm/P2zMg==
X-Received: by 2002:a19:2d49:0:b0:4f9:586b:dba1 with SMTP id t9-20020a192d49000000b004f9586bdba1mr5815392lft.4.1692002481521;
        Mon, 14 Aug 2023 01:41:21 -0700 (PDT)
Received: from [100.119.189.1] (95-24-155-142.broadband.corbina.ru. [95.24.155.142])
        by smtp.gmail.com with ESMTPSA id u27-20020ac243db000000b004fe26e36350sm1886231lfl.253.2023.08.14.01.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:41:20 -0700 (PDT)
Message-ID: <b1b923a03fe67ad6f7c96e3f8395a83a8d217ad0.camel@gmail.com>
Subject: Re: [PATCH v4] dt-bindings: net: ftgmac100: convert to yaml version
 from txt
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Po-Yu Chuang <ratbert@faraday-tech.com>,
        Conor Dooley <conor@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Mon, 14 Aug 2023 11:41:20 +0300
In-Reply-To: <20230805135318.6102-1-fr0st61te@gmail.com>
References: <20230805135318.6102-1-fr0st61te@gmail.com>
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

T24gU2F0LCAyMDIzLTA4LTA1IGF0IDE2OjUzICswMzAwLCBJdmFuIE1pa2hheWxvdiB3cm90ZToK
PiBDb252ZXJzaW9uIGZyb20gZnRnbWFjMTAwLnR4dCB0byB5YW1sIGZvcm1hdCB2ZXJzaW9uLgo+
IAo+IFNpZ25lZC1vZmYtYnk6IEl2YW4gTWlraGF5bG92IDxmcjBzdDYxdGVAZ21haWwuY29tPgo+
IC0tLQo+IMKgLi4uL2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1swqDCoMKgwqDC
oMKgIHwgMTAyCj4gKysrKysrKysrKysrKysrKysrCj4gwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvZnRnbWFjMTAwLnR4dMKgwqDCoMKgIHzCoCA2NyAtLS0tLS0tLS0tLS0KPiDCoDIgZmls
ZXMgY2hhbmdlZCwgMTAyIGluc2VydGlvbnMoKyksIDY3IGRlbGV0aW9ucygtKQo+IMKgY3JlYXRl
IG1vZGUgMTAwNjQ0Cj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mYXJh
ZGF5LGZ0Z21hYzEwMC55YW1sCj4gwqBkZWxldGUgbW9kZSAxMDA2NDQKPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Z0Z21hYzEwMC50eHQKPiAKPiBkaWZmIC0tZ2l0Cj4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZhcmFkYXksZnRnbWFjMTAw
LnlhbWwKPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZmFyYWRheSxm
dGdtYWMxMDAueWFtbAo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwMDAw
Li45YmNiYWNiNjY0MGQKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1sCj4gQEAgLTAsMCArMSwx
MDIgQEAKPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+ICslWUFNTCAxLjIK
PiArLS0tCj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L2ZhcmFkYXks
ZnRnbWFjMTAwLnlhbWwjCj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNj
aGVtYXMvY29yZS55YW1sIwo+ICsKPiArdGl0bGU6IEZhcmFkYXkgVGVjaG5vbG9neSBGVEdNQUMx
MDAgZ2lnYWJpdCBldGhlcm5ldCBjb250cm9sbGVyCj4gKwo+ICthbGxPZjoKPiArwqAgLSAkcmVm
OiBldGhlcm5ldC1jb250cm9sbGVyLnlhbWwjCj4gKwo+ICttYWludGFpbmVyczoKPiArwqAgLSBQ
by1ZdSBDaHVhbmcgPHJhdGJlcnRAZmFyYWRheS10ZWNoLmNvbT4KPiArCj4gK3Byb3BlcnRpZXM6
Cj4gK8KgIGNvbXBhdGlibGU6Cj4gK8KgwqDCoCBvbmVPZjoKPiArwqDCoMKgwqDCoCAtIGNvbnN0
OiBmYXJhZGF5LGZ0Z21hYzEwMAo+ICvCoMKgwqDCoMKgIC0gaXRlbXM6Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoCAtIGVudW06Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gYXNwZWVkLGFz
dDI0MDAtbWFjCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gYXNwZWVkLGFzdDI1MDAt
bWFjCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gYXNwZWVkLGFzdDI2MDAtbWFjCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBmYXJhZGF5LGZ0Z21hYzEwMAo+ICsKPiArwqAg
cmVnOgo+ICvCoMKgwqAgbWF4SXRlbXM6IDEKPiArCj4gK8KgIGludGVycnVwdHM6Cj4gK8KgwqDC
oCBtYXhJdGVtczogMQo+ICsKPiArwqAgY2xvY2tzOgo+ICvCoMKgwqAgbWluSXRlbXM6IDEKPiAr
wqDCoMKgIGl0ZW1zOgo+ICvCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IE1BQyBJUCBjbG9jawo+
ICvCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IFJNSUkgUkNMSyBnYXRlIGZvciBBU1QyNTAwLzI2
MDAKPiArCj4gK8KgIGNsb2NrLW5hbWVzOgo+ICvCoMKgwqAgbWluSXRlbXM6IDEKPiArwqDCoMKg
IGl0ZW1zOgo+ICvCoMKgwqDCoMKgIC0gY29uc3Q6IE1BQ0NMSwo+ICvCoMKgwqDCoMKgIC0gY29u
c3Q6IFJDTEsKPiArCj4gK8KgIHBoeS1tb2RlOgo+ICvCoMKgwqAgZW51bToKPiArwqDCoMKgwqDC
oCAtIHJnbWlpCj4gK8KgwqDCoMKgwqAgLSBybWlpCj4gKwo+ICvCoCBwaHktaGFuZGxlOiB0cnVl
Cj4gKwo+ICvCoCB1c2UtbmNzaToKPiArwqDCoMKgIGRlc2NyaXB0aW9uOgo+ICvCoMKgwqDCoMKg
IFVzZSB0aGUgTkMtU0kgc3RhY2sgaW5zdGVhZCBvZiBhbiBNRElPIFBIWS4gQ3VycmVudGx5IGFz
c3VtZXMKPiArwqDCoMKgwqDCoCBybWlpICgxMDBiVCkgYnV0IGtlcHQgYXMgYSBzZXBhcmF0ZSBw
cm9wZXJ0eSBpbiBjYXNlIE5DLVNJCj4gZ3Jvd3Mgc3VwcG9ydAo+ICvCoMKgwqDCoMKgIGZvciBh
IGdpZ2FiaXQgbGluay4KPiArwqDCoMKgIHR5cGU6IGJvb2xlYW4KPiArCj4gK8KgIG5vLWh3LWNo
ZWNrc3VtOgo+ICvCoMKgwqAgZGVzY3JpcHRpb246Cj4gK8KgwqDCoMKgwqAgVXNlZCB0byBkaXNh
YmxlIEhXIGNoZWNrc3VtIHN1cHBvcnQuIEhlcmUgZm9yIGJhY2t3YXJkCj4gK8KgwqDCoMKgwqAg
Y29tcGF0aWJpbGl0eSBhcyB0aGUgZHJpdmVyIG5vdyBzaG91bGQgaGF2ZSBjb3JyZWN0IGRlZmF1
bHRzCj4gYmFzZWQgb24KPiArwqDCoMKgwqDCoCB0aGUgU29DLgo+ICvCoMKgwqAgdHlwZTogYm9v
bGVhbgo+ICvCoMKgwqAgZGVwcmVjYXRlZDogdHJ1ZQo+ICsKPiArwqAgbWRpbzoKPiArwqDCoMKg
ICRyZWY6IC9zY2hlbWFzL25ldC9tZGlvLnlhbWwjCj4gKwo+ICtyZXF1aXJlZDoKPiArwqAgLSBj
b21wYXRpYmxlCj4gK8KgIC0gcmVnCj4gK8KgIC0gaW50ZXJydXB0cwo+ICsKPiArdW5ldmFsdWF0
ZWRQcm9wZXJ0aWVzOiBmYWxzZQo+ICsKPiArZXhhbXBsZXM6Cj4gK8KgIC0gfAo+ICvCoMKgwqAg
ZXRoZXJuZXRAMWU2NjAwMDAgewo+ICvCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImFzcGVl
ZCxhc3QyNTAwLW1hYyIsICJmYXJhZGF5LGZ0Z21hYzEwMCI7Cj4gK8KgwqDCoMKgwqDCoMKgIHJl
ZyA9IDwweDFlNjYwMDAwIDB4MTgwPjsKPiArwqDCoMKgwqDCoMKgwqAgaW50ZXJydXB0cyA9IDwy
PjsKPiArwqDCoMKgwqDCoMKgwqAgdXNlLW5jc2k7Cj4gK8KgwqDCoCB9Owo+ICsKPiArwqDCoMKg
IGV0aGVybmV0QDFlNjgwMDAwIHsKPiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJhc3Bl
ZWQsYXN0MjUwMC1tYWMiLCAiZmFyYWRheSxmdGdtYWMxMDAiOwo+ICvCoMKgwqDCoMKgwqDCoCBy
ZWcgPSA8MHgxZTY4MDAwMCAweDE4MD47Cj4gK8KgwqDCoMKgwqDCoMKgIGludGVycnVwdHMgPSA8
Mj47Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBwaHktaGFuZGxlID0gPCZwaHk+Owo+ICvCoMKgwqDC
oMKgwqDCoCBwaHktbW9kZSA9ICJyZ21paSI7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBtZGlvIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsKPiArCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcGh5OiBldGhlcm5ldC1waHlAMSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjb21wYXRpYmxlID0gImV0aGVybmV0LXBoeS1pZWVlODAyLjMtYzIyIjsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwxPjsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Owo+ICvCoMKgwqDCoMKgwqDCoCB9Owo+ICvCoMKgwqAgfTsKPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mdGdtYWMxMDAudHh0Cj4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Z0Z21hYzEwMC50eHQKPiBk
ZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAyOTIzNDAyMWY2MDEuLjAwMDAwMDAwMDAw
MAo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZnRnbWFjMTAw
LnR4dAo+ICsrKyAvZGV2L251bGwKPiBAQCAtMSw2NyArMCwwIEBACj4gLSogRmFyYWRheSBUZWNo
bm9sb2d5IEZUR01BQzEwMCBnaWdhYml0IGV0aGVybmV0IGNvbnRyb2xsZXIKPiAtCj4gLVJlcXVp
cmVkIHByb3BlcnRpZXM6Cj4gLS0gY29tcGF0aWJsZTogImZhcmFkYXksZnRnbWFjMTAwIgo+IC0K
PiAtwqAgTXVzdCBhbHNvIGNvbnRhaW4gb25lIG9mIHRoZXNlIGlmIHVzZWQgYXMgcGFydCBvZiBh
biBBc3BlZWQKPiBBU1QyNDAwCj4gLcKgIG9yIDI1MDAgZmFtaWx5IFNvQyBhcyB0aGV5IGhhdmUg
c29tZSBzdWJ0bGUgdHdlYWtzIHRvIHRoZQo+IC3CoCBpbXBsZW1lbnRhdGlvbjoKPiAtCj4gLcKg
wqDCoMKgIC0gImFzcGVlZCxhc3QyNDAwLW1hYyIKPiAtwqDCoMKgwqAgLSAiYXNwZWVkLGFzdDI1
MDAtbWFjIgo+IC3CoMKgwqDCoCAtICJhc3BlZWQsYXN0MjYwMC1tYWMiCj4gLQo+IC0tIHJlZzog
QWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSByZWdpc3RlciBzZXQgZm9yIHRoZSBkZXZpY2UKPiAt
LSBpbnRlcnJ1cHRzOiBTaG91bGQgY29udGFpbiBldGhlcm5ldCBjb250cm9sbGVyIGludGVycnVw
dAo+IC0KPiAtT3B0aW9uYWwgcHJvcGVydGllczoKPiAtLSBwaHktaGFuZGxlOiBTZWUgZXRoZXJu
ZXQudHh0IGZpbGUgaW4gdGhlIHNhbWUgZGlyZWN0b3J5Lgo+IC0tIHBoeS1tb2RlOiBTZWUgZXRo
ZXJuZXQudHh0IGZpbGUgaW4gdGhlIHNhbWUgZGlyZWN0b3J5LiBJZiB0aGUKPiBwcm9wZXJ0eSBp
cwo+IC3CoCBhYnNlbnQsICJyZ21paSIgaXMgYXNzdW1lZC4gU3VwcG9ydGVkIHZhbHVlcyBhcmUg
InJnbWlpKiIgYW5kCj4gInJtaWkiIGZvcgo+IC3CoCBhc3BlZWQgcGFydHMuIE90aGVyICh1bmtu
b3duKSBwYXJ0cyB3aWxsIGFjY2VwdCBhbnkgdmFsdWUuCj4gLS0gdXNlLW5jc2k6IFVzZSB0aGUg
TkMtU0kgc3RhY2sgaW5zdGVhZCBvZiBhbiBNRElPIFBIWS4gQ3VycmVudGx5Cj4gYXNzdW1lcwo+
IC3CoCBybWlpICgxMDBiVCkgYnV0IGtlcHQgYXMgYSBzZXBhcmF0ZSBwcm9wZXJ0eSBpbiBjYXNl
IE5DLVNJIGdyb3dzCj4gc3VwcG9ydAo+IC3CoCBmb3IgYSBnaWdhYml0IGxpbmsuCj4gLS0gbm8t
aHctY2hlY2tzdW06IFVzZWQgdG8gZGlzYWJsZSBIVyBjaGVja3N1bSBzdXBwb3J0LiBIZXJlIGZv
cgo+IGJhY2t3YXJkCj4gLcKgIGNvbXBhdGliaWxpdHkgYXMgdGhlIGRyaXZlciBub3cgc2hvdWxk
IGhhdmUgY29ycmVjdCBkZWZhdWx0cyBiYXNlZAo+IG9uCj4gLcKgIHRoZSBTb0MuCj4gLS0gY2xv
Y2tzOiBJbiBhY2NvcmRhbmNlIHdpdGggdGhlIGdlbmVyaWMgY2xvY2sgYmluZGluZ3MuIE11c3QK
PiBkZXNjcmliZSB0aGUgTUFDCj4gLcKgIElQIGNsb2NrLCBhbmQgb3B0aW9uYWxseSBhbiBSTUlJ
IFJDTEsgZ2F0ZSBmb3IgdGhlCj4gQVNUMjUwMC9BU1QyNjAwLiBUaGUKPiAtwqAgcmVxdWlyZWQg
TUFDIGNsb2NrIG11c3QgYmUgdGhlIGZpcnN0IGNlbGwuCj4gLS0gY2xvY2stbmFtZXM6Cj4gLQo+
IC3CoMKgwqDCoMKgIC0gIk1BQ0NMSyI6IFRoZSBNQUMgSVAgY2xvY2sKPiAtwqDCoMKgwqDCoCAt
ICJSQ0xLIjogQ2xvY2sgZ2F0ZSBmb3IgdGhlIFJNSUkgUkNMSwo+IC0KPiAtT3B0aW9uYWwgc3Vi
bm9kZXM6Cj4gLS0gbWRpbzogU2VlIG1kaW8udHh0IGZpbGUgaW4gdGhlIHNhbWUgZGlyZWN0b3J5
Lgo+IC0KPiAtRXhhbXBsZToKPiAtCj4gLcKgwqDCoMKgwqDCoMKgbWFjMDogZXRoZXJuZXRAMWU2
NjAwMDAgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImFz
cGVlZCxhc3QyNTAwLW1hYyIsCj4gImZhcmFkYXksZnRnbWFjMTAwIjsKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4MWU2NjAwMDAgMHgxODA+Owo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpbnRlcnJ1cHRzID0gPDI+Owo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB1c2UtbmNzaTsKPiAtwqDCoMKgwqDCoMKgwqB9Owo+IC0KPiAtRXhhbXBs
ZSB3aXRoIHBoeS1oYW5kbGU6Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoG1hYzE6IGV0aGVybmV0QDFl
NjgwMDAwIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJh
c3BlZWQsYXN0MjUwMC1tYWMiLAo+ICJmYXJhZGF5LGZ0Z21hYzEwMCI7Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9IDwweDFlNjgwMDAwIDB4MTgwPjsKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0cyA9IDwyPjsKPiAtCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHBoeS1oYW5kbGUgPSA8JnBoeT47Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHBoeS1tb2RlID0gInJnbWlpIjsKPiAtCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoG1kaW8gewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjc2l6ZS1jZWxscyA9IDwwPjsKPiAtCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaHk6IGV0aGVybmV0
LXBoeUAxIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gImV0aGVybmV0LXBoeS1pZWVlODAyLjMtCj4g
YzIyIjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZWcgPSA8MT47Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB9Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+
IC3CoMKgwqDCoMKgwqDCoH07CgpHZW50bGUgcGluZywgSSB0aGluayBJIHJlc29sdmVkIGFsbCBj
b21tZW50cyByZWxhdGVkLCBhbnl0aGluZyBlbHNlPwoKVGhhbmtzLgo=

