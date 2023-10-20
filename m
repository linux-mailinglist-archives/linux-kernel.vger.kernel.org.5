Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400207D1995
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjJTXXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJTXXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:23:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D9AD46;
        Fri, 20 Oct 2023 16:23:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so18486641fa.2;
        Fri, 20 Oct 2023 16:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697844222; x=1698449022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tA0wMNcNERqG1nwtTkGl0joUZs+Fa3lyRNyXvmPuo8A=;
        b=nSveuJ7uP/hhVXkuQeKWcnpWcx3v3H4eUzlVIkBMcEBx+aS+TJV883tljMRtb2DSOt
         eSb/fWW4isboSeieZqZxIF1n8Bv37i1F0tDEn4V6jQCByRXwzoDP0OppAIuf2xHBSmjb
         Xvxx4MnNaTXF1VBbphKs7IjJqffDopkz8BVFRvCWCUHeNO9H991vqwFQYlt7cMRkD5Wy
         /J4aAsp1gD9xh5/SL360UAePmkXbkfGBN5aivUTMIf3WJ0bt7kgSVli5acYgzh9ccsUk
         e2P3syXjovOs+bkSTuLj++9TUBekCXc8mb2pfrtUy3QM0FYsolqITqoTZjFga8DILrU0
         9HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697844222; x=1698449022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tA0wMNcNERqG1nwtTkGl0joUZs+Fa3lyRNyXvmPuo8A=;
        b=pWyo7sMAoRZKq7JqntJ8dF4zaB3rRZRdaKoLjeM7zIDol65HI08KycsUPCjTTsE8gq
         tvCr8BmcaRnc7njWm6bR3A3nNIWoFtl7wmcKttpmrDgRosKKjQ9iiKW4+WS2gu/YlaKC
         BXAddU/pNOHlv+GfgQoGfKUPdm+6FKteH06IORgMdbquQQyyLEyfSTOlTOburDov3O1C
         wVzQIDA92cg0RAftPOaa0QqLBDtJg01J6cR4g5fCd0T58y10ht7prvF2xOUsVeUzvK6f
         R58t0N4dTSpdXzm/c5NMuejtsNX2QNYYymLPt9ggjU3izIF3FCF8zWgMsftIhsryYSBO
         HM/A==
X-Gm-Message-State: AOJu0YwPbTowbySmrD3Vp8Oi1UhKNC8QW3QT0SFAEeUOQ6gLjcsb+Q7w
        QQPbxUWsuBKmBEa2BxFopoM=
X-Google-Smtp-Source: AGHT+IHZGy4hFw7sOwzF8cc2MWGCxLuUe9zs/pEzRv+NcaT5SFOm5DEbigsLc9Xt1jfKjVkjcsGMEg==
X-Received: by 2002:a2e:964e:0:b0:2bf:ab17:d48b with SMTP id z14-20020a2e964e000000b002bfab17d48bmr2245279ljh.34.1697844222079;
        Fri, 20 Oct 2023 16:23:42 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id s5-20020a05651c048500b002ba586d27a2sm567571ljc.26.2023.10.20.16.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:23:41 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 0/5] staging: media: av7110: Fix various formatting and small code issues
Date:   Sat, 21 Oct 2023 01:23:27 +0200
Message-Id: <20231020232332.55024-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
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

These patches cover various formatting and small code issues. Formatting
issues include missing newlines, whitespace and miscellaneous formatting 
issues. The series also fixes small code issues including using preferred 
integer types ('long' instead of 'long int') and ('unsigned int' instead 
of 'unsigned').

Jonathan Bergh (5):
  staging: media: av7110: Fix missing newlines after declaration
    warnings
  staging: media: av7110: Fix various whitespace checkpatch errors
  staging: media: av7110: Remove unnecessary whitespace before quoted
    newlines
  staging: media: av7110: Fix 'long int' and 'unsigned' variable
    declarations
  staging: media: av7110: Fix various formating issues

 drivers/staging/media/av7110/av7110_av.c | 114 +++++++++++++----------
 1 file changed, 64 insertions(+), 50 deletions(-)

-- 
2.40.1

