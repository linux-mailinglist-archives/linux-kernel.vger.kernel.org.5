Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB857C92B8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 06:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjJNEPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 00:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJNEPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 00:15:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575CEC2;
        Fri, 13 Oct 2023 21:15:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9bca1d96cso21891635ad.3;
        Fri, 13 Oct 2023 21:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697256933; x=1697861733; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O29APqEsWzl8rA+94kyGKt13NOeyzSLuuvl18117LsY=;
        b=lYrZReYkj4Ryr5TqwvghSdfONM7+AehD5YMltTBN+sEFBfubtde/lCgynaDn9GBKiH
         Rl3xEWoubI3V3hDv0L3tCOMGSh0m8R+mKFBh/nNgtx3HxK0FOKHaBDRClDg5wy4a3aIW
         oAqZFo2TTOwm7qeOjOuIN7oPj+GQLIquEpb3lETag1xWWOZaLwzg1Ki8YhPDZJK328WD
         yqH9snQjoxbZrWY/aX7fccM6bB68b+FAlPOc8JFYqxPnPSrfzHR60MbHj1cAbe5CE3Jb
         WoQiZMGVyyWAOplmGCY70NbkOd5VyC1DVPB3/pZGfJ9Gs5xxGpbsaJ76Coxao1Gmd/LB
         Bh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697256933; x=1697861733;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O29APqEsWzl8rA+94kyGKt13NOeyzSLuuvl18117LsY=;
        b=HK2A3UYyCQ8uo5SuMGv/T+iItjzD0hBj5CDW1sv7TqtKqhvhqmMVbn5gImOwYoUHOj
         VTHn40S6E3OjYepqmL3dYkYTRNMfCcjF0RE9LQL+QfFUqmkNHGCt4tt2suGUnEnn8oQ9
         7LArRppycNli+oHvBGNK+A4igDUXtTD+RO5eLj5vIYaGAsGzQ9BSO6Qe3qeXaa0EMHyh
         kB0p5idMJLbUn5nA41AAbxMzldIz7La06lh71z7Ie6oCf9BlP4J6sWyxyUT12bx/+Lxc
         GUdtpEUagVMdj2eeH0CxhviMz56LROSsT5MkGuIuqFgDeNDTVBhHTKgvTvWmFctRtvt4
         RRjA==
X-Gm-Message-State: AOJu0YxfxctWVQ8wwHWSLwhtJNPK2iRzK4jF1Y//X9OF4UcOAXcIQOyp
        dA1vgNy+Qi7X29NTXJfkkg0=
X-Google-Smtp-Source: AGHT+IGgyC2DQfSdVc8KSHwyXcSQutk4y8K8RSM6gFxJWr/S1Yeqgh9hjW5kUtKB3XG/U2YYweuA8g==
X-Received: by 2002:a17:902:c950:b0:1c9:d667:4e4a with SMTP id i16-20020a170902c95000b001c9d6674e4amr8589758pla.69.1697256932567;
        Fri, 13 Oct 2023 21:15:32 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:469c:3411:2771:1b7f])
        by smtp.gmail.com with ESMTPSA id m6-20020a1709026bc600b001b8b45b177esm386154plt.274.2023.10.13.21.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 21:15:32 -0700 (PDT)
Date:   Fri, 13 Oct 2023 21:15:29 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.6-rc5
Message-ID: <ZSoV4d4p8RKxEVeG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.6-rc5

to receive updates for the input subsystem. You will get:

- a reworked way for handling reset delay on SMBus-connected Synaptics
  touchpads (the original one, while being correct, uncovered an old bug
  in fallback to PS/2 code that was fixed separately; the new one however
  avoids having delay in serio port "fast" resume, and instead has the
  wait in the RMI4 code)

- a fix for potential crashes when devices with Elan controllers (and
  Synaptics) fall back to PS/2 code. Can't be hit without the original
  patch above, but still good to have it fixed

- a couple new device IDs in xpad Xbox driver

- another quirk for Goodix driver to deal with stuff vendors put in ACPI
  tables

- a fix for use-after-free on disconnect for powermate driver

- a quirk to not initialize PS/2 mouse port on Fujitsu Lifebook E5411
  laptop as it makes keyboard not usable and the device uses
  hid-over-i2c touchpad anyways.


Changelog:
---------

Dmitry Torokhov (2):
      Revert "Input: psmouse - add delay when deactivating for SMBus mode"
      Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport

Hans de Goede (1):
      Input: goodix - ensure int GPIO is in input for gpio_count == 1 && gpio_int_idx == 0 case

Javier Carrasco (1):
      Input: powermate - fix use-after-free in powermate_config_complete

Jeffery Miller (1):
      Input: psmouse - fix fast_reconnect function for PS/2 mode

Matthias Berndt (1):
      Input: xpad - add PXN V900 support

Max Nguyen (1):
      Input: xpad - add HyperX Clutch Gladiate Support

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table

Diffstat:
--------

 drivers/input/joystick/xpad.c         |  4 +++
 drivers/input/misc/powermate.c        |  1 +
 drivers/input/mouse/elantech.c        |  1 +
 drivers/input/mouse/psmouse-smbus.c   | 19 +++++--------
 drivers/input/mouse/synaptics.c       |  2 ++
 drivers/input/rmi4/rmi_smbus.c        | 50 ++++++++++++++++++++---------------
 drivers/input/serio/i8042-acpipnpio.h |  8 ++++++
 drivers/input/touchscreen/goodix.c    | 19 +++++++++++++
 8 files changed, 70 insertions(+), 34 deletions(-)

Thanks.


-- 
Dmitry
