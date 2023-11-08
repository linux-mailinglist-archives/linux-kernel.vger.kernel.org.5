Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5966C7E5D61
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjKHSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:39:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC2A2107
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 10:39:48 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5094cb3a036so9289212e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 10:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699468787; x=1700073587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s6Zb3+kBxD5wLG1lKQh8LxWXQGW8k91NV5iyAITNNk8=;
        b=B7dSsW6E06oacrpQ/efBOlHS2lhXWgFkoBX+q0IDwElrcHCPhDOJZ0ZSl+fqvpBy8T
         DROpBaWeOmm7UFmPxtf7VBbSC/C+Twu8qCwYc9kAxCQHXnoFBTpUDK/WmlKF+4oKLcWS
         D7uLpbRLYb8a5sBd5qsJpRSLNzwyca/OLmbrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699468787; x=1700073587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6Zb3+kBxD5wLG1lKQh8LxWXQGW8k91NV5iyAITNNk8=;
        b=vR0sRZ+/+fqblfwNaiMNLhbIl0eH5mc0WLhfnqCu9UWVrznXRPTTLYMixhSn5uPzkw
         Q6E+8acW1VIprar0eE3eVfbvpH3472DR1NBAbGTOXKjeAyfWWanegLRFxEQEfK948Suz
         +MomZEhMgnHqnIXg/ezueU9PAj/5we/PJRoxj/OGwRNgjmU0qesB+soM5wM23roGMeqj
         J/c21fMhKFy07LIs7o4VaJ7/rGPuxeI036ugwQVE6P/6k9CcaDIKNDRBpDOvpWNNSmbU
         Ns2BD3n1MzzbC4dYv+Ui+vC9mNeUSoP6kntpOb/29hhWap76scVHnHdW09C7uq+qTzKj
         sdPA==
X-Gm-Message-State: AOJu0Yxb0ic16tEMVTA40jDu+dzHv2Njwp2JLx9X0WoDAUN1Rbwxj/pr
        IXhLj2x8V9pILDcswvo8R1kKIphyOdzGkjhWhTLteg==
X-Google-Smtp-Source: AGHT+IGDO2j+B5bilMlhR2eSH0VEDePWuhc+ZMjDJzxKAc3bg2dfUbGBwD5tt1olDPHaLpqf9yTYfV9czMMndPzrqXg=
X-Received: by 2002:a05:6512:2248:b0:509:44cd:241c with SMTP id
 i8-20020a056512224800b0050944cd241cmr2618237lfu.32.1699468786562; Wed, 08 Nov
 2023 10:39:46 -0800 (PST)
MIME-Version: 1.0
References: <CACKFLi=VL8kHH-Q4UQF60tGaK2dk7NgH_9-yJpP7hgn_NE9e7Q@mail.gmail.com>
 <20231108181809.2405257-1-alexey.pakhunov@spacex.com>
In-Reply-To: <20231108181809.2405257-1-alexey.pakhunov@spacex.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Wed, 8 Nov 2023 10:39:34 -0800
Message-ID: <CACKFLi=R+yRa-Y5jr=jf9cJmB-rkWSjyHSZOppFMPXb9wTGCTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
To:     Alex Pakhunov <alexey.pakhunov@spacex.com>
Cc:     linux-kernel@vger.kernel.org, mchan@broadcom.com,
        netdev@vger.kernel.org, prashant@broadcom.com,
        siva.kallam@broadcom.com, vincent.wong2@spacex.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005cbe910609a86914"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005cbe910609a86914
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 10:18=E2=80=AFAM Alex Pakhunov
<alexey.pakhunov@spacex.com> wrote:
>
> Hi,
>
> > I think here we need to keep these counters accumulate across a reset:
> >
> > stats->rx_dropped =3D old_stats->rx_dropped + rx_dropped;
> > stats->tx_dropped =3D old_stats->tx_dropped + tx_dropped;
>
> Hm, tg3_halt() explicitly resets the HW counters:
>
> ```
>         if (tp->hw_stats) {
>                 /* Save the stats across chip resets... */
>                 tg3_get_nstats(tp, &tp->net_stats_prev);
>                 tg3_get_estats(tp, &tp->estats_prev);
>
>                 /* And make sure the next sample is new data */
>                 memset(tp->hw_stats, 0, sizeof(struct tg3_hw_stats));
>         }

Right, we reset the hardware counters but only after we save a
snapshot first.  The snapshot will be added to the new counters after
reset.

> ```
>
> We sort of doing the same thing with clearing [tr]x_dropped in
> tg3_init_rings() but it seems more confusing than helpful. First, why do =
we
> handle different counters differently? Second, tg3_halt() is not always
> followed by tg3_init_rings(), so the logic is not consistent.
>
> Instead I think we should just not touch [tr]x_dropped in tg3_init_rings(=
).
> The counters will be set to zero when tg3 is allocated in tg3_init_one().
> Hardware resets will not change tg3_napi::[tr]x_dropped since they are
> purely software counters.
>

Not resetting the tnapi->rx_dropped and tnapi->tx_dropped counters is
an option, but the number of queues (tp->irq_cnt) can change after
reset.  So to always keep the count accurate, we'll have to sum over
all the array entries (TG3_IRQ_MAX_VECS).  I think this will be
confusing and is not consistent with the existing scheme of saving a
snapshot of all counters before reset and then starting from zero
after reset.  Thanks.

--0000000000005cbe910609a86914
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDil2k9EOe+6/nR8025D6MLueROcZHXS
uxifbra8jY0tMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEw
ODE4Mzk0N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCz/adPYgtCWThwz1Q4Lc9P0uGr4GeZklbmVAqpSDb7OMXuGQUn
z6uSFZl3VtuRE2ZxElwnynXUy9Z4pFu+0AXOYQBqS9h6rLxJTop7KLUfhDWyRhA/UqXZFSkMB4Xw
O2U8lxnBEqBfzoyID/cblRNBFn0r81gWImoqhOhXVhn8b7ub5IOAHA57hdXbPaesutkNa2bVcEOZ
OqxbBRVdmHoocH5eC7lVFl17pZgMZQPHnDdpY+hGks/xzWQQLKSODWBvwYGObXUxVPHDzNkXhBPM
NP/FMS6tW5nzhAd+bneYaH9jTPypFBPtx7KEBc7Ig2w6k3rLeXWzr09A/VhkMur4
--0000000000005cbe910609a86914--
