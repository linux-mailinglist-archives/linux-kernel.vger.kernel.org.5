Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011E27A0B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbjINRZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbjINRZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:25:03 -0400
X-Greylist: delayed 76484 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 10:23:53 PDT
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5400:ff:fe00:d7d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83199448E;
        Thu, 14 Sep 2023 10:23:53 -0700 (PDT)
Received: from ritsuko.sh.sumomo.pri (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id 7CD123001ED;
        Fri, 15 Sep 2023 02:23:38 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 7CD123001ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1694712220; bh=t7fonimBO7gOWRqIwFxcElU/mZYIdNnjXJ9VabFw82w=;
        h=From:To:Cc:Subject:Date:From;
        b=mm6YSLuFPho2VgfMlo90AzZRDzxxbF+SXsvKN/SuLbp5+GwUyYQW7aXpKzhGiZbJc
         wf4ZWb0dk64TTWLx8IBJkgOmkaxjpAmmuHYezxmaiYzc58z5hY0plKdT+SRevfK1gg
         rWKsljkKIKq/dfsLeP1Q9P6qHa0xh7v5FghNLyuk=
From:   Randy Li <ayaka@soulik.info>
To:     linux-usb@vger.kernel.org
Cc:     Randy Li <ayaka@soulik.info>, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH 0/2] USB: DMA: point out recommend APIs
Date:   Fri, 15 Sep 2023 01:23:22 +0800
Message-ID: <20230914172336.18761-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although I submit these patches as the previous reply suggestion, I
am stilling wondering the IOMMU with USB controller. I think the most
of USB controller didn't need to create entities in IOMMU to support
scatterlist. Once the hcd supports that(sg_tablesize > 0), it could
support infinite scatter pages?

Randy Li (2):
  USB: dma: remove unused function prototype
  docs: driver-api: usb: update dma info

 Documentation/driver-api/usb/dma.rst | 48 +++++++---------------------
 include/linux/usb.h                  | 16 ----------
 2 files changed, 11 insertions(+), 53 deletions(-)

-- 
2.41.0

