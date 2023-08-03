Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7276F355
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjHCTSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjHCTSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:18:34 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25831BA;
        Thu,  3 Aug 2023 12:18:34 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76595a7b111so93771485a.2;
        Thu, 03 Aug 2023 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691090312; x=1691695112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=httX/IIWnWA/Ifa1Mp/nqpXb9POjzliyFa03frntpBI=;
        b=IQfjxzXztfBdSdGaCyL4vc1JtDh9brHapglrlZsCrz9QxnQWBKBhiZVfVmrq8aUwpv
         JapAshvIJE82D2550ZYQo/eat3WjguPN4SiJdDff2gAEfPlCYxg3YxUDs2lVEstl27xa
         pOl71oFzkpCFTGRhfYY0mt+gvBApHh/GtLHnjWQtFErMkYZTRqpJ1fF2+rLrlkgeAMVj
         w7oFY/lWq2WXuGCN4u5U0/duT6YR6ja0/GirA37ANsGMmKuiWto+jSFSmNUvLpbdiPGs
         szKATbeoTR2C87wE03oqLUAxFn7NAkKrsVVc53RAjXCIRP2uu4i5yOZwC1R47gptUSKy
         gIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691090312; x=1691695112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=httX/IIWnWA/Ifa1Mp/nqpXb9POjzliyFa03frntpBI=;
        b=VaEyd6c9NTbUJyyP9YGmgyq8dMVoWWDof7umyBQxHLWp0x0b8INTcf/uiV+JDpaw1H
         jdjr5vuTnXElzS/qtbAqxIfbtzKDKHEm8h8dNyuTPl6K+iTqaVbgymm8YHKxUh9xYKFj
         WpRVyaj79kwsETNhOFX5fPY/mFctHNClibcwEyMkcHjY5d8HH4rUSRrVajzJB7FgnbSF
         r7es4kBY0D40Qhb/Plcbct9FOMTpLQzu6TT50QyFGcceC09OFEfjjbFcjXRITqrrU9T8
         ShFnbNeKPKU7CAWYwtKbiX7+rMICThYh9baT+zGZRQdGGqDrnE0YkArG18oLU3uf06vy
         MQKA==
X-Gm-Message-State: ABy/qLYJ0hJ9QvFCRP4j5ydHRjowYGjv4bc8gaZqxarYvnoF/KFmthdp
        2cRmaLrpA978dWfFuWhn7hN+HyFp6dE=
X-Google-Smtp-Source: APBJJlGOFSLyw0wK4w0M55a6DSb/pQawYuqJH8tWrvjJ4AfxnoIDs7Koq2wUvb/my/L2srb85j4JmQ==
X-Received: by 2002:a05:6214:5141:b0:626:16ba:539f with SMTP id kh1-20020a056214514100b0062616ba539fmr16287234qvb.5.1691090312435;
        Thu, 03 Aug 2023 12:18:32 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id n20-20020a0ce494000000b0063762ab2f90sm108897qvl.83.2023.08.03.12.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:18:31 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] arch/arm/configs/omap2plus_defconfig: drop removed options
Date:   Thu,  3 Aug 2023 15:18:15 -0400
Message-ID: <20230803191821.36793-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230803191821.36793-1-twoerner@gmail.com>
References: <20230803191821.36793-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop CONFIG_NF_LOG_NETDEV as it was removed in commit 1510618e45cb
("netfilter: nf_log_netdev: merge with nf_log_syslog").

Drop CONFIG_NFT_COUNTER as it was removed in commit 023223dfbfb3
("netfilter: nf_tables: make counter support built-in").

Drop CONFIG_NF_FLOW_TABLE_IPV6 and CONFIG_NF_FLOW_TABLE_IPV4 as they were
removed in commit c42ba4290b21 ("netfilter: flowtable: remove ipv4/ipv6
modules").

Drop CONFIG_NF_LOG_BRIDGE as it was removed in commit 77ccee96a674
("netfilter: nf_log_bridge: merge with nf_log_syslog").

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/configs/omap2plus_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b685018dcf54..a87d7d4001b9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -78,7 +78,6 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
-CONFIG_NF_LOG_NETDEV=m
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_EVENTS=y
 CONFIG_NF_CONNTRACK_TIMEOUT=y
@@ -92,7 +91,6 @@ CONFIG_NF_TABLES_INET=y
 CONFIG_NF_TABLES_NETDEV=y
 CONFIG_NFT_NUMGEN=m
 CONFIG_NFT_CT=m
-CONFIG_NFT_COUNTER=m
 CONFIG_NFT_CONNLIMIT=m
 CONFIG_NFT_LOG=m
 CONFIG_NFT_LIMIT=m
@@ -179,7 +177,6 @@ CONFIG_NETFILTER_XT_MATCH_TIME=m
 CONFIG_NETFILTER_XT_MATCH_U32=m
 CONFIG_NFT_DUP_IPV4=m
 CONFIG_NFT_FIB_IPV4=m
-CONFIG_NF_FLOW_TABLE_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -200,7 +197,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_SECURITY=m
 CONFIG_NFT_DUP_IPV6=m
 CONFIG_NFT_FIB_IPV6=m
-CONFIG_NF_FLOW_TABLE_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_AH=m
 CONFIG_IP6_NF_MATCH_EUI64=m
@@ -225,7 +221,6 @@ CONFIG_IP6_NF_TARGET_NPT=m
 CONFIG_NF_TABLES_BRIDGE=m
 CONFIG_NFT_BRIDGE_META=m
 CONFIG_NFT_BRIDGE_REJECT=m
-CONFIG_NF_LOG_BRIDGE=m
 CONFIG_BRIDGE=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_VLAN_8021Q=m
-- 
2.41.0.327.gaa9166bcc0ba

