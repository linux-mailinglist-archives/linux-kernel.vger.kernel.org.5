Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65276B78A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjHAOdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjHAOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:33:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560A810C3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:33:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf3f59905so643661366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690900419; x=1691505219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+KC9X0SP7TlgnnEh6U7lIN9BNbXdA3jvj5APPvcXzI=;
        b=Q5HJhJeNyaFSjBG7MHhwbqiYjIAtoacD48lUpWvfvjjiRCKD9Bt1F3Agcx1PgyJDr1
         xzWwqbRn1bO3LrgrYeNfUx5vp2SEZCyTteYunKs4G64C/GrYubcaF3AR1YhDK17PNekP
         WyaJ6Og5hXTril/c1JH176dzB/RiLBtAJXiO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900419; x=1691505219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+KC9X0SP7TlgnnEh6U7lIN9BNbXdA3jvj5APPvcXzI=;
        b=ZU68nHFcmnBnMMWlTYiGI2qe9DeVatuigTuEZSjeFsRFRJ/5VNIXQeWjcGIW4bc4rb
         xlapLUkfb1dO1ApIKThWrYUoeE9bDzvHU/rJIDfYdiSL7tU9eMjCkKhu/d+AMQ/LiPGW
         evjLBo84Pb95Rb8KwsTxpURdAmVXzDCKtu6jrL+09J3Q3H7LXTs8Hpmkd5TI3c9akS0g
         upKRBHLhSpU3Wh7sqwwKYkZ6M8Io8m1vMxSV7PSlrbnSYt7VOIGOPDbNBXnxQ3kzjzle
         7YJymXc6/mfc35D2t1L4hf4rvEi3dLmKfsPrp6bm1lbDKvuS6Nmg9vEFgo940api5HKL
         rJDA==
X-Gm-Message-State: ABy/qLZBS5WWZuORqOg3/CKeR8RVai/5F5gVOyFU3FpM6dXhWBQNUalc
        ppC1lQf/keZay0cBY1m0JcsWhnqxxfek0/ks5QOh6A==
X-Google-Smtp-Source: APBJJlE/9Qf5TAVLjB8o6UjDOu1oUOxG0wsQr6oG6IXcieOQdKrxWxILyqM0UR1g4/nHIOUTMcIokg==
X-Received: by 2002:a17:906:18:b0:997:e79c:99dc with SMTP id 24-20020a170906001800b00997e79c99dcmr2538547eja.74.1690900419224;
        Tue, 01 Aug 2023 07:33:39 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906079300b0098e0a937a6asm7717062ejc.69.2023.08.01.07.33.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:33:39 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so11109a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 07:33:38 -0700 (PDT)
X-Received: by 2002:a50:c31c:0:b0:522:3ead:377 with SMTP id
 a28-20020a50c31c000000b005223ead0377mr141564edb.7.1690900418334; Tue, 01 Aug
 2023 07:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-aspire1-cmn-panel-v1-1-c3d88e389805@trvn.ru>
In-Reply-To: <20230801-aspire1-cmn-panel-v1-1-c3d88e389805@trvn.ru>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Aug 2023 07:33:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UwpjXVhP3k14ye93r_9jc3L9y--qYn7hf7HWB-4Hu12Q@mail.gmail.com>
Message-ID: <CAD=FV=UwpjXVhP3k14ye93r_9jc3L9y--qYn7hf7HWB-4Hu12Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add enable timings for N140HCA-EAC panel
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 1, 2023 at 12:24=E2=80=AFAM Nikita Travkin <nikita@trvn.ru> wro=
te:
>
> Add timings for InnoLux N140HCA-EAC. This panel is found on some laptops
> such as Acer Aspire 1.
>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> Timings taken per datasheet:
> http://www.58display.com/ggs/20180713155310173_N140HCA-EAC_Rev.C1_Ver3.0_=
20170121_201710238414.pdf
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

As per usual with simple additions to that table, there's no reason to
wait before landing, so pushed to drm-misc-next:

8229399486c4 drm/panel-edp: Add enable timings for N140HCA-EAC panel
