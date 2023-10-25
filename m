Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D847D6A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjJYLzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjJYLzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:55:52 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FCA18B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:55:50 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d12b3b479so34289466d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698234949; x=1698839749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7KZa/qCszE/qP7vkqP3vueJq/YTW0r01PBUz0b3K2Q=;
        b=nognSAgjrkYnM6M9FhSzC38LlNk0Dw7Et/hfQ5FlXE7QePrOs65TZbAFg+z+81Xnky
         bEzuj8GIFPFNUCz8BL/ejDmOETobQQOEFefLdc5wIttZZ9IZsyEV/SUwRyH4sZo2Qyfa
         DkX6Y5CSQxzzWvrfZppawbgttCIHs8Jpka9MUx5gt8HYj/CCOpnI5LkCebG+kqkwiVtB
         zZAwEq79A2GD8EvEp62RIzsa/bkRN5TopiUf6BVLoWQvhI4+PHEVnFySFCA8HTu5xz/q
         5S+CFhgVVlVvCfCXIyrYHWY9N4oqgt1yaWqVFlUjZGnBd0/DjuzLeiRq4MKlfVzXAj9S
         y8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698234949; x=1698839749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7KZa/qCszE/qP7vkqP3vueJq/YTW0r01PBUz0b3K2Q=;
        b=Jbbrk/2Wrh/QUR6yW3SiIO7HrWT2RowDwOFcpR0GmZV2XyPx2xfjgoAFqsHDvcQI7g
         CUzV6cy1wDrOi51JBIbm7vvvExdzFc+CwgYVnrYuKL/1gBTnCEXTGYEyzHl/K3cQqVCc
         vbriVrab/Q/zBxh6I874VuUpSgPVGj7Hpp7bej7ixA7T9d4KHyYyVcdYSmbJeMgyV/+3
         d8DKr751ipO7dVZhElmUWTjQBa9ty7BLR5kc8ltz0Cn0sE6aoBvtFfA+DAGPcN847F6x
         fCVxsxxfDB4iSu9uz5nkxwgrf3yi3bWd3kUF8McTIEmenLcyfG0I6kELJncGMnTYZekw
         DPYQ==
X-Gm-Message-State: AOJu0YwoLY/uLArjXfIEGwg5Jd3Fso/ijCCVGRguBsk9dPVVMafLlDz+
        w/uHk3O84HeQSDIr2nhSjhUv0aXkiAlgCl2WBWtR6w==
X-Google-Smtp-Source: AGHT+IHE1uViCDUfMiNXj4holbQZGa63puvIJAluMezFuLYIGaI53tGviDjPks5uBUFR1ZJU9vQqyRM1cLHbnQiLUkE=
X-Received: by 2002:a05:6214:29e3:b0:66d:2435:b3f8 with SMTP id
 jv3-20020a05621429e300b0066d2435b3f8mr18433118qvb.4.1698234949644; Wed, 25
 Oct 2023 04:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
In-Reply-To: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 25 Oct 2023 13:55:38 +0200
Message-ID: <CAHUa44GewV_GcBWk89foNu8EPVgQ03LvOTxzjgp5Smis34GWdA@mail.gmail.com>
Subject: Re: [PATCH 0/4] firmware: arm_ffa: Few fixes for FF-A notification support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
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

Hi Sudeep,

On Tue, Oct 24, 2023 at 12:56=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com=
> wrote:
>
> Hi,
>
> These are set of small fixes around FF-A notification support that are
> currently queued in -next. It is mostly to take care of absence of
> the notification support in the firmware as well as allowing them to be
> optional and continue initialisation even when the notification fails.
>
> Regards,
> Sudeep
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> Sudeep Holla (4):
>       firmware: arm_ffa: Allow FF-A initialisation even when notification=
 fails
>       firmware: arm_ffa: Setup the partitions after the notification init=
ialisation
>       firmware: arm_ffa: Add checks for the notification enabled state
>       firmware: arm_ffa: Fix FFA notifications cleanup path
>
>  drivers/firmware/arm_ffa/driver.c | 65 ++++++++++++++++++++++++++-------=
------
>  1 file changed, 44 insertions(+), 21 deletions(-)

Works as expected with and without FF-A notifications enabled in the
secure world.

Tested-by: Jens Wiklander <jens.wiklander@linaro.org>

Cheers,
Jens

> ---
> base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> change-id: 20231024-ffa-notification-fixes-9d5cf1e131ef
>
> Best regards,
> --
> Regards,
> Sudeep
>
