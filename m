Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5BC7584DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGRSby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGRSbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:31:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A003DD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:31:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so17834a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689705108; x=1692297108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJRfS2iQxUWH+byKp3jNigM7HLEQCRK1+MsC766nIxg=;
        b=VK3F1CCmO1RTo+Kf7Jb50AL8WhJi1OWC3MufV3fw9hjO+tfsdxy7hGFHK0FaRcx+n6
         MaRDv6DguXyvDuAlndnTBKoMnltFmqHIq+H7yexvaKRvhxr8esLudAhH9eqQV+0VW0Zx
         L6BOB85oJyZibh+iSelSeniCE38iT1wZZWyw/dZD2c+W+HTwH7e+9uoH2z1oFyz0oU6T
         tUbfY9l8iDUy2Ofw1s7u11N/2Og3cg34JxQV1FbFy0uyWRq8o7bqNgB8XbP9v9/Dp4v6
         e8JxXFzZfR1VdPcc7QdYEZkkzZsftK4a6ljNnMU7qpJXLW1dqucxdG7iFKmo9u9CcbwD
         pSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689705108; x=1692297108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJRfS2iQxUWH+byKp3jNigM7HLEQCRK1+MsC766nIxg=;
        b=PX4RV7C49obf7J8+zCs9DfRmNbivpVgZS0Mj9KpQALS/k2SFJfZ4EkjCb40SZlkFMC
         aZy8DSJtIDNlz+ajMIh+zvvn51AvVbJsUdx6rYHjuD+W5LqLZReOdgmAQ25MspfRzeVJ
         W2by3NAjsyBUiwUj2sot5B+bRw4fdcUmN7u5VQmoeTNOoLQtRX3EH09BF6Wi9oYsihTB
         c1xR6S9z1C1FWEXVxuwJbEMB6g6cDzR7EF8lBR9UmxsV8EvN8RpRtNjBvnd8aUK28jvy
         D/LjgRb7/rag7DtBMpcnZAPKLOcsoPT1xpMvEeHAFb3zjI/PeZ1umQrbHxh6psTI02he
         z3oQ==
X-Gm-Message-State: ABy/qLbho3hh2LA7LFxIOMrnpdgVAtdNhtk13lW1mLpw9Jw9O/Y2u4qd
        4ugjezg76l67vY8Sk/uXMUkeThbrsGQwj48a+5u4YA==
X-Google-Smtp-Source: APBJJlHVNVX4lMT4yqXasU4j9zkQHNPFeqEDpi2W7xK5jJyVyePMS9TC3zw0WklS4fCsBfR/dDebogwQVATMujTXuRY=
X-Received: by 2002:a50:bae1:0:b0:51e:5e41:a0b2 with SMTP id
 x88-20020a50bae1000000b0051e5e41a0b2mr181591ede.2.1689705107580; Tue, 18 Jul
 2023 11:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com> <20230707210947.1208717-3-rmoar@google.com>
 <CABVgOS=ttFomNVdsKAY1FZCuzi46vii=ESdGU3VeYs-pRfoPNA@mail.gmail.com>
In-Reply-To: <CABVgOS=ttFomNVdsKAY1FZCuzi46vii=ESdGU3VeYs-pRfoPNA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 18 Jul 2023 14:31:31 -0400
Message-ID: <CA+GJov7qG9VVp7EhnVKKBe-X1rh4QZ2u3w8WOFVdsaFp=vYpLA@mail.gmail.com>
Subject: Re: [RFC v2 2/9] kunit: Add speed attribute
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 3:39=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 8 Jul 2023 at 05:09, Rae Moar <rmoar@google.com> wrote:
> >
> > Add speed attribute to the test attribute API. This attribute will allo=
w
> > users to mark tests with a category of speed.
> >
> > Currently the categories of speed proposed are: normal, slow, and very_=
slow
> > (outlined in enum kunit_speed). These are outlined in the enum kunit_sp=
eed.
> >
> > The assumed default speed for tests is "normal". This indicates that th=
e
> > test takes a relatively trivial amount of time (less than 1 second),
> > regardless of the machine it is running on. Any test slower than this c=
ould
> > be marked as "slow" or "very_slow".
> >
> > Add the macro KUNIT_CASE_SLOW to set a test as slow, as this is likely =
a
> > common use of the attributes API.
> >
> > Add an example of marking a slow test to kunit-example-test.c.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> Looks good.
>
> Reviewed-by: David Gow <davidgow@google.com>
>

Thanks!

> >
> > Changes since v1:
> > - Remove the "fast" category of speed.
> >
> >  include/kunit/test.h           | 30 +++++++++++++++++++++-
> >  lib/kunit/attributes.c         | 46 +++++++++++++++++++++++++++++++++-
> >  lib/kunit/kunit-example-test.c |  9 +++++++
> >  3 files changed, 83 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 1fc9155988e9..c255c98a58f7 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -63,8 +63,25 @@ enum kunit_status {
> >         KUNIT_SKIPPED,
> >  };
> >
> > +/* Attribute struct/enum definitions */
> > +
> > +/*
> > + * Speed Attribute is stored as an enum and separated into categories =
of
> > + * speed: very_slowm, slow, normal, and fast. These speeds are relativ=
e
>
> Nit: we only have very_slow, slow & normal now.
>

Oops thanks for catching this. Will fix this before I send out the
official patch set.

> > + * to other KUnit tests.
> > + */
> > +enum kunit_speed {
> > +       KUNIT_SPEED_UNSET,
> > +       KUNIT_SPEED_VERY_SLOW,
> > +       KUNIT_SPEED_SLOW,
> > +       KUNIT_SPEED_NORMAL,
> > +       KUNIT_SPEED_MAX =3D KUNIT_SPEED_NORMAL,
> > +};
>
> A part of me feels that we could get away with reversing the order of
> this and having KUNIT_SPEED_NORMAL =3D=3D 0. (Possibly reversing the
> comparisons in the filtering, too.)
>
> That's probably not worth the added complexity though. Either way,
> maybe add a note that "UNSET" =3D=3D "NORMAL".
>
>

