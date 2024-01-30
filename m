Return-Path: <linux-kernel+bounces-44442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9945B84221B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E6628A117
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC766B3D;
	Tue, 30 Jan 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kl530pN3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670C66B2E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612398; cv=none; b=o+BxgoYHRvrSY8ZA56waGjU99RiOfbgLINCpphAByfSe2XQCYBPjPSSUB56fldEwr+aRRZBrVJqIw5DFXk8NBvWZr567lwC8NMVeJpONphWZrWLXIGI1jIuSNl7d1zscsDbIaURXVB1lrFMJeCXuTb1kxce8p8GFQctwqOYR3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612398; c=relaxed/simple;
	bh=udOcytbH7mtJOTHt3bS5t9BxYLH3RKUDDy+XlX13Mlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oayd7ejAEMtqUUZRbpLx3YJCUwNepQTxzXlZMqXAyHGXhrOOo1i+vXWo1XycZXrc5XlQeOTI7UWJYjDSOIPDo8JbLMWH4+XGfzqYjzfQtqtHASv57hHTgjx/G+uy7vx0jiyFyz5T34egRBRZn9cnqYQE1F4YqMXt+6VtKVLCeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kl530pN3 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 338D840E01BB;
	Tue, 30 Jan 2024 10:59:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WRxMG2SDOxr0; Tue, 30 Jan 2024 10:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706612391; bh=S0KbFF8EBNAGRRPAs/FZoki99W6fAqfJea+07pwpvKA=;
	h=From:To:Cc:Subject:Date:From;
	b=kl530pN3uUblU+FKbX/ueEozkYtTk6WKYK1w8YlwikXGKiTloBTHAXTwQabNUZg+D
	 qW2SxJ7JxTXJuTZANhmQqHqAeYSTnUQJNJIGxxGMwn0sw4OkhbTCyWeKgirLw4Oyyh
	 ptFqgXcf+uflEqaJiWriRjjpujV0x31ZkBTKBugm89JZhBdyYBj/YaB5+Uq1vHxiwJ
	 a0u4k9M0LerSZQ0NfyFueodTMh5Gn1/ZsC53NkbhFOBrj+qr+S+7ssM1cmqdCm8C0E
	 aJc2nYXDgK5i/yhtIBwl15A2f1DiAsSq9OHOzrim8VFTDyHlqKKd3IYbMeWP9Z8feI
	 EYOEOnTPU8kSJGd8u3CIy8AlYJOqdMkm0rvGTGWKm93gF/P0fiBM+VGgdLPzk9eu9y
	 IoWcLxXFFp6Foyb9gLzl/UPa6i5vxIDmgJKfC/cjvGrctk6iC3fI+0Sdz5wgyxAJqN
	 ZxJui0cOLV36kG6WsRGLH2uDwQOhogct2Uh3obd6NSdSC3FzZiqzDiTcop2fkji24V
	 XSC/bmMQOxKsfgnaZwUJQhYuI1dhf1nayhVeY6svlNroLxFsTFqtS5kiKF53BrNQlk
	 0b7bPj4tQfSdjyJ7ff8Zig7ibpeNnsuTiHMTUio2z6uxq4e252Ih3qfYuULxl8I7zK
	 ieo3Q3ORKqcoF+sUtTxcSy8Y=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31A0240E00C5;
	Tue, 30 Jan 2024 10:59:48 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] x86/alternatives: Do NOPs optimization on a temporary buffer
Date: Tue, 30 Jan 2024 11:59:37 +0100
Message-ID: <20240130105941.19707-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

here's a small set which sprang out from my reacting to the fact that
NOPs optimization in the alternatives code needs to happen on
a temporary buffer like the other alternative operations - not in-place
and cause all kinds of fun.

The result is this, which makes the alternatives code simpler and it is
a net win, size-wise:

 1 file changed, 50 insertions(+), 72 deletions(-)


Constructive feedback is always welcome!

Thx.

Borislav Petkov (AMD) (4):
  x86/alternatives: Use a temporary buffer when optimizing NOPs
  x86/alternatives: Get rid of __optimize_nops()
  x86/alternatives: Optimize optimize_nops()
  x86/alternatives: Sort local vars in apply_alternatives()

 arch/x86/kernel/alternative.c | 122 ++++++++++++++--------------------
 1 file changed, 50 insertions(+), 72 deletions(-)

--=20
2.43.0


