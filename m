Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0466777507
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjHJJ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjHJJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:57:06 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9942132;
        Thu, 10 Aug 2023 02:57:06 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bf08ca187cso584350fac.3;
        Thu, 10 Aug 2023 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691661426; x=1692266226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOdxuUErbexQ1SAxVC1t4edKrqJzDSjjOPaGhLnkFeg=;
        b=WAYjmgS2P48jqVOO1o7+Zu32gnCgQ45qbtxhhaBbvLYUXp7vGXCgCvZT8WQHfyRHVP
         90bM69MYnXCOR54XNra9P5VMP6gdHIHbFkNCC1pvsu9EybiQvjDYOfsj58B+Lbt0U7/S
         jkKbucENiEEjE0xV7bko5Gnnm0rZGVNybfjbsqJr2BpESbFYrOEutd17ungH3NietCXi
         K++ySvWlWBF6NALFsCnn8iGMDrwBp12sIl029brOiOgbaPq00YLa7IunVaahJ2jG7UhM
         0nwVS/DBE7lDO/sygbKGYpa3FLFgRPVZCGZe366yiMVfEk2L1wTiWotgsvwecK9wdm1b
         6rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661426; x=1692266226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOdxuUErbexQ1SAxVC1t4edKrqJzDSjjOPaGhLnkFeg=;
        b=IgMRxnrJQLBQgpcZcH/G0fCkk3kq5j5txVDoEn9sjINWZKroa8dYgr9+XDG3/M4Qbv
         Apdq+LRSD5RgW9my9QjUcJ/8UQ+uriIbgvy9Y6nJM4mki4DWedIKnYg2fkeP7eahFhRL
         N2Wpg+Q0md/dxupZuoK9QPL5CN1lqCQ+4QrSUc3uDn5eacZwOZ/fW420rZPshUaV8syU
         oF2Cv86erhcKOKiXVHlwLGh1ecn0Ua4HUlgaXiCpe0FdlxkKUBAQC+q1sbXa3cptjIof
         WThqBoBuK8nt5waimVloIKBH/Oov9gniYkgnCPceDXIRNyqM1VzYBZzLvi9loVv7yCxb
         VCdw==
X-Gm-Message-State: AOJu0YxBpR2qnNdc1jvoPJHSRY2d3AxIP1URbcjuxP9A2NXpj64f4+rS
        /l9yXEChwF5QheBK2m5Gt/y33l32aQuJGm5RqJ8=
X-Google-Smtp-Source: AGHT+IG9n9bXZTlrq4iBQUxl3qFhFC1s53IR3nsdT8Hyvvvia69O+ZlHw8qDLAKm1WoNsbxbJcklhtUsq5G1b58GjB0=
X-Received: by 2002:a05:6870:709d:b0:1bf:5559:4abe with SMTP id
 v29-20020a056870709d00b001bf55594abemr2194548oae.23.1691661425835; Thu, 10
 Aug 2023 02:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033144.2276-1-Wenhua.Lin@unisoc.com> <ZNJCLyWCdihyeC7a@smile.fi.intel.com>
 <CAB9BWhctPWUuL8tLpQSHmn0UWQ2ej4jN87HO89bTEz5__o9rZg@mail.gmail.com>
In-Reply-To: <CAB9BWhctPWUuL8tLpQSHmn0UWQ2ej4jN87HO89bTEz5__o9rZg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Aug 2023 12:56:29 +0300
Message-ID: <CAHp75VeVS4MfgpXeeiZygPOqYHR3-LagvWFD9ujOGVTp=J+Buw@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: sprd: Add clear interrupt
To:     wenhua lin <wenhua.lin1994@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 10:27=E2=80=AFAM wenhua lin <wenhua.lin1994@gmail.c=
om> wrote:
> On Tue, Aug 8, 2023 at 9:25=E2=80=AFPM Andy Shevchenko <andy@kernel.org> =
wrote:
> > On Tue, Aug 08, 2023 at 11:31:44AM +0800, Wenhua Lin wrote:
> > > Clear interrupt after set the interrupt type.
> >
> > Why?
> >
> > Can't it be done in the ->init_hw() callback of GPIO IRQ chip?
>
> Hi Andy:
> The initialization state of EIC is high-level trigger. If the external
> level is high and the interrupt condition is met,
> EIC has a latch function. If the module registers the eic interrupt,
> an interrupt will be generated immediately
>  as soon as the eic interrupt is enabled. To solve this problem, our
> processing method is to clear the interrupt
>  once when setting the interrupt trigger type, in order to avoid that
> this interrupt is the last interrupt.

Obvious question, isn't this needed to be added to ->init_hw() as well?

--=20
With Best Regards,
Andy Shevchenko
