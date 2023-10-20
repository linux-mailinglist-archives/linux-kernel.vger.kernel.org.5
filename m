Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8E7D17EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjJTVTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjJTVTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:19:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CBBD65
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:19:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27cfb8442f9so935520a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697836775; x=1698441575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9YjEIQWy6daCcnZfKUCk0eX4Io5MUDbFHgVHcjxrWk=;
        b=PNV9vn/5a1DnVJxIeVzJPor2YecmMN7Z6mahOizsTJMXGt53YBAAlm5Svq+TYrZ5Br
         e2DZf8hlN6sc/r0LlG3SKezQaXEjAa9bKNXNCRy89gu6NFYXfdyKdjTvSeUmGTCBw8dp
         I4Y52BbLEhjD/scGjrTx89vzpQvUDnL5IWXWwapTUAI3pEd6yIcrPXOmayWxbloPrmUW
         c7RNvl0nA6Jeax49e5aa1RtnGqUxXw3TVGiaTOHf1bJPNRKXNt1rQmGdpExzwcmxvCzm
         FdVFAgv7Iny7MS+aHBBuNmUeeo/ozz+KrQF+Fe/CmcTMO2T4GhTQR2lPlqgY9UvvqRoV
         fP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836775; x=1698441575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9YjEIQWy6daCcnZfKUCk0eX4Io5MUDbFHgVHcjxrWk=;
        b=b05Fv88tD585HO06lWHFpDt6MgJ+wtREVBDbQH7m+HQSHy65casEcMWAxHuHoV3jES
         PUJ69XWfeAMRjeuZDpZCGhhKJYqYc1KkLmxxmpbiAl7JTmTYTpuWIqRRM0PRf89pmiuF
         fYqk1OTfUSlXlUneaxjrgAY5YQo0WrpRoO/r9SqzwaJOhFCSCJi97e4BxCEcUK1Gq1nZ
         MnLk+uo1wKOxULf/TIh3/64NCAExvoa+jo4PhzzUHh/t6taiQhgvSdDxZ4CDaLE/R6FA
         8D5JjIOrYyX4z2uRHh8xgbI5kxoK+9CClCwOnvmdNQ0lFrzW4bgFAHfszhW1UMZCLoZe
         n5gQ==
X-Gm-Message-State: AOJu0YxE8R890+lyeguAEU/1a/nyfx4VIojczQ4TNy4whhIEJFSxvtgi
        wJv7ghmVKFd+7hG0oTfgRkEUFHAoZafQJgGMxkJg7Q==
X-Google-Smtp-Source: AGHT+IFAnBcyEirWRbOHDgQa0BipdQ3XDegYyx70W6pwGiyHgf1ILQcSADmA0O0n6k0IJ1PfErLWMZ7dzz68cVep4C8=
X-Received: by 2002:a17:90b:1e53:b0:271:7cd6:165d with SMTP id
 pi19-20020a17090b1e5300b002717cd6165dmr2893154pjb.26.1697836774929; Fri, 20
 Oct 2023 14:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231020145953.v1.1.Iaf5702dc3f8af0fd2f81a22ba2da1a5e15b3604c@changeid>
In-Reply-To: <20231020145953.v1.1.Iaf5702dc3f8af0fd2f81a22ba2da1a5e15b3604c@changeid>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Fri, 20 Oct 2023 14:19:23 -0700
Message-ID: <CAOReqxhrhzWh-aO5kt-7yqcfX9CbHW-WBgBAqQ9FqeUj-h1o=A@mail.gmail.com>
Subject: Re: [PATCH v1] ALSA: SOF: sof-pci-dev: Fix community key quirk detection
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        stable@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org
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

Curtis Malainey | Chrome OS Audio Senior Software Engineer |
cujomalainey@google.com | Sound Open Firmware Lead


On Fri, Oct 20, 2023 at 2:00=E2=80=AFPM Mark Hasemeyer <markhas@chromium.or=
g> wrote:
>
> Some Chromebooks do not populate the product family DMI value resulting
> in firmware load failures.
>
> Add another quirk detection entry that looks for "Google" in the BIOS
> version. Theoretically, PRODUCT_FAMILY could be replaced with
> BIOS_VERSION, but it is left as a quirk to be conservative.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

Acked-by: Curtis Malainey <cujomalainey@chromium.org>

> ---
>
>  sound/soc/sof/sof-pci-dev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
> index 1d706490588e..64b326e3ef85 100644
> --- a/sound/soc/sof/sof-pci-dev.c
> +++ b/sound/soc/sof/sof-pci-dev.c
> @@ -145,6 +145,13 @@ static const struct dmi_system_id community_key_plat=
forms[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
>                 }
>         },
> +       {
> +               .ident =3D "Google firmware",
> +               .callback =3D chromebook_use_community_key,
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BIOS_VERSION, "Google"),
> +               }
> +       },
>         {},
>  };
>
> --
> 2.42.0.655.g421f12c284-goog
>
