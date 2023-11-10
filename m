Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521A97E8020
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjKJSFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbjKJSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:04:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358E9ED0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 00:26:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32da7ac5c4fso1044197f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 00:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699604816; x=1700209616; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Sl6LMd5GvY2HGP4rRStwyGMOVlrH/dOjLpczszfQNw=;
        b=dVMwdMh7csv6ocS6Dn7T4xfuJ7I+6vh9XgT5fDmLsTKqmtCc854XNBLTYIRQbFNE4J
         yzFeBqXtk422Td9xptMQW6yvadSLHyVEchXOkVvyTA0cm1Vw0eMBNVzyoyjEYGOmkODv
         L4q52QXVzUykwCqYQKP3GeWAaAYWTvGjyflwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699604816; x=1700209616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Sl6LMd5GvY2HGP4rRStwyGMOVlrH/dOjLpczszfQNw=;
        b=dsuac1x2HxW19RRohrNV3Iw/Vw2LXyIjmhd0aEORqC2K0I1AcqT/ndhic/sDoy2hj0
         2FLsoSMDMkpmzuE2uZG+mx2I+T1RkEzvMuLTmW1apRkPjb5/uEGxKSg6AIK26FUz+Bqf
         VlSg6mYoLQBMe/vATFXGdt3XFD5Eohl3mwasGMMGSgG0aONyJPqkz/9k2GzGza4ZtIz6
         3Wf1P6PSruafVUOHPmWds6J6k6mif18KCzyME9YC55DoHx8ul6Emr/cb7DW9CejbOZbC
         rIs2GYjCJhP5pGlMqJfWra5dktz5sl2r2f3tvj1rhdpUrlsFRNmnnwBhHCN9aPBwZ3sc
         iX2g==
X-Gm-Message-State: AOJu0YyxE0VwZM6A7sLsY49NEJMXpFk4HOf2AyBjI2xPbGXOObrGV5yV
        cJjnObUzhbxP6q6xtc+gqYzJOQ==
X-Google-Smtp-Source: AGHT+IFa/6wfx+9kLbmLi8ldMycAx55pGtShVMYgpoK2iaa/HjZ2LPKqxCeLbkFt09pu6AmXKiAvUQ==
X-Received: by 2002:adf:8b14:0:b0:331:3a1e:b85 with SMTP id n20-20020adf8b14000000b003313a1e0b85mr971558wra.22.1699604815657;
        Fri, 10 Nov 2023 00:26:55 -0800 (PST)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id z14-20020a056000110e00b0032f7cc56509sm1391486wrw.98.2023.11.10.00.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 00:26:55 -0800 (PST)
Date:   Fri, 10 Nov 2023 08:26:53 +0000
From:   Kornel =?utf-8?Q?Dul=C4=99ba?= <korneld@chromium.org>
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?utf-8?Q?Stanis=C5=82aw?= Kardach <skardach@google.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable LPM during initialization
Message-ID: <ZU3pTY0qbA6cDB7f@google.com>
References: <20231109111934.4172565-1-korneld@chromium.org>
 <CAG-rBijqw2VO8AQbwBh5Cu47gBbDsOGwPgw-8hSXMWCHXi6GLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG-rBijqw2VO8AQbwBh5Cu47gBbDsOGwPgw-8hSXMWCHXi6GLw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

>Hi Kornel, see below.
>
>On Thu, Nov 9, 2023 at 6:20 AM Kornel Dulęba <korneld@chromium.org> wrote:
>>
>> To address IO performance commit f9e5b33934ce
>> ("mmc: host: Improve I/O read/write performance for GL9763E")
>> limited LPM negotiation to runtime suspend state.
>> The problem is that it only flips the switch in the runtime PM
>> resume/suspend logic.
>>
>> Disable LPM negotiation in gl9763e_add_host.
>> This helps in two ways:
>> 1. It was found that the LPM switch stays in the same position after
>>    warm reboot. Having it set in init helps with consistency.
>> 2. Disabling LPM during the first runtime resume leaves us susceptible
>>    to the performance issue in the time window between boot and the
>>    first runtime suspend.
>>
>> Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
>> ---
>>  drivers/mmc/host/sdhci-pci-gli.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>> index d83261e857a5..ce91d1e63a8e 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -220,6 +220,9 @@
>>
>>  #define GLI_MAX_TUNING_LOOP 40
>>
>> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
>> +                                             bool enable);
>> +
>>  /* Genesys Logic chipset */
>>  static inline void gl9750_wt_on(struct sdhci_host *host)
>>  {
>> @@ -1281,6 +1284,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
>>         if (ret)
>>                 goto cleanup;
>>
>> +       /* Disable LPM negotiation to avoid entering L1 state. */
>> +       gl9763e_set_low_power_negotiation(slot, false);
>> +
>>         return 0;
>
>What happens if the bridge is not driving the system rootfs? Imagine
>the case where
>the bridge is used to drive an auxiliary eMMC, unused until a few hours
>after boot. After this patch, the bridge may remain active (not-L1)
>for the entire time,
>although it's not being used...

That's already addressed by runtime PM. LPM negotiation will be
re-enabled duing the first runtime suspend. The default autosuspend
delay for all PCI MMC controllers is 50ms, so I think that's fine.
The only scenario where LPM will never be entered is if the user
explicitly disabled runtime PM for the controller. In that case however,
it's arguably better to have the LPM negotiation disabled for the sake 
of performance.

>
>I suspect we want the following:
>1. consistency - LPM register setting and runtime_pm state must agree
>2. power-efficient initial state - bridge must come out of probe
>runtime-suspended
>and LPM must be enabled
>
>I suspect the above will be fulfilled if we do
>
>+ /* Bring to consistent runtime suspended state with LPM negotiation enabled */
>+ gl9763e_set_low_power_negotiation(slot, false);
>+ pm_runtime_set_suspended(dev);
>
>WDYT?

I don't think this is something that we want do to. Apart from my
argument above there is one more thing to consider.
During runtime PM initialization in sdhci_pci_runtime_pm_allow
the usage counter is dropped using pm_runtime_put_noidle,
which doesn't trigger the machinery to suspend the device.
According to the comment that's because the mmc core logic will shortly
talk to the device, probably to initialize the eMMC card itself.

>
>>
>>  cleanup:
>> @@ -1323,7 +1329,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>>  }
>>
>> -#ifdef CONFIG_PM
>>  static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
>>  {
>>         struct pci_dev *pdev = slot->chip->pdev;
>> @@ -1349,6 +1354,7 @@ static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool
>>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>>  }
>>
>> +#ifdef CONFIG_PM
>>  static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>>  {
>>         struct sdhci_pci_slot *slot = chip->slots[0];
>> --
>> 2.42.0.869.gea05f2083d-goog
>>
