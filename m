Return-Path: <linux-kernel+bounces-33189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7878365D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B2EB226E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED83D575;
	Mon, 22 Jan 2024 14:50:51 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED4273FE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935051; cv=none; b=tp57MRU9AT5+lT4zSAcrH58yZtu7niunrrPMYRpiT2vkiURKbdRAga9Y4jSe8nZJnhIqrdqvF2eyrf3s1qrJHKjlNpTr0hR+lQzouBcQNNP9l/77ntT/s//K+Zrdlw3DbB01vYDcwsActLicWAXIZnPAMKwhTZt7hQbkILT4hQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935051; c=relaxed/simple;
	bh=S4OC+8fKxjC9Gfe3c0fpXSdUtwCq477IvrBjcmJwprs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T0VCi7PuprX/J7O00SVvLuPbv8n2g9VWWfYfA1kUPVpbYY7N5voVhPS91/9gnqAUW651wMauC5uoaafsmWEQ+a1y+lfaXxcUQF4anwrQJ2mWQSJrfcMTD6u5G5ytoeyGnQgLr7CZsMEdIjwA2pLQQ4M+gKWS42lAJP5/5gRexk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:955e:bba5:7ff4:cfb6])
	by michel.telenet-ops.be with bizsmtp
	id dqqn2B00h0ZxL6o06qqnHs; Mon, 22 Jan 2024 15:50:48 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvcc-00GGyk-PE;
	Mon, 22 Jan 2024 15:50:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rRvdP-00CFht-Of;
	Mon, 22 Jan 2024 15:50:47 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] lib: dhry: miscellaneous cleanups
Date: Mon, 22 Jan 2024 15:50:42 +0100
Message-Id: <cover.1705934853.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi Andrew,

This patch series contains a few miscellaneous cleanups for the
Dhrystone benchmark test.

Thanks!

Geert Uytterhoeven (3):
  lib: dhry: remove unneeded <linux/mutex.h>
  lib: dhry: use ktime_ms_delta() helper
  lib: dhry: add missing closing parenthesis

 lib/Kconfig.debug | 2 +-
 lib/dhry_1.c      | 2 +-
 lib/dhry_run.c    | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

