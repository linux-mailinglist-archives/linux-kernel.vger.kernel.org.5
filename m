Return-Path: <linux-kernel+bounces-149868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1394B8A971E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00092841FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206A15B969;
	Thu, 18 Apr 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fEC7K/qW"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86B15AD8E;
	Thu, 18 Apr 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435542; cv=none; b=VfWNsvStoygdrX+YS9pzaGtRrnMXPAXIZQ7ydJexikNW07hYG2JzIIJyWBOg8g2l0Lf7kvRw9nuiRObIOhXpZQbB7dsCuaXrO7Qs4AVmBGX+TPxPDTrdY+zzzvJ6jnSlahP6CH0/cPl6alGgBREiPRSnXg+T26upEa5Qe85N234=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435542; c=relaxed/simple;
	bh=z/hUMpplzHibHsKJBgmNXuW8EzCM6xcWFg+5AA3gd78=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUr4g0zQ5BcPdCkbTf6nLIInu/ip/hTQWyrQxBd2Omw5JHKUmX8G3lMcNSm+7StJ7fBov6fELHcY2rf9vtX24z3+d9xGRNpmV/GX+1SVhio/Lza9lB6DGt0i7O0Ghm6zBRjAAVbAk5GftBRzUjxhpwf18D2XXQUAz3DvMh2uWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fEC7K/qW; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I5vTHo004756;
	Thu, 18 Apr 2024 05:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=u5oDewUAuxPt3nz
	bwd1BP8yEuLREuEnZJS3DESJidV0=; b=fEC7K/qWfUze9cDg1UO0qN+v5xn0AEG
	XBUIThLiHcBGR0YaAGg8XXEcECPuDZRXtWSXF2+iJDne86KfYIv8KbG+Qeas5fiu
	xb4GFTVqHe0t5c4PDiKlcWb1BHpkIZtICAP+Ntq+8TH8+aVP333rwtRy90sTvlr6
	9SDtTZmQ9fJuAUw/EhLjtwU0sybw5ZHEpQDdeXxGdn4ptOIpi+0c82ZwXHp09Fhn
	udbRHpEk59uVjkryzYyiCRqHwB2iBxqwsXvlIlw9bDV+2htVhrSAiBDmxxBSn9Bw
	vP3rYHN8P01RSTQGOH0gnqKTee3jq/wf/G468KR6b9/whbr/dEU7RTg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhvmct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:18:42 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 11:18:41 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 18 Apr 2024 11:18:41 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id F00FD820245;
	Thu, 18 Apr 2024 10:18:40 +0000 (UTC)
Date: Thu, 18 Apr 2024 10:18:39 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
CC: Mark Brown <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cs42l43: Correct name of ACPI property
Message-ID: <ZiDzf4pdS5V4V4F6@ediswmail9.ad.cirrus.com>
References: <20240418094206.1323489-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240418094206.1323489-1-mstrozek@opensource.cirrus.com>
X-Proofpoint-ORIG-GUID: 6qytccbZeZ-buVVOdIzPt7C1jCys4bq4
X-Proofpoint-GUID: 6qytccbZeZ-buVVOdIzPt7C1jCys4bq4
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 18, 2024 at 10:42:06AM +0100, Maciej Strozek wrote:
> Fixes: 1f05252a3a95 ("Add bridged amplifiers to cs42l43")
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Apologies about this one bit of a curve ball from our Windows
team.


Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

