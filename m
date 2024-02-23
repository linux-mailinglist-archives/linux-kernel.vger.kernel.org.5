Return-Path: <linux-kernel+bounces-78459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5C28613C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C8B1F236B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A85F82D69;
	Fri, 23 Feb 2024 14:17:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1972811F9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697829; cv=none; b=O6ODy7Ix6tYAXKSRbkxoO+8c/4lbYY1sfsXOo6ZyM2+5QeUxUbSzIkuFORLzsA2GNwh0NGNfV6G/hFG7xTF04wIuhIUiao5L8Gah/SYiE8wlb9VYor2S6JWxuJgU54WIOyI2YMYFIriJ1rwCQCSaALluYNWgxB/Tl1s0wyqvtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697829; c=relaxed/simple;
	bh=uBv+s4SGLMdbgolqp2QWNEru5imW1UxdLM5GyLNVTUw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ki2iKe/GKlgOakXDzEzOAqrpicCG8lSMCKffSSThB4ypeJhTz17X+dVXyJHPhhYhNm0f1IuZKLTMFKiOF37MrZcedfClQ8xUVNqiFIjdm4Om/pk9JuJ3fGCAb6sNGZV8X4kE91JQrw2K4w3YNLilXGvhClT5WhIu8wirOr7s57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D369C43142;
	Fri, 23 Feb 2024 14:17:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rdWOE-000000077OA-2tYX;
	Fri, 23 Feb 2024 09:19:02 -0500
Message-ID: <20240223141902.554087446@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 23 Feb 2024 09:18:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [for-next][PATCH 07/13] drm/i915: Add missing ; to __assign_str() macros in tracepoint code
References: <20240223141838.985298316@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

I'm working on improving the __assign_str() and __string() macros to be
more efficient, and removed some unneeded semicolons. This triggered a bug
in the build as some of the __assign_str() macros in intel_display_trace
was missing a terminating semicolon.

Link: https://lore.kernel.org/linux-trace-kernel/20240222133057.2af72a19@gandalf.local.home

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@gmail.com>
Fixes: 2ceea5d88048b ("drm/i915: Print plane name in fbc tracepoints")
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/gpu/drm/i915/display/intel_display_trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_trace.h b/drivers/gpu/drm/i915/display/intel_display_trace.h
index 99bdb833591c..7862e7cefe02 100644
--- a/drivers/gpu/drm/i915/display/intel_display_trace.h
+++ b/drivers/gpu/drm/i915/display/intel_display_trace.h
@@ -411,7 +411,7 @@ TRACE_EVENT(intel_fbc_activate,
 			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
 									 plane->pipe);
 			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name)
+			   __assign_str(name, plane->base.name);
 			   __entry->pipe = crtc->pipe;
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
@@ -438,7 +438,7 @@ TRACE_EVENT(intel_fbc_deactivate,
 			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
 									 plane->pipe);
 			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name)
+			   __assign_str(name, plane->base.name);
 			   __entry->pipe = crtc->pipe;
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
@@ -465,7 +465,7 @@ TRACE_EVENT(intel_fbc_nuke,
 			   struct intel_crtc *crtc = intel_crtc_for_pipe(to_i915(plane->base.dev),
 									 plane->pipe);
 			   __assign_str(dev, __dev_name_kms(plane));
-			   __assign_str(name, plane->base.name)
+			   __assign_str(name, plane->base.name);
 			   __entry->pipe = crtc->pipe;
 			   __entry->frame = intel_crtc_get_vblank_counter(crtc);
 			   __entry->scanline = intel_get_crtc_scanline(crtc);
-- 
2.43.0



