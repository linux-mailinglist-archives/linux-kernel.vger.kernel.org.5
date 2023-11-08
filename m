Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39937E5172
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjKHH4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjKHH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:56:12 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DD199
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:56:09 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7789cb322deso423522885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 23:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699430169; x=1700034969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8w1oUIV6klkbpaooYBF8vQv1FOMQ0nxRBBCHhuNDO0=;
        b=nBX4z5F0s8vIxiiROnrnG9Moai/yIzsYdq53wjqC5E7t4IsEG0b/Qaynhp69m5YUtf
         7sZbF1sixXp1sbT2rcacArku5e4K7OGM7rUe2DSJKsNNVWsTWp+gjVJzTrm/sjw9ak/Z
         o5D/32WtcG2tQ5o2lC6djoETOoUCejCba/zzIWw0IGK+LDjEn937ozPPE7FUkhXGhz4w
         x6V1sKYyLJPn7Mj0Jt1KRKXPdv3yqN4VlVVfh05N6L4Kb0WVi8vo/2Je7w9Nz6fq4fJz
         V0KxTzYgvvi3+YYrmnp/Nb+DzD+uzcebHnTD2GbxuaWSqmSnUlF9QC78PLkueJJuCqib
         /A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430169; x=1700034969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8w1oUIV6klkbpaooYBF8vQv1FOMQ0nxRBBCHhuNDO0=;
        b=ihOH4F9bHwC079n2nx0HX+F+hDDeFI1XW4ubbKYNnRTv5e9mCXN7HGH9F9xY8iRKB2
         hTQsYBmPkCmzJrlyDRdIj0IGG6SUr2CmRiyXTOU6oiZ+lsScM9gJLJzOnhdsX9xq1LmJ
         1EFoVnzNnoRmADQt/04kKRjGdn7Y8rM7wixYxCAt8bNaJqRLNMcO9DuUFFh5FnOmhlJd
         Vyx31r2Ncsf7Kk0tYB2EBLF0hllYmGdvHrP4hj6W246ySTMs9bldRoab3Y04HPcED3Tu
         onL81UUZ3VojGILCG3yxOirUMA5o+2f2p6c9rYz6Yv6EX4lVrFzmjWQIlkn1mc5l/RoR
         IDXw==
X-Gm-Message-State: AOJu0Yz7BeTCp6mX12JPRxC2Lq0AMhbnbn63mTm7go1v5BovNBn8RzXW
        lQffDtfa/cCSp8InQ2CNJ/ZSOQqCafVp6ZaHSlgMgQ==
X-Google-Smtp-Source: AGHT+IGsdkg8STwLENrBsDgchNZNRsDeHm7bYpswSBdNOg3DTtiOOrLlcmATTww2OJz8gxU7EvanRomYrspFYydQcSU=
X-Received: by 2002:ad4:5d4b:0:b0:675:b8fd:b544 with SMTP id
 jk11-20020ad45d4b000000b00675b8fdb544mr1305574qvb.54.1699430169056; Tue, 07
 Nov 2023 23:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20231030084812.905549-1-etienne.carriere@foss.st.com>
In-Reply-To: <20231030084812.905549-1-etienne.carriere@foss.st.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 8 Nov 2023 08:55:57 +0100
Message-ID: <CAHUa44F+vGOWP-D2Jy+v5iQqDwV6q5uf_ZHt3FaoR7aX9R-oUA@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] tee: introduce TEE system sssion
To:     Etienne Carriere <etienne.carriere@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 9:48=E2=80=AFAM Etienne Carriere
<etienne.carriere@foss.st.com> wrote:
>
> This series introduces TEE system sessions for TEE service sessions that
> require TEE to provision resources to prevent deadlock when clients call
> the TEE.
>
> This deadlock situation can happen when a TEE service is used by low
> level system resources as for example when Linux kernel uses SCMI
> service embedded in TEE for clock, reset, regulator, etc... controls.
> This case is detailled in patch 2/4:
>
> > This feature is needed to prevent a system deadlock when several TEE
> > client applications invoke TEE, consuming all TEE thread contexts
> > available in the secure world. The deadlock can happen in the OP-TEE
> > driver for example if all these TEE threads issue an RPC call from TEE
> > to Linux OS to access an eMMC RPMB partition (TEE secure storage) which
> > device clock or regulator controller is accessed through an OP-TEE SCMI
> > services. In that case, Linux SCMI driver must reach OP-TEE SCMI
> > service without waiting until one of the consumed TEE threads is freed.
>
> Etienne Carriere (4):
>   tee: optee: system call property
>   tee: system session
>   tee: optee: support tracking system threads
>   firmware: arm_scmi: optee: use optee system invocation
>
>  drivers/firmware/arm_scmi/optee.c |   4 +
>  drivers/tee/optee/call.c          | 130 ++++++++++++++++++++++++++++--
>  drivers/tee/optee/core.c          |   5 +-
>  drivers/tee/optee/ffa_abi.c       |  14 ++--
>  drivers/tee/optee/optee_private.h |  29 ++++++-
>  drivers/tee/optee/smc_abi.c       |  32 +++++---
>  drivers/tee/tee_core.c            |   8 ++
>  include/linux/tee_drv.h           |  16 ++++
>  8 files changed, 211 insertions(+), 27 deletions(-)
> ---
> Changes since v11:
> - Fixed inline description comments in patch 1/3 and 3/4, other patches
>   are unchanged.
>
> Changes since v10:
> - Changes patch 3/4, other are unchanged.
> --
> 2.25.1
>

I'm picking up this.

Thanks,
Jens
