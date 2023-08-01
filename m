Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3A76C062
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjHAWZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjHAWZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:25:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B12EE57
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:25:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f090316dso4216197b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690928716; x=1691533516;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bTzvg6EZhXYEb9j5H58gLFqen57ziRPXJ/lg7K/DLTA=;
        b=BZZzs+1E1YUNGqAE/gopvowI2DsrQ8oWG311uUenPu7qC6dOrtV7MF3OAzCMYipufy
         Zp+IQy/aCWjNm6hFlZU6dRmp5CEpVM7rWBoZt7w4/DXnjeC6n5IaQKVaExB6aNxaGrJg
         /Iv1wUEFxarUTWnSEla/zUUWKXkHtJeQAmXdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690928716; x=1691533516;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTzvg6EZhXYEb9j5H58gLFqen57ziRPXJ/lg7K/DLTA=;
        b=C5qmfVzv8kgmDyvgHjUGGGX8a2eO8rrdPvfcZ5nuh8QE9GIxNs2AlWgDevJqTclb2M
         IcOCxb69YwH9rxX0Txd3o7RxlN8/8ozG9knYk1Nbjl78kbxOn1OfJBryKADy/6TCvXG1
         56lvJGn4SF/yAXaKpsJe0SeVoJcOaFi6esxO289UI809NPfd0VvlaKg0USG/rTkNMajR
         UZlRCy7xIV7D121sCQD6Tmv0Jl29xPAIiweyFv4UhGJzJ41G7bRQvThvzrAcTmoPPcp6
         vVIBip35Zntglh3dvra8NImafvXMsji7gnPIshFCJbyV1LspQf8eZMuvgQ38avsMMoTs
         5lQQ==
X-Gm-Message-State: ABy/qLaLCCG7oitgmh9FJN4H1aEdpRJwPvuFfTAUqU3LS/Zkpql1CzA0
        /WAYl8D7Qn5qZStlFlZolIu/aA==
X-Google-Smtp-Source: APBJJlEN+EnFB28PvfkiYEJLKzgFgJRH1Z16xAA/wJRGmeKtk1J7iwtw5AJ+LtZKYQynaFLvUHiXQA==
X-Received: by 2002:a05:6a21:7895:b0:132:1e76:6f02 with SMTP id bf21-20020a056a21789500b001321e766f02mr15774247pzc.34.1690928715632;
        Tue, 01 Aug 2023 15:25:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s4-20020aa78284000000b00679a4b56e41sm7536622pfm.43.2023.08.01.15.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 15:25:15 -0700 (PDT)
Message-ID: <8fcbe485-ce6b-c500-56da-77cae0c872ff@broadcom.com>
Date:   Tue, 1 Aug 2023 15:25:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000075eb040601e405f8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000075eb040601e405f8
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafal,

