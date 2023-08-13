Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555DA77AAD3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHMTMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjHMTMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:12:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA2D2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 12:12:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe934c4decso4700247e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691953974; x=1692558774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWAwLCIfCahvMHuC9MGhuZ1YxyXXpQRWsB/LQjc7rmM=;
        b=5TOFcFK7OBs9r+360d93HLi5NQ2gd2bCBrjdn7VrtwXcq9QlQL8VA82Tuv+f1fc+Nw
         njCyyt0vOfmqPG+9aPj3ZD6Pu/0T3nwvDk63k8YZWSDgamAfwhVRxOLnpBj6Ly8hYwbf
         pfAFEKjZmCHMonpPM60bnvkL8gEaBw6RFmeCoPGyXX/JlqK5crYsGHjCneXHt69kU4lU
         Sm+a+8nRQkEMn4b/H6+5koMIBdX5LjE6w8z7e+LsQj5G4/nxJPLZ8IDWXTBATmLLI6yM
         HUDQZfGBgDQZK4fSndd7WQAkU37JGjeVLZ9cKfKy8Mjls1C/9vg+EmyiT0L3ylbYQN8C
         p21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953974; x=1692558774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWAwLCIfCahvMHuC9MGhuZ1YxyXXpQRWsB/LQjc7rmM=;
        b=O0w7VWUEUgAGJDNVTrQvMBjyPSSzgFrVevDsZXZ0YXg7lw9bveRCT1JkOC5xnIlRik
         Q2/Rum2MgBdvY6D954IqI+3kLWNlsaeMO5g8zKo7pWDXcgAy38l591htZYnH+Ai/7hfF
         Rp3URN7/v60qtTPH7ykdzvKusLZYB4hnbprh8xM7i+E7ZJQRl2uOT9RdMGr6+nWLRP4X
         6404+AInG6XGLKOMiiQ5uJPpF9thFRQAp1+Ph180+JEN5QH4VGS0o4BkqD08zgEudjxq
         oVz/U5E09eRS5eSW/LUzIavgXQFHMqXZbJ+oZ5nOxL6hsExC5s3jK3hmQC+19qBlma2E
         1Nyg==
X-Gm-Message-State: AOJu0YzIeEOxw8ffLkuJW767Ig+3yfZaBCcAuky1EzQYmrAauEQZQgwS
        HCvxPTZHOVJRKCHpkldDm+0YNYyVTAt2PK7iLhKDow==
X-Google-Smtp-Source: AGHT+IEObO5DkVrfyAcAS7dtnYFOpV7QOvPWQC9Pz9LfSja4u5ttXygAkEAKqRnR6kPvEFwK3/YovyhAvZ/bCXFx/t8=
X-Received: by 2002:a05:6512:3193:b0:4fe:1ac9:fe5a with SMTP id
 i19-20020a056512319300b004fe1ac9fe5amr6919745lfe.39.1691953974530; Sun, 13
 Aug 2023 12:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230811191548.3340-1-aboutphysycs@gmail.com>
In-Reply-To: <20230811191548.3340-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Sun, 13 Aug 2023 22:12:43 +0300
Message-ID: <CAH3L5QrpWpxVL3LA_omJiHhs2KKB2e71qiEy_0n32wF7ZR9O7w@mail.gmail.com>
Subject: Re: [PATCH] thermal: max77620_thermal: removed unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:16=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail=
.com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>

I was (at first) tempted to say that this may be reduced to "return
devm_request_threaded_irq(...)", but after a while, I thought that
this is quite fine on it's own.
Just removing the 'platform_set_drvdata(...)' does add a bit of neat
symmetry to the code.

So

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>


> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/thermal/max77620_thermal.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max7762=
0_thermal.c
> index 61c7622d9945..919b6ee208d8 100644
> --- a/drivers/thermal/max77620_thermal.c
> +++ b/drivers/thermal/max77620_thermal.c
> @@ -139,8 +139,6 @@ static int max77620_thermal_probe(struct platform_dev=
ice *pdev)
>                 return ret;
>         }
>
> -       platform_set_drvdata(pdev, mtherm);
> -
>         return 0;
>  }
>
> --
> 2.34.1
>
