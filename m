Return-Path: <linux-kernel+bounces-9214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337C81C262
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61191F25334
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2EA23;
	Fri, 22 Dec 2023 00:39:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF352913;
	Fri, 22 Dec 2023 00:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCDEC433C7;
	Fri, 22 Dec 2023 00:39:48 +0000 (UTC)
Date: Thu, 21 Dec 2023 19:40:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan
 <shuah@kernel.org>, Linux selftests <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] tracing/selftests: Add ownership modification tests for
 eventfs
Message-ID: <20231221194052.430d193b@gandalf.local.home>
In-Reply-To: <20231221193551.13a0b7bd@gandalf.local.home>
References: <20231221193551.13a0b7bd@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 19:35:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> +
> +# find another owner and group that is not the original
> +other_group=`tac /etc/group | grep -v ":$original_group:" | head -1 | cut -d: -f3`
> +other_owner=`tac /etc/passwd | grep -v ":$original_group:" | head -1 | cut -d: -f3`

Bah, cut and paste error. Let me send a v2

It only worked because $original_group == $original_owner

:-/

-- Steve

