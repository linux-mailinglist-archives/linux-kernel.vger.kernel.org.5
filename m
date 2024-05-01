Return-Path: <linux-kernel+bounces-165540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51FA8B8DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225E91C20B91
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10EE130A52;
	Wed,  1 May 2024 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cVLSPO4N"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9E12FB35
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579632; cv=none; b=IC90eaNofYrKC+QaJGAj3EsuVbSNHEjuAg4ZG+FtnkDFWOL/W/TwAuV3aiuPQHXARaEFHj7VXX13/D2c0Zkpt4das2Qmz8OLkeAtzqA6sh6AjAQq8/T3TqPmz2nFjnjXCIiy1D/gODpurjDcGbs6UWQK3QMu7acno5tpQ0mk8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579632; c=relaxed/simple;
	bh=OBhqEyKuT9SGbY1gPylDuVYK6xBEaByxvLrKFZiA8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8GKhzRQEIC1YazjQ/Z5rE/XQixfrqhTJhnC0bsqkq8nlB0vZ07NNpVAPEpd6KF3zjb0czYgy82sj1FkL5VJT89vsXlsZfhnAcwXeFAP9TPcir+yv7LqPdA7P1roNbyAApVuMDDIwP23MQoPZlu5H57CczsMhz7jXFGrUE/arXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cVLSPO4N; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-790f699eb2cso304170085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714579629; x=1715184429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBhqEyKuT9SGbY1gPylDuVYK6xBEaByxvLrKFZiA8D8=;
        b=cVLSPO4NpEYu7PFl9RKOxx9L/Y6USU5VD25hFwQrr063VgZokHQhxT+wqvQPNiH59o
         YUatDw/oC9VpFeFKHP9/pj1xQY0m6yoPdCNneIVQpVffazogsHJDh9XAsd1MnpQPiPpG
         1zeyIfBujbW86IJIPwtmYiQia8fIZdiOIogWByqDGCFSUg8tj5ucVXvMwpQmoEG68na7
         J9jGf89nCEp+dnBkYsQTcRyP20RysJDfTu+TR43P8J5/mP+k9bFy58VnI3Tsz4QnKqxs
         TfPyLk0eGiRGJxmndmYmFw+ELMgspN8182021+0MU9hqftGU1sBTLnaDyhx6W1tHSoMz
         oPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714579629; x=1715184429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBhqEyKuT9SGbY1gPylDuVYK6xBEaByxvLrKFZiA8D8=;
        b=SgQXyw1gABmusF/YHosaCybWsQnHPcrw3Q4Iz3Cg9RbIAtMQiEdZQlEN6P91T3EmmR
         nFvpMJpNx9HQ92tHP1JxqfqqDfmpa/1UnFhETcahJ6jGlCF0hKMBPgWzu1PTV/1BPWR+
         nS309ROu5mmz+GL3g9BuEU+e2gdaSZopSOTI6+7aio1XEM5SUywt8Usa0GK7nZxAK6iq
         YY7Wv8OeUoC7LKp3PxAd9QfPYjJw9f+es9cYFlT1zutrAk6sLT0e+2k6lN4YZXW7NrjP
         S+MDuQoVpw+BZ8+1Cu4+MsvD67Eq82txTf/djc2xcQGVnORves3ch0NQ+/mq0GQkH6A3
         CC4g==
X-Forwarded-Encrypted: i=1; AJvYcCU1dvm6KE6tk0C3xvveZsI6S1ATu3/L33KTX5e6S3TzWClxYaKfa58pKbwgINi930w/pGe2WrVizKCiOq0fFqGgpGy/kXSxXiO3v32g
X-Gm-Message-State: AOJu0Yzf6Zr9sZaP0B3rq3GFamUlqSzbEefwTYF+9Ce3+zvf+y5A1d3x
	PppDFazEANEYn52ViNLfn4doc3eW3NwD4USnBI1aP+bs+vo3SFJ39n7owFdFZy0=
X-Google-Smtp-Source: AGHT+IEIToKXo0oiLD8614cnvRWTKlqp8YbwZyKQg7eanOTB8s3Hn6dt4BqjP2UpzNxDw9ZcGXsFhg==
X-Received: by 2002:a05:620a:2059:b0:78e:e7dc:fd3b with SMTP id d25-20020a05620a205900b0078ee7dcfd3bmr2822573qka.73.1714579629470;
        Wed, 01 May 2024 09:07:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id n6-20020a05620a294600b00790eb55fd58sm3512214qkp.129.2024.05.01.09.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:07:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2CU8-00DuqC-5D;
	Wed, 01 May 2024 13:07:08 -0300
Date: Wed, 1 May 2024 13:07:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v3 0/7] Linux RISC-V IOMMU Support
Message-ID: <20240501160708.GF1723318@ziepe.ca>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714494653.git.tjeznach@rivosinc.com>

On Tue, Apr 30, 2024 at 01:01:50PM -0700, Tomasz Jeznach wrote:
> This patch series introduces support for RISC-V IOMMU architected
> hardware into the Linux kernel.

It seems in reasonable shape now, at least in terms of implementing
the domain logic.

It would be nice if you'd run it through clang-format and correct some
of the minor misformatting it will point out. We still like to have a
80 col line limit in most cases. There are many overages here that
aren't well justified.

And you could consider the nitpicky style advice to use 'reverse
christmas tree' for the variable declarations like most of the
subsystem is trending toward.

Jason

