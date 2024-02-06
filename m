Return-Path: <linux-kernel+bounces-54131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF6984AB45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19411F2567C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E04A11;
	Tue,  6 Feb 2024 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT90LBri"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845144691
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181064; cv=none; b=VBOcq4ZbOk8479PkoQlUQVq/azJAOsow1931DGGvTupsF+45EDim1d0CJORCY4Uj+w7yxw5RPzyykLFPLwJbzNuqzt0WUJc1VzbxqIBk9KR/jUxB5r+sr/6CslTqODyA4O7h3Va0zhCmD2mGH+79yxOLbgp8VNHdTvMU6QUjEVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181064; c=relaxed/simple;
	bh=ok49kJM8y/x7RmBBmqh9U3hShX87+wb1f7woelwME4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p45LK/SeTvx2fiK32VOPdmH8mx77cBlAl7yaqMnCMY/e/cz6gQyBo5nvqEI1sLhREbwVXilEJHAmaXOrrigiqQHCjVTZ/S8CvSmYknsnFRt8zKtvdpPTIrPabCXKCoKOPwWgnrlEgy+fbwdADZkllLZovAZgRx3Y6ibkw5o0K9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT90LBri; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb9d54575cso3724315b6e.2;
        Mon, 05 Feb 2024 16:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707181061; x=1707785861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OU1O/t6B4n3fpcxc2rzwTIxP4GOsUQD40kyYtZYv+NA=;
        b=dT90LBriCuuM+BdwDrF+imE5T8+mmSfx/HAw42ya228RwrI1nMdF5VEzZUJRSAXxhp
         zf2mO1Q24g1R7PNMWr4aMvMEA57AiNA0+FBUiiWM9tMQ+5ciGclWAonMDYawQQODVOZL
         6msZEt3J0+cCIlPe1NHLAcHMDwiQNodM99uZRxyT+Rx4y0sXFDRooqodIyQtFvG6wxLb
         KCM5nBBtZQfayY+FdOwYgw0lSqzQXyuNIZjQ/Ef1zQunnBJokxdm/XMc769Cav6SRx95
         JOLCPZ+KPZ8O1zIFrMXAopcY/I8rP+ECS1krLcKQcFkRNJm0GVLVsX8ceL17v8asM4t+
         Mg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181061; x=1707785861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU1O/t6B4n3fpcxc2rzwTIxP4GOsUQD40kyYtZYv+NA=;
        b=BvDWHwUXEDXNhUxKxVJxUb+hNoaV/K5MaRDHvyDFcZ8B8hQgEaguTPJ2B+Ig9GEAp1
         zWKgahTC4Zi6+FvaK+5A/eei0zWNCIkuSJJpYrOPPT7k6ZgYLAK4fQsYcC3W/OZKlR62
         LnTLi37qJgIEhQm3N435h7/OiF55Gf0AOO1i1CqzywFI+IXSW1ncLmz9s9g2A5ozSFqj
         3dEUKk9GNYHVWZ+qUQ6aLVuElLnIaoZSSQVL8BbxknxHQuRwn0y3qO1MNLSl9aIBXT2n
         uszQA4oToWoEV8gZwwFada+RTX8/gkUiklaFX1tHDclciD4dWJx9Bzhld1KDDhyyyGTj
         NnMw==
X-Gm-Message-State: AOJu0Ywd7eNzlf516oi79pEnZB6dOYJgRftKPzc8BYDsOLdkaHBbw1fx
	vVD1YGEjun8lz6lEjkMb5IWvjayLgjvrPBiViZ1j8+tWvuR5wwiN
X-Google-Smtp-Source: AGHT+IFsxpABHpqh4gpVMyqHPcPViWu9lJk6jC0l/VRZnrly6YHRy1+CWAFCiXr8q4mbiwFDbLbIOw==
X-Received: by 2002:a05:6808:19a:b0:3bf:d4fd:4f64 with SMTP id w26-20020a056808019a00b003bfd4fd4f64mr1360914oic.25.1707181061614;
        Mon, 05 Feb 2024 16:57:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXdHbdcG1m4YfSni9GmJdgXhfmXH9lG07fbgKhdKk8p7Vs/TNCAUj8muoWsaEoCUysGJkPyb0BcZsRKGtubzHpuCsX9WGujeBcY3YiLmyuhl/44rkkuuC53yebU82dhHV8AuODOArBmR75mmjnOP5Cb6W9Akguo5mfRCcdEDBBSM4x6F3MddGiMX3KedN9hmH05Vh9tZvWhSZtPvtaXNl9BkJzAbjgOaqQr4RNPLbE9E6K/J+lgAVQj7pkpM+OZVDE4EnctjOSWYBNSRD81+KyQZpX30M0WgXw5dK5uvU7W
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id 3-20020aca0903000000b003bfdff46f1asm155872oij.34.2024.02.05.16.57.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Feb 2024 16:57:41 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: Jerome Glisse <jglisse@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	John Groves <John@Groves.net>,
	John Groves <jgroves@micron.com>,
	John Groves <John@Jagalactic.com>,
	John Groves <john@groves.net>
Subject: [PATCH 0/1] Correct a comment in include/linux/memremap.h
Date: Mon,  5 Feb 2024 18:57:36 -0600
Message-Id: <cover.1707179960.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correcting an error I ran across while working on the devdax iomap support
(and famfs - both of which are coming soon :D)

get_maintainer.pl was not very helpful (just
linux-kernel@vger.kernel.org), So I'm copying likely interested parties
(most of whom are in the vicinity via 'git blame').

John Groves (1):
  memremap.h: correct an error in a comment

 include/linux/memremap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


