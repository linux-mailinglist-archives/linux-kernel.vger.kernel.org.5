Return-Path: <linux-kernel+bounces-80189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D555D862B8E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E661F212B3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F511BC20;
	Sun, 25 Feb 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sH0/TJ9J"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028DA1B807
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877464; cv=none; b=E2u2Ffk7ZGUENm8ZBzOherIU14IzKp3hkQtjybe5eCEroHC6l9tGlS79kT6i9QJL+2X8BM6sZ4bYJXNw+yiJiWZNSy83K72Vi3U+YZT2qEIegTF+nw5nPTbVCpWQj6/9ptwoBeEljfLSRr96c1fJ+UM5SqtZUBERYpt1quiEvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877464; c=relaxed/simple;
	bh=TXaocwDZwWC94dxCxgh1lD1LjbtYnVPhJX4H4hTuSkY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZNEXGJuoPoCvvX9F9m2ghkGJGsBtqMoAcaCc146as31xpeB2ntOpJnIHuSKSyph0z8u7PJGh6Q+MkdQtWyjnY2KjtO20d16vMgpjK6Xz0A5nWI/iQb/genTzE87JcAwg6cJ6O6jcWPRXQEIfwDvcS7sAH8eqyxaalcVBNYLqzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sH0/TJ9J; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d23d301452so33386391fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708877461; x=1709482261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txzUoVNp86IgACLI+fWKJm3IORGCynctjjPSZgxX3Og=;
        b=sH0/TJ9JsrREP6EbQdMkaINAN1EwNOtU1n4g00tpUArKKgWsEgfNm85N9X1B5SReRY
         FkBB3k9Jfg0HwnlvqvKmknSQKUSUgjwXPy448josCPAthfpPBuLZq8JYfV5o2jJah1Ek
         KvLdJpu9uJtpcVw5CIktrlDt2cvPfmX6u7s2MulyhpNFxyZO/HH1gv1/VnB0QMpda50u
         MVqFMBX09qTwYnEWiGQrFm8N+w4+yyHMx68touG8KrMz4pdPCTeCOovVNdI0lhrYxFqn
         f7vqwO6bFvnFMWknswOMl2xU9tCyN46/0UvCiKWTh+hmoY8PHIhCuQTvSPo57wTpcHbc
         dtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877461; x=1709482261;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txzUoVNp86IgACLI+fWKJm3IORGCynctjjPSZgxX3Og=;
        b=wTAcrrH/vO+qqtKgXis9jdqKKA6TswD6cawqnY/tZWnY+9Y3NK0GCVfo1cMIveV3gg
         pX5iWJn9/khzT2Gru8GQUo2x4zgfzb/bSLqB5l2/2oLddJv1P9Qzt0GiIeUJmnHz6F+P
         qMU4UY2K6OAO9+Tf9EaAAHlwKJf5tSbJQful2cMxYf2bwsAM8LBR2zjjXj00lQsySnSc
         ZBYrpH8fluRKVVxaN3BixrQTIfK7TZAD+HTT3TB3yJFmvSROVZbHqJDfbe6+2g7cVlzF
         yc9vMqk1+Hg09axkuasElQlgiZeF4rvobBivD9ClFWhyVregUT2AE0aRYbc6lFjwd61P
         Kahw==
X-Forwarded-Encrypted: i=1; AJvYcCWkCih1iJnBSKOwNdBPr7YUy5ukm72b3rvhLvc/gr7ZbXJqKcDdToXU2JdZIuy3R/hIFkd6FLi6ys14VjgwqcilDtB720FfYnxAUm9Z
X-Gm-Message-State: AOJu0YzK+cAsqqFxP0/7C/F1AOk1hhb1LeUAE6Nfapx0OPoY735X055p
	wQwBG/aMU7Ya+y1e7T5pdX4CWdJIUN8aVJOuwPrAxV9ARgfdB037yepxhx8y+8U=
X-Google-Smtp-Source: AGHT+IGZUf06Jp1TAh+C+FZ9U0O5PY7DChQElQBeFj7nMxhUWpuHesCcwBoTIsNce2oxSMdZ8UvS0A==
X-Received: by 2002:a2e:86d7:0:b0:2d2:64e5:8447 with SMTP id n23-20020a2e86d7000000b002d264e58447mr2408560ljj.42.1708877461341;
        Sun, 25 Feb 2024 08:11:01 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e7215000000b002d2697570fcsm579184ljc.93.2024.02.25.08.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:11:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240224202053.25313-7-semen.protsenko@linaro.org>
References: <20240224202053.25313-1-semen.protsenko@linaro.org>
 <20240224202053.25313-7-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH v3 06/15] clk: samsung: Group CPU clock
 functions by chip
Message-Id: <170887745923.215710.8750487017286129944.b4-ty@linaro.org>
Date: Sun, 25 Feb 2024 17:10:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 24 Feb 2024 14:20:44 -0600, Sam Protsenko wrote:
> clk-cpu.c is going to get messy as new chips support is added.
> Restructure the code by pulling related functions and definitions
> together, grouping those by their relation to a particular chip or other
> categories, to simplify the code navigation.
> 
> No functional change.
> 
> [...]

Applied, thanks!

[06/15] clk: samsung: Group CPU clock functions by chip
        https://git.kernel.org/krzk/linux/c/be20ccc17f41240b52106bf3dad01734a7f11080

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


