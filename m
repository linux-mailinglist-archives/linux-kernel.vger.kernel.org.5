Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0F880192C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441999AbjLBA4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBA4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:56:22 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD37B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:56:28 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9c5d30b32so36333751fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701478585; x=1702083385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on0eUmIVBGIZNw/lnf6eJdI5XZ4MfrBWX3aiU7eK2L8=;
        b=lT3u7KJypv7dwo22jUjW/baMpdvY9YXLA7pvAuudiMd9uMahXREXae/S/LFxp8hapt
         AqH+6KiHXGj6+OUZnRF0ut0pmx0D/oEnEwgwIlXoRUDWI4wYugywDsgUBQL+YXE0aAZu
         pBikCk+Xv4NA9Lq4IJSd/8ita3RCPsF2lDJjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701478585; x=1702083385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=on0eUmIVBGIZNw/lnf6eJdI5XZ4MfrBWX3aiU7eK2L8=;
        b=RUHmwP+MW7Zfcgw+zGw38UBbsGrpG95DidVrRDzJv4wgXedDaOPrCugCPHZ3W2GtVS
         Fdn8x1UjbWhr/ZCFpQQjftjFoQkqE1MUnkiq3vrgRnwhimLKW5HiZ+Xg12aYPjQVnVzo
         VbOudGJJ0PW+RVCjQp1REZDEWxTnZru26h9aWZ9GxtFf7kWpKeMLg0ZMun7QOwPyihNZ
         PQpsNwRD1f+gWGr3k9DDsB15bfX7xOZtUgzSIEDeyeoQoflQJSuO2c9TIhH99Emjed6N
         m7KoBcV7Dh4vLpd83BuxuIApi111tH8SCVDmAfaYsYcIzzpgn/GFop89WpIR8vQCXpxE
         bKqw==
X-Gm-Message-State: AOJu0Yxni607IDmiDW0RCdZ44fMW4f7nrIiwz2z/K+i3MdmvbiBq14Su
        3iw/dC0avwG7ec56l87WPF43svcFgEOqREP8kT+EAnEh
X-Google-Smtp-Source: AGHT+IG7LssEVm6PMgQmeWm4A7ZwwAnMzUdJb0bzATYX42Y9hg2uwox9x7BLQixhu0fTKw6M0RxDow==
X-Received: by 2002:a2e:8755:0:b0:2c9:d862:c674 with SMTP id q21-20020a2e8755000000b002c9d862c674mr1235476ljj.97.1701478585509;
        Fri, 01 Dec 2023 16:56:25 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id t16-20020a50ab50000000b0054c738b6c31sm431852edc.55.2023.12.01.16.56.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 16:56:24 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40b422a274dso28025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 16:56:24 -0800 (PST)
X-Received: by 2002:a1c:6a0c:0:b0:408:3727:92c5 with SMTP id
 f12-20020a1c6a0c000000b00408372792c5mr311701wmc.2.1701478584358; Fri, 01 Dec
 2023 16:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20231128084236.157152-1-wenst@chromium.org> <20231128084236.157152-2-wenst@chromium.org>
In-Reply-To: <20231128084236.157152-2-wenst@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Dec 2023 16:56:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V_v11eZ6+3gUwOvdWGNM9owG7zCK5EiezTY7RJ3eaEMw@mail.gmail.com>
Message-ID: <CAD=FV=V_v11eZ6+3gUwOvdWGNM9owG7zCK5EiezTY7RJ3eaEMw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] of: dynamic: Add of_changeset_update_prop_string
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wolfram Sang <wsa@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 28, 2023 at 12:45=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> @@ -1039,3 +1039,50 @@ int of_changeset_add_prop_u32_array(struct of_chan=
geset *ocs,
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(of_changeset_add_prop_u32_array);
> +
> +static int of_changeset_update_prop_helper(struct of_changeset *ocs,
> +                                          struct device_node *np,
> +                                          const struct property *pp)
> +{
> +       struct property *new_pp;
> +       int ret;
> +
> +       new_pp =3D __of_prop_dup(pp, GFP_KERNEL);
> +       if (!new_pp)
> +               return -ENOMEM;
> +
> +       ret =3D of_changeset_update_property(ocs, np, new_pp);
> +       if (ret) {
> +               kfree(new_pp->name);
> +               kfree(new_pp->value);
> +               kfree(new_pp);

Given that this is the 3rd copy of the freeing logic, does it make
sense to make __of_prop_free() that's documented to free what was
returned by __of_prop_dupe()?
