Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E475C77A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGUNS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF4130CB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689945493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D9B4bpfSLsREvwYaNf5Y9F8Xh1WUptxvPVvaWAGHw44=;
        b=AM47ENdBjkGqdAm0V4ehaHKtbjI/tWUc6L8krYgdXOnoBS9vRuA2eSV/TlXlGamiL+2GT5
        qNVImqUJXLzFo6UzQujJkzu/qWHuF9voUXDNLFsLvBcMYolh1uLKCMlNqltSqLzpU+tMiN
        604P5GEtinSaDVbo6511vfsj9E+xtr4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-opffkOCUNLGgsjfT4yHlsA-1; Fri, 21 Jul 2023 09:18:09 -0400
X-MC-Unique: opffkOCUNLGgsjfT4yHlsA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D7743814945;
        Fri, 21 Jul 2023 13:18:08 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A9C540C206F;
        Fri, 21 Jul 2023 13:18:03 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, mawupeng1@huawei.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] percpu: some trivial cleanup patches 
Date:   Fri, 21 Jul 2023 21:17:57 +0800
Message-Id: <20230721131800.20003-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a left issue in my mailbox about percpu code at below. When
I rechecked it and considered Dennis's comment, I made an attmept
to fix it with patch 3.

https://lore.kernel.org/all/Y407wDMKq5ibE9sc@fedora/T/#u

Patch 1 and 2 are trivial clean up patches when reading percpu code.

Baoquan He (3):
  mm/percpu.c: remove redundant check
  mm/percpu.c: optimize the code in pcpu_setup_first_chunk() a little
    bit
  mm/percpu.c: print error message too if atomic alloc failed

 mm/percpu.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

-- 
2.34.1

