Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F87BCFD3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbjJHTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344511AbjJHTdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 15:33:43 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129FB3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 12:33:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d81b42a3108so4204007276.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696793621; x=1697398421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXRzHYXF1ovI5v0uOrxk9RS+XWxmoS5QhrpYqiMEbm4=;
        b=khYJK5FGDL4iNPcjHTTwctGYW1MUyU4Fr8ljsn0kS/9KsvdgbR6fuYFE2KLyt2TVeW
         b39ZE/lBiK2zA3gcGL5lRvnDMCmkv82X13gF+w0GTTmpH6l3o4evzjRxk4gyY9/ONzUt
         spMXlkmD6iYVRad5H/K8iS+gL+Q71v+OJTtWAskqJ0Q/9ybFxey5Y/u77yMhDdHAvhvX
         KvDyhYEqzZ0qpGURooZ2/f3ZSyXHAe6ew98suWXsZERPhDwiX2ALlbXMVI0mp0hGO55Q
         Hb+pXnyQ+ePAH9w1Lf/wohJpYIRRs7nHseOel7zwYpnVhFOA4QVJC4VyFKIjy+86/aVg
         CdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696793621; x=1697398421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXRzHYXF1ovI5v0uOrxk9RS+XWxmoS5QhrpYqiMEbm4=;
        b=HG7Sh4x2HNTb1kSSTwJH9Hs/2yp5GgcaauJh44UnwZodWt7kc3QTzZqsnxxAeIIu/N
         rXGTO0qbUGDQn0g9lQ0zYoTj+wyi3NK/RHpB3i2VxFMI80G0d0Z3BlkpqwiCpw1I6Zvj
         J0rkA5m/pDvn3Yq1/6Krcx6xRcvO6+OEW44QbJb6kXq6KZJVg/RMTHz29DmVHi6oe7xo
         BgN54gtLHAib/jshCOc0L1xqwemFslbaUOYv1B1K3M82liyLzCwIqEtTH8FOs8LuoWYR
         iYG76lKdqjH+LwBv2Gx85xkPnnVD+1Ha+6gzjK0Hj35djKn/5e1N3GgtsLes1SZw9WFS
         sxLg==
X-Gm-Message-State: AOJu0Yz4P4tiVm2w8A/aumRSCNo4D3pCBNhA4nJqrTqBwTaq+z+CWfb/
        HEyLX3U458x/3iftpkgq3dT0yJOVDUSu9NvFZSYmHw==
X-Google-Smtp-Source: AGHT+IHOqqme+I2o7pnkrO/NMwYTV0OkUbgJ6TEHW4l7Ztd3XLvE/HYW5b4ga2KyjrAdRgrcxO08nr9fo9VA/7Dbnl0=
X-Received: by 2002:a25:bbcd:0:b0:d89:4d9b:c492 with SMTP id
 c13-20020a25bbcd000000b00d894d9bc492mr10786483ybk.22.1696793621571; Sun, 08
 Oct 2023 12:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231007060639.725350-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231007060639.725350-1-yangcong5@huaqin.corp-partner.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 8 Oct 2023 21:33:29 +0200
Message-ID: <CACRpkdbek0-Vhk4_34qY+0=EGrQxJS_CfLuF_5fRozMMyc+=Kw@mail.gmail.com>
Subject: Re: [v1 0/2] Break out as separate driver from boe-tv101wum-nl6 panel driver
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        dianders@google.com, hsinyi@google.com, swboyd@chromium.org,
        airlied@gmail.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 8:06=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:

> Linus series proposed to break out ili9882t as separate driver,
> but he didn't have time for that extensive rework of the driver.
> As discussed by Linus and Doug [1], keep macro using the "struct panel_in=
it_cmd"
> until we get some resolution about the binary size issue.

OK works for me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Dough, if it looks OK to you too, can you apply the patches?

Yours,
Linus Walleij
