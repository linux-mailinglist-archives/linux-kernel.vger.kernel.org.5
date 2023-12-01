Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD8800631
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377919AbjLAIuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjLAIuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:50:35 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACE284;
        Fri,  1 Dec 2023 00:50:41 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33319741ba0so1653085f8f.1;
        Fri, 01 Dec 2023 00:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701420640; x=1702025440; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ecWJytuJ+NdbltNOlj+5D5e20+I6iSpYpRaSkGLH+ao=;
        b=PqujUTx2yloB+dAvZygavPqZ+10+EDZFX88B0QP58QRMNrrBf4IXJty9wIgiY5McvU
         Y+j8GvEtAhJmZctGS5ICZCJk6sCtSVizsBbB+DaucGp+u7Fey1aY/DsU77ef4RDpJqHx
         Q2QUCIQZxdmLdWQRY3ynGAj26yFq8qhkMzJC4PNy5xTvWGOuRT+MyvFH7rHW+v0spRv6
         dkvx6ypvNzwVO61iTB6ws9B0ouQ9Vg1/8Vo7SMfEzA2z2UMrv3eI0avR8O8NML1SfVY0
         uDn7VRFeA8D1u995KjTmY8tyGo2WOvzxaSvEJI+HsmkSm5gwnMbfM5PDENvydqj8wS9Z
         DMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701420640; x=1702025440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecWJytuJ+NdbltNOlj+5D5e20+I6iSpYpRaSkGLH+ao=;
        b=J9A3QLEYox2Gqtr0TEETE4hDjeNfUKfsNHwgqyCyOkhzbxmBr091kTqeenM62NAwfJ
         0yWS7RpQC6yap6f24vFVF/seWcGPwVQIYZ6g6HCF+WVWSLbJTjStvREXOilktaHQx6l+
         KwiR/hjPnSiKGsEAUY5qGeRAV4fO+LToJsre8LL6usv4UpRFKwb57jImj7EgLos6LspU
         RoKE4eMbXOrvjkuDPOlkRbYcgcqZ5Zeh/PisIMqztNNz2D7AdOXClFv348PYROHp90qA
         NZzn+M02nmxEPjNqrLxjXb18WY2+UbgDrKR3ivyylC+vvqzsUZqXw+bmfziJy3ly1y7O
         RCKw==
X-Gm-Message-State: AOJu0YyZ4rfsUiJiUbWxYl2iDzGKBO6tOMInibp6Dj0G+UiPWloy4XY/
        2NjVNGGiIXW+9dVGWuMsZL/gEMrSziCvkTbJ
X-Google-Smtp-Source: AGHT+IFCbfMHEcjyPqQbXPMzXQ/KK7iM0GO+9b2G9/58eDjqyMwqN5Q7UhryWe4i7D5iQsNfc8PBoQ==
X-Received: by 2002:a05:6000:1a45:b0:333:2fd2:4ad7 with SMTP id t5-20020a0560001a4500b003332fd24ad7mr666166wry.83.1701420639688;
        Fri, 01 Dec 2023 00:50:39 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id j1-20020adfe501000000b003332f1f51f4sm1732408wrm.94.2023.12.01.00.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:50:39 -0800 (PST)
Message-ID: <3b21271da4ec21e51a804181268a50a5d50ff85e.camel@gmail.com>
Subject: Re: [PATCH 12/12] iio: adc: adi-axi-adc: move to backend framework
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Fri, 01 Dec 2023 09:50:38 +0100
In-Reply-To: <CAMknhBFk1SbcQeG_bxtKUhR_hF2R0cRrVAPFomL_TOS9eh8Kqw@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-12-6a3d542eba35@analog.com>
         <CAMknhBFk1SbcQeG_bxtKUhR_hF2R0cRrVAPFomL_TOS9eh8Kqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

