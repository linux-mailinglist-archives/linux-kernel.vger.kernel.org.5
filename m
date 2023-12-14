Return-Path: <linux-kernel+bounces-265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1BA813E74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B91E1C21EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D56C6FF;
	Thu, 14 Dec 2023 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lV6Vokk9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA732DB81;
	Thu, 14 Dec 2023 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=BaJCsCfijs7GuDBKTrIWbe4mzrObKT7MV71UU5ZCbZI=; b=lV6Vokk9qA9LV1JxhmI1jaKIiu
	Ez3QbwTc6QyJJwweVy0QrKzsK56LfExa8KhtpvXwDP4wdCq9fGFIk+eJ0A2zx3Pj2n5HwBp6umEZy
	naBywZPbRyfhYQo7RwzQidTGDtq9CFX/ZNw/iQgOwWUwJvJHYBSyA3f9CrF+JWSi2bGBuzyA/MWo2
	QhF+mMZVp8V7W2pCFQNDqQ3tACEL3mJ3+ESC/gDjx3VM3O/h74/Q8b4gcQ/5v63eyc/91K37psgkj
	FZitV4YP+l0c3rK7eZNCHJCBrMz3XI8hzo+BSUA04/91AZ8wScvnjiSkwdlclKGYDzlR9Z8Gg1Pyr
	itWCHZHg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDva2-001aYl-1m;
	Thu, 14 Dec 2023 23:57:26 +0000
Message-ID: <8bddc464-a2f3-47e5-85e6-d4067db67ccd@infradead.org>
Date: Thu, 14 Dec 2023 15:57:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pm.c:undefined reference to `i8042_command'
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 kernel test robot <lkp@intel.com>, Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Nicolas Schier <nicolas@fjasle.eu>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <202312041909.lwhcU35R-lkp@intel.com>
 <5f1caaf8-1edf-444a-b017-c4d08e52213b@infradead.org>
 <f712a65b-4984-46e8-bd43-1309b5cd41f0@app.fastmail.com>
 <c10194f2-097f-4455-9932-19961edbf990@infradead.org>
 <40b5e438-22f4-43e5-9663-db44dd402a35@app.fastmail.com>
 <374978b4-9bed-4d5c-90e2-344e46dedaf8@app.fastmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <374978b4-9bed-4d5c-90e2-344e46dedaf8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/14/23 11:54, Arnd Bergmann wrote:
> On Thu, Dec 7, 2023, at 01:21, Jiaxun Yang wrote:
>> 在2023年12月6日十二月 下午5:26，Randy Dunlap写道：
>>> On 12/5/23 22:52, Arnd Bergmann wrote:
>>>> On Wed, Dec 6, 2023, at 06:24, Randy Dunlap wrote:
> 
>>>> I think it's bad style to force-select an optional subsystem.
>>>> How about making the entire file optional? It seems that there
>>>> are already __weak functions in its place.
>>>
>>> Yes, I agree in general.
>>>
>>> Hopefully the maintainer will opine your suggestion.
>>> Jiaxun?
>>
>> LGTM, PM is not an essential function here.
>> Arnd, do you mind making it a patch?
>>
> 
> I just tried it out and my version doesn't actually work since
> we still end up building the file with SERIO_I82042=m.
> 
> We could still make it work by checking for serio being
> built-in here, but in the end I think that's worse than
> Randy's patch, so let's just go with his original version.
> 
>       Arnd

I think that we should look for yet another alternative then.
I don't believe that adding "select INPUT" is a good idea.
It would be the only "select INPUT" in the entire kernel tree.


thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

