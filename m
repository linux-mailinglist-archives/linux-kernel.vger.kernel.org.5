Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C9F77BFE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjHNSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjHNSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:34:26 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A7310F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:34:24 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64723cf8264so5257846d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692038063; x=1692642863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUKj6iJDOdjNfGMp7lI4dnhHOH9acY50rwYfnudnhpo=;
        b=yyjNoPJ1bnr/pBFpYTs5oFqSuBiHDB5f/ma5PolZ/uGCezx5LAuR+w19dM5m4N+GdQ
         MqbPPCesXRxORPHYN8P1KDATPaR0A5dbWM3jkQZUqDV0i4ml5pXpODhkhni8l4qJPtAH
         Y7ZjvK6Y4NtFr+VuMgSOu26ashz9BubBGD3LNz4YnAwmuSm5TflJFzsZgNEq4D/5LK8W
         lJSFYrRHStk4KitCsv6J8i/WPUQYs1ANsECz5Oe4OP83kKd2tTD6vQCKx3tkykFYCE+M
         IPCmM+49BbMbOmPR49ABA83qYFmLcozZivBAzSJBcvZ0Z0h/jvpP7O8dXTpgFyBCsTMQ
         kpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038063; x=1692642863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUKj6iJDOdjNfGMp7lI4dnhHOH9acY50rwYfnudnhpo=;
        b=Je1xG5+6xrVbj1yGJ6AZBDD1IaugbIi4dQhJXQwuOPgKZqz5fqsoEfuTxUou0atFy2
         /OgJwfK7upLJ59CDh68PMYTjs+xj+u2gL8xS/hs2tRtpNVazDPZcQ7pDN5yFG4zghMGE
         sVgESWcX3bsgQjrDkcHrdKf8JE7NAv7b4yqFkT31fAjUfvWUXoYxndSXyQPibdUZmg0k
         XEZ2q+sxISoC6/MFrls6fbQpnoZvo4YprKaa9UtoN1Z0ErcDJ325erUFFKytNoFk1WXY
         7YjJE5cwBexHkSJLaEtYbUgfloqAJY9dfmr/FVV5PW7+hleIRzn+lfmQj2m9aQy84X4a
         eJrQ==
X-Gm-Message-State: AOJu0Ywv/kss+hw7hTyUTite+qMe7RkVzrjHnhYyC3tUSNLC8VjOkHEU
        AQKDKv+rCp/1rEBWvlCDrIlLkzuAaPUXYVnuoD6dQw==
X-Google-Smtp-Source: AGHT+IFw+hkrZDq2INobHooqEpULo1uNlgRQPVpk9bftXm+RLNziuU6oVDs4NxvKCPomXxDpD4YOCSK/e0K7tdHOzXM=
X-Received: by 2002:a0c:ed22:0:b0:641:8d8c:addd with SMTP id
 u2-20020a0ced22000000b006418d8cadddmr8457092qvq.48.1692038063416; Mon, 14 Aug
 2023 11:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230811233556.97161-7-samitolvanen@google.com> <20230814175928.GA1028706@dev-arch.thelio-3990X>
In-Reply-To: <20230814175928.GA1028706@dev-arch.thelio-3990X>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 14 Aug 2023 11:33:46 -0700
Message-ID: <CABCJKufjgT9r_cuRxyth3y_rLPW43OBqtmPB_hQVkSftXUfp=w@mail.gmail.com>
Subject: Re: [PATCH 0/5] riscv: SCS support
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
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

On Mon, Aug 14, 2023 at 10:59=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
> I took this series for a spin on top of 6.5-rc6 with both LLVM 18 (built
> within the past couple of days) and LLVM 17.0.0-rc2 but it seems that
> the CFI_BACKWARDS LKDTM test does not pass with
> CONFIG_SHADOW_CALL_STACK=3Dy.
>
>   [   73.324652] lkdtm: Performing direct entry CFI_BACKWARD
>   [   73.324900] lkdtm: Attempting unchecked stack return address redirec=
tion ...
>   [   73.325178] lkdtm: Eek: return address mismatch! 0000000000000002 !=
=3D ffffffff80614982
>   [   73.325478] lkdtm: FAIL: stack return address manipulation failed!
>
> Does the test need to be adjusted or is there some other issue?

The test doesn't work on RISC-V. set_return_addr_unchecked thinks 0x2
is the return address, so I assume the __builtin_frame_address logic
isn't quite right here. Kees, any thoughts?

Sami
