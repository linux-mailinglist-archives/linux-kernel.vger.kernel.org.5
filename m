Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8F75C0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGUIDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGUIDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:03:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7DC2704;
        Fri, 21 Jul 2023 01:03:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9939fbb7191so357267366b.0;
        Fri, 21 Jul 2023 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689926615; x=1690531415;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pFKYG/1VesNPnYJ+2RJdvyya/8SP7ErkfRv3C2Q2jPI=;
        b=R/L4KNBUiIY6pAG3BlMdjWhYbTWzwWix687+2+VjTMZNlM4lL//UqfFcQhZB/r1RH0
         BeE9LOjl7GnEWA6CVUuqscuQUz0koPEQcXPCZjx2N7tLRNXJ6UXCwzVpjXIeI7/dQ8XM
         Uu8lg2DipufmJAOmNSPJFPm85syLn46/UdjtDhJBSF8ADJb7BvW9L5TiZN5d3LUNBMyG
         usq7yMggmlo8/denLji15I8l7HM6vxulaqEu4tEhrI0x4UaxuzyCMTUXXRFRPFSpjAls
         dKbEF/t/VYnV7WD1AQMkzbdk9/k3Mk4S3311f0e4w/15seT5adOwioH1zWzAj9RfU+FQ
         VFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926615; x=1690531415;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFKYG/1VesNPnYJ+2RJdvyya/8SP7ErkfRv3C2Q2jPI=;
        b=eJ3OKB3PRe8eHptEzWkH7DhZFBXTmG0bQv3g7YBGuSH2SVhiyjS1MtYwM2Ka7TgQ2K
         xWhtxBqivHhoWmuv94fW9kLY8SYgprYwBLT+dP5MedeTZfebfon+vAcSl1ygJFdII+aL
         BgNqhtjHNZy4/AU82mjXChKi0dmOVElYWlQoAfpbOlxtKVloBSqn/VbN74U31ctgBs6g
         JbTIJ6qqR1t5NfvdKW6IA5lg1SC6JpNMye+vUY5c0fam2OhigotgLsp+gKfmM9f4xbQl
         VwsGsNWZliwjiCoXMbjMNqrH0FsSLkDB0mhHa1e6WckB6eWyPCAvMhv3/qY3E4rMWv01
         d7OA==
X-Gm-Message-State: ABy/qLYe4d9wWlQrozr8tT6ZV6FJaFdL96sNil/zhRXpSE2eKs9p5opX
        7QId1RTmNTZo3SiMsNIixF8=
X-Google-Smtp-Source: APBJJlEdzV4/PhSsRy8t+vhzJ4dvEI20DkeDzTmDvMYG15gC+Gh5C8YPehbk/aWURtovn9Bj7z+FKw==
X-Received: by 2002:a17:907:2bc4:b0:997:e7d0:e26d with SMTP id gv4-20020a1709072bc400b00997e7d0e26dmr1240606ejc.4.1689926615356;
        Fri, 21 Jul 2023 01:03:35 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:f946:69a3:7954:9ee0? (p200300f6ef058700f94669a379549ee0.dip0.t-ipconnect.de. [2003:f6:ef05:8700:f946:69a3:7954:9ee0])
        by smtp.gmail.com with ESMTPSA id fy17-20020a170906b7d100b009931a3adf64sm1853775ejb.17.2023.07.21.01.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:03:34 -0700 (PDT)
Message-ID: <d65e25da75142b7414cbf082c7f485464b82b6d1.camel@gmail.com>
Subject: Re: [PATCH v1 0/8] iio: core: A few code cleanups and documentation
 fixes
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri, 21 Jul 2023 10:06:05 +0200
In-Reply-To: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
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

On Thu, 2023-07-20 at 23:53 +0300, Andy Shevchenko wrote:
> Just set of almost unrelated to each other cleanups against IIO
> core implementation.
>=20
> The positive LoCs diffstat due to first patch that adds a lot of
> documentation for the new added macro.
>=20
> Andy Shevchenko (8):
> =C2=A0 iio: core: Add opaque_struct_size() helper and use it
> =C2=A0 iio: core: Use sysfs_match_string() helper
> =C2=A0 iio: core: Switch to krealloc_array()
> =C2=A0 iio: core: Use min() instead of min_t() to make code more robust
> =C2=A0 iio: core: Get rid of redundant 'else'
> =C2=A0 iio: core: Fix issues and style of the comments
> =C2=A0 iio: core: Move initcalls closer to the respective calls
> =C2=A0 iio: core: Improve indentation in a few places
>=20
> =C2=A0drivers/iio/industrialio-core.c | 226 ++++++++++++++++-------------=
---
> =C2=A01 file changed, 115 insertions(+), 111 deletions(-)
>=20

Neat series... Just a few comments on my side and on patch 3 is up to you t=
o
take the comments or not.

With my comment addressed on patch 2:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
=20
