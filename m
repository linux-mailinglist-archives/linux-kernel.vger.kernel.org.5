Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654527EF75A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjKQSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjKQSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:15:02 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7698DD5B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:14:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afe220cadeso35504207b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700244898; x=1700849698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fbLTFjANqYgwgt64Svgj7yz/+GXWm87q5kHEmh7RHQ=;
        b=D18fzpgP/uxJDuDBG6XxajmQj79mCb+B1ZRYRY0cFKHklp8Jpw7b7+fuTNlgpZJmWB
         GNzEGMn72ntfmgF7EQ5M+ng/dDVgj/6DDy1TZ0m0OR2EztOqq4vTYSUBRW1PFyY7TzP5
         GbfHnTc5z132UQ39jP+iIlL7ZqAPJj5fmaVoISRChcscwWrcbi8LwmisCAftsNMpDJNh
         VKRZtl4uBquXuzZblBkNj6pTkjrpTQQSBi0Oomk2hLCciSb6U2CY+bIpDfGzBq3i9qSx
         +DuveqaAF4O6QlYG7nTD9+UhvS2MYNg86SXkCBg6yZUI+WGW9KCgUNQc5T9paEpCJo6H
         +Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700244898; x=1700849698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fbLTFjANqYgwgt64Svgj7yz/+GXWm87q5kHEmh7RHQ=;
        b=MS48wjxk/Pl6xd60zx7qborn9TqQKmq16ucB2mtL5DJ2rLZ4umnyvFyT/wgoacHIBF
         W0y/hGcJfmcyck9UVwV1JNySHFH45H7aGEmum0KIrVG9pMZU4/u9i2hPa1Dc7Fn+IFRq
         oqbcKmYUzsCY3wBMFPyEQ+B8lg5ztJv5/o6sFeTIyHS4YJHcOBQCjsPqUyOs5YPklF6/
         fFzZYOUXGRV5tZYgszw+rtQcJm/M3oOPML9xv8l2nQfXWxgjG8TKDSTY9xWhaQxtxf4T
         v0yj20iPNg/VUU+T9/HRz/p/mh1EGTbKWtmb5f+fvVKARVVmkl8VNPhP+0ZmcY8zrM87
         o2Yg==
X-Gm-Message-State: AOJu0YzrcYe199cm1TZhrmYzc+YUuz/1pyZeaTpAWwdM7pGGzoXWkIKb
        rQbdlbpFZZNYHL0amqIKqL1PqZiiAYYEV4o=
X-Google-Smtp-Source: AGHT+IEE+IIx7KMHZPN9vdQjcuy3teOmitlUWHKVwlM0G1+hdGFPfVjvcVb0+yiLXwEizmypJME+tSYRJanyIsw=
X-Received: from sidtelang2.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b8a])
 (user=sidtelang job=sendgmr) by 2002:a81:d512:0:b0:57a:118a:f31 with SMTP id
 i18-20020a81d512000000b0057a118a0f31mr11293ywj.7.1700244898771; Fri, 17 Nov
 2023 10:14:58 -0800 (PST)
Date:   Fri, 17 Nov 2023 18:14:57 +0000
In-Reply-To: <CAA03e5Gb0BDn-e7Th8JPQqrX-EmFW3kGeiKfuFvwEzKe6xRadg@mail.gmail.com>
Mime-Version: 1.0
References: <CAA03e5Gb0BDn-e7Th8JPQqrX-EmFW3kGeiKfuFvwEzKe6xRadg@mail.gmail.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117181458.2260258-1-sidtelang@google.com>
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
From:   Sidharth Telang <sidtelang@google.com>
To:     marcorr@google.com
Cc:     acdunlap@google.com, ak@linux.intel.com, alpergun@google.com,
        ben-linux@fluff.org, bp@alien8.de, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, jacobhxu@google.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mingo@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, pgonda@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, thomas.lendacky@amd.com, trix@redhat.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this blocked on an item? There seems to be consensus that this
> patch fixes a bug and is taking the right high-level approach (i.e.,
> change the guest code to avoid triggering a sequence that isn't
> supported under CVM exception-based emulation). Without something like
> this, we weren't able to build the kernel w/ CLANG when it is
> configured to run under SEV-ES.

> We sent out two versions of the patch. One that does the mov directly
> [1] and a second that calls readl [2]. Is one of these two patches
> acceptable? Or do we need to follow up on something?
> 
> [1] https://lore.kernel.org/lkml/0D6A1E49-F21B-42AA-BBBF-13BFC308BB1E@zytor.com/T/
> [2] https://lore.kernel.org/all/20220812183501.3555820-1-acdunlap@google.com/

Signal-boosting this thread: is this blocked on any item?

We are still running into this issue (SEV-ES guest unexpectedly requests
termination minutes after booting) and applying this patch seems to fix it.

Thanks,
Sid
