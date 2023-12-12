Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BBE80E4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjLLHJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjLLHJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:09:29 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C71DB;
        Mon, 11 Dec 2023 23:09:34 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1fab887fab8so4053376fac.0;
        Mon, 11 Dec 2023 23:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702364974; x=1702969774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BLa1ACTMhoL5sxIMxyJMrp9FEUdpmwAC3VuqFAsyHM=;
        b=JrXOSA1rLeI/1SEpPekq1VDfBbov9Q7HaQXiBhPFEADXXVYnZmLXjJ/0LY0lEVo93g
         P1bI2YrXakuJdVji7+3Xw7zAKs5/JbbVcGoIDY3jArrwwUk9L/R6FdtupPHAmnM+K8l4
         z8qnHrR8p2teQ5Zok8ND2+DZrpDIw7Ky2khJQMXX2hvbPTFvWczprYcK7p8s5DHJBBG0
         GAvoQ550YTLONefxHFDTfU2i7JbK+nSDPk/FuJ1HpLmjeBiillaHyXgu3GhXcoLZ4A+y
         VIYFO+xaWnuIzjPTpv0npL7vzY6gUJmIQ/kwMDSJI1e8DbaqOhynzY0RMEK6vm607Cba
         7CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702364974; x=1702969774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BLa1ACTMhoL5sxIMxyJMrp9FEUdpmwAC3VuqFAsyHM=;
        b=IglEBqQgkXZzQytzOkNsb+TVpHBipeM8/iKenybchSz1cqO7HNR11KkIvDoO0cHPdx
         aI1X1NauoGEhCv/Z33Ki2B4zRn+2m/SSUnVybglz6fkclIIed01Mdke9nL0+LIjuyaGz
         HI2WMNNRDyGo+14FF+ppdRwPMClBGIQiNycu6+Wv6ltvIMtv41oyBt+EQwOIcRPtDcT4
         fkONvVf98vY/cRqiITL4t1hroE6TswK7sn9T9GiQt4OtqYvcrDbX9LIikkjT6heiWpgk
         vJ8+WVhfWnOkYlhGaV5T39AjOrDWvrODs6rMqFsjth2Ua8QtC7Cx22NC1/e0HR5RCVhQ
         X4Pw==
X-Gm-Message-State: AOJu0Yxy0ncXxfhuWxE2EyZypQlxK5Q1KyAmNf7fvac2d99RYV8DQ/Ka
        xcbsEqU4tNilCPAD6VelYobp9hRN1/eI4WOA7o6ukzZ/
X-Google-Smtp-Source: AGHT+IGIpDBuTK/4FnzR2uULLjG/np1grQx6jbWRwpjYaxfhigRvyIbHoDdhMLBibonboWXPER9D/eQMOZDGMxMr3Cc=
X-Received: by 2002:a05:6871:4390:b0:1fb:75c:3fe9 with SMTP id
 lv16-20020a056871439000b001fb075c3fe9mr8152885oab.73.1702364973988; Mon, 11
 Dec 2023 23:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20231022090633.792831-1-sergio.paracuellos@gmail.com> <ZXd3dhsc3HXbj7SR@alpha.franken.de>
In-Reply-To: <ZXd3dhsc3HXbj7SR@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 12 Dec 2023 08:09:20 +0100
Message-ID: <CAMhs-H-ejOPeO-4gamajT-GupCnNu0K7vgsdR6vwqyEXB40qSA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of the Ralink architecture
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, john@phrozen.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 10:01=E2=80=AFPM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Sun, Oct 22, 2023 at 11:06:33AM +0200, Sergio Paracuellos wrote:
> > Its been a while since I am making contributions to this architecture.
> > Hence add myself as maintainer.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> > Hi John, if you are not ok with this please let me know. In other case
> > please ack this patch. I can add myself as Reviewer if you prefer to
> > maintain alone this.
> >
> > Thanks in advance for your time!
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2894f0777537..406c26a6f5d8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17914,6 +17914,7 @@ F:    drivers/media/cec/usb/rainshadow/
> >
> >  RALINK MIPS ARCHITECTURE
> >  M:   John Crispin <john@phrozen.org>
> > +M:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
> >  L:   linux-mips@vger.kernel.org
> >  S:   Maintained
> >  F:   arch/mips/ralink
> > --
> > 2.25.1
>
> applied to mips-next

Thanks!

Best regards,
    Sergio Paracuellos
>
> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]