On 8/1/23 15:10, Rafał Miłecki wrote:
> Hi,
> 
> Years ago I added support for Broadcom's BCM53573 SoCs. We released
> firmwares based on Linux 4.4 (and later on 4.14) that worked almost
> fine. There was one little issue we couldn't debug or fix: random hangs
> and reboots. They were too rare to deal with (most devices worked fine
> for weeks or months).
> 
> Recently I updated my stable kernel 5.4 and I started experiencing
> stability issues on my own! After some uptime (usually from 0 to 20
> minutes of close to zero activity) serial console hangs. I can't type
> anything and I stop getting any messages. I've to wait about a minute
> for watchdog to kick in and reboot device.
> 
> #####
> 
> I took that great chance and decided to track the regression.
> 
> Linux 5.4 stable branch worked stable up to the release v5.4.197.
> Starting with v5.4.198 I started experiencing those stability issues. I
> bisected it down to the commit 4460066eb248 ("ipv6: fix locking issues
> with loops over idev->addr_list"):
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=4460066eb2480b9e203c73755e12e2efc820a27e
> 
> With above commit reverted I was able to use stable 5.4 branch up to the
> release v5.4.207. Starting with v5.4.208 it got unstable again. I
> bisected it down to:
> commit d0d583484d2e ("locking/refcount: Consolidate implementations of
> refcount_t")
> commit dab787c73f6e ("locking/refcount: Consolidate
> REFCOUNT_{MAX,SATURATED} definitions")
> commit 0d3182fbe689 ("locking/refcount: Move saturation warnings out of line")
> commit 809554147d60 ("locking/refcount: Improve performance of generic
> REFCOUNT_FULL code")
> commit 9c9269977f03 ("locking/refcount: Move the bulk of the
> REFCOUNT_FULL implementation into the <linux/refcount.h> header")
> commit 04bff7d7b808 ("locking/refcount: Remove unused
> refcount_*_checked() variants")
> commit 513b19a43bec ("locking/refcount: Ensure integer operands are
> treated as signed")
> commit 68b4ee68e8c8 ("locking/refcount: Define constants for
> saturation and max refcount values")
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=d0d583484d2ed9f5903edbbfa7e2a68f78b950b0
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=dab787c73f6e38d8e7ed3c1e683385e8f0fe28a2
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=0d3182fbe689e3808c03b6cde6be98237f9e0a4a
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=809554147d609163cfbaf815c443c575b538a7ef
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=9c9269977f03ab9c448c8b71581a951e0eb4fb7b
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=04bff7d7b8081c4bb2e8171be31d33df297eee5b
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=513b19a43becee5f7af6d283bb9d3d241a8a21a8
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.4.y&id=68b4ee68e8c8800cf8d6b61cc74b4031a0742a4c
> (I didn't actually check above commits individually).
> 
> Reverting above locking/refcount commits worked fine for few releases:
> up to the v5.4.219. Starting with v5.4.220 I got hangs again. I bisected
> that down to the commit 131287ff833d ("once: add DO_ONCE_SLOW() for
> sleepable contexts").
> 
> Reverting that extra commit from v5.4.238 allows me to run Linux for
> hours again (currently 3 devices x 6 hours and counting). So I need in
> total 10+1 reverts from 5.4 branch to get a stable kernel.
> 
> #####
> 
> I'm clueless at this point. Is that possible kernel has some locking bug
> I can hit only using this specific SoC? BCM53573s have a single ARM
> Cortex-A7 CPU running at 900 MHz. The only unusual thing about this hw I
> can think of is a slow arch timer running at 36,8 kHz.

 From the look of it, it seems like the CPU might have bugs with atomics?

Your log indicates that your Cortex-A7 is r0p5 which is described to be 
susceptible to ARM_ERRATA_814220, do you have it enabled by any chance, 
if not, can you enable it and see if makes any difference?

> 
> I tried compiling kernel with:
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_WQ_WATCHDOG=y
> but it didn't change or report anything.
> 
> Unfortunately enabling *any* of following options:
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> seems to make locksup/hangs go away. I tried for few hours.
> 
> Sadly I don't have access to JTAG or any low level debugging interface.
> 
> Does looking at commits I reported above give anyone a hint on what may
> be going on maybe?
> 

-- 
Florian


--00000000000075eb040601e405f8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQeQYJKoZIhvcNAQcCoIIQajCCEGYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3QMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICQwEu4WDP0ATx8W
OI8/zYQJ8QtOKzMLI5xAYn/i4xdoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDgwMTIyMjUxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCRHTfzcO0UzzyDQWQglUj4lXAzL8o5U/2A
oxrz2DpOkz9RZE6ooDi4Qf/0VHzcu9mFPJbMxbk7KtKLMQChI/2yeOpCN+YYI4RnKRZt8DuIrlnY
K+/Sgld1T5+Jrp/IF+NjSNSWTZLEzs5pUUgnbm+kNKxyPDtl1NGIc5cY49KOeblFDP+dgcTwjJDl
RUpZaN63OA1yh10rsqyOCf1ItukGVBVGxVO9DEUK1h/V9DO3fwmuhfcv4jWZv+/zK3dolKjh0yIu
AirHAM4i8rjjjJkAK3qIPYB5uzq2B/2dP4Qd6Z4oBhdswUXeObxH2n/11sDYOl8e74BynE/yPpYX
tDEc
--00000000000075eb040601e405f8--
