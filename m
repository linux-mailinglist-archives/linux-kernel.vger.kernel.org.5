Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1668277E236
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbjHPNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbjHPNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:09:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B0226B9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:09:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40c72caec5cso309251cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692191373; x=1692796173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUwAHT07txR6ptb2hVJ8LK/09TxpB4H9kqcF6ppAaE8=;
        b=rPyfPbkAbWrh3YW4SmnhFMhYUcoYPn3I4h0zOMx2gdulY2aKXYGgVPciDIcr853yAi
         k7u9TgJLelbpmZvDUxCAwQmNm9Cv5X7wgempRnF2n13nY0rjznc7kPsz/HodJS7JkyrL
         5Ee/5U4EKh7eMQ1k8NllsSpf7ltlnEH3/26L2oRM3GZc9t5M3T5d7DgT9K+YKg4Ooa8x
         dasaBw6a/UmHmldv/d5s6lSz6Di90yGxhZ7WRD6TKyQejObx8imUNdd00tGkvgBORBqS
         FC7rsD5mZJR0ATkHjNvyXOWfpJ0UsoVEWw6NgUFKZQ6MZkmKm4NAW9pc4pdRuWdKnGYW
         z37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692191373; x=1692796173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUwAHT07txR6ptb2hVJ8LK/09TxpB4H9kqcF6ppAaE8=;
        b=hf/xYKENMcMHitbc1W75SlaTTw/3UbE1d076gxxWOw3oSC2pu3PkxnIwstRna0hCfd
         sPze4ZKMPmLWLWDm4VZc/ArN51PA1amzC7JgmRt1IaqjLFwsLw0XDGX+H12gxANdv1YJ
         ubE492uEQGMFMjvL7hC6C7F9EEyxmkmsf8qO6oxC5LJ/BBRmUn8Nfzu4PxXSrdERb+tB
         ySCe2lGNSaSdv6BzeYWBaDloUZwMS5AMrrKv57dkeqI++XwPCSmK4M7oUUIdu1mL+Njs
         Z5nONEVUeY9uLdQQ7FQU4HeFU5P0c5yUXlHQdGr5Coze+VP0wmHIdUrkzYkNEVZmPtSX
         HogA==
X-Gm-Message-State: AOJu0YzbclOgT3xRkjm57aN3SoTRWWpLy8d95zhMdqO5dWBp3A5N8a/P
        /T8M9cAesJSY0gBfa11ejlK6sWXpCSyKw8nNFdwg7w==
X-Google-Smtp-Source: AGHT+IFsy1XvDp2NA9YFpnEew7M+xp5eAZzId2tM8tvK4Tz07m1370FGZFk9MXz5S+0gKJ3YKaM49mKWC9Yi2k6w/1o=
X-Received: by 2002:a05:622a:100f:b0:403:affb:3c03 with SMTP id
 d15-20020a05622a100f00b00403affb3c03mr284520qte.10.1692191373497; Wed, 16 Aug
 2023 06:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230816104125.712370-1-sadolfsson@google.com>
In-Reply-To: <20230816104125.712370-1-sadolfsson@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 16 Aug 2023 06:09:20 -0700
Message-ID: <CABXOdTe53fzK2eZ586cMh93tv+Bt=1+0Gg=-P8yBfWpoxrjf9w@mail.gmail.com>
Subject: Re: [PATCH] media: cros-ec-cec: Add Constitution to the match table
To:     Stefan Adolfsson <sadolfsson@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Reka Norman <rekanorman@chromium.org>,
        linux-media@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 16, 2023 at 3:42=E2=80=AFAM Stefan Adolfsson
<sadolfsson@chromium.org> wrote:
>
> From: Stefan Adolfsson <sadolfsson@chromium.org>
>
> Constitution has two HDMI ports which support CEC:
>     Port B is EC port 0
>     Port A is EC port 1
>
> This patch depends on "media: cros-ec-cec: Add Dibbi to the match
> table".
>
> Signed-off-by: Stefan Adolfsson <sadolfsson@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/m=
edia/cec/platform/cros-ec/cros-ec-cec.c
> index 29f9a464857b..3c27349ce1d6 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -313,6 +313,8 @@ static const struct cec_dmi_match cec_dmi_match_table=
[] =3D {
>         { "Google", "Lisbon", "0000:00:02.0", { "Port B" } },
>         /* Google Dibbi */
>         { "Google", "Dibbi", "0000:00:02.0", { "Port D", "Port B" } },
> +       /* Google Constitution */
> +       { "Google", "Constitution", "0000:00:02.0", { "Port B", "Port A" =
} },
>  };
>
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
> --
> 2.41.0.694.ge786442a9b-goog
>
