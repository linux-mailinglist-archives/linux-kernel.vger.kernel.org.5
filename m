Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC884753515
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbjGNIcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjGNIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:32:25 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A2B2121
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:31:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2PpZ3M6tzBR9sl
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:31:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689323510; x=1691915511; bh=wUAz80Gh0Z0D/BGyRr/WcEoBCY9
        jnoASW6XecQdyeJs=; b=Ebbcb1BsZ9d9WEpvkHS7x3Drf5M6UgyzfBxXxwNdGrA
        DNcWKg13/EKvYRCUGS144wVDHNCyBMrRrEuV5R2lSopnojlSixjwr3duPK1XmU1r
        Zzw2klxO2OH+7Q/QYhmLLZ5FzuuEVE7i4bVMTJqShHDcyAut2kfR5nlKvZHQaUgS
        zsMeJ0CwnAKWHaacSELD+MqTK7efNXswwLHjJoeMnfB+2ScvCP8k6Vvw+TnpMgtu
        p7DX8cTkgBNpmyubihJjMu0g1IqHcTPIx+uFteEnopu92PmhUuzcEJLKflfWkqOJ
        JOsg3c17ILY6o2GiSBHjUzmGn8Z0JdklobiwW0eaphw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id siJhZdY-1Ie6 for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 16:31:50 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2PpZ1gYnzBR9sg;
        Fri, 14 Jul 2023 16:31:50 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 16:31:50 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb: add missing spaces before '*' and around '=',
 remove spaces after '*'
In-Reply-To: <20230714083042.14458-1-xujianghui@cdjrlc.com>
References: <20230714083042.14458-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <ef55095b44ab1d31a65f1c662f33b60f@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: "foo* bar" should be "foo *bar"
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/media/dvb-frontends/mt352.c | 69 ++++++++++++++---------------
  1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/media/dvb-frontends/mt352.c 
