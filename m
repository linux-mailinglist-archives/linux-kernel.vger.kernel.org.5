Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7F77BFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjHNSpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjHNSp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304BD10D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692038656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9iTUOPVpR05s9Fej91hxE4Ic4aCodt95xn8Dfhz/TxE=;
        b=AR8OBiI6Cs9vlaVhkhWCxa30hu21HVloUJU0jE8oXVRandBpboTQAtfGHoycHvBiDZ129q
        hDVTCrKJLaajewAsoekVxjyYFVmHvYnJYRi/e4+iTEMgw3wIJieHQoGF6hdOxYH06R2+FT
        i7ZxOAiIqMubQ5JA3GDetlxQ4OrT72k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-BORsuuUYNPS470BJLBX_HA-1; Mon, 14 Aug 2023 14:44:14 -0400
X-MC-Unique: BORsuuUYNPS470BJLBX_HA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-64726969c8bso2205946d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038654; x=1692643454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iTUOPVpR05s9Fej91hxE4Ic4aCodt95xn8Dfhz/TxE=;
        b=WYQVKB+FLCfMm7doSIbwgi1ByRtKVh/+4YDc2e+2aMwtjx33wj4AAT3YHA4f3x5Hv3
         zh14QWWPOVM5YCl9ziH9x0QM5IiE9ML5JasskFyecEjFn7e1ptOfEMpWlyA3dk90T5tQ
         gZhZS34SJ7A8BzYb28xQmUiorgsG684/LdWwIMCqFAZqAOIpw2+81GUrWlKO1wfeS1w1
         zImhjYZA9DUcCElO1j/xj9ddKybNrQ1ZmKYLGb51MmXw23cfFBOmFylMkH13XNWFuDDr
         W6aSnNMzxs4XQyBkR/EAmGNOx4xp/jR4pS3Y5Vhlm4YFgmpRj9zONBtG1LdNTMOpXGDW
         uUKg==
X-Gm-Message-State: AOJu0YzJBSKL4Rurvj4LNPX5BGeZL4oyMfM9Y/V3tYlqds4KO8yVR96g
        mHUpDMQt+xwCp7clDVYKqZiihowSNL9wLNiIto3tmpV5uyWcDu6IVzUxRHsvoYhxVBzsiz1fCGF
        6UDPjfVQlbj/6L411JFWH77ng
X-Received: by 2002:ad4:5dca:0:b0:63f:64ba:a30a with SMTP id m10-20020ad45dca000000b0063f64baa30amr14356434qvh.2.1692038653946;
        Mon, 14 Aug 2023 11:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeyh3eKc10g/0yp7GWzkw4JVDBRlb4+1uOV9vMR3RZXB0gmBEIT7v0wwyIa7N/SxFKb6puAQ==
X-Received: by 2002:ad4:5dca:0:b0:63f:64ba:a30a with SMTP id m10-20020ad45dca000000b0063f64baa30amr14356406qvh.2.1692038653559;
        Mon, 14 Aug 2023 11:44:13 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a7-20020a0cb347000000b00630c0ed6339sm3566561qvf.64.2023.08.14.11.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:44:13 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH RFC v2 0/3] mm: Properly document tail pages for a folio
Date:   Mon, 14 Aug 2023 14:44:08 -0400
Message-ID: <20230814184411.330496-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rfcv1: https://lore.kernel.org/r/20230810204944.53471-1-peterx@redhat.com

This is rfcv2 of the patch, where I split two small changes out from the
last patch.  Please refer to each patch for details.  The goal of the
series is to document clearly on how the fields in struct folio is reused
over tail pages, and make it clear on what can still be reused as free.

Smoke tested on x86_64 only, kernel-doc should have no change.

Comments welcomed.  Thanks.

Peter Xu (3):
  mm: Add TAIL_MAPPING_REUSED_MAX
  mm: Reorg and declare free spaces in struct folio tails
  mm: Proper document tail pages fields for folio

 include/linux/mm_types.h | 60 ++++++++++++++++++++++++++++++++++++----
 mm/huge_memory.c         |  6 ++--
 2 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.41.0

