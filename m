Return-Path: <linux-kernel+bounces-149651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5028A9401
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA011F22783
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED2B757E7;
	Thu, 18 Apr 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuNnMXTQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC36A343
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425431; cv=none; b=OyLSbWJlXLCLMPYL6y56ZoNW3S4ovYOF2dUoodqE7yuzxNhqXMFtrZ00YYZe0WdzSC+C3LNG2xHF5xG3IzOUvIQr28ux5cZDEsP8vcXriaDXPnl2POv55Ul5AgSen1Rb5aK8O65/c9kz547FSIaSGKsG0h3LmV/qnPOqPQ2a/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425431; c=relaxed/simple;
	bh=jo84Ctj+EJCX1GrpA4pW6fdXW7pDWtjFx80MeyJrxQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9OdIu6LXLpO4dPAys4N+4WgOwm89ZQkXkXyjeat+8KMTyYEVQzt5wLQq8TgBvPCgOl8gRKGwkSmLY6UDHjDxHSyZvERc+2qsIjSrI6aXSgpzay9HjGcbUKEQ77NFgOxaPZzRuoKmhmYeIBeVxAWP0ZzUnJNyTOApmNwtkQAGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BuNnMXTQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4266673bbso5356655ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713425429; x=1714030229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9KH/0gX4nuEqY5M5Shgab8r86I8FtVQ44AsXqRTnb4U=;
        b=BuNnMXTQIDEJKUWx/2aFeg9hs86yWeNWfbs9fWr3NUfPHz4ZZ6bsaUF0AwI6OSZdKW
         F9glOIhvsv4vQJ07yZg9yCaGrqNkPqhqn/h9XqDhKRHTUUL+fKC4sITH+Lg9It1tW8l4
         oJG7wbB9Yx+x9VFci1TsNejc+PCU5kI4LOLHFtXneaM5Ofuif9XgNPWbIXnvEM1d7vxU
         rZCgh2An6ORg8y5C92Io7bsjGO+q5+Md0itODxUk1boEmMTwvs5+2H9dM3dq22v7l6AF
         ccBpLM7YHwXqcqEf321Ml0GflvY6gqVnLkwWWIyZMZzzzlqCAVJCkuh+9g/iRvKT1XHj
         cbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425429; x=1714030229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KH/0gX4nuEqY5M5Shgab8r86I8FtVQ44AsXqRTnb4U=;
        b=LJEVuk3liIQeSTQPfvCWa+nCSlXJPKGKCaQbj2qm8FR3lbIgyCzhHW0VuQW6RxesR3
         LCEJmAIUsQlr1XrCJ2p/+qQT0G8/5uckLtt28J/1b2/89tblIBuamBrj3lZIMYl+hc2T
         +gRSPms6Hakb5GxCiON+SnjvlR4uz+5R3pTybpJQMlYCk/LT+8wHvnBAGUhvplPZ1wZ2
         i/rY0H7QBVzdhFq0VqSoLJ5cqvr4rZyXkqjlJRsmu6hc0fedWGwL1lvDNjEfmHErGqa1
         l6QNf7fEVWMKD4Tk94QjA54VK4yHQCOaCuddvtZIcpqhVTPkSpLMUVpR6RL8FUPqNQT+
         RmUA==
X-Forwarded-Encrypted: i=1; AJvYcCXmbVKle6xMzFzb3EhMe8EKlJyuZrk49Ok6btpWN5VDDv5oZCl9MJCVf53kVD03INzTk3xm9MEUX3KJ+fWOVoLN7SzjgoQKhLCodp6h
X-Gm-Message-State: AOJu0YwqFicdLsRYB8AkDo3bCBL8wDmtkl4eFpDyMcRyVFg/fhD1qeB4
	wRu6SF6R2AToHlW//jJ9q8BYAsZ7Dgm+D3FVY98AOUKvUdM2JHSI3XMgRaKLhA==
X-Google-Smtp-Source: AGHT+IFWMS7B+eevMfCZ0tH7FwXVvT82Lh4Zn0V4gbiALK6EFJmnT/7oWMZI+ml4e2wBetkcVDGhUg==
X-Received: by 2002:a17:902:da85:b0:1e1:6850:f823 with SMTP id j5-20020a170902da8500b001e16850f823mr2668391plx.13.1713425428965;
        Thu, 18 Apr 2024 00:30:28 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id j23-20020a170902759700b001deecb4f897sm837286pll.100.2024.04.18.00.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:30:28 -0700 (PDT)
Date: Thu, 18 Apr 2024 13:00:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <20240418073023.GA4331@thinkpad>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
 <20240418054319.GB2861@thinkpad>
 <ZiDB18w4bnUCSH7D@ryzen>
 <20240418065308.GG2861@thinkpad>
 <ZiDITzuUXsTZ7U4T@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiDITzuUXsTZ7U4T@ryzen>

On Thu, Apr 18, 2024 at 09:14:23AM +0200, Niklas Cassel wrote:
> On Thu, Apr 18, 2024 at 12:23:08PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Apr 18, 2024 at 08:46:47AM +0200, Niklas Cassel wrote:
> > > On Thu, Apr 18, 2024 at 11:13:19AM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Apr 17, 2024 at 07:49:45PM +0200, Niklas Cassel wrote:
> > > > > On Wed, Apr 17, 2024 at 10:47:25PM +0530, Manivannan Sadhasivam wrote:
> > > > > > Instead of getting the epc_features from pci_epc_get_features() API, use
> > > > > > the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> > > > > > the NULL check is already performed in pci_epf_test_bind(), having one more
> > > > > > check in pci_epf_test_core_init() is redundant and it is not possible to
> > > > > > hit the NULL pointer dereference. This also leads to the following smatch
> > > > > > warning:
> > > > > > 
> > > > > > drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> > > > > > error: we previously assumed 'epc_features' could be null (see line 747)
> > > > > > 
> > > > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > > Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > 
> > > > > I think you forgot:
> > > > > Fixes: a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier" flag")
> > > > > 
> > > > 
> > > > No, that's not the correct fixes tag I suppose. This redudant check is
> > > > introduced by commit, 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer
> > > > core initialization") and this commit removes the redundant check (fixing smatch
> > > > warning is a side effect). So if the fixes tag needs to be added, then this
> > > > commit should be referenced.
> > > 
> > > Well, you have a Closes: tag that links to a bug report about a smatch
> > > warning that was introduced with 5e50ee27d4a5 ("PCI: pci-epf-test: Add
> > > support to defer core initialization").
> > > 
> > > So if you want to reference another commit, then you should probably
> > > drop the Closes: tag.
> > > 
> > 
> > Then checkpatch will complain... But I think I can keep the two tags? One is for
> > fixing the redudant check and another is for the smatch warning reported.
> 
> Yes, I think so too.
> 
> You can have Fixes: to the commit that introduced the redundant check,

That is 5e50ee27d4a5.

> since this was obviously not the correct thing to do, and then perhaps
> just mention commit 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to
> defer core initialization") somewhere in the commit log.

You mean a01e7214bef9 here?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

