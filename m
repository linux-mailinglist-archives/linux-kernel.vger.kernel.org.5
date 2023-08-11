Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9E57788EB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHKI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjHKI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:28:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A23272D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:28:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so41145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691742488; x=1692347288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+kjk6ZYtHmxbClcLrEjgJG2R5SBMYgYvrfKkXDi1Vm4=;
        b=2VDde0cgYj7FLVWblx3l9Fm9NxiGVoAPLF+j7KxW1hToRUWYsNtACgjGsDJBoUWEvQ
         R4Jh+lk65zVlMbV3omssNf+5Z3aFA53bx5n+shS9mEgHh55C9rO0Z8avh6fu1+P8vSbf
         3S5WjB+XCG+I8cgqzNcXVQ8I7AM4vPRthfnp4N9w3dY/HU/enzQ5k6UP1ftccJk60nZZ
         qqcY/I/dgGQ4pkE1LTUcqJ4j0x5t5GGdXV5mk2y0yAJwGmqUVgDQWKEnim3tg3Ba59go
         lqma1Q3n11pMl5HBCM3BTmd9zlQaua5KWfarvgIa6gZludkZJPQqn2c/zVoCE0OFOmZD
         P6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691742488; x=1692347288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kjk6ZYtHmxbClcLrEjgJG2R5SBMYgYvrfKkXDi1Vm4=;
        b=Up08wV6OSfdaSoaasFZHXYMwTjWO6wvnj61PoC1rsckBlGKXMtqwvGDUaJbq9hjwez
         dJAtO2gh5OBB5rTEnkNz2HTNqh4lcAiVQr+FpPmc/s+2mfG27CmLl+hquYKHf20WiF5/
         knovVbmxFDWvZ/r4oWAZmVJ3VREAcBAp21/uhyQPRU6SPsKKc4chBJLAZh8kkjIoEGAz
         B/gz4oovgtHfAtNpElLLOfTwlgfI+8WDb8LQjYQYySoQR0OK1ZV6tAL8klZdK0OBJ6Ty
         ZNNHS63ci19IeoAi5sFpS2aWvUMIbOzJwhVQ71HtbqhuO0EJTVB8HrCjPFUMXMgNXaGE
         fe4g==
X-Gm-Message-State: AOJu0Yyh6e0wZlSma5bErRitJ3IFsdY7Vk//UJeoYkjFWePBRB+AAUCx
        P4bHXpn4k2GjF2loZ/mqQof8rhJlnH8NGH/t7SAgsw==
X-Google-Smtp-Source: AGHT+IEfVMShCjvqKkAInTL/aRvCkoWE4R9Hg5P3NHW20ZpM2/tD8uKfCFlmysxoDFORrlpZXCOOVbv0Hjhb+j9iSwo=
X-Received: by 2002:a05:600c:3590:b0:3fd:e15:41e3 with SMTP id
 p16-20020a05600c359000b003fd0e1541e3mr83169wmq.2.1691742487886; Fri, 11 Aug
 2023 01:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com>
 <20230809155438.22470-4-rf@opensource.cirrus.com> <CABVgOSn4PWT6+TobiJd+ppmPXsL+0qtLdazgjuQmfymUfkYhnA@mail.gmail.com>
 <1cba22b4-d8e2-e5bf-98b2-597dd1797304@opensource.cirrus.com>
