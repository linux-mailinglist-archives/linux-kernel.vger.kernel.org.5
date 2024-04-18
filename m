Return-Path: <linux-kernel+bounces-150536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70538AA0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A955B2341C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73A5172BCA;
	Thu, 18 Apr 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2j4RfRk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2B171085;
	Thu, 18 Apr 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459857; cv=none; b=HgGJGHpskKUiu4mFli7GtVf/PqiApnoMg1/B7mDcbxcHrDpsU/GIgxoft5hfDdtrfb0M9+jRyZAUEORtKhdIR2HJh4nQwzdRvtg+wKlNWWxdBRI0DpN+XLNLAB/yY9OGEswCs7g6Ut8Sx8p5TdwKHwB2HfQTJyoTPbAwiXfwUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459857; c=relaxed/simple;
	bh=5TvDNXuYEqdu49jOXNsS0qeHKx5kk+3m83qD8A4Nbi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FF/vJKHHU4lNkWWXIQD1+YDddW/YTUWOFfp3HDv8/5VTOZjP7zsFPen+ZYvHKnddO0WxJ9ZRgFVNNUX5nSRZhYLPKKLwqG6pm6tGHtqzKe8tasVy/Dk30hoyuyHKT5jJln8xbe8bU/49VYKPZ/ztraAnahYyAQRXcMRmlw4jDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2j4RfRk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5194cebd6caso1350426e87.0;
        Thu, 18 Apr 2024 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713459854; x=1714064654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lSLHn8Zl8BP0Wy/iVTor2ayV5AC0mJY5tLNZUubBiyI=;
        b=B2j4RfRkqINyJtQGKO5aYmoN0x1tJ5ZHdJqPSyb+7eaLQ/H2aITDcW4Broc6HULCpb
         PllNt4JdQVHEobUfaUaaISc8DAAyexkQh42GwtwMRVBgIXHbXFu6aGzXIgwmjB6kV7UU
         /tRTunh57eZzdr4jwqDV2mWVYA78F6/6pvIFJgsvHbREAfwztch7ZxAbeVAP8nx0xxwL
         ukdt69EhRlX+8M3DqA8UaIhSLww5coADSfOBiaWjgy6f5ZaGI+nzfW95ZYOp/HelsCO0
         GxK4DNpTrOq2rv9uTNvVozuBPop/D8tRbkhFMv+Q4D6rx/HGDhKw1PQYnsIXEdf/YrzW
         zk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713459854; x=1714064654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSLHn8Zl8BP0Wy/iVTor2ayV5AC0mJY5tLNZUubBiyI=;
        b=p59pudGq9bOz/KJbE8XHuLovpwFKucRcY/PN7RT+ABY9zX5HGPTpUx35FLZS4H8Iwi
         7deCXpgTZHuzaKepFCfcathmAy5kKY1+gAIhoXtDEqS4HYVUP7NqtndPBJG15uVeoaHE
         dkHj1yzqwYhXhJInj+e9QNjX+7x4BbDfz4Wm0LadXlPRZArvDpTSiQk8GkduedfTrLDG
         u2LxTbnVADQFLBhs4zMTmjDW+owI76KMcBpV4bMIYaHXBsA8Ijggxqev6y2+e49sVA4y
         RoXCvjhkvhSUTCSk9v3NB4SjUxHE5WFFSTP2r03OIdTUhmSgJjLTSOK6uSjVbolCD5Rf
         JnKA==
X-Forwarded-Encrypted: i=1; AJvYcCW3QfJfihrQM2n5AfkXGLC3CUajJ6WPP89TYX+jPV0T7sTk7CIYNkC67Eie90FpCAmNAN3O0AnoJAuj7o3+o2yEg7K/5N5/oZu9zMaW
X-Gm-Message-State: AOJu0YxgRgOtAD2Obqw7v0NQ58rV9ODtBQpjeC+VitR+zeN2JcImwevT
	ybf8qPiw6Kqy9anZ/Y6+vtrF7EPk+dRl3a64siFe0lVJ/sbcXzq8
X-Google-Smtp-Source: AGHT+IFNmtDauh7kfAv04ZfeS5gpXspMJADhi0gjFGPb05MFwanTPIXDSevaDoHQ/7Ij1uzpt63NMA==
X-Received: by 2002:a19:5f52:0:b0:517:89cf:bbef with SMTP id a18-20020a195f52000000b0051789cfbbefmr2136938lfj.7.1713459853687;
        Thu, 18 Apr 2024 10:04:13 -0700 (PDT)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id v21-20020a056402175500b0056e7ba0497dsm1100636edx.28.2024.04.18.10.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 10:04:13 -0700 (PDT)
Message-ID: <f2429c78-9189-410d-9c6a-644ae8a4d12c@gmail.com>
Date: Thu, 18 Apr 2024 20:04:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: uclogic: Remove useless loop
Content-Language: en-US
To: Stefan Berzl <stefanberzl@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401004757.22708-1-stefanberzl@gmail.com>
 <nycvar.YFH.7.76.2404121751250.5680@cbobk.fhfr.pm>
 <4ae4be2f-4edd-4d1e-87e9-df5687627d00@gmail.com>
From: Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <4ae4be2f-4edd-4d1e-87e9-df5687627d00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jiri, Stefan,

On 4/18/24 4:31 PM, Stefan Berzl wrote:
> 
> On 12/04/2024 17:52, Jiri Kosina wrote:
>> On Mon, 1 Apr 2024, Stefan Berzl wrote:
>>
>>> The while in question does nothing except provide the possibility
>>> to have an infinite loop in case the subreport id is actually the same
>>> as the pen id.
>>>
>>> Signed-off-by: Stefan Berzl <stefanberzl@gmail.com>
>>
>> Let me CC Nicolai, the author of the code of question (8b013098be2c9).
> 
> I agree that Nicolai's opinion would be invaluable, but even without it,
> the patch is trivially correct. If we have a subreport that matches the
> packet, we change the report_id accordingly. If we then loop back to the
> beginning, either the report_id is different or we are caught in an
> infinite loop. None of these are hardware registers where the access
> itself would matter.

Yes, Stefan is right. I was trying to implement general rewrite logic, and if
we really had that, then the fix would need to be checking that the new ID is
different. As such there's really no need, and Stefan's fix is fine.

Only perhaps amend that comment to something like

    /* Change to the (non-pen) subreport ID, and continue */

Or at least remove ", and restart".

Thank you, Stefan and Jiri!
Nick

