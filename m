Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A356180DCDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbjLKVPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjLKVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:15:47 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7445CF;
        Mon, 11 Dec 2023 13:15:53 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f3790a187so253183685a.1;
        Mon, 11 Dec 2023 13:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702329353; x=1702934153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7MVcu7o/NtINowl0l8HYwXfyv01ZrwZ3Kxgw8afM7E=;
        b=UO3RYCBCs/OYVrVrh8TvyWr1C97c3buT477coH5ui2VG/FAaZe6z/tJNXNSsR7dAXP
         7BvvMu3xOdurdhJieurgbQNCEu0t9djqP73m+sK2IqRFWPDISL4TQzs/J15OwEmUcUHG
         7HHjpWXnbfgQ7qqAiTS8s8cLM5/EHp+V3xnXxSC2FpgxWsJ13Ij70qVuXUOAftNaOtaE
         9W+oyD2mlGFqtnfAAK1Wo3MhYgU2RvwQHjErrNRwsXM0q1S96LE5SmmRQYP9jSyxil3P
         BZ+QNlgAz0BPjxBcvx+qAiSOx1lnejIa7spl7RNfKQm1YeoNpKK5/C9s9SstPAyrMpqZ
         YKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329353; x=1702934153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7MVcu7o/NtINowl0l8HYwXfyv01ZrwZ3Kxgw8afM7E=;
        b=KZJtBndU/90X9ohrD+gnMSl2MLifHA0YzlOEAwZYnuxfcI+TexpyfvvXi96fa1LFah
         ccxmjctzORtATqd1+cCYGTwWK+26E8BRTF8r0VIvO5Byy1FCzmUytZ7MW1YUelV5RXkj
         PSXJzvppC3PPet8mtukb95QB8PJgD/E9hc1PBJydCKRh5sfCJfFOYSonzMW0JPRHfdX2
         gAS03E2hRtXYluqpNoT8DjjE8pbnVVewSU7+aYvaf7darJlAmhn2zNwAhsnaK5IUeh+U
         feLsPh5Hy+uwJlA1+s+fDBkAqeB1UvMuXJKNJMNU+/khNMwbNGx44w/gpOEO2XLCAAkU
         0kHw==
X-Gm-Message-State: AOJu0YzPgDEW6LpuZGS2UPFPUmm+1EXyL/GWKJ22Ba1bK8K3HCPtWx5i
        Vm5WcxLTKGP67cJbF2eJaFk=
X-Google-Smtp-Source: AGHT+IGsNhakLJTeZI6++7Are4btlVbr4oMf0+N+oBzUW+gS4V/RE/+UjPoePWZB+K/aoxk4RzxQkw==
X-Received: by 2002:a05:620a:1aa6:b0:77f:c96:bb8d with SMTP id bl38-20020a05620a1aa600b0077f0c96bb8dmr6908517qkb.6.1702329352929;
        Mon, 11 Dec 2023 13:15:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bs36-20020a05620a472400b0077d8a162babsm3200309qkb.13.2023.12.11.13.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 13:15:52 -0800 (PST)
Message-ID: <41909d24-db7a-4a11-8983-7101e87582e0@gmail.com>
Date:   Mon, 11 Dec 2023 13:15:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231211182036.606660304@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
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

On 12/11/23 10:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.68 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.68-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

