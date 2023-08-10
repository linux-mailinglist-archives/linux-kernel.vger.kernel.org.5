Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43048777158
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjHJH1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHJH1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:27:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508341702;
        Thu, 10 Aug 2023 00:27:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-99bded9d93dso15597866b.1;
        Thu, 10 Aug 2023 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691652452; x=1692257252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCKORxJsfo4OufW3aw4gMGl7fvrKhigQTJp6xrqqbtM=;
        b=ZGDvXmGB5zGmyNsBJKHgnDctj9w5YYf07kCPtoUJx6sOWfar6KzeD3A7HUZRGoH3aS
         94AKQjAy3BSpZ1XSq+w1TEv5zGcNVA91RBhjfkn3H8V68sMkul96jaoidYEG3E58wNoo
         SvighNbzEUguQZY9dZgSaKLjmOSVw8xARnEKloXjZdCESdkFEgTc4OvlQxSKdVC8c+bm
         0dcRQqId8Mi/PGfFcsoM2r01t+Hcqr5F1crm1hIVmIHJTjnYAcCV3iLEM/l5CLNleZfN
         WZn4Z/5kG89eMscAGvaVleqZgjiPvMs/+gTQZlZ2OVpewX5Vmh/zkvCTJ0fo0SqhLqwl
         +V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691652452; x=1692257252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCKORxJsfo4OufW3aw4gMGl7fvrKhigQTJp6xrqqbtM=;
        b=DdkyKTTutnJlTWQ8zzQpHx+IFA8l2tT5Ud6Q+g+V+E+WZIlmKfFsqA14YdNKRHqCjW
         ocEXUqByiuKGg/szZEcRMKMCoCXXdkvWrn+fhfF8MSxYGUYgHP1mh5n58/tKEFVmnyyT
         Vr28mrTRJI22PpgTVeij8B8VElbVG7h/J4RKv4UmT8mGJpsRvJ8aoGQpvNFej5ztg55p
         cMiUu1ETH3ZxdB+whW2DGcE3Gfx+E9hDLs2QhC0+ScmuLW55oFp9ADT7f9k3K5OvahEf
         RW9gbMESgERQIlVjv3T/1I54ZwKcBVYfRtEHSkp3jXYKz/TVd81/SjzhjBRducUGBb5x
         UE+A==
X-Gm-Message-State: AOJu0YzZdsLw59zpHl0odVx/Yq66Xykve5mmY/L74laKRdTkQ38Nxu6r
        OMqVQFgsBYTz5RWOlOVTj0ZZMntW7/CZwJx4U78=
X-Google-Smtp-Source: AGHT+IFh7B+i+e6RR3jWk9LIQtbjKdiFifNOLjH1dLSS5dWr0Y2egA+0guxH+ImUZNQd/5YCukFj2rmgM8ioqQWK3DM=
X-Received: by 2002:a17:906:51c3:b0:99c:5711:da5 with SMTP id
 v3-20020a17090651c300b0099c57110da5mr1028811ejk.5.1691652451671; Thu, 10 Aug
 2023 00:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230808033144.2276-1-Wenhua.Lin@unisoc.com> <ZNJCLyWCdihyeC7a@smile.fi.intel.com>
In-Reply-To: <ZNJCLyWCdihyeC7a@smile.fi.intel.com>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 15:27:19 +0800
Message-ID: <CAB9BWhctPWUuL8tLpQSHmn0UWQ2ej4jN87HO89bTEz5__o9rZg@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: sprd: Add clear interrupt
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 9:25=E2=80=AFPM Andy Shevchenko <andy@kernel.org> wr=
ote:
>
> On Tue, Aug 08, 2023 at 11:31:44AM +0800, Wenhua Lin wrote:
> > Clear interrupt after set the interrupt type.
>
> Why?
>
> Can't it be done in the ->init_hw() callback of GPIO IRQ chip?

Hi Andy:
The initialization state of EIC is high-level trigger. If the external
level is high and the interrupt condition is met,
EIC has a latch function. If the module registers the eic interrupt,
an interrupt will be generated immediately
 as soon as the eic interrupt is enabled. To solve this problem, our
processing method is to clear the interrupt
 once when setting the interrupt trigger type, in order to avoid that
this interrupt is the last interrupt.

Thanks
Wenhua.Lin

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
