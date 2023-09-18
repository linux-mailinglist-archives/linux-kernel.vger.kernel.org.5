Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424CA7A52E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjIRTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRTUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:20:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C66F7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:20:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-792623074edso140146939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695064837; x=1695669637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b86hQuE0ZsCAliAzznf1aFW63ModJ5OyRH3XXfZOYAw=;
        b=JLos0u6+Ctp/2yG6ETSGJK88G2nIAccbi2cPyZQXIh8p7a0PEcJA+PF1CJ8MuWz2DJ
         Zuz6e0bVmmGHqD4dZIIzcbofsY4/pFg74S1zSnRS1muJ0Gr2Ay/Vk8Vawoj0tv7sRYwh
         VkmFlgLh8o8a1LBxnoR7qcY0th91qN629/aSD6oyKEGZ69CV9FPGYjyUrL9RVfb/OOAe
         Nwsgtm91UpVJoElHgPibXghmHxxVi4VzC5oyoJ8/8UKY5Upc7d5HOtVA7gzp4fY2+sV+
         DyyLJlLri5W2SYDwwB641sxFYcteWaC5DWE+pmUvj7pg5mqJzThLR8tkYwd7yc2idT9h
         SkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695064837; x=1695669637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b86hQuE0ZsCAliAzznf1aFW63ModJ5OyRH3XXfZOYAw=;
        b=kLHsNy62vXPFd5LoBWp/Xx9nDb/PlE4X20SQMlVoSMmEheVtNwp79fvz6imxTawD4h
         Muy1kQV6ll8VYSiHVoywVC/zkc2Zrzx/TRpS/6xc82wA2xltsrgraBft5ZxVzsrCLdiN
         BTOHfOYQddlA0xylVndpr/xZUNFCrPJ3IvtLFeyQWEr/oDMqH7gnv/SkzsMbmwD4I3ua
         LY2Dayz1jz2oWU+sIEYUBP6ScoyKamTlMq7SYBIv16JSnlNzI3kzZ7CNpnwwTZwq2uVj
         bCuRoJntaOf6DaQVRy29hrQimAGsAbzaf9fLA2e5OIvX+eemKSYCYVzmwlO3PTMqpnnJ
         x0Cg==
X-Gm-Message-State: AOJu0Yz4ZUPtq0WoD27NbHUUZPznmLo2DhjIaQDHBjYe1xp6LGD9MqLs
        nvVxo2ygVCGaBZJl4Bn00PoW/p29A2M=
X-Google-Smtp-Source: AGHT+IGj3v2dR+x1TD21MoSvJrpzOp21HR2sWZYWJgcDej6ogfKBwiBJ+lIowYbHRaykD5DPaGR2oQ==
X-Received: by 2002:a05:6e02:1bcf:b0:34f:14e5:5c89 with SMTP id x15-20020a056e021bcf00b0034f14e55c89mr554146ilv.13.1695064837257;
        Mon, 18 Sep 2023 12:20:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y16-20020a02bb10000000b0042b3042ccd8sm2979490jan.13.2023.09.18.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:20:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 18 Sep 2023 12:20:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.6-rc2
Message-ID: <ca3ac950-db89-426e-b5af-9f8bf5f91658@roeck-us.net>
References: <CAHk-=whW=fV2tnAreSbtPVpJxq++pyBZa3g+cxX8_V__WSZzCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whW=fV2tnAreSbtPVpJxq++pyBZa3g+cxX8_V__WSZzCg@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 02:55:46PM -0700, Linus Torvalds wrote:
> Another week, another -rc.
> 
[ ... ]
> 
> Please go test,
> 

No significant change / improvement since last week.

Build results:
	total: 157 pass: 151 fail: 6
Failed builds:
	alpha:allmodconfig
	csky:allmodconfig
	m68k:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig
Qemu test results:
	total: 530 pass: 530 fail: 0

Same build errors, same warnings as with 6.6-rc1.

Well, that is not entirely true. I do see a bunch of warnings in folio
code, such as

WARNING: CPU: 1 PID: 774 at include/linux/backing-dev.h:252 __folio_mark_dirty+0x318/0x350

but that is because I started testing gfs2 which always had that problem.
I am not sure if it is even worth reporting it. I did send a note to
the gfs2 mailing list and maintainers, and I won't mention it here again.

My list of pending fixes includes the following three patches.

LoongArch: Fix lockdep static memory detection
mfd: cs42l43: Use correct macro for new-style PM runtime ops
ASoC: wm8960: Fix error handling in probe

Guenter
