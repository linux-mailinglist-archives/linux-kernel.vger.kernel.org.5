Return-Path: <linux-kernel+bounces-166262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F48B9836
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC111C21A64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682AC56B76;
	Thu,  2 May 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="R5TBtt59"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199756751
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643801; cv=none; b=on3Er/AlC46qfGaxpj+JykKq4DtHMj4oPCZLO1F/W3Z+0Hk6fXxRMJbWJjXw1GzylvpzL6AQ203GFNY5hq7Xi7oLGo16fn+xk9URzxbaCYo5TYtezfAeuai/3olJqjr0DJy6DuQPcdbd7wYQFX2WY6GBqFxzj86bFehayWL2Ztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643801; c=relaxed/simple;
	bh=3l3zV1CvMpPQ6M3agjT4bErcSYjrF9CaWcpEI3wJ9GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCnT6sXfmNbseH34qupx1/olSMDB9eQJUtxfgPbDxm5OzlomozXuRwCxeLEFmqHqFeEHQ/blo4QcM1JqN59kzkICIzZklFxk81jqnROqcy+BaRDs81V9xJHSIw+ZPSXAmImI7rYBnmyz61vYwlCN8qeA7CTtMKDXsuxfEPmdFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=R5TBtt59; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6effe9c852eso6837814b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714643800; x=1715248600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sucCdO5kXmwHz0FAAtAAGExlkRhEC3HqOy4Cv/qw8KI=;
        b=R5TBtt59vRw7pDNWPRdtnfrGzClC8OtQpN13oIl6mLbBGMWFqAhCgjMJ77PVbuTvdK
         w76Sq5hiI2T6WsreDf4rWfkHBD5ekHGzRUAuuKldv+z9sSBPcUWUkS6lxI3E11+Kz5gx
         8TPx0FK8znm3jozKmGlvT3OEr40HlR1WZ6nC9NafGgEwr4qvWEQs+Q56/Zi7X7HW4Xp/
         cEhnVJ4XtgJSpYnDJ3aIieLt6bYy+QAlpkvO5opoA/0pS+FqUOJ9XvXpsS898BH0yRsx
         Y3+GCMzFw2feSDRYNRSL6Daa8xbWWBIVz43B3hZs6+vvvWnlLjNFsfP7TGH5Pg/k3+qa
         oWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643800; x=1715248600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sucCdO5kXmwHz0FAAtAAGExlkRhEC3HqOy4Cv/qw8KI=;
        b=nYVR1HCWLQf9npIhO2vXypu1JEzgD27H4RBvG5rnUb22vEqjDaa5KcZ8SRqgl59+Y4
         R4s3Egj1Cy1/CTOCT0d9JiklP4qSOmhZXANMIyJbbPZoCizQyHSBpKTZUVHV876fh/gc
         Ugy2F57sD0vYtt3t3C3FjwomcoF1Sy7QUBl8g3ELMAqn89vzHDZxO1UzUUYWmhoE/dRG
         zsS3m6k3gumjqlKoEXZEHHxUuvaOTzJzHTKnHDRlL5uLnYGHHRwLbvMNA5Kwgp001aYg
         HBkq7wsGoovm25cMCOnpZVKqrTE1+t3OZ0UeVW1eu+QrvnlQGPdhA20NafQWlBIoQmmM
         6qJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKPdRTTTk4A7zyDTBx6CoN8rAVCriHl5YDgXiSF7/CNaehkqWf9hv8z4apX4YmemRvXOKP2cfrcAchXc8KQLokCy7jusNbQGqlQv8e
X-Gm-Message-State: AOJu0YzcgrUfBcX+ylT2r5XCs0BZbR54OykZe7gwRKl8kZAt5r4vSqzz
	aGqzUKOGnRcXUu0BfXhKWs+yWSR4WRTztacY5NCEPAT7Dyrjb74CfFWoKPpsxCQ=
X-Google-Smtp-Source: AGHT+IEdqN4j0tZUjqkf7AiQCf6AILBV0FVoUPT7pSiU8sVSt1YtTCq7aHm3fUhXEYUOJZhfGVfIwA==
X-Received: by 2002:a05:6a20:7f86:b0:1a7:5402:8a92 with SMTP id d6-20020a056a207f8600b001a754028a92mr1702915pzj.31.1714643799826;
        Thu, 02 May 2024 02:56:39 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id lf12-20020a170902fb4c00b001eb53dcf458sm864846plb.188.2024.05.02.02.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:56:39 -0700 (PDT)
Date: Thu, 2 May 2024 15:26:26 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 01/17] arm64: PCI: Migrate ACPI related functions to
 pci-acpi.c
Message-ID: <ZjNjSpJus7EYT6zn@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-2-sunilvl@ventanamicro.com>
 <ZjNbVPYIjINdk4Fn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNbVPYIjINdk4Fn@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:22:28PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:26PM +0530, Sunil V L wrote:
> > The functions defined in arm64 for ACPI support are required
> > for RISC-V also. To avoid duplication, move these functions
> > to common location.
> 
> ...
> 
> There are -M -C parameters to git format-patch. Use them in the next version of
> the series. (Note, you may add percentage numbers to each of those parameters
> to get prettier result.)
> 
Yeah, I tried different combination of percentage after you told me last
time. I just didn't see any difference in the patch generated. Let me
try again while sending next version. Thanks!


