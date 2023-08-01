Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB0B76B6B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjHAOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjHAOEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:04:25 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C1918D;
        Tue,  1 Aug 2023 07:04:24 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bb590d5cc0so3431580fac.1;
        Tue, 01 Aug 2023 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690898664; x=1691503464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/cMiRNP/239pTEP0A4NFBdkkjAfZu8q3B9iWEIKTlQ=;
        b=lxToUUxnHRPuOkuQr0JQKZQe/PmZEcnA4gl6vxvc7mO2zORAhcU9lBNlHEwjD38YFT
         wCiv07cRtkavSgZjUYBC4hrenylRbhMMN7VUNlv/pWExQjB8o5zGjjveZiZcgR2gdWLN
         TY1Elnv4xRR7UX4+p/ovvY3aa0qD+E0hxQiMr3nBM04BAeO2hubpDTgRVd5GmWmIg3QV
         cihKaSo0WfWJjD77o6N0iTTu9XPDjGTayZQPlXFulpDGUQUeC3ZUlTUC0X64ERbjkRZJ
         f5VTmMIPVsihFv+Uv7fuhfmXGaISjnGIHrvQKeF4iDqGQTeBbcf+H/7MeSSF4va0yEdA
         GWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898664; x=1691503464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/cMiRNP/239pTEP0A4NFBdkkjAfZu8q3B9iWEIKTlQ=;
        b=h2gLWWiVLEJmcIO49asQ5rr5I0k6AGkH3jV8khAsNxIvu7Qcoek+E1GdElCawbEKGN
         scZZ7VOtgsyyazPag09iYjdG+6mnvDroTSwjvYc4/hC9uTC8HEsPme5LX+i/gpqpyOac
         4qTrU2u0qA7yYEgQ7XM8P4HVpesjzrx7quZVHLdLtqUgH5Mq4aBruZy1m0hKinx7vCrs
         qGjbSshCaJOF3sdJLSACuBlBCGhQ/USLCxsaSiwf6To1sNFUWCTEIERFrsJZGbWylUO/
         rRG/3AOLpIwy92F0+bH0LI/BH4chTabqY9EaUA2mpXXXHGWOBmQVEhkCOTPTHVLupKNt
         dBGQ==
X-Gm-Message-State: ABy/qLYqXa2S8hUFr0n5iv2nDT3cA+NZdFEXVbSNu+NbB17BrLJb7eLZ
        FQgwfA3lcu+j1fU4GnwUmc1RAGOo3+Ra66DgT6A=
X-Google-Smtp-Source: APBJJlFf4x1qflnIM0P3QwaiCtlvYxETvNOjvtcHUCPoxOo9lnZ4DZ8L6ff0xJKHKuTXLCaa1nUaaHYhFoG6xdoA/Bo=
X-Received: by 2002:a05:6870:c212:b0:1bb:ab07:dd82 with SMTP id
 z18-20020a056870c21200b001bbab07dd82mr11952579oae.46.1690898664026; Tue, 01
 Aug 2023 07:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230725035755.2621507-1-alistair.francis@wdc.com>
 <20230725163046.GA23990@wunner.de> <20230727093857.000017aa@Huawei.com>
 <CAKmqyKOj9JxKcGbEEiTv_nxQSh+7cM-4uz6Z5uGFYdZyjeQ_5Q@mail.gmail.com> <20230731175216.GA19517@wunner.de>
In-Reply-To: <20230731175216.GA19517@wunner.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 1 Aug 2023 10:03:57 -0400
Message-ID: <CAKmqyKN2YgtZY3=wr5odoDaLXNv2sD1E4dvqM1DfHC1hxQ4Mtw@mail.gmail.com>
Subject: Re: [PATCH] PCI/DOE: Expose the DOE protocols via sysfs
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 1:52=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Mon, Jul 31, 2023 at 11:30:29AM -0400, Alistair Francis wrote:
> > Yep, a big benefit is lspci or other userspace tools to be able to see
> > what DOE protocols are supported.
>
> Fair enough, but please make that motivation explicit in the commit
> message.

Fixed in v2

>
>
> > I also have plans to expose DOE mailboxes to userspace. That way we
> > can run the SPDM requester code (using libspdm) in userspace to
> > communicate with devices using SPDM. That will allow device
> > authentication for example.
>
> That duplicates our effort to bring up authentication in the kernel:
> https://github.com/l1k/linux/commits/doe

That's great!

>
> We had a lengthy debate on the pros and cons of doing SPDM in-kernel
> versus in user space.  We realized that when resuming a device from
> D3cold or recovering it after reset, the user space component performing
> SPDM authentication might reside on the device (disk, network) being
> resumed or reset, preventing its execution.
>
> When resuming from system sleep, devices need to be reauthenticated
> during the ->resume_noirq phase, i.e. with device interrupts disabled,
> as drivers are allowed access to devices already in that phase.
> So authentication (and encryption establishment) needs to happen this
> early, when user space isn't available yet.

Yeah, I had the same debate. Resume/suspend and reset are good points thoug=
h.

Do you plan on supporting all SPDM commands in the kernel and then
passing information to userspace as required?

Alistair

>
> See the commit message of "PCI/CMA: Reauthenticate devices on reset
> and resume" on the above-linked branch for details.
>
> Thanks,
>
> Lukas
