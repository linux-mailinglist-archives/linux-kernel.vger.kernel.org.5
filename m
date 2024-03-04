Return-Path: <linux-kernel+bounces-90241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC486FC54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4CEB229FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BCE21109;
	Mon,  4 Mar 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WnEnDnHr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5FA1AAD7;
	Mon,  4 Mar 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541891; cv=none; b=KY7BbHucRQgMxs1Ip24o8CNQBokMlmNo7SlnFjFanp7UA5DeFa5XP+xiAFqL00chiGsIXtq6q6VoRzcxnbegI18mRgPmrIKkMYKlN3UhpdEC+luoSTzmCyaWIhqeddcGIgfHn4cTr0fEMyqtG9A9cwhVjhd3CqQc8Vdlnbn+wZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541891; c=relaxed/simple;
	bh=aQdBSLlALLw63VO8L/jjBkWYw2D61GkjyZobEivi5pg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jZJYmkVLYxpDk8igGUJlZkvCydPR3VREP9zsvN2eCZivVF7V7aINFti3Qj3jFfWiZTZAlzLiDSKigfnAqNbnV1ilr+PGbcfAgozAzs0vIdG7AJkXqtbF0j/m+Z0IYJNYPPXc+DJTMK913lMMI/K9udiOE1JN3jYBaCTjDo7ywhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WnEnDnHr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709541888;
	bh=aQdBSLlALLw63VO8L/jjBkWYw2D61GkjyZobEivi5pg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WnEnDnHr/h/QXOlI26XCkJxch5TkTF9EBxc6HF62ugTISIN5nv5ptzrwQOqtte1IP
	 UzYGGsH7s1getc6wfxdjsP1ksdp2eXXMUI6dWwBRDuGWRVz+AszYdf4eqhlRYl6qVw
	 cOuDy4kO2l+xUd2P0FheHhX54e6BJe4/5A1WjOlw5EdB5hIHqdBvmrB2x++GVReO+l
	 dkepW+mNmAQ9CcmUJ4Tc/D4bxuWqERG8byJ11ETfccLyc0lAIJkVk8caU7q1/Gypn6
	 J31c8g4WTtkPnuBAh1ekFrod/KKkWBwWKn6vOa703G00ZHxzlX6VDXMVbOxFwiAjr/
	 h2ze1Ljv0lSEg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1441F3782076;
	Mon,  4 Mar 2024 08:44:39 +0000 (UTC)
Message-ID: <bceb2aab-7b8e-4b87-a3ac-b5f25505612a@collabora.com>
Date: Mon, 4 Mar 2024 13:44:54 +0500
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
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: correct size for cmdwqe/rspwqe for memset
To: Justin Tee <justin.tee@broadcom.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20240301144434.2809483-1-usama.anjum@collabora.com>
 <5a0172a7-1a02-47d4-86c7-f5fd22e9767c@wanadoo.fr>
 <CAAmqgVM8+wWQOaF43FzQ1O-hBspB_aUODHygHeNM_e2o7Ni9uw@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAAmqgVM8+wWQOaF43FzQ1O-hBspB_aUODHygHeNM_e2o7Ni9uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I'll send v2.

On 3/1/24 11:59 PM, Justin Tee wrote:
> Hi Muhammad,
> 
> Agreed with Christophe's comment.
> 
> memset(cmdwqe, 0, sizeof(*cmdwqe));
> memset(rspwqe, 0, sizeof(*rspwqe));
> 
> Thanks,
> Justin
> 

-- 
BR,
Muhammad Usama Anjum

