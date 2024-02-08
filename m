Return-Path: <linux-kernel+bounces-57460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC084D957
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06B01C22EE0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB62E62C;
	Thu,  8 Feb 2024 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="nud4MXKj"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD1D2E3F9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 04:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707365852; cv=none; b=VNbWhH7qUGT1+io1gmmZKal7MKjV6hL+yq7/O8cdVg+o9ZiW7DszrZ5zpJnbPlUmuPx8aB5NXWoLoLouqaIs8mn7XE+QO6c9qtRg7LBHSI5nzEzM05uWx/2vbR2wl8LRKlx4wAgBBoIR3/9dZlpb+bC7MKKaGG2qE/1qvLZxlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707365852; c=relaxed/simple;
	bh=cAHh4xjhBUsUvi6dV0lRc25LSMG4QeXOE/23496L/SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtX0gbZEojpYY0xLJA8LWYFvVqO+zeS810UdwhYltbvkpTfatzFu8bA3c4Kwdu0+ETLi8focZ2lIWiN+eMnFopXT4SpFg0iFplVDWX/8bTkdXYBGrXcTbWu9mGhSqO0UYPjp0ksJYvDwLMBpPR1BSlpmt0Wjq8PI4Blieyn+ZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=nud4MXKj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e054f674b3so1029384b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 20:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1707365849; x=1707970649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMfM6tLjsjGv++dP9ohEDO8bzLO9AXA9FZHQRHDHuD0=;
        b=nud4MXKj8JDgAKaSMtBUg0URbf0yf4kvrvH8dd9wxm1t+a7/fX7t5X/Etg7oWHCSBn
         Ygi21z+n/ONyW9ewy7qC6wnWQMosUfxJVYDYsHUVx8BpMJJQYunY0hBG60CcZTj/tSm5
         7UmF6ywFFf3nAU9T3QQ6Wgggl2ZHFDgkHcGranLt6XFti5wCfHCDuYlsZaaz2OfNWwiQ
         GSHejnSZmNwwoWzTLcFww0EY9j5DPMaXyzEauOtMXixSfnQptLvjuzDGW/RpmJwSEz0B
         L6eoAzS/R1a8WoJlmxxDsPEERknrzIHxmKdnjDZ1A+QkNUJT/on761N2v8+YoqQjhmO8
         pdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707365849; x=1707970649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMfM6tLjsjGv++dP9ohEDO8bzLO9AXA9FZHQRHDHuD0=;
        b=J/U9eMR+gkNtXfCpLipS87FeXSLpSdBri1V5tS92Cr7884OVluUbakH4E+GXjTbcfc
         BrgqSBihYkkyL2ar2fqdqg0KSAi+nRnly10sRRMb9I9rkrPvclwv2dg2hEn/HwoYWlwY
         V4C17G2wZyOnb0+nIXr0N6txPU+NiqbJvqcwAnYTiebTvi5gOwYEobCevhZXnfqg8GaN
         0ttBnjL+7upJHiq+cboeJCGdeMn+NC5vR41YKYLCC1lJ+8aP7it2ReSKIMrgBNh0bdTo
         hNOLP8NIZD0rsuGm9NGyCnnBlSIPF6rUNRILWuDZE8MEnMffRcID6q9hdaJUAnQSlDII
         l8AA==
X-Forwarded-Encrypted: i=1; AJvYcCWCxPaIg+upeWqn8T+H1HIWP7NjJJaXWRIzrRvJG2rQp/vXoX8r39mOlBq3UzWvCwdUCsF9MkhkUO+tTW+HUG1dOahqNdvRgSSfdz0U
X-Gm-Message-State: AOJu0Yxd+/6q/EQPzHm6q461AL+n1IA4ollfF+FfIZeIOBy3owEIuXM5
	lC9jNzj7g180IRep+4csJBP5qm37NT6hxFntZHA7d6kq9XU9Sq6xBBA2HY3Cb6g=
