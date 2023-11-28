Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA77FCAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376626AbjK1XrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjK1XrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:47:23 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8721A5;
        Tue, 28 Nov 2023 15:47:28 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso5344191b3a.3;
        Tue, 28 Nov 2023 15:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701215248; x=1701820048; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoJTdvnUva0vOEP8D6/hcODd/TZNf7EsXrddDwBiX0Q=;
        b=E5DRzk8rGW/Pbws90gavOxsed/CK8SD6UkI6S+T267cUqL96rS6LQNcVZV89n57xkq
         wQ8onMppPsHwbZmM2QbmxUN2Acv1mjGi5BwA45KGpHTafUrwiqVYzMOCyLASGuVzZ5sZ
         cWtfOf1EcH0yIiaAV3uiulNtdqRM2QU4ixxNfD8DtUSgT4teW/p65JIZ1p3cSDBAIW8I
         oSbqvMneA7X66b1W0EE3WJj/ueyn+kUw1D8AOaTJ2LGDC/PdWbplY+LFuY/mntOiq1VS
         3U5t8w0PsAxvE/XcsuMq1m3/FAQ+aBNOot6Xmhs1bxBImdySS4mEg2ADBpl6MC6fHTlJ
         Bbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215248; x=1701820048;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MoJTdvnUva0vOEP8D6/hcODd/TZNf7EsXrddDwBiX0Q=;
        b=nqZffRfLYvARz3cOgyV2ArbhNFj/A103taq5RFdGYu+8IXG2mqtpYDEHcgPpNpEJz6
         PIGLWi+cbWlLRdiy0J58kbGBPv2a8oQyHc8E3L2CovtCC2BQRRmh+csAysgaPKfxCZvd
         ATdCMnlKzR3k7daJ/3bEGaQ0vvqt6nRM7cXSSiBe05x/Ws26NTuC63mSEeQJDjurvaCO
         qT6T6udl/wiY5r40BcMf/vT+EGgEzG+mrQuI0YLXfaFEs9ZVVjxvhHhnafHn20D/bWQH
         ODdjXG6PYvXs/i8XKUrgiXJ1NTHoVf5RLzorv1LnFcT065gZ52uvmljZp+KzDaOy+g06
         lAKA==
X-Gm-Message-State: AOJu0YxqEol1aBzSAJPC3jvNj2yMfVDI1uL+YiLlg2H1V/w2nQH3D9JN
        KVTYwWHCxdtqIuIngl38AeKbEPdLdEVYeQ==
X-Google-Smtp-Source: AGHT+IG0ToBag8VkYoAH8p7bmSYPEOYkke5pJZNFz0uaMrE6AdCr1IG7P+8YPR2dMp9dwjbggk5bbg==
X-Received: by 2002:a05:6a00:1d01:b0:6be:4228:698b with SMTP id a1-20020a056a001d0100b006be4228698bmr19323394pfx.20.1701215247817;
        Tue, 28 Nov 2023 15:47:27 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l65-20020a639144000000b005c2130fd8d7sm10038106pge.91.2023.11.28.15.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 15:47:27 -0800 (PST)
Message-ID: <562a2442-d098-4972-baa1-5a843e06b180@gmail.com>
Date:   Wed, 29 Nov 2023 06:47:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Block Devices <linux-block@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>,
        Linux bcachefs <linux-bcachefs@vger.kernel.org>
Cc:     Coly Li <colyli@suse.de>, Xiao Ni <xni@redhat.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Janpieter Sollie <janpieter.sollie@edpnet.be>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: block/badblocks.c warning in 6.7-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report that is rather well-handled on Bugzilla [1].
Quoting from it:

> 
> when booting from 6.7-rc2, compiled with clang, I get this warning on one of my 3 bcachefs volumes:
> WARNING: CPU: 3 PID: 712 at block/badblocks.c:1284 badblocks_check (block/badblocks.c:1284) 
> The reason why isn't clear, but the stack trace points to an error in md error handling.
> This bug didn't happen in 6.6
> there are 3 commits in 6.7-rc2 which may cause them,
> in attachment:
> - decoded stacktrace of dmesg
> - kernel .config

The culprit author then replied:

> The warning is from this line of code in _badblocks_check(),
> 1284         WARN_ON(bb->shift < 0 || sectors == 0);
> 
> It means the caller sent an invalid range to check. From the oops information,
> "RDX: 0000000000000000" means parameter 'sectors' is 0.
> 
> So the question is, why does md raid code send a 0-length range for badblocks check? Is this behavior on purpose, or improper?
> ...
> IMHO, it doesn't make sense for caller to check a zero-length LBA range. The warning works as expect to detect improper call to badblocks_check().

See Bugzilla for the full thread and attached decoded dmesg and kernel config.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: 3ea3354cb9f03e https://bugzilla.kernel.org/show_bug.cgi?id=218184
#regzbot title: badblocks_check regression (md error handling) on bcachefs volume

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218184

-- 
An old man doll... just what I always wanted! - Clara
