Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D4B7CC6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbjJQPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbjJQPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:01:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B5185;
        Tue, 17 Oct 2023 08:01:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507c50b7c36so287834e87.3;
        Tue, 17 Oct 2023 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697554882; x=1698159682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij6F2CslW6WIg30gxQ5rSpy+yOTNiOhd71ErNR12JCY=;
        b=lruQ5ixir4k6pZClagb9pGXklKz5xRCuz+QNVuMH4iueJYdtQ7pFmksJIoMLi6ZgUL
         DMh5hk662bQzZh8ru2zY/L+2Q8+QGHjYRaNfkYnbHy3yOL3uu3btQ2OmC/A5sSF7ADMa
         8L2cCAEefarhtlGLZXS6QqWk8fxsF4g0NtomSnaS2ajfMsCT/4AOHur046NRN7mIW2gn
         Lm6m5mjeqRR5EOHUigEvxpBuN0lwnR4HE4OdKk5IqSCYYSykRssbyPwXodP4Fmef9QY7
         WXcFUCa05g8P+Els2ygpyJY5/FIdwbVeTf5bf0dtV0gOCOTi8FJuo/8URsInD/GcueDT
         RC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697554882; x=1698159682;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij6F2CslW6WIg30gxQ5rSpy+yOTNiOhd71ErNR12JCY=;
        b=XFjF9+4yVq8cVsWdJLVNJc2bKsKwS6aiJh2ESUIcUGohcGtiZWnT2MobpfytyXaa2J
         jwYBahtN26Iau/e/u8DGpy9mwCoX9rwUZ3VdsXIEVTHOJjw8s5XXoOSYbLPAA7RvOnaE
         Q4S9MVeeMqo2g3N5eReJ/tx2K9lOKMjdygH5JkzmN3m36hZFmKmUATv3/9cWsk8j2x8A
         S0m9EpE7ScVDoQof5BoiMqDp7C3f1JHSPvwTS6w3WDas0F7SkorRwOhiUOJpBejOG+of
         hxekT2WCaKlQLQcrI+OApISfB7ittesekrJN9FkKw7ZFk9NRVM3QdFJ1CBZSsZ/A95JL
         vtjA==
X-Gm-Message-State: AOJu0YwPx0x86QHOqZAAeFmLPbPb2mBQs63vDqoK/zdswdOAY9ub4IxV
        EMc/VgaY2EDGWo2YTOrS30o7yNRdYPQ=
X-Google-Smtp-Source: AGHT+IEHBNdlz81U28CYvjPBW0/zcyTV71TfSTVDLMGqqjz0XcELkNyFQELvZ4ucDPGXA0eXNxs/TQ==
X-Received: by 2002:a05:6512:613:b0:507:9fc1:ca7e with SMTP id b19-20020a056512061300b005079fc1ca7emr1802933lfe.51.1697554881567;
        Tue, 17 Oct 2023 08:01:21 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id c64-20020a509fc6000000b0053ebafe7a60sm1409692edf.59.2023.10.17.08.01.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:01:20 -0700 (PDT)
From:   Arend van Spriel <aspriel@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Date:   Tue, 17 Oct 2023 17:01:19 +0200
Message-ID: <18b3e27d218.279b.9696ff82abe5fb6502268bdc3b0467d4@gmail.com>
In-Reply-To: <87fs2k5l1a.fsf@kernel.org>
References: <87fs2k5l1a.fsf@kernel.org>
User-Agent: AquaMail/1.47.0 (build: 104700356)
Subject: Re: [RFH] wireless-next: fix new W=1 warnings
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 9, 2023 9:10:11 AM Kalle Valo <kvalo@kernel.org> wrote:

> Hi,
>
> During the weekend we updated wireless-next tree from v6.5 to v6.6-rc4+.
> It looks like a new warning was enabled for v6.6 as I see with GCC 13.2
> and W=1 several warnings (list below). In v6.5 wireless code was still
> W=1 warning free with GCC.

Can't say I am a big fan of this new warning, but I will look at the 
brcmfmac related warnings.

Btw. is it possible to opt out per driver.

Regards,
Arend

