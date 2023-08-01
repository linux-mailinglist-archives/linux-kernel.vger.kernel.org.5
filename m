Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2676B647
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjHANxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbjHANw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:52:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB1FE4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:52:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31297125334so3861857f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690897973; x=1691502773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXUStV/k8ExcjG5bEMfsjTalaVoKA6nTdSvi56sS+yw=;
        b=UrcMQkJH2/LmlPi04LmT1Awqax6mNB88Z+qxMeNomi1CQLF7n8C+nGl4zg2IpUO000
         xhqTFK4eNEXjy0EzXz8SC3Jxm3+2Q88M+Zz0a75/BjQxZHLETmrgvGfBRXXampBb8oP5
         TzDfHXsMFhpF/JfqOfi702BI2MSwfRxYWKlOEj5pzre/KpYNv9M9tjT9zv1agSjsY89u
         0VjVYAaqNGih8ICfmWCMYedSEJi3HYbntU5N20GhsbI+FV5j6dgYMnCrpY0pXnZK9JIs
         vOsw0Okh7IVxvm6/+OV4kfTDaMLr+6KVm2HpVVCw2wc5v8SBoAS+FfF99Gw3sfvXeJ8R
         B4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690897973; x=1691502773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXUStV/k8ExcjG5bEMfsjTalaVoKA6nTdSvi56sS+yw=;
        b=ZmPycQiJPcUxPD0teNaKujyFxQLkZauC/irJN1fLsHwvvPEbNIDMi0/z4/aFytynxH
         f23DUxDJ35P5Bm/GZcZzsX8MQiP4TBa09Io4slOA0igHxXCM7fh2idZaL64ITlmdHQ6p
         Ewgx6FfxXlqO7FPK2hR8x24InOLMa9sjnWaDC8l6KcNHyw7qnFEoaQe3ZGAwEUVOd1Dj
         dcw9GR1HgG7I2C4SHYfikJdpwBCIHRtTeGnRoHzKMSprrULDVtbtQcgJ4c7ovjZc+kg0
         06hGdCNl3eKrZbIZpIhBBDCaPIS0PbhKIXkKtJnXvGPa0sD7e1HMXIA7eAs+3tKwFELT
         57zA==
X-Gm-Message-State: ABy/qLaJg8uajyiamF/xm4tFgiOLAGPcTTkAs1aslYNQ7tip33zkoVQk
        VbZ7I75kn9uER9+hJTi03kUriA==
X-Google-Smtp-Source: APBJJlEoyP+hdnGu4WBDl85EWrTlVIh+/QsC3aO15ODMrsTdWGEJLSPYL93d2Ef9MUAaNTt9ims50Q==
X-Received: by 2002:a05:6000:1011:b0:317:5e91:cf5 with SMTP id a17-20020a056000101100b003175e910cf5mr2562855wrx.7.1690897972898;
        Tue, 01 Aug 2023 06:52:52 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
        by smtp.gmail.com with ESMTPSA id g8-20020a7bc4c8000000b003fe1a092925sm8511971wmk.19.2023.08.01.06.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 06:52:52 -0700 (PDT)
Message-ID: <a0528da5-eb04-fd3b-fc78-d57ff16cbfc5@linaro.org>
Date:   Tue, 1 Aug 2023 15:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 02/17] MIPS: Modify the Loongson1 PRID_REV
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-3-keguang.zhang@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230729134318.1694467-3-keguang.zhang@gmail.com>
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

On 29/7/23 15:43, Keguang Zhang wrote:
> Because LS1B and LS1C share the same PRID,
> it's reasonable to rename their PRID_REVs to PRID_REV_LOONGSON1.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>   arch/mips/include/asm/cpu.h  | 3 +--
>   arch/mips/kernel/cpu-probe.c | 6 +++---
>   2 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

