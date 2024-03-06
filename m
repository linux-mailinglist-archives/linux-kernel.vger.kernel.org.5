Return-Path: <linux-kernel+bounces-93241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CCF872CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A8A1F2423B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A04D518;
	Wed,  6 Mar 2024 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbxhxhWo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC763AC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691820; cv=none; b=A6rZoisHXpQ3Gn9TzCRKuGog2avpawptv/n0lNfG+7nJV9IAo2fcxIi4CCG1wX/PIpVEIBMnAU+M1mkdJHaJChg9Kb4JtrTdOlsKnIDLbJsao5Pz7ut3Y+93kAuc6nra1Fv6JwhmRoZOs7AXC0TbQhifJaTEzUXNx+JZyd5mqXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691820; c=relaxed/simple;
	bh=thzyX0QVW7HCmD/AS2IUCEdrgCJD2FDngBW5T7A+LDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gStzMRr1olhuWXAylTfJsdwTvgd51thTFsnlBuYl39UpBcS1HnvBUD5ZVsDAiP/MJCZ7HPoyJWmSyGmjcpUTZttkFr60hL2WFz2tVU/Ufsvuh9/TE6LCnp+wiimkC/hi+taFyef+FUGuyvYETjTdS9+6CRcCyYZ12CJ+WG1Eb3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbxhxhWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B4FC433F1;
	Wed,  6 Mar 2024 02:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709691819;
	bh=thzyX0QVW7HCmD/AS2IUCEdrgCJD2FDngBW5T7A+LDg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rbxhxhWoauShrqAED6RbMQJ/l4S7v/CLzCOob8mtA5OwApBBzYLh3TF2BdWizUoJg
	 tSkgVlYC4X6YghhSZBVizxopWus6pN0+HrQPtiARiVa8hK9lrzS6SqMib6LgXiCVbx
	 zgHaedhVFaMCAbBNEgYw2eIwo5pLL1tbIl4SUXuNwqUT8Z/Kke6sxlOLNyVkSQcf8J
	 f6dewf2Xo8ZJToUJRT0O/XSbCzJaOMaguo7qe5aORGHxH09hMrgA7SA5G4D3jMMExZ
	 IsZCtATLpHb9zFGGIxko175wyrfOkUWVsGzbHZEGaVGos1fKQzIeCvVVdjISMzqGUQ
	 34zu+U5KfbMJQ==
Message-ID: <85cd3edf-8256-44d6-8dac-eebffb90fb52@kernel.org>
Date: Wed, 6 Mar 2024 10:23:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add a proc entry show disk map
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240305001709.637722-1-jaegeuk@kernel.org>
 <ZeeqmMT8sdPyPKi0@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZeeqmMT8sdPyPKi0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/6 7:28, Jaegeuk Kim wrote:
> This patch adds the disk map of block address ranges configured by multiple
> partitions.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

