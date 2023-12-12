Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9875780E127
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjLLCBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjLLCBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:01:08 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D74A9F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:01:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50c05ea5805so6134594e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702346472; x=1702951272; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7KWKhvYJwvM4Jhue2eRdgbRjWAjIqUdVY1eAlzHMEbo=;
        b=PmP012HaRjZW7W0k3QyntP4F8B8RexAxaIJvVx+6Mx+Z+ZjWhO3Bof9h0sBE4idEVC
         fyRaqEf6NZTgZ8VRh/X1Soo4vClm+KGVcPmYsptWHqQ0/rf3gOwEKIeoEnj2u3r62aPA
         F3wFHBEwmIhpUKuBQUMVqoHOiuxLUQpqD01o8ZYiXDWlc/jnxMU5VG+dZmSsDT0j2EOm
         1O2sGw9psMXUoZK2QoU2GezghdeEm1LPPPx1E600CV1yKHWGXM1xlyaMGlfrZINCdUKZ
         Z+kpqKefO8xTkmNCWxqmMUCbDYdcVMhL2O5r9KiMb2U3ZD1Bk8rByRHglvy6SOivfTkh
         uSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702346472; x=1702951272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KWKhvYJwvM4Jhue2eRdgbRjWAjIqUdVY1eAlzHMEbo=;
        b=c65ESHBWhWBDvo1kYyhhb6U83GC+dxO6snF0+PYccgpjaKo8BylaeCLnCsycaqVc02
         JAzp8BgSvyAiqjWgPR8n8rgHeJu2tdRKCXr9DrgzQ7yriWPxWdSaZB7+Of09T1g2jkPE
         az0dZITG7vtLejqUw4/sJpum+Zjs4VS+KEDSrLeoyDbEzzKpgm+q94CS6c0C1lpWlWDs
         LyrTsUOAYhVH4TxEO4Lw5K9gqYPa+9si9c9VEwDh1OBErG6ps+PAqDQP90uO8Uno1+iP
         kOZI2JKGzlyeO4izAgt5MujnCAlos3xRLlpSDPhF8rBQyPX7ofjb2C+BYIJk2cmz3J02
         m44w==
X-Gm-Message-State: AOJu0Yy+iMKHwjIEBtwmCGAyFj4d9wirAbrl4gpdQu7AS4BHqn1NhWDR
        jU+nMMhfHwibniNCiVlgQ+OTLQ==
X-Google-Smtp-Source: AGHT+IHLzGUzER1PQtCvbxvQ9OvEFB7C9qq206eKNePTtcEO3I3JMvlhyJvuiG/Ox/5VE5XRq8Dr1w==
X-Received: by 2002:a05:6512:2349:b0:50c:cdc1:b57 with SMTP id p9-20020a056512234900b0050ccdc10b57mr3057725lfu.3.1702346472558;
        Mon, 11 Dec 2023 18:01:12 -0800 (PST)
