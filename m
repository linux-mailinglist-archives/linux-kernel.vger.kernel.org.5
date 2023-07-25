Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D404C760B23
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGYHGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjGYHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:05:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A451B3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:05:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so4787109f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690268749; x=1690873549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCISgvcHkLE+IYvaLKjaAqSLgVkajEMYvriq0KgJeCs=;
        b=0HrQ3XBYZYdQcpqn/WILlevCOv0Bed+FdoMxOX6PFlSRZn2EEExBoyX+tV5PzdSsDH
         T4bBkG2MctRNxqI0VKGmx2AP9nq8LV1LUD954cloloOgmY9bkCcOiRmci+4li2ptKFRS
         dZ9LSG+zpvba62+Wz4a2CCjysdfTiWpkBYpfwyF37ncG6HSFKG161nZPu6x+B9JBdYuy
         lAuGeQCLugERaSurpdpOpHj2CSCUscIjju/abM6zecQAZaQvGp4XxA1OfDB92BX5GitP
         7iXoVDSHMaKMJH+rcxDgjQaXqs7QScLW54a7Htx0jqIzjVkOJ/ZAZRFvcWr21JUlVbkV
         m0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690268749; x=1690873549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCISgvcHkLE+IYvaLKjaAqSLgVkajEMYvriq0KgJeCs=;
        b=RNn9BBHy79cb8uyJC5QT6krSuXEBXJasHFfQSfyq6N8tC4jpG+tmXLp1JOdt8cQip4
         GBz+M9062V3vFxjmfm5Iq+90KqNhsjFTX9pTEQ+IUPcIHyqCFBjsw+pO4DvzNLH5Y/ql
         H3jxX3TrycHQa0Nj5wrDafZzC98ePBWB0uLp6GG7gIwOM0LOOl7zqnFWXxbzjP/V+DGT
         AKgPZdSaZb7ZshQ55zMOMrQXur73VZzkxEDVpPJXpn7Vf66zBJ9RZ0piigBM/SiWGEU+
         N9YQFgM8lHjZ52mCbFgqfc1YBRPLq40BnKHAc3WoZib6D8hBjQQiyxL2oZ5dHQoJ3eZj
         +j9w==
X-Gm-Message-State: ABy/qLbqfeDyawzOIkZVl6MCmhDGNvvK2TXjo9cNV5zl3qsi1h/K0Nkp
        Soc2OweYxLTHOtUqbe8+pItVJEcY43h86SDWbRDWQA==
X-Google-Smtp-Source: APBJJlHW5uTkeyUukPBI67eBenwUVtqS23RaHFSnsmXqJ6eKmnPPYkuP9xkRhbcOO0uBVEGmXWnjsnoOmWsrsJiIoxg=
X-Received: by 2002:adf:f251:0:b0:314:1249:d5d7 with SMTP id
 b17-20020adff251000000b003141249d5d7mr10276585wrp.16.1690268748838; Tue, 25
 Jul 2023 00:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230722123850.634544-1-alexghiti@rivosinc.com>
 <20230722123850.634544-3-alexghiti@rivosinc.com> <20230724-fineness-sectional-8cdd1e4bbff2@wendy>
In-Reply-To: <20230724-fineness-sectional-8cdd1e4bbff2@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 25 Jul 2023 09:05:37 +0200
Message-ID: <CAHVXubhVOpdZhmENkNbavAYGVZB47K9Q_4GN6RZ+rCex4uBb5g@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] riscv: Dump out kernel offset information on panic
To:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Jul 24, 2023 at 4:20=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Alex,
>
> On Sat, Jul 22, 2023 at 02:38:47PM +0200, Alexandre Ghiti wrote:
> > Dump out the KASLR virtual kernel offset when panic to help debug kerne=
l.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
>
> Either you're missing a Co-developed-by: or the author of this patch is
> incorrect.

Ok, I thought it would work this way, Zong first did something similar
a few years ago, so we need his name here. @Palmer Dabbelt if no other
changes are needed, do you mind replacing the SoB with a
Co-developed-by?

Thanks,

Alex

>
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
