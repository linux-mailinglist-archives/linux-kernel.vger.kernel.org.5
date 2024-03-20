Return-Path: <linux-kernel+bounces-108808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094DD88104C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4E01F2342C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7B3B1B2;
	Wed, 20 Mar 2024 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asBgSqLB"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193C31CD1D;
	Wed, 20 Mar 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932106; cv=none; b=eRf+JSmCe27Zy6xfGJnWlHtp2XMD7o99/tl5AZDyJojji8NZLvDJDbJ3/uB/8E/5At7mXO/XoZFM/SgnPBjMUYkFzR57AP1JHuEPH+NVqd2EEp3J+mu5bZ9ckmZRO8UxHuVTkfmgdYFGDDtTh072/RYdeXcFlr7NauE8ifeiIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932106; c=relaxed/simple;
	bh=9MEx+/630x8YJHJEXTgrms3jD2HafETD4hjcSjPg2ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fuLogiFAG1PcTk+XtchEnGYIMDHiTTlRwq1TcCoIupgRJgpZfIVeLQKRQegC/aDl2gcHwNhSRZj32vf0lfDyBxnf2aGZn0nJGpFXcMSorJnrXk+XyaUHaBBJSViVpOeXJ4wtqUkK/8fdTn8ZbULDfAAKtASSACaN31jcVSYqsvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asBgSqLB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ececeb19eso3051096f8f.3;
        Wed, 20 Mar 2024 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710932102; x=1711536902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CojcT9cRLJ5Bl337jcNfU0rqx9pdOlMvmn0shABcZak=;
        b=asBgSqLBS5ztovkBpZJ8o/Pn0ABFzk59wyAKgejYtS+EKlD6/c13P5jnHsjeeIBc4U
         Ip44/jnkAvut1VPUdowJWl3Dvibn/8E3q3cwZGRHeEXMM59FkoQBZRBtaNWaDTSNSaCf
         +hgMvmgJ/V6eCTwRlisWCwqbsrpGBsRiylH/JdDc0ZJWv+UnE+ZW/4if8dqp8u7Bwfd1
         u70MqZA7SJ3Sf2WvfbWh+JgSKtTrSF+xxyG0g2gLUO3id6Kb6JIQ972vbd1KYAsNIQMY
         CHmvfKEfA9ZmK3R7xxkPmi8LrwPytrQrYfKctER/UurjVmWo9ExV1cLrSD1Uw1vDdG61
         FSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710932102; x=1711536902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CojcT9cRLJ5Bl337jcNfU0rqx9pdOlMvmn0shABcZak=;
        b=gENIp5OzYLTbYcl0t7fKu/oDy0gNvKFJXBXQzdkm4WYYLZLhj7MGjMnoKaXoa0vmQL
         jaq9QhpO/GhyRttVbNeI65cp6rCeGLXLBiBvmcZiJN3oR9QNyBUBaijJ4CWUMyLX8qxz
         Rai+Tg7Y4e7ZDOBnvAc37+MgC67joEYy7a304I2HQmD1hss1FiBoZ9tSeHxlHf7g9n1i
         5i+VX94m1MH/jMoPwxV0kNLiEsN9DBj5KMh0BFJfCEPFzH5WrAmpsJEOeXT95GHONs5X
         jWcWRSZhnGLAWFn5Gma5M1kiuFHvYI/+sXbWkJ3qR2dZAfwd3M93eCYBnhpjAbeerVp4
         5Z/w==
X-Forwarded-Encrypted: i=1; AJvYcCWB8SYL1hp9j3hh05H2nCgyH1t6jM2bsOSdGquldXUmfimjSG4KbDpoOHOzwqxkN2xdx25RFGJ905Dd9NloeFAvrYBiypqKdA/VrollE1pUOjDJMlBblj6LG6LPtkUWFWuOLqtGW0nf0PC0JfqRgiNmrd9u5oH6WgQO
X-Gm-Message-State: AOJu0YxjGD+ZII0ccPxHxr3am5ESZmY2TFpWTbfZshSc1eEOPOulxFNe
	qg8YxOO2vDM0cnd6agrAU3YSbmWh/Hq4cHjoIgwRa5A+edxvtKpH
