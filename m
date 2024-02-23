Return-Path: <linux-kernel+bounces-77673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF58608B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFE81F22D67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5969ABE5A;
	Fri, 23 Feb 2024 02:11:32 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4849B8F47;
	Fri, 23 Feb 2024 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708654291; cv=none; b=gOtuWRQDwNui0zkhrpJE0bauhhq+aWxYsgf3CHQ4zrTzdX/hPtIfS76LHFGpeL/mojd65hyFB9hkUIdeLqUNontEjuccWP+O7RLVLqv8SsEFLIUDXUZxyDB+Ce0qbAIEKja4FWXI4L28+V3x4zLYMcqmXrAcAHLDh8Yo6jzAXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708654291; c=relaxed/simple;
	bh=M5LmF6kFoflz9uJySQG+mTHmhwdacuusQ0dma6Sds6M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type; b=caxT0JKPy+ErV2oNpK9lar/tAl2TVjWPsdp2yoazjp6Wge+e6R3kxBGUGQcXW+1ipjVTTY3HDIgRGy3SZv8g6rOFdmWgxGBn3tgU/ZqDO4u9jH1b96R8V5Rrr/fj4iQ7i7alPupXyuVGhdpiUUMDaJZu6uvKo7SLa7ukqLSUey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 3EBC86046F80C;
	Fri, 23 Feb 2024 10:11:04 +0800 (CST)
Message-ID: <dc2d05ab-2a56-bf9d-8500-858466ab68e6@nfschina.com>
Date: Fri, 23 Feb 2024 10:11:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
Subject: Re: [PATCH] orangefs: Fix possible NULL deference in orangefs_mount
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: hubcap@omnibond.com, martin@omnibond.com, xiyuyang19@fudan.edu.cn,
 cymi20@fudan.edu.cn, tanxin.ctf@gmail.com, devel@lists.orangefs.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Language: en-US
In-Reply-To: <3e4e23ca-5e00-43b3-91a7-690e690279e1@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/22 18:45, Dan Carpenter wrote:

> This was already fixed in commit:
> 9bf93dcfc453 ("Julia Lawall reported this null pointer dereference, this
> should fix it.")
>
> Amusing subject...  :P

Oh, really sorry for this. I forgot to check the linux-next git.

I'm not sure if commit 9bf93dcfc453 will lead to sb refcount leak which 
was previously fixed
by ac2c63757f4f ("orangefs: Fix sb refcount leak when allocate sb info 
failed.").

In any case, the null pointer problem has been solved.

Thanks for your reminder:)

Su Hui


