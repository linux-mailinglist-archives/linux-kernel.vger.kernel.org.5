Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAC77EB2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjKNPBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:01:28 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E0114;
        Tue, 14 Nov 2023 07:01:25 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6711dd6595fso29357196d6.3;
        Tue, 14 Nov 2023 07:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699974084; x=1700578884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsyBtl43yR5XGf9p1vfaDNOB+yJIZUr3JZKeUV5WTyA=;
        b=EzzuFOaKpn3dQn4d2BtlxjxEv9tzRLGiE1AwrPB51GP8UydCciyKHJE4RZrPQ3Bfk0
         LSnY2b3Y/Ec5Nv79yzImQlulFwrbBdhFNgpf5isXAUxNa/xZkIP9F4ir9r5lTgkUSRxV
         RM3PjulP+yNAwRYuPrOYtIBX85zLiqc3XpZvHxItKOuNI1128Ldp88wlAqVxvQyCZT2V
         AhvPsbNoLXU853BmtvHq9l2QP+MBYG1Lx1ivYeDBSvS/CSzwiyYMV8kNuPoRH1yxYOp8
         URGEsz9O3AWLgLoj7vHjw3k4VuC4rysAmvqkAaSJ9sGf0Fi2fNR6zIFoF9Tl7c0sF8Ey
         8atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699974084; x=1700578884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsyBtl43yR5XGf9p1vfaDNOB+yJIZUr3JZKeUV5WTyA=;
        b=lWI2gx+/yGOW6Omq/5Ar6T4mQopjZvl/0XsxCBzvvxC1YAsYzElN0O++OeSNx4FUIl
         GcUWAwGOIBf4cCS6Z2KqnJ7VozHd0tAonGuLoOnVZzRgadF4Yy3pB2Vk+R2N6JiaRc7N
         TCoLHFhngRfyP0HuHyLjzptVy/MMJFnvsOU1T3fWv16BPsVG4VYPygQJyNd7mpvrcv2K
         owE5ZCA18hv1D9uD4HLnHreBqOV9h8oqnSCGaGaYVTKc1jLPzRnyN3HI/iQyNJBuvgvw
         h6kw4AIsihHwGZIz5UA0Jve/uVrP8oUtVWEarY4P8LVyv0I4a7SzfAEMqb82jsQgBc/9
         ystg==
X-Gm-Message-State: AOJu0YxRnfBbeq57hP78B3O1+Bx3zAGnkQ3M14InUyhFfI8nHL0DcHk9
        B2i1z1beczpXa2flZQLkpFVVETKnFaZzOQ==
X-Google-Smtp-Source: AGHT+IHyp9k1Wsoe1cGwtSdjLvnYyonjSdcUNkDZyJCd3YFdyY6jmNvzWaCrLAqQECOdJR7nsPImhA==
X-Received: by 2002:a05:6214:2b4f:b0:671:25b2:7dbd with SMTP id jy15-20020a0562142b4f00b0067125b27dbdmr2392610qvb.3.1699974084011;
        Tue, 14 Nov 2023 07:01:24 -0800 (PST)
Received: from ?IPV6:2001:470:8:94a::251? ([2001:470:8:94a::251])
        by smtp.googlemail.com with ESMTPSA id i15-20020ad4410f000000b00655e2005350sm2956188qvp.9.2023.11.14.07.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 07:01:23 -0800 (PST)
Message-ID: <ea1d2505-7396-92c0-4687-facad575d299@gmail.com>
Date:   Tue, 14 Nov 2023 10:01:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects
 to Intel PCI bridge
To:     Jian-Hong Pan <jhp@endlessos.org>,
        Ping-Ke Shih <pkshih@realtek.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessos.org" <linux@endlessos.org>, helgaas@kernel.org
