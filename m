Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2487B5961
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbjJBRFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbjJBRFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:05:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3065CAB;
        Mon,  2 Oct 2023 10:05:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c61bde0b4bso136315ad.3;
        Mon, 02 Oct 2023 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696266324; x=1696871124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tm5ZgP4npWWxsKKblUdwHTtzFpVC+Tkeac3SWyzkCzQ=;
        b=aABt2uU7zTVRVfayudoNzVTg8a3ObIV6svTw7hHw8xQZXp1qphhrReciXzUfh/Sqo/
         XhlNY7Xg2Dl4huHmwW9vjoix9ZCoqDYw8skaAitEHRCthTqISq7l7gPq5sT2KvBvS3Hu
         jomK+FPiDL/sCugqbbETHsTLf2VqzXSAt+mqIZo04WremAvjybcz4MGiUWOMCKd7LWJb
         uYiwhwQdzyI0T69vp5PiCBUspfKCrjTQMK9iI1WWs6pqamCYncI5TwmDbrs7zMtUMzkx
         E4mdu28456Kg5lp641MnXUqhHQ0OGsamhNxP+dPHmbwHE0aiwQWMWW1Ci7+nItAHhj7a
         UcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266324; x=1696871124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tm5ZgP4npWWxsKKblUdwHTtzFpVC+Tkeac3SWyzkCzQ=;
        b=Zzxt8elUpSK1q3x6ILPXYzalTQ9TLx2FB/6LrQyDHiEXJgoFeXgiguRJ3h5TYPRCsT
         dFleLuD8reUDb4Ur2dgHM6mR4dJhUH7tE2Y/JV10o6dh3DEfS9igpldM7EP2DTao61n7
         QJ8S/yp0GF5qtg04/K7cYAMY9m91DmQq7HTHpgibaXMNz4s8PIed5G733EoV6IP7rMQP
         X9QsAg0TQa6qjjryrv5q1ezq+eeZn4+qSg+Htef4o+cylVkRAHpANJFsOa+Ts1QVy3va
         Ik8XNs501M4IKdcrs3UtgFcSnCp0XBKaZLAK0wGV4zIv2CYjVk0maDNt9vzYA5fefHBD
         j/uQ==
X-Gm-Message-State: AOJu0YwFJpw6egjyHSRj72Zux6CveXNq76WklFqUqq7co+rZ5eQcCuNT
        y6ODS5UlQDbawCs/688Ka88=
X-Google-Smtp-Source: AGHT+IEaszjqgU2abyNxBlvNw12ydAAMRyU8hW/BpciYMiEFH7TBldf3lwXRrOJJP1lDw16W+t6z6A==
X-Received: by 2002:a17:903:1ca:b0:1c3:e5bf:a9f8 with SMTP id e10-20020a17090301ca00b001c3e5bfa9f8mr16268734plh.19.1696266324538;
        Mon, 02 Oct 2023 10:05:24 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902ed0200b001c444f185b4sm16134591pld.237.2023.10.02.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:05:24 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     swarupkotikalapudi@gmail.com
Subject: [PATCH v2] usb: fix kernel-doc warning
Date:   Mon,  2 Oct 2023 22:35:15 +0530
Message-Id: <20231002170515.207633-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918193505.7046-1-swarupkotikalapudi@gmail.com>
References: <20230918193505.7046-1-swarupkotikalapudi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings discovered in usb driver.

Fixes this warning:
warning: Function parameter or member 'gfladj_refclk_lpm_sel'
         not described in 'dwc3'

Fixes: cf1202418e0b ("usb: fix kernel-doc warning")
Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
 drivers/usb/dwc3/core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a69ac67d89fe..078edfe0f88e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1106,6 +1106,8 @@ struct dwc3_scratchpad_array {
  *			instances in park mode.
  * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
  *			instances in park mode.
+ * @gfladj_refclk_lpm_sel: set if we need to enable reference clock for LPM in
+ *                         Global Frame Length Adjustment register
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
-- 
2.34.1

