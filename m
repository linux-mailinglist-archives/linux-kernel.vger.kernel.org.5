Return-Path: <linux-kernel+bounces-77191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1228601E8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2169B1C264E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A101B143C5C;
	Thu, 22 Feb 2024 18:42:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873073F21;
	Thu, 22 Feb 2024 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627320; cv=none; b=RQuAuC7cV1TXDnIAlL6ghx95h2g9k5cIevuH3/SginzmmAhn5NYZOhDnGfXPFC3Rhb3K5uEUmY4GuNDVwoxtJc4aOvjoZpSk6Kls8wdE7YT6hFmYk6eAlP8jP5jE+vElTMU3v4IG7F4NvUVhrBgla5uWnB9OGG0EImbRdfiSEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627320; c=relaxed/simple;
	bh=hKALnhFJto5r+V30fxKC0f0D56pLx9xeU/sxkNovT80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UX4+qpSvrCxX3TjXFUBfDD92bh7+DpkhazUSR/vgbEz1tz/Y4Ce5w1HgbDBT5DGvSSFUK4YQO96FyxPwAMThBb2WxI1gCZURoIzQty7ilkxyhBFWVbcBxkr3Bc6HvvaktNBozmb+czGuc6Z/MinpV+DQ6wIGvXym5mPBCoZDebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6731C433C7;
	Thu, 22 Feb 2024 18:41:58 +0000 (UTC)
Date: Thu, 22 Feb 2024 13:43:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, "Ville =?UTF-8?B?U3lyasOkbMOk?="
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, David
 Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/i915: Add missing ; to __assign_str() macros in
 tracepoint code
Message-ID: <20240222134349.1e9a155d@gandalf.local.home>
In-Reply-To: <20240222133057.2af72a19@gandalf.local.home>
References: <20240222133057.2af72a19@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 13:30:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> I'm working on improving the __assign_str() and __string() macros to be
> more efficient, and removed some unneeded semicolons. This triggered a bug
> in the build as some of the __assign_str() macros in intel_display_trace
> was missing a terminating semicolon.
> 
> Fixes: 2ceea5d88048b ("drm/i915: Print plane name in fbc tracepoints")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Note, I have patches that depend on this fix, so if one of the maintainers
would like to just give me an "Acked-by", I'll take it through my tree. I
doubt it will have any conflicts, unless you are planning on changing the
given effected events.

-- Steve

