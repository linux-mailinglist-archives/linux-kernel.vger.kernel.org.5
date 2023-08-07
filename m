Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF500772B39
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHGQkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjHGQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:40:05 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA5319A2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:40:00 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bbaa549bcbso3589237fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691426400; x=1692031200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GF3Lr/DH212oz0lCEyjQCKmiNVG2MspdIl8pBQl0rIA=;
        b=WdYrITzlxccrOy5/lKmsTwjw3lg46asLWh8CjyG+F/RL43pyNd3yUtGdXWX6p/y4P/
         V2TLwuyx3WiBUpp4/spOQuhSYS7Ey1/kfmu8HxwAbIzpOUXvjAu/ujL9QM7WkHA5/VU/
         Uv8tB4zvTsVy0MxjVXrcow1RG4Z7eJVtQOFu8hyOQZbyn98aWnk6IAk9EdCpchMTEtg4
         YrSD5uIs/dWyH3W+ba9+kbSDpZorSxRR1rjAJvkrOkta15LdkQiy7D6Q2XXLvaoe9tAH
         BMqO5AxkCCBKwCiBwYOjgDKgyyHc6qRI2BTDmxNuyNAlB4zx9K1kU9a5d1G4I9HLlcMW
         mYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426400; x=1692031200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF3Lr/DH212oz0lCEyjQCKmiNVG2MspdIl8pBQl0rIA=;
        b=SCglM46R8tIYG5NAb6QI6SI4dMH7L1v9LlvtkY7IxjkNPDK7dWS7oWJ39nTqdQqmKM
         y4lhmoQOht1Zek9u0Bt/w5Y4maov6hKqn+QdUyFinZQ9IbUPzqf4ZL71XlGl9y6Ig0j/
         3ycHfOPO7YDcL8ci6T2evWtNAGx0MXMPahMP95vMxxN5agSujFlyVnWKLG+iC9TH2K3d
         9Eb6mCQ0CfpfiEeIZJSqzYsxEh/XfafJUkjBKGEDTobwCrHRkZ1qmqQ2WwWNjS6AuW6r
         bZ9XL6GnGxgh4ORhquhRukVhi636pv19n99sk9OwB7hED/DXRF7ulcNGPt17BNEj2MNV
         fiMg==
X-Gm-Message-State: AOJu0YzyMHiUuNBhd453NKrW1lT5MCB2yBtToJ9VL6yueJtHraM9B2OO
        4aZlv4OBAqpQI4hjUvJY8g9c8ushcNcI5eoD2KA=
X-Google-Smtp-Source: AGHT+IGCQqS+Pvn6RsP9VGxE9d5ecNUtpobC74sSBj7QNadpN0c4h6dDSEZYWBMzhGuvsohcoMM5WplDRFHYBclcvx0=
X-Received: by 2002:a05:6871:204:b0:1b3:f370:79c7 with SMTP id
 t4-20020a056871020400b001b3f37079c7mr12163060oad.37.1691426399683; Mon, 07
 Aug 2023 09:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230801090237.7011-1-sunran001@208suo.com>
In-Reply-To: <20230801090237.7011-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:39:48 -0400
Message-ID: <CADnq5_OBvgLKvcfCgdOCHWxFB=uA=1Oaf_Fpu+YZKwNvj1FcVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Clean up errors in pptable_v1_0.h
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
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

On Tue, Aug 1, 2023 at 5:02=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> index b0ac4d121adc..7a31cfa5e7fb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
> @@ -419,8 +419,7 @@ typedef struct _ATOM_Fiji_PowerTune_Table {
>         USHORT usReserved;
>  } ATOM_Fiji_PowerTune_Table;
>
> -typedef struct _ATOM_Polaris_PowerTune_Table
> -{
> +typedef struct _ATOM_Polaris_PowerTune_Table {
>      UCHAR  ucRevId;
>      USHORT usTDP;
>      USHORT usConfigurableTDP;
> --
> 2.17.1
>
