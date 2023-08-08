Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D389773B74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjHHPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHHPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:49:05 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359C349D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:42:04 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40ddc558306so44151161cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509311; x=1692114111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ubqfsmYb7V02nf1U7/39ZUb74vPvlvUEXZk/eI/cgk=;
        b=se8C7+QuObYNgMHvYrvHsORdOr2GC2WMBnfGJ1Sd/clqfyghHeV87cVlXL1Lg1VOvi
         w+OgzklSG5Yo0wM7VCnRv5bNc4cMbBK0i5y8nwwlTllA7g3YQsBeHW6Q1RmpNcTKh6VY
         C6q1l4uWUERQ5AYLWOlWMUAkPN8+tyTKPdtdzbHqepCJYUEzgWLDeq/MD+loapF39TYK
         iyvJJFjqyIsF9kvH5FZgDgAPKnT3D8uIAJRl/0C5rDQKdhadGp7/X+PtO+dFxT5Q5/LP
         lx6aNjeZgAKAHVma9ty8ztbfGUwYBUcspvjKVnUAOG2RRWz8CNw3CKtLrE60Kz/J1Pgl
         NZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509311; x=1692114111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ubqfsmYb7V02nf1U7/39ZUb74vPvlvUEXZk/eI/cgk=;
        b=QzhBhm4dgRoHV02WZBvwv3W9qFjumYEhPPNG80y6iKqOM180JoZyxJuPPax2t29N1E
         rYpcj7PROsKdlkbMSJJ43Bd3JCNSaWqX+sY6jgjQ5Coh8bN9T8J5CBmxyJ42QCqGKKTC
         9L/urrITIrlQRKtG0+ANydk8moGZ0oJCpfOaioLQgxNlk0+SUiLD7tEDpx4jYJ+wvwod
         iDVyCveXePdpjhXF3spxRQrAny3C7awePXCkadsSEHKFDGcsK+BwpB4DbdwPWxhQF3Xl
         MHHA/gI8houDMEcgKYuA9gUN4zaRy52V+sW3Fznqa5pOKj3JWqj3Z+i2I1xzLNgThTPK
         eWzQ==
X-Gm-Message-State: AOJu0YxvDGFaBwD0ZgzFusMZGOW+pgOCL/sX2pUc1J/PhNxfVFD8ZvMH
        Gemb9poCprqaZwQygDB/Ndyb9EpdIw/2wyjxuIDkOiV1ZL79Vac/MdI=
X-Google-Smtp-Source: AGHT+IHSHduNAZhtuWl0717SI9PBFnzbesbPZPWpUKYUXoQcp0TJmbb1ePGniPOczgezUXb2rRF/CgEe7L4IP+lhQpc=
X-Received: by 2002:a25:b87:0:b0:d4a:4b59:367e with SMTP id
 129-20020a250b87000000b00d4a4b59367emr8892048ybl.38.1691490522681; Tue, 08
 Aug 2023 03:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230721101349.12387-1-victorshihgli@gmail.com> <20230721101349.12387-5-victorshihgli@gmail.com>
In-Reply-To: <20230721101349.12387-5-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:28:06 +0200
Message-ID: <CAPDyKFrmwct=b6angucfrKOXneZXe+_2KQ4f--OQEoKD=fc5hg@mail.gmail.com>
Subject: Re: [PATCH V9 04/23] mmc: core: Extend support for mmc regulators
 with a vqmmc2
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 12:14, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Updates in V4:
>  - Moved the voltage defines into this patch.
>
> Update in previous version:

Please drop the version information from the commit message.

> To allow an additional external regulator to be controlled by an mmc host
> driver, let's add support for a vqmmc2 regulator to the mmc core.
>
> For an SD UHS-II interface the vqmmc2 regulator may correspond to the so
> called vdd2 supply, as described by the SD spec. Initially, only 1.8V is
> needed, hence limit the new helper function, mmc_regulator_set_vqmmc2() to
> this too.
>
> Note that, to allow for flexibility mmc host drivers need to manage the
> enable/disable of the vqmmc2 regulator themselves, while the regulator is
> looked up through the common mmc_regulator_get_supply().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
