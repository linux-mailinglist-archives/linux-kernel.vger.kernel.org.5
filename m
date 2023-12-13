Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E160B810E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjLMJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMJo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:44:26 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A9A4;
        Wed, 13 Dec 2023 01:44:33 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-dafe04717baso6385873276.1;
        Wed, 13 Dec 2023 01:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702460672; x=1703065472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ASYoeG+9AFvYeeDJHcee3eBqiXqRIFwrkc299zj/Pws=;
        b=XWqUwPoDtjvM1vjDd9e9vrPsG6+yiPLPf/szFuPKe1Y/7kv1wPxPU305jiUYLv/qei
         kc9AOWpbgeUuz22KnS1yPLAVvTqfU7fneQKlGHu7i61M+d28fEy2Ym5MMTPmVSq6nO1h
         qYFwry3drA7WXYCscIlAMub65MYUUzoCHSCqZkLzPlsF4nceo5q7fEWjPjvqAf5UoeRl
         snhg8WdL7h20tecfeBY5OE/jfO2locHGX7r+xDuEBCMg66Ndz3f2OieBi6I6pazIRp7M
         DXRsDtJxFs0MlNXH6ReAiE61PWXFWxHJXaPFZK58t+G88KaU+lBx+0exov4AsZ310FL7
         9S8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702460672; x=1703065472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASYoeG+9AFvYeeDJHcee3eBqiXqRIFwrkc299zj/Pws=;
        b=SiVWMxDTyLtxX46VsOT4TKCjKfTW8ZFKM8g1l5i8fYMX9oYUB/0k+dXGNDLiKKQubK
         3wwKwleoRdBME5X6vOJUDsvd32Ms47n/ycaaWJu/3xN7r+i8LU1M7rdWAI6yA7Jp0+7x
         QUlLrDuVI6NmTTbis9CIWQnCs32QxbVfVZm/DEmFcD2FSRFN8Gg459u0fVtrCcMey0x4
         DxoSOGxdzH/qRtchqF+GlBsIh3Mlqy2XeNYDzd1DNU2zYT1kFgirFL48zLIHMagez/OJ
         B6gsUHAEtCpSzMwiSiRnTbnRAF3tvXKl1dHcnCUHaqqI02P9c9zeX41OXK5IFU/0a3pe
         ZMhg==
X-Gm-Message-State: AOJu0Ywhdgu9boyA0ixNrYcejcDd8DNmsb6b4pexH9go4es3E/J/H8fA
        HmU7Wm9ibnSVkcmVjaoO63piDblMG9Ym2ZIw3mRKUyoI
X-Google-Smtp-Source: AGHT+IFReZMPdh5wXkNk5emmDJZPdiX21eGS/QS6mi/SzTILCLuAo7qMjKxWOkz2Q1T/74u/1LVTt+yT2DQIlorAmDI=
X-Received: by 2002:a05:6902:1b83:b0:db5:4589:6b61 with SMTP id
 ei3-20020a0569021b8300b00db545896b61mr6408136ybb.18.1702460672466; Wed, 13
 Dec 2023 01:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20231212100703.3374555-1-tmaimon77@gmail.com> <3cb1647d-c58e-4040-9e3a-61965e6a08ac@linaro.org>
In-Reply-To: <3cb1647d-c58e-4040-9e3a-61965e6a08ac@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 13 Dec 2023 11:44:21 +0200
Message-ID: <CAP6Zq1j2O_Y7oApBp2dJJzEmrtO2fYzc8xKA9Jsr3BTimLfmMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] soc: add NPCM BPC driver support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     arnd@arndb.de, pmenzel@molgen.mpg.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your comment

On Wed, 13 Dec 2023 at 08:22, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/12/2023 11:07, Tomer Maimon wrote:
> > This patch set adds BIOS Post code (BPC) support for the Nuvoton
> > NPCM Baseboard Management Controller (BMC).
> >
> > Nuvoton BMC NPCM BIOS Post Code (BPC) monitoring two configurable
> > I/O addresses written by the host on the bus, the capture data
> > stored in 128-word FIFO.
> >
> > NPCM BPC can support capture double words.
> >
> > The NPCM BPC driver tested on NPCM750 Olympus board.
>
> Where is the changelog?
Sorry i forgot to add the change log, I will do it in version 3
>
> Best regards,
> Krzysztof
>

Best regards,

Tomer
