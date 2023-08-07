Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3A772C22
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjHGRLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjHGRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:11:07 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B61A3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:11:06 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-56cc3453e31so3109432eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428266; x=1692033066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m16fJSelMd4HZcAn1Zx8fvrGuQ+wWIhwtRhDA7myOIk=;
        b=MSYUk2F8V927UzOSmS+4fdZ/330PbUEqDcZWJVNyRRIp9V6BPcn2m0AmB74eqD1M8x
         z0/qzM7eRkxnPVmq3Ch2bhLig/AFhcec/LAVgsAPiyZqPrGIqqVmw+eASt47JkTcht2h
         eMF1YRIkHsN5x5ZGhA39FqaAPr4HCsuZupYPB+yc8N84NnQAy4qJaTbf4MD8fUUdA05K
         FB6fC383Ff6S4GIedCwd25vetvo1EhDYEJFnIqE96l3b0TFbgwKjBz28O69wQ9jJNxZd
         dKRgbnpStZBSuJWUmSdmIUe9EoR57gILkXm9RN/jJtuem6Jw99xiLkSXGmlyXBXA5B0/
         7NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428266; x=1692033066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m16fJSelMd4HZcAn1Zx8fvrGuQ+wWIhwtRhDA7myOIk=;
        b=IytS61SCgnsRPyUVf2xMwLfAy547g/tFESPGMdH1bgOn2QWoill1CzVcnCXUX9blqt
         1OXoOXcrWCRHMXY/KceBQTLrTTGI1sNkmVDBfSxkJObl2qwGTZiXGiHJjYddyrVxTuXA
         PUeBem/3GyW2Ia7GHNbWkdZMcYcbsOyg8DxbuOwkiYdpBsGPCNPeoA2ykvPnRVYJS+Mr
         NDMWVDo5rjRq6vE3O+xua4eQJ5LWGSwdoWmVzw74Zd3jSBInntSHY/r+aBDjYwKPf4Ot
         bu1FDk8JFxez6kLaEHINjGumFJsPQxKgP3JrJR8s27EgZiZINN6VkKty64tG4QLt0jrX
         mAqQ==
X-Gm-Message-State: AOJu0YxxfJocnKt3m18HLnMcUvxOPrlseX4y96l1fXyaoWeHvL8o9r5T
        FLGOMBOy7/DdtRomRDKI5bpLEocUNbFIVDjGaUk=
X-Google-Smtp-Source: AGHT+IE0ZWcy0BkKo64iUNra5AF7PwpsSxZjrCHZVah+Pvj31QkLtbNxbEUX8K0sOKFs700TnsTyDte7eqb6HgPsrbs=
X-Received: by 2002:a4a:3818:0:b0:567:154:25dc with SMTP id
 c24-20020a4a3818000000b00567015425dcmr9049143ooa.7.1691428266104; Mon, 07 Aug
 2023 10:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230802025814.10569-1-sunran001@208suo.com>
In-Reply-To: <20230802025814.10569-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:10:55 -0400
Message-ID: <CADnq5_O0O47XB0pbHFTX=afGcfa1LpD1rVVL4a+xbf1w8emEmA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dcn315_smu.c
To:     Ran Sun <sunran001@208suo.com>
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 1, 2023 at 10:58=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
> ERROR: code indent should use tabs where possible
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  .../display/dc/clk_mgr/dcn315/dcn315_smu.c    | 26 +++++++++----------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b=
/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
> index 925d6e13620e..3e0da873cf4c 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
> @@ -33,28 +33,26 @@
>  #define MAX_INSTANCE                                        6
>  #define MAX_SEGMENT                                         6
>
> -struct IP_BASE_INSTANCE
> -{
> +struct IP_BASE_INSTANCE {
>      unsigned int segment[MAX_SEGMENT];
>  };
>
> -struct IP_BASE
> -{
> +struct IP_BASE {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
>  };
>
>  static const struct IP_BASE MP0_BASE =3D { { { { 0x00016000, 0x00DC0000,=
 0x00E00000, 0x00E40000, 0x0243FC00, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } } } };
>  static const struct IP_BASE NBIO_BASE =3D { { { { 0x00000000, 0x00000014=
, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } },
> -                                        { { 0, 0, 0, 0, 0, 0 } } } };
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } },
> +                                       { { 0, 0, 0, 0, 0, 0 } } } };
>
>  #define regBIF_BX_PF2_RSMU_INDEX                                        =
                                0x0000
>  #define regBIF_BX_PF2_RSMU_INDEX_BASE_IDX                               =
                                1
> --
> 2.17.1
>
