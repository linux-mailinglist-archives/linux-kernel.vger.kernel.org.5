Return-Path: <linux-kernel+bounces-2340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB842815B46
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4D61C21925
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40731A94;
	Sat, 16 Dec 2023 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djt96kAK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E931A79;
	Sat, 16 Dec 2023 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc64629c16so4032441fa.3;
        Sat, 16 Dec 2023 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702754577; x=1703359377; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S98oFBI0UUJ9P0Z4cRUxVK2bTst+J8s4cNfMbl4bb5M=;
        b=djt96kAKmtQNizo4kauZ6mNVcX5UcYmb9yGgPAYqpi/3bvoSFQ2cAIMIHPq+Inbhzs
         zqAkVn7kVm6XFETjo6oAAXL/lmi/pUfq+R5Y86JPl2W8S96uWBqjFduvs6arJ1MW4/Yo
         nAd3wZjQhK8OkCnQGugqmamHoR+WqBu+ReF1EdTBirNv7FrXaIJ/yscpfx4D7BbyXvUm
         PEl6VLm8Ovo9pbdF1QF0gvsh2O/pVxBuluazokXVvw7YZLHYlGNCvjZXn1JNff/PRmJw
         6MevdnCod4BbaIXLiex9KwDBsm4QbZieft6+WOrsNt8Uim2VO5f9SVuDbpkjl2HHiuYa
         FxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702754577; x=1703359377;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S98oFBI0UUJ9P0Z4cRUxVK2bTst+J8s4cNfMbl4bb5M=;
        b=QrcMr/fRg7+cNFI87z4uX3LOlzsKYlcdrj9fCeM+vmYZOgmnaHDR74K9BgFeuGhKUh
         SOufzLoo7F5wUNgKwfhnuQthnl27LwfcEmlbIfCHHwbeIcxUr5mqVTbV4Ktj/QtR71mZ
         Z0HDlh+dBPb4rgdSjjLLSD+jKdUZUVyQpRSqZSDom8B64t7pZ/E0WH/29Yu/NVqcVoNK
         DAmd8UEs7W5ayHjDWvUiWgWLsMoO/LfqHasDwBIN86RrGn25jpJAQnOpWOj13PsfS4yV
         EX0Xh3eAEA0HqbFNXMKU93cgNDMAZv+4KCAOL8tQRqlmQiTRZkYjcVcrawVy6qZao3NH
         Garg==
X-Gm-Message-State: AOJu0YwHxFzcC0qo8K6GBw/CUqnQPSDt6Qkr7LYRd6g7BmYSrJDc50i+
	Co68nhvnJ8NB8wtmPl1tmpfT83s2w5kI2RfuKLk=
X-Google-Smtp-Source: AGHT+IF5N+ecoo8HJF71vvWhHBV/IDlO3/FBvblZbZAMRFSk5fii5+8KmBNsgId2d/zNfbKo/vEYelr8PGf48flyIyI=
X-Received: by 2002:a2e:bea9:0:b0:2cb:2846:63b6 with SMTP id
 a41-20020a2ebea9000000b002cb284663b6mr6456151ljr.0.1702754576967; Sat, 16 Dec
 2023 11:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Samuel Marks <samuelmarks@gmail.com>
Date: Sat, 16 Dec 2023 14:22:46 -0500
Message-ID: <CAMfPbcbUD_29FihCpePpKOdJUAAw5XE_ciDAb6Lf_XcDU0JKRQ@mail.gmail.com>
Subject: PATCH [netfilter] Remove old case sensitive variants of lowercase .c
 and .h files
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

---
`git clone` fails on case-insensitive file systems, e.g., on Windows,
MSYS, Cygwin due to case sensitive files. All but one are in
netfilter, and they seem to be old code that isn't necessary.

 include/uapi/linux/netfilter/xt_CONNMARK.h  |   7 -
 include/uapi/linux/netfilter/xt_DSCP.h      |  27 --
 include/uapi/linux/netfilter/xt_MARK.h      |   7 -
 include/uapi/linux/netfilter/xt_RATEEST.h   |  17 -
 include/uapi/linux/netfilter/xt_TCPMSS.h    |  13 -
 include/uapi/linux/netfilter_ipv4/ipt_ECN.h |  34 --
 include/uapi/linux/netfilter_ipv4/ipt_TTL.h |  24 --
 include/uapi/linux/netfilter_ipv6/ip6t_HL.h |  25 --
 net/netfilter/Makefile                      |   4 -
 net/netfilter/xt_DSCP.c                     | 161 ---------
 net/netfilter/xt_HL.c                       | 159 ---------
 net/netfilter/xt_RATEEST.c                  | 233 -------------
 net/netfilter/xt_TCPMSS.c                   | 345 --------------------
 13 files changed, 1056 deletions(-)
 delete mode 100644 include/uapi/linux/netfilter/xt_CONNMARK.h
 delete mode 100644 include/uapi/linux/netfilter/xt_DSCP.h
 delete mode 100644 include/uapi/linux/netfilter/xt_MARK.h
 delete mode 100644 include/uapi/linux/netfilter/xt_RATEEST.h
 delete mode 100644 include/uapi/linux/netfilter/xt_TCPMSS.h
 delete mode 100644 include/uapi/linux/netfilter_ipv4/ipt_ECN.h
 delete mode 100644 include/uapi/linux/netfilter_ipv4/ipt_TTL.h
 delete mode 100644 include/uapi/linux/netfilter_ipv6/ip6t_HL.h
 delete mode 100644 net/netfilter/xt_DSCP.c
 delete mode 100644 net/netfilter/xt_HL.c
 delete mode 100644 net/netfilter/xt_RATEEST.c
 delete mode 100644 net/netfilter/xt_TCPMSS.c

