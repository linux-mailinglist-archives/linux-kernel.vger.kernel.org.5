Return-Path: <linux-kernel+bounces-104938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E6587D62E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE9B2821DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3555491A;
	Fri, 15 Mar 2024 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT+cBjul"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8EF548FA;
	Fri, 15 Mar 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710538325; cv=none; b=MCOxaN3vNY2NIPE7hTMbxRRnDKsoM79vzxqQPN742kkcwA8GBcZu30OBdARYmBs3l2u3sfymwxnjIBFXTeCNfFMf8jGTVCYk5iOhoShIXpBSp6VPQpS2Qhp9csEPYYLb5T6eIx8SkbkFYzF3yS7yh4thnBZrCsqhamAQSnNtKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710538325; c=relaxed/simple;
	bh=kI3FpuAUIzIJ5YpNjrE1DZ6tCTgLd+HtXmRoONaXbJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tPHRP3yeoA6GvN2utaUIA3tTG9XlKaVxe9BOkpgXwTbFWs0hdekc8sJqixCaWKfbhJ2oPNZcNONovC98ckXmMmMvS/4bwvBpNjQB50HXelVvwSMthwa84hO7ON8dy7mZYvFkFseBjS1u6DM3z82PBX+ht/Zr9c3ddN3JKFqUoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT+cBjul; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc29f1956cso18099245ad.0;
        Fri, 15 Mar 2024 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710538324; x=1711143124; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ql5/CZn2RtGTQlI61ALXwrW8731eNL3M0vcE3ykcjDQ=;
        b=dT+cBjulfHBHkYtUnRAu1PodhY8MvJA281iqto+kH65pRuH5wFZZjerMjGQaid4mdw
         fPJx0rXVbckN1P8mmK+qG7IXHg3Azrm0L8/vXO1sVJJY9MUGnkEdd9Kae41PY/ecM/Yn
         X0mJYu5IFDc79P5qjwmtGIEVHjJuR8blUcY4yokJavPR9fbXlq24w6WEpzh3G84udxBc
         azvLIBY2oGVVGyAqJj7Ysq557EDPuGoH/USPoDlwO0dZ9FFLxurAIhFI8mIR70y+4yGZ
         WJc9Zpn3Q4VypeCQ33IIspz+doKk/0HuYQ3PcOxGFj4cl38VdmM+RqrWDHpv41e0dIHo
         u7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710538324; x=1711143124;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ql5/CZn2RtGTQlI61ALXwrW8731eNL3M0vcE3ykcjDQ=;
        b=wUglw7S9B3Suu8bMaEpAMPzvATvjGc1wX7MzVY3+5Yzro7FH/uxfzqtk0eQkHeRJBc
         Q/whj6cW0WIm9Y9VEavL7ZyuZCYDxnBll34shdWfyBHgPI6IDIu3EyEhxtVz12zlin6m
         tmwqmACOCe7vLZlk/O8BDpb14PhNsm4YlJ18NbUr/KCilWJCFZAJTzYoTbSL4OoX+1k+
         rtefnjA3af6jqPVZ/4kJJGSnU0QyOWshaBEsqsVoUHzXp/3CmHEkI0hVqKeyZZeqURoB
         Dr2vUlrDOCXb0I5Cwd01pNXIfhiPKnf55exMcq3dEg4FyTZh99IFbyCynFHOnhTx3gbz
         ucPA==
X-Forwarded-Encrypted: i=1; AJvYcCUGyo+JEbns9bDuDxVbXw7GmnOXNBDoWVV7+Z+MCJatdt6+zN2PqtDQhbTaJtb+nP0kpdQO8ZI/m8kusNN0s0N/JT1mKW85xg/LN0I+++kpoS4OaNy5cj5E9BIuWa2bd06grdV0ZFZ+p+o=
X-Gm-Message-State: AOJu0YxexrTo6TMywsqhAEZ7PqMx8Pe2JuMsbqSoJ9dFn9kF+X55U/9p
	5w1awxHdoa4az+VrtOt4RsMNMXGZKdsHyAOqpfqFG9bqqMuG8ZE7
X-Google-Smtp-Source: AGHT+IGq2m6m0XKukC+zMZPHwWnmwOFptJAIRQ/jUEi1zvutS2LuS4RGpVQGVxHy/NR/2poQBzBUQg==
X-Received: by 2002:a17:903:22cb:b0:1dd:66d1:a62b with SMTP id y11-20020a17090322cb00b001dd66d1a62bmr5176084plg.5.1710538323770;
        Fri, 15 Mar 2024 14:32:03 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.124])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001dddc21866csm4364301plh.103.2024.03.15.14.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 14:32:03 -0700 (PDT)
Date: Fri, 15 Mar 2024 15:32:01 -0600
From: TaheraFahimi <fahimitahera@gmail.com>
To: Marc Dietrich <marvin24@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: nvec: edit udelay comment
Message-ID: <ZfS+UaVyob+lFmmS@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Signed-off-by: TaheraFahimi <fahimitahera@gmail.com>
---
 drivers/staging/nvec/nvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 282a664c9176..b4485b10beb8 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -712,7 +712,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 	 * TODO: replace the udelay with a read back after each writel above
 	 * in order to work around a hardware issue, see i2c-tegra.c
 	 *
-	 * Unfortunately, this change causes an intialisation issue with the
+	 * Unfortunately, this change causes an initialisation issue with the
 	 * touchpad, which needs to be fixed first.
 	 */
 	udelay(100);
-- 
2.34.1


