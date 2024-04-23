Return-Path: <linux-kernel+bounces-155406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CD8AE9F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E271F22741
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751213B78A;
	Tue, 23 Apr 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Euk68xFI"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39719BBA;
	Tue, 23 Apr 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884348; cv=none; b=NVkPNsT2ce6bf+CvEoa5FeqaZ3zGwGZNXNZTu5d7NT7A3KN4+famOcKmxvgP8H9+z4BsrQuNP0uf6j/0IawAd5aob4PEuOS7r3OTganBkJZN+Ry4Na9s2/JAq+gdrroPe4Z21EdaycTb47rBcQyS1BzOJmZNZczHYmtqGcFzAtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884348; c=relaxed/simple;
	bh=Yce+qDBOZuO+SfiuLBCU/iYtbYmkEpQFI26Eyr98dJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEhu4ZlV+wJIj/KYT/ungxKFyzCiWU9m+YvO3hA93ze900fx38ihmkd55J0OqcI6x8Gvr5E34e7GEm+Yrrw99ckkv5w6Iytzl69XaNZUdKAvjgHfVmjHXSWpLrabSCE38RjffOWXSdTeXPLaQi/0m5CJoqJ1b7Ip0phWThRI5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Euk68xFI; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5A3B8600A7;
	Tue, 23 Apr 2024 14:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713884341;
	bh=Yce+qDBOZuO+SfiuLBCU/iYtbYmkEpQFI26Eyr98dJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Euk68xFI4y8XXUx+z6g6V0jHbc97oDHz4Ykrc1dFaHrz2+APG9+rMjRwumONlJ3v9
	 kvq/rBT59BH4Wm3plThuU/m7SE44w4Y9ma3r8epFTJyj0/+B+afoY8qY2uW6QEv9PF
	 mX57F2UEhS9ddG0RjEF49Ic3bp/6geC7mEFHJ10dQWbehrG0Cf698nmnjT7fW5AHiu
	 AM3cgn/9DHwGf4Ucj0oGjFjklNhgduZ6l8ANv8IizC+Fzr0nEo60yuI0a9LitqVbUd
	 fmZIZ8000qT91Fk8KQhOUL48nRrLcvjQDeWgTnqjhCu1zIjrlLEZf4CWEQiRfkIw/Y
	 u/nnH8EJYneLg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id DD630205A1A;
	Tue, 23 Apr 2024 14:58:54 +0000 (UTC)
Message-ID: <883a41cc-58b2-475b-a247-b45f69c7f24b@fiberby.net>
Date: Tue, 23 Apr 2024 14:58:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: lan966x: cleanup
 lan966x_tc_flower_handler_control_usage()
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20240423102720.228728-1-ast@fiberby.net>
 <20240423140048.GU42092@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240423140048.GU42092@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Simon,

On 4/23/24 2:00 PM, Simon Horman wrote:
> On Tue, Apr 23, 2024 at 10:27:17AM +0000, Asbjørn Sloth Tønnesen wrote:
>> Define extack locally, to reduce line lengths and future users.
>>
>> Rename goto, as the error message is specific to the fragment flags.
>>
>> Only compile-tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> 
> Hi Asbjørn,
> 
> This patch-set did not apply to net-next at the time it was posted
> (although it does now), so it will need to be reposted.

Weird, patchwork incorrectly matched up the two series. I had
rebased shortly before posting (net-next was at 077633afe07f4).

The 4 emails and their Subject, Message-ID and In-Reply-To:

Subject: [PATCH net-next 1/2] net: sparx5: flower: cleanup sparx5_tc_flower_handler_control_usage()
Message-ID: <20240423102728.228765-1-ast@fiberby.net>  (A)

Subject: [PATCH net-next 2/2] net: sparx5: flower: check for unsupported control flags
Message-ID: <20240423102728.228765-2-ast@fiberby.net>  (B)
In-Reply-To: <20240423102728.228765-1-ast@fiberby.net> (A)

Subject: [PATCH net-next 1/2] net: lan966x: cleanup lan966x_tc_flower_handler_control_usage()
Message-ID: <20240423102720.228728-1-ast@fiberby.net>  (C)

Subject: [PATCH net-next 2/2] net: lan966x: flower: check for unsupported control flags
Message-ID: <20240423102720.228728-2-ast@fiberby.net>  (D)
In-Reply-To: <20240423102720.228728-1-ast@fiberby.net> (C)

Patchwork have two series A+D and C+B, instead of A+B and C+D.

> Also, please consider providing a cover-letter for patch-sets with
> more than one (but not just one) patch.

Sure, will do. Didn't know if it was appreciated for so small series,
anyway v2 will have more patches, after splitting this patch up.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

