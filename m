Return-Path: <linux-kernel+bounces-117777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6848088AF7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239092E3489
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CF2125C9;
	Mon, 25 Mar 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW1GcPTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9551094E;
	Mon, 25 Mar 2024 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393921; cv=none; b=t+OznefY40VJeDhhYQkee+dRnAGlnWAHgo40B5MuUX3KJ+p7I83ucrUOgWyd9pogMyeEiLxMuqMq0cdCXqZcfxO1l5Lfsd3JENa/w8TI8Ji0qf4Y5iVFE7Tro6N/srX6nv02CqBCk3oBd8HbaQZbWOIUghdTtHDrMB7LCeXPLmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393921; c=relaxed/simple;
	bh=u7jAwOBoyoEFZf/8d+oD1X/Pe8+N3eKMDolm6R9REw4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hbEk1raGE4fbB28ixJn9+ji0edQesNEqk1Q8HXxX7yPtoRMZhK8e4qNCVVVEEZbEUolOnfZAlQo1TAyFGyUmlzEhbeev9jHNaMXu0A5LsARJcYMSZdFYC2r1GSomW83u02g6VtiktEryJ9PeUgk8bff3zQ9muSOhuGAWZyNg/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW1GcPTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8041BC433F1;
	Mon, 25 Mar 2024 19:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711393920;
	bh=u7jAwOBoyoEFZf/8d+oD1X/Pe8+N3eKMDolm6R9REw4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=XW1GcPTfA8aKj6N4r9YfSxGEKxNzrNpo397atjIL1ilMDEIKJv+U3Idjo47Lsy2N2
	 RZK5elJCDCFXZZ2nwka9ZBbS7uzk03MBwVuq6RuWAlI1lcRcMwgV8wTUKX1bu3TKnL
	 bzrLk5BVgwpxbeJRmuLOyUePw9FBHif2yq/5LJnpiKuRhDCky3OTZeXlMUMUhkZvEp
	 xJEaJDl4kN4rs7aneTZDDecBbeC8C8IPZ1zUnsT7i/cSyTIDuUYZyHEiRED43Mdt1z
	 c8z3jIM0hWHoVQt3I0CTb7Skq2Lrw7WSRYgU0DkGsAGVW/SGCFlbgPcpoMgNscFagb
	 hE9562rX7NzVw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Mar 2024 21:11:56 +0200
Message-Id: <D032IFOPKJI8.3TKDPQQI9I6LG@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>, "Naveen N .
 Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 <linux-trace-kernel@vger.kernel.org>, "Calvin Owens"
 <jcalvinowens@gmail.com>
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
 <D031SE4QN1CG.18GY6AS20QF1J@kernel.org>
In-Reply-To: <D031SE4QN1CG.18GY6AS20QF1J@kernel.org>

On Mon Mar 25, 2024 at 8:37 PM EET, Jarkko Sakkinen wrote:
> > You also should consider using IS_ENABLED(CONFIG_MODULE) in the code to
> > avoid using #ifdefs.

Hmm... I need make a couple of remarks but open for feedback ofc.

First, trace_kprobe_module_exist depends on find_module()

Second, there is a notifier callback that heavily binds to the module
subsystem.

In both cases using IS_ENABLED would emit a lot of compilation errors.

BR, Jarkko

