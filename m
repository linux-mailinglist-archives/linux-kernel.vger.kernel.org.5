Return-Path: <linux-kernel+bounces-82094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C48867F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337CAB2664E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5CD12DD87;
	Mon, 26 Feb 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbX5F5/D"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA412B167
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969635; cv=none; b=CUyGfrtFJ1I4PkD+agtZtj83ke9WW9/ul6QjMXLSHs9iafUGFWKFuKJbo84Sr9/bJGyyyqZJshFHh9yfh+6t6H/t0bDeVuEmdMhMW0ZqTyZ1HkZXWwCfzEOzRIVR1gjOTKE2/NM+SJFyCTK6Yc0hgGGNHvkWAlX33Q2XsisgaCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969635; c=relaxed/simple;
	bh=B41ir5VYbxpF04PAmMUAVJ67JQSh5yH++omCohwmiS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/f8LTkOaR6IZTWWzX/M+/lBVKXxX5rDi8XYZOE1+CSvoXAe5xrkJuxwILZpCLKLIgxBbgJBrPHNgACTz6qG+S/wp/6LoUGfvGoTgrfFzCnvUi+L08wOmYQ57SwIOtuStWl6W1RJgRMI7ZcOfqAqHfga+YIFWyFrwuk4DtYhDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VbX5F5/D; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e49a5b1bbfso916357a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708969633; x=1709574433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+coxhOY/Hxui8PDFROluhcZaBPd/6HAGgu1JExmMgQ=;
        b=VbX5F5/DZxveCk2tDyNEIm7WztWZikJvS/YRnxBwsZMnJs8Crnm5NwaBubebNioLHh
         ufnUC8Fo+DrZ/XdhakT6xmn6J+w06Iw/038QHNHAHcgR8X/gXKNWOt7gWYHOsIHwUUYI
         eDHouEcOG+q0xBuieDZtKUirxYjDaTLgK98shmMUrdvB1YwWaoWFiAI3jsJnsTQQsSza
         zQKkyJjGukK58k0PXIJ6i6qc528fCAU4XYG4Fr1D2MyVEQgGb2XUR1WdHyfCvbUln7du
         5RLdb/bRkvAvVw0PC6lHZG+zIMN7p9hBTsyHZxdBho3dxLBXBhe0eKAn9uNN8q6Q6acv
         9Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969633; x=1709574433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+coxhOY/Hxui8PDFROluhcZaBPd/6HAGgu1JExmMgQ=;
        b=E0OivX3p7T4ON6+uD5IkpesjpnvMUjx+ibmLHU6Z2TanWwdIyATXVX5cu63rx97gQ1
         yQq7lHDmFw8XnwGxPelwSTHXgpMg34eucAxrYnL1rkJo+238yAXxw6wyOH1UTT3CktBc
         uUFREEult232NVJqvDmPHPFdr4LUPo7rPummqDGkjfN6xeFxlQjfwq85ZYEJ+3rJerl2
         VtX4wSeC4apnYa7uRw5tjiWhUTtDxxsh+8dO/DDhDxoRugV+bxomYlKFU28B/2BvOTRF
         Jgar0i8pyeJjagi/whgU4llpqiq4bpc51JcsG/RNvgf8Kc4RAvxK8SY+0p8nZ/lH1cL1
         jWuw==
X-Forwarded-Encrypted: i=1; AJvYcCWbA4pG1Pv788+Rr+rvXyQ0d6gtGE7yolr71yEoSHwKqY+ZcRpRvyxd90wa1CW0D0i3Psv+dof0bRqjmKNQqa8k4jJcLwrnXpqAj/SB
X-Gm-Message-State: AOJu0Yyb6tAyzrNQWrGfFW1pIXUO4fA/M+f1rCudl1aotSrrYINql6z3
	NwW6wm2nuEoqjgkJvilu69rfpjgIporRZGEydYsPQ//XrFFLsiszDnm4gIoub5Y=
X-Google-Smtp-Source: AGHT+IFCePGlGVE4lMjTY0/9moCLWOzSCx+v5oqeY2701JqpmJJ2XNiwbKLDRoBfBHN6yiXmmfdKLQ==
X-Received: by 2002:a9d:6c42:0:b0:6e4:8122:c5a2 with SMTP id g2-20020a9d6c42000000b006e48122c5a2mr9142155otq.0.1708969633143;
        Mon, 26 Feb 2024 09:47:13 -0800 (PST)
Received: from ishi.. ([185.243.57.248])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a034300b00787c7c0a078sm2247762qkm.121.2024.02.26.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:47:12 -0800 (PST)
From: William Breathitt Gray <william.gray@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] counter: constify the struct device_type usage
Date: Mon, 26 Feb 2024 12:46:49 -0500
Message-ID: <170896953583.22408.16217091033236084164.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219-device_cleanup-counter-v1-1-24d0316ae815@marliere.net>
References: <20240219-device_cleanup-counter-v1-1-24d0316ae815@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Feb 2024 16:52:52 -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> counter_device_type variable to be a constant structure as well, placing it
> into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] counter: constify the struct device_type usage
      commit: 3bb282ef1149a08a94bc5321b758825bc99c84c0

William Breathitt Gray <william.gray@linaro.org>

