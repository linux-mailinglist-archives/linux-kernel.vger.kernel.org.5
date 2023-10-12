Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5045E7C6A03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjJLJw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJLJw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:52:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0CDA9;
        Thu, 12 Oct 2023 02:52:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d292d38c0so26567a91.1;
        Thu, 12 Oct 2023 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697104376; x=1697709176; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GPcG4HISW15HdH/wIIcwcI9FurWIe0F/LA1VfavK10=;
        b=a+i1Lu5rxeqYy+k+eTVqMTOsP6tSubXcxODUVlYyypqk1Bu+oYoe++zSdAw2OhzJk2
         hkTEXPHxE9B5ACTtbOXNoX0IMai8gXFIA7MrhV65BepDaBvJX8J4jNUpedGQDU/MrCXH
         90tPeSam7ZI5jPngU0QRuFCKhAgtvSQO3/Oy27no+I3MkAtHwi4UovNxXgcNPXRZLpmI
         8SlIDXPjrlfo34uE/6fuP1Xl5Eb26yJ3G111FqdrjFeEZIOggx3h6b+Z+f8ejUKcRgB/
         mqprNnNFyF0KBgjIRFNv5eMrgbfBU+bNklmn5xlJCoKx42fw6UzNhXefcuUlfKKe9a2M
         VvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697104376; x=1697709176;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5GPcG4HISW15HdH/wIIcwcI9FurWIe0F/LA1VfavK10=;
        b=pG3hlKH/tdAOYWjbjIavsjjDYjMw7UxjWW4oyCQRo06xo8HAhE+PU68Dutk4mVd7A0
         K9X7GXJ18RLF0/PLEFosoEjTLmH3JA6l1DG/4jwqY5TeU2wOja5a4YaWAhQWy/aZHp03
         JCS7/gAIOBgZbGTPWDQW7GT288Akvb+4LHit4gwAKpnGxUh6jB3osCDgHD1sme9HWDxH
         6bTFasQiweKLnV5kQp5fCPYa5eqoXIY8Jj0397F7uvKHBUlfeHh4eiPGQbmMaD2HOa5X
         O4ayfWHPMyq8qDqsQh2cdQFEtggOWqxZH5Vz63HsNpkyVlwK56nBa3305/1XValW/Kky
         qQXw==
X-Gm-Message-State: AOJu0Yx3WKpF7Jxw1gm0Yr0xbl/pg1AgMLblwKttzd0+/AgsT/ctl60r
        xvHfhU0i1ITOiQojUa5IiAeEAVdqqv0=
X-Google-Smtp-Source: AGHT+IE8Oe9KXbpDRNnlaCTZlxxhVs6faIab8J1drxYmO04exZINnSUsvkzdXNKkoTcZ/bL1+Zzl/A==
X-Received: by 2002:a17:90a:b78f:b0:26f:7555:76 with SMTP id m15-20020a17090ab78f00b0026f75550076mr20070356pjr.11.1697104375764;
        Thu, 12 Oct 2023 02:52:55 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z18-20020a17090abd9200b002609cadc56esm1421733pjr.11.2023.10.12.02.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 02:52:55 -0700 (PDT)
Message-ID: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
Date:   Thu, 12 Oct 2023 16:52:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wireless WAN <linuxwwan@intel.com>
Cc:     M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Intel 7560 LTE Modem stops working after resuming from standby
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I noticed a few days ago, after Fedora moved to Kernel 6.5, that my Intel LTE Modem was not working anymore after resuming from standby. 
> 
> The journal listed this error message multiple times:
> kernel: iosm 0000:01:00.0: msg timeout
> 
> It took me a while to determine the root cause of the problem, since the modem did not work either in the following warm reboots. 
> Only a shutdown revived the modem.
> 
> I did a bisection of the error and I was able to find the culprit:
> 
> [e4f5073d53be6cec0c654fac98372047efb66947] net: wwan: iosm: enable runtime pm support for 7560

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: e4f5073d53be6c https://bugzilla.kernel.org/show_bug.cgi?id=217996
#regzbot title: pm support for Intel 7560 makes the modem stops working after resume

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217996

-- 
An old man doll... just what I always wanted! - Clara
