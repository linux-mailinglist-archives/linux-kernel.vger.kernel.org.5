Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0D77E5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbjHPPuw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Aug 2023 11:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbjHPPuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:50:19 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F02D46
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:49:59 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-58c7bd44c7bso9572417b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200999; x=1692805799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iT0YlCUUEWGIL1xiG1wfsHzxu/rA8CnFEMGG0g8NF0=;
        b=OUoYY6FxZqwnASu/nYtQi8S+6/h+sgAST5nACZqi+DXf35Z+yTY+D7qTygqDdkEv/o
         pBAf7rBSRKWrmJz2Q6AtmWMdnMvMcYErLDtcwY1PigFlr2HLyg58pz569JQrFhCQISJZ
         x9LPbeg2VoD1Lzcstqkn/JOPgpIU491yVFrVIQzfP+I1II2u0mGY9xGVvwGtxIq/+1MY
         uXjj/nZrsKNBvzbocJqCWqlqV+K8r9+NDpj9XWK73cRHGkzIIZ75u7I4dSqNoe8RYX/H
         hhkNZOgwypqO1hcuTVtXCFBzHtrTBN3oRMfx29SaOCXQlrgY3dnC3uuIN2Jx7x2hQ08I
         OCjg==
X-Gm-Message-State: AOJu0YzgLVy0pg702NmGbfvvBq+sNkI+pWKqZejighlNIkM9Wqwk0Exe
        GxWj9uSkaBxDLSZtwXgAjyFozhZF+ZkfrQ==
X-Google-Smtp-Source: AGHT+IFOiSEX2GvbNI0JKcwmWZjLa6KCRZuNdiMsyBsJJAaD6TTfIaZD/CRRdO3GDzs6w0Kgcvj1qw==
X-Received: by 2002:a0d:e6d0:0:b0:568:d586:77c4 with SMTP id p199-20020a0de6d0000000b00568d58677c4mr2066588ywe.4.1692200998915;
        Wed, 16 Aug 2023 08:49:58 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id v13-20020a81480d000000b0056d2a19ad91sm1391795ywa.103.2023.08.16.08.49.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 08:49:58 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso6573876276.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:49:58 -0700 (PDT)
X-Received: by 2002:a25:6b44:0:b0:d01:2e8:740e with SMTP id
 o4-20020a256b44000000b00d0102e8740emr2125365ybm.37.1692200998153; Wed, 16 Aug
 2023 08:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230810141947.1236730-1-arnd@kernel.org> <20230810141947.1236730-11-arnd@kernel.org>
In-Reply-To: <20230810141947.1236730-11-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 17:49:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWuFSX+W6-MaiUAf+s4pqmGZnX2z5NV1vyGVQaMz5CaWw@mail.gmail.com>
Message-ID: <CAMuHMdWuFSX+W6-MaiUAf+s4pqmGZnX2z5NV1vyGVQaMz5CaWw@mail.gmail.com>
Subject: Re: [PATCH 10/17] zorro: include zorro.h in names.c
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 4:22 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The zorro_name_device() function is defined in drivers/zorror/names.c, but
> the declaration is not visible there:
>
> drivers/zorro/names.c:58:13: error: no previous prototype for 'zorro_name_device' [-Werror=missing-prototypes]
>    58 | void __init zorro_name_device(struct zorro_dev *dev)
>
> Include the header to avoid the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.6 branch, with the "zorror" typo fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
