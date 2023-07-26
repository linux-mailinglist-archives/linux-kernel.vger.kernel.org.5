Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E218E76420A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGZWTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGZWTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:19:39 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC51BFF;
        Wed, 26 Jul 2023 15:19:38 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63cf40716ffso2192836d6.2;
        Wed, 26 Jul 2023 15:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690409978; x=1691014778;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/j0l43eZqMt7XKeTTtri9t9bS6YoQJJQ60maQhqW7Rs=;
        b=d8gcXg73ZNT8HEPJBWzCf+Akd1TSI81bOxX7NNzTpeZIsCqSWss9G1knygLaJquIO/
         NCeyhBzTMrp3shE5dMrkIB4ARgBTQP7M1hGf5ZMmQAMCRXLzmib3VoPqIHaSeQxNqN51
         WKdxngmW7E1uyNkapJUnqySoTMJpJZFlYIZIdAVZlfuX3gSGY9gGIs+nhAZsEAyEvI7d
         LU0ytgQHsg6OyMieBbRWa1RixHLM23RZtF5GdQAOoZGMwWZj2FPJ9RED+X8YRuRFsBuc
         ZjzQn/BCjWQ/drYRkj4WqpVDdijjbvz6A+MRNicklYE9BbHBn8xVe/n34Hbl3n7HNnaN
         YAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690409978; x=1691014778;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j0l43eZqMt7XKeTTtri9t9bS6YoQJJQ60maQhqW7Rs=;
        b=Ss8act3l2A07nZaDXPhanD93trQiC19kCNuehGuRRchdfeuPeBMUPTRTvIPeM6FY8s
         AWQnibF3wK7FYDecLuRXmb/waYblKTYg9FInZq5r3j6aUms+3AN32fOSdYUV5CnHAo6U
         UvwnRPUkejTZTd1t/OyiI/OQZQct4hy7YLGaair8/pbEnN+5g9tATrzjlcg8AJNXImLc
         foflgTnUyjmAoBFcHIvzrL1PEnovabWs3zlwySEFBL27d78fHUthCawLCvb9607S3kA4
         j/hxIw7W1TxF1CemQdFo9j5HS7TCPc3jJ1ARODfJ5fTqTYmJHGNVOic5mhsoQHc9rEJN
         hKiQ==
X-Gm-Message-State: ABy/qLbM73PSo95UKlAFt6wLKoeHzawJ2pAC12nFhGpglZMCjdwIZdww
        wi2zaoavrzWG6eiUlEvLxw8=
X-Google-Smtp-Source: APBJJlE0ZoI7/W78t15Hg4I24Oe7hTuxYVYJ0vDRV4lSl6U+l5hKyfa96k+fULGsZGALZaNcHP58dg==
X-Received: by 2002:a0c:e3d3:0:b0:63c:8afd:7273 with SMTP id e19-20020a0ce3d3000000b0063c8afd7273mr2949689qvl.12.1690409977855;
        Wed, 26 Jul 2023 15:19:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x9-20020ae9f809000000b00767cee76155sm4627344qkh.55.2023.07.26.15.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 15:19:37 -0700 (PDT)
Message-ID: <7cd0c538-afeb-848a-4c91-4c96934a70ba@gmail.com>
Date:   Wed, 26 Jul 2023 15:19:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next PATCH 1/3] net: dsa: tag_qca: return early if dev is
 not found
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230724033058.16795-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/23 20:30, Christian Marangi wrote:
> Currently checksum is recalculated and dsa tag stripped even if we later
> don't find the dev.
> 
> To improve code, exit early if we don't find the dev and skip additional
> operation on the skb since it will be freed anyway.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

