Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08DF797DE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbjIGVWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbjIGVWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:22:46 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A163D1BDD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 14:22:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41205469f4eso6889841cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694121742; x=1694726542; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JD1qUvsvAX9N/vVCrpfCLXVIE/WE2QZDGkSKm97kqyY=;
        b=lI8TQW6RMICIM0XfzVoZ/zUXYZQNEKybD4UPGtqw1sUOVXPx/B/flGHvwlptMplBKa
         ZfQKd9+xZyTCjUUatlaEj2VTkvjh9HmwmwTFRRuV3POBsnW9b96yIFG91knc8jdKjtzs
         aUxBf5gqXOKoZLd/9s+LqnzJFNMN2Sb4uuCFVpioVglliBruqAKhdFhNlwwzKUNBuXcR
         RBlqVg2zfrRl7YQkkSkswCIues8AR5aoHpYXdePcfZMXjfLu/uxMFMOhymCo2L4dhMwj
         HRogE9t1YMOsWVUAMR2HR+iodH3mLENCm8oKYP3vDa82cPY2jzwHbcC7GNL6s4Dq4zJq
         IEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694121742; x=1694726542;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD1qUvsvAX9N/vVCrpfCLXVIE/WE2QZDGkSKm97kqyY=;
        b=RSACK51QQHEq/aPUwItzv7QQwlDqcOED15c4TkCIFS7CvlKJGhick8y5jlUvgxXkh+
         CGqxb9J12cFNB9/gYp+2l0/SHfcRcOCTgRFqixQNl2pj++rfzynq2UKv9MPz9+9YDLaX
         ZpjFrkK5PnCLaYYJ3Dsltx4lF+WWW1uyNpHF83Qzl67cBoyWeuanEUuCaYKZHLsCfmmj
         FbMuhoNkf74LOg0WSzwNn10N8w3MoCKTFVPq6G4JLWUDaPCVP2bTm4Dl96qt2bBNsdmm
         hFsr0U+1U+m/Lth6Q5AnWrHxN1knIgYbiVf1mgFcoMDtXxV9J7xSs7kHtWyX+t9yVwFX
         SnlQ==
X-Gm-Message-State: AOJu0Yyh0qLhBBGP7wHvRBmtT+K3K6hebFX1p9m/pbrpQhhjKUba2Bi+
        ObMd94wLeaIRZTWlQYl0sxA=
X-Google-Smtp-Source: AGHT+IEiAIPFTI41Jj56iUto48HXvzHdyuVUvnv1XAhN0K/RRh5y1bNSFX429MlpDQ5jZ7SEoSQzLA==
X-Received: by 2002:ac8:5c91:0:b0:412:223a:8f9c with SMTP id r17-20020ac85c91000000b00412223a8f9cmr964116qta.9.1694121742283;
        Thu, 07 Sep 2023 14:22:22 -0700 (PDT)
Received: from smtpclient.apple ([2601:189:8480:9a90:e176:8006:767b:ffee])
        by smtp.gmail.com with ESMTPSA id o14-20020ac841ce000000b0040f200feb4fsm133971qtm.80.2023.09.07.14.22.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Sep 2023 14:22:21 -0700 (PDT)
From:   Robert Kueffner <r.m.kueffner@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Memory protection keys: Signal handlers crash if pkey0 is
 write-disabled
Message-Id: <FF299375-B46F-46D0-90A9-333959FE9380@gmail.com>
Date:   Thu, 7 Sep 2023 17:22:10 -0400
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Robert Kueffner <r.m.kueffner@gmail.com>
To:     Kyle Huey <me@kylehuey.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to establish memory protection domains in x86/linux using =
memory protection keys and the protection key register PKRU.=20
Briefly:
(1) My program allocates a new protection key pkey1 and associated =
memory, and installs custom signal handlers for FPE+SEGV
(2) I define "user code" as code that should only operate in that =
memory, i.e. I want to disable write on pages with pkey0 by setting =
PKRU.WD0=3Dtrue
(3) In this setup, if the user code causes an exception, the kernel =
causes an additional SEGV when switching to my signal handler
		(a) in case of user code causing SEGV this occurs upon =
return from sigprocmask()
		(b) in case of user code causing FPE this occurs right =
upon switching to the signal handler
(3) only happens when user code runs with WD0=3Dtrue, my example code =
tests successfully as long as WD0=3Dfalse

Is there some way to make this work, or is it generally not possible to =
successfully handle exceptions if WD0=3Dtrue?

More details and a minimal implementation: =
https://unix.stackexchange.com/questions/755160/memory-protection-keys-exc=
eption-handler-crashes-if-pkey0-is-write-disabled

Robert

---

12th Gen Intel(R) Core(TM) i7-12700

Linux version 6.2.0-32-generic (buildd@lcy02-amd64-023) =
(x86_64-linux-gnu-gcc-12 (Ubuntu 12.3.0-1ubuntu1~23.04) 12.3.0, GNU ld =
(GNU Binutils for Ubuntu) 2.40) #32-Ubuntu SMP PREEMPT_DYNAMIC Mon Aug =
14 10:03:50 UTC 2023=
