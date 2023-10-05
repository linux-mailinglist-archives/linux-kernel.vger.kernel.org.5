Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169AB7BA5CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjJEQQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbjJEQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:13:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCC46A6D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:34:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so5992875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 23:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696487656; x=1697092456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAGnF6ivb9XCkOa0cJSmkl42J0d0u2NBYDWoXIvrcGA=;
        b=L5IV3LnWLMZdlbi5AOr0h0w+p/Rp4qQU3q1CD6x1KYACQ0tDqvYuqMY8nr/Tvvltml
         J5UzF1aaYEAEEoENq7j20LRzJepLoYzZMsdRQ4LXnCmoyIPO1Qbz7DZjPiVWttOptOp7
         k8htvW9bEdmnkxF7O73midHTCeI7ZiMQhsFFCNe00v+8kXo6R3slyrk/HcDqTZJ/0SJO
         h7d+yqrBIzVT3O7KOu+5aq9tYnl+U0kX3HJb/n3ST9bT40UZSq+qo2Qy1HYjsqxM5TYC
         KMVcVz/zxnq94NcYlSTr47vY0jmXPF7v6RASjf6fZTUHK2XqTfmtKEbY+fH1Pg2SIr2w
         ns3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696487656; x=1697092456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAGnF6ivb9XCkOa0cJSmkl42J0d0u2NBYDWoXIvrcGA=;
        b=ZHXNFvK6o/teF26teb5zZYgVgcslKjdT7ntAontJECUHNNus4bYKcjxZEa80s42/Td
         pNGiNhPmhO/JjoBgNkxQIyaQWM2WgWAv6+k7FkpEjJmK2JvdEAUY1R0Cfyzoy7VO5S7E
         ILBtpo33F8+QSFSJjedYBrNK1PjKWqnZbq/sEk3cSOa+MFHzzvUo4gFmYN10vPYG7pQh
         UzhCWSHLVMAUVlImYkAlZA3dFX6jcf7AMaHgPIGfv51W39jfefcBI2/76tWl5uC3VXnA
         tjLGMhRxjES9K+xyoG9mMW3GS8xNQ906SAfqrwk3s1uIJ1nIahcxNwJ3PCj0ievichtN
         n90w==
X-Gm-Message-State: AOJu0Yzjf6eBvGgpecXF7PXmFFoxihd8LC6ctG05Fihl1zXPnevg/XVU
        YXmdWaECQm3tYu+fcipuNK0hHg==
X-Google-Smtp-Source: AGHT+IHfu1g/GRdrcugnUpqlXYMQCy3BPpNW7d/xBS1RRTEcQ3OcEzpLb8O0GphuzAvpN62W7P2H6g==
X-Received: by 2002:adf:d08e:0:b0:319:74b5:b67d with SMTP id y14-20020adfd08e000000b0031974b5b67dmr3741813wrh.66.1696487656662;
        Wed, 04 Oct 2023 23:34:16 -0700 (PDT)
Received: from [192.168.69.115] (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d60ce000000b0032763287473sm946899wrt.75.2023.10.04.23.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 23:34:16 -0700 (PDT)
Message-ID: <9415563e-1429-8bca-25e2-12b474c3c5c8@linaro.org>
Date:   Thu, 5 Oct 2023 08:34:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 04/11] dt-bindings: Add vendor prefix for Mobileye Vision
 Technologies Ltd.
Content-Language: en-US
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=c3=a9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-5-gregory.clement@bootlin.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004161038.2818327-5-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 18:10, Gregory CLEMENT wrote:
> Mobileye Vision Technologies Ltd. is a company developing autonomous
> driving technologies and advanced driver-assistance systems (ADAS)
> including cameras, computer chips and software.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


