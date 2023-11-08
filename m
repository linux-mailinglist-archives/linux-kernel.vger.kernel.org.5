Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4647E526B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjKHJLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjKHJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:11:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F1C1725
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:11:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so11345485a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 01:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1699434706; x=1700039506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EaqDXaOs/op7942EK7D9FQA0DqV6BEYWAfqEkv2slqY=;
        b=GQNJ3uiUO0QCM7eZYCuuXDOu3YLUr3zKRaDCJol5RjYQyaaIaxdzr0IhNe4NC9GcWn
         4piGVC8WATcLD6Fqb3WXO26bDzYe0L5oD8o+4C0HxIlHwNvCnKPQvVjbx+d6R5aYAUU7
         EIbmP1oCsSuzHdAAX9HAX5qrs0UcE0ua5vTKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699434706; x=1700039506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EaqDXaOs/op7942EK7D9FQA0DqV6BEYWAfqEkv2slqY=;
        b=Som5WfL6mLTbzMKFcZOUREhM5pCfBLnHKWsZLI3m4ulCYLIi8/KF4yGAyH2g1itTUQ
         NtnAar6Zvw6DXMkcwhM6mvRGb8ZjlLg5r4O3F/V5IIuZjff8IzwQTCrlnskT+gQsutNW
         c+g9w5lL2MbMY5LgV4AkPykcKPngf7YqBFp3DQ6tYFn/7iwSHbxQBKADgmf8HF+dLu/9
         kpEIw92lawp93lRS9aYS3KvjmgpMQ428AW/Fq+L8nHYVAIEEUPVHnfMctYeTlHOwqufj
         nWu68UvI/qy6s0eiGbL1RTuALxKTU80sGVn/7YK52XMqmKhwwQfmKFAydBNXiIpbCghG
         jYkA==
X-Gm-Message-State: AOJu0Yw11o2N9zRF6KdXvV3xg0EpimOsjRNIHF2Z2sYisjsYKEzBi6+Z
        fcrDwQAqldvicAMUZA6yraXftGmHgPFdz1C7LldxJQ==
X-Google-Smtp-Source: AGHT+IFT2SFJTGzzr8nvrwYJuArjzQOPkb9wjA7bseEogcFh7rn13hpWlbHZ69aMtM4D4lyhZXsSZFXzukFpYmmB53I=
X-Received: by 2002:a50:9303:0:b0:543:566f:2e89 with SMTP id
 m3-20020a509303000000b00543566f2e89mr891741eda.37.1699434705567; Wed, 08 Nov
 2023 01:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20231108010129.2009947-1-alexey.pakhunov@spacex.com>
In-Reply-To: <20231108010129.2009947-1-alexey.pakhunov@spacex.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Wed, 8 Nov 2023 01:11:33 -0800
Message-ID: <CACKFLi=VL8kHH-Q4UQF60tGaK2dk7NgH_9-yJpP7hgn_NE9e7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
To:     alexey.pakhunov@spacex.com
Cc:     mchan@broadcom.com, vincent.wong2@spacex.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        siva.kallam@broadcom.com, prashant@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fa98310609a079a0"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000fa98310609a079a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 5:01=E2=80=AFPM <alexey.pakhunov@spacex.com> wrote:
>
> From: Alex Pakhunov <alexey.pakhunov@spacex.com>
>
> This change moves [rt]x_dropped counters to tg3_napi so that they can be
> updated by a single writer, race-free.
>
> Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
> Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
> ---
...
> @@ -11895,6 +11898,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct=
 rtnl_link_stats64 *stats)
>  {
>         struct rtnl_link_stats64 *old_stats =3D &tp->net_stats_prev;
>         struct tg3_hw_stats *hw_stats =3D tp->hw_stats;
> +       unsigned long rx_dropped =3D 0;
> +       unsigned long tx_dropped =3D 0;
> +       int i;
>
>         stats->rx_packets =3D old_stats->rx_packets +
>                 get_stat64(&hw_stats->rx_ucast_packets) +
> @@ -11941,8 +11947,23 @@ static void tg3_get_nstats(struct tg3 *tp, struc=
t rtnl_link_stats64 *stats)
>         stats->rx_missed_errors =3D old_stats->rx_missed_errors +
>                 get_stat64(&hw_stats->rx_discards);
>
> -       stats->rx_dropped =3D tp->rx_dropped;
> -       stats->tx_dropped =3D tp->tx_dropped;
> +       /* Aggregate per-queue counters. The per-queue counters are updat=
ed
> +        * by a single writer, race-free. The result computed by this loo=
p
> +        * might not be 100% accurate (counters can be updated in the mid=
dle of
> +        * the loop) but the next tg3_get_nstats() will recompute the cur=
rent
> +        * value so it is acceptable.
> +        */
> +       for (i =3D 0; i < tp->irq_cnt; i++) {
> +               struct tg3_napi *tnapi =3D &tp->napi[i];
> +
> +               rx_dropped +=3D tnapi->rx_dropped;
> +               tx_dropped +=3D tnapi->tx_dropped;
> +       }
> +
> +       /* The counters wrap around at 4G on 32bit machines. */
> +       stats->rx_dropped =3D rx_dropped;
> +       stats->tx_dropped =3D tx_dropped;

I think here we need to keep these counters accumulate across a reset:

stats->rx_dropped =3D old_stats->rx_dropped + rx_dropped;
stats->tx_dropped =3D old_stats->tx_dropped + tx_dropped;

> +
>  }
>

--000000000000fa98310609a079a0
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOvqVP23Dn9/POnZoYnqqairy+j9908o
2trpN46/BSVrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEw
ODA5MTE0NlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAHq6xFPbRSQMfFGvqC8YRbKbFdAV10uWuyD54WSADMYArn9Ia2
+o2GSCP6i7qQJjYY+qg/9Rv7Ce7HgUYwhQbEo0mR304qjOYnryPd+nCN4GEQghnOuWHBfcDuDxuY
L2Fn3PBqWrouHCFG18zqjJQGrM7Oyfwk6BSfy+FVLz8WeP7/HtaOBrk3uLOPDL4LHH+p37IPGqzb
hj3G2b+23uTYDgIrJrLz1KpQ9V+HNep3M/CUCn/qfUolraNq0T4K9w67sKeFOUN1FSKcnCmmI6BG
MBhHaUJbTGXmad6iWiEnuhug2dhepnh3GnYWU7Kc071Pwc/cuoODfuEJle0cefwx
--000000000000fa98310609a079a0--
