Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAE7E0862
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344215AbjKCSpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKCSpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:45:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB2184
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:45:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc2575dfc7so19997085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 11:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699037099; x=1699641899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vi9i7BH5SJFXe9yvdoMNH7A2nK29qOJicsyy3NPBNKM=;
        b=I1iOh2X2QkWQuSRD5NGq52mh88ZIvCnXywM3R6IK4z28mNZfDiXZOlifISKUiSeXMZ
         I22NSMcyv90hngigu8X2L4MwechIbhOQ1NOHXejPOu7YaCkPfXjmoy4uHOIueMmtloZz
         WLLT1QqG/YFPJkd+aPb0kkjK5uAkWmi7f8gAbyjimgKvfm5HN5r167ejo4K7ey4l0J3r
         svnzaxcV/L5Nt3ol/dat0IAa/B4qtCNeDzLs/Gi5j5zL1Bb4S2xjzQ8fmQcLfbB018px
         c1PPKnXwygXJeMWGYRX4Ovla4o6QNmbzAuA2mv+axsajGJ28i5F0AsVClW/R06m1/LVp
         4h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699037099; x=1699641899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vi9i7BH5SJFXe9yvdoMNH7A2nK29qOJicsyy3NPBNKM=;
        b=eC5NYIee2KRo8aBMotHHeq+sEVVBmLSRxf6O8qlw92tdkaGhZDBEF980GxHcyT2YHJ
         2DXn9CFwf0ZYcG9ei98fKQImEA1Kif5qDkoG/iJEokGejw0aK3ZVnCHN09tToP8IbA6B
         LO9p1qVNIoQNtsBN2TYSpmUlh2Ij8FkFFa6W+kb0leasCTeQ+6BEgBf1+VJWG4Atm5LD
         BCPRxcqWRVMzjEYyBKAw3WJkzC670OCRmv1QDYlwRuf+qTPEk6xhHs4u8yldIsAf9dRf
         9hE/qJyqdGBr99dUzQyvw/A6Xom8P8mTkHxzh9MmvS7MSwx5zF6ZPC0PrjTEgJgr2M0a
         QmXw==
X-Gm-Message-State: AOJu0Yx8vRfjQFSwBNHgyQYzjDth2uTDASb0DYcq4F2pH32edTuo6+HP
        TGo6uf+ZPuI4QhL38lqwWf0=
X-Google-Smtp-Source: AGHT+IG50DCmBBcOVKSGZ/DBbJtvVwaoNL+SSgA9Vl/rozZksO0yLCvULX9+9JEru4DMqperxujV8Q==
X-Received: by 2002:a17:902:d18d:b0:1c9:e2ed:66fe with SMTP id m13-20020a170902d18d00b001c9e2ed66femr16394484plb.52.1699037099336;
        Fri, 03 Nov 2023 11:44:59 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-201-13.dynamic-ip.hinet.net. [111.255.201.13])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902e31400b001c613b4aa33sm1678257plc.287.2023.11.03.11.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 11:44:58 -0700 (PDT)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wuyun.abel@bytedance.com, linux-kernel@vger.kernel.org,
        s921975628@gmail.com
Subject: [PATCH v3 0/1] sched/fair: Track current se's EEVDF parameters
Date:   Sat,  4 Nov 2023 02:44:31 +0800
Message-Id: <20231103184432.9247-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v2 -> v3:
    - Simplify how we avg_vruntime_add() and avg_vruntime_sub() when
neeed
    - Do not avg_vruntime_add() the contributions of 'curr' again when
put_prev_entity()
v1 -> v2:
    - Consider the contribution to avg_vruntime for 'curr'

 kernel/sched/fair.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

-- 
2.34.1

