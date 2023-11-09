Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F92C7E7072
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344717AbjKIRjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKIRjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:39:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC57FD58;
        Thu,  9 Nov 2023 09:39:33 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9becde9ea7bso467469866b.0;
        Thu, 09 Nov 2023 09:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699551572; x=1700156372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwAos2Vp+3CBuBh4Ho3TD6tt3v+scS5jjCdbPfAR/to=;
        b=iF1t3hWSXE1um/Ci0sln6ddCLflpmadL4Wp+UQ6a63dYHuJ3rt7jDiunGukdpAz5FJ
         AsRxRUCzBUAlF605bKh3gDcVcPp7BDAXT2++J/CCnvG9NsoJCzGgZQh4BjnWlwxC73tX
         Jop7+hfdHNm3E9/GveIXE6f1AOcw9MwuHH/Jp+SixD7pQEgmp464XtwL6lr2ejZLI+rv
         WMpGp88f5+ypCymVEX5OzDlcMGNJZhIEhgXk0WSwGA2ihQTOQv5GMINs2HKxflzXeq5a
         R4eWE8d26bv6c4PbHDVLkcuOzExJDJ+ame2HWEfeb6R0/koL4GKQLZ6WDXcYfWmrzXwT
         D5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551572; x=1700156372;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwAos2Vp+3CBuBh4Ho3TD6tt3v+scS5jjCdbPfAR/to=;
        b=vegknNPovSCxriwXWRca0tQRDvQZWXKQHdv+FgXCFxoBI5Cd5g61ZW7ATPVG059pmn
         393qeWVvdpeKYzay3npGoNn7MTb9zklgIQuQEXpkm3mDQmc/RMTyG7aV3TUPk+exoTCB
         f+PCtF+JGEWcfG+NYdTZiRwpWadgwjJp9AxbGlFhrHzugKuxIVRpiZsLvIJRR0wSzaSE
         JtzoSjXkSc7/Ly2HYMpTPWV+DsA3U0X+LtAVOgmAYUstWKWy5v0BuL4iZZGYzROouIBk
         P5XAhJvP9Ms3szkzcypf6Cye2Y9A/KGxmTTXrxNjOnvlz+61008kvohdFNQ1XutYoW3Y
         VlBw==
X-Gm-Message-State: AOJu0YzNWSAPF4sJNLR5+a8RgaBLWmQg0v2Qjk+EWVXJNyyzGWE3LDdh
        j5chMnikZKc4tNiwFZoflAA=
X-Google-Smtp-Source: AGHT+IHAws4EaFRozygmI0ktWYPKZwdj17ZHyWR6H3c9UOOt+PJbrijh480uBwjlv9jJ5fXozloYOQ==
X-Received: by 2002:a17:906:25b:b0:9a9:fa4a:5a4e with SMTP id 27-20020a170906025b00b009a9fa4a5a4emr3935118ejl.13.1699551571999;
        Thu, 09 Nov 2023 09:39:31 -0800 (PST)
Received: from ?IPV6:2a01:c23:bd8b:e400:ed81:899c:b431:d0cc? (dynamic-2a01-0c23-bd8b-e400-ed81-899c-b431-d0cc.c23.pool.telefonica.de. [2a01:c23:bd8b:e400:ed81:899c:b431:d0cc])
        by smtp.googlemail.com with ESMTPSA id mj10-20020a170906af8a00b009ddcf5b07b8sm2857060ejb.148.2023.11.09.09.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 09:39:31 -0800 (PST)
Message-ID: <32de4415-8211-4993-af3e-1644dbca5f7f@gmail.com>
Date:   Thu, 9 Nov 2023 18:39:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] r8169: add handling DASH when DASH is disabled
Content-Language: en-US
To:     ChunHao Lin <hau@realtek.com>
Cc:     nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231109173400.4573-1-hau@realtek.com>
 <20231109173400.4573-2-hau@realtek.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231109173400.4573-2-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.2023 18:33, ChunHao Lin wrote:
> For devices that support DASH, even DASH is disabled, there may still
> exist a default firmware that will influence device behavior.
> So driver needs to handle DASH for devices that support DASH, no
> matter the DASH status is.
> 
> This patch also prepares for "fix network lost after resume on DASH
> systems".
> 
> Fixes: ee7a1beb9759 ("r8169:call "rtl8168_driver_start" "rtl8168_driver_stop" only when hardware dash function is enabled")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

