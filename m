Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC9809B44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjLHFEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjLHFEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:04:39 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6919E10F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:04:45 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4b2dcc7b71dso454403e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702011884; x=1702616684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCezDiITLYZlXZkoiENFPkRYgXSgvqAlJqwCHapkHlo=;
        b=b9sy+JFyQagGKWdLCx3dMj6XtRaN/EnROb7OqKGv4nRCLx+3uUlPGyUOOsPj+O/H0x
         wlPPLtpggOBvo28hetHnipHg/WRC1E3nfs1KmIxjt/CTyBFyMNQ5aAXfjiuiWCVBK92w
         bBV6N6QjaDOZbIjJith22oK5zOfWxc6zB1eIJqQP6V5ictYFMms3WNkpUxUfu7hu77wf
         UDA6c+H+RcbrsGZ8ypcdQ3SjNCPM3pkb94ACIJOd2hxR7/NmzZmBgTk1Pb/lHDlLNAHE
         eB8/nhFDWXAw+Y3XHSD3YU5GUkRVbeXyagQbxf4GQuuHX4q9r9maFlAvV7w95qgY6HaZ
         DjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702011884; x=1702616684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCezDiITLYZlXZkoiENFPkRYgXSgvqAlJqwCHapkHlo=;
        b=A2uzCn0QPKZJ80HMuJW/lKxuqRMe1YSaMVM1zyPhPd+ciJeFsHcWZnLPGQbGCjSbbx
         MAF514ojefF+Kv+jzQc/iZTJhYn79m+prspDY02ZtJJ+XfFIFvx8q1JwT51Y7U1TwW4l
         yz5+p7DTNMrQU7JYTQNZOp2cKOkHEskGeqDebhcECw6N5mkUBCJtssuVAwdHoKkSsZSP
         ldQuSo+SIRM8InzcNh/lmFd8PT9S2g/dwCfRYwOA1QPiPLsoSdtaJTHLsttxqjCyPVu3
         bqpk2b6rQGxzc3oMtoszcJg39rkQoeiKmDcq4/x7f9tBPLVZqGgIWrr7h/CaCnQ1ObdL
         Ltog==
X-Gm-Message-State: AOJu0YxdLjXUwsjOm0bh81rUX3w5NS9YqWCMqZM0yfEO1UStx506LVcQ
        WBUe9A53qAyI9c9B/6JKCcscCw==
X-Google-Smtp-Source: AGHT+IHd3xhGQZwcUIcLtaS/NPIhQH51OI4srkcBz6UdtbLizYUKJjw8nicEQTdHb0F/v/M3ROTE/Q==
X-Received: by 2002:a1f:c843:0:b0:4b2:c555:389 with SMTP id y64-20020a1fc843000000b004b2c5550389mr2948641vkf.31.1702011884531;
        Thu, 07 Dec 2023 21:04:44 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:41c5:bf1:860b:1e95? ([2600:1700:2000:b002:41c5:bf1:860b:1e95])
        by smtp.gmail.com with ESMTPSA id i14-20020a0cf38e000000b0067a33133420sm494592qvk.110.2023.12.07.21.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 21:04:44 -0800 (PST)
Message-ID: <4f277982-fffb-4fe1-bc02-007633400f31@sifive.com>
Date:   Thu, 7 Dec 2023 23:04:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        llvm@lists.linux.dev, arnd@arndb.de
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
 <20231122030621.3759313-4-samuel.holland@sifive.com>
 <20231123-headdress-mold-0dd7a74477f7@wendy>
 <20231130004224.GE2513828@dev-arch.thelio-3990X>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231130004224.GE2513828@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On 2023-11-29 6:42 PM, Nathan Chancellor wrote:
> On Thu, Nov 23, 2023 at 02:23:01PM +0000, Conor Dooley wrote:
>> On Tue, Nov 21, 2023 at 07:05:15PM -0800, Samuel Holland wrote:
>>> RISC-V uses kernel_fpu_begin()/kernel_fpu_end() like several other
>>> architectures. Enabling hardware FP requires overriding the ISA string
>>> for the relevant compilation units.
>>
>> Ah yes, bringing the joy of frame-larger-than warnings to RISC-V:
>> ../drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: warning: stack frame size (2416) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Wframe-larger-than]
> 
> :(
> 
>> Nathan, have you given up on these being sorted out?
> 
> Does your configuration have KASAN (I don't think RISC-V supports
> KCSAN)? It is possible that dml/dcn32 needs something similar to commit
> 6740ec97bcdb ("drm/amd/display: Increase frame warning limit with KASAN
> or KCSAN in dml2")?
> 
> I am not really interested in playing whack-a-mole with these warnings
> like I have done in the past for the reasons I outlined here:
> 
> https://lore.kernel.org/20231019205117.GA839902@dev-arch.thelio-3990X/

I also see one of these with clang 17 even with KASAN disabled:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:37:6:
warning: stack frame size (2208) exceeds limit (2048) in 'dml32_recalculate'
[-Wframe-larger-than]
void dml32_recalculate(struct display_mode_lib *mode_lib)

     ^
1532/2208 (69.38%) spills, 676/2208 (30.62%) variables

So I'm in favor of just raising the limit for these files for clang, like you
suggested in the linked thread.

Regards,
Samuel

