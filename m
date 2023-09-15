Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFBA7A1FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjIONYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbjIONYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:24:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FFE272C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:23:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a64619d8fbso279546066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694784227; x=1695389027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1U96v2df/GCS7HRvhdN4EdRezxa7IYKwHOpPeh6hRvI=;
        b=OX5/o2SfUDZzte6E2Fms4S38dZjkUlYBOY6m5IaZGBwMYwwhMXJ9JmYQ6qTTiGAHQS
         HxJIXd58R3JnsTtOF+HO6CcB5XZ2eeF/BbzD9TgS1UL5ZXYP+FtU5OkZHrsno96SBYjq
         4jhbXAfltQDyQwVDMfZoQx+PfRGO+boaGYzMlIrUMNKP6S5LbPp/xo+muxhG0R8Tte9Q
         sBBw48xHDDKkKyMr5DX/keWtZrknSdmL23SUyBnm1bs1fUo0IZgJmevyaJTiP7AX+GLO
         y5cfAKCzEQ/Zp++//J0RYC9Dx/AzJKGQJmsj1KTDOJwUh5Cs/q6yMUtLvNkFlOKeqtRS
         SMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784227; x=1695389027;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U96v2df/GCS7HRvhdN4EdRezxa7IYKwHOpPeh6hRvI=;
        b=GKxWF0BgPTZGIpnp4rimY4C7nvRT5uJSMScJNH6S/iiEl6IQM8TIfFWHC/CvKkpxUw
         9SNEASDQly1277VtHdr0a2o1ZJv8ibHiauXd9J2bdaYkfFCWN3JdTtJvmKk2SGgakGq8
         nvp0Kzly66DRElYfSRcPkcS8YDn/bvS2D/MC3X6iGUveSwed4P8qLXcJvtZ5MbglXU+X
         zCu5wk8cGUH41NkNX+gM8zCU6DVg8R2ieykb4x0s1g0EbxtcfgUYRrGYFJFCWri9yOkQ
         6rxHBrhQXe8TKQLW7zhCKJi8mIRstjgK6oHg3HmvP3xSeM8mfsJ1/wFox3XSNbTNvIe/
         l2Tg==
X-Gm-Message-State: AOJu0Yz7kWmCzrxCkNaqhbPoDOrNPmIqAaBn/w29q5IJ0PEyapmPoLVD
        vQ9n1TOtVbw/7FeFLnvX8ZTbRA==
X-Google-Smtp-Source: AGHT+IHJb4HtPGUePL9mUs+HJqXER2fgOPpx0hOjcuuKj93Ug0wBvTft9KXdW8nwYNIXmes1SpZBiA==
X-Received: by 2002:a17:906:76d0:b0:9a5:9305:83ff with SMTP id q16-20020a17090676d000b009a5930583ffmr1500146ejn.18.1694784227395;
        Fri, 15 Sep 2023 06:23:47 -0700 (PDT)
Received: from [192.168.69.115] (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
        by smtp.gmail.com with ESMTPSA id fi8-20020a170906da0800b00997e00e78e6sm2419215ejb.112.2023.09.15.06.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:23:47 -0700 (PDT)
Message-ID: <f69ac27a-943c-3966-385a-e12ecd71d33a@linaro.org>
Date:   Fri, 15 Sep 2023 15:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/3] Move Loongson1 MAC arch-code to the driver dir
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
 <ueevvju7i42wik6fevdmvbtypm4su77guyo4zizhrfreexken7@nrcovxfnyuvq>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ueevvju7i42wik6fevdmvbtypm4su77guyo4zizhrfreexken7@nrcovxfnyuvq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/9/23 11:55, Serge Semin wrote:
> Hi Keguang
> 
> On Thu, Sep 14, 2023 at 07:44:32PM +0800, Keguang Zhang wrote:
>> In order to convert Loongson1 MAC platform devices to the devicetree
>> nodes, Loongson1 MAC arch-code should be moved to the driver dir.
>> Add dt-binding document and update MAINTAINERS file accordingly.
>>      
>> In other words, this patchset is a preparation for converting
>> Loongson1 platform devices to devicetree.
> 
> No more comments from my side. Thank you for the patches and
> especially for the patience in the review process.
> 
> For the entire series:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> * I'll also send individual Rb tags to each patch so b4 would be able
> * to take it into account.

Maintainers using b4 should use the '-t' option, then you don't need
to do that:

  -t, --apply-cover-trailers

  By default, b4 will not apply any code review trailers sent to
  the cover letter (but will let you know when it finds those).
  This lets you automatically apply these trailers to all commits
  in the series. This will become the default in a future version
  of b4.

https://b4.docs.kernel.org/en/latest/maintainer/am-shazam.html#common-flags
