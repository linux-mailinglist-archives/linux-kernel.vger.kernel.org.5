Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA966790D4C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345834AbjICRd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbjICRd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:33:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25BBFE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:33:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so905497a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693762431; x=1694367231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJlJEDKaMVpuZOQmNMYZZ3OzPFp1RwseEJnA06hFnEc=;
        b=aRGyh1ls9VmxVJEZAXhrbvZ5TgoToXcQaCMoJJF7dEw4sBHsRaPD4r7DYG7mz0z49r
         Fn2gXel+hxFsvL/Ratey7oFYgrHSyyxuG+whRxc6v8nD7D9N2VPyghqvWbHdhKG0E9VK
         sf1xvC8g2JXj3ejP4ZkM4NkVwxvL0Jv/6CYhzm3Dgiy6YOJhCphb2WRsvlUkWu6aApU3
         6r+FKoc3ve9GeqRugB2ujg+xRA2B+slpaTqd49JqLKIDWQ5OPb4dvVwIMQ6Vtbrnk2k2
         2bscTOACBnI8mDhwuxZNQeerF7Tv/IAOG/xxBs9BPaYFbGFXmPoiJ/FcJTNkqvO+TCJJ
         120A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693762431; x=1694367231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJlJEDKaMVpuZOQmNMYZZ3OzPFp1RwseEJnA06hFnEc=;
        b=TD/zUtNLtE8HoOL45s4c070CQA79gNz6N/9F1BoKTW9esRe+psjRkbdtMAIv8TrSyK
         SqvyjHT/jfMsl7WS3bxhdll/vlMsqjrNWohStNSViYletwEtP+2RAJ260iMv2lqSV1Dd
         IAP924eEttbFhxZ80ttNGlWfuLPsuTra41IRIvd30q4zUClRAkn3tV/uN2RTJ/4cJePI
         cHIV7j1nnjSz8c9Jp6G6fhHb2F/LxObr5f5b2bnJSSrcwAvyT5k2eunEsyFDISGL4+hv
         mEmTifKepUmcKRO/FolM9ZFCHNMYyKwqoatZRPEoKhuMaZtXXK8fdlyeuHoi39ayYBPB
         xWzQ==
X-Gm-Message-State: AOJu0YxDD6Yvf2pOizdvMqr8OIm2n+3ywU2A+DdAiKzHOBwVuwiPvaXR
        +9+kgg/3CyyQqZ+9XiMvJzki/w==
X-Google-Smtp-Source: AGHT+IFp8PyiuVpsHpKOtE87RrTWgxXMDJl6l6P8L0HRMD/itI6bupjZ7KaLE5yLbm/5Kt8EVTeM8w==
X-Received: by 2002:a17:906:31d2:b0:9a1:c9c5:5fa1 with SMTP id f18-20020a17090631d200b009a1c9c55fa1mr5729464ejf.4.1693762431275;
        Sun, 03 Sep 2023 10:33:51 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id s1-20020a170906960100b00992d122af63sm4995441ejx.89.2023.09.03.10.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 10:33:50 -0700 (PDT)
Message-ID: <79bee2a6-6d6b-9fdd-4e97-cfebf65f81f7@linaro.org>
Date:   Sun, 3 Sep 2023 19:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] crypto: qcom-rng: Add hwrng support
Content-Language: en-US
To:     Om Prakash Singh <quic_omprsing@quicinc.com>
Cc:     neil.armstrong@linaro.org, konrad.dybcio@linaro.org,
        agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        robh+dt@kernel.org, vkoul@kernel.org
References: <20230901131502.1549809-1-quic_omprsing@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230901131502.1549809-1-quic_omprsing@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 15:15, Om Prakash Singh wrote:
> This is follow patch on top of [1] to add hwrng support for newer
> platform with trng capability.

Please use subject prefixes matching the subsystem.

Best regards,
Krzysztof

