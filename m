Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C1575A481
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGTCrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGTCrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:47:15 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D992109
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:47:13 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5xt53vZwzBRDrh
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:47:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689821229; x=1692413230; bh=0KLRTreuiIUpnVrU58gqyhT7akT
        3Ptoka1vuCFuY8Ks=; b=yIRU9Jz2MTcaVPUC4gaANxQTLgjPReL1hqyav0gXyo/
        X0B98wRsya9+bsAKtZqjrX0Eb6Yv1fajhIyxKlU1derntgfNunZ6AD9+1D6KYkTW
        V0D8hEL0hWCaMXhjKwIsEESgEyFTEszG0cPBARktxfvooo37E+y9VH8tcvhMezqM
        qnQvI3948bVs04OCVPAXNqo8FM2faimpKOKasQKcLWZRpC/4smO0WyghgUgY7hzj
        t1VYPr0jJUqGq/6ZNPuGNwAL5I7hlv+a4EO1pQQRTTDmMqJ6VXEzMrkBtSNTb9IJ
        wy9Rv9xwQBoLGqJsG/GjV5Mnek3a/Polbp44RAjRyQA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 711FXe9qawhD for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 10:47:09 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5xt52DFszBRDrS;
        Thu, 20 Jul 2023 10:47:09 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 10:47:09 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: add missing spaces before '*' and
 remove spaces after '*'
In-Reply-To: <20230720024545.1230-1-xujianghui@cdjrlc.com>
References: <20230720024545.1230-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <1e9b311ce35bc4a115e4a171a565e415@208suo.com>
X-Sender: sunran001@208suo.com
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

Add missing spaces to clear checkpatch errors.

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/media/dvb-frontends/ds3000.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/ds3000.c 
b/drivers/media/dvb-frontends/ds3000.c
index 20fcf31af165..ca40234a28fa 100644
--- a/drivers/media/dvb-frontends/ds3000.c
+++ b/drivers/media/dvb-frontends/ds3000.c
@@ -456,7 +456,7 @@ static int ds3000_read_status(struct dvb_frontend 
*fe, enum fe_status *status)
  }

  /* read DS3000 BER value */
-static int ds3000_read_ber(struct dvb_frontend *fe, u32* ber)
+static int ds3000_read_ber(struct dvb_frontend *fe, u32 *ber)
  {
  	struct ds3000_state *state = fe->demodulator_priv;
  	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