In-Reply-To: <1cba22b4-d8e2-e5bf-98b2-597dd1797304@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 11 Aug 2023 16:27:54 +0800
Message-ID: <CABVgOSnYKEK4S1Jo9sT4CLY6z56Vfsz+A_c4ykz2mRcp6MR7Hw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] kunit: Handle logging of lines longer than the
 fragment buffer size
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000105a230602a17eab"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000105a230602a17eab
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Aug 2023 at 23:09, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> On 10/8/23 15:38, David Gow wrote:
> > On Wed, 9 Aug 2023 at 23:54, Richard Fitzgerald
> > <rf@opensource.cirrus.com> wrote:
> >>
> >> Add handling to kunit_log_append() for log messages that are longer than
> >> a single buffer fragment.
> >>
> >> The initial implementation of fragmented buffers did not change the logic
> >> of the original kunit_log_append(). A consequence was that it still had
> >> the original assumption that a log line will fit into one buffer.
> >>
> >> This patch checks for log messages that are larger than one fragment
> >> buffer. In that case, kvasprintf() is used to format it into a temporary
> >> buffer and that content is then split across as many fragments as
> >> necessary.
> >>
> >> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> >> ---
> >
> > I think this looks good (and is a long-overdue addition to the logging
> > functionality).
> >
> > One thought I have (and I'm kicking myself for not thinking of it
> > earlier) is that this is starting to get very similar to the "string
> > stream" functionality in lib/kunit/string-stream.{h,c}. Now, I
> > actually think this implementation is much more efficient (using
> > larger fragments, whereas the string stream uses variable-sized ones).
> > Particularly since there are a lot of cases where string streams are
> > created, converted to a string, and then logged, there's almost
> > certainly a bunch of redundant work being done here.
> >
> > My gut feeling is that we should stick with this as-is, and maybe try
> > to either work out some better integration between string streams and
> > logging (to avoid that extra string allocation) or find some way of
> > combining them.
> >
>
> I completely failed to notice string_stream. I could re-implement this
> to use string_stream. I wonder whether appending newlines gets
> a bit inefficient with the current string_stream implementation.
> Could add newline support to string_stream and alloc one extra byte for
> each fragment just in case we need to add a newline.
>
> The string_stream implementation would waste a lot a memory if you log
> many short lines. My current code wastes memory if you log lots of lines
> that don't fit in available space in the current fragment - though it's
> simple to shuffle the formatted string backwards to fill up the previous
> fragment (I just haven't done that yet).

Yeah: I think your implementation here is overall better than the
string_stream one. string_stream might handle concurrency a bit
better, which would be nice to have as people start wanting to try
multithreaded tests.

I think the ideal solution is:
- Update string_stream to basically use this implementation.
- Update the logging code to then use this via the string_stream API
(probably with some tweaks to handle newlines)
- Optimize the string_stream append implementation to not create a
temporary string, as string streams are written to logs often. (If you
were prepared to allow string stream fragments to have variable
lengths, and do some ownership shenanigans, this could even become
O(1), though I suspect it's not worth the added complexity.)

That being said, I don't think we'd need to land all of that at once.
Even if we ported to the suboptimal string_stream API now (which would
still gain us the extensible log and some concurrency support), and
optimized string_stream later if it turned out to be tricky, that'd be
fine. (I wouldn't want to hold this up if changing string_stream was
regressing the other code which uses it, for example.)

How does that sound?

-- David

--000000000000105a230602a17eab
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
MDIwAhABAz5xDls09r2CKyYRqnNbMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCS
0wNjjyijoqxv0R6f2xQQwp7ItVerZgt4bQ/mH+YqCzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MTEwODI4MDhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYjiizHaKf/6YVSyF75VV
IKkj9q73Vy92OaHjnEmaPmQ/jnU/uq6uygg+SMV05SkRPFOqfJS96jM4qD1k66GTK8yPUZEoKfTJ
xdIBFHhtJrZHo/aLpnYmmMyWcrjdRYBrufdZNuib2zVZo5QfZiFSBeRVLftm4QbuXpQ8hPlQDA3+
rVDEihsUUyteIxuwiAsCiRBVPIDQh3LTRaQoBN6ecpgsU6QT+26HwLqHsPasJijKtY+JYeenalwp
fHPT6vH7yuuO476bWWXe2OW+Hzd1391lXG2zjVD48E6BuNMxVTvdxeqUinzt1cBpOCgtdSkdsslp
i0J/atD+L98GInXtTA==
--000000000000105a230602a17eab--
