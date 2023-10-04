Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095857B84B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbjJDQP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjJDQPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:15:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A209B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:15:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50305abe5f0so2878481e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696436120; x=1697040920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjqJ6yA/NOdoWTZ0mouoo71KG+EE4Iop0vNyplfA27c=;
        b=tL8bEl0zBYLzIk3OhbA+lEnAyuWJ5yNpBw39jojs7TfQyFwJ/counUkTdqUXEyQWaa
         Q4H0v5ya/14HrcgPHaWy65OvN1G4MRVm7WqQx7b7CPtixEKLwHwsJ07U7c2Q2GqBVHiw
         ZPf/Wx7u7JZVmz2FCMvAirPHMIM9o+o8ZWs4SI0jjrsqYarHSLn4rHz5FkHR+BrjgYXO
         B1pgaWezVn+eBrYkr1rCGIA9bxcXg2KETcDCZwHKXyMLxgqL45u2l46UUWlghIfqqXpE
         z6ucCEIq1XC2x/5w86kWRpfbncUxNmYV1fDJOcPx0Z6CtyLPOWDyiK74sDp71l1IjEcq
         S5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436120; x=1697040920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjqJ6yA/NOdoWTZ0mouoo71KG+EE4Iop0vNyplfA27c=;
        b=fc0VGiHSQWlQ4Qq6G9D7dJNv2v9A84W4DC+OCnVLUlt56e/f2KaB71MAGHHebIGekb
         GCIG0fy3AtL1UAtMWrfDUJSCs57Ett4fzh0wSlblioCwcsH8iUlr2V3Ogdnc6QAexma+
         DieF2DOYBP9iRoQlHB+oD1pQwKxpdvthB4iXtGZW7gaoljbX7T8LVZt/fBU9P+el4YF3
         m2xGaLTDbxMvRInz0QY03b8Idlr7RZaKjy1A4dmC6Qz3O6P0/WhbKB5naiPUL1LPkC4r
         pzfPTosyZ+EjRujafd9gpVE0b2P7dWcdR09KOe8TgNT1bSXA2pG8g/9tlj/PSt7Y9bra
         2Guw==
X-Gm-Message-State: AOJu0Yy5sMUw5FjoZFxxLpQZ0ReFR9xZB35jHKI9JHhU4nFietRxwncy
        VRf/Bq3GNnsWddjbMu7coNG4+2B8EgQNxSjsTvZ/xbr4BprSuNiY
X-Google-Smtp-Source: AGHT+IFgAghQ+58w+Zz87hBVIlsXs3LWYovUUhxnq3Ak/RWVDzhw1Gopvv/oOCWHd8hZZx2paZ238iqWICOkl7ICviU=
X-Received: by 2002:a05:6512:ba7:b0:4fe:db6:cb41 with SMTP id
 b39-20020a0565120ba700b004fe0db6cb41mr3296167lfv.39.1696436119889; Wed, 04
 Oct 2023 09:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231004151405.521596-1-cleger@rivosinc.com> <20231004151405.521596-7-cleger@rivosinc.com>
In-Reply-To: <20231004151405.521596-7-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 4 Oct 2023 09:14:44 -0700
Message-ID: <CALs-HssMjAtsJTxR=qyx7bb60BAReXOM0-EVUQrbNYyzAdN2KA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: annotate check_unaligned_access_boot_cpu()
 with __init
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        =?UTF-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 8:14=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@rivo=
sinc.com> wrote:
>
> This function is solely called as an initcall, thus annotate it with
> __init.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Ah, nice fix.

Reviewed-by: Evan Green <evan@rivosinc.com>
