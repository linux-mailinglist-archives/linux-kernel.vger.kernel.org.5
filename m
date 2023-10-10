Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DECB7C410E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjJJUW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJJUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:22:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DA494;
        Tue, 10 Oct 2023 13:22:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so77888381fa.3;
        Tue, 10 Oct 2023 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696969372; x=1697574172; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vDjPtqZx84zWguUSFW1JsiqpZUg5GWs2kKDpjG6iuuE=;
        b=NrpAmGDko6K4pgTw8dZ3MtXYZqXcvmi//oKGO9eaoSbGmQD5N49oySQz96YpV+3py9
         saDrNHkWlXFX3eeSGvHwvOY42O41/kwP8Cb75xFrwakE9AxtkBqw1YEF5lkT4Wlrozbm
         pb6vLGJ7WQEsmgR8jqqYj5yB4581TqXIC8i7A6LMGdHcYUYv92MdhAM7Biyq6uuI/bS6
         arn+6tt3K6JHLaJHL7qz5nWAGGsSBc37QO0B8t4WY3zNSFLdepvuKc+Sc61My16J205Z
         u3Apq2LeAx2DNxSS4EAQ7k4kGxnCU56ILHgQ5ljCD2Hgb7MPkTh2S/8gqLIvblcfRP98
         Iksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969372; x=1697574172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDjPtqZx84zWguUSFW1JsiqpZUg5GWs2kKDpjG6iuuE=;
        b=fIeVECZoVOU8/gAS+DY+iQemDpmzLqpfQuJZFCEKdczjlNhbFdSNlmfcEJN0mudvQj
         BxZ7jNYCh0ELmXEfOnEGDQefYuyWW3QbO46hPvhZ957ua2TYZ4JiwAeyBmnQ7yjchkWb
         Frt4g9ltZRkwoHs6igaPkAlQ0vqwbGpT8jCqIoeoIiVWkUCgO1OLKWyNoZXt19eCifKZ
         GG6eqw5xWUrrbNdadQe3SRVSdSac4w/HKigon6WbTOym7TWTkmYpOrQe3ig6YRJV0YqF
         Gc5h2jxkWwu0h3ZFNVaHIAA84CZMtfBaG8TaOH4V+ni4Si9oRTDEe8uygmhubrExEi8g
         5P/A==
X-Gm-Message-State: AOJu0YzlaAlhCHVKz4A+n79Jc/gLzCt38jykvVbg7ssPrDycFiXl/fZG
        mn846bdAOsArMJeBP5bcxw1Vz0uw9DJFhoAK
X-Google-Smtp-Source: AGHT+IE28CXznW0UVKK+i7P1urClXsfMtm49e1W8qAbYhWfoHwDVTzmedHYwt3dD+7JS6Wd8AmZdug==
X-Received: by 2002:a2e:3a10:0:b0:2bc:bd41:ab7c with SMTP id h16-20020a2e3a10000000b002bcbd41ab7cmr15028105lja.53.1696969371587;
        Tue, 10 Oct 2023 13:22:51 -0700 (PDT)
Received: from [192.168.1.161] ([46.31.31.132])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e7312000000b002ba586d27a2sm2558615ljc.26.2023.10.10.13.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:22:50 -0700 (PDT)
Message-ID: <383064a5b0863a4a616cd60cff8d4bc18e397fd7.camel@gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Tue, 10 Oct 2023 23:22:48 +0300
In-Reply-To: <20231010154042.2ef667b2@jic23-huawei>
References: <20231007234838.8748-1-fr0st61te@gmail.com>
         <20231007234838.8748-2-fr0st61te@gmail.com>
         <20231010154042.2ef667b2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDE1OjQwICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Ogo+IE9uIFN1bizCoCA4IE9jdCAyMDIzIDAyOjQ4OjM3ICswMzAwCj4gSXZhbiBNaWtoYXlsb3Yg
