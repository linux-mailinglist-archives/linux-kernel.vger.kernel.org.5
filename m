Return-Path: <linux-kernel+bounces-56752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 347C984CE9D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E831F28C99
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8828063F;
	Wed,  7 Feb 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7f5xI/d"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749C80025;
	Wed,  7 Feb 2024 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322108; cv=none; b=P7L4zqousvBrDwVdoeQzn2w78x/Up2Rm4r+a1L69XF2sf89wRLdgnbwCpaJDhI9rFDW1dmpmrIM37AM4dE9LwaNGWhfr6e6Gdg0C1qwZ2mSJjS3NnJN76pdjLWYS9+gm9M9e8BtROi6HpvTvX4O7CKaiL6p/fH9UwS1vDCSbffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322108; c=relaxed/simple;
	bh=ybXxYVD+1xVfCdbJXIvnEMTLZOlDPSTHiwvTM13eAQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZTFCrLG66XgF6TXNdU/Qud1x5VXbHOcyTpUKJZT1I2EMaZVgPDktX6FbW2yojD8/pglUzPfBZ7s4uiNcVd8Gg3AFpcWl+IEF+YdPUXDeko0ymPxR7FgbSF5ioe1azUDby6Xvh0oqr2skJjqZfcCMlUne5Q13PngN43uYxoQPo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7f5xI/d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33929364bdaso555722f8f.2;
        Wed, 07 Feb 2024 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707322105; x=1707926905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+9E7Zi0e1bKNYiVydcX0jTLNst7Y59nJaxzHbAYQts=;
        b=M7f5xI/dWdVCUJbn2F2e8RCBaps/B2w6GEhY5a6Y6Not/XSOiE+TqaLCmguVO1EmyS
         Y4bR3jwfwjT2cD2MiF8fuoL1WdC/FqUySvixA3wfK7egCFkPG582JEDbAq6Z1bstlO35
         uomKUzztyz29ygZ9MLdI+Emu3j9gqciKU/cAAq25ejH2CZxbHCjy+E2IqfB34PCRhaPo
         1hNhaS5+7RjwFPgP+tTTY1z5X1ql1qligRxW1Zxuk3wAHJDJ1hqT1AqF7n5wN27f4Cwc
         b9TTHqVGWXVPijEM5ef92D5GIx+6WCXWGNSHVFydGIuGU9JsX34RN6rXpbDxaGonmJiR
         PhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322105; x=1707926905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+9E7Zi0e1bKNYiVydcX0jTLNst7Y59nJaxzHbAYQts=;
        b=f6OHzkQU0gKF9wAnyNCVwq5E8AKGXeZEBzenOfDljOxUd7gAPBJ0v9PrtUcU+zcrti
         XtmuOsOvm6ZDP4l5ut6mQCFewEDKW61PVQ+WQPBkCYso16hVB5CHwtAw4agwvKJfaolu
         /ZwKLCshBUcRn/TlAphfJ98+K3lrVqZNOsumEufhUkFSeIFsuT1TVLfsWGhSrhrRd7C+
         TN38LxIVyAN3L7r14NVESJXqyxk65cun/m3MUUCTNx2J6Ec/Cj79A1UB+ly3BTeBTfuy
         CZb6Sn2cpHjWu8NMiwMzgfFgObtUJQjkPZCv4ofP2sO7jsXQ4zqZBIcSdstrUL/621dm
         Jc5Q==
X-Gm-Message-State: AOJu0YyQI5BBrqELT+TLdJlmCMRcMdGR6BCBfVPPd2oqXnbgDFc5NMRV
	extqaIuxgWelRfbYykzDgpwyLpH+cRw7F2R76if69UesQU9BA7nL
X-Google-Smtp-Source: AGHT+IFtD/CHaJZpuyKN6v7r29cEqFNjuSi8yt7dTA3vHUsaAfYvz6zkcitLjyXRot0LIS4iGLVTJg==
X-Received: by 2002:adf:a490:0:b0:33b:50e5:8a78 with SMTP id g16-20020adfa490000000b0033b50e58a78mr1147730wrb.22.1707322104631;
        Wed, 07 Feb 2024 08:08:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgGkdMQoT4CUK0BnnpQl8RR76S/fzcALiVhHADUlV9a8FAFY1tpHqkry5uu53W7KhHY9pB9x65tXZL+yM1IorCZFU3BJhO5j9c3GztCQ3oPwNNjnadYurUa3kZzHjn/godOhciKoA95g6arwrOIbwuPfA=
Received: from [172.27.248.114] ([212.187.182.163])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000024600b0033b40a3f92asm1809576wrz.25.2024.02.07.08.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:08:23 -0800 (PST)
Message-ID: <9e20a488-870f-4ff4-bfea-195a3f62b92e@gmail.com>
Date: Wed, 7 Feb 2024 16:08:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MediaTek for-next: Replace matthias.bgg tree with mediatek
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <00a81be6-7dd7-4959-b1dc-eb94022bf0e5@kernel.org>
 <20240207090505.515d8977@canb.auug.org.au>
Content-Language: en-US
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20240207090505.515d8977@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stephen,

On 2/6/24 22:05, Stephen Rothwell wrote:
> Hi Angelo,
> 
> On Tue, 6 Feb 2024 11:08:25 +0100 AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org> wrote:
>>
>> A while ago we migrated the MediaTek SoC trees from Matthias' GIT repo to the new
>> MediaTek collaborative one. I just noticed that the linux-next branch didn't get
>> replaced (we didn't tell you anything about it, so that's our bad!).
>>
>> Can you please replace the tracked for-next branch?
>>
>> ...The old one, to remove, is:
>> git://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git#for-next
>>
>> ...the new one, to add, is:
>> git://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git#for-next
> 
> Done.
> 
> I have only Matthias listed as a contact for that tree, should I add anyone
> else?
> 

Please add Angelo to the contact list.

Thanks a lot,
Matthias

