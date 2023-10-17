Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A188A7CC97D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbjJQRIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjJQRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:08:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1FBA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:08:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40566f8a093so56626685e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697562484; x=1698167284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxLf5XyHvT0i+YFj0zy66WfQ0UBHwKFSI6ot74gg5Uw=;
        b=nOBOIvvs3AuunwazWTHWogu+aFJa5P/nhqLTCMmMLi3J1QIKvLnBRHQPVl2AhJUITH
         +QmRM4MNPmZjuCcDPrVl/yKLP4qAPiCes8vzIV1ez3obL+54zlnqLHPdzdQEL0PgYC6s
         8tIEnAfMzrkEeWQSWgR6IHrl4kEjEQoMDq/vg6/byfCrq1MgVX7SL80I1Nl1cKqaAcmG
         3iMHTHWfpoWZvKPXFRdr1lunF78g2l3zXtC56yFvc43Xm1Qrdx+X/+i+ogWQ0zVCfuly
         FzRM5KLBRtwveifDitOojTPSaYtRvzbBT7j/kAClMHRBHDTWO9tdLd5VuJw2rHdjFDEt
         HePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562484; x=1698167284;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxLf5XyHvT0i+YFj0zy66WfQ0UBHwKFSI6ot74gg5Uw=;
        b=b3G8LsF4oE7JkMfUkUvX5eja3DBIbIvTIMKmFxtqQIlhs+Z/Z5Cz5ON78ohmlAKBGS
         ZDLjvrtOUA5O//r5g4NkAIp3SM1RbSk8UqoGYegSGWUjUTzOMdTINWQVlNKZ6tJakfdR
         t3OcGGtMy4G2CeTYXfSdcFT1bJh7ky2uU7SkrbRK6e4xwnJ/ikb0IxvmddC5suWN59n3
         Xe8IlQeDVcUiX2BBvfyqkACzlF2o61irQKy3vipdiVDyjhAS/CfGMh9HGrdlk7hwtiG+
         Y0ac+i77VPY8hvnGveIgef0CrKJ/2fzBfZmanUauzrK5kd66XHgVw1XsR271i7tKNXed
         9IQg==
X-Gm-Message-State: AOJu0YwuupGaQzoR6jEWmR1vcQZuSr8POwid7ml2SoJpb90ZaRiqpnCv
        ED+//xvq4MisMJE6z6tTBbd+Hw==
X-Google-Smtp-Source: AGHT+IF+hwCCbhh2L5YcrtEDqHkl+JVInGYryubVQ89hKW56ue5tiPvEwAn+64VUbSlvYZrJRbDUOQ==
X-Received: by 2002:a05:600c:2e16:b0:407:5b54:bb15 with SMTP id o22-20020a05600c2e1600b004075b54bb15mr2072759wmf.36.1697562484162;
        Tue, 17 Oct 2023 10:08:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c429400b00402d34ea099sm10213001wmc.29.2023.10.17.10.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:08:03 -0700 (PDT)
Message-ID: <6c7d9c92-7616-4fad-806e-44302c33b63c@linaro.org>
Date:   Tue, 17 Oct 2023 19:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] HID: touchscreen: add himax hid-over-spi driver
Content-Language: en-US
To:     Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
        Doug Anderson <dianders@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, jingyliang@chromium.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org
Cc:     jikos@kernel.org, wuxy23@lenovo.com, conor+dt@kernel.org,
        luolm1@lenovo.com, robh+dt@kernel.org, dmitry.torokhov@gmail.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        poyu_hung@himax.corp-partner.google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        benjamin.tissoires@redhat.com
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2023 11:18, Tylor Yang wrote:
> Hello,
> 
> This patch series adds the driver for Himax HID-over-SPI touchscreen ICs.
> This driver takes a position in [1], it intends to take advantage of SPI
> transfer speed and HID interface.
> 

Dear Google/Chromium folks,

As a multi-billion company I am sure you can spare some small amount of
time/effort/money for internal review before using community for this
purpose. I mean reviewing trivial issues, like coding style, or just
running checkpatch. You know, the obvious things.

There is no need to use expensive time of community reviewers to review
very simple mistakes, the ones which we fixed in Linux kernel years ago
(also with automated tools). You can and you should do it, before
submitting drivers for community review.

Thanks in advance.

Best regards,
Krzysztof

