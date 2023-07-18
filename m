Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE207571B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGRCQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGRCQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:16:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD56E10C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:16:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4jHk6fTzzBQslb
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:16:34 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689646594; x=1692238595; bh=kcQDfIFF3dft+pZX76e0sxAFQ0w
        CFG18W5YqOSfTYPU=; b=bW0xhFPM5tvAWoF1xmrUAgV9fnw/DCjE9XRYBQrEdQP
        qK+pL/ioQCKuXX4Af157mOaAjzS9MJFVctN2p+bgQBqcvQ7c2OLwWvu6krI3fx9v
        iGeTC7BD9GIaeI/s9uCy7XWB3j/zPyIj7gZBrFYX/fHNiFqknlJPGWPoGmEUAl32
        6j8zO+XeosPE9/ZFfjXgR3glueRmMbWy+vKXtZX7TK0r62ag3mKArW+2m1I5hU49
        YML0bqBk3E2Mtm+l9B3I6ElpY6zkj6rcGvs2ZQczgkmjXNgbBrZHKXGR6RS4dUvg
        kceNlSqG/m8p3HcVV9xCONBBPgz/Kp0Fihf9GN08uug==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6IfElN6TPnhS for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 10:16:34 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4jHk4lgWzBJJjN;
        Tue, 18 Jul 2023 10:16:34 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 10:16:34 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dib8000: remove spaces after '*'
In-Reply-To: <20230718021448.15551-1-xujianghui@cdjrlc.com>
References: <20230718021448.15551-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <627723b2e55bfc71dfbb4e1fe2594521@208suo.com>
X-Sender: sunran001@208suo.com
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

Fix four occurrences of the checkpatch error:

ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/media/dvb-frontends/dib8000.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/dib8000.c 
b/drivers/media/dvb-frontends/dib8000.c
index 2abda7d1cb6e..43731167146f 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -3806,7 +3806,7 @@ static int dib8000_read_status(struct dvb_frontend 
*fe, enum fe_status *stat)
      return 0;
  }

-static int dib8000_read_ber(struct dvb_frontend *fe, u32 * ber)
+static int dib8000_read_ber(struct dvb_frontend *fe, u32 *ber)
  {
      struct dib8000_state *state = fe->demodulator_priv;

@@ -3820,7 +3820,7 @@ static int dib8000_read_ber(struct dvb_frontend 
*fe, u32 * ber)
      return 0;
  }

-static int dib8000_read_unc_blocks(struct dvb_frontend *fe, u32 * unc)
+static int dib8000_read_unc_blocks(struct dvb_frontend *fe, u32 *unc)
  {
      struct dib8000_state *state = fe->demodulator_priv;

@@ -3832,7 +3832,7 @@ static int dib8000_read_unc_blocks(struct 
dvb_frontend *fe, u32 * unc)
      return 0;
  }

-static int dib8000_read_signal_strength(struct dvb_frontend *fe, u16 * 
strength)
+static int dib8000_read_signal_strength(struct dvb_frontend *fe, u16 
*strength)
  {
      struct dib8000_state *state = fe->demodulator_priv;
      u8 index_frontend;
@@ -3888,7 +3888,7 @@ static u32 dib8000_get_snr(struct dvb_frontend 
*fe)
      return 0xffffffff;
  }

-static int dib8000_read_snr(struct dvb_frontend *fe, u16 * snr)
+static int dib8000_read_snr(struct dvb_frontend *fe, u16 *snr)
  {
      struct dib8000_state *state = fe->demodulator_priv;
      u8 index_frontend;
