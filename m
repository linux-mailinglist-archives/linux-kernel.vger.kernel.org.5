Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC0677C125
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjHNT6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjHNT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:58:17 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201FD10C1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:58:17 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-589ed5132c5so16688817b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692043096; x=1692647896;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KuLUGonkyHypddRCRvc9uIETvmmIAQ5QUWOkyLwj158=;
        b=ooM7tj8exl1jghot/8pzykPkTnev4uSKv4NR/tIEeNzKmANgx7Be+MHrsT8US0vl6o
         mNM6JrBnDU9G6XPfIzQgMHJUVPIifFpT/HYyhHGszGn24TQFivwlnM3Ul7fR6JEb/2pf
         gNLNaOyj1s+I9AdhMNmMUK+Lj6tjmMVyK3VFOo61cXH8EKh04y6vzZZi95a4+w/YoKZp
         xXRZLUy1IwsnG4G2C17wkYaOsxxt7NOEgXDiry/uFq/SmR9vQ8udxfAaxqYrnaGa1z62
         YJrMkhiXuoqnlKzBDK2sleZFEpPAkKqjkWVhcUvq/qhHHxvfcQNUwd9qJIu8x7pRr7SA
         OhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043096; x=1692647896;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuLUGonkyHypddRCRvc9uIETvmmIAQ5QUWOkyLwj158=;
        b=QVU69b2HKXSORY6U8woWOwCW0Mnmn1qUOI7YdThtRMfgaMjTTO3uZH7ILvphgfim9W
         iMbBld2d3FHvT8BnkDOnPXZE2T7/3dWdq1y5/ROlDli6CfLYFOQmai7ISt3jKlEkL5K4
         ibhbXhAlFee+ZTX9rFiJ7IVBX2q1QcZ8NMvoGrl9Jvnexg0j3ShL3iJsinJr+21EF1bE
         1bRnzB4ZRNLXzw66d7Zv/SQD8Qg0EohCVSJDV3ntNvwU+skbgC2gvJB/q51a6qOy2xrl
         BQCmWKMJCp6ATQ/f1bqkhkdZKJDtXUdhr2HQd7dwvUTU1GE02Gu5dctghm7q8Ncrqlmi
         pP0Q==
X-Gm-Message-State: AOJu0YxE37YEAI+gsO1/2e+JKPJMc1gLK5YKYHfCtY5LGANnhslhVZkg
        uQ0hoegEToiuvzMxB+0ZkatEeQ==
X-Google-Smtp-Source: AGHT+IHD4aJXt8+KzczkizMYxhIRcfrH5YzRDw+eyq/V7eUoP0Hj6R4frkIWfVwAgNBA4Y3ZpBHMzw==
X-Received: by 2002:a81:62c6:0:b0:586:cf7:2207 with SMTP id w189-20020a8162c6000000b005860cf72207mr14499410ywb.14.1692043096146;
        Mon, 14 Aug 2023 12:58:16 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t10-20020a0dea0a000000b00586b5b6347csm2922292ywe.109.2023.08.14.12.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 12:58:15 -0700 (PDT)
Date:   Mon, 14 Aug 2023 12:58:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/3] mm,thp: fix sloppy text output
Message-ID: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm,thp: fix sloppy text output

Three independent trivial patches, fixing sloppy text output which has
annoyed me; but might risk surprising a parser, so any can be dropped.

1/3 mm,thp: no space after colon in Mem-Info fields
2/3 mm,thp: fix nodeN/meminfo output alignment
3/3 mm,thp: fix smaps THPeligible output alignment

 drivers/base/node.c                          | 4 ++--
 fs/proc/task_mmu.c                           | 2 +-
 mm/show_mem.c                                | 6 +++---
 tools/testing/selftests/proc/proc-empty-vm.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

Hugh
