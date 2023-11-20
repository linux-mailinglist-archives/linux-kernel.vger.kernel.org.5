Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15D17F173B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjKTPZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjKTPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:25:50 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EB3A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:25:46 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso2578713a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700493946; x=1701098746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST028Kw+5opFnctTC026fdT6iYVhh3htW2mHBCbv3rM=;
        b=TNEPf+HKlYZ8A7VjdjLqlMf50cwFlug5NQnOQ72H+1lcrh/Mzc453QDWCbeYVia7bf
         LhfbKopGZeNT1AbTvXj25RGYoa+C56y+KbjGqnh0YrqyNVyoEu+C0xS4KEeq6YXMgXm7
         2nDS7y7U0AVRPU6idh06HdpJh/6qag5NBqYSQ/gz1GW6IyaW4o4/JeX+voc1vVV6JkZq
         RThnJ2I/LxA8FiVS5SNj8jehwLhuoS/eF/QSSBKExYrSHN9+7Vl4oQJr8O4uRIgS6UoZ
         mAU/Kr7xhcy2qGbr7JCJSEaAoOaNxj87Zk4TCxfoZj6bU3dBLEk4NkOYMmLyRO7yQ0B+
         RanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700493946; x=1701098746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST028Kw+5opFnctTC026fdT6iYVhh3htW2mHBCbv3rM=;
        b=dZ7Rx8k1UvtxU/Ss8koa8DtAjkvPXninvmG6sPvSCsAHVKzKeyl/R7lCY2VLIV+Kc2
         SPng7SvHajpvSrAoi/ybmpwVa1/5Lli0ceoM3AIhhc059i3cvRW6+Qpvord+R7qKHxXX
         IopuOF6dbFfn7Q1gahEbxcgnBxeQWewf8FMJYSUQZBv6zfWgnBvQefjSxbKm/J8d7XvB
         vmaWRVPuuemDbECzkX756lEtkHHYcfYeJ/LEC7dPgRcNtSQ2AzI56FkzVtSN1NekyFqC
         39whzxrBYsZvZac1fk7pCJelsiUxkhTOP8sI4EpYsM0FXzAm88VPV7pMTRm+fJYIK/gv
         tiqg==
X-Gm-Message-State: AOJu0YxAOKANhhz5EjjqI88QW7+uVetmvde22Edj0lL/X3KseLRstVXw
        d/6q+Syztbco277wyJ/2Z/pcNIStF3V1Mx8IqTqpJQ==
X-Google-Smtp-Source: AGHT+IGZ24BmTxFlV8ARS0eiBOVZL6XuY7FDIhzbJcGWCamZieGWAK8UG+n6P3hSBpS7YfkOpYF8HB8uorYNx0Elgz8=
X-Received: by 2002:a17:90b:4f81:b0:27d:d36:763b with SMTP id
 qe1-20020a17090b4f8100b0027d0d36763bmr5505892pjb.31.1700493946018; Mon, 20
 Nov 2023 07:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
 <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com> <CACRpkdYUzYxV+NY=mymXP59mt9msTUvSXM__f+4qRM+_xjX0Nw@mail.gmail.com>
In-Reply-To: <CACRpkdYUzYxV+NY=mymXP59mt9msTUvSXM__f+4qRM+_xjX0Nw@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 20 Nov 2023 09:25:34 -0600
Message-ID: <CAPLW+4mT5Qpo+B7fSfiG1qRVr4cSvuWhArpu-3kbFtSukSV8_w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sam Edwards <cfsworks@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Nov 14, 2023 at 2:20=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Tue, Nov 14, 2023 at 7:09=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> =
wrote:
>
> > I am not an ACPI subsystem maintainer, but my understanding is that the
> > files in include/acpi/ are copied verbatim from ACPICA, so any change t=
o
> > those files will have to be sent to the ACPICA project and wouldn't be
> > accepted here.
> >
> > More likely, we'd want to do something about the circular-include
> > situation between linux/fw_table.h<->linux/acpi.h.
>
> I agree but I have no idea how to fix that really, should I just send
> a revert instead so the authors can get some time to figure it out?
>

Just want to confirm that linux-mainline and linux-next builds are
broken for my ARM64 board as well, because of the commit you
pin-pointed. I vote for reverting it and letting the author rework it
properly. On a side note: I'm surprised there are no bots or automatic
CI builds out there testing the kernel builds with baremetal
toolchains. Can't believe everyone's using Linux toolchain, the kernel
is supposed to be baremetal project.

> Yours,
> Linus Walleij
