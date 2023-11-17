Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FA27EEE19
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjKQJGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjKQJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:06:04 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C729D4E;
        Fri, 17 Nov 2023 01:06:01 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso1805700276.3;
        Fri, 17 Nov 2023 01:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700211960; x=1700816760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrD8+qkSJjr9Q+fiMn2ZGucWuBAaYvxiKOqNR6fU0Tg=;
        b=dXW2bCLqomF1ugBldSMZ9p3D02VTxtwUdMsfkmAdvEQU9cmz3ohLkeqi9qJiebNIBa
         bHRKzGc6iza2+8kWPDg63zx5Gsnt8BTNbnYhuzYImPBSGdA6yJhkYed3jxdWphF/KvAS
         dHIgC8eI2mhHrJMA7Knteqd9Oa0Q5E59gir0kE90cDYgU/rv/Upm+CWclXYQqGCnWbn0
         2P4zfSLoy4Oj4Fx7KVUd6ll5spUkhYvy3CnDz5B4xKLbcq0U/WuzgYOFK4YLpigi1ps2
         chRIR+vOVoUoq/4JLjyEs1f8Zy1xynHTHIXb5+lstQL6Gwr6qmM8J8hduRzWiX23Jn69
         LTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700211960; x=1700816760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrD8+qkSJjr9Q+fiMn2ZGucWuBAaYvxiKOqNR6fU0Tg=;
        b=voMT3M/k1DMMT092neCY5gNdb+kUY8HwBuXhqYFIzxqrl+kVjLOTfYUVpvNA2sAsnk
         KEc9g6bHKYidRmWEijpmtpUxw5NiUudCsLNWJSNHo51SjNVj3+gw+uiV45afxkuLgtIO
         CYYOVL8/WZyIH61Imx6cLaQdolBLMFERT5tMX0CUWz9WqWNvu8lNSMWCuMt0Jjj+pbHQ
         ZTn88HqKweqt2Uf+9jw2d8YNF/N08LwRNMty9Ng12jFbc3vsxEpwIYqGAYizo4uJ7qux
         GMO6602NyQVgn2PQ930MetRx3YTp4WfkuW42jD9qhwMt8IAuBCbqxKZPgP/H7LWoBMPq
         thyg==
X-Gm-Message-State: AOJu0YysG7Ie1k/8kevfc74gJDrOOu1Yb9gn0pzJYhHonBHmjLLIgDvp
        3S9EHVvm4YRes0mmmFR4eCP9rMEz1pmqlcdHpKk=
X-Google-Smtp-Source: AGHT+IEPixzhGpSc3tEVO8ZRFesnGrSzYBPawj/qAai8ntLRg9Ayp0XOI/51MrxatMcMZiHLvSJYqxEGgMe7A1fzuaU=
X-Received: by 2002:a25:6ad7:0:b0:d9b:4bfd:b75 with SMTP id
 f206-20020a256ad7000000b00d9b4bfd0b75mr15683441ybc.18.1700211960566; Fri, 17
 Nov 2023 01:06:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699521866.git.zhoubinbin@loongson.cn> <84cb3df17eee993fc6a10e965b3f438f9034d2de.1699521866.git.zhoubinbin@loongson.cn>
 <20231116173907.GA2446677-robh@kernel.org>
In-Reply-To: <20231116173907.GA2446677-robh@kernel.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Fri, 17 Nov 2023 15:05:49 +0600
Message-ID: <CAMpQs4KkOS1Eo-Y7=D2kP+yOW78zVN_7WDO_w0mc5-uaBGT47w@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: interrupt-controller:
 loongson,liointc: Standardize the naming of 'loongson,parent-int-map'
To:     Rob Herring <robh@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:39=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Mon, Nov 13, 2023 at 10:36:21AM +0800, Binbin Zhou wrote:
> > Since the 'loongson,parent_int_map' attribute naming is non-standard, w=
e
> > should use 'loongson,parent-int-map' instead.
> > Also, 'loongson,parent_int_map' will be marked as deprecated.
>
> Again, as I said last time, it is not worth adding
> 'loongson,parent-int-map' and having to support both forms in the kernel
> forever. If you can define a time that we keep 'loongson,parent_int_map'
> that's less than "forever", then may be it would be worth changing.
>
> To put this another way, using '-' instead of '_' is for *new* bindings,
> not existing users.
>
OK, I see, and I will fix it in the next version.

Thanks.
Binbin

> Rob
