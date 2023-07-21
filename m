Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87AB75CCC5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjGUP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjGUP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:56:01 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A63A90
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:55:48 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b0719dd966so1611496fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689954947; x=1690559747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl0eTAwzZMqhrxk94X5w3ULTemUp7A7rZI7DezrgeA0=;
        b=kmuAo33/+EOAbBUeF2mJvFIvjHiyGDFqgVkxovydnyB+xcalD42PZFUywMTVcGNa8t
         5u4fevWpKgGGQiezFXTQkf7jwfFC0llQlpMIwAIQKM/BPDfdf20BfJkXkXGfurQ4gqAx
         eiB0ljF43D5RmbBCizRa98SBKdhu0Il0FmJyzjX9EqMDxuvjvX2XddKQzWI6bxZraYXr
         ffvqZ3CyBL2oRQ9Ut+ahEuZgU2oh5GtpQ3/nFq4l1IlFaYgG4+JADAloi03ppBV/aAu3
         V1YZkFNO0TOnqwjf42Y+u61M4BM7CDldqMPhfQvtZn9QTvjfgzGaiPk2EziUpvYK2OWh
         epGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954947; x=1690559747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl0eTAwzZMqhrxk94X5w3ULTemUp7A7rZI7DezrgeA0=;
        b=c/Ts7nP5XIVjLgx6V9Mjtaqy2pTeHv2SMIF8+da5xY5GIKnwXaEx0ZECEzXkZNvP5R
         5/xL7oqwXfM8GLQ5TE/HBKZxH202NcIBDCrgGF3DqDOQacnqxfLRSQfDIotfPkPZKeuO
         s6Sph9B1Mq/Uf6XlwpqaqAGRjasoNP/B4xidBOPldmQ2KnOaSCUJ8hx7LcTbUWWgdc+y
         Nx2HOB+SSfNVgOTziJeww4Y5FSyICONvzlW4iwbCmktTCd0tqJJzDPhtByHu9YNeZZhE
         Co7nPNrbuKgwHSVUUgiGW3e6N8TQuOvYQj9zubKxR+yCWzjBn30qUoJPl0G6ze5TwKV3
         w9lA==
X-Gm-Message-State: ABy/qLbeI/NN+tErAWtlwXoZvHw4SlYYjdlJhrOf0cYYXe4V8keYeFWh
        lbvyfCtv/w0BWYsDQtn/BKAw+lk9YzSto2PJssc=
X-Google-Smtp-Source: APBJJlGM5h3R4hILd/o0pnv8AxWx2WjHbhsf+MePdcnfu8LONxoSi8vOo0ew6VGAU3e747yKPBDUS4PpIeBWd1GtK0c=
X-Received: by 2002:a05:6870:7389:b0:1b0:89e4:e26b with SMTP id
 z9-20020a056870738900b001b089e4e26bmr2799810oam.48.1689954947629; Fri, 21 Jul
 2023 08:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230721012635.4552-1-xujianghui@cdjrlc.com> <f9f0077b8f91d858777e9ad2db972db8@208suo.com>
In-Reply-To: <f9f0077b8f91d858777e9ad2db972db8@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 Jul 2023 11:55:36 -0400
Message-ID: <CADnq5_O6HO70hXuoahwcnN6q0e1YbW8kLZbFT0uV=YeLPZwnmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: open brace '{' following struct go on the same line
To:     sunran001@208suo.com
Cc:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 9:31=E2=80=AFPM <sunran001@208suo.com> wrote:
>
> Fix the checkpatch error as open brace '{' following struct should
> go on the same line.
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>

git am didn't seem to like the patch, but I was able to apply it
cleanly manually with no fuzz.  Not sure what's up, but I've applied
it.

Alex


> ---
>   drivers/gpu/drm/amd/include/yellow_carp_offset.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> index 0fea6a746611..a2c8dca2425e 100644
> --- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> +++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> @@ -7,13 +7,11 @@
>   #define MAX_SEGMENT                                         6
>
>
> -struct IP_BASE_INSTANCE
> -{
> +struct IP_BASE_INSTANCE {
>       unsigned int segment[MAX_SEGMENT];
>   } __maybe_unused;
>
> -struct IP_BASE
> -{
> +struct IP_BASE {
>       struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
>   } __maybe_unused;
