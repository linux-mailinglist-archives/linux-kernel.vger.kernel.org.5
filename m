Return-Path: <linux-kernel+bounces-142031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43388A2675
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F171F24F09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA872C87C;
	Fri, 12 Apr 2024 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YB4N7eMq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E663611D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903052; cv=none; b=tOL8WStA+tBkF8dD+XUSc93OrMo5kYpeZ94FviXNSRvpnw4qwRMugliCFmsToDkyys9m7d1J4CgXTcUK3CT98IvHVjSQllen43UOPyHhfm7OXijf//I3NhPgO/4Ifc+mEBQavWPKICEWhw6PKcoko3c54JmhoLuR57z+grSs13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903052; c=relaxed/simple;
	bh=0GLmHSGNmiAF2DmpKbt49+aQB1/2U9npSjFezwUw/1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTTYkFmtv8KPYaLssJ2iB11ZKnQX6+3vPGqNURJvTsy0U/kvOFGA92henFDaf6XukjUXY7dNWEtiNpjvumzd71tu1H6mnUFUcXIBZKc+ughzVR+qByZzz/plrVz5wGgoZQpkG+oLP7Reo7WEgJ46oxAhSwarpnVPqQRqSI0rWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YB4N7eMq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3c9300c65so5805905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712903050; x=1713507850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3K27Jb/EpKyrvqkBXTlJHPw4VsuOznOHMEoo+4oX24=;
        b=YB4N7eMq4wuALSS++0dZlY/jbHcTNgnrM3cbKpKlLrLwp5TrMOO5PjXvdZzfA0UohG
         R3pr+1s1o54Y+RdERNkGjona6RAT2tvjaYnhHeanaFswlnEOwWKzYo3L+ZBeTadbJwAh
         l8HDJgMtexEwxw2ghhlVGV+8VeycGZa9aMm/YZhz73gRu7VReImCeonByzp1ogggQ7aj
         ZWT3h7Ocy8beSyv5xWH9lxDzZmZuCTlt7KT+ZdjOFDRrwqkfWwGzUDs6w6x1OxTtg/PP
         LjWjtwZlmvvEbRRXdeHsrDNYZ18AIH7ZRimOg4EzJcSTJjsYjhIKwmN2vdS8hcoFu4PI
         uJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712903050; x=1713507850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3K27Jb/EpKyrvqkBXTlJHPw4VsuOznOHMEoo+4oX24=;
        b=ChjerTJ1IB8DM9HaV9XgSb4StBIoGu07PMwb+GHKKjh2EixlQ0U90jN0MNvn//Faiv
         lf84HdA5rLM/Jxg5cvltm8uHb3JpSblB5R5QAxLxlC8naQM0aeOolzS7r7zAAkObnFBc
         S1jTrxqWQg6xcdJR4iNGYbqKUDJq3DOmPhhBoYLfA+cUK4AdHHTxECfJynZvbYsh5ZdA
         z9stxdr9gWq3BxIb+ujX/vVRNX5/EVRbbgT5q0SXbgToq8hnTyOdunR9l4SB/ZiAX3Nc
         ElqRBw5pMmCEBIo3tNVwoOa3TH1cez6tHzfjv1cwDO6T1jWp7O67wu68FrNhon7gBrwJ
         TQgw==
X-Forwarded-Encrypted: i=1; AJvYcCVb7zrpZCu6ytYOzuwLG02Vgoo4z8mqXYxcza5JzpUKk3uzu0yxw1BBk64HbxzoYkQKkRfLXSd9krApKYxQjx8Ga4DfVnYDPuGOG3hZ
X-Gm-Message-State: AOJu0YzwtpOcI+xY7+faWZc3j88O9J80DSftyFaOF1LscSUy49Hye5nc
	fbBh20AKC8aRKCt5ATMDAM1EH9e8r0P897Oxw/1kKXF4Gictlff4prVBe5qNr94=
X-Google-Smtp-Source: AGHT+IHapdYpNtazPiszbiSvldPufTiO193eywbvrlVIV0YTrq+KmZ8bVwsOOYSlFnjA/lSzfW0ZxA==
X-Received: by 2002:a17:902:ed54:b0:1e3:e242:4dc9 with SMTP id y20-20020a170902ed5400b001e3e2424dc9mr1328786plb.33.1712903049849;
        Thu, 11 Apr 2024 23:24:09 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b001e3e081d07esm2210688plh.179.2024.04.11.23.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 23:24:09 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:54:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: lizhe <sensor1010@163.com>
Cc: rafael <rafael@kernel.org>, linux-pm <linux-pm@vger.kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: exit() callback is optional
Message-ID: <20240412062407.ntahibzv6xsbrnxs@vireshk-i7>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>

On 12-04-24, 14:12, lizhe wrote:
> I was the first one to find this problem, so the patch should be submitted by me.

:)

This patch doesn't take away any of the work you have done. What you are trying
to do is simplify drivers with empty exit callback and the unused return value
of the callback.

And what I am trying to do is fix a bug in the cpufreq core, which only makes
your other patches more acceptable.

So no, you never identified the problem this patch is trying to solve.

Please don't feel that anyone is trying to take away your hardwork. That's not
how things are done here. We appreciate anyone who is spending time to make the
kernel better.

If I were to take credit of your work, then I would have sent a big patch to fix
the exit() callback issue you are trying to solve, with randomly sent patches.

-- 
viresh

