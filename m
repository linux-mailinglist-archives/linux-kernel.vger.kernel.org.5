Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CB575FEA1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjGXR6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjGXR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:58:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781261BE1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:56:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d066d72eb12so3888812276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690221412; x=1690826212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZhW5guor5Hz2gkFyNtuQtClYHHtgI1jQRPcPTzIh4g=;
        b=zBP6/yssRg6JfCnUlMmgDV1KxmrqEtLeMzVKSNMKDdWWkEQDA4EoLBuC84wHvotvY2
         Qj2MlscVI3d7nbXefmICVw3aBmPAtP9Iy6/OTwfq6JEkjb4vXpdsdgMPwJNqXjAzM1uA
         MFXXwr7tzsIgdikd7fWjX90eygo11I3J+6EBQEbNzVohHcbLLpYf5mJs93AZcTEDkLv/
         hdXt2SSH2TxvFPMAkJepU3KPocNnmuOF5kJtVZJ3C/4r7axqfcJUGws70DY0u/15kH28
         XUBb7ixKkiCBAf69Y+1BvE4u5wVSXEnY6O/cEOFaacU2bmQL5z3uagVZ7j/bj/sUJSGe
         7Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221412; x=1690826212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZhW5guor5Hz2gkFyNtuQtClYHHtgI1jQRPcPTzIh4g=;
        b=NF7j58NwAG163BwzQNeyNv7uBH46jhy24IfhjUCAEutN+nrYX7SyHObKvvidcL/bRz
         w55i6GBT9TNcw0kc3c+LCTP+PkkRUhCRtKUGYqqd+AAPIiA2IBJGSDTRyY2ba0gLxfQZ
         7OpHx3Qm38athcXaVkqRbB8hJJbVfxBil8pOC1jtbmRVGs62bRwKw+fyZ9DSwijGxwDX
         J/IO0PnpsjbeMIP9aTwcmffOBBLJH8HFH+x2pZ7hCabWFk+zotCQ7QlVcHX5aDmr4mzT
         VAnuYVcit5w69/HasRjwrvZSs1WQtN//UrHhv9rIRtkwDLF0laHGwKfk3DuTxdeiOsRV
         hRDQ==
X-Gm-Message-State: ABy/qLbanBpTxfhV2UBrGM1Vc9qfnDcuCMsqOm2SWYRm3V2UBuqqyLlx
        HskVihR78JRXZM8ez12qjy3WU9juW1v+yoVg8HA9IQ==
X-Google-Smtp-Source: APBJJlEL49lC9Xnmn+AOa8dWCtiGCXwv36+U8j4wMBcZBf0by+9XagUVQLV+jdt1mUay5/9S78Hs2x+mC09ZmIB3kEc=
X-Received: by 2002:a25:bcc4:0:b0:d07:2183:f547 with SMTP id
 l4-20020a25bcc4000000b00d072183f547mr5274226ybm.32.1690221412745; Mon, 24 Jul
 2023 10:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230719105829.148011-1-luca.ceresoli@bootlin.com>
In-Reply-To: <20230719105829.148011-1-luca.ceresoli@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 Jul 2023 19:56:41 +0200
Message-ID: <CACRpkdYshDD0CmdjdeVk_oG1s1W4BHHFzLmzN9QtZeMaEyvTBg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: db7430: remove unused variables
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:59=E2=80=AFPM Luca Ceresoli
<luca.ceresoli@bootlin.com> wrote:

> These variables are never referenced in the code.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Patch applied and pushed to drm-misc-next.

Yours,
Linus Walleij
