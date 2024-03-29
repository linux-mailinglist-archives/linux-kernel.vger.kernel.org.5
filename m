Return-Path: <linux-kernel+bounces-125068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8952891F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671091F30F12
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329B5143C4B;
	Fri, 29 Mar 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfzpyN47"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6416143889;
	Fri, 29 Mar 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719323; cv=none; b=PF2Q+SwcX6sqVXG21xpDHE3y6qXDJfqANPy08YjwKYBWowOm+H/VnmqsAkfEeptIZ0vJ2HFMrTKAyWmUVKOHZ5KOX3RxeTS5kXx0Fk8JPwxxQK3IZxLV8PcB4dmLrIqRSqNG3x1DzW1i77xnuph77s1dDJv50FnQHIB1QzJ7n3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719323; c=relaxed/simple;
	bh=DeVjDjgAaNp8OqOKPW/Hx1Bpl4U8VaXR8t8x8PdRezU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYU8N9ZdSHEj+lJDX4FYHNWXLrycSDpPiqp82zKgF4/9KoXqBq2EUY4RKn0jfs6P565kp/AaiEZvq/B9FWN75HCJvnHXu55cgH6SOoTYIJmKGlsWZ7Q5A+neEA45vZW0pfUZLgne6JkpAGBKwE3F9O23VmGKwCCkUZS2e5rRueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfzpyN47; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d718efedb2so8822051fa.0;
        Fri, 29 Mar 2024 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711719320; x=1712324120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mdX+NaUvjLzoIWlasG6BkIYssuCP0CBEfyEvr+GPt+w=;
        b=LfzpyN47VAREg1DyYbP8LBTJ1SyRR4RvjZsjLmSSgHur0ZnHFWoeY32uqiP9grvOVH
         CXDCPKkde9bg02loPab3duGZ03BOzaIRP48bu09v/UlFGU/wQF4RHWob6Dw4EWKPYQwE
         zdF3vvdUhvDWtx6JDZ55nqdm8UGMkTf2uIReVzJ4MMiwd4u/PJM4BiYpX/OF/YShKeqe
         7PlYRB35bgNdQZ0sWDIrPJ9cavS1O9m4ujhtFHgzAOVSu0c2DWMGBByCgFgg2F89tOeA
         s+09IjrgbgmznE9mtwQFeJZIgelcKeIvgvPB3vDxc5/qJ01+XXLdkikqh4CIEAkf97iu
         fyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711719320; x=1712324120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdX+NaUvjLzoIWlasG6BkIYssuCP0CBEfyEvr+GPt+w=;
        b=oZnkGG+IXHFwg5RtVnSwd+NkXjOw3cGzH4Hm+pIco6XVeRb3Gjj2b3DuazjkF39gf8
         lWX6o5anlWrKsM+GfCWSvNTJtQ1/n8z98Rbitb0ZooNc2wYRTwK2Xkiyas6zFJiYVdcK
         e/TibAxmjR6hVAZuTc052/3Kxh0B8+lwSaV973LbGGYQA/OR7WyLfl5wioyDz8m8aRl3
         gc93evvwxpZKUvFGAIFc6nJ8mCAkGv5HoLJeecPhNtg87eg5OVIxpq1lcmvnx3dryHUx
         6YgTRzjn0kM14WwbNDBHHqadn4yL+Ra+SUaeLHpH9m57gfk4X/WLChHuzfztC4W+MnC1
         kEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpSWMOxSEg1aswf+GXN+njgds86i3zXkZyKbl/aFGZeRHg1x6nBiqU/ftIVl/M0CBcgG8EPwLHCjvAz+68SabCVhhWePBoJpDqngeoVkeEbXTMZao7oh/I3InwFaa5OoyPTs/ZzJRU
X-Gm-Message-State: AOJu0YwToGYAuv8D/zseyG1kzHX+REUMxYVSQgcauRMOD2XzedkQzOzo
	TThAuSLJxP3L+jevJVUaxzZhMkiRhJV7xxsOxlwCCMz7WAuE0oXd
X-Google-Smtp-Source: AGHT+IHGgNMuqJZbqwHOAPNjSebEC4PFHvtmvbXXV4nHS5eZLG9tn+9ib0eMqHefmU8r3oCefHTMcQ==
X-Received: by 2002:ac2:4add:0:b0:513:d5ec:afb with SMTP id m29-20020ac24add000000b00513d5ec0afbmr1998626lfp.40.1711719319704;
        Fri, 29 Mar 2024 06:35:19 -0700 (PDT)
Received: from fedora.fritz.box (host-79-34-203-60.business.telecomitalia.it. [79.34.203.60])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906135000b00a46ee3c31afsm1921408ejb.154.2024.03.29.06.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:35:19 -0700 (PDT)
From: Francesco Valla <valla.francesco@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	fabio@redaril.me,
	Francesco Valla <valla.francesco@gmail.com>
Subject: [PATCH v2 0/1] Documentation: networking: document ISO 15765-2:2016
Date: Fri, 29 Mar 2024 14:34:40 +0100
Message-ID: <20240329133458.323041-2-valla.francesco@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the in-kernel ISO 15765-2:2016 (ISO-TP) stack is fully functional and
easy to use, no documentation exists for it.

This patch adds such documentation, containing the very basics of the protocol,
the APIs and a basic example.

Thanks,
Francesco

---
Changes in v2:
 - rename (and re-title) documentation to to align it with KConfig option,
   using ISO 15765-2:2016 instead of ISO-TP (the latter is still used for
   brevity inside the document)
 - address review comments
 - solve warnings coming from checkpatch and make htmldocs

Francesco Valla (1):
  Documentation: networking: document ISO 15765-2

 Documentation/networking/index.rst      |   1 +
 Documentation/networking/iso15765-2.rst | 357 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 3 files changed, 359 insertions(+)
 create mode 100644 Documentation/networking/iso15765-2.rst

-- 
2.44.0


