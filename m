Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551B47DF4A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376740AbjKBOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKBOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:11:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96837128;
        Thu,  2 Nov 2023 07:11:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c3443083f2so278059b3a.0;
        Thu, 02 Nov 2023 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698934312; x=1699539112; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeyFP7WMW0RjDqklzVx1kbYfEg/rdHyVxFLBKwTmGxA=;
        b=V8+ZWOUOW+Uog4+J7EeSAkhzKwes2yJQP0hzoVZV/zpmnXrN2PbuC9nzkEyW9BBKCK
         dFtEYkdiStMHP0um+tvHI36YeivsncYupmv9TtcIks0A7svZeUR5N+MUoRa/qdKXsqYA
         01XP9zVVA3sTWhuaoMeENTXEQO2Ml3VKMjycoRsoB8YGRk/BhwlhT5HtjS7tObGwR7+r
         kDPUsW+HaouQSGLoHJ5lKt71X4QpzMdlafbhTgEQTJ+fs/uk9dYSKomrGkW/ilJT3x0C
         ecJ7aVw6F73kG6mEcKEtxA8dVGi1L+CVdu+cSq9ZQK2iazfh2uC9M18wm1eAhXHMOlwU
         r/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934312; x=1699539112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YeyFP7WMW0RjDqklzVx1kbYfEg/rdHyVxFLBKwTmGxA=;
        b=PWymQ8q8qx+EZSsjkhl0GzNavjnYzccwS6irwFpU0Jlk/ySFlslDtnUwgiGJ/AL/Jf
         py1vlu9N+8+Kfr7JYamnFoSAe0HkO0+huSOIEp3Tj59QzszhchVpeKr9A/1Chay+atMP
         K3RMq+O4aNeIV5H4PuS67ycgiUs32GuDvrR1AEFGa0ApK/65chH7AAKDbG21J0wGDAdk
         RcVl0iE3SVbTjV5p6i33+ivAAleUGyEQR5U/zju9iiosPYV/feNAyQtgasP723VTg8NL
         xG74xV2Eu6PjhqzMEE1SAPNeYFySnUiVvJiH5H1PKEc3Q8rZCeAsY42bMheGGeOX5pnW
         Pqzw==
X-Gm-Message-State: AOJu0Yzfqha5lVIoqlRkYL7EefZP5rCsICbFZ4QFhqxuBfSGMzrBp0GI
        je2AUReBj7aDuBa+4xe7KCBwXLLC6LE=
X-Google-Smtp-Source: AGHT+IEOJ0B7C0nr9peL6eqLxZmuiUXorl8e5tMZ2eb2nOkE3SyIQIQwO5CMJg8XGG7sEFw+ZGTAGA==
X-Received: by 2002:a05:6a20:548b:b0:14e:a1f0:a8ea with SMTP id i11-20020a056a20548b00b0014ea1f0a8eamr21471203pzk.3.1698934311673;
        Thu, 02 Nov 2023 07:11:51 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78085000000b006bdc8bb2ed5sm2945197pff.82.2023.11.02.07.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 07:11:50 -0700 (PDT)
Message-ID: <6929ebbf-f2e0-4cd4-addc-1e33ecf3277f@gmail.com>
Date:   Thu, 2 Nov 2023 21:11:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Input Devices <linux-input@vger.kernel.org>
Cc:     Mavroudis Chatzilazaridis <mavchatz@protonmail.com>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jkosina@suse.cz>,
        LinuxCat <masch77.linuxcat@gmail.com>,
        Marcelo <mmbossoni@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Logitech G915 Wireless Keyboard acts weird on 6.6.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hello,
> After upgrading from 6.5.9 to 6.6.0, my keyboard started acting really weird in its wireless mode, key actions sent are completely wrong, see video attached. 
> 
> Most keys are perceived as either E, 3 or F7, with F8 and <, as well. 
> 
> Modifier keys (CTRL, ALT, ALT GR, Shift and Super) are working normally, as well as media control keys (pause/play, previous, next, mute and sound up/down).
> 
> The keyboard works as expected if it's wired.

Another reporter bisected the regression:

> Bisected to 
> 
> 9d1bd9346241cd6963b58da7ffb7ed303285f684 is the first bad commit
> commit 9d1bd9346241cd6963b58da7ffb7ed303285f684
> Author: Mavroudis Chatzilazaridis <mavchatz@protonmail.com>
> Date: Sun Jul 16 18:23:44 2023 +0000
> 
> HID: logitech-dj: Add support for a new lightspeed receiver iteration
> 
> The lightspeed receiver for the Pro X Superlight uses 13 byte mouse reports
> without a report id. The workaround for such cases has been adjusted to
> handle these larger packets.
> 
> The device now reports the status of its battery in wireless mode and
> libratbag now recognizes the device and it can be configured with Piper.
> 
> https://github.com/libratbag/libratbag/pull/1122
> 
> Co-developed-by: Filipe Laíns <lains@riseup.net>
> Signed-off-by: Filipe Laíns <lains@riseup.net>
> Signed-off-by: Mavroudis Chatzilazaridis <mavchatz@protonmail.com>
> Reviewed-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> drivers/hid/hid-ids.h | 1 +
> drivers/hid/hid-logitech-dj.c | 11 ++++++++---
> 2 files changed, 9 insertions(+), 3 deletions(-)

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: 9d1bd9346241cd https://bugzilla.kernel.org/show_bug.cgi?id=218094
#regzbot title: Logitech G915 Wireless Keyboard key event only detects few key codes
#regzbot link: https://streamable.com/ac6l8u

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218094

-- 
An old man doll... just what I always wanted! - Clara
