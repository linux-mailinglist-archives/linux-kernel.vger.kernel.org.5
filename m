Return-Path: <linux-kernel+bounces-149705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ED08A94CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F91282E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2E839EB;
	Thu, 18 Apr 2024 08:17:43 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282412B175;
	Thu, 18 Apr 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428263; cv=none; b=rXXcL6NWu0mq8n+sJterlo+7heeUmWqOOad2+rHL3PvDxKO73GqtUiM4S3P4P/ONJJRz32IiwEwPsU4jup2FNg+/pNNA3hqLdMd3Uxy2zzTu87U0+XUH0meAfdcjzXDd+1Xqh8Jc+YHbNK4Il0a8WwpTiHhEodpZZTtuc5bEQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428263; c=relaxed/simple;
	bh=pf85lD8r/4opaS2PQcuNhKY4RQkk6PZivUWjlc/oRvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQ1U0EKKDWk3LEfVtXOTaDnRgtRO5jcSrB9WxZtkqwy5+LW5uX9v9iVwvweS/tzzYkUeW5r3ixbfIgcEnpNVJqRfUiyMjsP5VJyeO8UKNgHxjSs9X7kpxd0lLJWpxfNcBNiWfMirWRXRpivetmwCmNpnBGz+FXmkZ2xS/Yq9R34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz10t1713428166tsdgl4
X-QQ-Originating-IP: N+tKmcA/ERgx2BiI8yj+P142qjRcxVW8oGXd0CCgU6A=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Apr 2024 16:16:04 +0800 (CST)
X-QQ-SSF: 01400000000000D0B000000A0000000
X-QQ-FEAT: E6xLhkkW4u3Va972c78++tikAhBOiEroa65wcG2ieWFgzg7R8mOb/50dTOO3O
	R119m9bBzMQTN8ptezxmdAvQFd6Xm6ebn8zTi6P6R9GJoFYFsSv9j63YPT9XLztMhuWOD+X
	TGe4pmIO7oweYK+bBhpkxRALZzOrPEzhjEAXlmxATKddrZkz6l6aYF01mrNeElSZOg+Vpfm
	cQhmILatzf0wPQRpGtvzBywRPHtQMn1fjFf3hLjdfZuRSiwjdrHraX2kwvfwY4qiBYB+30p
	SX0jV1mkRJyRyOWAUkpqdSignV570yAouwoMHu0DNb4UVvthzZK54AcMX+4LBrnfsBX6Qrj
	vZiqvdgIvly4P2rl3i+4+EI+ithikso+CT/EspCoyY78YfL7FBt7p2xEwW+8qpetEgXW4Yg
	9jYlwk6SuZc=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3488498768241902848
Message-ID: <AA3FCBB9232F6C97+0e28ccd7-11cc-4047-866c-92069ddbb550@uniontech.com>
Date: Thu, 18 Apr 2024 16:16:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: PS/2 - add support for Lenovo Xiaoxin keyboard
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rrangel@chromium.org, shaoyang@uniontech.com, helugang@uniontech.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 huangbibo <huangbibo@uniontech.com>, yesh25@mail2.sysu.edu.cn,
 bernhard.kaindl@cloud.com
References: <593C1A73FB93BACE+20240326131718.20497-1-wangyuli@uniontech.com>
 <ZgXUZtEwHEF8Rs3i@google.com>
From: WangYuli <wangyuli@uniontech.com>
In-Reply-To: <ZgXUZtEwHEF8Rs3i@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Hi,

On 2024/3/29 04:34, Dmitry Torokhov wrote:
> Could you please tell me more about the keyboard?

Link: 
https://lore.kernel.org/lkml/20230514083336.3811-1-yesh25@mail2.sysu.edu.cn/T/

Link: https://gist.github.com/yescallop/5a97d010f226172fafab0933ce8ea8af

Those links above mentioned the same situation.

Lenovo has a batch of laptops shipped in 2021 with the same problem. And

the combined sales of these products are considerable.

> What ID does it use?
0x83.
> Majority of keyboards are using 0xab83, does your device forget to send
> 0xab by chance?
Unfortunalety, I'm afraid not.
>
> Thanks.
>
Thanks.

-- 

WangYuli


