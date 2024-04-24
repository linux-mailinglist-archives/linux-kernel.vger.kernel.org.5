Return-Path: <linux-kernel+bounces-156422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A768B02A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042DC2850C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8196158D9E;
	Wed, 24 Apr 2024 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMnjVhQ2"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A65A1586F3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941671; cv=none; b=iTAfyhiZoTx/Nbe8MIsKKnS8zrUKTJZn+qHVuDfkod9vl6/gVzjoQOXLtEJ9ntyEl09ZQFrbdVdlJUdmp1rvgaNe0lTFzxQ7IzBCjaiuxmMeQbcdqOoJGVFYIhTMX+u3T6/RniR1sH8IoBmJ0fOvmX8Ho2lcOexJFocQuPfkwZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941671; c=relaxed/simple;
	bh=kWNHGysWTblhgSs0SJ23vg8euiQMUy4EJwOQsw/+q5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPfIyQZyPdOLbXR0zHl1Je5UXrMbESvOkqiTBlWV8MLoEYT4PCfoJp7cF8Kj/Ny5qNsdb5onj3smfpZSRVqruweBQGlHFaKF5f7dZUAxZ9ABBVJM1CvPSH4HtWcqe6QUN7x594mdD7X0A9SXNsvct207Jk/pRGf0WZwhwEQodFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rMnjVhQ2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343f62d8124so5281496f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941668; x=1714546468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp8+cGX7XtwofafT1aXzsyhi/8LAW0O99poprNGjx1o=;
        b=rMnjVhQ2mJ6owuCHD0sl1mBJ1vT+PecKOAz/OoexkeQGZP/Xupiojr+CkK1npi31I3
         36vp7RP4Qvna5DeXaM8T4np7DqQCxSk153gbw7h6JL61sAk/RV8cbRYDo4dVqJIsFG42
         eMb2cc2NFfMTShliqwBfDvMz6yz+LZdXPSfY0/MLXXkbV7nM767ExawsnGPCgDm4YE0I
         i4RJqfJae0K86AWwXxpq8flWZJwVF7gO9niwKjkRpbk4Bye1VTqV6DrwsM+ykgIS+Qi0
         jiVGiWC1wFgd6uV1Ysq5PcD8WYWRBT498G/CiRLEHNU33viCHbdnkTqCI8k3bV3p7riE
         fHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941668; x=1714546468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kp8+cGX7XtwofafT1aXzsyhi/8LAW0O99poprNGjx1o=;
        b=XggqLRD7MHU36K7Q2tZM7LAM0U+1ThtBXdKn4D+/O+3QQhxxUXW670owhNzlSahca8
         O/PR/Uc/wBq/ouYqFBEIN6/L9PoeuY+Nwq3omvsKkhi+13Gh6nEQy4r/E+axBHTw22QL
         TAW8J47mWp/zFf7RaM68uLypic73vO8UaxMZcr3LyaO6/upU4oRJsWd3nTOWD4d3s0wO
         KpYVKlJ7vCtwH2CtHPT18Z0Seiv6isINNb1m1kKPi21QQ1C4kBe1JOXjZHpr0xPlcJRw
         ImyM7y/l7MK/mOiBdlGlxtcd2PJK9YrN5EjPUlS3QlW+ud+dvwqnGYxVcjSLSZaZVO7m
         wjWA==
X-Forwarded-Encrypted: i=1; AJvYcCVvKXB4NMBp8WnteCJyw6TsRQ1tZxh2NxJswTy+ou91zamyRg5J2lRz6DrlrjGC5HfTVyApkv3tUfLjysjTA8kpHCmr9gWTZKNyUzsO
X-Gm-Message-State: AOJu0YxqbIy6RahmKFmo6Ze5ybLyNRs/gMDhlN2zm0MyTuqJUdU0NZm1
	/PTYEVdSzrEv+1bDheO7r7Ejl8xG+xkNE7syBy7OsX9S4zidZMDlQOaFDIN/hxA=
X-Google-Smtp-Source: AGHT+IFhrNuNdXyJDZskwR1EqA9Da3fPmgWhRxtO5+hpDh0nt443HLAIbFJ22742sOrHXtLXDLV5Wg==
X-Received: by 2002:adf:ed81:0:b0:346:758e:5f29 with SMTP id c1-20020adfed81000000b00346758e5f29mr994865wro.60.1713941668106;
        Tue, 23 Apr 2024 23:54:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b0034997769ae4sm16338534wru.15.2024.04.23.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:54:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-realtek-soc@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] arm64: dts: realtek: rtd129x: add missing unit address to soc node
Date: Wed, 24 Apr 2024 08:54:14 +0200
Message-ID: <171394159880.43787.6058652515148052600.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401140912.97157-1-krzk@kernel.org>
References: <20240401140912.97157-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 01 Apr 2024 16:09:10 +0200, Krzysztof Kozlowski wrote:
> "soc" node has "ranges" property thus add matching unit address to fix
> dtc W=1 warnings:
> 
>   rtd129x.dtsi:51.6-122.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> 
> 

Almost a month passed, no replies from maintainers about picking it up. Dunno,
looks abandoned, so let me grab this. If anyone else wants to pick it up, let
me know.

Applied, thanks!

[1/3] arm64: dts: realtek: rtd129x: add missing unit address to soc node
      https://git.kernel.org/krzk/linux-dt/c/9c1998bb182d7edbddf8bef66f87ea68f8b91d67
[2/3] arm64: dts: realtek: rtd139x: add missing unit address to soc node
      https://git.kernel.org/krzk/linux-dt/c/ed719eaa59f8bb0354dde2e37ece3e05239d0b1d
[3/3] arm64: dts: realtek: rtc16xx: add missing unit address to soc node
      https://git.kernel.org/krzk/linux-dt/c/bd54eff2c5272efeb91d37efd4d1af9270601028

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

