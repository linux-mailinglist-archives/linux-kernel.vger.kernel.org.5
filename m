Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E056A7AFBBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI0HNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0HNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:13:22 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3110E126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:13:21 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4527ba546d2so3934830137.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695798800; x=1696403600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghpkue7N6oiwgsmKag0rzCvKeWoEMHhP4MSi8oTAVck=;
        b=p2pGSvuXJe63WqsWpESNlKlGO+hbak4OmXhPyRV/bCBD0OiRIpVUOAGhaXyR9USvNq
         kElwNeMbi0EbPVjcC65L2Yc0KkbdgZCevuT6PevLswUXNgr3dJXX04QhnbtvWcppY8+k
         aHCa0Kv+dLvEkNWp5wg4IDvPAIb1oa4W+GKKoAb5/pnet7iTnHGlibhnqDKqCFEi2PjF
         V6YRbH2/x7AdjlsXqozd1+3GOq98Dg1vCUAovUQqa4aAgwTLHMu06BB3T0c7yO70Q/H7
         VwcHzXrVr8M854FRbucBBE6+IrKipLb7fgT8sUQqWvnM4NWmfwKGvoK7QcvYLbjUmBhr
         7/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695798800; x=1696403600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghpkue7N6oiwgsmKag0rzCvKeWoEMHhP4MSi8oTAVck=;
        b=TEmCO3PGusHnO3Cz+rHJqEIVrvONwwWL6OKb8sUHrkmfWMkoLk9wf4rEGx0ox6oVWU
         AKLJomLXvTFF+8eh75jbqmskuHYzLeuIXAiL9fECFpr/oEv1K2oA8rlTktxYnyi9AXN0
         uBu8mOAExS2BJ0DXuCNJ0SjTM6M96vbQEF148j96V48iPOOoy+Rs4wTz3rj3DcLgZlyy
         wheTSRvTFMzGQCQHqrQSaqtJCAbM0UwE0jwHcQOjCujRMxVLEJDHiwm/dSoQBOJx9Cba
         hqWVP8g5+gG/EDMgaMNrNGFSVPbgZ1D+PLdrhj7ueg/4Qc2mSFtioWx41F2MTn2aU7V7
         rJvg==
X-Gm-Message-State: AOJu0YyW1K8G+onauyNWl2A+FhgwjF1WqrjEZwUfA+3BFCpqzPH16bxH
        /eamrm2pYYeeMxZP6u4qs92m6aLKr2bDpVtcxCaZMQ==
X-Google-Smtp-Source: AGHT+IHAENgUH9UcARUTyK7pqCnC0yqp7lcr2HSBpJL/3Zx3Ubb/BJSBsI0uRd8EEbUyiSWiywWjH+q7vKFynTt06Bk=
X-Received: by 2002:a67:e218:0:b0:452:c3a4:1f9e with SMTP id
 g24-20020a67e218000000b00452c3a41f9emr981881vsa.19.1695798800231; Wed, 27 Sep
 2023 00:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230921122527.15261-1-Wenhua.Lin@unisoc.com> <20230921122527.15261-3-Wenhua.Lin@unisoc.com>
 <ZQxjxA2UwHpTPKKr@smile.fi.intel.com>
In-Reply-To: <ZQxjxA2UwHpTPKKr@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Sep 2023 09:13:09 +0200
Message-ID: <CAMRc=McZsmqQXEUSGaNOWLWZWGYaa--euDao6xzsXicYy-QXnQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] gpio: pmic-eic-sprd: Add can_sleep flag for PMIC
 EIC chip
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 5:40=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Thu, Sep 21, 2023 at 08:25:27PM +0800, Wenhua Lin wrote:
> > The drivers uses a mutex and I2C bus access in its PMIC EIC chip
> > get implementation. This means these functions can sleep and the PMIC E=
IC
> > chip should set the can_sleep property to true.
> >
> > This will ensure that a warning is printed when trying to get the
> > value from a context that potentially can't sleep.
>
> This deserves a Fixes tag.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Added when applying and queued for fixes.

Bart
