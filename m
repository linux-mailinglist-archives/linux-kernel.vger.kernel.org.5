Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F65806174
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346428AbjLEWK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346604AbjLEWKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:10:55 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CF31A5;
        Tue,  5 Dec 2023 14:11:02 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67ab41956f8so11195036d6.2;
        Tue, 05 Dec 2023 14:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701814261; x=1702419061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hiHYrWLVsQ4xi96qKilwHGdyOD8NQ+GmXlpe3R+oL10=;
        b=nT9L9bJxuTmIJMhfXvrPipfexjRnhEQbFM3h13RuhdzJ+QdS2Y1P06sBrrrViM7+xT
         ZrmezlSqmZPewvmfhF1cnLUcttTPMAd49sKU9iKMcMCME+SPk7E4cTtL6b4PdGI7hSx/
         q2I++ay4VC14XapE6u7Qk7iZCb79JtiQv4/iTNbNFYk/HUp1QJSKV1syMnsODNL9RV99
         oy3saqYtVNlzjfW6MvmdNawiyxg0UlRzuuwLnKdLolX2uAK4+hvJO9v2I1egSyuFmrwH
         CDnZffA9mvHwzS7/gmqgMCCReruaZpAeGQDkaNgvyq0aUVxem6ScLCnp4W9SNvYnLPvN
         1/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814261; x=1702419061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiHYrWLVsQ4xi96qKilwHGdyOD8NQ+GmXlpe3R+oL10=;
        b=eOEu3va0X8yruM2tQTkT4jnIt8+o7XWgFd3aBgUB+atTAgOy0IfcXMjBSQneKsx8+m
         tdWwlCHdKkL07Up0RJs7a9AwIc5I9N/e9qkTSFMiK05IuyM+5/dLSzQwUfUor5otU68e
         37/i5TOO+W0VILR72HEwVHRuv7MkLwXt9BUNS7SJoGLARSoZDffmjN4hQaXPxcQkl2TN
         qvIXUHxfsGIH3omXfBIPZpfhPo4JrV5Z52rKTnS5xV3lci1sktu+7ufnigcq6C1V1yRq
         njSujgHrhQrOzQxDtApMrae/rPD8HUNabg3Yj3d6T+1q4pJ+Y9BpSLDsvq6jVvHjqRXt
         z/uA==
X-Gm-Message-State: AOJu0YzZERPgWHtZEeTc1dr3u77WgwQO6DNrVzp/9tzRfoNEqDBqJvEs
        EjIpVPZEfpOBQCPX9raHKFkH13noJe8=
X-Google-Smtp-Source: AGHT+IF+mdfV+A5byHRDJyw7Fl1+njvyzE+4VwQsv0XG5ecPxbVjutByKhU53pJtzwDxC5jgIepBKQ==
X-Received: by 2002:ad4:4090:0:b0:67a:a721:ec23 with SMTP id l16-20020ad44090000000b0067aa721ec23mr2012694qvp.103.1701814261044;
        Tue, 05 Dec 2023 14:11:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bv14-20020a05622a0a0e00b00425406b64a1sm3709864qtb.24.2023.12.05.14.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 14:11:00 -0800 (PST)
Message-ID: <ee7deb44-a48d-4a91-a137-3c7d2ff95246@gmail.com>
Date:   Tue, 5 Dec 2023 14:10:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/64] 5.15.142-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231205183238.954685317@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205183238.954685317@linuxfoundation.org>
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

On 12/5/23 11:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

