Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DDE7D5F26
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjJYAoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYAoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:44:03 -0400
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F94E9F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1698194633;
        bh=UO/hFLLCVSGUQcpbxOQBk7OKmQn8mqkkoiQ7OUS4LCM=;
        h=Date:To:From:Subject;
        b=jUiSghDYShUvrcJK3ZI2J3c8rXJBudZT4flPwCA4qBmNI7ltVHQXy1fTUf8qi3OnE
         A0tCYw/hF36vO/QM3Kioh5ESJTrYQR0S9TDo9CfqsxMRWf28D5ToUb92H2880UO2jT
         SmqDnpiAdPpTIbx9zpVlxWTCBhZdGcgqw6hJIQZw=
Received: from [10.56.52.5] ([39.156.73.12])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id AF418868; Wed, 25 Oct 2023 08:43:52 +0800
X-QQ-mid: xmsmtpt1698194632tp7q4unq7
Message-ID: <tencent_6D116D0C3A84FEB2E02EED540C5F5B469309@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8ksfWJEg0tBWe+hLpcLpPEnKLAuWz7OTLg257AlBAqEWPNGD1R0
         1CFLH1RaDxd42UPYVn91UTsflPjAh4XOf8ROcHYqcC67HqmrXmke+5skhLxi9bW1p79IBjo1C65L
         ecoNBMDzQlWgjcX7MP/xw/VtjsCUoHWrJrX9MWnuoclrzxODyELh/N9eGJW9mdrzAKzE0jbSwLOJ
         fouwYB2TLVbh7syDLtJA76lZy7niZ68O7t/fL4WqDI0vhgb11UC1cO0h4MS3v/JSyBJ2FTLqu65R
         T0pYLT9dDEOZYPzKcjTc+DjDMSdkC0rQx2UrkUAp6pjQpg2fXDayuFZo7D98kPiZ+2NF3DBVM+Cn
         urjFOhn2gs0tOfzA2xz8O0L+Ou4p4BLg6LK/gWiF/UkeqB/dfw+IY4k1RVJimUYkrBfrjyg/UXE3
         MK7Q6znPHhHpr/9WLNm6tFo5TzIwzGzbVkzJya/fBp5M0A8aaWgOrYRlULuGPgt6eX3Edm30c2Z5
         o9ToPk3DjGFo8cWRAZLsgYETmQqGd/rlddpxSH7fjcIbNXQkJlOlHQxWG6agGxDfcIU/rcUgBwNo
         /yWjqmva/UDarFo5+spRWvXjMiAXW7GUD3iEN6c/+QyR7qVK+SC16FGolyrL8j1ITDoQfCEvCemk
         SIuoSeXaXFk0VlM907d7R5BYok8FWts3Y3WLFfxQeMhh1vaqMV8URK7P5IQZb82c2jWG0zat8R8k
         sfckrmZj3I3JIE6q5yCV1pPtLTVki/nixWHe+zn4Xrn6uot4Q8+NEM6O25cB/1dWy1HejNan3Fxg
         MU3onQXKv8+ls3WlGk7lEoDSTijMbXB3BWEib4ijk592rm9ItIPtEWxzjjMCaE0JpKl0d3SA2zUg
         HQ/Ie0B6O32Xqj+f67R2KjXNrZarFEm3bYKFVsTbg8d2w5ku60akgNrXogjzFMCAjo/SrYLDqv8S
         t+StogHQmwk22V3rG7Gx+WM/7hf05GhWnUkSEwOuzqhctzuLnOWreIayfGVNbqhrhvZVbLzULUez
         heptaR86nBtZ69xB+S
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <e2b302f9-5840-49e8-8176-c6c5ea725895@foxmail.com>
Date:   Wed, 25 Oct 2023 08:43:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     open list <linux-kernel@vger.kernel.org>, rtoax@foxmail.com,
        Rong Tao <rongtao@cestc.cn>
From:   Rong Tao <rtoax@foxmail.com>
Subject: [PATCH] stop_machine: pass curstate to ack_state()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multi_cpu_stop() state machine uses multi_stop_data::state to hold
the current state, and this is read and written atomically except in
ack_state(), which performs a non-atomic read.

As ack_state() only performs this non-atomic read when there is a single
writer, this is benign, but it makes reasoning about the state machine a
little harder.

Remove the non-atomic read and pass the (atomically read) curstate in
instead. This makes it clear that we do not expect any racy writes, and
avoids a redundant load.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
  kernel/stop_machine.c | 7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..268c2e581698 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -188,10 +188,11 @@ static void set_state(struct multi_stop_data *msdata,
  }

  /* Last one to ack a state moves to the next state. */
-static void ack_state(struct multi_stop_data *msdata)
+static void ack_state(struct multi_stop_data *msdata,
+              enum multi_stop_state curstate)
  {
      if (atomic_dec_and_test(&msdata->thread_ack))
-        set_state(msdata, msdata->state + 1);
+        set_state(msdata, curstate + 1);
  }

  notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
@@ -242,7 +243,7 @@ static int multi_cpu_stop(void *data)
              default:
                  break;
              }
-            ack_state(msdata);
+            ack_state(msdata, curstate);
          } else if (curstate > MULTI_STOP_PREPARE) {
              /*
               * At this stage all other CPUs we depend on must spin
-- 
2.42.0

