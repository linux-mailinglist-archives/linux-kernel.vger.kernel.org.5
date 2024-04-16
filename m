Return-Path: <linux-kernel+bounces-146238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 577388A628F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF0E1F21D92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BF73770B;
	Tue, 16 Apr 2024 04:47:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2239FD0;
	Tue, 16 Apr 2024 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242853; cv=none; b=SC4zODg1lbcFcfDN4diEa6naee9wUFu/Bbs1J2U4nMOn1V5d8wgI5HdNGKltqaha9PH0EDGjl3vwqlAgi9o5/Tfl0QokUzT+VRNT4yXnO8EtroND3Vr0VcCC0cBCyGVhoTfmaE7kxgJX/9BVCqIV8CUnEdK2KeNndUU4KFMbbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242853; c=relaxed/simple;
	bh=TeLoISl2F+4ryxFAdG4SfJT5pi3IscEEiknzA03nl3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riCvH3Vtf4Qqv4OAsUjcLCGSnKrWczb5cavHxErJzkkqBBgnyj9kzt2yQ0P3n2HtN5ywXwKu7a7u5sDLV+CGAzDeX9xWh6bhQ5Up2ha/8/pQxnS/6Z1NYpAtjAtXVAtN8hTNNT5j+Qq4aV+x30+vN19CPsuQn22jMMNz6xxngMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9FCC113CE;
	Tue, 16 Apr 2024 04:47:31 +0000 (UTC)
Date: Tue, 16 Apr 2024 00:47:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Francis Laniel <flaniel@linux.microsoft.com>
Subject: Re: [PATCH for-next v2] tracing/kprobes: Add symbol counting check
 when module loads
Message-ID: <20240416004726.792b8158@rorschach.local.home>
In-Reply-To: <171317402290.228024.13465974857683559752.stgit@devnote2>
References: <171317402290.228024.13465974857683559752.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 18:40:23 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Check the number of probe target symbols in the target module when
> the module is loaded. If the probe is not on the unique name symbols
> in the module, it will be rejected at that point.
> 
> Note that the symbol which has a unique name in the target module,
> it will be accepted even if there are same-name symbols in the
> kernel or other modules,

This says what it does, but doesn't explain why it is doing it.
What's the purpose of this patch?

-- Steve

