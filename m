Return-Path: <linux-kernel+bounces-145659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710D8A5917
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08381F2182B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3284083CB1;
	Mon, 15 Apr 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="o+UJcLmz"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9182D93;
	Mon, 15 Apr 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201991; cv=none; b=YXoTpZTEcf85XOW/79ZMGQSfp9DXgg3CXzQURBLOEYyHBuwi+vzi9oba7c7GlGOwTdWg2bMAVxszaDHatkmKRA2wQvV2jPwUz3jFKlxnFMwwfJcy0J7DjmNcZ97KBOJOKL16AGAa0E8lCmtYpiPVbgsehIMUIBEPcfYfmzOmcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201991; c=relaxed/simple;
	bh=gdtpSZeek4WxRDYyyqJtK/AcbBU0P9+7sC1xniRLlV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h63L0EMumDmI9o5Ik1+Jcw7ECysEFOkqV/w4+vGh542iAu6jEd7FAvEjuYXuOEGLfVQIc0KqnapAbyfxypn9g4otqYT3DK+EOYIYYHDK5RGC4xYT3FpsgFTueIAisycA/xnz8Jk0dkB98wnKa5DJmSOMSpRUldTBURe8joxMiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=o+UJcLmz; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VJDc5485CzlgTHp;
	Mon, 15 Apr 2024 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1713201988; x=1715793989; bh=yEI0tBPFIPNtNRdhFblfE9OP
	YM2lTomLnreEVEQMdKA=; b=o+UJcLmzCjA0xhxvZ7J+CEQqPpOzjv7ohgodgvep
	gCW5SC/+QL4Ggcg84XY2YPtsc962fU+MA70o/o2oEnd4ja7bQRzB30w04K6uX0oR
	OnHDkcm5B7l2OdHmunNvnNJjEigxdTNrJqDtOYNs1KLfJWeDFMEIiK5kU0/7KFAw
	oINbLdpgbLR7dNlsxnxd/AobV61tw1qwU5j2mNU5xSGTjYq+2tw7uv0omxo9YJSv
	0UwdONM4qfK4keZfJPM9YPwziewUAlRyxARH5nvEGHqR4AB7Cj07iMJb3WYnONFq
	f91rdUXOTCV9E7Ooq4uTqPrWsYRQP4PDneAiA13F4WLF/Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id msOUn97a8RmL; Mon, 15 Apr 2024 17:26:28 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VJDc31rlczlgTsK;
	Mon, 15 Apr 2024 17:26:27 +0000 (UTC)
Message-ID: <48043100-a817-4ca2-a141-60e3ab9cbfef@acm.org>
Date: Mon, 15 Apr 2024 10:26:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: scsi: fix shift-out-of-bounds in
 sg_build_indirect
To: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
 martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, xrivendell7@gmail.com,
 syzkaller-bugs@googlegroups.com
References: <CAEkJfYNguDt47=KnEUX7tLwx_46ggBx3Oh3-3dAcZxqndL_OWQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAEkJfYNguDt47=KnEUX7tLwx_46ggBx3Oh3-3dAcZxqndL_OWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/24 20:14, Sam Sun wrote:
> -    num = scatter_elem_sz;
> +    num = max(scatter_elem_sz, PAGE_SIZE);

Shouldn't the following statements be modified instead of the above
statement? I think these are the only statements that can cause
scatter_elem_sz to become smaller than PAGE_SIZE:

	scatter_elem_sz = ret_sz;
	scatter_elem_sz_prev = ret_sz;

Thanks,

Bart.

