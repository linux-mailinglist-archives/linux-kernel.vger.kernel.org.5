Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B300753380
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjGNHtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjGNHs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:48:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA930DC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:48:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso14754175e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689320935; x=1691912935;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3QpjptWEe+VIO/fnSv61CBVGJqoodwQcJwlBI1/HFzc=;
        b=MQU8BC23rfL4Dy56JGTZFq3hrCDJrWs/CrxfYiAoWhKVmMF/bK3V4DcbQ7RqddmjHM
         FCkutIIwNM0Y2t0pK6V1NY5UTWSertqVCqoESckkVTu0z9RFb+BoQPCxXdvha6bSCViC
         Y0vfyFL6xoyxR7fIp4K2u0S+Z55BjGyvgr8CDLJJgXoc541ro0QZ9w7+wibyL3iv+ykT
         Y6qbylRbPqhUrNFF8ot4oRJlnR/Eiyu7jHgLvalU0uzPwd6mQt88Wis3cTEMawCKcxk7
         xoM/94qFzntqDrfkypbS6xLO/Fzu6HpixHcC7a1M1bGEKdRU5PLthSFLwsTfEdsQNfz5
         yCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689320935; x=1691912935;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QpjptWEe+VIO/fnSv61CBVGJqoodwQcJwlBI1/HFzc=;
        b=Rro6sdiq3dRv9KjRX+PJf3pf8janbi9mflUyeqleq32rpxMEOh49HFWVSuwRK63nNM
         OWYlH5F9j0cB/y53OTf9tnXblcBluADj8pVbkrrFb68QDBhjeuAG5YvTtnshi5BDyCQq
         KxArjC5hRq+7+8bq5N8sY2R/ZzlcHWrlWrfZv+YHR7jdQC2qf/4TaS51EkhzjYw+4AZ4
         rrurd+JuQWYY5dqP8gV0gSnR7rin6acjGX//9CJz7iP+d+mva0M4TAiZiP0nof0RlAlm
         2IkUNrSx3qbChnLiqvFYHT1K7RW+BtJ6Bj8JcVJfhFy2DSARsy15RQxyI2dHhnHCUkR4
         Jbcg==
X-Gm-Message-State: ABy/qLZwI/d3EWXbKdvBXR18QynWto0ZZxLrgIBdjbkWt9UM7U9Cx1p9
        /fkKl+vSNwxTvdiGI6oJd0Q=
X-Google-Smtp-Source: APBJJlHEKf5mwrmYXECNSguayI7QvgnO7Xg9DEangRk0h9LE6wpUnDrG1u3sWpiikIq8dGUA4Usuvw==
X-Received: by 2002:a05:600c:214c:b0:3fb:dbd0:a7ea with SMTP id v12-20020a05600c214c00b003fbdbd0a7eamr3335602wml.37.1689320934886;
        Fri, 14 Jul 2023 00:48:54 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:4ac8:4223:8b53:53c1? (p200300f6ef0587004ac842238b5353c1.dip0.t-ipconnect.de. [2003:f6:ef05:8700:4ac8:4223:8b53:53c1])
        by smtp.gmail.com with ESMTPSA id z16-20020a05600c221000b003fbaa2903f4sm806599wml.19.2023.07.14.00.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:48:54 -0700 (PDT)
Message-ID: <27105a1712cd7be1d3d36702873f5702999566e7.camel@gmail.com>
Subject: Re: [PATCH] drm: adv7511: Fix low refresh rate register for
 ADV7533/5
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bogdan Togorean <bogdan.togorean@analog.com>
Date:   Fri, 14 Jul 2023 09:51:23 +0200
In-Reply-To: <CAOMZO5Br-nMxLSekZL5jLHNpyfOH_KgL1WUgAZ25wu86S2eYwA@mail.gmail.com>
References: <20230516164416.11616-1-alex@shruggie.ro>
         <CAOMZO5Br-nMxLSekZL5jLHNpyfOH_KgL1WUgAZ25wu86S2eYwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Alex,

On Thu, 2023-07-13 at 17:19 -0300, Fabio Estevam wrote:
> On Wed, May 17, 2023 at 4:08=E2=80=AFAM Alexandru Ardelean <alex@shruggie=
.ro> wrote:
> >=20
> > From: Bogdan Togorean <bogdan.togorean@analog.com>
> >=20
> > For ADV7533 and ADV7535 low refresh rate is selected using
> > bits [3:2] of 0x4a main register.
> > So depending on ADV model write 0xfb or 0x4a register.
> >=20
> > Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
>=20
> Should this contain a Fixes tag so that it could be backported to
> stable kernels?

Yeah, most likely yes... With that:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


