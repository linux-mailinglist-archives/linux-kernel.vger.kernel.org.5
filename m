Return-Path: <linux-kernel+bounces-13198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D15DD820112
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EF9B21A64
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED99912E49;
	Fri, 29 Dec 2023 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N8GTPD4Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088412E42
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 18:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554F2C433C8;
	Fri, 29 Dec 2023 18:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703875189;
	bh=O2/xlsfiGK2JHX2jsq2q2w5sendbByQnKeXFXc+aUE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8GTPD4QtGaJRknEw3hKvPJTn65EuvF1AIz8lsXowR5KkEcpuwPv8E0ipy/jKGS8H
	 GfHWW+24N8VRDYHcLpXRx6mXBzz7nZR3gt1ZZJtH1IJkMy/hcCgj4t3p5FghmVjj4L
	 qN8278+p/NAwbb/ndeJIBoLx8/mbU7+5qSmad+3I=
Date: Fri, 29 Dec 2023 10:39:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/9] lib/group_cpus: relax atomicity requirement in
 grp_spread_init_one()
Message-Id: <20231229103948.4a78a75a83962df0874d04f1@linux-foundation.org>
In-Reply-To: <20231228200936.2475595-4-yury.norov@gmail.com>
References: <20231228200936.2475595-1-yury.norov@gmail.com>
	<20231228200936.2475595-4-yury.norov@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 12:09:30 -0800 Yury Norov <yury.norov@gmail.com> wrote:

> Because nmsk and irqmsk are stable, extra atomicity is not required.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> NAKed-by: Ming Lei <ming.lei@redhat.com>

Well that's unusual.  I suggest that the changelog at least describe the
objection, and its counterargument?

