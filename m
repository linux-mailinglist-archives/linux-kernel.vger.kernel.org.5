Return-Path: <linux-kernel+bounces-99236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18BD878567
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72011F20F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1F481C7;
	Mon, 11 Mar 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGtO4CLI"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC25482C8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174218; cv=none; b=cHKB8hM29aqM60b93Ke1j4jkVlbbWrv020UsIqs22Zl+Q+0hp2JJikp4KA8h1s9Cl701q2r2y/OvQmE90ZSjoVInp6uhgDbHa7jdB4WHLD08yhFgzrxTTKusvayL/6vjA7ucg2CJ/sJRUqzFWz0t++pn+RLNr3re/G9Zf+HT7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174218; c=relaxed/simple;
	bh=B4UjQ02vkF5MZVKlOVVO21yeG118Tat5CQgQ78lvxd8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KFnTg8KMS+RxYU27FNsP1uf1C3lhP7OXXR6SxKUwE9Ud4qyIw3Srzgxtj2aIZoHva4vAwhBUQryjl1pIboTHBFveVa55+b70vb8ML9N1l3gGV7c7HT0YYGtHRnwTSPdJHA43gs0/WdSJCZTkrU8N2Zb3g6V35XlBTNTS/W+cri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FGtO4CLI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28a6cef709so472630966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710174214; x=1710779014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCj1yZt/u8hIPMQRhcMCeiFDWVHTVd6VcNXpQPTiU/4=;
        b=FGtO4CLIvZrVJL+lAWQdn44LBuBwYJb3Pw9H1w8bMgmDXc2FZ1cuJEyH0y27F9v+za
         YvLNWhkuKJLvV8ssoLkm0oRLr6AUFST5cyjP/bfkx+vzmCpwIrdP0t3jv2BAWq/Y/6hV
         nswGKzk02TuoLT+UJVWJkwXHyXoLTN3DfpWbySRr2R14t8K8wL9UhZV1WmtBGZu5ARLi
         VZdA93JBbnv/DNDXvAVjGJm6JzUx/pDbIRHwJhVCO1vaQ7r60+PABc3Xe5sO1PNYcCIk
         0kKC77zXONfHLuznBo6PqREtvWB7emTbBIhqD+BKhY4zytXR1qAJD1S83YjVLAfzInEp
         kzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174214; x=1710779014;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCj1yZt/u8hIPMQRhcMCeiFDWVHTVd6VcNXpQPTiU/4=;
        b=i+H9dSMT4IRnSxxk78ZBDdGrxc8CgEBQdkgFKwZM5wN41rvRxyOyke/FZboeTMbG3g
         LHVBGjJ/ufroGsiiCwWmr8yffximrvvWYe6+vYmI6CrDZnef37KgYUynlO+7WwXVxNcC
         6uXX1IreoSJeT1oa+V+SBr2epFIGOJ3vNh1FmaJKkjyDvIIfv/ksXjEFEm+IXSS+v56H
         nb7KUbVRnHk6wQ1plbu5j6gWaXn52a+K7Q2We1orAtVBMW98I5s0siqORpCJbVMXxE9K
         j5NEhLF8cEWet7e04UTWltIi6bYTteIpPZSXlrJmLj5D9QNHgrFwTEdfHIJ4hd7yoYey
         FTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNBnNwmm2Mbxt+yOQLgmM0ymkU3P9gvt+tcC6qlxoPNlvNRynai3n5PFvQalGsMkdqxmVIny0Vi8e8QuoxGt0OA9N9xyuFtpgjbiJg
X-Gm-Message-State: AOJu0YwOiLjbLqafhU6n1fsJ4NxZwySqHyX/noMNsQpgRHvZ5S23IAZ7
	i1k3j7j7VlMILo8TIVlBT3p5scZIZdLdztDx5X9BTvMEmW/eGpLkvSmBot1kVJM=
X-Google-Smtp-Source: AGHT+IEln6XX/dQ+mav4bnye2klH/Xim0EpdtZ6nOOUNG65yuCRJ/JrmmLqOpUR7F6JkrFoS/2blZw==
X-Received: by 2002:a17:906:eece:b0:a45:511:1533 with SMTP id wu14-20020a170906eece00b00a4505111533mr5625253ejb.75.1710174214711;
        Mon, 11 Mar 2024 09:23:34 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id gl8-20020a170906e0c800b00a43e8562566sm2960425ejb.203.2024.03.11.09.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 09:23:34 -0700 (PDT)
Message-ID: <65accffc-e9ec-49c4-867a-6fd51a44f1c7@linaro.org>
Date: Mon, 11 Mar 2024 16:23:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Move camss version related defs in to resources
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240227122415.491-1-quic_grosikop@quicinc.com>
 <5800231f-633d-44f1-a056-58f87f1d5c67@linaro.org>
In-Reply-To: <5800231f-633d-44f1-a056-58f87f1d5c67@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/03/2024 16:22, Bryan O'Donoghue wrote:
> On 27/02/2024 12:24, Gjorgji Rosikopulos wrote:
>> The different resources required for different camss versions are
>> split in to two groups:
> 
> Pardon me for not getting back to you on this earlier.
> 
> Would appreciate if you could post this series rebased on sc8280xp 
> patches which are @ v6 and ready for merge already.
> 
> I will find time this week to test your patches on rb3, rb5 and x13s 
> with the SoftISP patches on libcamera.
> 
> ---
> bod
> 

These patches

https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/sc8280xp-v6.8-rc4-camss?ref_type=heads

---
bod

