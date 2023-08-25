Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB8E788045
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242501AbjHYGtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbjHYGt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:49:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00041FE6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:49:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fef2fafee2so66025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692946164; x=1693550964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PYzGhjIGy4tQBm8K617KYDIQreyk1kfnyn+1oJLUWvU=;
        b=2vOWXqZPQSc1h0cIL88Q2VfSu267NKwJTaqaLQivpd3COl8/etGcddHw6Ob2/t/XVA
         3fqhDdqDEAr1Q1nnrExls/BAnjYjtZitQ/e9dquFs0LZ8hy5vKbz4duw57vwL+vXIYRp
         ljmYISuyjbn+2HSi0rxodcNw3uWniZ83o88PwLIoV0hF/Eroo6/aPpB3icQBTLJ//gLI
         YYdw8p7e5abdmA6Kre80Ppk2J8yJFbG4vloY6X2mnospHwqRESWaHaSisxU3ZZ3UCmIe
         pe45VQft8WLLdt1irdtF6JPPHyh36XeJFeIZVNdu+3jcR8cAgyG4/BMeUa5taj9lzkFY
         vEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946164; x=1693550964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYzGhjIGy4tQBm8K617KYDIQreyk1kfnyn+1oJLUWvU=;
        b=CgBdox7mL89qanvjIPGHbbtKkd+wNCEFoBQpv0zTDbYT/rgXV2mZOsxxu/7hofKkUG
         A8MnEIXI2JEddIHo8QbZaKZveFcRbbYOeWjmmI1HqBYsb8S0qmvyr2dfmNxh98kLk59k
         DAibIPFTSCuklh2hG3hoklD63G91V2nF4fk/ZYn6wEObqlCKshbaIpoqVtKxfK7oJvXV
         SPtRHhdtJ28TXHnOI2Zf+CuMy5iTknjd2Cza4PYIsTDtNMZZCTX/tC4qUgKVder2BNNI
         mZzIYw9hNyQbQsLkKByH1/PPshCY9/RlnyuFG8hPTgx+5PgvJnU317dUaG1lGzl3ab3v
         Q1Zg==
X-Gm-Message-State: AOJu0Yy163JNRUV6ZZ6af/Jya/L5V6n3x1RiAQln7CliAo/oHFmQKNjC
        MReTUDKDxYYA+QJlDPGzl/OxZu3ay4ogcbvzv8Ygkg==
X-Google-Smtp-Source: AGHT+IHi6UV3hxpZcE5QYhwsQ02MwSt5B/SL2pzP9cVLW1Zlb+CUcK44V6+nF1iRSWVDwAMMCdfwCJ1wpzNxiot9Inw=
X-Received: by 2002:a05:600c:1c92:b0:3fe:f32f:c57f with SMTP id
 k18-20020a05600c1c9200b003fef32fc57fmr138490wms.0.1692946163972; Thu, 24 Aug
 2023 23:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143129.1957914-1-rf@opensource.cirrus.com> <20230824143129.1957914-2-rf@opensource.cirrus.com>
In-Reply-To: <20230824143129.1957914-2-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Aug 2023 14:49:11 +0800
Message-ID: <CABVgOSk+7XXT3GarvUUQuy7odEfqW9g1=GY4tHF=TyhaS=n5_Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] kunit: string-stream: Don't create a fragment
 for empty strings
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000c0e47f0603b9be44"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c0e47f0603b9be44
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 22:32, 'Richard Fitzgerald' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> If the result of the formatted string is an empty string just return
> instead of creating an empty fragment.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  lib/kunit/string-stream.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
> index cc32743c1171..ed24d86af9f5 100644
> --- a/lib/kunit/string-stream.c
> +++ b/lib/kunit/string-stream.c
> @@ -50,11 +50,17 @@ int string_stream_vadd(struct string_stream *stream,
>         /* Make a copy because `vsnprintf` could change it */
>         va_copy(args_for_counting, args);
>
> -       /* Need space for null byte. */
> -       len = vsnprintf(NULL, 0, fmt, args_for_counting) + 1;
> +       /* Evaluate length of formatted string */
> +       len = vsnprintf(NULL, 0, fmt, args_for_counting);
>
>         va_end(args_for_counting);
>
> +       if (len == 0)
> +               return 0;
> +
> +       /* Need space for null byte. */
> +       len++;
> +
>         frag_container = alloc_string_stream_fragment(stream->test,
>                                                       len,
>                                                       stream->gfp);
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20230824143129.1957914-2-rf%40opensource.cirrus.com.

--000000000000c0e47f0603b9be44
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB7
ehKB6A8Lh54+T2VTvr61rg7UOhAjBbgt2pODpTTMTDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzA4MjUwNjQ5MjRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAGiz2dQa53lXiOII54hLg
fvklJnh77XYo0dB4DY8V6+5DSwNE9UAh9UE90phHFlXsos4D/iFF+UYBih0yML6n8ApAnwIA2QLT
vj98xJjSNcU0FgVxKeEnP9kcvsQoPI7qTAR48zP1Uaf7iX3XNadVrzgqLkd1CcUIHnXXJtOtXzsP
cVfBtHNgmA2qk7AgjA5HzZQ7k+0Mb3sBfoheSTI5D2ZTjE5/hhbdbhVyeY4HcayQd30Hodt9vrjc
Cjl6bv7QUEKkkqYmDyjSPNkbwic8FsxDJWegY/LSheMP2xPfL+/o6ifJg8z4Yh4BL0kQT2gjzo/E
zPfmss1GvnjXokRdRw==
--000000000000c0e47f0603b9be44--