References: <05390e0b-27fd-4190-971e-e70a498c8221@lwfinger.net>
 <20231113043454.10053-2-jhp@endlessos.org>
 <2614f3f7a386435ea7d5f989061c7780@realtek.com>
 <CAPpJ_eeNbq5saQFTq0tz72r05Z4ROSWqn_CNBx=bEpLsd6vT7g@mail.gmail.com>
Content-Language: en-US
From:   Jonathan Bither <jonbither@gmail.com>
In-Reply-To: <CAPpJ_eeNbq5saQFTq0tz72r05Z4ROSWqn_CNBx=bEpLsd6vT7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/13/23 22:01, Jian-Hong Pan wrote:
> Ping-Ke Shih <pkshih@realtek.com> 於 2023年11月14日 週二 上午9:41寫道：
>>
>>
>>> -----Original Message-----
>>> From: Jian-Hong Pan <jhp@endlessos.org>
>>> Sent: Monday, November 13, 2023 12:35 PM
>>> To: Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih <pkshih@realtek.com>
>>> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> linux@endlessos.org; Jian-Hong Pan <jhp@endlessos.org>
>>> Subject: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects to Intel PCI bridge
>>>
>>> Disable rtl8723be's ASPM if the Realtek RTL8723BE PCIe Wireless adapter
>>> connects to some Intel PCI bridges, such as Skylake and Kabylake.
>>> Otherwise, the PCI AER flood hangs system:
>>>
>>> pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
>>> pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
>>> pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
>>> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
>>> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
>>> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
>>> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
>>> pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:00:1c.5
>>> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
>>>
>>> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=218127
>> Seemingly, you can use "Link" or "Closes" tag.
>>
>>> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>>
>>
>>> ---
>>> v2: Add the switch case's default condition with comment:
>>>      "The ASPM has already been enabled by initializing
>>>      rtl8723be_mod_params' aspm_support as 1."
>>>
>>>   .../wireless/realtek/rtlwifi/rtl8723be/sw.c   | 24 +++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
>>> b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
>>> index 43b611d5288d..b20c0b9d8393 100644
>>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
>>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
>>> @@ -25,10 +25,34 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw *hw)
>>>   {
>>>          struct rtl_priv *rtlpriv = rtl_priv(hw);
>>>          struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
>>> +       struct pci_dev *bridge_pdev;
>>>
>>>          /*close ASPM for AMD defaultly */
>>>          rtlpci->const_amdpci_aspm = 0;
>>>
>>> +       /* Disable ASPM if RTL8723BE connects to some Intel PCI bridges, such as
>>> +        * Skylake and Kabylake. Otherwise, the PCI AER flood hangs system.
>>> +        */
>>> +       bridge_pdev = rtlpci->pdev->bus->self;
>>> +       if (bridge_pdev->vendor == PCI_VENDOR_ID_INTEL) {
>>> +               switch(bridge_pdev->device) {
>>> +               case 0x9d15:
>>> +               /* PCI bridges on Skylake */
>>> +               case 0xa110 ... 0xa11f:
>>> +               case 0xa167 ... 0xa16a:
>>> +               /* PCI bridges on Kabylake */
>>> +               case 0xa290 ... 0xa29f:
>>> +               case 0xa2e7 ... 0xa2ee:
>> Out of curiosity, do you have so many real platforms to test?
> We have tested those platforms before, because of the hardware
> enablement.  They all have the same error, and the error bothers
> people many years.
> https://groups.google.com/g/fa.linux.kernel/c/0uz8Nr_NVOI
>
> However, most of them are returned back to the owner now.  By
> accident, we keep the ASUS X555UQ equipped with Intel i7-6500U CPU and
> Realtek RTL8723BE PCIe Wireless adapter on hands for more test.

The device matching that you're doing follows what was also done in 
commit 7184f5b451cf3dc61de79091d235b5d2bba2782d for an ACS quirk on the 
same chipsets.

I'm just curious if the issue is a more universal Intel one and 
can/should be resolved with a pci quirk as opposed to inside an 
individual driver.

>
> Jian-Hong Pan
