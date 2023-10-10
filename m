Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA097BFE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjJJNl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjJJNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:40:54 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0161110C0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:39:40 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7aaa73d55so17416957b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945180; x=1697549980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=Rb1RgGDQAYR3GfGAUgAovrKgkXvgkCeBS1fAjNWrmTzUD008LnCuAFfvX+s9kuBJm4
         7O/VtlC7W9+MKbu9CsksumqAfYZDSha6ouzq51v1ib5Jf3g+P+LtA36YDr+DihIOQyNp
         hGQuaPM71ImbTUOZHis8HaCcQWHm5g2WERrvYwH0nqvK20FNUjZIMxAQ0iqEiS/rDnsK
         wxfCzdQcloAacOc0tHG2bfBd+NqYDV0awsbiMaWvSHhCXG25mznE7Iaka5dk7mz3UIYR
         Ubnv9gwrVlSCPuBjMrgy9mlpTzGxt7Efn8Tum2zS7zP/12mZjK+ps4X9ixUiH1BJm7wi
         Pzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945180; x=1697549980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHv90yeM59s0sxqLXofNmRkQi512BP/YIHCc5n2XRV8=;
        b=CIPwqNY40bf4+j5TYWcHuTz37F7t0/Y9+L7pO8YaBK6xlYNToFx2kL4tos40XO5kPH
         qYrH3d6Cc50oTFSrpPhxR7LzMWjVnfoCxLh0D4y4nd+GSh3QVyHoYlsQ4Pg+yW5ZLhtt
         zgYx7VCvdt/q4LMlOJX+BFWux2uRASkz2gDzr9uLwxUDTjIAma9Y6F+enIfhTzCWru2L
         3nKZvp2Ih0cLInKOzn/aSoQ4roPyf9i0dq2wGn9EtyVgugeEaOYANtv4exSSEv5YWjFr
         azH0epIBBPPrufyA78m3ICyd64u9ebw0lcnsA+KsduB5lymMXWiEH/Zq2isrlzrob4Hj
         6kjw==
X-Gm-Message-State: AOJu0YzJkj0d1YFBHv+OrD//D9/xJW73TfEFBgpCdFiKv0mcv2ljZvEa
        EtM+Ors/zMpdj6wEJv1DsPMTiKXCoo3kFUPzI5SqkoX+tN0wVGkblpU=
X-Google-Smtp-Source: AGHT+IEtHtNGXfV4b/OIFYxT0p0m30lcqUfsOnETKBIs86dOxB4vQyGIRyKjEzonKsDLSTmR35U0Lrn6THw/bUsi1QM=
X-Received: by 2002:a81:ae13:0:b0:5a7:b036:360c with SMTP id
 m19-20020a81ae13000000b005a7b036360cmr3010246ywh.23.1696945180141; Tue, 10
 Oct 2023 06:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de> <20231009083856.222030-10-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009083856.222030-10-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 15:39:29 +0200
Message-ID: <CACRpkdbfHpGGf8f3Bngj3Ypc93bP2Gp76SB_+1HPjsXyq4wTHQ@mail.gmail.com>
Subject: Re: [PATCH 09/20] pinctrl: artpec6: Convert to platform remove
 callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        linux-arm-kernel@axis.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:22=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Patch applied.

Yours,
Linus Walleij
