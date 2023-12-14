Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879E88125BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443043AbjLNDFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjLNDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:05:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F503E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 19:05:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso3998a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 19:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702523105; x=1703127905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IVrg+y9yIpujhdIPX5HknKMa5FLgpbZgvEAjU5qzF7U=;
        b=ZGQaPUWXO0yV3LKTwGKmUg4e+AQZ5gWplSBCjqVgyuWBeBHkUBd2jM/Mp4fGLZ1Hrj
         Jeh7HFBEohdQFxeot/TP94hqYAS+nJcZqUQhl+dmqTzLKa8Wv2kxSiUqyqH3rLarzP2a
         nV3RNTM4bScRd/O/00Ty8cc1/4XqpGEXbV94+grk6cGaCHt/A8XJd6DOgA+RdXjfaZeR
         p8TvkIC9BuHjB6Hm1BB5g+EaPCKnTxu7boY+srMacAM+KGec59eORnW2NuvgQyrgTeK2
         /BXVH3gdh6wDb86nFtUEWWeaUmua9Lh/TUP6LPldr02WwtEmkMlae8scYuamMM/IvvtT
         5FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702523105; x=1703127905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVrg+y9yIpujhdIPX5HknKMa5FLgpbZgvEAjU5qzF7U=;
        b=PHDJRl16LcMK9nQHeT/DXjAmrtq9aagXrTryuYm7MuHvyVuuY9mkGwMNUZcpi33drm
         Xi9rKXHZfVe/cRuiJpw5FmP1Kf8nAIr9l5m10wyvKm7OsMWR8JDT0OXPyIKVoTtdPEuw
         dW5BPWOvrZCGfTLWOTSrix1jW2WZd9O0AMrf10cm08S99r6Wz63g/O/6DDjuEEXHvo7G
         KOpPf2K/HAu6nYsEc97eJgLYIJnIM2IyQ4qZd4QooqkZivz7GCTGE9nS3GGDJRr7uj3a
         UHka1Gn/B1jJuHfmbP+71mt/XtJUY8qvgoWLi3HlFpyt14APj2DPdE6jK9cIyVWVqm3O
         emug==
X-Gm-Message-State: AOJu0Yx5WCQG3uDFgDO84d26o6VAee9U5VEVcoR6BLZ6tiHSymYmX78N
        /Kdjgr7APW4atXVFGqXaHlpCiyhI5+BjP/VXGJ6aew==
X-Google-Smtp-Source: AGHT+IGppbMjJWraWWXBqhbwuXXQinv7RYjogPmOjSjNA7t8g6dLDmds5BnMlL8zw/Lhizsi1L+OWpnWzQ+NMt/rDuI=
X-Received: by 2002:a50:d08f:0:b0:552:365c:6960 with SMTP id
 v15-20020a50d08f000000b00552365c6960mr127029edd.2.1702523104665; Wed, 13 Dec
 2023 19:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com> <20231213194421.2031671-3-rmoar@google.com>
In-Reply-To: <20231213194421.2031671-3-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 14 Dec 2023 11:04:52 +0800
Message-ID: <CABVgOSk-6mmHTK4K1FfdEC8pG0HDPAttOxm-ziFJYspDwn_OPA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] kunit: add example suite to test init suites
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e767c8060c6f8c96"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e767c8060c6f8c96
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 03:44, Rae Moar <rmoar@google.com> wrote:
>
> Add example_init_test_suite to allow for testing the feature of running
> test suites marked as init to indicate they use init data and/or
> functions.
>
> This suite should always pass and uses a simple init function.
>
> This suite can also be used to test the is_init attribute introduced in
> the next patch.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks -- this looks better to me.

Reviewed-by: David Gow <davidgow@google.com>

-- David

> Changes since v4:
> - Mark test as __init and then set cases as __refdata to supress modpost
>   warnings
>
>  lib/kunit/kunit-example-test.c | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 6bb5c2ef6696..d2f7a3c62c18 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -287,4 +287,41 @@ static struct kunit_suite example_test_suite = {
>   */
>  kunit_test_suites(&example_test_suite);
>
> +static int __init init_add(int x, int y)
> +{
> +       return (x + y);
> +}
> +
> +/*
> + * This test should always pass. Can be used to test init suites.
> + */
> +static void __init example_init_test(struct kunit *test)
> +{
> +       KUNIT_EXPECT_EQ(test, init_add(1, 1), 2);
> +}
> +
> +/*
> + * The kunit_case struct cannot be marked as __initdata as this will be
> + * used in debugfs to retrieve results after test has run
> + */
> +static struct kunit_case __refdata example_init_test_cases[] = {
> +       KUNIT_CASE(example_init_test),
> +       {}
> +};
> +
> +/*
> + * The kunit_suite struct cannot be marked as __initdata as this will be
> + * used in debugfs to retrieve results after test has run
> + */
> +static struct kunit_suite example_init_test_suite = {
> +       .name = "example_init",
> +       .test_cases = example_init_test_cases,
> +};
> +
> +/*
> + * This registers the test suite and marks the suite as using init data
> + * and/or functions.
> + */
> +kunit_test_init_section_suites(&example_init_test_suite);
> +
>  MODULE_LICENSE("GPL v2");
> --
> 2.43.0.472.g3155946c3a-goog
>

--000000000000e767c8060c6f8c96
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
ddIn9n5Jt6Z1o79zxraLMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBtHFwIgQZjer5K
H+4Q+wns10k7qN+4wN2Uf+JsyOYjukaMEgdLErfA1wwtQ9uHkoYQZcWBuVVkQFa5hI+sqI2m1Weq
riMCFSiU38s1tADdMX12IMfJRN60Nznhrw+nPyDRZqRhUTW24TwnHorkDnFPW8PHo7fAw4FrpI0n
impZAng7ccvvK09K3ZuhwTIxJMsPXCZYsrXWORTw5sczRAP6XvKbPBJnsJoSTe5dFBPBHOQJOGhU
qWfEfWnWMJPF3LxSGLpLFQXO3RwQqmxv08avwXfVPouh1xuB3FX7rpDabT8YDhu9JgIZkLEKko7L
yQt6zWwng7k8YF/jGbiAta6VMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC6
Aa9GsMwGrFjWpbRbINppmiFGTkepZa4bgdiaVxmx5TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMTQwMzA1MDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAShnnuJuSnlbDxW8PWc3t
E8OgVWSlLQwDFDyC7Vxv3I0Wjij8GrmXyT1GayZgtifQjuv3uFVljzg57G0GbFGxLwrVHjMPzXb5
UtghR6WCe8KeHSi1me0SgimMMDrSav2qtYVvxS0ciKmG13owi7ZF80ZBbgRIphloCU8wSHsdA7O9
lVkWSbCWNJ6ywCYVxAIKS7DV2v1466Y4wghwhzXIYO6Cv1XzRh1bxwvId/EUTJq0GqW4mTWrl00v
hK8SWvcmUYgVnTTYud0lzWkWGEkutI5l2fsyDyT4+ZfhBb8THMTu3pDz3vFU2xP3+sig0AHYoGqu
SUvbCP5GAy82oFc6eA==
--000000000000e767c8060c6f8c96--
