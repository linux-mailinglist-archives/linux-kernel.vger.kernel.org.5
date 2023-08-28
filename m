Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A6678B86C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjH1TcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjH1Tbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:31:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECF4123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:31:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40061928e5aso33519805e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693251096; x=1693855896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMkU/J0ZFGbg/p09y/D3bDFi8JfdBo0Ur6oFiBkPA20=;
        b=f0y2DGQKoS++PI9l9qvolhZJcGlTrZJr6hU/CUSUFXMe1OPFY58hbdLsqyUc8IQpch
         VGpTtPSxmUGmi0busKagj2gajsDg8jqYbUuGw4yRB8CHUYoiSjIgQHQZ+E4EtQqDHHsD
         zW36Q5mQh9rbCELjpcEP6GqAhU7+qYBK4uaI8E7wDOogWpu6SzZyyUT/fdPXGkTynitk
         OrH7hix3rnJQuFHFNWlCbomKMGTmxcNuPySuekuW1J1rX3zj0qbNC6NzCChZHoup2WXo
         StVAz8vblACLtEx+V4SkRnxkhHm3+QwgjjSoEEF7WLtCTrZGjXXel7sRHkTMS3aWuqRg
         JSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251096; x=1693855896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMkU/J0ZFGbg/p09y/D3bDFi8JfdBo0Ur6oFiBkPA20=;
        b=aSfV3lLgnDUIa+ntuECi9a3VeXyCKL13N30jtQzkC2trMG22rcAv+mPUvwWIsukAjI
         AmL3/lS9kdL/qGgtmyR3DTykBCuRuJq2ErmPM1Xya6LqsvcWA/0yhHnef+MjXu7D95CS
         lmwd1OXcH7dfUMw57GLyzbM2JxdpRzLlHCpfw0+RkYBf0Z6aMdjUQeZVcJ6VDKtqVaMJ
         oqCnDufJHHW0OZ5ubbBjai6FyvzpirjHh/YUK63OMG9JgVOnHwadv9AEOpDd+vvx2skV
         6ukJvcK1KAjMECt/HoeEikHSwTTLK2X2XOI1bedm4T4dQfAOnoBaQziGjKI15BvHaQkS
         3Jbg==
X-Gm-Message-State: AOJu0YxQve+sXK28AOzM4wVBOgR6VbvqAIqmyQ6e4RRznWqcLQ6nz+q3
        NhXm1ca3OYzz/nfWvq40pE9J+A==
X-Google-Smtp-Source: AGHT+IHnY+pallKwdR5CRCn7xPvUv0V1vQ+gNzNjXUHu5T2JRvk8F9cWhCJt20KO7WEGRKlUv/EDKQ==
X-Received: by 2002:a05:600c:224b:b0:401:73b2:f043 with SMTP id a11-20020a05600c224b00b0040173b2f043mr9561376wmm.1.1693251096409;
        Mon, 28 Aug 2023 12:31:36 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a9-20020a05600c224900b003fef5402d2dsm14994380wmm.8.2023.08.28.12.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:31:35 -0700 (PDT)
Message-ID: <5464b036-1b90-e7e5-0bb9-100a1fc96a8e@linaro.org>
Date:   Mon, 28 Aug 2023 20:31:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 05/15] media: qcom: camss: Pass line_num from compat
 resources
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-6-bryan.odonoghue@linaro.org>
 <20230828183616.GJ14596@pendragon.ideasonboard.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230828183616.GJ14596@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 19:36, Laurent Pinchart wrote:
> Should the variable then be renamed to num_rdi or similar ?

Yes but, the use of "line num" is pretty extensive. I plan a series to 
normalise the namespace a bit later on. I'm just trying to scope limit 
the extent of the changes in one blob.

- rdi_num
- size of struct resource strings

being two that are "high up" on my TODOs.

---
bod
