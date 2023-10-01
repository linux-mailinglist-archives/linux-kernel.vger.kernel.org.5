Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004587B4818
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjJAOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJAOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:40:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F5EDF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 07:40:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c136ee106so2155113266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696171234; x=1696776034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WSXGXHBURPzmrW9bvhy9NXhgUHoIYOxdiOp4oYI05E=;
        b=OWazHkrQFi9ydc6GKaSXUKtcIMn/ouoM6uD5imB8I8P7g2YbEL3BxkFm/bPBD0TPI7
         VAdQ2P/OAp/TnqMkfWhKN/gDmla63KtoUHoBWSzrIcsN14lm7T1eeBnR0TRQ3HjK+nHe
         nsMKTmpN9z1bn77QnGQryXGH61o8JM/66lFxT1QT0NjsxjuMIcuBXGfoq+eTItpcb1qW
         6g5kMeUQBgQOrcZealJjQwpCyWUXv1kGYm/CwLEuvsyOz3R2MZUvBUBBrpfOefpLhKx4
         nQ4GzQzXBg+3vOTe6ua3MiCJ5FfGz59IjB1NqwdIjHwMllHffwcMMUNQf1TV9x5a2j60
         A+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696171234; x=1696776034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WSXGXHBURPzmrW9bvhy9NXhgUHoIYOxdiOp4oYI05E=;
        b=G/Hu+n4Xq1DrYP3MbBvALt3xPjVD5WoMgQrfVPXgrZR8aTPY+7J6Lx+MhULAj1mx1f
         rqdDpCviM9YcSguDu7h5/gZY+g6fPoUOVUiUAB5ArOfXx6XB0ygV6He6aTXJ4s+9nYXp
         E2EE955saEpCjjayggOZnEpUOS3bePjznfCNADC+NSWBVUNDXjk3MREIGs1U8mBa3WkW
         OKiAVKcEHHDxES6VsVn8zwW3IxPLdLd9bXuwDwvBNIFrTx8wlU/Dp8bjtLjqMv7XB07H
         Nl6LRe8bYkNOGUel71onXQl6G9299J4P5jHA5wx1eKxHN5qbVgFRbGsxTlC6VZ5RN4bP
         oBkA==
X-Gm-Message-State: AOJu0Yx7/mkR8htvjwEEqUNN0BTfBwpVsS8nM1rbIie6IPOinrbszZAt
        Hh6fS/rbPj1V88uqEhvR9RZO5A==
X-Google-Smtp-Source: AGHT+IFeKziBiDxciXW7IYU9GXRpZ7Acba6SrW2fNPJ0lVgwpU/JeOc+jSOevgpbrnpxGuOEWPRqkw==
X-Received: by 2002:a17:906:6a19:b0:9a1:c0e9:58ff with SMTP id qw25-20020a1709066a1900b009a1c0e958ffmr10773602ejc.11.1696171233722;
        Sun, 01 Oct 2023 07:40:33 -0700 (PDT)
Received: from [192.168.1.23] (host-2-99-112-229.as13285.net. [2.99.112.229])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c220300b00406443c8b4fsm5378881wml.19.2023.10.01.07.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 07:40:33 -0700 (PDT)
Message-ID: <230ca044-99c7-45df-9947-4605b8c0d295@linaro.org>
Date:   Sun, 1 Oct 2023 15:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Add fixes for FastRPC driver
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
References: <1695973360-14369-1-git-send-email-quic_ekangupt@quicinc.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <1695973360-14369-1-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/09/2023 08:42, Ekansh Gupta wrote:
> This patchset carries the following fixes.
> - Reset metadata buffer to avoid incorrect fd getting freed
> - Free DMA handles for remote calls with no arguments
> - Clean buffers on remote call failures

Bit of a nit pick here, but you should try and use the cover letter to 
explain the necessary context and justification for your series. An 
overview of the commits is already included below by b4 or git-send-email.

It would be good to establish if these fixes are all related in some way 
(ie to enable a specific usecase), or if it's just a few random things 
that folks have discovered. Although it's almost always useful for 
maintainers to know how these issues where discovered as it could expose 
a gap in testing.

Regards,

> 
> Ekansh Gupta (3):
>    misc: fastrpc: Reset metadata buffer to avoid incorrect free
>    misc: fastrpc: Free DMA handles for RPC calls with no arguments
>    misc: fastrpc: Clean buffers on remote invocation failures
> 
>   drivers/misc/fastrpc.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
> 

-- 
// Caleb (they/them)
