Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0517F857C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjKXVaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjKXVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:30:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B80219B2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:19 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a04cfeecb15so66101966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700861418; x=1701466218; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6R1/B3Gpd0WqEyYMT6wMEe4jySl/wJKQezxM85rFgxE=;
        b=RMYz2cQ4k9pjIvCr9OlJ2Bq3Tzvy9XSOAxJWMv260KcanIyHX1+X88iec8turAFFCe
         yF3CLPTKwSIyXDcADKEsxKnENKK98sloDvfz6qFyw7GKlTJe/ar49xUkWtEnxcVB9gFj
         Vaqc+0AbE6YEWIy+9ba6SO4qVv7EBz5oFaQwoglAjqSXQ0srNfXjXXNxMwudhho39nAm
         ZHQdnHsac7ibjQi/6Jv7VV18u/dTLiKdZBS/et9bz0hI/uMWS9xw9AUGSe2GKXsT/0/Y
         Y5X8ycIQSqjXznwHFiYdT8Mbm8S/Y1qdbIGWluxb34zXR0GEzCf2NPfIcwAd1613lq+0
         JXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861418; x=1701466218;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6R1/B3Gpd0WqEyYMT6wMEe4jySl/wJKQezxM85rFgxE=;
        b=sgcQ9SW55xB+6HOaDxVt0Zlz1zRkHcOEcKX510YbPyqb86liNBX6a6g87EZ6fy+kkz
         DXq0NA2kzScOkiqsEk9y3yiK/mN3PjyM2XJXXenOzr2OG9zdoFZvBR9MK39KSqDZspRK
         gy8AFpG8Ww2LZjF4jkCSH4IlbGciHUmnBomvrq64f0aSXGg2AaaU+d3ikdt5IWyzFswi
         OGFDeH8Tp2CxVRG4xOD1M+px2Ne5GW6SEm8DEpT6LnYOCRGpmmcMb9tWaIvj/jXrVPmy
         ls/QfoVpdXyXa+Lv7yAc0ySIGTfT26+Aqscf7S9KLWnk5Jm6DP4E5CfKHC+rf5VU13Fg
         Uptg==
X-Gm-Message-State: AOJu0Yxud3ig16JUS/UKCYqAht6ey3uWblU0D1RKayJ5u65JRM0lJBr5
        tFVGFHbpE1NVTE5nq6OMpYY=
X-Google-Smtp-Source: AGHT+IEWbmcnVqC9MkWPJSylBqhlInbTCWAcS/eX5prInruM0qp5xcSBhoChSK10CO9Z/PAWaWacpg==
X-Received: by 2002:a17:906:6dd2:b0:a01:ee03:37ee with SMTP id j18-20020a1709066dd200b00a01ee0337eemr3069238ejt.4.1700861417761;
        Fri, 24 Nov 2023 13:30:17 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906285500b00a0179ebc25esm2535720ejc.85.2023.11.24.13.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:30:17 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:30:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: rtl8192e: Remove sending beacons
Message-ID: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
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

This driver supports station infrastructure and monitor mode. Therefore
it does not have to be able to send beacons. Remove all code with the
preparation of beacons.

There are two ways to time beacons. One is via an interrupt from
hardware and one is from a timer in the driver. Both are removed.
 
Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (8):
  staging: rtl8192e: Remove unused interrupt for IMR_BcnInt
  staging: rtl8192e: Remove unused function rtllib_get_beacon()
  staging: rtl8192e: Remove unused timer beacon_timer
  staging: rtl8192e: Remove unused function rtllib_send_beacon()
  staging: rtl8192e: Remove unused function rtllib_get_beacon_()
  staging: rtl8192e: Remove unused function rtllib_probe_resp()
  staging: rtl8192e: Remove unused function HTConstructInfoElement()
  staging: rtl8192e: Remove function rtl92e_update_rx_pkt_timestamp()

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  48 ----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |   5 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |  16 --
 drivers/staging/rtl8192e/rtllib.h             |   5 -
 drivers/staging/rtl8192e/rtllib_softmac.c     | 219 ------------------
 6 files changed, 1 insertion(+), 296 deletions(-)

-- 
2.42.0

