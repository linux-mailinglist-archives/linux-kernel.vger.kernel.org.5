Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37F7D0E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376953AbjJTLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376927AbjJTLLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:11:36 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0C818F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:11:34 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7c95b8d14so7264877b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697800293; x=1698405093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=238BGF/tc90S5r9KIjhwqf0Ln5fMccNmQ3YyMRe3cHM=;
        b=y4DMfBrj1hvn174C5nx08iCxmQ+1IlNAv2L4kQOtHTQ4u3LhQ23gjms2AlAXDfuXcu
         savYhDfFU488UFg30aLuSGhS4y1aPl2JyGe3ZVvQMfsBiLq69erK7rVGlfi5cSdHtM2B
         nP29chVgg5KTL7Jaq6qeTCvPcD+At0/tr6AONXniu5MyZR5U9t6EwcEsOevJnjg11qsC
         uYNKgZ8ol5zjWmQg3px5BONDGgYe73avmxIf37H8cL9R2oD0AM0HYfAghlUyPFqabuXr
         y5DoNNVl9opOMSnxxifI5iLqvWztcBqBlHYx7oOHik+8SL+GtyT630rbxuVVxgMOzA2B
         6S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697800293; x=1698405093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=238BGF/tc90S5r9KIjhwqf0Ln5fMccNmQ3YyMRe3cHM=;
        b=KjlZUMi3H3+OMTThZGzd/C/ecLZbs7LdjDIqWUvxzrWet8cTtvxO1rWTxOse5qryar
         FSp2bBqjO0niJBJw6n+dYhm2yoodIyRFb/BO2nZ18ccchtARjM9sD7Hw/IAp51OD+Yd/
         1zrpPhAZF5RtSWTOYCYI2+Z0NtasO0jiX0TMj3Ni9OsTbL5Hm1YaN1RLreUI0O18wkte
         Y7AACS5PrcYBzD5SugAk1UDn+h0iQH5oIs6+CLFrtpuTa1t4ErLmBMKi0ik6Pjr3+2Vj
         LH/AwBXSTXmSithcXRr73RrDMfvCUXXk2dLhTTY/s8dfuLORe+Te4zNxaTJxJXYJ8Joq
         RHlA==
X-Gm-Message-State: AOJu0YyFdmpXg9F4igMYQjqrAei1/J3g3Z93Qd/oficvsIIh2ZKHNnO2
        pR9sguFFOvaU9KXVDQOKVzrFViP/37I2Fh98cz/NERv33CZMsJRB
X-Google-Smtp-Source: AGHT+IHrTRBukRUSX+tX4qVyHMfQ0ol4wLNSh8CW2fcwseZZ9etXJsyey59rz+FklqB+EOylNKE9GnrwX/uU3HCDcEE=
X-Received: by 2002:a25:acd4:0:b0:d9a:5f91:c615 with SMTP id
 x20-20020a25acd4000000b00d9a5f91c615mr1338698ybd.18.1697800293306; Fri, 20
 Oct 2023 04:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231013091844.804310-1-yangcong5@huaqin.corp-partner.google.com> <20231013091844.804310-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231013091844.804310-2-yangcong5@huaqin.corp-partner.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Oct 2023 13:11:21 +0200
Message-ID: <CACRpkdb93nGB=Owx9k6KepAVd_n=TgD5BHSZvuRv4+RGAs1CFw@mail.gmail.com>
Subject: Re: [v4 1/3] drm/panel: ili9882t: Break out as separate driver
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        dianders@google.com, hsinyi@google.com, swboyd@chromium.org,
        airlied@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cong, Doug,

thanks for fixing this up, I'm very pleased with how it turned out.

Yours,
Linus Walleij
