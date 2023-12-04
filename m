Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6118802F83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbjLDKCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjLDKCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:02:45 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD00E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:02:51 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5d3d5b10197so32912107b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684171; x=1702288971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHeHXQ88hRKi6Kt+4mUFvWDi4ml4PVcTqzfdXUNFDa4=;
        b=O7FroEFuCRpOSjUkss301/U+nUzr7dxPmqEPV5Q4rdSOS0jwCbPnhLaLxIOILQtrJL
         A7P8B6bH/zdUQSCrR+3vgB8bJHFLs/aJg+0g38e5C0fvpaJ2jlBpZW3K/VxQj+Ly0ojq
         DMZ/PLtsf7usZe5TTwu16WqVNbSpY1hqGAzscEaRkodCNBMbO1e07Cx6xDFykrapOFIR
         JU52346uDUIhRss4lsvb12JoOwEdVB2UWzVkXoeuSxOuu8QELhuCDfupfOoKqlizVS7P
         LdcBaQQOuu+zqsDap/0hQ2TeWzxQ0ZgD5n2v+eyokRQO/Eb+3iXZHMuyvkH9pliswdBO
         lVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684171; x=1702288971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHeHXQ88hRKi6Kt+4mUFvWDi4ml4PVcTqzfdXUNFDa4=;
        b=AjyUKJnsDW91ExxTvoxqc/PUavHtOpDlLnCUyvB1HJPanNgzwVBDcsSwkhXlhroUds
         3pJw1TWdy7eh8zKDsZNl0Y/m+heeCj70LHDwOdWEt9FmNFV3rWGJkDvJZ8F9qBwFjasQ
         JjdwLx6i3vaT0Bh4PIXIYNxdJPvMT1Ic14jEMU0YLVMaauto4S9HEHyhMJlHFMRmRKNF
         HiTXIYKD46iyAbK14Oy96gYK83V1IcCZ1wtAYYT/ceJzHR2ADTz0HK/dqjUjjEqGBXxU
         TpyVRULA9N9/Ks256dJ0Kby0CLwDug4vYhRHlgGkpqjt3vr6cPnWypp80A5YTO9odUC8
         OIjA==
X-Gm-Message-State: AOJu0Yx57FI1pf2Zm/lnDlA+tS9NgyWORQDGmolaOpPE+QjpkZcqgLoN
        vuBgbuV+YhkFbieaeNFCFABixROG84y8/F4Bca8BOA==
X-Google-Smtp-Source: AGHT+IHtGl7d7t8F+Ugxjb3gUAHpsq3ksAoua4G3E3fpsarBicCY1G24CUHhw6UOMwZ59tqgp31KqEPz/mwrnkbsdEM=
X-Received: by 2002:a81:ae21:0:b0:5d4:2ab1:9f0a with SMTP id
 m33-20020a81ae21000000b005d42ab19f0amr2427769ywh.42.1701684170746; Mon, 04
 Dec 2023 02:02:50 -0800 (PST)
MIME-Version: 1.0
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com> <20231130-mbly-uart-v5-7-6566703a04b5@bootlin.com>
In-Reply-To: <20231130-mbly-uart-v5-7-6566703a04b5@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 11:02:39 +0100
Message-ID: <CACRpkdZDed3kJn0fC4ENR9U4WPvRnfWzANxxeV_Nd8eEP2JdkQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] tty: serial: amba-pl011: fix miscellaneous
 checkpatch warnings
To:     =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 3:07=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Fix the following messages from checkpatch:
>
>     $ ./scripts/checkpatch.pl --strict --file \
>         drivers/tty/serial/amba-pl011.c
>
>     ERROR: do not initialise statics to false
>     WARNING: Possible unnecessary 'out of memory' message
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>     WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
>              dev_info(dev, ... then pr_info(...  to
>     CHECK: Prefer using the BIT macro
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
