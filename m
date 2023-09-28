Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1004E7B236D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjI1RKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjI1RKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:10:38 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7766E1701
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:10:31 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4527d65354bso5868102137.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695921030; x=1696525830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwI/pWHHt3c6ousus3HY74F/tUTyUgVMaKzFQON1XhU=;
        b=nDi5OS4Xr1KMxhz54Adyr5SOLINtS1+k1bVbgtlr0OUCbcdX20YgbssyB9lVt5XAkC
         iLdb1oMUltK7nNd7fu1LOTuG0+aWk77nm93A0/bwupUBsxJ/u4A/jI4adqap0XLeYJKU
         NAhrnqRiieaR0HAg7YJNEnd0TqcGAVjxjpW9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921030; x=1696525830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwI/pWHHt3c6ousus3HY74F/tUTyUgVMaKzFQON1XhU=;
        b=GGDPKHmyZCE6n/KMXvnFxRUczwk8+b1fDpr6uEZQ1SzFzXC8tTNhjJ5uEIYEntauyp
         qseqdrgaLl4VZc++gwdqfwIqEe6UztwkYhC/+q0gzzrGCwR5eK0eJ+7LEEb/w5BDUcw8
         OhfFLi5Ri5V5leprOWKd2lH2VSgO+IDWylUEk3O0lpM/bWtxrw5VQ2yl4aDdUku3fz9G
         44rrjBXULhBspqHtF3BQNaIv9LeUkN9V5liF1u2gMMacgI02UK5jxB8HGOnYv0FaqxhN
         K7kxrLZHDd+OVPjfGNW675CoCH4C8wvFt9p+u3k7s8sNxRgBCS706ux+sRnss2cHphgC
         ZNTg==
X-Gm-Message-State: AOJu0YyitGWh1ref8e0wL9EmymxReisuDW1uHfwEYkPzxMDUvN1Q9LJT
        YIOi8aQtXU+/MTFnBn+1fdrH+K7l/QExAiJiKJecST0jklk4w1eY
X-Google-Smtp-Source: AGHT+IE17jAVF0w1soiVJOQKNrGSpb7KUe+bYLEd88iRVMjflNPYirtHKlvNR2nEJbQuNcNHrxnC+wkZXFTAHhHhy4A=
X-Received: by 2002:a67:f50a:0:b0:452:55f5:55e9 with SMTP id
 u10-20020a67f50a000000b0045255f555e9mr2031564vsn.14.1695921030478; Thu, 28
 Sep 2023 10:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de> <20230927081040.2198742-8-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230927081040.2198742-8-u.kleine-koenig@pengutronix.de>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 28 Sep 2023 10:10:19 -0700
Message-ID: <CACeCKafuji+G_pn+A=9qUGRcSLS3cWeVYbVr85ZoHGvSUXKaoQ@mail.gmail.com>
Subject: Re: [PATCH 07/27] platform/chrome: cros_typec_switch: Convert to
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
