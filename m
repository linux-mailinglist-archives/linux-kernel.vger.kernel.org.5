Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E423805DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjLESqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjLESqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:46:34 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AACD43;
        Tue,  5 Dec 2023 10:46:33 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so691547b3a.0;
        Tue, 05 Dec 2023 10:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701801992; x=1702406792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjVRAabg54DYaUkQE0x+HQEZpRifdvwoWnanLEPmYbk=;
        b=OpvgMJvjpamKVmq6i5SdYAe1P0Ci6T/cqYnRohL/t9TftykaPD5gMjXkj7R7oW8XLM
         wC4QGu39ppLTIhRFwe6WQ7DtgfvjaujFP5d+j+6m+/t65OLZncle5bgLiRtzQqgLqT42
         wdzuGbefknXDc8INaHEYxgOYb22HgbOTT9jV5sfSNjJr9dgApugESI7YS//mUP0P97pP
         zxdZohLRO6cIuPjf7fKz84AdTmAyi5hsamDpqNLy41wZswuRNpg1q8LWjX2iVOUm9mDu
         sp0UHURJVQnb6UbzPHuirck11v4b2ueOZukUB+9bTsCfFgFHeb/0QWB+GqC+rTIzjsXO
         xs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701801992; x=1702406792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjVRAabg54DYaUkQE0x+HQEZpRifdvwoWnanLEPmYbk=;
        b=ex4VfwFbkfS7G26ImJ5dq3yXX6pUdPVOi5xzNCPFnXe/YBhyVEfoZ6ENbegHhVjogv
         upwKVrP3DT49bUTVTcmg1hjjLl6NG+mZkLGXgvUwgdmKWASELzCks4RCIwdcU+eL2TOX
         gCvudF2Qg5/lM9APAQ6KC75knr8Tkz3hrepC7c/jdh9Qs8v2DqvoQAM7iVxBVd5Wj/vq
         +ItL9SQtJxM9q187Tox9Zh9h9/YYytLAY7JolaVV8qnb/QdbUawuht4EMmwtBj4Rx9q2
         RU2BuQi5JAwyTzWh4vFoGCShBVkKg78niL/HgNzqsJCGmb0vl8I7QHKGBa7RJfmNTKkp
         mflw==
X-Gm-Message-State: AOJu0Yz7+gFcrz4wR3WYEGPl76S5pEhSickPEMZ3Tb1zkEupjz1RMCim
        +xpEDo1LiTVGT9Qu73siM3M=
X-Google-Smtp-Source: AGHT+IGXta1ulaAYdeZtZ+IcEKjBU6b6E/TwofV0oeYBhqo4fwe18xdryCv/mSKvnp3/Vf2a7f+D7g==
X-Received: by 2002:a05:6a20:da86:b0:18c:57a7:ea29 with SMTP id iy6-20020a056a20da8600b0018c57a7ea29mr4037407pzb.45.1701801992470;
        Tue, 05 Dec 2023 10:46:32 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z20-20020a637e14000000b005c68da96d7dsm2520922pgc.38.2023.12.05.10.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 10:46:31 -0800 (PST)
Message-ID: <b36d17a2-2e7c-455a-b815-2c97606bbf6e@gmail.com>
Date:   Tue, 5 Dec 2023 10:46:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/134] 5.10.203-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
References: <20231205043610.004070706@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205043610.004070706@linuxfoundation.org>
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

On 12/4/23 20:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.203 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 04:35:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Same perf build issue as reported by Harshit already.
-- 
Florian

