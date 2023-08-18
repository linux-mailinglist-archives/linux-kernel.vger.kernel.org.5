Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0B78109C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378693AbjHRQl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378800AbjHRQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:41:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871634211;
        Fri, 18 Aug 2023 09:41:05 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so10975235e9.2;
        Fri, 18 Aug 2023 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692376864; x=1692981664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=llWGqwOUEcvGgJX27cVTnwCFd4kTNMJ1aEznWwewQDA=;
        b=qjufmJ0AnN3fBqC8z19KJd0LenNRUz/ljHs1f5fnyeBb4wqm4haxnHSaOkzXqBbGAe
         ZsBYqkIewBhLXqn1Xcd00nrJTS3a3UxQaRAvGmlt7KQDDXpKHOIAuE9AFWCshosuiHBk
         8+rZHpl4TFqdq24fpijh8OhdnSHEePyRYKtX+JS/kCrYCAz73fdqXkTIV2TKBhumaCxF
         n3jc7lf0bkcH4XibGJ818+0bUbjf/y7HcuU4GMp6Q+Oarmr3Nq0SnG+F38Jqz37sViBJ
         JmpeXpyI7wL/8ug613ayC/3nnTUcAD/+kJ/mzTcCx9ymGEgMrUTB8diS1sCVFbhSZmhp
         zT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376864; x=1692981664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=llWGqwOUEcvGgJX27cVTnwCFd4kTNMJ1aEznWwewQDA=;
        b=B/tDgxzoJQwoZKENzv9rBNVhT7BURlEPKffBGNZaJsmP3doyiOWo3PumtWUUB+9vZ1
         c9QGWzlpEOl3NeWWCGC5w1/PH8nRduRo1w80Nx3b4PAV2G72a9UBQYexpDaDhx9VFOwF
         IYSSXKeHzPB/QD/Fcz75QN3TknuC4bl7j5Jy059hEnJl9aJ7mMtp6qlzKsYqWZkoHTHX
         cUOfF2MXAGe4NMuzReg3DGK1xLMszqogFw/D1eYZTYN08mDc9Me60OUqbLImIEyBlKww
         NbfZwp9z2FYCCOiltdbWrPzqM0i31rYZMflxP5iJRBkoJ5RAXpRKJZU3fNjLtzpDaRaN
         3cog==
X-Gm-Message-State: AOJu0YxYaVFtyveFWQ/88V2r2Q1WIPGekyAG76ccJjWVqcmzZUyCo34l
        lduFsZK9v/z0AIGPs248Y9w=
X-Google-Smtp-Source: AGHT+IEB8a/G+9BZ2dnBLPj/ntNNt6rplNjHz/KD0/JrsBpFPPzMtEwYfol4loLcyOsUbn5o5GNEQg==
X-Received: by 2002:a05:600c:365a:b0:3fb:b008:2003 with SMTP id y26-20020a05600c365a00b003fbb0082003mr2558846wmq.38.1692376863691;
        Fri, 18 Aug 2023 09:41:03 -0700 (PDT)
Received: from DreamMachine2.lan (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id u24-20020a05600c00d800b003fbe791a0e8sm3465886wmm.0.2023.08.18.09.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:41:03 -0700 (PDT)
Message-ID: <a0a4bb894689f0377ac7a3e3eb750516459fe1bb.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: pressure: bmp280: Allow multiple chips id per
 family of devices
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri, 18 Aug 2023 18:41:02 +0200
In-Reply-To: <ZN+U3Rqef7bvhpZ7@smile.fi.intel.com>
References: <cover.1692305434.git.ang.iglesiasg@gmail.com>
         <8856287079b5dc1099f5b98a0168f008fbb8debd.1692305434.git.ang.iglesiasg@gmail.com>
         <ZN9TyGjr/pqLQUpT@smile.fi.intel.com>
         <b209214a80c98f92db57be30883ec78dfc116ab0.camel@gmail.com>
         <ZN+U3Rqef7bvhpZ7@smile.fi.intel.com>
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

On Fri, 2023-08-18 at 18:57 +0300, Andy Shevchenko wrote:
> On Fri, Aug 18, 2023 at 05:52:07PM +0200, Angel Iglesias wrote:
> > On Fri, 2023-08-18 at 14:19 +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 17, 2023 at 11:05:21PM +0200, Angel Iglesias wrote:
>=20
> ...
>=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const unsigned int chip_=
id;
> > >=20
> > > Yeah, this const makes a little sense...
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const unsigned int *chip=
_id;
> > >=20
> > > ...but not this :-)
> >=20
> > Isn't the same case as "const struct iio_chan_spec *channels" or "const=
 int
> > *oversampling_temp_avail". I thoght that this meant a pointer to a cons=
tant
> > integer. On bmp280-core I declare the arrays with the modifiers static
> > const.
>=20
> Yes, and that is my point:
> - old code makes a little sense
> - new code makes a lot of sense

Thanks for the clarification. I initially understood the opposite :S

> > > What I'm wondering is why it's int and not u8 / u16
> > > (as it seems only a byte value there).
> >=20
> > Yeah, can be u8, as the reg width is 1 byte and this IDs are stored on =
one
> > reg.
> > I just carried over the int type from previous versions, but it's just
> > wasting
> > space :/
>=20

