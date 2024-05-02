Return-Path: <linux-kernel+bounces-167041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1988A8BA3C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58548B23B94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD171CD16;
	Thu,  2 May 2024 23:10:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4741A80;
	Thu,  2 May 2024 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691436; cv=none; b=YEYYpVzsP08u328rP6FO3kZD5Rj9/vVeHQ+qJISUzPoGUIxsYyRFkGg5jqde1e9f+VF5iad6d7DvSeytq1OQ2hOvFJ0T7D8ZtI7WZoBUTzJDToy3cQWnuhf+b0lOs91esKYT6H39UIfMhIWZDH6GfcmyMXMN9XSYImzKKlcvGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691436; c=relaxed/simple;
	bh=abR62XvotnlmKHlaEyVFF2bj4acdZ6OSsYfsTsrVQGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctKsQiZBr3WwY9mvIHf5GII/yCGjhauj5Jhjmc/0/9LXyG79jG0bywNdeEHiQRmn+x6piF4gjk8ZWazBAmCybjxpfyl/ZrmnvubztSAbmMbkprjmDBkDOJwm3FZJgzc7dyGgCxyHRI7m0aoV0FVzs/xLL8PFKHFC6u/2i9gKyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24139C113CC;
	Thu,  2 May 2024 23:10:35 +0000 (UTC)
Date: Thu, 2 May 2024 19:11:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 dcook@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] tracing/user_events: Fix non-spaced field
 matching
Message-ID: <20240502191121.3b3f331b@gandalf.local.home>
In-Reply-To: <20240502225853.GA412-beaub@linux.microsoft.com>
References: <20240423162338.292-1-beaub@linux.microsoft.com>
	<20240423162338.292-2-beaub@linux.microsoft.com>
	<20240502171634.7e2ac794@gandalf.local.home>
	<20240502225853.GA412-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 15:58:53 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> It's not an issue on the matching/logic. However, you do get an extra
> byte alloc (which doesn't bother me in this edge case).

Figured as much, but since there was no mention of it, I decided to bring
it up.

I'll take this as-is then.

-- Steve

