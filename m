Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7123180861F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjLGJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjLGJ7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:59:08 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564F133
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:59:14 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db539ab8e02so878046276.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701943153; x=1702547953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6K465pI4zAWlwCamlpDG3HILRkV9gPVUA692gl6Sek=;
        b=O55XMeMlHOwm+GbmwnwdJIf8Tb5gumCUwMQnspnn/K0AiiXvZ6jlXGOCT08XfFgORF
         aWKiDAufxdj75Jb0o4eyq83/3da7EuU7EPQDTlXOHrp5Q8DvmRfu7VNORk/r4pRZ8ajy
         eDSoajDaghkYNgKF2rGvI+PRjk5zSplohxDhAlbUSlAhfKNJKlxHoAZCEzogB7VQ7BSC
         SeLoGsrzqoftl62DFFH25HLRyAPQMjUSlkk8NrtUfYTPXt03E7ZuXIECiV9tpyru1a7o
         JvMFAEjrpPeSzex9bV3eWlFFJwF8+UJG0x8fqiVedGXAEnIMp9YJZhR7HQs+tiDcgt9J
         jxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701943153; x=1702547953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6K465pI4zAWlwCamlpDG3HILRkV9gPVUA692gl6Sek=;
        b=RJODMBAhITGLHZd5gsfbH5ODTa7Vr0sKeWgYejtlb/o4pn4a56rqzBzNVUy4HX+z0q
         nTsUpqIxxh1LToWCfWAzL/+6EnNsnvaAb3H2pbQ4SHlC1E95fWDswBsqTwtpzfkSPZet
         55xL+aFERvVd5BDO0BmjD/ZDScc2xX7i12YFYvNsyJE3tTWQgfvFkzq3USGkRqJGsELP
         K5LaN486tFxZIR/gDIXpa0igxeaz7UOUNwcgeLP+JGZMQDB+868/HN0KphOkxsI0cfyh
         aqKrkb0Pj0+g0/jbZDTBTmAXD2RABdybfiUFZ2wEgrrJnr9NNKwJySwSdwh/GJzJHBCS
         QZbg==
X-Gm-Message-State: AOJu0Yza3hB6uXS1iNUpXpgCH9LVUcnRU+AF9nyIPDVMCw6Dk4lCYWgj
        dr0MmxIeVQNOIRu5rMn6+XxpRw8858rCIYx8Lfs8Aw==
X-Google-Smtp-Source: AGHT+IHcD5fIoEp/CcfEh8HnMUMO2l3b3jKL0vWFNg+litPEiRW5cySzVq5LBwYkPm8QSog0pjXe77K4eJFUFT+j6Y4=
X-Received: by 2002:a25:b8b:0:b0:db7:dacf:ed91 with SMTP id
 133-20020a250b8b000000b00db7dacfed91mr830253ybl.114.1701943153500; Thu, 07
 Dec 2023 01:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20231204203357.2897008-1-ben.wolsieffer@hefring.com>
 <20231204203357.2897008-3-ben.wolsieffer@hefring.com> <CACRpkdZKjcE5yMF0=E+4BRTEmrShSqFzCcyH8Rug7u7kOotUQQ@mail.gmail.com>
In-Reply-To: <CACRpkdZKjcE5yMF0=E+4BRTEmrShSqFzCcyH8Rug7u7kOotUQQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Dec 2023 10:59:24 +0100
Message-ID: <CACRpkdaqZ4+oefozT863YbsY7e1kVJvSMBuiFmwhKSeXtPsE2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: stm32: fix GPIO level interrupts
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 10:56=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Mon, Dec 4, 2023 at 9:35=E2=80=AFPM Ben Wolsieffer

> <ben.wolsieffer@hefring.com> wrote:
>
> > The STM32 doesn't support GPIO level interrupts in hardware, so the
> > driver tries to emulate them using edge interrupts, by retriggering the
> > interrupt if necessary based on the pin state after the handler
> > finishes.
> >
> > Currently, this functionality does not work because the irqchip uses
> > handle_edge_irq(), which doesn't run the irq_eoi() or irq_unmask()
> > callbacks after handling the interrupt. This patch fixes this by using
> > handle_level_irq() for level interrupts, which causes irq_unmask() to b=
e
> > called to retrigger the interrupt.
> >
> > Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Marc Z can apply all the patches to the irq tree once he's happy
> with the solution.

I see Marc stopped doing irq_chips, so tglx then!

Yours,
Linus Walleij
