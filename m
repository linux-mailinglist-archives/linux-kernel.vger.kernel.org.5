Return-Path: <linux-kernel+bounces-89878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632CE86F6CD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D691C21127
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918587CF37;
	Sun,  3 Mar 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1UTb49q"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A87C094;
	Sun,  3 Mar 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493671; cv=none; b=rBy3I1tOKNt52eMeO/ugDJBsFIw3h2usmBrwE6AW3zXZ7biPu28pDcCz9vQ0ad0G9Jj0kAjM872Oo7DsP233KIjPhetBtqjGA1Wcb9rEyV11WV8E6PiEM7yWNDDSjk5yjrS64zdVwCSnMtyceVMsUThIbGSSHSIXftr//GuyYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493671; c=relaxed/simple;
	bh=HbF8PhOHWXzQebb+281vK8rEhxcXGPsG5YmKmH9qB48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpmbW2vfqprzhI6Qh6rZCeCQI/TWto3eaSVLWd89DyIo8+hMDQbIee9xBcuN4RvOhYrgIMuw7Eetzb3M6flSdFvuUuY9LwKEl0ANFBGh402JV3wYU0dWnbu19OOwWjwBTGc2UjuXOTEu3goX2yJWqnk0fuFDAsfCNijtP+NsZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1UTb49q; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d269dc3575so32378001fa.1;
        Sun, 03 Mar 2024 11:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493668; x=1710098468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1NBB/w/tNKdMZAaK5g6A1PLO2nptHAk6enBO1WBgZQ=;
        b=Z1UTb49qL2HPpX8fTLsSPTPP52LQOr0MG+0ThTcwSfgl4MCQkf7+P3rMNsKMz9HlkV
         uRSVz7sgEoFFF2IiPpo2uXb3EwSPnq8O7nfdmfyhzBYkxs2j7SXRLHWMlR7RVLMMQqbR
         yShwR1QpwlWWLFeIvTCJx+rT/J9uq5/JfwsOo0noCSmcckohxNVTBbn0F3ZXTXZnA13l
         2yemL47JudLkzv6IMuMLHLhELXVrr15uK69lcs1W7N6qCooPiNZKY3ZWYz0+Ql7cnRGb
         3ghRrZiNYAMJpNAZuevgWSgGz069tprc7iksDJ2e7kR/8gu+aJbEQt1Dbr61CJlHN+cA
         730A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493668; x=1710098468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1NBB/w/tNKdMZAaK5g6A1PLO2nptHAk6enBO1WBgZQ=;
        b=ICnAJglU8MDIISoPmNlD4Vr2ICmwse1ISEHrHEauD4B0562Us4PZabo/Qme74oS8P8
         fV52m1YPvvy2w+a/lfjQOYvak7k7v4Xul4IY+YhQmxp2Rh3PKhyqsfFigIxy8kMYbos5
         gVxrBwmF4dKngzWqnETRSMsRNQxqFJF1no7xv1CYmAVctYRCuSFLRG+17VJPjr0M5896
         mj9yUgMN6lPoW2jWF77xX/5eQ3cnhC22RiFhQJaUJgrExr/lu76h4zpBEaVuT8Mo+H5U
         sXo0f8fs5bMWIjsVgL52PgHdnYVwF7xUSGVQd9HN6bU+jnikMuRVsGRBLJ5XtnhmfqFw
         UruQ==
X-Forwarded-Encrypted: i=1; AJvYcCWldB7eH3N4Z0V6sIkzgv4MY/r6gBWUyl2/A9UFevnQJr+c0HbZSBiLJ6yN7W1gIfJ/dn38gDdhb7mSe+rCxi6tZ4j9rbgALBjySRkIZYdZV9/n2LdTidq2maxayTaFTGzd1zlNjwvVhy4=
X-Gm-Message-State: AOJu0YxKl66us2qO85+wzOxEDBi2TvlLEgCOGTmgrmm27Mdipu7cOhxA
	r/8NA3/rgYdpRKV/JVgyvXUVTNAG/5HGei9cehn805KxC0Wqzpzd
X-Google-Smtp-Source: AGHT+IFCdKjU0W9mTDjumHrBpz5piviPHr5+0eVAzAPOVxFlUryE4CqRsVq+4HKGKE9pwhUuQH//Jg==
X-Received: by 2002:a2e:b602:0:b0:2d2:864c:8467 with SMTP id r2-20020a2eb602000000b002d2864c8467mr3020394ljn.20.1709493668462;
        Sun, 03 Mar 2024 11:21:08 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:21:08 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 9/9] staging: media: av7110: Ensure newline after variable declarations
Date: Sun,  3 Mar 2024 20:20:40 +0100
Message-Id: <20240303192040.8116-10-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303192040.8116-1-bergh.jonathan@gmail.com>
References: <20240303192040.8116-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following change:
 * Ensure a newline after variable declarations

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/sp8870.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index a3c7660c5092..f652c8d7d2ee 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -538,6 +538,7 @@ static int sp8870_i2c_gate_ctrl(struct dvb_frontend *fe, int enable)
 static void sp8870_release(struct dvb_frontend *fe)
 {
 	struct sp8870_state *state = fe->demodulator_priv;
+
 	kfree(state);
 }
 
-- 
2.40.1


