Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B496773C45
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjHHQDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjHHQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:02:18 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A6A2112
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:30:25 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d16889b3e93so5525946276.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691465425; x=1692070225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mT4/NWkzlbjzHfA8fPhCG7w61qdlctOtO8GcZ/OHAQM=;
        b=lIcxouJOfbcMQdsk9ecCR3A6B2DiHV9VmDSft4B6yVNqMDHMgeeCOAO5x+ndkSgt1R
         C0+nYIuwH1gaeAzVOm2iOb2d+ocMlYLA5hThfLkhBumjK/rTJGu8wt0ysUfGdw+Tgofv
         qcnGhDEZJOKBnOY+zLAgkQkQMKrN8eHRRkDIl4Fz/HBdVm5jx/r839UxeZibiN8j7A3R
         3ficPytxhhOXC7L+QFlFJr5s315BYEtMs1JTqGKPcwFZYDgeGMIa8qNs5nc/4qpXXsB2
         IqNQbrF2HtEg1TR6Jhkr0fod3CZ/KyXng4wz88WFL4/uGR2Vc6eqKo+DJop3RcW04+DX
         /Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691465425; x=1692070225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mT4/NWkzlbjzHfA8fPhCG7w61qdlctOtO8GcZ/OHAQM=;
        b=aFP0g3u75QIO21dYjF0rRAU6iDZoLtdHKOBrLaExEBQc5N/LY7FTD0WDOo9+PT+CXU
         K0nsXEk9EYht4Ac79rH3KqbcBPZWw9pkedgfIVRYJps6FTD/N4/vfGBYaaozIYpJpNfM
         XGFDlFMBPv23P2Jr13EV399jHVO4E2VbujExnxn9PgGWoO7KrrCupHkYUsNQ1r/c3GfO
         wf9QPKtqJ3FcsU6/nZ/sinaH2OsswDPWXbMQDDjbMi6d6stzJxC4YB0RrJZAOCigfcrl
         Bd1oPPFGx98AromycSAp9DRaatSE/kZk3tfa+K0/71F5Fpou3MtZzPqRmd1mUryPZ4IV
         MVsg==
X-Gm-Message-State: AOJu0YzMoVvl6NUweIi5aHL3ADW1DCrMscEx0KPaORpc6HK9u+6BeKcG
        eY0BsYNK0aX5dUrPLOfBHm1QmUcjLZe/tw==
X-Google-Smtp-Source: AGHT+IFjqBS0HkxgVUQI2l47Z0xG795/dgCyTOQ/hTIEzNs+ZSxYkXHneE7UIGKbyrAj15V7020IBg==
X-Received: by 2002:a05:6902:247:b0:d49:9ba4:bea8 with SMTP id k7-20020a056902024700b00d499ba4bea8mr8913527ybs.40.1691465424792;
        Mon, 07 Aug 2023 20:30:24 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id em12-20020a0566384dac00b0042bb5a8e074sm2854031jab.8.2023.08.07.20.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:30:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/2] checkpatch tweaks
Date:   Mon,  7 Aug 2023 21:30:17 -0600
Message-ID: <20230808033019.21911-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 small changes:
  . silence extern in .c warning if sym is present in vmlinux.lds.h
  . warn about >75 chars 1st, since thats the actual test.

Jim Cromie (2):
  checkpatch: special case extern struct in .c
  checkpatch: reword long-line warning about commit-msg

 scripts/checkpatch.pl | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

-- 
2.41.0

