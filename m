Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14B0772D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjHGRdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjHGRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:33:03 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA76DE74
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:33:02 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56d0d7300d9so3327357eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691429582; x=1692034382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slNXbmbSSnIwi3BpDNUJS0+fwnT8XgMHLlRFXSdcVVg=;
        b=kyVwv0vLuRg9EY/dgRbk8n4WXHmYQ04yaQgTCB4v/M8ramvvAGtL5yG4GTx+bD1jdi
         QRV1GH2b8yQBt9IyCYkOq4N7iliFzJ0CE63vl8XW5EeMg8JKd2qFcsIQ+ieqZno4m+vo
         HBDtOaHPkne2kT8uWWNvteB95MSi8jWiGUIRV342qKJY7QCi6zr3xDe7szTj97WEroRw
         oC+B4ENHKteZxs6RCmbgSb4geAbSo0rWAPOtkVs8sSd5ZqBsNeLy09q+pfN+R5H7oA9F
         1vKML60T1L69es1bKX/xOqe+Mqa/P9MCL0gwQ7wEulST6P/Jum9zvlLfgrfbC/VAnj+4
         vcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691429582; x=1692034382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slNXbmbSSnIwi3BpDNUJS0+fwnT8XgMHLlRFXSdcVVg=;
        b=GmuKbLFlWYqNrBvqdHOzDjmtHK+XXdelm/IccatCEpGqlSn6aY2CCKhq3lyh0J/b7W
         kvWhu/eDUD4IjKJFWQL52o6BCo9VQ2iOtAWiLOrdR/4qSlQSMKGgK06UtRsdg9aLpfWm
         FEc0Is2qrgpGR2LQ6ZwqNdOQTxB3fzTak3on12w4pw0KVhcA66esmbkHnqyXsEQeMsi+
         46WEsyI4EHKku2RpN88NsFCUTJlRxji7wwMbroFP9vu1N4g8YLy2cTIhnFtoOvOm0fZB
         MPJuwd7kbsdiZQN5zXE6AxU8l2o2tKuWiG/BquRezPtvJN7d+gFD7kuNEoEMMblERXFR
         FTkQ==
X-Gm-Message-State: AOJu0Yw0OO4wUyVn36820Mvuj0DIRdYF6Ge324fr9vI6Ik+gx+7NpFDA
        ncGQ0u6nzfZsDX5iM+OsyblbZZKlcI9UXLsu9Fs=
X-Google-Smtp-Source: AGHT+IFkOeQkxPjn4cm9wX404EzPeGgHSyPEfKx3Z41F0ikI5Dv6r/HQGP8wlX8dojWOe3D9aspuzyqqbwmJVZRu/fk=
X-Received: by 2002:a4a:7658:0:b0:560:ac0f:b87c with SMTP id
 w24-20020a4a7658000000b00560ac0fb87cmr9846723ooe.8.1691429579607; Mon, 07 Aug
 2023 10:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230802075014.13861-1-sunran001@208suo.com>
In-Reply-To: <20230802075014.13861-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:32:48 -0400
Message-ID: <CADnq5_NiDj8fO05_67E8ccRwZg2j-fekwbi54EiTc+haQSUvBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clean up errors in tonga_ih.c
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

On Wed, Aug 2, 2023 at 3:50=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/tonga_ih.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/=
amdgpu/tonga_ih.c
> index b08905d1c00f..917707bba7f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -493,8 +493,7 @@ static void tonga_ih_set_interrupt_funcs(struct amdgp=
u_device *adev)
>         adev->irq.ih_funcs =3D &tonga_ih_funcs;
>  }
>
> -const struct amdgpu_ip_block_version tonga_ih_ip_block =3D
> -{
> +const struct amdgpu_ip_block_version tonga_ih_ip_block =3D {
>         .type =3D AMD_IP_BLOCK_TYPE_IH,
>         .major =3D 3,
>         .minor =3D 0,
> --
> 2.17.1
>
