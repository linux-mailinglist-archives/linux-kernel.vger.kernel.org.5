Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603E777525C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjHIFrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHIFrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:47:46 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA011BF2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 22:47:46 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-79a00f74a92so1894208241.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 22:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691560065; x=1692164865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBLwxu6RYThOPPkkhftSaHaz4S+8BmxS9YaXuc86KFk=;
        b=stTWLXEu8wC6U7FPxhdve1jfeBZsyNvTpiOBh5eVf4eP+dWy29hRzi1XPR0hlS75Lx
         LMqZtQ1CAbb1AR/nvsmWujjIORMF2/EzNRdIS4RXttwv8QZvo0XcIT9n8gzIJe4v1ONs
         OdJ6CBIRmoEd9+XXN6V3Zfw9Wdn4sYTwONkpNW/lDftSJkXle1oa+YkEw3zsSBE4il5j
         Y39ECNj/5se9obsALwgDz4Baewve5gWAjvI+bA9LUd5OMwcP2HgrzyBhLDi+BiTG49pM
         eFS75Xk3B2B79x1hkahpa57yttr5qVDTwIohhJqvZRoc1ypZlmGlkcNMQSWMzglaSmWu
         TBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691560065; x=1692164865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBLwxu6RYThOPPkkhftSaHaz4S+8BmxS9YaXuc86KFk=;
        b=bFOKdCuUWItI0G+fG3XtPuGkNJD+chZKqDKaxAg/PAkPh4hNWGXREANWM7RBsko807
         pCxRs9ghUvr8mJ8gB35a+MJAzJfAw3nBOMeG2FUCEpUY6/t9psNX1TCPy/yVTg6QKinq
         NYUk/Or9oYcm7i1pjRhOuzCFpItHT7616axe3St+srRkIYCnJXDskAhmcTxNMybGEmJv
         K0Ai/Vb+O1ic1BYNOhydvqIQH+TkbQ97wXm3zSKyhV3V5cWe8xOSnadvHuf6mHenpCkY
         NWWYuXXfM9e8bYRJmkRfYD+DFHzceLqd+RAnqKCBqyVjrAKAvZiZ6aJ4m0FBEBbq74Vp
         dA3Q==
X-Gm-Message-State: AOJu0Yyt1dJgxus+R/qUwQXTNj7LtLDajKSvt0DmInZY/tWxB2puaEfp
        MLk6gI0MfVaPyPFQCOVfAOs1c5EQHtDseYUSNaI=
X-Google-Smtp-Source: AGHT+IFK/kLitKRAXtzX4cGkYGLlfe7kOFdY9ILd29NBdnbjrFS44Phs7iBA/1Sfl3aLRlv1t0uASXocPtU0QlgNutg=
X-Received: by 2002:a67:fe4c:0:b0:443:6c53:e26b with SMTP id
 m12-20020a67fe4c000000b004436c53e26bmr2002986vsr.10.1691560065096; Tue, 08
 Aug 2023 22:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230807122233.28563-1-yangyicong@huawei.com> <ZNL9s92HjLy+MZTw@localhost>
In-Reply-To: <ZNL9s92HjLy+MZTw@localhost>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 9 Aug 2023 13:47:31 +0800
Message-ID: <CAGsJ_4z5kYWOa2L+BHypM4S6W_UhUfUe3wo2rwiy0u7Hf1Q5pw@mail.gmail.com>
Subject: Re: [PATCH] perf/smmuv3: Add platform id table for module auto loading
To:     Liang Li <liliang6@email.cn>
Cc:     Yicong Yang <yangyicong@huawei.com>, will@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 1:01=E2=80=AFPM Liang Li <liliang6@email.cn> wrote:
>
> On 2023-08-07 20:22, Yicong Yang <yangyicong@huawei.com> wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> >
> > On ACPI based system the device is probed by the name directly. If the
> > driver is configured as module it can only be loaded manually. Add the
> > platform id table as well as the module alias then the driver will be
> > loaded automatically by the udev or others once the device added.
> >
>
> Please consider revise the long log to clearly express the purpose of the
> changes in this patch:
>
> - What's the exact issue the patch is addressing
> - Why the changes in this patch can fix the issue or make something worki=
ng
> - Consider impact of the changes introduced by this patch
>
> These info may help reviewers and maintainers .. and yourself on code mer=
ge.

years ago, i found a good doc regarding this,
https://wiki.archlinux.org/title/Modalias

guess it is because /lib/modules/$(uname -r)/modules.alias fails to contain=
 smmu
driver without the MODULE_DEVICE_TABLE, isn't it, yicong=EF=BC=9F

>
> Regards.
>

Thanks
Barry
