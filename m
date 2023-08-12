Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A547777A0E4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjHLPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:50:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B408AE4D;
        Sat, 12 Aug 2023 08:50:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso26854615e9.1;
        Sat, 12 Aug 2023 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691855435; x=1692460235;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u8IVYGqEH3Y3ZSIOn/x2bcKDSicUgSZMVN8qe7sTQxw=;
        b=mCBaSBLPzVgFIuf1UFh8gjyiaENdrvhsdzYZOGbd3dmirSkGSg/5OfI6J6FM+Qtv4f
         Nq/PFTLjeFqC+q2niQKQhvqGmbJHiMxYnZi1xrfJjRw0ihUS70g+uz2AxoE8AFEkqMg4
         CUviuCPvoUXbq0NEjjClnpRF1co00g1kRH3uzGl84mmuxoDqmp1V/cK32YvKdkfoFldG
         afNOkovksP/8ZWEC6SUXQbtOVIlEr62KuT/JBIfc6yy9qRsaVc/0FBIbO76idF9dkfX4
         OWxtxqwMoX/qImiljfVGAgamX9o1Ed0j3ZX0webN44XAs/RW22u/Z0UbT/WAh90X7wym
         gREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691855435; x=1692460235;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8IVYGqEH3Y3ZSIOn/x2bcKDSicUgSZMVN8qe7sTQxw=;
        b=EmOpP2cYGr6epdSk91cucPI3Ufj+dodeTS5/EtgLJwNMPUGccX/oZpPKNulkNO/grc
         VamX+UuE9gYcrRrcuwBuS968Xk9OF+6Bh+IS4UVHNJkcgEnlwSBGnJ+U+bGzBnZNzPEG
         xwgevlLXlngzuGSxdExCnc4oz5A1kUN9IY2znOqa3RcpPizKCV1XtYhmuv3Aer5Y2Dzv
         Shw/XMI0avyATGIj0qWXbp0mCdz5Yz4oEbOtCj0f+dEPJlD/WoDLNoekXZJ2t0uDZ0VZ
         Y877kugNUINIBP6L9GZ68qMXwWRSTbom6143u/m5NJ+9VYrF/TsLpQEb4oO0Uuplagh7
         6cvA==
X-Gm-Message-State: AOJu0Yz/gPakW+5RbbthAJo0slIR9R+FPZrA8pAMcQdEY8hg2jobkmhW
        L2+IdKLXlVIn2de3VgzT760=
X-Google-Smtp-Source: AGHT+IF5g0xLpWLYh2ysH+zUmzaZLbKulu6pTqus92bRtixr6gdsLwEg3vY+LURn6qb8aYDJDZXhjQ==
X-Received: by 2002:a05:600c:1d20:b0:3fe:3521:d9e2 with SMTP id l32-20020a05600c1d2000b003fe3521d9e2mr4073713wms.6.1691855434987;
        Sat, 12 Aug 2023 08:50:34 -0700 (PDT)
Received: from DreamMachine2.lan (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600c11cf00b003fd2e898aa3sm6758422wmi.0.2023.08.12.08.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:50:34 -0700 (PDT)
Message-ID: <91329fb858ec7dbb71455c46dab73373c3ee366b.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: pressure: bmp280: i2c: Rearrange vars in
 reverse xmas tree order
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Date:   Sat, 12 Aug 2023 17:50:33 +0200
In-Reply-To: <ZNERMrPeftok9LF8@smile.fi.intel.com>
References: <cover.1691276610.git.ang.iglesiasg@gmail.com>
         <80c7bf32dee57a4a21e5c623b9adbc5e1175f2de.1691276610.git.ang.iglesiasg@gmail.com>
         <ZNERMrPeftok9LF8@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-07 at 18:43 +0300, Andy Shevchenko wrote:
> On Sun, Aug 06, 2023 at 01:15:02AM +0200, Angel Iglesias wrote:
> > Minor cleanup reordering local variable declarations following reverse
> > christmas tree convention.
>=20
> What about other functions there? Are all of them ordered correctly?
>=20
This one was a leftover from previous work I did on this driver. I will che=
ck
the rest of the drive and update it to follow the same convention if requir=
ed.
Thank you for your time.

Kind regards
Angel

