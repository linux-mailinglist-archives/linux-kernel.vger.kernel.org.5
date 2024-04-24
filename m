Return-Path: <linux-kernel+bounces-157413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5E18B1156
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAFC28943E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F079D16D4DC;
	Wed, 24 Apr 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="bdXhc4H+"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46315B55C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980478; cv=none; b=ZY/4Zef6JAWxY6qaAym2Ppr8nVDghBbsQw5hL//NHm1CRUAo5zxlB01JdiOvkN5J98GHs3Q2cxU7rHJNWYwe67z6VtZEW+0Xg5bBJa6LVi39Iv5+Gos5EhbbfMTAWbJLza0DuwULO5XNBHpuWi2CX8rU+8xkzJHS1qN3di1ul0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980478; c=relaxed/simple;
	bh=p0y7wYEfB9strGsjBErr4K6JYzYUMIncHnOELKfuNXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PMjsPd9oNbt/N3eOq5gHKEUo3ia4jmx8i9GphTpqRkez/jpyha31z62jI3qYihKwsmzGzfdF5KIRHyUC0q5W4uXlfn0VyoRS07o3O3vjnbxKXTxV21MDpFKc+JWUJrYJ9kJqT2sva+QuJnbtmea2RsFvm+WKiPI5lpNFVPq0wyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=bdXhc4H+; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3624:0:640:caf8:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 2CD4C617BD;
	Wed, 24 Apr 2024 20:41:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5fPc8OQh9W20-EDXenxJg;
	Wed, 24 Apr 2024 20:41:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713980465; bh=p0y7wYEfB9strGsjBErr4K6JYzYUMIncHnOELKfuNXo=;
	h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
	b=bdXhc4H+i/g0G6GFdvP2ODb9hn9QRNs/XGQeuN/4oovCxVchrI9U2ttrcHfhD0fVw
	 GzBhXzNrRDYArskLtpHiOD4vppdiMdBp7QjzQe0iU5e5jbZOIpMrYljt9z4yCDbJes
	 A1fusObS9j2mu+2A5yL3RK9LmgL/6uGVUEtkx00c=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <faa340cc-e62b-4332-9808-f90d15171e3e@yandex.ru>
Date: Wed, 24 Apr 2024 20:41:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: reorganize path_openat()
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240422084505.3465238-1-stsp2@yandex.ru>
 <858f6fb6afcd450d85d1ff900f82d396@AcuMS.aculab.com>
 <6c9e5914-8dee-4929-b574-f59f50305f4a@yandex.ru>
 <e12149437c4b4e609ccefef66701a082@AcuMS.aculab.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <e12149437c4b4e609ccefef66701a082@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

24.04.2024 18:07, David Laight пишет:
> From: stsp
>> Sent: 24 April 2024 11:59
> ...
>> Posted v4 with this code verbatim.
> Nope - you've just posted a different version of the 'v1' patch.
> Should be [PATCH v4 1/2]
I simply use `git format-patch`
and `git send-email`.
Are all those customizations needs
to be done by hands?