T24gVGh1LCAyMDIzLTExLTMwIGF0IDE3OjMzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IE9uIFR1ZSwgTm92IDIxLCAyMDIzIGF0IDQ6MTfigK9BTSBOdW5vIFNhIHZpYSBCNCBSZWxheQo+
IDxkZXZudWxsK251bm8uc2EuYW5hbG9nLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPiA+IAo+ID4g
RnJvbTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPgo+ID4gCj4gPiBNb3ZlIHRvIHRoZSBJ
SU8gYmFja2VuZCBmcmFtZXdvcmsuIERldmljZXMgc3VwcG9ydGVkIGJ5IGFkaS1heGktYWRjIG5v
dwo+ID4gcmVnaXN0ZXIgdGhlbXNlbHZlcyBhcyBiYWNrZW5kIGRldmljZXMuCj4gPiAKPiA+IFNp
Z25lZC1vZmYtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT4KPiA+IC0tLQo+ID4gwqBk
cml2ZXJzL2lpby9hZGMvS2NvbmZpZ8KgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiA+IMKgZHJpdmVy
cy9paW8vYWRjL2FkaS1heGktYWRjLmMgfCAzNjQgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKSwg
MzAwIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL0tj
b25maWcgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZwo+ID4gaW5kZXggYWY1NmRmNjNiZWZmLi5j
YzQyYTMzOTljNjMgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZwo+ID4g
KysrIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcKPiA+IEBAIC0yOTIsNiArMjkyLDcgQEAgY29u
ZmlnIEFESV9BWElfQURDCj4gPiDCoMKgwqDCoMKgwqDCoCBzZWxlY3QgSUlPX0JVRkZFUgo+ID4g
wqDCoMKgwqDCoMKgwqAgc2VsZWN0IElJT19CVUZGRVJfSFdfQ09OU1VNRVIKPiA+IMKgwqDCoMKg
wqDCoMKgIHNlbGVjdCBJSU9fQlVGRkVSX0RNQUVOR0lORQo+ID4gK8KgwqDCoMKgwqDCoCBzZWxl
Y3QgSUlPX0JBQ0tFTkQKPiA+IMKgwqDCoMKgwqDCoMKgIGRlcGVuZHMgb24gSEFTX0lPTUVNCj4g
PiDCoMKgwqDCoMKgwqDCoCBkZXBlbmRzIG9uIE9GCj4gPiDCoMKgwqDCoMKgwqDCoCBoZWxwCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2FkaS1heGktYWRjLmMgYi9kcml2ZXJzL2lp
by9hZGMvYWRpLWF4aS1hZGMuYwo+ID4gaW5kZXggYzI0N2ZmMTU0MWQyLi5iMmFiMmMxMTllZmEg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWRpLWF4aS1hZGMuYwo+ID4gKysrIGIv
ZHJpdmVycy9paW8vYWRjL2FkaS1heGktYWRjLmMKPiAKPiA8c25pcD4KPiAKPiA+IEBAIC0zOTAs
MzcgKzE2NiwyMyBAQCBzdGF0aWMgaW50IGFkaV9heGlfYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCj4gPiDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqAg
aWYgKGNsLT5pbmZvLT52ZXJzaW9uID4gdmVyKSB7Cj4gPiArwqDCoMKgwqDCoMKgIGlmICgqZXhw
ZWN0ZWRfdmVyID4gdmVyKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2
X2VycigmcGRldi0+ZGV2LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAiSVAgY29yZSB2ZXJzaW9uIGlzIHRvbyBvbGQuIEV4cGVjdGVkICVkLiUuMmQu
JWMsCj4gPiBSZXBvcnRlZCAlZC4lLjJkLiVjXG4iLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFESV9BWElfUENPUkVfVkVSX01BSk9SKGNsLT5pbmZv
LT52ZXJzaW9uKSwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBBRElfQVhJX1BDT1JFX1ZFUl9NSU5PUihjbC0+aW5mby0+dmVyc2lvbiksCj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQURJX0FYSV9QQ09SRV9W
RVJfUEFUQ0goY2wtPmluZm8tPnZlcnNpb24pLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFESV9BWElfUENPUkVfVkVSX01BSk9SKCpleHBlY3RlZF92
ZXIpLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFE
SV9BWElfUENPUkVfVkVSX01JTk9SKCpleHBlY3RlZF92ZXIpLAo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFESV9BWElfUENPUkVfVkVSX1BBVENIKCpl
eHBlY3RlZF92ZXIpLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBBRElfQVhJX1BDT1JFX1ZFUl9NQUpPUih2ZXIpLAo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBRElfQVhJX1BDT1JFX1ZFUl9NSU5PUih2
ZXIpLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBB
RElfQVhJX1BDT1JFX1ZFUl9QQVRDSCh2ZXIpKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVOT0RFVjsKPiA+IMKgwqDCoMKgwqDCoMKgIH0KPiA+IAo+ID4gLcKg
wqDCoMKgwqDCoCBpbmRpb19kZXYtPmluZm8gPSAmYWRpX2F4aV9hZGNfaW5mbzsKPiA+IC3CoMKg
wqDCoMKgwqAgaW5kaW9fZGV2LT5uYW1lID0gImFkaS1heGktYWRjIjsKPiA+IC3CoMKgwqDCoMKg
wqAgaW5kaW9fZGV2LT5tb2RlcyA9IElORElPX0RJUkVDVF9NT0RFOwo+ID4gLcKgwqDCoMKgwqDC
oCBpbmRpb19kZXYtPm51bV9jaGFubmVscyA9IGNvbnYtPmNoaXBfaW5mby0+bnVtX2NoYW5uZWxz
Owo+ID4gLcKgwqDCoMKgwqDCoCBpbmRpb19kZXYtPmNoYW5uZWxzID0gY29udi0+Y2hpcF9pbmZv
LT5jaGFubmVsczsKPiA+IC0KPiA+IC3CoMKgwqDCoMKgwqAgcmV0ID0gYWRpX2F4aV9hZGNfY29u
ZmlnX2RtYV9idWZmZXIoJnBkZXYtPmRldiwgaW5kaW9fZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqAg
cmV0ID0gZGV2bV9paW9fYmFja2VuZF9yZWdpc3RlcigmcGRldi0+ZGV2LCAmYWRpX2F4aV9hZGNf
Z2VuZXJpYywgc3QpOwo+ID4gwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ID4gCj4gPiAtwqDCoMKgwqDCoMKgIHJl
dCA9IGFkaV9heGlfYWRjX3NldHVwX2NoYW5uZWxzKCZwZGV2LT5kZXYsIHN0KTsKPiA+IC3CoMKg
wqDCoMKgwqAgaWYgKHJldCkKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biByZXQ7Cj4gPiAtCj4gPiAtwqDCoMKgwqDCoMKgIHJldCA9IGRldm1faWlvX2RldmljZV9yZWdp
c3RlcigmcGRldi0+ZGV2LCBpbmRpb19kZXYpOwo+ID4gLcKgwqDCoMKgwqDCoCBpZiAocmV0KQo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPiA+IC0KPiA+IC3C
oMKgwqDCoMKgwqAgZGV2X2luZm8oJnBkZXYtPmRldiwgIkFYSSBBREMgSVAgY29yZSAoJWQuJS4y
ZC4lYykgcHJvYmVkXG4iLAo+ID4gK8KgwqDCoMKgwqDCoCBkZXZfaW5mbygmcGRldi0+ZGV2LCAi
QVhJIEFEQyBJUCBjb3JlICglZC4lLjJkLiVkKSBwcm9iZWRcbiIsCj4gCj4gV2FzIHRoaXMgZm9y
bWF0IGNoYW5nZSBpbnRlbnRpb25hbD8gVGhlcmUgYXJlIG90aGVyIHBsYWNlcyBhYm92ZSB3aGVy
ZQo+ICVjIGlzIHN0aWxsIHVzZWQuCj4gCgpZZXMsIHRoZSBvdXRwdXQgd2FzIHdlaXJkIHdpdGgg
JWMuIEkgZ3Vlc3Mgc29tZXRoaW5nIGNoYW5nZWQuLi4gSG1tIG5lZWQgdG8gbG9vayBhdAp0aGUg
b3RoZXIgcGxhY2VzLgoKLSBOdW5vIFPDoQo+IAoK

