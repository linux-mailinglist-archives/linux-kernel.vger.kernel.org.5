Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5C782D37
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbjHUP0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjHUP0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:26:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C5D9;
        Mon, 21 Aug 2023 08:26:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68730bafa6bso2979481b3a.1;
        Mon, 21 Aug 2023 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692631580; x=1693236380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRNVXVCFNY+UAp3a/7xKqvOgphTENTBOPiaI1Ml0pY8=;
        b=RCbqm+rF2yaI4yacjZbgZLO+iclVWqLpoMdHPQ5uG6qjCecueeGi5XHOP/Lq99DID6
         OXpd01nQ/QFbPNCcj2nCJbAs1ebNTcgxfr92qawsKDoZmeDIvaXoFutZoj9EJBBGV4rr
         SEcoOtmuuT134F4NzOVziWRt+LlvVbao81lV+vYCKA1+67OcGyxFbCOPkYksLqZ1sWxj
         wU3KIry3h11QkfMaErrUr9UC9wL1sYboSX270peT2/Go/OrYhonLAFHBBr7DpJ92Q4ep
         UnVvknnuXY+fWJSCgSTKWwNwpqe6cQssL/bfA5EXoPPDcLXdlUvIzrXkhpQqfb6psM6G
         26Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692631580; x=1693236380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRNVXVCFNY+UAp3a/7xKqvOgphTENTBOPiaI1Ml0pY8=;
        b=I/+C38vnvZIesXYNrOpMnSNpYBClJARvZh3KotswgdcmoB7luh0H3LTVFHFbkTEQu+
         o8n128tC494RLFO4GiHV4i1WVr/u8uJC0WukONp1Vkrk3Rs7h7ZR7LeFGX9d92NmBf2N
         UbKTUmeMVHsAtgJ1PPyQz+Y7TRci2c34CfhNiYgUJEe6xOKBq91swJYGbp9Ax4kyCFWh
         M8wUdVwm91cGoXD4eWIkPxpY6MaDAbHfbkCf+UEXBRJDBBjt+i/Q2Wi11GikQq0VZCsL
         JQ6ZDH0UBQ/dJ3cd7BYYXXsHE6o2xQeQL/72Ri5h5jAtB8JDmtzASsCxijajrs2Rhzuz
         8iyQ==
X-Gm-Message-State: AOJu0Yz+nNctSciLXuJhs3yr3Oy9RKrgkVRGIEkT1IT9NAFD7+VKKXja
        NNqD2e1fI0N88zbU89MTIRU=
X-Google-Smtp-Source: AGHT+IHVjVgqofdmH1MW157zPEVBDYtOITySPcuMe25EjXsQbquQ+ng+hIi/VKApxARhJ+H3qeMIIg==
X-Received: by 2002:a05:6a20:8f1e:b0:133:31a5:51e7 with SMTP id b30-20020a056a208f1e00b0013331a551e7mr10088503pzk.15.1692631579772;
        Mon, 21 Aug 2023 08:26:19 -0700 (PDT)
Received: from vinayak-ubuntu.. ([2406:7400:81:e7e8:c1a2:4b35:18c4:443d])
        by smtp.gmail.com with ESMTPSA id p27-20020a63741b000000b005651c9351e1sm6434860pgc.64.2023.08.21.08.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 08:26:19 -0700 (PDT)
From:   Vinayak Hegde <vinayakph123@gmail.com>
To:     sumit.semwal@linaro.org, gustavo@padovan.org
Cc:     Vinayak Hegde <vinayakph123@gmail.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Remove the parameter not described warning
Date:   Mon, 21 Aug 2023 20:56:06 +0530
Message-Id: <20230821152606.10325-1-vinayakph123@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vinayak Hegde <vinayakph123@gmail.com>
---
 include/uapi/linux/sync_file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index 7e42a5b7558b..ff0a931833e2 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -56,7 +56,7 @@ struct sync_fence_info {
  * @name:	name of fence
  * @status:	status of fence. 1: signaled 0:active <0:error
  * @flags:	sync_file_info flags
- * @num_fences	number of fences in the sync_file
+ * @num_fences:	number of fences in the sync_file
  * @pad:	padding for 64-bit alignment, should always be zero
  * @sync_fence_info: pointer to array of struct &sync_fence_info with all
  *		 fences in the sync_file
-- 
2.34.1

