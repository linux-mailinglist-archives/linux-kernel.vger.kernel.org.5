Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A37CC95E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjJQRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbjJQRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:01:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE19AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:01:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-577fff1cae6so4223309a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697562098; x=1698166898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVk6JqAcC96nmoEP5CbFtt2U7U2MiyM1ZZJce8WrKz4=;
        b=G5ULKFtg0ez6pC9GOWvrrq2GlC7ePiLyqC4ez3/nelOGioEcz+v23Vq385dwByUMez
         Gq5zm1/f3o9EFYbGTrYL7X56WvtfEoLKnlaOLb9ALXarT6qQAtt1uoIxjqpsfuIJ3LuD
         VlpsLyzwZWK0B7vjzmkSx23Xpf8z6XnRpA4J8iRGGauqTi+MMNibxEZLtJE3Waglo4do
         LuPMAVj1Io8jXMW/RTDvPiYG8lZtVqqarCekq/W3oKolyxhyljYLgek2v8lo3467uosU
         mwxeToUbtScM6YDiiutsp6AK1vQEuk7HGqO6mMiRqaMYYONbLsuWvaiDEMt95m37bvnx
         Dk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562098; x=1698166898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVk6JqAcC96nmoEP5CbFtt2U7U2MiyM1ZZJce8WrKz4=;
        b=sxcgJyI0cpF4fVuW5XWFPnx+6d1WNxaX05jXBHMci/VM6eCvgACrWoqURDrvzSBv9i
         MQ33DT1SZNN/oB8XUYyuiRGEezqw+Xwa9W8tfybjueKxFAteKFPu5l4q68kJ6FygBDP+
         /cF7miPK9xpSwNeifHV3AEoIRT9KpbARi5Hh5jUE5DQr6FYCgCBgJFSzT3R7EMwPsNH5
         IEHUbW7nIDQgIr8KI3YUed7U1OacEsmliqBt1OzMp8S5QrwHksfetLpu7Y3297LwtrB1
         K93KMEu1qeEMK0KA2DJsOPy0RTalankZ6JMT5+qIerKuy3479QW1qtehyb4AoxXo6mn1
         Kyow==
X-Gm-Message-State: AOJu0YyChcTcLwvTF28wwTEWEf9QwJOuQLIADwMoG/vI4M/kPvN4aEhA
        ND+XDi2ucDmTEndTYHQTmBhJBEEseaVq5+SIk0HbxQ==
X-Google-Smtp-Source: AGHT+IFDk7hkhX1JWt5UM3OF7m5iDhCPicJKdhd0WXX/tzKf/H3qlErdWc1Aw853TP5fbSf6Lfycu4M/E9Est0yqpk8=
X-Received: by 2002:a17:90a:6d43:b0:27d:d9a:be8b with SMTP id
 z61-20020a17090a6d4300b0027d0d9abe8bmr3758897pjj.6.1697562097547; Tue, 17 Oct
 2023 10:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231016083953.689300946@linuxfoundation.org> <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
 <2023101641-resource-scalding-3e1d@gregkh> <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
 <2023101655-throng-rickety-ff79@gregkh> <fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com>
 <2023101716-sporting-geology-2de2@gregkh> <2023101719-anteater-deviant-bdf9@gregkh>
 <8cd1f099-b16e-4db8-91d8-ae1ad974bf08@oracle.com> <2023101700-symphonic-stretch-b62b@gregkh>
In-Reply-To: <2023101700-symphonic-stretch-b62b@gregkh>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Tue, 17 Oct 2023 11:01:25 -0600
Message-ID: <CAEUSe78K_CJpr_=UhPC1h-A+q7Qizj9zY=zsf6_PBWzaKYLwxw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
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

Hello!

On Tue, 17 Oct 2023 at 10:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
[...]
> And yes, I do run newer compilers and libraries, but the rest of the
> kernel builds fine with them (I make sure of that), but given that no
> one seems to care about perf breaking for so long, I just apply patches
> when they come up and don't have conflicts and see if anyone notices any
> difference.
>
> Normally, no one does :)

Just for the record, we stopped building Perf on these older branches
as we agreed with Guenter, for the same reason that you said before:
it fails all the time with a variety of toolchains/architectures. For
now, we're only building/testing Perf on latest stable (6.5) and
latest stable LTS (6.1). We brought that up at the OATS call a couple
of months back.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
