Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7A97AAAF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjIVH4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjIVH4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:56:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF88D197
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:56:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98377c5d53eso218108766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695369396; x=1695974196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOczsUF+BCYrh6dDHSzppLS2kdf/aZwXvn7gPWWOBaI=;
        b=shGf+TxTG0fV+dZwQFUkOKEU21lL9PDV6wEo64OLjI/1qkO0Jf/ERpo9Ro2OdPqEHX
         Quc6ZNXnMJdzgsS/NGyjE9HMudkratX5dprikaTNGYYGtWnLhr6oW7eHvjAvmVLmBXxk
         woMH7gFYVSRJ5423ANVbqCfOqdvtG9Wg7Y/Oe53BuiLwyvChL0/GzPkNg5mD54gLY5H7
         78F79aEIYy1tS28g7zagKd7WVOjcBFP+FqVRfWwPzmyxOLtkmQwnjmKNmR2F9k474HgR
         p1mkhws40hw2R4UBvtw9yWO2SQ/QehUvoEhAP+JSGgauQhNGlvp16pVrbM6DYxbFz/Eq
         I5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695369396; x=1695974196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOczsUF+BCYrh6dDHSzppLS2kdf/aZwXvn7gPWWOBaI=;
        b=ZGtVB8gIo5YMZ/mvVu8vSi+oVRKhsKxiH7S404i8cJAziQTqlV4HCI6yQGRCVfgdSO
         Opj4evN9Q8cMdfX6hR+aEc1bXeEXDZeFl5aaSCUf9OAVnswafUbJ22r5OBfDUB7DEgJo
         ETPNb8JvYFkrLlamx9RK1ourOIDoqN4rkyMrD2dau/4VxmzmlUMvFwvSd+8nfNVLiR8S
         F1zX7ELnRCnNPl4GT7yx5c2gToC92Xfi3WYrEPk+OcELJ8S9j6jpJcfjQEIdtr/fgT/J
         fmVFrmn1iWObCvHwkm8i2U2Mh6sKbfHSwVBrfnBX29sCe4r3EJNHfb0/pKasDQBhSSe9
         UgSA==
X-Gm-Message-State: AOJu0Yyloj0z1PgGHA0vDA3i2KUr/NHoTodtKkFpRy6AJi32TzGL2rc+
        uv0xxg40wY1aS4E6k9vRVj1E+1ZWiwZ9kE1Y9cr2699MUgJFbceG
X-Google-Smtp-Source: AGHT+IHJkhjBPXZRFF/OS5Z6jauyAMcCVTAOx/S3WXMuSFszFyeFwmzr+cmcR4dQYflZoedGLikHXQ4VZkiOC2bdwt8=
X-Received: by 2002:a17:907:7712:b0:9ae:6ff4:9f15 with SMTP id
 kw18-20020a170907771200b009ae6ff49f15mr1925645ejc.11.1695369395757; Fri, 22
 Sep 2023 00:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230919024943.3088916-1-tylor_yang@himax.corp-partner.google.com>
 <20230919024943.3088916-2-tylor_yang@himax.corp-partner.google.com>
 <20230919-70b2f1e368a8face73468dfa@fedora> <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
 <20230919-cc4646dbfb953bd34e05658c@fedora>
In-Reply-To: <20230919-cc4646dbfb953bd34e05658c@fedora>
From:   yang tylor <tylor_yang@himax.corp-partner.google.com>
Date:   Fri, 22 Sep 2023 15:56:25 +0800
Message-ID: <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI device
To:     Conor Dooley <conor@kernel.org>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        "jingyliang@chromium.org" <jingyliang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wrote:
> > Hi Conor,
> >
> > > > Additional optional arguments:
> > > > ic-det-delay-ms and ic-resume-delay-ms are using to solve runtime
> > > > conditions.
> >
> > > Runtime conditions? Aren't th=D1=94se properties of the panel & there=
fore
> > > fixed? If they were runtime conditions, then setting them statically =
in
> > > your DT is not going to work, right?
> >
> > Because each platform's display driver ready time is different. TP part
> > need to avoid this timing by measuring the waveform of LCD reset pin
> > low period and TP probe timing. For example, if LCD rst pin low from
> > timestamp 100 to 800, TP driver probe at 600. TP probe will fail. Then
> > user should set ic-det-delay-ms bigger than 200, to avoid LCD rst low
> > timing. As you can see, the timing needs to be measured at runtime to
> > decide how long it should be. Then, if the condition is not changed, th=
e
> > value could keep the same.
>
> That sounds to me like something you would test once for a given
> platform and then the values are static. If you are actually changing it
> at *runtime*, how is doing it through DT suitable? Does your firmware do
> the tests & then set the values in DT dynamically?
>
Yes, you are right. I'll change the description.

> >
> > > It looks like you deleted all of the properties from the previous
> > > submission of these changes. I don't really understand that, it kinda
> > > feels just like appeasement, as you must have needed those properties
> > > to do the firmware loading etc. How are you filling the gap those
> > > properties have left, when you still only have a single compatible
> > > string in th=E3=84=9Fs binding? Is there a way to do runtime detectio=
n of which
> > > chip you're dealing with that you are now using?
> >
> > After reviewing, I found the properties could go to IC driver settings =
:
> > "himax,heatmap_16bits" because it depends on IC's ability;
>
> How do you detect the IC's abilities?
>
The driver code has a part of IC detect process, and each IC has its own
driver code to define its abilities. This part moves to that position.

> > Some
> > could remove and use default values: "himax,fw_size",
> > "himax,boot_time_fw_upgrade". "himax,fw_size" has a default value in
> > IC settings, and likely won't change in this IC.
>
> Okay.
>
> > The behavior of "himax,boot_time_fw_upgrade" seems not stable and
> > should be removed. "himax,fw_in_flash", I use the kernel config for
> > user to select.
>
> That seems like a bad idea, we want to be able to build one kernel that
> works for all hardware at the same time.
>
I see, so I should take that back?
I'll explain more about it.

> > "himax,pid" could be remove and use default firmware name
> > "himax_i2chid.bin" to load. It was added because users may desire to
> > choose a special name like "himax_i2chid_{pid}.bin" instead of the defa=
ult
> > one.
> > It also could be replaced with newly added "himax",id-gpios" which is s=
till
> > experimental.
>
> Also, pleae don't top post, but instead reply in-line with my comments,
> as I have done here.
>
Ok.

> > Btw, I encounter an error of patch [2/2], which says:
> > BOUNCE linux-input@vger.kernel.org: Message too long (>100000 chars)
> > and the patch didn't appear at patchwork.kernel.org. What should I do t=
o
> > deal with this problem?
>
> No idea. Maybe try to split it into multiple patches?
> The other option is to also cc patches@lists.linux.dev as that has some
> higher capacities, but that's not going to be a silver bullet.

Thanks for the reply. I'll try multiple commits to reduce the size.

Thanks,
Tylor
