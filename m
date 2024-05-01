Return-Path: <linux-kernel+bounces-165521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD7A8B8D87
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB121C2113C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FEA12FF7B;
	Wed,  1 May 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teu73MUk"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82012FB28;
	Wed,  1 May 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579031; cv=none; b=GvI8s1MUfTiJCBxVgkzVFp78AWffdOKiB7CjYO+ApJwuypHzr2qSIYNUz90yX8BFzz4BjdXytDab7Rbez1b6Id752h6c86SF+L7fZQHUyU/W+lWSgu9VADHjU8+7IVevb2l4sLMFORzeJjjWSuWWy+0576io+ytKun/k7Sho2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579031; c=relaxed/simple;
	bh=ckoWfyyPNvCGxi2fVomdJaaX3vET2oCk2vilFXck1oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mve1SLSzeXTPC6pHk5seRXGehaXPv9DGJ2/fKdOkwYfdruv1M3Fa3oEOIKiuA0foLOT+4EjJve6YawkvT8n1voSvtBWkCwWadlpAJvTZ6IJmm2x1cPo1vmpEXR7mXSls/1LVIfTUnb2Li2PE5Saz18yV14LoJojhNxI3NE4IGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Teu73MUk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b370e63d96so79687a91.3;
        Wed, 01 May 2024 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714579029; x=1715183829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzfY/kmW53uOWAjNU/h5BVe0MuVfIdc+r+3hv3BH8NA=;
        b=Teu73MUkjYaEKcNVW9NY23lU4vyeAKML5RMpZHGJGbl11WFR/s/ItVK+/rVuvX/DM6
         DfEM6GQHctpsaEbS410C4VpWumWCMCCIWNJ2rNXsdzW4DgY2V8TTR/B5bDHQKAHfVMIi
         gCTBhO2N2Mqpj3m9Wv2FkOxQIUyBI85PalVwYfaC1Ku/g92Ll0rd5agVvxxUuECha7pd
         kHkXuWHPcD86RPeyqQLpZ4UyGimJn8iefblg0XCWmIZetTpncELrkPt+AIj+UYnCzOI1
         4lbeiXIAYhM4X2OlWZO13/q0esvN0Ixrwc6Pb0mmfP5fmg/zxUxI6E9QFHTAjGcPUMG0
         QODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579029; x=1715183829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzfY/kmW53uOWAjNU/h5BVe0MuVfIdc+r+3hv3BH8NA=;
        b=xUveGThBhfwoTKZbCVW6oOq+LLJTQDYex01rGxllUdT1WcxX+QE1uVyzhSn9VlGs19
         f7ipKuobHN5HKn1UNH9PwhvhN32AC5AXGFgPuK8XSNHABzFQ/hdlXz/hRY5PrOgE8UpV
         LWHv90HQXDEiwMB29BFmYq1hn3Ybf+1FfDGaOQjQ4L5e3rXGML2BgMY6zkCebNvrkJM7
         aKMQ6sgKsXtcGs20PqhRRjHRNtzzD3f21R8VCdBDxQvTwdJAcfOtVWjDT5HU1AiPz02a
         H9E3c9afqZYuSPEPR0JW7xq7yoMvih42M09BgLr2a3Mwe5rxe5T80cmEU6pqpYTpQTMe
         bkLg==
X-Forwarded-Encrypted: i=1; AJvYcCUYZqg0799HBlHwYq+fl+ACQJWQzpBoIJOwLGm+rA969SG0mp6RNi/mKddZRs0BHEOcmIejH9Ez9IC0ysWUK1T8Ip7Ptk5qEl2w9IOHuvbRkjRgDHJ/CNwbrxB7UHhclbmOcKnY
X-Gm-Message-State: AOJu0Yxnig631ozZhXIBlmTEkQJ7c+6St043aX+JHsvrNOknhl4SLZw4
	0yG06HVFPtseCYqgyrnln5ZZpbMM9bn7HXmgZL/rq4LzCulsB8uX
X-Google-Smtp-Source: AGHT+IEqUo1eBvHR/WvPzsLh02ckKC0kjNX4dU4g0A0KwEIj4AgPLsyI8oM8EjDjFw9PvnKEhB/wtg==
X-Received: by 2002:a17:902:db0e:b0:1e7:b7da:842 with SMTP id m14-20020a170902db0e00b001e7b7da0842mr3016504plx.2.1714579029330;
        Wed, 01 May 2024 08:57:09 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b001ebd7bdaaffsm5820761plf.288.2024.05.01.08.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:57:08 -0700 (PDT)
Date: Wed, 1 May 2024 23:57:05 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Shi-Sheng Yang <fourcolor4c@gmail.com>,
	Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
Cc: Simon Horman <horms@kernel.org>, matttbe@kernel.org,
	martineau@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: subflow.c: fix typo
Message-ID: <ZjJmUcfDioUzX2Gg@visitorckw-System-Product-Name>
References: <20240429225033.3920874-1-james1qaz2wsx12qw@gmail.com>
 <20240430180057.GB2575892@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430180057.GB2575892@kernel.org>

On Tue, Apr 30, 2024 at 07:00:57PM +0100, Simon Horman wrote:
> On Tue, Apr 30, 2024 at 06:50:33AM +0800, Shi-Sheng Yang wrote:
> > Replace 'greceful' with 'graceful'.
> > 
> > Signed-off-by: Shi-Sheng Yang <james1qaz2wsx12qw@gmail.com>
> 
> Hi Shi-Sheng Yang,
> 
> Elsewhere in the same file 'earlier' is mispelt as 'eariler'.
> Could you consider fixing that too?
> 
> Better still, could you consider running codespell over
> net/mptcp/ and fixing (the non false-positives) that it flags?
> 
> If you do repost then I think an appropriate prefix
> would be 'mctp: ' rather than 'mctp: subflow.c ',
> as this follows the pattern in git history.
> 
> And I think the target tree should be net-next.
> That is, the patch should be based on net-next and
> it should be designated in the subject.
> 
> e.g. Subject: [PATCH v2 net-next] mptcp: fix typos in comments
> 
> Lastly, please keep in mind that 24h should elapse
> before posting a new version.
> 
> Link: https://docs.kernel.org/process/maintainer-netdev.html
> 
> ...
>

Hi Shi-Sheng,

I also noticed that the email you sent and the email from SoB are not
the same, which causes checkpatch.pl to complain about the following
warning:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Shi-ShengYang fourcolor4c@gmail.com' != 'Signed-off-by: Shi-Sheng Yang james1qaz2wsx12qw@gmail.com'

total: 0 errors, 1 warning, 0 checks, 8 lines checked

Could you please address this issue in the next version as well?

Regards,
Kuan-Wei

