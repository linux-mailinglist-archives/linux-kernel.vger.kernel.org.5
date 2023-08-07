Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A3B771A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjHGGSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjHGGS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:18:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4091733
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:18:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso63209571fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691389102; x=1691993902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ok4uu/XP4a2Y0d29uucrwqKlMMNRMzSfs207EGkhv1k=;
        b=MqgaC+gkaDl5iNPx9lmlXVPYxHC/IRAf0SNJ30pqEzjD+iLnPzu0OV/+0hE6jZJd09
         01sYD+D1C6Lm25UEikbRxQNnpocSOc3+20FBJntl8IcI+bLBLi7TdjQc8sUPjIR2sOvx
         mVscFa0yJeOGRQbxe755whnyjJFdNZMw/KhC+w9pcaT96+29BGbLvIleDF0s6WbafJUR
         2DSBh22Lggg+4cw2ehCGxYdZ1gvIp12/DpRAoYwPBH6sNO8SyU7jHVlrC3SsFnFmXWGl
         lqfAit6nBu1VaTJuAO/BOR0vGzJ9YGdfH/EE+dz4RVqTGpt0xlUAmWqcpiS4wkJhJAef
         r3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691389102; x=1691993902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok4uu/XP4a2Y0d29uucrwqKlMMNRMzSfs207EGkhv1k=;
        b=lmkK/3GPEf4tHroK7iE0t9LTIhcywoXeN2PGOjelE5LQG9IC2VAyugMH6MSF/9ROq/
         zRMSWPpj7BFsksBCJtzekG7DIFBJDFrMkYxKa18b+X2jJNnKc/suesLc8qp2x+t+aFZp
         BwVEkemo2csVmq0y3hy9JgN4bkgM7LuHPYq4cCGUWeZg5gleV3f1n/nugqD4nlalvvzP
         E1zX/AniraUBa7f3jQeLKemmegutmpgZB4GcjMAevfvsR3fi8CGWINnHkLuRtG9NKH+B
         XmKWR1Q6Zqz8FSev4KbHwSWO5DLYxIwYnNAcFriwuktGoboR9byNlZJq9iEB7YPGG7rE
         t6tA==
X-Gm-Message-State: AOJu0YzHdo/W74MkzQWs7h7CtLcvVR363/C0eSgn+q1kGG5lT/ZeK/Fi
        nmCgrqvgQ6+WxE7NjiASaYAn1A==
X-Google-Smtp-Source: AGHT+IF/eA5gnCaZ0FvMzg89QFGJdSCFfcX1ffb2bThrktFi83lpOp/Jfsm10T3HQj7PLV/2JeS8aA==
X-Received: by 2002:a2e:6817:0:b0:2a7:adf7:1781 with SMTP id c23-20020a2e6817000000b002a7adf71781mr6027875lja.2.1691389102222;
        Sun, 06 Aug 2023 23:18:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id t23-20020a17090605d700b00993cc1242d4sm4670949ejt.151.2023.08.06.23.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 23:18:21 -0700 (PDT)
Message-ID: <aebedcca-16a0-64e8-747e-47afae983715@linaro.org>
Date:   Mon, 7 Aug 2023 08:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v5 08/10] dt-bindings: net: xlnx,axi-ethernet:
 Introduce DMA support
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        michal.simek@amd.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, git@amd.com
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1691387509-2113129-9-git-send-email-radhey.shyam.pandey@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1691387509-2113129-9-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 07:51, Radhey Shyam Pandey wrote:
> Xilinx 1G/2.5G Ethernet Subsystem provides 32-bit AXI4-Stream buses to
> move transmit and receive Ethernet data to and from the subsystem.
> 
> These buses are designed to be used with an AXI Direct Memory Access(DMA)
> IP or AXI Multichannel Direct Memory Access (MCDMA) IP core, AXI4-Stream
> Data FIFO, or any other custom logic in any supported device.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

