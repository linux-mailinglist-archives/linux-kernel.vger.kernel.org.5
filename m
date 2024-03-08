Return-Path: <linux-kernel+bounces-97604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE54876C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9252821BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C494604B0;
	Fri,  8 Mar 2024 21:31:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADD5E096
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933474; cv=none; b=STe2kBeq75ebXwkwXLclhEEL6cL0kHMU2xOvQMLZLmk5YW0aPhmnbc6RvXGxacXS/3xnZ440heffr0v4jPFzfOmSIqiqMg5fEFT2L+s2a0OIxGqmK5VUJ211OXazwGAabIi4xAcfj73FN5RyqBqngMVg4LFKBhNg/1ifeYSaHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933474; c=relaxed/simple;
	bh=QAJ8fJK21sztPMaHNltW5WJdbf4tRVa/Fcbxf1vHrac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RwTu8B6SFLg3Rpkssc1clpbmLPZwfj+E5KEwL6ZIzFps817wZbDVFJ1+B+cNLFSBnobQuLlp1vn7uA3hpedc+oB8auyuJhWAEtNAtF7rbXV1WunKrG14Ao3q+zNRGx070BuRyFHauGYm53K7q256VUQQmfaNv+317N6HxNJgnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riho6-0004ej-2Y; Fri, 08 Mar 2024 22:31:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riho5-005D0I-Dh; Fri, 08 Mar 2024 22:31:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riho5-002WXE-17;
	Fri, 08 Mar 2024 22:31:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 0/2] uio: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 22:31:00 +0100
Message-ID: <cover.1709933231.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=QAJ8fJK21sztPMaHNltW5WJdbf4tRVa/Fcbxf1vHrac=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl64OWlGAXnhXJnnmZV7Vc0ZxPpoq6IG+ycBGDL dyM8MLFSoeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeuDlgAKCRCPgPtYfRL+ TjYACACiEbHqG0Js6SGv38TbpOU8bS5nNTn5NQV7yiRIHcB5Aj8RU5FjYjMyWSYpPZZ5E+tQteF dV8IQjuHaArHgfVAhTGwk04dtP/FJXgZqohTLMB1U9tMz3NMqWZgKfTyaTzkyrD4VUNb0VKakqD nleCHwTvTFWgLLVfsECMEgDnRQ/u3xjOhTd0uQBGLe71HaQcsZq2iox6hloUPb1meA4EsITP8Od /9tkY8i7gquHN09t6ZIDLkvW52/nHmlOtII4BCh/jzfrbkLcnpL+GWSfvmOQsWZhBkbaphEztHP Wrjx0gIoKiT3VQW/+34OqUPqYCVunb5Df1PbdhPG2kCEm3RZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this series converts the two platform drivers below drivers/uio that
make use of .remove() to use .remove_new() instead.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.
The TL;DR; is to make it harder for driver authors to leak resources
without noticing. The drivers here get it right though and so can be
converted trivially.

This is merge window material. The two patches are independent of each
other so they can be applied individually if necessary. But I assume
and suggest that Greg will pick them up together.

Best regards
Uwe

Uwe Kleine-König (2):
  uio: fsl_elbc_gpcm: Convert to platform remove callback returning void
  uio: pruss: Convert to platform remove callback returning void

 drivers/uio/uio_fsl_elbc_gpcm.c | 6 ++----
 drivers/uio/uio_pruss.c         | 5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)


base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


