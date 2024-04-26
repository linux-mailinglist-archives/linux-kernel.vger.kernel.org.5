Return-Path: <linux-kernel+bounces-159806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFC8B3455
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490E41C228EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C2E13F42B;
	Fri, 26 Apr 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCbGdLzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26A13EFE8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124479; cv=none; b=R/pfpiFx8f/MZUez+Wxjm3ECs7I7ad4WmkYGedDl0jDWSDZSke+XTrvTwlmKg4v9k457d+gE+JsjBPhM5EwzI217UfB9kcosTVartDoGYel/s7JvUydXeSYaO6hojuqOD5ulpHtWru8WPVEkLFfN5/lOCie8AhUOPVcNI9sn2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124479; c=relaxed/simple;
	bh=3XTOEocsRLJi7cHrKqhtGln2IUJoC3krYPasCKtAAgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7Pm/9tWK+LU7YYRla+OwF/9OjwZikmCu4+P1LP+KQa1fgPmVBagBfyH3OQ7IPoPZyIcam8GWCn4V8ib0BZ2tZaAZJxzVNJATAwQ0qo7INyIOMWP1e59TduFP2RZJyyXChPO495N+OzsbV0IpjsoaOO7FLkOO3EG+23Xc9iN5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCbGdLzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB01DC32782;
	Fri, 26 Apr 2024 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714124479;
	bh=3XTOEocsRLJi7cHrKqhtGln2IUJoC3krYPasCKtAAgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QCbGdLzVs24AMjUmS/VRAKvXHl2bzuoWovU3ugxsBpTYnpDVQpxHQTABR7ZdWoJ1a
	 GsFiWYP6L1eXSwJktIJrJb0HFFtKeezKPsYxA4c19EcLqNIP47MI0GKYABHG0reLXA
	 KJBhNe+KsF1oNefCyOyxbCr/vBzhQQ3SbpL/jUg3/hRUNuW+CMhwhp/hhLzwKX67Jz
	 NgKSGvIkfc3rRIxKVupWCNmuO/9ymEy8QySBYCJjDRdNeQdbWrPjn9ATPu575YjDvA
	 SBjJKk1VZM8p7yx9BzQ48thOGEoAw342F0D2hMJ06SE6nhFqPHZxR5N4lMVJEWVUFX
	 2nopneqDDJP7w==
Message-ID: <ff6b6c5d-d325-442e-a8a3-5bb19564e92e@kernel.org>
Date: Fri, 26 Apr 2024 17:41:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant parameter in
 is_next_segment_free()
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240425145528.2925372-1-zhaoyifan@sjtu.edu.cn>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240425145528.2925372-1-zhaoyifan@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/25 22:55, Yifan Zhao wrote:
> is_next_segment_free() takes a redundant `type` parameter. Remove it.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

