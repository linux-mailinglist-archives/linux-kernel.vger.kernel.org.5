Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7644780A761
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjLHP3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjLHP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:29:03 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB351732;
        Fri,  8 Dec 2023 07:29:10 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9d0d0e083so1500981a34.2;
        Fri, 08 Dec 2023 07:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049350; x=1702654150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2To1yV3sBlyUIXX2dRxgZLUw8e5tQCWslY62gbS5zc=;
        b=uuSt5PVHIIv9XjMoynJbPC5N/Wdn+bYHEfO8B64NSRmjeMuZDSgSnt6t5K8TQl7jFM
         AgQpiJ8PYP+/0swiiDyLJ4BM63nOQm9YYp93gDLIjhGtuVGkpEWPYG2RlhV9kcx1w9H6
         as15tMOsfsScZv0kXRQHIqyB4l1RJo3i0f4JhWzglDv8Fj9pUPKDqN1JT7iQe/jYY/sk
         tV50T6LQNNgBR6Rz+jHDGBI4q6mL8I4Vegquhj5Wre+xsnGBi23t1zdtRhtPnysUWXjj
         geTycgN/DqaXJtQsVJZh4+0zK2m7+kF2WaHhVLTK9bnZ+xU2RhkD/k59WI5AaJKdF8mZ
         3M5A==
X-Gm-Message-State: AOJu0Yxi2uHxTEUTS/0LeTk+wgFUc9j7QB74SbIcl254z0nznV5qO+Lu
        g/ZAvBsgm5ZH5Qg7PvoxMg==
X-Google-Smtp-Source: AGHT+IHyKKjladIMN927leaaMAXflSx/bGCGRS95D1nFq54QptT3Wo+QdUF8jxOs29jg+9zj+WWbgg==
X-Received: by 2002:a05:6870:b69d:b0:1fb:75a:6d47 with SMTP id cy29-20020a056870b69d00b001fb075a6d47mr273275oab.110.1702049349884;
        Fri, 08 Dec 2023 07:29:09 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lv18-20020a056871439200b001fb24a0c23csm434995oab.35.2023.12.08.07.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:29:09 -0800 (PST)
Received: (nullmailer pid 1380806 invoked by uid 1000);
        Fri, 08 Dec 2023 15:29:08 -0000
Date:   Fri, 8 Dec 2023 09:29:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pmdomain: rockchip: Add missing powerdomains for
 RK3128
Message-ID: <20231208152908.GA1378274-robh@kernel.org>
References: <20231202125144.66052-1-knaerzche@gmail.com>
 <20231202125144.66052-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202125144.66052-2-knaerzche@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 01:51:40PM +0100, Alex Bee wrote:
> For RK3128 the powerdomains PD_PERI, PD_SYS and PD_CRYPTO are currently
> missing.
> Add them.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c   | 13 ++++++++-----
>  include/dt-bindings/power/rk3128-power.h |  3 +++

Bindings (and DT headers are bindings) should be separate patch.

Rob
