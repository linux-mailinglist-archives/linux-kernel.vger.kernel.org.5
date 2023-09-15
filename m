Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA67A2402
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjIOQ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjIOQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:55:30 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909EE19BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:55:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so37426831fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694796923; x=1695401723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLxmdVTS/wciVdI7TLv83h6lFbbkbtSW/rwiXOLux+Q=;
        b=VuR8N2c6renj8KJytud6/FH9AEM40UsbVXaRSK+rxNoZWI9CWbJgkukAeWtVH0JxQt
         iEAKNGJ5Axwx2X3ZcOd4iKChu12QeRSRMoX1M69Q1llA7AHArMq/EaPfaaMgK7vlCsxR
         8z7q83OAM2SH1H4+iAfvEUuVcoqory20HPolc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694796923; x=1695401723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLxmdVTS/wciVdI7TLv83h6lFbbkbtSW/rwiXOLux+Q=;
        b=MQV2YdRMFK7pelRCafA9JT3XV4PLLyIn/1pgDGqtI50eca5tmqsJVY58CczbljHnZe
         ITCi97ozZddOgEWqInAhW7v1ydiWElmM4Hu/RRiglQJN81+uaO1vT99ca6E1mceA1sp4
         D7LbN/mVuAV/i8dA6svkYjx/wLhtpxNTuIvUDlFwbtQ/3MvntjOHzGH+pnNsHgTZbeDM
         6BXq2HjHJ82vDCybb1ERWONklBYw2WDflSQA4Jv+0LIzKjpfjLmDuD0LdNFyitL5gP8g
         0ZM5AlR2yByz1f+f+5VJj0zZiNSWXVij73MJ1oVVAfXst+yZM/5N76WUHlOwYykeNKIa
         6vuw==
X-Gm-Message-State: AOJu0Yxm92vC5OqTKXtF7IAHAeRTQFhi/3e0lnmGKlnISvLmRl+OTlrh
        +zW+ii7gNg2/keRV0R4K++LEsz93UbPe33gZqgY=
X-Google-Smtp-Source: AGHT+IF02dbUHy73K2uLNicOLkn7jQIv1JouEf5WpR5C7QA8PfLFMwbCw0+ipjHbbWxxW/LScKbreA==
X-Received: by 2002:a2e:950c:0:b0:2bf:ab17:d48b with SMTP id f12-20020a2e950c000000b002bfab17d48bmr2041993ljh.34.1694796922724;
        Fri, 15 Sep 2023 09:55:22 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r16-20020a2eb610000000b002b6ad323248sm792123ljn.10.2023.09.15.09.55.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 09:55:21 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-502defbb0c3so3970564e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:55:21 -0700 (PDT)
X-Received: by 2002:a05:6512:234d:b0:4f9:5519:78b8 with SMTP id
 p13-20020a056512234d00b004f9551978b8mr2526640lfu.63.1694796920796; Fri, 15
 Sep 2023 09:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <PA4PR04MB9638B8753EFD81E174E55BC3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96381E2BC08BD1B636067413D1F7A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXP9rytcdS1Ao4RbfEULU2kwm4fRiu1MC1H59HABWGPdEg@mail.gmail.com> <PA4PR04MB96385D1A60A99C17E6140C67D1F6A@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB96385D1A60A99C17E6140C67D1F6A@PA4PR04MB9638.eurprd04.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 15 Sep 2023 09:55:06 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO0aQz0Y+Z2=zMcgC2=xGBXB_BoKFYiT4mP9pcDS-YBxg@mail.gmail.com>
Message-ID: <CA+ASDXO0aQz0Y+Z2=zMcgC2=xGBXB_BoKFYiT4mP9pcDS-YBxg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 0/1] Patch History
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Francesco Dolcini <francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 7:19=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> Following is the mailing list I collected until now. If I still miss some=
one, please let me know.
>
> <<mwifiex mailing list>>
> linux-wireless@vger.kernel.org
> linux-kernel@vger.kernel.org;sharvari.harisangam@nxp.com;yu-hao.lin@nxp.c=
om;tsung-hsien.hsieh@nxp.com;kvalo@kernel.org;amitkarwar@gmail.com;ganapath=
i017@gmail.com;huxinming820@gmail.com;davem@davemloft.net;edumazet@google.c=
om;kuba@kernel.org;pabeni@redhat.com;francesco@dolcini.it;briannorris@chrom=
ium.org

AFAICT, you didn't actually fix anything. That's a months-old list
(plus manually adding me). Did you run scripts/get_maintainer.pl on a
recent wireless-next tree? Mine looks like this:

$ scripts/get_maintainer.pl -f drivers/net/wireless/marvell/mwifiex/main.c
Brian Norris <briannorris@chromium.org> (odd fixer:MARVELL MWIFIEX
WIRELESS DRIVER)
Kalle Valo <kvalo@kernel.org> (maintainer:NETWORKING DRIVERS (WIRELESS))
linux-wireless@vger.kernel.org (open list:MARVELL MWIFIEX WIRELESS DRIVER)
linux-kernel@vger.kernel.org (open list)
