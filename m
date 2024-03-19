Return-Path: <linux-kernel+bounces-107547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDB87FDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7558D1C22039
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DC540854;
	Tue, 19 Mar 2024 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAAZ/c/B"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E93D988;
	Tue, 19 Mar 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853234; cv=none; b=TcVIVYazWBTAcFo43Graz/kTt9t4/JQU0FZ7k33QkQg6IYTJfM80HvKbqqed5t6X1asJK7YS8ICAxOlDTstKoiUf5/HbWY6uT1NGcmg6wpY3ZhaFrUsGVOl4eummuqhgXT+kC44UfKqNXrvR1oc+hA4fslUYcmcH9z2tr2f5jrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853234; c=relaxed/simple;
	bh=X3ngRTOmBSENfT4pC4SEpBMNoSAl96UHnRwIOZMD6Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaUj8BnbvXL1smE6/K+390d9RU97kEv/eyJ/CkR7ATViE34OO7QQu/HDHJY2qu9tHdyMISVxopwl6jX+ZA3Eva0gclj6eTRBvWGAnmjf0Nc42Wb3q95uEkOOF3XpxMzYCBN0sIfkJduEe35k/KNoUm7NrUWujy+4pAG6qXyRMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAAZ/c/B; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513dc9d6938so4751017e87.2;
        Tue, 19 Mar 2024 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710853229; x=1711458029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikpifW49vxDzRqh6w6Bpn2L4IqQ6nEASXcredupfisA=;
        b=UAAZ/c/BOk+3Ni2SbFGxPvBgyyxC2IeRvTFalpVt6Hr2ETuCq4qGZGN4Okd3JAexK+
         32pQ55dKNxYR0qsdMHf3eTfZ8CwdQxqMo8CFWDFGZZPGtBDTZdo6O9z+P8DAeFUCJ4vO
         vQ+1MQHgVjeQdepRhZJwKjt2q1eq6xjc9xHhAb+pkbjhPThAWigf0tHzvTT9+g0W1YWQ
         dtMPR3jCZFx098KTDqA1V/0XVgXgYvnqFc0cgbOrtC3EH9Hse29CwneJb/WSJOqyssqk
         9azLIpk3AsUB3suqiJEixrsrWoBg1xWgtcqewyCWVa5eZglI8yymSI16wd7OuTXfZf3s
         hY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853229; x=1711458029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikpifW49vxDzRqh6w6Bpn2L4IqQ6nEASXcredupfisA=;
        b=WRY9ZY7utkaP7qIgLRijuCtwJWqyQ4pXHyJf/aUDiQYVIn3HlyfROKDRy4qc6cUURR
         Zga3hApWpj9kOO+BBxNIovAlAcNQ6PtbV4wFX0u5z+kOD+BID0nkGcoquHED+Oc3OsDa
         VL/RqmlK/5zcDNJTZ+WO80sAyn6cihn+7EC2ZTPnDsxpXC85GUN00eO6OtwKPhZTyEC5
         nnGa1RU2CaHVYGlpdodfml3We+2yuCgDVg+fMxS1XJTmPbcLwzfkCA956Vd9G5NWbfac
         FXY4f/SWGCFE7B8ofy7hQ2PExBkTJ/e3cJIoYXP0SShnph0e6kyBf9C2bPTM3vazt2z0
         EzdA==
X-Forwarded-Encrypted: i=1; AJvYcCW9mhPbpwx5svc/Tz5eUsICUlSyUZ5Sx1GKZvm1kyW2NenmqQXzWpb6nMh9bH6XyTlfLb8/fJD4QvaFu3+G7afdCTjPA+fiUW14nPY/
X-Gm-Message-State: AOJu0YyginyneFAXnQS0ghyqFtoxCKcCMyA6ND85vWs8hihheuU9aKzU
	tNhnLZTj1HeW9bcPsocJpJQERShtlycarfibEBr11gdYKoG04znBXDBpZ6OOcWw=
X-Google-Smtp-Source: AGHT+IGI86wqXJ6dM5dzMduFBDisRJzegsAzdOqnsvwuQhicxoEFTiIQYra6hsGrjAD02TVhKD88vg==
X-Received: by 2002:ac2:598c:0:b0:513:a732:4878 with SMTP id w12-20020ac2598c000000b00513a7324878mr9890140lfn.41.1710853228990;
        Tue, 19 Mar 2024 06:00:28 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a44fcdf20d1sm6056859ejb.189.2024.03.19.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 06:00:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 19 Mar 2024 14:00:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
	seanjc@google.com, pbonzini@redhat.com, eranian@google.com,
	irogers@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Subject: Re: [PATCH v4 1/2] x86/cpufeatures: Add dedicated feature word for
 CPUID leaf 0x80000022[EAX]
Message-ID: <ZfmMah58YSyYGywo@gmail.com>
References: <cover.1710836172.git.sandipan.das@amd.com>
 <846eebace0aea3a600b81b06bddd0024e5ac1350.1710836172.git.sandipan.das@amd.com>
 <ZflmU+H2Lt2I0VOq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZflmU+H2Lt2I0VOq@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> > +/* AMD-defined performance monitoring features, CPUID level 0x80000022 (EAX), word 21 */
> > +#define X86_FEATURE_PERFMON_V2		(21*32+ 0) /* AMD Performance Monitoring Version 2 */
> > +#define X86_FEATURE_AMD_LBR_V2		(21*32+ 1) /* AMD Last Branch Record Extension Version 2 */
> 
> Thank you! I presume you tested both patches on the relevant system 
> with the X86_FEATURE_AMD_LBR_PMC_FREEZE bug?

Also, Boris reminds me that we really want to do what I suggested 
originally and use a new synthethic word here, not a new vendor word, to 
keep all the bits better compressed in cpuinfo.x86_capability[] - so one 
more iteration will be needed.

Thanks,

	Ingo

