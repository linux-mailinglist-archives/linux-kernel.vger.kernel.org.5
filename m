Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7427A4F82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjIRQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIRQo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:44:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7AA2736
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:43:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-321617ef967so95823f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695055394; x=1695660194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e85KhEdB/8L2KjMgrb/nt50KjNVE0e0jrLX/VqJL4Lg=;
        b=QOV4SK9O1f3g9SqQCbXlMKkQlMYR2lBDGymFYmXXdpr66Emd9+te2yxtK1e5OSjW5g
         RcSftOW/LGc9f9lpUOj7aI9nFUFRw5OU0H/vlxZ3saObW2FjWHn9aevVzWTWgxTX6sRs
         op77XVADF4QRIzMsQelCwL8WWwCvEaJtq4IH3uqiY1xhlOUpRNzxL/USk9hkUQvVt5/2
         oJUwB3otqbxhossz3iEysiiBUOQJ9Tl8F4+dYZnJkKsZ4SPXRiuo0ahO6DSxF98uR8Yi
         +DskXyZV7bp9d2Q+w3LHiMIe458eJ7C8iWWX1hm4148RpAojxFhfK5TH8pRj1Idgr79W
         WcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055394; x=1695660194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e85KhEdB/8L2KjMgrb/nt50KjNVE0e0jrLX/VqJL4Lg=;
        b=rKX2uAI98VJuZig1iHN2TVeX18mfQoFRFf8iHn6PppEZ5Ak+sdZ0e56u1a8DfRePsH
         Wyud5la74gN2fHgWiehtauEcfZ1/VtxVydsBtkADbUwXOvWQqNk1WxX8WFw7eAY5QPqq
         4jRSIBG3wPF45S3+rjoUlKDKpKkPBYqJNK+leqMf8iMcPHTYr1r6jdecRRLm3KYslgyi
         v5qlBh1nGowuDloaKvL3nW90pbsNiQdOcpCQA8h0p2Q0d7+joojAGha8rlcJvukK3UZb
         LL/onm5SmUHi/1RzcO62pVfHea8W8adFldZDG8BCmoqp6o0LcKomxRPdWlIbExB73dMP
         ENeA==
X-Gm-Message-State: AOJu0YwEwz5L33ce7n4f32e0HLkdEDYqi8zd+Uqjnzfib6d1NiLL67Q1
        LgTKpbBVpqJKck1/TDIJTjHVXU6aeNua3w==
X-Google-Smtp-Source: AGHT+IEGkpjzaTNNA4HPhAu0hboCH8oLTrTqtsXb5iWixZukeONcx4voT+ZkWj9F+tqJkcjyy79XBQ==
X-Received: by 2002:adf:ef88:0:b0:317:3d36:b2c1 with SMTP id d8-20020adfef88000000b003173d36b2c1mr7889626wro.7.1695055393996;
        Mon, 18 Sep 2023 09:43:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id q11-20020adff50b000000b0031c71693449sm13174527wro.1.2023.09.18.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:43:13 -0700 (PDT)
Date:   Mon, 18 Sep 2023 18:43:10 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192e: Fix compiler warning truncated
 writing of iwe.u.name
Message-ID: <2caafb8628880570725385e87150c47689474fc4.1695054044.git.philipp.g.hortmann@gmail.com>
References: <cover.1695054044.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695054044.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iwe.u.name and proto_name have both 16 bytes of space. But when writing
to iwe.u.name the first 10 bytes are used by the fixed string
"IEEE802.11". Evaluating the code shows that only the following strings
can occur in proto_name: "N-24G", "g", "b", "bg". Therefore it is
sufficient to shorten proto_name to 6 bytes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309171733.Gl96cmYd-lkp@intel.com/
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index e9469bfef3dd..a37250de7ba3 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -29,7 +29,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 					   struct iw_request_info *info)
 {
 	char custom[MAX_CUSTOM_LEN];
-	char proto_name[IFNAMSIZ];
+	char proto_name[6];
 	char *pname = proto_name;
 	char *p;
 	struct iw_event iwe;
-- 
2.42.0

