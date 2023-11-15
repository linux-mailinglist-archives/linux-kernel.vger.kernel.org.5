Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5915F7EBCF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjKOGNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOGNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:13:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2592F91;
        Tue, 14 Nov 2023 22:13:33 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2802b744e52so142673a91.0;
        Tue, 14 Nov 2023 22:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700028812; x=1700633612; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIPV+gDq2yOCjdPc3jrCxYdVWVXe1Hxr5GLMCAXMCvI=;
        b=Ghb6OW5rrJRR5YI6yPdqhgnS7RhX3Wam3OTmcSBKwmUEQk1ORhQOFD75O6IbTTkc/L
         /PPSbdJabgMbh0z0QUQjS928CcLbG7uJ+XNI16N9B4laHrRGEe6qqBb/zEjaV7OlyxiZ
         0mJeBJ5vz83KjypAywgChCBartIRK3Q2SnzaACPu1H1hXe/MlMZH9zynasK9jRBDmWrr
         ZyoiRyNXWpLjX9OqABYOtU8mUAeZpwNixgUVoIvz181lI/2gz33MbeEcvA9RMlXrct1h
         310AxWXDqqrITJFok/0gLi5Nf+ejcem95RgBzOJvIQ348S2+xkphBgFI5qJAPf8atwdv
         GSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700028812; x=1700633612;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIPV+gDq2yOCjdPc3jrCxYdVWVXe1Hxr5GLMCAXMCvI=;
        b=w+jgSILl2u0diQiSjXUwE4WTsGOr35Wbu9FpFej+DRkZD4U1bJJMApy7pVVhZ0j4Ej
         famAzfU0D75sS0l3Jc0RXVLUOYc8zeG87XYk9sJdorwfrsIkVAFlAxadO95dw+tRgYqO
         kEq6SiAV8jaPfthbaK99gohZCR95BB1J4NkGNgzRleqTTIWR1iPov+ICudPAHCgdGAqS
         jQPU0ye4cOHcV2/iKAf4NhjPmm/ev8PngdAfxNe2ag0rFcPIw+SrpcoyyDSZnj6f0aFY
         sPG5ZdfZsSLGp0ohOVI2vKISH7OdrjASRkQEIvVFY+v4YQBS+sYui1zSJorCwvJau/9e
         EXfA==
X-Gm-Message-State: AOJu0YzJ6ttQN+WZfChDFbwWFwxzRfsgZqeRxUexp6n/ZtgABLKL6KLd
        ByhRequUkJwYWof/tyW4xDo=
X-Google-Smtp-Source: AGHT+IHNRxh6ip9wuilteMswJq0OHDd/alKbzQRFE5QrXCJMqgoditaW9gS47pvvjb9JP1aiDp/2OQ==
X-Received: by 2002:a17:90b:38c7:b0:27d:433e:e69c with SMTP id nn7-20020a17090b38c700b0027d433ee69cmr6648625pjb.18.1700028812378;
        Tue, 14 Nov 2023 22:13:32 -0800 (PST)
Received: from smtpclient.apple ([2601:600:967f:6b00:1ce2:9961:5f20:7dc5])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a0d4200b002801ca4fad2sm8983020pju.10.2023.11.14.22.13.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2023 22:13:32 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: sr-iov related bonding regression (two regressions in one report)
From:   Anil Choudhary <anilchabba@gmail.com>
In-Reply-To: <0f97acf9-012d-4bb2-a766-0c2737e32b2c@leemhuis.info>
Date:   Tue, 14 Nov 2023 22:13:20 -0800
Cc:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        Andy Gospodarek <andy@greyhouse.net>,
        Ivan Vecera <ivecera@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFC5ADF4-1EE4-4900-B250-AC35656DC68B@gmail.com>
References: <986716ed-f898-4a02-a8f6-94f85b355a05@gmail.com>
 <32716.1700009673@famine>
 <0f97acf9-012d-4bb2-a766-0c2737e32b2c@leemhuis.info>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its not hardware issue when I do rmmod iavf ping started working .
So issue is certainly in this kernel and with sriov only
Iavf id Nic driver for VF(sriovnic)


Thanks,
Anil

> On Nov 14, 2023, at 9:50 PM, Linux regression tracking (Thorsten =
Leemhuis) <regressions@leemhuis.info> wrote:
>=20
> On 15.11.23 01:54, Jay Vosburgh wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>=20
>>> I come across LACP bonding regression on Bugzilla [1].
>=20
> Side note: Stephen forwards some (all?) network regressions to the =
right
> people:
> https://lore.kernel.org/all/20231113083746.5e02f8b0@hermes.local/
>=20
> Would be best to check for that, no need to forward things twice, that
> just results in a mess.
>=20
>>> The reporter
>>> (Cc'ed) has two regressions. The first is actual LACP bonding
>>> regression (but terse):
>>>=20
>>>> Till linkx kernel 6.5.7 it is working fine, but after upgrading to =
6.6.1 ping stop working with LACP bonding.
>>>> When we disable SR-IOV from bios , everything working fine
>=20
> Makes me wonder if things have been working with or without the OOT
> module on 6.5.7, as strictly speaking it's only considered a kernel
> regression if thing worked with a vanilla kernel (e.g. without OOT
> modules) beforehand and broke when switching to a newer vanilla =
kernel.
> If that's the case it would be okay to add to regzbot.
>=20
>>> And the second is out-of-tree module FTBFS:
>> [... skip OOT stuff ...]
>>=20
>>> Should I add the first regression to regzbot (since the second one
>>> is obviously out-of-tree problem), or should I asked detailed =
regression
>>> info to the reporter?
>>=20
>> 	My vote is to get additional information.  Given the nature of
>> the workaround ("When we disable SR-IOV from bios , everything =
working
>> fine"), it's plausible that the underlying cause is something
>> platform-specific.
>=20
> Maybe, but when it comes to the "no regressions" rule that likely =
makes
> no difference from Linus perspective.
>=20
> But I guess unless the intel folks or someone else has an idea what
> might be wrong here we likely need a bisection (with vanilla kernels =
of
> course) to get anywhere.
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' =
hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.