X-Google-Smtp-Source: AGHT+IEy6JZfLQalCuFkIMrHkVu1a1n1fJ1XRhpe4sO2kek5wBWWMQRhG2cEIUkyFVaABlSMXiD/HA==
X-Received: by 2002:adf:f105:0:b0:33e:1e95:cac2 with SMTP id r5-20020adff105000000b0033e1e95cac2mr11207495wro.11.1710932102100;
        Wed, 20 Mar 2024 03:55:02 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bw11-20020a0560001f8b00b0033e7a204dc7sm3867731wrb.32.2024.03.20.03.55.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2024 03:55:01 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf] bpf: verifier: prevent userspace memory access
Date: Wed, 20 Mar 2024 10:54:36 +0000
Message-Id: <20240320105436.4781-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With BPF_PROBE_MEM, BPF allows de-referencing an untrusted pointer. To
thwart invalid memory accesses, the JITs add an exception table entry
for all such accesses. But in case the src_reg + offset overflows and
turns into a userspace address, the BPF program might read that memory if
the user has mapped it.

There are architectural features that prevent the kernel from accessing
userspace memory, like Privileged Access Never (PAN) on ARM64,
Supervisor Mode Access Prevention (SMAP) on x86-64, Supervisor User
Memory access (SUM) on RISC-V, etc. But BPF should not rely on the
existence of these features.

Make the verifier add guard instructions around such memory accesses and
skip the load if the address falls into the userspace region.

The JITs need to implement bpf_arch_uaddress_limit() to define where
the userspace addresses end for that architecture or TASK_SIZE is taken
as default.

The implementation is as follows:

REG_AX =  SRC_REG
if(offset)
	REG_AX += offset;
REG_AX >>= 32;
if (REG_AX <= (uaddress_limit >> 32))
	DST_REG = 0;
else
	DST_REG = *(size *)(SRC_REG + offset);

Comparing just the upper 32 bits of the load address with the upper
32 bits of uaddress_limit implies that the values are being aligned down
to a 4GB boundary before comparison.

The above means that all loads with address <= uaddress_limit + 4GB are
skipped. This is acceptable because there is a large hole (much larger
than 4GB) between userspace and kernel space memory, therefore a
correctly functioning BPF program should not access this 4GB memory
above the userspace.

Let's analyze what this patch does to the following fentry program
dereferencing an untrusted pointer:

  SEC("fentry/tcp_v4_connect")
  int BPF_PROG(fentry_tcp_v4_connect, struct sock *sk)
  {
                *(volatile long *)sk;
                return 0;
  }

    BPF Program before              |           BPF Program after
    ------------------              |           -----------------

  0: (79) r1 = *(u64 *)(r1 +0)          0: (79) r1 = *(u64 *)(r1 +0)
  -----------------------------------------------------------------------
  1: (79) r1 = *(u64 *)(r1 +0) --\      1: (bf) r11 = r1
  ----------------------------\   \     2: (77) r11 >>= 32
  2: (b7) r0 = 0               \   \    3: (b5) if r11 <= 0x8000 goto pc+2
  3: (95) exit                  \   \-> 4: (79) r1 = *(u64 *)(r1 +0)
                                 \      5: (05) goto pc+1
                                  \     6: (b7) r1 = 0
                                   \--------------------------------------
                                        7: (b7) r0 = 0
                                        8: (95) exit

As you can see from above, in the best case (off=0), 5 extra instructions
are emitted.

