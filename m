Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB7755FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGQKAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGQKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:00:46 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D846136
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:00:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4Hdj18mnzBR9sW
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:00:41 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689588040; x=1692180041; bh=czwbeW8H49F0gfKBw9D02MCpsic
        pEDfqhcKbVAk1Tqg=; b=lMTggVhZkGKxotJVftzW0pZh/Ef0jl9x9Z9FNedccUH
        vItyystMz/kADR829A3eyp5JlBqQxdDntLSIZ6c+ZYSIc54isFUvixAAowdpUJBr
        zra4t5Aor5IqT3lzbD5QIV78IXNKgsqYRDZzeBWmq1hzOmll7/bclcQv1Y/k5ql8
        1htV0pMTUx9z4bKeufTW3BeUK+Pjt2fHKrBnejsUU4tl++BlSoXmXtJqknwW64vi
        2Cg3S9KA0D4GbzyKRzjYCe+JtxpuhclYn9+6ZvjCYJSiszaR38Kj+IBbnO2a69OC
        o0qaeWhhwvGVMA0ZZMuncg4TSIPPSTW25AWIEeggv+w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1W9SFrqHgBFD for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 18:00:40 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4Hdh6T7NzBR7b5;
        Mon, 17 Jul 2023 18:00:40 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 18:00:40 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: stv0299: add missing spaces before '*' and remove
 spaces after '*'
In-Reply-To: <20230717095932.389-1-xujianghui@cdjrlc.com>
References: <20230717095932.389-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <006749faebbc8d727076152d7e9d1575@208suo.com>
X-Sender: sunran001@208suo.com
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

Add missing spaces to clear checkpatch errors.

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/media/dvb-frontends/stv0299.c | 28 +++++++++++++--------------
  1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/media/dvb-frontends/stv0299.c 
b/drivers/media/dvb-frontends/stv0299.c
index b5263a0ee5aa..f933928eb836 100644
--- a/drivers/media/dvb-frontends/stv0299.c
+++ b/drivers/media/dvb-frontends/stv0299.c
@@ -82,9 +82,9 @@ static int stv0299_writeregI (struct stv0299_state* 
state, u8 reg, u8 data)
      return (ret != 1) ? -EREMOTEIO : 0;
  }

-static int stv0299_write(struct dvb_frontend* fe, const u8 buf[], int 
len)
+static int stv0299_write(struct dvb_frontend *fe, const u8 buf[], int 
len)
  {
-    struct stv0299_state* state = fe->demodulator_priv;
+    struct stv0299_state *state = fe->demodulator_priv;

      if (len != 2)
          return -EINVAL;
@@ -92,7 +92,7 @@ static int stv0299_write(struct dvb_frontend* fe, 
const u8 buf[], int len)
      return stv0299_writeregI(state, buf[0], buf[1]);
  }

-static u8 stv0299_readreg (struct stv0299_state* state, u8 reg)
+static u8 stv0299_readreg (struct stv0299_state *state, u8 reg)
  {
      int ret;
      u8 b0 [] = { reg };
@@ -109,7 +109,7 @@ static u8 stv0299_readreg (struct stv0299_state* 
state, u8 reg)
      return b1[0];
  }

-static int stv0299_readregs (struct stv0299_state* state, u8 reg1, u8 
*b, u8 len)
+static int stv0299_readregs (struct stv0299_state *state, u8 reg1, u8 
*b, u8 len)
  {
      int ret;
      struct i2c_msg msg [] = { { .addr = state->config->demod_address, 
.flags = 0, .buf = &reg1, .len = 1 },
@@ -177,7 +177,7 @@ static enum fe_code_rate stv0299_get_fec(struct 
stv0299_state *state)
      return fec_tab [index];
  }

-static int stv0299_wait_diseqc_fifo (struct stv0299_state* state, int 
timeout)
+static int stv0299_wait_diseqc_fifo (struct stv0299_state *state, int 
timeout)
  {
      unsigned long start = jiffies;

@@ -194,7 +194,7 @@ static int stv0299_wait_diseqc_fifo (struct 
stv0299_state* state, int timeout)
      return 0;
  }

-static int stv0299_wait_diseqc_idle (struct stv0299_state* state, int 
timeout)
+static int stv0299_wait_diseqc_idle (struct stv0299_state *state, int 
timeout)
  {
      unsigned long start = jiffies;

@@ -211,9 +211,9 @@ static int stv0299_wait_diseqc_idle (struct 
stv0299_state* state, int timeout)
      return 0;
  }

-static int stv0299_set_symbolrate (struct dvb_frontend* fe, u32 srate)
+static int stv0299_set_symbolrate (struct dvb_frontend *fe, u32 srate)
  {
-    struct stv0299_state* state = fe->demodulator_priv;
+    struct stv0299_state *state = fe->demodulator_priv;
      u64 big = srate;
      u32 ratio;

@@ -229,7 +229,7 @@ static int stv0299_set_symbolrate (struct 
dvb_frontend* fe, u32 srate)
      return state->config->set_symbol_rate(fe, srate, ratio);
  }

-static int stv0299_get_symbolrate (struct stv0299_state* state)
+static int stv0299_get_symbolrate (struct stv0299_state *state)
  {
      u32 Mclk = state->config->mclk / 4096L;
      u32 srate;
@@ -261,10 +261,10 @@ static int stv0299_get_symbolrate (struct 
stv0299_state* state)
      return srate;
  }

-static int stv0299_send_diseqc_msg (struct dvb_frontend* fe,
+static int stv0299_send_diseqc_msg (struct dvb_frontend *fe,
                      struct dvb_diseqc_master_cmd *m)
  {
-    struct stv0299_state* state = fe->demodulator_priv;
+    struct stv0299_state *state = fe->demodulator_priv;
      u8 val;
      int i;

@@ -295,7 +295,7 @@ static int stv0299_send_diseqc_msg (struct 
dvb_frontend* fe,
  static int stv0299_send_diseqc_burst(struct dvb_frontend *fe,
                       enum fe_sec_mini_cmd burst)
  {
-    struct stv0299_state* state = fe->demodulator_priv;
+    struct stv0299_state *state = fe->demodulator_priv;
      u8 val;

      dprintk ("%s\n", __func__);
@@ -323,7 +323,7 @@ static int stv0299_send_diseqc_burst(struct 
dvb_frontend *fe,
  static int stv0299_set_tone(struct dvb_frontend *fe,
                  enum fe_sec_tone_mode tone)
  {
-    struct stv0299_state* state = fe->demodulator_priv;
+    struct stv0299_state *state = fe->demodulator_priv;
      u8 val;

      if (stv0299_wait_diseqc_idle (state, 100) < 0)
@@ -346,7 +346,7 @@ static int stv0299_set_tone(struct dvb_frontend *fe,
  static int stv0299_set_voltage(struct dvb_frontend *fe,
                     enum fe_sec_voltage voltage)
  {
-    struct stv0299_state* state = fe->demodulator_priv;
+    struct stv0299_state *state = fe->demodulator_priv;
      u8 reg0x08;
      u8 reg0x0c;
