Return-Path: <linux-kernel+bounces-7241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D681A3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEBF1C22CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089B47A4A;
	Wed, 20 Dec 2023 16:01:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF045C09;
	Wed, 20 Dec 2023 16:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A679C433D9;
	Wed, 20 Dec 2023 16:01:56 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:02:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v8 0/2] Introducing trace buffer mapping by user-space
Message-ID: <20231220110257.2b338dce@gandalf.local.home>
In-Reply-To: <ZYLw6okkDJq9Pi2O@google.com>
References: <20231219184556.1552951-1-vdonnefort@google.com>
	<20231219153924.2ff9c132@gandalf.local.home>
	<ZYLmvmzLOBfrrsSu@google.com>
	<20231220082932.1b391355@gandalf.local.home>
	<ZYLw6okkDJq9Pi2O@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 13:49:30 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> I meant, to only do in rb_wake_up_waiters()
> 
>   if (rbwork->is_cpu_buffer) 
>   	rb_update_meta_page(cpu_buffer)
> 
> And skip the meta-page update for the !is_cpu_buffer case?

Ah yeah, that works.

-- Steve

