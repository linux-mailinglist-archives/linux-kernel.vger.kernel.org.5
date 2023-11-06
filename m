Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21487E286C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjKFPQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjKFPQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:16:16 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4049EB3;
        Mon,  6 Nov 2023 07:16:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40790b0a224so34743625e9.0;
        Mon, 06 Nov 2023 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699283772; x=1699888572; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3v3nCG3TlJu5hJkh/EcwD9eIuQG7bBphrhJ6+6K0+LU=;
        b=aliYKMkxcgleVBZRpBIJCjHzcjoM+0edmZ+TfEqMdLC+BsSCz2qGd0mgwbhvDEqwDc
         4uzzSTSPrGckmCxFtxJg/JuCz4j73krjofEK4L6O6yJ28PPfyUq+fUdW/1GPT+1NNuI/
         axzfecmuKRueuCOw3DdWkTA3gOsFaOHVjmoKzJdxv9+80NtFrhAvA3Wv0Y2HhH2sZpY/
         ENlPTpbw6R3Ocwwu0FQyGANqrpbB50OZvwX4QYhr7CUqc2111L0p1JNuFFQgSDrJwCeW
         6SsiWvQIk31bINmtNs2H5JEC2PKCUGldbs6lDqifqK/dHVwBGiBPka1FwsVMVQ26CPwF
         KvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699283772; x=1699888572;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3v3nCG3TlJu5hJkh/EcwD9eIuQG7bBphrhJ6+6K0+LU=;
        b=cS3c2solxxPC6We00c2I+6Ypx1pfYW32GOC92JrOb9uZTVqhUN2kVbAJKJmABMpsoy
         9jauDEpVWbd5CtGPhVbv0nni/teXrmv/KSMj/J59aq+jmjyYkn32yU3DSAh0Ci1G9Sj+
         eYtlm9vqU9gEeJkLBAYoeLFgOwXoCUgi6aoOfw+2I3aYMztb7uH+r/EB+zBb2ogt83jm
         AxDu3yemEw+OtpUa+up8XELkFrY4JB7Bs+Hb6uuYVz8S5S/CgU5ZvUMAKblkyH96+pZ5
         DYksMYuFNVGFWyvC9XBELpkNGbMXk/RSaCs2Btpup4tXpjO4sDT4HM5oz9uwRkOZnVgF
         TsLQ==
X-Gm-Message-State: AOJu0YwHlkrtjGgGy4s7Lvl6T30mnNbqFuzJUlX7yoIWONmJjZnENFvf
        fcycrzooQX9v85qrm58MAv0=
X-Google-Smtp-Source: AGHT+IEqXBr/fsfrXexxWha/Icxv2t4d1e39DSTutU3sK2NePYGtnET5E7xVnOVFsm5AQTqYZz1vag==
X-Received: by 2002:a05:600c:1394:b0:409:7aa9:a8fd with SMTP id u20-20020a05600c139400b004097aa9a8fdmr4928544wmf.22.1699283771396;
        Mon, 06 Nov 2023 07:16:11 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c4e0500b00407b93d8085sm12688608wmq.27.2023.11.06.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 07:16:10 -0800 (PST)
Message-ID: <8371368263aea64bc0f635f723cb6ca9d0176dea.camel@gmail.com>
Subject: Re: [alobakin:pfcp 5/20] drivers/iio/imu/adis16475.c:363
 adis16475_set_freq() warn: set_bit() takes a bit number
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nuno Sa <nuno.sa@analog.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Nov 2023 16:16:09 +0100
In-Reply-To: <41eff9b4-3041-4a1e-ba28-b16d866cd894@intel.com>
References: <ff4ef031-774e-4e4d-a009-31f242bf6aee@kadam.mountain>
         <5b0f8705-71cb-4c4c-a70c-d9d3a15886cb@intel.com>
         <f040255ef1b3be87050b8255c947b4b375e75a02.camel@gmail.com>
         <bf2b6899-fad0-4ac7-a906-e8d361e5a46d@intel.com>
         <e29dc510c78205d87b573e0fe185dc7c7d509310.camel@gmail.com>
         <41eff9b4-3041-4a1e-ba28-b16d866cd894@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Mon, 2023-11-06 at 14:39 +0100, Alexander Lobakin wrote:
> From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> Date: Mon, 06 Nov 2023 13:02:58 +0100
>=20
> > On Mon, 2023-11-06 at 12:18 +0100, Alexander Lobakin wrote:
> > > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > > Date: Mon, 06 Nov 2023 11:07:16 +0100
>=20
> [...]
>=20
> > > assign_bit() does not take a bitmask as a first argument, but a bit n=
umber.
> > >=20
> > > I.e. if you want to switch BIT(0), you call it like assign_bit(0, ...=
),
> > > not assign_bit(BIT(0), ...). Same for the bit nr 1.
> > >=20
> >=20
> > Yes, I know... if you look at my reply to Dan you can see I realized th=
at already
> > :)=20
>=20
> Oh okay :)
>=20
> >=20
> > I guess by the time I first sent this time I didn't knew or maybe just =
a dumb
> > mistake...
> >=20
> > I'll send a patch later today removing the BIT() from the #define, thx!
>=20
> Nice! Don't forget the tags the build bot asked for :p
>=20

Just sent it... Hopefully no tags were forgotten! I was not sure about the =
Fixes tag
but added it anyways as this is indeed fixing something (even though the bu=
g was
never triggered).

- Nuno S=C3=A1

