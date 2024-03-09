Return-Path: <linux-kernel+bounces-97708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71BA876E2C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CA01F231E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D44315BA;
	Sat,  9 Mar 2024 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPug1NqD"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DCDA921;
	Sat,  9 Mar 2024 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709944470; cv=none; b=MrDU6JR1McMEpbOUbSF2dAnkr+QfZOTd6a6D/dUkTElC1Z/7N/Juo+1Gmk44gZZHwfakdhMcXrlVhWHtsgm5b9qqsEp6hegz4VqZUlWoazj5FK/ZGHSCyiTt4+KHp0CtXTZi3aZWth9xYvj91ImNgNfwzTb8YvHqf7U+FOPLPTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709944470; c=relaxed/simple;
	bh=q4z0JBKtHiuuo11OV6hJdZdX8sEzI8QeCNwfqdbmNiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1EWVosc0GwycZQsBrI1OSJ5H81cxebBCGIn+0VRz5vpjFwFfBDfa4L6RSeFt7RmDRpj46PM9PAiyZrLRe+bKO35EEPtmnsqDFnSZ5N875Gy43jFBUD3CXhy6ndb8Zw06VyTJ7+iHZx0uFJyT8K+eXbbFIyFMkC7zO1++0IMp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPug1NqD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2273726a12.1;
        Fri, 08 Mar 2024 16:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709944469; x=1710549269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gfto3PH7OgXOdEBTnJiQU8idIpmlC2PcZAHMX1LkysE=;
        b=SPug1NqDQ14J+lKq9d99zmcC7fxwixAb6W98Vk5I8WpGMGc47kIYfZWypoM7Dkbi3w
         sfph2xFtODbeSiBGVpBslrM7NVHQ0WWxhqQ2dHlOTc5HLQY/d2d1aYLqbONijHsNcruU
         I+sJW5zaq+0Ql2bknQ4pWQsRKemqbe6zNh6PjfatN/OSD/9eAfR+PUVlFkMcdic9ublT
         wIDeW5K/iZfrTY3KoW8I+ajd9n8vmtiRHwxDtPdzOy7grwW3fXsgOHSvvrzegZqHBufC
         q7Ss72jtYARhgzzyH41Y9LEBM22zuycDfogom6E9IGhen/S6Vu2MqQUT1RSqwG/1rtWL
         Nrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709944469; x=1710549269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gfto3PH7OgXOdEBTnJiQU8idIpmlC2PcZAHMX1LkysE=;
        b=bx0qv+pqsS4GtNY1zp9KBRFfb993X5hxKCnAX/lQ0tEMpPbe6nMCqvuXAcKzkeCEh0
         53W9zyKksRTZMj+IUIZdNYwJpiqCwn+JwAwtAPJaSgg5EaOZ3biAKjquF0f01DpJqbs8
         4mZr2BCpevkJgc0iooafvwx6lvYj/7G6RHubBx7gDyd9D/E/alZutQEVe5E4cCwDhVo8
         BJ/xJcMZwFvlQPolmxVtw1B/Hdwjd16m0ON7siiWBGDNp9AMs6ssC4oPVgh3K+j5shsd
         SnZSaMYYpp6IYlpm+/+G7LPnQzAdmD9QzhFMdePmtBJUptljVOuQCuhEyHUYtQP42qxw
         mHMg==
X-Forwarded-Encrypted: i=1; AJvYcCXOrbEe+CO1jJ9lqux/tzdXm63g+tB+6c4nKbkFQgA1/Raz8Q9IEVBisc9OOd7rfLFIm0jNSa8iOBpmK0gSW0FwW67POep1QIiMj3DRGPpD5YNa1cHJX7kGJ3Fr6iVUyq/hUdcst+RMF7v83CENi5gyfAVU/bhnIxLQDEHCME1C1rgoJqsw
X-Gm-Message-State: AOJu0YwBPCHVe5l3BA8pS+DuU/peZYHXIpFFzaG/y7Hy//4s0V6jEqCg
	8ukFCZGWglz3WZMzTuv7Mu6Hj+FpvgD3CkZUKXmNSPqIi1hVqIVJ
X-Google-Smtp-Source: AGHT+IFs3hzvyY4O/JtyWuRJxKBnq5s8GOuRyNAOPC0O14RH8LjLu7ZnxPlIEUzThPXzP9CP0jVtLw==
X-Received: by 2002:a05:6a21:3a48:b0:1a1:48f7:a621 with SMTP id zu8-20020a056a213a4800b001a148f7a621mr284306pzb.40.1709944468714;
        Fri, 08 Mar 2024 16:34:28 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f556:b889:3e89:5ec3])
        by smtp.gmail.com with ESMTPSA id ie21-20020a17090b401500b0029b5f69830dsm302858pjb.22.2024.03.08.16.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 16:34:28 -0800 (PST)
Date: Fri, 8 Mar 2024 16:34:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	hari.prasathge@microchip.com
Subject: Re: [PATCH v2] dt-bindings: input: atmel,captouch: convert bindings
 to YAML
Message-ID: <ZeuukSCMBqYEosNd@google.com>
References: <20240209064755.47516-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209064755.47516-1-dharma.b@microchip.com>

On Fri, Feb 09, 2024 at 12:17:55PM +0530, Dharma Balasubiramani wrote:
> Convert the Atmel capacitive touchscreen bindings to YAML format.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Applied, thank you.

-- 
Dmitry

