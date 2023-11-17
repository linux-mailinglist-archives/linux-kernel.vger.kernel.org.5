Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346437EEE0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbjKQJEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjKQJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:04:07 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C601D5F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:04:04 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso1803858276.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700211843; x=1700816643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=INxHYDPvWZEfX4YbefK8xCXn7NpSQ5SeCE7fYLVC5i4=;
        b=lVk7xpGKzQjLMtPfAwvx559jyEKATnwqoz8QAh9+w2BN33po2h1wVYpTw9LSf6y2cd
         QgrB6Fn84NnFKDVDuIrfC4UFOveZ0vs9RxgttR8MI5mwEsYcprkpv/oEu8SmCcPdFqcZ
         QSIUYIyGuhp+Je02RI9LatF2/KDYj7aflv05tevQdxOq30Ql9x8gBqm9xO01Dpl2X+XJ
         4GNW8mDS3EmLH3Ucrw1aG4Jw5DVL9xSkNgHvIp+Zs043/0rRfVqxmTkBiRb3RwB5Nzjb
         94FUyub45pZ04Aaqus4JSHU7kIdZTyMDp0IOy9TS/YfBITlZhf+MQy/2XnFNvxujMN/W
         gIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700211843; x=1700816643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INxHYDPvWZEfX4YbefK8xCXn7NpSQ5SeCE7fYLVC5i4=;
        b=OYt8AYyTkk0VijitUoDLPIwYF22qFKQRraCpH3wxYXsZosV6MbJSAwSQyl9mnnB35g
         j8kx4rnwvdvjVFYTZs8hKHE8x4lelgBLmWLOthJETiIoqSNuKN7KDV1YbryGcaWsXyDg
         nQH9Vujiz3v/i3JIfQ2RnphbRsbqbf8eUP8qV2lbqAjxG9Vm7YNC3h0qE35MPUCc3ESm
         v5ukJgAqyDuVoFK2KNY6VK7vC8g4WndUTNQzzmZmYDs5wQ+lUIzKX9UtF1ZTCrsGxQCD
         vZbKbvFGxGZ8DZ57f0T7xGUNz9YizwYHX7PwBoXq/8draNgiZKWJ9g/4cEqvZ7LULJ/w
         aE/Q==
X-Gm-Message-State: AOJu0Yw1hMqk3P3xsfJzzz2G+wpHHol4J7GXJrcyUDdZC5Y0lcqyrpnp
        QD+6bVFrQ0cFfk2wzppjiM2C2w90cjHCgaQ9Qpa5sw==
X-Google-Smtp-Source: AGHT+IH1pWflHfi8hN98JclJU1bBwV+AayAuHAiCbo2Yy6iJi5kz8hoy6KNUMTIHH4XZlaK+GjuYo/OBc5e8YA7rimg=
X-Received: by 2002:a25:107:0:b0:d81:89e9:9f48 with SMTP id
 7-20020a250107000000b00d8189e99f48mr16791660ybb.63.1700211843160; Fri, 17 Nov
 2023 01:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev> <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <1b59d647-c345-4260-b07b-22abb70ae17a@linux.dev> <CAA8EJppY2+ymX0kLY+cuR=SV1Po2J24r=NQecmb3ZhSE9NHG7Q@mail.gmail.com>
 <7b85d057-3d66-435a-a657-dd69067b6bef@linux.dev> <b9eacd91-8d6f-4265-931e-bc31cadd54d4@linux.dev>
 <CAA8EJpo1KhzTpaSqjbOuQvNKw4WGaqrtNBtNfdNLn28eZVgwhw@mail.gmail.com> <cf27d25a-3e51-4292-af63-37e5bc585d88@linux.dev>
In-Reply-To: <cf27d25a-3e51-4292-af63-37e5bc585d88@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 17 Nov 2023 11:03:50 +0200
Message-ID: <CAA8EJprm6FL9_ZOr5uBXNXLBt=scs=FY2o6ZEv5r576iEM5KRw@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 06:24, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
> On 2023/11/16 23:23, Dmitry Baryshkov wrote:
> >>>> Then you will need some way (fwnode?) to
> >>>> discover the bridge chain. And at the last point you will get into the
> >>>> device data and/or properties business.
> >>>>
> >>> No, leave that chance to a more better programmer and forgive me please,
> >>> too difficult, I'm afraid of not able to solve. Thanks a lot for the
> >>> trust!
> >  From my point of view: no.
>
>
> I respect the fact that the community prefer generic mechanisms.
> If our approach is not what the community want, can I switch back
> to my previous solution? I can reduce the duplication of our
> localized it66121 driver to a minimal, rewrite it until it meets
> the community's requirement. I know our device looks weird and
> our approach is not elegant. But at the very least, we could not
> mess the community's design up by localize. Otherwise, I don't know
> what is the better approach to solve such a problem.
>
> Can I switch back or any other ideas?

I keep on repeating: create the i2c device from your root device
driver, which parses BIOS data.

-- 
With best wishes
Dmitry
