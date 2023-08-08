Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D77743F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjHHSOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjHHSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:13:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF8744A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:19:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5223910acf2so755a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515146; x=1692119946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5tJzzmRT4rdUMQj/IcPHKZl4bEv/tjuaSpGwRsgKPk=;
        b=ryD4F5kMCOcPdcY3gOJ06eaoqc+5ARtn7UgwyWxoiE89Bb2OvMo//rqsowOviBw2iV
         R/JJs4PoyvTqb519HapKdLWkHu1XHVFEcLAhHjKOpuYusKx2AmtQNyYOoWsPtmFgIq1o
         t3rfI4P8IX9DTRL957Y7V+a4f8FnN3KrqtDGTvuc+QBfoSW+Mzy4JgyJ5LxWSfjnXgmZ
         C847Fy2ywSQ2FA2NB24LLx/sBcGNeInWgbUMo9R90ufeg1Z/0taIRcZ2Af2PgdLmIqHa
         2Sell3+noTtH1eRM7byfI9Ow2sSshE6+zZMLQjDQCk1bvx0CfhGr93Yx7QuEg5HcqB9t
         5Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515146; x=1692119946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5tJzzmRT4rdUMQj/IcPHKZl4bEv/tjuaSpGwRsgKPk=;
        b=k2qrjAcRZ0Yu9oTOCJnYUVmvpk4UZgtexooIp4H1d9oTwlIPhf/+lvnVzuIMBMeCU3
         YcHyYLwfkYKgJK2UFg0tRf7G3FUhsMea05QyY13RW+UtRuRVkZtVFQt+SQJkKU/WKIt8
         WicutnyOuJr4lSB7JQQkftWG1F/AVRjH9z3eZpj/mZhZpmEY16v4+V9/Ax7U/n5pad1B
         0eCyaD6rsmdOkuN1E6P3aXHPcd5yyct+gHmngYQeN9XZS+NmAHBtGypJexdz/EacXLH8
         /yyRtVN/dVA/3XOTzimL0e6BLg/rG4W7B+8iA9ZDv0IvE2fYWrWRjeeV3IZD5Q2uf5qt
         csQg==
X-Gm-Message-State: AOJu0Yx7mkPJXZjSOGtmklhYI0mE4UxOZK7NOGYw88mVQa5fkmPgq+YH
        BOibvSS2KF3r6tRqwlWcLq71NQ3MEubmySGg7ektt9//LGqT8FAeFGM=
X-Google-Smtp-Source: AGHT+IFraQ0OcIWw4OFyPefngCmKF1+A14fe6gIk1IZceTxJUf6o9Mr0SifYlTI7pCN2/4k8cfiNcRMbcptc64cAum0=
X-Received: by 2002:a05:600c:1f93:b0:3f7:e4d8:2569 with SMTP id
 je19-20020a05600c1f9300b003f7e4d82569mr264291wmb.5.1691480868259; Tue, 08 Aug
 2023 00:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230807102352.4607-5-janusz.krzysztofik@linux.intel.com> <20230807102352.4607-8-janusz.krzysztofik@linux.intel.com>
In-Reply-To: <20230807102352.4607-8-janusz.krzysztofik@linux.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 8 Aug 2023 15:47:36 +0800
Message-ID: <CABVgOSnjy=LCRTDHvjSUAr+SF=GKwGs7kgeYjN29xSNvG84NKg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] kunit: Allow kunit test modules to use test filtering
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006c43d806026c8f86"
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006c43d806026c8f86
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Aug 2023 at 18:28, Janusz Krzysztofik
<janusz.krzysztofik@linux.intel.com> wrote:
>
> External tools, e.g., Intel GPU tools (IGT), support execution of
> individual selftests provided by kernel modules.  That could be also
> applicable to kunit test modules if they provided test filtering.  But
> test filtering is now possible only when kunit code is built into the
> kernel.  Moreover, a filter can be specified only at boot time, then
> reboot is required each time a different filter is needed.
>
> Build the test filtering code also when kunit is configured as a module,
> expose test filtering functions to other kunit source files, and use them
> in kunit module notifier callback functions.  Userspace can then reload
> the kunit module with a value of the filter_glob parameter tuned to a
> specific kunit test module every time it wants to limit the scope of tests
> executed on that module load.  Make the kunit.filter* parameters visible
> in sysfs for user convenience.
>
> v5: Refresh on tpp of attributes filtering fix
> v4: Refresh on top of newly applied attributes patches and changes
>     introdced by new versions of other patches submitted in series with
>     this one.
> v3: Fix CONFIG_GLOB, required by filtering functions, not selected when
>     building as a module (lkp@intel.com).
> v2: Fix new name of a structure moved to kunit namespace not updated
>     across all uses (lkp@intel.com).
>
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> ---

