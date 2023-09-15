Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43E17A2342
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjIOQHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbjIOQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:07:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE5A2700
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:06:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31f8ddc349bso314033f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694794016; x=1695398816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGM1IFZwU7Wt303Jm8PGCn2ePTabuQMB8pTK/IDboT0=;
        b=Ul31wQeKFVkF/ScJ+474ozS70bo3hItov4ne6Ng8pSFNUpQO31BrE5d+oH5jzieVfb
         44OMLucswSs4XQk178UN2Nzb/ogPJSGtjaYKF1porp9FVtm2iMgyJoAGrK3heDbnnfHw
         XpgtoZ+odyv7IesX4DEsZa2YzKEOmstNmTw3OumGxCz31Vw1dtzdEZtLARJNwALN/qJF
         AOFZ8XtOMIgwnhqbR0UAZx674iOSvl7vX+3nR7ruldMdoBw8r4SRz2BBmPiUUVmo7mPG
         zuszhdlYr9X9uM1NfLn3H4CXYeHVlRTn4KpKfqWTQTCRUxAu7ba19mUoDOM6WKjbQZWW
         jbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694794016; x=1695398816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGM1IFZwU7Wt303Jm8PGCn2ePTabuQMB8pTK/IDboT0=;
        b=VhvWqOGztbRk2g2Jogs2gjUZ5FIcT83cwWFC1Hn1GfQIeqo4yvJ5KqlG7zLWbiPbdG
         qGxIJkqOXaWajjC01D2L6Vww8KfnbXaQSKGkYul8mpUVeeMRyDXumOKnyTqNMYbrgFg0
         bELsZ90V0EN2ncBeODpNyJmxr8VENCT+f9ci0ElQNFph+/HLpP9UOhysul81/wT81sjt
         Ely6/a4A/YUT44WxCCTNv91w1E62S2QG6cYBZp03FcFHGVonqknnzztTO5KOHrDk/RqS
         3RMGRwjRGNawnmLe0OJmhqK0kNbHYfWsWA/DpQDg1QKdnLuKSuVEwBn7OFiOQWnpvNEn
         Y4bw==
X-Gm-Message-State: AOJu0YzrdTi9mWU6xTCYUrM+1Ll8N0Lbdb/3fwspvA3A4QmpymfhOV66
        24CyAvefChgxGympp1jqiOs=
X-Google-Smtp-Source: AGHT+IF85Oj9/6BKo+0uFr/Sgg1sPEIGA/wJDkfK7IwroU8qof6JWRocqBYZ8TkG9OTkQivE0QoZ3Q==
X-Received: by 2002:a05:6000:1047:b0:31f:a096:6e18 with SMTP id c7-20020a056000104700b0031fa0966e18mr1760927wrx.6.1694794016367;
        Fri, 15 Sep 2023 09:06:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6b87000000b0031ae8d86af4sm4754226wrx.103.2023.09.15.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:06:56 -0700 (PDT)
Date:   Fri, 15 Sep 2023 18:06:54 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] staging: rtl8192e: Replace struct rtllib_hdr_3addr in
 rtllib_rx.c
Message-ID: <4d5409433c681557f8187b13f0bbf124a662ff96.1694792595.git.philipp.g.hortmann@gmail.com>
References: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694792595.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace struct rtllib_hdr_3addr with struct ieee80211_hdr_3addr to avoid
proprietary struct.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 7c16d4db67ad..dddd38bbc648 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -210,7 +210,7 @@ rtllib_rx_frame_mgmt(struct rtllib_device *ieee, struct sk_buff *skb,
 	 * this is not mandatory.... but seems that the probe
 	 * response parser uses it
 	 */
-	struct rtllib_hdr_3addr *hdr = (struct rtllib_hdr_3addr *)skb->data;
+	struct ieee80211_hdr_3addr *hdr = (struct ieee80211_hdr_3addr *)skb->data;
 
 	rx_stats->len = skb->len;
 	rtllib_rx_mgt(ieee, skb, rx_stats);
@@ -753,10 +753,10 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 			 struct rtllib_rx_stats *rx_stats,
 			 struct rtllib_rxb *rxb, u8 *src, u8 *dst)
 {
-	struct rtllib_hdr_3addr  *hdr = (struct rtllib_hdr_3addr *)skb->data;
-	u16		fc = le16_to_cpu(hdr->frame_ctl);
+	struct ieee80211_hdr_3addr  *hdr = (struct ieee80211_hdr_3addr *)skb->data;
+	u16		fc = le16_to_cpu(hdr->frame_control);
 
-	u16		LLCOffset = sizeof(struct rtllib_hdr_3addr);
+	u16		LLCOffset = sizeof(struct ieee80211_hdr_3addr);
 	u16		ChkLength;
 	bool		bIsAggregateFrame = false;
 	u16		nSubframe_Length;
@@ -764,7 +764,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	u16		SeqNum = 0;
 	struct sk_buff *sub_skb;
 	/* just for debug purpose */
-	SeqNum = WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctl));
+	SeqNum = WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctrl));
 	if ((RTLLIB_QOS_HAS_SEQ(fc)) &&
 	   (((union frameqos *)(skb->data + RTLLIB_3ADDR_LEN))->field.reserved))
 		bIsAggregateFrame = true;
-- 
2.42.0

