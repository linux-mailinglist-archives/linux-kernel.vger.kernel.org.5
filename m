Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AAC79B000
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjIKUsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbjIKOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:42:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B771012A;
        Mon, 11 Sep 2023 07:42:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdf4752c3cso30794045ad.2;
        Mon, 11 Sep 2023 07:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694443321; x=1695048121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9mEfdNRBv36Id6cA4R/qaRT3o+SLZtHn5FXKarxxl0=;
        b=eWaY4oWEtOSQLEjmOIoh68uWloyti+GLsFACOlDTqFssjAefpC5xbWk81KW8iEfpa5
         nGE9VL4lHxrrPVnZjSxOlvmmnDw/QDQLYAeg3R+Y4DhrfQf+8aSo2n5taTJaLvwQxSMk
         J0XSZhh+7k4/oe2efkIRmscoJE5zpTdrdSRuTXEJv1Ob4xTQMdrGXCJmMIUv4IwSH85x
         0GXoDYlPWMQY2HQNsgoizzPaU9T3V8W+OQyppWVfxxCbPGdw7daG+/yhoFPoNgceci53
         rWrBG5eTWq+uVm+Z2MZU8rOkZCZMBSF3Edegb9GPRpX57deFLEJubTO2m6gju6xVYnrm
         0EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694443321; x=1695048121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9mEfdNRBv36Id6cA4R/qaRT3o+SLZtHn5FXKarxxl0=;
        b=xNOhNokChhKu5uF34vFDhA3WfTAD7OEX0A7j2t9Hx4HGIjwqRFq6p3+7aPc6GDBF9R
         8ftuZ66tasg/9+VPwWbFao8oW3c1+CadNN77zpsc19CmV83mGp/kkoxinr69wVwYH68U
         WRUVQM4ZEpilsEs7f/Sq2IgsmrQLAz30uTJPkNcCHncr0XZ6h3Rz/gScLJLmciwrR7Qt
         QGELEpgf991A7QinrsWJXXWGS7iZO9MaWnI9b2DXWGYnrxN5U0hIN9Z4VGmGxqEyx+JF
         19ELhhLinThJXQFrKJleToUzEaZMaZ0T+WD5j/jHmHUNw2eDSG3Ui7rhoXNHEYgQuFXh
         MTKg==
X-Gm-Message-State: AOJu0YyIH0oyfvHJUAc3bBbH0+pscfcjHHWQDAW8C16RE/ZTK2O0RkrB
        QJZcfav9ZQjlcQHI23Y7agQ=
X-Google-Smtp-Source: AGHT+IHerRZcuoZ5Ogx/usT5Z5o59ZjgUHMFuEAUjJXNeU3xg03bZYLFnT5ZxjM6OQ/cK0kZZ9R6vg==
X-Received: by 2002:a17:902:d4c6:b0:1c3:8464:cad1 with SMTP id o6-20020a170902d4c600b001c38464cad1mr9611340plg.26.1694443320803;
        Mon, 11 Sep 2023 07:42:00 -0700 (PDT)
Received: from localhost.localdomain (220-133-92-232.hinet-ip.hinet.net. [220.133.92.232])
        by smtp.googlemail.com with ESMTPSA id kb14-20020a170903338e00b001b8a2edab6asm6594337plb.244.2023.09.11.07.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 07:42:00 -0700 (PDT)
From:   xx777 <zenmchen@gmail.com>
To:     zenmchen@gmail.com
Cc:     Jes.Sorensen@gmail.com, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com, rtl8821cerfe2@gmail.com
Subject: Re: [PATCH] wifi: rtl8xxxu: fix LED control code of RTL8192FU
Date:   Mon, 11 Sep 2023 22:41:45 +0800
Message-ID: <20230911144155.5871-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230910002038.56362-1-zenmchen@gmail.com>
References: <20230910002038.56362-1-zenmchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote：
>
> Can you explain in the commit message why you changed the
> LED_ON and LED_OFF branches? It's not obvious to me and they
> don't have anything to do with the hardware-controlled blinking.
>

Hi,

Sorry that I didn't explain this clearly.
After some researches these days, I came to some conclusions:

1. The LED of MERCURY MW310UH and COMFAST CF-826F seems to be controlled by
   REG_LEDCFG1, and currently rtl8xxxu controls the LED through writing
   some suitable values to this register, so MW310UH and CF-826F work fine
   with rtl8xxxu.

2. The LED of ASUS USB-N13 C1 seems to be controlled by another register 
   "REG_LEDCFG0" for unknown reason, so when I write 1 or 2 to 
   /sys/class/leds/rtl8xxxu-usbX-Y/brightness, the LED doesn't turn on 
   or blink because the register "REG_LEDCFG0" is not filled with a suitable 
   value, This is why I changed the LED_ON and LED_OFF branches.

I will modify the commit message in the next version of patch, thanks.
