Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725FE792D10
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbjIESHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbjIESHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:07:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3E61981;
        Tue,  5 Sep 2023 10:51:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c65820134so2436101f8f.1;
        Tue, 05 Sep 2023 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693936253; x=1694541053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TI5XKlmo+CJsjgSI4p71LCm2s0UeJLQRpJFQV+gA8+A=;
        b=LaVPn3BdH5D+SRs1Q9W3qGQ3p9QeYjp539BHACkCt89VAMV73BZk5HEy2OAMjx8eu7
         R+VIxG46l/oeM3o81Utg4hDBK1L5Lh0nZv3/8owYtL40khm39HZRkuOBNwwfZP/HZXZ5
         /sV0kIGENmRcykSFWAg3881gZdWz5vOQeNLgazseR5MXl9uj/Ls9C9N7MPj/xCai/3eA
         AOBx7nxqqFiWOqw2sOeNQgEbaJOU2xLE039bCiVeYIQUi0YlbU0c6sPRF6wgT0ku+PHI
         I5moUIxXrOaGe+P0b5nvlIHdwxLweHXZpZXBYuGZf25dcrowQh4zH45/4uFLCuCWhdSB
         uebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693936253; x=1694541053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI5XKlmo+CJsjgSI4p71LCm2s0UeJLQRpJFQV+gA8+A=;
        b=jcFycGGW85bL8QX76ax1i6RWenfgPVnHDHUEDkVfx0ffJlxSOT0zZA5u1/97BONXcp
         UUQeFtMmZdkCNRJSFD3nL7CKSRI5rSkmnnX4LZvNMixYEQwDRALQIDAxpwORfCwsU9BR
         cbIDTAEw+PA1ig2uYZxYaqBU9YBLe/zTbTy4jf1aqschygOjL2vsTgSPc2O0bvIMwqel
         NNGlk8nfWWXjzWnZ2UvaBLpPtRoxvVm7tnSUxj/DSDlfzHlblZXaE8W9tE6ITCuxkiBx
         GioBo052glqpqnMX3C4rTTN4SlkEa2qnulUsx8VT7vaSgLUlH713RwYXw7sT02MNKOrn
         lk5g==
X-Gm-Message-State: AOJu0YxvaUGyOIqxCJ/EtSuqC8bQWWwje3xxji3VNWriHEpc4LWy6Omt
        uX4ajb1gq1uQL2UgtP6QSmEoI20QRcL/79Nu2EBIcX+nKUN8tA==
X-Google-Smtp-Source: AGHT+IG1w4iLh436pA73EaV+2xRNxHjpHWMG2DVf1y31ClKfzTSnb6cWKD3jqo09RmxUQh6Pj8ePlAmpOKwmfK004yU=
X-Received: by 2002:a2e:910d:0:b0:2bc:b0c3:9e8d with SMTP id
 m13-20020a2e910d000000b002bcb0c39e8dmr216569ljg.41.1693932290913; Tue, 05 Sep
 2023 09:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
 <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info> <ZPc8v9-lHF4jAcxL@kbusch-mbp>
 <2a379b3a-6ff3-444b-bbad-0fba0bc3a28b@leemhuis.info> <ZPdF3uqbJNSZADzv@kbusch-mbp>
 <CA+4wXKCi+idhPQHx3ywdEDHqRmOyBbhz4Gj4gGr_dDvWBWohQQ@mail.gmail.com> <ZPdYgK0ebgHtDTXd@kbusch-mbp>
In-Reply-To: <ZPdYgK0ebgHtDTXd@kbusch-mbp>
From:   =?UTF-8?Q?Cl=C3=A1udio_Sampaio?= <patola@gmail.com>
Date:   Tue, 5 Sep 2023 18:44:38 +0200
Message-ID: <CA+4wXKAe3==K1CoSvmRpbmPcR9QK+EuzDB-cNteNB34Cgur_0w@mail.gmail.com>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
To:     Keith Busch <kbusch@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten and Keith,

Thanks for the details. I'm still unsure if responding by email is
better or adding to the ticket, but here it goes: I have tried for
days both with complete power off of the machine and cycle-booting all
kernels in succession and without exception, 6.1.x LTS and the patched
6.5.1 kernel always recognize and operate the NVME, whilst the other
kernels also fail with the same error message. As this is my
"production" desktop, though, during the week it's more difficult to
me to perform tests with it, but I will try to do it in a more
methodic way and also with 6.5.1 vanilla.

As for the reason the Lexar doesn't catch the quirk default, I can't
say I catch the complex logic of the driver activation, but I found
out how to "fix" for my case because there are three other Lexar
models in the pci.c file: NM610, NM620 and NM760 (this one with an
additional quirk marked on it on the code,
NVME_QUIRK_IGNORE_DEV_SUBNQN) -- so I guess whatever justifies the
exception for them also justifies for my model, NM790. Might even be
the case that I would need NVME_QUIRK_IGNORE_DEV_SUBNQN (not sure what
it does) like in the NM760 case, but it activates correctly without
it.

--=20
Cl=C3=A1udio "Patola" Sampaio
MakerLinux Labs - Campinas, SP
Resume Gmail - YOUTUBE!
Facebook - Facebook da MakerLinux - Lattes
