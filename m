Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3CC7C99EB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjJOQKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjJOQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:10:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB4BA3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:10:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9bfbc393dfaso18811566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697386246; x=1697991046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFlAKwPdiVPZC4+5an3YYYk82elgh71XEl/RX5OSmnQ=;
        b=d/Y5bsxshZ4QCaIRF+B6BnhuRAo25ywuASHROp+6OcfbV/qWvnRqtIR37aIpoUbVx/
         NLJiBOFrkr+La/meHSz9t6PCeJ6gl8ATzINRJbtV6dFXasQkMuRBg7s6FjS8iR6rYrUA
         lyidry+637zqqiJG4CTyK1W3MqvdaOmW8CwEe2TOF+zXimrUXdsXLVXE27+CNznJFMkY
         aZjj1oWOdLOTpvk3BeBV6iVhZ9OKJPvht2AHKA+NqNku473XUJEjCIg3GJUafPtq66em
         ZDvyGcefckpnAHXkaebeNG3TD2ZurusW6e7rzAx54p/5NG5dNjUCELSiymuoLAZE6aNf
         t7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697386246; x=1697991046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFlAKwPdiVPZC4+5an3YYYk82elgh71XEl/RX5OSmnQ=;
        b=tR9+SEe9lxj63vw2nnVKiCY3erkyXLnckvgo9+oEGd+tW6m9sIM6LNDR2HEBsIg4UY
         sFahnf6FIDriOAA/Vqk7u1LIvEmBE4ThUmT/a/7kT1HWB1ZVvDfQKh7lEMfN7TeHYRHQ
         VFmsnYtYs0Bd/ADPwguCd+tHO7OScys6n6gQhC/1Ni+LefwA+0nqPCamzZb7wY+MfYgS
         nmBzCQo2kvkFR1E0MaSpdAs7szqPx3kxSCMB8BWtmg9P+q/cd956kWySU7axbD17T/R8
         uznzQAKwxpc1ii88aqPs23TiEjz/Oyd+MgdTApinZDMbPPbvCCCxEC6eE7D0ZMSCXV+p
         zKFg==
X-Gm-Message-State: AOJu0YzGBSbT9cJHicTaZbnXXiX2AwXX/1VPlunhzGNbpBzIJL6Wvjbx
        Cs0maiIsYjPh8qM+suP4/ftF2j3RbVc=
X-Google-Smtp-Source: AGHT+IFHDujuMay6WLdWcRvNEQ8/IZ3uIbParwsg2fx/ggiSx2fG0J7+iHNFvq53BrzaBmGYgrMdbQ==
X-Received: by 2002:a17:907:7249:b0:9c4:409:6d42 with SMTP id ds9-20020a170907724900b009c404096d42mr522714ejc.3.1697386245758;
        Sun, 15 Oct 2023 09:10:45 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id my46-20020a1709065a6e00b009ad8796a6aesm2431624ejc.56.2023.10.15.09.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 09:10:45 -0700 (PDT)
Message-ID: <b5ac8e9f-f733-46bf-bff0-79556f0bd280@gmail.com>
Date:   Sun, 15 Oct 2023 18:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] staging: rtl8192u: Mute checkpatch error
To:     Julia Lawall <julia.lawall@inria.fr>,
        Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
 <bfe99c7a-f01f-4ae3-a17d-1e5887a5121f@inria.fr>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <bfe99c7a-f01f-4ae3-a17d-1e5887a5121f@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/15/23 17:52, Julia Lawall wrote:
> "Mute checkpatch error" is not very informative.
> 
> julia
> 
> On Sun, 15 Oct 2023, Gilbert Adikankwu wrote:
> 
>> Align descendant arguments to the open parenthesis as per the "Linux
>> Kernel coding style" in Documentation/process/coding-style.rst
>>
>> Mute the following checkpatch error:
>>
>> CHECK: Alignment should match open parenthesis
>>
>> Gilbert Adikankwu (6):
>>    staging: rtl8192u: Align descendant arguments
>>    staging: rtl8192u: Align descendant arguments
>>    staging: rtl8192u: Align descendant arguments
>>    staging: rtl8192u: Align descendant arguments
>>    staging: rtl8192u: Align descendant arguments
>>    staging: rtl8192u: Align descendant arguments
>>
>>   drivers/staging/rtl8192u/r8180_93cx6.c     |  4 ++--
>>   drivers/staging/rtl8192u/r8190_rtl8256.c   | 16 +++++++--------
>>   drivers/staging/rtl8192u/r8192U_core.c     | 20 +++++++++---------
>>   drivers/staging/rtl8192u/r8192U_dm.c       | 24 +++++++++++-----------
>>   drivers/staging/rtl8192u/r819xU_firmware.c |  4 ++--
>>   drivers/staging/rtl8192u/r819xU_phy.c      |  2 +-
>>   6 files changed, 35 insertions(+), 35 deletions(-)
>>
>> --
>> 2.34.1

Hi,

this driver is about to be removed.

Have a look at:

https://lore.kernel.org/linux-staging/20231014211051.GA29518@matrix-ESPRIMO-P710/T/#u

Thanks

Bye Philipp
