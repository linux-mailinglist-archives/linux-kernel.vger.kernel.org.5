Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3669792D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbjIESPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240822AbjIESOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:14:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892D91FDD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:09:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso14404525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693937250; x=1694542050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G3WP3YwMsu76Cet1Bxz2RfkxbGHzyW+58lMB5e2zd8=;
        b=srsk37omRd/ATJR/s2PZIUBtVeeTOKnIkNUawDXiHHlh7JZiAV3dnWccV5TN6DXm6F
         2vE965s3AEaacEh0EPv+tfx2ZKfglkMB7juW0CUdVZjcEOCCN7VYJ6BoUPxIbyp3DO+3
         7MYOtLD0GFdHAP934LMPIVAdCtaQBuh+uJEC3n5i2b0mOhk5yE4acHqUHrd//swNL2w/
         NkwQYxmc33QYdGvnpqVZo/D7uA1QBH6867apMrLpZ/vmxCw9IPFxfVumY1Frai8zj74I
         4Xvj819c7ZtH1jPz7UAkWfDvDX/LjHdMH2RffiXhQ5TIOL6ybtrzH/vvsajgLeWp2gBg
         8uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937250; x=1694542050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+G3WP3YwMsu76Cet1Bxz2RfkxbGHzyW+58lMB5e2zd8=;
        b=MEe3+ant194bVvZc3Mbu7+fmZiF0WN0m8xScePeFf3r3tF7+frAy6PlcD9tJu3rq5L
         XTv/y8XXzlI16/UpyrBX6pao9bdmuaAf7tBORDwnQTGfrEM013Tiz5hP91WZFYigZqam
         ElJQ3n6GarZklkUAABOI6bwbok9KK1EYVRmZfDJ2VuW9jjTtYp9W1W7aGXoltKOsw3CJ
         My+p4K3Bxx9w43twCP8NoMoxbfd/ERp698DpPurFSMukPbgsg0UW/HbeZQAbm7N8X984
         qrQqedKOdCypt0sJlKkvdtUYkXVp4wKMlzTDJAzagx3Koc41EwislwsEpR2RRQNKymsh
         8fXw==
X-Gm-Message-State: AOJu0Yzr//S+luZMTklPyYNHXbkBGpyDAziZ+KfITqlEibEsWRLq8PTh
        b289VFwUU878Goasdo3zrEV+d71qmDvY8LWCnhXtqFXT
X-Google-Smtp-Source: AGHT+IHecd024T1nCg53+h5Nw6+5wkM5lcLiVKJmYeAT3ciRMXuJIv9C2BSCL0YfARRctZoAH9w9tTNF7KG382+qQ+I=
X-Received: by 2002:a05:6870:472a:b0:1be:f720:bb7b with SMTP id
 b42-20020a056870472a00b001bef720bb7bmr17836496oaq.16.1693935277843; Tue, 05
 Sep 2023 10:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230901005226.42307-1-yang.lee@linux.alibaba.com> <20230901005226.42307-3-yang.lee@linux.alibaba.com>
In-Reply-To: <20230901005226.42307-3-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Sep 2023 13:34:26 -0400
Message-ID: <CADnq5_Mgw7YvCUjiGnmOe-SbryZwq7pwNaR5kySOh=M0BMY3KA@mail.gmail.com>
Subject: Re: [PATCH -next 3/4] drm/amd/display: Remove duplicated include in dcn35_hwseq.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        harry.wentland@amd.com, christian.koenig@amd.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, Aug 31, 2023 at 8:52=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c: clk_mgr.h is includ=
ed more than once.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
> index cacb557a3014..666e2809d9dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
> @@ -31,7 +31,6 @@
>  #include "clk_mgr.h"
>  #include "reg_helper.h"
>  #include "abm.h"
> -#include "clk_mgr.h"
>  #include "hubp.h"
>  #include "dchubbub.h"
>  #include "timing_generator.h"
> --
> 2.20.1.7.g153144c
>