Now, we analyse the same program after it has gone through the JITs of
X86-64, ARM64, and RISC-V architectures. We follow the single load
instruction that has the untrusted pointer and see what instrumentation
has been added around it.

                                x86-64 JIT
                                ==========
     JIT's Instrumentation                  Verifier's Instrumentation
          (upstream)                               (This patch)
     ---------------------                  --------------------------

   0:   nopl   0x0(%rax,%rax,1)             0:   nopl   0x0(%rax,%rax,1)
   5:   xchg   %ax,%ax                      5:   xchg   %ax,%ax
   7:   push   %rbp                         7:   push   %rbp
   8:   mov    %rsp,%rbp                    8:   mov    %rsp,%rbp
   b:   mov    0x0(%rdi),%rdi               b:   mov    0x0(%rdi),%rdi
  ------------------------------------------------------------------------
   f:   movabs $0x800000000000,%r11         f:   mov    %rdi,%r10
  19:   cmp    %r11,%rdi                   12:   shr    $0x20,%r10
  1c:   jb     0x000000000000002a          16:   cmp    $0x8000,%r10
  1e:   mov    %rdi,%r11                   1d:   jbe    0x0000000000000025
  21:   add    $0x0,%r11              /--> 1f:   mov    0x0(%rdi),%rdi
  28:   jae    0x000000000000002e    /     23:   jmp    0x0000000000000027
  2a:   xor    %edi,%edi            /      25:   xor    %edi,%edi
  2c:   jmp    0x0000000000000032  / /------------------------------------
  2e:   mov    0x0(%rdi),%rdi  ---/ /      27:   xor    %eax,%eax
  ---------------------------------/       29:   leave
  32:   xor    %eax,%eax                   2a:   ret
  34:   leave
  35:   ret

