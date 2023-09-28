Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ACA7B2371
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjI1RLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1RLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:11:35 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18480E5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:11:33 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7741c2e76a3so736218085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695921092; x=1696525892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad6GXmCMMLGlA/s915WQkLBQI5kRAuCS5UswE60HNfI=;
        b=LYhJumivTY/T3QifHdiGaBlcvxDxihJZafURLd+upntiLJCQk2rJv9wTR/g1/4sd/G
         RKH6NzKMo2AonbSolMcVYeTlryfs82eKxx/C2FCQyXHGWBgl0pg5TpRFSdmsopXwT4LY
         juGvAhN8UxdaHGg36KMLCVpVV4koajmd8wMAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921092; x=1696525892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ad6GXmCMMLGlA/s915WQkLBQI5kRAuCS5UswE60HNfI=;
        b=LJkVGUfDNSR+cVQyHbI8PE1mmQ3z3eQfkJvoqokN3WB4dMsYE7rdkiHeHnKO/TiqAn
         vKVOJxFGmTsmSmemZ88DP1BKyXsi3rVuyY3VO9iQHZErOVGWKpkU6ciLYw91uuD5+Xpt
         DDSz+IVYDQrUXwKa7AteO0GWoV+43EOMk1A3mAhAhWI658smtpk10I6hS19Eg1rseisN
         7NBWzT6DFQvlQVLEsJznjcuUuuf6L8jsUFJq8efIiNGcF7jnllATHGFHLxcm2vZSRL/9
         qBmk9xJ31CjFB0HJ64qpuy4dAfeaoXwcMUcjhE5OS5g537fAxHvWdWfzdhs2ViT+jfzA
         DU8w==
X-Gm-Message-State: AOJu0Yx07JQCYZUFwPiGuVlantrJRNX2eeTmTdV/97P/rT1sWKzW1N/k
        x83lOFfbeHYRM4WTrv2BQ7cwOxesrrVjITxcxbekvA==
X-Google-Smtp-Source: AGHT+IHesZpiVMVGppRM5sZGX1k8dAYc8NbOshqx6ZWg4hpnRK2dL3bBByRuZLAHM7JVHkxI33vZnAXSKsbJODPG+W0=
X-Received: by 2002:ad4:4f04:0:b0:64c:9d23:8f55 with SMTP id
 fb4-20020ad44f04000000b0064c9d238f55mr1744028qvb.58.1695921092168; Thu, 28
 Sep 2023 10:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de> <20230927081040.2198742-10-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230927081040.2198742-10-u.kleine-koenig@pengutronix.de>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 28 Sep 2023 10:11:20 -0700
Message-ID: <CACeCKacb0+zKuMFTMnqeSD2DRFd-K=v9+iU2tvLjj9QyeEiRrA@mail.gmail.com>
Subject: Re: [PATCH 09/27] platform/chrome: cros_usbpd_notify: Convert to
 platform remove callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
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

Hi Uwe,

On Wed, Sep 27, 2023 at 1:10=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
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
Acked-by: Prashant Malani <pmalani@chromium.org>

BR,

-Prashant
