Return-Path: <linux-kernel+bounces-24652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892A282BFBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39836286064
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0D6A350;
	Fri, 12 Jan 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MpASqvbb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A56A330
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705062397;
	bh=3xV+wsTUV3xL9L7p898cYKtNKQKI1vGiui53M52wWtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpASqvbbpKGCJkKSrbsnAkSIKCQxV9PSfcTwhLoYnfeJPFCNXoqdEKjq2l3TGWOZS
	 fKwtUoS8CnQ2CgLYSyaEo475fIxEMDvP5r+xGbXEVXnzg40I1NQMIgEHbGA7wKkWF9
	 G3E6vIEf5fSz3k7OdHbzoGpO5SbYyi6LyeUho+JEFhqSXrwi1hV5U14IVOETeaLiTl
	 hdaPVhAxaSqlRzeoD09DgQvGCSp6ZpFhSlN0kixhQ7Dpc5dva/3Lkio7NDu3pCp0cy
	 CaHsaGmimX1RecYjT7kfWiIu8ydzcDO+9Sas0tzmBlq5TWY+tc+4PiSd2BU2mhvL1e
	 9vt3DELps5d5A==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0138E3782017;
	Fri, 12 Jan 2024 12:26:34 +0000 (UTC)
Date: Fri, 12 Jan 2024 09:26:02 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] firmware: google: cbmem: Add to module device table
Message-ID: <0380391c-7927-4b69-aa14-76c1ff5d5207@notapiano>
References: <20240111151226.842603-1-nfraprado@collabora.com>
 <20240111151226.842603-4-nfraprado@collabora.com>
 <ZaCKFCMop9lqWzxx@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaCKFCMop9lqWzxx@google.com>

On Thu, Jan 11, 2024 at 04:38:44PM -0800, Brian Norris wrote:
> On Thu, Jan 11, 2024 at 12:11:48PM -0300, Nícolas F. R. A. Prado wrote:
> > Create an id table and add it to the module device table to allow the
> > cbmem driver to be automatically loaded when a matching device is found.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Might as well also patch framebuffer-coreboot.c and
> memconsole-coreboot.c while you're at it?

Yeah, no reason not to. Will do in v2.

Thanks,
Nícolas

