Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15941780E69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377882AbjHRO57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377827AbjHRO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:57:39 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918DA30F3;
        Fri, 18 Aug 2023 07:57:38 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-583d702129cso9607427b3.3;
        Fri, 18 Aug 2023 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692370658; x=1692975458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3YL1cTS042mke7QX2gTenX5Fxm6ube31C+a3rIf0p8=;
        b=gr3cKPnyBvC6suRBhrybQKWDaFjvkdC80lgXVYk5CrW+lP57VuSucWxFsjgLZNhqjr
         6I6vYOw9kcBU5v7L7SJPMHTBwnO6jhSJq+QcqmcJ95/hPSmdFKVWJ0YElZTlwgF3WGDP
         vHDpBtL934WdgIy8dgOqua+bVSXbuC24CgEIfu6DZdz1S8OzdoUZJ1JrWnQdvnZXHwW0
         sQURlJSjHUndXS7djGA4gHceGODZRjdOsQt/Q5gie4bF896hmi23u+cZzqeTX4QpJGib
         sEBMjz9/YZWjEp73Wr3FTZ2YWDNkxXJ0A0jd5cYzXst2shg1iGqATk7Jdqv2KptdF/Jn
         2ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692370658; x=1692975458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3YL1cTS042mke7QX2gTenX5Fxm6ube31C+a3rIf0p8=;
        b=YExJU4ZScE68qR1fQ/ho6YejgxoUefGGkPecFGJhxCTk7JWc+GDPpUcZvINRgN3/cp
         xhqD3YG2/hUtEGHNS0qQxZLd7ce79RKMW7Ef1iKtSLsnwS6MkGa3XriQaOzMlSh9s9Jw
         XH0UJbNoNAlp78vKU5PWBrFsBbxiUROPznPl1OSHd8LV0cHlMPTP813TAjgcZMM51Hh3
         9EVsbWrgyE9D79673beZIO83m5kPqWLBDyUNOhF+zDmolPoCClYJrv+JxgldticLwJk5
         ulzfpTNA+C3TMAaRWDSD+De5fkZNR+MRTvtTQWwCToBgRDw2WQTskYUhMWLGhjT2Zlhu
         bhGA==
X-Gm-Message-State: AOJu0YwBGmMTWJ6TkCQf9fIu/8L7fLmTi+3/HYrrufojgWyB5l7Auyd9
        RikX4CPuEX8ZhYtD3lorgwvxoSn5QOsCtEuSspvnnrHsAQk=
X-Google-Smtp-Source: AGHT+IEVyOBTNDONrRYORdqyoqvB3RfI5AjMLCBcAe9FeymzuePHuGJelhqWDGW+wuXL90AsPWrv3F78f4TGPkwXNI0=
X-Received: by 2002:a81:8341:0:b0:56d:3b91:7e76 with SMTP id
 t62-20020a818341000000b0056d3b917e76mr2819352ywf.12.1692370657737; Fri, 18
 Aug 2023 07:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+jdBS3KPCDL2WZ8UBFRhu0hZyHqs0HAdnhamswswF6iug@mail.gmail.com>
 <CAEwN+MB6O03aaFo67CdDJoMCYQuexF0LCY5J1T47Bs4o_gcKrw@mail.gmail.com>
In-Reply-To: <CAEwN+MB6O03aaFo67CdDJoMCYQuexF0LCY5J1T47Bs4o_gcKrw@mail.gmail.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Fri, 18 Aug 2023 20:27:26 +0530
Message-ID: <CAHhAz+hTFdBNh=S1XfWA_pAUnPUO2czHPXgqvA4SiJBacxZo5A@mail.gmail.com>
Subject: Re: Seeking Guidance for New SPI Driver in Mainline Linux Kernel
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-spi@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous email, I mentioned that the FPGA hardware(SPI block)
was connected to the Linux system using the PCIe interface. Here, when
I refer to the Linux system, I mean an x86-based Linux system, not an
ARM-based embedded system.

On Fri, Aug 18, 2023 at 7:28=E2=80=AFPM Raul Piper <raulpblooper@gmail.com>=
 wrote:
>
> Have you gone through the bindings documentation for spi driver?
> What are the pin configuration for your hardware sli?
> Br
>
> On Fri, 18 Aug 2023 at 6:40 PM, Muni Sekhar <munisekharrms@gmail.com> wro=
te:
>>
>> Dear Linux Kernel Community,
>>
>> I hope this email finds you well.
>> I am writing to seek your guidance and assistance regarding the
>> development of a new SPI device driver for our hardware system.
>> Our hardware, implemented on an FPGA, features an SPI interface that
>> acts as a Master, offering two distinct modes for data transmission
>> and reception.
>> This hardware is connected to the Linux system via the PCIe bus.
>> This hardware offers two modes for communication: using registers for
>> debugging purposes and utilizing DMA channels for high-bandwidth
>> applications. Both modes leverage the PCIe interface for data
>> exchange.
>> The hardware boasts several noteworthy features, including support for
>> multiple speed settings, SPI port switching, configurable sample edge
>> programming, and adjustable SPI transfer sizes.
>>
>> As we embark on the task of developing a device driver for this SPI
>> interface, we intend to follow best practices and leverage existing
>> resources within the Mainline Linux kernel tree. To achieve this, we
>> plan to refer to and adapt existing SPI drivers.
>> We kindly request your recommendations on which existing SPI driver
>> within the Mainline Linux kernel tree would serve as the most suitable
>> reference for our endeavor. Your invaluable expertise would greatly
>> aid us in ensuring the success of this driver development process.
>> Thank you for your time and consideration. We eagerly anticipate your
>> guidance and insights.
>>
>> Warm regards,
>> Sekhar
>>
>> _______________________________________________
>> Kernelnewbies mailing list
>> Kernelnewbies@kernelnewbies.org
>> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies



--=20
Thanks,
Sekhar
