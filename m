Return-Path: <linux-kernel+bounces-77195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF398601EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088E31C26566
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FADC54913;
	Thu, 22 Feb 2024 18:45:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC9548EA;
	Thu, 22 Feb 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627511; cv=none; b=qqMZ+0+UZ+QNhsDi1+fZMe4TW1YwO0ha+rc3j391a0RRKnNmaPAz2nGXkR2GlvSfz63GBoJfQRR1NTA6t1jPa/PdHY1q2J8jUwBLGi46GMVeUaQugYOeB2DCayfthHVriNNlKghhp8JEojpBB/5FXLK7l6spyVHlQP2yc0+d+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627511; c=relaxed/simple;
	bh=ee03aKfFxuX5GQPwbf2aUU3EIerj2TUkkcLr7OFMdK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCAROv3jsCL7hBIckUxr6QKBxSaUJyzaDGusJnKBg2SnrhpnzChcEaK0aMXg8KGFZNU5AhgHQUfIN2SKbYI8oE7XUa97JfNJTs7KbmBOEh0rMhrrfCjpgLDaMUYTEIcbwjS+MU6bn/jRZV8W2j7AtbGj/7LHM5eyZqDf7XnACMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2731C43390;
	Thu, 22 Feb 2024 18:45:08 +0000 (UTC)
Date: Thu, 22 Feb 2024 13:46:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, Daniel
 Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/i915: Add missing ; to __assign_str() macros in
 tracepoint code
Message-ID: <20240222134659.0a2bb63e@gandalf.local.home>
In-Reply-To: <ZdeVs-rlk4oGEOs7@intel.com>
References: <20240222133057.2af72a19@gandalf.local.home>
	<ZdeVs-rlk4oGEOs7@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 20:42:59 +0200
Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com> wrote:

> On Thu, Feb 22, 2024 at 01:30:57PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >=20
> > I'm working on improving the __assign_str() and __string() macros to be
> > more efficient, and removed some unneeded semicolons. This triggered a =
bug
> > in the build as some of the __assign_str() macros in intel_display_trace
> > was missing a terminating semicolon.
> >=20
> > Fixes: 2ceea5d88048b ("drm/i915: Print plane name in fbc tracepoints")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org> =20
>=20
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>=20
> Do you want me to apply this to drm-intel or do you want to take
> it through some other tree? Either way seems fine for this stuff.

Thanks. I would like to add it to my tree as my changes rely on it.

But I think to do that, I still need an Acked-by from one of the
maintainers listed in the MAINTAINERS file.

-- Steve

