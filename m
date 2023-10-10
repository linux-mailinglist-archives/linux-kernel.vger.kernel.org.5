Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418757C042D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343770AbjJJTLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbjJJTLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:11:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485F194
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so2682a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696965087; x=1697569887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UhWPPtavJHzLAPYPA+MixCb/WnkmoReo5Jlg6WhyMY=;
        b=PVGqJiHcTWWwpYwrCKQGaD7/enN0rPX3bvl7p3XxyqF5hhURHuJXcJpWUEu9rGtKYx
         VEvqcO2+Aey1O62yVvv8yE49N2YYUrckjY7ksxGrqKbV0WSFCQMjOSlA7lIJana7L0bW
         F/UMPML7kjwS+9OYeAcyEyQqPbjXJT3owDo6NSzRepBYqAYudsdyLtDnLQCSbuMq9Yya
         1sCmvCmo3PLHE1p17zbNAxXN+omuE2U9+GW+4ks7DpLxxcPHC5nq9t0wx1QXl6kL3V7i
         G7rQi2vuM+FaLbz0SjacfYnwQAlmNN98TRR7Kg8pv4N/MBge6OBWpWXfyewTstr+CBqa
         VJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965087; x=1697569887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UhWPPtavJHzLAPYPA+MixCb/WnkmoReo5Jlg6WhyMY=;
        b=QjqTCPowsBs5B+hxVQFkahuhuKrAlik2AcmYeVC1D6LpQ/qzlNuY0RxcRtoHZTrJRb
         Jti7UxWbC4BNK5zrU0tJyi/IXoJ4okOtgQqQEDeNG5djChpYVMqjKwr9Z9Ll+9d9uPwv
         9U1ssvxbBDKiOidNLZyU+vCUgX8bjXNFoRLMcwiou1R+CbOGEh3uj0cWJMs9iBwOixFw
         5C29JOotcrQuouRe3e0+Bw8fiEuXkODk+/ckb28RBbG7LEk8NPO+UMI+ffQo7rZKRLlK
         ZX6dpehlxYycU/b04g+PEHTh8mjumACq99Rqxq/doJ2hmH8xQXUF/UkD6A6azqgyG2VY
         w7lg==
X-Gm-Message-State: AOJu0Yx9pGSbkVM1bNJvJCZuBW8aI3DjDmif2Ngo8ttwK5SrloINOAcN
        2tdT4WUQrQ+Hd2Jv+aenlzBWw5LXjTlFbkr43r/i9A==
X-Google-Smtp-Source: AGHT+IG3iu4lDDQxvxjKVyXKAvsUtrHzYogEnV9JAMPz8LTFaFQJBRNy+ua8NBMQYnzwgvmcL0rlz26idEroMAGFi5U=
X-Received: by 2002:a50:9309:0:b0:538:2941:ad10 with SMTP id
 m9-20020a509309000000b005382941ad10mr23380eda.5.1696965086532; Tue, 10 Oct
 2023 12:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231010121402.3687948-1-yangcong5@huaqin.corp-partner.google.com>
 <20231010121402.3687948-4-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231010121402.3687948-4-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 10 Oct 2023 12:11:14 -0700
Message-ID: <CAD=FV=XFYyMRBoAnWuu-x4_qpKwVNR2-kLera73cwnu==DZkVg@mail.gmail.com>
Subject: Re: [v2 3/3] arm64: defconfig: Enable ILITEK_ILI9882T panel
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, linus.walleij@linaro.org, swboyd@chromium.org,
        airlied@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 10, 2023 at 5:14=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Enable ILITEK_ILI9882T panel.

Could you add a little background? Maybe something like:

DRM_PANEL_ILITEK_ILI9882T is being split out from
DRM_PANEL_BOE_TV101WUM_NL6. Since the arm64 defconfig had the BOE
panel driver enabled, let's also enable the Ilitek driver.


> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
