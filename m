Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8278566F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbjHWLIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjHWLIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:08:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5FACEF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:08:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so745351766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692788901; x=1693393701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13ZiGAbaPI1bJ6e405gOO4diSQC4pPB1YKTk8I5pazg=;
        b=pEUttLFM9xcLVYRmZhUVb3fwHeOXyoJkqOjYQz6TgHgU8kswvgpe2wRvcocnFbFaiw
         dajllE/4xQ/3UaYoW3jL5H/zrzwXu6KSBNbct5VIsAPRQBz8MDzUHrCQfhP697BKuz8o
         pXUC7keQGXUiZffjVrBt691gOZrtHimGVcq8YaTpNUgIYnYj28VtX7bRxAC9wgZychg6
         /rjopibEDPkuFaW9iTqvQutl7pB5rEAeL+Etsp1XitUC+w66Hd5GbGNp80tlu/WyH8NG
         0qXWOCRu8xeHRpBiC2BwleSxLioxge/v1E8hkGCgzXPTMalyJaM9XJe8kwmWhat5UB8y
         Otaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692788901; x=1693393701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13ZiGAbaPI1bJ6e405gOO4diSQC4pPB1YKTk8I5pazg=;
        b=VdGbAZuRbzDVDrQlS6JeyjKFWNFTqfL0YXkrA4Hx2NzLQUhgwb7WtXrVDCxjs0rxcb
         I65hpydosiQVxGPlbFE6IXqfrOPNWR4/u/+iYHLbDjVv0YlnVEK4mlMXU+LU6WB5DNFE
         36qziMtV88jaiwrvDnBAJTNvzMjRNWv8qB+Yd87uzVGHHC0UF5vvoyRcDpMmgi8FnkyN
         oHF4dmAJlSTp+AIRDsrS0NM8lsR2+jNUfoTw6h4ptXvqvVKGbClTTcZNVEhjXja4FKAU
         16h8og8apAi3hIAxdtHt6zlsEK0q65x0extPY7OcOCfsAoNGbQn5uC9Vic7pQyfyalXw
         XyLA==
X-Gm-Message-State: AOJu0Yw5OvA1pKPlTlH7G9eqPjMf7AcU4SROcbOdkY5Ts3rYszRrfzgD
        fmXR4k7Qg7aREqjyrnGyBSJCmQ==
X-Google-Smtp-Source: AGHT+IFPpc/M9qEHjj5tV+w9O5JQwtSamWghJvL0uJZa7j3GJ3omdOLx5vjTovj6fvUU6krRyeBONg==
X-Received: by 2002:a17:906:24e:b0:99c:c8ec:bd4a with SMTP id 14-20020a170906024e00b0099cc8ecbd4amr10548084ejl.60.1692788900696;
        Wed, 23 Aug 2023 04:08:20 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b0099de082442esm9656576ejb.70.2023.08.23.04.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 04:08:20 -0700 (PDT)
Message-ID: <3506906f-7a89-c90c-c753-c330fd33d68c@linaro.org>
Date:   Wed, 23 Aug 2023 13:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] net: dsa: use capital "OR" for multiple licenses
 in SPDX
Content-Language: en-US
To:     Kurt Kanzenbach <kurt@linutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
References: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
 <87h6oq9k9d.fsf@kurt> <601f8735-39ea-7579-0047-3d3358851339@linaro.org>
 <87edju9ggi.fsf@kurt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87edju9ggi.fsf@kurt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 12:54, Kurt Kanzenbach wrote:
> On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
>> On 23/08/2023 11:32, Kurt Kanzenbach wrote:
>>> On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
>>>> Documentation/process/license-rules.rst and checkpatch expect the SPDX
>>>> identifier syntax for multiple licenses to use capital "OR".  Correct it
>>>> to keep consistent format and avoid copy-paste issues.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>>>
>>> Side note: The SPDX spec in section D.2 says: "License expression
>>> operators (AND, OR and WITH) should be matched in a case-sensitive
>>> manner.". Should is not must. So I assume checkpatch and spdxcheck
>>> should handle both cases. Especially because:
>>>
>>> |linux (git)-[master] % git grep 'SPDX' | grep ' or ' | wc -l
>>> |370
>>>
>>
>> But "should" denotes preferred rule:
> 
> Yes, of course :).
> 
> You mentioned checkpatch. But checkpatch doesn't warn about it. Or does
> it? 
> 
> |linux (git)-[master] % ./scripts/checkpatch.pl -- drivers/net/dsa/hirschmann/hellcreek.h
> |total: 0 errors, 0 warnings, 0 checks, 321 lines checked
> |
> |drivers/net/dsa/hirschmann/hellcreek.h has no obvious style problems and
> |is ready for submission.

Checkpatch checks licenses of only some files, so maybe I should change
description here (it's you know, copy-paste...).

Best regards,
Krzysztof

