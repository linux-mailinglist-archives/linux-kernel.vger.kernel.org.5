Return-Path: <linux-kernel+bounces-85000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E986AEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059B9B2408A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B33BBCA;
	Wed, 28 Feb 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QHS61vcU"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861A36139
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122605; cv=none; b=ADmK5yl2ov6vKxJhc/U602JwcZ3e9AUL3iz09VOrNleBwgiBNXlw4keO+isUujLWUqUCf7364TWQ5Nh6yiCx2T0l4Fky4DksLZW1yLFx/M1tajhj8flwDPSTG3N+173kuB03eixkntH8mXXXYZobeCkhwgFvvvNcK4l6NIVwx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122605; c=relaxed/simple;
	bh=ldvpcSU35Jz8322hCmCPRQeBN5Om3WvOv278ShMhodA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th3FNGCILB99O6aGGwHc1PJdWnu/owJ9/1kYLJ0lOHBgCVIUj8XgWkMvMG+Agr56co/PRmg///LKr2dXPwJDcKU088CjYE/LrbcW6u6d4i+8WHWMRTLMfxcXZzHOSCKqs0hTNY829mW0sF9f+HqEaGU//QmkIA2g43kAIXD77nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QHS61vcU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a441882f276so30871866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709122602; x=1709727402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1M9Nkh3R0yrVqMl2adPOdhz/1QaFUKB8Zn96BDk2Qc=;
        b=QHS61vcUkC8hfyvP6v0Sq/ZIz2ET0IuZgWvTZ2rSB/iahiViBGhYrfYudweAek6+vw
         QWdsvTka4JKvlLQZZzok2mIApKElamkpZdtOJbkTcZNyptJl0SFejMtOCmiHvCAPab9/
         AcW1EIP7F1Hrj5Cces/gs0JykGXoqP1Mnw7wihye/b9wUOhVtFmh8UK2TcKsDVcI9L9A
         VmeWW3WdVixDqZ2LBUFqkRp16AGvECtm9I8Mppg+l+KEz9YsIsw5Exbq1GeCAsuq0gGc
         DLBdxqqTar5wYjzo+9jTFpzY0ZwbhQ19gd+aEIDTvlHHTiZCaeM8Z+Wk5vxghuwd8bgQ
         E+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122602; x=1709727402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1M9Nkh3R0yrVqMl2adPOdhz/1QaFUKB8Zn96BDk2Qc=;
        b=XvFmS3mqwpKIEQz/HwTq6G8Zob6ndcHE4VEzyyfFnCpceui7PFCPI2+R8LTrJWGwWZ
         7q6vwkqrrs/7On7FToGkKQQVLqTZBGb31uSU47kuEDoNKe5EqaEfnDHdVGH3ZvmQeFSh
         M8HS9EvJIrmxOdGnf70Ih1u9K1OKcd9SnEGwujbTFJbA6lhRIuRlSI7dKS5XkWvnWrtr
         DHyvNtO9YfMkJFOnNv92yBuz2zCO/gsdtHjmPiRwFhfjdxiH8/Ksvu/9QmIqjAIvOcI7
         Y1YmO3mHFTHPPzfKFVFxWt2w02tU3TqOxRLkDl69VuJ53foZEWbHs/QtxNyIaUCzGhv8
         wf9w==
X-Forwarded-Encrypted: i=1; AJvYcCWwEoUf6hG0dk6kphlnEiJAfpqsplAooqEJg1I1w1XXfoJ+5RGiZeT9HiiWnH6JQ4z/tRBVg4EIsmA+n3zMZqj/SzZeUt4vSEg6h3zX
X-Gm-Message-State: AOJu0YwMHKXPZnsiqWhsgDxi1fQ6FOEkbwu/VAlUEZX7lmtylYtENTtd
	3owK6m1FvPfEZtw8OEa5PHt/rpjEF6BN05gsTJSXIRugf5IBE8g6NelpieYiMZw=
X-Google-Smtp-Source: AGHT+IFe1CsGF2APUDiVY14PUctNwIaAU5Ml4MK3iHilwHYud1qRv7qvb0fStxtDtgtYfeA8cfHqyw==
X-Received: by 2002:a17:906:796:b0:a3f:5c5c:33ac with SMTP id l22-20020a170906079600b00a3f5c5c33acmr9860351ejc.62.1709122601794;
        Wed, 28 Feb 2024 04:16:41 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906374e00b00a431488d8efsm1773598ejc.160.2024.02.28.04.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:16:41 -0800 (PST)
Date: Wed, 28 Feb 2024 13:16:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling
 mistakes
Message-ID: <Zd8kJgaOdJwe6BzC@nanopsycho>
References: <20240228082416.416882-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228082416.416882-1-pvkumar5749404@gmail.com>

Wed, Feb 28, 2024 at 09:24:16AM CET, pvkumar5749404@gmail.com wrote:
>Changes :
>	- "excercise" is corrected to "exercise" in drivers/net/mlxsw/spectrum-2/tc_flower.sh
>	- "mutliple" is corrected to "multiple" in drivers/net/netdevsim/ethtool-fec.sh
>
>Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

