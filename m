Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601BA76575F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjG0PXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjG0PXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:23:04 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C101BC1;
        Thu, 27 Jul 2023 08:23:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C3A55C020C;
        Thu, 27 Jul 2023 11:23:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 27 Jul 2023 11:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690471382; x=1690557782; bh=Eo
        M4IIhDJ+nima2YIRQB3D+oQTQUjMH7C/WgWPLN1hU=; b=h1DQnKtcQ3OCGoqvmU
        /OILwe4t1OgM3Um4SRPpjuP2P7NuE0lPg8nIhZwQOSZEyYH8/K0BNWygkVdYKzmo
        0a/7m6JL+UKklm8WZBsuGkKQpXWdCh3l+gH9CzRdvUf0FFOHV1CpDFuls64CyNlF
        Mv8rGL/Um5t0zsDOvqlMPyuCg4F5zbpOtj7Ym2gVvehRC8Latx7nj2O9p9j0g9d9
        9zFOgZIys9fqxSOJvZnCnAC6kRAG6fc67UCYVNGueUb6oP3op1HE3b62WAqeDELJ
        i3AUXh/4btRW35231KpKxBA+L7fCMo5RePak/muG/a1pTGBL09+DJLyur4aT9GuM
        crUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690471382; x=1690557782; bh=EoM4IIhDJ+nim
        a2YIRQB3D+oQTQUjMH7C/WgWPLN1hU=; b=FKLkZAbK37Av510F9o8VWviFqTlN3
        DrYX9p97hkyv8TIScAk4+hpt5wamLncfo6xJUaS+gx8w3manJkp/5W3sRHOMRVKp
        4zj4OGuZqgqQxZeg7gEoATYPT1YNkHPu7CUEeMNIFvKZfISwnxIZbd0pqf/vSckr
        E9rDKBtLmSDPXyv+K6G0b7O+xoYeU8+yIdA0zvQxroI7TXFebB3AmnCxzRotOBxi
        qSNVJ5U20Nk8S/yjKJJ8baBOjBgBfQZxkqZHAAPKh8YfC7Bd/kf7G775HeXLWY/E
        I7ErcYK2BW79i2YGdKReiz8glVLY12vQJcSZQEtp7D1cLvpKW0jtqTYWQ==
X-ME-Sender: <xms:1ovCZLSAc1zEjeKtpsJ4LzVHbwglioL_pX6kLVZlMlBWDshmvE4PIg>
    <xme:1ovCZMygtSitOU5z-3X96q0auUn1RKJwP5t1F7aePYs44uGj5Abx2nBWYPq4zRKu_
    etihgZpbtKTycw4l18>
X-ME-Received: <xmr:1ovCZA0XPZ-jDIv3KBQ6TCCb7yS4OJGet1ioyLbWEUSg5hmrXrHPOWQcG1t4toMcOmGzr6nn0jzpwSv_DU_RlgsnQSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeggdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghvihguucft
    vggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtghomheqnecuggftrfgrthhtvg
    hrnhepheetveetgfdvffehfeffieeugeejhfevieejveeivdeuiefgvdduueffhfefveeh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesuggrvhhiughrvggrvhgvrhdrtghomh
X-ME-Proxy: <xmx:1ovCZLDql3qzJFBsgOxgVETRmXnYDYTRZnPI3JjSVYIGDHCVbbc2IA>
    <xmx:1ovCZEjRDOaJau88vWKBSsNSc4myOEKCRGKSp2BuzQSwtHgZTHwNxA>
    <xmx:1ovCZPpnwlZbZDByvhNk14sfkCRv1xbIJ-N-Eqz-VHRLUG6EYSlNbw>
    <xmx:1ovCZOZc2rVbWBnFTxZws2Qz0PQ0WGnbfxc55b8-EWiNW9TNRr-Yew>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 11:23:01 -0400 (EDT)
From:   David Reaver <me@davidreaver.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        David Reaver <me@davidreaver.com>
Subject: [PATCH] docs: ABI: sysfs-bus-nvdimm: fix unexpected indentation error
Date:   Thu, 27 Jul 2023 08:22:34 -0700
Message-ID: <20230727152234.86923-1-me@davidreaver.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following error when running make htmldocs:

Documentation/ABI/testing/sysfs-bus-nvdimm:10: ERROR: Unexpected indentation.

This is caused by missing newlines before the code examples. In particular,
before this patch, the second example for ctl_res_cnt doesn't render properly.

Link: https://docs.kernel.org/admin-guide/abi-testing.html#abi-sys-bus-event-source-devices-nmemx-format

Signed-off-by: David Reaver <me@davidreaver.com>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index de8c5a59c77f..8564a0ff0d3e 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -18,7 +18,9 @@ Description:	(RO) Attribute group to describe the magic bits
 		Each attribute under this group defines a bit range of the
 		perf_event_attr.config. Supported attribute is listed
 		below::
+
 		  event  = "config:0-4"  - event ID

 		For example::
+
 			ctl_res_cnt = "event=0x1"

 What:           /sys/bus/event_source/devices/nmemX/events
