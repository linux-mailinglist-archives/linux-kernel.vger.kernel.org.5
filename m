Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF17AA01F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjIUUcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjIUUcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:32:33 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8257C727
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:36:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41513d2cca7so32411cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317798; x=1695922598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBzLJvv/ftwfpQgrnjlc3wBvEJtehhEbaRaf34rd/Ho=;
        b=X078Ri54Vr4YfYs3a3qm0UVu7k9AqCC7eehXLxlw1O+Ly8K1frL+XuEqudE48bpF0R
         econW33xDgYQBRLAeR21nISEizTAaUTebrs8Mj7QUKbfrsK2U2aY6dYQRM5ggFRja2KN
         uCkEL8oAfeKpA2U8kusb5NTnkEsJVHQUmknDO5H/Ax6W8Nwhup1PxyhA74BNu/Blxgtq
         iSXl395Wf1e4rzspf6EIxSOJB1oFWbYCIQAJCPO2YmPBNf2CD3FVZ0RuNaSxRNMHmhPe
         3ZlcTTw6dfO1qS2WsQ3LQLsW3BKz5MXQW3OrNccPnJWhnaL3Kr9d1K1Pn2+S9KnMXnVL
         x3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317798; x=1695922598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBzLJvv/ftwfpQgrnjlc3wBvEJtehhEbaRaf34rd/Ho=;
        b=Llq98ghb/ZBqIOg+h2ZITHMqohR0VW3phPXhHkJD1mI3WKyleWP4c4YxMxsCfNTXL9
         0CpM721hZ7EOkKjBN0X7dRxMFE9cAAWPd5dBwhwpGMf6ZNS1kjnwLL6LFCu1Ipz1du/i
         zL5Rh7E4cMnqM6SN/g1yW1wqbP1pdRNFUe20BK+6XSmMWG6j1vgfSqOpL0LMv7VZu7x8
         5Qlm5dGMJ4GgExZzMmjMQVgOmRuVX5wFB7qR5+eD9zQaPqpHW8z0rftiQOY7mCqSu4Xw
         hxgPgUpDQ9RrtO25PqeuEXACy0GT6m66dAS6kEVQAXH2g35fZ/Ky8cjvxA+zOThXrjWe
         kDaw==
X-Gm-Message-State: AOJu0Yz0QUb3zWeLe+dVi1leKUa+pGbYnwbQY+vXGWT6yzYPIROazxKZ
        GhAJSLxJypoZ7QTUWxLsBByJudFUX+He0ZpnQApTkA==
X-Google-Smtp-Source: AGHT+IFx0+0opFSDfHf+E0ps6Y9eB6I1HH/YKUUXQibtMkDSOHXkECPOMU5yz2XJaI8U9lF5aZ4Obhl7U0RkskYPY+U=
X-Received: by 2002:a05:622a:4889:b0:403:96e3:4745 with SMTP id
 fc9-20020a05622a488900b0040396e34745mr341867qtb.20.1695317798407; Thu, 21 Sep
 2023 10:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230920001728.1439947-1-maskray@google.com> <20230921072655.GA14803@noisy.programming.kicks-ass.net>
 <CAFP8O3+_8H+fetuoqwwcfqJLNtYmpsWZhY2arD7HMuPmcN+X_g@mail.gmail.com>
 <20230921153537.GG14803@noisy.programming.kicks-ass.net> <CAFP8O3K6Lgxe=Res9d2GKipRYdXqzv3wa_0PLtDcyn7g7H=z5w@mail.gmail.com>
 <20230921171900.GB29413@noisy.programming.kicks-ass.net>
In-Reply-To: <20230921171900.GB29413@noisy.programming.kicks-ass.net>
From:   Fangrui Song <maskray@google.com>
Date:   Thu, 21 Sep 2023 10:36:27 -0700
Message-ID: <CAFP8O3JpkWTXnxYxa45uANNMQ34g2VUPnfj7-oWn3oq9egUb-A@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation, objtool: Use absolute relocations for annotations
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 10:19=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Thu, Sep 21, 2023 at 09:26:43AM -0700, Fangrui Song wrote:
>
> > I do not see why absolute things need 12 byte entries.
> > We can freely use `.long .text.foo` even in ELFCLASS64 object files.
> > There is no risk of overflow (the ultimate link .text.foo may have an
> > address of 0xffffffff........) since the section will be discarded.
>
> And you're sure no toolchain is going to be clever and tell me that the
> absolute relocation will want to be 8 bytes and does not fit in the 4
> bytes allotted?
> Because clearly that is something some clever assembler is going to
> complain about any day now.

Well, only if the clever assembler doesn't support 32-bit absolute
relocation for a 64-bit architecture.
I don't know such an architecture. In addition, as long as the
architecture intends to support DWARF32, it has to support 32-bit
absolute relocations for a 64-bit architecture.

Of course, I cannot predict new toolchains for new architectures from
doing insensible thing, but
DWARF32 support and other metadata section uses are pretty strong
arguments for them to add a 32-bit absolute relocation type.

Note: some .discard.* sections before commit 1c0c1faf5692 ("objtool:
Use relative pointers for annotations") used
absolute relocations.



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
