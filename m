Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFED7B5C51
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJBVBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJBVBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:01:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0528FC9;
        Mon,  2 Oct 2023 14:01:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692ada71d79so174742b3a.1;
        Mon, 02 Oct 2023 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696280508; x=1696885308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRAxndoOywhRzYPgMdhdUgmtQrGkiYMmSMD+Z1Z5zSg=;
        b=JS2routNGvf+sgz0pfotst8KnIoKgS5BYZ+MZZ5qApfk4kTZaINEuIUww4MV1gbWJP
         E5rWWDz09HTCxCjYvu7qDAnTlkf5Hxiifo83T04IV4RPgkcHOp5/uYeiDqXtmEtunOIZ
         oQVm0ipCGVU8xRUdwURVP6PH2pHRIIoNQrATvNdFB48QK/P7fvuDEITaoWvG2iPwfCGA
         i8WizS1djNnhqsIKLdVDl1qZfcXqXxhBHgIEeKcRnTh6XIkg/UKiLHZ2HvyQZHHk/lxU
         ZZ5vfsFw2JF1UtW5AMjmmB2wvE1gJpKDMB/IBq71xLO0mex/9LQfaMQ5nmrwHv98D6xF
         QQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696280508; x=1696885308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRAxndoOywhRzYPgMdhdUgmtQrGkiYMmSMD+Z1Z5zSg=;
        b=FLZw5GqHLH6Jgn0kHioM7bXCqTseef8DWOej6dQV0apfWo8n9jTPpROWXVjy9Ba8is
         NqzhzfdxumVInjjYvlB/keq8uStDb9D8/sdcsmD+zie2UU/1TP19tnrZbHcyNaQCqr9u
         CEsCwRDiA9zpAIZ7WB4OTBJvUH1pv4CFPz4WWxFOmOOb9oCHySXS51tTVkQGP/A2EKN0
         +UtOlSD4NQZ2m6coFfgPmwfnoDJfDVCBzuZhTsu1vdAnxbHmC5qD1ZDpSXFKXeVoU5ma
         Cxr7IqP1A9prPoJ6uroO7LiUa7ILf0vfZ4oFVDOqdY7yDGYmjUI8vzM8h7uIZ4qTmkIS
         gfmw==
X-Gm-Message-State: AOJu0YymUZmEpjSzT0L4660YfAxwpr5IpWE0ZUDb+a8A86vFQv7ao2AS
        ii5NMv0Ys0vlWfjWqNtcOwCrPDb58xCaPhhN
X-Google-Smtp-Source: AGHT+IEKCfUG0nwjH8sZfRtHvsAK+dOUfuK8uQYrL1Bc9Etwdi/XDgar1p1eQl8pEiTFhOqtIgGXOg==
X-Received: by 2002:a05:6a20:2589:b0:135:4df7:f165 with SMTP id k9-20020a056a20258900b001354df7f165mr11492945pzd.21.1696280508384;
        Mon, 02 Oct 2023 14:01:48 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78c1a000000b0067b643b814csm20072472pfd.6.2023.10.02.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 14:01:47 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     swarupkotikalapudi@gmail.com
Subject: [PATCH v3] usb: dwc3: document gfladj_refclk_lpm_sel field
Date:   Tue,  3 Oct 2023 02:31:37 +0530
Message-Id: <20231002210137.209382-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Avoid a kernel-doc warning by documenting it:
	drivers/usb/dwc3/core.h:1343: warning:
	  Function parameter or member 'gfladj_refclk_lpm_sel'
          not described in 'dwc3'

Fixes: a6fc2f1b0927 ("usb: dwc3: core: add gfladj_refclk_lpm_sel quirk")
Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
 Changes in V3:
 - Include correct Fixes tag as suggested by Thinh
 - Update the commit message
 - Update the commit log
 - Change wording of document warning fix
 
 Changes in V2:
 - Include Fixes tag as suggested by Greg

 Changes in V1:
 - Fix document warning

 drivers/usb/dwc3/core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index a69ac67d89fe..96685391696d 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1106,6 +1106,8 @@ struct dwc3_scratchpad_array {
  *			instances in park mode.
  * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
  *			instances in park mode.
+ * @gfladj_refclk_lpm_sel: set if we need to enable SOF/ITP counter
+ *                          running based on ref_clk
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
-- 
2.34.1

