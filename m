Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0149C77A677
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjHMNKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:10:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41601712
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:10:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-26b3f4d3372so376806a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wetwork-net.20221208.gappssmtp.com; s=20221208; t=1691932210; x=1692537010;
        h=in-reply-to:references:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9dkcTCaAfKcLj+E8nkveq9vwUpF+PXDmi7HDoOlJHc=;
        b=l1yXwKNBTIfxuyfUBetaWfusvGzTo47eSfzoEYh8lnkQMKQTcxxr35ViPftQ2MCMtf
         gp5uEL6hlAF3rd+EHdnQzC66SmuIdnHwFDS5NowY/7ZbfJbF5qYi2DUZNBYaMCJvUEMz
         0PrJsViU/jHpP4A4m5x7NRtJYyYk4KCW6hJNElbYPo88f0wss6YYb1gt167M4EHWOW37
         /WkNKhvmZ1R9a18U53DdEoqN6shaHu1l+gxhsyfKrvoZdBocncSTpA1HOpIIfg0NuRlK
         Vy6X9otzo+Q3ayx+d/xDyqi5Iz9+bL7ymRNfK5edNwRv+e41z7uQwUsKkCL0hy5ZZ2d4
         PCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691932210; x=1692537010;
        h=in-reply-to:references:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b9dkcTCaAfKcLj+E8nkveq9vwUpF+PXDmi7HDoOlJHc=;
        b=U2YV/DucQPvv53CZ3x+k+zHgqLowe2pI4oZII7wlZG1vLzEeWaSXGVkiStJ44dVHxN
         UU3T3ilOuYOXKc2jloNosk4okJMjRoNlNAF3359PvLMBYh/ahN9CRJdBQf+V6K17PLNV
         cEFamoql39AT9Tq6p7Gj1Zt+gHCL5Lc+SKRK4RYS9dGe3um8Sko7dcCFpAu1HKoqfE/b
         CrDXW0uBIzzzII0GWg+4/DJKvi7PHo/2kn+E9uscHshhwLAFNZ9W5P/FBSAVVRA4XUKt
         GZAQDJCS4wcV55fG8FzHbe6sTpr/r2vOltuY0tzaY3YGRzt+3nPmHJeiLoOn5V24pDoj
         JLMQ==
X-Gm-Message-State: AOJu0Yyn/Sl3SJHwic02n+VQIHWqHGFtpkN50Bn1V7JHlaERrcaxmbTW
        ds6OpRNtH80LYw6JHnUKHqp3eDLhmvbfA0tHLdE=
X-Google-Smtp-Source: AGHT+IGAWkJ41uKnYkNn2wQmYvf2/xba8cmJOz3yJOToCsBvFiPdE3trX265oZFhMDikJX8jGmBFjw==
X-Received: by 2002:a17:90a:fd83:b0:268:400:ecef with SMTP id cx3-20020a17090afd8300b002680400ecefmr5038473pjb.45.1691932210273;
        Sun, 13 Aug 2023 06:10:10 -0700 (PDT)
Received: from ?IPV6:2601:500:8700:d766:b88d:dfe4:c55:9738? ([2601:500:8700:d766:b88d:dfe4:c55:9738])
        by smtp.gmail.com with ESMTPSA id bo24-20020a17090b091800b00262d6ac0140sm6248065pjb.9.2023.08.13.06.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:10:09 -0700 (PDT)
Message-ID: <9157cdb4-7d49-d1b4-7de3-9205b5400802@wetwork.net>
Date:   Sun, 13 Aug 2023 06:09:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Regression with new AMD/Intel patches in 6.4.9/6.4.10 prevent Signal
 from functioning.
Content-Language: en-US
From:   Ehud Gavron <gavron@wetwork.net>
To:     linux-kernel@vger.kernel.org
References: <3f59d2df-44d9-a1b3-1400-34c454ad5be3@wetwork.net>
In-Reply-To: <3f59d2df-44d9-a1b3-1400-34c454ad5be3@wetwork.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070100070603020800040300"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070100070603020800040300
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,  please CC or BCC me on any responses.  I'm not on LKML because typically I don't need to be.
In this case, however, there is a kernel regression.

