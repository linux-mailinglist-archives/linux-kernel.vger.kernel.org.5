Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009C87E2BA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjKFSHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjKFSHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:07:41 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530BD45
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:07:38 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ce2ee17cb5so3112076a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 10:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699294057; x=1699898857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tafTCuaDIZv8Kn/Yy+yywU6nsPqrGi5A1KlK8AgjacI=;
        b=haDQsfePuyStLrKeOCiOU5xWM1YhAzjLWLdZNytfy2ZyTQa5rt0eEPcwlIPooBGMiC
         ImOEsY7rrXcw5Am6DXqJFCW42ukHIZWh+EsgawlN7uL4ROGLDFDbwuDVLYqpOMa29sxH
         sGZr6DwHomk7UrRCZ0Vn6MzZSIgbeg+muUnc7MF+J4BMXK01gQ5z3O19ALR36tn3P189
         Qk2ngBGk5/U2Go37F7cm+8SE7XuYIvBvt9UDXGoQ2Ks5G9cT8YToG1m8UYn0uij+s4iS
         rgGlxfvB8DpBomV9Bk5V+naxW8OE6hxw9g6+9zMOWEL5WmAmfTO9ypVPGYNcj38EevdA
         Z4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294057; x=1699898857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tafTCuaDIZv8Kn/Yy+yywU6nsPqrGi5A1KlK8AgjacI=;
        b=w3FodQlApKdp8uyGbEw3QOcLR72+Gi4CK2YA2rOcbtk6TqCUHoLJwDQEEJQk0NTeOz
         BFcZmAh88kKShGTOMNloYSIW9h0fDE5NCkd7OiDrU66hjRxzsPolADmID759RtQXiHVF
         K+9fpZRh60mJQFcQRekpzRWq0wjVKzUFkS0ylpdagfc3W2WLktlqBgWAD2pRjSxWLIS3
         ge3oAYDs6MpDHc3UAaQRN2YTM9Di8lvtVHa96G+LhBVtPg3NjEprwKKG2m3oUlBTTNjp
         UOT/bCq960jkum58ia2Q4tHy930LxI4cZICbQ1KoHOv7xPF320hjLblAJvIRUtQxxpke
         NLbw==
X-Gm-Message-State: AOJu0YxpQYqMf9mMXLOzURKy0QjshIDDmo/WNCrFHyNQ04zVrWARSn+n
        PK2SY7zKJHv4aT4r7MZnuZoUdRKWKS6PUGsQtEI=
X-Google-Smtp-Source: AGHT+IEbNL69KgmGLe/DKKMcPk0NOJhXvqcrI8V+qSWT3aWG/7c42QsolIs3ozPRa9afveQtwIigOFd+7uk9hS8zhog=
X-Received: by 2002:a05:6830:1e87:b0:6c1:7927:6550 with SMTP id
 n7-20020a0568301e8700b006c179276550mr31678236otr.2.1699294057308; Mon, 06 Nov
 2023 10:07:37 -0800 (PST)
MIME-Version: 1.0
References: <202311051347.7J6bthD7-lkp@intel.com>
In-Reply-To: <202311051347.7J6bthD7-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Nov 2023 20:07:00 +0200
Message-ID: <CAHp75VcKj_zFNZTkipdJokzZWoWUk5M2RyWO-=49VbmUmt6-Pw@mail.gmail.com>
Subject: Re: drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined
 but not used
To:     kernel test robot <lkp@intel.com>, Peter Rosin <peda@axentia.se>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend to all)

On Sun, Nov 5, 2023 at 7:03=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Chris,
>
> First bad commit (maybe !=3D root cause):

Indeed.

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   aea6bf908d730b01bd264a8821159db9463c111c
> commit: e9e40543ad5b38b848879768359fd13650529961 spi: Add generic SPI mul=
tiplexer
> date:   3 years, 9 months ago
> config: i386-randconfig-004-20231101 (https://download.01.org/0day-ci/arc=
hive/20231105/202311051347.7J6bthD7-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231105/202311051347.7J6bthD7-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311051347.7J6bthD7-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined but =
not used [-Wunused-const-variable=3D]
>      134 | static const struct of_device_id adg792a_of_match[] =3D {
>          |                                  ^~~~~~~~~~~~~~~~
>

I dunno why it's pointing out to that commit and some (random?) people
in Cc list, but the real problem there from day 1, i.e. (ab)using
of_match_ptr(). The of_match_ptr() should not ever be used. It appears
more harmful than useful.

Hence the proper fix is to drop of_match_ptr() in this file.


> vim +/adg792a_of_match +134 drivers/mux/adg792a.c

--=20
With Best Regards,
Andy Shevchenko
