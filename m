Return-Path: <linux-kernel+bounces-167190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E178BA56E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49331C22053
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703F1C697;
	Fri,  3 May 2024 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="fIt+hGjn"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925F17984
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714704860; cv=none; b=P33oKMstb1gIkintHrDWkaTureGi2thYcHMXLPX2O2hY2UCYC4oiklv8KC35GaqPYVYHs/2JJyvTPmhaRAJrNW5LjGlzFPeNxaP+aLRuHrJ8xrFwrtE5b93aNfXlAjAOJlh3oetN05DGExlIAzIzIdhLc6l7NxB5O4JYiGAECFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714704860; c=relaxed/simple;
	bh=yDKp3H2GfAFPNZ//JlJZqmJUnus8qIYGocHIGeNqTb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yt1pVQdZ++mj3y72j8uhUFo/z4fQ3DGQ6O3iLUIWji8QAsE73FoUr+yJe+N4ivE3gCl5gjZ2oMJhYekGOW3jVyiBADdGt1/Y0gEZNguPzZE4Q0zaGaW44Xrz6VluE3u3YYpNm1B7Vdu2D9hqLov8znrScIkNA9JSDA65EI40Ogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=fIt+hGjn; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id 2Q7ms7FXISqsh2j3ssRto1; Fri, 03 May 2024 02:54:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 2j3rssSBrF4Xp2j3rsuYfa; Fri, 03 May 2024 02:54:11 +0000
X-Authority-Analysis: v=2.4 cv=UpZlNfwB c=1 sm=1 tr=0 ts=663451d3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=S1Wz6wX7FG998aEX3qAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gvy8fIgr+vT9YwCzeMJn5rmWISCqNLxgzY8ECKu1DD4=; b=fIt+hGjnb8qMSf7zfQnPHWPwV9
	+PHLiVGoa0dYqbjWgIlYH4TSlU92rnz0bzF6gSGUtN4ULDgo6vgtamfSeJ2gESDF5f5Eq6lyaL3hg
	R8vf5NOTO8GJ24FPyrn4vQQbxBxz+K0PqM05XgH+4L9wEOpKEVDOtaRiF2daY0Z2Km6xRiIgZJ6xm
	T3wHpEheKpb3akP9911RL8xU6aDoQfKkaFRpg9K6SDDW0VsWfU+cVA68JZG49gzOHxA9TNdoTRICa
	7eXAZqUHxLPMhFdJ235r+RpbofESf3n+CEDHz3LDZR0MNIz7NbZnVf0NIyLnNfeNLxKCSQCt7DI/k
	AT1L6krg==;
Received: from [201.172.173.147] (port=32918 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1s2j3p-003YI7-1m;
	Thu, 02 May 2024 21:54:09 -0500
Message-ID: <b552b828-ffa3-48aa-bb13-addee866dfa4@embeddedor.com>
Date: Thu, 2 May 2024 20:53:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] Bluetooth: hci_conn: Use __counted_by() and avoid
 -Wfamnae warning
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZjO9qCx10KUJbK6w@neat> <202405021045.CEE4DCA@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202405021045.CEE4DCA@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1s2j3p-003YI7-1m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:32918
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC1vFr3trTtw7cHZHdwLPgEv0S7eFV7WLFTxVAxKSsGrqc1WLwagaHHCTN7mkBIHOOgZr0tvPz2zpfsgmZhnrQkKVlNz8EBYrSkvO/zG9ajCj2MDYBvC
 lX3wVcH63cUVSvMLv+YBXZpEhc4+WG1rkEnSU06elacKIVUnbs0iH2CkgomM3uE+iOj69DM2SK7l3ZTAxeEXdZhBWN7009CzUFVlgZrEqCfha5hBsHEeGcce


>> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
>> a flexible structure where the size of the flexible-array member
>> is known at compile-time, and refactor the rest of the code,
>> accordingly.
>>
>> With these changes, fix the following warning:
>> net/bluetooth/hci_conn.c:669:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Link: https://github.com/KSPP/linux/issues/202
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Nice! This looks really clean; I'll point people at this patch when they
> want to see these kinds of conversions. It has it all! :)

I really enjoyed writing it!

It was great to find out I could remove that global struct. :)

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks!
--
Gustavo

