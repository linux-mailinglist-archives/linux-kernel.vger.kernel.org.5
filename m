Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9827C663B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343618AbjJLHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjJLHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:15:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892689D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:15:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so2303525e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697094949; x=1697699749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXCX0IrmSUAHDEC+IloTWKmfzlKX5kVqCGXqvzJraC0=;
        b=hDewP4PBYrmftFZlJqTRZmmPM0wynRvkFH2AGWmNpEZHaOsLRKLPEXJk2Tluu8W4VF
         an+V7rFmrvY87N4lgrz89l0QUTg+20sBENn+UzLtJ5pY056y31F8HWYjUwAJ/Wnl8Flz
         sEMeIqNFs6k4HOSq0h9QQyYKRSO8Gbo60vlZesG4p0PhzwPto+FL41/kIl9jtyW0K7NS
         ly0QLU7gL9E8XvHWblRPfpMngjlcR+I52lnnO1l2nX+J+myiTcNx8S+5bLw3YuS/iwP1
         tzlqhZNfQ+hg+/xSOF6NhJrdnK7K0TtEvhBzeVrEjlQT/SY0AwBpLUxZpHx/pHjt6H+F
         vb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697094949; x=1697699749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXCX0IrmSUAHDEC+IloTWKmfzlKX5kVqCGXqvzJraC0=;
        b=G5CsQxmSxLR4pGIXU0nd/hUPPwxeLMc0ytzzFwLCCoQrm+I+2RFK0fovYIcvYMz1Op
         u3dF2CWG4Bp1xr4em96tMcKk9vDVwY9UlEoVf3F33UGgjApzbNgXMD8zX7m8TDzbv/uD
         zHkTE8NTVObYa++d5RDbg8kVNNAJ9EXV58VZcT8yYz8Luf6mkVoTVy8lV5Jq45zh1Bak
         RvWlP1RKDrKUoaKeqFrNkMlUgfFyNVcCC/sto++wnYo4fAbS8DZ72lXFeqF/xvNDOhmy
         6yGjYCTeBj0um44qHiM9ygCxOZsB6TGdqMlPxTghIO6oiidLbWQW/osLGaoTrgRPOviV
         Y15A==
X-Gm-Message-State: AOJu0Yx4+Jx3nBJbvB7RkICGd6I+1vE8jtYo+HNBSLVnmBj+EqSft1jh
        b2mEWS1sYSMAR2QRwfKRzFBKmw==
X-Google-Smtp-Source: AGHT+IF8ZVCCfIFHscwR+LhyeBNqMXqYxxa5f++Vy8Gg5L6iDKMU8VQSX5qkaLQ8psvTbqv+62pjxw==
X-Received: by 2002:a05:600c:214f:b0:406:513d:738f with SMTP id v15-20020a05600c214f00b00406513d738fmr20891443wml.2.1697094948360;
        Thu, 12 Oct 2023 00:15:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:3fed:c1e5:145f:8179? ([2a01:e0a:999:a3a0:3fed:c1e5:145f:8179])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc450000000b0040536dcec17sm20897533wmi.27.2023.10.12.00.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 00:15:47 -0700 (PDT)
Message-ID: <11d6a463-4e00-4407-9d93-2f9d190c4be3@rivosinc.com>
Date:   Thu, 12 Oct 2023 09:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/13] riscv: report more ISA extensions through
 hwprobe
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>, Conor Dooley <conor@kernel.org>
References: <20231011111438.909552-1-cleger@rivosinc.com>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231011111438.909552-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On second thought, maybe it would make more sense to squash all logical
commits together (dt-bindings, hwporobe, etc) with all the ISA
extensions in each. Tell me if you think it would be better.

Clément

On 11/10/2023 13:14, Clément Léger wrote:
> In order to be able to gather more information about the supported ISA
> extensions from userspace using the hwprobe syscall, add more ISA extensions
> report. This series adds the following ISA extensions support:
> 
> - Zfh[min]
> - Zvfh[min]
> - Zihintntl
> - Zvbb
> - Zvbc
> - Zvkb
> - Zvkg
> - Zvkned
> - Zvknh[ab]
> - Zvksed
> - Zvksh
> - Zvkn
> - Zvknc
> - Zvkng
> - Zvks
> - Zvksc
> - Zvksg
> - Zvkt
> 
> Clément Léger (13):
>   riscv: fatorize hwprobe ISA extension reporting
>   riscv: add ISA extension probing for Zv* extensions
>   riscv: hwprobe: export Zv* ISA extensions
>   dt-bindings: riscv: add Zv* ratified crypto ISA extensions description
>   riscv: add ISA extension probing for Zfh/Zfhmin
>   riscv: hwprobe: export Zfh/Zfhmin ISA extensions
>   dt-bindings: riscv: add Zfh/Zfhmin ISA extensions description
>   riscv: add ISA extension probing for Zihintntl
>   riscv: hwprobe: export Zhintntl ISA extension
>   dt-bindings: riscv: add Zihintntl ISA extension description
>   riscv: add ISA extension probing for Zvfh[min]
>   riscv: hwprobe: export Zvfh[min] ISA extensions
>   dt-bindings: riscv: add Zvfh[min] ISA extension description
> 
>  .../devicetree/bindings/riscv/extensions.yaml | 127 ++++++++++++++++++
>  Documentation/riscv/hwprobe.rst               |  65 +++++++++
>  arch/riscv/include/asm/hwcap.h                |  21 +++
>  arch/riscv/include/uapi/asm/hwprobe.h         |  21 +++
>  arch/riscv/kernel/cpufeature.c                |  21 +++
>  arch/riscv/kernel/sys_riscv.c                 |  53 ++++++--
>  6 files changed, 294 insertions(+), 14 deletions(-)
> 
