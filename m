Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94117CCF57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbjJQVde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJQVdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:33:33 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258DF1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:33:30 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d122f6294so40237476d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697578410; x=1698183210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6zl+wSE/fz+ducMX6hYKgOCMYM8auRGMjne06mswZ8=;
        b=UIEZEHvL7hzh3w/bekKJLvI64FtN5/nnD2ZhZtfRKTzuzHqiEWa9YAkSW0o/t/9U9M
         WCqa4v4dGnZi+ZwpkRsDWGh/fiSQrsQDcqvSBBnJg6WAQOKuKW8td7XTAZxMKylUDijF
         qTlPo6ePleq8Ugdmctwax16vi4hy3djcIjKmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578410; x=1698183210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6zl+wSE/fz+ducMX6hYKgOCMYM8auRGMjne06mswZ8=;
        b=YPlBnFOLdzquSrb00BdMFYLY8zzO8nStCgTbe+rcNbx3NZItkTFhRFnA3IzDL2oTaD
         M2gO+0H1DBiufVRiS20l9+iCs3bFGXBQouyR0xrhEnx5ESRLaLlcjB58FQTrpfwReRQ2
         dSCbNM16jJydUUpgQ5KWPemaMOm7M0cqK4niwbIQmxeehm+dhUHKJLIq8EFrNemEsYqG
         dmJ51CjpUgjC2Lcn3yRLGwEMtYrHxV2joAW9PcGDcSh5O89YmkoknxKAOPBART1Aly8I
         Lx4yqWHc5MezIBl6iPEXQKeIx9TTA62SXj9iRb/RGiUmglhNg01k0hT+W0hdbeuI8zHI
         ERIQ==
X-Gm-Message-State: AOJu0Yxv7K51G4zclx8BnZstf4Hc0B/fw+ivh2+IsoGmJvvHwXkRI2YJ
        4+9FqiZzWqB7q4P/nA3Q5Ah1FqD4uIFtEEQg/KK5fw==
X-Google-Smtp-Source: AGHT+IH8Ju4SHUrvi7DxIyMG1q3LZA6VMP0Ksgj6FYRzSOeuH/AGPBdUwfFnt4kIpk837MMVangLq1QoeOR7S2QqfFA=
X-Received: by 2002:a05:6214:2a47:b0:66d:6994:daed with SMTP id
 jf7-20020a0562142a4700b0066d6994daedmr4772001qvb.35.1697578409829; Tue, 17
 Oct 2023 14:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231016225617.3182108-2-rdbabiera@google.com>
In-Reply-To: <20231016225617.3182108-2-rdbabiera@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 17 Oct 2023 14:33:18 -0700
Message-ID: <CACeCKac2kknw2s7orH1tu4RsiCr5+WYy1VQ483ok_zuzC2N9zQ@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: altmodes/displayport: verify compatible
 source/sink role combination
To:     RD Babiera <rdbabiera@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi RD,

On Mon, Oct 16, 2023 at 3:56=E2=80=AFPM RD Babiera <rdbabiera@google.com> w=
rote:
>
> DisplayPort Alt Mode CTS test 10.3.8 states that both sides of the
> connection shall be compatible with one another such that the connection
> is not Source to Source or Sink to Sink.
>
> The DisplayPort driver currently checks for a compatible pin configuratio=
n
> that resolves into a source and sink combination. The CTS test is designe=
d
> to send a Discover Modes message that has a compatible pin configuration
> but advertises the same port capability as the device; the current check
> fails this.
>
> Verify that the port and port partner resolve into a valid source and sin=
k
> combination before checking for a compatible pin configuration.
>
> Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mo=
de")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>
> ---
>  drivers/usb/typec/altmodes/displayport.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec=
/altmodes/displayport.c
> index 718da02036d8..3b35a6b8cb72 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -575,9 +575,18 @@ int dp_altmode_probe(struct typec_altmode *alt)
>         struct fwnode_handle *fwnode;
>         struct dp_altmode *dp;
>         int ret;
> +       int port_cap, partner_cap;

VDOs are 32-bit, so u32 is probably better here.

>
>         /* FIXME: Port can only be DFP_U. */
>
> +       /* Make sure that the port and partner can resolve into source an=
d sink */
> +       port_cap =3D DP_CAP_CAPABILITY(port->vdo);
> +       partner_cap =3D DP_CAP_CAPABILITY(alt->vdo);
> +       if (!((port_cap & DP_CAP_DFP_D) && (partner_cap & DP_CAP_UFP_D)) =
&&

nit: bitwise '&' has a higher precedence than logical '&&', so the
innermost parentheses shouldn't be necessary:

           if (!(port_cap & DP_CAP_DFP_D && partner_cap & DP_CAP_UFP_D) &&
               !(port_cap & DP_CAP_UFP_D && partner_cap & DP_CAP_DFP_D))
                   return -ENODEV;
                ...

OTOH, perhaps you should just introduce a macro that performs this
bitwise operation for even better
readability. Something like

#define DP_CAP_IS_DFP_D(_cap_)        (!!(DP_CAP_CAPABILITY(_cap_) &
DP_CAP_DFP_D))

(not sure if "!!" is tolerated in kernel style, but you get the gist...)


> +           !((port_cap & DP_CAP_UFP_D) && (partner_cap & DP_CAP_DFP_D)))=
 {
> +               return -ENODEV;

Single line if statements can drop curly braces [1]

Best regards,

-Prashant

[1] https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing=
-braces-and-spaces
