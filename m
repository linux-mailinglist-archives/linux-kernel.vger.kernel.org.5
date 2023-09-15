Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E6B7A12EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 03:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjIOB27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 21:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIOB25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:28:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F5B2100
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:28:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98377c5d53eso204405866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694741329; x=1695346129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBGNOe9gI9NaJRPLZ/Vx8tqTgrMHNSFjAjNWZOJ75IE=;
        b=U1Pi6e7SQjnYLqhQ6iC1GT+CqA51C6lv7qHyeG7Tp4BJ4ZUi2KFmMS03JvLkzRFlZ1
         x58lqaicroEAmHW8LjKIKOI8YlN8oTtRynf6QnQRtwjUFnDnr3zMkTQUVVHFl4PY3B1V
         3K/RajSOYpCwq5l7lrIuDtdejlN1XgKTtMN70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694741329; x=1695346129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBGNOe9gI9NaJRPLZ/Vx8tqTgrMHNSFjAjNWZOJ75IE=;
        b=lRzCqsGFfgMHTWVuN4dcIpKTOQqzT9A2KEL1FA7SXyDPJLMLi/8f+r7CAKj5BmFcJX
         lzddjk7qwwvPNmV68QIu8zGS1bAtee0aCuDBKBNobiVvzsCGbLf4atkwhLHsL1q8qGRg
         vVkvl+o2pVQazqFptKlglL9oSB4yR+H9lgQD6RQ/UOxw8J2bRHgasLacilSMfkeqwAN8
         fLdKdNDF8iy9XGu1TofuOHSxwkqZADjbvUVU5sDcQefLFgRmGcUNmWAR1yNv7xkEjt0b
         nSGVnyN3pEOSgllKiElylkSukfQoKLCqHx2q+n/Wt2Yc+MM5uOYtwcJPlrp+iI2Daowh
         1g0w==
X-Gm-Message-State: AOJu0YzXp/u3I7b4ZM3zdiRG/pINfHfi5QNv9VbPAdMo3+wMo/9rtpdM
        0HV5U9KkHucfH09M5zTXjCJJpzMm+h2010LyyV8=
X-Google-Smtp-Source: AGHT+IGf21eqPPMkmngTVsi8qiU+nLHHOJQNWt4OLnnEeE0eexxjUDsPrLpLstE6F0EfXgGBlCl1aw==
X-Received: by 2002:a17:906:dc:b0:9a5:9f3c:9615 with SMTP id 28-20020a17090600dc00b009a59f3c9615mr89329eji.63.1694741328635;
        Thu, 14 Sep 2023 18:28:48 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906374600b009ad81554c1bsm1688214ejc.55.2023.09.14.18.28.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 18:28:46 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-98377c5d53eso204399966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:28:46 -0700 (PDT)
X-Received: by 2002:a17:906:3191:b0:9a5:d899:cc36 with SMTP id
 17-20020a170906319100b009a5d899cc36mr143392ejy.2.1694741326159; Thu, 14 Sep
 2023 18:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <PA4PR04MB9638B8753EFD81E174E55BC3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96381E2BC08BD1B636067413D1F7A@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB96381E2BC08BD1B636067413D1F7A@PA4PR04MB9638.eurprd04.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 14 Sep 2023 18:28:31 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP9rytcdS1Ao4RbfEULU2kwm4fRiu1MC1H59HABWGPdEg@mail.gmail.com>
Message-ID: <CA+ASDXP9rytcdS1Ao4RbfEULU2kwm4fRiu1MC1H59HABWGPdEg@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Patch History
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:42=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wro=
te:
>
> Hi Kalle,
>
>         Patch v4 (https://patchwork.kernel.org/project/linux-wireless/pat=
ch/PA4PR04MB963838F12BADC1B9FD377CB7D114A@PA4PR04MB9638.eurprd04.prod.outlo=
ok.com/) for host mlme had been submitted for a while.
>
>         Current state of this patch is "Deferred". I wonder when can this=
 patch be reviewed and merged.
>
>         Is there anything I can do to speed up the acceptance of this pat=
ch by upstream?

You still haven't sent this to the correct maintainers (i.e., me) for
one. I also thought there were outstanding unaddressed comments from
Francesco. And given how much Francesco looked, I'd appreciate getting
his Reviewed-by when he's actually happy with it.

(Like I said earlier, I'm not exactly happy that y'all are failing to
maintain this driver, but then insisting the community review and
accept new features. At least if your paying customers will help out
this process, the bargain is less-bad...)

Brian
