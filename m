Return-Path: <linux-kernel+bounces-7734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F1E81AC6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D10287865
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB098184C;
	Thu, 21 Dec 2023 01:56:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7304A19;
	Thu, 21 Dec 2023 01:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE92C433C9;
	Thu, 21 Dec 2023 01:56:03 +0000 (UTC)
Date: Wed, 20 Dec 2023 20:57:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 15/15] tracing: Update subbuffer with kilobytes not
 page order
Message-ID: <20231220205705.64de0424@gandalf.local.home>
In-Reply-To: <20231221092621.c3d4ecc23b852d3c4183370d@kernel.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185631.809766769@goodmis.org>
	<20231221092621.c3d4ecc23b852d3c4183370d@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 09:26:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > If the user specifies 3 via:
> > 
> >   echo 3 > buffer_subbuf_size_kb
> > 
> > Then the sub-buffer size will round up to 4kb (on a 4kb page size system).
> > 
> > If they specify:
> > 
> >   echo 6 > buffer_subbuf_size_kb
> > 
> > The sub-buffer size will become 8kb.  
> 
> I think this is better interface. Can we apply this earlier in the series
> to avoid rewriting the document and test code?

I kept it separate for testing purposes.

Through out all this, it was a good way to make sure the two approaches
were compatible. I still like to keep them separate as that's the way it
was developed. It's good to keep that history.

-- Steve

