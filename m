Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5D7B56B1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbjJBPge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjJBPgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:36:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AADD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:36:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-277504a23a1so2265382a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696260981; x=1696865781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RgMLD9dSESZx52XLswNxjXiae7bjz6p9TOP3CQJHyA=;
        b=oky/oqG2dLxveE0LCaeozY/1eKrsOFkx/QIfqtBzkf9wQXi+RSSxI+IAzKe5SePCIR
         +SgKbhHh0n1FeXE76779o5YLUAGOwVkyoDt78Wwzp6L2ZjdGArDi9UumFpkQNRLd3/21
         m4LE0R1onuyCZvn0aW9y5JwsVdnD4AWxKO5dSn1jkg2ttlWrYFy2WrJY3e2F1badcnYU
         bZSgJldjWYsHLhchTN6VOdlYvrQEcaAo/KHm2i8v6fe0Dws64FE58UJvgqvNB48MtmJf
         +1n2VuC4RC4gTrQ8EK7uEyUUejfCa5lSPo+efD/TVTsa6zYh7GpWVLnkzb4OhwcbF2eR
         zM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260981; x=1696865781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RgMLD9dSESZx52XLswNxjXiae7bjz6p9TOP3CQJHyA=;
        b=szKa65ewxoTkBNmX2my7t11ckYYTxwWN5EkOIDdsFm+bqtqc1nPoT3Qqyw/V1tNRzt
         Hddek7NTLoNkmPzGnxpid9e5Mj2y6qYQckJJizBOGSCeYRy+EIUcaMdv555BmT0KKRBX
         oI6udbbvkBefRS1a7QSbec5AFOE/MgvN9Cmm8qRoz4UVQ9/gwKp0ZvXIwhHyyXUBTPJ3
         zkmeX7zehAuQErtIrJvkL5aduA97pbVixSbbTcugjCFVM8x664pKDN6Sv9BltB52OWI2
         7R2P4FsD1vdjVzZvejbcPJuo1K9BkYD5bGlzi55t+sVpbFNGmKG7PtwWL+Rm7D18fWGt
         pzYA==
X-Gm-Message-State: AOJu0YyNODxaAIdh2pXVGOWBxXnsHRW1VNrfpyLBTSETDRGhbpmtC05/
        m5xtkMxnlnzi7X4+2sqpvxxSBXzuNbY23BY16StWZA==
X-Google-Smtp-Source: AGHT+IHdUbkKZ2bTW3F9Qg4PjCMCpRtqgGBYo+9VzsIQ8Arz7Ddo4OzAJxCLa36qrqP4KqitPbbTePoaUqx96PBwxCI=
X-Received: by 2002:a17:90a:b396:b0:277:422d:3a0f with SMTP id
 e22-20020a17090ab39600b00277422d3a0fmr18387610pjr.17.1696260981095; Mon, 02
 Oct 2023 08:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
 <20230919035343.1399389-2-apatel@ventanamicro.com> <ZRpitP5y1yhzKwbE@infradead.org>
In-Reply-To: <ZRpitP5y1yhzKwbE@infradead.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 2 Oct 2023 21:06:08 +0530
Message-ID: <CAK9=C2XyQtHy3__i+fahbi49=j5Z3Z_Bv5s3Ptqjmuaa5q18LA@mail.gmail.com>
Subject: Re: [PATCH 1/7] RISC-V: Detect XVentanaCondOps from ISA string
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 11:57=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Sep 19, 2023 at 09:23:37AM +0530, Anup Patel wrote:
> > The Veyron-V1 CPU supports custom conditional arithmetic and
> > conditional-select/move operations referred to as XVentanaCondOps
> > extension. In fact, QEMU RISC-V also has support for emulating
> > XVentanaCondOps extension.
> >
> > Let us detect XVentanaCondOps extension from ISA string available
> > through DT or ACPI.
>
> Umm, I though Linux/riscv would never support vendor specific
> extensions?
>

We already have few T-Head specific extensions so Linux RISC-V
does allow vendor extensions.

Regards,
Anup
