Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3307F638E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbjKWQG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjKWQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:06:55 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E627210E3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:07:00 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so975241276.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700755620; x=1701360420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gECdDvL3zdjhM1uOEUZS/mAxmnQq5h/GZkoU/9Sdfs0=;
        b=bRnVi8b9AnYrq7qlDJgCkYwyekEAfZZMrgcuXg/E/wOJ7kwav0GFsGeM7lXZpsfiqS
         9VEYAIgP/e11OGlyjreBDQ9YbmwxSynFv+MR+92rUxpTr0FMN09GHUTBFG7J9gkkLZXi
         KgDQE7wuH5SZLabEOea/zAdOcyNh/tuhTMD4ciQoii1d9ALrrV2a0avOaMp89zgM0wuA
         T3SUHfQ03tWD05t6VlAOsf5bNTMhLVQP2HS+KrNPzgDlNDhu6S1LHJGCP1vdpkBHPknL
         VhoUsdIyPThIkk/FQadAwbKr4EeMN9lqW/t0z15loTqd7mPG/l3m0VImy8ZnjQXXD/IJ
         Ec+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755620; x=1701360420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gECdDvL3zdjhM1uOEUZS/mAxmnQq5h/GZkoU/9Sdfs0=;
        b=HoCkJ8TBARRwGvHR5yCJfwvEC4xJY310AxfwnM9hOdnVLkg6yfM60cO3n7bhQTlB0w
         cnMh7aT6TakWqnQy9zPUMszUC9b0KDq07ihOG49kJJ3x6N8LNtapaH/rZE32+hE3W8kw
         YPVky0hoKFWn9XGYar+47OsfXKbAv7NzHppb6D1pPNg3FaHQp+mJszQYZxlo19a0tGeo
         qiEUUZXICixgc5sVO8dJvRA/bEpNypFflYbAJKJObu0QGn2Co/EH5Qsjk+wvhEYNcIOj
         wMf+wrbPJkmK92dNIzwmjtPbifEj6R+KoFupSoQ49t7bk2X1d5c41gwWVKLsVFPrny1M
         WFMw==
X-Gm-Message-State: AOJu0YyxiSEIihQ+HLGzCBM8c86QZb/yZ9rze2uM7fG/qxCH6Qh1dMNO
        pzEya2CHLM5p3X/8NxRKlzql+LZBr1c8yUHNeRLf4zUkeMWT2Bzb
X-Google-Smtp-Source: AGHT+IG6rRchvB3o7IDoWGjkljYi/LHm1aTYwpKg5U+Xqyfaq7bFXS/QLI2PhPRLvXpmv8+CX2s4KbvZozP8qky2+KM=
X-Received: by 2002:a25:9c44:0:b0:db4:25b7:5f8b with SMTP id
 x4-20020a259c44000000b00db425b75f8bmr3554529ybo.63.1700755620065; Thu, 23 Nov
 2023 08:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev> <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev> <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
 <121163c9-0d56-47ad-a12e-e67390fef2b4@linux.dev> <CAA8EJpowjhX=LL-9cnQL4pfCei63zNkCGW5wGOeeFxcnFpNCVA@mail.gmail.com>
 <00ba2245-0e48-4b21-bcd4-29dfb728e408@linux.dev> <CAA8EJpoiehS2wS3ri_DggzxeEfLY4yK7X6c+bCFKvkwSce6r+A@mail.gmail.com>
 <963d7722-738f-4e46-bfb7-131027ca5341@linux.dev>
In-Reply-To: <963d7722-738f-4e46-bfb7-131027ca5341@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Nov 2023 18:06:48 +0200
Message-ID: <CAA8EJpoTWoSYjyZL7ARQiAeWabcXymy6f-tAzPM3YO=C_GOOZw@mail.gmail.com>
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

On Thu, 23 Nov 2023 at 17:41, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2023/11/23 16:08, Dmitry Baryshkov wrote:
> >> The semantics of DRM_BRIDGE_ATTACH_NO_CONNECTOR flag are implement-defined,
> > No, they are not. Semantics are pretty simple: do not create the
> > drm_connector instance. Pass the flag to the next bridge in the chain.
>
>
> Then, my problem is that do we allow create a drm_connector instance in drm bridge
> driver nowadays?

Yes, if there is no DRM_BRIDGE_ATTACH_NO_CONNECTOR. But that's deprecated IMO.

-- 
With best wishes
Dmitry
