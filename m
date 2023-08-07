Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7251772BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjHGRB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHGRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:01:57 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84A499
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 10:01:56 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56ccdb2c7bbso3124081eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691427716; x=1692032516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sPbbuQHjUxy7oDdnPJjchuEOxUnF5YIqG/ENh0PvEY=;
        b=m2cV+XgsH/1HSspbcpCMx+3r5uswy4jWSGM9tllwSpxcWEdFFaullwKWraLSzrdu9R
         sm4rdsKfU2pLAKdAL7bwbq42jsH+UbIOhoOgKCbEdrM2UWJOA7f3S9w30HyQHw97ikqj
         06xYa2nUfu94x/XMPH2tIHbccwxFHP+pMi6VDOwh6XAIX2kRT25yUWsIvDlX+W4w7mB0
         R+7zI3lEMUIhxvgqmkv2zoNai8VVgAea2KvSmOAqJGzBr0WIz/Ot0oeD1R99quCiyr4F
         7/Ic98LILCIMDYJ3+Ph/DfrjsLELA9yWOX6BJQPJPQCMQQaIu4vtulz+988gXJO6eNpv
         zO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427716; x=1692032516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sPbbuQHjUxy7oDdnPJjchuEOxUnF5YIqG/ENh0PvEY=;
        b=hw8kgcN+oypR7JY2OvdHjXouksXjd9YHN+vEf2gB8M/yiFQbWdHl/QtIikc3Vv/Zrk
         eRRdbojxD0kKMraFylOfEmSseZ9OAwLk+BHluHhKRQ7EgTBimvRDAqyJYl5tW2uDgLiy
         HOVDF1QSs00Maf6SdFUvMiAm+r4ibbqSjJrUrXuO2PihwSbJCPCZh6BsO/uaB5f5RlvB
         PhULJdNY/a3y+5r2bQ8PHUhAaMRzCfpez3JQkV0RPFtgPLryURinD2C56W+56SGIBo0r
         Hn+rTF2RfA+U4VmkjqQw0+vXM63BORrLIwCUGuyjKyWb/hW/IbcZRmp12DzfyarnSeQH
         yyEA==
X-Gm-Message-State: AOJu0Yz9uXaxglWrNuVLEWreiehVgHK+QlEFE8JprUzx0WoaFQPF4mv9
        3mZA79cLjn8GzoPIWzqrxVCzIBKJUn4uWLTdBcY2PF66
X-Google-Smtp-Source: AGHT+IF5QIcbT5+WCBnJ293rhtM/BzGfjCnE0duO5lX0GFVyhqKv0D57sO0c17AF/nWdnhkUJWf7lGgBSQM//mLkwuw=
X-Received: by 2002:a4a:6c5b:0:b0:56c:e928:2889 with SMTP id
 u27-20020a4a6c5b000000b0056ce9282889mr8692494oof.3.1691427715991; Mon, 07 Aug
 2023 10:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230802020312.9233-1-sunran001@208suo.com>
In-Reply-To: <20230802020312.9233-1-sunran001@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 7 Aug 2023 13:01:45 -0400
Message-ID: <CADnq5_MmwoaF-rprRfsAV86kYjkjRDV2BBgWkgXDLFifnnK6Sw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Clean up errors in smu8_smumgr.h
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

Need to be careful with these changes to make sure we aren't changing
the size calculations somewhere.

Alex

On Tue, Aug 1, 2023 at 10:03=E2=80=AFPM Ran Sun <sunran001@208suo.com> wrot=
e:
>
> Fix the following errors reported by checkpatch:
>
> ERROR: Use C99 flexible arrays
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> index c7b61222d258..475ffcf743d2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> @@ -73,7 +73,7 @@ struct smu8_register_index_data_pair {
>
>  struct smu8_ih_meta_data {
>         uint32_t command;
> -       struct smu8_register_index_data_pair register_index_value_pair[1]=
;
> +       struct smu8_register_index_data_pair register_index_value_pair[0]=
;
>  };
>
>  struct smu8_smumgr {
> --
> 2.17.1
>
