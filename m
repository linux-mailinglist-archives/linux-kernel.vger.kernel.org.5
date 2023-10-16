Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580887CA09F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJPHcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPHcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:32:20 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0647AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:32:18 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d11fec9a5so24090666d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697441538; x=1698046338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKqGW1ZxrYglYW7fBJYmvRdjCTAJDcJrIqOEfv9H1uk=;
        b=Om+U9oU+hO3iHwKRJymKmpUVs6wFpOs8Wm0M3jP+5PrrgWtssWt2wC5igZk9KnDZTJ
         X5n+LoGGQSXYHvp1XiZdCTJn5YTZRcnRsPDoKsIJB5JUKr473efy1bVe96cQ6DQkfuhh
         X1zkNe4TQ8ydUp5hx3+UY+EO1LGhdPSOTmqaiT2qPQxnJLMsbZeKL95Gmvhc8Ni78zCK
         qqO9dOCf4aI0ZHnntDT5h2Fb/Yo0wI6o2mP6+5T9SzjU2csFPsCJ7IVPUWJg17wAFfus
         l/c1UasC/oquata9klvg/EGCZAWH2p5IFRocpOqb1kwGa4pPuHFxGk7Hr5hB6FM5P/ob
         NnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697441538; x=1698046338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKqGW1ZxrYglYW7fBJYmvRdjCTAJDcJrIqOEfv9H1uk=;
        b=FIhJlSFl3x1+nAspMtZtIejlsUtYZlGpDBp/+zW5YfVjVNlLs5Zm4Z3DKI2FdhrAf7
         a9qXZEo5S4FPTBDbp7l5lGVf07t0jGdCR4IMQuefdEu+MLkMxKWf5bR8GhgZyW9u6WWr
         8/UJHzolh0v1vhE4jtrH0851gPRUpvd352nPYc8GbZmXsyNAY2RvLfkHA+DAM+Skohlo
         hwlusI0Rj8TjSvDTmgA/tYtUIVqcgBlccxCVVMt0sfB7zIyCrzDtfcnJSH6d8ORiV+13
         3XZALzUTRqn3dSPQiKWgFw796yR/ZeWNOksYooA900bJJdYu+mz+ffk4KR2oDRHUZzzC
         9WxQ==
X-Gm-Message-State: AOJu0YxQlV81ZcuYjhl6ontzGW7IalCpttdf0jgKawFj+Zas0Tvdj6X4
        0eB9zXgDvCeloCnOs7vNaUBwd02zncrMLGsMsOMWrHMlCseA5f6o
X-Google-Smtp-Source: AGHT+IGDJGLk2sPYyF9/0p3UrPzmhWrwGi14izmtEbaQT4hL8piWfr7a/FqEXkrbLzvx+9V/HGXb34g2yeloHaBGTsc=
X-Received: by 2002:a05:6214:246e:b0:66d:4fdb:5e36 with SMTP id
 im14-20020a056214246e00b0066d4fdb5e36mr3439994qvb.36.1697441537773; Mon, 16
 Oct 2023 00:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230728134832.326467-1-sumit.garg@linaro.org>
 <CAFA6WYP7hgRWS_gp2AFEWDs27aOeUndB6+1dh95TtW2s1N+5Ag@mail.gmail.com>
 <a9515560-32bc-4f3b-a36c-87f7242081a9@siemens.com> <CAFA6WYOZPD+y0SOQTCih8qf5_FjX6DWtPTki13MM8J8V8LaHMQ@mail.gmail.com>
In-Reply-To: <CAFA6WYOZPD+y0SOQTCih8qf5_FjX6DWtPTki13MM8J8V8LaHMQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 16 Oct 2023 09:32:06 +0200
Message-ID: <CAHUa44Gyzv23c+L7dKQXh0oVgbJ_96guOZwTb7o87f2Gy9b9Dg@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: Fix supplicant based device enumeration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        op-tee@lists.trustedfirmware.org, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>
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

Hi Sumit,

On Thu, Oct 12, 2023 at 2:40=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 11 Oct 2023 at 20:15, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 29.08.23 13:03, Sumit Garg wrote:
> > > Hi Jan,
> > >
> > > On Fri, 28 Jul 2023 at 19:18, Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > >>
> > >> Currently supplicant dependent optee device enumeration only registe=
rs
> > >> devices whenever tee-supplicant is invoked for the first time. But i=
t
> > >> forgets to remove devices when tee-supplicant daemon stops running a=
nd
> > >> closes its context gracefully. This leads to following error for fTP=
M
> > >> driver during reboot/shutdown:
> > >>
> > >> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke=
 error: 0xffff3024
> > >>
> > >> Fix this by separating supplicant dependent devices so that the
> > >> user-space service can detach supplicant devices before closing the
> > >> supplicant. While at it use the global system workqueue for OP-TEE b=
us
> > >> scanning work rather than our own custom one.
> > >>
> > >> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> > >> Link: https://github.com/OP-TEE/optee_os/issues/6094
> > >
> > > I see you have marked this issue as resolved. It would be good to hav=
e
> > > your tested-by tag if it works for you.
> > >
> >
> > Sorry for this very late reply. We finally validated that this works
> > fine for us, though only over 6.1, our current test target. I hope we
> > can enable tip of tree soon as well. But I think I can still add my
> >
> > Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
> >
>
> Thanks.
>
> Jens,
>
> Can you queue up this fix?

Sure, please supply this as two patches. One for the work queue
changes and one for the device name change.

Thanks,
Jens

>
> -Sumit
>
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Linux Expert Center
> >
