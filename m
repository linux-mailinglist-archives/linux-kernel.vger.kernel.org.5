Return-Path: <linux-kernel+bounces-72447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDD685B399
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E56B20AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009CD5A4E5;
	Tue, 20 Feb 2024 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB7e3AwC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A39B5A0ED
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412635; cv=none; b=C4hOIJWR0aXXsPvHpNxrglHlAfrcsgHaulrbfcJfdI1YCEmdGw/ZJ+wOmHCSMTg3QOSQnpPH8suAnt8O+E9tkw/kGW2fCrruMg5A4AYl6i8LpU3XjW/30Ts2m6owekD81Kw7kybAZQy9LlByBahwhlZAWorJ/LKXc/gJzAZX5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412635; c=relaxed/simple;
	bh=mK3/+1CIk9h4sPEMSZq6eWNT6lI3qCL1uD9W0cWW7Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=djn51LostOGlndxuBcYxGPaEu5cdeWMS5TaWX5jm8Ht82+E3SJ0MceamZtTunarZq3tC7iV8q+zqQVRe2BDatX7z58MSTAftF0CEzv4l4zH8GH9a9s1WAMcwNXGw12HpAmDDkc//3viBkq7MUplBo/n6LyIYeB93X8+GH89JbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB7e3AwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B983CC433F1;
	Tue, 20 Feb 2024 07:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708412634;
	bh=mK3/+1CIk9h4sPEMSZq6eWNT6lI3qCL1uD9W0cWW7Oc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UB7e3AwCRHXypLAaksxeFrbJrHFTEnUJvXDHvr3qNapyvRA6Fb6LnuZAX3OA1ZgHt
	 9v9sx2HasFkqJz+/UIcmKNN+ghY1yn2t+GuBxyUm/jzmY89LHowieqkUdtNhlVbotH
	 zXzsZJvZJNbGOvFeN6VUkJIaV9YkJ+PoHozJCDA59/HG7e8JeQuKly17SA/Xq/4/Xb
	 vrCwLgqx9NeyBbiLfvr1ZFenisI1QmAWAqX/zs4hUEOlOijS/2gYMOdbevy8NtQpnG
	 7w4uwj+MfTBX3+lmq5Oa3T9ZWt8Sjn8RBX9eazegAunpeSE1UmCIMYCOqt4sHxZAf7
	 3hAWIxIUHkwyA==
Message-ID: <4965a052-5918-4b5a-ac00-b5e33c0d9c7b@kernel.org>
Date: Tue, 20 Feb 2024 15:03:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: deprecate io_bits
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240207005105.3744811-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240207005105.3744811-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/7 8:51, Jaegeuk Kim wrote:
> Let's deprecate an unused io_bits feature to save CPU cycles and memory.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

