Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EE97D7905
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjJYX72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYX70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:59:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1328C10E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:59:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so349875e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698278362; x=1698883162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOKIo8DF+sUuPmcncHrP3egXRJzB8ddS10YhGbuNSzU=;
        b=UB72BJq30rGKXf7E1VClFhiDBSQdC/A/I7YETf/8ML6csp5zKnN7t00iKD5vtOmoXU
         dcdHQXCL1O3qlHdvVcDcHpLvyV29VLutrqr1UTLVWAA9WXbMp8z95kgaEKYaj44WabNe
         fGgmvEuZ+I1iGodb+i2IJx7AG1Q/3yp6qZzFBvv+wVMP8Aixjl9RwX6JBbKOgbWhQDqe
         dS6CU9hWQa/k/psvIL8aKmFLLx7C4Cs/Jwk4Z18JPNNcgWpa952z61f9/nCxCJjrwArH
         DLrZW6c+EH84f3p9ajt+VXktdRLAE5+Bt0hrKWM7tUzO0nvLnfzLxwq/AQF0qyjFpzME
         a/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698278362; x=1698883162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOKIo8DF+sUuPmcncHrP3egXRJzB8ddS10YhGbuNSzU=;
        b=tycsxrh8NG4Fd2m9TV4PID8Mzfl6Upp1K9kz/R0rarjgVS1rkbFv4lussdT+oXmVRn
         jVlBnhx8nMP7hCfc5TwTGv4WEAbGyoHVjF0+3DDRrn8EeTUgue+HQ/5nt85X3Lh7lEgF
         VZe1xRBSxYDy902ntOmdgcoUE/s2Q8cYqESCezLeSrWuUZDRrCMo1YQDlC1MDKGt2qVS
         okIxluEZ7Uuc5c8PyvYDDytW7X6wj83qxBpdnGW4e+CQnMOa8Poz9g0CBjpJlVmPAapP
         goOg8PBBfSZFX8+wntV/VKO5YwMNSF8mUsLRn1eKIh00hBU6aV57QkwqPJXEAk39Ymcy
         /wvQ==
X-Gm-Message-State: AOJu0YyY+cQ3m5bItBSwMQIvf8mt6F9Y8XPOH+yd4yBUKV5T4BupqU2x
        14pE82QrdrqMgyIN1RU2HqspZacB7vURP3lo8TeZvg==
X-Google-Smtp-Source: AGHT+IGtsFDBZKN+N/ZF4VcJsolWlfdEFrnQ/DXEW85XQ02kN1A3YBCHAzvuiK4AYre/UMSRQEecJKagI7QT12Wqsd4=
X-Received: by 2002:a19:2d54:0:b0:507:ceba:a94d with SMTP id
 t20-20020a192d54000000b00507cebaa94dmr12847400lft.14.1698278362169; Wed, 25
 Oct 2023 16:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
 <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com> <10a072f549e187bc2fdc735c0161c09c90fc1392.camel@perches.com>
In-Reply-To: <10a072f549e187bc2fdc735c0161c09c90fc1392.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 25 Oct 2023 16:59:10 -0700
Message-ID: <CAFhGd8r5YFJrpy7xvhi2LZUrsPNTTpWKy2PYgDOjnrnTNBN3Bg@mail.gmail.com>
Subject: Re: [PATCH 2/3] treewide: Convert some ethtool_sprintf() to ethtool_puts()
To:     Joe Perches <joe@perches.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Louis Peens <louis.peens@corigine.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 4:51=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Wed, 2023-10-25 at 23:40 +0000, Justin Stitt wrote:
> > This patch converts some basic cases of ethtool_sprintf() to
> > ethtool_puts().
> >
> > The conversions are used in cases where ethtool_sprintf() was being use=
d
> > with just two arguments:
> > >       ethtool_sprintf(&data, buffer[i].name);
>
> OK.
>
> > or when it's used with format string: "%s"
> > >       ethtool_sprintf(&data, "%s", buffer[i].name);
> > > which both now become:
> > >       ethtool_puts(&data, buffer[i].name);
>
> Why do you want this conversion?
> Is it not possible for .name to contain a formatting field?

The case of using just two arguments to a ethtool_sprintf
call may cause -Wformat-security warnings. If it did indeed
have format specifiers then we would have more format
specifiers than arguments. Not ideal.

The second case of having a standalone "%s" isn't
necessarily bad or wrong. I used this exact approach to
replace some strncpy() usage in net drivers [1].

I'm working off guidance from Andrew Lunn [2] and Kees
who said it may be a good idea to tidy this up with a puts().

All in all, this patch doesn't do much but fix some warnings
and provide a more obvious interface. The number of
actual replacements are relatively low (around 20ish) so
I was hoping to sneak them in via this series.

>

[1]: https://lore.kernel.org/all/?q=3Ddfb%3Aethtool_sprintf+AND+f%3Ajustins=
titt
[2]: https://lore.kernel.org/all/a958d35e-98b6-4a95-b505-776482d1150c@lunn.=
ch/

Thanks
Justin
