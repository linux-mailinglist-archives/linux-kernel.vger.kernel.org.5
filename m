Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30DB7CBA50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjJQFpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjJQFpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:45:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026F2124
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:45:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32799639a2aso4714439f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697521521; x=1698126321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTPon32JpfuzRNvtltenUlD8VwAiIQ3b0g3UQ/8lPys=;
        b=f1fx4pZYdENQElgLBsTKZ1HEubIu1kxKFKWaZ+Hzsf8Ko5j5Mp4FGlz9dg9Tz3r11/
         IwTsL57pc8CEQQrl+m3i7Q3lsjxotIdKWkf0WroOQVJaaZ2tFcHnI0wbVUuv9Toparzr
         Dsib1qXyTUj5SK3caxmHg6MnpTp8NXwa2V9uejns98t4f+Bw5RwjL6PbAHUwQ26NBQA8
         SX1VrRyAUNP8yiCtQ1oaoF9yLQZhS+6IM+Ei9TgdSEMXjgMdK0ewZwOrq2yQnmmzic6s
         aR7Zqd5kecvkwcrGNoWtMEINDcV/wIeK2sT91+zlldnhlcUxmurPGdE+XfFIf9KFboTI
         oSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697521521; x=1698126321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTPon32JpfuzRNvtltenUlD8VwAiIQ3b0g3UQ/8lPys=;
        b=pU72q7JNHs7XaQ2yBC9B3Hj0EF7TTsUXY1oKL0GCxY0xc+lZfvOPAT8+7F2AG7CpFl
         W6FnICf9/lH3qrBksYkm1PN+UZvrFg4MNaar/i3gHBaYT/RcYMv46uMIHr+kY7SjStDC
         JksPKnlHH6y/bqjTNfYMUAwLJX+om+QSI/xUTVlLziQ+9BLHCfDfGk1/uEd3qC5bgPLG
         HDzxfZyGkF7gVnB87OQ/t2+woJJJtatc7E6VJt9yTgauSHvXmdrKBgPGVnucegffgeyF
         qMH/ied3zmSGANMniurybuRe0JIZZqJR7A5RfIGDn0KAp/KBakTr+q774WbBSCC4XP6b
         O8GQ==
X-Gm-Message-State: AOJu0YzfY1qXAGw+FIg3cyhLTEB0/X9HKVTSS9/WvCqv48WnEbCSq6pX
        ekkUKpn4wQDSx/Z1JNu+UjI+yIDo+3rh5Gqee40=
X-Google-Smtp-Source: AGHT+IHs3B7noUBTeQn7HYvMJMcEsF3Esl+YvcRhoVp01N9+CZVaf7/PFCNBrx3Rm5TotCf3NsmByA==
X-Received: by 2002:a5d:4c8a:0:b0:32d:a335:e33d with SMTP id z10-20020a5d4c8a000000b0032da335e33dmr973868wrs.58.1697521521578;
        Mon, 16 Oct 2023 22:45:21 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id i3-20020a5d4383000000b003232380ffd7sm809226wrq.102.2023.10.16.22.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 22:45:20 -0700 (PDT)
Message-ID: <02ce70da-346b-6c24-b7ed-8f5b30f1c99b@linaro.org>
Date:   Tue, 17 Oct 2023 06:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: linux-next: duplicate patches in the nvmem tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231017150714.41a6c640@canb.auug.org.au>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231017150714.41a6c640@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen,

This is now fixed for both nvmem and fastrpc tree.

--srini
On 17/10/2023 05:07, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the char-misc.current tree as different
> commits (but the same patches):
> 
>    d0b450caca6f ("nvmem: imx: correct nregs for i.MX6ULL")
>    f46cfdaf5c07 ("nvmem: imx: correct nregs for i.MX6UL")
>    e898831a6683 ("nvmem: imx: correct nregs for i.MX6SLL")
> 
> These are commits
> 
>    2382c1b04423 ("nvmem: imx: correct nregs for i.MX6ULL")
>    7d6e10f5d254 ("nvmem: imx: correct nregs for i.MX6UL")
>    414a98abbefd ("nvmem: imx: correct nregs for i.MX6SLL")
> 
> in the char-misc.current tree.
> 
