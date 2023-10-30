Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C512D7DBB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjJ3OES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjJ3OEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:04:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B9C6;
        Mon, 30 Oct 2023 07:04:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso7348229a12.2;
        Mon, 30 Oct 2023 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698674645; x=1699279445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+oNiOzVWb1OPayLI3UpcZtoHUryNLF1OMI1H1r1pii4=;
        b=Oe1p/UbXOjEB16mqtM1xgjfGZcZ9YhOAsR3RSrrtzAtaKcSPeHLSu9cV7q0jwXOyuC
         Nn6C345j6MZ8JSSp1qZV68yd6cjIWWbUkytcsW2cj7EgeWwJ6etiF4gxg1fCi5eLoUhz
         9qc0It1OOhkure5AMu4pNqSXNo9yenU17hFOwY8JgF5/iOzddqJsRrHYFHKxdSdbynrK
         JcQtRCF8K4jESgn1FIiKj2nfuMFWVl94jdjUA5Wrat4lkg0qXpf2flp3MB6DbAxtrnYi
         NYiNE9xEcNUVoEZs4BxKYG4Ak5gnwsIoSObgIqpVwmqNpdgeXW7jhKOn2omfEWGJaEw3
         FPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674645; x=1699279445;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oNiOzVWb1OPayLI3UpcZtoHUryNLF1OMI1H1r1pii4=;
        b=rdORYNvYPME4//7Hfzg9qdg0Z51xtWM7DL5e9xNNP4yCEwD2ZNY6npwx/ix0YwAOuv
         XL1RucZdcIhSTi/7raWvUhCcPJL548tY/9dWgnga/XLljmBsTDC05BmPBtsuTUhyVgPc
         eUCtqSc7aaC10QTueA20Ep6+daIUECoIUShSD55WHItbmiNyPlWhTSkRRZm3iHQcqvnQ
         sWZoK50q5MJJSIRHWWS77kS+tkbkwEeXTvBf8AV4nWlZ76Y2FZrGp7qNUWXFLSHkmvaV
         DYhpERCHK0xckcMoeCaarIDfyUBqi5XjUF2InRCRpt5YaiSF1h5JQPxtONumzQ8qvFGH
         EiMg==
X-Gm-Message-State: AOJu0YzI3M6DwJXILuWgk+VRLg2/bd4ZKw3Hk9eVcPuWtIFJye6uN2/0
        CNs7MBEVg2A0yxaRMuARAFA=
X-Google-Smtp-Source: AGHT+IGuB54s6jt5VweeRbOkpv1wIU19siV44qKlRwvJUPLaaNQIqUU4r7Z2qBf99J+gcTg2aucBeQ==
X-Received: by 2002:aa7:d70e:0:b0:53e:fd81:67ab with SMTP id t14-20020aa7d70e000000b0053efd8167abmr7583675edq.6.1698674644917;
        Mon, 30 Oct 2023 07:04:04 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc31:8900:5db7:a938:1060:35a3? (dynamic-2a01-0c23-bc31-8900-5db7-a938-1060-35a3.c23.pool.telefonica.de. [2a01:c23:bc31:8900:5db7:a938:1060:35a3])
        by smtp.googlemail.com with ESMTPSA id n27-20020a5099db000000b0053116e45317sm6278564edb.44.2023.10.30.07.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:04:04 -0700 (PDT)
Message-ID: <a3cc5420-8b0e-4336-accd-78557b5f8f46@gmail.com>
Date:   Mon, 30 Oct 2023 14:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] r8169: Coalesce mac ocp write and modify for 8168H
 start to reduce spinlock contention
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
 <20231029183600.451694-3-mirsad.todorovac@alu.unizg.hr>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231029183600.451694-3-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.10.2023 19:35, Mirsad Goran Todorovac wrote:
> Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
> the startup of 8168H involve implicit spin_lock_irqsave() and spin_unlock_irqrestore()
> on each invocation.
> 
> Coalesced with the corresponding helpers into r8168_mac_ocp_write_seq() and
> r8168_mac_ocp_modify_seq() with a sinqle paired spin_lock_irqsave() and
> spin_unlock_irqrestore(), these calls help reduce overall spinlock contention.
> 
> Fixes: ef712ede3541d ("r8169: add helper r8168_mac_ocp_modify")
> Fixes: 6e1d0b8988188 ("r8169:add support for RTL8168H and RTL8107E")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
> Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> v5:
>  added unlocked primitives to allow mac ocs modify grouping
>  applied coalescing of mac ocp writes/modifies for 8168ep and 8117
>  some formatting fixes to please checkpatch.pl
> 
> v4:
>  fixed complaints as advised by Heiner and checkpatch.pl
>  split the patch into five sections to be more easily manipulated and reviewed
>  introduced r8168_mac_ocp_write_seq()
>  applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
> 
> v3:
>  removed register/mask pair array sentinels, so using ARRAY_SIZE().
>  avoided duplication of RTL_W32() call code as advised by Heiner.
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 26 +++++++++++++++--------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f4a1d1a74b8b..29ee93b8b702 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3231,6 +3231,21 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  		{ 0x04, 0xffff,	0x854a },
>  		{ 0x01, 0xffff,	0x068b }
>  	};
> +
> +	static const struct e_info_regmaskset e_info_regmaskset_8168h_1[] = {
> +		{ 0xe056, 0x00f0, 0x0070 },
> +		{ 0xe052, 0x6000, 0x8008 },
> +		{ 0xe0d6, 0x01ff, 0x017f },
> +		{ 0xd420, 0x0fff, 0x047f },
> +	};
> +
> +	static const struct e_info_regdata e_info_regdata_8168h_1[] = {
> +		{ 0xe63e, 0x0001 },
> +		{ 0xe63e, 0x0000 },
> +		{ 0xc094, 0x0000 },
> +		{ 0xc09e, 0x0000 },
> +	};
> +
>  	int rg_saw_cnt;
>  
>  	rtl_ephy_init(tp, e_info_8168h_1);
> @@ -3271,15 +3286,8 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
>  	}
>  
> -	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
> -	r8168_mac_ocp_modify(tp, 0xe052, 0x6000, 0x8008);
> -	r8168_mac_ocp_modify(tp, 0xe0d6, 0x01ff, 0x017f);
> -	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
> -
> -	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
> -	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
> +	r8168_mac_ocp_modify_seq(tp, e_info_regmaskset_8168h_1);
> +	r8168_mac_ocp_write_seq(tp, e_info_regdata_8168h_1);
>  }
>  
>  static void rtl_hw_start_8168ep(struct rtl8169_private *tp)

For these few calls I don't really see a benefit in the change.
Instead it makes the code harder to read.