This works a treat here. It's a bit annoying to have to unload /
reload the module to change the filter, which might be something for
us to consider in the future (maybe via a debugfs entry?), but this is
nevertheless an improvement.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/test.h | 11 ++++++++
>  lib/kunit/Kconfig    |  2 +-
>  lib/kunit/executor.c | 63 ++++++++++++++++++++++++++------------------
>  lib/kunit/test.c     | 17 ++++++++++++
>  4 files changed, 66 insertions(+), 27 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 6a338a3267ed5..d33114097d0d0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -310,6 +310,9 @@ static inline void kunit_set_failure(struct kunit *test)
>
>  bool kunit_enabled(void);
>  const char *kunit_action(void);
> +const char *kunit_filter_glob(void);
> +char *kunit_filter(void);
> +char *kunit_filter_action(void);
>
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
>
> @@ -320,6 +323,14 @@ size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
>  unsigned int kunit_test_case_num(struct kunit_suite *suite,
>                                  struct kunit_case *test_case);
>
> +struct kunit_suite_set
> +kunit_filter_suites(const struct kunit_suite_set *suite_set,
> +                   const char *filter_glob,
> +                   char *filters,
> +                   char *filter_action,
> +                   int *err);
> +void kunit_free_suite_set(struct kunit_suite_set suite_set);
> +
>  int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
>
>  void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 626719b95badd..68a6daec0aef1 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -4,7 +4,7 @@
>
>  menuconfig KUNIT
>         tristate "KUnit - Enable support for unit tests"
> -       select GLOB if KUNIT=y
> +       select GLOB
>         help
>           Enables support for kernel unit tests (KUnit), a lightweight unit
>           testing and mocking framework for the Linux kernel. These tests are
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index e877c1f1e75c8..5181aa2e760b6 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -27,24 +27,37 @@ const char *kunit_action(void)
>         return action_param;
>  }
>
> -#if IS_BUILTIN(CONFIG_KUNIT)
> -
>  static char *filter_glob_param;
>  static char *filter_param;
>  static char *filter_action_param;
>
> -module_param_named(filter_glob, filter_glob_param, charp, 0);
> +module_param_named(filter_glob, filter_glob_param, charp, 0400);
>  MODULE_PARM_DESC(filter_glob,
>                 "Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
> -module_param_named(filter, filter_param, charp, 0);
> +module_param_named(filter, filter_param, charp, 0400);
>  MODULE_PARM_DESC(filter,
>                 "Filter which KUnit test suites/tests run at boot-time using attributes, e.g. speed>slow");
> -module_param_named(filter_action, filter_action_param, charp, 0);
> +module_param_named(filter_action, filter_action_param, charp, 0400);
>  MODULE_PARM_DESC(filter_action,
>                 "Changes behavior of filtered tests using attributes, valid values are:\n"
>                 "<none>: do not run filtered tests as normal\n"
>                 "'skip': skip all filtered tests instead so tests will appear in output\n");
>
> +const char *kunit_filter_glob(void)
> +{
> +       return filter_glob_param;
> +}
> +
> +char *kunit_filter(void)
> +{
> +       return filter_param;
> +}
> +
> +char *kunit_filter_action(void)
> +{
> +       return filter_action_param;
> +}
> +
>  /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
>  struct kunit_glob_filter {
>         char *suite_glob;
> @@ -108,10 +121,7 @@ kunit_filter_glob_tests(const struct kunit_suite *const suite, const char *test_
>         return copy;
>  }
>
> -static char *kunit_shutdown;
> -core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> -
> -static void kunit_free_suite_set(struct kunit_suite_set suite_set)
> +void kunit_free_suite_set(struct kunit_suite_set suite_set)
>  {
>         struct kunit_suite * const *suites;
>
> @@ -120,7 +130,7 @@ static void kunit_free_suite_set(struct kunit_suite_set suite_set)
>         kfree(suite_set.start);
>  }
>
> -static struct kunit_suite_set
> +struct kunit_suite_set
>  kunit_filter_suites(const struct kunit_suite_set *suite_set,
>                     const char *filter_glob,
>                     char *filters,
> @@ -218,22 +228,6 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>         return filtered;
>  }
>
> -static void kunit_handle_shutdown(void)
> -{
> -       if (!kunit_shutdown)
> -               return;
> -
> -       if (!strcmp(kunit_shutdown, "poweroff"))
> -               kernel_power_off();
> -       else if (!strcmp(kunit_shutdown, "halt"))
> -               kernel_halt();
> -       else if (!strcmp(kunit_shutdown, "reboot"))
> -               kernel_restart(NULL);
> -
> -}
> -
> -#endif
> -
>  void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin)
>  {
>         size_t num_suites = suite_set->end - suite_set->start;
> @@ -271,6 +265,23 @@ void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr)
>
>  #if IS_BUILTIN(CONFIG_KUNIT)
>
> +static char *kunit_shutdown;
> +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
> +
> +static void kunit_handle_shutdown(void)
> +{
> +       if (!kunit_shutdown)
> +               return;
> +
> +       if (!strcmp(kunit_shutdown, "poweroff"))
> +               kernel_power_off();
> +       else if (!strcmp(kunit_shutdown, "halt"))
> +               kernel_halt();
> +       else if (!strcmp(kunit_shutdown, "reboot"))
> +               kernel_restart(NULL);
> +
> +}
> +
>  int kunit_run_all_tests(void)
>  {
>         struct kunit_suite_set suite_set = {
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 5232a43737826..49698a168437a 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -740,6 +740,17 @@ static void kunit_module_init(struct module *mod)
>                 mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
>         };
>         const char *action = kunit_action();
> +       int err = 0;
> +
> +       suite_set = kunit_filter_suites(&suite_set,
> +                                       kunit_filter_glob() ?: "*.*",

I've just learnt a new gcc extension! A bit scary, but it works on
clang as well, so I'm fine with it.


> +                                       kunit_filter(), kunit_filter_action(),
> +                                       &err);
> +       if (err)
> +               pr_err("kunit module: error filtering suites: %d\n", err);
> +
> +       mod->kunit_suites = (struct kunit_suite **)suite_set.start;
> +       mod->num_kunit_suites = suite_set.end - suite_set.start;
>
>         if (!action)
>                 kunit_exec_run_tests(&suite_set, false);
> @@ -753,11 +764,17 @@ static void kunit_module_init(struct module *mod)
>
>  static void kunit_module_exit(struct module *mod)
>  {
> +       struct kunit_suite_set suite_set = {
> +               mod->kunit_suites, mod->kunit_suites + mod->num_kunit_suites,
> +       };
>         const char *action = kunit_action();
>
>         if (!action)
>                 __kunit_test_suites_exit(mod->kunit_suites,
>                                          mod->num_kunit_suites);
> +
> +       if (suite_set.start)
> +               kunit_free_suite_set(suite_set);
>  }
>
>  static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
> --
> 2.41.0
>

--0000000000006c43d806026c8f86
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
9IGQSBx2i4m+hGXJpET+MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQCRI3Z4cAidgFcv
Usqdz765x6KMZSfg/WtFrYg8ewsP2NpCxVM2+EhPyyEQ0k0DhtzdtGoI/Ug+jdFDyCKB9P2+EPLh
iMjMnFILp7Zs4r18ECHlvZuDZfH9m0BchXIxu5jLIuQyKUWrCRDZZEDNr510ZhhVfYSFPA8ms1nk
jyzYFOHYQyv5IfML/3IBFKlON5OZa+V8EZYULYcNkp03DdWglafj7SXZ1/XgAbVYrC381UvrsYN8
jndVvoa1GWwe+NVlIIK7Q3uAjV3qLEDQpaNPg1rr0oAn6YmvTccjVMqj2YNwN+RHhKNzgRGxY5ct
FaN+8fXZhRhpv3bVbAWuPZXoMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC5
OWIziW184Bl6vjbiYf7sQNq4RA2PJVRgLg8daP0XNzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MDgxNzE5MDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAip6NzNmz8ASbzu2q3OdO
MI5pKZiIR/bj5MKouSLsUD3imzaYM/53gi9+Bf2G9ujznRmKawjyO/AloVyBP6cdHxOKXbirgp0O
ncJJEJT+hUzHnYX6HzUv9WKKlVxdJa/E+s8XZBMyixU1ATL9iYO1PFEaPPWtPTso/3Ciwe/sWpbO
DM1VLsnNxvikbEdtrDUFsQQ9FcPlOjJ7usQNNpPQUJ/6vpa11aE0WgpTKXiDnsRsglHVZaZneoeK
Z2F55L+qETNWrTqKwbPAtQxHvotvV9Fe+4ZnP/MgAzODgAZfwmeNIeCUprZTOWtWcbuTu6VjePJx
bNIYzg09vaDLU282mA==
--0000000000006c43d806026c8f86--
