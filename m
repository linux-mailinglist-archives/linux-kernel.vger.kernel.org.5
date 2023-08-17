Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85D877FFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355275AbjHQVWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355269AbjHQVVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:21:50 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5ABE4C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:21:48 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-589addee1c1so2737187b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692307308; x=1692912108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bOsJhNQoYOmFJimTxaJ2mCEMh67hQeGjwrVTDjEnLSc=;
        b=TPpXhy+K1amcpaItC/ed4ueSEE/vXLBV37L0U6/4TdOwYOXUGHidIxyLeJ855ApD3H
         oDYlcUS74zFmYL6eH28+wHzC9YxLzFs+OpCV2DVcetcWTCbSVQNeYdQGSFK+FThsvMIY
         RO5IXOiS6OvvhxNXyUGeYhTrePsgYMhEgiVMCbzKOjw30Y//ytN3kPRHEuK1kZVmG/AF
         cDjGWNVEwq6K67K+cEVhDcyLj+94WUGZJEtvOokIPU9caXSIRCmyINJElm/IMjvnfEn6
         m4Ju2t6PeSZWlALjduMmSKltL0B3e3YkiXr1p2dLRtCQxbjqWrEkRLaTikMyTyWNS12I
         szMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692307308; x=1692912108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOsJhNQoYOmFJimTxaJ2mCEMh67hQeGjwrVTDjEnLSc=;
        b=TS86IaqJ2mCqDdPKpQypCacFC0nnm7wUvqVatW56/Nx2AwY43JrY6+WyN6Mou/at+Y
         YGdEWN671wfTRD9Y6fIqc25aVZS3vn82Uw6i01Ceck3gjOAgnBa0kUKTgFdWcsCDDUHM
         WcftLZK1/3gonGWA1mnpV5fYXvgYzKT9cZk5oh3VPw8ARoMjh7wOmrzxw6hnGvTE8Lzk
         +AJwoDqlIdwZi8thTyZRyYykVFIYfGJtkt1c4GnYnteDbKijoS8FOjS3Ukwnth4iWXTN
         cvtJqgWShi4/fGFpL5TBHLNPp3sM0t3zlx5RQqu8foQ8AEXjdzuDZcBUxPczXoGtuxuQ
         P1uA==
X-Gm-Message-State: AOJu0YxfPwhC0yC0aXtJF5cMJo5U91L4Igc04AIvMgJGlg/gA28Jscke
        4X0HrI59pAIIJoRyDT55T/U2EMPbZjnLfC8002kwzpSM
X-Google-Smtp-Source: AGHT+IGQXTWxmdciEZxIzZP/m4iBdXR2/9RjqgCWXFOWD1UKeTLBCsQK/MaM+1qERKqXAU3q08FpBTVkStU29ojPqmQ=
X-Received: by 2002:a81:8a81:0:b0:58d:b9f3:adde with SMTP id
 a123-20020a818a81000000b0058db9f3addemr463939ywg.51.1692307307925; Thu, 17
 Aug 2023 14:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAGgoGu7Vim82Hu1JKc+m6cPkcn7+WWDFwK5P_YE6grFQS9E21Q@mail.gmail.com>
 <ZNm2ihdTojuPJM2f@debian.me> <CAGgoGu5XuHhVbnrNKBzhZyZH993bBHiLgjTrtyofvePZ-dxLow@mail.gmail.com>
 <CAGgoGu5iTE1xeupwTUUAcJv59294dNQJEf9oUWQKF72hrpFxRw@mail.gmail.com> <ZNwWNopPItNwKCTV@titan>
In-Reply-To: <ZNwWNopPItNwKCTV@titan>
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Thu, 17 Aug 2023 22:21:35 +0100
Message-ID: <CAGgoGu4R2Y5Yj4zEQyekZK0Vkb+XpWg+mudmW3LNmfq3tCFDjw@mail.gmail.com>
Subject: Re: Question regarding Linux-6.3.5 and Sunxi A20 NAND/NFC support
To:     John Watts <contact@jookia.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux sunXi <linux-sunxi@lists.linux.dev>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        boris.brezillon@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 01:20, John Watts <contact@jookia.org> wrote:
>
> On Tue, Aug 15, 2023 at 11:01:02PM +0100, Fawad Lateef wrote:
> > Hi everyone,
> >
> > Can someone guide me? I am not sure what I am missing here.
> >
> > I am trying to debug the code but I assume that the SUNXI NAND driver
> > is supposed to be working and that something is missing from my
> > changes and additions to the dts/dtsi for A20 SOM.
> >
> > Thanks in advance
>
> Hi there Fawad,
>
> I've hit this problem before and it's usually been because the pins are being
> used by another peripheral already
>
> Could you post the kernel log? It might have some notes on this.
>
> John.

Hi John,

Thanks for your help. I found the reason for my issue. I defined the
pinctrl information under the "soc" next to "nfc" entry in
sunxi-a20.dtsi which was messing it up.

I moved them inside the "pio" dtsi block and NAND is detected now.
Though almost all blocks are reported as bad-blocks.  I am thinking
that it's happening as I don't have partition information defined in
DTS. Do you think that this is the reason for bad-blocks reporting?

Regards,

Fawad Lateef
