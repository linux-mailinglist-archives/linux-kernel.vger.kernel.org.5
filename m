Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5750B7FD7DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjK2NWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjK2NWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:22:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDAD83
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:22:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54b545ec229so4694536a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1701264156; x=1701868956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/VP3ii8qzlwzBFXOUvCIlM2ChKhNv0Z2flI0ZUJ06go=;
        b=tZ0e393k6tGqc7Kfw0mVPdohIqElSw69RXqLpX8IwWMLhdVRjk2+lGHUCDMdL35iVT
         VhEnZDDghUrA+ZSFTlGpI2xPDFPoqJVBUMnn6rt3QxyFWKUfq/Ujde27tTe9cffSaB85
         +yI1Sd5CdrOnyAReBZHQSjBrONOvCVCKMAtRKXSYfXEABpvbHhQfKFwMuYJfperB/X4a
         tLlggBN/LzPTJL/794bzw/k7dWpS12qPEUK2A+EQ2miVEPon3fjBQbiCgsYSWqcyMr4k
         uJSqvYRewfMuGhaPteitj06eDuPPfEoqwH2G9jBk7FwvrUac+HfMFVGdv1PMyeJkcE7+
         7OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701264156; x=1701868956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VP3ii8qzlwzBFXOUvCIlM2ChKhNv0Z2flI0ZUJ06go=;
        b=CZIjW1s0UnptsV3JfVEZEmMgkv20DcdJudONFr3FVQaVtBLvHvdZy+0TagTL3F3rtR
         myJvHtqKcWa2CgTKEEM+n57mX+3r33eChdG8JbBwttMfg1pvLeT2mmOYPpKs9roDa/Vw
         A2RyY2DW6H09PEOauIUQJ1TPQdJnHsKPvlON9SLaItb3rbpaoPsUXFtFdhTONlXU42PH
         QzdgxFWhb8JK6necNpK6NlYzOL+Fo2DK0jasvIGo39PgviRHgtOUkLrEiiLZJ7TdJdG0
         8/xGbsVMLUpCrSv6VlLzDEpHs69u8kmnIDJydshdNv9d8TKdLRcN8aFxFjvB4W3td8v/
         HULg==
X-Gm-Message-State: AOJu0YwKZ4NncjUn/1Iec1ycaekTymakP7gkbuxtqWnaG4cv6MtJRMk7
        q9FdjeoviM1rzInxuMFmbtmeE9ouxFmQ2RjeFWWS/A==
X-Google-Smtp-Source: AGHT+IESfQEmd7uikH5eYlpIkIXnzdfz7yOnSZr9KANdmLWdgeBrFVefxKHw37NvqQrsvZJsay74wE6WyTTIfjyDBNw=
X-Received: by 2002:a17:906:3f88:b0:a02:a2cc:66b8 with SMTP id
 b8-20020a1709063f8800b00a02a2cc66b8mr11788067ejj.14.1701264156218; Wed, 29
 Nov 2023 05:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20231129121841.253223-1-vignesh.raman@collabora.com> <20231129121841.253223-7-vignesh.raman@collabora.com>
In-Reply-To: <20231129121841.253223-7-vignesh.raman@collabora.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 29 Nov 2023 13:22:24 +0000
Message-ID: <CAPj87rPKywWa8KxTCeJQz4vvgTwhPzL+y4aCX9zxZDkkfrvsoQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] drm: ci: mediatek: Set IGT_FORCE_DRIVER for mt8173
To:     Vignesh Raman <vignesh.raman@collabora.com>
Cc:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        daniels@collabora.com, emma@anholt.net,
        gustavo.padovan@collabora.com, linux-arm-msm@vger.kernel.org,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        david.heidelberg@collabora.com, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On Wed, 29 Nov 2023 at 12:19, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Expected driver for mt8173 is "mediatek" and for mt8183
> it is "panfrost". Set IGT_FORCE_DRIVER to 'mediatek' as
> the expected driver for mt8173.

Actually, for mt8183 it's both. And for mt8173 it will probably be
mediatek+pvr pretty soon. Each of these SoCs (like most Arm devices)
have a separate display controller and GPU, with different drivers for
each. They'll run different tests with different xfails. So we should
figure out a way to support igt running for both devices on the one
system.

Cheers,
Daniel