X-Google-Smtp-Source: AGHT+IGy56Ygai1gEesu11gcC5X7oygZYFdrRpd1VgYGiAFJeE0xjOR3DXoJ2a9vLefMqnwckTySXA==
X-Received: by 2002:a05:6a21:9214:b0:19c:5ae6:4425 with SMTP id tl20-20020a056a21921400b0019c5ae64425mr8350230pzb.59.1707365848984;
        Wed, 07 Feb 2024 20:17:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWeDIoarGsQx3+UKEz2tEshr1jtFWhOljZpJblOlXsUweFB7dY+oThk+1y+Uw/fQWVuSyPNYrKLJ5eq0PdMVe1Tatbj8GTEK9MG0UfNls1BEwdwsc93HkJDUXV1CX0PP7N4Du2STjp+fU4OslOUawzmCn67uTAQ6p7/7vyZymWNQ+RKGnISD5lsF6xJI2MtRIH3rdbZSMlDMW5fGF18O+Bh0tOBcmemCm63n65N7Ze1V9FR8cfmCYPFW7OLTwro/yrfouI+AemQx+cnDlhVHZh8t9GQtavASrrdOq4PTKYhlZXhlBqZOV/2nr6vMPSOal2MeECG3/DBHzfZ5LpnQ6+0TuUWjkUtnb9TiaCtYa+ROQeiLpPqsldrnzZxH0jMu1LYcDlwGzxiG3G3ZE7x8P0cliIh8+fln/sdIL253DhGUvTQv7yrUV42VsD45tS6GFFQdqAx/dUV5Jmk91NcC5qQdBO6/CXEcxpD7Cc/PfaSbmqxBnA0pw=
Received: from x1 ([2601:1c2:1800:f680:3e6:72a3:7bf1:6e29])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902c74b00b001d9ef367c85sm2171292plq.104.2024.02.07.20.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 20:17:28 -0800 (PST)
Date: Wed, 7 Feb 2024 20:17:25 -0800
From: Drew Fustini <drew@pdp7.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Message-ID: <ZcRVZYtmFMz0fdjU@x1>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130222034.37181-1-tony.luck@intel.com>

On Tue, Jan 30, 2024 at 02:20:26PM -0800, Tony Luck wrote:
> This is the re-worked version of this series that I promised to post
> yesterday. Check that e-mail for the arguments for this alternate
> approach.
> 
> https://lore.kernel.org/all/ZbhLRDvZrxBZDv2j@agluck-desk3/
> 
> Apologies to Drew Fustini who I'd somehow dropped from later versions
> of this series. Drew: you had made a comment at one point that having
> different scopes within a single resource may be useful on RISC-V.
> Version 14 included that, but it's gone here. Maybe multiple resctrl
> "struct resource" for a single h/w entity like L3 as I'm doing in this
> version could work for you too?

Sorry for the latency.

The RISC-V CBQRI specification [1] describes a bandwidth controller
register interface [2]. It allows a controller to implement both
bandwidth allocation and bandwidth usage monitoring.

The proof-of-concept resctrl implementation [3] that I worked on created
two domains for each memory controller in the example SoC. One domain
would contain the MBA resource and the other would contain the L3
resource to represent MBM files like local_bytes:

  # cat /sys/fs/resctrl/schemata
  MB:4=  80;6=  80;8=  80
  L2:0=0fff;1=0fff
  L3:2=ffff;3=0000;5=0000;7=0000

Where:

  Domain 0 is L2 cache controller 0 capacity allocation
  Domain 1 is L2 cache controller 1 capacity allocation
  Domain 2 is L3 cache controller capacity allocation

  Domain 4 is Memory controller 0 bandwidth allocation
  Domain 6 is Memory controller 1 bandwidth allocation
  Domain 8 is Memory controller 2 bandwidth allocation

  Domain 3 is Memory controller 0 bandwidth monitoring
  Domain 5 is Memory controller 1 bandwidth monitoring
  Domain 7 is Memory controller 2 bandwidth monitoring

I think this scheme is confusing but I wasn't able to find a better
way to do it at the time.

> Patches 1-5 are almost completely rewritten based around the new
> idea to give CMT and MBM their own "resource" instead of sharing
> one with L3 CAT. This removes the need for separate domain lists,
> and thus most of the churn of the previous version of this series.

Very interesting. Do you think I would be able to create MBM files for
each memory controller without creating pointless L3 domains that show
up in schemata?

Thanks,
Drew

[1] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0-rc1
[2] https://github.com/riscv-non-isa/riscv-cbqri/blob/main/qos_bandwidth.adoc
[3] https://lore.kernel.org/linux-riscv/20230419111111.477118-1-dfustini@baylibre.com/

