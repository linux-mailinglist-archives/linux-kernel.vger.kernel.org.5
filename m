Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2E75B994
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjGTVbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGTVbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:31:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24B2111
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:31:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1627a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689888688; x=1690493488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+TZv+9vK9meP7yrsiegPH7fftVme4KMzKQcTAi+dYg=;
        b=J9e30X5mOAwxlKHrwP2CbSu1F/CG6CRF7CJdwE5hWdatry0QdC7GvE9sa2GAUHmqfx
         BQnNh2u/B8EU2isZoPyJaY55LxZr8Wk7ijCpORBGrRQRtcI9DRSQa1JxA+IpFvev3qHQ
         2NETPb6LKzoIq9u5qvcHNgD/tLM6DhBjaeNaA/47QL1sXQacbivg0MR8Mg4hi0l70+UI
         z9aWO1z0PneeUD7Gx5YAfVdbYnZ5MQ4/NvrTPiy0rWggWHYTSo+esvZacmx3WmPFCilh
         cFtM8RiYLG+6x9amz7i0XqnUCojw/43ZFwPD+JXlTBit32B5TjQlPciHIN99sayBH5Rx
         tn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689888688; x=1690493488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+TZv+9vK9meP7yrsiegPH7fftVme4KMzKQcTAi+dYg=;
        b=f2s/lAKHLIybC7lfyExVbJQEy7H7Dl/WCVpQoExd6fvOKVkxqsNOxC/zXSCz28KLsU
         A+nPCzg0uIEHruGhQiC/niROtJKQM1vHyF69v/Z/3HgQmL1AiY7rCZ68mJnl+aW15G4e
         WWWJAGkJEsZV3qPncx458XukBXi5vS5yoKxs4UdCHjBUjPCqFC2PMiGvljhqisRGaTr9
         KvXXT25Tqm8BAAaIwWNHH3VagYD3VwxbW8ItaM/2AK1w5JfsAd3pOkQabJM8Ri9fmK5U
         lHUBtJGPezRhPBAnOHLSYjXbzyTdBVMYDEp6eNQoTlZqnMA+pEDekOvsQn3eXoaCjR9N
         gknw==
X-Gm-Message-State: ABy/qLauaosI1G3ZCUchcZXW6n+VR358COxGXhXH4KZZWzBHuZkNbWfb
        NqvKR7SB7tTyaak5kHZLYqV5DXqzbegn9YclsLTxlg==
X-Google-Smtp-Source: APBJJlHZmK/ZBI3PExS8dMAh0beNXqHS4PzqN8eSz+tcvORm0rEPyAk7MU4aQKmS9HkW2VbAurIC5Ay813GGueoI0q4=
X-Received: by 2002:a50:cd16:0:b0:51e:27ac:8f9a with SMTP id
 z22-20020a50cd16000000b0051e27ac8f9amr10339edi.1.1689888687673; Thu, 20 Jul
 2023 14:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230420205734.1288498-1-rmoar@google.com>
In-Reply-To: <20230420205734.1288498-1-rmoar@google.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 20 Jul 2023 17:31:07 -0400
Message-ID: <CA+GJov6w2GvD8th0t9RW=K1ntHk4dQRuYa4hoDHcmzBDK5YriA@mail.gmail.com>
Subject: Re: [KTAP V2 PATCH] ktap_v2: add test metadata
To:     frowand.list@gmail.com, davidgow@google.com,
        skhan@linuxfoundation.org, keescook@chromium.org,
        Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     corbet@lwn.net, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@lists.linux.dev,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 20, 2023 at 4:57=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
