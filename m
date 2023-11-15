Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4577ED801
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbjKOXMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOXMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:12:50 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7598A4;
        Wed, 15 Nov 2023 15:12:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc316ccc38so2112365ad.1;
        Wed, 15 Nov 2023 15:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700089967; x=1700694767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TzHkXurTXiuoLmd0INQVFVSX2Z2pNe+xxd8p54D+3E=;
        b=c76JcrV1j5OUgInyj9Iw4EMyFmK9Obv1GWjr2m3EcS3uxirxxmO/wBQmSwmEqI2uGf
         E+t3Td1ZoMwnCkm2wCnwTQTd7L2Q+6pnfv/iF1kRHiU5Ll4T6Cgyylu56E1nu5RM2Ztu
         xkj9OdMPbysRK6WMds7HwcqE3z0qvTcnmZzdqYgbydo1htyhBbZzJK+FenIIWiP4z6pl
         TwJq/S9CMQ4dLpMlUMH4rzEXAunm/lMjvKu0zVh+7A0w5hPtee8mp3lSzbZL81C1ssjS
         aVpICbafUMamOe9D9psHOqjsPxqDxHPy519WMSe6IhxjmvqAm6U8drTU15UVTlculljE
         nY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700089967; x=1700694767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TzHkXurTXiuoLmd0INQVFVSX2Z2pNe+xxd8p54D+3E=;
        b=sIdszXFS6Q9vUg6vmAaffgissLE+dlg/KXg7kWZPDvqBMhqqA4pqBEsPVye+9AZjLS
         DTd7cCIVrV95023BmojFOZwooMANSFnBY4CFWLsnAitnS+R0s1oUvyO+ZfAAEzWY/FL0
         2MbkpRQLEeXp2Lry7Wj3ndc68vB6eKH2OQ5bmEsYQdKfoE1FEXzhW/eoZiHHnYTrd5jj
         30TNbOhsElReEhD1tJSWBZCa+Z/RmHOCWdbrLaJ9v/Chxig9Ph6S2Z0NRUu01cBQ2Kok
         dHsR02knF5GBVLT6VogAtGs3LVNvujFMxrnb0nhkvqLEGaWX0lE5FtfrLAowOB0Jnl0j
         aa4A==
X-Gm-Message-State: AOJu0YxEldN1E1ir031+S6QXufWZthD75zO6PgGIv2G0VHsezA2l22SH
        sXeysoL8I0DLJTKyljAxw4lFsyaNVxc=
X-Google-Smtp-Source: AGHT+IEWFvVqRwce+MLl9wrOrqSKPdP5sEXaSaCx9X50CKqft32/VVoyhKQ+r4kM4ynEObKGna+nRA==
X-Received: by 2002:a17:903:228f:b0:1cc:3fe1:f45e with SMTP id b15-20020a170903228f00b001cc3fe1f45emr8153767plh.27.1700089967204;
        Wed, 15 Nov 2023 15:12:47 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ja5-20020a170902efc500b001cc3a6813f8sm7945947plb.154.2023.11.15.15.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 15:12:46 -0800 (PST)
Message-ID: <4869f897-ecbb-4f5a-9f4a-8eb6102be34a@gmail.com>
Date:   Wed, 15 Nov 2023 15:12:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/244] 5.15.139-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231115203548.387164783@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
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

On 11/15/23 12:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.139 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 20:34:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.139-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same as with 5.15-rc and AFAIR the previous -rc cyle, we get perf build 
failures:

/local/stbopt_p/toolchains_303/stbgcc-12.3-0.2/bin/../lib/gcc/arm-unknown-linux-musleabihf/12.3.0/../../../../arm-unknown-linux-musleabihf/bin/ld: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf-in.o: 
in function `evlist__add_aux_dummy':
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/evlist.c:266: 
undefined reference to `evlist__dummy_event'
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile.perf:670: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/perf] 
Error 1

same culprit: 21e98e11091bd6ef5e8e70650c6a52dee0e6c11f ("perf evlist: 
Add evlist__add_dummy_on_all_cpus()")
-- 
Florian