The x86-64 JIT already emits some instructions to protect against user
memory access. The implementation in this patch leads to a smaller
number of instructions being emitted. In the worst case the JIT will
emit 9 extra instructions and this patch decreases it to 7.

                                  ARM64 JIT
                                  =========

        No Intrumentation                       Verifier's Instrumentation
           (upstream)                                  (This patch)
        -----------------                       --------------------------

   0:   add     x9, x30, #0x0                0:   add     x9, x30, #0x0
   4:   nop                                  4:   nop
   8:   paciasp                              8:   paciasp
   c:   stp     x29, x30, [sp, #-16]!        c:   stp     x29, x30, [sp, #-16]!
  10:   mov     x29, sp                     10:   mov     x29, sp
  14:   stp     x19, x20, [sp, #-16]!       14:   stp     x19, x20, [sp, #-16]!
  18:   stp     x21, x22, [sp, #-16]!       18:   stp     x21, x22, [sp, #-16]!
  1c:   stp     x25, x26, [sp, #-16]!       1c:   stp     x25, x26, [sp, #-16]!
  20:   stp     x27, x28, [sp, #-16]!       20:   stp     x27, x28, [sp, #-16]!
  24:   mov     x25, sp                     24:   mov     x25, sp
  28:   mov     x26, #0x0                   28:   mov     x26, #0x0
  2c:   sub     x27, x25, #0x0              2c:   sub     x27, x25, #0x0
  30:   sub     sp, sp, #0x0                30:   sub     sp, sp, #0x0
  34:   ldr     x0, [x0]                    34:   ldr     x0, [x0]
--------------------------------------------------------------------------------
  38:   ldr     x0, [x0] ----------\        38:   add     x9, x0, #0x0
-----------------------------------\\       3c:   lsr     x9, x9, #32
  3c:   mov     x7, #0x0            \\      40:   cmp     x9, #0x10, lsl #12
  40:   mov     sp, sp               \\     44:   b.ls    0x0000000000000050
  44:   ldp     x27, x28, [sp], #16   \\--> 48:   ldr     x0, [x0]
  48:   ldp     x25, x26, [sp], #16    \    4c:   b       0x0000000000000054
  4c:   ldp     x21, x22, [sp], #16     \   50:   mov     x0, #0x0
  50:   ldp     x19, x20, [sp], #16      \---------------------------------------
  54:   ldp     x29, x30, [sp], #16         54:   mov     x7, #0x0
  58:   add     x0, x7, #0x0                58:   mov     sp, sp
  5c:   autiasp                             5c:   ldp     x27, x28, [sp], #16
  60:   ret                                 60:   ldp     x25, x26, [sp], #16
  64:   nop                                 64:   ldp     x21, x22, [sp], #16
  68:   ldr     x10, 0x0000000000000070     68:   ldp     x19, x20, [sp], #16
  6c:   br      x10                         6c:   ldp     x29, x30, [sp], #16
                                            70:   add     x0, x7, #0x0
                                            74:   autiasp
                                            78:   ret
                                            7c:   nop
                                            80:   ldr     x10, 0x0000000000000088
                                            84:   br      x10

There are 6 extra instructions added in ARM64 in the best case. This will
become 7 in the worst case (off != 0).

                           RISC-V JIT (RISCV_ISA_C Disabled)
                           ==========

        No Intrumentation           Verifier's Instrumentation
           (upstream)                      (This patch)
        -----------------           --------------------------

   0:   nop                            0:   nop
   4:   nop                            4:   nop
   8:   li      a6, 33                 8:   li      a6, 33
   c:   addi    sp, sp, -16            c:   addi    sp, sp, -16
  10:   sd      s0, 8(sp)             10:   sd      s0, 8(sp)
  14:   addi    s0, sp, 16            14:   addi    s0, sp, 16
  18:   ld      a0, 0(a0)             18:   ld      a0, 0(a0)
---------------------------------------------------------------
  1c:   ld      a0, 0(a0) --\         1c:   mv      t0, a0
--------------------------\  \        20:   srli    t0, t0, 32
  20:   li      a5, 0      \  \       24:   lui     t1, 4096
  24:   ld      s0, 8(sp)   \  \      28:   sext.w  t1, t1
  28:   addi    sp, sp, 16   \  \     2c:   bgeu    t1, t0, 12
  2c:   sext.w  a0, a5        \  \--> 30:   ld      a0, 0(a0)
  30:   ret                    \      34:   j       8
                                \     38:   li      a0, 0
                                 \------------------------------
                                      3c:   li      a5, 0
                                      40:   ld      s0, 8(sp)
                                      44:   addi    sp, sp, 16
                                      48:   sext.w  a0, a5
                                      4c:   ret

There are 7 extra instructions added in RISC-V.

Fixes: 800834285361 ("bpf, arm64: Add BPF exception tables")
Reported-by: Breno Leitao <leitao@debian.org>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 72 +++++--------------------------------
 include/linux/filter.h      |  1 +
 kernel/bpf/core.c           |  9 +++++
 kernel/bpf/verifier.c       | 30 ++++++++++++++++
 4 files changed, 48 insertions(+), 64 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4900b1ee019f..9b3136187938 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1327,7 +1327,6 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 		u8 b2 = 0, b3 = 0;
 		u8 *start_of_ldx;
 		s64 jmp_offset;
-		s16 insn_off;
 		u8 jmp_cond;
 		u8 *func;
 		int nops;
@@ -1802,78 +1801,18 @@ st:			if (is_imm8(insn->off))
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
-			insn_off = insn->off;
-
-			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
-				/* Conservatively check that src_reg + insn->off is a kernel address:
-				 *   src_reg + insn->off >= TASK_SIZE_MAX + PAGE_SIZE
-				 * src_reg is used as scratch for src_reg += insn->off and restored
-				 * after emit_ldx if necessary
-				 */
-
-				u64 limit = TASK_SIZE_MAX + PAGE_SIZE;
-				u8 *end_of_jmp;
-
-				/* At end of these emitted checks, insn->off will have been added
-				 * to src_reg, so no need to do relative load with insn->off offset
-				 */
-				insn_off = 0;
-
-				/* movabsq r11, limit */
-				EMIT2(add_1mod(0x48, AUX_REG), add_1reg(0xB8, AUX_REG));
-				EMIT((u32)limit, 4);
-				EMIT(limit >> 32, 4);
-
-				if (insn->off) {
-					/* add src_reg, insn->off */
-					maybe_emit_1mod(&prog, src_reg, true);
-					EMIT2_off32(0x81, add_1reg(0xC0, src_reg), insn->off);
-				}
-
-				/* cmp src_reg, r11 */
-				maybe_emit_mod(&prog, src_reg, AUX_REG, true);
-				EMIT2(0x39, add_2reg(0xC0, src_reg, AUX_REG));
-
-				/* if unsigned '>=', goto load */
-				EMIT2(X86_JAE, 0);
-				end_of_jmp = prog;
-
-				/* xor dst_reg, dst_reg */
-				emit_mov_imm32(&prog, false, dst_reg, 0);
-				/* jmp byte_after_ldx */
-				EMIT2(0xEB, 0);
-
-				/* populate jmp_offset for JAE above to jump to start_of_ldx */
-				start_of_ldx = prog;
-				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
-			}
+			start_of_ldx = prog;
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
 			    BPF_MODE(insn->code) == BPF_MEMSX)
-				emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+				emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			else
-				emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+				emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
 				struct exception_table_entry *ex;
 				u8 *_insn = image + proglen + (start_of_ldx - temp);
 				s64 delta;
 
-				/* populate jmp_offset for JMP above */
-				start_of_ldx[-1] = prog - start_of_ldx;
-
-				if (insn->off && src_reg != dst_reg) {
-					/* sub src_reg, insn->off
-					 * Restore src_reg after "add src_reg, insn->off" in prev
-					 * if statement. But if src_reg == dst_reg, emit_ldx
-					 * above already clobbered src_reg, so no need to restore.
-					 * If add src_reg, insn->off was unnecessary, no need to
-					 * restore either.
-					 */
-					maybe_emit_1mod(&prog, src_reg, true);
-					EMIT2_off32(0x81, add_1reg(0xE8, src_reg), insn->off);
-				}
-
 				if (!bpf_prog->aux->extable)
 					break;
 
@@ -3473,3 +3412,8 @@ bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
 }
+
+u64 bpf_arch_uaddress_limit(void)
+{
+	return TASK_SIZE_MAX + PAGE_SIZE;
+}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index c0d51bff8f96..cf12bfa2a78c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -965,6 +965,7 @@ bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
+u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5aacb1d3c4cc..bb8024eacc31 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2958,6 +2958,15 @@ bool __weak bpf_jit_supports_arena(void)
 	return false;
 }
 
+u64 __weak bpf_arch_uaddress_limit(void)
+{
+#ifdef CONFIG_64BIT
+	return TASK_SIZE;
+#else
+	return -ENOTSUPP;
+#endif
+}
+
 /* Return TRUE if the JIT backend satisfies the following two conditions:
  * 1) JIT backend supports atomic_xchg() on pointer-sized words.
  * 2) Under the specific arch, the implementation of xchg() is the same
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de7813947981..6eb0d7643af1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19657,6 +19657,36 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+		/* Make it impossible to de-reference a userspace address */
+		if (BPF_CLASS(insn->code) == BPF_LDX &&
+		    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+		     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
+			struct bpf_insn *patch = &insn_buf[0];
+			u64 uaddress_limit = bpf_arch_uaddress_limit();
+
+			if (uaddress_limit < 0)
+				goto next_insn;
+
+			*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
+			if (insn->off)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, insn->off);
+			*patch++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 32);
+			*patch++ = BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, 2);
+			*patch++ = *insn;
+			*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+			*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
+
+			cnt = patch - insn_buf;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
 		/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
 		if (BPF_CLASS(insn->code) == BPF_LD &&
 		    (BPF_MODE(insn->code) == BPF_ABS ||
-- 
2.42.0