TL;DR when using stock 6.4.8 Signal works fine.  With 6.4.9+ (6.4.9 and 6.4.10 tested) it errors out.
Logs were attached, but LKML mail filters said narp.  I'll put a DIFF -U0 at the end here
for those to whom that will provide a clue.

Story:
When setting CONFIG_SPECULATION_MITIGATIONS=n and recompiling the kernel, 6.4.10 works from
the command line (e.g. "$ signal-desktop") but does not work from the Gnome panel.   ("Does not work"
means the processes sit there but no window ever pops up.  Firing up a command line version says it's
the second incarnation and *immediately* displays a window.)

Summary:
A kernel change that doesn't require ABI changes should not affect user-mode code.  The changes
introduced after 6.4.8 do affect user-mode code, and in this example, Signal.

6.4.8 - Signal runs fine.  From either the command line or the panel icon.
6.4.9/6.4.10 - Fails to run on either.  It displays an error message on screen and if on CLI one on there also.   (was attached but 
LKML said narp)
6.4.10 with CONFIG_SPECULATION_MITIGATION=n allows Signal to start from the CLI, but starting from Gnome's panel
results in a lack of displayed window.  The processes look fine in the background (e.g. ps -eaf | grep -i signal looks good)
and starting a new signal from CLI indicates it's #2 and IMMEDIATELY displays the window.   Exiting that will remove all
Signal processes.
Rebooting to 6.4.8 instantly restores normal behavior (works from Gnome panel icon; works from CLI; no errors).

There is some regression introduced by CONFIG_SPECULATION_MITIGATIONS that is preventing this (and likely other)
user-mode from working.

I'm available to alpha-test.  I'm not on LKML so just CC or BCC me on the reply.  I'm a newbie at CPU pathways but I am
a contributor on the BC43 driver.  And yes I did read section 3 of the FAQ on posting to LKML.  If this makes you want to
flame me, please enjoy, but also contribute something useful. Like the solution, the possible issue, or a generic comment.

Best regards,

Ehud Gavron
Tucson, Arizona
> $ diff -U0 signal-desktop-6.4.8.log signal-desktop-6.4.10.log
> --- signal-desktop-6.4.8.log    2023-08-11 13:47:37.371278092 -0700
> +++ signal-desktop-6.4.10.log    2023-08-11 13:45:46.134110820 -0700
> @@ -13,2 +13,5 @@
> -(node:3844) [DEP0005] DeprecationWarning: Buffer() is deprecated due to security and usability issues. Please use the 
> Buffer.alloc(), Buffer.allocUnsafe(), or Buffer.from() methods instead.
> -(Use `exe --trace-deprecation ...` to show where the warning was created)
> +Render process is gone: Error: Reason: crashed, Exit Code: 132
> +    at App.<anonymous> (/opt/Signal/resources/app.asar/app/global_errors.js:88:7)
> +    at App.emit (node:events:525:35)
> +    at WebContents.<anonymous> (node:electron/js2c/browser_init:2:89989)
> +    at WebContents.emit (node:events:513:28)



