Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66147E835E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbjKJUEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjKJUEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:04:11 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC09D;
        Fri, 10 Nov 2023 12:04:08 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5845a94dae1so1224865eaf.0;
        Fri, 10 Nov 2023 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699646647; x=1700251447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ok7T5kOB9FTvNg2Z1Ix/MQSI1tJOHNOutZNWOUXGjg4=;
        b=iooO++W5arAhMIrGuKYxNyhLJ2uiWQ16bwKBKVs3xkERnIcXP+V2vtGAmy2LPDMO4W
         WpbEz3jLwFJHJ0HWffxrL++nTlRsGALH7hng1aOt2Ug26+H8OHkVjD77GTYEzFWpTCJl
         Bxg4YlrvkZh/WGpE8PnCreDblD4+S7yB8Q5CG5Y5B1sGHspstqVpmpotWwKV8kzzMvRs
         UlmSOqt2bY2KazrOH6bbJiBs1uINsQ2WvvkZGQo8bvh76OBQgN1qenkK5iEKFpbtywrj
         joPQYlodHD2rlRtjYIchMyYzWZnQeq1FP7BWt4rZZKs0ui8MQEdq/yVfZEPC/Y5u6/03
         Nbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699646647; x=1700251447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ok7T5kOB9FTvNg2Z1Ix/MQSI1tJOHNOutZNWOUXGjg4=;
        b=a1Wf/EwCtH00ozcseLtOxs4QzmKXHjcJz1ZDk1sx7lpyXMdVJffLQeApf7rZikACPL
         vUv82kBORK4MZbqEicdsyi3IpbPdqGk3lsZlYx/oVBqVEPdi7XTVMbM+tHRBQv7j2egi
         OOSWVoFYIqvDP6GZXOMg34pSW9G+6czaWSKH1r4M0LU9lUDCznc9cVlZZ+yaWWdklc7b
         Yry38CvHv+pOqic02FV86RSjEz3EUyP6Frj1+wnMQgie/RGUyPILm7Ehiu+CA2mgP9cI
         8tJ0z8QxjOJEaRFvy5ri3vW0SWH/m3bfyu2IMsxBoKGbNHl4i8dDxMvIMaZ8hMMcdO8H
         MYIA==
X-Gm-Message-State: AOJu0Yz4omHa3Oso2ZpucUki60F8Bf3ufqIf2Xi4elpGVw43+U3abRDe
        pBU3y5nWNwOpuXllO4/xhvc=
X-Google-Smtp-Source: AGHT+IEVMiQvoQ7QuO6zONN+XDqwBqZXLrHtlukr0r8Gu8Pz8GUD/b6P7fyVF6W6LKqL2qjo1lbwsw==
X-Received: by 2002:a54:4118:0:b0:3b6:c3fa:3d25 with SMTP id l24-20020a544118000000b003b6c3fa3d25mr1651363oic.14.1699646647265;
        Fri, 10 Nov 2023 12:04:07 -0800 (PST)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id ez4-20020a0568082a0400b003a9cd23980esm35404oib.8.2023.11.10.12.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 12:04:06 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <05390e0b-27fd-4190-971e-e70a498c8221@lwfinger.net>
Date:   Fri, 10 Nov 2023 14:04:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects to
 some Intel PCI bridge
To:     Jian-Hong Pan <jhp@endlessos.org>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessos.org
References: <20231110103227.58008-2-jhp@endlessos.org>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20231110103227.58008-2-jhp@endlessos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 04:32, Jian-Hong Pan wrote:
> Disable rtl8723be's ASPM if the Realtek RTL8723BE PCIe Wireless adapter
> connects to some Intel PCI bridges, such as Skylake and Kabylake.
> Otherwise, the PCI AER flood hangs system:
> 
> pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
> pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:00:1c.5
> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=218127
> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> ---
>   .../wireless/realtek/rtlwifi/rtl8723be/sw.c   | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> index 43b611d5288d..720c79e0781a 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> @@ -25,10 +25,29 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw *hw)
>   {
>   	struct rtl_priv *rtlpriv = rtl_priv(hw);
>   	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
> +	struct pci_dev *bridge_pdev;
>   
>   	/*close ASPM for AMD defaultly */
>   	rtlpci->const_amdpci_aspm = 0;
>   
> +	/* Disable ASPM if RTL8723BE connects to some Intel PCI bridges, such as
> +	 * Skylake and Kabylake. Otherwise, the PCI AER flood hangs system.
> +	 */
> +	bridge_pdev = rtlpci->pdev->bus->self;
> +	if (bridge_pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +		switch(bridge_pdev->device) {
> +		case 0x9d15:
> +		/* PCI bridges on Skylake */
> +		case 0xa110 ... 0xa11f:
> +		case 0xa167 ... 0xa16a:
> +		/* PCI bridges on Kabylake */
> +		case 0xa290 ... 0xa29f:
> +		case 0xa2e7 ... 0xa2ee:
> +			rtlpriv->cfg->mod_params->aspm_support = 0;
> +			break;
> +		}
> +	}
> +
>   	/* ASPM PS mode.
>   	 * 0 - Disable ASPM,
>   	 * 1 - Enable ASPM without Clock Req,

Does the switch statement need a default case in the event that Intel offers a 
compatible AP?

Larry

