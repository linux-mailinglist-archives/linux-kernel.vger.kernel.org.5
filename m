Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845587ABA9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjIVUrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjIVUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:47:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65CC1A7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:47:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405524e6768so3595485e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695415629; x=1696020429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VK7nKo5jjv/BHuGhevJXoAw67kPf3F2A5OmfN/InhIQ=;
        b=wLgS/eEWNR/WdZXzkXUmPtrZ7vVlg9rybM6mu03ITnVN4Hc4HJHK17X9oFpRml+eFq
         o+8jMLHNX/WxIP5jSL+y1G9qP7m1gSCb3DZED9XNQNa1SmhyPclW7J8H5vj9ffRt1DcR
         h4kJtHIKw11IftpdmCtcgdyqDudxwEGtmE5CZcbAVxb5YQZKAON5Kh/B3snyudZjNkKX
         sVDPRHSDUC0FQSZCDWtV9wTFNisLV/h9vkbuh+iTwO9fiWjLR13kBkw0QHTGN47Jj2Bd
         2iTQSrU1JReNVbpCMRw5fuXpf4xI8M4FSp8B4cOElkG+m+TOkdS6ohDJ2NbS9E7qYw2Z
         +Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695415629; x=1696020429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK7nKo5jjv/BHuGhevJXoAw67kPf3F2A5OmfN/InhIQ=;
        b=qAoBi73vE8/YlefYog/djHqjFUJiAfhtn8g1y/g2hxDm6Yfh6xTIBRNJ1AI8mC1MZK
         FlGmvlDwgIA4xT+4nLZGmthD+8zxZxhAl1C1LFc3UB/4SOdtZjprtcsamyonrQWdG8EC
         R5dQXiS75wzu7eVwtr+JBnY9gjFabV3wm4rmZnkInQjdPjt3jg6g+5YwTbVb2fjVhbix
         eloW2JadpoE6e7qHVMYxtU0ut+wGcqwE4kIOkM6cN3WiNFRbk/R4bnJWa3nxgdHhGH0I
         W/KNWQGIAxC8Aa7lNrZa8qIA3rtw9pQjCWL7THyucuyNfnf+rfEdlhrNoAgtG0mOofJG
         Puvg==
X-Gm-Message-State: AOJu0YxHsy9e/ucDBJGCQndHNGVtVwuYsaffCXXdkjjTahnN4jGkwVyk
        erW1xjUW9ntoqswjdY2jWLLofRMiC4SqxzZYRzdwSQ==
X-Google-Smtp-Source: AGHT+IF1Q2/tmPB84H7WmLEwWFwROp72h5OiwDOtOjp5PSPkN/sg1ZigDvHO2lxQasE18CL5/ZUEQw==
X-Received: by 2002:a5d:4310:0:b0:315:ad1a:5abc with SMTP id h16-20020a5d4310000000b00315ad1a5abcmr697086wrq.5.1695415629287;
        Fri, 22 Sep 2023 13:47:09 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c12-20020adfed8c000000b0032179c4a46dsm5248221wro.100.2023.09.22.13.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 13:47:08 -0700 (PDT)
Message-ID: <c835c404-33f3-4f5b-8a8a-819d4019e74b@linaro.org>
Date:   Fri, 22 Sep 2023 21:47:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to
 DT overlay
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230922-apq8016-sbc-camera-dtso-v1-0-ce9451895ca1@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 16:11, Stephan Gerhold wrote:
> Follow the example of the recently added apq8016-sbc-usb-host.dtso and
> convert apq8016-sbc-d3-camera-mezzanine.dts to a DT overlay that can be
> applied on top of the apq8016-sbc.dtb. This makes it more clear that
> this is not a special type of DB410c but just an addon board that can
> be added on top.
> 
> I also prepended a patch that cleans up the node names a bit.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Stephan Gerhold (2):
>        arm64: dts: qcom: apq8016-sbc-d3-camera: Use more generic node names
>        arm64: dts: qcom: apq8016-sbc-d3-camera: Convert to DT overlay
> 
>   arch/arm64/boot/dts/qcom/Makefile                    |  5 +++--
>   ...nine.dts => apq8016-sbc-d3-camera-mezzanine.dtso} | 20 ++++++++++++++------
>   2 files changed, 17 insertions(+), 8 deletions(-)
> ---
> base-commit: 7236e86ce5c8198b01c30933c2334d07d877cf48
> change-id: 20230922-apq8016-sbc-camera-dtso-f247bea40f99
> 
> Best regards,

db410c doesn't ship with a bootloader that is capable of applying a dtbo 
though, so this conversion mandates an updated or chainloaded bootloader 
or out-of-tree kernel patch to support.

__adding__ is fine but, converting implies imposes a new requirement on 
the bootchain.

Perhaps a middle road solution is to

- Add, not convert a standalone dtbo or
- Add a dtbo that includes the mezzanine dts but amends it

Option 2 for preference but, I'm not sure the dts syntax can be 
meaningfully made to do that.

---
bod
