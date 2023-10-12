Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD67C6804
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjJLI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjJLI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:26:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4797698
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:26:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d834ec222so668254f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697099168; x=1697703968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLRauRBH4aeyVBgsUf72ZcduKD3CXNdCJpgoKyXaTzE=;
        b=DWWTnxuaZE2C8lwlcr9PnS7q6ZigOe1BG0QxFj88xJ4HpE8JsFM/Qy1R06Oel1EH42
         wA3mB6jDP4yBtxiR2zY2CqO9oJBM5dNbEeDsoIRd830olIxfIDu628iFzHWv3PVYckbL
         JZc4NOoTlPjFiISmkEaPfo29gX8o/EAOj8uBUnUmVCqpRArt0VTekLyUjc1ZhvMSTKnJ
         rOm3NTFlZCTglRHptNefxycIbU4HJI/wVnaLueoGJBhARNlttBOKUJIByHOfKCC/kznU
         eQnbvgxW7ldPC23xEubIq70qY73Ay4ZjcV0a49KJ2fM+sUknU1R3UifIEX5uD17fGyon
         /5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697099168; x=1697703968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLRauRBH4aeyVBgsUf72ZcduKD3CXNdCJpgoKyXaTzE=;
        b=e5JkOo2FP6tCQA3CL9W52KX5mUNcqz03B9WvoOWFFewCMYus5lf5nkp8IFmWe0QrY9
         dS1zhk+ls3NYqjE4H7zpndIIT5SRtFcnqhNe+FsNsBQhS+L6jCSG4xUbuGVaAWAj3g0Q
         9UDfaUt6LK7gRXJMr5c4n9IBzWy3AnI9K3cuLANn9ho+WBJ3GjYOae+Ni6KSZHz0iH63
         gsKeR7q9tS7Vqn4c+HRQpujLvdmilyjh0Ia/Aig2u39MBo4STV0r+NxOqn5UfL/L8kw+
         RMqLc6P82/Qkn8KzJ1nV5S3VK5F4upb4XyAG4kSOVoqW5Ui+QAWvG3ZXxgvH7dq+TYwC
         +f7w==
X-Gm-Message-State: AOJu0YypA8g/NcEHo5pNaW4biw3Ma4iYqp0Y88wKkr3Mje7FMWLPTPJD
        usX24w1wGocCQP4KZRhFd7Gj8Q==
X-Google-Smtp-Source: AGHT+IH19IstQl6QJ4VeBUsUqjZC9bJd1On8NmKj8/4J6ftXw7EApl15+f/UcbBvU8+71kCic6vXJg==
X-Received: by 2002:a5d:6e85:0:b0:323:10b8:543e with SMTP id k5-20020a5d6e85000000b0032310b8543emr19104792wrz.49.1697099167560;
        Thu, 12 Oct 2023 01:26:07 -0700 (PDT)
Received: from [192.168.26.175] (192.red-88-28-24.dynamicip.rima-tde.net. [88.28.24.192])
        by smtp.gmail.com with ESMTPSA id bu21-20020a056000079500b0032d829e10c0sm4618147wrb.28.2023.10.12.01.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 01:26:07 -0700 (PDT)
Message-ID: <c4167ddd-f30a-ba4e-c205-3eab53f02b9a@linaro.org>
Date:   Thu, 12 Oct 2023 10:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] MIPS: lantic: Fix pcibios_plat_dev_init() "no
 previous prototype" warning
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        kernel test robot <lkp@intel.com>
References: <20231010143406.974591-1-helgaas@kernel.org>
 <20231010143406.974591-2-helgaas@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231010143406.974591-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 16:34, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> After bbd8810d3998 ("PCI: Remove unused includes and superfluous struct
> declaration"), <linux/of_pci.h> no longer includes <linux/pci.h>, which
> provides the extern declarations for pcibios_plat_dev_init() and
> pcibios_map_irq() via <asm/pci.h>.
> 
> This results in these new warnings:
> 
>    arch/mips/pci/fixup-lantiq.c:13:5: warning: no previous prototype for 'pcibios_plat_dev_init' [-Wmissing-prototypes]
>    arch/mips/pci/fixup-lantiq.c:24:5: warning: no previous prototype for 'pcibios_map_irq' [-Wmissing-prototypes]
> 
> Include <linux/pci.h> directly to get these declarations.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310070445.tzRBNYRC-lkp@intel.com/
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   arch/mips/pci/fixup-lantiq.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

