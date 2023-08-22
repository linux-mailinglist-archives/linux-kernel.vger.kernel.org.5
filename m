Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A6784246
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjHVNmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbjHVNmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:42:08 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB7A18B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:42:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so69294041fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692711724; x=1693316524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Egpf4nO9MxCc5I3bpbxT3F3NaAmmYcHK6c3ZOncDOR8=;
        b=EolNPLxaikwe2UkNg4w2LO+KoO2sgrf0fiq+5YejLsw0k360qbZa1go95NhjL2q9T6
         N7jDWeoLW4+3oN6oVkmWDRLkz9fBViKMDcWknCJiep12pVIYew3A0hw652yHGW46J6Ja
         Xa+tcHabDWaCy6ei3Ex5jJU02dLrV3IgZgyLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692711724; x=1693316524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Egpf4nO9MxCc5I3bpbxT3F3NaAmmYcHK6c3ZOncDOR8=;
        b=fEAXSc/zyWqtEfrrq/5jQLE4/lRNONt6T6Ytw3Mf8k2cuT953STkM8Y/vsR7eKAW5D
         VcxEv82pIIHiUOxD4fC+4LBz9jl5Tyv51dnxdARddYybL+9c2gfATEebdJj9B3ehtGXN
         fcHAUrkz4gJX4bD8bqaO2O/EN8w70uC9CLFPs/Ft60XpKO8QKI2hn6LjhznUcQkARXPu
         lCbWiz7vXZ6UMst+zfNAm7HuEaNkXDorVh+9JZqv/GhS1ikE3RnESpjYUpJd++Z2dgMy
         WWYaBkUf4Ts5IS6LB7OeN6z+32lzKBGiFJ2l2W1EjXl6pFrO9yDsv4qgbD/Ue9XF9nmE
         knaw==
X-Gm-Message-State: AOJu0YyTeoyOqu4AH8M00QWlzTZTntDIsS4WmgyhRijMcgx8k6ZP0158
        KpOhRFAcNEsYlvkyX8xKmzSj6w2YqIQbEBaF8jfiGQ==
X-Google-Smtp-Source: AGHT+IG+MCgZYLjikDf4IKuwKqAMpJX5qjmjs3PeIgM9wWA97BZYIeB2DrLvqMsUVtOZAvuQaWN28whK5AoYYqCapXI=
X-Received: by 2002:a2e:6e0e:0:b0:2bb:8eea:7558 with SMTP id
 j14-20020a2e6e0e000000b002bb8eea7558mr6285582ljc.13.1692711724514; Tue, 22
 Aug 2023 06:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230517181353.381073-1-kursad.oney@broadcom.com> <CACRpkdYiOK6853iKpy8bqfGokq5yRBiena8uUYm87L6r0vd6Wg@mail.gmail.com>
In-Reply-To: <CACRpkdYiOK6853iKpy8bqfGokq5yRBiena8uUYm87L6r0vd6Wg@mail.gmail.com>
From:   Kursad Oney <kursad.oney@broadcom.com>
Date:   Tue, 22 Aug 2023 09:41:52 -0400
Message-ID: <CAMm8Nh39RLt9rWNBu7nKKF-hJsRT25kn8VzANLy4PyunugcX0A@mail.gmail.com>
Subject: Re: [PATCH] ARM: memset: cast the constant byte to unsigned char
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000010a91b06038329fa"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000010a91b06038329fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus, Ard,


On Thu, Aug 10, 2023 at 4:15=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Wed, May 17, 2023 at 8:14=E2=80=AFPM Kursad Oney <kursad.oney@broadcom=
.com> wrote:
>
> > memset() description in ISO/IEC 9899:1999 (and elsewhere) says:
> >
> >         The memset function copies the value of c (converted to an
> >         unsigned char) into each of the first n characters of the
> >         object pointed to by s.
> >
> > The kernel's arm32 memset does not cast c to unsigned char. This result=
s
> > in the following code to produce erroneous output:
> >
> >         char a[128];
> >         memset(a, -128, sizeof(a));
> >
> > This is because gcc will generally emit the following code before
> > it calls memset() :
> >
> >         mov   r0, r7
> >         mvn   r1, #127        ; 0x7f
> >         bl    00000000 <memset>
> >
> > r1 ends up with 0xffffff80 before being used by memset() and the
> > 'a' array will have -128 once in every four bytes while the other
> > bytes will be set incorrectly to -1 like this (printing the first
> > 8 bytes) :
> >
> >         test_module: -128 -1 -1 -1
> >         test_module: -1 -1 -1 -128
> >
> > The change here is to 'and' r1 with 255 before it is used.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>
>
> Wow you found this old thing!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Can you please put this into Russell's patch tracker?
> https://www.arm.linux.org.uk/developer/

Thank you for the reviews. I just got back from vacation and will add
this into Russell's tracker.

>
> Yours,
> Linus Walleij

--00000000000010a91b06038329fa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
H97gptZzNuD5FN8AnEYMQC6vPslbDQ8OeHrqANhF8taWK+SSbnl4/km7NnYL6pYm2/HulJ7szr6k
Bga+i8qlQQLDYjSqVnvSx4I0lnIx8mkbKOjKUkaTAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGt1cnNhZC5vbmV5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUKWCMBqRGX3LrgDeTNWWULeUnAkw
DQYJKoZIhvcNAQELBQADggEBAGiGVwLlVHzCwc131bPGlyqtSUpcV3ZIrDzgI5b9P928irKwLLfx
42XWJIfF5VAW8uJunv6HyQcNeBRM52s06xq2dcX7RdXXPLUU/YX5f3PGhzcRRC6UMknFS8JuNiK2
RdXw0IUu9RCTfRpaM27WGAYxZ7JV9ifux005OUgthb9fXYbMWSVRTm68SS3zmWnEQFFLCVK7X2/W
eX50x5mei/gYP8RsWh/OebUYfGNnz3I6D7hU/yeXOIXxSqWJU3e87v7O4nntiBsS+np8/aI0DPwO
9taRRqYu6VYqshU5nPIYjgZWPwbumnWj5akjBeUPbItThOMNwidMbPamkAkQI+YxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwXP8QzF7cAzvmLbq4wDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAMSkak0o2/CvIsDwOPrhdh4k6gILo3E+sND
uvq5jrmgMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgyMjEz
NDIwNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAgIYPLn1wWJTdqy7iXHIg5e33wNRY395h1BBngYJuZySNlHjaiEa0J
cURjOGCNUPczbYiVf4SCptWmvQJsV+BG+x4nOdfMS7kuVnrfLdXXFcb3oryfwt5dHlwMpJ97iuWp
lIOxQB/pH2NrsKzs0ZsQfqh7yMrviYF1sbOd9QNC3ciHtPupHL8hX7hXN1wLtdJy3G1egGuNP2tY
MWfZ1M60AMGvGWzF/cYYTAvN6+hqNnPP7MayEfncDkGhy0m47UIFqH4evSlQdJaA5/s+T36kHvpG
5gIhWpnCdKfoNXGg7pbQKmH0t3W+4NtB+zt0HYXeBTA+T5plPIvC183TExKa
--00000000000010a91b06038329fa--
