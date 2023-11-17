Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4E7EF4B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjKQOm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjKQOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:42:57 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672D6130
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:42:54 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7789cb322deso117866485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700232173; x=1700836973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymqFoYk/jU858rX5vvkEZJFGQ4uv1Zr84sl14wdwAkk=;
        b=A7uix7vHhHlwRdRanJxg9GOSgXw240mxI4dNXty94h1qhdtkeDomkcQ3LxnTogXcd/
         h99AdtPW4JskjmMqm191VGK8u4zjq4w8uFUMx3uMEYe8w4AtErqZmxxK53+fx9UVnXOM
         flMbUhyR0ow0IpIglzzo4AX4lrWDk/se37VqWUzbywGRnB/acAuOc5wuEA7f0HbWqNcs
         Dv3T1PLevHs81ysvYX9ci5Y8MuMGMg+y2H/WW/o6DGHHN/XV4ENAD5+canuDF2JZAyLq
         5tI3Tm4fniLfIsSBxUBypoPAGB0E3RvuxLfdEcfmT5JKPMeAH2xpQswPg/qNysQ9Vvpf
         NjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700232173; x=1700836973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymqFoYk/jU858rX5vvkEZJFGQ4uv1Zr84sl14wdwAkk=;
        b=uqef9TFN3+odIJ2yJiU0aASqmHUw7g9R5cu6IP4CRKI2TASxc1u3m03lEV1UHLAYlQ
         ZZ96h+6u6zET7OHzy59vRfroVVB9qyFsv3LBzx7Cn0v++4VNqa9AowrkNh1uBdE0KlXi
         vw97p5DVhsEul+r08s41eBkDdZHZhkpxrlV2z6gQLRCHPm6vapSRXfl/VOhaRrpvk/eI
         jij6mYTWt39Wb7X0BDclwwWVlQjkRl3Ni+hAc+gjZdCVqavq1FUr9NgZ/zeUu12Nidb2
         DM+/oqJc2z4yjQOCS/b57ekWjmkZe9A5fvCO94vhR8qkbSnRu6/qdlKa0BKN8gB+/M5r
         j0Gg==
X-Gm-Message-State: AOJu0YzJewVvSxB0Lmog2DhxX/mKv03ki2xgAJ66ZuFhPxVtHlHVRg9j
        E00rLyeTA1+LSbFFzFdE44BWkfhGOxfSMUZVGXbXaKkXW5l32gZS
X-Google-Smtp-Source: AGHT+IGn0Cddkip2iaXYWJAtE1ecHPoBbkUTKNOWh+tFMZVSNA2LoidAFhi4yAkXPI75DuyF3urkU3g3A7BOVLEndsY=
X-Received: by 2002:ad4:4509:0:b0:66d:4b1f:e121 with SMTP id
 k9-20020ad44509000000b0066d4b1fe121mr11773822qvu.40.1700232173177; Fri, 17
 Nov 2023 06:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20231107160657.3798803-1-jens.wiklander@linaro.org>
In-Reply-To: <20231107160657.3798803-1-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 17 Nov 2023 15:42:41 +0100
Message-ID: <CAHUa44EXRjDqNjvf5dNVieopKvjVWgXh+NcEN=ec5W489fEORQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] OP-TEE FF-A notifications
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Olivier Deprez <Olivier.Deprez@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 5:07=E2=80=AFPM Jens Wiklander <jens.wiklander@linar=
o.org> wrote:
>
> Hi all,
>
> This patchset adds support for using FF-A notifications as a delivery
> mechanism of asynchronous notifications from OP-TEE running in the secure
> world. Support for asynchronous notifications via the SMC ABI was added i=
n
> [1], here we add the counterpart needed when using the the FF-A ABI.
>
> Support for FF-A notifications is added with [2] and this patch set is ba=
sed
> on Sudeeps tree at [3].
>
> [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander@l=
inaro.org/
> [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0=
-cddd3237809c@arm.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.gi=
t/tag/?h=3Dffa-updates-6.7
>     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version t=
o v1.1")
>
> v1->v2:
> * Applied Sumit's Reviewed-by
> * Addressed Sumit's comment on "optee: ffa_abi: add asynchronous
>   notifications"
>
> Thanks,
> Jens
>
> Jens Wiklander (2):
>   optee: provide optee_do_bottom_half() as a common function
>   optee: ffa_abi: add asynchronous notifications
>
>  drivers/tee/optee/call.c          | 31 ++++++++++-
>  drivers/tee/optee/ffa_abi.c       | 93 ++++++++++++++++++++++++++++++-
>  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
>  drivers/tee/optee/optee_private.h |  9 ++-
>  drivers/tee/optee/smc_abi.c       | 36 ++----------
>  5 files changed, 155 insertions(+), 42 deletions(-)
>
>
> base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> --
> 2.34.1
>

I'm picking up this.

Thanks,
Jens
