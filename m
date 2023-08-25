Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA034788388
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbjHYJ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242570AbjHYJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:28:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF891FC4;
        Fri, 25 Aug 2023 02:28:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3110ab7110aso544680f8f.3;
        Fri, 25 Aug 2023 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692955730; x=1693560530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L9gkSsKr8PfNJlb4LvEK/fNo3ovniSqfgVEwj5PCDnc=;
        b=O/7SRdB0PhfYQW4c8F/nT+UANPGRlskpmigPZjnpMDFBU6DLLvtR7E3GNbkh4FFmY2
         GkhbY/EHhRAC7ZUKPqga1eirDWsWACmQbXikIf5Lm1KyGi1lwQxtGv+L+imcmqsOSWqB
         QxKqLLQp6UtEeoK4/nwQoPqBLe9O3yGmXUgKCQ/5bSsh5NauTxrcMI0ane8BM+rl5q1r
         z+vg6gBE0gwkFZoY+Di2FJfya+03XLebeDKaobSMbwH1/qhumwtn34+kt0aAIYbOwcJG
         kjeXMy2z0slmntnWmCoQs7Bv5O2WH2q5m4aNKxsHfn1/dNc3ON5uNGcd31Cl1/hhxMV+
         rPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692955730; x=1693560530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9gkSsKr8PfNJlb4LvEK/fNo3ovniSqfgVEwj5PCDnc=;
        b=gG9GLH5FVq6lXicK31xEcuQ5DmcAN3L+Pw1bXwHFI1vmaJDWWLdtO3RFku3u8qb0B7
         1hbXGoEQviqkRMpeSl8fFmkilGvN1zByvjxK1enZqV15NIbf6IJT4Lofpxro/VPG53N8
         emQIC14bTZYCnXP6KLHNLj9HkjFlWAXrZRtB3Xkj69Y30puMuOIkOXWeTdiFfsqhRMdR
         /epPmTOTmL5V3a+scCwmSDPxYUMZR3f5cyd3RZslzmVpHw7iWtK8qySoJoelYsA2S+dN
         JnSD1TkGqp9qNDdf6Yf5zsONMU8/RHoItg7ZBJB1Tqnsk3O0mbM8vYiMSSZOOU+38Asl
         naCQ==
X-Gm-Message-State: AOJu0YzHx7W73ZeLNu8M3lm8vUfBYLFasY7nL1UJ0tl3VWFlp8DEas/S
        reYkZSYmx5xLzDJzFyTDQ3JAJ7V4CW8=
X-Google-Smtp-Source: AGHT+IE4bXY5Mj5h0YD1I3pVT1xVuU9EpvBJbVIxKDFQJtM70Ht49M9+YPoC0rEOX6GQOBoT8KeZqw==
X-Received: by 2002:a05:6000:12d2:b0:317:58eb:1e33 with SMTP id l18-20020a05600012d200b0031758eb1e33mr14002442wrx.8.1692955730319;
        Fri, 25 Aug 2023 02:28:50 -0700 (PDT)
Received: from thinkpad-work.lan (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d67cc000000b00317afc7949csm1680566wrw.50.2023.08.25.02.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 02:28:49 -0700 (PDT)
Message-ID: <60fcef0b71c3b6a5a35bd2bf706af7545acc3e6a.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: pressure: bmp280: Use uint8 to store chip
 ids
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri, 25 Aug 2023 11:28:48 +0200
In-Reply-To: <ZOYxGhZxpTDUpURQ@smile.fi.intel.com>
References: <cover.1692805377.git.ang.iglesiasg@gmail.com>
         <cf08dd2fab1fd91ca7ed0724d1f50435c8c2914b.1692805377.git.ang.iglesiasg@gmail.com>
         <ZOYveUBg3rKK+ZQ9@smile.fi.intel.com> <ZOYxGhZxpTDUpURQ@smile.fi.intel.com>
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

On Wed, 2023-08-23 at 19:17 +0300, Andy Shevchenko wrote:
> On Wed, Aug 23, 2023 at 07:10:33PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 23, 2023 at 05:58:05PM +0200, Angel Iglesias wrote:
> > > Represent the device id reg values using uint8 to optimize memory use=
.
> >=20
> > This doesn't correspond to the code, in the code you used uint8_t.
>=20
> ...
>=20
> > > =C2=A0struct bmp280_chip_info {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int id_reg;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const unsigned int chip_id=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint8_t chip_id;
> >=20
> > While this will compile and even work properly in kernel we use uXX typ=
es,
> > here u8.
>=20
> Actually this patch doesn't optimize memory use. The alignment will creat=
e
> a gap anyway.
>=20
> That said, this patch is simply redundant.
>=20
OK, I'll drop it on v3 then
