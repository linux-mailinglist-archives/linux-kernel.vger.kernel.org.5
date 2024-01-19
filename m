Return-Path: <linux-kernel+bounces-31294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4DB832BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE99A1C2481E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3418E54F86;
	Fri, 19 Jan 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZchzV3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0C54BCC;
	Fri, 19 Jan 2024 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676209; cv=none; b=MPb/Qd9K1vHdfKY8ssNtHzkZ61PTQC6AsLiRsMWv+Ch0gckcUdiL4LgXfa3s4KG6HzkL/DQ3uSdRWLtpZY30zIEW3TEAXwdJyrlZ6HCidBOXsLmR+Mn+bSiuDqDyfkAWy3obVWeeksqoV4yLfo6fw6wNqjeDuukVgT62jkXilm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676209; c=relaxed/simple;
	bh=UE5O8R1jO06bM6GSbAt01cR2dBDr021Of8rOmzjLEsg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ECJOtl/s+i2RNeenP0xHX2ttE5M8Yycyv7vej3oyftSbL1OhgYvdTWRXWeShzc2gw06lkvrHEsPYaDMm8fMQhX5mLqqQ0VBbI8SJsZP2azJViF2FLQpLVGpu9/iW5O2HNr4h4fAQKatfTqfMX1EU8JvgGxeo9GoP9w9VygtRsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZchzV3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECE9C433C7;
	Fri, 19 Jan 2024 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705676208;
	bh=UE5O8R1jO06bM6GSbAt01cR2dBDr021Of8rOmzjLEsg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=UZchzV3Slr+eunRu1UgOANDTlgDiMbVXze2Mpd+vgt8Fcxt6R3NpmXgDMkfEOl4bY
	 FZ1GRu2s0chC0JmvRuPo/NGzvy5F8XZZpm+T/DcYRHHenFv0eNq7RDjbOts0e3DnFJ
	 vhhV8lVdqso52aUxVgg2YoZdM78/cNTfCrKwK9Q+F8v9z1+I+1PfrTqa9/dlQzzQ8D
	 yZvVLPBzJzgBRkBcFnxJTJLBTXk49QJLIOJvNKvKuOqYCsw9sJ4RnheWGmU+m2Zu0u
	 8w2BVd6dT9OfQY5+u7LYb4hvi3/YNb9QKSOX+0qPN4FqgbyyYs8OUCbuEwdMSy76Gf
	 8wBEXC8fLeXUw==
From: Kalle Valo <kvalo@kernel.org>
To: "Lin Ma" <linma@zju.edu.cn>
Cc: djohannes@sipsolutions.net,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] nl80211/cfg80211: add nla_policy for S1G band
References: <20240119093724.7852-1-linma@zju.edu.cn>
	<6acb79fc.79d3.18d211a170c.Coremail.linma@zju.edu.cn>
Date: Fri, 19 Jan 2024 16:56:45 +0200
In-Reply-To: <6acb79fc.79d3.18d211a170c.Coremail.linma@zju.edu.cn> (Lin Ma's
	message of "Fri, 19 Jan 2024 17:42:54 +0800 (GMT+08:00)")
Message-ID: <87v87pe5hu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lin Ma" <linma@zju.edu.cn> writes:

> Hello there,
>
>> Our detector has identified another case of an incomplete policy.
>> ...
>
> I mark the net-next tag for this one and a previous sent one in this
> morning ([PATCH net-next v1] neighbour: complement nl_ntbl_parm_policy).
>
> Please let me know if such nla_policy complementing should go net instead.

nl80211 patches go to wireless or wireless-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

