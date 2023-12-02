Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F02A801CB1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjLBMpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjLBMpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:45:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A748184
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 04:45:17 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1882023bbfso392438466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 04:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701521115; x=1702125915; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1g8MqwHZBgoNHWh+bYkNb6sIC9zXf19tQTXlJc9qQOU=;
        b=CYkZ+IAixkiWTz0S2FqHBXNvQ6WQ29Wihd3rxHw/7hQSM7xyBki8h23POPGAXRubga
         x1vQboO7th1i7ZJi6Ou+B099ztmrfy8uL4vtf8NEHIFDtAUkk6rZFlxaZaiK0UwGQB5T
         DBY8mtehKl+Wn4DneWzIKX24SMy3Ri6PwUyDKZNmrTRE8Ki3Z4cZzSdALxPFnCkIlTgS
         hw7xZkE4XbLdQftoYWgedK9kyDxIzrV4bXTgrhAO9WDou3c7iJ4cVhTQ7pSgjucD2M+G
         k5xyotlIxKAEu6vcruUYh3mXSBdkLCUjbfBNh0fn5qrd4p73AgJfE+j0jX4+9ntmfFbh
         Q6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701521115; x=1702125915;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1g8MqwHZBgoNHWh+bYkNb6sIC9zXf19tQTXlJc9qQOU=;
        b=q7ER4/fg+vOccORWo3TQRMAsDEgtZH9KbGZWeT4xya7Y+eHnTrgyPGIoy3rHPpG75N
         oc2cRK6X+4OwN2OokUcHfw0bWnc8sBzyon+3IMZzzoa/Ny3ggGFL4peCbdaDpYNcfwdI
         zbvby/J8j+KyT1Pv/tihuhC1jHlpHVzvsSP20Jg1jYBCquuLq7wa67GwmX/Sb/JgehAW
         TMF/I9lY5iNiJpLOmliCB86IJQ4VuvII2/cZZKe/sxcUpHHxMzCu6U/HTcvwvn4nZ9XH
         JxYrbHoWux+2SDxm/dE+kjkQnimjm0TQAS8lejfQjZdQTEE3CGKvpWCxzVo81R5pZ9A7
         Is3A==
X-Gm-Message-State: AOJu0Yz5Kr2Vm1Nmv5mEu/FSmC3FsT/j+xgOG97Nt1TrFPc17X3Nw5Fu
        KRq0fjf448idEmwJqpjPZ0BFI3jdMA==
X-Google-Smtp-Source: AGHT+IHul/Ty6BFqvibyURDrcuceAwFckVUDN6BYvqsuBva/WwjgWdpw138uePY8i0gIimMn0QDYZw==
X-Received: by 2002:a17:906:fb99:b0:9e6:38f2:8439 with SMTP id lr25-20020a170906fb9900b009e638f28439mr1457788ejb.60.1701521115337;
        Sat, 02 Dec 2023 04:45:15 -0800 (PST)
Received: from p183 ([46.53.252.219])
        by smtp.gmail.com with ESMTPSA id qz1-20020a170907680100b00a1a25e756d4sm1658139ejc.107.2023.12.02.04.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 04:45:14 -0800 (PST)
Date:   Sat, 2 Dec 2023 15:45:13 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Willy Tarreau <w@1wt.eu>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nolibc: optimise _start() on x86_64
Message-ID: <38183c29-9b7f-4960-8702-d71ce816cf80@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just jump into _start_c, it is not going to return anyway.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	Also, kernel clears all registers before starting process,
	I'm not sure why

		xor ebp, ebp

	was added.

 tools/include/nolibc/arch-x86_64.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -167,8 +167,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"xor  %ebp, %ebp\n"       /* zero the stack frame                            */
 		"mov  %rsp, %rdi\n"       /* save stack pointer to %rdi, as arg1 of _start_c */
 		"and  $-16, %rsp\n"       /* %rsp must be 16-byte aligned before call        */
-		"call _start_c\n"         /* transfer to c runtime                           */
-		"hlt\n"                   /* ensure it does not return                       */
+		"jmp  _start_c\n"         /* transfer to c runtime                           */
 	);
 	__builtin_unreachable();
 }
