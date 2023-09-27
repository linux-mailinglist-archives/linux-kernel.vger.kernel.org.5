Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986077AFB07
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjI0GZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjI0GZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:25:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B93F5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:25:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso7694796a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1695795938; x=1696400738; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/2T+kTv/JcuflJsGd2CXCzB7+oY7taYM7m20LJ70dY=;
        b=VFohLm3h8u7dS+QaCKcE42bLOQ/JXYcZgbCLmSPA2AKaeJeuC0qbjbrpzY25wtEPlU
         LsmHessL1mPfqJCozBlq21GBXroG4lOnvFulV+UbHlRCIR51TfOsXT2bcKVQbCw/fGRQ
         o8nBmAS2zizgTzM+IKWSGNO6cSgRYstk7C2huu56I3A+r+AG+xH5twZpKPEJcTv/ZSER
         9t5IqKPranxIkGfqQcjaHl8NtsmJoerix+U2rZtqWEyPBaFF9qy9YS1fyEjvH+yjOqVK
         b/hcCb3oIHm4PG/xcw9/igv3krje/tVe5G7mkgN786PcZgayZKPcet4zXk+uwcgBsYj5
         60dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695795938; x=1696400738;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/2T+kTv/JcuflJsGd2CXCzB7+oY7taYM7m20LJ70dY=;
        b=XINJHGL8s2RoBSt77mKZSt21O5CqwLzTzLE8r6wIowkA1e5iN5mEQwHPXa5i04uejy
         H2S17wpFkgwU4gB8T4P9+30MbAUXGMd8fnK+wbVrNTi4l8qBV/YMNk7I/YxAYryfxHQt
         +ysIWA0fq5Xy0QkEEEjtIRbrdrBHkd8QhJqi6VgPNlr+7kgS4zytRRfr5ObxXzJsLV4q
         gTGs2bqwg1uO3nInce+kB2wB7BxJWhhNtk/dmCmj0XfwOP+vRP6BMQQmN/axqlV/bQ+S
         UsIIFGedh876vWadeJq3pVxwJoYWSrINkHpmbY2tEXQWX/wwwmDapQmRnsaFu/Jy2sO4
         7QDg==
X-Gm-Message-State: AOJu0YxYvavlJonktZ1hGzCIaqjyYfHHagGCxkg9oD/5kXVB+4it6IFx
        xZ0o8zUiFLzvKBsLvLIzPVg+Fw==
X-Google-Smtp-Source: AGHT+IF+sh98cRJjLNIq8jQ2+ohMpgsb7FuT+Rgx8cnmOM61ikOsnrb8g2fLxxOWDkxmJbxpUUyb7A==
X-Received: by 2002:a17:907:7858:b0:98e:26ae:9b07 with SMTP id lb24-20020a170907785800b0098e26ae9b07mr860495ejc.35.1695795937865;
        Tue, 26 Sep 2023 23:25:37 -0700 (PDT)
Received: from smtpclient.apple (213-225-13-130.nat.highway.a1.net. [213.225.13.130])
        by smtp.gmail.com with ESMTPSA id rh27-20020a17090720fb00b009930c80b87csm8868973ejb.142.2023.09.26.23.25.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 23:25:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3 1/3] crypto: mxs-dcp: Add support for hardware provided
 keys
From:   David Gstir <david@sigma-star.at>
In-Reply-To: <CVS3NIJ8OO6Y.2C6GJ9OBR6COC@suppilovahvero>
Date:   Wed, 27 Sep 2023 08:25:24 +0200
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        sigma star Kernel Team <upstream+dcp@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        Li Yang <leoyang.li@nxp.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Transfer-Encoding: quoted-printable
Message-Id: <88FFAB6B-10A8-4732-A901-50859E22352D@sigma-star.at>
References: <20230918141826.8139-1-david@sigma-star.at>
 <20230918141826.8139-2-david@sigma-star.at>
 <CVS3NIJ8OO6Y.2C6GJ9OBR6COC@suppilovahvero>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko,

> On 25.09.2023, at 17:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Mon Sep 18, 2023 at 5:18 PM EEST, David Gstir wrote:
>> DCP is capable to performing AES with hardware-bound keys.
>> These keys are not stored in main memory and are therefore not =
directly
>> accessible by the operating system.
>>=20
>> So instead of feeding the key into DCP, we need to place a
>> reference to such a key before initiating the crypto operation.
>> Keys are referenced by a one byte identifiers.
>=20
> Not sure what the action of feeding key into DCP even means if such
> action does not exists.
>=20
> What you probably would want to describe here is how keys get created
> and how they are referenced by the kernel.
>=20
> For the "use" part please try to avoid academic paper style long
> expression starting with "we" pronomine.
>=20
> So the above paragraph would normalize into "The keys inside DCP
> are referenced by one byte identifier". Here of course would be
> for the context nice to know what is this set of DCP keys. E.g.
> are total 256 keys or some subset?
>=20
> When using too much prose there can be surprsingly little digestable
> information, thus this nitpicking.

Thanks for reviewing that in detail! I=E2=80=99ll rephrase the commit
messages on all patches to get rid of the academic paper style.


>=20
>> DCP supports 6 different keys: 4 slots in the secure memory area,
>> a one time programmable key which can be burnt via on-chip fuses
>> and an unique device key.
>>=20
>> Using these keys is restricted to in-kernel users that use them as =
building
>> block for other crypto tools such as trusted keys. Allowing userspace
>> (e.g. via AF_ALG) to use these keys to crypt or decrypt data is a =
security
>> risk, because there is no access control mechanism.
>=20
> Unless this patch has anything else than trusted keys this should not
> be an open-ended sentence. You want to say roughly that DCP hardware
> keys are implemented for the sake to implement trusted keys support,
> and exactly and only that.
>=20
> This description also lacks actions taken by the code changes below,
> which is really the beef of any commit description.

You=E2=80=99re right. I=E2=80=99ll add that.

Thanks,
- David

