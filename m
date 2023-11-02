Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264E27DFBD0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjKBVAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjKBVAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:00:32 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041B7194
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:00:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b201a93c9cso1314385b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698958822; x=1699563622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8KFumTag/+mfUr046qXGDZHDIauHHYyGcdwD8EXFRY=;
        b=JZIyIVCwD0ECTxQVk3G1/Ci2yYOqLuqNmMu2KPCbmd4HFX/q2nNzTTZYxyfmFDLYg0
         bgFDBtojDff9NEPVAdbup66Ulfsc/yAOnuKDctVk7jf6dalWD5meSdtrbkSTA7uqjiZK
         3UFg71SQe1vaYzXXRWpxMU9Kz777urhB4z6ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958822; x=1699563622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8KFumTag/+mfUr046qXGDZHDIauHHYyGcdwD8EXFRY=;
        b=b4Vl54a1Ic8fvVA8Z5rxwOLw3S/3XPrRHxnrvbpnSCNZgcro1eufPfHy0WpUy5qNf7
         BmHUM9sST1bnfiRKEiPy+EK3sRN0Q1knep8dg4ORmT4rXAaxq7Qrhofon5KEAWPbCkMf
         6ihOzF6taELY8jId07+AaPorbE3etcCM/Z3r4nCMu4SEnokQkJX1aQkTqxv+ysnA5Yun
         LHuCCveaM0p3guQnz+c/35Q1veyyq3VUAMhQXdxikfxkzUwAIfK+7I2WhZApTXN3mt4/
         dbGDGCKIiIbqUKXX8pd3GiAzH0ecq8Mlj7HTEYIgHjCZXnizCR/MQbR3g6wcZrLmFXMr
         Hqmg==
X-Gm-Message-State: AOJu0YyvBfCf2tXS9RfvbCCY4MDKTYu86TBeJOsAAEU/Bycwk6iz38zC
        p135XylpToee30Qp9P+KQuVPGQ==
X-Google-Smtp-Source: AGHT+IHpWfHMpmZgu3Ki0ANwOyVLt9nZosdSKPzywMjZQkoftSaNFtV+rbheqzdq77GxD/borUX1wg==
X-Received: by 2002:a05:6a21:18a:b0:181:74fe:ba83 with SMTP id le10-20020a056a21018a00b0018174feba83mr5241243pzb.40.1698958822357;
        Thu, 02 Nov 2023 14:00:22 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:a601:95c2:1e12:1936])
        by smtp.gmail.com with UTF8SMTPSA id b7-20020a62cf07000000b0068842ebfd10sm174384pfg.160.2023.11.02.14.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 14:00:20 -0700 (PDT)
Date:   Thu, 2 Nov 2023 14:00:17 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Karel Balej <balejk@matfyz.cz>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] net: mwifiex: add support for the SD8777 chipset
Message-ID: <ZUQN4Ua8byy-Fsy8@google.com>
References: <20231029111807.19261-1-balejk@matfyz.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029111807.19261-1-balejk@matfyz.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 12:08:15PM +0100, Karel Balej wrote:
> The driver requires proprietary firmware which is not yet part of
> linux-firmware, but it is packaged in postmarketOS.

You gotta get that done:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#new_driver

"have firmware images submitted for linux-firmware with an acceptable
license allowing redistribution"

We can't have a driver requesting a mrvl/sd8777_uapsta.bin firmware that
isn't available for anyone [1].

Until that's done, NAK.

[1] I think you might be referring to this:
https://github.com/xcover3/android_vendor_samsung_xcover3lte/commit/6e324b43b32dc607327d89148dd5d83a14429ee6

But I don't see any license info, so I don't think that's going to be
appropriate for linux-firmware.
