Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114607D7C56
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJZFmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZFm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:42:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDF90;
        Wed, 25 Oct 2023 22:42:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so717391a12.3;
        Wed, 25 Oct 2023 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698298944; x=1698903744; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O18ACdOlxBoaBz1z4uRBsuAuyaadjOVTHABGOAlW9Lc=;
        b=RizroLFceyNCH7nUtYUQb3ykdWectyra2zQeewt7DoZoHAObTyqk+ns0hiRvQvnW/7
         kCAZe7oKwSES+7UWlU+LpVFqWm9vZsjwWJ6lwW7v/rCsfG1u6mSM6vG22/y2LMshTAYD
         ib7sRIWmjhBh4NCwvaLFFuF2v5bPy/UfB0Jg/UjPgGPfTdPFkS3ryEY3ZS35clbrF3Km
         AwCfxKn0f48kGhWiCZ6Ebg2aBP2tRgpuugIcKi90uNU/6rma6EDyGnz288cD4RCGx9pM
         xFq3JUfRmmK/ovAteQjTlOVb4iB1l6LrNN146HMJxqPGLoIciWkJwm2lOjHQm2zb4zjc
         2kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698298944; x=1698903744;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O18ACdOlxBoaBz1z4uRBsuAuyaadjOVTHABGOAlW9Lc=;
        b=ANi9xFEl/02YfXFJuh2Q7lnyHr6gCoBISomm2PVM8kTMSNS/7eR2rGsY6YVmDyb7Dn
         /oBTI2vJNcpmCRWSUWcYccAz2xbaBFsRNvVZpzUO6kd2QlIvHkm+14fdqzER9X07AZmM
         us1Srhcl2Cn266HtJXiiWDOMWnvQy3xaIMmuX8e0TCFz7iNNG9nJQvDv5iX3p8srdWYZ
         NoHaoa/7OpjXUlzkbIjH7a8+25MmKaE3IcZCT5IqmschffWj9Hir1z24pdR6ZDMXd4xy
         6S0qMQoUxrC9Ukgx4oxwKrXSFZP+30/VneUhG4e3vgQTujBrBKSpO+dzA1jKAmDNG3A3
         yh/Q==
X-Gm-Message-State: AOJu0YxfldO7Thk/LOcY2/8JAYJHvLt2rDGcRf46EVbcQWS5rESNKaE/
        SsF5sOdgE0KMRI7Kl4K8imE=
X-Google-Smtp-Source: AGHT+IHmMO3TLhv7sxxKLpdaJx+E9H3rUYUWCTNqp9Fy0oskRy3AJT3yW6Ydo3VAks2ONiqNvcp/xg==
X-Received: by 2002:a17:907:3d9f:b0:9c1:9b3a:4cd1 with SMTP id he31-20020a1709073d9f00b009c19b3a4cd1mr12788174ejc.3.1698298943815;
        Wed, 25 Oct 2023 22:42:23 -0700 (PDT)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090602ca00b009b2f2451381sm11117028ejk.182.2023.10.25.22.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:42:23 -0700 (PDT)
Message-ID: <65d6ffc4c7bd6ce0ae75f7fb7d1f622467bfe9a7.camel@gmail.com>
Subject: Re: [RFT PATCH 05/17] ASoC: codecs: max9867: Handle component name
 prefix
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Date:   Thu, 26 Oct 2023 07:42:22 +0200
In-Reply-To: <20231023095428.166563-6-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
         <20231023095428.166563-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDExOjU0ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IFVzZSBzbmRfc29jX2RhcG1fd2lkZ2V0X25hbWVfY21wKCkgaGVscGVyIHdoZW4gY29t
cGFyaW5nIHdpZGdldCBuYW1lcywKPiB0byBpbmNsdWRlIGFsc28gdGhlIGNvbXBvbmVudCdzIG5h
bWUgcHJlZml4Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlz
enRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4KPiAtLS0KClJldmlld2VkLWJ5OiBOdW5vIFNhIDxu
dW5vLnNhQGFuYWxvZy5jb20+Cgo+IMKgc291bmQvc29jL2NvZGVjcy9tYXg5ODY3LmMgfCA4ICsr
KystLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL21heDk4NjcuYyBiL3NvdW5kL3Nv
Yy9jb2RlY3MvbWF4OTg2Ny5jCj4gaW5kZXggYjYxNmFkMzk4NThjLi4zYjlkZDE1OGMzNGIgMTAw
NjQ0Cj4gLS0tIGEvc291bmQvc29jL2NvZGVjcy9tYXg5ODY3LmMKPiArKysgYi9zb3VuZC9zb2Mv
Y29kZWNzL21heDk4NjcuYwo+IEBAIC01NiwxMyArNTYsMTMgQEAgc3RhdGljIGludCBtYXg5ODY3
X2FkY19kYWNfZXZlbnQoc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgKncsCj4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBtYXg5ODY3X3ByaXYgKm1heDk4NjcgPSBzbmRfc29jX2NvbXBvbmVudF9n
ZXRfZHJ2ZGF0YShjb21wb25lbnQpOwo+IMKgwqDCoMKgwqDCoMKgwqBlbnVtIG1heDk4NjdfYWRj
X2RhYyBhZGNfZGFjOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFzdHJjbXAody0+bmFtZSwg
IkFEQ0wiKSkKPiArwqDCoMKgwqDCoMKgwqBpZiAoIXNuZF9zb2NfZGFwbV93aWRnZXRfbmFtZV9j
bXAodywgIkFEQ0wiKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFkY19kYWMg
PSBNQVg5ODY3X0FEQ19MRUZUOwo+IC3CoMKgwqDCoMKgwqDCoGVsc2UgaWYgKCFzdHJjbXAody0+
bmFtZSwgIkFEQ1IiKSkKPiArwqDCoMKgwqDCoMKgwqBlbHNlIGlmICghc25kX3NvY19kYXBtX3dp
ZGdldF9uYW1lX2NtcCh3LCAiQURDUiIpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYWRjX2RhYyA9IE1BWDk4NjdfQURDX1JJR0hUOwo+IC3CoMKgwqDCoMKgwqDCoGVsc2UgaWYg
KCFzdHJjbXAody0+bmFtZSwgIkRBQ0wiKSkKPiArwqDCoMKgwqDCoMKgwqBlbHNlIGlmICghc25k
X3NvY19kYXBtX3dpZGdldF9uYW1lX2NtcCh3LCAiREFDTCIpKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgYWRjX2RhYyA9IE1BWDk4NjdfREFDX0xFRlQ7Cj4gLcKgwqDCoMKgwqDC
oMKgZWxzZSBpZiAoIXN0cmNtcCh3LT5uYW1lLCAiREFDUiIpKQo+ICvCoMKgwqDCoMKgwqDCoGVs
c2UgaWYgKCFzbmRfc29jX2RhcG1fd2lkZ2V0X25hbWVfY21wKHcsICJEQUNSIikpCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZGNfZGFjID0gTUFYOTg2N19EQUNfUklHSFQ7Cj4g
wqDCoMKgwqDCoMKgwqDCoGVsc2UKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAwOwoK

