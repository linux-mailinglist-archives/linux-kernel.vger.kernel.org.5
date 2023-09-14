Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF1079FF69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjINJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjINJCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:02:55 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E11FD2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:02:35 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41761e9181eso112731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694682154; x=1695286954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1uEkZ8AewlH4VkHXLgnDcZZ4NDv2GyDPMI8S1n2Giw=;
        b=fX2VrpMJ2pWqqqPYU4cMFx2hUfdMuDS523jN4ZVeSknG5bMUhXcK6zzULqxSu9VEdl
         L6G7DU8moVw7oDt75UO98+4B5PY2mRgdmpm2Hu5C4qL17ZV7hZ3ZTb5TYfN7/9ifAGDn
         7jFEeFNKFVTfZWfeI2FWRi+0t3UQAAO8+p24RgStgjjO7ahA7jQc9vcg8vn5cIpLkXly
         +8YA+4j6XrrsFiYO7BBfgkKoaaErI7p7elEz2PwJbvwS/DMH4iR1S4GxPSqunFcyMDGr
         K0gwIVQSdeZxKaJZEWexeHigwDYo7lfjPHzdoPUXhDcmtNXrBydOXW8lctCqhmC7bSU5
         zv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682154; x=1695286954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1uEkZ8AewlH4VkHXLgnDcZZ4NDv2GyDPMI8S1n2Giw=;
        b=IvpUrmdw7fr+PzmpqJWK7VD40iysbe4nAoPpKB6GSm1DIpZMoVOFEQe3bvlqq3oZjZ
         2QaW6pw9rAlA7OUrge+dVeL5einLu+GJ2vruacHXFurF9L+EPlqgNtUx76YREbEQ3iwp
         R/v/0CE6WlWVezEWCTBixWJtJm+oCa2E05+sOTyzVR2Ju1QWr2ar0xZQt1UCNHdrFu44
         rEOaHO9u4jKUttnL+3oMDRudFALaDjykpcI0ZXPsmv3vX8I/xEkQJrTYRGf34zyZb2na
         VsOp245ELB9NgnS1yMpxjCwefRC18atH1+IRZhvg9SJlvc/F3YD485uU7S8OHEWaYbaM
         y/Xw==
X-Gm-Message-State: AOJu0Yzgs9yKgLrBDR/Lk5PLQe+cTfoPLamWRrF777I7Fhq9R2h55t+Z
        d7K78srT6gfxVpfsnIbo1QjRbwdmvd6LR8AbciJ0uw==
X-Google-Smtp-Source: AGHT+IGLYvslnZ50So6mjixflAeizPqblOjFot0SC0qSJrxPgXATQW71P15tPNcPhMGfUdBdiLJYjPvjl/0Re3DbDZ8=
X-Received: by 2002:ac8:5951:0:b0:410:385c:d1e0 with SMTP id
 17-20020ac85951000000b00410385cd1e0mr467589qtz.25.1694682154431; Thu, 14 Sep
 2023 02:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230627033326.5236-1-nicolinc@nvidia.com> <CAGfWUPziSWNMc_px4E-i+_V_Jxdb_WSwOLXHZ+PANz2Tv5pFPA@mail.gmail.com>
 <ZQJbunPj6Q8XRcpV@Asurada-Nvidia>
In-Reply-To: <ZQJbunPj6Q8XRcpV@Asurada-Nvidia>
From:   Michael Shavit <mshavit@google.com>
Date:   Thu, 14 Sep 2023 17:01:58 +0800
Message-ID: <CAKHBV25dfy2q73DmU7X6j_2XNTfgk8kbstanMczy8oZo_WFxrA@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass with
 a pasid support
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Aahil Awatramani <aahila@google.com>, robin.murphy@arm.com,
        will@kernel.org, jgg@nvidia.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, yangyicong@hisilicon.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 9:03=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> This has another version [1] rebased on top of Michael's refactor
> series [2]. We'd need Michael to respin the refactor sereis and I
> will resend mine.

Just to clarify, you'd like me to rebase off master and re-send? Or do
you mean something else by respin?
