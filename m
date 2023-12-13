Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA49810B30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378678AbjLMHNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjLMHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:13:33 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A984109
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:13:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso5689a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702451616; x=1703056416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CySHbFNihEKJypUz43arLxA13iJ+ywCfajnfMajq70Q=;
        b=ZsjSB0u1gaon2FcFB8ZlchO6Y5YCCj8JZqQExxZlfZLrvzvIcJKIg6A6kn4i6q4bxN
         j3ea8Kl3M1lN4rxSMkN4ZmB/4YkBv9QYHOm4PF8uNXrGRkRRJY+aOuES1AuLBbStKLwI
         EUj0RukDTZBZ5y7DGpUKJvsRtrqg7kf4gv/deZ0JjKIku+U8CgS9rj1u4zq54VJ1AzCh
         Fg7Y03J7lHSnmOtb5uMf3Vitga3WK7Jb/Z0Lu7uN/hIRCju7Fyr2/uYCoaYpjNMj2U87
         RXj3BwZVYy9Yj52wUjd1macFfqgbkKYaZ5YAbxAXex3ZSnauPclaHsaP+LSGB+JRKsHZ
         jzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702451616; x=1703056416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CySHbFNihEKJypUz43arLxA13iJ+ywCfajnfMajq70Q=;
        b=lJlWNKEu0yA1MA/Fy8oVVaV20nmCyr0yu0wikE/h81c8WB4T5a87SNp1WqwZvN+oHK
         jixvhh4aqdO2f/NjVDbzKsyJpHuOrSE+73qR/LJFikKgQiNF1OT+utQy+PauBiykao8f
         7jSt/B3/VOmnmTVpIT9fksFK5tx9vGGyu59hDM+QeNTR+RGOefjJR5TXpnXy+8vRvkiP
         aHP5EeP0JVfW6H6pfN6Qyasa0C2HglGWdPWlTfFC9nBpYFO6idOxCQguM43TeD5Ormyx
         q4kJDNG61YsRBTERrP73DxpLeFnVPDwBkYpMHxlE49TkMdLmvEZHo1o57esRmPMsc9eM
         qLmg==
X-Gm-Message-State: AOJu0YxWidBn7vkzUgFtlMoapxyAytZugMWG9uzXzZsU1dLSOJaKffAU
        pAy5ImeHmwqfS9VBtmU+198NAfw3oNSV+jj9uvb1iQ==
X-Google-Smtp-Source: AGHT+IEM1kOIuphEqfzrZd8Lq3/vYg/WFrUXV4kjMhsDwYBCMUeA7vM00dEA1sSZwBeUnhsh1M+TUTrJDhLbPt/1Pcg=
X-Received: by 2002:a50:c192:0:b0:54c:f4fd:3427 with SMTP id
 m18-20020a50c192000000b0054cf4fd3427mr458949edf.7.1702451616197; Tue, 12 Dec
 2023 23:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com> <20231213010201.1802507-3-rmoar@google.com>
In-Reply-To: <20231213010201.1802507-3-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 13 Dec 2023 15:13:24 +0800
Message-ID: <CABVgOS=tUmp1noFpOiQfxnBi29fYWoWtVaz7-VTr1ckN6pVkJA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] kunit: add example suite to test init suites
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000db25da060c5ee758"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000db25da060c5ee758
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 09:02, Rae Moar <rmoar@google.com> wrote:
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
> Changes since v3:
> - I ended up not changing anything as adding __init to the test gave
>   a build warning. It did still work so I could add it back if wanted.

I had another look at this, and I think the most correct solution here
is to make the test __init, and the array of tests __refdata.

(Ideally this would be something we could wrap in a macro, but I think
it's fine to just have it written here for now, so it's explicit in
the example._

How does that sound?

-- David

>
>  lib/kunit/kunit-example-test.c | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 6bb5c2ef6696..18495778de7c 100644
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
> +static void example_init_test(struct kunit *test)

Add __init here.

> +{
> +       KUNIT_EXPECT_EQ(test, init_add(1, 1), 2);
> +}
> +
> +/*
> + * The kunit_case struct cannot be marked as __initdata as this will be
> + * used in debugfs to retrieve results after test has run
> + */
> +static struct kunit_case example_init_test_cases[] = {

Make this 'static struct kunit_case __refdata example_init_test_cases[] = {'...


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

--000000000000db25da060c5ee758
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAB
opzJXx00VyA7Vn6SnDcgNQP8PsnMGMOuo71Ec++DOjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMTMwNzEzMzZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEApLzgiwU5c2fMe8dm0br5
GeblHCl33Rx6hl4bSkoup31jDW8+qDljh/UswNUI5KbT4MmMC+sL1eKkyqJU6J6c+vv4VCjy5liC
8vWYOF5RiTo2Tba4A9pbq2v32nI6Z//fDEmBXElId7fqQECa+eJ6QMU0X+GA2/lNcOYLeUpz5kwC
EAA9gQgPgTpgq83y09ojt/hfQnmO3ENpb7oUe3ForTvcLr7dsgemO5tUTdtppZOUn8pk9G7OPadx
ryBO2KGm3eKtB7zLJ88GUeqNXbE/aNCiNP7Ox0/qZKGDN8GpIrraK4I2+B5gpVV28NIidmTMJeOu
svhopC3SOUYObeKwHw==
--000000000000db25da060c5ee758--
