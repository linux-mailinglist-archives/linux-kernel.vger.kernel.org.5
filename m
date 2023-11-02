Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B883A7DECE3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjKBGcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:32:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE866125
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:32:44 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-da2e786743aso602316276.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698906764; x=1699511564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e463TBeue+MFy7uWY9tlDphfm+xYnPDbO9CJfPVFqIQ=;
        b=V6AXJc71vdC7J3W6qxHUT1jh4HL6zsCxmOVXlJHsZpm/ba6JYbT6g7QoPDJBuhwY/r
         ePznvbv/vcQmxAExNtfSPkae6a6E/KJR0ADE+YyxSAuEoE8QHdvwr0DBtqcyCG39jd03
         tM1Oiu8qUXX5Mz6JXSr0mCK/IcqyjuZHZGskax+unvhOaknDbxKHPxTVA1nqGAxjmy1s
         TyCOEnvnSweBU7YjxklHPvXJZQF9AaNLOZQ36qubvUnIj9i1VQDneyp5Xw70GFrId5gV
         f7j3TtZMDR1Q0BfhR5zY4WfW7XnIk4gqx/Rqxqd7GF7CgYdLQJR3c3DKqt5Ed9fiGWWk
         OGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698906764; x=1699511564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e463TBeue+MFy7uWY9tlDphfm+xYnPDbO9CJfPVFqIQ=;
        b=vTNXcCec/yO3eSNWw7zfHLRwYtbzZdUCJ6qS634kLxGkgTQHz8lq18leDMq5rOK2eL
         R9QJOlEaTwAwVKpNZcj0x75jH9JBzllzdi80Lo2W0ivGspTes6fDcrUOrphY/inV6RWj
         s8IpvchztbjWUbLVEZyFteNEQJ9j/Ly38A0UwlShhd8hjrGaM6ZUBHNDwJSgcl7bWkK2
         aLSMOmx2JrBFjEgZBEN3Z2QmrVWa2ByPlw4uFtBMCCYqy/eJ8Qiaz+xnsPdkdaTvDGZP
         X7A5MWVdq3owJeCEeXgdLK7XiPkF1mQenPMzJErY+ogaiT9SlR7rCXgIdsB6LIJ9exF0
         7SYg==
X-Gm-Message-State: AOJu0YzDPx3mki2rHW30h0nrBL4nYYazS/0lPVvb2cS9L/urZpze3Id5
        HM8Q59LiifxjNS/6dX3hHGuYN4Qk5iJx9zfA+NxZZsZxb6zy1cAt
X-Google-Smtp-Source: AGHT+IEKbxMkN9v/F+SLKkpicMwLxreimmwuAvu7DOVgsoD2WJnvmaGxs9R33WZY2hRSvlC1PaE7wCNfetxGDTKGF3w=
X-Received: by 2002:a25:7648:0:b0:da0:7826:8b98 with SMTP id
 r69-20020a257648000000b00da078268b98mr17766201ybc.55.1698906763884; Wed, 01
 Nov 2023 23:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231102022946.115603-1-penghao@dingdao.com>
In-Reply-To: <20231102022946.115603-1-penghao@dingdao.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Nov 2023 08:32:32 +0200
Message-ID: <CAA8EJprEX72imAwt-975povxgMw-pH7SkrBJKg5pV-PEKMvb1Q@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/drm_framebuffer.c: Use Macro instead of actual number.
To:     Peng Hao <penghao@dingdao.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Thu, 2 Nov 2023 at 04:35, Peng Hao <penghao@dingdao.com> wrote:
>
> Use Macro DRM_FORMAT_MAX_PLANES instead of 4, to improve modifiability.
>
> Signed-off-by: Peng Hao <penghao@dingdao.com>
> ---
>  drivers/gpu/drm/drm_framebuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
