Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59FC758113
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjGRPhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjGRPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:37:40 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BF0DD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:37:38 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-cefa8fe4cbeso356565276.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689694657; x=1692286657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCK/3yqfFrlybI59Y4EJcaEm+Nx014dFpbGVy/E/MBg=;
        b=CLEWljICIIoucgxTCR1IaTNbzLTRvnz0v2Q/fUOUs2kgcUwk+r2wTzjkakH+7QSYMM
         hloULaKPOSagnIDJrovRDms+5oQlOxHPa02pEemIETmJMy2LT7IGqguP35gOH4cRFEx7
         g5QGNE1dqeuugrSRRTGAlJ0USVTmNj2yLZ//IQi6VE8IZBaZyBUWo/TOatSJ0+jglUSW
         fEZ5Jrti4Gm/QW/BVdJL+ezJAVf5f9wypV/V1XpO98iH0RZKjqsVKF6KboDc6Hlm5Va0
         rqtQDXK5w75CFD7r/WNQLI1TreQ/cQlyDjyOGhM67QqxNN1AW9lW2SC4rAfWbWGIo711
         ZXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694657; x=1692286657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCK/3yqfFrlybI59Y4EJcaEm+Nx014dFpbGVy/E/MBg=;
        b=Ik+FZ3y+ODZPWlkkikzGvsUldfOJh5hrG7Per2dGl1GF6UKFAm5jH2LxHsIzuz+wx4
         e1Xu2c+FfQMldgT8uZIbp8CAZuVFzI4L4kSxtrGVU+cd4nSNeIeelqfKW3a/ImOrBdhE
         OqVPWFnoVKaFnHVBWCyfeNaPMGrGnYpQnth0VYOszo6+DvkPs83yertz+PHTsJ5vFLtx
         aNQrBWewq0f4jMAzVFHbeBtoRCng7h0+ykSGmW8MvNwIJuh1VEd66pdtvWIkYbZtTcSJ
         0KbqlHWrleLkxNH/60kkQqjk70E7310w2D+nH5kUo/+rsrrLWvr1CQGI0Xn9v/Cy0VOL
         GsyQ==
X-Gm-Message-State: ABy/qLY0sMh4pzSbP0h2P1hnuGYIC/rhcWrQIKsNLIWSnxeYURYp+ore
        ZwOn/xhJdt2d1aNuXrfHYJvew3lF868=
X-Google-Smtp-Source: APBJJlHPPCNkkovEfDYORaVktJHC28ybqCtxxi/B22V7tT8hgRC+Ls00SGG6g/fGUDGKRHa+pKiC4A==
X-Received: by 2002:a25:2743:0:b0:cea:64bf:f884 with SMTP id n64-20020a252743000000b00cea64bff884mr44662ybn.56.1689694657522;
        Tue, 18 Jul 2023 08:37:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n62-20020a25d641000000b00c6135ffd2fcsm481432ybg.15.2023.07.18.08.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:37:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 08:37:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.5-rc2
Message-ID: <74b3b7c7-8373-412c-923d-7ee7d11c571c@roeck-us.net>
References: <CAHk-=whXp01JfPMm9=xd6YDnNwoCbtoRZ7_fLYttLOuHnEeNJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whXp01JfPMm9=xd6YDnNwoCbtoRZ7_fLYttLOuHnEeNJA@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 03:55:09PM -0700, Linus Torvalds wrote:
> No surprises here: this thing looks very normal. The patch stats are
> about 60% drivers, with networking and gpu drivers being the bulk of
> it, but there's a little bit of everything in there: nvme, pin
> control, x86 platform drivers, HID, etc etc.
> 
> Ignoring drivers, it's a mixed set of fixes all over: architectures
> (x86, powerpc, RISC-V, xtensa), some core networking (mainly
> netfilter), core kernel (tracing, scheduler), filesystems (erofs, smb
> client), and documentation and selftests.
> 
> And some minor noise elsewhere.
> 
> Full shortlog appended, but nothing in there looks particularly
> thrilling. Unless, of course, it happened to fix a bug that affected
> you.
> 
> Or maybe you're the kind of person who finds CFI annotations and
> getting all the endbr64 annotations right to be endlessly fascinating.
> In which case you're having a really good Sunday.
> 
> But please - don't think of this as "not very interesting", but more
> as a "this looks safe to test, and it's not like I have anything
> better to do".
> 

All my tests are now passing.

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

If I don't have anything better to do, I'll try to add mode boot and kunit
tests and try to find some that are failing. Other than that, I'll keep
testing, but only report until 6.5 if there are new failures (in other
words, the lack of reports in the next few weeks will be good news).

Guenter
