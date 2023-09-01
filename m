Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72F9790396
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbjIAWTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350784AbjIAWTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:19:22 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DDB3A97
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:19:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so43590281fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693606753; x=1694211553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V73CygJUTsaH3Qg0PMg0RLn8AC4bljovOrUH8Gozo0s=;
        b=JwiaKbYdjdS0E4d+sXwulYrrBjM8SIafkDW4T9LaYNxqlmR98DwdlLum8SPB7IR1ef
         kZk6W1ax30FROir2o725vguM4UdkksibljHqHoFjL6WLM7IUoml/cxyAnBjFAm8gHn2q
         rrUFPbKI5XrbYlPxwv6sYAK7VKfrZ7UGZ5her4Aio2IO4oasd/Qch2XSCW7gvBKqt1xh
         q1uBg0/Au7ZK2WM0wz+iMj6HVfeLOPzpj+9ZkCGUzUZTHtf9l8UDeGkYK1E6snEyT5sk
         D4q2enFKKjjZ3kmZqnhKevcvN7apQSBJwJXQq4rzmvLJwRG8mgyuTQvWxkBsbQe4nfqi
         cwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693606753; x=1694211553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V73CygJUTsaH3Qg0PMg0RLn8AC4bljovOrUH8Gozo0s=;
        b=EHGx6CEfBE5J6vmPBMfiD5G2cL+JFvG2cXcjVfnbO295tpSe1FB+Vb9axnFddAoYRw
         X40qg1psGHT9cEw8kw0dMXCbiUU9oGPNw/yjgUwsIP9+y4xwDsKM++QjHmuUu42aM9t2
         4AR0v31wNMj+tvbkRyVpExg61x8ifzddGpj0ehDrDB0SiuMf/BVkOeYqEHBgTX+2esXS
         jLyK0KwC9ovhHf1utdWDkIaXZdS3e8GCnMwv17LOpQXxWoq9xdvZwBQKXucUVzGDT7wE
         e7sqnCImH+KR7fUiQUMVYzNlWbDbpt4JdzwUd3Y+NzgoxoCKP49iz77eoMinSF7grZWi
         k4Bg==
X-Gm-Message-State: AOJu0Ywu5KvrSkjwgX4nW2du9J6yO+m7FKS/ypV01DfJ0mwsg99clIya
        wrBan3XBWPiYUfokdZcWX2WUBIOVwWY=
X-Google-Smtp-Source: AGHT+IG5PDFdK3BsX9onNRxvy0q/oioplcREolAiZdETZNeLTKgsDF8MGT/h4v07oaE8M2zYIZtqqg==
X-Received: by 2002:a2e:7403:0:b0:2b6:cdfb:d06a with SMTP id p3-20020a2e7403000000b002b6cdfbd06amr2404099ljc.22.1693606753049;
        Fri, 01 Sep 2023 15:19:13 -0700 (PDT)
