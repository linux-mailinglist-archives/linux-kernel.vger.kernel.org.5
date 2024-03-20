Return-Path: <linux-kernel+bounces-109265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2948816FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC641F23633
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0586A8B6;
	Wed, 20 Mar 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuEoqUvI"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9996A34D;
	Wed, 20 Mar 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957679; cv=none; b=iU+FVvNRbf3x4KKUuAIzJlqPmRJvTkFy+j2fMZwThx3VeBy5nW1EOZKyhuouusjeY+3Ul+zB+Djrnx9a5mUMnJ/RPtEO9PdbUx0+Wm6yG5Ra5ZLoiZaDLdubNnScUMKssLLLuWDvkfMQUBlyoqHP3UFPaZAGu7de0gW0YuAKNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957679; c=relaxed/simple;
	bh=ymr1f2mMkgEncrgAlT2WiV0Xxzk7YqhUaIfael4pJrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDkw5yCizjGxSsnQsxVA+a5gmxl9mlhSOGtQqmzUVxCxIYLoPgJ87zhTJm7H+GT6OvS8bf7hpT4kDkK+/W0HrYOQHUJ9Ccoxhr0l4JbwaytnxNMwNhDVqY2+EAsZBBPk/42xo02QTbNRu4m0+EejuLdUMRwtu7sHAgECLMm+Q2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuEoqUvI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd955753edso578275ad.1;
        Wed, 20 Mar 2024 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957677; x=1711562477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+EPj9HeAGH/gl0oSvfO1IUhtpAie7DUc9DIX8DS5vA=;
        b=kuEoqUvIMVVis+xh3nFAnU0VLwysKTSOERCciUEU9D0Dy1CEsGao/FJ9JGi7JbspsD
         uFuUAsEcXhBOGRDEKMA2x914uUQsnmwCFEarTxzcUZvj80/18wOQnRzgZPthG7aN64rX
         BANv402shKTDngQdWb+W9jOBLY3eRSz9K3GnXOzs0b1kC3hDWrBy2WER/FzGNbmJgT87
         lw59syFGwkF3bE8WjOX6vUFdK9jiiwYA0iYX4ucSqrIgfMfvCu4co1dT6EeHrR3y8bNq
         hZkGva/aQHyExuBp7CHpbgp83G8/yW2xTfpC510uWz43MbrE28Tvp5cc+mM+6IRhpQlB
         NaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957677; x=1711562477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+EPj9HeAGH/gl0oSvfO1IUhtpAie7DUc9DIX8DS5vA=;
        b=Ypg9GpsP8Rpo8n6ggtq2mehpT3ohE8Zi1f8eutaasdwF1EtrQWz/XqYLdVAy1/rDGn
         by6NGx/EZ6r1kTkDclTF9EPXisNeptXO1iu0u9AauKXQtdSX5ScEr/GYBC1nsD24ZO/o
         Rd2bJkYS2TnxFS8Jjk9rYQNJzj5/Dxd0AtWPgAoNp4PI9diE/DvZaiEmKhSe5hUqMkUM
         gsIQYoXc+L+RD29kSj+SDBvBdyKAJZmG3Me5E9KGLWmZ9nVy6lLSsYeV56pt1Ljjyf5p
         nkHg+N3cUcF6S6KpfsrSxr/7A0rROwJ5hl3LStkKJOcoONeRqj1Bf+573/QWQpN+D3nt
         LvFA==
X-Forwarded-Encrypted: i=1; AJvYcCVhMRov3l/c1IygqKQaJYYZ1451GrOxk4lDl5uZPtrlSy0ZG6TRDurv7FuEAYkqGGRVj5i0T0hDipZy8nviQlf7bd+6PCDYJasrh2bnjWjoJCMrRa7EgoPu9kWwmy6H39p7pDiMst4CMMVdGed7u3t342ZtFDsqp6/W0JF1aUFrEZxoui34
X-Gm-Message-State: AOJu0YzBT/yniyY8O0fuQwRwHgkdse/ECQLkXadCqJQs3lfJqlv3KRli
	2OC+QL2Y1q47jQIW6TGyuAcq+yaGe5Q3PnZKuvmBYijQsrBhSRxo
X-Google-Smtp-Source: AGHT+IHM2XTem3JgVQP0IEX99GUflswwZbPvHTBC/KXEXyhYYIawJfvzbVQn5Y611HdY+Vb1VCov5g==
X-Received: by 2002:a17:902:7790:b0:1dd:8daf:99b2 with SMTP id o16-20020a170902779000b001dd8daf99b2mr14382250pll.13.1710957677502;
        Wed, 20 Mar 2024 11:01:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001dd707d5fe6sm13937024plb.158.2024.03.20.11.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:01:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 11:01:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 2/2] hwmon: (acpi_power_meter) Ensure IPMI space
 handler is ready on Dell systems
Message-ID: <9f6ee66e-f76d-46f3-8de2-516bad47311d@roeck-us.net>
References: <20240320084317.366853-1-kai.heng.feng@canonical.com>
 <20240320084317.366853-2-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320084317.366853-2-kai.heng.feng@canonical.com>

On Wed, Mar 20, 2024 at 04:43:17PM +0800, Kai-Heng Feng wrote:
> The following error can be observed at boot:
> [    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c5) [IPMI] (20230628/evregion-130)
> [    3.717928] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)
> 
> [    3.717936] No Local Variables are initialized for Method [_GHL]
> 
> [    3.717938] No Arguments are initialized for method [_GHL]
> 
> [    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
> [    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST
> 
> On Dell systems several methods of acpi_power_meter access variables in
> IPMI region [0], so wait until IPMI space handler is installed by
> acpi_ipmi and also wait until SMI is selected to make the space handler
> fully functional.
> 
> Since the dependency is inside BIOS's ASL code and it's not
> discoverable, so use this fixup is a hack to workaround BIOS issue.
> 
> [0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-messages-displayed-in-dmesg?guid=guid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to hwmon-next.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter

