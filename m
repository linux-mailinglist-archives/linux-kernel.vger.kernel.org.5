Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3638E7A51FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjIRSYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:24:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1A1101
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:24:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50307acd445so3266389e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695061485; x=1695666285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l4dXk6Q78Nq5eL8rDRkALATs4DmJ8BnONZg2xTC0Jc0=;
        b=SRmWWcQZjLCKCvOafhEkJYbsDkRQDuThsR0JjAnOFQjFKuroOUZLaLjUIDqXk4BJBW
         ciKZPKmcYDtgHrLxerQdLQC+JGLM+VKJdo/IO7sLR7DkRL6chRho6iTR63y/i696uuBe
         fAkZd6LkPwAFMt51COjtS+lT3D1OYWPfSGN7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695061485; x=1695666285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4dXk6Q78Nq5eL8rDRkALATs4DmJ8BnONZg2xTC0Jc0=;
        b=YHVFD2QmQ+0Wcrp9Q2jVGIeOxJYMYu0G+1zNNN4kHFhMs2QSAXYW+rlbgDx/nEywIX
         9vftv+7FmnUAh/RyYDXKNZJtKdujFuUwfJv+YCWks9bYaWzuXsjRBY4xUUV3P+3kNA+J
         dc2yPqDrukyfRkUesphMnMks+ZTk4cnYV+CliFxNKGTlZbGl92vC1rWG0O7wnMwnzc4U
         K4STHIcxxtceAhlPPffp8rWNm7jmwIMpBmNkeARDBPTIgvkg3KdhOFmoYM6TxXNYsiDS
         yS0mSd/G/QtCWvAtNCPviBkBiVnRWfSCW/R2vS7fBKJvn0xftnd1v93m/LNuXIX72ukq
         G+8Q==
X-Gm-Message-State: AOJu0YyLzeDT5+KnJsH/oH0DlEhU1lWHltV65Dx9wHoJdeXHfC7YgehT
        JUIHCMVaIdxfNsD/T3EmqNXWCe0yZ117rg+ac7XND8Iq
X-Google-Smtp-Source: AGHT+IFF+oHK9mb4dNe0cKDxpE1KMi0gxr3iFQq8BEPkyL3g6ZDDBSJUdgto2Sf2BD4avH3YhNtDDA==
X-Received: by 2002:a19:5011:0:b0:503:2561:adbc with SMTP id e17-20020a195011000000b005032561adbcmr1162966lfb.64.1695061484768;
        Mon, 18 Sep 2023 11:24:44 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id z3-20020a19f703000000b0050084e55bd8sm1901744lfe.138.2023.09.18.11.24.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:24:44 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50307acd445so3266336e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:24:43 -0700 (PDT)
X-Received: by 2002:a19:ae07:0:b0:500:9524:f733 with SMTP id
 f7-20020a19ae07000000b005009524f733mr7387536lfc.20.1695061483382; Mon, 18 Sep
 2023 11:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
In-Reply-To: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Sep 2023 11:24:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
Message-ID: <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
Subject: Re: [GIT PULL] timestamp fixes
To:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 04:54, Christian Brauner <brauner@kernel.org> wrote:
>
> * Only update the atime if "now" is later than the current value. This
>   can happen when the atime gets updated with a fine-grained timestamp
>   and then later gets updated using a coarse-grained timestamp.

I pulled this, and then I unpulled it again.

I think this is fundamentally wrong.

If somebody has set the time into the future (for whatever reason -
maybe the clocks were wrong at some point), afaik accessing a file
should reset it, and very much used to do that.

Am I missing something? Because this really seems *horribly* broken garbage.

Any "go from fine-grained back to coarse-grained" situation needs to
explicitly test *that* case.

Not some kind of completely broken "don't update to past value" like this.

               Linus
