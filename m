Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D6D80DA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjLKTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjLKTFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:05:13 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5F41BE;
        Mon, 11 Dec 2023 11:04:35 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4258e0a0dc1so28697961cf.2;
        Mon, 11 Dec 2023 11:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702321474; x=1702926274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Owb5uItYn8kw7O33SQIVp7iH4r7RmA4K+7xsYCtDFM0=;
        b=japufGkuh8z7FSQzrkHchaquwjde7uLTK+W3x8nLhn/wP+qDUAqjH90FY4O7dbVOJA
         TP3PSHdq1eJ11pM7JLtNVdFHwaEPlQP0e0P8e444AZHOyoWRO1++dKZwmShlTpag+NFB
         yVUwFyiUzsoZosUzihDkH69IgJqq4n0OJmUpv+tQzFoMS4EsYJtWOwz91U6HIpB9Ey94
         qfsl1s7KcGR/Wd2ZbXryOFUD/RM4XEB1X3jrdKtPjCRj7Ozdzv27Z9r4U/dza11QebQd
         73wt+/Z8+PUA+P2+YlC3oYVOQ5MMNYmgJLREoXSx1wNkJZqaxfrklSkp++nd7IQ6/5oT
         ErPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702321474; x=1702926274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Owb5uItYn8kw7O33SQIVp7iH4r7RmA4K+7xsYCtDFM0=;
        b=m4IYsf6hxIqqXU7zWo5OHXmKgBNS1W8n8qUreTAO/cMYUsAjmTShgDEvM3soiTL7KY
         2LsLQjujO+tTi9FvNfBFTPGEOytNJ2Qcad2vUjAPBF0qQHR48pZyQ+p2c8vHpXzh9t83
         4v6L3Cs+kzO4wZMXUxX+ZIazmSlP+KaWNv3ZmdvDHGE/pt+4kqCK6Ab1WXFlG/awMUTX
         0SKWrCexbMotCEg+07yyhdQKLcC0r4LfDcYNS2Tq4wEuJ+oAdeWeWZCW/1+nMmgyr/10
         B/1vFQPy+uSGvSLMDwSPV8WcjLc9n/56YO7zPdnv7iheLwYRElWzd346pbVYZFCYOVRw
         gqCQ==
X-Gm-Message-State: AOJu0YwSHFwCF8KN3iRLHy4LZAMYPdO6h/mQe1UtD+h/RVzm/MqnUOCc
        rP8SdmDv034bUkjojfuy5fc=
X-Google-Smtp-Source: AGHT+IFIEGUvFHVgU2aCwUnLKbRC8jwfxPyiHXos7n9wRbHv8eqC3u49v9pRWLhJFb2vVFjgm8Jq5A==
X-Received: by 2002:a0c:cd83:0:b0:67e:bc54:8df0 with SMTP id v3-20020a0ccd83000000b0067ebc548df0mr4599938qvm.127.1702321474058;
        Mon, 11 Dec 2023 11:04:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u8-20020a0cf888000000b0067acbd864e0sm3473069qvn.69.2023.12.11.11.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 11:04:33 -0800 (PST)
Message-ID: <1fd0d7c1-70e2-4ee4-89c7-b1085bf078c7@gmail.com>
Date:   Mon, 11 Dec 2023 11:04:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231211182045.784881756@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 10:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

