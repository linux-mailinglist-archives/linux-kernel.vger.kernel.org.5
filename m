Return-Path: <linux-kernel+bounces-6919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249DA819F54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86331F22B35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B9A25541;
	Wed, 20 Dec 2023 12:52:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883A2577A;
	Wed, 20 Dec 2023 12:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AE2C433C8;
	Wed, 20 Dec 2023 12:52:09 +0000 (UTC)
Date: Wed, 20 Dec 2023 07:53:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 01/15] ring-buffer: Refactor ring buffer
 implementation
Message-ID: <20231220075310.634672bc@gandalf.local.home>
In-Reply-To: <20231220184843.163d60de46f82b7b4ee01d3d@kernel.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185627.723857541@goodmis.org>
	<20231220184843.163d60de46f82b7b4ee01d3d@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 18:48:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
> > 
> > In order to introduce sub-buffer size per ring buffer, some internal
> > refactoring is needed. As ring_buffer_print_page_header() will depend on
> > the trace_buffer structure, it is moved after the structure definition.
> > 
> > Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-2-tz.stoyanov@gmail.com
> >   
> 
> OK, but the title is too generic. Something like 
> "Move ring_buffer_print_page_header() after ring_buffer_iter"
> will be preferable.
> 

Yeah, I can update the subject. Thanks!

-- Steve

