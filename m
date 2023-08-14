Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8637677C168
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjHNUTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjHNUTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:19:08 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DC6E5B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:19:07 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-447abf05ea4so1343974137.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692044347; x=1692649147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7NBKIaudZg5pCYQXSbPQz6qkuoJtThIS+SlVr6T2ss=;
        b=2ggILfUkx+J0GaDwD/w6xQ7NdbZaQign7zCVMSAYwBlsbMHdYcvWTyE+wiwuDmmePV
         6bj/epA9FIr5PNwc4chwEbunFmcsFgL9YTpMtJJKoglfZO5XQgPzZBjplAQdcaU27ghN
         OSAcUZLdRhvL7lJ18RDzVd58oCk45dvfuTbLQveUpvxOILVM7V44UfBsEDgDYG+poAyL
         aeJ1qOaC7QqVnk/zuFb0t7R8gUJ63o5wt7qvNRHkhgOFVgikTyu7QLysHU6fGHqdoXHU
         pnIZsvEx/ZJwdwuFKUgaFHcBeeTPEOhb2n2qfj69XijWr/RDxo/LGgy3bElIpmevDSUC
         Ruiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044347; x=1692649147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7NBKIaudZg5pCYQXSbPQz6qkuoJtThIS+SlVr6T2ss=;
        b=ksMqFkw7N+uXMa/osui0ifJv4KAsNzhqOluSnAwCUY9kqH6P69v7OAczcGnc24zlFC
         QL6/SkKEZSpKNUkiv/mcQyvXsbDaIUQdFXWsvkjRPRPDcVZ3HV2Sq/NxA8CCT8twe7Hk
         wGRAKFuiJPxnZuE9C5A7O8WCresXfPuVKmQDJIlwgxDUC9jTsQiTPfvjpUYghB7wlZp5
         3xI4UDTzqaG2z3eHITUOxp+VEp9rbdL4LMIbVTUd2NYmLuAbLnkb4JceGzQQJIYoe5/d
         G0BbmdRInDCS3vdDRxGy3RWeD7iuAT4kAPqfFQLsABsuRLEY0iJVWHPSSV5qSSA++WAL
         UdZQ==
X-Gm-Message-State: AOJu0YwyoDn3TqYOpQtuHoFOBKqGFzWldeuq3c97Ud3T1ObUMS71jTCW
        85NhkJW3DNkHyZnmO7/LoKIHFZTx/xbEzabkHmHCZg==
X-Google-Smtp-Source: AGHT+IHF0E09EnWMkn/qFpKOn1LBeu/xmPCIZS3ihtJBPqiw208Hlg8gySJGMAbdcb4rzGK3mlcno6Gp80oreT0TkNA=
X-Received: by 2002:a05:6102:1344:b0:443:5927:d415 with SMTP id
 j4-20020a056102134400b004435927d415mr7180453vsl.10.1692044346673; Mon, 14 Aug
 2023 13:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230811233556.97161-7-samitolvanen@google.com>
 <20230814175928.GA1028706@dev-arch.thelio-3990X> <202308141131.6B90A4205@keescook>
 <CABCJKueV8N4pDBFmw0aWn3wqeyjWUVTGotiC-gjMohJtw=_97Q@mail.gmail.com>
In-Reply-To: <CABCJKueV8N4pDBFmw0aWn3wqeyjWUVTGotiC-gjMohJtw=_97Q@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 14 Aug 2023 13:18:30 -0700
Message-ID: <CABCJKue93aSknVnr8Mc1uaw5D5vk7xaPxaGp8JMqvvjqqHY3jQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] riscv: SCS support
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:57=E2=80=AFAM Sami Tolvanen <samitolvanen@google=
.com> wrote:
> Looks like __builtin_frame_address behaves differently on RISC-V.
> After staring at the disassembly a bit, using
> __builtin_frame_address(0) - 1 instead of + 1 seems to yield correct
> results.

Elliott was kind enough to point out to me off-list that this behavior
has been documented here:

https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.a=
doc#frame-pointer-convention

I'll include a patch to fix the test on RISC-V in the next version.

Sami
