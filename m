Return-Path: <linux-kernel+bounces-70927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C61859E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A774C1F22166
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174E21363;
	Mon, 19 Feb 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqQYis2J"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E320DFC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330941; cv=none; b=FupSUtBxLMc+ukJ/4bY1kB1fb8g2pPuixTd8wPHT1yeIgZdlPalDI4HS7GGk2yn5p6a9yO0fvU0ShIlYrMPe3khc9rvUildFdqIjym51gEnIksZ1qYmS0U3f6UvpihsXZDynf5QNTOjlgzBuCuZi17SBKPbcNP3WPIjxstKZc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330941; c=relaxed/simple;
	bh=FvBbTrLHfzMAs7VtoWvq0W2MIUhWBuAqZ0NPy17yAQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Le2ZL74sv2J8OPzBsg6bPXPjFF7/akqh2kI35m9KfiLmrf3LDYptsZBeh5f8tVRToGG9WYwaDKMH6zEwHl+05BZ6Lgz7jOsHY5ZsNjN9xPcBVW+tKIG54vDkr16CvRTbIMhU9Daln31pfGFyLLsfvRvabHXQVwzNmJg1igmhy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YqQYis2J; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512ab55fde6so1490685e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708330937; x=1708935737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ycvOyJbv26u3Dhx0FmRMkxR9ksBoiOuJ0RI4MXT3nOI=;
        b=YqQYis2J+7HZG2tUZWiYo4PsGnEEhzPNX77ns8wPYZY1L6iI+4RdrCaYQr+xuCzCmP
         jdXV46UrhVTFtQOJHYix7T2rEx7CFpiHnzRj15M9/MAqPlNYdiat6U4b9c8fe2rNHiFM
         Zx7k8jho5Kk4W1GMPrTKVGUcY4Bq/rlnXSrFzL6x1stWcWSmaROEcvgJRE687oF0GYDC
         LjnMv8iamnVeGOW3WDomvUurtD1ml3OoPGnWipI7OviYnTZ44laN+z3LbTOUMmvyqjs1
         xcb0RMPb/r9t1PYS+aSxLtAST6av7OhWEsC5+KYsGV8YInYgwfmbKu+fm1efIgaP7jVD
         Ra9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330937; x=1708935737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycvOyJbv26u3Dhx0FmRMkxR9ksBoiOuJ0RI4MXT3nOI=;
        b=nw8HNmEDRX4+SRlw+IrrYzn8qQuINic1jFOsFdTmRaaDRND8zx8Y2QRtA92fcyfmDb
         ywQoh2Nbm6g3XppJsiwJGyIjcQxjrKFB6eD6ILpC19ABAcSLnuIYU0SwesBH8XBd1TeL
         QfaU5kQdKGP4G7disFUcAPjaOcIxAOxG6a67AUc0XLuHd+KwwC5OXps8vXxybu0cqCou
         PCiLZe4wDAkwCmJZerk4qyROQW5fFdTQVwccPctZZOtRxhhCJws0yKmV1hQXq6iwXxC2
         m9KycmVPZyx8qUQ5ZZ5Nq4VmBQ1nEXQvhL3xsORevkwAWF36gw76COraS6ENTZ7LhwT4
         w54g==
X-Gm-Message-State: AOJu0YzDed73zgLENFLT/DG0wuGUjmnnm01vZ2FC6y5otNJFS5m/H8fq
	ZZbWi/7MCuNFMVfhfveIWuZRmRNErEJb6mdozBw7GEEOjrR61mukk96HVX2F/jeMZdoXmZJ9NJC
	Y
X-Google-Smtp-Source: AGHT+IHvRfIaq2XgjkibK92o/u6nDYSEPMdw9SGBjJGEu6RzlWl8HQjQntEPLa5yOddMIpYADzYYYQ==
X-Received: by 2002:a05:6512:3bb:b0:512:b694:27be with SMTP id v27-20020a05651203bb00b00512b69427bemr570928lfp.45.1708330937308;
        Mon, 19 Feb 2024 00:22:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id bq24-20020a5d5a18000000b0033d50091f3dsm2214696wrb.8.2024.02.19.00.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:22:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: MAINTAINERS: add "Profile" keyword entry name
Date: Mon, 19 Feb 2024 09:22:12 +0100
Message-Id: <20240219082212.13676-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HTML output of MAINTAINERS file prints "P:" for subsystem profile,
e.g.:
	Status:   Maintained
	P:        process/maintainer-soc-clean-dts

Use "Profile" as this entry name.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9c3100ef587..35933bd320cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24,7 +24,7 @@ Descriptions of section entries and preferred order
 	   filing info, a direct bug tracker link, or a mailto: URI.
 	C: URI for *chat* protocol, server and channel where developers
 	   usually hang out, for example irc://server/channel.
-	P: Subsystem Profile document for more details submitting
+	P: *Profile* Subsystem Profile document for more details submitting
 	   patches to the given subsystem. This is either an in-tree file,
 	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
 	   for details.
-- 
2.34.1


