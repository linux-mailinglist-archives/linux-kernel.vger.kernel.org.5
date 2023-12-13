Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D501810933
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378460AbjLMEl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjLMEly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:41:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4493DBE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 20:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=a3qVTxx6w2bR4XNs6x84ZJuB18NoMPstcgYiA1Luofw=; b=Ve8PiquLdb/dNb6mgVcdnQ1mst
        xeZ3PYeAJnrMS9fl3mXkXDdlU2E3O9w2/v40uCd7dIFBOAkSusj2L+E4iHx1JK8wS0CHxFUPPHHMd
        /6H1Ibf4RlIXlCAkRMt1nWdur/6L4mSiYiZbR+FLUJMD2hI3lvxdWEv8L4lvmGylPaXHamVBcOVrf
        qY8/mHw89n2fnPLlAc0TcEIRJbpJ0NV3bz3QLwBb9vma/7Dn6y2kmCF9CBkD4/6fAFZ0HZhzxmX6z
        fS9Te9oFONVd4lctDxM0c2iis//HxYGxsNLuVKGJTIkwMBjCuc4CaoYLXljJ11/aRtMoTzLhZ89m+
        Lf/qwvYw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rDH4I-00DbVL-2R;
        Wed, 13 Dec 2023 04:41:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] mei: fix spellos
Date:   Tue, 12 Dec 2023 20:41:58 -0800
Message-ID: <20231213044158.4449-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spellos reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/mei.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/include/uapi/linux/mei.h b/include/uapi/linux/mei.h
--- a/include/uapi/linux/mei.h
+++ b/include/uapi/linux/mei.h
@@ -100,14 +100,14 @@ struct mei_connect_client_data_vtag {
  * a FW client on a tagged channel. From this point on, every read
  * and write will communicate with the associated FW client
  * on the tagged channel.
- * Upone close() the communication is terminated.
+ * Upon close() the communication is terminated.
  *
  * The IOCTL argument is a struct with a union that contains
  * the input parameter and the output parameter for this IOCTL.
  *
  * The input parameter is UUID of the FW Client, a vtag [0,255].
  * The output parameter is the properties of the FW client
- * (FW protocool version and max message size).
+ * (FW protocol version and max message size).
  *
  * Clients that do not support tagged connection
  * will respond with -EOPNOTSUPP.
