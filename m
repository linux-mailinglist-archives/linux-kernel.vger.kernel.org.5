Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BFE77DEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbjHPKew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243920AbjHPKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:34:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1702117
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:34:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe4ad22e36so59555205e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692182079; x=1692786879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TBFn80+o0TLek+tL20KausYPCYv+uibCCkUTGpWXII=;
        b=U6swsDAbG+qx9TXxFTUymdjEanUzVmA7yebBb8lE3T+bHlCH1zW/VN0QoY5d3379Gp
         k/3no7XUva6SHr2hK16zBJyQiL2vn2+lmyxKnb2JOytfFC+WUYHkHFIacpznwjhkHAEC
         O1e06fogSY7D47cOctHJS86WHNees2xYk3MB5gTQK1LCQbVxE5WRvx+QlftRJtOjnLox
         vELFO9EfXCTTNlr5lSPDOFKGD8DBZVEUTDN8qMN8EXN7juPE1y3sYl/uJW8B3DG4bYd7
         5gajEkVpDl7kobnwAzGNYqtdgXGYt3WjNFF/M4xbsJo9EJFnLwPUaaKOE/XojvDF+Tp1
         7rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692182079; x=1692786879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TBFn80+o0TLek+tL20KausYPCYv+uibCCkUTGpWXII=;
        b=G8jv6mQ1eZznqg0zBqZYdwb/jnoDMADO0NRfRKlX5vuXYFaoHw1vbXtnqf9WilwldX
         sjMouUNdfEoDr2Ewdk5/cj5R96kZ6JJ9Ls2SUVTlO2p8Czm2iM6Pk2iM+ZkxPero2Nkd
         HLiYztwLq596+bvx6pLcphtcsYP1GsIG+8SeZMs9eTA4PLxJav7GsEJQH/v+kNcrZdHn
         gfW/3hWz5XGFCCR/IlGfvjfCHDbg1ZBduUC+Wvx0O4E66/C/+PXs6zcf3OyhmCvhr2Pk
         ibBi4zJ7G8sxGPiR1GRh23lTd4k2EQ+hzGPJrCCG4CXh9IRk/lVXosjRaddyUR174fqI
         z6Hg==
X-Gm-Message-State: AOJu0Yxi8yTpXSRs6aN+7JPzyNjxEMJrK4da/RJwSPpRu5WJkx52sjq+
        X2nYXJ8vAkW66ORePkpOAl71sA==
X-Google-Smtp-Source: AGHT+IFlcNBWlNE8mfmjhWrUCRt3pXMI2oaXy/5gBTXPSbPjugwMcUsRpxIw6Pa7OJZaHH+3Wv77iA==
X-Received: by 2002:a1c:4c0f:0:b0:3fb:e1d5:7f48 with SMTP id z15-20020a1c4c0f000000b003fbe1d57f48mr1080073wmf.5.1692182078531;
        Wed, 16 Aug 2023 03:34:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z15-20020a05600c114f00b003fe2bea77ccsm20796404wmz.5.2023.08.16.03.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:34:38 -0700 (PDT)
Message-ID: <cfcc85b6-fcb7-6433-d64b-58f287e9d028@linaro.org>
Date:   Wed, 16 Aug 2023 12:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: max77620_thermal: removed unneeded call to
 platform_set_drvdata()
Content-Language: en-US
To:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     alex@shruggie.ro, rui.zhang@intel.com, amitk@kernel.org,
        rafael@kernel.org
References: <20230811191548.3340-1-aboutphysycs@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230811191548.3340-1-aboutphysycs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 21:15, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

