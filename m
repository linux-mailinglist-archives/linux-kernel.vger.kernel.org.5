Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0647E6C81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjKIOge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjKIOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:36:31 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05D230DE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:36:29 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-49dc95be8c3so395318e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 06:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699540589; x=1700145389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0W3+VXWhRt/YdsoX67KLjAW6NuBZU8bYSere/jdVKY=;
        b=i5ewt4FOGo6smWsOwAKV6NYxq6RCpkAnHiAG9NyNqKFrTDluWjV5qYJROHwxTB5aOE
         kr4hD/t/S9BeC4GOdXMxHpqhaI5jomGt1O5yzfG+t1M2ohQ2+XtkEn1CcvYNOAq6xSNT
         qwr5enp6nysDnP79Ne5QOffoTsX8PJbqOIpC2GoVV+vcKT3UldkSvumWxpeAimV6F8/y
         zjotjG2dhC1NQTsTj0lveHuNuIgmTe5oKh3O0RcfZQl9+5UdPeXyz5Cr4ZSnwvfj8zfK
         9ATLORKdNvyjk3GLak3mpcijX+00xQdYja78+tzXoUz6WJdsE+u0uDAWGp4CmpklsjsV
         UY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699540589; x=1700145389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0W3+VXWhRt/YdsoX67KLjAW6NuBZU8bYSere/jdVKY=;
        b=JCHaQlShXCTOHgyKcSDBOBMMDeZ7tqHZR6bBNoywCO0UoiKV7FpkwJAHpuE7zKGZZO
         hlLRfNE2YeSeFuW3DQnCY+3GpOphGoQoCFQeylc+SfWk+Cz+78c+VQklvOJwMo6+RfvX
         sZqvsBPezjrKBn5To7CAekLYtw4JKOqw/uOFJ0wr31o2BxCNbrHq6f4ZKQqHkTT67Ra4
         4TpF5pTKXU+tAx2Muh8oDDDxp6W8Nha4OISY8mi6HCmFsXy7svnp1kglEfWuCXNWa0qq
         ORByvkmdOlpulQefMMo9YCmSTKj+vgscggO1pMt59LFZT/A4MdZQL1rz4dBkkm+A/xcB
         6Y3g==
X-Gm-Message-State: AOJu0YzhpggmqfisMGHlbIRK2QuUAVFUPVuOtdgpTG+ENGlVVawo+vlF
        gpaK81/fgzgRjX2oH4J6H4mcQYw0qnmoRw+Q83Qx8A==
X-Google-Smtp-Source: AGHT+IHqR78r51+mkNsmu8vbLuPJOJ0ONXbMIC7PFt2VVqNIxbPsZ2d33+TtCWZ8rk4CcNkGNDd8TH4bwZO0fWWeMDo=
X-Received: by 2002:a05:6122:1799:b0:4ac:7529:e903 with SMTP id
 o25-20020a056122179900b004ac7529e903mr1581266vkf.13.1699540588528; Thu, 09
 Nov 2023 06:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20231030153210.139512-1-glider@google.com> <20231030153210.139512-2-glider@google.com>
 <093114e8-b02f-4df0-a0d4-8e9f86e2259d@intel.com> <CAG_fn=W3LqtdDoUDDVGn_=2+gvKNeCusH6yUzWmVmMmOLZp9jA@mail.gmail.com>
 <27f5d15b-28da-469b-9625-1c840f33b60d@intel.com>
In-Reply-To: <27f5d15b-28da-469b-9625-1c840f33b60d@intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 9 Nov 2023 15:35:52 +0100
Message-ID: <CAG_fn=XwzkiMwEAA2P5T+JGpuF7tyC=uJi_urHc17-Y3d5rXxw@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] lib/test_bitmap: add tests for bitmap_{read,write}()
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 3:32=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Alexander Potapenko <glider@google.com>
> Date: Thu, 9 Nov 2023 15:28:56 +0100
>
> >>
> >> Could we maybe rather extend __check_eq_uint to take ulongs? Doesn't
> >> seem like they differ a lot.
> >
> > We could redefine expect_eq_uint as:
> >
> > #define expect_eq_uint(x, y)           expect_eq_ulong((unsigned
> > int)(x), (unsigned int)(y))
>
> Do we need explicit casts here tho?

We do.
test_bitmap_arr64() passes u64 values to expect_eq_uint(), which
results in test failures.
We could add an explicit cast there instead, but I think it's more
natural to let the users rely on expect_eq_uint() taking uints.
