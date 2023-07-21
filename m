Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01475C221
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGUIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGUIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:54:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5CB2D7D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:54:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so1306435f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689929640; x=1690534440;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYfPow4s5dm2AWNlgMyIXRIdeTwyUVfZBCOfl+Gq2Cc=;
        b=EQLqgIrH2Rwsx+q1bfzyKSuH0BapF1Bjw3JfXQDlKY6HeDY46hFHdJHYSIDAxsMYww
         46JDV/tF3ZicxebBCdIeMdKKr5om1C8K8IeUyzyBivGJpmf2SshRX4rCv7yOIYtDNmat
         mNl1E0c3AuJzvJt+OE2y/rvvxx73yYw7S03A0z3p+nGzUzSEhMGCdK08YeumqiHTrkUs
         yxektXIbD8TNb1EmwbvKwVmqCdMMI5WyHq9urHMpy3bdscXBkPrVPPHZS3YUKwiSFY1w
         M9ySNTx+YvReorQEarTBpNb2jIwfNzbjGBKuqSp6BZEKCeR4W6wDuAe3jHXrSzrzBmox
         0tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689929640; x=1690534440;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYfPow4s5dm2AWNlgMyIXRIdeTwyUVfZBCOfl+Gq2Cc=;
        b=ZKnBDf6D10owmfcY+4GDQJIi0Vj/aY8/OXws2/L/3Hb9c5Xx5wSMZ/N5qjyIhOr9JZ
         NFrMapbRMBA8lo0gI27UBpbSK5s9hCTzpBwNc1Q5OiVK2Si1ANk6B0MFagKkrwGIAv00
         Bpd1zs2MgJ6ng0/HnnzmyjSCf1Cp+XgH8Hp+caSXuaGsFLJgdMjtZ5A7oSdXY83h/R+q
         SaILpcYnNtWD/PlrER6p1bbofQ+I9GVmsOXdtC+QPJ6yU9uNt39zKvNOOsAS1GOF4Nh9
         JXZLJI9QehHiwshsz+PBbgBf7TVxCkT54/MSVSGOKWjvJXEKwIRk+BCnoGJqrM/HbMPA
         kf7A==
X-Gm-Message-State: ABy/qLYgxqtHDwofswQPEKoghbB+m6ZkVf/xp6yxY7on2LC++s6RtseA
        dD/iFEE0I7W/mnQBycncvZrq/w==
X-Google-Smtp-Source: APBJJlHU99VKTdLj2WpfBN8UKdqYO9W/lL1DQfYnQ/yuZ4GK84mr/0I5x2BAZmL6HHMZVDulEUVpqA==
X-Received: by 2002:a5d:4989:0:b0:316:fb39:e045 with SMTP id r9-20020a5d4989000000b00316fb39e045mr745335wrq.48.1689929640254;
        Fri, 21 Jul 2023 01:54:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d4fc3000000b00314329f7d8asm3592170wrw.29.2023.07.21.01.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 01:53:59 -0700 (PDT)
Message-ID: <884ed5d5-8863-ac76-5f00-4ed58480e9ab@linaro.org>
Date:   Fri, 21 Jul 2023 10:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v2 PATCH] arm64: dts: stratix10: add new compatible for Intel
 SoCFPGA Stratix10 platform
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Meng Li <Meng.Li@windriver.com>, dinguyen@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230721083821.1820881-1-Meng.Li@windriver.com>
 <b8333812-df9d-368a-939b-3495878a2e5e@linaro.org>
In-Reply-To: <b8333812-df9d-368a-939b-3495878a2e5e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 10:51, Krzysztof Kozlowski wrote:
> On 21/07/2023 10:38, Meng Li wrote:
>> Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
>> the Stratix platform also does not support clock-gating. The commit
>> 3d8d3504d233("usb: dwc2: Add platform specific data for Intel's Agilex")
>> had fixed this issue. So, add the essential compatible to also use the
>> specific data on Stratix10 platform.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> From where did you get it?
> 
> Did you just fake a tag to pass the review?

I just double checked my replies and this for sure never happened.

NAK, don't fake reviews. This very impolite and destroys entire trust.
The model of upstream collaboration depends on the trust, which is now
gone for Windriver.

Best regards,
Krzysztof

