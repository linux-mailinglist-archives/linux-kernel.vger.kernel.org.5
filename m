Return-Path: <linux-kernel+bounces-45734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB518434C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7271C2439A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC22168C2;
	Wed, 31 Jan 2024 04:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ic3qFH+e"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE821642A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706674386; cv=none; b=E48OypOzSztJgEsQjWjbEHVe084zRHw4Ubu7Q0aZNloyIG6Yu7FOAxC+UKXw8sAQa4o9wA00kTDzyZF1yEhwzdT5OZWmM3jUWtHrngbElvWqYGjX9Qq79ruFZ69Joj1T7wOYoaNXFzx610Cf86wixt9N/IZS9BMA/9gJ45KivJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706674386; c=relaxed/simple;
	bh=1DlelYrLN89WSNoFjjCbPz3xqUy1erf6nQWCSqiJPlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlGofJd9X0cuMLlded3Eu5Tap1m9GZ2F4FOmWscMq0namsdGvD90Np8TTLf6axidgWDHZllXjfDuLutGO45b9TH3WPCJR0y57dp+OW5Iq7BD4//1EdVDEYUAFpbaP4L2EhPkReV38oDiAZc+BCaln6yqJeQIjza0l3ABgISOdNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ic3qFH+e; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-204235d0913so2741881fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706674383; x=1707279183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eIysVhoe65X0wgevyt64SdMAqRbA+C/+sG2DwD+IGM=;
        b=Ic3qFH+eBdtsC0/v9dKbU20oFsXIFoSfENTBOlPWbsVazhqq1E58jPGZ3ikfD+rfmj
         zVgd2c1XwKwnui5inOHCwp4YMt+pxT7RE/LfMi1TKf3egEbIzGSaMZl/0+Ld1cArnrN1
         FQ99qwTpDdet6XRrOFvzPmXw8NfG16b81a0VClt5O3kzkDSGkzTkzt2ZGrG1mrv6xD6a
         coHT8Eidus50HUW2ppug9nSnLHGA4hKPBQScb+R4hxmJ5wofZy8pVoQTxatl/QkcneMR
         ArqdW+hMrF+hVhAQYWCWAoG3y5Ax7Xeh3LjnmAHkvNl1OBrDoayBmDHN8Ujho8n2cZbC
         24rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706674383; x=1707279183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eIysVhoe65X0wgevyt64SdMAqRbA+C/+sG2DwD+IGM=;
        b=p7vL8vssCfiE0eBylJZjwmxQe1CJEglaWAkB8d+1yFOXsYuSn8mb7ZBqzQoe9mUNUF
         Bcwhj4+l+whFw8LWofMUPYUuHCfguURxF+bqmQYmgz1KQIYD4eY+RDwZqcF4Y7kipQR6
         O90Mf+zfDiM01Tv3gYZTEQGAi2UYDz5pMbVENt3vDqtz6NUF+GBuw2dEfsPtZEZhD7Rg
         Hr430s/4QtAh2RzSZuqApk2QY9+D6y7J5eeYM8yniHhbCNDjHXElw2tJP6GeGR0h6epY
         7n07Z3OkPskhPwl+irrDsWG1aoAd0iBd3SJNDG35N8YAzF2wnNR/1FxRml/IA8/oMUG3
         DLJA==
X-Gm-Message-State: AOJu0Yxnxn6EeIjlIqMHfMFNax4DM7ojr0aSFH84LZK8UfMnCRlClydE
	fK6fmjRG9Wo5Sxig5fBHlSMWnJEwilUgZpuPFse2hHfKoQMJakm8fesyzRN79Fo=
X-Google-Smtp-Source: AGHT+IFEZzXD9DMDfH5HSEnFHPIAtZPWEMhK8ueV+vJgCW0NttJjSRUtfwc4WWn9ISBOO4PxcAYxyw==
X-Received: by 2002:a05:6871:6108:b0:214:911a:e871 with SMTP id ra8-20020a056871610800b00214911ae871mr683945oab.5.1706674383427;
        Tue, 30 Jan 2024 20:13:03 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id c185-20020a6335c2000000b005d8b6e5ce00sm7758714pga.27.2024.01.30.20.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 20:13:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jan 2024 18:13:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <ZbnIzqmClhAvPxKC@slm.duckdns.org>
References: <20240125170628.2017784-1-tj@kernel.org>
 <20240125170628.2017784-10-tj@kernel.org>
 <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
 <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
 <CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
 <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
 <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
 <20240131041205.GA3517117@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131041205.GA3517117@dev-arch.thelio-3990X>

On Tue, Jan 30, 2024 at 09:12:05PM -0700, Nathan Chancellor wrote:
> Hi Tejun,
> 
> On Tue, Jan 30, 2024 at 06:02:52PM -1000, Tejun Heo wrote:
> > Hello,
> > 
> > Thanks for the report. Can you please test whether the following patch fixes
> > the problem?
> 
> I just tested this change on top of 5797b1c18919 but it does not appear
> to resolve the issue for any of the three configurations that I tested.

Bummer. Can you map the faulting address to the source line?

Thanks.

-- 
tejun

