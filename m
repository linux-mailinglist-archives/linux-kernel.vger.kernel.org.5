Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B227EE749
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjKPTQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjKPTQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:16:31 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0BD50;
        Thu, 16 Nov 2023 11:16:28 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6cd0963c61cso660315a34.0;
        Thu, 16 Nov 2023 11:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700162188; x=1700766988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJfsU8TyNZy07krkN4D/GXW5S5/EGPw3AYjVhWjd3Xk=;
        b=cbcQ23mnsmgmBfHIg/HzEe/1BakeFhzJa6vBERnzZrWgK56KXBpO27e5gQONZQjdpa
         WwdDEhJlphxF8QEBHAKtXqf6ysLDw7KEc35ml71C0gY5DmBr7utuFaD/AeUsCrCBjARE
         ywAdTWHI4ArtDLzpUraYfAxkN+PBt1LDFe4DLPnb9on7jwrqxjOhlfNp1jXsIeIXd9sc
         4Czyxi39hVN8nFMcSs4Uh5GpOs4h7Jz7VsLFTe0Z+ULE1En1XSSBtnCIrrQW27hSjTSP
         LgLJevh1FbwNFR0Cy5O5EMFqWz5BJxcXtuyihZyptc/XW74blfNabzSjv41Bl1hNKskb
         JRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162188; x=1700766988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJfsU8TyNZy07krkN4D/GXW5S5/EGPw3AYjVhWjd3Xk=;
        b=qYqt6y5p8/pCZOA6wahft6nDYMbfc2hHZPP/vZprrdrSsFoW0L9un/xDpyZ8ct9qsz
         WnucnzsR3u154nd7X7b/46bWOlYzbaUCofmkhDrauUiKr+Ex7CJ+ZpekbieDRK6EEqkv
         bIiYWIHtoL7UfF05Z1eOPSOF2lp4YkzHIUNEiMMTWs1xKS4e9hQlQvB6zdSLaZbfY2ln
         lmghlZPSD+GXE3A8Xl320mT2Zq2nn4FflEfqaZO14eCztgeSYSxnU7c7XHRumRrORNAL
         NN9N58ERi3TcTrogPMh47b8Ji3SxvywSi+Sm9wk5IecZsUtmH5iIzO58HNJZQXtIXfXX
         s1TQ==
X-Gm-Message-State: AOJu0YzypTODjW14TGV6lsTebO32TeaHCBTR38WiX3h6050eqPXfybIM
        UBvCIJyySQSykYfTZY0QATKD6HHM2V4QGarSKLU=
X-Google-Smtp-Source: AGHT+IH1vNrw5v/An0taWdCw0btGDRa71oZV0TEwIktj88J12G++fhmCiIcWXFXTRS4R2QvxslI1LRmieXxGxzE+l3c=
X-Received: by 2002:a05:6870:5494:b0:1ea:ce71:dd13 with SMTP id
 f20-20020a056870549400b001eace71dd13mr18093837oan.28.1700162187978; Thu, 16
 Nov 2023 11:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20231113112344.719-1-hkallweit1@gmail.com> <20231113112344.719-8-hkallweit1@gmail.com>
In-Reply-To: <20231113112344.719-8-hkallweit1@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 16 Nov 2023 14:16:17 -0500
Message-ID: <CADnq5_OQ+hX5_vtKKRndSGZf1Gv8pW9E52ij7LdGb_eeQCgSQg@mail.gmail.com>
Subject: Re: [PATCH 07/20] drivers/gpu/drm: remove I2C_CLASS_DDC support
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-i2c@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Nov 13, 2023 at 6:24=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> After removal of the legacy EEPROM driver and I2C_CLASS_DDC support in
> olpc_dcon there's no i2c client driver left supporting I2C_CLASS_DDC.
> Class-based device auto-detection is a legacy mechanism and shouldn't
> be used in new code. So we can remove this class completely now.
>
> Preferably this series should be applied via the i2c tree.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Technically two separate drivers, if you feel like splitting it.  Either wa=
y,
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Feel free to take this via the i2c tree if you prefer.

Alex

>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c |    1 -
>  drivers/gpu/drm/radeon/radeon_i2c.c     |    1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_i2c.c
> index 82608df43..d79cb13e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> @@ -175,7 +175,6 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_=
device *dev,
>
>         i2c->rec =3D *rec;
>         i2c->adapter.owner =3D THIS_MODULE;
> -       i2c->adapter.class =3D I2C_CLASS_DDC;
>         i2c->adapter.dev.parent =3D dev->dev;
>         i2c->dev =3D dev;
>         i2c_set_adapdata(&i2c->adapter, i2c);
> diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon=
/radeon_i2c.c
> index 314d066e6..3d174390a 100644
> --- a/drivers/gpu/drm/radeon/radeon_i2c.c
> +++ b/drivers/gpu/drm/radeon/radeon_i2c.c
> @@ -918,7 +918,6 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm_=
device *dev,
>
>         i2c->rec =3D *rec;
>         i2c->adapter.owner =3D THIS_MODULE;
> -       i2c->adapter.class =3D I2C_CLASS_DDC;
>         i2c->adapter.dev.parent =3D dev->dev;
>         i2c->dev =3D dev;
>         i2c_set_adapdata(&i2c->adapter, i2c);
>
