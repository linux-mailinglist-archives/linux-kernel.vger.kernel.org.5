Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318DD7E2655
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjKFOLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFOLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:11:44 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD53FDF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:11:41 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5b383b4184fso54024407b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699279901; x=1699884701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ODn++dUHbXaMIGDwTBO8HRgNU7TuGpihiT0x1eE0ts=;
        b=ipmIGwRoIRx4utESMV18ltXnQED4V8PIqas1/M3I2Yq4iP06+LQ0pyB2rdPIzllFxS
         cNijO3OSTdRCO8pjWLKTjxXeuUrxWvRwDEaSzv0Lkhw3p8Vgipf+RCj5V2Zw3qNwfYF6
         herfJ25sYSNO2p18X1+FL2gLnLpIo+xmkPoEMYJ6ex6Mc6vX/DFO/jXkehq6b8fzAf3N
         /g0ZrxFpiApHO3YSOaac0VwTgaFl7pJAd6jU95aBH0urZAwQF3VKHrkmV5Q64762zlKP
         VnX2Dd45KLvwBILmouE9Eyy4ToeEyRK3rbLBKtvD63k6y5xSzEN8lW1GGJvvmEGwnxo+
         f5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699279901; x=1699884701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ODn++dUHbXaMIGDwTBO8HRgNU7TuGpihiT0x1eE0ts=;
        b=KO0S9v445gXCHr8dziMi0AH7avUTJx6kFlug49iQkUg+pgUQIYefQYGdNhFiZCuECd
         8FK05jbfE5fAiRLrrw1f71NPZsjX0k5ikzfF0p8Ayky6jTr1sbuiiGdHTjz65dWWLfDI
         jI/PzTiwznfapppWbIzF/FrcOll5LnRmGj86k8E1Ldz8EFOPeR45PBSJjYHf5Nvo/owO
         aHg0X9P8CWehFI2SeJYgdNCA6NCd8PHTl2IQ7aBZVWcohBJPssyYgmgMFpZAYIdLeZJO
         jE/TKF92jUj2cffhTjwxVI42TLibjvINDvijuClV9SOwAYF6/dAzuk7KdkaQtO+F235U
         yMRw==
X-Gm-Message-State: AOJu0YweApMAzgbbkzNGKrj2ctaWSW6fjmGl242AWQbg/+S0FBcHIrC5
        SMi/pcsryZPMR2PHriRZAqogsokl46ExdoY5haCufw==
X-Google-Smtp-Source: AGHT+IGq8v3jwn+3ZwyAYS24yFVZoELQr+D4HYZ50lJCnz5T9VmWyscEmFpzDH/0ZSEDhcSnoNINtBDLng1TwUdhQ8s=
X-Received: by 2002:a81:6c94:0:b0:5a7:bff3:6fe4 with SMTP id
 h142-20020a816c94000000b005a7bff36fe4mr11378024ywc.9.1699279900942; Mon, 06
 Nov 2023 06:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20231023090613.1694133-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20231023090613.1694133-1-dario.binacchi@amarulasolutions.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Nov 2023 15:11:28 +0100
Message-ID: <CACRpkdZwTQSNymOMFVTwWZg1-GT1=yj7rwbfo8uWH1V_R5VCrg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: nt35510: fix typo
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 11:06=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> Replace 'HFP' with 'HBP'.
>
> Fixes: 899f24ed8d3a ("drm/panel: Add driver for Novatek NT35510-based pan=
els")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Patch applied!

Yours,
Linus Walleij
