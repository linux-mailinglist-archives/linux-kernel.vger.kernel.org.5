Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFBE7EFBF4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjKQXAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQXAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:00:35 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2719189
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:00:31 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507cee17b00so3293062e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700262028; x=1700866828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMkvkcQ13fcCiTw6RuM4WY/Bg/hY3XQDUqCeInYeZG0=;
        b=gGc1quYSRFmsuS3sWhgqMRi2KGWb+RI8f+PbjarhSrw920uoXyevuAuANh+Cx25UoB
         Wc0NxeVKyJq8WeTzF6pKzogESHKjIWP8Mli1rxvuLZGmWEjNkDqRWlyAvInZeqhypBFL
         qGSonwDJkRXd5F2UZXASP0FvrZoRKhlSMEf54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700262028; x=1700866828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMkvkcQ13fcCiTw6RuM4WY/Bg/hY3XQDUqCeInYeZG0=;
        b=jqxGGQKNIxsdkYES4rGkXNaXd+gXy6i3ux5L7U9jSsHbqc9k/x60FnDNtsulg4NE0/
         7W+oSYbe5ydl3GTxfZl40Ocflig34oLc6RMVnWK69wINfeOP+6KLhCmeUPI+ak+pN5IE
         mAKvI2CghUloiHwSvVK7drkYX8tgwQaNEq9zmRU9bz9xW+JcRMQgmPqzawLxcd3KNH4c
         vXXHv61yiatqp2z5kttn9x2LKllaZdBIFGu2jx4OPtChnLzx8s2iBAyrtrHkSCF6HIMB
         PEN4vllKlqvJHjgiKJqnl3wAvPu39YuY00PxfhIvOzH/zWzfRT0Fes56xlXYg/QfQpS1
         0+WA==
X-Gm-Message-State: AOJu0Yys6W/bl7JtatmJueVaxmTThvBEVMugKEwQzr9dP/ZupgNwI5Ei
        wkO28s9cqWoctak4QeH4SY3TwHHQ+gu5UtLJLoUeYLVT
X-Google-Smtp-Source: AGHT+IFl++2JBmgrYl2DVQut6Ikv8THdK+2nmMtxGpIzHgKJvq/TY+JCBb6bDCHcJ0teXV9u2weQ4A==
X-Received: by 2002:a05:6512:4d1:b0:507:ce49:81ba with SMTP id w17-20020a05651204d100b00507ce4981bamr599380lfq.67.1700262028016;
        Fri, 17 Nov 2023 15:00:28 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id bo12-20020a170906d04c00b009d268e3b801sm1259126ejb.37.2023.11.17.15.00.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 15:00:27 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so4386a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:00:26 -0800 (PST)
X-Received: by 2002:a05:6402:ea1:b0:544:f741:62f4 with SMTP id
 h33-20020a0564020ea100b00544f74162f4mr65555eda.0.1700262026298; Fri, 17 Nov
 2023 15:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20230921192749.1542462-1-dianders@chromium.org>
 <20230921122641.RFT.v2.4.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid> <2f7fbd1b606b4d08b8c8c6eefff5898c8faa697c.camel@redhat.com>
In-Reply-To: <2f7fbd1b606b4d08b8c8c6eefff5898c8faa697c.camel@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Nov 2023 15:00:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XkeicQ3Gq4yaFtXsF7yM_7pXbpNKB56DbOwBmsEsrF_g@mail.gmail.com>
Message-ID: <CAD=FV=XkeicQ3Gq4yaFtXsF7yM_7pXbpNKB56DbOwBmsEsrF_g@mail.gmail.com>
Subject: Re: [RFT PATCH v2 04/12] drm/nouveau: Call drm_atomic_helper_shutdown()
 or equiv at shutdown time
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        bskeggs@redhat.com, daniel@ffwll.ch, kherbst@redhat.com,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
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

On Fri, Sep 22, 2023 at 2:06=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> actually very glad to see this because I think I've seen one bug in the w=
ild
> as a result of things not getting shut down :)
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Tested-by: Lyude Paul <lyude@redhat.com>

Any idea of where / how this patch should land. Would you expect me to
land it through drm-misc, or would you expect it to go through someone
else's tree?
