Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DD27BBEF0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjJFSrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjJFSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:47:04 -0400
Received: from mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31C18D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1696617986; bh=RYszOFam6KVl1ypA3hz/Gcl2MPX05Hk70/Nt/veHpOM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=F1xvBXAVWvtXxgW1QQNTe41Wrl1V8lgkOuvedF2t9O0VLnM/P4+c/KixHwe0EMhNF
         iVsVYf9i9rpf288wnN0fDJ++tNtL5+KqkRvkONOwM5R0Xpkry+Wuq0N0tan+ZP3yWB
         EAMt6nYiQZHghB6vvGwhbpkJyXeF/SiqIfLMS4Iw=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri,  6 Oct 2023 20:46:26 +0200 (CEST)
X-EA-Auth: wLkTObUMxPeiTYFDpw6KkYlMjjTpxPawCOc5bmQzZOsGoLzdy2ksD4xiQuNg42zWt+KIKqlCXA9oIB3RokB0KAtS6XdsuVA+
Date:   Sat, 7 Oct 2023 00:16:18 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: kmap() transformation: Question about copy_user_highpage
Message-ID: <ZSBV+h/gjPWV7+Gj@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am attempting to work on replacing the kmap[_atomic]() calls by
kmap_local_page() function call. A detail on this change can be found here [0].

I would like to know if this function: 
	arch/loongarch/mm/init.c::copy_user_highpage()
is currently in use or is it a dead code?

If this code is not in use, can this be removed instead? However, if it is in
use, can you comment why kmap_atomic() was preferred over kmap()
function call?

[0] https://lore.kernel.org/all/20201029222652.302358281@linutronix.de/

Thank you,
Deepak.


