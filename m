Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4064A7EBA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 01:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjKNX7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjKNX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:59:16 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB6C2;
        Tue, 14 Nov 2023 15:59:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc316ccc38so49023915ad.1;
        Tue, 14 Nov 2023 15:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700006352; x=1700611152; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U28cHFzBVkR11z4RuPSvS1sL4RTNO+cnLUGQEPnb7SU=;
        b=ItE+1blxL4WXLi85dgykTPHnVvjfIVJzPkcVw2q3zch2y2bcYEfda3DzDgpvHbATtb
         kxf/qLcw3HblbNrPlbSZTT26pYECC0+sNmBK7rIAeQuM7INrl/yfVGe/5YRkgqr4tJdT
         k4OEvXJoBkJSqp1d4yY0p0NReE7sSasMo4EqoqGeAZIMElK2dF44z/xVkOalQTpTFEyI
         WWtbbeqK1MWfNWnPANhfmJcPobxF75xFE+WVWsGDOjndofz4hhZ90l+DF1KXjR5ka8Au
         PObw55nENkLOrLl4h4CwumOhQ7gDTuj+t7v5aPYP9wa923dWugR0BhfOvhKNKIevbeWv
         WEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700006352; x=1700611152;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U28cHFzBVkR11z4RuPSvS1sL4RTNO+cnLUGQEPnb7SU=;
        b=RpG1HwU9/bRpRQr166nPEuGHGTt2KGx7lfZz9RaI1VESwz10f4LoLk2hpLFemhXC1E
         wn2ukyOo9SzA76maBoj/DRb/KrAo4LrT8t79U2BmfeJpWyWP/e8VbvTOi1W/CVAz+H0f
         GuDCf91URQruCgrH9EE8KXxP99ARj8pbkTlvkd7M8PuEknE9XiEiKEzPuG4kR+5B9Ay7
         35XWYv5GlzWIJbuWhmUAARcCQhF95cD+jdH7aRMYkFX3LbwkQSPYMtF7m+tl6QHDrEgn
         IBdsk94BYypqrDWZGrdHkS+AS1kd6XhZmUhSInvhpdnmL4XR0KiRjeqrZqyIJK3PvF8K
         qG/g==
X-Gm-Message-State: AOJu0Yw8XmiMk2jWHwrnU2ude1po0qkOYv7petYU8pj7V1zyrwnf+hn/
        mwMDJLSo0vpqHVUIeB+cK3QANRf0d9oNvg==
X-Google-Smtp-Source: AGHT+IFMeftzfcV39U6BZ/StdmHwqGFz5CwiraE6RrTHkQW6l2CoWrog5MrXkcFrCsLrAiB8ZOrAjw==
X-Received: by 2002:a17:902:6808:b0:1cc:3ac9:7189 with SMTP id h8-20020a170902680800b001cc3ac97189mr3780268plk.7.1700006352543;
        Tue, 14 Nov 2023 15:59:12 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b001bc21222e34sm6190560plg.285.2023.11.14.15.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 15:59:12 -0800 (PST)
Message-ID: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
Date:   Wed, 15 Nov 2023 06:59:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Ivan Vecera <ivecera@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Anil Choudhary <anilchabba@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: sr-iov related bonding regression (two regressions in one report)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten and all,

I come across LACP bonding regression on Bugzilla [1]. The reporter
(Cc'ed) has two regressions. The first is actual LACP bonding
regression (but terse):

> Till linkx kernel 6.5.7 it is working fine, but after upgrading to 6.6.1 ping stop working with LACP bonding.
> When we disable SR-IOV from bios , everything working fine

And the second is out-of-tree module FTBFS:

> Also we are not able to compile 
> driver: ice
> version: 1.12.6
> We are getting following error.
> 
> 
> 
> With inter driver code(version 1.12.6) while complaining I am getting following error.
> /root/1.12.6/build/src/ice_txrx.h:363:29: error: field ‘xdp_rxq’ has incomplete type
>   363 |         struct xdp_rxq_info xdp_rxq;
>       |                             ^~~~~~~
> /root/1.12.6/build/src/ice_main.c: In function ‘ice_remove_recovery_mode’:
> /root/1.12.6/build/src/ice_main.c:1540:9: error: implicit declaration of function ‘pci_disable_pcie_error_reporting’ [-Werror=implicit-function-declaration]
>  1540 |         pci_disable_pcie_error_reporting(pf->pdev);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /root/1.12.6/build/src/ice_main.c: In function ‘ice_probe’:
> /root/1.12.6/build/src/ice_main.c:7046:9: error: implicit declaration of function ‘pci_enable_pcie_error_reporting’ [-Werror=implicit-function-declaration]
>  7046 |         pci_enable_pcie_error_reporting(pdev);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:243: /root/1.12.6/build/src/ice_main.o] Error 1
> make[2]: *** [/usr/src/linux-headers-6.6.0-rc7-vdx/Makefile:1913: /root/1.12.6/build/src] Error 2
> make[1]: *** [Makefile:234: __sub-make] Error 2
> make[1]: Leaving directory '/usr/src/linux-headers-6.6.0-rc7-vdx'
> make: *** [Makefile:174: all] Error 2

Should I add the first regression to regzbot (since the second one
is obviously out-of-tree problem), or should I asked detailed regression
info to the reporter?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218139

-- 
An old man doll... just what I always wanted! - Clara
