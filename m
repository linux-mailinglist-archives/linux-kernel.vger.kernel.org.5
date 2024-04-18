Return-Path: <linux-kernel+bounces-149874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D88A38A9733
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E47B21BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BD615B985;
	Thu, 18 Apr 2024 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MHeb3n/2"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019B15B96A;
	Thu, 18 Apr 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435716; cv=none; b=OURW9tXn1RXTbJZi+XGexNb41tent1OOvv/do7WbOwSGYSjQT53HUf9uarIVU7Zk9SPnrHkipUYPuItzN/6s8i3P/gMaEYFxH7APBzpP7dgJJdEJRIBujBUL1DjtQl5/2ryz5+slsVZyQsBMuPtsmCUmzvvBkSkmJaw3P35Kwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435716; c=relaxed/simple;
	bh=P4sbd+3pJKDK4SD5ImAjJjDozCp4Sq4s5N8AojfbsIQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLadICK2GXx7e+oGwHsMQx+ae+19lq5+PqDCXwi+7pGn8GryXjXicPlwescCdPT3Y+onGvUD25RXuU+r1FqiVEy5SdwvsDowYkQLOk3e304KrwzUQ9WcEGm6z31EdWrWCGxaNu6wKoY4qt32XfWnBtjb/LiC2zyc5YEX11QRt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MHeb3n/2; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I4kSJ5025732;
	Thu, 18 Apr 2024 05:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=P4sbd+3pJKDK4SD
	5ImAjJjDozCp4Sq4s5N8AojfbsIQ=; b=MHeb3n/25i/TKPJsrqnriXd2rC2TgDS
	8/tjSdgVH1V4xB3TUPYyHgSwtaZ6+8EqT4ZZcy0UKdOflh+JuShpK5gfLet1xKj8
	rX/kZl+jhXtIlS8N/o6P8JzRFuHImDy9ZVb4j0q+K03YnDofm7+oIHtwXeG4rw9n
	KAFRQDESnUXto70t9c60T3rnbuzFGgeMwrEqeYnoRomjcnBo/D+m4kcPdvDMXJOP
	UXoWoDyzEkPA1/K+oXbcvEX9WxIF8w2Jx4RJkw3nJrRF6unBiNWM8JiEHdJyhATE
	KEdyGe+TzBT0+R5GioQHY4gmG2sf047Lcj8rDG8aoqcWdoXWTMgUmzQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xfqeycmcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:21:46 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 11:21:44 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 18 Apr 2024 11:21:44 +0100
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id A0F57820245;
	Thu, 18 Apr 2024 10:21:44 +0000 (UTC)
Date: Thu, 18 Apr 2024 10:21:43 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
CC: Mark Brown <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: cs42l43: Correct name of ACPI property
Message-ID: <ZiD0N24MpYX7uj1U@ediswmail9.ad.cirrus.com>
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
X-Proofpoint-GUID: iOergdAmvvoNkdmHzP23eCDEat5Yd9v_
X-Proofpoint-ORIG-GUID: iOergdAmvvoNkdmHzP23eCDEat5Yd9v_
X-Proofpoint-Spam-Reason: safe

On Thu, Apr 18, 2024 at 10:42:06AM +0100, Maciej Strozek wrote:
> Fixes: 1f05252a3a95 ("Add bridged amplifiers to cs42l43")

Sorry actually are you sure this commit ID is right, I don't
think it matches the one in Mark's tree?

Thanks,
Charles

