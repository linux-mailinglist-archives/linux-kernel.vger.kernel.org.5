Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B05C7E141E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjKEPj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEPjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:39:54 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC659A7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 07:39:51 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5afa5dbc378so38874797b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699198791; x=1699803591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIRczTXfn+cVdrtwd6HPB4w+9CcJ9CMEei9Vyyc427c=;
        b=pfn5JOgRe9MXAEpOmtUuJZ+nAeWjiKM80ldbCVW1EBG9ksXhQKm5OraONKCsI0x3C6
         SHDl5CfKFLxvk5QV5iIoufg5sNkD7VhRajG0Fa9sugBnErzOULLqHzVet2CzfWeI/SFn
         RcD0gGmIRM7pxwMvSRGm0t+9KVJm8eKtrSe93k10Q3dGuyxiqOW0BWH8m4S7Bn65Peny
         pd6wBD56Y9ewajjsFk8JvYu0JHeo0fvkdNFvw8z60EQBOt/BkamGuZAf07DybulG6syA
         tonHHzBkME/UOYNWByXfpfEqcMQWKD26przqD/zDyJ9MWyoK6u+flry6UZA1ZTfZI1h8
         tDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699198791; x=1699803591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIRczTXfn+cVdrtwd6HPB4w+9CcJ9CMEei9Vyyc427c=;
        b=pKDYY4UDWdbSMrxI75Ocqp3qqVddju8mUvGP1mWKrrdfhKNEqZSVm5jQ/X8Gbyj/A9
         cSlo/ucr0SxBSYx9NuPfp0XWrOV+CcZwsuHbtv+7V1ZXtEFnYQfUoNmMzbXTDDagfZN/
         6A/rHzydeUrt1M1PrCbnR/izpSx5HUQme5jfIT/3rOczvVINl+bDQOmSnoR631z4OhGG
         qVL8jGLF8ahgDJ+XNwYfCrZ3oCAPfy3ot2j5Tt5yL7DiCV+nP7D4TWQkuBhiCWJu8X97
         k8FWJVlz8rkJQFgG220Ldn5+AlWR6Bwh4HBl2N0E3htK5N1ONGhKpvxYFY8Ec27kECcH
         ewRg==
X-Gm-Message-State: AOJu0Yx5+1BG7wKdzVp4m5yDnUC3CbLxCvtzRJtHdNgtfdHRLyiQNlzn
        ejA1YOVbQf2FSewlJg3JBuBpD4iyQn1zbxNJlJKuSA==
X-Google-Smtp-Source: AGHT+IHEEd3Z58OJSbu1kC00IY8Ri5dk/C9FXZOIVPhdVnSWfheJrkBviCNduE6nekOB0EJ+yhrPM00IBE9vwiOhmqs=
X-Received: by 2002:a05:690c:388:b0:5af:5c55:8298 with SMTP id
 bh8-20020a05690c038800b005af5c558298mr5566964ywb.36.1699198790965; Sun, 05
 Nov 2023 07:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20231104-no-y-uapi1-default-v1-1-f60d318b6fbe@linaro.org> <ZUbsAhXyk-d4R2M9@rigel>
In-Reply-To: <ZUbsAhXyk-d4R2M9@rigel>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Nov 2023 16:39:39 +0100
Message-ID: <CACRpkdYP7kO99wV2q8=2q-Q-jgDQf9JHHVdLZEs1tN7AmQF5EQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: Do not enable the v1 uAPI by default
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 5, 2023 at 2:12=E2=80=AFAM Kent Gibson <warthog618@gmail.com> w=
rote:

> If you want to provide the end user with two years to migrate, and given
> that libgpiod is the major consumer, you might want to hold off for
> another year.

OK then, just testing the waters.

Probably we need to encourage libgpiod 2.x a bit.

Yours,
Linus Walleij
