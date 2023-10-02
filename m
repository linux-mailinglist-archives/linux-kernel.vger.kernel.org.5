Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75587B59CA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbjJBRxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjJBRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:53:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4609E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:53:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ae3d7eb7e0so517711566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269184; x=1696873984; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMNM0aRdpEfcCNVG8Zt3kh8xBFlOSvcHGJleVt42moA=;
        b=H2UvYAEihk5hVTLNyJgh6vawLltpmaIkztZa9MxM/aHtsx7tP/zJ1HRsVb1SXlXVpt
         M/RG88wUlo0GpK97KrnbdFsAtfcODFopTZNseXq5bplf5TJKOCcBZKzicqBc846e7J2K
         /bLa+6rdL+sr6vsshkXckmED7QZoA6QU13X6aY2q5Zy4RgL2YO7QAZ5AXu/9SeQyZnPg
         5vPTydc1trJJ4M2HoeZ0mpxa0wgQTNooHes2M1fPfMtcl+VQ6Q7/8dIWY2WqJ9jhPrfJ
         nvSd/GbodVHyzVGtfEZ4957u1x7q0TZgvoMzPt3QzYggjS+tFrRTRAy7s9uTYgCaNPpZ
         abfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269184; x=1696873984;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMNM0aRdpEfcCNVG8Zt3kh8xBFlOSvcHGJleVt42moA=;
        b=T6Yq9Bop1yoZlOYFHmEB7BEKd0xqQEWQl/Z7wWSpAGM9aBOrM0TAIKHypbOvlCBYvA
         0mwSvVm+bJsyDW4u6I2s+SVJq9KOgZ6xQQbUhYjVjel54g+Ej1YSH9xIK4I3jnP00/GW
         3XLDUMT33zWQo+0VELNQaT6dP9k/cLzREvYTdkbU68H9Nl2Wq5vgpJzR2q5ezkglHQlB
         wUqL/5e1m2GB1r5O4o1XNis7+BHIQyZbVs647zNSO2VKxRqYOXfuSDKfytXbSvTrOpSe
         SnufXRloBUSJipKYiBWWuV3bfUXUdLVEZ0JwJSiAvU6kzGm+bbwcYWvTx51xOxh46lZe
         f5TA==
X-Gm-Message-State: AOJu0Yz1fjtozSSiFe1uDpLIRyxWSgWdVBPLxeqijxpUNfPgomZ7MDDu
        qcOMDcQXYAKEK6DA6Fuhv5k=
X-Google-Smtp-Source: AGHT+IFWFHOoILjj1gCnBsboKkDjpRRge8iCCyKPGdNXYWEcYyYGtOooNZfCWIUE/yjtLRDDQTbrfw==
X-Received: by 2002:a17:906:5352:b0:9a1:d79a:4190 with SMTP id j18-20020a170906535200b009a1d79a4190mr10128359ejo.2.1696269183580;
        Mon, 02 Oct 2023 10:53:03 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm17364467ejc.153.2023.10.02.10.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:53:03 -0700 (PDT)
Date:   Mon, 2 Oct 2023 19:53:01 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: rtl8192e: Remove unused functions related to
 removed reset
Message-ID: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused functions rtl92e_dm_backup_state(), 
rtl92e_dm_restore_state() and rtl92e_cam_restore(). Remove unused
variables. Most parts are leftover from the previous patch series.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (8):
  staging: rtl8192e: Remove unused function rtl92e_dm_backup_state()
  staging: rtl8192e: Remove unused function rtl92e_dm_restore_state()
  staging: rtl8192e: Remove unused function rtl92e_cam_restore()
  staging: rtl8192e: Remove unused variable last_ratr
  staging: rtl8192e: Remove unused variable rate_adaptive_disabled
  staging: rtl8192e: Remove unused variable rfc_txpowertrackingindex
  staging: rtl8192e: Remove unused/constant parameter mesh_flag and
    shutdown
  staging: rtl8192e: Remove constant parameter from
    rtllib_stop_protocol()

 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c  | 63 ---------------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h  |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  5 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |  1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   | 83 --------------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h   |  2 -
 drivers/staging/rtl8192e/rtllib.h            |  7 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 22 +++---
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  6 +-
 9 files changed, 16 insertions(+), 174 deletions(-)

-- 
2.42.0

