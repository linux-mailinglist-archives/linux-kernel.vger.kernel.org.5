Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D2B75209B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjGML61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjGML6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:58:21 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C52D2D42
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:58:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1tQz15KyzBRSV7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:58:03 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689249482; x=1691841483; bh=BIsYHfdCMZPZNbfMC1iMXVuZv2Y
        KkrROMhSFrUl8kDw=; b=m5zGAmeAEdwlMReZ6DG42VyWTkk5KoAbPNeL7xFz0nF
        FQx411L1vGxLG+cR8cwsGCMncyU+SoCIkQ+spvqsB0DRyZZfJyehGs/O7FcLIWCj
        +sAi00eywYqegAoVmWMIt1QBcYlWWDP2Xv3lcaMSsTVhT95EPEF0QLK8p2719n5e
        ZOvCIKePLK/OKravWeUohTfrBxfaGIdrZFIU79LKyIv3TautYPpTgdfcZ6O69/bk
        Z2hRt+D+gfpm9Xq1AVmeH1I9fHlYB5nrEmi6ElvF2gtZrSHiy7xxIwmsVRxT+RW+
        vE1xKRlkYyTiKXBb499RwJEGVOxUTOomvQJuDGbU0CQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t2XR1mud2LBa for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 19:58:02 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1tQy50xQzBRRLy;
        Thu, 13 Jul 2023 19:58:02 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 19:58:02 +0800
From:   hexingwei001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        maddy@linux.vnet.ibm.com, rashmica.g@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: void function return statements are not
 generally useful
In-Reply-To: <20230707142206.52811-1-panzhiai@cdjrlc.com>
References: <20230707142206.52811-1-panzhiai@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <359683bc83ac7a0090089ef3837969d0@208suo.com>
X-Sender: hexingwei001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

void function return statements are not generally useful,
so deleted the return in function ia_css_get_crop_offsets().

Signed-off-by: Xingwei He <hexingwei001@208suo.com>
---
  drivers/staging/media/atomisp/pci/sh_css.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css.c 
b/drivers/staging/media/atomisp/pci/sh_css.c
index 93789500416f..bd0e2451cd08 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -3107,7 +3107,6 @@ ia_css_get_crop_offsets(

      IA_CSS_LEAVE_PRIVATE("void start_col: %u start_row: %u", column, 
row);

-    return;
  }
  #endif
