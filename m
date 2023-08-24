Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F89778674E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbjHXGCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbjHXGC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:02:28 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561F10DD;
        Wed, 23 Aug 2023 23:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1692856942; bh=vVRyuNLkZSfSbUTWRT7F8T0v3fD1MZl9S+fAoKzm0/g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y4P9HQqPdEgxcHNjnvkKJCVXn8KB4BAiIfRktjuzHtAPBoaa40s0h0ZbAkdHmx5M/
         iVKOfM8xKy8DitVEZYUgRHrn9jWDs0lB7szFluwBsKcfgdbD1jgxFDScOp+9Pvh0al
         7PEbU40iMtg9KCQYNzVZWQb5IwMPagSnPTMyCfzI=
Received: from [192.168.9.172] (unknown [101.88.24.218])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 2D5BD600DA;
        Thu, 24 Aug 2023 14:02:22 +0800 (CST)
Message-ID: <4df42f2b-3dde-f077-4ec9-b7e87d15fa4a@xen0n.name>
Date:   Thu, 24 Aug 2023 14:02:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/4] arch/loongarch/configs/*_defconfig cleanup
To:     Trevor Woerner <twoerner@gmail.com>, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20230817115017.35663-1-twoerner@gmail.com>
 <20230817115017.35663-3-twoerner@gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230817115017.35663-3-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/23 19:50, Trevor Woerner wrote:
> Drop CONFIG_IP_NF_TARGET_CLUSTERIP as it was removed in commit 9db5d918e2c0
> ("netfilter: ip_tables: remove clusterip target").
>
> Drop CONFIG_NFT_OBJREF as it was removed in commit d037abc2414b
> ("netfilter: nft_objref: make it builtin").
>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   arch/loongarch/configs/loongson3_defconfig | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> index d64849b4cba1..4700655b2bcb 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -137,7 +137,6 @@ CONFIG_NFT_MASQ=m
>   CONFIG_NFT_REDIR=m
>   CONFIG_NFT_NAT=m
>   CONFIG_NFT_TUNNEL=m
> -CONFIG_NFT_OBJREF=m
>   CONFIG_NFT_QUEUE=m
>   CONFIG_NFT_QUOTA=m
>   CONFIG_NFT_REJECT=m
> @@ -227,7 +226,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
>   CONFIG_IP_NF_TARGET_NETMAP=m
>   CONFIG_IP_NF_TARGET_REDIRECT=m
>   CONFIG_IP_NF_MANGLE=m
> -CONFIG_IP_NF_TARGET_CLUSTERIP=m
>   CONFIG_IP_NF_TARGET_ECN=m
>   CONFIG_IP_NF_TARGET_TTL=m
>   CONFIG_IP_NF_RAW=m

Acked-by: WANG Xuerui <git@xen0n.name>

Thanks!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

