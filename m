Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9EE773B15
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjHHPlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHHPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:40:49 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1372109
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:36:28 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso9569570e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691508891; x=1692113691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wSCMvsrvGtP/SRB0drN+VU/GnJ3+psGhnVmypWifVc=;
        b=a0hkuKG/eW/8mV1nyNFIwbBQgL7FELk2fmWcaOWumd9WsY8dztDCl+YGrUcAqwBawn
         7uhLfTqToONmup5j2gaQRfZK7utVS+WYYFGVaMnLbTXlmGIYEgPF+CaN+wAf4sJaBUjd
         GHQJxh0Z5PR+Oef1edt9MCh6Gf8qt2GdMMyurYh81uyk6VcHbB02p/1hQ5FfjqmvGglf
         a3a3PE2YBdJnEjBne59LviVf8s6RB36zkI5AuDaDCWYq2iT3kDE5h5SkFcmil/VBMdqW
         dJg3e+zBZf8I+IY0bSxAmQpnG9GKgfhfOZndrtUAtQorJ6kPnIoJPrkjUOTvo7OpPUdI
         KZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508891; x=1692113691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wSCMvsrvGtP/SRB0drN+VU/GnJ3+psGhnVmypWifVc=;
        b=Ekw8zZs5ZHXpqyDU2PDLRK+OZi9n0g2eDpfGBrH+skcCrew4e9GkoB8giZl1waji/B
         0+mGpSxRgoaXiS8VmCDu18WMD+LE9iK28ilmyQD2ekUMtIh2pUk1OCYjqrkWPO0SUKXx
         kTR3CJf7yXcHj1O4xEbDaY+gUNHfCOBd9/IypMQeSH/GmB3TDHlvNYn2P98gd6W1Lt3y
         JERckSJ5x9vh4p6ZKfeB8/DQlfwFfXYR35ox8ZalDr88qBPzCq/tq+BkSpzO8kJhX1mN
         2hCxPQIp1fIdsxRMT1QLsZVi9GFWE+iGIv48KV/3uuGx0sbgvISsjxSlE+vxLohNJ7jG
         4LSA==
X-Gm-Message-State: AOJu0YxJITDfwEFgrFeyiNDyJYQUjEuzIGJhJC0jnGyc662wEA9cr5uT
        mJpoxkCoCt37G/YO+8RJVUBz55C0ldJR7dl/vKo=
X-Google-Smtp-Source: AGHT+IEt+Kf3mPdgxinq+Mt4SlVaTOKw94gaghcqyMPjmABWGoq+4o6zGEM2ZElSHkgdewFxWTvliA==
X-Received: by 2002:adf:ff8c:0:b0:317:df3e:13d with SMTP id j12-20020adfff8c000000b00317df3e013dmr5441304wrr.38.1691487443405;
        Tue, 08 Aug 2023 02:37:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.177.253])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm13073883wrs.30.2023.08.08.02.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:37:23 -0700 (PDT)
Message-ID: <cbc22d2f-726d-86fc-1f34-c529cd91fdbe@linaro.org>
Date:   Tue, 8 Aug 2023 11:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mips: remove unneeded #include <asm/export.h>
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230807153243.996262-1-masahiroy@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230807153243.996262-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/23 17:32, Masahiro Yamada wrote:
> There is no EXPORT_SYMBOL line there, hence #include <asm/export.h>
> is unneeded.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   arch/mips/kernel/octeon_switch.S | 1 -
>   arch/mips/kernel/r2300_switch.S  | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


