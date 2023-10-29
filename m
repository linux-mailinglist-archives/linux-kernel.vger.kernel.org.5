Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F4F7DAD7C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjJ2RR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjJ2RR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:17:26 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A60CC4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:17:24 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1efa01323b4so918547fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698599843; x=1699204643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aa92vQyBLMDsfUrGLOgAAzxcI/AQl9YQBCGhT8VmX1U=;
        b=KgxtFtFXvaf0/QrQRrO0LjteIm1E9Tkk/m2inWD5tqbHEgLDbSP7EzIqK38Op+/pI+
         EiNr1X0E6iA3xAQ5kZdLbNttzGN2vZMB8NemTvaNmnpgB4TYUsB3uzuZS5CK6ks9vICG
         zcf4BzYjQIoQcTzxo4JOsVD18HYBVwXVHapU48JtCXDngq5OyrmVD6/WGhRSN1DFjfkX
         rtLg+w3AICyRCAdO/AgE5+dX5cgLSjx4NlmyungK8cT3+nv4eHj2ddfalP5CWbGeCqJr
         Lf+BcYHGep2s0TmiOBsd0JtgREKwkChNye8/OnUAkFput+TrMKzcH6H8ek1ZPY4b7vMQ
         7swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698599843; x=1699204643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aa92vQyBLMDsfUrGLOgAAzxcI/AQl9YQBCGhT8VmX1U=;
        b=rYdNDFhckLfC0UdhN4lb3RQoCgyaS/2rykrKVIfJHhUKBuaALgNoTEPcYmui4LfrED
         9x35Hcwdh/bVjG5P3v0x/eFX5+quRPP7Z6zBUak0D8HSh7704oVsxKJWJEGRt4uaXJgz
         2tAvM1c+aan2RscIxwWxwv2hI5pv4QY2lLBTQjo9z+7T3FNhnAwV6wVaTbDAKygnz03+
         Nb/Je9VMd8dwbuIpHoMCQU/4W8XOJNzDHjkaAAEZs30Hi8gn/8SqCP0ku5VNzC9XiGLu
         LBa/VQ4rnIozvRz/j3qCH+WACqzZnuqcNfzVGLq7evKZPY+4TSlDrm9b02U46d5uzKn9
         /zzw==
X-Gm-Message-State: AOJu0YzebvXWVR8ujIUSFrDbmg7xOBQWld3bOr34dSf37s/rcPuerw9d
        ATCZq1q4h7J8PS1ZfXxsD18=
X-Google-Smtp-Source: AGHT+IGfcbrF6D7orwcy3m3cKiu0vuWmbM1NFlNW87iGz/EgtdotK6pF6lZOhx+NU9k9hH7fmkIzTg==
X-Received: by 2002:a05:6870:1eca:b0:1ef:bacc:e4d2 with SMTP id pc10-20020a0568701eca00b001efbacce4d2mr4069002oab.28.1698599843224;
        Sun, 29 Oct 2023 10:17:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006be484e5b9asm4467621pfu.188.2023.10.29.10.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 10:17:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 29 Oct 2023 10:17:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oliver Crumrine <ozlinux@hotmail.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v5 2/6] staging: octeon: remove typedef in enum
 cvmx_helper_interface_mode_t
Message-ID: <32e9ad3c-191e-4dd1-b1cc-07f7b93c3f28@roeck-us.net>
References: <cover.1693236450.git.ozlinux@hotmail.com>
 <PH7PR11MB7643DEB4401AA83A0578087CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7643DEB4401AA83A0578087CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 11:39:07AM -0400, Oliver Crumrine wrote:
> Remove typedef in enum cvmx_helper_interface_mode_t, and rename all instances
> to cvmx_helper_interface_mode
> 
> Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>

In linux-next:

Building mips:cavium_octeon_defconfig ... failed
--------------
Error log:
drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_get_stats':
drivers/staging/octeon/ethernet.c:204:37: error: storage size of 'rx_status' isn't known
  204 |         struct cvmx_pip_port_status rx_status;
      |                                     ^~~~~~~~~
drivers/staging/octeon/ethernet.c:205:37: error: storage size of 'tx_status' isn't known
  205 |         struct cvmx_pko_port_status tx_status;
      |                                     ^~~~~~~~~
