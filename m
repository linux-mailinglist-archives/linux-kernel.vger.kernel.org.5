Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB07C686F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjJLI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjJLI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:27:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A55EA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:27:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405505b07dfso11486675e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697099238; x=1697704038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKF5RslixwYnF6NPB4Ue0u9mlsPBwuiyecdU3j9RLbY=;
        b=MY4DzKuh7sFgf51ws0JXckF/Y1gZxS86OdCuGnwP+T9fVEr3qdsycgtZc0aZg+qFdG
         6psTBN/+bTpQAI0SLRozAMiJYElAmTbqrDRRpu4ytpzpliM4HIS8HoPbXuDKYOQpEKGU
         gKk//gju7UBE5lxjnfrorwxFVAnZTcofvP2jxPsQoL79NcF+8vD8ui4qKevLQ8MhnQqp
         eYwBTcqj9UVN/tM5Cgc9YzsVzXW42al4SJwTm1szLxGwddRHepDeNDjtZm2eN9lE9p11
         bYUoBQtnhge3XGxKXHY+kfAZ0U1t/Rjfb7CjA0PClzL/BVQ8pFTGrD6DbqO4WJFrzeAR
         HqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697099238; x=1697704038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKF5RslixwYnF6NPB4Ue0u9mlsPBwuiyecdU3j9RLbY=;
        b=WxwPeFqgm1YH3/Z35fTTleSaRcv9JrLFJOB0cAc73A98u968Ti4Dup6A8KOq3Peapd
         D/wZZio9oQecjQ6b9+tFo4a0aMYAN1AZ/4Dp1tdSKe6uWizJ+9WE7C/LnSV9rek1X2Fz
         s/u2bDlEUjv/w8mQVtSY14laVcDGMt/ha8mhqrOgw6K45/sxinJN1dq+EQpsay31oXdw
         4ZQDtYzgL9/2Gvc1yFBt955k/txKjAFpBhf19e9hGkGrMJwOTVHNF1T7w/98Ncoy+ZZ0
         gsX9AG/mMavMyr2gyYNlfvhXUcJu74kr46eis6qTFDtDtvMr1q2pq0xhLFvrpa+flLNi
         tsFA==
X-Gm-Message-State: AOJu0YyZ7UJp7q7gAlgl69rdcZpCNKSwzFLJ23GHCL9OOuU7fL/Dbi6v
        CglH1kFYc1FxwRPx1326A2K2OQ==
X-Google-Smtp-Source: AGHT+IEjzZvXcXRm2+veFG5eaSipzgiDaC1Jwb5jV3NKZvmZjWHZ6hMMW0VwInEKzbbcTSrNVgG3qg==
X-Received: by 2002:a05:600c:4f02:b0:401:609f:7f9a with SMTP id l2-20020a05600c4f0200b00401609f7f9amr17836673wmq.8.1697099238097;
        Thu, 12 Oct 2023 01:27:18 -0700 (PDT)
Received: from [192.168.26.175] (192.red-88-28-24.dynamicip.rima-tde.net. [88.28.24.192])
        by smtp.gmail.com with ESMTPSA id fl16-20020a05600c0b9000b00406847c988asm21175473wmb.12.2023.10.12.01.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 01:27:17 -0700 (PDT)
Message-ID: <529023a8-1c13-beb4-8c71-0b3e4ada24f1@linaro.org>
Date:   Thu, 12 Oct 2023 10:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] MIPS: lantic: Remove unnecessary include of
 <linux/of_irq.h>
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20231010143406.974591-1-helgaas@kernel.org>
 <20231010143406.974591-3-helgaas@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231010143406.974591-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 16:34, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> arch/mips/pci/fixup-lantiq.c requires nothing from <linux/of_irq.h>, so
> remove the include of it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   arch/mips/pci/fixup-lantiq.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/pci/fixup-lantiq.c b/arch/mips/pci/fixup-lantiq.c
> index 8f5fb98b3984..13009666204f 100644
> --- a/arch/mips/pci/fixup-lantiq.c
> +++ b/arch/mips/pci/fixup-lantiq.c
> @@ -4,7 +4,6 @@
>    *  Copyright (C) 2012 John Crispin <john@phrozen.org>
>    */
>   
> -#include <linux/of_irq.h>
>   #include <linux/of_pci.h>

Indeed, we are good with <linux/of_pci.h>.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