diff --git a/include/uapi/linux/netfilter/xt_CONNMARK.h
b/include/uapi/linux/netfilter/xt_CONNMARK.h
deleted file mode 100644
index 36cc956ea..000000000
--- a/include/uapi/linux/netfilter/xt_CONNMARK.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _XT_CONNMARK_H_target
-#define _XT_CONNMARK_H_target
-
-#include <linux/netfilter/xt_connmark.h>
-
-#endif /*_XT_CONNMARK_H_target*/
diff --git a/include/uapi/linux/netfilter/xt_DSCP.h
b/include/uapi/linux/netfilter/xt_DSCP.h
deleted file mode 100644
index 223d635e8..000000000
--- a/include/uapi/linux/netfilter/xt_DSCP.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* x_tables module for setting the IPv4/IPv6 DSCP field
- *
- * (C) 2002 Harald Welte <laforge@gnumonks.org>
- * based on ipt_FTOS.c (C) 2000 by Matthew G. Marsh <mgm@paktronix.com>
- * This software is distributed under GNU GPL v2, 1991
- *
- * See RFC2474 for a description of the DSCP field within the IP Header.
- *
- * xt_DSCP.h,v 1.7 2002/03/14 12:03:13 laforge Exp
-*/
-#ifndef _XT_DSCP_TARGET_H
-#define _XT_DSCP_TARGET_H
-#include <linux/netfilter/xt_dscp.h>
-#include <linux/types.h>
-
-/* target info */
-struct xt_DSCP_info {
-    __u8 dscp;
-};
-
-struct xt_tos_target_info {
-    __u8 tos_value;
-    __u8 tos_mask;
-};
-
-#endif /* _XT_DSCP_TARGET_H */
diff --git a/include/uapi/linux/netfilter/xt_MARK.h
b/include/uapi/linux/netfilter/xt_MARK.h
deleted file mode 100644
index f1fe2b4be..000000000
--- a/include/uapi/linux/netfilter/xt_MARK.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _XT_MARK_H_target
-#define _XT_MARK_H_target
-
-#include <linux/netfilter/xt_mark.h>
-
-#endif /*_XT_MARK_H_target */
diff --git a/include/uapi/linux/netfilter/xt_RATEEST.h
b/include/uapi/linux/netfilter/xt_RATEEST.h
deleted file mode 100644
index 2b87a71e6..000000000
--- a/include/uapi/linux/netfilter/xt_RATEEST.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _XT_RATEEST_TARGET_H
-#define _XT_RATEEST_TARGET_H
-
-#include <linux/types.h>
-#include <linux/if.h>
-
-struct xt_rateest_target_info {
-    char            name[IFNAMSIZ];
-    __s8            interval;
-    __u8        ewma_log;
-
-    /* Used internally by the kernel */
-    struct xt_rateest    *est __attribute__((aligned(8)));
-};
-
-#endif /* _XT_RATEEST_TARGET_H */
diff --git a/include/uapi/linux/netfilter/xt_TCPMSS.h
b/include/uapi/linux/netfilter/xt_TCPMSS.h
deleted file mode 100644
index 65ea6c9da..000000000
--- a/include/uapi/linux/netfilter/xt_TCPMSS.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _XT_TCPMSS_H
-#define _XT_TCPMSS_H
-
-#include <linux/types.h>
-
-struct xt_tcpmss_info {
-    __u16 mss;
-};
-
-#define XT_TCPMSS_CLAMP_PMTU 0xffff
-
-#endif /* _XT_TCPMSS_H */
diff --git a/include/uapi/linux/netfilter_ipv4/ipt_ECN.h
b/include/uapi/linux/netfilter_ipv4/ipt_ECN.h
deleted file mode 100644
index e3630fd04..000000000
--- a/include/uapi/linux/netfilter_ipv4/ipt_ECN.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* Header file for iptables ipt_ECN target
- *
- * (C) 2002 by Harald Welte <laforge@gnumonks.org>
- *
- * This software is distributed under GNU GPL v2, 1991
- *
- * ipt_ECN.h,v 1.3 2002/05/29 12:17:40 laforge Exp
-*/
-#ifndef _IPT_ECN_TARGET_H
-#define _IPT_ECN_TARGET_H
-
-#include <linux/types.h>
-#include <linux/netfilter/xt_DSCP.h>
-
-#define IPT_ECN_IP_MASK    (~XT_DSCP_MASK)
-
-#define IPT_ECN_OP_SET_IP    0x01    /* set ECN bits of IPv4 header */
-#define IPT_ECN_OP_SET_ECE    0x10    /* set ECE bit of TCP header */
-#define IPT_ECN_OP_SET_CWR    0x20    /* set CWR bit of TCP header */
-
-#define IPT_ECN_OP_MASK        0xce
-
-struct ipt_ECN_info {
-    __u8 operation;    /* bitset of operations */
-    __u8 ip_ect;    /* ECT codepoint of IPv4 header, pre-shifted */
-    union {
-        struct {
-            __u8 ece:1, cwr:1; /* TCP ECT bits */
-        } tcp;
-    } proto;
-};
-
-#endif /* _IPT_ECN_TARGET_H */
diff --git a/include/uapi/linux/netfilter_ipv4/ipt_TTL.h
b/include/uapi/linux/netfilter_ipv4/ipt_TTL.h
deleted file mode 100644
index 57d2fc67a..000000000
--- a/include/uapi/linux/netfilter_ipv4/ipt_TTL.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* TTL modification module for IP tables
- * (C) 2000 by Harald Welte <laforge@netfilter.org> */
-
-#ifndef _IPT_TTL_H
-#define _IPT_TTL_H
-
-#include <linux/types.h>
-
-enum {
-    IPT_TTL_SET = 0,
-    IPT_TTL_INC,
-    IPT_TTL_DEC
-};
-
-#define IPT_TTL_MAXMODE    IPT_TTL_DEC
-
-struct ipt_TTL_info {
-    __u8    mode;
-    __u8    ttl;
-};
-
-
-#endif
diff --git a/include/uapi/linux/netfilter_ipv6/ip6t_HL.h
b/include/uapi/linux/netfilter_ipv6/ip6t_HL.h
deleted file mode 100644
index eaed56a28..000000000
--- a/include/uapi/linux/netfilter_ipv6/ip6t_HL.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* Hop Limit modification module for ip6tables
- * Maciej Soltysiak <solt@dns.toxicfilms.tv>
- * Based on HW's TTL module */
-
-#ifndef _IP6T_HL_H
-#define _IP6T_HL_H
-
-#include <linux/types.h>
-
-enum {
-    IP6T_HL_SET = 0,
-    IP6T_HL_INC,
-    IP6T_HL_DEC
-};
-
-#define IP6T_HL_MAXMODE    IP6T_HL_DEC
-
-struct ip6t_HL_info {
-    __u8    mode;
-    __u8    hop_limit;
-};
-
-
-#endif
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index d4958e7e7..a7f8ffeb0 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -162,20 +162,16 @@ obj-$(CONFIG_NETFILTER_XT_TARGET_CHECKSUM) +=
xt_CHECKSUM.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_CLASSIFY) += xt_CLASSIFY.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_CONNSECMARK) += xt_CONNSECMARK.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_CT) += xt_CT.o
-obj-$(CONFIG_NETFILTER_XT_TARGET_DSCP) += xt_DSCP.o
-obj-$(CONFIG_NETFILTER_XT_TARGET_HL) += xt_HL.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_HMARK) += xt_HMARK.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_LED) += xt_LED.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_LOG) += xt_LOG.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_NETMAP) += xt_NETMAP.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_NFLOG) += xt_NFLOG.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_NFQUEUE) += xt_NFQUEUE.o
-obj-$(CONFIG_NETFILTER_XT_TARGET_RATEEST) += xt_RATEEST.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_REDIRECT) += xt_REDIRECT.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_MASQUERADE) += xt_MASQUERADE.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_SECMARK) += xt_SECMARK.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_TPROXY) += xt_TPROXY.o
-obj-$(CONFIG_NETFILTER_XT_TARGET_TCPMSS) += xt_TCPMSS.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP) += xt_TCPOPTSTRIP.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_TEE) += xt_TEE.o
 obj-$(CONFIG_NETFILTER_XT_TARGET_TRACE) += xt_TRACE.o
