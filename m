Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9388789179
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHYWM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjHYWMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:12:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A026AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:12:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ff933f9ca8so2128364e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693001542; x=1693606342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiWB9v97HWraryvHTLxgc+CEYJjrfdQeQMgf9JwDwYo=;
        b=o1abNyuclFO15A/6/McYne+QOGIvn+XTYDY6EIdUqTY7Uv72XDgslSh4NIBvaPwrky
         VefCSgOlljqAYmvca33GNDESWnr8NjwUtptaxUI7HSp5I4f7L+qS8ObI9awr+xXDNFJq
         OT17UeWtSdtNMigelavMdMQ7qsP1EFFGutJfQN0MNi1kmp9XMF0h1UrQsw0nNm3O3rIH
         ZYGWjlbDXdumPqFAfFSlsc9NRMs0hEAIOp2L1WihyC94uiDt44DsNRdtNrdZm3UakEo7
         5UxbuKT6LL/v1kdfL2NOj0u8INTOOqDCuKNZ97EbAnejSfI2lXJlEgSOHvehrCVynpgk
         BPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001542; x=1693606342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiWB9v97HWraryvHTLxgc+CEYJjrfdQeQMgf9JwDwYo=;
        b=ODXZYKy2JYcon5Agm+eHsDFRY+Aya7rIjUuXv68oY9ABmji8vHfvl5FfIwoYldBxya
         g6Tgqzr/UKBFOD7tBywUMBK2NWu8vMRTr2ybEyTtVbiekE79WFL9FNmqkMt5VAhYk9qa
         0SFCUjRdLjWDseyGrV0CAdTgo9eqPB/T6px+Wc68qEEa0Nzb9Hxd6H5WRRwzLGsUGKlf
         mETqzRNkJZjPlbMYMMrxkj4FeV3SnKeQwfU3a1K8W4z9G6BTu1TkDUDFrmnTR2teKO/V
         BZGSSMFMJrGsHmuunscieURbj09o9KfTWkbwXiFifNRf+2WHGBaXk5MO9QRTK/iWjPWJ
         jd5Q==
X-Gm-Message-State: AOJu0YwjvpsAshozPtB0/RgmxeTfCIjKHjqAJrOZNYVrh2HdxGRw80AQ
        EJKHg7uA7DR62hyoQpEFTerxh+4l/6ndAIMLK5AFtQ==
X-Google-Smtp-Source: AGHT+IEh37w7GhGca8NdEFatO+jxjw3lxK9RNgllGYwXHOM5rh3j9u6rw1eIsrbFwWS9IZn0hsI2lv3Fj8ImeK3KR9k=
X-Received: by 2002:a19:ca44:0:b0:500:90d1:90a6 with SMTP id
 h4-20020a19ca44000000b0050090d190a6mr7433122lfj.63.1693001541950; Fri, 25 Aug
 2023 15:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-v1-1-b81d5639e7a3@google.com>
In-Reply-To: <20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-v1-1-b81d5639e7a3@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 25 Aug 2023 15:12:10 -0700
Message-ID: <CAFhGd8p-8a4SGQgcN=3LGA4Ju2tyxnkBf9yUTQSBpsXcZ12_7Q@mail.gmail.com>
Subject: Re: [PATCH] habanalabs/goya: refactor deprecated strncpy
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch as well as two other related patches were combined into a
single patch [1]

 Thu, Aug 24, 2023 at 1:49=E2=80=AFPM Justin Stitt <justinstitt@google.com>=
 wrote:
>
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]=
.
>
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
>
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-n=
ul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/accel/habanalabs/goya/goya.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/habanalabs/goya/goya.c b/drivers/accel/habanal=
abs/goya/goya.c
> index 7c685e6075f6..d0ac7065f3d7 100644
> --- a/drivers/accel/habanalabs/goya/goya.c
> +++ b/drivers/accel/habanalabs/goya/goya.c
> @@ -466,7 +466,7 @@ int goya_set_fixed_properties(struct hl_device *hdev)
>         prop->pcie_dbi_base_address =3D mmPCIE_DBI_BASE;
>         prop->pcie_aux_dbi_reg_addr =3D CFG_BASE + mmPCIE_AUX_DBI;
>
> -       strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
> +       strscpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
>                 CARD_NAME_MAX_LEN);
>
>         prop->max_pending_cs =3D GOYA_MAX_PENDING_CS;
> @@ -5122,7 +5122,7 @@ int goya_cpucp_info_get(struct hl_device *hdev)
>         }
>
>         if (!strlen(prop->cpucp_info.card_name))
> -               strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAM=
E,
> +               strscpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAM=
E,
>                                 CARD_NAME_MAX_LEN);
>
>         return 0;
>
> ---
> base-commit: f9604036a3fb6149badf346994b46b03f9292db7
> change-id: 20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-2a05a220=
2c78
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

[1]: https://lore.kernel.org/r/20230825-strncpy-habanalabs-combined-v1-1-da=
a05a89b7e3@google.com
