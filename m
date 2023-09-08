Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A043C799157
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbjIHVAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIHVAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:00:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0706ADC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:00:44 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d7e9d849bdfso2228693276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694206843; x=1694811643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh18cb+B4DQiVqR2FUjNTiQ8Lh4wfYdzCcaNqcauz90=;
        b=CpNgAR1U5bRgvwfdGTgrAj4+GXpWl9u6z6aBoKW5bjG53DwciuPwMZ0+4KGNJm8jBS
         GskrY5CT9NFVqYMbn6ApKqS5YF4TE+JEKV42vcnAi8Wdh1tdky9Q89W+D1Pg/yF2V5uB
         XFHBBXCB8pdvTfZhaG9PAhLQAyQhfRT0asJCjLROQZSPSgjXYo627HgXc3CFDFEAxrWR
         XeRN2v7p0jqd1S8/xsc3DgT5+IbNw3S5g+oUBtBomiA8ZrjIEAC0O6tRWij8fqPvy/+9
         niXravnZCnVK5Tqxa8E6LyLOz5/Ba5AfDTfQtTJ/bhwfGdN4vun/HpoBMMAgNc3KfUb8
         6Y4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694206843; x=1694811643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gh18cb+B4DQiVqR2FUjNTiQ8Lh4wfYdzCcaNqcauz90=;
        b=Stf4xu847RUorNmg5LZSu5UrMhooyFO7OxyWqLLstyBQox1XcXcpLhaQhQfNPcWeRe
         leof8XIP1dY7HIciVkTzmb9nszg0NJiGzlpBSH99nCg4aa6IEBzh/9AsSQ4A8cMU1Iaz
         6BYUXy+elvPrQYZPPz/kynnCEjrwTQTEBDK9vypKYS+89aHmEp7uv8w4qjzQd6UXWj3I
         6Rj9qMRI4OJ8r+NyZl+bi/CtaP7oWE5Gudd3sXKrS81Bywbcx85/dOvaAsgMIPoBlCds
         Iqc8+oKWPAydqktDI/tu5gWT+VNu88Fsd3IHx54dRz024K2prlAhoL0X4oFm86vX2GUY
         oVaA==
X-Gm-Message-State: AOJu0YzGoHrfIj8cep4GxYEPhPduBYb4v1dkp/P9lLzP2ikw8VfFXp16
        UzRAQS7KOZAI34H7zFD5ALzi4MruI9GqFYZeIxY+SA==
X-Google-Smtp-Source: AGHT+IHkEpImwbbsHeSlP6vaeEcHIvp1Q6piKEPtcNTxlSMYR8qKJjRwHSrRyCqbNK4QvGQ2NZIZknHe6PF50W7CxKk=
X-Received: by 2002:a05:6902:704:b0:d12:77c7:b362 with SMTP id
 k4-20020a056902070400b00d1277c7b362mr4350629ybt.26.1694206843217; Fri, 08 Sep
 2023 14:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230907143302.4940-1-zhizhou.zh@gmail.com> <CACRpkdY=EYQfRrUaw5JL5e0x2p=KurYfwvfunJ+GF1PmupKNqg@mail.gmail.com>
 <ZPsmiV9I4qbqpAsO@shell.armlinux.org.uk>
In-Reply-To: <ZPsmiV9I4qbqpAsO@shell.armlinux.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Sep 2023 23:00:31 +0200
Message-ID: <CACRpkdYdf9H=LNRZMPurzTcA+bqoOHC1n-8TeCnVdz_iF7H+NA@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: fix stack corruption when CONFIG_ARM_PV_FIXUP=y
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Zhizhou Zhang <zhizhou.zh@gmail.com>
Cc:     rppt@kernel.org, akpm@linux-foundation.org, vishal.moola@gmail.com,
        arnd@arndb.de, wangkefeng.wang@huawei.com, willy@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhizhou Zhang <zhizhouzhang@asrmicro.com>
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

On Fri, Sep 8, 2023 at 3:50=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

> However, it makes a total nonsense of the comment, which explains
> precisely why the flush_cache_all() is where it is. Moving it before
> that comment means that the comment is now rediculous.

Zhizhou, can you look over the comment placement?

> So, please don't put it in the patch system.
>
> The patch certainly needs to be tested on TI Keystone which is the
> primary user of this code.

Added Andrew Davis and Nishanth Menon to the thread:
can you folks review and test this for Keystone?

Yours,
Linus Walleij
