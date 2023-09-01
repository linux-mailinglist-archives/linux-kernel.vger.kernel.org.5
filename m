Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB35F78F770
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348213AbjIADW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjIADWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:22:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D05D7;
        Thu, 31 Aug 2023 20:22:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a6f6a66e1so1263252b3a.2;
        Thu, 31 Aug 2023 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693538572; x=1694143372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBLPQzPIWAWSC+qsvJbFVdMdGKth1jrainH5lRp8kgI=;
        b=PxYZyy45AG/azJko5T+M6FV6Jt2iNtiyh70lkHW5QkwBzpVrH9TGvIK2aw9f4TKO+w
         ZPBQ7UI04HlhFEFlHQyLVuv7dJhz5+yYYviHoAdUEpFvttLkQpQ60NQTMgErEFk7wMFH
         YUqJRcrUcyVyRsL4wqC4TvFbkx0B7GJk3wPm9+4qNYG8QvJ80fSmgnf5tQNcnzlJ79BO
         b4ytOkKI3Df/r5SAvbZepqi63op8qn62cUTj2z4Pwf/nwVGjE7zqAwPWnHmRJ+hke/uL
         2Lffb+svEtH2odg9j0mcTTVgk5LjbleLRyeWzp59mkBhrG1dBVcNRym/D77KPFm1xbCi
         u3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693538572; x=1694143372;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBLPQzPIWAWSC+qsvJbFVdMdGKth1jrainH5lRp8kgI=;
        b=hZ3D8tKU2tNeVFbIzIrpLs9cP5gmr1BNAVTvTAESbWkCuhU9K2SRhe8/tadwgtVSIH
         mdqzwrYKUTCcnVHkUTrooIMHbpPD1FqQF7XpgoxTBSFmvU+LOxFQh3IrIHe94nZ0+oKb
         /bjl8jWki4UcRSeu8TCnFByIrcNDmIvDo0o7azZVh5/NKBgsn2HTApjrhbHUf07fcCth
         VyRoWFTq/zMS4BzCLbaG5f2JwGE/6TqpS3ImTKwp1n6aUnsKkMMqtgF/eQmbLB7JMTQu
         k+8QkbjCHFprMbmzKAWqX7F2x77eBGMZJlOmKz5Z8K8bIlD0tKhXVazJ3VQoqsVphJBj
         tBog==
X-Gm-Message-State: AOJu0Yxj7x53SYns7mNNPwRC225N2nanGjvKsfjiw4gXDQztr+6ExWJ/
        Jw0w/YcwRkR3nebYmZQFcdNiDlnAE4tFjw==
X-Google-Smtp-Source: AGHT+IF5ywUa7Qg+xJbjyDPhgXCzWKPknLqcwuD2RE4g0BKWwqAHqS2Q0t52zJrFjKRYQwdObFdUrw==
X-Received: by 2002:a05:6a20:6710:b0:14d:5580:8ff0 with SMTP id q16-20020a056a20671000b0014d55808ff0mr1193033pzh.25.1693538572050;
        Thu, 31 Aug 2023 20:22:52 -0700 (PDT)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902fe8200b001bdf45eb5b6sm1908358plm.284.2023.08.31.20.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 20:22:51 -0700 (PDT)
Message-ID: <ffe1aff7-5216-ce3c-d57a-1163731d1158@gmail.com>
Date:   Fri, 1 Sep 2023 11:20:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230831082819.4000425-1-peteryin.openbmc@gmail.com>
 <20230831082819.4000425-3-peteryin.openbmc@gmail.com>
 <7b241edd-4775-afbc-e5a1-63f5ecfce331@linaro.org>
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <7b241edd-4775-afbc-e5a1-63f5ecfce331@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/23 20:38, Krzysztof Kozlowski wrote:
> On 31/08/2023 10:28, Peter Yin wrote:
>> Document the new compatibles used on Meta Minerva.
>>
>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.

Thank you for kindly providing me with the information. It has been helpful.


> Best regards,
> Krzysztof
>