Yes, I definitely have been debating this order myself as well. This
order makes slightly more sense to me so I will likely keep this for
the next version but I will add that note. If there are more comments
on this, I am definitely open to reversing the order.

> > +
> >  /* Holds attributes for each test case and suite */
> > -struct kunit_attributes {};
> > +struct kunit_attributes {
> > +       enum kunit_speed speed;
> > +};
> >
> >  /**
> >   * struct kunit_case - represents an individual test case.
> > @@ -150,6 +167,17 @@ static inline char *kunit_status_to_ok_not_ok(enum=
 kunit_status status)
> >                 { .run_case =3D test_name, .name =3D #test_name,    \
> >                   .attr =3D attributes }
> >
> > +/**
> > + * KUNIT_CASE_SLOW - A helper for creating a &struct kunit_case
> > + * with the slow attribute
> > + *
> > + * @test_name: a reference to a test case function.
> > + */
> > +
> > +#define KUNIT_CASE_SLOW(test_name)                     \
> > +               { .run_case =3D test_name, .name =3D #test_name,    \
> > +                 .attr.speed =3D KUNIT_SPEED_SLOW }
> > +
> >  /**
> >   * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct ku=
nit_case
> >   *
> > diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> > index 9bda5a5f4030..e97096dbb3b1 100644
> > --- a/lib/kunit/attributes.c
> > +++ b/lib/kunit/attributes.c
> > @@ -40,9 +40,53 @@ struct kunit_attr {
> >         enum print_ops print;
> >  };
> >
> > +/* String Lists for enum Attributes */
> > +
> > +static const char * const speed_str_list[] =3D {"unset", "very_slow", =
"slow", "normal"};
> > +
> > +/* To String Methods */
> > +
> > +static const char *attr_enum_to_string(void *attr, const char * const =
str_list[], bool *to_free)
> > +{
> > +       long val =3D (long)attr;
> > +
> > +       *to_free =3D false;
> > +       if (!val)
> > +               return NULL;
> > +       return str_list[val];
> > +}
> > +
> > +static const char *attr_speed_to_string(void *attr, bool *to_free)
> > +{
> > +       return attr_enum_to_string(attr, speed_str_list, to_free);
> > +}
> > +
> > +/* Get Attribute Methods */
> > +
> > +static void *attr_speed_get(void *test_or_suite, bool is_test)
> > +{
> > +       struct kunit_suite *suite =3D is_test ? NULL : test_or_suite;
> > +       struct kunit_case *test =3D is_test ? test_or_suite : NULL;
> > +
> > +       if (test)
> > +               return ((void *) test->attr.speed);
> > +       else
> > +               return ((void *) suite->attr.speed);
> > +}
> > +
> > +/* Attribute Struct Definitions */
> > +
> > +static const struct kunit_attr speed_attr =3D {
> > +       .name =3D "speed",
> > +       .get_attr =3D attr_speed_get,
> > +       .to_string =3D attr_speed_to_string,
> > +       .attr_default =3D (void *)KUNIT_SPEED_NORMAL,
> > +       .print =3D PRINT_ALWAYS,
> > +};
> > +
> >  /* List of all Test Attributes */
> >
> > -static struct kunit_attr kunit_attr_list[] =3D {};
> > +static struct kunit_attr kunit_attr_list[] =3D {speed_attr};
> >
> >  /* Helper Functions to Access Attributes */
> >
> > diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-t=
est.c
> > index b69b689ea850..01a769f35e1d 100644
> > --- a/lib/kunit/kunit-example-test.c
> > +++ b/lib/kunit/kunit-example-test.c
> > @@ -220,6 +220,14 @@ static void example_params_test(struct kunit *test=
)
> >         KUNIT_EXPECT_EQ(test, param->value % param->value, 0);
> >  }
> >
> > +/*
> > + * This test should always pass. Can be used to practice filtering att=
ributes.
> > + */
> > +static void example_slow_test(struct kunit *test)
> > +{
> > +       KUNIT_EXPECT_EQ(test, 1 + 1, 2);
> > +}
> > +
> >  /*
> >   * Here we make a list of all the test cases we want to add to the tes=
t suite
> >   * below.
> > @@ -237,6 +245,7 @@ static struct kunit_case example_test_cases[] =3D {
> >         KUNIT_CASE(example_all_expect_macros_test),
> >         KUNIT_CASE(example_static_stub_test),
> >         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
> > +       KUNIT_CASE_SLOW(example_slow_test),
> >         {}
> >  };
> >
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
