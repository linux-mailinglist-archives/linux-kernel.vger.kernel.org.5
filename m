Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4777A0CB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHLP3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjHLP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:28:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FFE54
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:29:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52364e9daceso3784120a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691854140; x=1692458940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pbNQW1MAcVh5LkMzORbrZvwF658G3qR94qScwvqkcGo=;
        b=YTFa4HGI6ZO2VBsskocvIF5PdpiZtMufVeQOnpOMDzAhGfSH+lwbkeYyuQ7NHE/v5s
         8wybBS69xJ+XK9x5oBTyAXc2BNzbZhcuK6ZDOXNMSbQlUBwWHZOMUIeR/b26Yci82Q3R
         nW4H/oRBGn/b3e7imKPwfm3lTalszX7evDcQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691854140; x=1692458940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbNQW1MAcVh5LkMzORbrZvwF658G3qR94qScwvqkcGo=;
        b=VZ9jFNGZqeW0pKJUnBBmBgODJIJugBxb/StTtVK80AAeif4RPQPsTQgX+U1h8k3XFF
         0Uap1UfQcFSVJ78CoEwQ174KEPwphmMy6SBLTRr7iekYiW6WatLRjv6bV8E5NnTOcVZE
         lFG1+5BT7Xa65jZtSMKThDhgK1xSZ4csINNt1Ole4FIu7IosJQCTS0HuLpgXJrCVC/Ea
         827mWfMBS2YTCvAE/IvuMXnwyetrQJ8uVDWhrE3nxdylopSevVP7U9VTvYf5mE4oj84A
         UNRdXKYphtWduemQaixNHrbW2A6/2eOMb2sWY8sGC6nK22NPMUuQlAS6N5i4aBWOQ8DO
         JuUQ==
X-Gm-Message-State: AOJu0YyJlxdMrtfzPQX2x7huMNVfZTxSjotyfvNjVL60pDW27F78t5UT
        UuLTP+GUJAzj4iyB/NScq1XV7mOLJ3imhfIkWWHbb1u1
X-Google-Smtp-Source: AGHT+IEmKURAm3pYnh6/rC1awsOx1EP2bv2S8uZ8i86P7kH1vvFunTJmIQRe9O0DKwv+4AiCRZXGdg==
X-Received: by 2002:aa7:c049:0:b0:523:3e47:2657 with SMTP id k9-20020aa7c049000000b005233e472657mr3885411edo.11.1691854140190;
        Sat, 12 Aug 2023 08:29:00 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id l9-20020a056402028900b0052337ff078bsm3322637edv.92.2023.08.12.08.28.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 08:28:59 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so3816603a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:28:59 -0700 (PDT)
X-Received: by 2002:aa7:d98e:0:b0:522:59a7:5453 with SMTP id
 u14-20020aa7d98e000000b0052259a75453mr3709223eds.35.1691854139239; Sat, 12
 Aug 2023 08:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230812123757.1666664-1-mjguzik@gmail.com>
In-Reply-To: <20230812123757.1666664-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Aug 2023 08:28:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFxfLENgUp42RVPKHosy7FNu4U3kZCV=9b0HrXs8hW2A@mail.gmail.com>
Message-ID: <CAHk-=wjFxfLENgUp42RVPKHosy7FNu4U3kZCV=9b0HrXs8hW2A@mail.gmail.com>
Subject: Re: [PATCH] vfs: remove spin_lock_prefetch(&sb->s_inode_list_lock)
 from new_inode
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 at 05:38, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Also worth nothing is that this was the only remaining consumer.

Send a patch that also includes just removing the definition of that
thing, and I'll happily apply it.

                   Linus
