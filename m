Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09004752C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjGMVyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGMVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:54:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3351FEE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:54:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fa988809c0so2345945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689285282; x=1689890082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8Vq/YjU2+7KUXiY4AhyoCFj0jPM2WGiCCtNGuwnzcM=;
        b=d4nxYVrDzzkD7OoNM1KkCMHmJJTnNYUxKcWynlunLf1rRuU1C5GpGUJuEHDgNt05zH
         DqcQYmRPQqvQnpludttrGoxS1jcKViNKjQD/g98ZtKD7QE4WZyj+EucnrWb4h8klaqi3
         JiGHYEUxTS3wpCUYjSL3uFV/X2PTmAtcIJdMTM7giU4uRCshi0JK7hvnX9t7bKj0mm1j
         ccQLEUcmdzDDfje647vCDoM2mtBwxtthNi+zUsCCSy9cmQVpjnvUIr1UApFoM/I5Ngmh
         di60MUsykzG3oyepjCzICg3O6peoODsD/9YdybstoFk7JMOOvXBpDjCeA0MBriIAKyZk
         CQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689285282; x=1689890082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8Vq/YjU2+7KUXiY4AhyoCFj0jPM2WGiCCtNGuwnzcM=;
        b=WH1l1/i+kq8hHJLMCdAVkDVVjFgHt5cGEoVEKcxWhG/GM0i3gZxDArnAMTBdOqhPmP
         lP7tLWrBV22Hrx5drfElFhNVtpJLJp2PB/VEKn+LYRbUwI/gdscRnJlMEd981kRMaqJ0
         sG81RO2t/6HSDa65oSlUuJmboGvuIiwdOBbLdw6pf6Bn4oag09g4wK5lopY75qVhhA6v
         jBwgm60O/7UQrDgdAaql0WTY7elqZVCQT/svl4mKYwwct8EmStIa2GatNMislVmfsuJd
         GQ/OZVMb/svBPhoNWZA7zG3RFNvSekQ9zevbG2N2Pvyb4HymE+eHVEP5MWRwD4VOipV+
         yTBg==
X-Gm-Message-State: ABy/qLYTpIyZCDVoTizZngPUdF1H5J+w7mcZ8x3UWAahnkyFopb9o3Af
        jhxeegBth5u8WCF2bDSBLFg=
X-Google-Smtp-Source: APBJJlFy9gw0RVV4xtKrJIUZJPAF3MKnoCeSrwrB3gei1w9ZwQZRtEE8huiJhjtLCtkFuY9kd87FNA==
X-Received: by 2002:a05:600c:8513:b0:3f7:e7c9:4039 with SMTP id gw19-20020a05600c851300b003f7e7c94039mr2465428wmb.4.1689285282229;
        Thu, 13 Jul 2023 14:54:42 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id x11-20020a1c7c0b000000b003fbcf032c55sm48649wmc.7.2023.07.13.14.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 14:54:41 -0700 (PDT)
Message-ID: <724b252e-0c72-6c77-4817-aee8d87a99cb@gmail.com>
Date:   Thu, 13 Jul 2023 23:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/12] Staging: rtl8192e: Rename variable pBA
Content-Language: en-US
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca, error27@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZK84sYjc9uHIWZcr@basil>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZK84sYjc9uHIWZcr@basil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 01:35, Tree Davies wrote:
> Rename variable pBA to pba in order to Fix checkpatch
> warning: Avoid CamelCase
> 
> Signed-off-by: Tree Davies<tdavies@darkphysics.net>
> ---
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 106 +++++++++++-----------
>   drivers/staging/rtl8192e/rtllib.h         |   2 +-
>   2 files changed, 54 insertions(+), 54 deletions(-)


Hi Tree,
the p is typically for pointer. This is not wanted when you change the 
name. But ba is is in use....

Bye Philipp