drivers/staging/octeon/ethernet.c:205:37: warning: unused variable 'tx_status' [-Wunused-variable]
drivers/staging/octeon/ethernet.c:204:37: warning: unused variable 'rx_status' [-Wunused-variable]
  204 |         struct cvmx_pip_port_status rx_status;
      |                                     ^~~~~~~~~
drivers/staging/octeon/ethernet.c: In function 'cvm_oct_probe':
drivers/staging/octeon/ethernet.c:801:22: error: variable 'imode' has initializer but incomplete type
  801 |                 enum cvmx_helper_interface_mode imode =
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/octeon/ethernet.c:801:49: error: storage size of 'imode' isn't known
  801 |                 enum cvmx_helper_interface_mode imode =
      |                                                 ^~~~~
drivers/staging/octeon/ethernet.c:801:49: warning: unused variable 'imode' [-Wunused-variable]

Bisect points to this patch. Bisect log attached.

As usual, my apologies for the noise if this has already been reported
and/or fixed.

Guenter

---
# bad: [66f1e1ea3548378ff6387b1ce0b40955d54e86aa] Add linux-next specific files for 20231027
# good: [05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1] Linux 6.6-rc7
git bisect start 'HEAD' 'v6.6-rc7'
# good: [5ba945807e7caa7aeb2111b8259f7474919c067b] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect good 5ba945807e7caa7aeb2111b8259f7474919c067b
# good: [dd91766be714f0b06fe9dbba660e37623d8200d4] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
git bisect good dd91766be714f0b06fe9dbba660e37623d8200d4
# good: [06915762e0427a51262d17147ccd28659635452e] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
git bisect good 06915762e0427a51262d17147ccd28659635452e
# bad: [642f5501bdbd0030056348abd970708e8c3bd67b] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect bad 642f5501bdbd0030056348abd970708e8c3bd67b
# good: [ec6cf0d999ec6efbad23438bc24312377a3f4391] Merge branch 'tty-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
git bisect good ec6cf0d999ec6efbad23438bc24312377a3f4391
# good: [c306097335a2d271f64ce8346bd4d1cbe2b30557] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
git bisect good c306097335a2d271f64ce8346bd4d1cbe2b30557
# bad: [b25c17e5c2497d13857772d411142daa20c70e59] staging: qlge: Replace the occurrences of (1<<x) by BIT(x)
git bisect bad b25c17e5c2497d13857772d411142daa20c70e59
# bad: [d50f64b5520311cacf38b8c2c240c5955c815d10] staging: rtl8192e: Resolve circular locking with rx_pkt_pending_timer
git bisect bad d50f64b5520311cacf38b8c2c240c5955c815d10
# good: [87f8e11d5147992fe0b8c232e656be96f778408e] staging: rtl8192e: Replace control subframe types with IEEE80211_STYPE_*
git bisect good 87f8e11d5147992fe0b8c232e656be96f778408e
# bad: [7458fdf8a778b14ad814c9c13695d0c85b210afa] Staging: rtl8192e: Rename variable Time
git bisect bad 7458fdf8a778b14ad814c9c13695d0c85b210afa
# bad: [8d26aa90458f82b952dcaa64e7c4afed9c862d68] staging: octeon: remove typedef in struct cvmx_pko_lock_t
git bisect bad 8d26aa90458f82b952dcaa64e7c4afed9c862d68
# good: [571fa9b51375eee059846c780dce05f04528b065] staging: vme_user: fix check unnecessary blank lines in vme_fake.c
git bisect good 571fa9b51375eee059846c780dce05f04528b065
# good: [7bebd832177670e6cce1783cf144f989cd3cf4b5] staging: octeon: remove typedef in enum cvmx_spi_mode_t
git bisect good 7bebd832177670e6cce1783cf144f989cd3cf4b5
# bad: [28fae776c69bdac005fa77a7e0daa64725d0f4f8] staging: octeon: remove typedef in enum cvmx_pow_wait_t
git bisect bad 28fae776c69bdac005fa77a7e0daa64725d0f4f8
# bad: [a13f7e45823cd29af716ed6be1f53a344e0b9268] staging: octeon: remove typedef in enum cvmx_helper_interface_mode_t
git bisect bad a13f7e45823cd29af716ed6be1f53a344e0b9268
# first bad commit: [a13f7e45823cd29af716ed6be1f53a344e0b9268] staging: octeon: remove typedef in enum cvmx_helper_interface_mode_t
