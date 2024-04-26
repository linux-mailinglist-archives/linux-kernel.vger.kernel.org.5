Return-Path: <linux-kernel+bounces-160270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AA58B3B28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F15CB22AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D032A16FF39;
	Fri, 26 Apr 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBtIY03c"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC6157492;
	Fri, 26 Apr 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144728; cv=none; b=BttU980tgQ6a0k3jUWo7IWHdPOKEs9zGqneHZskfwOlfxXulSlJoaDIJYsGaysb9Rhnf4iV8uiBuD+EmOuMr7+S4JAp5B+VUi6OdyyJOf/Zh9OTKC29FjCUhatkQpjwCBpDeCdx3d36rSrIuhPe9ulByehvVQyBATxB3XZjuM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144728; c=relaxed/simple;
	bh=xDXR4jGjSYN0GC7bX9ghHVGM783FJ6/ARVqYRX6/33k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMyCXsV986JwOStyfq3qzpBdCBivzsmp0c707NfuqQP+74ukejJvU4ggweDaThvhKJHQMrFyi56khhI55QpiIJwMpOawpo5uOs5kidep8lGcOvafCFPTn4iZiqSMEgnmAJf8x5DfbQwAmIhIGa/GzwUxYJtjHKFZTK1Z45GABAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBtIY03c; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so5791978a12.0;
        Fri, 26 Apr 2024 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714144725; x=1714749525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kpEePsUV7nJIPsd2LpqCo6410MJmYJkw/rGNMDqU0E=;
        b=HBtIY03c2MBdlgjKaCxgzMdBJhpW1iv+oereOLdx/5JY3j9LmYnt6mkAXguNZu+oax
         gJqaT9+z4a9Za2e9rZPu76fRkaA6YFOU/8JdqQG2/PlYqBAIsVtgCL+V48IeQo9rC8hT
         jL5lWz3RUwV3VX2UTTPSh9qem4a3kUxlh9A6Od3Rvam7X8u5PC4y7IwEYS6dH57f0ktc
         CuxZNvjMK1F6UStRSdXSjkh+1ZT/Mlt5wdVfr21v/Lre7u33zw9p+Rt7HWynvML5cb1O
         UCQTQh6MZpDBcpl+qnrm0rtsQJ/5px3VdOFNOLWF5VBZmMqE9/DMsczIZvjuO22ZXwXr
         AcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714144725; x=1714749525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kpEePsUV7nJIPsd2LpqCo6410MJmYJkw/rGNMDqU0E=;
        b=EyWLWU9IQL6ZRuYxiXQr7NRyOJrG/S/DH1r+MWZw5SKDQrVKS0AScp2yz3tQ7NP50G
         VGL4dWRKbthORzaV8A6yk+WobDLfLkMs3UQPN5E/8bZU54NZ696ydhP3OfdB69Vd85z3
         0L7Y/UMr3dbDwWagxs1YwwPrKjubyZOaugV69zyu/gHOZrjPpwPXnA7M9P0uPAX7YvXe
         6GYqdyLLsqp/7ZQcl3AZ017cJPob58pcyysY9J5G3r+DmSBiHk2amCJJdEUOzmoOM+QX
         7gy5WtyjUNh0gTz5nNJcLn+Ep3gNkWul/30rH3xFq1j89GBtrnqAOAP8quQjFNcDEWMq
         VFNg==
X-Forwarded-Encrypted: i=1; AJvYcCVmhHvAdp2zBRQ66egUGOKqRlMG1E9QFTT5LfoxCXZYhsLqCm4QSEdU6iP225bWQ3syaDsmLOrYqRdI55rpwqg/5Nzzq0J/iAhXR/d/HoyMdA89pNPP3764II07DyZXMTkx/Qzn0CrT
X-Gm-Message-State: AOJu0YycdnSBs1LcFHVEi8xiy8nku+9ibHnUF2S5VSFtArA4fd4AU3w1
	zIQ5oXZfTvO07OA2lLRmMMAFs+e6YAGC4FiMifoY7qAGHISxNZDg
X-Google-Smtp-Source: AGHT+IEphW+cY8HC5z3tGFpXv3PALgQYDo10WbNXlOUf3GKBkIEhxbGYao2zggBh/LXIojnz81SrPw==
X-Received: by 2002:a17:907:2d2b:b0:a58:c09a:71bf with SMTP id gs43-20020a1709072d2b00b00a58c09a71bfmr3066388ejc.38.1714144724578;
        Fri, 26 Apr 2024 08:18:44 -0700 (PDT)
Received: from fedora.fritz.box (host-79-27-41-113.retail.telecomitalia.it. [79.27.41.113])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709067b9100b00a51bf5932aesm10684754ejo.28.2024.04.26.08.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:18:44 -0700 (PDT)
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
Subject: [PATCH v3 0/1] Documentation: networking: document ISO 15765-2
Date: Fri, 26 Apr 2024 17:18:12 +0200
Message-ID: <20240426151825.80120-1-valla.francesco@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the in-kernel ISO 15765-2 (ISO-TP) stack is fully functional and
easy to use, no documentation exists for it.

This patch adds such documentation, containing the very basics of the
protocol, the APIs and a basic example.

Thanks,
Francesco

---
Changes in v3:
 - drop the :2016 version suffix, as in the mean time ISO 15765-2:2024
   has been released (and is thus referenced as the referenced
   specification)
 - add details on mixed addressing (all the paragraph about the addressing
   format has been reworked)
 - align some descriptions to the specification
 - miscellaneous fixes
 - collected a Reviewed-by

Changes in v2:
 - rename (and re-title) documentation to to align it with KConfig option,
   using ISO 15765-2:2016 instead of ISO-TP (the latter is still used for
   brevity inside the document)
 - address review comments
 - solve warnings coming from checkpatch and make htmldocs

Francesco Valla (1):
  Documentation: networking: document ISO 15765-2

 Documentation/networking/index.rst      |   1 +
 Documentation/networking/iso15765-2.rst | 386 ++++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 3 files changed, 388 insertions(+)
 create mode 100644 Documentation/networking/iso15765-2.rst

-- 
2.44.0


