Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB578EF37
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbjHaOFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345081AbjHaOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:05:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D44E0;
        Thu, 31 Aug 2023 07:05:02 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-792975085b2so33453739f.1;
        Thu, 31 Aug 2023 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693490702; x=1694095502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDYwl4eIi6h/gyUKt1OoObJst40opzW/aVju8PiClbw=;
        b=S2Pg1Wd1xPHm3XaOpGrSJp/ZoyAuR6dP17rVIRc2t12WVbKztNrWv7uBaByvfMeuTp
         acB3A6Wj9CST5uxxZemiOHzGHyS1eE+kVjlj92PSPEcvG1BYGwx+UgktiCth6qyvDyzJ
         vr1Zchz7XUcB+5AKTIbC/NDiDygRecgd5ch+G6pzXRTPtI7RpPpr6uOSHtYkMfFfD5Sz
         g/vYo9Q5ExLufYeijO+jsdOf/MxBQXvgBHx/LTuXL1wHc2Nha76F/akzti45FCR95weA
         Ep1LLxXeDsP+g7cduicpBFsFwNp2RfIQGTrhg1ZXBbCX/lSM+VnM2Dc2VQa9anbobQzZ
         tU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693490702; x=1694095502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDYwl4eIi6h/gyUKt1OoObJst40opzW/aVju8PiClbw=;
        b=LHRmtAgpXN2Prub8n3Up6C/O5PXsUZMKmpQXWZDDTFy+YdiH8b/ogW1tJbjN/2Aedt
         5jWzxz8zGc/DSg3vPjVWmCbERmmL8VNmJGwDnRAUkZm4rNMXbmxIgKheJ3DjuMbdexLX
         tu5QxypVwdQWgHceMCB70Hn9HUBh/M7KDI2wYqvDaJMlbP20JNYA7p2ThIZry7YNEgsz
         rGFHU8NYjXhe1U953AG592cmwFCkRk3IBG0zkbYmQUoKP/GK7pJXgjLlkkhsm3v0rz3d
         x5bI0ngPTBInSPW6eBFboJjyFlRSl61sRbeZndg+Ss//A53KWbEaOgj9T4VO1I7YVYOc
         qkAQ==
X-Gm-Message-State: AOJu0YyvTQlZeXnwA9JuVmSquRsV6wqJVl1fAMHPZXLudoGKGjqAr+C5
        5kPG1ZY9vXMQC0soiOr1jcQvSkSaihY=
X-Google-Smtp-Source: AGHT+IGJDvgnNN8eBDD5q/ZjqmhQeL+FjVbIQhi6XfcgsC0OOVkrKsw/bTxjp3ge/N2ardqbC8tOrQ==
X-Received: by 2002:a6b:dc03:0:b0:792:8230:c175 with SMTP id s3-20020a6bdc03000000b007928230c175mr5367301ioc.6.1693490701753;
        Thu, 31 Aug 2023 07:05:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t8-20020a02c488000000b0042b1061c6a8sm417875jam.84.2023.08.31.07.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:04:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 31 Aug 2023 07:04:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Colin Leroy <colin@colino.net>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh: Explicitly include correct DT includes
Message-ID: <6df12112-0849-4d7b-8f99-d2a7a3560a97@roeck-us.net>
References: <20230714174654.4058898-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714174654.4058898-1-robh@kernel.org>
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

On Fri, Jul 14, 2023 at 11:46:54AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

This patch results in the following build error.

Building powerpc:ppc32_allmodconfig ... failed
--------------
Error log:
drivers/macintosh/ams/ams-input.c: In function 'ams_input_enable':
drivers/macintosh/ams/ams-input.c:68:45: error: invalid use of undefined type 'struct platform_device'
   68 |         input->dev.parent = &ams_info.of_dev->dev;
      |                                             ^~
drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
drivers/macintosh/ams/ams-input.c:146:51: error: invalid use of undefined type 'struct platform_device'
  146 |         return device_create_file(&ams_info.of_dev->dev, &dev_attr_joystick);
      |                                                   ^~
drivers/macintosh/ams/ams-input.c: In function 'ams_input_exit':
drivers/macintosh/ams/ams-input.c:151:44: error: invalid use of undefined type 'struct platform_device'
  151 |         device_remove_file(&ams_info.of_dev->dev, &dev_attr_joystick);
      |                                            ^~
drivers/macintosh/ams/ams-input.c: In function 'ams_input_init':
drivers/macintosh/ams/ams-input.c:147:1: error: control reaches end of non-void function 

Bisect log attached.

Guenter

---
# bad: [b97d64c722598ffed42ece814a2cb791336c6679] Merge tag '6.6-rc-smb3-client-fixes-part1' of git://git.samba.org/sfrench/cifs-2.6
# good: [1c59d383390f970b891b503b7f79b63a02db2ec5] Merge tag 'linux-kselftest-nolibc-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
git bisect start 'HEAD' '1c59d383390f'
# good: [53ea7f624fb91074c2f9458832ed74975ee5d64c] Merge tag 'xfs-6.6-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect good 53ea7f624fb91074c2f9458832ed74975ee5d64c
# good: [4fb0dacb78c6a041bbd38ddd998df806af5c2c69] Merge tag 'sound-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 4fb0dacb78c6a041bbd38ddd998df806af5c2c69
# good: [05c618f39089d977b0c3dc1105cb6cd5fc53cd01] arm64: dts: use capital "OR" for multiple licenses in SPDX
git bisect good 05c618f39089d977b0c3dc1105cb6cd5fc53cd01
# bad: [4a3b1007eeb26b2bb7ae4d734cc8577463325165] Merge tag 'pinctrl-v6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect bad 4a3b1007eeb26b2bb7ae4d734cc8577463325165
# good: [47ca50600efcf994adb62a9a4e75c77d91bd0781] Merge tag 'soc-defconfig-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 47ca50600efcf994adb62a9a4e75c77d91bd0781
# good: [8f447694c23a432b2e9cfe67fb2651f8f6655bfd] Merge tag 'devicetree-for-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect good 8f447694c23a432b2e9cfe67fb2651f8f6655bfd
# good: [cd40a1ffddc963e69884a713d8704edd98035861] Merge tag 'qcom-pinctrl-6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt into devel
git bisect good cd40a1ffddc963e69884a713d8704edd98035861
# good: [82a65f0844852cec6a70ac05c7d8edb0586c851c] Merge tag 'intel-pinctrl-v6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into devel
git bisect good 82a65f0844852cec6a70ac05c7d8edb0586c851c
# bad: [ef2a0b7cdbc5b84f7b3f6573b7687e72bede0964] Merge tag 'devicetree-header-cleanups-for-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect bad ef2a0b7cdbc5b84f7b3f6573b7687e72bede0964
# bad: [233d687d1b78080ee79f67356327e0e0e50ef6f5] macintosh: Explicitly include correct DT includes
git bisect bad 233d687d1b78080ee79f67356327e0e0e50ef6f5
# good: [6303d0693f7d6c44bb6eb0b29c906ee28156dd28] clocksource: Explicitly include correct DT includes
git bisect good 6303d0693f7d6c44bb6eb0b29c906ee28156dd28
# good: [32bc7297d855608fcb13af62a95739a079b4f8e2] hte: Explicitly include correct DT includes
git bisect good 32bc7297d855608fcb13af62a95739a079b4f8e2
# first bad commit: [233d687d1b78080ee79f67356327e0e0e50ef6f5] macintosh: Explicitly include correct DT includes
