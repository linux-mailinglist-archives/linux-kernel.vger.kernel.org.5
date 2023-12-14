Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B568127F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjLNG2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjLNG2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:28:36 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9669B7;
        Wed, 13 Dec 2023 22:28:42 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id 006d021491bc7-59064bca27dso4533860eaf.0;
        Wed, 13 Dec 2023 22:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702535322; x=1703140122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFZu36W523M/IjZJ0zLsPRUfcorscyCpKb4i2bBi7JM=;
        b=FaKSQrntyhylXGsU79tD73+19BuO7Vvk0fBFqzegmI+sHDskW7+1qTK+EzLpTotLD+
         gxRFnMmOmoNgGiVP4HWmF3LF1+B/Sk4GRB528KPcgrpx31UFe4Y8ez5V+Ni3BqKrEKjN
         UMVznNg0mMaCNmTBD/5ruOuqNZPA6kU4FC/VQKVAWtnD7qWW8Gn3ssPJlmmgxqXhsZEM
         ViBm64hEWJOPdAKL3vK4M3VNvkzkhCmPOIntwTKjxORx6Hw1KaRrA81+eHU/OrSbvBzL
         dH041L6B/cTY6NVo/g4dTTkMFysOZazywhKp+6utPMkL6rpmS6/0iKFNnLV8ha/59n4J
         WB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702535322; x=1703140122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFZu36W523M/IjZJ0zLsPRUfcorscyCpKb4i2bBi7JM=;
        b=mLnjzbNNSpL1Hd7AIx68VMzea8MW/x2KmQaajv3575go5lpv7d5jZdZ7+woVOHuGV4
         lgSkO96bOCpY5K3tlvXpEDwoB3nSSzClieWrezA8sCvi79z4grO7xrUEhmKXNktG0IzF
         UnY8zvqYJ8Cbn2I6+9MDpCsXC/sYsrLyvsp0Po289NJPwqRqnQQB9auWWLFsaB3uUTJX
         Q7PBErWM5vjWUkg7Oc1jLBMeyBZrSbwz/Z2bOXaCGqUvancHUVMnHUgAvTBmmhVTaKpr
         czKQxCYYyRdgdvB8Z39JfxTMI9ZZdaZV5LPwDsWplAFT01OmmCer6DmMOm2ERqevkGUo
         HA4Q==
X-Gm-Message-State: AOJu0YymEH2zbzli3zg1wxA076GvR3kjevE/JWk0wRMeQIcGg1tV40/+
        vzuo4MFZ5NzrqJCG/ZIUnjc=
X-Google-Smtp-Source: AGHT+IH0Z8oklLoVwtqKng7fBpjEZuvK/ZBwtCGGOrBiqwXrujJe7Gm0MThqe/H5X7eJfEBPY6LK+g==
X-Received: by 2002:a05:6358:9209:b0:170:1d30:56e0 with SMTP id d9-20020a056358920900b001701d3056e0mr10361590rwb.30.1702535321817;
        Wed, 13 Dec 2023 22:28:41 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e107000000b005af08f65227sm10744770pgh.80.2023.12.13.22.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:28:41 -0800 (PST)
From:   Menglong Dong <menglong8.dong@gmail.com>
To:     andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: make the verifier tracks the "not equal" for regs
Date:   Thu, 14 Dec 2023 14:24:33 +0800
Message-Id: <20231214062434.3565630-2-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214062434.3565630-1-menglong8.dong@gmail.com>
References: <20231214062434.3565630-1-menglong8.dong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can derive some new information for BPF_JNE in regs_refine_cond_op().
Take following code for example:

  /* The type of "a" is u16 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
v2:
- fix a typo in the subject
- add some comments, as Eduard advised
---
 kernel/bpf/verifier.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 727a59e4a647..9b1932e51823 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14332,7 +14332,43 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		}
 		break;
 	case BPF_JNE:
-		/* we don't derive any new information for inequality yet */
+		if (!is_reg_const(reg2, is_jmp32))
+			swap(reg1, reg2);
+		if (!is_reg_const(reg2, is_jmp32))
+			break;
+
+		/* try to recompute the bound of reg1 if reg2 is a const and
+		 * is exactly the edge of reg1.
+		 */
+		val = reg_const_value(reg2, is_jmp32);
+		if (is_jmp32) {
+			/* u32_min_value is not equal to 0xffffffff at this point,
+			 * because otherwise u32_max_value is 0xffffffff as well,
+			 * in such a case both reg1 and reg2 would be constants,
+			 * jump would be predicted and reg_set_min_max() won't
+			 * be called.
+			 *
+			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
+			 * below.
+			 */
+			if (reg1->u32_min_value == (u32)val)
+				reg1->u32_min_value++;
+			if (reg1->u32_max_value == (u32)val)
+				reg1->u32_max_value--;
+			if (reg1->s32_min_value == (s32)val)
+				reg1->s32_min_value++;
+			if (reg1->s32_max_value == (s32)val)
+				reg1->s32_max_value--;
+		} else {
+			if (reg1->umin_value == (u64)val)
+				reg1->umin_value++;
+			if (reg1->umax_value == (u64)val)
+				reg1->umax_value--;
+			if (reg1->smin_value == (s64)val)
+				reg1->smin_value++;
+			if (reg1->smax_value == (s64)val)
+				reg1->smax_value--;
+		}
 		break;
 	case BPF_JSET:
 		if (!is_reg_const(reg2, is_jmp32))
-- 
2.39.2

