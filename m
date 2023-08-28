Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0446678B739
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjH1S0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjH1S0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:26:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A719B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:26:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2690803a368so821482a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693247197; x=1693851997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiPV4G5iHAtAG4UvFP/AL0UjoI+7fgafbUPgIedNHeY=;
        b=hZRyflvdsgVf7Z/jfpA1eH6omfmqrfbtnaUVRqGynac978QClZRwXdwM5S4YzNbiIx
         9CuNrESpSwwG3hBb4UCMzoYqjIBgnNl1s6SbU1GwRBplRSyLaOZLw3dC9iX0nCAQw1hL
         k7AtYHIcp7Zm+ZfR1FIen1P1Rk1vve+N0dQPPNI3oAOmhUvm4q6SVlqSmYZq1qkl3pKF
         mZOmBbbMaDjimrVgM7vOBkt77dWEM2QPZM2FpLtFFBOCvM5lkKE0qANOGCzzYDVqWVZe
         BqDp/50Hlo3+4wMOD61LqQFmFhf2oiCx7JKlGUBiHS6SuWPoH7pcTzP2nPv1mumg+m5W
         d+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693247197; x=1693851997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiPV4G5iHAtAG4UvFP/AL0UjoI+7fgafbUPgIedNHeY=;
        b=NI3uwd+w5a9xVeuzp69trSoC9NcgXYsO0CS9R4szCd/Uic1i0IMGTdl0ELasIO2wDt
         yGOp1SlmuoG8DuDcddaUjzOePuvcGJVxL0K+qu1dF5bW9ny9TTulSzxQVCvwRbLF5MXJ
         ZathGzH+5RqYwCd6yEQVjnR3SN1G9Lg0QmxmqaHUM/NOGafbgqYhh/GKIIKeJE5+OXIA
         aKJj7+JwThwBRn4beTVdpQTXe+TidBx/t3Rxqyo1BhXU0SgNtiaQZQ29ifj2irISRdqc
         GYXN8CdY/Nkan80iUYcwdLjxJOkZYE0zUnrZcOX1qQcgD3gTxjgKAPjXCURrx14haMBg
         NJaA==
X-Gm-Message-State: AOJu0YwF4vFqLVGS9tTF7naOqvaC9e1vHgqSVn1Tp0YxvlWkWbVDIFMq
        orS5URE2tIxK2MrO4uztFO4DOKYzq9733oJxyGQ=
X-Google-Smtp-Source: AGHT+IGoMCQugWsIfzxKXbeAuTWuckm9aMkH0QVvfSGDqsCLi/h7IPshGXj6QQLYt0zErVLqJGKelTlnx9A0D0AYI8w=
X-Received: by 2002:a17:90a:680e:b0:26d:2635:5a7c with SMTP id
 p14-20020a17090a680e00b0026d26355a7cmr24357519pjj.2.1693247197185; Mon, 28
 Aug 2023 11:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de> <20230818-samsung-dsim-v1-4-b39716db6b7a@pengutronix.de>
In-Reply-To: <20230818-samsung-dsim-v1-4-b39716db6b7a@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 28 Aug 2023 15:26:25 -0300
Message-ID: <CAOMZO5AFEDMT1de2O2sUUuw8E0ZRCyD4QVVCKxAtfRaisU5gVw@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/bridge: samsung-dsim: adjust porches by rounding up
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

Hi Michael,

On Mon, Aug 28, 2023 at 12:59=E2=80=AFPM Michael Tretter
<m.tretter@pengutronix.de> wrote:
>
> The porches must be rounded up to make the samsung-dsim work.

The commit log could be improved here.

The way it is written gives the impression that samsung-dsim does not
work currently.