>
> For wireless we get lots of questionable cleanup patches. But actually
> these kind of warnings are what we would prefer to be fixed instead of
> the random churn we always see. Hence I'm sending this Request For Help
> (RFH) in case the cleanup people would fix these. Is there a mailing
> list I should send this to?
>
> The sooner these are fixed the better, it makes it difficult for us to
> see any new warnings from this noise.
>
> Kalle
>
> drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:63: warning: '%s' 
> directive output may be truncated writing up to 63 bytes into a region of 
> size 32 [-Wformat-truncation=]
> drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:9: note: 'snprintf' 
> output between 4 and 140 bytes into a destination of size 32
> drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:63: warning: '%s' 
> directive output may be truncated writing up to 63 bytes into a region of 
> size 32 [-Wformat-truncation=]
> drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:9: note: 'snprintf' 
> output between 4 and 98 bytes into a destination of size 32
> drivers/net/wireless/intel/iwlwifi/dvm/main.c:1467:19: warning: '%s' 
> directive output may be truncated writing up to 63 bytes into a region of 
> size 32 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/dvm/main.c:1465:9: note: 'snprintf' 
> output between 1 and 64 bytes into a destination of size 32
> drivers/net/wireless/intel/iwlwifi/mvm/ops.c:1307:19: warning: '%s' 
> directive output may be truncated writing up to 63 bytes into a region of 
> size 32 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/mvm/ops.c:1305:9: note: 'snprintf' 
> output between 1 and 64 bytes into a destination of size 32
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:52: 
> warning: '%d' directive output may be truncated writing between 1 and 5 
> bytes into a region of size 4 [-Wformat-truncation=]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:46: note: 
> directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:46: note: 
> directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:262:9: note: 
> 'snprintf' output between 9 and 17 bytes into a destination of size 9
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:55: 
> warning: '%d' directive output may be truncated writing between 1 and 5 
> bytes into a region of size 4 [-Wformat-truncation=]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:48: note: 
> directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:48: note: 
> directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:265:9: note: 
> 'snprintf' output between 10 and 18 bytes into a destination of size 10
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:50: 
> warning: '/' directive output may be truncated writing 1 byte into a region 
> of size between 0 and 4 [-Wformat-truncation=]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:42: note: 
> directive argument in the range [0, 65535]
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c:342:9: note: 
> 'snprintf' output between 10 and 18 bytes into a destination of size 10
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:549:33: warning: '%s' 
> directive output may be truncated writing up to 63 bytes into a region of 
> size between 48 and 56 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:547:9: note: 'snprintf' output 
> 9 or more bytes (assuming 80) into a destination of size 64
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:729:33: warning: '%s' 
> directive output may be truncated writing up to 63 bytes into a region of 
> size between 48 and 56 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:727:9: note: 'snprintf' output 
> 9 or more bytes (assuming 80) into a destination of size 64
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:989:51: warning: '%s' 
> directive output may be truncated writing up to 63 bytes into a region of 
> size between 46 and 58 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:987:33: note: 'snprintf' 
> output between 7 and 82 bytes into a destination of size 64
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:984:53: warning: '%s' 
> directive output may be truncated writing up to 63 bytes into a region of 
> size between 40 and 50 [-Wformat-truncation=]
> drivers/net/wireless/intel/iwlwifi/iwl-drv.c:982:33: note: 'snprintf' 
> output between 15 and 88 bytes into a destination of size 64
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:51: warning: '%d' directive 
> output may be truncated writing between 1 and 3 bytes into a region of size 
> 2 [-Wformat-truncation=]
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:48: note: directive argument 
> in the range [0, 255]
> drivers/net/wireless/ath/ath11k/debugfs.c:1597:9: note: 'snprintf' output 
> between 5 and 7 bytes into a destination of size 5
> drivers/net/wireless/ath/ath9k/hif_usb.c:1223:42: warning: '.0.fw' 
> directive output may be truncated writing 5 bytes into a region of size 
> between 4 and 11 [-Wformat-truncation=]
> drivers/net/wireless/ath/ath9k/hif_usb.c:1222:17: note: 'snprintf' output 
> between 27 and 34 bytes into a destination of size 32