Received: from ?IPv6:2804:30c:915:cb00:89a8:6d94:ec55:e0a3? ([2804:30c:915:cb00:89a8:6d94:ec55:e0a3])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a1b6cba8d20sm5467208ejc.122.2023.12.11.18.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:01:12 -0800 (PST)
Message-ID: <e2817181598490e0455e33add1a61021b2535f78.camel@suse.com>
Subject: Re: [PATCH v3 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        live-patching@vger.kernel.org
Date:   Mon, 11 Dec 2023 23:01:02 -0300
In-Reply-To: <2c4f2771-0557-4b44-9c98-6bd2e6930d2f@linuxfoundation.org>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
         <20231031-send-lp-kselftests-v3-2-2b1655c2605f@suse.com>
         <ZWn7dEzVWoKxycmy@redhat.com>
         <alpine.LSU.2.21.2312061543280.13051@pobox.suse.cz>
         <273a86d6-d220-fdcf-3c2f-70516c519ff9@redhat.com>
         <57fb9f30afbaddb09def96aac11c45296a59a277.camel@suse.com>
         <2c4f2771-0557-4b44-9c98-6bd2e6930d2f@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-11 at 14:56 -0700, Shuah Khan wrote:
> On 12/7/23 12:19, mpdesouza@suse.com=C2=A0wrote:
> > On Thu, 2023-12-07 at 10:20 -0500, Joe Lawrence wrote:
> > > On 12/6/23 10:05, Miroslav Benes wrote:
> > > > On Fri, 1 Dec 2023, Joe Lawrence wrote:
> > > >=20
> > > > > On Tue, Oct 31, 2023 at 06:10:52PM -0300, Marcos Paulo de
> > > > > Souza
> > > > > wrote:
> > > > > > The modules are being moved from lib/livepatch to
> > > > > > tools/testing/selftests/livepatch/test_modules.
> > > > > >=20
> > > > > > This code moving will allow writing more complex tests,
> > > > > > like
> > > > > > for example an
> > > > > > userspace C code that will call a livepatched kernel
> > > > > > function.
> > > > > >=20
> > > > > > The modules are now built as out-of-tree
> > > > > > modules, but being part of the kernel source means they
> > > > > > will be
> > > > > > maintained.
> > > > > >=20
> > > > > > Another advantage of the code moving is to be able to
> > > > > > easily
> > > > > > change,
> > > > > > debug and rebuild the tests by running make on the
> > > > > > selftests/livepatch directory,
> > > > > > which is not currently possible since the modules on
> > > > > > lib/livepatch are
> > > > > > build and installed using the "modules" target.
> > > > > >=20
> > > > > > The current approach also keeps the ability to execute the
> > > > > > tests manually by
> > > > > > executing the scripts inside selftests/livepatch directory,
> > > > > > as
> > > > > > it's currently
> > > > > > supported. If the modules are modified, they needed to be
> > > > > > rebuilt before running
> > > > > > the scripts though.
> > > > > >=20
> > > > > > The modules are built before running the selftests when
> > > > > > using
> > > > > > the
> > > > > > kselftest invocations:
> > > > > >=20
> > > > > > 	make kselftest TARGETS=3Dlivepatch
> > > > > > or
> > > > > > 	make -C tools/testing/selftests/livepatch
> > > > > > run_tests
> > > > > >=20
> > > > >=20
> > > > > Quick question:
> > > > >=20
> > > > > - We have been building with CONFIG_LIVEPATCH_TEST=3Dm to
> > > > > generate
> > > > > the
> > > > > =C2=A0=C2=A0 test modules at kernel build time
> > > > >=20
> > > > > - Our packaging filters out the selftest scripts and
> > > > > supporting
> > > > > modules
> > > > > =C2=A0=C2=A0 from the general kernel RPM package into their subpa=
ckages
> > > > >=20
> > > > > - Tests are run as part of CKI or other manual tests by
> > > > > installing the
> > > > > =C2=A0=C2=A0 pre-built packages from the previous step
> > > > >=20
> > > > >=20
> > > > > After this patch, we would need to add something like the
> > > > > following to
> > > > > our kernel build, before packaging:
> > > > >=20
> > > > > =C2=A0=C2=A0 $ make KDIR=3D$(pwd) -C tools/testing/selftests/live=
patch/
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^
> > > > >=20
> > > > > If this is the correct way to build the test modules for
> > > > > *this*
> > > > > tree and
> > > > > /lib/modules/$(shell uname -r)/build... it might be useful to
> > > > > document
> > > > > in the commit message as an alternative use case.
> >=20
> > That's right:
> >=20
> > $ make -C tools/testing/selftests/livepatch/
> >=20
> > is indeed the way to build the tests without running them. KDIR
> > will be
> > set to=C2=A0 /lib/modules/$(shell uname -r)/build is empty.
> >=20
> > Yes, I can definitely add documentation about it inside the
> > tools/testing/selftests/livepatch/README.
> >=20
>=20
> How does the default kselftest run work with these changes?
>=20
> make ksefltest - does this still work as it did before this change?

Yes,

make kselftest TARGETS=3Dlivepatch

works the same as before. As well the

make -C tools/testing/selftests/livepatch run_tests

Both ways work as before.
>=20
> thanks,
> -- Shuah
>=20