>
> Add specification for declaring test metadata to the KTAP v2 spec.
>
> The purpose of test metadata is to allow for the declaration of essential
> testing information in KTAP output. This information includes test
> names, test configuration info, test attributes, and test files.
>
> There have been similar ideas around the idea of test metadata such as te=
st
> prefixes and test name lines. However, I propose this specification as an
> overall fix for these issues.
>
> These test metadata lines are a form of diagnostic lines with the
> format: "# <metadata_type>: <data>". As a type of diagnostic line, test
> metadata lines are compliant with KTAP v1, which will help to not
> interfere too much with current parsers.
>
> Specifically the "# Subtest:" line is derived from the TAP 14 spec:
> https://testanything.org/tap-version-14-specification.html.
>
> The proposed location for test metadata is in the test header, between th=
e
> version line and the test plan line. Note including diagnostic lines in
> the test header is a depature from KTAP v1.
>
> This location provides two main benefits:
>
> First, metadata will be printed prior to when subtests are run. Then if a
> test fails, test metadata can help discern which test is causing the issu=
e
> and potentially why.
>
> Second, this location ensures that the lines will not be accidentally
> parsed as a subtest's diagnostic lines because the lines are bordered by
> the version line and plan line.
>
> Here is an example of test metadata:
>
>  KTAP version 2
>  # Config: CONFIG_TEST=3Dy
>  1..1
>      KTAP version 2
>      # Subtest: test_suite
>      # File: /sys/kernel/...
>      # Attributes: slow
>      # Other: example_test
>      1..2
>      ok 1 test_1
>      ok 2 test_2
>  ok 1 test_suite

Hi everyone!

I have been doing some more thinking on KTAP Metadata as I have been
working on the KUnit Test Attributes patch set
(https://lore.kernel.org/all/20230719222338.259684-1-rmoar@google.com/).
Two additional ideas have come up in the discussion:

1) I wonder if it would be easier to separate "ktap_attributes" into
individual attributes.

The two proposed KUnit attributes currently are speed and module name.
I think it would be easier for parsing and reading if these attributes
had corresponding "ktap_speed" and "ktap_module" categories. Then, in
the future if there are too many attributes to print on separate lines
they could be grouped into a "ktap_attributes" category later.

2) I wonder if we can shift the concept of KTAP metadata to all tests
rather than just suites.

I think it would be very valuable to have a KTAP metadata format that
is flexible to work for both suites and test cases. To transition this
to test cases, I propose we would use the same format we have been
discussing but just printed just before the test result line (David
Gow originally came up with this idea). This would look something like
this:

KTAP version 2
# ktap_config: CONFIG_TEST=3Dy
1..1
    KTAP version 2
    # ktap_test: test_suite
    # ktap_module: example
    1..2
    ok 1 test_1
    # ktap_test: test_2
    # ktap_speed: slow
    # test initializing   // diagnostic data
    ok 2 test_2
ok 1 test_suite

I don't love using the "ktap_test: test_2" line since the test name is
repeated. However, I like that this mirrors the same format used for a
suite and I currently think it is the best way to define the start of
the metadata header.

The test name line could actually be useful by providing context for
any test diagnostic data printed below or if the test crashes while
running.

What do people think of these ideas?

Thanks!
-Rae

>
> Here is a link to a version of the KUnit parser that is able to parse tes=
t
> metadata lines for KTAP version 2. Note this includes test metadata
> lines for the main level of KTAP.
>
> Link: https://kunit-review.googlesource.com/c/linux/+/5809
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---
>
> Hi everyone,
>
> I would like to use this proposal similar to an RFC to gather ideas on th=
e
> topic of test metadata. Let me know what you think.
>
> I am also interested in brainstorming a list of recognized metadata types=
.
> Providing recognized metadata types would be helpful in parsing and
> displaying test metadata in a useful way.
>
> Current ideas:
> - "# Subtest: <test_name>" to indicate test name (name must match
>   corresponding result line)
> - "# Attributes: <attributes list>" to indicate test attributes (list
>   separated by commas)
> - "# File: <file_path>" to indicate file used in testing
>
> Any other ideas?
>
> Note this proposal replaces two of my previous proposals: "ktap_v2: add
> recognized test name line" and "ktap_v2: allow prefix to KTAP lines."
>
> Thanks!
> -Rae
>
> Note: this patch is based on Frank's ktap_spec_version_2 branch.
