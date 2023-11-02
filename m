Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825A47DFB44
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377408AbjKBUJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjKBUJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:09:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D815138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:09:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5406c099cebso2178421a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698955790; x=1699560590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8zXO3phoTEViix+hMviy+60LnVgetDBy9jBk4zJkYs=;
        b=VoD+kuwio8gideyjxwcn+57WqAVQupwwj3kJBx6tCHcC9p/692FJRwM9cf3UVn5nad
         2ClSMD1Au365zd3z0jUDnVo/0rgoQ5kDvekzwG6Nf9SNle2/EiNcJGeX9ai9T39KyROA
         SDyMj0M2w8M7t/OeFQAhsb7iBUGtj4BLZT2CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698955790; x=1699560590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8zXO3phoTEViix+hMviy+60LnVgetDBy9jBk4zJkYs=;
        b=LtKqp74zw+sBMa0Qp4/vl/twt2MAkRwgcie8hB4xOZsu+LME1LDCZnZJJ6lczV/9OW
         OxgE9wUiKVFl6DtDODhrJf9UNxoC/uwhDyU2k3tF5fM/1R5hJXfg0XmgxlCMHZYva/MK
         RJ0DHzqAjia4yptPn+ACbgRZ1CvWXBQg9Ut7pLZazR9GBKus9Kfk07urt1n7MWcQPM/G
         r3LiAnVaeXRCkHW7IrzhI8KfADM3ywtsfTqou9IETzwioRwJxQ5SMUibqcnT5C1AVT97
         np7VCaWTnOxbp+HC1NKn1m7AiKhe8TE4+x+7yQNL5CyTAKNDkJIJdm1Huk/Ht43riDqi
         kZZg==
X-Gm-Message-State: AOJu0YygSEp1oCWFmn5yBJD5Oaelzl3fDjzxFvMXWyojnlMiMKDgwFqV
        WhHXy9r7bfnAzDaKBLWPMPAKHvnrQOfmwvtZDVfDRA==
X-Google-Smtp-Source: AGHT+IFMs7gE+1afbOornL2C6s85fqkKlonfMCmtw8Cg9X5GeakuiHBeXRXvxmeqTGprGyxJMA4GonoqP0NIHogGBWQ=
X-Received: by 2002:a05:6402:2032:b0:540:e935:81d6 with SMTP id
 ay18-20020a056402203200b00540e93581d6mr15324359edb.6.1698955789716; Thu, 02
 Nov 2023 13:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231102172503.3413318-1-alexey.pakhunov@spacex.com> <20231102172503.3413318-3-alexey.pakhunov@spacex.com>
In-Reply-To: <20231102172503.3413318-3-alexey.pakhunov@spacex.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Thu, 2 Nov 2023 13:09:38 -0700
Message-ID: <CACKFLin3AQD07nOg2ZBAw5H7E+8hVMwSjw-CBphpkHPzwCUyXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tg3: Fix the TX ring stall
To:     alexey.pakhunov@spacex.com
Cc:     mchan@broadcom.com, vincent.wong2@spacex.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        siva.kallam@broadcom.com, prashant@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005d3efb060930f814"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005d3efb060930f814
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 10:25=E2=80=AFAM <alexey.pakhunov@spacex.com> wrote:
>
> From: Alex Pakhunov <alexey.pakhunov@spacex.com>
>
> The TX ring maintained by the tg3 driver can end up in the state, when it
> has packets queued for sending but the NIC hardware is not informed, so n=
o
> progress is made. This leads to a multi-second interruption in network
> traffic followed by dev_watchdog() firing and resetting the queue.
>
> The specific sequence of steps is:
>
> 1. tg3_start_xmit() is called at least once and queues packet(s) without
>    updating tnapi->prodmbox (netdev_xmit_more() returns true)
> 2. tg3_start_xmit() is called with an SKB which causes tg3_tso_bug() to b=
e
>    called.
> 3. tg3_tso_bug() determines that the SKB is too large, ...
>
>         if (unlikely(tg3_tx_avail(tnapi) <=3D frag_cnt_est)) {
>
>    ... stops the queue, and returns NETDEV_TX_BUSY:
>
>         netif_tx_stop_queue(txq);
>         ...
>         if (tg3_tx_avail(tnapi) <=3D frag_cnt_est)
>                 return NETDEV_TX_BUSY;
>
> 4. Since all tg3_tso_bug() call sites directly return, the code updating
>    tnapi->prodmbox is skipped.
>
> 5. The queue is stuck now. tg3_start_xmit() is not called while the queue
>    is stopped. The NIC is not processing new packets because
>    tnapi->prodmbox wasn't updated. tg3_tx() is not called by
>    tg3_poll_work() because the all TX descriptions that could be freed ha=
s
>    been freed:
>
>         /* run TX completion thread */
>         if (tnapi->hw_status->idx[0].tx_consumer !=3D tnapi->tx_cons) {
>                 tg3_tx(tnapi);
>
> 6. Eventually, dev_watchdog() fires triggering a reset of the queue.
>
> This fix makes sure that the tnapi->prodmbox update happens regardless of
> the reason tg3_start_xmit() returned.
>
> Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
> Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
> ---
> v2: Sort Order the local variables in tg3_start_xmit() in the RCS order
> v1: https://lore.kernel.org/netdev/20231101191858.2611154-1-alexey.pakhun=
ov@spacex.com/T/#t
> ---

Thanks.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--0000000000005d3efb060930f814
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDZE8fPIjhSTT0Fr5sXQfho3nipYwTgr
Ow7zP1zoeTI4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEw
MjIwMDk1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCeunuSyFVM+Zcs1qFcFe2Ml0/2djBK0AZn3vwQ+LYKcthiG7lH
lE4TWPMA29kXhIFqDUC2KcsjaXIC/jfOIIjXmKi02hSVmVyeW0DcnT1jE1e+ulkSt+ebJhmf0QU7
bxOwudYUPEEjXo6M1bmCGhVpNL4in71zORZcnHJPZeku49q3fFCHIJthGVjSIRzET0Vy8868hgd6
gghzeEeDLEA7a1IXzmVQIjQ8vedHhS47r2O8QjHl+QgOcDBRrHRMcPRxKXv/7ybtgSrEGWc7kCWT
yItbIM/PInp769GnJO/++PCozHyCUCi6vfuB6WYMuKEicqksafE/37ioUBLPDj+H
--0000000000005d3efb060930f814--
