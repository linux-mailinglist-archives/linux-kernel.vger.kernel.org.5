Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C362B7B5E3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbjJCAcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjJCAcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:32:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8076A93
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:32:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5048156976cso347633e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696293118; x=1696897918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO9eQroF7O4wqoRvgq0RaFH1dV9uh3sUuUFRmWyQ7SM=;
        b=dOsTw547TyPCkGpt+h6pm5S+wFjC+EEkvQkcCotftcxw2PMqo0W3AK2Inl9t14KCNd
         rUaImT71ml8EPS99raGDelyZ30DUQ7aJC2VWThoNvbLuDi51TeRNXf6VHLOXLs/n8V/v
         YhwdaLJiBAkJPJfvbwPc3d530JTmBCrv+wlkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293118; x=1696897918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO9eQroF7O4wqoRvgq0RaFH1dV9uh3sUuUFRmWyQ7SM=;
        b=ayQyUDYdEwXXlz0WXLhGqAdT4p92SJPMcp/m8umlFydgHUi2/No2zDm3cCp2oRhUuf
         yFwrNruzLu1gCIUE4hEJy8RECXsgr3rnTTlBLmo6FjZDbjaABcthwoeQ53ma7Ieh93D9
         YKUey7j//7I6dsGU56FpkGImXi9uCe8qf73FrqUqUcX/45ygFCO04Ee9GFXwnZl7T+Kx
         QXMaLINayZ/oovuFQpM9TvVLsnFsF8ZC4Q5RDnOyO8Kye9nq/ZbiKQ54hhcIg4JWMENK
         eyljBP33y/r+L8mMvR/4YRCJOlKlJhuLTlUKKeNz84Dnx9OsrEPfPPoZgsvXQ60QpOdo
         b55w==
X-Gm-Message-State: AOJu0Yz7Xohmf2XAY+RGQNBD6jt1S8NWsxhACxzKh4+t8s5mWBoE0epd
        phbxY4xWl5GQ5axazFSdEfb01pIzCfhK63EU7BJgsqyc
X-Google-Smtp-Source: AGHT+IE3+Z8uVErnLoCeHjn7TcA2bcNF/m2Fgoqep+pY2pLL8QB67B4YZFjDEf15DVZEOCNMhE6WQw==
X-Received: by 2002:ac2:5f68:0:b0:503:364d:b93b with SMTP id c8-20020ac25f68000000b00503364db93bmr9320173lfc.33.1696293118499;
        Mon, 02 Oct 2023 17:31:58 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d16-20020ac25450000000b004fe5608e412sm4939941lfn.170.2023.10.02.17.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 17:31:58 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50302e8fca8so2722e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:31:57 -0700 (PDT)
X-Received: by 2002:a05:6512:3903:b0:504:7b50:ec9a with SMTP id
 a3-20020a056512390300b005047b50ec9amr25948lfu.1.1696293117450; Mon, 02 Oct
 2023 17:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231002235407.769399-1-swboyd@chromium.org>
In-Reply-To: <20231002235407.769399-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Oct 2023 17:31:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U2dza-rxV=YtcfJwUY-gZw5FrCyn0NahOxvXJW2J2-vg@mail.gmail.com>
Message-ID: <CAD=FV=U2dza-rxV=YtcfJwUY-gZw5FrCyn0NahOxvXJW2J2-vg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Associate DSI device lifetime
 with auxiliary device
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime@cerno.tech>
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

Hi,

On Mon, Oct 2, 2023 at 4:54=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> w=
rote:
>
> The kernel produces a warning splat and the DSI device fails to register
> in this driver if the i2c driver probes, populates child auxiliary
> devices, and then somewhere in ti_sn_bridge_probe() a function call
> returns -EPROBE_DEFER. When the auxiliary driver probe defers, the dsi
> device created by devm_mipi_dsi_device_register_full() is left
> registered because the devm managed device used to manage the lifetime
> of the DSI device is the parent i2c device, not the auxiliary device
> that is being probed.
>
> Associate the DSI device created and managed by this driver to the
> lifetime of the auxiliary device, not the i2c device, so that the DSI
> device is removed when the auxiliary driver unbinds. Similarly change
> the device pointer used for dev_err_probe() so the deferred probe errors
> are associated with the auxiliary device instead of the parent i2c
> device so we can narrow down future problems faster.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Maxime Ripard <maxime@cerno.tech>
> Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI =
device at probe")

Even before that commit I think it was using the main "dev" instead of
the auxiliary device's "dev" for some "devm" stuff. I guess the
difference is that it wouldn't mess with probe deferral? Searching
back, I think the first instance of a case that was using "devm_" with
the wrong device was commit 4e5763f03e10 ("drm/bridge: ti-sn65dsi86:
Wrap panel with panel-bridge")? Would it make sense to use that as a
Fixes, you think?

In any case, this looks reasonable to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll give it a week and then apply to "-fixes" if everything is quiet.
