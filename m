Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE747808C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359302AbjHRJg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359303AbjHRJgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:36:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD512B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:36:50 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d690c9fbda3so699374276.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692351410; x=1692956210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPpEVGqtIKmhcLG/eTEzAWQK843J9IUYE2hQEuAGPKo=;
        b=jB4EATJzRxoolZU4fx0W0t9xqYwuwIX0CvZS8y0vt4ZtFjMZ+vlbw1g1/elaPqWehF
         IDc26Jdns1NPEgY/J+TM6Wu6YB9TSJ6kKYkKF1oyNnkdhx+X7RVBlP/OlLLASGJW+2s1
         K5BM3MB3MUEDtFgZJrRQXfc+3uFCbLxfHpmDfjsrKn2JC+1S56/h1uX86hJKMJRpYWIb
         nHP/o+Tui7hlDRKR/D4kllXT7biPG91Itjtv+TXAD4AlmwMIYkZ3hEveWt03c+3DS0PH
         lLkrOX+nJiu6n6jXlE7IX8d4ZRZ8blFiaxsTHmoDh4c/asehBcnya396U9IYm7go5Sat
         7nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692351410; x=1692956210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPpEVGqtIKmhcLG/eTEzAWQK843J9IUYE2hQEuAGPKo=;
        b=c0NdIhYyBfrcPAS98JPjxQcUntj8T5ceol+O70HVeBkNxUABrZw4xL35HYwzI6qwTG
         YuHAQ7BKv9SYUGowfQbSw9a18MBhFsM1npeCh/vtGhPbPBO06RCSkBOWcH7MJmttFTbS
         mM2YAevSz1gsPYiOZGNyif/8jwzyrieNEsYQXo4nuY6830hu0EIEcwlkO30Fwr7CFD2t
         XsRlFMdtbc+2kDIC0lX7HcEpacBnyCOE4pFZzj0BZx3M8ryPsh38EyO4YkES3Z7sKeFg
         N/jtMaXYBcaFDGLCjd2E73XrmW06fpkxbZWHeszJIpsho9fLrrtLKEGrxFj8fUUrmPDB
         NRXg==
X-Gm-Message-State: AOJu0Yys39lzRO2rmFKQizsoFgRA4JyDpsk7GGOsVIeaaax04O9+uEWF
        qp966cfJVcYPcMmdMES5HOq/QmrcyU5hpylVA/VXwQ==
X-Google-Smtp-Source: AGHT+IGRK78hniY31Ki6QVVWUwoHDAJVlb6ExLmqX78KL6qCCZewH7G19LMWrACauQlVW4n4wxLc4Kmx2MonQGC8VDg=
X-Received: by 2002:a25:230f:0:b0:d12:25d:fd60 with SMTP id
 j15-20020a25230f000000b00d12025dfd60mr1987490ybj.9.1692351410142; Fri, 18 Aug
 2023 02:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230816082531.164695-1-sarah.walker@imgtec.com> <20230816082531.164695-3-sarah.walker@imgtec.com>
In-Reply-To: <20230816082531.164695-3-sarah.walker@imgtec.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Aug 2023 11:36:38 +0200
Message-ID: <CACRpkda-XnS-DQE-5WXnTFdycwVnJwffhhR=V27gp8vnxkHTrA@mail.gmail.com>
Subject: Re: [PATCH v5 02/17] dt-bindings: gpu: Add Imagination Technologies
 PowerVR GPU
To:     Sarah Walker <sarah.walker@imgtec.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, matthew.brost@intel.com,
        luben.tuikov@amd.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, mripard@kernel.org, afd@ti.com,
        boris.brezillon@collabora.com, dakr@redhat.com,
        donald.robson@imgtec.com, hns@goldelico.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sarah,

thanks for your patch!

Patches adding device tree bindings need to be CC:ed to
devicetree@vger.kernel.org
and the DT binding maintainers, I have added it for now.

On Wed, Aug 16, 2023 at 10:26=E2=80=AFAM Sarah Walker <sarah.walker@imgtec.=
com> wrote:

> Add the device tree binding documentation for the Series AXE GPU used in
> TI AM62 SoCs.
>
> Co-developed-by: Frank Binns <frank.binns@imgtec.com>
> Signed-off-by: Frank Binns <frank.binns@imgtec.com>
> Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
(...)
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,am62-gpu
> +      - const: img,powervr-seriesaxe

Should there not at least be a dash there?

img,powervr-series-axe?

It is spelled in two words in the commit message,
Series AXE not SeriesAXE?

Moreover, if this pertains to the AXE-1-16 and AXE-2-16 it is kind of a wil=
dcard
and we usually don't do that, I would use the exact version instead,
such as:
const: img,powervr-axe-1-16
any reason not to do this?

I asked about the relationship between these strings and the product
designations earlier I think :/

Yours,
Linus Walleij
