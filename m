Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64D7B1B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjI1Lwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjI1Lwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:52:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B5AF5;
        Thu, 28 Sep 2023 04:52:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so26002105e9.0;
        Thu, 28 Sep 2023 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695901947; x=1696506747; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mi0Qpp+66iw3Eu/2daVu9ecjp3IKiE246H3U/Qd4rPQ=;
        b=Tbaxa8XohlcrfUiklJnMbu+C1R2dj3gody8A5AMsuQNL05ssalTcltgNffJxWmF+bz
         Xyqz0POZbFCyUnTl3SMKC/FiZjoLSGWaGPqF2pccmxjmpsUwOfr29OWm2GnjPJUMA+Sb
         h6T6Ipuad9oC8NAbAL4HLZn4rT1jwLRW0Kfyk9iDqNP0XOnsiEdBW35C7E+WOEtl+tib
         KuoBWQ9oGhY4NvLqqMWPTwnJsdd1R4CbF43NOtAqdGjglHe6rfVQ5TWaX2qub/4qwZmx
         dHott82ayqfzxHVdffjX7Hshe8pHlHV5+s0frQgMX2OvLxD+qxu3BfSGAyquYnYuPKB8
         slrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695901947; x=1696506747;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mi0Qpp+66iw3Eu/2daVu9ecjp3IKiE246H3U/Qd4rPQ=;
        b=fRwmiqkob226ghs0AFrDjsMo/tQUQ0Dtt0x16hdIKjUkCF+sPOnl7cZn5hyjVMTJGV
         m0aQR8cIiIe5bOI4tRSd1JB1ki4kopHez3/nD4w1dapYZm8G0ogmcEnljIKmrDn7NaD9
         8OqQtxjVLZreDj+MYyDn/qsYXMX0eKrhfnf6q/ceobINoXirrxXBYB0GbHBi0eVGUxky
         iYMcD7govTMOx8zOXTFoTAalIpZ00mgxR6qvWTiABeNiRNcxK7zNFUHH2o6dtRsieIIR
         G0fWej1MDkUH3Xp6Lwt4+NKyb/5ERHZDt0xFdZudIqQj0MV4Qx3uZKrOPgWr1PGzSezc
         83+Q==
X-Gm-Message-State: AOJu0YwiizTL6A0PRslkALGzJTjjMToqKUHSxku/W8VCj3aqHVwabeTo
        Rch4SgnHtdWd0ZJuAQDEiZ8=
X-Google-Smtp-Source: AGHT+IERkIcRtPRoApWbVzzaEhLEJdqPbeDDri5WVWkJACp1t/QAn3tCqsvofX8pzjO+1dLmLStnWA==
X-Received: by 2002:a05:600c:21c5:b0:406:45c1:a657 with SMTP id x5-20020a05600c21c500b0040645c1a657mr1026826wmj.6.1695901946900;
        Thu, 28 Sep 2023 04:52:26 -0700 (PDT)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b00401b242e2e6sm17293654wml.47.2023.09.28.04.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 04:52:26 -0700 (PDT)
Message-ID: <5b6318f16799e6e2575fe541e83e42e0afebe6cf.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Eliza Balas <eliza.balas@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 28 Sep 2023 13:52:25 +0200
In-Reply-To: <839638d2-7502-4925-8b7f-6b15779a6840@app.fastmail.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
         <20230928092804.22612-3-eliza.balas@analog.com>
         <839638d2-7502-4925-8b7f-6b15779a6840@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

Hi Arnd,

On Thu, 2023-09-28 at 12:07 +0200, Arnd Bergmann wrote:
> On Thu, Sep 28, 2023, at 11:28, Eliza Balas wrote:
> > This patch introduces the driver for the new ADI TDD engine HDL.
> > The generic TDD controller is in essence a waveform generator
> > capable of addressing RF applications which require Time Division
> > Duplexing, as well as controlling other modules of general
> > applications through its dedicated 32 channel outputs.
> >=20
> > The reason of creating the generic TDD controller was to reduce
> > the naming confusion around the existing repurposed TDD core
> > built for AD9361, as well as expanding its number of output
> > channels for systems which require more than six controlling signals.
> >=20
> > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
>=20
> Thanks for your submission, I've had a first look at the driver
> and the implementation of the interface you have chosen looks
> all good to me, so I have no detailed comments on that.
>=20
> It would however help to explain the ideas you had for the
> user-space interface design and summarize them in the changelog
> text.
>=20
> You have chosen a low-level interface that wraps the individual
> device registers and gives user space direct control over them.
> The risk here is to lock yourself into the first design,
> giving you less flexibility for future extensions, so it would
> help to understand what the usage model is here.
>=20
> One risk is that there may be an in-kernel user in the future
> when the TDD engine interacts with another device, so you
> need a driver level interface, which would in turn break
> if any user pokes the registers directly.
>=20
> Another possible problem I see is that an application written
> for this driver would be incompatible with similar hardware
> that has the same functionality but a different register-level
> interface, or even a minor revision of the device that ends up
> breaking one of the assumptions about the hardware design.
>=20
> In both cases, the likely answer is to have a higher-level
> interface of some sort, but the downside of that would be
> that it is much harder to come up with a good interface that
> covers all possible use cases.
>=20
> Another question is whether you could fit into some
> existing subsystem instead of creating a single-driver
> interface. drivers/iio/ might be a good choice, as
> it already handles both in-kernel and userspace users,
> and provides a common abstraction for multiple classes
> of devices that (without any domain knowledge in my case)
> look similar enough that this could be added there.
>=20

Yeah, the same question was done in v1 [1]:

For some reason (I guess a simple mistake :)) Jonathan only replied to me: =
Here is
it's response:

"
> We do have tons of specific attributes (non IIO ones) for this device. Th=
e ones
> resembling IIO is likely because it feels familiar to us in ADI. Anyways,=
 I have my
> doubts this fits (at least as IIO stands right now) but maybe Jonathan th=
inks
> otherwise.

From a superficial look, it's a stretch but we have stretched IIO in the pa=
st
(things like very high frequency synthesizers)

In some ways this looks like a complex PWM device though it would probably =
be hard
to force it into that framework.

This is weird enough that I'd be surprised to see it fit well anywhere so m=
isc
might be the best option.

Jonathan

>=20
> +cc Jonathan...
"

That said, I do agree that some of the interface should likely not be part =
of the
"main" ABI. Like anything that states "debugging purposes"  in the ABI file=
 should
probably go to debugfs. I'm also not sure about those dual "*_ms" vs "*_raw=
" files.
Ideally, we would only provide the non "raw" ones. At least in the beginnin=
g...=20

+cc Jonathan again so he can confirm that I'm not putting words in his mout=
h :)

[1]: https://lore.kernel.org/all/b2379aadad95d68ca9605bb9566ce6a70121a409.c=
amel@gmail.com/

- Nuno S=C3=A1

