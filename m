Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA177E803D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjKJSII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbjKJSFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0773977A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:44:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so161725e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699627471; x=1700232271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10OEd7QT7TQMRLL1rtLuH43/neHocTKp/HU4MqBMxu0=;
        b=m1pFAfKvfjJu6lx3hjaJ6koQMLVfKcpBcczvRIf39Hlv8qMwpfqxEiyYuxnHYUVxBh
         PNxKCRQPBBzpPoOeJ/er5/jifaJ7l1kv8trDGdT/EQxeHM5Tg9eqv4sNweZfPDQHV/+g
         Dk7Bxm6EsfYVntHzjVD/LuiK96bciPSKwoji+pt+sq3VaI3Nu2dae2ccbC3OAuq/xTIg
         BzcZ0M3vatJ9UiXZ+Cem/Biaz6gmMV/PGBYScom2ZImCpwPcqWcpfNJl/T3oCqIEIzqA
         R2UrUkCT4bFinNMMAu0sdDkd9pg0W9Xdn3Zrle7DA1eV8B3w/JAGl/u6rr2SqC3fNOZm
         DspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627471; x=1700232271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10OEd7QT7TQMRLL1rtLuH43/neHocTKp/HU4MqBMxu0=;
        b=KjkNoKb3UvdgcExdfNyPexOLGZK/t8xoQoacB1Ie9toPJwSzanQTBtduu9wl+C9LUr
         v8om3qPNXa6lsm2rmm2beWt4Qe4TcBsyez7jcZVVXOdutCE2zKRtSC3/yW5U5S6N1xyT
         ELTTb/IQDtI0tyK/cd73v26ewPz4C3F3UuY2wAZaXZfivaqybWSDxtXBJfEWpI1wY4GH
         0pR2uuwYv0Vx0ZlZC0eMG4j3gRUEO5cxmE1+tmjnctg1Y3eYE8rBe4n2TP8HvmQBzc4r
         oMoNz/z2fWahgFvVPivqdgfF9xnHbIJbMww29qydeqM8XTRCs1AR3HPzzqouxwvFhEfh
         K2tA==
X-Gm-Message-State: AOJu0YxQ0ps1yDP+7VXwRS8BMUY1qd/dt3yGrqLb9fTSrgWyp1lrmdEW
        Np5L8seSawkHtZa/LICNvX/wlK1d8bp3l9ohnLrvYQ==
X-Google-Smtp-Source: AGHT+IE5FXYGSgPFXoXtBFZ/aR7LWB3EeBWSPwp3SiMKQVhxi/p83QC6vx+njb0turh9PF6w2RlHWJfsime4QvXZBNg=
X-Received: by 2002:a05:600c:6013:b0:400:c6de:6a20 with SMTP id
 az19-20020a05600c601300b00400c6de6a20mr356475wmb.3.1699627470599; Fri, 10 Nov
 2023 06:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20231109092634.1694066-1-xuxinxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20231109092634.1694066-1-xuxinxiong@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Fri, 10 Nov 2023 06:44:14 -0800
Message-ID: <CAD=FV=VxQJFWFaGHD+zpr4dxB85jMQpJiTDAmFZk67CTYNcg=w@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: auo,b101uan08.3: Fine tune the panel power sequence
To:     Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 9, 2023 at 1:26=E2=80=AFAM Xuxin Xiong
<xuxinxiong@huaqin.corp-partner.google.com> wrote:
>
> For "auo,b101uan08.3" this panel, it is stipulated in the panel spec that
> MIPI needs to keep the LP11 state before the lcm_reset pin is pulled high=
.
>
> BUG=3Db:309908277
> TEST=3Demerge-kukui chromeos-kernel-5_10

BUG=3D and TEST=3D are not something that should be included in a patch to
the upstream mailing list.


> Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>

Can you add a "Fixes:" tag, too?


> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 1 +
>  1 file changed, 1 insertion(+)

Once BUG=3D and TEST=3D are removed and a fixes tag is added, this is fine
with me. Please send a v2. Feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
