Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209A078CF79
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbjH2WV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbjH2WVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:21:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D848B1B1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:20:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so6395658a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693347655; x=1693952455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBGxhGVE/O9KafVESYT+LOweSNa/w8MY2IicYyYz9S4=;
        b=Unc0se7ruQg74CBzq0y8JF71x/zDRCuWc/gUiKc2TP5QW741lBf5x09S6Au7QR3VtO
         qkw6E/qoqU0fi/j1FkQAtYmvveUKJ6xOI65Q7SfqK9jU7N+wpX/oUT4aTFImYf3QRXEI
         krQ1mlWWu2qAN/pariSljSm9a95iFx/XsyA+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693347655; x=1693952455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBGxhGVE/O9KafVESYT+LOweSNa/w8MY2IicYyYz9S4=;
        b=EnuL+73QvjIent0DCFztDuchAQ2JK1FOWlFE66bnBo1zTH7j2wQyjGjc+E3uQFh90X
         6qaM72vjA79EfXfZZVVCvX/JbFEu1ETKHWom9apoSGVlG/f4kFNOyN2bZdR9UjIR332K
         8fyXT25ScJQpGWUhTif2DM9vCYjVJIr/jwswAnzidFUFfrZy5D1mCLZvFmUJZzKuvp1k
         ThURcO+7A9+Km6STXYKivpBN84xEYt3aai7ZZLIS3rZN152hEZUh0aRkbwGbt3sX0TIk
         eLVGfsqo9aERAcaWjFmo0HomG943jVMEX42fgreTrtw3S/fyVMbH7nOLF2mM/p0/W2em
         XOYg==
X-Gm-Message-State: AOJu0YwCEqVNDD/B09bZA4X4xoLtXDzUTV5V50OadBoEpPLtS4jDVhK4
        UsKsN1CYehi+ZMoflRjo9BE0Oi+rX+2jOpnTL+nGmZwQ
X-Google-Smtp-Source: AGHT+IGkr3NHoy4eQEN+rJk6ACcOsgV1bpQWsyJEPJoWsq05Z3xFkIaZBOMXtHHS0sL2+FKv1LFk7A==
X-Received: by 2002:aa7:c6ce:0:b0:51e:362d:b172 with SMTP id b14-20020aa7c6ce000000b0051e362db172mr401291eds.32.1693347655238;
        Tue, 29 Aug 2023 15:20:55 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id y9-20020aa7d509000000b0052239012c65sm6102908edq.82.2023.08.29.15.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 15:20:54 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-31aeedbb264so4448105f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:20:54 -0700 (PDT)
X-Received: by 2002:a5d:554b:0:b0:317:618a:c72 with SMTP id
 g11-20020a5d554b000000b00317618a0c72mr262356wrw.64.1693347654025; Tue, 29 Aug
 2023 15:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230828225431.354d3d2d3b80ee5b88e65eb5@linux-foundation.org>
In-Reply-To: <20230828225431.354d3d2d3b80ee5b88e65eb5@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 15:20:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsKp2ZPxQ_WvRGLJXtZG6Z2TrqC_jNppukfniCZB9doQ@mail.gmail.com>
Message-ID: <CAHk-=wgsKp2ZPxQ_WvRGLJXtZG6Z2TrqC_jNppukfniCZB9doQ@mail.gmail.com>
Subject: Re: [GIT PULL] non-MM updates for 6.6-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, 28 Aug 2023 at 22:54, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Linus, please pull mm.git's non-MM updates for this cycle.

Hmm. For some non-obvious (to me) reason this triggers

  vmlinux.o: warning: objtool: ibt_selftest+0x18: sibling call from
callable instruction with modified stack frame

which didn't happen before, even though the pull doesn't actually
change that file at all.

I see that Josh has a patch to fix this by making it be real assembly
code rather than a hacky inline asm in a C file, but it's a bit
surprising, and I don't see why it's triggered now when it wasn't
before.

At a guess it's related to the Kconfig changes, but I have nothing to
back that guess up with.

Slightly annoying, but I guess I'll live with the warning for now.

               Linus
