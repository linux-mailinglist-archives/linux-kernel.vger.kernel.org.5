Return-Path: <linux-kernel+bounces-58278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC284E3F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8AD28D185
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D245D763E1;
	Thu,  8 Feb 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8LGELJ5"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EEB79DDA
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405656; cv=none; b=CSxROwvogKXCB+RpSK/KE6X2GMf52cFUZ3M95cvuM+XQTxlun7mXZY2SnzLDfkzITK+koGMvt+wnz4nG0/KyOtIiA87XvU2oqBVTtFBPA9di90wOVw3X82LJQ3k3GePYxAsSB77g9FjXjrU1sNNnJh5BBV5tuAE6+Z3pZVbqBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405656; c=relaxed/simple;
	bh=e6LL/boihmzl95iQhD5MsD3wzUPnSlCg3/GP80js4bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPExyXqHrUmP32g/7rgj131+dyFMk29LCV8A8WfrACW5rkchWMQGkEnUBD88hf/3qlGhz6exO5MagWWoRnezUzmp9QdiVTAn4C5td3WbOKOFFNm6JuW57OEuG0m1OR1y00gUX0xTbiSQczSAn82nXaXgufk5+zRjw9XDG+79tJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8LGELJ5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1554749a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707405654; x=1708010454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4SUyOkuVIMktpMqHoBsqERsMG6Vrc32rtuOcsFES00=;
        b=f8LGELJ5HgVrHmedOT0H5oFgqU7opXfHS2EB8n3dlvicrOBop8aflXNGNQLAIFoR0q
         XftA0cv1PPiL+CGLYo/gqQIh9bxkNKcz8Erh4CwXm5kq4VoFYrmnpcw9xzgqBU+uV+As
         GsR3qiwXtSBhwKCsczPYKoYFtfiwYapgdS85cou/8ZZcLFFT25z5n0Mn9FqoacL9DfjB
         xNJnzqfpw7RJPAtnuCqAj9z8NfaETioUpROvE0Tn73adAqRSsKp+fO0qEbkqVGI8dsu8
         cgndAh/bTmDz/WImVGvxtXW/9D8oJ16ZqpU2aJSfIgLL++fjZL8WMGKf/h43ySO43qpm
         AQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707405654; x=1708010454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4SUyOkuVIMktpMqHoBsqERsMG6Vrc32rtuOcsFES00=;
        b=VVgwMtNut1UrLkrtufLCr2oh+u1r7THkbN8s0Kiu52hO41lhvG6RpK9f0odHMyvJKT
         ItXP02ajTG0nE68o6f9OsyQAaAMvC3e94wpk57KiSdCq/8VK+0Ad8UTbyhpw5RXqTnub
         kVAf59fDMfcX2t8s6zUUB2toifeWb2CZ7Q6stpq88OVz8VE/gck1dOMoeJoSnoud3E9N
         EFlMmtGjn6FUdhLC2cw0bo9RiVRz9D2ZLMX0VRgyLu1Vyv1qjxgWi1eZty9BZiQoV3kp
         K5jmiUd/htJQnWGp5Pi4SS7kMu3PIal3Yan7lJmdWQiqccOjqu6ECmBh1QBp+3Rjh+bN
         dLaQ==
X-Gm-Message-State: AOJu0YyEB9y8fbsvuSY2l+RQmuSlaOllARh2fQwjs1ZVaHAckWIcbNfZ
	1VmuXlWy9zqElkMX0WYWn99vxY0i6bW20mj0pghw9lTYBRe8GxplP30Kuv9f
X-Google-Smtp-Source: AGHT+IFWij2qLvMyMS1So8ZS5+EbE5THWihGnXyqY2UhXz23H//aOHTSEK4bTUi5aRbOfssdwTnM/w==
X-Received: by 2002:a05:6a20:1594:b0:19c:aaee:bb1b with SMTP id h20-20020a056a20159400b0019caaeebb1bmr9414587pzj.7.1707405653887;
        Thu, 08 Feb 2024 07:20:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKhHbop8QyLV7zKtS1yikcbbIGGioUvFtS8Ksy8Q4nTMXqusYEVCj+9Gh3yHXuX7zHCTVGbh1zeEVYGkwUGLfZpwqPeRNsw8yimR5NmsT+iP559ztzaK4/Pij3W02NcVPXI0Sp3ZaWxgRvJ8Etu1y6pi6HXS46CjiVfMPSuyXOp7v5ttRW
Received: from five231003 ([2405:201:c006:31fd:caf7:454f:61ba:8f68])
        by smtp.gmail.com with ESMTPSA id it7-20020a056a00458700b006e02da39dbcsm3988559pfb.10.2024.02.08.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:20:53 -0800 (PST)
Date: Thu, 8 Feb 2024 20:50:48 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] gpu: drm: display: indent fix in comment
Message-ID: <ZcTxUDb3_Xtqk8uW@five231003>
References: <20240124183659.511731-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124183659.511731-1-five231003@gmail.com>

On Thu, Jan 25, 2024 at 12:05:56AM +0530, Kousik Sanagavarapu wrote:
> The comments explaining the function "drm_dp_mst_atom_check_mgr()" had
> uneven indentation which made "make htmldocs" complain:
> 
> 	Documentation/gpu/drm-kms-helpers:296:
> 	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5496:
> 	ERROR: Unexpected indentation.
> 
> 	Documentation/gpu/drm-kms-helpers:296:
> 	./drivers/gpu/drm/display/drm_dp_mst_topology.c:5500:
> 	WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Fix this by getting the indent right.
> 
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> -- 

Ping again.

Thanks

