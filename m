Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323C7772BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHGQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjHGQ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:59:07 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79361BF3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:58:55 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1bb89ac2013so3521018fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427534; x=1692032334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht9CVkEuLvEDlECGaNyh72t0oWLZ5rOzw2cYOTaZ4Nw=;
        b=o78vcJW1v6fC2ogvCSQihkzCi0gWyJfKNFNbhNKUdJcCxnEx4t4zoOgv0RwDJ4yrz4
         eRMWq/223OgNAF9hRo947ctUpX/jicwQZG+S2q7Hf41lHwAW097PPUghT8ifN1b+xv54
         89mR3hzVQudK3PR8WOwL5yhuXTjWWqNGtd50EcdwFHcCK//no9RlrCI1LA5CNiPQUxxH
         Usa/JjyYQMmnh2cSR1HPlDXwAKHMwMLiMDKQFA8r5QzBOlt5JjhRUiQCd5RUK8rBud5e
         9QPXy+X9ZnZ1NyC7/K6fMJukcdXsg15Jr+lwA1/CJQW4piayEjaXT15FZinkk+k72dB1
         g3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427534; x=1692032334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht9CVkEuLvEDlECGaNyh72t0oWLZ5rOzw2cYOTaZ4Nw=;
        b=EhC+yd9M9Hyxoc2AmogSwlkFmIyx3xJbuls90T+u19Q2piAuzNOamOJKVBSmLHbBbU
         TJDOTltqZ22rAk+j0IprG7MxDHQMZMIpd40G6mfXS/FgpCYXR1L01GdtHjscwzkZnHT9
         ffMgyDT+qNMBZxByeR/ML0Z4h/DHtDe2ikIRPLfv7+AEwmCgsErH9wRbtNPBxc4hJR9l
         RYnLrqcaCfs+I6JFpouT2Abv3Go5tvkMAGla7uyK/S3jA2pQJIExFC3w+r4t0XrG1F5O
         PGfrJmdvKubd7JFlHV1laa/z6q3P2LlerMGCEDi0ulGKt7q11DF4rnnu7C+oajOHnSc1
         L3mA==
X-Gm-Message-State: AOJu0Yx3agfjkIdOV2CYWR2b8tPXV5johpXW28goSe0B0XclUKUD8CwL
        xUPcMgkuxCRwG3GLp8BDMktSYEKy7kAamVyj6cU=
X-Google-Smtp-Source: AGHT+IFBxw8o1+DrrO0YSUvC4JPhgxI+w79qoyh04gIbMIj+7djS9xkWma7q9uw8FF93wgoOKVe3Bz/6LapXjbw1pb8=
X-Received: by 2002:a05:6870:911e:b0:1bb:91fa:7a7b with SMTP id
 o30-20020a056870911e00b001bb91fa7a7bmr11987865oae.58.1691427534680; Mon, 07
 Aug 2023 09:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230802013939.8855-1-sunran001@208suo.com>
In-Reply-To: <20230802013939.8855-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 12:58:43 -0400
Message-ID: <CADnq5_PovdNJb8cefvyAwZtcS=vXZq=K9V42fzJh-eR_39MAHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in hardwaremanager.h
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

On Tue, Aug 1, 2023 at 9:39=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: open brace '{' following struct go on the same line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h b/dri=
vers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> index 01a7d66864f2..f4f9a104d170 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
> @@ -44,8 +44,7 @@ struct phm_fan_speed_info {
>  };
>
>  /* Automatic Power State Throttling */
> -enum PHM_AutoThrottleSource
> -{
> +enum PHM_AutoThrottleSource {
>      PHM_AutoThrottleSource_Thermal,
>      PHM_AutoThrottleSource_External
>  };
> --
> 2.17.1
>
