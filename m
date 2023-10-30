Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3637DB90D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjJ3LgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjJ3LgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:36:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA4C2;
        Mon, 30 Oct 2023 04:36:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9be02fcf268so648081066b.3;
        Mon, 30 Oct 2023 04:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698665770; x=1699270570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csnOKH0S/yzTOhLnRQCy767OQRSbbASGrw4KMOOKM64=;
        b=Kpfd4QjtjjTOoRIyXoFjG5tqBAW4U3SaQU9OXXplH9UrEJH8LS53iOc4ZhBYeiVzA0
         0T9bb0p5eYKdXBsbwYKcsfiztOFE6t2kngSBb44H38+1Cpx8S8LBcERnJEFCvX7fNa7K
         koj7MqCQpKrTeqg4L3hJFIOQ4GjO3CjxKMXzOcLwal/R4ni3iIN56KdB7SH+SzegyPt0
         7ilLhXaN8+7dFVY/YiUACq1bTsQ+aiHWbCA5UuIKQhgcDHp4plUExEPqeNQ39MBMEaf2
         9YmGNBRncG4/368YQGJdEVs8zCFJnWqJRkYUFt95vI7dvSG0KpGvD2TlJFY+sDhC9kYM
         a04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698665770; x=1699270570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csnOKH0S/yzTOhLnRQCy767OQRSbbASGrw4KMOOKM64=;
        b=NwnvmyOPtPJPN7B/rKP051npsp02Occ8r2Q8h7ZMctEMIjw7Aa4oEtW/O5msNI9bfj
         cJ89MkZpqnK6jkLlQZ9WCUEDekvEpcqJIoY3jV84qY2lXXR76zTLjQyTmG8J6bTomH1W
         VsmQPjy/58V7n1CUcuxFM2QI1zPzy32SBbt+pZy6RWAi1YM/MRaOx/QZImnow+9VV1Ri
         7tn1JC5KbhCGA2KYXDmju5IwTgdxru47E/37UV5n0moqx9K1fUSpm8oIXMqXoHH4uG4g
         KL/UkONZQCSF5zuNkJaawogqbOJgAHIrHi9vAeaFquBi3+gjurzATokrW/7MFAzBOJ/K
         3ZSA==
X-Gm-Message-State: AOJu0YwvKAAaNqj8fjvKr56UAFI0qyr1DCmEyFU6nCPBeuGF4YGNBRmh
        bAxnT5Nv7imKLt8BcEasHVPN2rsu50nYdYXiH3Y=
X-Google-Smtp-Source: AGHT+IHL/kCqmaB88Pd1lPonhz6Vn742Gqxb3ymqWLk7yKiz6eLcTFUoPUHkQCusca9qSLjjOQRPJZIMXFrM3pWF4XY=
X-Received: by 2002:a17:907:608a:b0:9ae:74d1:4b45 with SMTP id
 ht10-20020a170907608a00b009ae74d14b45mr8197615ejc.65.1698665769789; Mon, 30
 Oct 2023 04:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <1698402948-10618-1-git-send-email-shengjiu.wang@nxp.com>
 <c1cfa3e0-6e5d-4e1d-b6e0-4d1045196a11@xs4all.nl> <CAA+D8AOCujL-eD2-chqHAW7UN7UmLrO6CWRd7d6wTCPP8=VyfA@mail.gmail.com>
In-Reply-To: <CAA+D8AOCujL-eD2-chqHAW7UN7UmLrO6CWRd7d6wTCPP8=VyfA@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 30 Oct 2023 13:35:56 +0200
Message-ID: <CAEnQRZAGOTm=5j_9CStnKuZVPBK_Oxr50L8XLaFd7Czr7SLnWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 00/13] Add audio support in v4l2 framework
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
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

On Mon, Oct 30, 2023 at 3:56=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail.=
com> wrote:
>
> On Fri, Oct 27, 2023 at 7:18=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl>=
 wrote:
> >
> > Hi Shengjiu,
> >
> > Is there a reason why this series is still marked RFC?
> >
> > Just wondering about that.
>
> In the very beginning I started this series with RFC, So
> I still use RFC now...

I think we are way past the RFC stage so if there will be another
version, it is better to remove the RFC tag.

RFC means that this patch series is not ready to be merged but is
merely in the incipient stages of development.

thanks,
Daniel.