--------------ms070100070603020800040300
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DVMwggXeMIIDxqADAgECAhBcoH6uGaKTQYLD3fim3HIcMA0GCSqGSIb3DQEBCwUAMIGBMQsw
CQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRy
bzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1
dGhlbnRpY2F0aW9uIENBIEczMB4XDTIyMDgzMTE5MTQzNVoXDTIzMDgzMTE5MTQzNVowHTEb
MBkGA1UEAwwSZ2F2cm9uQHdldHdvcmsubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAyGoEPxQZqEGzQelI/2f/bgobj2D46M/ClFn01L/Hp41esGClOFxffo9e08QQuaZS
Oz84zialNiDmENos01NtipsgeVnVWeg84xLSzk35YJG6Pq5UmzuXorRZ/8lEHeNOO6aWAt9I
BAIcjrRVC1muqRvnc9doXgpyyqdjgrF2MUqX82bbUxqlC6xoYD42pwqQH/lPphPV855OAyIX
f94JWjgogQGNCCoTHJlhkSiGhM836t31uHGJsUin6z8aDw6Aj+hxJDdsfplmvMMkXTdUDLvc
vUuC/ZGfOjtC7tBZL9De/XXrW8fAYOr04m8hPtbd/MXKfcWg6tpdr24Hpzw+zwIDAQABo4IB
szCCAa8wDAYDVR0TAQH/BAIwADAfBgNVHSMEGDAWgBS+l6mqhL+AvxBTfQky+eEuMhvPdzB+
BggrBgEFBQcBAQRyMHAwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jYWNlcnQuYWN0YWxpcy5pdC9j
ZXJ0cy9hY3RhbGlzLWF1dGNsaWczMDEGCCsGAQUFBzABhiVodHRwOi8vb2NzcDA5LmFjdGFs
aXMuaXQvVkEvQVVUSENMLUczMB0GA1UdEQQWMBSBEmdhdnJvbkB3ZXR3b3JrLm5ldDBHBgNV
HSAEQDA+MDwGBiuBHwEYATAyMDAGCCsGAQUFBwIBFiRodHRwczovL3d3dy5hY3RhbGlzLml0
L2FyZWEtZG93bmxvYWQwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMEgGA1UdHwRB
MD8wPaA7oDmGN2h0dHA6Ly9jcmwwOS5hY3RhbGlzLml0L1JlcG9zaXRvcnkvQVVUSENMLUcz
L2dldExhc3RDUkwwHQYDVR0OBBYEFBfL5XO+k7FAN6j8jMzjabiiGxUJMA4GA1UdDwEB/wQE
AwIFoDANBgkqhkiG9w0BAQsFAAOCAgEAge81wd2LhOsbnIa0MIbfC9lfTrYyglX37Acpd2eU
eVl1JRDijgAMo4puvMJEhghPKrtQOv2ceMT+XtQlQb9XKSiqR9+Im6VVPm97tM4fghAGEp8g
i7H4uhVXsVOnuJqzHOL3YLWlCjfKHktrmGou0FB30z8DooeRODZkYhbxC620SpdGULwq6090
w0NLYjtA+MgI5F2iYYr7lKeHm2CrcYmj099TRmH4ZzYE2nvm4AIK5GyakHWEP90+v1Ke31Uk
i9cdNPXMUHyikHe2734XW56PRnOKmxCjRipgRZo1a19P8eXj7Db2wmoq6UkLI05axhNWa2lg
EY9WflrS8IVAgUIGf6gS/bYa6EXCkg+oHP9CkiRV8vsINMzA9C6uQkYhQKko6nkWJPoUUVY3
f8N+xCn1Ko7C0GMtg1M9TQczCgWHaF8EOFkWIZ4gNabPwGQOrzIfgOwQwV2zt71Hch6hRXri
1uZW+SIL3PHHRnZ9HK93VhkaXuJJWf7ZVQfXYy+H8SQmuB2j8KhhVg7TOxio5ShpLpLiZv/v
QLxjyShe7oEbHQitKPZkaUCM4/9s250kk2cbyhbeLC1YoDa4FzmGKt6q4J3K+8l/m884t6r/
xfoaUkVsRpdVJ+467Y/vkpSFz7ds95k9wdFVm0QMoeFPHyIcXn+Kg4iJ1iq1vP0GI9Awggdt
MIIFVaADAgECAhAXED7ePYoctcoGUZPnykNrMA0GCSqGSIb3DQEBCwUAMGsxCzAJBgNVBAYT
AklUMQ4wDAYDVQQHDAVNaWxhbjEjMCEGA1UECgwaQWN0YWxpcyBTLnAuQS4vMDMzNTg1MjA5
NjcxJzAlBgNVBAMMHkFjdGFsaXMgQXV0aGVudGljYXRpb24gUm9vdCBDQTAeFw0yMDA3MDYw
ODQ1NDdaFw0zMDA5MjIxMTIyMDJaMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2Ft
bzEZMBcGA1UEBwwQUG9udGUgU2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4x
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
AAAAAAAA
--------------ms070100070603020800040300--
