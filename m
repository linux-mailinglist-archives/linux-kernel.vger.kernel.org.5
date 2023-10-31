Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D617DD740
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 21:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjJaUqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjJaUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 16:46:18 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6DCF9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:46:15 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35904093540so4506215ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1698785175; x=1699389975; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7eXo0ddf+sciRuQugdUDq24628/XZno+8x5fyRm3rT0=;
        b=iaiipl/GGdOYRL98K4uLSs8KCogs9PnSOleZWt1laNpE1/7DNAUO3k2hFMiEhh1uTs
         kl0ydjhvVBvR2X2MoZXur8THLCJ0U4HPO+R0cdcd4AG29NIJyi2Yv4ovvZJ/O8OZLId6
         DXTWslgCF2KY77V+C0HAFcBO34wIXKGtkHF5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698785175; x=1699389975;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eXo0ddf+sciRuQugdUDq24628/XZno+8x5fyRm3rT0=;
        b=LUjjcmHcZgjCf22/09pRFMIy4dShaLqdmpdgRQkYKMzOfJZnnFHiWm6Ht3dqA49Uwl
         95uYjLmzDIL9Rvi0+d1Bza5Ntf+AgD9oCPVA/YuHnz3Qiypv1/8w+/yaJK4emVXYbTMZ
         edL8xgQEWGn6569UDdtwxw3wJNISqJvUS5vgHJiwu8VmxSTCGdStA06XGc16+7yxjO98
         R1Lx3QFRc6BZZHqeGGLFOTA+jk9f/XoCRLJtqnCGMYUB7wnzotHaB9efV/2lklrkSbmS
         711BR7IVOslEFjhBb5s8cIK7GKlklN5mxcpMOlxoVeUnUsjI/OuCo75G1Xb8MnliqrR9
         OS9g==
X-Gm-Message-State: AOJu0YxD5nkVWDl5Xk2fOAjAA0lAkvvAGYQDR9qhQXYJJ4EurmivY/MX
        1f6czNWeWJCI4ZHu27Q/L3UFNg==
X-Google-Smtp-Source: AGHT+IHiv4MyuMnuGvdptxenePWIcQYm+rdtE9PV44sipnpUH4f1tTqlhq2fHE/CQYl5z3RzKMuhDw==
X-Received: by 2002:a6b:500a:0:b0:792:6068:dcc8 with SMTP id e10-20020a6b500a000000b007926068dcc8mr15387509iob.2.1698785175129;
        Tue, 31 Oct 2023 13:46:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id p30-20020a056638191e00b004596858b397sm540000jal.7.2023.10.31.13.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 13:46:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------oSst4u9RT5c61q10b1otNbDp"
Message-ID: <30046a10-bd4d-4c5d-ac55-f8862f01e141@linuxfoundation.org>
Date:   Tue, 31 Oct 2023 14:46:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.7-rc1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------oSst4u9RT5c61q10b1otNbDp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.7-rc1.

Please include it in your next pull if you already sent your
PR.

This cpupower update for Linux 6.7-rc1 consists of a single fix to
documentation to fix reference to a removed document.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.7-rc1

for you to fetch changes up to 6feb1a9641197ee630bf43b5c34ea1d9f8b4a0aa:

   cpupower: fix reference to nonexistent document (2023-10-25 10:14:35 -0600)

----------------------------------------------------------------
linux-cpupower-6.7-rc1

This cpupower update for Linux 6.7-rc1 consists of a single fix to
documentation to fix reference to a removed document.

----------------------------------------------------------------
Vegard Nossum (1):
       cpupower: fix reference to nonexistent document

  tools/power/cpupower/man/cpupower-powercap-info.1 | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
----------------------------------------------------------------
--------------oSst4u9RT5c61q10b1otNbDp
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.7-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.7-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1wb3dlcmNh
cC1pbmZvLjEgYi90b29scy9wb3dlci9jcHVwb3dlci9tYW4vY3B1cG93ZXItcG93ZXJjYXAt
aW5mby4xCmluZGV4IGRmMzA4NzAwMGVmYi4uMTQ1ZDZmMDZmYTcyIDEwMDY0NAotLS0gYS90
b29scy9wb3dlci9jcHVwb3dlci9tYW4vY3B1cG93ZXItcG93ZXJjYXAtaW5mby4xCisrKyBi
L3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL21hbi9jcHVwb3dlci1wb3dlcmNhcC1pbmZvLjEKQEAg
LTE3LDcgKzE3LDcgQEAgc2V0dGluZ3Mgb2YgYWxsIGNvcmVzLCBzZWUgY3B1cG93ZXIoMSkg
aG93IHRvIGNob29zZSBzcGVjaWZpYyBjb3Jlcy4KIC5TSCAiRE9DVU1FTlRBVElPTiIKIAog
a2VybmVsIHNvdXJjZXM6Ci1Eb2N1bWVudGF0aW9uL3Bvd2VyL3Bvd2VyY2FwL3Bvd2VyY2Fw
LnR4dAorRG9jdW1lbnRhdGlvbi9wb3dlci9wb3dlcmNhcC9wb3dlcmNhcC5yc3QKIAogCiAu
U0ggIlNFRSBBTFNPIgo=

--------------oSst4u9RT5c61q10b1otNbDp--
