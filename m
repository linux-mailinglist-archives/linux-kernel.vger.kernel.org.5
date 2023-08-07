Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3D772BFC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjHGRED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHGREB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:04:01 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCDD10D4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:04:00 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1bfc2b68090so1690823fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427840; x=1692032640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXFBy7712uE3kfDTRNRBt1+/C4b4AQWJWe2+dMjh1ks=;
        b=K0XjOCrnf/nJH0pqMzpC+/VboRlwZCR952ZMtzBtMMnxLv66byrTwmDwfZ+ooDh8ZW
         QreEURBnxzIrySgkkgkwN261N4My88y1GrRhH8nt1YdEN83Iqj0SufCII9zIhiDpE64s
         d8sLSmIJpulOdgXOev86k/z2JKfiYwcU5Nadf5D6uQLrE6yITUhdqmX5KfOkaHRC/8Gt
         DR0r+KHNTXfibhP4SGPmOZTbE22OmCBYq51hUFCD2ffhu8eVVyr3+uRjYI90nlA3qxXK
         wzu5/ZyD28a9O6sfAOh/sB/Nibz6Smh2nCa/HbVR6Wjh597j9XxC1cDSUQxqlvP3zpvB
         PEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427840; x=1692032640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXFBy7712uE3kfDTRNRBt1+/C4b4AQWJWe2+dMjh1ks=;
        b=W4vWMMW8HTJqId3iAL9DE8WXLZ6N+UxeoXSB9gS7F+s1bZQNvd2z56JG/nnq0AfE5E
         8Sj9Cc3e6X/UgwUIWWwcX45ULwmJzaXjPAyPpllxFbM1VuAJ23LpuYEPjZbe4W+I0PGM
         5yNRc8LdFIe47qs3DxjBTqJQVCfWlwTJ1uSSEbUWBblDCjh3h9taOn9Lb8AVCKXWq4jK
         Fi7anQgWudBkNMhuuMSc15EL4WQruP3RT4Y1e2pF3YrEFnsz/6tSURikrfahE/dpqLcu
         feJWph8FMyIgzHUw7kqLVuK4lF8PIyNeV8G+Y+/ThLOMM1A3JpcCO4EZ5lzFbcaDlC+t
         PdZA==
X-Gm-Message-State: AOJu0Yzz0cfnbciFNCGaW8fibd2WHTFjDcRjSJhdOLAGTYlv7lzztm6K
        PjX/IXI3sdrieGAhriMJ0B12PSN1EjmDTmyQa5rHltt0
X-Google-Smtp-Source: AGHT+IHlkC7Pt3rCEKpR2f6h9hE2+W9zb5ra8F/7JHeXbFW/+rtKjGLMF4AcecgpLGAMJWPvoqJ0HH71kilAGM+D2Ok=
X-Received: by 2002:a05:6870:702b:b0:1b4:60b3:98bc with SMTP id
 u43-20020a056870702b00b001b460b398bcmr12150216oae.2.1691427840112; Mon, 07
 Aug 2023 10:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230802021504.9439-1-sunran001@208suo.com>
In-Reply-To: <20230802021504.9439-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:03:49 -0400
Message-ID: <CADnq5_MMA479HCGqitBKGvd4hn8pquiA1b_=veZzJWpZPSrPEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in r600_dpm.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 1, 2023 at 10:15=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h b/drivers/gpu/d=
rm/amd/pm/legacy-dpm/r600_dpm.h
> index 055321f61ca7..3e7caa715533 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
> @@ -117,8 +117,7 @@ enum r600_display_watermark {
>         R600_DISPLAY_WATERMARK_HIGH =3D 1,
>  };
>
> -enum r600_display_gap
> -{
> +enum r600_display_gap {
>      R600_PM_DISPLAY_GAP_VBLANK_OR_WM =3D 0,
>      R600_PM_DISPLAY_GAP_VBLANK       =3D 1,
>      R600_PM_DISPLAY_GAP_WATERMARK    =3D 2,
> --
> 2.17.1
>
