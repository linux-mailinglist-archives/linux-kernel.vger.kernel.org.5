Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEF680BBF7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 16:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjLJP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 10:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjLJP0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 10:26:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EE418E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c2655da63so5703455e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702222013; x=1702826813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5AX8g/wXZvYEzrNX0i7zijBGLcVcluFx1cTL3h9KKB8=;
        b=DQ8TmW5FpxfVS3Te0xcT1UV08WymrMwpmVRqKN2xdlS3G1fWL5n3lRF4/p1ngvVIR3
         fwVYziy4BZSVSMBSpMJF7HdZQjmuU9CKh5yEA5FSIvKxw/OijPA50ZikqYh+vWkQAnDL
         A8IH6vgocmZGX++MzgJF6JzCQlbxB9V+WdQ+1UEO7qPHfqNcH/FbiTKnU+9VuqgEw6Uy
         nXC6hFtZI4082GxJdmn/03nRVpGAHWjDPwuhtrp5BFKyp/EhFYRmUhfs6eLWEY8BbYoy
         rNff7v6opNYDXZe+Ywq8MtLad+UzxIY+sInREveFLnijTnIAz7Sv8s/CrO+k+D2j4ukY
         cTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702222013; x=1702826813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AX8g/wXZvYEzrNX0i7zijBGLcVcluFx1cTL3h9KKB8=;
        b=jFrqjtnO3dTYPP2aoomEzs99lcDPQUknqb1hJrl9UJ7v1lp+DPkeC7G8drQzYM56ug
         8QJyRLgMLFl/SSBX8juN/IPz+RxUeKYbdfWmMVhsHHZeIDHoZ08Dpzjy8QDn51jW9+fQ
         faDMxVbs9tI83e1agxIa+6LQHq4mTA9J+qrOzEmb2R8Q9L+3wv44SJgqwJqUOAoSJAV/
         F3j9JCjPfCsCH2IBAJTtQM1LX/wJa5n3PrlcfPlyPy7Cn6kDH++lpZgFFRGhNrJKxqNI
         IymaXv6ngGF7l3APtYXgEJ97KHGxe5AKCNWF7hw2lTAE5CT36uLpA5zvGSdvig7jIfmr
         oWkQ==
X-Gm-Message-State: AOJu0YyCsraJldFaViyeQmtTzxqI8ibkwdasXKuU4iMD1Fv0K0A2bYp8
        Vh9s41I/J2QpWIyJG1GxYnf8Bh0uX+4=
X-Google-Smtp-Source: AGHT+IFwiSupcld5jHo8mMdVpVgGC1r4PqCFLqRK+5FD52FyqP306qJnkCRLeOOXrzuYK5T28BZhIQ==
X-Received: by 2002:a7b:cb99:0:b0:40b:4cce:baf4 with SMTP id m25-20020a7bcb99000000b0040b4ccebaf4mr3959298wmi.3.1702222013655;
        Sun, 10 Dec 2023 07:26:53 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c138f00b004060f0a0fd5sm9905070wmf.13.2023.12.10.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 07:26:53 -0800 (PST)
Date:   Sun, 10 Dec 2023 16:26:51 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] staging: rtl8192e: Remove equation with
 pPeerHTCap->DssCCk
Message-ID: <16ec7f928d1c51ffe68b9a1a68d09abaaa79924a.1702212003.git.philipp.g.hortmann@gmail.com>
References: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702212003.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove equation with pPeerHTCap->DssCCk as it is set to 1 and unchanged.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index bedee290e7f5..ca9da96b6f6c 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -471,7 +471,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->cur_short_gi_20mhz = ((pPeerHTCap->ShortGI20Mhz == 1) ? true : false);
 	ht_info->cur_short_gi_40mhz = ((pPeerHTCap->ShortGI40Mhz == 1) ? true : false);
 
-	ht_info->bCurSuppCCK = ((pPeerHTCap->DssCCk == 1) ? true : false);
+	ht_info->bCurSuppCCK = true;
 
 	ht_info->bCurrent_AMSDU_Support = ht_info->amsdu_support;
 
-- 
2.43.0