diff --git a/net/netfilter/xt_DSCP.c b/net/netfilter/xt_DSCP.c
deleted file mode 100644
index cfa44515a..000000000
--- a/net/netfilter/xt_DSCP.c
+++ /dev/null
@@ -1,161 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* x_tables module for setting the IPv4/IPv6 DSCP field, Version 1.8
- *
- * (C) 2002 by Harald Welte <laforge@netfilter.org>
- * based on ipt_FTOS.c (C) 2000 by Matthew G. Marsh <mgm@paktronix.com>
- *
- * See RFC2474 for a description of the DSCP field within the IP Header.
-*/
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <net/dsfield.h>
-
-#include <linux/netfilter/x_tables.h>
-#include <linux/netfilter/xt_DSCP.h>
-
-MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
-MODULE_DESCRIPTION("Xtables: DSCP/TOS field modification");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("ipt_DSCP");
-MODULE_ALIAS("ip6t_DSCP");
-MODULE_ALIAS("ipt_TOS");
-MODULE_ALIAS("ip6t_TOS");
-
-#define XT_DSCP_ECN_MASK    3u
-
-static unsigned int
-dscp_tg(struct sk_buff *skb, const struct xt_action_param *par)
-{
-    const struct xt_DSCP_info *dinfo = par->targinfo;
-    u_int8_t dscp = ipv4_get_dsfield(ip_hdr(skb)) >> XT_DSCP_SHIFT;
-
-    if (dscp != dinfo->dscp) {
-        if (skb_ensure_writable(skb, sizeof(struct iphdr)))
-            return NF_DROP;
-
-        ipv4_change_dsfield(ip_hdr(skb), XT_DSCP_ECN_MASK,
-                    dinfo->dscp << XT_DSCP_SHIFT);
-
-    }
-    return XT_CONTINUE;
-}
-
-static unsigned int
-dscp_tg6(struct sk_buff *skb, const struct xt_action_param *par)
-{
-    const struct xt_DSCP_info *dinfo = par->targinfo;
-    u_int8_t dscp = ipv6_get_dsfield(ipv6_hdr(skb)) >> XT_DSCP_SHIFT;
-
-    if (dscp != dinfo->dscp) {
-        if (skb_ensure_writable(skb, sizeof(struct ipv6hdr)))
-            return NF_DROP;
-
-        ipv6_change_dsfield(ipv6_hdr(skb), XT_DSCP_ECN_MASK,
-                    dinfo->dscp << XT_DSCP_SHIFT);
-    }
-    return XT_CONTINUE;
-}
-
-static int dscp_tg_check(const struct xt_tgchk_param *par)
-{
-    const struct xt_DSCP_info *info = par->targinfo;
-
-    if (info->dscp > XT_DSCP_MAX)
-        return -EDOM;
-    return 0;
-}
-
-static unsigned int
-tos_tg(struct sk_buff *skb, const struct xt_action_param *par)
-{
-    const struct xt_tos_target_info *info = par->targinfo;
-    struct iphdr *iph = ip_hdr(skb);
-    u_int8_t orig, nv;
-
-    orig = ipv4_get_dsfield(iph);
-    nv   = (orig & ~info->tos_mask) ^ info->tos_value;
-
-    if (orig != nv) {
-        if (skb_ensure_writable(skb, sizeof(struct iphdr)))
-            return NF_DROP;
-        iph = ip_hdr(skb);
-        ipv4_change_dsfield(iph, 0, nv);
-    }
-
-    return XT_CONTINUE;
-}
-
-static unsigned int
-tos_tg6(struct sk_buff *skb, const struct xt_action_param *par)
-{
-    const struct xt_tos_target_info *info = par->targinfo;
-    struct ipv6hdr *iph = ipv6_hdr(skb);
-    u_int8_t orig, nv;
-
-    orig = ipv6_get_dsfield(iph);
-    nv   = (orig & ~info->tos_mask) ^ info->tos_value;
-
-    if (orig != nv) {
-        if (skb_ensure_writable(skb, sizeof(struct iphdr)))
-            return NF_DROP;
-        iph = ipv6_hdr(skb);
-        ipv6_change_dsfield(iph, 0, nv);
-    }
-
-    return XT_CONTINUE;
-}
-
-static struct xt_target dscp_tg_reg[] __read_mostly = {
-    {
-        .name        = "DSCP",
-        .family        = NFPROTO_IPV4,
-        .checkentry    = dscp_tg_check,
-        .target        = dscp_tg,
-        .targetsize    = sizeof(struct xt_DSCP_info),
-        .table        = "mangle",
-        .me        = THIS_MODULE,
-    },
-    {
-        .name        = "DSCP",
-        .family        = NFPROTO_IPV6,
-        .checkentry    = dscp_tg_check,
-        .target        = dscp_tg6,
-        .targetsize    = sizeof(struct xt_DSCP_info),
-        .table        = "mangle",
-        .me        = THIS_MODULE,
-    },
-    {
-        .name        = "TOS",
-        .revision    = 1,
-        .family        = NFPROTO_IPV4,
-        .table        = "mangle",
-        .target        = tos_tg,
-        .targetsize    = sizeof(struct xt_tos_target_info),
-        .me        = THIS_MODULE,
-    },
-    {
-        .name        = "TOS",
-        .revision    = 1,
-        .family        = NFPROTO_IPV6,
-        .table        = "mangle",
-        .target        = tos_tg6,
-        .targetsize    = sizeof(struct xt_tos_target_info),
-        .me        = THIS_MODULE,
-    },
-};
-
-static int __init dscp_tg_init(void)
-{
-    return xt_register_targets(dscp_tg_reg, ARRAY_SIZE(dscp_tg_reg));
-}
-
-static void __exit dscp_tg_exit(void)
-{
-    xt_unregister_targets(dscp_tg_reg, ARRAY_SIZE(dscp_tg_reg));
-}
-
-module_init(dscp_tg_init);
-module_exit(dscp_tg_exit);
diff --git a/net/netfilter/xt_HL.c b/net/netfilter/xt_HL.c
deleted file mode 100644
index 7873b834c..000000000
--- a/net/netfilter/xt_HL.c
+++ /dev/null
@@ -1,159 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * TTL modification target for IP tables
- * (C) 2000,2005 by Harald Welte <laforge@netfilter.org>
- *
- * Hop Limit modification target for ip6tables
- * Maciej Soltysiak <solt@dns.toxicfilms.tv>
- */
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <net/checksum.h>
-
-#include <linux/netfilter/x_tables.h>
-#include <linux/netfilter_ipv4/ipt_TTL.h>
-#include <linux/netfilter_ipv6/ip6t_HL.h>
-
-MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
-MODULE_AUTHOR("Maciej Soltysiak <solt@dns.toxicfilms.tv>");
-MODULE_DESCRIPTION("Xtables: Hoplimit/TTL Limit field modification target");
-MODULE_LICENSE("GPL");
-
-static unsigned int
-ttl_tg(struct sk_buff *skb, const struct xt_action_param *par)
-{
-    struct iphdr *iph;
-    const struct ipt_TTL_info *info = par->targinfo;
-    int new_ttl;
-
-    if (skb_ensure_writable(skb, sizeof(*iph)))
-        return NF_DROP;
-
-    iph = ip_hdr(skb);
-
-    switch (info->mode) {
-    case IPT_TTL_SET:
-        new_ttl = info->ttl;
-        break;
-    case IPT_TTL_INC:
-        new_ttl = iph->ttl + info->ttl;
-        if (new_ttl > 255)
-            new_ttl = 255;
-        break;
-    case IPT_TTL_DEC:
-        new_ttl = iph->ttl - info->ttl;
-        if (new_ttl < 0)
-            new_ttl = 0;
-        break;
-    default:
-        new_ttl = iph->ttl;
-        break;
-    }
-
-    if (new_ttl != iph->ttl) {
-        csum_replace2(&iph->check, htons(iph->ttl << 8),
-                       htons(new_ttl << 8));
-        iph->ttl = new_ttl;
-    }
-
-    return XT_CONTINUE;
-}
-
-static unsigned int
-hl_tg6(struct sk_buff *skb, const struct xt_action_param *par)
-{
-    struct ipv6hdr *ip6h;
-    const struct ip6t_HL_info *info = par->targinfo;
-    int new_hl;
-
-    if (skb_ensure_writable(skb, sizeof(*ip6h)))
-        return NF_DROP;
-
-    ip6h = ipv6_hdr(skb);
-
-    switch (info->mode) {
-    case IP6T_HL_SET:
-        new_hl = info->hop_limit;
-        break;
-    case IP6T_HL_INC:
-        new_hl = ip6h->hop_limit + info->hop_limit;
-        if (new_hl > 255)
-            new_hl = 255;
-        break;
-    case IP6T_HL_DEC:
-        new_hl = ip6h->hop_limit - info->hop_limit;
-        if (new_hl < 0)
-            new_hl = 0;
-        break;
-    default:
-        new_hl = ip6h->hop_limit;
-        break;
-    }
-
-    ip6h->hop_limit = new_hl;
-
-    return XT_CONTINUE;
-}
-
-static int ttl_tg_check(const struct xt_tgchk_param *par)
-{
-    const struct ipt_TTL_info *info = par->targinfo;
-
-    if (info->mode > IPT_TTL_MAXMODE)
-        return -EINVAL;
-    if (info->mode != IPT_TTL_SET && info->ttl == 0)
-        return -EINVAL;
-    return 0;
-}
-
-static int hl_tg6_check(const struct xt_tgchk_param *par)
-{
-    const struct ip6t_HL_info *info = par->targinfo;
-
-    if (info->mode > IP6T_HL_MAXMODE)
-        return -EINVAL;
-    if (info->mode != IP6T_HL_SET && info->hop_limit == 0)
-        return -EINVAL;
-    return 0;
-}
-
-static struct xt_target hl_tg_reg[] __read_mostly = {
-    {
-        .name       = "TTL",
-        .revision   = 0,
-        .family     = NFPROTO_IPV4,
-        .target     = ttl_tg,
-        .targetsize = sizeof(struct ipt_TTL_info),
-        .table      = "mangle",
-        .checkentry = ttl_tg_check,
-        .me         = THIS_MODULE,
-    },
-    {
-        .name       = "HL",
-        .revision   = 0,
-        .family     = NFPROTO_IPV6,
-        .target     = hl_tg6,
-        .targetsize = sizeof(struct ip6t_HL_info),
-        .table      = "mangle",
-        .checkentry = hl_tg6_check,
-        .me         = THIS_MODULE,
-    },
-};
-
-static int __init hl_tg_init(void)
-{
-    return xt_register_targets(hl_tg_reg, ARRAY_SIZE(hl_tg_reg));
-}
-
-static void __exit hl_tg_exit(void)
-{
-    xt_unregister_targets(hl_tg_reg, ARRAY_SIZE(hl_tg_reg));
-}
-
-module_init(hl_tg_init);
-module_exit(hl_tg_exit);
-MODULE_ALIAS("ipt_TTL");
-MODULE_ALIAS("ip6t_HL");
diff --git a/net/netfilter/xt_RATEEST.c b/net/netfilter/xt_RATEEST.c
deleted file mode 100644
index 80f6624e2..000000000
--- a/net/netfilter/xt_RATEEST.c
+++ /dev/null
@@ -1,233 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * (C) 2007 Patrick McHardy <kaber@trash.net>
- */
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <linux/gen_stats.h>
-#include <linux/jhash.h>
-#include <linux/rtnetlink.h>
-#include <linux/random.h>
-#include <linux/slab.h>
-#include <net/gen_stats.h>
-#include <net/netlink.h>
-#include <net/netns/generic.h>
-
-#include <linux/netfilter/x_tables.h>
-#include <linux/netfilter/xt_RATEEST.h>
-#include <net/netfilter/xt_rateest.h>
-
-#define RATEEST_HSIZE    16
-
-struct xt_rateest_net {
-    struct mutex hash_lock;
-    struct hlist_head hash[RATEEST_HSIZE];
-};
-
-static unsigned int xt_rateest_id;
-
-static unsigned int jhash_rnd __read_mostly;
-
-static unsigned int xt_rateest_hash(const char *name)
-{
-    return jhash(name, sizeof_field(struct xt_rateest, name), jhash_rnd) &
-           (RATEEST_HSIZE - 1);
-}
-
-static void xt_rateest_hash_insert(struct xt_rateest_net *xn,
-                   struct xt_rateest *est)
-{
-    unsigned int h;
-
-    h = xt_rateest_hash(est->name);
-    hlist_add_head(&est->list, &xn->hash[h]);
-}
-
-static struct xt_rateest *__xt_rateest_lookup(struct xt_rateest_net *xn,
-                          const char *name)
-{
-    struct xt_rateest *est;
-    unsigned int h;
-
-    h = xt_rateest_hash(name);
-    hlist_for_each_entry(est, &xn->hash[h], list) {
-        if (strcmp(est->name, name) == 0) {
-            est->refcnt++;
-            return est;
-        }
-    }
-
-    return NULL;
-}
-
-struct xt_rateest *xt_rateest_lookup(struct net *net, const char *name)
-{
-    struct xt_rateest_net *xn = net_generic(net, xt_rateest_id);
-    struct xt_rateest *est;
-
-    mutex_lock(&xn->hash_lock);
-    est = __xt_rateest_lookup(xn, name);
-    mutex_unlock(&xn->hash_lock);
-    return est;
-}
-EXPORT_SYMBOL_GPL(xt_rateest_lookup);
-
-void xt_rateest_put(struct net *net, struct xt_rateest *est)
-{
-    struct xt_rateest_net *xn = net_generic(net, xt_rateest_id);
-
-    mutex_lock(&xn->hash_lock);
-    if (--est->refcnt == 0) {
-        hlist_del(&est->list);
-        gen_kill_estimator(&est->rate_est);
-        /*
-         * gen_estimator est_timer() might access est->lock or bstats,
-         * wait a RCU grace period before freeing 'est'
-         */
-        kfree_rcu(est, rcu);
-    }
-    mutex_unlock(&xn->hash_lock);
-}
-EXPORT_SYMBOL_GPL(xt_rateest_put);
-
-static unsigned int
-xt_rateest_tg(struct sk_buff *skb, const struct xt_action_param *par)
-{
-    const struct xt_rateest_target_info *info = par->targinfo;
-    struct gnet_stats_basic_sync *stats = &info->est->bstats;
-
-    spin_lock_bh(&info->est->lock);
-    u64_stats_add(&stats->bytes, skb->len);
-    u64_stats_inc(&stats->packets);
-    spin_unlock_bh(&info->est->lock);
-
-    return XT_CONTINUE;
-}
-
-static int xt_rateest_tg_checkentry(const struct xt_tgchk_param *par)
-{
-    struct xt_rateest_net *xn = net_generic(par->net, xt_rateest_id);
-    struct xt_rateest_target_info *info = par->targinfo;
-    struct xt_rateest *est;
-    struct {
-        struct nlattr        opt;
-        struct gnet_estimator    est;
-    } cfg;
-    int ret;
-
-    if (strnlen(info->name, sizeof(est->name)) >= sizeof(est->name))
-        return -ENAMETOOLONG;
-
-    net_get_random_once(&jhash_rnd, sizeof(jhash_rnd));
-
-    mutex_lock(&xn->hash_lock);
-    est = __xt_rateest_lookup(xn, info->name);
-    if (est) {
-        mutex_unlock(&xn->hash_lock);
-        /*
-         * If estimator parameters are specified, they must match the
-         * existing estimator.
-         */
-        if ((!info->interval && !info->ewma_log) ||
-            (info->interval != est->params.interval ||
-             info->ewma_log != est->params.ewma_log)) {
-            xt_rateest_put(par->net, est);
-            return -EINVAL;
-        }
-        info->est = est;
-        return 0;
-    }
-
-    ret = -ENOMEM;
-    est = kzalloc(sizeof(*est), GFP_KERNEL);
-    if (!est)
-        goto err1;
-
-    gnet_stats_basic_sync_init(&est->bstats);
-    strscpy(est->name, info->name, sizeof(est->name));
-    spin_lock_init(&est->lock);
-    est->refcnt        = 1;
-    est->params.interval    = info->interval;
-    est->params.ewma_log    = info->ewma_log;
-
-    cfg.opt.nla_len        = nla_attr_size(sizeof(cfg.est));
-    cfg.opt.nla_type    = TCA_STATS_RATE_EST;
-    cfg.est.interval    = info->interval;
-    cfg.est.ewma_log    = info->ewma_log;
-
-    ret = gen_new_estimator(&est->bstats, NULL, &est->rate_est,
-                &est->lock, NULL, &cfg.opt);
-    if (ret < 0)
-        goto err2;
-
-    info->est = est;
-    xt_rateest_hash_insert(xn, est);
-    mutex_unlock(&xn->hash_lock);
-    return 0;
-
-err2:
-    kfree(est);
-err1:
-    mutex_unlock(&xn->hash_lock);
-    return ret;
-}
-
-static void xt_rateest_tg_destroy(const struct xt_tgdtor_param *par)
-{
-    struct xt_rateest_target_info *info = par->targinfo;
-
-    xt_rateest_put(par->net, info->est);
-}
-
-static struct xt_target xt_rateest_tg_reg __read_mostly = {
-    .name       = "RATEEST",
-    .revision   = 0,
-    .family     = NFPROTO_UNSPEC,
-    .target     = xt_rateest_tg,
-    .checkentry = xt_rateest_tg_checkentry,
-    .destroy    = xt_rateest_tg_destroy,
-    .targetsize = sizeof(struct xt_rateest_target_info),
-    .usersize   = offsetof(struct xt_rateest_target_info, est),
-    .me         = THIS_MODULE,
-};
-
-static __net_init int xt_rateest_net_init(struct net *net)
-{
-    struct xt_rateest_net *xn = net_generic(net, xt_rateest_id);
-    int i;
-
-    mutex_init(&xn->hash_lock);
-    for (i = 0; i < ARRAY_SIZE(xn->hash); i++)
-        INIT_HLIST_HEAD(&xn->hash[i]);
-    return 0;
-}
-
-static struct pernet_operations xt_rateest_net_ops = {
-    .init = xt_rateest_net_init,
-    .id   = &xt_rateest_id,
-    .size = sizeof(struct xt_rateest_net),
-};
-
-static int __init xt_rateest_tg_init(void)
-{
-    int err = register_pernet_subsys(&xt_rateest_net_ops);
-
-    if (err)
-        return err;
-    return xt_register_target(&xt_rateest_tg_reg);
-}
-
-static void __exit xt_rateest_tg_fini(void)
-{
-    xt_unregister_target(&xt_rateest_tg_reg);
-    unregister_pernet_subsys(&xt_rateest_net_ops);
-}
-
-
-MODULE_AUTHOR("Patrick McHardy <kaber@trash.net>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Xtables: packet rate estimator");
-MODULE_ALIAS("ipt_RATEEST");
-MODULE_ALIAS("ip6t_RATEEST");
-module_init(xt_rateest_tg_init);
-module_exit(xt_rateest_tg_fini);
diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
deleted file mode 100644
index 116a885ad..000000000
--- a/net/netfilter/xt_TCPMSS.c
+++ /dev/null
@@ -1,345 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * This is a module which is used for setting the MSS option in TCP packets.
- *
- * Copyright (C) 2000 Marc Boucher <marc@mbsi.ca>
- * Copyright (C) 2007 Patrick McHardy <kaber@trash.net>
- */
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <linux/module.h>
-#include <linux/skbuff.h>
-#include <linux/ip.h>
-#include <linux/gfp.h>
-#include <linux/ipv6.h>
-#include <linux/tcp.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/ipv6.h>
-#include <net/route.h>
-#include <net/tcp.h>
-
-#include <linux/netfilter_ipv4/ip_tables.h>
-#include <linux/netfilter_ipv6/ip6_tables.h>
-#include <linux/netfilter/x_tables.h>
-#include <linux/netfilter/xt_tcpudp.h>
-#include <linux/netfilter/xt_TCPMSS.h>
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Marc Boucher <marc@mbsi.ca>");
-MODULE_DESCRIPTION("Xtables: TCP Maximum Segment Size (MSS) adjustment");
-MODULE_ALIAS("ipt_TCPMSS");
-MODULE_ALIAS("ip6t_TCPMSS");
-
-static inline unsigned int
-optlen(const u_int8_t *opt, unsigned int offset)
-{
-    /* Beware zero-length options: make finite progress */
-    if (opt[offset] <= TCPOPT_NOP || opt[offset+1] == 0)
-        return 1;
-    else
-        return opt[offset+1];
-}
-
-static u_int32_t tcpmss_reverse_mtu(struct net *net,
-                    const struct sk_buff *skb,
-                    unsigned int family)
-{
-    struct flowi fl;
-    struct rtable *rt = NULL;
-    u_int32_t mtu     = ~0U;
-
-    if (family == PF_INET) {
-        struct flowi4 *fl4 = &fl.u.ip4;
-        memset(fl4, 0, sizeof(*fl4));
-        fl4->daddr = ip_hdr(skb)->saddr;
-    } else {
-        struct flowi6 *fl6 = &fl.u.ip6;
-
-        memset(fl6, 0, sizeof(*fl6));
-        fl6->daddr = ipv6_hdr(skb)->saddr;
-    }
-
-    nf_route(net, (struct dst_entry **)&rt, &fl, false, family);
-    if (rt != NULL) {
-        mtu = dst_mtu(&rt->dst);
-        dst_release(&rt->dst);
-    }
-    return mtu;
-}
-
-static int
-tcpmss_mangle_packet(struct sk_buff *skb,
-             const struct xt_action_param *par,
-             unsigned int family,
-             unsigned int tcphoff,
-             unsigned int minlen)
-{
-    const struct xt_tcpmss_info *info = par->targinfo;
-    struct tcphdr *tcph;
-    int len, tcp_hdrlen;
-    unsigned int i;
-    __be16 oldval;
-    u16 newmss;
-    u8 *opt;
-
-    /* This is a fragment, no TCP header is available */
-    if (par->fragoff != 0)
-        return 0;
-
-    if (skb_ensure_writable(skb, skb->len))
-        return -1;
-
-    len = skb->len - tcphoff;
-    if (len < (int)sizeof(struct tcphdr))
-        return -1;
-
-    tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
-    tcp_hdrlen = tcph->doff * 4;
-
-    if (len < tcp_hdrlen || tcp_hdrlen < sizeof(struct tcphdr))
-        return -1;
-
-    if (info->mss == XT_TCPMSS_CLAMP_PMTU) {
-        struct net *net = xt_net(par);
-        unsigned int in_mtu = tcpmss_reverse_mtu(net, skb, family);
-        unsigned int min_mtu = min(dst_mtu(skb_dst(skb)), in_mtu);
-
-        if (min_mtu <= minlen) {
-            net_err_ratelimited("unknown or invalid path-MTU (%u)\n",
-                        min_mtu);
-            return -1;
-        }
-        newmss = min_mtu - minlen;
-    } else
-        newmss = info->mss;
-
-    opt = (u_int8_t *)tcph;
-    for (i = sizeof(struct tcphdr); i <= tcp_hdrlen - TCPOLEN_MSS; i
+= optlen(opt, i)) {
-        if (opt[i] == TCPOPT_MSS && opt[i+1] == TCPOLEN_MSS) {
-            u_int16_t oldmss;
-
-            oldmss = (opt[i+2] << 8) | opt[i+3];
-
-            /* Never increase MSS, even when setting it, as
-             * doing so results in problems for hosts that rely
-             * on MSS being set correctly.
-             */
-            if (oldmss <= newmss)
-                return 0;
-
-            opt[i+2] = (newmss & 0xff00) >> 8;
-            opt[i+3] = newmss & 0x00ff;
-
-            inet_proto_csum_replace2(&tcph->check, skb,
-                         htons(oldmss), htons(newmss),
-                         false);
-            return 0;
-        }
-    }
-
-    /* There is data after the header so the option can't be added
-     * without moving it, and doing so may make the SYN packet
-     * itself too large. Accept the packet unmodified instead.
-     */
-    if (len > tcp_hdrlen)
-        return 0;
-
-    /* tcph->doff has 4 bits, do not wrap it to 0 */
-    if (tcp_hdrlen >= 15 * 4)
-        return 0;
-
-    /*
-     * MSS Option not found ?! add it..
-     */
-    if (skb_tailroom(skb) < TCPOLEN_MSS) {
-        if (pskb_expand_head(skb, 0,
-                     TCPOLEN_MSS - skb_tailroom(skb),
-                     GFP_ATOMIC))
-            return -1;
-        tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
-    }
-
-    skb_put(skb, TCPOLEN_MSS);
-
-    /*
-     * IPv4: RFC 1122 states "If an MSS option is not received at
-     * connection setup, TCP MUST assume a default send MSS of 536".
-     * IPv6: RFC 2460 states IPv6 has a minimum MTU of 1280 and a minimum
-     * length IPv6 header of 60, ergo the default MSS value is 1220
-     * Since no MSS was provided, we must use the default values
-     */
-    if (xt_family(par) == NFPROTO_IPV4)
-        newmss = min(newmss, (u16)536);
-    else
-        newmss = min(newmss, (u16)1220);
-
-    opt = (u_int8_t *)tcph + sizeof(struct tcphdr);
-    memmove(opt + TCPOLEN_MSS, opt, len - sizeof(struct tcphdr));
-
-    inet_proto_csum_replace2(&tcph->check, skb,
-                 htons(len), htons(len + TCPOLEN_MSS), true);
-    opt[0] = TCPOPT_MSS;
-    opt[1] = TCPOLEN_MSS;
-    opt[2] = (newmss & 0xff00) >> 8;
-    opt[3] = newmss & 0x00ff;
-
-    inet_proto_csum_replace4(&tcph->check, skb, 0, *((__be32 *)opt), false);
-
-    oldval = ((__be16 *)tcph)[6];
-    tcph->doff += TCPOLEN_MSS/4;
-    inet_proto_csum_replace2(&tcph->check, skb,
-                 oldval, ((__be16 *)tcph)[6], false);
-    return TCPOLEN_MSS;
-}
-
-static unsigned int
-tcpmss_tg4(struct sk_buff *skb, const struct xt_action_param *par)
-{
-    struct iphdr *iph = ip_hdr(skb);
-    __be16 newlen;
-    int ret;
-
-    ret = tcpmss_mangle_packet(skb, par,
-                   PF_INET,
-                   iph->ihl * 4,
-                   sizeof(*iph) + sizeof(struct tcphdr));
-    if (ret < 0)
-        return NF_DROP;
-    if (ret > 0) {
-        iph = ip_hdr(skb);
-        newlen = htons(ntohs(iph->tot_len) + ret);
-        csum_replace2(&iph->check, iph->tot_len, newlen);
-        iph->tot_len = newlen;
-    }
-    return XT_CONTINUE;
-}
-
-#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
-static unsigned int
-tcpmss_tg6(struct sk_buff *skb, const struct xt_action_param *par)
-{
-    struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-    u8 nexthdr;
-    __be16 frag_off, oldlen, newlen;
-    int tcphoff;
-    int ret;
-
-    nexthdr = ipv6h->nexthdr;
-    tcphoff = ipv6_skip_exthdr(skb, sizeof(*ipv6h), &nexthdr, &frag_off);
-    if (tcphoff < 0)
-        return NF_DROP;
-    ret = tcpmss_mangle_packet(skb, par,
-                   PF_INET6,
-                   tcphoff,
-                   sizeof(*ipv6h) + sizeof(struct tcphdr));
-    if (ret < 0)
-        return NF_DROP;
-    if (ret > 0) {
-        ipv6h = ipv6_hdr(skb);
-        oldlen = ipv6h->payload_len;
-        newlen = htons(ntohs(oldlen) + ret);
-        if (skb->ip_summed == CHECKSUM_COMPLETE)
-            skb->csum = csum_add(csum_sub(skb->csum, (__force __wsum)oldlen),
-                         (__force __wsum)newlen);
-        ipv6h->payload_len = newlen;
-    }
-    return XT_CONTINUE;
-}
-#endif
-
-/* Must specify -p tcp --syn */
-static inline bool find_syn_match(const struct xt_entry_match *m)
-{
-    const struct xt_tcp *tcpinfo = (const struct xt_tcp *)m->data;
-
-    if (strcmp(m->u.kernel.match->name, "tcp") == 0 &&
-        tcpinfo->flg_cmp & TCPHDR_SYN &&
-        !(tcpinfo->invflags & XT_TCP_INV_FLAGS))
-        return true;
-
-    return false;
-}
-
-static int tcpmss_tg4_check(const struct xt_tgchk_param *par)
-{
-    const struct xt_tcpmss_info *info = par->targinfo;
-    const struct ipt_entry *e = par->entryinfo;
-    const struct xt_entry_match *ematch;
-
-    if (info->mss == XT_TCPMSS_CLAMP_PMTU &&
-        (par->hook_mask & ~((1 << NF_INET_FORWARD) |
-               (1 << NF_INET_LOCAL_OUT) |
-               (1 << NF_INET_POST_ROUTING))) != 0) {
-        pr_info_ratelimited("path-MTU clamping only supported in
FORWARD, OUTPUT and POSTROUTING hooks\n");
-        return -EINVAL;
-    }
-    if (par->nft_compat)
-        return 0;
-
-    xt_ematch_foreach(ematch, e)
-        if (find_syn_match(ematch))
-            return 0;
-    pr_info_ratelimited("Only works on TCP SYN packets\n");
-    return -EINVAL;
-}
-
-#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
-static int tcpmss_tg6_check(const struct xt_tgchk_param *par)
-{
-    const struct xt_tcpmss_info *info = par->targinfo;
-    const struct ip6t_entry *e = par->entryinfo;
-    const struct xt_entry_match *ematch;
-
-    if (info->mss == XT_TCPMSS_CLAMP_PMTU &&
-        (par->hook_mask & ~((1 << NF_INET_FORWARD) |
-               (1 << NF_INET_LOCAL_OUT) |
-               (1 << NF_INET_POST_ROUTING))) != 0) {
-        pr_info_ratelimited("path-MTU clamping only supported in
FORWARD, OUTPUT and POSTROUTING hooks\n");
-        return -EINVAL;
-    }
-    if (par->nft_compat)
-        return 0;
-
-    xt_ematch_foreach(ematch, e)
-        if (find_syn_match(ematch))
-            return 0;
-    pr_info_ratelimited("Only works on TCP SYN packets\n");
-    return -EINVAL;
-}
-#endif
-
-static struct xt_target tcpmss_tg_reg[] __read_mostly = {
-    {
-        .family        = NFPROTO_IPV4,
-        .name        = "TCPMSS",
-        .checkentry    = tcpmss_tg4_check,
-        .target        = tcpmss_tg4,
-        .targetsize    = sizeof(struct xt_tcpmss_info),
-        .proto        = IPPROTO_TCP,
-        .me        = THIS_MODULE,
-    },
-#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
-    {
-        .family        = NFPROTO_IPV6,
-        .name        = "TCPMSS",
-        .checkentry    = tcpmss_tg6_check,
-        .target        = tcpmss_tg6,
-        .targetsize    = sizeof(struct xt_tcpmss_info),
-        .proto        = IPPROTO_TCP,
-        .me        = THIS_MODULE,
-    },
-#endif
-};
-
-static int __init tcpmss_tg_init(void)
-{
-    return xt_register_targets(tcpmss_tg_reg, ARRAY_SIZE(tcpmss_tg_reg));
-}
-
-static void __exit tcpmss_tg_exit(void)
-{
-    xt_unregister_targets(tcpmss_tg_reg, ARRAY_SIZE(tcpmss_tg_reg));
-}
-
-module_init(tcpmss_tg_init);
-module_exit(tcpmss_tg_exit);
-- 
2.34.1

