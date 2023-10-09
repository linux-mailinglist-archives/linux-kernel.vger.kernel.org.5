Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1821D7BD419
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345378AbjJIHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbjJIHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:12:46 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73BBAC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:12:43 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-49d39f07066so1308498e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 00:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696835563; x=1697440363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcLBkttrnLyWRPQcmdLUsIhnk5fgBx0T1gVgylMyObc=;
        b=0L2XxtY72fZ9t0ivQdB48xalEXRi8tzZQB4h2VVaXkaCn2V7OpVzA+Jzw7PSesRZXj
         XjlNikuHh78hefd9Y33mqrdbq/rMRMui54cSBWfrsBGj/Q0a61bQJU9BQa4tQNbTWoir
         2IATn7Z9S2rzHz7BBjsN3uEeWSXiFTAO7z48vM5gaYa8rZi2yWq8SZZXrlZGvHiiH6ob
         fEgRq5SubFO/NJKrC0ILwg+vJlAnIRwC+Un8rr8mMblvUHhbYlj0Sm6tQNCy78OrQ2yY
         9QT1Vu4VHmkqERxqHC0vAZCZg6/mRPJMQECZoRDX+bticDcLl3ZgpNa0tOIPrkpvKY6u
         PaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696835563; x=1697440363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcLBkttrnLyWRPQcmdLUsIhnk5fgBx0T1gVgylMyObc=;
        b=uLpmlz2kfNU58TouwactAvUzyuMU5dQYzah+AEtZYp9fKoOI+lz8sClDUHLjpg29pq
         9Mn1LaP5jmP57g4yhhUyNAW+4VX7e9FL8k6zqVLwL52EDsg0hJiZcaBhyGqlshtpemWx
         44N7eRZBJSMK/ij3wbpVT8KnhZDcsofDKuYSjzil0QIJa2cBPv57vwaZa/0wXsFwAWzF
         d2EcBmtww6/VATvavArvd3Gu5vjuFX8z+MCB+IPPGSb/3kE+4Bdy9EmG1pPkf8w79hNs
         v6O5T8cZhc/mfkkYa8xXkTIR7YPXoIbLFW6FnepbxhQI5o071zz104AnTEbDZ/XwQbI1
         aWqg==
X-Gm-Message-State: AOJu0Yw1E0fUSDIpvgyE1/KNiEpB89zth7diqEj8s+W092xc5mn/2b2T
        VeaOjm5O9QWTpcc/NQKXVRDgfTgkhkVmJFf10XWl3g==
X-Google-Smtp-Source: AGHT+IFwDwzm+lRsT8bOFKIAm/GhR+1llhPbmAbOCazbvOSuFiL5J72lfZwBACd3hGJsn9Q29a1UTTr3OVDkXyj/GAc=
X-Received: by 2002:a05:6122:222a:b0:493:5420:f20c with SMTP id
 bb42-20020a056122222a00b004935420f20cmr13749354vkb.10.1696835562966; Mon, 09
 Oct 2023 00:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org> <20231006-descriptors-asoc-mediatek-v1-2-07fe79f337f5@linaro.org>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-2-07fe79f337f5@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Oct 2023 09:12:32 +0200
Message-ID: <CAMRc=MeVp63fPXWs=JDL-GYg7iYzL-m=3nkrp6J+nyM_pL2=tg@mail.gmail.com>
Subject: Re: [PATCH 2/8] ASoC: mediatek: mt2701-cs42448: Convert to GPIO descriptors
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 3:46=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> The driver is pretty straight-forward to convert to use GPIO
> descriptors, however a separate patch is needed to accept
> the DT GPIO resources ending with "-gpio1" and "-gpio2"
> instead of the standard "-gpio" or "-gpios" name convention.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
