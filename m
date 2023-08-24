Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1FA78755E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbjHXQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242613AbjHXQ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:28:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE3219AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:28:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so2276214a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692894489; x=1693499289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpS5AtVwekY92p5VcBpjHAB55WfvmXg0YgxAnOX9Fik=;
        b=O83BnSk/S2aG6RwXlpx1uWrfBD96Aq6M0GC/DKIoG57nTP6FFmkSQ5/w6y1yMbFTQr
         ybpO6M0ttf3Xi0hciLhFrWTidy6ENtkjAJop9o2mdoy8ErX+btkCO5opl4shnqsv3xmn
         YrhiXyF9jxxSPeVB6DlUAwEGCyeguqw87zx4gxkKNpYQrXodtN9VUkM56yEBSPHR/5S+
         62P6O/G9lkcYWcHy4MMvORWIHB/PhKEW1hJZhji7PB2nNvpYnW9JmioRQ8vXm03u84e4
         8gOIBK0fjNFlV+rhd1nJg1GfJVOx6/WPMLawtLakrO0rf+PKsoyLC7ING9m9FbmvB9JL
         7pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692894489; x=1693499289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpS5AtVwekY92p5VcBpjHAB55WfvmXg0YgxAnOX9Fik=;
        b=P1daNIDaOX1nXol1Es9FYkX5JWyreTH2f+9XSlLD/znuEuFtgZPtwLiByykG5wMwxV
         i32WInKWKNlps6Ghe43u+eauMzDdDtC1QHOuS+zUKhfkBP39BwJsSZKxXWmhME2SgAHD
         lC8YCicxb0nNa3/W53jQJF/A8TPzV4R1NnoWwAtocEIVVB7Prt2YndVPDIQr/CQEBQEy
         dG4yB64NgC4iBjRe6aV0vBWaISJWACpYnGqE3B4iJUwQdIEp21JG2gjlWD7T+OF0AZkM
         0CL33dt1brCvb/GWYOC7hVpVTqw4S0mKHpiSYhVuMNTrTmd4DygJhjmXRfJaNG05+5Ut
         SMuQ==
X-Gm-Message-State: AOJu0YyoqnGybIHk22tjnLxtPz18UvlqdNdZoIXS9L9e2cJeVpyVv/K9
        tjXjHyelMEL70tGBVdFKegklaQ==
X-Google-Smtp-Source: AGHT+IFyCV8WniKgbzUxCp5JYtc0h8Bdf1TG9+VH8ni7twLHda1zaqLey2kdNUCe7M2QmpT5WJMzqA==
X-Received: by 2002:a17:907:a04a:b0:994:5407:9ac9 with SMTP id gz10-20020a170907a04a00b0099454079ac9mr16827400ejc.5.1692894489362;
        Thu, 24 Aug 2023 09:28:09 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id y6-20020a170906470600b0099364d9f0e9sm11148888ejq.102.2023.08.24.09.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 09:28:08 -0700 (PDT)
Message-ID: <f79087c0-cc44-4fb6-fa2e-b43db5dfd6d4@linaro.org>
Date:   Thu, 24 Aug 2023 18:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
Content-Language: en-US
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     azkali <a.ffcc7@gmail.com>, Adam Jiang <chaoj@nvidia.com>,
        CTCaer <ctcaer@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824153059.212244-1-linkmauve@linkmauve.fr>
 <20230824153059.212244-3-linkmauve@linkmauve.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824153059.212244-3-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 17:30, Emmanuel Gil Peyrot wrote:
> From: azkali <a.ffcc7@gmail.com>
> 
> This is used as the USB-C Power Delivery controller of the Nintendo
> Switch.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> Signed-off-by: azkali <a.ffcc7@gmail.com>
> Signed-off-by: Adam Jiang <chaoj@nvidia.com>
> Signed-off-by: CTCaer <ctcaer@gmail.com>

These do not look like real identities. In this and previous patchset
your author emails bounces, so I propose to drop all stale addresses and
all anonymous entries.

Best regards,
Krzysztof

