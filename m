Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC30D7FC5B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346023AbjK1UnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345855AbjK1UnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:43:04 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1411F172E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:11 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b2a628c25so4630375e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701204189; x=1701808989; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8Awudp5GYWpf8rpOsAUkyVnz4CdB7ttjVu4BYCLfzo=;
        b=IuM6Q2aLXuAm2y0OKz+VJn3GaaHx3hn+PhTkwfUY0jJbwDDg+3LrI7Vvc6Hv6IJWYv
         iOmbqVMDZCCnLSigLwtgFbMDPRwXDjScdNLbT3bDLqWZ+GWTJdhE5plU0LQuFpFmk1Eh
         +pb3arBTRwXRaO032R+8lBYsDI5HvK2dVFEikGpmwLW9iO+lzFshG7HXHynhGNaRAjEz
         2luN3fzBKMvXue/Y/aXNuGIV2PuvZPZQ0QI09lGDoCcD+ZNzB+j5zT2O3/Lc+AxJY9Tl
         JWneqbzdMWLEaSwh3ILRYK01gqJ9w5xCj7E3Eb203SBtaMC9/Nfc6kY89S71GCDDLCSd
         Szvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204189; x=1701808989;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8Awudp5GYWpf8rpOsAUkyVnz4CdB7ttjVu4BYCLfzo=;
        b=bDOJG9o7nEBZESp7aXV6JEtVgOL0EtQI0DspSVf6cKMCAOWdoJQz+RcaWp5A7mK2ei
         owLcQhhPcgov7fxsb+HGP0wueacvC8EsPifXN4a1tXdIUYaw7QskMk+17btASSDANV0d
         od2QNc8DtAFIBPgVg+CODQtzvfHOkc9m6Pp+u1Qn2oF7gQmuCM8pT+rIF/QdTw4f0AN8
         9HdC8bArL08DydiWniUE2H7A35A3itPFPDOIOE7JVoDeE7/g6wD6Fnk6AjxANU7DcSox
         /TyUjwNP7Io+s4z3cPb9f5jnACDkoD5EPxgpDOqcSRAt4NXTU9rJjbTZKx6maYP69O60
         5Phw==
X-Gm-Message-State: AOJu0YyWxQzQpJ5ZkoSRFfWooLpG0FExZGzP849WoxLEdeFwzkoiy1DN
        j8WW/4EtoHEtlngF0ek6Bd8=
X-Google-Smtp-Source: AGHT+IEbfJp/yQHh7SQ42Y15xiVD2dKDwlsR63ME/1S17+huXuroYI5EaQ7egaZFPUCUeedYixms4g==
X-Received: by 2002:a05:600c:993:b0:40b:3d90:884e with SMTP id w19-20020a05600c099300b0040b3d90884emr9448329wmp.2.1701204189184;
        Tue, 28 Nov 2023 12:43:09 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0040b3632e993sm18727804wmq.46.2023.11.28.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:43:08 -0800 (PST)
Date:   Tue, 28 Nov 2023 21:43:07 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] staging: rtl8192e: Remove action block acknowledgment
Message-ID: <cover.1701202700.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AP are learning very quickly that rtl8192e driver is handling block
acknowledgment (BA) not as expected.
The log of the driver is showing the following output:
rtl819xE 0000:03:00.0 wlan0: received DELBA while QOS or HT is not supported(0, 1)
Then AP are giving up.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (6):
  staging: rtl8192e: Remove action block acknowledgment
  staging: rtl8192e: Remove unused function rtllib_rx_ADDBAReq()
  staging: rtl8192e: Remove unused function rtllib_send_ADDBARsp()
  staging: rtl8192e: Remove unused function
    rtllib_FlushRxTsPendingPkts()
  staging: rtl8192e: Remove unused function rtllib_rx_ADDBARsp()
  staging: rtl8192e: Remove unused function rtllib_rx_DELBA()

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 262 ----------------------
 drivers/staging/rtl8192e/rtllib.h         |   6 +-
 drivers/staging/rtl8192e/rtllib_rx.c      |  33 ---
 drivers/staging/rtl8192e/rtllib_softmac.c |  30 ---
 4 files changed, 1 insertion(+), 330 deletions(-)

-- 
2.42.0

