Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4420D77F323
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbjHQJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349528AbjHQJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:23:00 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536951FE2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:22:58 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-48ace7e7dfbso446320e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692264177; x=1692868977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7fy+9Nt/5u8K/03c2D/41QJ7yPuFSAX1HxdogFd/EU=;
        b=ua1x/BGegCmBVcohQkJABTUxSYd4ICO3vUoRkbl0lte5yWPEUGJkmA8i+E2jKiS0KH
         oJMmJkaq+JQL6H+qe31FFaVPFHjH+e6tfONTD7BnQB5HavM+p48DixIi0ibhJfFcTXLT
         IZ4UwNytLe+DMi6WhqiDlRCUX5JaQKPwXJaxjve+u2XBp8RXFOzOw8OosiIwb6BTyjYE
         BWQtwPsp3Rv5AZ3kU8JP7Fc5qAvW5wmEC75kgV5ejKvC/UtyGKtLxDw7h1BgYt3LdNva
         faj8qWL54HTnstxXlJx0T7bUaADAsAkjtrX7WGTU8oatEAZlElHeLXENTLhtbIyX76my
         N2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264177; x=1692868977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7fy+9Nt/5u8K/03c2D/41QJ7yPuFSAX1HxdogFd/EU=;
        b=W8205aIlV7MBdKlmkpL9I09DVpbqEAne3NSXCfPxTSCHDoLax88NFD/uMTd5NC+kJk
         5CSotuAKeBzFZkCfVDRQTb9ePqGWmsB4v8VXZO73O2rxlWoP/HbT9DxHsWXn4o//xjWS
         aqY9i3jV6TUlf1csU3UUdvHJIZnzYrv4mkU6AmNJtbaU5phpu2pgL4tkYi+3ecjcH6fe
         4TXboEGNttaCJmMSOO12+KDQ4qiL4uPJuzbTvqQEWTxyZko/O3DpmkfOjSUeVMNkx3/q
         e2RiJUwudXrf8w+oolfX3hfaRX/SIUDrXTVKjf/c5Us0TwAiCIq2RI2yf/wUWDDuCTBL
         OE8Q==
X-Gm-Message-State: AOJu0Yx7TiJCm6X6bjM+jMyLVtbV+65PvXSQf/eoqJwG8waqiTCoXonV
        TETX3SI7ix1LWfgB7xXQ+ayTauhk/BFsBKWQMIpW/C32Z+suq07T
X-Google-Smtp-Source: AGHT+IGtG3sctqFdWuGYjesM0umx6CVNWHgh9yq9NSrhTeT0jAroBy1OPLZkYVK7EIuFZqVeq3JvECzj+L/PsbD0jMc=
X-Received: by 2002:a1f:3f54:0:b0:488:1b30:e992 with SMTP id
 m81-20020a1f3f54000000b004881b30e992mr3416805vka.0.1692264177346; Thu, 17 Aug
 2023 02:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
 <CAC_iWjLU+mVtG4uGVoEJSJwuE0=GVcfJgi=h3QX54=fh2P4EAg@mail.gmail.com>
 <660cec45-d0d1-433f-b58e-a22a07a289fb@siemens.com> <CADQ0-X_dJag7EuEEEgCZrnJNNH9Va77mxmGYA9vPFw9DkoB-AA@mail.gmail.com>
 <CAC_iWjLzaSBz3_j=rz73QLCBX_YouCL+KBvR7sXMFFMQA3pOPg@mail.gmail.com> <1fd4b729-3896-48b6-865e-85b4f1ba5ee9@siemens.com>
In-Reply-To: <1fd4b729-3896-48b6-865e-85b4f1ba5ee9@siemens.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 17 Aug 2023 14:52:46 +0530
Message-ID: <CAFA6WYMekJC8dOUU-d7DJDK6fiUh27sWw8xbVMvFGmBe8VYxLA@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 16.08.23 13:58, Ilias Apalodimas wrote:
> > On Tue, 15 Aug 2023 at 05:41, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> >>
> >> Hi Jan,
> >>
> >> 2023=E5=B9=B48=E6=9C=8815=E6=97=A5(=E7=81=AB) 2:23 Jan Kiszka <jan.kis=
zka@siemens.com>:
> >>>
> >>> On 14.08.23 11:24, Ilias Apalodimas wrote:
> >>>> Hi Jan,
> >>>>
> >>>> On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@linaro=
.org> wrote:
> >>>>>
> >>>>> This series introduces the tee based EFI Runtime Variable Service.
> >>>>>
> >>>>> The eMMC device is typically owned by the non-secure world(linux in
> >>>>> this case). There is an existing solution utilizing eMMC RPMB parti=
tion
> >>>>> for EFI Variables, it is implemented by interacting with
> >>>>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC drive=
r
> >>>>> and tee-supplicant. The last piece is the tee-based variable access
> >>>>> driver to interact with OP-TEE and StandaloneMM.
> >>>>>
> >>>>> Changelog:
> >>>>> v7 -> v8
> >>>>> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
> >>>>> - fix typos
> >>>>> - refactor error handling, direct return if applicable
> >>>>> - use devm_add_action_or_reset() for closing of tee context/session
> >>>>> - remove obvious comment
> >>>>
> >>>> Any chance you can run this and see if it solves your issues?
> >>>>
> >>>
> >>> I also need [1], and I still need a cleanup script before terminating
> >>> the tee-supplicant, right?
> >>
> >>
> >> Yes, we need patch[1] and a cleanup script.
> >> Sorry, I should note in the cover letter.
> >>
> >>> And if need some service in the initrd
> >>> already, I still need to start the supplicant there and transfer its
> >>> ownership to systemd later on?
> >>
> >> Yes.
> >>
> >>> These patches here only make life easier
> >>> if the supplicant is started by systemd, after efivarfs has been
> >>> mounted, correct?
> >
> > Not systemd specifically.  Any tool that can signal
> > <dev>/driver/unbind would work.  Sumit is just reusing the default
> > unbind notification mechanism
> >
>
> I was referring to the boot ordering topic, not the shutdown issue.
>
> The latter has now a nicer way to trigger the device shutdown prior to
> killing tee-supplicant, but you still need to do that explicitly, no?
>

Yeah it has to be done explicitly in user-space. As you have already
seen, my first try (v1 patch) to do it in kernel space failed. The
reason being that when those devices are being removed, the
tee-supplicant has to be alive to handle RPC calls. The kernel only
gets notified once "/dev/teepriv0" fd is closed and by that time
tee-supplicant is already dead.

-Sumit

> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
