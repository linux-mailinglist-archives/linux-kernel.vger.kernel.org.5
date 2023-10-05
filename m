Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9A17B9E66
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjJEOF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjJEOEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:04:14 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815982484D;
        Thu,  5 Oct 2023 04:11:44 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3af609c3e74so565243b6e.2;
        Thu, 05 Oct 2023 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696504303; x=1697109103; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZLz384BnmtZTkRlTbx4zMnrnVvcuSLVD0ixPYcWO2Q=;
        b=F+COXs2L1P0XOqvdTqBWQ2sEtLS5ecKjqy2FDOWky7SkMbITnExlsDNbMm6cMmbGeD
         wz33yILgOstsdAIh/4riIYAZ0WezuSKFWjPBeoZ/inFz8yR3MOCSBca7uC9OYJpt/nKw
         /dCmvezTbge7VJJiT4RxClNI03ysPXYge60agicrppwIMmx6SZ+il7q5wUg5IT4ApqGV
         xX6AxbN7h8yHXN+Ltjr6X3yIY3oQAVFIfOrSEN84FT4K5VwIf+ZJUDPdwFtAWVofYW4+
         /zS+uYCyw+EfU4nBUseganlEoWKVkPij20yY4Nn1KXSUUQlZ91hq7ArOQMpGqCyJ2nVO
         p0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696504303; x=1697109103;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FZLz384BnmtZTkRlTbx4zMnrnVvcuSLVD0ixPYcWO2Q=;
        b=izJ7eNHMhk9a/8OfdmmjjnZZYeFvBVXLNVv3ZZGo315WgAwZwaKtPDLBLYoPY1vbUR
         uRdoroffDIvozhaX2ZvWtCdhcs9pJIxj7Caw6vXESXhg9pIE4kogBffFpHMoJyNszLNy
         nK4K9RdVvxrYoHTDSUc8x3WJAIuaJRETk6j4Vw/gx91AtK+owAB9fph+YvbpUyFVR/Dn
         TMEL0nV41ummQFC9oOqec88nfs7RCEUKuJHlLiDZJglOCxjgCQ+RIi2eKWV0Zi0fsg6t
         UVZXmw/YfTNjnADmFuyOtNWjb/5GZhtFykuMG3HAilHZUIiBp5s4jlxle1SReQrlC2Wh
         5+JQ==
X-Gm-Message-State: AOJu0YxyNRhFYsE+fgaQGAtqQ54KP5kIFzflcn5/fe8CZ4AzDERZSvun
        fi7rIEH9MqaUtZw6i+VYGneANsbOr+A=
X-Google-Smtp-Source: AGHT+IHUEXw1wL4QkSvnckVLi0TTTFo19lB0LVDgyCRKEWOJzXsDiIkSz5Vp+7Yrny8xruGz8dXBrg==
X-Received: by 2002:a05:6358:4297:b0:13a:2fed:337c with SMTP id s23-20020a056358429700b0013a2fed337cmr4966489rwc.24.1696504303486;
        Thu, 05 Oct 2023 04:11:43 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090a74c300b0026b50d9aee6sm1282934pjl.25.2023.10.05.04.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 04:11:42 -0700 (PDT)
Message-ID: <9fa3c04b-bd98-4fde-9bfd-27d83132e766@gmail.com>
Date:   Thu, 5 Oct 2023 18:11:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Pawel <pawel.veselov@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: 6.5.5 hardware access timeout / HW error / GPF in iwlwifi
Content-Type: text/plain; charset=UTF-8
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

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hardware: Intel(R) Wi-Fi 6 AX201 160MHz, REV=0x370
> Works just fine with 6.4.15 (and older)
> Using FC37, updated to the latest available kernel 6.5.5, can't use WiFi or even boot.
> Linux firmware package: linux-firmware-20230919-1 (latest available version for F37)
> 
> First boot:
> Timeout waiting for hardware access (CSR_GP_CNTRL 0xffffffff)
> at __iwl_trans_pcie_grab_nic_access+0x14a/0x150
> followed by HW error, resetting before reading at
> iwl_fwrt_dump_lmac_error_log+0x50c/0x600 
> The interface didn't ever plumb.
> 
> Second boot: GPF. I don't have the traces, but I swear it originated from iwlwifi module from what I saw on the console.
> 
> I've attached the traces for both the failed boots, and the normal boot from 6.4.15 for reference.

See Bugzilla for the full thread and attached dmesg logs.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217963

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217963

-- 
An old man doll... just what I always wanted! - Clara
