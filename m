Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162D176B9A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjHAQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjHAQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:30:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894FF1BEA;
        Tue,  1 Aug 2023 09:30:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f0d66652so5553980b3a.2;
        Tue, 01 Aug 2023 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690907426; x=1691512226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6SHihvZpMURcyhm7Z81CBDjuSNiSBVG7mTtgS7+Wb8=;
        b=gy5ZfNOUmH6cM3NLp0tiUJKLaahZnFZlaJqPZEeC1a+ancG30Y2LQxTksSk+v9QrGU
         N5ilAtVSZlnBU0bpvin7raZQG8VPka9wl3+8QLf5GPuQXW2/bKIjoUfYu2Je2s5hn0qi
         X+p3Dp+0v08XvxzSSbGZh/BxU7pxK65JgqyJ8knTC1IfLMIrzXO8ndOVIDCpubpezL1+
         n6U5RWNrErAPhCYRanpscP7/9f+iMmfn1ntKMp1KDTYK/pvtqbvsIUh3z4/WOiffn5IW
         aZpUvvipLNewQxta6EmnyRRzThftEh7LTZl7wjM0ELmtWZPGti81jpcDoxLqRuGQaX9P
         PHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690907426; x=1691512226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6SHihvZpMURcyhm7Z81CBDjuSNiSBVG7mTtgS7+Wb8=;
        b=MDEsGvWc5+dn0OX46Oy40rsarrtbKMJdv6BQN4NTBm3b4DHAY5AAkLvYA+Ehvq2oT1
         xufVvRFhndPcKcf+jgPArep1gikyqqMxRiS6iChAO5+kw6c1UBQylQHzlc47JDxShtAT
         MCeWWml5Q0dsaC+udOSkBqcOzooJqVjacsfxZ7jVAcckFbjNUJ8OYEkDgf1rpDGKmPWq
         J4fE3CZIJHbFhdaEE8Hgsh+4CFSctiZgPMYEMNq/+hrlvbSERvhLbYgXpybpABeeQxzj
         19cb3zXjKPk/uHBfPLSiyJkz6/Ham/TJtM9gagaTjpvZ1z8m+0/yW++/R5PgOeHhzjUA
         CYjQ==
X-Gm-Message-State: ABy/qLZI+8FbwdOZir8kVk57zTpw0KBskzgf07yhzFoes4GOEnbTSj8u
        O1gBrRkHWifvkXSgpyGfsNT4pAwfwBx9vA==
X-Google-Smtp-Source: APBJJlHyV+DNAhqLdZDvVlGGrpxeDH3ScXnLCA79TbQybXBy4r9sC8kEeISZVOW1Z8bNFQBx3wZKxg==
X-Received: by 2002:a17:90a:b306:b0:268:2523:652c with SMTP id d6-20020a17090ab30600b002682523652cmr13179348pjr.31.1690907425773;
        Tue, 01 Aug 2023 09:30:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g12-20020a17090a300c00b0025ea87b97b9sm1456497pjb.0.2023.08.01.09.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 09:30:25 -0700 (PDT)
Message-ID: <03b23f8c-91c3-4ae9-b86d-4aa6c8cb5d78@gmail.com>
Date:   Tue, 1 Aug 2023 09:30:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 000/155] 5.15.124-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230801091910.165050260@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 02:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.124 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc1.gz
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