Received: from shift (p200300d5ff37af00aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff37:af00:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906410900b0099bd5b72d93sm2550690ejk.43.2023.09.01.15.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 15:19:12 -0700 (PDT)
Received: from chuck by shift with local (Exim 4.96)
        (envelope-from <chuck@shift.daheim>)
        id 1qcCTw-001p5l-0C;
        Sat, 02 Sep 2023 00:19:12 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, seanjc@google.com, klaus.espenlaub@oracle.com,
        bp@alien8.de, glx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com
Subject: [PATCH  v1] x86/cpu/cacheinfo: fix panic on Ryzen Mobile 7x40 series in VBox VM
Date:   Sat,  2 Sep 2023 00:19:11 +0200
Message-Id: <652989ad8a7f110bad16cf1244c4c68a823f0afe.1693606609.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryzen Mobile 7x40 chips experience an early kernel fault
(division by zero) due to nonexistent input validation
from CPUID data in amd_cpuid4().

This error was first reported on reddit [0] for a
"AMD Ryzen 9 7940HS w/ Radeon 780M Graphics", but since then
the bug has been reproduced on a "AMD Ryzen 7 7840HS" Laptop
too.

That user reported the following dump:

| divide error: 0000 [#1] PREEMPT SMP NOPTI
| CPU: 0 PID: 19 Comm: cpuhp/0 Not tainted 5.19.0-46-gen [...]
| Hardware name: innotek GmbH VirtualBox/VirtualBox, [...]
| RIP: 0010:amd_cpuid4+0x195/0x2f0
| Code: c1 e0 0a 81 e3 ff 03 00 00 81 e2 ff 0f 00 00 [..]
| RSP: 0018:ffffbb78800a3ce8 EFLAGS: 00010246
| RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
| RDX: 0000000000000000 RSI: 0000000000000400 RDI: ffffbb78800a3d60
| RBP: ffffbb78800a3d48 R08: 0000000000000000 R09: 0000000000000000
| R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
| R13: ffffbb78800a3d08 R14: ffffbb78800a3d58 R15: ffffbb78800a3d5c
| FS: 0000000000000000(0000) GS:ffffa05759a00000(0000) knlGS:0[...]
| CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| CR2: 00007f2946fc1e24 CR3: 0000000108010000 CR4: 00000000000506f0
| Call Trace:
|  <TASK>
|  cpuid4_cache_lookup_regs+0x14d/0x160
|  populate_cache_leaves+0x180/0x200
|  cacheinfo_cpu_online+0xc1/0x1c0
|[...]

The error points to a divide by zero in amd_cpuid4() in this line:

|arch/x86/kernel/cpu/cacheinfo.c:
| ecx->split.number_of_sets = (size_in_kb * 1024) / line_size /
|		(ebx->split.ways_of_associativity + 1) - 1;

the culprit here is "line_size" (it's reading "0").

The reason why this is happening is because the Ryzen CPU reports in its
CPUID 80000006 edx register (which contains the L3 Cache Information)
the value "00009000". This magic value means according to AMD's
"AMD64 Architecture Programmer's Manual Volume 3" Table E-4.
"L2/L3 Cache and TLB Associativity Field Encoding":

| Value for all fields should be determinded from Fn8000_001D.

(This means to look in cpuid(0x8000001D,...) instead.)

So, amd_cpuid4() is missing this special case. A case which has been
present - according to this AMD Community post [1] - since
Zen 2/Ryzen 3000 Series.

But wait, why is this only happening with Linux' when running under
VirtualBox with these Ryzen Mobile CPUs and not when running natively?

Well VirtualBox should be able to sanitize the CPU Feature flags or
even emulate another CPU, right?. So it does not set the
X86_FEATURE_TOPOEXT feature and as a result, cpuid4_cache_lookup_regs()
takes the fatal de-tour through amd_cpuid4():

| arch/x86/kernel/cpu/cacheinfo.c:
|	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
|		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
|			cpuid_count(0x8000001d, index, &eax.full,
|				    &ebx.full, &ecx.full, &edx);
|		else
|			amd_cpuid4(index, &eax, &ebx, &ecx);
|		amd_init_l3_cache(this_leaf, index);
|	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {

Now, from what I can tell the VirtualBox devs are already working on this.
Kudos to Klaus! However, I think that amd_cpuid4() should not be crashing
regardless.

To this end, I propose the following change that amd_cpuid4() falls
back to "what the doctor ordered" (i.e. get the cpuid(0x8000001D)
values) rather than use bogus values or skip the detection.

But this still leaves the code vulnerable to other cpuid values
shenanigans... Is there already an consensus on how CPUID data should
be check/sanitized? Because I bet more peculiarities could be found
once syzbot learns to fuzz CPUID.

[0] <https://www.reddit.com/r/linuxhardware/comments/161h0lc/issues_with_ubuntu_vm_on_virtualbox_7010_inside/>
[1] <https://community.amd.com/t5/processors/ryzen-7-3700x-cpuid-function-id-0x80000006-returns-wrong-number/td-p/376937>

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
Previous thread: (layout/mail got butchered by my own stupidity)
https://lore.kernel.org/lkml/89fad050-e074-463e-8c27-a72b89de620c@gmail.com/

... I would of course welcome some discussion how to deal with cpuid.
Sean Christopherson already brought the idea of zeroing out the bogus
data on the table. And yes, I do think this would be working as well
(since amd_cpuid4() already checks for that).

But, how do >you< think this should be dealt with, or is it "don't care"?

Finally: Are you a VirtualBox user with an Ryzen Zen 4 Mobile and
are affected by this division by 0? Well try:

vboxmanage setextradata $VM VBoxInternal/CPUM/HostCPUID/80000006/edx 0x02009140
(Where $VM is the target VM. Then just start the VM again, it just
should now run).

(That 0x02009140 is what a Ryzen 9 7950X uses. While these values are
somewhat bogus too, at least the VM should boot... And should be "fine"
for the vast vast use-cases out there)

Or do you want to test this patch and emulate the 7x40 Mobile misbehaving?
You probably need an AMD CPU and just set this:

vboxmanage setextradata $VM VBoxInternal/CPUM/HostCPUID/80000006/edx 0x00009000
(This way you can see how this patch handles the situation and how kernel
without the patch just crash.)
---
 arch/x86/kernel/cpu/cacheinfo.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 8f86eacf69f7..96b3fadc384b 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -284,6 +284,29 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	case 3:
 		if (!l3.val)
 			return;
+
+		/*
+		 * AMD's "AMD64 Architecture Programmer's Manual Volume 3" states in
+		 * "Appendix E.4.5 Function 8000_0006h - L2 Cache and L3 Cache Information"
+		 * under Table E-4 "L2/L3 Cache and TLB Associativity Field Encoding"
+		 *
+		 * that a magic value of "9" means:
+		 * "Value for all fields should be determined from Fn8000_001D."
+		 * (this means that the cpuid(0x8000001d) should be used instead).
+		 */
+		if (l3.assoc == 9) {
+			/*
+			 * As a result, stop any further processing since the values
+			 * could be wrong/misleading/missing.
+			 *
+			 */
+
+			pr_warn("Falling back to recommended L3 Cache Information values.");
+			cpuid_count(0x8000001d, leaf, &eax->full, &ebx->full, &ecx->full, &dummy);
+
+			return;
+		}
+
 		assoc = assocs[l3.assoc];
 		line_size = l3.line_size;
 		lines_per_tag = l3.lines_per_tag;
-- 
2.40.1

