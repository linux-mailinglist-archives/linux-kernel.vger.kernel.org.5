Return-Path: <linux-kernel+bounces-56784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A784CF1F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665F828E407
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DE281ACA;
	Wed,  7 Feb 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atUuRV+3"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CF823AF;
	Wed,  7 Feb 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324001; cv=none; b=I3N0itenE79l4XpxD3xGlBePSHuN/Ml7p8wG0mXRs0f5w2f8zpmSCIEMcuGb992ZQJiGw1nys1hWlcQ1BqJPwYl6C8rqU96uzpfORQK0+fEMZb5T2Rk0ZttNs9yR4gqaZ2Erd3+ruMKcK0r6mvP+AylI6b/YMLTeMUvQuEaOlRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324001; c=relaxed/simple;
	bh=HytXVEy+ANJziuLYRMygHMgvK7XUKozrB1ii63nKIDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX5l8Lw8K7S8U9tK9Z/SB4olsKVYWanGVJqNLEDXB7AMe8MnW5sPJfKN0B9pieU5QDyJya8hHYYxG4UiX0fmSe8a9uq5mMFz2bJcs2zEMCL8Hh/p9iiZA/VlR+/ev7P/fQmdybBMAYhusYzacTFGd4rN6MwCYm15lz4aAv7RPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atUuRV+3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e053b272b0so576707b3a.1;
        Wed, 07 Feb 2024 08:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707323999; x=1707928799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8KJtp77wlYWq0w1wOKWzusn/Uo4anw6GXXyl6LfPT0=;
        b=atUuRV+3tAVwZVHXkydtwEXoqdPUySuMeX3rqfujh6WgMqVhEZc1iMPAaR/NvIvfir
         Xn0fFFraLNmLReNGoWfoRQtuulWiXXHxdrEqJ7Zlj7FMwWHWTFh/DjLYae1feOEMD7Nx
         ipVPTftUjkIUPSE1VMXGqs3h6HpL8eSpVbMSrx37MNcJlAmL9sabFSvgfdNMrN8FbwtE
         qcdSQOWlCrkE1mwSNqYFKivohXr3AgfrByKmHQhUrSBOxoJLDsi3yP4oX4Utvv2oGBvF
         PFrIpn1ab1dHKQ1zMRm5Elo68GYlKgBs4tAur9LZuKmbAudnDBFO/UFgg4WNaMg7OA+2
         k/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323999; x=1707928799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8KJtp77wlYWq0w1wOKWzusn/Uo4anw6GXXyl6LfPT0=;
        b=I+PPYPNGOIBseNlcfezapkinnc5XLMDScAJCNuU4tC7T1L0DFZYQaVJvL/SotwUwJw
         EgBYTYw6Q04A+bH4iGs9zF38/A1HH4mdIt5cvpwFfwDX0RG+WVRs30os8YJWaLAnaFa/
         5zSfdaaZYuzd6drEj7WMka/SPUd3AZFG1oNrYjm6q5126XiTSOW4/ks+mqbv11yPAVv+
         mOE4jjc9LEE6kvrAvfgJjz6+eCnOBQaxb5PZbtaz2ahXF7WG8wInYxLmNIKeW/B0yl8r
         7dZ4eWz5A1aolKb3pelugZi2WNcos43m8z6gHvC2+B5i84SzxAvcwrtqiW11Pohgrc0o
         qV/g==
X-Gm-Message-State: AOJu0YzvljgNSzYFxehkqK0pri0RQE4wVvf55seIvGyQxrK3jWCTi0Es
	UQ94t6aMdGWdl9iZC18i/gBz1aOpXswO+TgeQBWvcRSx0gRK+28G
X-Google-Smtp-Source: AGHT+IFAq40avHsEnwllpRS2lwsNcfUaWNOwO6yJ1fT11VX/WmuNmewsIsd/LJZGXV0o9y90rAImmg==
X-Received: by 2002:a05:6a21:3d84:b0:19e:54bb:c816 with SMTP id bj4-20020a056a213d8400b0019e54bbc816mr5112767pzc.26.1707323998855;
        Wed, 07 Feb 2024 08:39:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQeDrFaDqEBUp+0C2KiKLzE4SzQI4acky4EP4AOVn+bZ7T2JRlqjjSB6+K2oS+35zkZVxdHtBxcJBU6Zttd2GZYKHNTxQaihLbhS+5P4wbVgNKCyX41etF6rlbFo0kaLhXbJ5g0v9PlqzQ5GOTnZC2Q1VfnNBPwkyuPRg8YvoDDlOgq/rV5HRXt7OnmcB1IpNRONgGofFyr9bMN3ffeuhxRWUPEiUtveitUTFhPtZW3v0yXi1z4kuXY94iV8Wh9HY1/nY0rfbjap3L0nmmsh4atjlFGByqtWpTka9uDLYQ1r+S3H8G9DGselOqd6zmcx8/IZRM/0S6gvAkE21vwP+T1SZK//atBPsJza4lSNdormGXH5mHwMPt4z/7s8Y=
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id du4-20020a056a002b4400b006dddd685bbesm1807115pfb.122.2024.02.07.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:39:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2024 06:39:55 -1000
From: Tejun Heo <tj@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <ZcOyW_Q1FC35oxob@slm.duckdns.org>
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
 <10423008.nUPlyArG6x@kreacher>
 <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
 <CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
 <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
 <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>

Hello,

On Wed, Feb 07, 2024 at 12:25:46PM +0100, Rafael J. Wysocki wrote:
> The other one is that what happens during async resume does not meet
> the assumptions of commit 5797b1c18919 (for example, it can easily
> produce a chain of interdependent work items longer than 8) and so it
> breaks things.

Ah, that's fascinating. But aren't CPUs all brought up online before devices
are resumed? If so, the max_active should already be way higher than the
WQ_DFL_MIN_ACTIVE. Also, are these multi node NUMA machines? Otherwise, it
really shouldn't affect anything. One easy way to verify would be just
bumping up WQ_DFL_MIN_ACTIVE and see what happens.

Thanks.

-- 
tejun

