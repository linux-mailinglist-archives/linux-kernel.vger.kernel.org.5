Return-Path: <linux-kernel+bounces-90242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C63286FC59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFB91C21A22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EC2225CF;
	Mon,  4 Mar 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UALh7dVU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A51A58B;
	Mon,  4 Mar 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541905; cv=none; b=Q2oXlMRQDUl1o09dCJ0c8J/MI6xS/TwEnG6Zc1uFkxtIS0+3PKJg5yl0qaX3+CAAdnZDqdp5qR7vFZLoj4YaD96mSBrVyW76+0GT7IXuSDyOTfqXst0XCp+CX9G9bhMfxsZ8+lYfpZWGehJU7padKWxsywrg0kpKJEIT/6SxfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541905; c=relaxed/simple;
	bh=+GAQ/9U68cQzOw2tMQbxtkFHqRIm+NAF8L7v5JI73Gc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OSWObJKQisbgujSV0LqXS6OAs1ud+L2oglQtEjjfTI6ZBkDtkmzwJZNHDN5SGsAUbjhC6teIOtsBJngjyUoV7QwmF4VOLPl+wX64ucv5qjSnQujVjf7c5Yc4E95a4gU5RGroBLEEw4e3PDU47FmJ+I4imfVNq5fPQfuNSCMkGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UALh7dVU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709541902;
	bh=+GAQ/9U68cQzOw2tMQbxtkFHqRIm+NAF8L7v5JI73Gc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UALh7dVUtCYFrhCQ5TAZ5MK8Q/UevNMPEqpLGVu+OI/GqYHa1YTfY33IsWVPbeedy
	 SRMHz17SrzspB8mcA13JYZdoLeE8h2vDYMNXoapafhvFMPDR3H58l2rqrD9lMF78Es
	 Y1+1UId6VhzAGEMYg7jfdMyj/ik7+xI9zriN9MefPzq4mhaOIEXpdb2ENcday/FaNL
	 esmQ1Z26WjB/Eler2WoxiE5v44ZiYwxlcdVI7AJBKIEtKKtBaUeTpgpOeYchS9IDt/
	 rLV+HiZ+6evQrgk4pK0klUDjy+UIdstJEH6lWfrIuJU/5m3fUuJ4hjq7CwssE/njWe
	 GgPNw6iwjd3gg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 05B9A3781FE9;
	Mon,  4 Mar 2024 08:44:49 +0000 (UTC)
Message-ID: <f9be0f59-acaa-4a37-ba66-4096112a15bb@collabora.com>
Date: Mon, 4 Mar 2024 13:45:21 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 Justin Tee <justin.tee@broadcom.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: correct size for wqe for memset
Content-Language: en-US
To: Justin Tee <justintee8345@gmail.com>
References: <20240301144458.2810597-1-usama.anjum@collabora.com>
 <CABPRKS-0v0bdsAp6aK80AQn80WRSGpF3SP9HtwH2wMPXoByJQw@mail.gmail.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABPRKS-0v0bdsAp6aK80AQn80WRSGpF3SP9HtwH2wMPXoByJQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I'll send v2.

On 3/2/24 12:02 AM, Justin Tee wrote:
> Hi Muhammad,
> 
>> -               memset(wqe, 0, sizeof(union lpfc_wqe));
>> +               memset(wqe, 0, sizeof(union lpfc_wqe128));
> 
> How about instead memset(wqe, 0, sizeof(*wqe));
> 
> Thanks,
> Justin
> 

-- 
BR,
Muhammad Usama Anjum

