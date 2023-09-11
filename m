Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772A479BF33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjIKUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbjIKNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:41:17 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF37ECD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:41:12 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d78328bc2abso4168133276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694439672; x=1695044472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nSmSHdLay9tWo1ueOBouSeDs8BbyLWV7Pc0CpX32Vg=;
        b=fRx+MwvlaMHxRM8TIa8O3Dmjq+9Z7V3HFZu+twFoLTLJfkq4SBP2jauRjs2u+Jd9/3
         KfBH/zjn8/K3dlw2Ix4kcBiyVc8mJsVoPWWX05x8yhTX0McdvEyOcmyskY4xT3lOV3fM
         rmytmlssrHhbnSeGQyeRkiWWx+O1LKHe3O0U4IrnlqOH+8el/OCAPNoic9Uu0yB5x8xZ
         g0RY7kZHWRKig/E/glt9PUeIT1mI6x1PKQgiJRwz6zhXzRUPczRwjAo+3RRJ4oJ5N8mr
         5QGPr4D09UL2Azvc7I5zQWoxDIi/a1Ggu3/+SArSyu5gZ3b3G7yNJGJ4eC+0COID1hEe
         CSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439672; x=1695044472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nSmSHdLay9tWo1ueOBouSeDs8BbyLWV7Pc0CpX32Vg=;
        b=NP55lh8FCK3nLHEquWokb+TlGa+5uDrVQUW6MhVw/NmjgT+Bb+bkBU0rMiT28Bhn3c
         kwpaFzZv3QzTOsAgxytwuJC3jNFe+X6+5L1rr8/wYTMEg4yKUUZZaSZCXfz5pcK/OOGi
         g9g72TAxTLQ590n+gr7RagkB2EkeNjKXofXgn/qDUdLKgjDuwUMXIKWfRKJSkzKqVJkm
         QB8SCR/6f/8X0UWMG+F+TELklwp/UxPvGchR1E9VZ+D6OHPTrpH2Jtr3K4uv5o3LVvWz
         6dYu2KkhTFExJR3j5sf/4TIPmZMz922cUXAL5WGm4BXLAESlxOhZlgoKeYzCG7tpSijz
         IS3Q==
X-Gm-Message-State: AOJu0Yx7T1PPh3l2Z4W3VmQQq/q6XAi/OXgKGfjddYn08lvEHMPs4JuA
        yQpyYf5yorEb2adnkC/DYMm8Gp6GgcDNoxmUvGa5PamZzG4W89JL
X-Google-Smtp-Source: AGHT+IEWBodMRYoPw67CDfe1qi/gAWKjCx2VF+eFj06Y3kZgEZ3CDzO8HvC6ljEaTiF2RSH76zpapCoshLhrfKyRQsg=
X-Received: by 2002:a25:410f:0:b0:d80:8497:72c7 with SMTP id
 o15-20020a25410f000000b00d80849772c7mr3990786yba.15.1694439672060; Mon, 11
 Sep 2023 06:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
In-Reply-To: <20230908055146.18347-1-Linhua.xu@unisoc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 15:41:00 +0200
Message-ID: <CACRpkdbUOM7KD2h+mSZ4xj7UCCe_Gj_Dzcc7hSmOfOftve_kyg@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] pinctrl: sprd: Modification of UNIOC Platform
 pinctrl Driver
To:     Linhua Xu <Linhua.xu@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
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

On Fri, Sep 8, 2023 at 7:52=E2=80=AFAM Linhua Xu <Linhua.xu@unisoc.com> wro=
te:

> From: Linhua Xu <Linhua.Xu@unisoc.com>
>
> Recently, some bugs have been discovered during use, and patch2 and patch=
3
> are bug fixes. Also, this patchset add new features: patch1 is for
> compatibility with more platforms, patch4 add pinctrl support for UMS512,
> patch5 Increase the range of register values, patch6 add pinctrl support
> for UMS9621.
>
> change in V2

V2 is starting to look good, please address Andy's comments, especially
move the fixes first in the series so they can be queued as fixes
if need be.

I would really appreciate if Baolin can review the patches as well as
he knows this hardware very well and wrote the initial version.

Yours,
Linus Walleij
