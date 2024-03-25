Return-Path: <linux-kernel+bounces-118193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B6C88B59B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC9D2E7A02
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2486245;
	Mon, 25 Mar 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeRP34BK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493385293;
	Mon, 25 Mar 2024 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410643; cv=none; b=TjzE6V3sfn4uVZ5SMALrA4QNR2buMgQSB4FkZHfbvVNdy0KQo8DrBKqbWqJKs+cSqRDLtXW6Z3IR/MiyxqglXg4xBd0LVmwv9nz6/pEvT0yFPEp0YttUHhZQSgTVZA7OpPtiUJh1Gikor9SxKgm1y0D97sb1HjS1FY3G6RbtqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410643; c=relaxed/simple;
	bh=EQ0lNcHAsZM9AzkcfyMG2JMpCa+0V7NnfA1QWVnegz0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T2JF6POUganQ5upLGv7Fn6wwAoiyHSvJcknNwQWwC5OrMMcBh4sku7zJYgYhVg1lBKl4rsyoSgPPNjxP6dlH0+vVVPRYWaWxmemLwUOoEUO9e3ymDNVbj+PBiVS1dcpE47F3hz/X0oSVH9t8nzYwvXa0MKO2LQnuVnvKkCqw7S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeRP34BK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3549C433F1;
	Mon, 25 Mar 2024 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711410642;
	bh=EQ0lNcHAsZM9AzkcfyMG2JMpCa+0V7NnfA1QWVnegz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KeRP34BKGe6jQH6sHSXzv3tQPiBBAiBgxtv6jJ5ahzUFHgORlz9ucYi5FAuAeANb3
	 fqwLhGm9JrkZE0xg3KsWmBMRyZhX9Lt82aFlMKuTP7DIXmhf64GWD1xFLHA0IZP5ox
	 DIY/farVYhuaroLBBAv1FHVack2kmO5PTS8CkgT2KvFsdCwh4tEev3QK3ctL15Pkeq
	 193osBE5rF6/BPy0txNZB+DYnsn0Z9yOfcd8BsAESuQb6Z7wPUQV6cjCYJDf2sTONc
	 nkZFMbL/Ig711iuw+2GH4A+7muzT36lFsAMoxkuJcVmlzxcjvyNpIXPv0CT7BYs5CP
	 AcGfmzt+9cwvg==
Date: Tue, 26 Mar 2024 08:50:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 <linux-kernel@vger.kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>,
 <linux-modules@vger.kernel.org>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/2] kprobes: textmem API
Message-Id: <20240326085037.0142d7dadc702e3b49a3251e@kernel.org>
In-Reply-To: <D036AJAEAOUF.34494O217N0RI@kernel.org>
References: <20240325215502.660-1-jarkko@kernel.org>
	<D036AJAEAOUF.34494O217N0RI@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 00:09:42 +0200
"Jarkko Sakkinen" <jarkko@kernel.org> wrote:

> On Mon Mar 25, 2024 at 11:55 PM EET, Jarkko Sakkinen wrote:
> > +#ifdef CONFIG_MODULES
> >  	if (register_module_notifier(&trace_kprobe_module_nb))
> >  		return -EINVAL;
> > +#endif /* CONFIG_MODULES */
> 
> register_module_notifier() does have "dummy" version but what
> would I pass to it. It makes more mess than it cleans to declare
> also a "dummy" version of trace_kprobe_module_nb.

That is better than having #ifdef in the function.

> 
> The callback itself has too tight module subsystem bindings so
> that they could be simply flagged with IS_DEFINED() (or correct
> if I'm mistaken, this the conclusion I've ended up with).

Please try this.

-----
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 70dc6179086e..bc98db14927f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2625,6 +2625,7 @@ static void remove_module_kprobe_blacklist(struct module *mod)
 	}
 }
 
+#ifdef CONFIG_MODULES
 /* Module notifier call back, checking kprobes on the module */
 static int kprobes_module_callback(struct notifier_block *nb,
 				   unsigned long val, void *data)
@@ -2675,6 +2676,9 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_unlock(&kprobe_mutex);
 	return NOTIFY_DONE;
 }
+#else
+#define kprobes_module_callback	(NULL)
+#endif
 
 static struct notifier_block kprobe_module_nb = {
 	.notifier_call = kprobes_module_callback,
@@ -2739,7 +2743,7 @@ static int __init init_kprobes(void)
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
-	if (!err)
+	if (!err && IS_ENABLED(CONFIG_MODULES))
 		err = register_module_notifier(&kprobe_module_nb);
 
 	kprobes_initialized = (err == 0);

-----

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

