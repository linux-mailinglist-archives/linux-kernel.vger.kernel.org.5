Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22EF78B702
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjH1SGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjH1SGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:06:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3B11B;
        Mon, 28 Aug 2023 11:06:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c479ede21so2951641f8f.2;
        Mon, 28 Aug 2023 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693245973; x=1693850773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uI9Ikev+9JS4tOOaqkicM0zsp0agDJgqoKYQ31wjrJk=;
        b=F40UEImFzFa+fRkSVtHaawSzbQbGzki6okp9zjV+eofZvGmobI+l+YcTvQrVK6/Quc
         oeMqbZEaHfjHLWUltNlL2pxWrKX3HcAmIEcnH2Ivr1uTZrCQJN1bGXvxJgo7Qa5gHE4X
         fZPVn1O3LXUHRLrSZtIR9jBLOHB0jqWUcxF4lM02Qrv/8XIckGf2Kxu/P+OzFbET7THD
         LNGg3QuTHs36+D7GAkPtvLWhsTZs8sErduKBnh4N5tBJRtcCPs3mxm0xyKR1mrkyzB9w
         oeI3Br8Q78Qn4O25x4Sh2RQhe4tC27AXe5O+YX/4Hg6Z9mxSM4Ae2FEOOPXTAn5iYJeU
         jvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693245973; x=1693850773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uI9Ikev+9JS4tOOaqkicM0zsp0agDJgqoKYQ31wjrJk=;
        b=L4GHj54Djz7Yn8hGn5Oqyo2KlluuWmO/szWaGnJmHgx+zrEL585w5ciHoodXRbl6+8
         TrwFHtw6jHl7x2MU2HQAFg2FjEwo+xAEqQmhmlCJqqzyMFp0DZH65hiJ8zjooKGA2FMD
         YPseTO7f0hh+hYOBPfgius8qFeu7TdcqFbuSCck6TYDbe5lgO3e7xiHiq0i53dfVXP32
         gkTweaD3Gttjgmei3PoXOmBK38qjJ7Z/K76Wa2SVyUV3kLlQXqhCvit/IJ71YE1vWn/p
         /kD4oIRmgbh8IHu6KJfRwogRklGgm9YNJzpaMfciZdqDoCu8OzEIbrz70qPFqv9Vz/k/
         qVjA==
X-Gm-Message-State: AOJu0Yz8VlyZRG6SiWg4D0MCOlTmypmVOE8A+vj13/lbUcOBtgZU2juW
        bTIaMy3TX3/gOcsqlbmxxbQ=
X-Google-Smtp-Source: AGHT+IEX4NuxQl4jAqp8zfBZSGZfAgYCv99+iZ+Y7be8zElEvXIjN6mvdclt37gm1YQS66o8UaNFaQ==
X-Received: by 2002:adf:ce82:0:b0:319:a24:8d6b with SMTP id r2-20020adfce82000000b003190a248d6bmr19680207wrn.14.1693245972688;
        Mon, 28 Aug 2023 11:06:12 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d43c3000000b003140fff4f75sm11128439wrr.17.2023.08.28.11.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:06:12 -0700 (PDT)
Message-ID: <689ae7b5-0b73-3cb3-5d9c-5ae23e36ee85@gmail.com>
Date:   Mon, 28 Aug 2023 21:06:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v1 1/1] wwan: core: Use the bitmap API to
 allocate bitmaps
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     haozhe chang <haozhe.chang@mediatek.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2023 16:19, Andy Shevchenko wrote:
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
> 
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Make sense. Thank you.

BTW, any plans to update __dev_alloc_name(), which was used as 
reference, in the same way?

Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
