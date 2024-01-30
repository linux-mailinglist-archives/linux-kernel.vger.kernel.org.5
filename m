Return-Path: <linux-kernel+bounces-45464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5333843113
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E591F25492
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4215F79941;
	Tue, 30 Jan 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2jmISR5"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DD7EF06;
	Tue, 30 Jan 2024 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656932; cv=none; b=mqE7zmIl4RPCu29wZLFQO6Gjc1cqh+BIlTJqEInlxNtYxMtsMQ1ORExRpwCU+98pmdSKOnBgjMXPwQ9BpUklcMfx7GC056BimQZcJtC0UxnsLKFUi9d0wb4k4VccEBVemjSXVzvfTdrLtrAZ/athyBXxLqWUUlUI4LrAF0nLStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656932; c=relaxed/simple;
	bh=kv+e9Cs/2JkPD7PTMh8KOS/xZyRVE/K3NioD86J90SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP6hGUSz6bgeSgGKl6MqNKKQPfHEXMSXbOGj/cHmBi/5vuk84qm0Sbln3o9521dxzlxvpTsATU13ZRCJlR/7pVtQJLxozt0OKuJo/mEF9VJGT22/JWtTbo2tYh6iL1GlTjK81RA59I9vrePTN2D1FYv2mv60ot+jKpRNNqJT+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2jmISR5; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3637f958e9dso5939595ab.1;
        Tue, 30 Jan 2024 15:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656930; x=1707261730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEYhELlxY9RsXySQ9haft7PmND+A/JY4VFg9NvdfEZ8=;
        b=V2jmISR58XyjnxAMPZTPCSMBj2bFFStmrabttbyOnnMkq4grnGsspogP37DnxBf/Yh
         058eTGjEW7mu51KmKV8Jo8t7V0QOHvpzbwadAcpKs47hJReHGSvXdJh3bKczETkQV1cX
         xJ0gpaJs80lCaUNcRwQGnkk7iV3/cwbvzMzpQO60nRsmjRKCrU4yQ2TZPNOMLYuwHjba
         BRDjA7eJfDy4k5XLtH9ksrwhcCxsfi7i45LaKsGGEp7X0SieRVA0XyqQ1jCBHYCg0OSE
         Z4+b9l7zzfI9w9f2Kqs6WQ6qWE2SRorvYMpptxwqPMmdFEXelDuLrWKcV63sQGxmynyg
         ZA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656930; x=1707261730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEYhELlxY9RsXySQ9haft7PmND+A/JY4VFg9NvdfEZ8=;
        b=K/CCu0/lBTsuSlGXbXO5iiMh9NZv9gGLv/sbWFPwqcxlKGVTF1tBA4KBKJb28NUNH5
         D56aXsBXlJ7ambUaoGpakaN8acJ1n/Wq0FzembNddLEx8wJBxGDpSbmsJhVDxgUGmhmh
         eRsaumGHjXr7vEppSVgO61SEMOP7GaGSOqUhjSu69WmXYAcc0yHLY/ebaDW1ieiigdhd
         1pqWDKUXXskqXDVrFNhtgmA3DLF4J7bRyUokK20hlZSJfCZ8Qz/mxDiuL/OuM6NPeqHL
         g6VIv4E9ugzOaLQdGMZSwH3rSCc+LyiPBoQTCqLRNPcRZqo8TQ0n6QdtZ0vraqi19H+r
         GA0g==
X-Gm-Message-State: AOJu0YzRMsfRDH2rcfFe0z4SFt/SPoWu1fdbY60cJtbcHK/zuXQpf/Ry
	pBlZ1i44iXhq2qOy46CgtImrdXwxPmGWa3PT0qb4CPLNhdQF9CvK
X-Google-Smtp-Source: AGHT+IHHlT1De7ZNKLWcKB3LNAdis9rHuBmeNy7AumhkIETFmTaOgTEA8gWxiebRB2SKhhiN4LIBXg==
X-Received: by 2002:a05:6e02:685:b0:363:8353:324b with SMTP id o5-20020a056e02068500b003638353324bmr77262ils.1.1706656929914;
        Tue, 30 Jan 2024 15:22:09 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:955e:133f:54ba:f642])
        by smtp.gmail.com with ESMTPSA id n28-20020a635c5c000000b005cfba3c84b7sm7924472pgm.81.2024.01.30.15.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:22:09 -0800 (PST)
Date: Tue, 30 Jan 2024 15:22:06 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v15 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Message-ID: <ZbmEnhIoJzC__4no@google.com>
References: <20240129-topic-goodix-berlin-upstream-initial-v15-0-6f7d096c0a0a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-topic-goodix-berlin-upstream-initial-v15-0-6f7d096c0a0a@linaro.org>

On Mon, Jan 29, 2024 at 10:16:34AM +0100, Neil Armstrong wrote:
> These touchscreen ICs support SPI, I2C and I3C interface, up to
> 10 finger touch, stylus and gestures events.
> 
> This initial driver is derived from the Goodix goodix_ts_berlin
> available at [1] and [2] and only supports the GT9916 IC
> present on the Qualcomm SM8550/SM8650 MTP & QRD touch panel.
> 
> The current implementation only supports BerlinD, aka GT9916.
> 
> Support for advanced features like:
> - Firmware & config update
> - Stylus events
> - Gestures events
> - Previous revisions support (BerlinA or BerlinB)
> is not included in current version.
> 
> The current support will work with currently flashed firmware
> and config, and bail out if firmware or config aren't flashed yet.
> 
> [1] https://github.com/goodix/goodix_ts_berlin
> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied the lot, thank you.

-- 
Dmitry

