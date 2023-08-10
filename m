Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0774776DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjHJCKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHJCKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:10:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D732E1994;
        Wed,  9 Aug 2023 19:10:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-565439b6b3fso334357a12.2;
        Wed, 09 Aug 2023 19:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691633419; x=1692238219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4+peB+2E26RUHjOzSdDJ9QSAl1pkJkFX0L3VTxCIpI=;
        b=IPfwYKYO1K83Clbsut5Pz/7TTqiDddJ9B6rG+eNqcd17Wdj6UiviOnWouFSBdLPIps
         i9Jz8FJcvlL0EZ1jL5WisfdfDZIWHhwhhyqk2vjfVBw1kNzJg5XiAZQDlbA0UlLfNXJA
         uxFu3QBnvQ5ZnSNvZ6KjFib8oNTwZCaEpOfrVMOy3MA1hmRpuWK/Vn8fRwfVLW7LqYrt
         jxfK7mWM+6C9nLcYrmseFYnVFs01MF1QANvgb+UBdESORk3nsLzIk3fGHs3LuYWG3ATA
         eDrso9z5x6ityh9mlfvmQwb2keGxIvh9iaAgmUsi8xy+FADmFoB52JArGJZl4F3tvJCN
         VS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691633419; x=1692238219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4+peB+2E26RUHjOzSdDJ9QSAl1pkJkFX0L3VTxCIpI=;
        b=IveBvDNODYi1VaTIXHt4+EYnVtakmLKgnvjXhOb4YeCxaHi3a0DB7OsbAnFXbwlKuo
         Qu34eplNB/EcN9R2l8hajh1oINKs3PZzYjjynOs/AHh4XPdS7KRayXVYGuiWsSaIrRIy
         IlLjIXclPhnRiv6lg8IujZ7SQwl5rdV/aE9rQ+SUIKcNYSuH1syAiPnqWc/NmaTd/US+
         77Zps9/3+k6qBe+T8vhWo6gSRVXmzEGKfL3vItClnaGb9SIve7vbppdYpGYw2Fm2c+W7
         jLh3If44jbwAWs3ZBQTK/+FqgKQRfAhJN4SkusyYf3A4DtE+yx+aMIGN4DGFDhao41QX
         AAaQ==
X-Gm-Message-State: AOJu0YwAybJOFhchskoXHFQuY1r/IQUJC/i9ZlLsJ49iy/iSUhKWZZnl
        bSG2e/KKYydioq3pqjLJ7aI=
X-Google-Smtp-Source: AGHT+IF40gJgHXn/kRlHmgnx8Ed0rlDr5VjB2KHJbqHBVoKDDeiqcETBRtfOOny/DfuIGlXUOFoxVw==
X-Received: by 2002:a05:6a21:2799:b0:13b:79db:e222 with SMTP id rn25-20020a056a21279900b0013b79dbe222mr985681pzb.53.1691633419286;
        Wed, 09 Aug 2023 19:10:19 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709029a9400b001b7ffca7dbcsm243691plp.148.2023.08.09.19.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 19:10:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 42BDCA66B350; Thu, 10 Aug 2023 09:10:16 +0700 (WIB)
Date:   Thu, 10 Aug 2023 09:10:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>, hanyu001@208suo.com,
        stf_xl@wp.pl, helmut.schaa@googlemail.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wireless: ralink: rt2x00: "foo* bar" should be "foo
 *bar"
Message-ID: <ZNRHCBbvEPtq-cE7@debian.me>
References: <tencent_316424AFC531C5F050C0203FDBA08E84F907@qq.com>
 <18520fa625b8a901314c65bb8e557091@208suo.com>
 <36e36d94e81da4342283aac471fb5a7bd3eb9f65.camel@sipsolutions.net>
 <bed853f70773496902b5676e568922edbf487dfb.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WpA8IGdgWEPzHWb0"
Content-Disposition: inline
In-Reply-To: <bed853f70773496902b5676e568922edbf487dfb.camel@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WpA8IGdgWEPzHWb0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 10:40:53AM +0200, Johannes Berg wrote:
> On Tue, 2023-08-08 at 10:34 +0200, Johannes Berg wrote:
> > On Fri, 2023-07-21 at 14:34 +0800, hanyu001@208suo.com wrote:
> > > Fix checkpatch warnings:
> > >=20
> > > ./drivers/net/wireless/ralink/rt2x00/rt2x00.h:386: ERROR: "foo* bar"=
=20
> > > should be "foo *bar"
> > > ./drivers/net/wireless/ralink/rt2x00/rt2x00.h:513: ERROR: "foo* bar"=
=20
> > > should be "foo *bar"
> > >=20
> > > Signed-off-by: Yu Han <hanyu001@208suo.com>
> >=20
> > This patch is broken. I'll just point you to what I wrote before:
> >=20
> > https://lore.kernel.org/all/058dd31ef48495f8641f5b66839aaea039af0f08.ca=
mel@sipsolutions.net/
> >=20
> > What _are_ you trying to achieve?!
> >=20
> > Currently all you're achieving is annoying everyone with broken (and
> > pointless submissions).
> >=20
>=20
> And the email address doesn't even work, only about two weeks after you
> sent this patch?
>=20
>   hanyu001@208suo.com
>     host mx1.qiye.aliyun.com [47.246.146.58]
>     SMTP error from remote mail server after RCPT TO:<hanyu001@208suo.com=
>:
>     554 RCPT (hanyu001@208suo.com) dosn't exist
>=20

No wonder why @208suo.com people ignore reviews from mailing list - their
addresses are send-only without real mailboxes...

BTW, how can you get above error message? I'm curious.

--=20
An old man doll... just what I always wanted! - Clara

--WpA8IGdgWEPzHWb0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNRHAwAKCRD2uYlJVVFO
o6inAQC1qI8SMVRHoX5sycRsS65nRVKFoGnBhaL3dY9cEHLC+QEA6POgGHLgyDkM
Jxidj+uFqYU/Kokh/jH4B3ZFYj52WwQ=
=c3ZP
-----END PGP SIGNATURE-----

--WpA8IGdgWEPzHWb0--
