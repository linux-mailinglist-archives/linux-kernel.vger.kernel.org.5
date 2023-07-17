Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D5755CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGQH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGQH0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:26:37 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90131715
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 00:26:28 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4D2z05sczBQt25
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:18:51 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689578330; x=1692170331; bh=oH++UjaaaxYLGRolIrJRxh81kJR
        iyD8cuVKSNoiVOTM=; b=Ma22pCQt4lrmtYb8HfRLjcJMU08FtLHSK+lxRNWXwFy
        ZNOMRRTtssp7TRp9MjI90j1+ypJ2mu8qWKbED0tqOZoRjs101N1FxYahQwjjoCMJ
        xd2K1DWv8L47oLtwtyWnJomhhoQ8+sU0HtMy1tNKW2z+ombZPyTbigayNbx5xZpJ
        fAUF2XtpVIUPG/CpXBD3RHtJcYjFPxvCTFDFid7qCiBTOEbVhWBTySUIAMZ7LOtR
        mUviAElvjrBIB5yvOQp33FbJxAOWFZgGDooGYrbo+zxFNr1M5ibe7bqmxFohoQD0
        ny5p9F4lkGdCwt6kCfJsdBJEkbg9+Crieay6x0K5BvQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E63qjaSTCeqM for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 15:18:50 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4D2y60gdzBQHHX;
        Mon, 17 Jul 2023 15:18:50 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 15:18:50 +0800
From:   shijie001@208suo.com
To:     w@1wt.eu
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tools/nolibc: Fix warnings in ctype.h
In-Reply-To: <tencent_17E97603EBEAD2CF4830CCE529421ED7BF05@qq.com>
References: <tencent_17E97603EBEAD2CF4830CCE529421ED7BF05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ca6e44ee0e6bd01abd31415c986aa269@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch warnings are removed:
WARNING: __always_unused or __maybe_unused is preferred over 
__attribute__((__unused__))

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  tools/include/nolibc/ctype.h | 26 +++++++++++++-------------
  1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/include/nolibc/ctype.h b/tools/include/nolibc/ctype.h
index 6f90706d0644..41c49002c0fc 100644
--- a/tools/include/nolibc/ctype.h
+++ b/tools/include/nolibc/ctype.h
@@ -13,84 +13,84 @@
   * As much as possible, please keep functions alphabetically sorted.
   */

-static __attribute__((unused))
+static __always_unused
  int isascii(int c)
  {
      /* 0x00..0x7f */
      return (unsigned int)c <= 0x7f;
  }

-static __attribute__((unused))
+static __always_unused
  int isblank(int c)
  {
      return c == '\t' || c == ' ';
  }

-static __attribute__((unused))
+static __always_unused
  int iscntrl(int c)
  {
      /* 0x00..0x1f, 0x7f */
      return (unsigned int)c < 0x20 || c == 0x7f;
  }

-static __attribute__((unused))
+static __always_unused
  int isdigit(int c)
  {
      return (unsigned int)(c - '0') < 10;
  }

-static __attribute__((unused))
+static __always_unused
  int isgraph(int c)
  {
      /* 0x21..0x7e */
      return (unsigned int)(c - 0x21) < 0x5e;
  }

-static __attribute__((unused))
+static __always_unused
  int islower(int c)
  {
      return (unsigned int)(c - 'a') < 26;
  }

-static __attribute__((unused))
+static __always_unused
  int isprint(int c)
  {
      /* 0x20..0x7e */
      return (unsigned int)(c - 0x20) < 0x5f;
  }

-static __attribute__((unused))
+static __always_unused
  int isspace(int c)
  {
      /* \t is 0x9, \n is 0xA, \v is 0xB, \f is 0xC, \r is 0xD */
      return ((unsigned int)c == ' ') || (unsigned int)(c - 0x09) < 5;
  }

-static __attribute__((unused))
+static __always_unused
  int isupper(int c)
  {
      return (unsigned int)(c - 'A') < 26;
  }

-static __attribute__((unused))
+static __always_unused
  int isxdigit(int c)
  {
      return isdigit(c) || (unsigned int)(c - 'A') < 6 || (unsigned 
int)(c - 'a') < 6;
  }

-static __attribute__((unused))
+static __always_unused
  int isalpha(int c)
  {
      return islower(c) || isupper(c);
  }

-static __attribute__((unused))
+static __always_unused
  int isalnum(int c)
  {
      return isalpha(c) || isdigit(c);
  }

-static __attribute__((unused))
+static __always_unused
  int ispunct(int c)
  {
      return isgraph(c) && !isalnum(c);
