Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F067FAE77
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjK0Xga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjK0XgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:36:25 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B57D10FB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:36:28 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5c85e8fdd2dso45517437b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701128187; x=1701732987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxfDgaFC4m6dvQrI/xxwWv1ne3cvruiJUHEQ9EmXeMY=;
        b=mOwCj1Dbip2p1zIGRpj+HqkCyi9NhMnS1y3/7RRHJiohcJJ2bI87n2JVEW6TQW7COs
         H2wc0j+q2zRdVyj9N8rov2/Az1AqWlXy+7Uf6OICJQFMTQI0qV6Rd8u8Kl04TmjV6QJH
         VPPXgvfLFs/mEmHok+KqiyV/DyK7RBVVmn9w25ub/cvbx+KGq95KN55RVh1lIBMBMA/v
         cDvWvGsrAS5cfj9V/Fh1GO8Xfnv3jVnwXCBC4egDfl+EhJupM3skOLgfhhel0wJS5Vvn
         mjCeY9bCC5AChI26ySP77By6GF9R+vI9mSmGgPpl8wPvOPfC6bpsIZkdRlQwuhOcUN4p
         8Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701128187; x=1701732987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxfDgaFC4m6dvQrI/xxwWv1ne3cvruiJUHEQ9EmXeMY=;
        b=f8+DSrM0/CvKI8WocAK13Gzu/cBkQ14eMOHrgPNLT7RCq+D4hFOhyzEqw4HJ1Tr3FP
         umK/xN3boFtGjhx+ZOeoTCyU3Lk9qG5IhhccT4qqZnQ4DJGQK11pChubsg052e1DoMLE
         5cKquPJz2wGcm8VqC0/sZxb8AJ2Q197cigUqSnQ+nbuzphrKvUaCJ2RWTwPJZljmw+S5
         BF9LNBwB79Wf49TASXGC5tPJzA72sfuTd1kyaN4Zs90SNWl+lk8QbTKdikB4kfi34xBt
         itTeA2g/Sb/kHrTcjsNX+QGbz1T4dxTHbyst4p2yhzmdh6K+sMp/wi2CmCof458t7uWu
         YAJQ==
X-Gm-Message-State: AOJu0YzxZ0GIkQTCwyNJSLFa6yWEYe7Szk05iIdZT6lO/NhgcjGnM4Wu
        H5+6CksZRP4Zgh/g3Gi7Q1QFUvVCrfsDO1YZqtIDgA==
X-Google-Smtp-Source: AGHT+IGfr0I9La4Kr//PgkPIyvm3aD+su31rYz/shnFc17Jv2+3LBLLPhjJe+M3dYscwj691DO6cbenHSGUKNV0HBVI=
X-Received: by 2002:a81:ae68:0:b0:5d0:4199:de09 with SMTP id
 g40-20020a81ae68000000b005d04199de09mr5390153ywk.35.1701128187543; Mon, 27
 Nov 2023 15:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org> <20231127232542.GB25590@pendragon.ideasonboard.com>
In-Reply-To: <20231127232542.GB25590@pendragon.ideasonboard.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 00:36:15 +0100
Message-ID: <CACRpkdYWjHbgWQc46hGM3bg+5nf4NiveEZJmHrnx0X-=XsUDLA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Revert panel fixes and original buggy patch
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

On Tue, Nov 28, 2023 at 12:25=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, Nov 28, 2023 at 12:10:18AM +0100, Linus Walleij wrote:
> > This series reverts the attempts to fix the bug that went
> > into v6.7-rc1 in commit 199cf07ebd2b
> > "drm/bridge: panel: Add a device link between drm device and panel devi=
ce"
> > and then it reverts that patch as well.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Linus Walleij (3):
> >       Revert "driver core: Export device_is_dependent() to modules"
> >       Revert "drm/bridge: panel: Check device dependency before managin=
g device link"
> >       Revert "drm/bridge: panel: Add a device link between drm device a=
nd panel device"
>
> To preserve bisectability, you should revert in the opposite order.

You mean apply patch 2, then 1, then 3 so the kernel builds after each
revert?

Yeah that's a good idea, I don't know if I should apply these though, bette=
r
someone else do it since I screwed up too much.

Another option is to just squash the reverts into one, that bisects too :/

Yours,
Linus Walleij
