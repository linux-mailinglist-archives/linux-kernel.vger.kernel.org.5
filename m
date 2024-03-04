Return-Path: <linux-kernel+bounces-90434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C07386FF1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0846DB22D46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC037157;
	Mon,  4 Mar 2024 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JbVnd2YV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E2249F4;
	Mon,  4 Mar 2024 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548345; cv=none; b=Az4uGbhOfr7vs2iS8Tb64EQxnNLEujK1CGYwepuiJczGDApaDbgjY8j8toDt0MjttC0KzPPtMZTU/Cyf5vYHUOtlElzPj/fccMKAU/gHUnLSD7s1cXbFH8BVkzcUNaR59XWlvP44RsSJg1WI91HjJWSMpjVWnz05nUmPsXJYZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548345; c=relaxed/simple;
	bh=YazaxYSTieA5lQl0E2xF/DFcpgv65JFrmncXrg70YAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SP/wfQ45M4y4DbXX03TZHz0lwhjsp0/ZY5t6IUK6jipPkBd4DlnMiJjKp8w19rPQrU/+2oM8xFleq4M+IQb7l2Z7L+4ejcsphKGkTkehGN47YGXvvc/AzH4j6M+DpO9pf/M6Uqd27riXX6veV5/qt7oBk1gNCD99zWhxG/VAS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JbVnd2YV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709548342;
	bh=YazaxYSTieA5lQl0E2xF/DFcpgv65JFrmncXrg70YAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JbVnd2YVXN+09b8YSM/hkmyBdT/HVu8L+jWuMtEsPq7uaUp7AWwUc8OAVMjkDgEQz
	 3ODfYOfwRgn3vU3MuD8ddQIS447f69xvNL+BkMSFUE+fPIfyVNfvPqaFeuChmTS9Ny
	 bjpD72J54iuvOd8a8lv18uoVHIqvHCEj4b/o44y3RflRYiQwMwNNmneCjWF0djjUsY
	 mmJOnSPZReJeiXnBZVQEx3iCV7458BRDqbHB9etRVMNlcvJT7eYON+pBqlYbr1jtUl
	 hjhYa+d9Vb6cHatsnNEilmpOmgVJHm6snmDVOozDLfIRfLp45V7/qes78Tyx/4tVj7
	 r6nzgSCaBHGUA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 050FC3781FE3;
	Mon,  4 Mar 2024 10:32:21 +0000 (UTC)
Message-ID: <367fd03e-b645-49bc-95f2-0fe06a043370@collabora.com>
Date: Mon, 4 Mar 2024 11:32:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: lpfc: correct size for wqe for memset
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.com>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304090649.833953-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240304090649.833953-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/03/24 10:06, Muhammad Usama Anjum ha scritto:
> The wqe is of type lpfc_wqe128. It should be memset with the same type.
> 
> Fixes: 6c621a2229b0 ("scsi: lpfc: Separate NVMET RQ buffer posting from IO resources SGL/iocbq/context")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



