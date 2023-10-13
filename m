Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6867C880A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjJMOno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjJMOnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:43:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C3D95
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:43:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40651b22977so5490645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697208220; x=1697813020; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aG00PdL+ABV3Jv6f2eYnPmx4jdva3XIyRSs1GmjeDRM=;
        b=lneYxYmwOn8GVvKrlXk3TzUXab6eLbd4BfwTUhWh0RAZfkLD6rS2HdxTZuLh36FYB/
         6FRR3OI8VO+RYTwP3EdPlTjy+ZxVSqQMI3z82/Wf5TuYrxqScRVamPZwU0Nipw/v0nUP
         DGrwtKCeSknu2ayEI1pjmy3AjeUK7F5PrK3dZz4hmfDDrz1D1E1YJbF3HPDzUKStBMWs
         O07tEmRwOFpdlKagR6/pCQRM4bjqn6l9uVidPQE1dWSbC9jFJsaMHZ5pwMeiGjQ3Vqsf
         aP4SDEe6PULQdw7j+2bQ0bTRM/3TqrBuF4tvtx/YgKAYgqMPUbhMc+KToaaT/OM4+PSD
         1FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697208220; x=1697813020;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aG00PdL+ABV3Jv6f2eYnPmx4jdva3XIyRSs1GmjeDRM=;
        b=B8GvG+YGNcWS034Wsii1JvmWSNT3EfTHFmt6d4FxdJAv59TsczMI1YuzK43em562Yd
         BD0f6ed0LzNaSNBp48SVulyCMGkMZ+vwbZsu+OTRwmVPKJzatz2ZLW3sRE2E3itbpir+
         dj6MqUke/44rNlIUA6t1xsjLRKVHQ6VXJ0g5wGuKC5XgFvfkWeSL7PKdo6zxFkmZfnLx
         NtmdHdmSDob+XAfwdbIDi0kTAxQxoXASSb0tA8v8/BPJPaSflNlFopOV/hoNFiGq4JeH
         Mm18eLALYZIIqNn/CZEhgEylOvrsAN8XLNSghmkmLNlqSKGf5DGPcvgpViVwyppqn0pJ
         AkQA==
X-Gm-Message-State: AOJu0YxRPnY5n3viJpBQtZrRSMMwBmr0ch9go/hi0erfr+oTxuN2CxFD
        l1w0Di7LZNKiTbxkPOJX+vA=
X-Google-Smtp-Source: AGHT+IFZHMYoZSSUtr3q6NTzx3Uiw4NKh8ZutBAl4ivgaTx+RZn/TD04HA2nWIBGiwIEO6YIsyBkSQ==
X-Received: by 2002:a05:600c:1d18:b0:404:72f9:d59a with SMTP id l24-20020a05600c1d1800b0040472f9d59amr24407294wms.0.1697208219797;
        Fri, 13 Oct 2023 07:43:39 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id bg21-20020a05600c3c9500b004053e9276easm317825wmb.32.2023.10.13.07.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:43:39 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:43:37 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] staging: rtl8192e: Remove unchanged variable
 dig_enable_flag
Message-ID: <cover.1697127817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead code leftover from previous patches.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (6):
  staging: rtl8192e: Remove unchanged variable dig_enable_flag
  staging: rtl8192e: Remove unchanged variable dig_algorithm
  staging: rtl8192e: Remove
    _rtl92e_dm_ctrl_initgain_byrssi_false_alarm()
  staging: rtl8192e: Remove unchanged variable dig_algorithm_switch
  staging: rtl8192e: Remove unused variable dig_state
  staging: rtl8192e: Remove unused enums dm_dig_sta and dm_dig_alg

 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  11 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 156 +-----------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h    |  25 ---
 3 files changed, 1 insertion(+), 191 deletions(-)

-- 
2.42.0

