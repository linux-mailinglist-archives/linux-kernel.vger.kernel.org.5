Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F50772CA6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjHGRUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjHGRUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:20:44 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B518E66
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:20:21 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1bfafe8a425so2303910fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428816; x=1692033616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tjmnvzk6F5Cc3BXb1Q9hk2iZgMj75iv+C6EvtJVbyY=;
        b=OhhYefLvsjRTZ0L12AmrUT5XV4rc7JF5/9w+yBEJ4aEMupPPdlv2xZJNoxvP4hq/a1
         E3EthlVG+MD6+El1SJrSc3HyAk+o1BmSnjx571YrpVVzjDf2Yj7bWntSu3adDKUohvBQ
         QEL/k5w/HgpCoG++LBg4YAm2mcTU4RXb8CS39SNizclX6Rt02fuovrhfBJXBbI92mefi
         agt5dAy+vWonE7c3WS83P8iDw4aTk7yjKMWl/TXhawka1KL7+O8DfWpMxy87KAih+E98
         BK3F+P0nF9OEkAROhQzo0lSZzfqXOHy9S6L35AbWq4ofCjsa0kEjwJF1w+W1T6lL/AI4
         402A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428816; x=1692033616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tjmnvzk6F5Cc3BXb1Q9hk2iZgMj75iv+C6EvtJVbyY=;
        b=X0GtolxXnSiJWUSpX11YerlaxKluxRmCgHtCWszwKq4lhDVXnu0rWF23uzjkK4PC4a
         +Dfoa1sIHWqhK9uAy+Hsu3L39ZgSeh4+NPNAIqmILMfDjnB1iW+oXY1tEnqb6bGT4n/v
         S5rj6L7O0RwDDrnmUQYAEh1sQiu2U8yQnZzcm5/rBn8SVKzyMcfEMhHJJHrR3yftojIB
         sn5IlHZyBzA6YvtPCNfMY/B0a7rCcMKXJoWSLRzxg0lWROlm7rLCnX16ORA/PhP1xytS
         ekmJ7Kvx7Z8UHHeV/hJ9maouodry+CCRtvdh0/+/3prRyDwRVqQyaj1GTPLsBdY2IyeN
         GYXQ==
X-Gm-Message-State: AOJu0Yzy+og+YfDwe3794xitggWiQ8z7SLnj18hUwFdNexC8KOwR3RWN
        DxVM2vX+oiJIiCO85zShheBtXJNjcIg3pp4SR3k8jnYt
X-Google-Smtp-Source: AGHT+IGv+vt5Hld//6AeQPcv0rUDVYpQJnIe/R19tAp0YTd7yrv7i9JfsLOqtgPJBg4KhaiINvLEdQ8QUp9gOYDO/2Y=
X-Received: by 2002:a05:6870:fba9:b0:1bf:b863:b6d with SMTP id
 kv41-20020a056870fba900b001bfb8630b6dmr9826435oab.1.1691428816327; Mon, 07
 Aug 2023 10:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230802065127.12183-1-sunran001@208suo.com>
In-Reply-To: <20230802065127.12183-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:20:05 -0400
Message-ID: <CADnq5_PQr8Op2tqs4s78Qg+niP9=VMxxPQt9Ya8BJL-czWCshQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/atomfirmware: Clean up errors in amdgpu_atomfirmware.c
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

On Wed, Aug 2, 2023 at 2:51=E2=80=AFAM Ran Sun <sunran001@208suo.com> wrote=
:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: spaces required around that '>=3D' (ctx:WxV)
> ERROR: spaces required around that '!=3D' (ctx:WxV)
> ERROR: code indent should use tabs where possible
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 0b7f4c4d58e5..835980e94b9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -58,7 +58,7 @@ uint32_t amdgpu_atomfirmware_query_firmware_capability(=
struct amdgpu_device *ade
>         if (amdgpu_atom_parse_data_header(adev->mode_info.atom_context,
>                                 index, &size, &frev, &crev, &data_offset)=
) {
>                 /* support firmware_info 3.1 + */
> -               if ((frev =3D=3D 3 && crev >=3D1) || (frev > 3)) {
> +               if ((frev =3D=3D 3 && crev >=3D 1) || (frev > 3)) {
>                         firmware_info =3D (union firmware_info *)
>                                 (mode_info->atom_context->bios + data_off=
set);
>                         fw_cap =3D le32_to_cpu(firmware_info->v31.firmwar=
e_capability);
> @@ -597,7 +597,7 @@ bool amdgpu_atomfirmware_ras_rom_addr(struct amdgpu_d=
evice *adev,
>                                           index, &size, &frev, &crev,
>                                           &data_offset)) {
>                 /* support firmware_info 3.4 + */
> -               if ((frev =3D=3D 3 && crev >=3D4) || (frev > 3)) {
> +               if ((frev =3D=3D 3 && crev >=3D 4) || (frev > 3)) {
>                         firmware_info =3D (union firmware_info *)
>                                 (mode_info->atom_context->bios + data_off=
set);
>                         /* The ras_rom_i2c_slave_addr should ideally
> @@ -850,7 +850,7 @@ int amdgpu_atomfirmware_get_fw_reserved_fb_size(struc=
t amdgpu_device *adev)
>
>         firmware_info =3D (union firmware_info *)(ctx->bios + data_offset=
);
>
> -       if (frev !=3D3)
> +       if (frev !=3D 3)
>                 return -EINVAL;
>
>         switch (crev) {
> @@ -909,7 +909,7 @@ int amdgpu_atomfirmware_asic_init(struct amdgpu_devic=
e *adev, bool fb_reset)
>         }
>
>         index =3D get_index_into_master_table(atom_master_list_of_command=
_functions_v2_1,
> -                                            asic_init);
> +                                       asic_init);
>         if (amdgpu_atom_parse_cmd_header(mode_info->atom_context, index, =
&frev, &crev)) {
>                 if (frev =3D=3D 2 && crev >=3D 1) {
>                         memset(&asic_init_ps_v2_1, 0, sizeof(asic_init_ps=
_v2_1));
> --
> 2.17.1
>
