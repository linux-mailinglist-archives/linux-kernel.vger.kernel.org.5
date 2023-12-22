Return-Path: <linux-kernel+bounces-9508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AED81C6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D07284660
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35819C8D4;
	Fri, 22 Dec 2023 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxLEv/pd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E572D53AA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so9837a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703234344; x=1703839144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vGDpnqsLPMX+ye1PVjr11QJumDxnFnfu3DILXj2F5I=;
        b=vxLEv/pdqYav20QpB0gUJKVTp4egkuge9hb6ATCnTnPu56aUPjrHAyg4oWvYCiMTW4
         eEVdd5jI1cnevOIsxmsflruPt8/aUPMF4EEZuSqnA9Dd1oOAG9DLOO++AwM+jyji3lOk
         H3GFDUz/VfT/1cW3hHSU+vZzqqmu2D6ReL2cWFnLjjnzpDTZyn4zMpbXVsc60Nn4Wcgw
         CifgCG5iRgbQOuniD/sMIO2fS8rfTRqorQycMM2hd9jqjHSEVZ+TYBKu5+PfkT/bNt9G
         iKU6Im/wk0+gItWiTI+kb8jRgHN1skrVa+74BgqmQpY3nk0MTjwvHNERotslPDaDcAoM
         5UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703234344; x=1703839144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vGDpnqsLPMX+ye1PVjr11QJumDxnFnfu3DILXj2F5I=;
        b=dlnvROC4JIyydpzBM/hnazcRR+Y0lwllEhrXcKfXvIj0IFHTYpXQxBrO2jDt3rGj4W
         bP4p6QrQ9sZ7e2vnw4tfJk79ZWiDqi2VYm/k6NoMjAdSfSsVM2sDxaSv0CVNFhAUq/kR
         OteuyxKEzzXccJuUh+tBFDYiffA3i4bimOrj58+GP/qgpnM8PlctTSSnqjSZFdKIXwVM
         xM51ZykBRVUeS4io/CuXEsX4OV7kjYmAFZC3/Cs2lmvqTDLws1W6JnVjObuC35M8YbQX
         D++V+vjvsFw4zGKD2SbGE3i6r5ax4yl66k1Ohw+SNPvM4EiblhJH4IvbfG6D/meXAEPA
         Aveg==
X-Gm-Message-State: AOJu0YyWpPsHcxFyPzcc4QnykazvQAwNP+9ZswduMsNSzjC58TYaR/4Z
	GuUdh35zy0b49QfJqJHZmbukRnQ3M7hZRkRzp6SDUxtSBJEd
X-Google-Smtp-Source: AGHT+IHyailRraZ3yd8lW96Fn8XUo3VTEQaA2tBGRcF98d25EXKyiUQ00BKoRE16r/HjI4cB+NjCvylfgzpN7Yl5now=
X-Received: by 2002:a50:ba8e:0:b0:554:228f:4b8e with SMTP id
 x14-20020a50ba8e000000b00554228f4b8emr101387ede.2.1703234344152; Fri, 22 Dec
 2023 00:39:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221103858.46010-1-rf@opensource.cirrus.com>
In-Reply-To: <20231221103858.46010-1-rf@opensource.cirrus.com>
From: David Gow <davidgow@google.com>
Date: Fri, 22 Dec 2023 16:38:53 +0800
Message-ID: <CABVgOS=kECrGMXCg49QWsO1q-CGEzJdshxZ8XAA5GLKw58nR-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: Allow passing function pointer to kunit_activate_static_stub()
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000120622060d1526a9"

