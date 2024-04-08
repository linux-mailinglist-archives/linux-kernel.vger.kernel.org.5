Return-Path: <linux-kernel+bounces-135833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0CF89CBE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFE1B29294
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0D14532D;
	Mon,  8 Apr 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="B65DQIQo"
Received: from msa.smtpout.orange.fr (msa-218.smtpout.orange.fr [193.252.23.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30905B1E1;
	Mon,  8 Apr 2024 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601772; cv=none; b=SWFi94nxsDUJUkBCV5MSRE2/3+o4GgEbiFqcUcxKCIChmsRvRYKGaQLZMOZpjKrHDmmrwdCp7JqJGoXz/olvxrWOIPaGlCTyOLHNixJIO3zJ730lv/zFUSAh2tNv2iCLKiA/thlP24/Oc5qBGSHZo1uqqGRlkcNA/qrRY2bx3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601772; c=relaxed/simple;
	bh=R9etM9K/rMXR1S/WeDzLSM3twTGK87ckl9PKXWHangM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dm9LTnqDId+ksWOCvVwGYx9+/aDnd5V8753l961SJCa1HOSrlQPAiiTQYVEJAaS+0oeO/1ap12ay1bzkHFBEl/jj041+Sv7vrvPd2R7OETHRGV9rmJwsOSin1J4o5jqfeScKQN0jk3sWRVeToC1MDmoIw+WRxpL4w+ZXAL/09HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=B65DQIQo; arc=none smtp.client-ip=193.252.23.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id ttvHraeeh8kwettvqrxLFy; Mon, 08 Apr 2024 20:41:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712601689;
	bh=uODaAsGcejErYuW1YygJ3cxSc6qnAISZuPiqVvd2Fxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=B65DQIQoh++9ClW+m9OS7AvA+W5nnU8YNdGLOzf90gDeJpzJIH1p8rDandXiTXb82
	 RJX7TfgHHeFsQnilRsDh8IA6uxZrmx7exkET3nebzDGuTuCeJaiPceXVD+nZAM9d4X
	 vgD9LwUJHGMvME/h49yuS+L7faj5zuEKE7lAQoOn6hMIWCsMfzvDeE2WnmVAR/jPeJ
	 669E2dZc0eyMq1ERcIEwPnRFtAh5LT32pHa0Hl1LBq/3SU2ubwhCdDzacg8qgWjeag
	 ASS7M5nckPusI7uTkvL2fHApeeoxZnLwwingI9z8RPJkNsRfCwe3BqzvYaVaCCsO57
	 /6MYHLvVJXsJQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 08 Apr 2024 20:41:29 +0200
X-ME-IP: 86.243.17.157
Message-ID: <4ebbe227-38b1-4a1c-af34-9ba7bdfecad5@wanadoo.fr>
Date: Mon, 8 Apr 2024 20:41:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Improve some
 memory allocation
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <42a87fb9837f1760d1ad4eb7162a7536785dc6f5.1712520052.git.christophe.jaillet@wanadoo.fr>
 <8cb69f245311a348164b0b5ca3dbc59386746035.1712520052.git.christophe.jaillet@wanadoo.fr>
 <d97f2a57-d318-455b-a860-8bd7972c8aaf@moroto.mountain>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <d97f2a57-d318-455b-a860-8bd7972c8aaf@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/04/2024 à 10:09, Dan Carpenter a écrit :
> On Sun, Apr 07, 2024 at 10:01:49PM +0200, Christophe JAILLET wrote:
>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>> index 3003dc350766..b133f731c5ba 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>> @@ -204,7 +204,7 @@ static const struct debugfs_reg32 lvts_regs[] = {
>>   
>>   static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>>   {
>> -	struct debugfs_regset32 *regset;
>> +	struct debugfs_regset32 *regsets;
>>   	struct lvts_ctrl *lvts_ctrl;
>>   	struct dentry *dentry;
>>   	char name[64];
>> @@ -214,8 +214,14 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
>>   	if (IS_ERR(lvts_td->dom_dentry))
>>   		return 0;
>>   
>> +	regsets = devm_kcalloc(dev, lvts_td->num_lvts_ctrl,
>> +			       sizeof(*regsets), GFP_KERNEL);
>> +	if (!regsets)
>> +		return 0;
> 
> I understand that this preserved the behavior from the original code,
> but the original code was wrong.  This should return -ENOMEM.

Hi Dan,
I don't agree.

For me, this memory allocation is of the same type as all debugfs 
functions that we ignore the error code.

If it fails, it is not a reason good enough to have the probe fail. 
(anyway, if we are short on memory at this point other errors will 
likely occur)

> 
>> +
>>   	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
>>   
>> +		struct debugfs_regset32 *regset = &regsets[i];
>>   		lvts_ctrl = &lvts_td->lvts_ctrl[i];
> 
> The blank line should come after the declaration.

The blank line was already there, and in this file, it looks like the 
preferred style (even if not completely consistent)

Let see if there is some comment about 0 or -ENOMEM in case of memory 
allocation error, and if needed, I'll repost without the blank line.

This patch being a really tiny tiny tiny improvement (IMHO), so it may 
also just be ignored.


CJ

> 
> regards,
> dan carpenter
> 
> 
> 


