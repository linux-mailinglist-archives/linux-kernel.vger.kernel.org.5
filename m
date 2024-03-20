Return-Path: <linux-kernel+bounces-109393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35716881889
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2291F231B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D5E85933;
	Wed, 20 Mar 2024 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBDZT2Gl"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169C29CE8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710966184; cv=none; b=U672NG1fQUJ2oae5IgyBN9D+mdIJ7zO1C/WK8saH4h6PFDHrNRFHQSYrN9Ugho3GI+JHu9Nv4zrqjK2bSk9Zt1NzsXxHEIExGupYuXjgTAMoM0TusiZ3V2bZV+FHl+edXKD4acOjuYloOqC/VQ4ti6to3tUjLkHSYRGqrJCvK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710966184; c=relaxed/simple;
	bh=3D/2C31Jo6cwf5wUXMKjbHS4YEMu6u0BqV/VsQuhICM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpubtaCBgwpVKYcmrw96/dzbIBtDPkNpdPZrS4F4fkLoCCHmSTlVfE3QTAiGtz1ZFVT2klT91CzM+0miARy3uWP9pfqVfoQ2PpNrLO3sv5AR50KHkD/xoBDSEY4gPwL60FqG5FM/B8b6KJhwU0Erh+6xvoieNqYo0WigWAUUIow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBDZT2Gl; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609f359b7b1so2295147b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710966181; x=1711570981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snDVwR9LnpNXTKd4ocxRa1zFXi0aO0gU1t/jX8TRxNw=;
        b=lBDZT2Gl0mR7a9KWBpJmwkZgyujlMsdEQLwGtMtCM6dMqmfmT7XyclB0dIlKCSDdMm
         B1ldWuxybM1oklHi02q+atgcI/cDS6Gh4IrpdTUkRwXV/DNZISYiBfqioJz2DfH5GdwV
         h4Le3bZ35EAS38gCBjfiTn5T9QDDzHrUb0jd0pGJ00ulnmZ/w/guo2Bb9e0ELPAEa7Mp
         xE+MvKxv7s3ngJbjVLz5ElF4F9Kg3a6/Io9GNQeD9Zbl7xI1jiBeTkAfMPWT0HH17tTV
         3eSvQxEZSOKQSdE/ZaVXtmkMJUVNxtFZIrr1I24EhbWIlyUthB7+assHlIYaE4J3eulm
         WTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710966181; x=1711570981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snDVwR9LnpNXTKd4ocxRa1zFXi0aO0gU1t/jX8TRxNw=;
        b=AS1JwL8qYfyVHOUIruPCJJ1Byh93TD6HmwihbaLryPhjBOYKynnkfVnFjCz5R3KIPV
         O8wZGPmjeeFJsdoGZEXhCgPENjH3d832qOkkFKtIIId1rxCvy3dO3CsZJ6Vvg7hnddM5
         igLqi/3/21JCkMXi4Nlglz95YNfiJnchysYR1en8C/PMF5XPVmhguRq74RkaGrbZkbEq
         qIDldqyNvzUnQawp22Ifu0QMuA6tjkahcUuYUn+XrSWGRDHTWz6i1VDwQbdNrAxZRbst
         aMdKTsP7GLR58jjdI0yQ1m6lCFz/Qm8mOAWt4+jmPZL1Vb04mU6PbZLUzqw0OGN1jHkx
         34+g==
X-Forwarded-Encrypted: i=1; AJvYcCW53e1kvz9iyBXcMDkfiADUZ9JMk7hmxTzoaFXALaiaXpJqO4pnxIuMsuNSgGEEVt630HD5ZNqz0BOk88SaasfabEXRgCi2DbscDceu
X-Gm-Message-State: AOJu0YzvpgNMVqu1s043Q/EtXgCKRWQrQxpST32l4qGeWGmnpUPaG9R3
	vEkSc+ayUcxZDq2O2o4l7fQ7WKQ9DV7mWNmHn/cHZhI2GFYw59VZmOoUNFYH
X-Google-Smtp-Source: AGHT+IH2EIq0ng1IcNCHiiHHYA3Q6d1I978t2sNtbYUFsXF5/Dqt9wzlFTRCzK4IAfQazNE+oORfpw==
X-Received: by 2002:a81:6284:0:b0:610:b930:816a with SMTP id w126-20020a816284000000b00610b930816amr7824743ywb.49.1710966181544;
        Wed, 20 Mar 2024 13:23:01 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:a6a6:49c0:6a02:df54])
        by smtp.gmail.com with ESMTPSA id v73-20020a81484c000000b00610b6cc1ff7sm1884925ywa.109.2024.03.20.13.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 13:23:00 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:22:59 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, russ.anderson@hpe.com,
	dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH 1/2] cpumask: Add for_each_cpu_from()
Message-ID: <ZftFo5qESOuv6+XL@yury-ThinkPad>
References: <20240319185148.985729-1-kyle.meyer@hpe.com>
 <20240319185148.985729-2-kyle.meyer@hpe.com>
 <ZfsrdcUOsNp7ATjK@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfsrdcUOsNp7ATjK@yury-ThinkPad>

On Wed, Mar 20, 2024 at 11:31:18AM -0700, Yury Norov wrote:
> On Tue, Mar 19, 2024 at 01:51:47PM -0500, Kyle Meyer wrote:
> > Add for_each_cpu_from() as a generic cpumask macro.
> > 
> > for_each_cpu_from() is the same as for_each_cpu(), except it starts at
> > @cpu instead of zero.
> > 
> > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> 
> Acked-by: Kyle Meyer <kyle.meyer@hpe.com>

Sorry, please read: 

Acked-by: Yury Norov <yury.norov@gmail.com>

