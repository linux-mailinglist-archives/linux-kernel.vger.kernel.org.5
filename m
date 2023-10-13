Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256B7C7DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJMGfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJMGfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:35:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17ABC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:35:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99357737980so285770866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697178932; x=1697783732; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mw7d2rWqkx84mECPA0MX5FELEn+q0S5ND1l7U6MlW1M=;
        b=fm4Dbls/0njpq32LVctJfLhPqWi0yJ2J3EF7WOVckfgZlax20krmmVv5gg2VZIZt8H
         NhlzC3+gxZ2F6XK/5uapNx04onfXTOVBbcfWS0WW+lINoVpDBp+TI3u7ug5XFIKcbB+a
         UKvJinKavIL30e8Os1gt2Bav1/RsUt6iMBb6p1zUx+w5bEYJmBu/LsSgW7HzEQBceEpp
         odky8UsJHB1frVNKCUg8W9NBNp55gWD6j/JsaZt8dHP/qzvK6CqzdyeiGZk0D3cBBYPq
         h5vwJWeCb/PR/u0o9aRa2ZQZ0Yqg68m774t9QkukPBLVRqBv8mRQ2v6HLJA2YRmUOfvW
         4nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697178932; x=1697783732;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mw7d2rWqkx84mECPA0MX5FELEn+q0S5ND1l7U6MlW1M=;
        b=C0jGNvQCDOrK5TNzQZHEwS65kT31uAT30boiDWcutz6nwuDOVdHxCzCq6124dV2JkS
         N9mjtkb9f9GpE3D69CUcc3an+r2mYrXzB4Yr3aluEUsyhhtxI6r4XmQb1nt1JNDO0lfX
         Y2gOdfnjdcrJ5nuclJaPo5kKhfRL6uLn/GvNe7D+vSVtJAqqagZ8S2CQGEgY5rRi0puJ
         gHae0VrhzzklFGsfhf8kfJQHrBDsbT1dJe8Eg2rXHLwno38Jvi37zqsfGzZHH24xap85
         5AefvinGdIs673l9cCQi9HD36HNhk6a8pK7SQ2QeaXWpY/6gKTdI+ccijb5ugH1Kq8EC
         Qm6w==
X-Gm-Message-State: AOJu0YzRNqwQwAhC5o5dsgDTStZoVJtOmXrNcJhRx2ZaBkLzZpWAaNiQ
        5YdPy/1nImzKMpbn+JmcnnGnNg==
X-Google-Smtp-Source: AGHT+IGbjKov6XXZ6PjO42kk5Nimru0P7r6dHP1nYYD+Mxr/9oWhoDfATrLUq4GyB5DEQmuF+pYfpw==
X-Received: by 2002:a17:906:20d8:b0:9b9:f990:c701 with SMTP id c24-20020a17090620d800b009b9f990c701mr17557436ejc.52.1697178932152;
        Thu, 12 Oct 2023 23:35:32 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709060b0d00b009ad87d1be17sm11920164ejg.22.2023.10.12.23.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 23:35:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 13 Oct 2023 08:35:31 +0200
Message-Id: <CW73PXH7OBDG.22PGA47PJR8T2@fairphone.com>
Subject: Re: [PATCH v5 0/7] Add support for LUT PPG
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Anjelique Melendez" <quic_amelende@quicinc.com>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
Cc:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <quic_gurus@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <kernel@quicinc.com>
X-Mailer: aerc 0.15.2
References: <20230929003901.15086-1-quic_amelende@quicinc.com>
 <CVX5ZUGU9BVE.2TA819U1AI6BZ@otso>
 <a2781978-2081-f4cb-dfe3-0489860dab8e@quicinc.com>
In-Reply-To: <a2781978-2081-f4cb-dfe3-0489860dab8e@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 12, 2023 at 11:50 PM CEST, Anjelique Melendez wrote:
>
>
> On 10/1/2023 7:15 AM, Luca Weiss wrote:
> > On Fri Sep 29, 2023 at 2:38 AM CEST, Anjelique Melendez wrote:
> >> In certain PMICs, LUT pattern and LPG configuration is stored in SDAM
> >> modules instead of LUT peripheral. This feature is called PPG.
> >>
> >> This change series adds support for PPG. Thanks!
> [..]
> >>
> >> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp=
3 (pmi632)
> >=20
> > Hi Anjelique,
> >=20
> > Actually I've retested this now on PMI632 (and also realized that my
> > previous tests weren't correct and wasn't actually using hw_pattern).
> >=20
> > Using the following commands (after boot) I'm expecting to get a
> > 500ms on 500ms off blinking pattern between white (255 255 255) and off
> > (0 0 0).
> >=20
> >   echo pattern > /sys/class/leds/rgb:status/trigger
> >   echo -1 > /sys/class/leds/rgb:status/repeat
> >=20
> >   echo "255 255 255" > /sys/class/leds/rgb:status/multi_intensity
> >   echo "255 500 255 0 0 500 0 0" > /sys/class/leds/rgb:status/hw_patter=
n
> >=20
> > What I actually see is it blinking between cyan (0 255 255) and red (25=
5
> > 0 0).
> > At some point after playing with many patterns I got it to actually
> > cycle between white and off, but I couldn't reproduce this again (or I
> > didn't try hard enough).
> >=20
> >=20
> > But with this example it correctly blinks red on-off.
> >=20
> >   echo "255 0 0" > /sys/class/leds/rgb:status/multi_intensity
> >   echo "255 500 255 0 0 500 0 0" > /sys/class/leds/rgb:status/hw_patter=
n
> >=20
> > With "0 255 0" and "0 0 255" the other colors also work fine, it's just
> > the combinations that seem somewhat broken.
> >=20
> > Regards
> > Luca
> >=20
> >=20
> Hi Luca,
>
> Thanks for testing again and the feedback!
> Looks like for multicolor devices there is a small concurrency issue with
> enabling pattern at the same time for all the led channels. This could be
> why you observed your device blinking between red (255 0 0) and cyan (0 2=
55 255),
> instead of seeing all channels (255 255 255) blink.
> The fix I'm planing to include in the next series is is to disable the mu=
lticolor led
> channels first, then configure all channels, and finally re-enable channe=
ls
> so that pattern is triggered at the same time for each all of the channel=
s.

Sounds reasonable I think!

>
> I am currently testing with pm8350c device so if you are able to test nex=
t series
> on pmi632 it would be very appreciated!

Will do, thanks for fixing it up!

Regards
Luca

>
> Thanks,
> Anjelique

