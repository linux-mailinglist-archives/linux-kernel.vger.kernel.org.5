Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3A0772C1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjHGRKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjHGRK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:10:26 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE786199E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:10:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bcccbd9365so3681839a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428208; x=1692033008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVnv4Pt11q/ZKsoCJD2SAX36HKBbik8lLwU9hV+RPkI=;
        b=oywPoegN13kmjmfc1hbMrkM6c8UhdKOpLvWPnCis7HDZzdByg9orxAspo3B5FX2T19
         u6BUE3G9LTpdj2mR9LBaeVDgspHapuIVLCmE7M3LDyK4BnLBIkcb0PFRgvTxVIRw0Q3S
         Km0qyzEdOdFE7W34yBmgk/xVOuI0lL3TJ+KBhwCDtlqr9SsnqTEXgzE27SFXnQQ2qFTT
         Pbrl6kibusLcdiP2M/LC0k4Kg6t+kcXMYiOTUv4+CYYhQuxNtK4U7AGT3Cw0ek7cqM0b
         /UdopVVPDvkBXNqdhL0NH4e3PU44lN2R+jAytKTEvJXXjlp+5F2yIe3DfQBgPuHzP3VA
         xZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428208; x=1692033008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVnv4Pt11q/ZKsoCJD2SAX36HKBbik8lLwU9hV+RPkI=;
        b=iqrBKcq38joXIl5b6YaxQ5suZPWlZjA+Fim2hMJphEoXF1z+ITkeD7TiT4jHmpV9p7
         q0zq/Nuo+fXOyiFQUU863T7Pg07nsyRRKKnsmu7PtpVYjgUf5+yo1i7n83gdz7IhEDl6
         YL5wWP4vaSXqz9eKTamtqEEHxmZvhfjIgQ+++G5KaUI8gVxG/S+3nTstjQBfPqinGUF8
         vUSPn8SGCsfeAZF7orGj2N0qwhU8fssvnK8KfYTRXuz3cQsm04x/aMFRo2nU64714P3e
         ED/h+hAJABLlbpIOR/bcLdmooQX3OodtxrMvAq3nEjaArvUfX4v1XPjvbwY+Z6yvYANp
         5kNw==
X-Gm-Message-State: AOJu0Yw4Tyt7edsKQ5wqbzNEdGDMvjFDFvGo/RUrVZJnozfaHEpyfMPW
        e0YUl3CcLI2muiaEHoaXiZOcdv39ov+kwDLC8F8=
X-Google-Smtp-Source: AGHT+IEGee/UoJizGgd8V5/QtJKZOQUAowC18ZU+CvbPZSqKpklX8z5WMafDRzxaLFJf/Vt/vMup6KocjkmPjs2aFjY=
X-Received: by 2002:a05:6870:a916:b0:1bf:7cdc:df0 with SMTP id
 eq22-20020a056870a91600b001bf7cdc0df0mr11644328oab.35.1691428208036; Mon, 07
 Aug 2023 10:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230802025443.10458-1-sunran001@208suo.com>
In-Reply-To: <20230802025443.10458-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:09:57 -0400
Message-ID: <CADnq5_MedA1DMxAqAjg5EOYo65cguZdF0etHV=Q0NHahcchw0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up errors in dce112_hw_sequencer.c
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

On Tue, Aug 1, 2023 at 10:54=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: space required before the open brace '{'
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c =
b/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
> index 690caaaff019..0ef9ebb3c1e2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
> @@ -127,7 +127,7 @@ static bool dce112_enable_display_power_gating(
>         else
>                 cntl =3D ASIC_PIPE_DISABLE;
>
> -       if (power_gating !=3D PIPE_GATING_CONTROL_INIT || controller_id =
=3D=3D 0){
> +       if (power_gating !=3D PIPE_GATING_CONTROL_INIT || controller_id =
=3D=3D 0) {
>
>                 bp_result =3D dcb->funcs->enable_disp_power_gating(
>                                                 dcb, controller_id + 1, c=
ntl);
> --
> 2.17.1
>
