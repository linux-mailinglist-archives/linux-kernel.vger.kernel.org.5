Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC5E7E2A15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjKFQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjKFQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:40:43 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7DD6E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:40:41 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso726272966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699288837; x=1699893637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHfisBbuFpYRYY9jvfglgsuHpwuxgJMa/knm4CemjiE=;
        b=M4SnlxdMDJM5PgLO2Jw+Y5DLduQ5RAIZhEg6nkeDfPWviWBurzLjnZbm8yKW5RamE/
         aVfy+Z4KghsabXxf53RfO7Tr5RUQbuMmr5wURHrQQqPdGtzzeQwRYckUg1tAQoXicQrz
         5ctUE8fUnT93zMhmAczvziEdx9HXNMAnbulNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699288837; x=1699893637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHfisBbuFpYRYY9jvfglgsuHpwuxgJMa/knm4CemjiE=;
        b=ixZPk+7R+g0aVxMnPH8hBFjJHWT/DeJLFe9nze/6Rpa3JCfATLyrf0InyLWNY2PjCu
         5TFQ3oEJG1wbg4MR24LpCQ6tgObtOGNqPmEg1Z3Wm41Lu0Pk1M4qrzFODljicczY37cm
         RuHu5Ta2w73sKiu5roHq5DSDrXs0xb7fZ9CwC2RcoixkX7IZjQlE/+C1TBzZQqeIk18R
         sLNotQHoZzVCuciGLe9AhbgTRVtx2vHbldhGNFoAYAB30eeXjhjRyTAntBGX+4UnIiPJ
         PHeT+NC6FL6jbHqdsLDtyKX9X1qlxCzBgIGDZHO8NiVyEgX6dmelJpVYTCze6GZ6DpBg
         HBfg==
X-Gm-Message-State: AOJu0YxbPnCz03L2efHm71GwAArtuk7mD9rgBHqZ0y4Q38C/9PRe6DIN
        sjD05n+70iksZ42zIXqdiL8+6P810B33e7URYhKGJQ==
X-Google-Smtp-Source: AGHT+IG2lFrHURrf0nMHSXzXZcOO3+29lPs2zEO4tIy06S2ijH360xhtu7BRSp4uNrwAWd5FRhy89Q==
X-Received: by 2002:a17:907:2ce2:b0:9be:21dc:8a9a with SMTP id hz2-20020a1709072ce200b009be21dc8a9amr13183694ejc.39.1699288837277;
        Mon, 06 Nov 2023 08:40:37 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id xa25-20020a170907b9d900b0098921e1b064sm15891ejc.181.2023.11.06.08.40.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 08:40:37 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so107015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 08:40:36 -0800 (PST)
X-Received: by 2002:a05:600c:a01a:b0:404:7462:1f87 with SMTP id
 jg26-20020a05600ca01a00b0040474621f87mr166311wmb.6.1699288836339; Mon, 06 Nov
 2023 08:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20231105063602.10737-1-xiazhengqiao@huaqin.corp-partner.google.com>
In-Reply-To: <20231105063602.10737-1-xiazhengqiao@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Nov 2023 08:40:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UKA1sRMppdzmdX-48Hu7OKL=nWURS79kxTAJpu3Dq5PQ@mail.gmail.com>
Message-ID: <CAD=FV=UKA1sRMppdzmdX-48Hu7OKL=nWURS79kxTAJpu3Dq5PQ@mail.gmail.com>
Subject: Re: [PATCH] HID:i2c-hid:goodix:Modify post_power_delay_ms to avoid
 touchscreen not working
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, mka@chromium.org,
        fshao@chromium.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 4, 2023 at 11:36=E2=80=AFPM xiazhengqiao
<xiazhengqiao@huaqin.corp-partner.google.com> wrote:
>
> For "goodix,gt7375p" touchscreen, When the device restarts,
> the reset pin of the touchscreen will be pulled down by 10ms,
> but this time will make the touchscreen have a probability of
> not working properly. Increase post_power_delay_ms to 20ms,
> so that the reset pin is pulled down 20ms, and toucsreen works fine.

s/toucsreen/touchscreen


> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hi=
d/i2c-hid-of-goodix.c
> index f1597ad67e7c..caabf7a62cde 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
> @@ -111,7 +111,7 @@ static int i2c_hid_of_goodix_probe(struct i2c_client =
*client)
>  }
>
>  static const struct goodix_i2c_hid_timing_data goodix_gt7375p_timing_dat=
a =3D {
> -       .post_power_delay_ms =3D 10,
> +       .post_power_delay_ms =3D 20,

Do you actually have a Goodix "GT7375P" touchscreen, or do you have
some other touchscreen that is using the Goodix GT7375P compatible
string? As far as I know the 10 ms here came from the Goodix GT7375P
datasheet and has been working fine with devices that have Goodix
GT7373P. Has this always been wrong for the Goodix GT7373P, or (as I
suspect) do you actually have a different touchscreen and for that
different touchscreen you need a longer delay?

-Doug
