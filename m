Return-Path: <linux-kernel+bounces-132096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E27898F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180E41C2167E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DBC137916;
	Thu,  4 Apr 2024 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHlIuaOe"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E8137760
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262295; cv=none; b=BiHA6hAygu4xdrzMcKQ7QTPyB2QM8Btf4PxjsJdjQwm6MU4/J/ikz53E58sDrfAOoHMv0MOlSaVyOn/N6tnEfShBToI4M0COzbj6I8ry7ZP+coVv3/6wEQiRp6gWTjPeNb8SWG/I/iVIBKA2uJidlmrt2eA5Q4p8xvMlzWm4Fnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262295; c=relaxed/simple;
	bh=cb+xpFUvW1ym4RZ/w8ygNPKaBmjVVnZYJY4THfK47Uw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jS7Aw0fx+kBp4m22Hadtj1PTcN4U13cMlOMMxtUTUWe8OoJOEbpf9+dOWoSWGKB9AvTS8H3KoUEf+K0+JPKhj4Npl5kA25Mh5SHojsyDKSrh6zgOxw4dBwafj7kI26KC8rBTWL4ePQunh4gY/nCrjOFhAo9xsHrbmZKpwE8jLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHlIuaOe; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46f056c29eso52372266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712262292; x=1712867092; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxEdchIOJyohPfcLz/fjqkZd2ixkQOJ/RrWlRAjzV6Y=;
        b=SHlIuaOej2Fn7pqsEj2SInkIjouF5x6NEKqebOTFp/xj8q2mOLunJ4HtXvaMCYNHg5
         /p7SRE5s9Uey1pfHzQSvqsPdJ3HJpIx9uJ7xGGXydkZWnSgductqgfVbYXMzxVfu+k0l
         /cntG1TJojF5BD6P8E3RdQy8J4RiSAsU+zKi9Ey38S3zZ+ryFsChuvdwIaZP3YMRDHNm
         D5UHu3c1cBfwjoME7+PRl/lF5M2K5wqE2jV4R7YLSMoizDgVdR/pb6CDBlh6bfIUxPv4
         v8PRO2r6eUoufvi55iEHnLBwomNH0L9zB/sHapZv+jxVZC+InZnjaDHAdDOFZyFQU89V
         1CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712262292; x=1712867092;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxEdchIOJyohPfcLz/fjqkZd2ixkQOJ/RrWlRAjzV6Y=;
        b=Jaq2hjp3cBXAMuP3G4qos9/9zGaCwBdZd2l3ocT7pfxEj/0jTh13IfHOviNIcyogRu
         TE275Tdt+3xi7CkvzneQ2AtJrAGsHF8tk3CVGYLsotg+3WyhNdPq5YMnBeg3fJjGMVBk
         Q8ELg3lr6i6ZH6GX3CCOCqig0r8k2RJNQexD9W+X7kThh1zVeYOPvtsKd0NJ4pJZJUdt
         PP7WX7vUhTKBIdsFWTsq45FB1HSMpkiqnx5RwvX3pE9TevzSYdf9b4PPyZvNTpvr+8cm
         R/s6JLe3FXRAtrIB3KAnUcBNCCNMOpIbaPRnXnvC+Vi0uFmIGRAvZlGB56axGkrdTXRo
         zaaA==
X-Gm-Message-State: AOJu0YyPiYXblN4TgCjdLur/ocvlOA6NIM3doF9eZpSWZlvFMOebbcPD
	wrZ/F/VwatyarCqEsbRsoNZ0myhvrJ+xJgU3lv2jQZAyvM5BRcMARDUm+MUkgzI=
X-Google-Smtp-Source: AGHT+IFgkZal3em7v+Bo8oOg550ypfObgLX0ds69+PUsv73lsglX1d1ws7/JbBwHPx6iZ5BtH5jrKA==
X-Received: by 2002:a17:906:a449:b0:a46:485a:3163 with SMTP id cb9-20020a170906a44900b00a46485a3163mr2080643ejb.6.1712262292311;
        Thu, 04 Apr 2024 13:24:52 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id pw14-20020a17090720ae00b00a4e35cc42c7sm8326295ejb.170.2024.04.04.13.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:24:51 -0700 (PDT)
Date: Thu, 4 Apr 2024 22:24:50 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	dan.carpenter@linaro.org, forest@forestbond.com,
	gregkh@linuxfoundation.org
Subject: [PATCH] MAINTAINERS: vt665?: Replace Forest with Philipp as
 maintainer
Message-ID: <20240404202450.GA23408@matrix-ESPRIMO-P710>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove Forest Bond <forest@alittletooquiet.net> as maintainer as this
email address is not reachable anymore. Add me as I want to take care
of the driver and I do have vt6655 and vt6656 hardware to test.

Link: https://lore.kernel.org/linux-staging/d599cd7b-a5d6-4f2d-8744-10254b75f7e5@moroto.mountain/
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..15492869ac8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20954,7 +20954,7 @@ S:	Maintained
 F:	drivers/staging/sm750fb/
 
 STAGING - VIA VT665X DRIVERS
-M:	Forest Bond <forest@alittletooquiet.net>
+M:	Philipp Hortmann <philipp.g.hortmann@gmail.com>
 S:	Odd Fixes
 F:	drivers/staging/vt665?/
 
-- 
2.43.2


