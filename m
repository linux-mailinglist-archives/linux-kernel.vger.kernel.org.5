Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A255F77FF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355101AbjHQU7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbjHQU7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:59:20 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D059D3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:59:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6873f64a290so55427b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692305958; x=1692910758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bw7QlxoxGVRnYreIiU6VXUliqehbFENeqT/KzAZ24Q=;
        b=ZOjMStG8k4y+1lUKtclfzBKQCWA6smeEu8j6VLTdEeUYEh3YQuKvfAX18ITqOSxW/p
         bF8mYiGpjsRfku5J4keO3HVt3lxNUYH6rWMPngE7b6eonhiHo8n9MUWbOSfsUWHQD2kp
         6Z6qlFEMzfJCy9pzWBHCA0aV+0A7kXLsQ3iofVbumc+t8iU73QdWz6nlMRj+6GZoExeb
         cn3Ip1maxazHjdCpdfz4zpoIRfxosC9aKNMuPal7Fl41iuKLj9cQggHPXtJawENRgJQE
         stzLh6oVO8bjPoT65Iw2mjBl+aqZxhWITf3cY8RORV0kHLof9Vok78be5UkedrU+vjjI
         lQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305958; x=1692910758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Bw7QlxoxGVRnYreIiU6VXUliqehbFENeqT/KzAZ24Q=;
        b=Yqv+l05girY1lUmGaooIunzgEflL7gUP7gpTgTwMoWDEJ/Acq+ZAtidC0XtwJJulj/
         5V/dO+cOrOaLrvjUGBVQBHGTSa2c18M4hmHVt5GXayX3TeX8pwvVI806vxFjvDxrkbTW
         nxpk1Rpk3csfKgHLVNNgFSeqehVYBTFIe3mUWyUslXb+1HI+M/37/xckbrGy3ECbP9TF
         aAl4H7PiWsccsgZFfU2aZOeJwPmlbeI0lBf9azoZ2f25OqoyH53hb+Eh6x1R6jRQsDzL
         e4OH35sXFbv3Kbs+Pwqaqg0Qk9NSSGZGpmYbcKZVemm9rSA9nxBgZu7BPGvtvHnh5Om8
         LHxA==
X-Gm-Message-State: AOJu0YxtpVEasWkqcrKdaSHtCKY6LN+bDrkXsY157k7v1pIbuCOcqFOl
        Q87F8IzWKVDy1pJCpZQIaMu+bgm0bwDJVRJs+hc=
X-Google-Smtp-Source: AGHT+IGAfktZdkEG0Wkw0BsEMMrCbym4+evYp65NA60yeZ+eypqzVnSeVeoxCjK0Wn3r72QXBzsGNcDuvUg37LtxTNA=
X-Received: by 2002:a05:6a21:999f:b0:145:3bd9:1377 with SMTP id
 ve31-20020a056a21999f00b001453bd91377mr790079pzb.5.1692305958381; Thu, 17 Aug
 2023 13:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230724151640.555490-1-frieder@fris.de> <CAJ+vNU27A15eLWtFfHCOVn8JgawcgoGUAv2PhKmEf3wcoerPXg@mail.gmail.com>
In-Reply-To: <CAJ+vNU27A15eLWtFfHCOVn8JgawcgoGUAv2PhKmEf3wcoerPXg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 17 Aug 2023 17:59:05 -0300
Message-ID: <CAOMZO5At6U9_JinNnumCqLMi2ER=3RZXDtsfdAEyjS35SvBaKQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: bridge: samsung-dsim: Fix init during host transfer
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Frieder Schrempf <frieder@fris.de>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
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

Hi Tim,

On Thu, Aug 17, 2023 at 5:53=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Frieder,
>
> Sorry for the delay. Yes this resolves the regression I ran into. I
> tested it on top of v6.5-rc6 on a gw72xx-0x with a DFROBOT DRF0678 7in
> 800x480 (Raspberry Pi) display which has the Toshiba TC358762
> compatible DSI to DBI bridge.
>
> Let's please get this into v6.5 as soon as possible.

Care to provide your Tested-by tag?
