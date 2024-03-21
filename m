Return-Path: <linux-kernel+bounces-109864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AD58856D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CDF1F21A18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF0754FA9;
	Thu, 21 Mar 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZQPC+7IZ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A055645B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014552; cv=none; b=a6VurV5OsYp1IvKo/ZrEOPCoiGdecScu06gek5Ng1xwaqm4KwCP5wGDoW8n1vo0phfHrsxF8z7vwRBPahbAZbt2isuRBFeBGb/R/eI7J9rJTfiRZdHS3SNm5Dj6eEXTpk180pWTwibb5eHOgO+obFafcfdbmK2cTwpceLTyzDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014552; c=relaxed/simple;
	bh=l3ghcW6Wpc01USfRbBDFgdXMiPSFcEy9PO1CFvr9MzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qvgl0eFDL3JyB2Xv1atX+oCO4hdx/aMf7Pb8elP5fSE5gznLjCoDIzvPm6baEG61n07zC9D0A7i4YqHO7PkXQxtNVSEg1/VOV4HLHaoIZ82fW6OG10rfZvqWqD4aUo0od11qWZOcznGVZ3EZB0EMls6UpFuAVJAFrUHD6Lkru3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZQPC+7IZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-341950a6c9aso500159f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711014523; x=1711619323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQnaVRKvIjzKZu/W9svAkJqqB541GQ+AgFRgogKa+oc=;
        b=ZQPC+7IZrh7UOTSELthV+dbIaYcZTg3R7VX+FsoP7NWz+jdgsQFaC70YCDHgcDozW/
         tj+abfD+IYjUW/hZm7mADgwztUKyWBOgZMqL0W5uwY6WQf8PrIWy0vpZ/kr4exOulvi9
         WlVDg75O3V9wZcGVmoGYtTqh+SjmdAuFyBwDd/TVHlpKUrJ40VRYS8O1WINEjoRqZAkP
         yoMcNiCIVIgwVzUb4kfdWh1BBoqZvK4EyJk0WbecL/3gAD1mXmvJxB99rU74+MqVRCf4
         fBhNAhzu+ZuR1QGdH19YRkcl+b0cK63HeJIWOVk5qf21BkisMiG7KwSDPGF474lO9c1l
         p67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014523; x=1711619323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQnaVRKvIjzKZu/W9svAkJqqB541GQ+AgFRgogKa+oc=;
        b=cn+5cmXoAJVzcpOtYEiK7pdTVsLPqQN3TxNSl6f7Zr7Tfv8gQf4IntEYsi59y0+bW5
         7l/0ZrtjAKNtJ0SUDPQkZlOc2hS9VuERqI1a/Rtbvg6KvFFiPFSCyOMjhIOnZNRK6FOn
         NKRL/prZQacYdHjjIIMj1TTsZGkhj0IJqNvkoot3/st5zrBjoJGM2CJR60ULzmiO8HlR
         yOPm39V1lIdqClIO0eFrzo8ANT93I5358mgBrQcUipLobNe2cGt2NTlMU6pSREb0amBN
         JNMcKYLdVq+40miAX/5uKZtE3kFQO7EyVvLoRGkqifn/4QWiF4sy+CBmoKonVG443yG/
         ejCg==
X-Forwarded-Encrypted: i=1; AJvYcCV8oezLM7t85uOI4byNva/xKv+HAAvJqkhJQpu/wCCEmgxNop/9u9kg38icBmLybOOh5alKymaj8wQHnQF1mZ6VXsZIe4zDd+aTkBdO
X-Gm-Message-State: AOJu0YwlstTA8NQNEXWaVtM8gwOKrmx/OX0pJqdILz35ZKTBglnUO+rC
	DqGa5S/30UojPEFL1s/L0c0O25Yg/bzJ3yTAlZhx7rBv2FNEtLy2A8fsT3qHvaY=
X-Google-Smtp-Source: AGHT+IGvSZEOt1oQ+NlJ1ttHSdpngsPBxO1aKwqD8k2tM3F3kCenyeLG4fsre/EN6wfoIDduTKE1xw==
X-Received: by 2002:a5d:490d:0:b0:33e:bb67:9596 with SMTP id x13-20020a5d490d000000b0033ebb679596mr1273242wrq.64.1711014522487;
        Thu, 21 Mar 2024 02:48:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b0033e79eca6dfsm16682495wrm.50.2024.03.21.02.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:48:41 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:48:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, u.kleine-koenig@pengutronix.de, leon@kernel.org,
	asmaa@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] mlxbf_gige: stop PHY during open() error paths
Message-ID: <ZfwCd_7RuyEJRpcq@nanopsycho>
References: <20240320193117.3232-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320193117.3232-1-davthompson@nvidia.com>

Wed, Mar 20, 2024 at 08:31:17PM CET, davthompson@nvidia.com wrote:
>The mlxbf_gige_open() routine starts the PHY as part of normal
>initialization.  The mlxbf_gige_open() routine must stop the
>PHY during its error paths.
>
>Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
>Signed-off-by: David Thompson <davthompson@nvidia.com>
>Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

