Return-Path: <linux-kernel+bounces-77254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DA0860338
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF76BB33A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728A548E9;
	Thu, 22 Feb 2024 19:25:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7A14B807;
	Thu, 22 Feb 2024 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629954; cv=none; b=GXLlrNY7UDSDo3msp4UCIOa/xYveBh7Z6axb32jYdUI1WzHTox2NBkEV1Ja0Ne9aNjXYe2R9KpA2xCzQawBjD4SZSYYeiqvr53KRlhyDK64a4Na3ZkXO1TkhL+nxJeRxrIh8GjrpYrdx2djJ9VXATRMwzNYioHulHuDIwa8PoFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629954; c=relaxed/simple;
	bh=Lh3bL2eQJL7g5kg7cwQk3CBNA5SsIWGK81bMP8Jzb2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHCOC588S+oOKn6CwRnw6ktamHhi3AnhY4qBlnNZ+CC8euQBM7fj7AKAGtzOrCGFJjizSiXEkH9HPQbWHf7iJKPX7E+qGkMowkDslOb0IJzNBxfRP5qRrTuSKoUCH1sPJZkyCmdXSiWN/0Gs77ubNFuD2echqH+Hw0p8x1md8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB39EC433C7;
	Thu, 22 Feb 2024 19:25:53 +0000 (UTC)
Date: Thu, 22 Feb 2024 14:27:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>, Ville
 =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Vetter
 <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/i915: Add missing ; to __assign_str() macros in
 tracepoint code
Message-ID: <20240222142744.177cc877@gandalf.local.home>
In-Reply-To: <ZdeatNbtahdEWMXV@intel.com>
References: <20240222133057.2af72a19@gandalf.local.home>
	<20240222134349.1e9a155d@gandalf.local.home>
	<ZdeatNbtahdEWMXV@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 14:04:20 -0500
Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:

> > Note, I have patches that depend on this fix, so if one of the maintainers
> > would like to just give me an "Acked-by", I'll take it through my tree. I
> > doubt it will have any conflicts, unless you are planning on changing the
> > given effected events.  
> 
> since it is not breaking builds on our side and the conflicts, if any, would
> be minimal, feel free to take this trough your tree
> 
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Thanks, much appreciated!

-- Steve

