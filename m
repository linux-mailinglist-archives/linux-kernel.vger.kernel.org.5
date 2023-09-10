Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2F799CA9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 06:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346187AbjIJEhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 00:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346161AbjIJEho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 00:37:44 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC47195;
        Sat,  9 Sep 2023 21:37:38 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1d4e0c2901bso2392179fac.0;
        Sat, 09 Sep 2023 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694320658; x=1694925458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28TDwagANbm8HIbTFyx3CBMn7Zz+dpCIZxzUcErrG5s=;
        b=m1WpsjztrNH8peo0rxuhh9CYykqUTvvKq+PZnE5LAhSm2Q39l/5m2RX2QDFdBuV4IZ
         xyl/eSAFZQCbNslK9r0yfC1HkbBn55TzAmmQhItWr8E8+bujrwBrevQZrYXe9VeeyFOQ
         54cFhNR805zTVFusk30MLKZ/4+nSfby8hBJizBL4MhA+IZGAbl8nXjMZNltTtL26RdR9
         H4KhCDuUDVvRlGIpK+uOaBCPwnx400CKFul76WnLPhEVpZQfcUk8yAFpfoBIJWsSE3B7
         qfFQjNZ5BjNLW5wZn+LFrx2icxpEqM+iH4h05wJlPy1ucvYj2Fp0OpJfNGVXTY87djTH
         9+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694320658; x=1694925458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28TDwagANbm8HIbTFyx3CBMn7Zz+dpCIZxzUcErrG5s=;
        b=hDf1lr3P2DlG7ZlbCKi3A47pyma3wCR1X7ytlOBOXZK3u/krvnVtISWVhC8hZ6N25Q
         vrsJeznbluCYjHCCqCiKI3uoljOXjbf6Nunfb1znor0o+THFyN6taV1elxxEHvWbAxqC
         s0jm3UPkmVEDOc+iiI7dzDSAT1/24VY1vNG3+RxEYQs/9V6xik+awPK/hmKY2kTbCzmM
         HutyfxwfgxbVXjIfn1eYQU4C+fQcY+dv9ReDDREIH0DJg1YyjIAKTJSFkosqBwI2/p0k
         VrOL1Z66BiXPhbjfgCiN/SERbM1Wet9Ocy7xPw7y8r+VdrcZxSYU/EunJyrJds9nguVW
         srxA==
X-Gm-Message-State: AOJu0Yy0uvfQF7/jQpFS8HWvdfL9+ALUyHbbfNgSIR6GTMqhNAh5+Hgt
        UAhtHN45uHGBAa3Sh25Agh57dMfl9njL+z951GooCSVWzcY=
X-Google-Smtp-Source: AGHT+IFp5zFknvSKDmGFWesaph1tNcTKmNY5gmPbhFPx4wUKtcAyiXJnWBq1XpvXecYQlxYJj3e2qPsd6JZB0TUcnY0=
X-Received: by 2002:a05:6870:51c7:b0:1be:f8d9:7bdd with SMTP id
 b7-20020a05687051c700b001bef8d97bddmr8159153oaj.6.1694320658018; Sat, 09 Sep
 2023 21:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230910040811.53046-1-erer1243@gmail.com> <ZP1DsYlG+R/Y9fjr@casper.infradead.org>
In-Reply-To: <ZP1DsYlG+R/Y9fjr@casper.infradead.org>
From:   Oliver F <erer1243@gmail.com>
Date:   Sun, 10 Sep 2023 00:37:27 -0400
Message-ID: <CAHhkmma2uKdnDCCidRVd0pF-xJRPDL_f5qfYos5vpcUE6cXdJA@mail.gmail.com>
Subject: Re: [PATCH] docs/sphinx: Explicitly convert Sphinx paths to str
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 12:19=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Sun, Sep 10, 2023 at 12:08:06AM -0400, Oliver Faso wrote:
> >                  else:
> > -                    doc =3D env.srcdir + "/" + env.docname + ":" + str=
(self.lineno)
> > +                    doc =3D str(env.srcdir) + "/" + env.docname + ":" =
+ str(self.lineno)
>
> Would we be better off doing the path manipulation in Path, then converti=
ng
> to string?  ie:
>
>                         doc =3D str(env.srcdir / env.docname) + ":" + str=
(self.lineno)
>

That would be incompatible with earlier Sphinx versions, which most
people are probably using.
The benefits would be supporting non-'/' separators, and invalid uft8 in pa=
ths.
But, I think those things don't matter here.

(sorry Matthew for double mail, I hit the wrong reply button)
