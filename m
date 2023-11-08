Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9687E536B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbjKHKbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbjKHKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:31:38 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B265F10D5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:31:35 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so90163641fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699439494; x=1700044294; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZHOWVitV8fpPpTSt/LEY0mOQlvuP3Z+CJF3ZJjpjr0=;
        b=vmey2JKfJAgJXu+kERqQxwEh+21Omc1JC8PbHnFipzbzFLGTPTVqOcDVYxWO95MoXd
         +pZNvu2JmgHeJxPNI9yx7drxwM5w5OTPk7yBHKYMsEJtYUgXnMp3+LKpKS3vBb5vKLRG
         eH5HbK2licHvxT5Sq6fqEe9IEEeCO/K2SXBvyruHfPeyRMoHMS7rS7x5yDtdL60h/0RA
         8U36/bdagKghF+T2s14WdwIJIPTNDK72Yt34KeTfM60i2MsadsATim/DPrn7qG3/eMPK
         Weaq1AaXa/RzwN6Vxv6E3F2DE3WF3P0iLYn6xRDw37H2geR8qH8GvFcp8XLgQggvs4Gy
         LJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439494; x=1700044294;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZHOWVitV8fpPpTSt/LEY0mOQlvuP3Z+CJF3ZJjpjr0=;
        b=PLGJINQC5+6PJ+GRl1fKWQNpYqM+cJywBkJtyZNP/vtMzKmO8QU4/bKTyTIbjBhOxw
         icDyMjruPB4tdfMSHSiRGpkMB/aP9YaznOPWcHlpVioYhxqBJjAqXC7Y+wRhznK5cXJL
         0I3DnZxjz/yXdgFtdhUDzzYcmJP/08uqGip6RDZm4usY1SqfVS49s7JLPK9Mm2FCgksr
         LLsXSZE/K/tGJJExwy8j/2A0HRarCsxx5ODLu6EhlYmCCwIf57iTFx4D3VI6l5ZeV8Xc
         0CQFq0nGygXAvgYxawxQ+igJENeyZBJcXUJmQISvS34r3+PYtu8PTpWhmsXNdnkBHlxD
         rDgw==
X-Gm-Message-State: AOJu0Yy3yp8ow4fzEw9lgRZIrsBk9c8bOwehFX8QeCw00NNx2zpH+80A
        wQAbYlzDHfQsrjLeYc2cSyIdpA==
X-Google-Smtp-Source: AGHT+IFGbhaVKFe4xCjLwT+C8qJk1HX078wZSs2uP1BZS21UHg0qYYDKYp+gYXHQ2/HXV4dQHz545Q==
X-Received: by 2002:a2e:9682:0:b0:2c5:1809:69ba with SMTP id q2-20020a2e9682000000b002c5180969bamr1256401lji.40.1699439493885;
        Wed, 08 Nov 2023 02:31:33 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b004097881d7a8sm15887394wmg.0.2023.11.08.02.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:31:33 -0800 (PST)
Message-ID: <61be0ebb17ae0f01ea0e88a225cbfa07ff661060.camel@linaro.org>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
From:   =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 08 Nov 2023 10:31:31 +0000
In-Reply-To: <7df24b0e-ea98-4dc7-9e1b-dfc29d0fa1b1@leemhuis.info>
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
         <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
         <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
         <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
         <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
         <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
         <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
         <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
         <2023102731-wobbly-glimpse-97f5@gregkh>
         <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
         <2023102740-think-hatless-ab87@gregkh>
         <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
         <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
         <CAOssrKfP+t-cy322ujizQofgZkPZsBu1H4+zfbWNEFCmTsXwug@mail.gmail.com>
         <afe378bf254f6c4ac73bb55be3fa7422f2da3f5f.camel@linaro.org>
         <CAOssrKeJB7BZ7fA6Uqo6rHohybmgovc6rVwDeHbegvweSyZeeA@mail.gmail.com>
         <7df24b0e-ea98-4dc7-9e1b-dfc29d0fa1b1@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten,

(sorry for the slow reply)

On Wed, 2023-11-01 at 13:36 +0100, Linux regression tracking (Thorsten
Leemhuis) wrote:
> I'm taken a bit back and forth here and it seems we are stuck again.
> So
> let me try again to hopefully clear things up a bit:
>=20
> Andr=C3=A9, could you please state
>=20
> * What practical use-case actually stopped working?

It's impossible to use a newer kernel together with an older user space
which is something that Android had been supporting for a long time.

> * What Linux kernel version actually worked for your (because if
> thing
> broke when you upgraded from a vendor kernel to a vanilla kernel than
> this does not qualify as regression IMHO)

We are using the Android kernel in all cases and Android applies
patches on top of Linus' tree, yes (as does everybody else). The
previous Android kernel worked, the current Android kernel doesn't
because of the patch in question.


I think Greg made some valid points before:
https://lore.kernel.org/all/2023102731-wobbly-glimpse-97f5@gregkh/
> I'm talking about a patch where you are changing the existing
> user/kernel api by filtering out values that you previously accepted.
> And it was done in a patch saying "this might break userspace", and
> guess what, it did!

I guess it boils down to an an agreement regarding Greg's previous
questions/points:
https://lore.kernel.org/all/2023102757-cornflake-pry-e788@gregkh/
> So because Android userspace is sending a flag value that is not in
> the upstream table, this breakage is ok?

and https://lore.kernel.org/all/2023102740-think-hatless-ab87@gregkh/=20
> now older Android userspace breaks with newer kernels because of this
> commit, which you all even agreed might happen here!
>
> So either you have a policy of "we only care about libfuse use cases
> for this api", or you don't, which is fine, just say so.  But that's
> not what the changelog says.

But I agree, it seems we're stuck and I'm not sure how to resolve this
either, Miklos has his points, Android has a different position.


Cheers,
Andre'

