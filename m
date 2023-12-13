Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693BC8121A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442815AbjLMWkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjLMWkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:40:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D7CD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xidh7a9HbH8MOgSBlX1LRgGvNt6UZ5IQf2RfKydeXns=; b=qqi2ByVJwjuH5fZSuTzhHDmXCu
        CmZ804LEqlZgCMQNaUuFwImO0+R37R4SA8djfKAYGjryxeIcmlc5VkYQzo2dnf4EC7NzswmPijnxI
        Kkn8UbxbmMswyuRd3oSC2Xmv2DG5prVxdOdf1U+X++19Addig+odOwAhpzVUnh9nJ+l/9++T7GM6G
        MpFCAd+DFGd/qWMjGBIA9J07EFsRYPfKQboVSAe/hoI0kz1cF3h/NhRFieghqtT7l4Chb5rmGgz4y
        EDvzAns3ZIYQ/E7CkAJemSVTf1vbOUEh9nxbaLKen/jnFOTbHkfupQmxDPvXr5xbu3fug4MUAatbU
        i4/cfJSg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rDXtm-00G9Be-3A;
        Wed, 13 Dec 2023 22:40:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] mei: fix spellos in mei.h
Date:   Wed, 13 Dec 2023 14:40:14 -0800
Message-ID: <20231213224014.23187-1-rdunlap@infradead.org>
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

For include/uapi/linux/mei.h, correct spellos reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: specify that only this one header file is updated.

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