--000000000000120622060d1526a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Dec 2023 at 18:39, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Swap the arguments to typecheck_fn() in kunit_activate_static_stub()
> so that real_fn_addr can be either the function itself or a pointer
> to that function.
>
> This is useful to simplify redirecting static functions in a module.
> Having to pass the actual function meant that it must be exported
> from the module. Either making the 'static' and EXPORT_SYMBOL*()
> conditional (which makes the code messy), or change it to always
> exported (which increases the export namespace and prevents the
> compiler inlining a trivial stub function in non-test builds).
>
> With the original definition of kunit_activate_static_stub() the
> address of real_fn_addr was passed to typecheck_fn() as the type to
> be passed. This meant that if real_fn_addr was a pointer-to-function
> it would resolve to a ** instead of a *, giving an error like this:
>
>    error: initialization of =E2=80=98int (**)(int)=E2=80=99 from incompat=
ible pointer
>    type =E2=80=98int (*)(int)=E2=80=99 [-Werror=3Dincompatible-pointer-ty=
pes]
>    kunit_activate_static_stub(test, add_one_fn_ptr, subtract_one);
>       |                             ^~~~~~~~~~~~
>    ./include/linux/typecheck.h:21:25: note: in definition of macro
>    =E2=80=98typecheck_fn=E2=80=99
>    21 | ({ typeof(type) __tmp =3D function; \
>
> Swapping the arguments to typecheck_fn makes it take the type of a
> pointer to the replacement function. Either a function or a pointer
> to function can be assigned to that. For example:
>
> static int some_function(int x)
> {
>     /* whatever */
> }
>
> int (* some_function_ptr)(int) =3D some_function;
>
> static int replacement(int x)
> {
>     /* whatever */
> }
>
> Then:
>   kunit_activate_static_stub(test, some_function, replacement);
> yields:
>   typecheck_fn(typeof(&replacement), some_function);
>
> and:
>   kunit_activate_static_stub(test, some_function_ptr, replacement);
> yields:
>   typecheck_fn(typeof(&replacement), some_function_ptr);
>
> The two typecheck_fn() then resolve to:
>
>   int (*__tmp)(int) =3D some_function;
> and
>   int (*__tmp)(int) =3D some_function_ptr;
>
> Both of these are valid. In the first case the compiler inserts
> an implicit '&' to take the address of the supplied function, and
> in the second case the RHS is already a pointer to the same type.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Rae Moar <rmoar@google.com>
> ---

This makes sense to me.

I was a little worried at first that this might actually be adding a
layer of indirection (which, given we're keying on the pointer,
would've needed to be done carefully), but this is an obvious fix to
me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


> No changes since V1.
> ---
>  include/kunit/static_stub.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
> index 85315c80b303..bf940322dfc0 100644
> --- a/include/kunit/static_stub.h
> +++ b/include/kunit/static_stub.h
> @@ -93,7 +93,7 @@ void __kunit_activate_static_stub(struct kunit *test,
>   * The redirection can be disabled again with kunit_deactivate_static_st=
ub().
>   */
>  #define kunit_activate_static_stub(test, real_fn_addr, replacement_addr)=
 do {  \
> -       typecheck_fn(typeof(&real_fn_addr), replacement_addr);           =
       \
> +       typecheck_fn(typeof(&replacement_addr), real_fn_addr);           =
       \
>         __kunit_activate_static_stub(test, real_fn_addr, replacement_addr=
);     \
>  } while (0)
>
> --
> 2.30.2
>

--000000000000120622060d1526a9
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
MDIwAhABzgV+4+mJnUzG7XDy6d2uMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCV
tSgRF2QWw07pLTlzkew4GpUEDKc1+4lREeF5ICBdvDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzEyMjIwODM5MDRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAlRZ6W0/q0rFjGYDaRAy8
bCQEuMQxy2V6fuVbp7yRa/qKHTbo/HBGVj8LnWijzLvpX5OlUYF/5ZMkeESZN/l3+8yzcNNT2QVB
nH0GUR6OdMMiMnhaBp6og3pbyNlcZOkXiQFvoqZfijopTYUj3yNWLJVnZNheIvOa+rGtOKUpZGXn
g43bqzMbiW/TViVkaWA1ykqVNV4ucyTQLAi0uZlVCxxY80TJNFbIPYf+xVhJRzb9kdJHqIp428/C
Qg36DAsgbE+/k7Q1tqUyGi1tmklXPmqmn/2IHeYL/Xullq3fMhIsqlUVO0vVt9qjDP0GUvzwCh2Q
pVA3fZTgKkn3wWi8AQ==
--000000000000120622060d1526a9--

