Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C07619E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGYN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGYN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:26:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEAA19BF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:26:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso4245464f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690291600; x=1690896400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sohdea9KJoSOqyVVvykUQquJ+txNA8sQVTw6IM0tbbI=;
        b=DjCY8xAxoFhRhfqHJ11qHQwtNTVgYrOIDINAVVv+VZaDGh7HZaLISjLqHtwAFRW7zO
         Jom1E7jqKmBSWIOicBFiVw1axSo7PNnsZh32rQ5s4vOerRt06B/tXXEjJA/YxwKwkzhI
         fTzYbXf0ThLmQqZ+EVT8nbTy6+PC+qKhXTBftZaBQ8/h8upzJQcVaTJF/wXKdePxAsRB
         M9S7FBeJH67eJWdcCNVHONn+FseEFW0jVNRz4XC3MIzBtOl0CNEqlgPO4mbdTfvuqOE9
         +A4gsjn0D1dyZSrsuaZOh8VA5As3DC2rp6O44XpjKQ/IQlotPGY1GhH6FSrg6sJHRx3F
         Jdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291600; x=1690896400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sohdea9KJoSOqyVVvykUQquJ+txNA8sQVTw6IM0tbbI=;
        b=WFMsWyAtYXDC/6YIAP5+QkJZKInHvoxI/jeI93i4RxNQkEO4b6CKTowWWL9VNFC8bi
         KiWRPwFBd5DDgBa82GypLQFB/8DfajNcvVfO8XHd9OOgljnGJahYT3qXhfPERId/eAhM
         rPqiYUujPMA3e9tGTBTUVJ/j3pPVO2oFXtkdreyHkW/uSrmlBLJhG2GLwv73BpBt5VSv
         9qbsBbGt74/W6JzuNcMIv1wEJAKzzz2QHjJ1k4urueAM/6an01cTMQgdaS2bABjKKrmw
         tEoR2L/ibUfC/+s+tn8GYz06yyvnheSHwa+Syg4aN9qz8b9n62gYly+npvyiUG1nQR+B
         4WcQ==
X-Gm-Message-State: ABy/qLbi3PFguZOSdOMOnBsSaaTI/4hmn+lcAFosaoBPBI4LcH8LX4x/
        rxd5yP5SCxn2hxvUHCF/wl9jQa1HjgoOIlPpip4=
X-Google-Smtp-Source: APBJJlG8BJSzzIo2Yij5qOtXiOvireLsqonHDc68f7QTB8F6IVYj1NTBtdEmNub316rnS7UO4qY0pg==
X-Received: by 2002:a5d:6051:0:b0:317:6314:96e2 with SMTP id j17-20020a5d6051000000b00317631496e2mr3439624wrt.14.1690291600681;
        Tue, 25 Jul 2023 06:26:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.142])
        by smtp.gmail.com with ESMTPSA id n8-20020adfe348000000b00315af025098sm16472754wrj.46.2023.07.25.06.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 06:26:40 -0700 (PDT)
Message-ID: <bc8989c4-fde7-bec4-b255-d54630f54798@linaro.org>
Date:   Tue, 25 Jul 2023 15:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] MIPS: Loongson64: Fix more __iomem attributes
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230725060144.1501195-1-jiaxun.yang@flygoat.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230725060144.1501195-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/7/23 08:01, Jiaxun Yang wrote:
> There are some __iomem type casting being missed in previous patch.
> Fix them here.
> 
> Fixes: 5bd3990723bd ("MIPS: Loongson64: Prefix ipi register address pointers with __iomem")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307020639.QCZOKp8B-lkp@intel.com/
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Drop invalid attribute for play_dead pointers
> ---
>   arch/mips/loongson64/smp.c | 160 ++++++++++++++++++-------------------
>   1 file changed, 80 insertions(+), 80 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