b/drivers/media/dvb-frontends/mt352.c
index 399d5c519027..457deff9a364 100644
--- a/drivers/media/dvb-frontends/mt352.c
+++ b/drivers/media/dvb-frontends/mt352.c
@@ -28,7 +28,7 @@
  #include "mt352.h"

  struct mt352_state {
-    struct i2c_adapter* i2c;
+    struct i2c_adapter *i2c;
      struct dvb_frontend frontend;

      /* configuration settings */
@@ -43,7 +43,7 @@ static int debug;

  static int mt352_single_write(struct dvb_frontend *fe, u8 reg, u8 val)
  {
-    struct mt352_state* state = fe->demodulator_priv;
+    struct mt352_state *state = fe->demodulator_priv;
      u8 buf[2] = { reg, val };
      struct i2c_msg msg = { .addr = state->config.demod_address, .flags 
= 0,
                     .buf = buf, .len = 2 };
@@ -55,22 +55,22 @@ static int mt352_single_write(struct dvb_frontend 
*fe, u8 reg, u8 val)
      return 0;
  }

-static int _mt352_write(struct dvb_frontend* fe, const u8 ibuf[], int 
ilen)
+static int _mt352_write(struct dvb_frontend *fe, const u8 ibuf[], int 
ilen)
  {
-    int err,i;
-    for (i=0; i < ilen-1; i++)
-        if ((err = mt352_single_write(fe,ibuf[0]+i,ibuf[i+1])))
+    int err, i;
+    for (i = 0; i < ilen-1; i++)
+        if ((err = mt352_single_write(fe, ibuf[0]+i, ibuf[i+1])))
              return err;

      return 0;
  }

-static int mt352_read_register(struct mt352_state* state, u8 reg)
+static int mt352_read_register(struct mt352_state *state, u8 reg)
  {
      int ret;
-    u8 b0 [] = { reg };
-    u8 b1 [] = { 0 };
-    struct i2c_msg msg [] = { { .addr = state->config.demod_address,
+    u8 b0[] = { reg };
+    u8 b1[] = { 0 };
+    struct i2c_msg msg[] = { { .addr = state->config.demod_address,
                      .flags = 0,
                      .buf = b0, .len = 1 },
                    { .addr = state->config.demod_address,
@@ -88,7 +88,7 @@ static int mt352_read_register(struct mt352_state* 
state, u8 reg)
      return b1[0];
  }

-static int mt352_sleep(struct dvb_frontend* fe)
+static int mt352_sleep(struct dvb_frontend *fe)
  {
      static u8 mt352_softdown[] = { CLOCK_CTL, 0x20, 0x08 };

@@ -96,12 +96,12 @@ static int mt352_sleep(struct dvb_frontend* fe)
      return 0;
  }

-static void mt352_calc_nominal_rate(struct mt352_state* state,
+static void mt352_calc_nominal_rate(struct mt352_state *state,
                      u32 bandwidth,
                      unsigned char *buf)
  {
      u32 adc_clock = 20480; /* 20.340 MHz */
-    u32 bw,value;
+    u32 bw, value;

      switch (bandwidth) {
      case 6000000:
@@ -126,12 +126,12 @@ static void mt352_calc_nominal_rate(struct 
mt352_state* state,
      buf[1] = lsb(value);
  }

-static void mt352_calc_input_freq(struct mt352_state* state,
+static void mt352_calc_input_freq(struct mt352_state *state,
                    unsigned char *buf)
  {
      int adc_clock = 20480; /* 20.480000 MHz */
      int if2       = 36167; /* 36.166667 MHz */
-    int ife,value;
+    int ife, value;

      if (state->config.adc_clock)
          adc_clock = state->config.adc_clock;
@@ -155,7 +155,7 @@ static void mt352_calc_input_freq(struct 
mt352_state* state,
  static int mt352_set_parameters(struct dvb_frontend *fe)
  {
      struct dtv_frontend_properties *op = &fe->dtv_property_cache;
-    struct mt352_state* state = fe->demodulator_priv;
+    struct mt352_state *state = fe->demodulator_priv;
      unsigned char buf[13];
      static unsigned char tuner_go[] = { 0x5d, 0x01 };
      static unsigned char fsm_go[]   = { 0x5e, 0x01 };
@@ -298,15 +298,14 @@ static int mt352_set_parameters(struct 
dvb_frontend *fe)
      return 0;
  }

-static int mt352_get_parameters(struct dvb_frontend* fe,
+static int mt352_get_parameters(struct dvb_frontend *fe,
                  struct dtv_frontend_properties *op)
  {
-    struct mt352_state* state = fe->demodulator_priv;
+    struct mt352_state *state = fe->demodulator_priv;
      u16 tps;
      u16 div;
      u8 trl;
-    static const u8 tps_fec_to_api[8] =
-    {
+    static const u8 tps_fec_to_api[8] = {
          FEC_1_2,
          FEC_2_3,
          FEC_3_4,
@@ -317,7 +316,7 @@ static int mt352_get_parameters(struct dvb_frontend* 
fe,
          FEC_AUTO
      };

-    if ( (mt352_read_register(state,0x00) & 0xC0) != 0xC0 )
+    if ( (mt352_read_register(state, 0x00) & 0xC0) != 0xC0)
          return -EINVAL;

      /* Use TPS_RECEIVED-registers, not the TPS_CURRENT-registers 
because
@@ -406,7 +405,7 @@ static int mt352_get_parameters(struct dvb_frontend* 
fe,

  static int mt352_read_status(struct dvb_frontend *fe, enum fe_status 
*status)
  {
-    struct mt352_state* state = fe->demodulator_priv;
+    struct mt352_state *state = fe->demodulator_priv;
      int s0, s1, s3;

      /* FIXME:
@@ -458,9 +457,9 @@ static int mt352_read_ber(struct dvb_frontend* fe, 
u32* ber)
      return 0;
  }

-static int mt352_read_signal_strength(struct dvb_frontend* fe, u16* 
strength)
+static int mt352_read_signal_strength(struct dvb_frontend *fe, u16 
*strength)
  {
-    struct mt352_state* state = fe->demodulator_priv;
+    struct mt352_state *state = fe->demodulator_priv;

      /* align the 12 bit AGC gain with the most significant bits */
      u16 signal = ((mt352_read_register(state, AGC_GAIN_1) & 0x0f) << 
12) |
@@ -471,9 +470,9 @@ static int mt352_read_signal_strength(struct 
dvb_frontend* fe, u16* strength)
      return 0;
  }

-static int mt352_read_snr(struct dvb_frontend* fe, u16* snr)
+static int mt352_read_snr(struct dvb_frontend *fe, u16 *snr)
  {
-    struct mt352_state* state = fe->demodulator_priv;
+    struct mt352_state *state = fe->demodulator_priv;

      u8 _snr = mt352_read_register (state, SNR);
      *snr = (_snr << 8) | _snr;
@@ -481,9 +480,9 @@ static int mt352_read_snr(struct dvb_frontend* fe, 
u16* snr)
      return 0;
  }

-static int mt352_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
+static int mt352_read_ucblocks(struct dvb_frontend *fe, u32 *ucblocks)
  {
-    struct mt352_state* state = fe->demodulator_priv;
+    struct mt352_state *state = fe->demodulator_priv;

      *ucblocks = (mt352_read_register (state,  RS_UBC_1) << 8) |
              (mt352_read_register (state,  RS_UBC_0));
@@ -491,7 +490,7 @@ static int mt352_read_ucblocks(struct dvb_frontend* 
fe, u32* ucblocks)
      return 0;
  }

-static int mt352_get_tune_settings(struct dvb_frontend* fe, struct 
dvb_frontend_tune_settings* fe_tune_settings)
+static int mt352_get_tune_settings(struct dvb_frontend *fe, struct 
dvb_frontend_tune_settings *fe_tune_settings)
  {
      fe_tune_settings->min_delay_ms = 800;
      fe_tune_settings->step_size = 0;
@@ -500,9 +499,9 @@ static int mt352_get_tune_settings(struct 
dvb_frontend* fe, struct dvb_frontend_
      return 0;
  }

-static int mt352_init(struct dvb_frontend* fe)
+static int mt352_init(struct dvb_frontend *fe)
  {
-    struct mt352_state* state = fe->demodulator_priv;
+    struct mt352_state *state = fe->demodulator_priv;

      static u8 mt352_reset_attach [] = { RESET, 0xC0 };

@@ -519,7 +518,7 @@ static int mt352_init(struct dvb_frontend* fe)
      return 0;
  }

-static void mt352_release(struct dvb_frontend* fe)
+static void mt352_release(struct dvb_frontend *fe)
  {
      struct mt352_state* state = fe->demodulator_priv;
      kfree(state);
@@ -527,10 +526,10 @@ static void mt352_release(struct dvb_frontend* fe)

  static const struct dvb_frontend_ops mt352_ops;

-struct dvb_frontend* mt352_attach(const struct mt352_config* config,
-                  struct i2c_adapter* i2c)
+struct dvb_frontend *mt352_attach(const struct mt352_config *config,
+                  struct i2c_adapter *i2c)
  {
-    struct mt352_state* state = NULL;
+    struct mt352_state *state = NULL;

      /* allocate memory for the internal state */
      state = kzalloc(sizeof(struct mt352_state), GFP_KERNEL);
