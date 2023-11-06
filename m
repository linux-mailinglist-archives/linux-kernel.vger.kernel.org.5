Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21747E2AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjKFRcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKFRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:32:38 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70BA134;
        Mon,  6 Nov 2023 09:32:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2800bdf888dso3632579a91.1;
        Mon, 06 Nov 2023 09:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699291955; x=1699896755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIBrIYqApw7fSHDtPe3Pg1olZEmzuGAS+T77XqoaE0s=;
        b=VcLST85TXR0xA0L8Wwkjm+xJMxqUepOLjE5A/CKXd5BbUqPf8GTLPnuIJkZ7J8ozBw
         VFNhnIdW57AZ2VlDlmLj1cmqmQ0GqJdZv/ekWWXVpSbf1EsDhOAhODnM6aIqcAyHHoWB
         jHIRJEmNbDeaJbm2TcDlsZG9Ei5lUVKQsvjd1Qvzh2IY+D0Yn5rru2WKLWhZsat+FU5U
         GRrSmCU0HT3gZ+pVRXMm3zzVzVhJSjeX5ZorBrTG9rxCzU945EpmAmBH0lu4zqsV6pzw
         ol3eGW2oIWL65tUqf8+9KRevNmk2RVoEcLsAF6Y3UoP32nHLt1GSIZDKO7raxvAqVVj0
         8zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699291955; x=1699896755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIBrIYqApw7fSHDtPe3Pg1olZEmzuGAS+T77XqoaE0s=;
        b=wB99ZonuzImbqJuD06MiU9bJIB5k4tLPqg074gS1VcDiGzLVKBQcq1fLnqwOO3ZKFN
         TbsziPNDeBu686e1tqlHf6Kw4DPWFDSx4aATyhrp1+coR1Q4gcNzI1VPC4VApGvCBV6d
         vMBnrzDVjxyMEy8OziV01VzO2qO0DwruhRs6Hl3RMr4fV0zSCGjHIcBoazMWOXcpWCP6
         n/u8C0y0vNCI3gUAFuqEV5sY1MzQ0x9I95F8tW2zDgesiuFybtc7Ti40q1qS6FpWSTdL
         v5asmbI6suuQ5qVEthbNLXgv+39+KMI786l6g/xHMmx/qRDddi7OlzZOx9OO60W6wKMM
         wYGw==
X-Gm-Message-State: AOJu0YzwM+Nu/YAJqFGnQImU0iN+KtD1x/gpkxc+KgVmIGiZoIZaIJLN
        oVT6jDQoLbgnmB+MpYoqfyc=
X-Google-Smtp-Source: AGHT+IHjmwc18Ai8f/eQ3aVPPqt7f4cG4Zh5ILvd2PJoi3fWfhA87/WnnKR3BGJ9KZaTVcqHIW/XPQ==
X-Received: by 2002:a17:90b:1649:b0:280:fc4a:cbca with SMTP id il9-20020a17090b164900b00280fc4acbcamr245666pjb.5.1699291955164;
        Mon, 06 Nov 2023 09:32:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 26-20020a17090a035a00b00274262bcf8dsm6383055pjf.41.2023.11.06.09.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 09:32:34 -0800 (PST)
Message-ID: <a42cb7dd-d87b-460a-b532-5618174f993a@gmail.com>
Date:   Mon, 6 Nov 2023 09:32:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/74] 5.4.260-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20231106130301.687882731@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
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

On 11/6/23 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.260 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.260-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

