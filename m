Return-Path: <linux-kernel+bounces-166893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276518BA16B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D699D288025
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A16C180A95;
	Thu,  2 May 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge2W1nD5"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA773158845;
	Thu,  2 May 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680750; cv=none; b=XhCRHhFjs84sfkwawz0n8uLB12TQmLWEOpI1m6/C5yLVzdlqae5XnhphDOmQ+UVnWHqbxwgLyxtS5B2DURV515CSvOi0BB9g7XjutWWbL/b6pHsFphyS53/8PGWp9ZfxHldpLUjNpV1mVZuOi6EdQ7UmWz/0PsCqus90zlvZa3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680750; c=relaxed/simple;
	bh=m2RT8PC4x1UCnE8lG23iBCFVaGRGa4zOXUVtHgndTQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OLsefs2xNQb20FRi08FEETe5Av8pPP80F5Gz12TJUHqfEfMA6E6OM7bWde+pKA6NBB+97woyoPAmtd+EYAqxHlBvAuoh9M3FSIBNa8gAUEcAVJdCv0MkKLJ4knufnO7rspSu2e+QgyxntnysOPjdinAB2ZPNiL37dGw3VfLQMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge2W1nD5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso23653b3a.3;
        Thu, 02 May 2024 13:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680747; x=1715285547; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6meDpwIFn6POwM0GTM589VI6wgTQh6ljoPgnNTkMk6k=;
        b=ge2W1nD5TdeklGBzFFoI0zcQEingoFhN2BdeS75r+QyfIFedSal+b+zYkC3ddjHrdg
         +BSZg+DYtPZJ31lsgSMXfg10hiJPFxTBNSDgEo3TQwG75cEks87ydVr8bX+mLnfISWDN
         wLzObveYakL0LM0x1ge95ML8W4f8OcuVGPEZri9o1q/slyEwFT7VnczTvLzahr61Izw4
         DkM1ELFCw6IV9OL4X41wH1glcgO1u0dHn4kIfgXqh+18Pn4gd2Ki49sIerztgHFAS1AM
         zfXO54FExQ1hF26XvYxwdPy47fvJPw2hBMygFke2kph/HkgtxxuI9u2wX3KHcebKPpm3
         Mofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680747; x=1715285547;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6meDpwIFn6POwM0GTM589VI6wgTQh6ljoPgnNTkMk6k=;
        b=muGUPWBIdek1TYfGUK7ppc0onSskbJll9dPPOAAjOGgL8L7iuGa+WwXM8LJtRMlHVr
         sKBmx+lamLiPzRU1Zz6esQxOHC15wq8e5LlMMvSixt073NH37WkGkPx03xbKzno7VuPk
         CN38pwEvGHZUakZHQxlohDWWE+v+rpfOY1JfpwZDxv8QVPVQWk5x0Cua7SodCoBtoQz6
         iid26/LG/5GSJO2QoJcSfgAEL9p21ixedyT1vfzNAue0jUVwehflmjeqMS2AYUmhbTAV
         gaeGw0a7ijzgmiPZfk0TUjMe7SnAN0sYteUAOxgnFLNT/fARZjy2M0RWR4iQlvadSxyy
         ElpA==
X-Forwarded-Encrypted: i=1; AJvYcCXU7Y05rFJi9ar9AVrrJzC5XQViL4iZ+6bYKTV+7ro53JoIMXCRBO76Q+wURcoybFk2Ekt7kEp1L2bmAvbI8d/LXbzH0OW2t1bSVKh4zlv4Jiw7m0dZ/stb3sgV4MYs0Qygaic/+bZ4
X-Gm-Message-State: AOJu0YwQJ5ua5cygl6pSyZ+jPeqoy6vRTqphZg1Xf0ZK0wVHsibOx9gc
	fMaNbWcvkKw4FxAOqpGqAFIpeJihypJkB66yhSAMI5n1pIM9yrPMObcW6m+H
X-Google-Smtp-Source: AGHT+IEkeV0ZW1vAReZH/O25DndzDOP7OdAvbWnDjw0Mc3J2E3onwOJi72SjnZxcb1iqBZb/Ax44sA==
X-Received: by 2002:a05:6a00:2290:b0:6f0:b53c:dfb4 with SMTP id f16-20020a056a00229000b006f0b53cdfb4mr736947pfe.22.1714680747237;
        Thu, 02 May 2024 13:12:27 -0700 (PDT)
Received: from localhost ([115.96.207.161])
        by smtp.gmail.com with ESMTPSA id k1-20020a632401000000b0061ca8fac008sm84332pgk.22.2024.05.02.13.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 13:12:26 -0700 (PDT)
Date: Fri, 3 May 2024 01:41:21 +0530
From: Aryabhatta Dey <aryabhattadey35@gmail.com>
To: linux-leds@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: pavel@ucw.cz, lee@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: [PATCH] Fix typo
Message-ID: <y5bqy3p7deaemny5sczd33zy2dwtbqvucgrq6wxqs7ibf4omwb@kpd2gwfve2ax>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change 'dasy-chain' to 'daisy-chain'.

Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
---
 Documentation/leds/leds-blinkm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/leds/leds-blinkm.rst b/Documentation/leds/leds-blinkm.rst
index c74b5bc877b1..2d3c226a371a 100644
--- a/Documentation/leds/leds-blinkm.rst
+++ b/Documentation/leds/leds-blinkm.rst
@@ -7,7 +7,7 @@ The leds-blinkm driver supports the devices of the BlinkM family.
 They are RGB-LED modules driven by a (AT)tiny microcontroller and
 communicate through I2C. The default address of these modules is
 0x09 but this can be changed through a command. By this you could
-dasy-chain up to 127 BlinkMs on an I2C bus.
+daisy-chain up to 127 BlinkMs on an I2C bus.
 
 The device accepts RGB and HSB color values through separate commands.
 Also you can store blinking sequences as "scripts" in
-- 
2.44.0


