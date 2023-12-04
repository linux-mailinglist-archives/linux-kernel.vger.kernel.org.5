Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511068039CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbjLDQLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:11:21 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0CAA4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:11:27 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4254adc1f1cso14988971cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701706286; x=1702311086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLbHKm7/lgDwaDgnbAdnxLd6DuvDCpDhtD1Uof8rcGw=;
        b=RgJubYn9d3a+5NL3NzXps+vk+f/9/6fUUaUsNcFbAXYWn+BMcn778z75Hp9MOlUy4s
         +e5i1fcUNM+rGTC8e4BCpIOhuhLCibFvjN/M35sCRYbHmO9YNc4QlY2uWrnVutilQbPd
         jXVwY307KEhI+irNVsgV/vO8GVq1yYct8JCDtSqtrVXKiCeixPi/UTKgEGGYC1yvOWDq
         ErZo9+MkpmM62tudt/y5M1DJt6/0fQjaCEnKLHwD1AiAjAOQotJCUGcZEuxwQVaRdOYE
         9woX+JEIU0TueQbv0ZZKmwFl2kj5jCoBiQJbkBFfhXjWOFnCO1ne0YISEy/4qqKrl8T+
         HvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706286; x=1702311086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLbHKm7/lgDwaDgnbAdnxLd6DuvDCpDhtD1Uof8rcGw=;
        b=DBwyoo97Ts8n58U8NNkgaF3dVseplxw7PlEPiSKZiHAQ0lh+TgotfknTsy6rtThQV+
         Wjju8tLqGiS59uHO/nZscZl+JqkvFFLD+jkTuyA5I4Jt47IbZNfjvNRFVSSgjCty5hz/
         lel68SsGauAPjQGHMMEQVjmZpEyhbFItLz74vRGpiub/X12DHsX64LYJakIo1PgS29+k
         IxS3WUBHR2ZyPm8P5VUw25a5nyHrCS5x9T7wbpKki4CP1AQnJM1+no8WauFUQtjjoJ1a
         Co4r5W95yvNftqav1I+hNOP5Rev6C1ib+jBKrWixYfQeKKKW/lCeYTge/lvSoZPZ5d95
         Yn8A==
X-Gm-Message-State: AOJu0YwaexgtRLQcQwLaNgxn3QFSwfM+J+RfMe6fGHkjHiDicKpqB5lt
        K7GlYx0sHjb860/E9N2rVoXDv9ZamWQFstsC4DbBGq9WpqUviu6t
X-Google-Smtp-Source: AGHT+IHBS8kRiofFIAnp2NheRRLUlynDbNs7sfwICW3mhCfWGD2kg7si6Z5hPhudSKJDOq7nZ91lKDfllxaXCPPZwZc=
X-Received: by 2002:a0c:e609:0:b0:67a:d238:8e31 with SMTP id
 z9-20020a0ce609000000b0067ad2388e31mr795444qvm.105.1701706286113; Mon, 04 Dec
 2023 08:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20231114095217.1142360-1-jens.wiklander@linaro.org>
In-Reply-To: <20231114095217.1142360-1-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 4 Dec 2023 17:11:14 +0100
Message-ID: <CAHUa44Hw5=91VpE9T_vtv=2+Pmy5=zH4yMnSiAAWFedxEihXPg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] OP-TEE kernel private shared memory optimizations
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Shyam Saini <shyamsaini@linux.microsoft.com>
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

On Tue, Nov 14, 2023 at 10:52=E2=80=AFAM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> This patch set optimizes OP-TEE driver private shared memory allocated as
> dynamic shared memory (not from the static shared memory pool). The first
> patch handles kernel private RPC allocatations larger than one page and t=
he
> second changes from alloc_pages_exact() instead of alloc_pages() for more
> efficient memory usage.
>
> v1->v2:
> * Split into two patches as requested
>
> v2->v3:
> * Simplified optee_pool_op_alloc_helper() by always doing the same thing
>
> Thanks,
> Jens
>
> Jens Wiklander (2):
>   optee: add page list to kernel private shared memory
>   optee: allocate shared memory with alloc_pages_exact()
>
>  drivers/tee/optee/core.c    | 44 +++++++++++++++++++-----------------
>  drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
>  2 files changed, 44 insertions(+), 45 deletions(-)
>
>
> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> --
> 2.34.1
>

I'm picking up this.

Thanks,
Jens
