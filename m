Return-Path: <linux-kernel+bounces-89871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7986F6BE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8B01F2103C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEB7A70D;
	Sun,  3 Mar 2024 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn12UnbD"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14779DCD;
	Sun,  3 Mar 2024 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493660; cv=none; b=VLN6ZKZruhfH92yUNdc/Au/0V0NQyxJcFjrJMu8P4g8IR+3pEvWsxbIOeIE7z7rhuYcmWIXoGxLdR53LqllgF/xEM/xtli9eOFZpZepz0oZeaJX9JqLwVO0u3ettMpq00bMChvGrAxhBnpKpo3gk8vU8VTDQaq6rrOnDu3Dteyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493660; c=relaxed/simple;
	bh=ZgYDrj0YYvD+dXTAAy8LDU2DHLTSdomYNZmOn8qNHto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a9Bn04GESpcveOrfTkrGWEfuWdUcs/pR3NCTSMWsttc70ivfOaVr1CTa7xAd/1svuA6h48TewFYdlxyG9IvY+r5Jk0iKapMzg+N9osrEQameOXNpn5Gh2XLFVCnoeu1zfZsLgrXS8niBwxJtXXBJgl9CCoRs+dYronR1AFj3Pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn12UnbD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d2991e8c12so37475391fa.0;
        Sun, 03 Mar 2024 11:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709493657; x=1710098457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acUUqPyDOG3LFbF39uA3RbQi0wyLKzhv/SV7pzsE7a4=;
        b=Mn12UnbDjOiyJymPzVsOC4nTFVAZ2B0yqu79QmWKB3Y/EDHEC8+MAqBwC+K80VNrdC
         EyxzzV2Vx82CZeoz/uRcwp3YvuNA+P/cktJ+kyXgvVnV3sjTqIk8AaPF7qAHZdarxJ4C
         Kt0XWfsCgPKljwQRQ+lC9fvIDAFL0O9ody5q2zMoF55GYqydNC8fR1VTXW08PwK9nCgd
         F3f+RRvMdJjGzSArPig2Q2jpVub0aCJ8D2Xq1P93JGaeBBldSNacjXqdqaC98nxs02d2
         BSGWnHxsIRXuTfi0Nbemr8rFw8yLf/NLdxJniBQEjBZB18Fwtkxag//dtInr4oAElahS
         OdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493657; x=1710098457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acUUqPyDOG3LFbF39uA3RbQi0wyLKzhv/SV7pzsE7a4=;
        b=OMJ2TOvpDZwf/28nw8to9Abd1VSuJOrXcaF9s5Iod49WVlEWpow9Dxgl8Yv7PeK3tp
         Zjg9gzUd1hfYVTfXFwdArMLdjVdaESp/57yyT4DPlve8SCKsdLIOUnN8Wpdt9Nypkxtz
         e/4vNod+T2N84hsMYLnL9XbekzwKK4WwW3pZtO87KdFRxFTCGWv3nGdOtKlnWvPEoBAa
         849IH2F95i1ZpcgFx8IDIHlTurUdV+JjkpFwH0KSsBVk5gyq1WuU+tCt4tMJmUYDiMbD
         ahZeX7Ws6WVDO62PZKrhRbAiNM8STuaJW4f0pCmFz9p2iv47/qC3sHDkC7R5SvUqj3Ce
         HEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrNtFiqluj4gGerruZKOAHx7agH+bWFlfLyb7REFv0c9ue5vUfTBJkxSmEznd6O+h7LVp4tqI3ziTv8mET3O1Q59cdxzEpjV4JfJPE8qNK6/Pv6WML2DTgtwn7MR48G2Hrx4oFsadl1Tc=
X-Gm-Message-State: AOJu0YxuGz2hLM3HATrDsAiB2XP3daovu4RIqo25wy1DO9QE310mcBug
	rRXT8NcR3VoTVewmgUYYLFJ0cMeXCfcMR/dzc0d/pPyPNVqSZq4eJKqdtjpb7I5zig==
X-Google-Smtp-Source: AGHT+IFEkey3XDjrh3yGBXOYsA99qGQ33aOIkyZKj28WKcllyhS3hRxdC3Vn8Kz4k3cdTgqQz1Qnbw==
X-Received: by 2002:a2e:b0f0:0:b0:2d0:af40:7058 with SMTP id h16-20020a2eb0f0000000b002d0af407058mr2952956ljl.14.1709493656728;
        Sun, 03 Mar 2024 11:20:56 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id y10-20020a2e9d4a000000b002d3c466adc7sm68438ljj.15.2024.03.03.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 11:20:56 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: mchehab@kernel.org
Cc: mcgrof@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/9] staging: media: av7110: Remove braces for single line statement blocks
Date: Sun,  3 Mar 2024 20:20:33 +0100
Message-Id: <20240303192040.8116-3-bergh.jonathan@gmail.com>
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

This patch fixes the following issues:
 * Removes braces for single statement conditional code blocks

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/sp8870.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 83685443976d..2c30582191d4 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -529,11 +529,10 @@ static int sp8870_i2c_gate_ctrl(struct dvb_frontend* fe, int enable)
 {
 	struct sp8870_state* state = fe->demodulator_priv;
 
-	if (enable) {
+	if (enable)
 		return sp8870_writereg(state, 0x206, 0x001);
-	} else {
+	else
 		return sp8870_writereg(state, 0x206, 0x000);
-	}
 }
 
 static void sp8870_release(struct dvb_frontend* fe)
-- 
2.40.1


