Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D14805FAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjLEUpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjLEUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:45:20 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DC91A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:45:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1b54b58769so12724166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 12:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701809124; x=1702413924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y+jY+0Fv8pe8Zjgn3mhV8qrJZdO/zPS1zfBF2bsh/g=;
        b=bKc+PZ8SDwdp+OoZ7kLS3GZIX+yyKvUD1TzBRLwRPrMHvQjTJgpy6U+WifxH/l9xzN
         y095dyRdDX3iyMyEDUygcK/A9g4+Sxlg5y5HWxvgWFW9dS/jptUkTUNgc1ee421pa+3y
         0o6BlEfB2+vzJo+EqPG8xVi2GZRLlYDtTGPiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701809124; x=1702413924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Y+jY+0Fv8pe8Zjgn3mhV8qrJZdO/zPS1zfBF2bsh/g=;
        b=Boa0s2XxfXaTkuBYHv/XWNOSDJuCASD6V36cLEdcaV/xyEkoSVAQgxfOY3pilhZPTg
         b1wjg6sxwwnTjmPsBBghVXNJg6cJCIyxSlIgBzV0hxH/OXT982zgpJKwpZOJV7LO7thP
         sFGq9JV9D2JT7pt53fxN+vIFZ4Uaxu61aoQCwwenTV3e4zV3xncHMoxORvrdeEz78ivH
         1F6r7JVvxsFE4xup7hmnzHhJAPQRjD9E1oK/BeeS/A/lC24X3p2Rn9q1AdwnnUPkkdJO
         D6zWm2gyFo+tsXrqz3XoaY6YdK299opv3DwcLkD4rdSeTMqXH80jxhK5wQnJDIkw1wRD
         RDYg==
X-Gm-Message-State: AOJu0Yy38vxpRo8lzptHADeBnveNgXybwqk0WNQhte6iZMBK+srHnRNb
        m6n8T29Jgz3KHi8+HT4A5zAC31foohzHKvBnlu5yCOjR
X-Google-Smtp-Source: AGHT+IEt3CQLGK5IrVgbo3FMPoKgiMdDOFmF7SAXdiTm25EIgAk4bMEFu5xYrajsZC2sROkPJvohbA==
X-Received: by 2002:a17:906:a451:b0:a02:609a:5c6c with SMTP id cb17-20020a170906a45100b00a02609a5c6cmr1042066ejb.44.1701809124166;
        Tue, 05 Dec 2023 12:45:24 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id qc14-20020a170906d8ae00b009a9fbeb15f2sm7197650ejb.62.2023.12.05.12.45.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 12:45:23 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 12:45:23 -0800 (PST)
X-Received: by 2002:a05:600c:4e8d:b0:40a:483f:f828 with SMTP id
 f13-20020a05600c4e8d00b0040a483ff828mr15612wmq.4.1701809123285; Tue, 05 Dec
 2023 12:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20230921192749.1542462-1-dianders@chromium.org>
 <20230921122641.RFT.v2.4.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid>
 <2f7fbd1b606b4d08b8c8c6eefff5898c8faa697c.camel@redhat.com> <CAD=FV=XkeicQ3Gq4yaFtXsF7yM_7pXbpNKB56DbOwBmsEsrF_g@mail.gmail.com>
In-Reply-To: <CAD=FV=XkeicQ3Gq4yaFtXsF7yM_7pXbpNKB56DbOwBmsEsrF_g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Dec 2023 12:45:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XDhkstFX3e2qPGeYGkFWefRMH24BjNgRujBX5PQyE6MA@mail.gmail.com>
Message-ID: <CAD=FV=XDhkstFX3e2qPGeYGkFWefRMH24BjNgRujBX5PQyE6MA@mail.gmail.com>
Subject: Re: [RFT PATCH v2 04/12] drm/nouveau: Call drm_atomic_helper_shutdown()
 or equiv at shutdown time
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        bskeggs@redhat.com, daniel@ffwll.ch, kherbst@redhat.com,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
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

On Fri, Nov 17, 2023 at 3:00=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Sep 22, 2023 at 2:06=E2=80=AFPM Lyude Paul <lyude@redhat.com> wro=
te:
> >
> > actually very glad to see this because I think I've seen one bug in the=
 wild
> > as a result of things not getting shut down :)
> >
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > Tested-by: Lyude Paul <lyude@redhat.com>
>
> Any idea of where / how this patch should land. Would you expect me to
> land it through drm-misc, or would you expect it to go through someone
> else's tree?

Still hoping to find a way to land this patch, since it's been
reviewed and tested. Would anyone object if I landed it via drm-misc?

-Doug
