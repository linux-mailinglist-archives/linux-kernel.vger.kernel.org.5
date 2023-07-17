Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24E0755A28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGQDnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQDnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:43:07 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511801AC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:43:05 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R47Fx2NqKzBHYM3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:43:01 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689565381; x=1692157382; bh=/7krcvMT1smBctXUrn+65cydTRs
        81mX1rdV/FZXmGpI=; b=nnFBk5V/dKdC+wlpUMlPVLg5pWPyvj1/md5Gh//aE+A
        amipOzFHYZq/5ttSxrQZubv8+H6jqArRLlQxECildSRCbORrChkxBpyq/Wmcg1gB
        a0CHqhK6PujFAL5Z8lw14GnXqbV65/CMshfXzyjv7/CyRhPiIbByCNH5nwlc+lC1
        bqC0erzIUuirM8G+IQpCaWF+pQ7R3xdBgIJRa8hIxocN+4oBtUScgi0HgTc0sANA
        hbSiXc1CVGgK76AgqUzyTxv4VTn4RSZXyVSUjulruBFdBe89YvAMSg7jNUFM6WOB
        4OoRPUmtMOV7bEQSnRe6Acx5O15JsbXIrojHQ7VKwTQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8-d7VwKyXCnN for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 11:43:01 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R47Fw6XhYzBHXhP;
        Mon, 17 Jul 2023 11:43:00 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 11:43:00 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org
Subject: sfc: falcon: Prefer unsigned int to bare use of unsigned
In-Reply-To: <tencent_EE1674B8CDD721F12D12287A857E04C5DB0A@qq.com>
References: <tencent_EE1674B8CDD721F12D12287A857E04C5DB0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ab907800461dadf95c332a097f58e6f0@208suo.com>
X-Sender: hanyu001@208suo.com
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

Fix checkpatch warnings:

./drivers/net/ethernet/sfc/falcon/net_driver.h:1167: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'
./drivers/net/ethernet/sfc/falcon/net_driver.h:1188: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'
./drivers/net/ethernet/sfc/falcon/net_driver.h:1188: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'
./drivers/net/ethernet/sfc/falcon/net_driver.h:1202: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/sfc/falcon/net_driver.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/net_driver.h 
b/drivers/net/ethernet/sfc/falcon/net_driver.h
index a2c7139..d2d8f9b 100644
--- a/drivers/net/ethernet/sfc/falcon/net_driver.h
+++ b/drivers/net/ethernet/sfc/falcon/net_driver.h
@@ -1164,7 +1164,7 @@ struct ef4_nic_type {
   
*************************************************************************/

  static inline struct ef4_channel *
-ef4_get_channel(struct ef4_nic *efx, unsigned index)
+ef4_get_channel(struct ef4_nic *efx, unsigned int  index)
  {
      EF4_BUG_ON_PARANOID(index >= efx->n_channels);
      return efx->channel[index];
@@ -1185,7 +1185,7 @@ struct ef4_nic_type {
               (_efx)->channel[_channel->channel - 1] : NULL)

  static inline struct ef4_tx_queue *
-ef4_get_tx_queue(struct ef4_nic *efx, unsigned index, unsigned type)
+ef4_get_tx_queue(struct ef4_nic *efx, unsigned int index, unsigned int 
type)
  {
      EF4_BUG_ON_PARANOID(index >= efx->n_tx_channels ||
                  type >= EF4_TXQ_TYPES);
@@ -1199,7 +1199,7 @@ static inline bool 
ef4_channel_has_tx_queues(struct ef4_channel *channel)
  }

  static inline struct ef4_tx_queue *
-ef4_channel_get_tx_queue(struct ef4_channel *channel, unsigned type)
+ef4_channel_get_tx_queue(struct ef4_channel *channel, unsigned int 
type)
  {
      EF4_BUG_ON_PARANOID(!ef4_channel_has_tx_queues(channel) ||
                  type >= EF4_TXQ_TYPES);