PGZyMHN0NjF0ZUBnbWFpbC5jb20+IHdyb3RlOgo+IAo+ID4gVGhlIGhhcmR3YXJlIGJpbmRpbmcg
Zm9yIGkyYyBjdXJyZW50IG1vbml0b3JpbmcgZGV2aWNlIHdpdGgKPiA+IG92ZXJjdXJyZW50Cj4g
PiBjb250cm9sLgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBJdmFuIE1pa2hheWxvdiA8ZnIwc3Q2
MXRlQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gwqAuLi4vYmluZGluZ3MvaWlvL2FkYy9tYXhpbSxt
YXgzNDQwOC55YW1swqDCoMKgwqDCoCB8IDE0MQo+ID4gKysrKysrKysrKysrKysrKysrCj4gPiDC
oDEgZmlsZSBjaGFuZ2VkLCAxNDEgaW5zZXJ0aW9ucygrKQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2
NDQKPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL21heGltLG1h
eDM0NDA4LnlhbWwKPiA+IAo+ID4gZGlmZiAtLWdpdAo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9tYXhpbSxtYXgzNDQwOC55YW1sCj4gPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL21heGltLG1heDM0NDA4LnlhbWwKPiA+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjk3NDlmMWZkMTgw
Mgo+ID4gLS0tIC9kZXYvbnVsbAo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9hZGMvbWF4aW0sbWF4MzQ0MDgueWFtbAo+ID4gQEAgLTAsMCArMSwxNDEgQEAK
PiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2Up
Cj4gPiArJVlBTUwgMS4yCj4gPiArLS0tCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
c2NoZW1hcy9paW8vYWRjL21heGltLG1heDM0NDA4LnlhbWwjCj4gPiArJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjCj4gPiArCj4gPiArdGl0bGU6
IFR3by0gYW5kIGZvdXItY2hhbm5lbCBjdXJyZW50IG1vbml0b3JzIHdpdGggb3ZlcmN1cnJlbnQK
PiA+IGNvbnRyb2wKPiA+ICsKPiA+ICttYWludGFpbmVyczoKPiA+ICvCoCAtIEl2YW4gTWlraGF5
bG92IDxmcjBzdDYxdGVAZ21haWwuY29tPgo+ID4gKwo+ID4gK2Rlc2NyaXB0aW9uOiB8Cj4gPiAr
wqAgVGhlIE1BWDM0NDA4L01BWDM0NDA5IGFyZSB0d28tIGFuZCBmb3VyLWNoYW5uZWwgY3VycmVu
dCBtb25pdG9ycwo+ID4gdGhhdCBhcmUKPiA+ICvCoCBjb25maWd1cmVkIGFuZCBtb25pdG9yZWQg
d2l0aCBhIHN0YW5kYXJkIEkyQy9TTUJ1cyBzZXJpYWwKPiA+IGludGVyZmFjZS4gRWFjaAo+ID4g
K8KgIHVuaWRpcmVjdGlvbmFsIGN1cnJlbnQgc2Vuc29yIG9mZmVycyBwcmVjaXNpb24gaGlnaC1z
aWRlCj4gPiBvcGVyYXRpb24gd2l0aCBhCj4gPiArwqAgbG93IGZ1bGwtc2NhbGUgc2Vuc2Ugdm9s
dGFnZS4gVGhlIGRldmljZXMgYXV0b21hdGljYWxseSBzZXF1ZW5jZQo+ID4gdGhyb3VnaAo+ID4g
K8KgIHR3byBvciBmb3VyIGNoYW5uZWxzIGFuZCBjb2xsZWN0IHRoZSBjdXJyZW50LXNlbnNlIHNh
bXBsZXMgYW5kCj4gPiBhdmVyYWdlIHRoZW0KPiA+ICvCoCB0byByZWR1Y2UgdGhlIGVmZmVjdCBv
ZiBpbXB1bHNlIG5vaXNlLiBUaGUgcmF3IEFEQyBzYW1wbGVzIGFyZQo+ID4gY29tcGFyZWQgdG8K
PiA+ICvCoCB1c2VyLXByb2dyYW1tYWJsZSBkaWdpdGFsIHRocmVzaG9sZHMgdG8gaW5kaWNhdGUg
b3ZlcmN1cnJlbnQKPiA+IGNvbmRpdGlvbnMuCj4gPiArwqAgT3ZlcmN1cnJlbnQgY29uZGl0aW9u
cyB0cmlnZ2VyIGEgaGFyZHdhcmUgb3V0cHV0IHRvIHByb3ZpZGUgYW4KPiA+IGltbWVkaWF0ZQo+
ID4gK8KgIGluZGljYXRpb24gdG8gc2h1dCBkb3duIGFueSBuZWNlc3NhcnkgZXh0ZXJuYWwgY2ly
Y3VpdHJ5Lgo+ID4gKwo+ID4gK8KgIFNwZWNpZmljYXRpb25zIGFib3V0IHRoZSBkZXZpY2VzIGNh
biBiZSBmb3VuZCBhdDoKPiA+ICvCoAo+ID4gaHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9l
bi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9kYXRhLXNoZWV0cy9NQVgzNDQwOC1NQVgzNDQwOS5w
ZGYKPiA+ICsKPiA+ICtwcm9wZXJ0aWVzOgo+ID4gK8KgIGNvbXBhdGlibGU6Cj4gPiArwqDCoMKg
IGVudW06Cj4gPiArwqDCoMKgwqDCoCAtIG1heGltLG1heDM0NDA4Cj4gPiArwqDCoMKgwqDCoCAt
IG1heGltLG1heDM0NDA5Cj4gPiArCj4gPiArwqAgIiNhZGRyZXNzLWNlbGxzIjoKPiA+ICvCoMKg
wqAgY29uc3Q6IDEKPiA+ICsKPiA+ICvCoCAiI3NpemUtY2VsbHMiOgo+ID4gK8KgwqDCoCBjb25z
dDogMAo+ID4gKwo+ID4gK8KgIHJlZzoKPiA+ICvCoMKgwqAgbWF4SXRlbXM6IDEKPiA+ICsKPiA+
ICvCoCBpbnRlcnJ1cHRzOgo+ID4gK8KgwqDCoCBtYXhJdGVtczogMQo+ID4gKwo+ID4gK8KgIHBv
d2VyZG93bi1ncGlvczoKPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246Cj4gPiArwqDCoMKgwqDCoCBT
aHV0ZG93biBPdXRwdXQuIE9wZW4tZHJhaW4gb3V0cHV0LiBUaGlzIG91dHB1dCB0cmFuc2l0aW9u
cwo+ID4gdG8gaGlnaCBpbXBlZGFuY2UKPiA+ICvCoMKgwqDCoMKgIHdoZW4gYW55IG9mIHRoZSBk
aWdpdGFsIGNvbXBhcmF0b3IgdGhyZXNob2xkcyBhcmUgZXhjZWVkZWQKPiA+IGFzIGxvbmcgYXMg
dGhlIEVOQQo+ID4gK8KgwqDCoMKgwqAgcGluIGlzIGhpZ2guCj4gPiArwqDCoMKgIG1heEl0ZW1z
OiAxCj4gPiArCj4gPiArwqAgc2h0ZG4tZW5hYmxlLWdwaW9zOgo+IAo+IEkgZ3Vlc3MgdGhlIHJl
dmlldyBjcm9zc2VkIHdpdGggeW91IHNlbmRpbmcgdjUuwqAgVGhlcmUgaXMgc29tZQo+IGZlZWRi
YWNrIG9uIHY0IHlvdSBuZWVkCj4gdG8gYWRkcmVzcyBoZXJlLgoKSm9uYXRoYW4sIEkgdGhvdWdo
dCBJIGRpZCwgSSd2ZSBjaGFuZ2VkIGVuYSB0byBwb3dlcmRvd24tZ3Bpb3MgZnJvbQpLcnp5c3p0
b2YncyBjb21tZW50cyBidXQgYWJvdXQgdGhpcyBvbmUgcGluIEknbSBzdGlsbCBub3Qgc3VyZSwg
aXQKbG9va3MgbGlrZSAqLWVuYWJsZS1ncGlvcyAobGlrZSBpbiAqLWVuYWJsZS1ncGlvcyBwaW5z
IGluCmlpby9mcmVxdWVuY3kvYWRpLGFkZjQzNzcueWFtbCkgcGluIG9yIGlzIGl0IG5vdD8gT3Ig
bWF5YmUgYW55IG90aGVyCnN1Z2dlc3Rpb25zIGFib3V0IG5hbWluZyBvZiB0aGlzIG9uZT8KClRo
YW5rcy4KCj4gCj4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOgo+ID4gK8KgwqDCoMKgwqAgU0hURE4g
RW5hYmxlIElucHV0LiBDTU9TIGRpZ2l0YWwgaW5wdXQuIENvbm5lY3QgdG8gR05EIHRvCj4gPiBj
bGVhciB0aGUgbGF0Y2ggYW5kCj4gPiArwqDCoMKgwqDCoCB1bmNvbmRpdGlvbmFsbHkgZGVhc3Nl
cnQgKGZvcmNlIGxvdykgdGhlIFNIVEROIG91dHB1dCBhbmQKPiA+IHJlc2V0IHRoZSBzaHV0ZG93
bgo+ID4gK8KgwqDCoMKgwqAgZGVsYXkuIENvbm5lY3QgdG8gVkREIHRvIGVuYWJsZSBub3JtYWwg
bGF0Y2ggb3BlcmF0aW9uIG9mCj4gPiB0aGUgU0hURE4gb3V0cHV0Lgo+ID4gK8KgwqDCoCBtYXhJ
dGVtczogMQo+ID4gKwo+ID4gK8KgIHZkZC1zdXBwbHk6IHRydWUKPiA+ICsKPiA+ICtwYXR0ZXJu
UHJvcGVydGllczoKPiA+ICvCoCAiXmNoYW5uZWxAWzAtM10kIjoKPiA+ICvCoMKgwqAgJHJlZjog
YWRjLnlhbWwKPiA+ICvCoMKgwqAgdHlwZTogb2JqZWN0Cj4gPiArwqDCoMKgIGRlc2NyaXB0aW9u
Ogo+ID4gK8KgwqDCoMKgwqAgUmVwcmVzZW50cyB0aGUgaW50ZXJuYWwgY2hhbm5lbHMgb2YgdGhl
IEFEQy4KPiA+ICsKPiA+ICvCoMKgwqAgcHJvcGVydGllczoKPiA+ICvCoMKgwqDCoMKgIHJlZzoK
PiA+ICvCoMKgwqDCoMKgwqDCoCBpdGVtczoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgbWluaW11
bTogMAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoCBtYXhpbXVtOiAzCj4gPiArCj4gPiArwqDCoMKg
wqDCoCBtYXhpbSxyc2Vuc2UtdmFsLW1pY3JvLW9obXM6Cj4gPiArwqDCoMKgwqDCoMKgwqAgZGVz
Y3JpcHRpb246Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIEFkanVzdCB0aGUgUnNlbnNlIHZhbHVl
IHRvIG1vbml0b3IgaGlnaGVyIG9yIGxvd2VyCj4gPiBjdXJyZW50IGxldmVscyBmb3IKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqAgaW5wdXQuCj4gPiArwqDCoMKgwqDCoMKgwqAgZW51bTogWzI1MCwg
NTAwLCAxMDAwLCA1MDAwLCAxMDAwMCwgNTAwMDAsIDEwMDAwMCwgMjAwMDAwLAo+ID4gNTAwMDAw
XQo+ID4gK8KgwqDCoMKgwqDCoMKgIGRlZmF1bHQ6IDEwMDAKPiA+ICsKPiA+ICvCoMKgwqAgcmVx
dWlyZWQ6Cj4gPiArwqDCoMKgwqDCoCAtIHJlZwo+ID4gK8KgwqDCoMKgwqAgLSBtYXhpbSxyc2Vu
c2UtdmFsLW1pY3JvLW9obXMKPiA+ICsKPiA+ICvCoMKgwqAgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVz
OiBmYWxzZQo+ID4gKwo+ID4gK3JlcXVpcmVkOgo+ID4gK8KgIC0gY29tcGF0aWJsZQo+ID4gK8Kg
IC0gcmVnCj4gPiArCj4gPiArYWxsT2Y6Cj4gPiArwqAgLSBpZjoKPiA+ICvCoMKgwqDCoMKgIHBy
b3BlcnRpZXM6Cj4gPiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZToKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqAgY29udGFpbnM6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdDogbWF4
aW0sbWF4MzQ0MDgKPiA+ICvCoMKgwqAgdGhlbjoKPiA+ICvCoMKgwqDCoMKgIHBhdHRlcm5Qcm9w
ZXJ0aWVzOgo+ID4gK8KgwqDCoMKgwqDCoMKgICJeY2hhbm5lbEBbMi0zXSQiOiBmYWxzZQo+ID4g
K8KgwqDCoMKgwqDCoMKgICJeY2hhbm5lbEBbMC0xXSQiOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oCBwcm9wZXJ0aWVzOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnOgo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1pbmltdW06IDAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtYXhpbXVtOiAxCj4gPiArwqDCoMKgIGVsc2U6Cj4gPiArwqDCoMKgwqDCoCBwYXR0
ZXJuUHJvcGVydGllczoKPiA+ICvCoMKgwqDCoMKgwqDCoCAiXmNoYW5uZWxAWzAtM10kIjoKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqAgcHJvcGVydGllczoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJlZzoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtaW5pbXVtOiAwCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWF4aW11bTogMwo+ID4gKwo+ID4gK2FkZGl0aW9u
YWxQcm9wZXJ0aWVzOiBmYWxzZQo+ID4gKwo+ID4gK2V4YW1wbGVzOgo+ID4gK8KgIC0gfAo+ID4g
K8KgwqDCoCAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+Cj4gPiArCj4gPiArwqDC
oMKgIGkyYyB7Cj4gPiArwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4gPiAr
wqDCoMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MD47Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKg
wqAgYWRjQDFlIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0g
Im1heGltLG1heDM0NDA5IjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8
MHgxZT47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG93ZXJkb3duLWdwaW9zID0g
PCZncGlvMCAxIEdQSU9fQUNUSVZFX0xPVz47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2h0ZG4tZW5hYmxlLWdwaW9zID0gPCZncGlvMCAyIEdQSU9fQUNUSVZFX0hJR0g+Owo+ID4g
Kwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Owo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDA+Owo+ID4gKwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoYW5uZWxAMCB7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgwPjsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1heGltLHJzZW5zZS12YWwtbWljcm8tb2htcyA9IDw1MDAw
PjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+ID4gKwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNoYW5uZWxAMSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZWcgPSA8MHgxPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG1heGltLHJzZW5zZS12YWwtbWljcm8tb2htcyA9IDwxMDAwMD47Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4gPiArwqDCoMKgwqDCoMKgwqAgfTsKPiA+ICvCoMKg
wqAgfTsKPiAKCg==

