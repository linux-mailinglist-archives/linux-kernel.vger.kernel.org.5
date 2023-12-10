Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDF980BCBE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjLJThF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:37:04 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F0AE7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:09 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0a7b72203so32649395ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1702237029; x=1702841829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWMq+fsJDOtZmzmL+dlI9RAA4JQyKEd0rPprq/Mm6AI=;
        b=gzxyZDsShm9oGQqfSBs6LFyhzOXLBIvZ0mth3BIG0Xn0eEV+dga9mhU05XfPprHblF
         H2cBw769OtOLBK+Q3W9hgcCu8HXLTSrXDhTNY8RZMJTfkIZ+OTZLQdO6EJQ1h1NIs29r
         kSscyzHoevF80WpzNaw5OyE2rBN3BhvOkfqFd/ZhRSR4tbaamqnXgUt/drkVgZk9iEfz
         9L78miTihesoTTHwnSkZSVRbZ61H2f38r1NJ9RD4iBFIzs5tV0cmjhJqGUc2vJ5q0hhA
         8LgDSMJz4OUmLPRMi6z+Nh2e1lXjQ5yFADtkhuT3v4WnCA6PqF7TqOVBSnPpqDuGkqNy
         i/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702237029; x=1702841829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWMq+fsJDOtZmzmL+dlI9RAA4JQyKEd0rPprq/Mm6AI=;
        b=maHCx0W4px+wBphxqFyEyDUVs3UBivwgOpXJkCUCC2PybkXY3Ut8eD8j6eAPVbiSe0
         vi+YO9JRa+Ksk6QQwIeugxH8RZAzLyyt131gdLdf+gnIObvnZW1H2iEMQO0tWY/tmMG7
         ODNo9pnqk9ex1cLJ0U8n+aB+qHxpUWm/vnafyainIkSWmkxVw3Orw+KcuwSboYTIhmfI
         ORht4E+xfUHlZA/zjK0aJI9TPigu/JyHZBB4Yoiso81PM+wrmZ1XVhnSqnKWW0wjoRdX
         V7jkeNsCBdDdYPtYlXjB5j/mb3Jzqg8Jxu3Qb1GVHORGo2BoxZL5gv3hB4Zat6KDuqrM
         zIMw==
X-Gm-Message-State: AOJu0Yy/G2aN7fZnbjl/k3ZrCz+gO2+Qmazo+s8hDdxbObeO00SHVBFB
        UxYubDqDrqPRQJ3llZKxjpRRzQAA5TzXQLnZuxoT8g==
X-Google-Smtp-Source: AGHT+IGr/MvG95lLuKzFxIXvwXlSw/NAE8PySqhzQPaocAekiGryY/Tyyls5+MukENzO0Hze+3yu6A==
X-Received: by 2002:a17:902:704c:b0:1d0:ba40:b0e1 with SMTP id h12-20020a170902704c00b001d0ba40b0e1mr3851430plt.124.1702237028818;
        Sun, 10 Dec 2023 11:37:08 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001b9e9edbf43sm5117419plk.171.2023.12.10.11.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 11:37:08 -0800 (PST)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/4] Staging: rtl8192e: Remove unused variables in struct cb_desc
Date:   Sun, 10 Dec 2023 11:37:01 -0800
Message-Id: <20231210193705.2131807-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes a few unused variables from struct cb_desc in 
rtllib.h

Thank you in advance to reviewers.
~Tree

Tree Davies (4):
  Staging: rtl8192e: Remove variable bFirstSeg
  Staging: rtl8192e: Remove variable bLastSeg
  Staging: rtl8192e: Remove variable bEncrypt
  Staging: rtl8192e: Remove variable macId

 drivers/staging/rtl8192e/rtllib.h | 4 ----
 1 file changed, 4 deletions(-)

-- 
2.39.2

