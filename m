Return-Path: <linux-kernel+bounces-51397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1645848AC8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DCEB226E8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99B4439;
	Sun,  4 Feb 2024 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA7oSEYy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D21C17
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707016436; cv=none; b=cj4Yw5zlOsEIGtqIN8h8zmAYRN/FNMjm2SER5L1JtuySBnwKbB/h9mIHlKs6kg779PtKDkzItCvkE3jWzlosTisOSqoF58kALs8AvqLV6YBKWD359NAu+6jD2QGWtS6bu4YfSLy+nauAZ/e5Aq9EoQUycptbwoC2EP25MFflnOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707016436; c=relaxed/simple;
	bh=Eti2NB0KIjgkNzs/sLAB0bK7ofCKBJxDarMp4JeuXnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWVnXEAMGeg99Lpvp11vsnVC3s6ZA2qtumyoAG2excLKib4c9sFA3AlZN7QV9zcr/SopTaPzD8cyYHs251lKUClR2gfGLkOVfRvcQdZLMePw0UWpwU9+6WnY4sqBMlC58SsFakjJ8XjdSXfGpXRlw2KgburN5YALEKCWsqiCpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA7oSEYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473E6C433F1;
	Sun,  4 Feb 2024 03:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707016435;
	bh=Eti2NB0KIjgkNzs/sLAB0bK7ofCKBJxDarMp4JeuXnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FA7oSEYyK6hKtYUD17C7Dd8J6OB1tOcWEd8AOjozhvtknPt4aMgm2RehFhfvG9qzz
	 ekWfd2HudtytfzvM0u98F3sWNEh8AilUbzdhUOVTskJQxmZ4qSKM7uetFNyZ/jpd8z
	 UPq21rBQV3fObUJ4Q+dxd0DwYU7DPjz3jlEM5Oq6ewk1srf1AHv0nR2ezPV07JtX1t
	 ttjVkXUacO37jjw/XstluGQ12F1xBDO6rOO6Ysnci4mlYv8njf9WWF72J6K7b1K7yX
	 8um3mT+B8BxT7Egte1+PGuz/18QvfdM6xrHqa48zzobUzBDnrJpJsO97px6uhBayWf
	 J2/Ddha8pFIYw==
Message-ID: <30907165-9727-451e-8955-0e26cd219fdb@kernel.org>
Date: Sun, 4 Feb 2024 11:13:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] f2fs: fix zoned block device information
 initialization
Content-Language: en-US
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org,
 yangyongpeng1@oppo.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Cc: hustqwj@hust.edu.cn
References: <20240204031022.1189-1-qwjhust@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240204031022.1189-1-qwjhust@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/4 11:10, Wenjie Qi wrote:
> If the max open zones of zoned devices are less than
> the active logs of F2FS, the device may error due to
> insufficient zone resources when multiple active logs
> are being written at the same time.
> 
> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

