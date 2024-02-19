Return-Path: <linux-kernel+bounces-70931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6709859E26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F8D2820D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649821344;
	Mon, 19 Feb 2024 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4fZ/f4T"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401778BEF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331096; cv=none; b=JRUDIg0TG0nKqmbQj/uo2D/ftLfN7GFzGbun+z3/QU4Oa5BV6pwcsxW6+Fy1hE3VXTzLRTvOp2AxwYA9/ovN9U/C7U6sWpRgStp8V5/D2XvlsZqFULSEijP6ImZcsuzBDkmRhsSfHDg508vkjuNtigDJyj4rtzxohQlNnliLJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331096; c=relaxed/simple;
	bh=Cm14M3AOqBWIacANhQdsnkUQYFsqmJsGStrT+CQVFWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NFrZu7y2H7z6pOj2/yQmGIBLP12Er7ZpYHJM4OP7TlxVI++JgJoPzJ3RAJIniG83e/NCdaN2oXBTM2dDLVMSD5Za0UXnB1PfX64JwtKA8sZjeQd5eMhyRqODX8apzcUniQaEC+Pk8rDjsBhKaPnKScfCQJNrkxlP2369Fx0AnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z4fZ/f4T; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d21e2b2245so34116851fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708331092; x=1708935892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0JpVlr3Rj/c4Qzm5arTBdHpNayVsgbTN0Vg0UGksGk=;
        b=Z4fZ/f4TJxAZuPRdfcvK/bd20ufUUsW7nAuzMxmcoNo+EHh8HOJNshGBJqcLtwFSzI
         uE/0sib3GZW+G8drTRaj6ZH04uw0WleOTQQZCkEU9uz29Daie6rOEekxxmbZ59xzKhO9
         6cFK4fL7O6I5l9B1Q1TXYaJ8RY1jGpyp3cGEeeTIyo1UfgV7ziyXPP+bfBdSa0v4iPFu
         G1/hACpnAhJ3YYLJli6i3hzpLuwCz96MFsqSuWQU+RXCu2PGCHNwm8hz7dJtH8YXiayT
         aFQSNsgQsd+werpTFjVz3HDYDuBjaACnwJDzGi/xXDYpw4W6G/tMEbrHN+Zcg7TZREWo
         R3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708331092; x=1708935892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0JpVlr3Rj/c4Qzm5arTBdHpNayVsgbTN0Vg0UGksGk=;
        b=kR+l4VGlOwbPL8BGJbZeIwSrFy9Kg+cb/bygH2d5RhyWltLYs9hZF/f1F9cn0LbaTk
         bOW6xLQKeD0donDnUj9VPlVJkNktqGqbThgUyT+wfBsRwhnG0YAIdTxZCfa1ZWySQiXC
         ZxhmWNmGUBq/OfOVQUWFNn40JBIB51m2uQIgC5J1/vTIrycAjFolgNx3mE4rezeiVn/1
         i7UO4SNrG0kfk8U++IhDYCV8gdfhHjXQeW9qfPoGwV/EpXMNQictPEX/edEHMYCkEBn4
         nKIZZWReMMpUEHyG8MuSmOWQrKtRYbtEF0cFTTLBR6IWNfvkQhj20iMKA6qK30dbqCbN
         +gAw==
X-Gm-Message-State: AOJu0Yw1xGqQLTHbErUeqn14YVf1rtKYM1d5EnfpssfnFPKHFYGz2A1V
	XUcmmHXlRNz00aitR43P9uIeKPWvoiIA27SlJSoI82KIF8CSagC3hZ202ffO/j8+BRHjhHj5LF2
	V
X-Google-Smtp-Source: AGHT+IGl7NEY2uD3XDkNwXB6bSFXBxdMvVaR+g3ETTOChrm2nkM6lK7gTzKtS2cVBknaGgBzfdrNGQ==
X-Received: by 2002:a2e:9048:0:b0:2d0:de72:9d47 with SMTP id n8-20020a2e9048000000b002d0de729d47mr7790373ljg.8.1708331091929;
        Mon, 19 Feb 2024 00:24:51 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d420e000000b0033d282c7537sm7047857wrq.23.2024.02.19.00.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 00:24:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] docs: MAINTAINERS: add "Profile" keyword entry name
Date: Mon, 19 Feb 2024 09:24:48 +0100
Message-Id: <20240219082448.14157-1-krzysztof.kozlowski@linaro.org>
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

Changes in v2:
1. Drop duplicated "Profile" word.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9c3100ef587..36fac6b3499a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24,7 +24,7 @@ Descriptions of section entries and preferred order
 	   filing info, a direct bug tracker link, or a mailto: URI.
 	C: URI for *chat* protocol, server and channel where developers
 	   usually hang out, for example irc://server/channel.
-	P: Subsystem Profile document for more details submitting
+	P: Subsystem *Profile* document for more details submitting
 	   patches to the given subsystem. This is either an in-tree file,
 	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
 	   for details.
-- 
2.34.1


