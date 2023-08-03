Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C954576EFD9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjHCQoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjHCQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:44:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617C83AA3;
        Thu,  3 Aug 2023 09:44:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso1998023e87.1;
        Thu, 03 Aug 2023 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691081056; x=1691685856;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zvwc1p5HtLDdNnsvsflobUwI0/gIvHPTTxHIRtuIk8=;
        b=UxFpZJVklEjVT9J0WAyRjTYVtSEY5EaP9Ji4DmlgE6lTalsWxrhtjRqjvUEP8EeZ4H
         OnXNQflVLzN3WNhL5UFdHhQvLsRlv/UzrJx00959KjuYPw52rg4PMlhgRD2CXKNk3sCg
         fxSvb6Q0GZuH3EHAtUjY63sWQIMTCAVpH119uhwuYMsfXYBjj9PrIqu6lCYvBkXaLh5q
         9Ldqw43FAZKbod3mJGv3rnHjjgX89e6WKaaq2FpJoBlvybTRzvLifC/3EeOvBDcLdCjp
         4umyJ51fMttfV5jp/yyfxqW7fojvx3JwInrO4veeM28DnWwR1uJKUQyAXF7FZqHdTuJs
         0fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081056; x=1691685856;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Zvwc1p5HtLDdNnsvsflobUwI0/gIvHPTTxHIRtuIk8=;
        b=A3AFmqjiS8RhUf9mTaUUJMfpHP4v7+X1QaD0dFtkkEUNMPHq1yMu2weWteuyJGkuvL
         4U5QKDu2pX9pzUmQIK+MLIt25Gzt+cNRDZqqNZ9MSnKTYakAmGy6k4tMH15jvGut1AGN
         6dqdjr/JeyCUKxWTO1WEsJXEw2nBtD9zyc7qgfOolw4mAjl5dGMtTOpjV+d/5xHu6Pb5
         pMnI6hh0AN9EfgMRW7ZLSojneXl+Acm9cgBuEm7mZwdR/u9+2WHlkbo4W08POG/Z2w9r
         Rr50BZNwfLkULg7KioHdj3nLXs4g7GiIPg5JGBbaNbOAPCMMs6YPo8aji/m4kZ+w29OJ
         qv3A==
X-Gm-Message-State: AOJu0Yy1tzdp3BoSABHFL6KqZj6CfwvNmorbyBErXVSBsvWaxma8E09N
        Az+LtYnbNVtH4sx6w2FG0+KKOmvOg6k=
X-Google-Smtp-Source: AGHT+IFYiIiKCHEmkIuEXSOxCAFeDHZwl7zIB9KRI4AoS4Sjrnoopn+udfez+RoXdfRA3ZMUaR/06w==
X-Received: by 2002:a05:6512:31c9:b0:4fe:4e2c:8e52 with SMTP id j9-20020a05651231c900b004fe4e2c8e52mr4062960lfe.42.1691081055961;
        Thu, 03 Aug 2023 09:44:15 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.72.24])
        by smtp.gmail.com with ESMTPSA id b7-20020ac247e7000000b004fe4e89dc41sm30011lfp.214.2023.08.03.09.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 09:44:14 -0700 (PDT)
Subject: Re: [PATCH -next v3] usb: musb: Do not check 0 for
 platform_get_irq_byname()
To:     Zhu Wang <wangzhu9@huawei.com>, b-liu@ti.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803120039.83502-1-wangzhu9@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <d45574ec-17cd-cd30-2c6f-8c2719f811e3@gmail.com>
Date:   Thu, 3 Aug 2023 19:44:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230803120039.83502-1-wangzhu9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 3:00 PM, Zhu Wang wrote:

> When platform_get_irq_byname() failed, it may return -EPROBE_DEFER,

   s/failed/fails/, I think...

> -EINVAL or -ENXIO, it is important to propagate the detail upstream, we
> cannot override it.

   You better rename the patch to something like "usb: musb: Fix deferred
probing" now. And remove "-next:, as this became a real fix.

> And platform_get_irq_byname() used to return 0 (as both IRQ0 and error
> indication), there are several patches fixing the inconsistencies.

   In no way I suggested to take my "historical" passage into the
patch description!

> Commit ce753ad1549c ("platform: finally disallow IRQ0 in
> platform_get_irq() and its ilk") makes sure IRQ0 is not returned.
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
> 
> ---
> Changes in v2:
> - Update the commit message, present the reason of replacing the return
> value of the probe.
> 
> ---
> Changes in v3:
> - Update the commit message, explain in detail why the return value of
> platform_get_irq_byname() cannot be override.

   You didn't emphasize the deferred probing breakage we're trying to
fix here at last; the other error codes here are not very important...

[...]

MBR, Sergey
