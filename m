Return-Path: <linux-kernel+bounces-155224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72D28AE715
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DF2281935
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05F126F10;
	Tue, 23 Apr 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vIuHSojF"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C778C6E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877015; cv=none; b=LRq+3+004dedm7py50cLgs2X1d59IzH7wKo1V9ysdEMeAhMtzdds1veXNGlY4570X64b3xncl/EoSJgjd3C/AvqLEynap87eN4lC6V54BIpVV3ax4t8KqjoV5Sjawlotbx0782gJl4CfbLmlWGxTuZ3Irea+RWJOWJEUfPSWGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877015; c=relaxed/simple;
	bh=f6Z+o+xgj9PM23FyriN0xzEPc3uiy9E/YIUdc03valU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKVj5Av+DlRGTykAzutOtnU2bwTJunSapACgci3GlCEDrWsQaGJFJukwie5ErUjCqbdSIplui9PBR22nwz5Y2z0ZgW3WELFvMmqqhJ4320OMlqRtQWhJmUz29nX2V4km6bpyYDTptTLxgu2k8Wnxjf2YRccTbOkbpjTjlXkCVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vIuHSojF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51acc258075so4690712e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877011; x=1714481811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6Z+o+xgj9PM23FyriN0xzEPc3uiy9E/YIUdc03valU=;
        b=vIuHSojFtK3XYpB16TFKoOissahrx43Aw6ew7pZbdD0sPlF9ZAICotBpAaqlcQfAfG
         vheAhS+GvK2RZvhFEvRAv0AEzcOiQolG7TDw6h6afvYjlq9Ddy5u6hnL/ZtfgW7WiMAQ
         lLFCef2IRhrQsk7ZpVwnfbNkubkbrU1Uuuyje/mk9ZTF4UyL0eGpPxrSnLxWc0RJJSK+
         rfsh/liA3U6KKLsUnMgtB/J4dAvujnWFirMi0I5RIadtMjOY5TS88HhVx5//rJVfjA50
         Rho8wQIZrBSiYA6XDWwKCLeuWQC/E0K79oTaIDxqwPUFS/mO/ekP9h+UxXaxLIwY6UB6
         h9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877011; x=1714481811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6Z+o+xgj9PM23FyriN0xzEPc3uiy9E/YIUdc03valU=;
        b=vxxFJ2IvSqVu7x/lCZo8lTaLUgK/VLQof3CcWQZl+pudsYL8yEQAu+KC2gWv1Retbf
         8zt/vt+OwMYpelqOaPDBt2J5RGsl9muaaRE8x8vv9WxA/UX/iFTgNb8KKzVx95hjqe7/
         id7fAXmoJfbidgr16p7FiMl0qYbur+v1XdYsvu6JL1jbJsv0s1B0sZEWsZNca8TwBaaH
         JeZVBsbgUi1V25A80UZYOx7MoKUX2OeSvQOnuJNBagmSSiRBd1zttZCWmd9yenKAlJIu
         mRjhXHlPUzHjp202ihNHJsRURsOgyMQY2hN+gN1U8dtKzasaRyoeVxEyao6RHTzfzA3e
         myag==
X-Forwarded-Encrypted: i=1; AJvYcCUvwh3q3+cdTH1+8rcYv3enNgNmNRrdW1q8qnbKxmlZCw1TQWU9xybBhk7mPoywfd8MARkbhcDB47y70LrSO6Vz+6BBauQKDT9+Bvw7
X-Gm-Message-State: AOJu0YxYXgsfBhlpYgzborqwHqabF96A5GpoA6HZvKpr5jltpCZpLT9C
	CSdubvDAvtYOmBs6CEFP87wPZ3velnQghU2zOepNkH4KE8+6BKFNJ7QsHvR9nH8=
X-Google-Smtp-Source: AGHT+IFFuhrISIMhxTfW6IGKz1USrI/VzV1UhYtSxvpvIJMgOYCxg57AMxIr7EOvnNCAfxzw/2nmmQ==
X-Received: by 2002:a05:6512:3693:b0:513:23be:e924 with SMTP id d19-20020a056512369300b0051323bee924mr7414572lfs.59.1713877011358;
        Tue, 23 Apr 2024 05:56:51 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170907360200b00a55a8ec5879sm3408082ejc.116.2024.04.23.05.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:56:50 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:56:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH net-next] bnxt_en: flower: validate control flags
Message-ID: <ZiewEJb7KHXeoFeJ@nanopsycho>
References: <20240422152626.175569-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422152626.175569-1-ast@fiberby.net>

Mon, Apr 22, 2024 at 05:26:23PM CEST, ast@fiberby.net wrote:
>This driver currently doesn't support any control flags.
>
>Use flow_rule_match_has_control_flags() to check for control flags,
>such as can be set through `tc flower ... ip_flags frag`.
>
>In case any control flags are masked, flow_rule_match_has_control_flags()
>sets a NL extended error message, and we return -EOPNOTSUPP.
>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

