Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0BE799A84
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 21:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbjIITHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 15:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241605AbjIITHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 15:07:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E51A8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 12:07:39 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bf3f59905so379212766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694286458; x=1694891258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2YnWP7VfXn+k9yatNje7Bpehe5l9b+P3goY1ZXeneT0=;
        b=Y9oIv4kVTFlkhY6QpanCgA0EMWd3HpEygFTl5+wxpdY54OFnsa0Hueh/tibapSxAZu
         jzhBTL2eDC+tQPKbF36luPIXMKfX0ycj2dILedcHT6gMWwDNV6SUmg4tPhiEG0z3DNWn
         l8xodwp0/bZrRKn28J2jpPuv/+M48v/ETEYkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694286458; x=1694891258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YnWP7VfXn+k9yatNje7Bpehe5l9b+P3goY1ZXeneT0=;
        b=sM4Uqysah62XJmFRhHxQr4z+uP5yn2RbenQyF15ZwpAfBfJx1UTU2kX709JUXVjrRg
         W+7UUaTPD4bjf7rX+KBMnIwjcs8cOCUUvQyBn5H3LXh/1b/1Bwxep4qig5rsVGoB0dbS
         5Dc9+PzPiTTz2F+boc+bRxoZF9+WA5jnh8PjmH7QVzb7GZn7TKeBYmY+gYEKUUvZTifW
         f+eN6HulIqPns5ZXIWjc3INxruqj4u/86ErtasehhIdTTk6wFXohwIOOP/srsjZ42A0S
         hTG0clVjRcbN2xDG9JlR4sxOZTLwtGvSilucLqXrwGliOs/EqXqW6ZcFixIz95aNg/Nn
         cG/A==
X-Gm-Message-State: AOJu0YweztvQ0u+nPrPY4/zfnnmeafwzp+W+FLho+te64/btYn782s5x
        TJvBUQ0eRWTcEGjqnhnHjhZgQfxdV6oE8+qB1x8LEn5X
X-Google-Smtp-Source: AGHT+IFM03zSf5bfkGGaUIViwixTpyMwXgw0bLn2TWYQ0yr3pW/BrwYOJi/lK/0UIv1om6jHljAYbQ==
X-Received: by 2002:a17:907:1de3:b0:9a6:69bf:fa5a with SMTP id og35-20020a1709071de300b009a669bffa5amr4891374ejc.63.1694286457921;
        Sat, 09 Sep 2023 12:07:37 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906a09200b0099b8234a9fesm2692839ejy.1.2023.09.09.12.07.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 12:07:37 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99357737980so379174666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 12:07:37 -0700 (PDT)
X-Received: by 2002:a17:907:77c3:b0:9a1:cfd5:1f3a with SMTP id
 kz3-20020a17090777c300b009a1cfd51f3amr4317899ejc.13.1694286456638; Sat, 09
 Sep 2023 12:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <285d43b9cbe7bc2b9aaa8537345f14aeec93c982.camel@HansenPartnership.com>
In-Reply-To: <285d43b9cbe7bc2b9aaa8537345f14aeec93c982.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Sep 2023 12:07:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9eoo+zHigat9FSeCLLCDjumFbY8Sb4Z5qgdc4MX0byw@mail.gmail.com>
Message-ID: <CAHk-=wh9eoo+zHigat9FSeCLLCDjumFbY8Sb4Z5qgdc4MX0byw@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.5+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sat, 9 Sept 2023 at 07:47, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Mostly small stragglers that missed the initial merge.  Driver updates
> are qla2xxx [..]

That's not even remotely a "small straggler". That's a thousand lines
of new code.

I've pulled this, but I'm not going to keep playing these games.
Getting pull requests with big changes in the last day before I close
the merge window is simply not ok.

The two weeks are for integrations, not for "we put them in the tree
at the last minute before the merge window, and needed the merge
window time to just have them actually get tested in linux-next".

And actively misleading pull requests only piss me off. I look at the
diffstat, stop trying to minimize or hide big last-minute changes.

              Linus
