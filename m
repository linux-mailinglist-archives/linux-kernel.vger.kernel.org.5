Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B60811514
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441826AbjLMOob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379400AbjLMOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:44:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7A11D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:43:56 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7BDDE3F12E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702478634;
        bh=Mq8kkShbdA3rJyVce+fgmgBoPNay+3LOO1K45+P/PiY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=GZx70vXWwbdzlEGK7j65rKOJFt2BGPRi/vbKKSSC3snKWhh+rOzKWg8/vnk7biH7m
         ovvujNQY6EOL+i0Wr/LEN6stKQnHuVH2W4F+Y17hAmXwXtbVsUwMSCZkRm/0iV2Wgz
         hdYvdHA7qQXcApxMrsOqPnvCpe3EOamnAIDvGHT1dK9A2ZlYnnWxGTVjRUI5Y+1sZV
         zTc02tToea+HAxIYD5MjEIR2VFTzyOjLS6snQqQ0qadf8C3oZmuqlPMbHr3I/a6rSA
         qXxNZlDNxpAa6bGqVuQ1nhYX6OEyT6AecJ0JzLd3JxPonHqFLiK7usmlr0dFct9UcT
         hS0FQg4zPsGeA==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-333501e22caso5560776f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478633; x=1703083433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mq8kkShbdA3rJyVce+fgmgBoPNay+3LOO1K45+P/PiY=;
        b=q3glnFDxtgCy0ondK69USW/Mb22X4CbIekVoaKkL7Ije9+dEWMYnMca0kRFWyfyXso
         FmDB71OdznS6vV4mQ9b/hPErtdYEex1UvV6QlFW2EiNzXyJIxCEZVxUhvSY6BUIbAzKb
         F14BMf+04gk/ddBs/DDS4CzjAtlYkAdeQRRzVAM5fLTDMyQzWsD4aJluLetNbSdLa106
         mQctKvqYE9NY0yaSfCXVk9mRbvnYwfbRoAyj0cXNJcRSP2pEhgW66lgNqX458nA+PygM
         U/4m7E1CNqiCpjqifB/Emm/OMivXURNgUl5+SUd7Vje4EnbmQIHZahJtEyL8JHKvwzfX
         sjcg==
X-Gm-Message-State: AOJu0YwcVUK7Uv0Fi6navf5TMW7Lgkzdc5+hlmCIAZVOXJhbvMFiM3oJ
        AoW+ChTIPPzmF6HwePz6WCy/G8J8R70P4uzLBVZsPwwAWfFoGy4znJ0RJ7j9RXe9nV6UvhkcS37
        7C8oW1YB4jCYX5FT+9VvyqHXvgrC2VrXtpgxvkIAwk4npUMksHg==
X-Received: by 2002:a7b:c416:0:b0:40c:2e1c:8f7f with SMTP id k22-20020a7bc416000000b0040c2e1c8f7fmr3749328wmi.143.1702478633471;
        Wed, 13 Dec 2023 06:43:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxje99wS4DP91jNbb0URn1aAUkttetXAiUa9hMds1BTuvDcsg2JBZMRUfMu4o7Kl+kXKLjxQ==
X-Received: by 2002:a7b:c416:0:b0:40c:2e1c:8f7f with SMTP id k22-20020a7bc416000000b0040c2e1c8f7fmr3749320wmi.143.1702478633071;
        Wed, 13 Dec 2023 06:43:53 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id bd21-20020a05600c1f1500b0040c25abd724sm23245849wmb.9.2023.12.13.06.43.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:43:52 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] objtool: make it more strict
Date:   Wed, 13 Dec 2023 14:43:39 +0000
Message-Id: <20231213144339.2345304-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is attempt #626 to make objtool slightly more strict.

Changes since v1 patch:
 * fix the return statement & comment in check() function
 * attempt to make SLS & RETPOLINE strict

v1: https://lore.kernel.org/all/20231212185339.1562967-1-dimitri.ledkov@canonical.com/

Dimitri John Ledkov (3):
  objtool: Make objtool check actually fatal upon fatal errors
  objtool: make objtool SLS validation fatal when building with
    CONFIG_SLS=y
  objtool: make objtool RETPOLINE validation fatal when building with
    CONFIG_RETPOLINE=y

 tools/objtool/check.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
2.34.1

