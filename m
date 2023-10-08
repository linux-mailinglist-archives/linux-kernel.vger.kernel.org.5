Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803217BCC9D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbjJHGZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344392AbjJHGZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:25:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A818C6;
        Sat,  7 Oct 2023 23:25:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9adb9fa7200so771334266b.0;
        Sat, 07 Oct 2023 23:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696746343; x=1697351143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NIZ6HwYzlFusyGWjEQKDrSy6Sb/ORrlNJfmg+KZe3c=;
        b=Kz5F2j3xWndNl+dWO3ChBKBPXrgh6Y9vGduQ2ADrxjWbJTrtsar0zGa4sGgO62Gg8a
         HdDwVLlH91JndqsVAGKbg9/CH6PJiAKKtIx39f2hOIEdKT8VAzycyOgMy6Y0obE5EFP+
         0ajHPy8KvwyyPLrB4mxjPACchcIyTf78QLpiGjAXXQ7+3LXb5FfIHH450M7f46JijqyV
         99xhCJx9cn/wEIGzXQPSQ3Tis926DKTMjrPZcoZzPW6pooA5VFzQMVu1nLPos5q2xqZk
         Fo+C7pos2R3OOVGe61+H9rbKNQT9R+HrighbolAXKr9tPI6VgTA94RgIZ6KJBplp6/Ms
         +isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696746343; x=1697351143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NIZ6HwYzlFusyGWjEQKDrSy6Sb/ORrlNJfmg+KZe3c=;
        b=c05BnJXj5d8G4+wf/d6kSqGTjBGfMkOK5ETKpJG5Pg2ZDAmDVFti3FcOocmS6QZMTJ
         HND8mAcuR+LWQ0m86bsIqPK6Tnpr70CqA79l+ErBQNZNHBh6Rzu+V1eaDSZrMic2+xNX
         coYmYJ4tHErTTAs4MZEpUGDnMwlYZ3mOZexKaeGBK4IiJlaQ9w7Ele0KVg+xP7PrZ5Iq
         L29dV0Z7zxFE1pfbE8ruLTuR8xGuthfu8NOnzNPLHwAl61QdPmTPNfL6o4chXr1w3rKb
         Cd9TeNTPwxTIhiIapR3KJwJV6Ybj6oJQPlle81znjmDJOAZAd2CmHZuMIFTqt5ty58fc
         L8EA==
X-Gm-Message-State: AOJu0YyI9d97bRWrvVfWG8wB8fNo8L9GGmXch0AIujuVPystEO4taySI
        eNy6TLwRNbRDdw0jA+P3icR9yufiyQ5lnofqVBY=
X-Google-Smtp-Source: AGHT+IEpDcKfqVoGO7slR9jC1Tekmva9MXv7wcLZDjo9EnCEFJ2wH7sVv0i+q1UEJL4O4/NvLOgmajsEq0xutLXvH7Y=
X-Received: by 2002:a17:906:32d4:b0:9ae:5866:9745 with SMTP id
 k20-20020a17090632d400b009ae58669745mr8906344ejk.21.1696746343496; Sat, 07
 Oct 2023 23:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com> <ZQggiuLyLGq/ekMS@smile.fi.intel.com>
 <CAM+2EuKXW+FsgY6rp=ugU03owJS6ReeWUNWOcMKiUfomiY_a2Q@mail.gmail.com>
In-Reply-To: <CAM+2EuKXW+FsgY6rp=ugU03owJS6ReeWUNWOcMKiUfomiY_a2Q@mail.gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sun, 8 Oct 2023 11:55:32 +0530
Message-ID: <CAM+2Eu+94awdDtC4RVuCe6Nq_QXj_A5-nv6=iuPLzgybHu1qSQ@mail.gmail.com>
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,


On Wed, Sep 20, 2023 at 4:13=E2=80=AFAM Jagath Jog J <jagathjog1996@gmail.c=
om> wrote:
>
> On Mon, Sep 18, 2023 at 3:34=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote:
> > > The Bosch BMI323 is a 6-axis low-power IMU that provide measurements =
for
> > > acceleration, angular rate, and temperature. This sensor includes
> > > motion-triggered interrupt features, such as a step counter, tap dete=
ction,
> > > and activity/inactivity interrupt capabilities.
> > >

...

> > > +static const struct attribute_group bmi323_event_attribute_group =3D=
 {
> > > +     .attrs =3D bmi323_event_attributes,
> > > +};
> >
> > ATTRIBUTE_GROUPS() ?
>
> Okay, I will use ATTRIBUTE_GROUPS.

The ATTRIBUTE_GROUP(bmi323_event) macro will define two variables,
bmi323_event_groups and bmi323_event_group. The event_attrs member
of iio_info is of type struct attribute_group*, which means that
bmi323_event_groups will remain unused. Since I am using a single
event group, Can I keep it the same way?


Regards
Jagath

Jagath
