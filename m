Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCEC7F65E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjKWSCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:02:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FF3D41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700762546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4EEXViqB805TEJLl95Oc48y0HOh1LGI/lPszglbnn4k=;
        b=iQM2FzLOiwoYKUGqIMdAHh3rSeG6/y1SK/SWyDhqrOyVm9itztVZn9boGg1BlyZbLVsk/S
        MfGDcU56elmktZEQ408DvZJ99qt6jo59swYjG7R80WRtxISLG09xmrmoNglrURmJu/Yqe+
        b1TUIQx9f4wMiRrVXna+hTEaUaHwPBw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-aewL9pyOOc-jHFR0DY4Hdw-1; Thu, 23 Nov 2023 13:02:25 -0500
X-MC-Unique: aewL9pyOOc-jHFR0DY4Hdw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67a05428cceso2146146d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762544; x=1701367344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EEXViqB805TEJLl95Oc48y0HOh1LGI/lPszglbnn4k=;
        b=Pm+zGSrbyvWYMCO2e/AxE1OdkIG5pp94liJKQ3/jNPIlpXLWaGh5OnhPVRGHX76feo
         YaZ3E3zfdhcoxDwaiI4COYbZwkrybXMVMW/lZCQbuwNGZfBhh7JYtdik+3D5NiuJnIQ6
         B/df5fuCXLx2HEmkzPxU3J6PzaGtuT2G1Dtrx85/CSPlUBox8JhdsF+99SSp8zPOmGHP
         KQWy7Qde7re00dUxq0naXfsQLffOdQk1COwJd17NKvmDysNMdfdVMvT5GDTLCQEWX0ou
         W7E4Aob14HGt19sUagFjKc4GVNDYuJ1bOdXnobI16+U9P/CaDxBp6JQ+AIaC/+RiRck/
         Q2Rg==
X-Gm-Message-State: AOJu0YyDllhig5Rk+hCzbL4nu7OKnaDq25uwpfCaAp1Tg7j9Ah9eAoYa
        QWQEVVuT65p8ZEGeFVD8+p23z97rOHKc90WzaVHGRi4fjiSarBqRUpKutBlSDCGMUvr49JAKDvi
        MwIJkCLRQ4WYhksKD79yCPljrS2m+yQse
X-Received: by 2002:ad4:420f:0:b0:679:d8a9:ef41 with SMTP id k15-20020ad4420f000000b00679d8a9ef41mr273790qvp.0.1700762544394;
        Thu, 23 Nov 2023 10:02:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUr77F/yyuIsbmtEQQMFGKhS5qNFNQVBgvQdBpyjkNFaD58T2jqzyON33YgIFslunf28Y/Jg==
X-Received: by 2002:ad4:420f:0:b0:679:d8a9:ef41 with SMTP id k15-20020ad4420f000000b00679d8a9ef41mr273772qvp.0.1700762544131;
        Thu, 23 Nov 2023 10:02:24 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id s2-20020a0cdc02000000b0065af9d1203dsm693210qvk.121.2023.11.23.10.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:02:23 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] mm/gup: Fix follow_devmap_p[mu]d() on page==NULL handling
Date:   Thu, 23 Nov 2023 13:02:22 -0500
Message-ID: <20231123180222.1048297-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bug found not by any report but only by code observations.

When GUP sees a devpmd/devpud and if page==NULL is returned, it means a
fault is probably required.  Here falling through when page==NULL can cause
unexpected behavior.

Fix both cases by catching the page==NULL cases with no_page_table().

Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Fixes: 080dbb618b4b ("mm/follow_page_mask: split follow_page_mask to smaller functions.")
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 231711efa390..0a5f0e91bfec 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -710,6 +710,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		if (page)
 			return page;
+		return no_page_table(vma, flags);
 	}
 	if (likely(!pmd_trans_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
@@ -758,6 +759,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		if (page)
 			return page;
+		return no_page_table(vma, flags);
 	}
 	if (unlikely(pud_bad(*pud)))
 		return no_page_table(vma, flags);
-- 
2.41.0

