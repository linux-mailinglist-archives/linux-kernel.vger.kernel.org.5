Return-Path: <linux-kernel+bounces-90693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90235870373
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DEC1C20EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270A3F8F1;
	Mon,  4 Mar 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bCWJcTC+"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A93BB3A;
	Mon,  4 Mar 2024 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560645; cv=none; b=ht/41+m9KZoBbHnXzVDspeOMOh+PrwM9GE3eafu0utGoQgzN65lNtQupQCrkU8jjdQk1fIJe9yLe/db90micw8kgbHq5A4UNZmt1fcKo417eGkSSwjqhKfktTUcgaUluhjYzoG84W2bv/PtNkNen/C9npst1SmJRYcHFqOAcJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560645; c=relaxed/simple;
	bh=t4HFn7eIQvSgZ5wRMktcT8dDyGdFxF5R14Sx2I7vfPA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HInLCEsyXSXX4Dyr4DkWnRPjzNIxJ5vj5HrnJeSg6H6ff2jVac6yfYYA5x41whZsd8pEuqS2VCwzyxlntD5SDOUO+zpkerkBtVrJ5DXcD3B/qFfQQKi0nmozk1AbuzuIXXDTJ0UEzFbCvwvTXPcKYtWiN6XPy5y0tYtvpIWK4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bCWJcTC+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/9y+afRjJ9gLFaGiuSXGFB7Y07dNe/W9ADUFEmL+ed8=; b=bCWJcTC+qhzGEcw0AlIPOLXZMv
	kB99hkpaGpzUUsbTOkEnCLqlnPQxfI8zpFRheZLYeATnoe6WspE6EORRspXR0jKLkhwR7qR8asYEu
	/NYxVOPmYlHXxaP952ZNhI5wV+7As+uLHXPPF45xksU4HyQE0+GAmr/Lzj7/KRfcKJMAn8pilpnaz
	a5m8Y37DS84apb0+4Z2WwTJ5sFQUcfpYfpS0hSSwgF4ZrRb5Q9hhYCGaT6IskNyM6cEwy9cweuuv2
	xuEtvH+KqwwfDn7x0ry5aoQFBY14fRKLmlBi/bYSf31Z6+0bN3EXH1TeIkWMytBVJAwLyNZchluvL
	b932B+SQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rh8od-0005eq-A2; Mon, 04 Mar 2024 14:57:15 +0100
Received: from [178.197.248.27] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rh8oc-0003y7-Jh; Mon, 04 Mar 2024 14:57:14 +0100
Subject: Re: [PATCH net-next v2] net/nlmon: Cancel setting the fields of
 statistics to zero.
To: Jason Xing <kerneljasonxing@gmail.com>, yuanli fu <fuyuanli0722@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 fuyuanli@didiglobal.com
References: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000>
 <CAL+tcoDAmA4q+FxJchgA1LQ2fxhD8oRdjDOmVPeJ1-eSnkSt5Q@mail.gmail.com>
 <CABbqxmcJ+bybv0e-Rby9Q1jVR59Na_XE9MBee+f_zu0HUTmvqA@mail.gmail.com>
 <CAL+tcoDkTPLFksXWReGXNjujOQbgtiTKN0_-MW1f7Yhj8+CzgA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <df93a088-e8f8-3708-8009-b0560c0d07f7@iogearbox.net>
Date: Mon, 4 Mar 2024 14:57:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL+tcoDkTPLFksXWReGXNjujOQbgtiTKN0_-MW1f7Yhj8+CzgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27204/Mon Mar  4 10:25:09 2024)

On 3/4/24 2:25 PM, Jason Xing wrote:
> On Mon, Mar 4, 2024 at 7:14 PM yuanli fu <fuyuanli0722@gmail.com> wrote:
>> Jason Xing <kerneljasonxing@gmail.com> 于2024年3月4日周一 15:05写道：
>>> On Sun, Mar 3, 2024 at 7:43 PM fuyuanli <fuyuanli@didiglobal.com> wrote:
>>>>
>>>> Since fields of rtnl_link_stats64 have been set to zero in the previous
>>>> dev_get_stats function, there is no need to set them again in the
>>>> ndo_get_stats64 function.
>>>>
>>>> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
>>>> Link: https://lore.kernel.org/netdev/20240302105224.GA7223@didi-ThinkCentre-M920t-N000/
>>>
>>> Suggested-by: Jason Xing <kerneljasonxing@gmail.com>
>>> See https://lore.kernel.org/all/CAL+tcoA=FVBJi2eJgAELhWG_f+N-kwmrHc+XRfKXhYk2RJcPKg@mail.gmail.com/
>> OK, I will submit a v3 patch which updating commit message, thanks.
> 
> I don't think you need to send a new version of the patch unless
> someone points out other changes that should be made.

I think this patch is not needed anymore, see net-next :

4f41ce81a919 ("net: nlmon: Remove init and uninit functions")
26b5df99bf60 ("net: nlmon: Simplify nlmon_get_stats64")

Thanks,
Daniel

