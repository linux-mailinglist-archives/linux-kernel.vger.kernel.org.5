Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0BC75769A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGRIdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjGRIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:33:19 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186A0E4F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:32:58 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4sdx6tjTzBR9sk
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:32:53 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689669173; x=1692261174; bh=D1JR376ut2gRbi0CB7QUW/R7kN4
        /leXBafyAsKEc36w=; b=s3kJAJOCiGhn8ikDKGEiZkFIOsAsVDiNS8delabXfFJ
        EB/x0Hg+28e3Tr7EAxnw3gQiRhqL253cEx/G0tGn85dVVbk8I1BLyVN8nJ8XuH/S
        YGb3Mb7demhx0RaJFugrB8UKLeHzluHPeY2Qwxc36bzF9dZxwYl4vsL74oFrmqom
        JAp/JTNpY2JKp/3L91gkX/UjJa8gFjgAFk8mBTu7qBdfelSXQA41E708kaG7d4Ro
        +gBfHe3Zn5aUNy3vn7cWn5+aVuYm4t1Ghfaqr4m3yagb+q9BFwWxP1q5gS55IDAl
        MYX9yh1GF455D07fiAdaRh4dOyGlX6c4bP7qFdEyEAw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u7JMxMiwaTwq for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 16:32:53 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4sdx5dKnzBR7bp;
        Tue, 18 Jul 2023 16:32:53 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 16:32:53 +0800
From:   hanyu001@208suo.com
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ata: libata-sff: "foo * const * bar" should be "foo * const *bar"
In-Reply-To: <tencent_3B346C373B06E62D90341667146D42B78209@qq.com>
References: <tencent_3B346C373B06E62D90341667146D42B78209@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <c1103cc73a3cb587405dcc9326a583a5@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes the following checkpatch errors:

./drivers/ata/libata-sff.c:3145: ERROR: "foo * const * bar" should be 
"foo * const *bar"
./drivers/ata/libata-sff.c:3177: ERROR: "foo * const * bar" should be 
"foo * const *bar"

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/ata/libata-sff.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9d28bad..54777b0 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -3142,7 +3142,7 @@ void ata_pci_bmdma_init(struct ata_host *host)
   *    0 on success, -errno otherwise.
   */
  int ata_pci_bmdma_prepare_host(struct pci_dev *pdev,
-                   const struct ata_port_info * const * ppi,
+                   const struct ata_port_info * const *ppi,
                     struct ata_host **r_host)
  {
      int rc;
@@ -3174,7 +3174,7 @@ int ata_pci_bmdma_prepare_host(struct pci_dev 
*pdev,
   *    Zero on success, negative on errno-based value on error.
   */
  int ata_pci_bmdma_init_one(struct pci_dev *pdev,
-               const struct ata_port_info * const * ppi,
+               const struct ata_port_info * const *ppi,
                 const struct scsi_host_template *sht, void *host_priv,
                 int hflags)
  {
