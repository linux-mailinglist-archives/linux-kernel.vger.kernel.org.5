Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481577CB35F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjJPTfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:35:49 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41192AB;
        Mon, 16 Oct 2023 12:35:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5ac87af634aso1860116a12.2;
        Mon, 16 Oct 2023 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697484941; x=1698089741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOJxXXeBtjc0spitVwBsAGSK4WaERY8PQRMb0100h7M=;
        b=lHbVum0urCeZlVsKDXMtf9CAmwEMCkmTYCKKKXvVGPzY9zmblbr5mQJxGV//XxiKp6
         cpYlNVYbee040ixn68kHFNomWPLEfMyyMIFJd4k3RBeh0QoNO43/Sy2oVB8kye5SVYXQ
         AawvFrbWX14MeOuMOfM6Hh1O9jiWM3iPK0Cf1zmIFUf7Fds6mZd3v3pxfNGG5RMod3yE
         SxytZZs28vdeURLJ65iIEfSwjpbvVl9pYHy5e+8YNUy6I9CJ3nLUTF/yA90JSkZt/Fyd
         xCZgZffZxOGbfMCQbBkqrKsF1URUGokOj55X3Sp1m2h8HzHpycMEeAxXFZpnth/RAvhP
         wBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697484941; x=1698089741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOJxXXeBtjc0spitVwBsAGSK4WaERY8PQRMb0100h7M=;
        b=Y7xUGphbKvXO6CQh3WpjvD+8tTgI9IABceXMfk+XTGoKD8n6zzzaBZnAChQ98DCLpR
         21ZdPqSecUHlpZRGlBtgmhA4/eCrilpwySI+/KYvkl7hsIMgFzL38o8E2OXvTE0pqyvG
         nI59Ey68XntxFZXB/Yv0HaSjVPsbYnJhGrKjeFYhJ2Y5vS1pMlGMGo1dW6czkCGgEoMl
         G8qrKms7EHwLSJou0GgSneP6VaWtaySndGeWvnuni71rpOWC9RpkhPmdhfKMVzmTxtuB
         VPt6cqPhIRQNOZ/WlyUjFIKOnAK1xQRT16neOcMG3CO1rg3vaG+9m38JhW7+zchQnvhZ
         wKbg==
X-Gm-Message-State: AOJu0Ywfkbehhd7fEsLq45ryK1qoa4E8O8InTptnRhrfeVYCWh67mnPL
        0PZ8slY+QGfmWDwwxm8I9Uo=
X-Google-Smtp-Source: AGHT+IErO7JHvJXX9sU4QBFDKVtFr9LGVWDF8mau/ICaxo8dHwmUqFSgMuqNQN5D2vsct6Lww2q+uQ==
X-Received: by 2002:a17:90a:77c6:b0:27d:2109:6279 with SMTP id e6-20020a17090a77c600b0027d21096279mr110007pjs.12.1697484940556;
        Mon, 16 Oct 2023 12:35:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id go6-20020a17090b03c600b0026b76edd607sm5181577pjb.15.2023.10.16.12.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 12:35:39 -0700 (PDT)
Message-ID: <17ddeb79-b5c3-46b9-ab59-0f1918b8de95@gmail.com>
Date:   Mon, 16 Oct 2023 12:35:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/191] 6.5.8-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231016084015.400031271@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 01:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.8 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

