Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7087CFEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbjJSP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346478AbjJSP7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:59:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA1199
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:59:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507973f3b65so10570467e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697731145; x=1698335945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm/Wii6+7o3UXX8C55yUutEJQSIovh8VXkokjTN3YvQ=;
        b=K/NEFcZo6LXuop6dYkg2EkVZANrGbVlnANb4YU8w8XgxJqVRS59Lnuvjws9l34VXbd
         lcUQjtOplHylYKpkyF5OrwwTxiuRkxiQwEsEpEax461jOQ51LcqsfT+qFDwmIk1ES4d3
         cIsn+fudxCYIRGepGUyertcblfwmK/j9BM1HDUj61bma7N8tw00v98KrWoCLQaUSBu4R
         /yfaabDlKxaO07FDVqv9BGOoMahmZhbw2zp6jVo6qN7vuyJrf9zMbjWWAKglq72d3hzI
         TfoHMZ+WFZOy2crAux3luNzVQ5hiRH4GImUoz9zS0VwRPc11bx/BnIbXnJAT/YPP6i/n
         f5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731145; x=1698335945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sm/Wii6+7o3UXX8C55yUutEJQSIovh8VXkokjTN3YvQ=;
        b=TjYANJ6EZPYZbV2RHYB73nOL9o/yMcqadRTzZbCB+p3RAiblKu7wV2YGq0QmP0kSOy
         giGdUzPGt+7vrnVULFTgqGSZqvsP0uY1l0R+XAZq1bHj7E5bRDhaGqUXS2pykFnpbtU2
         igNA8RQSkRGnxay6mS2i7CXhMDZu2t4Yrf8bu0TZlqcRtJIvhXwszznPJVbME4tGKRqr
         8/S8utzkM1FZP1frtYnJMYkzj8fMszSv2D8EuoFJ4xjwuB6SfgkGMdgk96Uo7msfZgJx
         +ZwR6FeAhi5L8GgARv/uFKLfMastxZXj6pThGkMGbQ+uFj33/Sx4nuDpDpGDIxJ8iyIg
         s/mg==
X-Gm-Message-State: AOJu0YzgRwI46yV2XhplOi5l2/OHVhqYpquPGydFan8WdbK+AZPo+Mmw
        3SAtrVB2L43djA1+LYzFgmaMuayAghfUHvDG0ys1ZA==
X-Google-Smtp-Source: AGHT+IFhWqGbbE8JI0y4QRuxzilbQXa+K0fS3Bh2vLrdcR1Ry3XED7EDIlt4FyQSCadgcN054zLlg6tJMnlCOQmsWWg=
X-Received: by 2002:a05:651c:555:b0:2bc:c28c:a2b8 with SMTP id
 q21-20020a05651c055500b002bcc28ca2b8mr2127428ljp.27.1697731145578; Thu, 19
 Oct 2023 08:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-2-cleger@rivosinc.com>
 <CALs-HssL=wNwj9nRuZwpZhy1CB9p9-X=OqgwBw9zvgA7hA4fEg@mail.gmail.com>
 <20231018-scrap-bankable-a0f321d97a46@spud> <20231018-flagpole-footpad-07a6228485f3@spud>
 <CALs-HsteDO0PvAKKQje7wU0f4z8w2V3f7WiHh5+LvQeVaSua1w@mail.gmail.com>
 <0b2cbc89-7892-4c43-898c-03757eaaf3b7@rivosinc.com> <20231019-smith-purging-627c50cfa3de@spud>
In-Reply-To: <20231019-smith-purging-627c50cfa3de@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 19 Oct 2023 08:58:29 -0700
Message-ID: <CALs-Hsv2HK7dtZRi9R4GH0vZnf2oU9xVhKfK153S7Y_txUceqA@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] riscv: hwprobe: factorize hwprobe ISA extension reporting
To:     Conor Dooley <conor@kernel.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Samuel Ortiz <sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 3:24=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Oct 19, 2023 at 11:46:51AM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> > Indeed the comment was a bit misleading, is this more clear ?
> >
> > /*
> >  * Only use CHECK_ISA_EXT() for extensions which are usable by
> >  * userspace with respect to the kernel current configuration.
> >  * For instance, ISA extensions that uses float operations
>
> s/that uses/that use/
>
> >  * should not be exposed when CONFIG_FPU is not set.
>
> s/is not set/is not enabled/
>
> But yeah, definitely more clear, thanks.

Looks good to me too. Thanks, Cl=C3=A9ment!
-Evan
