Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE27F659D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbjKWRjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbjKWRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:39:14 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D3C189
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:39:20 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db40898721fso1048345276.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700761160; x=1701365960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjgH4EkUYchg4j5kMkgkHWQ0qshINLgkzgLZ6QI8pc8=;
        b=CwJkkPF9buPkAhjEFB+mIeK09lyeEShpuNljFbAvK54Za2hvYDgwQPxXEyNtLvpfWO
         /+izahTpZbZv9y2ceEJqj1wdH7qipeX8ShHruYgBRQ2n2eb0MDY4gvbMXKFl6CbFZwno
         /IB6s3iQg+pAiupphZz2nABkXoL6qIER100vZyz+GHc7A4wzdLt8ovnE4BoAZzPATB3H
         1zcrCpxfT2Bl4uAQS9ZgSpYia2MwGHKWZLdlHO0O/pv9iThPSET/BOfxzMn0nBm0jWXV
         ZjXss5qUULdhRDyv0kzriDLmO2A5AhWlwbUqN93Jc2UFAo2G4ErOnmsYWCeuNkRSvBPl
         teBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700761160; x=1701365960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjgH4EkUYchg4j5kMkgkHWQ0qshINLgkzgLZ6QI8pc8=;
        b=ueh2iAi8kzDnOumUUSGEvpOdRihk8VSlKA2Dyz9orly6n4hiPofXLsSHg/gCEyUevo
         xtZZM/M9D8SyUs4GhTYcGp1l6VHHqGqMxPP79Hjw4Qa1Pt+007Wqxyes3Lvdxc6Fov8F
         Ki5qDZnC0BKzd4rNhR1XTsU4o3Uecmbhc2nnrjHiVGOXLozoNIbViCbTkUWEGOhxMBrV
         hEhzvA/W9DcY4RViWsNqgJ+h+4cCCXcyYT97T+DLM+4NIS9O9V0K6bx7sJe+CpSQJZIT
         GzbVuR5dIbqHLr7dL7lJ0CgvDcwNWhwMae7C/EJlQGN0mcOvnEHAxeTb3d4gGhDSkYRH
         1lJg==
X-Gm-Message-State: AOJu0YyiG4NLjE7jX0L424Rxia7fyydSYaFIV0RUAuR5ewp+vsrM+r4e
        8R2mPxNB3hfRPoHx7CTHQRcksQtgeoRHojLWWzMd9MtlnczleZX+
X-Google-Smtp-Source: AGHT+IGBZtcTHAbj2wdNf4qoa5a7G0j9kuSPQXq5UsQCdvUM1YHbdFfUVoz/McPrY9b6Ui2wjsez126KRpqKrjfM69M=
X-Received: by 2002:a25:5845:0:b0:d9a:e129:92a1 with SMTP id
 m66-20020a255845000000b00d9ae12992a1mr5443261ybb.54.1700761159972; Thu, 23
 Nov 2023 09:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev> <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev> <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
 <121163c9-0d56-47ad-a12e-e67390fef2b4@linux.dev> <CAA8EJpowjhX=LL-9cnQL4pfCei63zNkCGW5wGOeeFxcnFpNCVA@mail.gmail.com>
 <00ba2245-0e48-4b21-bcd4-29dfb728e408@linux.dev> <CAA8EJpoiehS2wS3ri_DggzxeEfLY4yK7X6c+bCFKvkwSce6r+A@mail.gmail.com>
 <77c3ad35-24e4-4bf4-87a1-f48e13a6b838@linux.dev>
In-Reply-To: <77c3ad35-24e4-4bf4-87a1-f48e13a6b838@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Nov 2023 19:39:08 +0200
Message-ID: <CAA8EJpoAOeb_zGBwGPN0ymo=ZJk3_jFamhF3Qede-9uBvXpK0g@mail.gmail.com>
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

On Thu, 23 Nov 2023 at 19:04, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2023/11/23 16:08, Dmitry Baryshkov wrote:
> >>> The host can not specify the
> >>> DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, it will cause a warning here. And
> >>> it can not omit the flag (as otherwise the first bridge will create a
> >>> connector, without consulting the second bridge).
> >> The semantics of DRM_BRIDGE_ATTACH_NO_CONNECTOR flagare implement-defined,
> > No, they are not. Semantics are pretty simple: do not create the
> > drm_connector instance. Pass the flag to the next bridge in the chain.
> >
> >> for our case, I could just ignore it if their
> >> don't have a signal(DT or ACPI) tell me that there are multiple bridges
> >> in the chain. This depend on community's attitude.
> > Ignoring a flag is a bad idea.
>
>
> Can you also read the code in the bridge/lontium-lt8912.c please?
> when flags == 0 is true, the lt8912 driver will just create
> a drm_connector instance in the drm bridge drivers. The behavior
> is similar with this patch in the perspective of spirit.
>
> And the most important thing is that no matter what the flag the upstream
> port is passed, lt8912 just always pass the DRM_BRIDGE_ATTACH_NO_CONNECTOR
> flags to the next bridge. Does this count as a kind of ignore? or
>
> This is to say that both the lt8912 and the tfp410 drm bridge drivers are
> allowing create a drm_connector manually in drm bridge drivers. They didn't
> being asked to move the drm_connector related code to display controller
> driver. I don't know why I can't follow this way?

This is called 'legacy'.

>
> Do you really read the code before do comments or I failed to understand something?


-- 
With best wishes
Dmitry
