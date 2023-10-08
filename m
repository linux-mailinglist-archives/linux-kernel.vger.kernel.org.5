Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE727BCDB9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344622AbjJHKAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344616AbjJHKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:00:30 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B73812C
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:00:17 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1dd8304b980so2489517fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=transsion-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1696759216; x=1697364016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjwttTM8shNa+ZykQipB79DYWo5iJnu0BccYrm9Eubk=;
        b=Tc/3SJt/9ZFMvTKSKDWOq+UB65R7NeloWYUVVeLGgoVxa5rFRpiSSKOjPrc6Mfin6c
         OY90IgsHzj1ti0J4TGOW6UCwFJfDeRn1iA3wyLFQc7TJe9x3M8nCi0/BLg6iDY8zXdQW
         a09kgFaPYbO8KvjjXM19PKK/0P8Oy4iN1foVgxrOhAO8M1VCTvlkCqvBYrRoNWivoYES
         RcTP5YqSKpBTfBDGdyMKa8MitdaFD1mH1ornmHRy5laONY1xPUC55vd2LWO+ia3iBy+e
         D9umBGVU7gRdyLlaKq9uDn/eKOFK34Uzi/wnn1Zj+Mxb3CDxyEHlZ5OrZxxvo9g5c7Nk
         a1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696759216; x=1697364016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjwttTM8shNa+ZykQipB79DYWo5iJnu0BccYrm9Eubk=;
        b=JShS1kBg3TeGZqLRCsa01b9WnfIUVdhblVLQF7Yg3t943A+zvVLYIel1p5OUv/LRCi
         7P9q24Rpf/OXdyjBV6D02bApypdPcOwXVDeaPgTITeAOajS1EHmHcAOo1r94hePUlqnU
         qsVJvVPNnsfWheP7AgghWSIhC61O9Ihf83BbOzg7SyK4dRlo4Jf9W+LoWAsN+qFr1tFf
         RU3PVcKNsf/2PQULlx3XT2suFz0Z33juya0HPgZ5t0UOTSeWvUq1Z5pQ4lPzR/9oPmuP
         qpihefkxK8yQ9wZXllOhQTbNjVoqvqBitJrheNtH5bJf9JB89fOLzjnsaNTudex9MKnA
         LNVQ==
X-Gm-Message-State: AOJu0YznJB2+oM0HQfxedKzde6Xt6b6TeW3XEsFkWQHn7CNc/eY2hQ4m
        r/WkpogLP75AuM1TZhhkCfGCNiVFByOsGiKb9nE=
X-Google-Smtp-Source: AGHT+IHbSkEM0AN5q48/SQhxJuecJnMxGYLkPP4mU+9ovjZ/3+4gSc8kFKvogvablROZw3L0oZktig==
X-Received: by 2002:a05:6871:451:b0:1dc:ddcd:876f with SMTP id e17-20020a056871045100b001dcddcd876fmr15041196oag.41.1696759216748;
        Sun, 08 Oct 2023 03:00:16 -0700 (PDT)
Received: from linchengyang-VB.. ([103.40.76.4])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090282c900b001c72c07c9d9sm7126343plz.308.2023.10.08.03.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 03:00:16 -0700 (PDT)
From:   Lincheng Yang <lincheng.yang@transsion.corp-partner.google.com>
X-Google-Original-From: Lincheng Yang <lincheng.yang@transsion.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mhiramat@kernel.org, willy@infradead.org, hughd@google.com,
        peterx@redhat.com, mike.kravetz@oracle.com, jgg@ziepe.ca,
        surenb@google.com, steven.price@arm.com, pasha.tatashin@soleen.com,
        kirill.shutemov@linux.intel.com, yuanchu@google.com,
        david@redhat.com, mathieu.desnoyers@efficios.com,
        dhowells@redhat.com, shakeelb@google.com, pcc@google.com,
        tytso@mit.edu, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        catalin.marinas@arm.com, lrh2000@pku.edu.cn, ying.huang@intel.com,
        mhocko@suse.com, vishal.moola@gmail.com, yosryahmed@google.com,
        findns94@gmail.com, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wanbin.wang@transsion.com, chunlei.zhuang@transsion.com,
        jinsheng.zhao@transsion.com, jiajun.ling@transsion.com,
        dongyun.liu@transsion.com,
        Lincheng Yang <lincheng.yang@transsion.com>
Subject: [RFC PATCH 5/5] mm/swapfile: add swapfile_write_enable interface
Date:   Sun,  8 Oct 2023 17:59:24 +0800
Message-Id: <20231008095924.1165106-6-lincheng.yang@transsion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008095924.1165106-1-lincheng.yang@transsion.com>
References: <20231008095924.1165106-1-lincheng.yang@transsion.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user does not want to write back cold pages to swapfile, set
/proc/swapfile_write_enable to 0. At this time, all anon pages, regardless
of hot or cold status, will be written back to the zram device.

Signed-off-by: Lincheng Yang <lincheng.yang@transsion.com>
---
 mm/swapfile.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 629e6a291e9b..557d1c29be77 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -106,6 +106,7 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
 atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
 static unsigned int workingset_restore_limit;
+static unsigned int swapfile_write_enable;
 
 static struct swap_info_struct *swap_type_to_swap_info(int type)
 {
@@ -127,7 +128,7 @@ bool swap_folio_hot(struct folio *folio, bool hotness)
 	unsigned long restores;
 	int delta;
 
-	if (hotness)
+	if (!swapfile_write_enable || hotness)
 		return true;
 
 	if (folio_test_swapbacked(folio) && folio_test_hot(folio)) {
@@ -2775,10 +2776,46 @@ const struct proc_ops workingset_restore_limit_fops = {
 	.proc_write = workingset_restore_limit_write,
 };
 
+static ssize_t swapfile_write_enable_write(struct file *file,
+					   const char __user *ubuf,
+					   size_t count, loff_t *pos)
+{
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint_from_user(ubuf, count, 10, &val);
+	if (ret)
+		return ret;
+
+	swapfile_write_enable = val;
+
+	return count;
+}
+
+static int swapfile_write_enable_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", swapfile_write_enable);
+	return 0;
+}
+
+static int swapfile_write_enable_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, swapfile_write_enable_show, inode->i_private);
+}
+
+const struct proc_ops swapfile_write_enable_fops = {
+	.proc_open	= swapfile_write_enable_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release,
+	.proc_write	= swapfile_write_enable_write,
+};
+
 static int __init procswaps_init(void)
 {
 	proc_create("swaps", 0, NULL, &swaps_proc_ops);
 	proc_create("workingset_restore_limit", S_IALLUGO, NULL, &workingset_restore_limit_fops);
+	proc_create("swapfile_write_enable", S_IALLUGO, NULL, &swapfile_write_enable_fops);
 
 	return 0;
 }
-- 
2.34.1

