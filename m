Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9703E7F203B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjKTW0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjKTW0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:26:02 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836FEA2;
        Mon, 20 Nov 2023 14:25:58 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6c34e87b571so3927964b3a.3;
        Mon, 20 Nov 2023 14:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700519158; x=1701123958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIewKBhuaI5kA/pG5c0UrmfJakVAsL1vNxVtUi7+Ncc=;
        b=f0mNcaCDXKSQoK/UUiIwDCYLSqKF+qIDt+KbzNFij4qI3UjrTjgcEzCfrX8Hbo4s5Z
         csnG/87N1b8yKFW/+dgH3iTVyKHQhKNNgnEkTr36CDV0XGi/+w9OxEhocwN9BiuYrgdi
         uk0d+RRJJj5XyWDTl/vFCkfhkogBjzaEogWml64zKWjXdiNVKFlxjAF2tRrqOqmfeALw
         wHm4qWRAdtQmDvii0ReIO5BOYE6SaUfmQmMXnyIqWcEKSMpAn4/ncJDa7FTNhZIrroBd
         MP9SGxkvl/WltXuDzrK4/g1PX16r8AbcMH5wistmyK9bNrvws4/UdikGW5zOARKhAYu1
         V+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700519158; x=1701123958;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIewKBhuaI5kA/pG5c0UrmfJakVAsL1vNxVtUi7+Ncc=;
        b=g/Cstt8XnTZXcEOKQ9e3/Ge4upRrsm4yeSS+Tp7dwQuS0fo0ue5Pc1sixezNjn8Rvr
         tcAoWoskcGVSZEMQJDgDTPvDgOCJh3m/7NEUW0Z7uSnehBWdXAp34073FrB09iE6d9x+
         n0JTtuuGpbs9r8m4XrG7f7lSG//atqScvqXTpAJMRvANaZS87Drb1kpsXfwuH02Aq6O9
         HRWNXkO1OKAezc2k0t+ynkxraPqNvYxKbByp0tiiHyCq8HUdtZH81w4bN4orDDo7uamN
         rFKoglHipVyfTafJU4U7xA19vSdnclw4UdI9r+5Ko9LXRFNYPamMGBk7Ag0XGnnOEQsr
         O1OA==
X-Gm-Message-State: AOJu0Yy/c0H5d0MlHtELKsqGDCMjDdDFhem3RzvYgHwxSVkdTJrw47e6
        vgLmFKXq/Yx0nEZS1a997Lo=
X-Google-Smtp-Source: AGHT+IGAqE9bwjRGCyAX/cznPjzCAw5yqxf09VgWksVXVXQ5GdjVlRkYSao/SWly4rvufkHZSlxZSw==
X-Received: by 2002:a05:6a00:438b:b0:6bc:ce7a:6f39 with SMTP id bt11-20020a056a00438b00b006bcce7a6f39mr3294563pfb.32.1700519157774;
        Mon, 20 Nov 2023 14:25:57 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id g11-20020a056a00078b00b006cbb51b9974sm1337049pfu.173.2023.11.20.14.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:25:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 20 Nov 2023 12:25:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH block-6.7] blk-iocost: Fix an UBSAN shift-out-of-bounds
 warning
Message-ID: <ZVvc9L_CYk5LO1fT@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When iocg_kick_delay() is called from a CPU different than the one which set
the delay, @now may be in the past of @iocg->delay_at leading to the
following warning:

  UBSAN: shift-out-of-bounds in block/blk-iocost.c:1359:23
  shift exponent 18446744073709 is too large for 64-bit type 'u64' (aka 'unsigned long long')
  ...
  Call Trace:
   <TASK>
   dump_stack_lvl+0x79/0xc0
   __ubsan_handle_shift_out_of_bounds+0x2ab/0x300
   iocg_kick_delay+0x222/0x230
   ioc_rqos_merge+0x1d7/0x2c0
   __rq_qos_merge+0x2c/0x80
   bio_attempt_back_merge+0x83/0x190
   blk_attempt_plug_merge+0x101/0x150
   blk_mq_submit_bio+0x2b1/0x720
   submit_bio_noacct_nocheck+0x320/0x3e0
   __swap_writepage+0x2ab/0x9d0

The underflow itself doesn't really affect the behavior in any meaningful
way; however, the past timestamp may exaggerate the delay amount calculated
later in the code, which shouldn't be a material problem given the nature of
the delay mechanism.

If @now is in the past, this CPU is racing another CPU which recently set up
the delay and there's nothing this CPU can contribute w.r.t. the delay.
Let's bail early from iocg_kick_delay() in such cases.

Reported-by: Breno Leitão <leitao@debian.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 5160a5a53c0c ("blk-iocost: implement delay adjustment hysteresis")
---
 block/blk-iocost.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 089fcb9cfce3..7ee8d85c2c68 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1353,6 +1353,13 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 
 	lockdep_assert_held(&iocg->waitq.lock);
 
+	/*
+	 * If the delay is set by another CPU, we may be in the past. No need to
+	 * change anything if so. This avoids decay calculation underflow.
+	 */
+	if (time_before64(now->now, iocg->delay_at))
+		return false;
+
 	/* calculate the current delay in effect - 1/2 every second */
 	tdelta = now->now - iocg->delay_at;
 	if (iocg->delay)
