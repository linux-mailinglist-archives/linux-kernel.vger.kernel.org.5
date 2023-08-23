Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30171785490
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjHWJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjHWJr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:47:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D05E54
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:47:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso8173758e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692784041; x=1693388841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJYxY9EKyE3nWLrlKwhz/hBGJk5NPLW4fkCZ4lrsGEw=;
        b=bw5w4gl/4vvhu25m5/SOpPCnGec9H3hlKTxmBMwAlXDijKxzcKALGzp/upD4QCDV2E
         YcgEph4FhLWEOwsgMOtu1c0+NuwvyLsPlz5FhF2i63t7TYZYDKVt4PhSxrci4zeN0jKL
         gVuIKzEWDBqOkZa6pw0jwXd5x6CnAqGrIS3IQhxS7UmTlg+qECFn8+gXt1CzixRyrbI/
         Wj7RnpKNXU9tPd2wI+HeqamGI/5+pBAhkLmzfGMOZWisH97vY50a65l7i8D9JMdsltZf
         Hlihoe4ka/yTWi+diQbqKGJ65AU06iFHtSIXYUVQipIvK/9bJ1789qiiIUXiRmZwaGef
         mjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692784041; x=1693388841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJYxY9EKyE3nWLrlKwhz/hBGJk5NPLW4fkCZ4lrsGEw=;
        b=ei3t4RpksZdkgSobHfl05YICJecDiZ2dfEu5aHJmdUwN+fTLpfg44/HeAORpoloDWo
         4sYY3qRPzw1P036R/k2jp1z/CoJuqbGcE7l0UzgSO4KzZ53jpo4jSGYVMXIxyDj11meI
         4zcDJHHH8jid8IbL4qV2O3Q1bTgrJjbCpB+rIdy8upNhXqxcB1ww6ccabs/40Gttv8KE
         jx8Kmt09qVwtGkQh1fOrwO3YxVWq2KsVh3gUTU383RAX9mQpd/MN5XUu8GusVI4dBWQw
         +n6Yqzxa6sjBJ4c2iZaOzOpP0ged4VoIu8UL+1AzbOpOIW/zZ9cXdT4x7BCEod/srkeA
         KMWw==
X-Gm-Message-State: AOJu0YxLJTdmHC3GrjmLBJZz3+ZecjFt+ks9A5T2aCtTtAFNxKULft8r
        kRNxOmY+xY+t3Zz08qAHNkc3gQ==
X-Google-Smtp-Source: AGHT+IE7cysoJxUCYOrYxdZSwvOf4+Tr5mGAWORNPlXqqK8SIWiZ5/c3SimYFa8oVbbcvbfQe/rYeA==
X-Received: by 2002:a05:6512:3b9e:b0:500:9a67:d40e with SMTP id g30-20020a0565123b9e00b005009a67d40emr192736lfv.60.1692784041188;
        Wed, 23 Aug 2023 02:47:21 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c4-20020aa7df04000000b00523b1335618sm9078804edy.97.2023.08.23.02.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 02:47:20 -0700 (PDT)
Message-ID: <601f8735-39ea-7579-0047-3d3358851339@linaro.org>
Date:   Wed, 23 Aug 2023 11:47:19 +0200
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
 <87h6oq9k9d.fsf@kurt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87h6oq9k9d.fsf@kurt>
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

On 23/08/2023 11:32, Kurt Kanzenbach wrote:
> On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
>> Documentation/process/license-rules.rst and checkpatch expect the SPDX
>> identifier syntax for multiple licenses to use capital "OR".  Correct it
>> to keep consistent format and avoid copy-paste issues.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Side note: The SPDX spec in section D.2 says: "License expression
> operators (AND, OR and WITH) should be matched in a case-sensitive
> manner.". Should is not must. So I assume checkpatch and spdxcheck
> should handle both cases. Especially because:
> 
> |linux (git)-[master] % git grep 'SPDX' | grep ' or ' | wc -l
> |370
> 

But "should" denotes preferred rule:

git grep "SPDX-Li" | grep " OR " | wc -l	
7661

Best regards,
Krzysztof

