Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8915077CB27
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbjHOKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjHOK3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:29:53 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57EEBB;
        Tue, 15 Aug 2023 03:29:51 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bc9d16c317so4205179a34.1;
        Tue, 15 Aug 2023 03:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692095391; x=1692700191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYDXyiZB78nsgrVFtbBiEWQh6Rm8Zgp3p/+6t5OSe0c=;
        b=acAS9HwOf7BPvfJSYqtarCjh8y6fAcxuiqLAUEudrMocPaIjpfMrfPUcq5+weHaHxZ
         Q2BSUEM9Vtq9V1M7FYkzSNRWZ/Kkuv0zJKMtA6/xLOjCm+W2YVbI7fRuuYNtvQv11isc
         eKNMiaaSBubHhRnnvsE7jj3PXYotge+huF3LpcuT131Nb73pXVcmUL0KTb+wPORjqMwk
         wBt7dxfxsKAqU9VUwHQsE2FiXkAr5AtOKcF8DC6biSNGk0ws2qqCpStVUzdlH7XrDTIE
         tYiDJ2rEHTRav2soHqT69OA+czUIksqWGGWQIuzTGPRlKaGQHzKtDBKIiMRsU4ZgDMdA
         gZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692095391; x=1692700191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYDXyiZB78nsgrVFtbBiEWQh6Rm8Zgp3p/+6t5OSe0c=;
        b=YH6cRsK7z7lfA/RxfpgIrrEl8db5mbdezCqmRNP7hYcj7G5hFIgzDfs14F5xKdrr/I
         xj2OvJT8su6cDcdUWEXnsEeIGMer3DImKHzhLk+d3ZSNVy+pnHQfXRX2VprfCBxbAT9Z
         1j6+k3+ApHlea764+NcUii0YIp+V9nBb2M8vqMmTYz3bw1genypPwnkBOz1/T1tWLRpW
         YsSi+beQ0LfUDe6Ly4qditt+ridRv2XfC93pigvPPFUg3k+VC5BnfgaYb+kRCEXUzx4H
         Lf6MdjZB58bhtFiEjGDX5yc9gmsQFIq/pgav2EDg1OTPwvgS0Vmbq3Y7AQhTeNoPY1vX
         6YtA==
X-Gm-Message-State: AOJu0Ywgvof8aKiV1qnn5mNmAnqB6O6t1OhKZhuo+mb9pIUDaY0LPwhP
        TY9E6djXi8hdmoYOuE2inZwZeNpYmxUC2cHZ0gk=
X-Google-Smtp-Source: AGHT+IFUzE2FcYCsyVhpeRb1n3RSSTTo0sSL5CLJwo5HoUGzz2Zr7mZIBP1US+PdtcFC8R7x7fpMBSFIRPdja3hqjTs=
X-Received: by 2002:a05:6830:1d72:b0:6b8:7eef:a236 with SMTP id
 l18-20020a0568301d7200b006b87eefa236mr10375640oti.30.1692095391030; Tue, 15
 Aug 2023 03:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230815014057.13589-1-wenchao.chen@unisoc.com> <e66ee2ba-1668-cb88-f7ac-7c7722387fe7@intel.com>
In-Reply-To: <e66ee2ba-1668-cb88-f7ac-7c7722387fe7@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Tue, 15 Aug 2023 18:29:39 +0800
Message-ID: <CA+Da2qyuh-WcXdj2emkWcUkqH57W4p6aei8wijFw5fA7og0eaA@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: sdhci-sprd: Add SD HS mode online tuning
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 2:21=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 15/08/23 04:40, Wenchao Chen wrote:
> > Change in v2:
> > - add mmc_sd_switch() and mmc_send_status() to the header file
> > - split up core changes from host driver changes
> > - Use pr_debug instead of dev_info and dev_dbg
> > - Optimize the best sampled value algorithm
>
> What about hooking ->set_ios() as Ulf suggested?
>

I've tried that, but it's not a good way to do it.
We found that sdhci_runtime_resume_host() calls ->set_ios, but we
don't want to do that.
We just need SD HS mode tuning at mmc_sd_init_card().

> >
> > Wenchao Chen (2):
> >   mmc: core: Add host specific tuning support for SD HS mode
> >   mmc: sdhci-sprd: Add SD HS mode online tuning
> >
> >  drivers/mmc/core/sd.c         |  12 +++
> >  drivers/mmc/core/sd_ops.c     |   1 +
> >  drivers/mmc/host/sdhci-sprd.c | 152 ++++++++++++++++++++++++++++++++++
> >  include/linux/mmc/host.h      |   8 ++
> >  4 files changed, 173 insertions(+)
> >
>
