Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59189762F69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjGZIPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGZIOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:14:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1FC8694
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:05:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992acf67388so936499066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690358738; x=1690963538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAHUQ8fB6FGgHFeTYFJpEoe7c/sqaC3KeyYejkkBsfE=;
        b=k+qqrxnCxTnSv0JS4TM2MVG/86jPA2QGCR8vVSQrKTNLIZvoCHFAGNtvHwYlWne+nR
         u2VVErVNZtfbA2qmx+I044+t2dS5XFCTw/KW/aFZQa0LNkau5oZMVKgPaaIhynMFZx8T
         C1PqB14vPiE8Jpjtn6Rrn3fzZX9Hd1yiTMYn8b/9vl6YN5JMbYDspJe0Cl7pgdqhIBry
         xadJ40gaCvOs0EWSI6ycFpglFFFrV+57ulGbWf1HblyUSzC1FnhduZrgrQfwUZDK7ozp
         5rZ5LocqVPzCzj8RLhAsYjFvayK1Xn4rkk0FO400T2RsYwJtPOXQpuOoG+tckeR+sozb
         LkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690358738; x=1690963538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAHUQ8fB6FGgHFeTYFJpEoe7c/sqaC3KeyYejkkBsfE=;
        b=WscHqAHS3ugzhsFlCmyGB1sYzieijJ/vWhEvYsgDXGbU2GHhrRXr9960zY2M9hBzru
         RiEPyaxhgcWdnUDVZiHDHfNSaEFcnthJZk35bpFVhsE2TOQ02Q66c8V0l2GWLnv7Z2C1
         F1EgIrDXxaTYPrw+HHhGmKlbKQZVhdZQp6ZwpN8WJVK3hn4o5BlMLdT0LBEz73m6IAou
         QD/LE7vohotTx/PSXjhJTUXgehsDzjl3VxEf3Zr17n4qbh/yGwibMC/CODYs9UNmUF14
         a0DcrHsReBIPZ3XwqMlwLiNj5cHc4AOisGILZJ9xRz9B7K4FVBeqLFw9XcWCHIqKsDlb
         hMaQ==
X-Gm-Message-State: ABy/qLZHK+Wwd5xMtopayW2k2rzMRzaiebQ7H3cNp8Ejh1bsfhSPl/uF
        Qp8IHTRLxjZPHGUDp/hElcsUBA==
X-Google-Smtp-Source: APBJJlGXqrlH1L3HW/5n5DFFk+S3iCmieB/iM2I8GQM6MuItXN4lAIxlK+OxT+lcgGKQKjfcjjHvww==
X-Received: by 2002:a17:906:7692:b0:987:498a:87f6 with SMTP id o18-20020a170906769200b00987498a87f6mr875048ejm.34.1690358738498;
        Wed, 26 Jul 2023 01:05:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id jt14-20020a170906ca0e00b00992e51fecfbsm9380573ejb.64.2023.07.26.01.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:05:38 -0700 (PDT)
Message-ID: <1ad985f9-2738-8b42-a8e2-c2312ec57d9e@linaro.org>
Date:   Wed, 26 Jul 2023 10:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ASoC: loongson: mark OF related data as maybe unused
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>,
        YingKun Meng <mengyingkun@loongson.cn>, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
References: <20230726070648.700754-1-mengyingkun@loongson.cn>
 <174b4c41d10fa1b31821482ec737733ca4633464.camel@xry111.site>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <174b4c41d10fa1b31821482ec737733ca4633464.camel@xry111.site>
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

On 26/07/2023 09:20, Xi Ruoyao wrote:
> On Wed, 2023-07-26 at 15:06 +0800, YingKun Meng wrote:
>> The ASoC Sound Card driver can be compile tested with !CONFIG_OF
>> making 'loongson_asoc_dt_ids' unused:
>>
>> sound/soc/loongson/loongson_card.c:200:34: warning: unused variable
>> 'loongson_asoc_dt_ids' [-Wunused-const-variable]
> 
> Hmm, why not guard the definition with #ifdef CONFIG_OF instead?
> 
> Source text is first and foremost for the human reader, not for the
> compiler, and an ifdef clearly shows the condition when the definition
> is not used.

Rather drop of_match_ptr so this can be used also on ACPI.

Best regards,
Krzysztof

