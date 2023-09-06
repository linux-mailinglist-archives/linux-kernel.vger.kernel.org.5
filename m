Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76507941B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbjIFQv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjIFQv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:51:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF5C1997;
        Wed,  6 Sep 2023 09:51:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-573f8afe1d9so83025a12.0;
        Wed, 06 Sep 2023 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694019113; x=1694623913; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2zLoFpI4oq78gnS3M70eaqwcugwfdYALt72FuhYX+Y=;
        b=c6EiboYDU3INrJaALN8ntgB9Y/DNhq+i9R2n2AX9XjOlT2+7AHpLYkgTYSS4Lx0XJ3
         exx92hUPDEsvT20E4u87aB3x5J4BBLo5SbQ6nEgjEzB/gD2FRUPfNfz8KAP6fdjo2XDU
         QpfCL14fTqiKYB16rXAmqwYzvhfI7pSZQl/JivrEB+8oZ99hmlgsUl9sFqgrgJWvkC55
         7Rb4c0/a5y7b+BO0TV4tjdg4+zmGB2ND13kDbYSAhv/8MhLsajZ/ttEBSEc51QAuuib+
         T649+IX8eoVxyBe0houdqRwFDageSIhlzOEBAWyKxT/E0ZxyOlkfyOLoXeHGiiEFh3Hf
         WGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694019113; x=1694623913;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2zLoFpI4oq78gnS3M70eaqwcugwfdYALt72FuhYX+Y=;
        b=dI17R1jZvB2b55dpIs3s9K+40eRcQzHnnDS7Pd62wf2wT8FrciV6hTC9JBKs6eDeAp
         1AgeBTFjXA+DA63eMPFskfAtRbKtguzHHBe8QSSaRU73LWEcHakKqMTNFH/wgql0HDTu
         OVE6TsLtDRzib1m6Oc6qjvmECxZxS4BgdrQaVwXRO7RNwxmV0VeEpdSBqWnlizEsJUF4
         i3z1iJBjyUc4HyN81Bpo7zmIqYnv3/4nw3qWgGD/PxpMgd3+r7LbaELiYbqVIU/aNGR4
         F+SqQKru/LN3/A7GaJR+7spaFQSZ6HdkJ6iiHRyrhqMcCeRyGVrShiaxHtEIH/rzOEWL
         npCA==
X-Gm-Message-State: AOJu0YxQXhOBym1bU0BNTtow+Evei7iMNNX0YeyHpoVbWEs+//IkM163
        1s6KJq2+zBXz4PTYebQY26M=
X-Google-Smtp-Source: AGHT+IG3yGBJOscZW8IygjSlhgGj+Agxa9KMGg1dtQxUiFZmK7w/mnFERg2G/FKxqRFMEVRMnWqcUg==
X-Received: by 2002:a17:90b:188b:b0:269:33cb:e061 with SMTP id mn11-20020a17090b188b00b0026933cbe061mr14731094pjb.24.1694019112671;
        Wed, 06 Sep 2023 09:51:52 -0700 (PDT)
Received: from vinayak-ubuntu ([117.255.46.255])
        by smtp.gmail.com with ESMTPSA id bt22-20020a17090af01600b002612150d958sm15277pjb.16.2023.09.06.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:51:52 -0700 (PDT)
Date:   Wed, 6 Sep 2023 22:21:43 +0530
From:   Vinayak Hegde <vinayakph123@gmail.com>
To:     sumit.semwal@linaro.org, gustavo@padovan.org
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Remove the parameter not described warning
Message-ID: <ZPiuH+ghqamtwJGA@vinayak-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered a warning during kernel documentation compilation
due to a missing colon in the documentation for the
'num_fences' variable in the sync_file.h header file.
This change adds the missing colon to align with the documentation format.

Signed-off-by: Vinayak Hegde <vinayakph123@gmail.com>
---
 include/uapi/linux/sync_file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index 7e42a5b7558b..b389a5495181 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -56,7 +56,7 @@ struct sync_fence_info {
  * @name:	name of fence
  * @status:	status of fence. 1: signaled 0:active <0:error
  * @flags:	sync_file_info flags
- * @num_fences	number of fences in the sync_file
+ * @num_fences: number of fences in the sync_file
  * @pad:	padding for 64-bit alignment, should always be zero
  * @sync_fence_info: pointer to array of struct &sync_fence_info with all
  *		 fences in the sync_file
-- 
2.34.1

