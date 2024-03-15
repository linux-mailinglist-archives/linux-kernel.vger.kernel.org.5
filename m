Return-Path: <linux-kernel+bounces-104004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F45487C7C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B4A282B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01D0D29B;
	Fri, 15 Mar 2024 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="R/EVY4VR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2ED272
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471591; cv=none; b=EE1aeUfQaVm/1VGaFyS6VcsPTlfyI+GQBF2vUCzR+jbC90zSWVkThdsJ3vNj71zTKp8vGnJLCUyjFbQiv+rQxFE68fd0x5Tg6CJ437Ze1GHLcpW3kvMHTfFG53C4w66HOphMHT30zwStOCIhQvGDKyJlZmk7ZPzb1wLkMULckh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471591; c=relaxed/simple;
	bh=Gi6bYkUhl40PWspGJBH44VCyXQYToNIWB6h8WhyMJBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRVdfxqpXmO7PSzH3CSYQtbawJMohclCn7JZbYjJT5rq7gxEbTsAbAwFj20hOWaKGY7K/ZkZBfZSn9ABEYrH7drIIDhKA2r2poSvN9NL2mZTt6+EKw4jK9JYC9/WoPR8tqnalSMWf9EZQU230L2EK82EbT5jj3WKieVGU9i0auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=R/EVY4VR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dddad37712so15398205ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1710471589; x=1711076389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DF3u6fUKhDyXy3K2gFHmZ27anukGMBI1JFmpHSdBQdY=;
        b=R/EVY4VRFul6Eut1Bifc+7CmzHFnJppkp34RnIOoiS3P/dRoY2y/0I9C0BDA4sVpVj
         HVNOHL6meawiwM6tVp02Via/+JqD7LQyZ0kqaYMDDpBjrCloV+f8T9Y0Y9QPqMXIcYUR
         3t9Erp3Ijc5ZeYtiwwupcZPbknL3JiZY4mTVS1/5jUEf9+Pmtgpnh2g7nVKuoUoE/ILp
         SDP/iv6BcIRvzuz7iDSTQCVq5Decko86e+RbJgOuBYHPddzVMciMMcmSqCCSDie+0V+u
         asbx69iBKUWHLZg0vYMRXxeoqAkY3PScndkVX7VyOERZ9nWDuuk2cUdgoF6g2FRWT4R9
         rWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710471589; x=1711076389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF3u6fUKhDyXy3K2gFHmZ27anukGMBI1JFmpHSdBQdY=;
        b=Ayhd48WMpW5sNofJeSeYsDnGAY2GWNVPtPL0JyzsVXR09voCeSC9Onmwe1+HW4qOcX
         La8aedPv78l/M/szQ6muvEbW60sCtgh2e4W9WWsKAZ9rN9NfTRaPKLiHer+4Ivr09Ye7
         q2i740/cnZOHBeB7oxohZKJi85RYzRtt8eBFQZHUm/PmDuEQdvjNxSXIq0YCDNOQBRzf
         lPDonUlf9p8qpqpCRht0OMB9veqyrX5rYmenZTRgym8eme0qkeaPztQcgkybrDrFBaEx
         PFn0BRbd314D2PrJeeZuDdc8lIMu/MoNgP9x2GIf9eIv+u03zzVZKInJQeFTA75ZmEqS
         GytA==
X-Forwarded-Encrypted: i=1; AJvYcCWbVQ797XKs4eyxj/Xm9/h6lnUGubDpbR6BhxHX3bLAQg5vTaMQ/U7Hj2F6qA4m07IWwP/V/Nq2seuN9nfInWh/ifXaiv6VfZnC3w25
X-Gm-Message-State: AOJu0YwYOshAehQAGxkeWrV9SvzBPsQ1rBnq2wXkD/lr1geO9wnvr0ao
	RL4d06O61sbrh14e6fHqE7aLQO2ze7UfZPMhs7wV2W1zvL++ALSiz7aKm0hueTs=
X-Google-Smtp-Source: AGHT+IFCcd+8CehiYUMhG/6taZofm4Zmag/eB0icU74TL0kdsU7vlKVvJ1lw2qGnNTk4BdQ6IicmvA==
X-Received: by 2002:a17:902:cecf:b0:1dd:d412:906c with SMTP id d15-20020a170902cecf00b001ddd412906cmr4971466plg.12.1710471588778;
        Thu, 14 Mar 2024 19:59:48 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:a790:ff9e:11a8:fac0:d063])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b001def18c0cfdsm112750plb.300.2024.03.14.19.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 19:59:48 -0700 (PDT)
Date: Thu, 14 Mar 2024 19:59:46 -0700
From: Drew Fustini <drew@pdp7.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 0/3] RISC-V: ACPI: Add LPI support
Message-ID: <ZfO5oiVSVSmlP8eL@x1>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118062930.245937-1-sunilvl@ventanamicro.com>

On Thu, Jan 18, 2024 at 11:59:27AM +0530, Sunil V L wrote:
> This series adds support for Low Power Idle (LPI) on ACPI based
> platforms. 
> 
> LPI is described in the ACPI spec [1]. RISC-V FFH spec required to
> enable this is available at [2].

I'm interested in trying out this series. Might you be able to provide
some guidance on how to setup a test environment?

Are there specific branches of qemu and edk2 that I should use?

thanks,
drew

