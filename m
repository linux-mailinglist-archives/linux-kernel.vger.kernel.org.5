Return-Path: <linux-kernel+bounces-153271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18D8ACBC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D45B24893
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA25146597;
	Mon, 22 Apr 2024 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RV5atbym"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001514600B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784416; cv=none; b=uBNwfphUpHVm5DU7fOf7piqlTuJ6BVtsSucVMp4SECM8nCucR9RsvZ0opsTXYFv0taKikSyoj8ACPXD12KTkYc+/1fbARt+obCpD1Z1lSDbWSAIKvrMJMixC16VGpw2WxekQgRe8g4HvDpnC1UDt/osvYaoEEmBjX1vPuXDIlNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784416; c=relaxed/simple;
	bh=gf1LSfks/DZu1KDGH9YWvHY5EzI1fuwlgU++9PgdGiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jq79ry1lwD41oGcPgOIKMcCDj+jsxUxX/eqk+Dr6BjXjaxjODp0iIW+jW/rympPoV4CnB7Nr/wc67a7oCXJ4U3Ma38PcpzBI53+4Go0j4vnSNxMJMv8XygzrpDN9mpDtFZnX0Y3CAkCYUy33ALyiWFkPJChyKZlIjtz4RY01Bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RV5atbym; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346b96f1483so2202548f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713784413; x=1714389213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzoM1x8KJ7efkIkmfaAcVKjjXVwNSzB4dxxASXuEBKw=;
        b=RV5atbymdvPdnVTe3Sg/5pmOTEzsOZ3I2J3JKSWht745V2NfXKCueu1WioOlaQp6jc
         N7HJcfUEBB2RM6bXmbDg5AHrBRiQXfZUshioXI8JfiHQqc6veP7EcTHzA8E6ZeASeLxA
         9i+ye3w6sK7w3OMcLLDWy+ugSCkHprv3Kq9SJuDH3d14yetUvSIhy/IoqyKJFUeC6HA2
         BKT34BhvLuwyMYxL8o9zxfol9NrlrHPlDEl/SUGv4EgqQ3SUxmZIRTqzazqcq2GVLXPr
         IAxuv2L1UXE3VUwv9E9fSqqprIfccQrmQfqVhwp60++XNco8L8Nhb8tEiF8cZFKa8Mv/
         3+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713784413; x=1714389213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzoM1x8KJ7efkIkmfaAcVKjjXVwNSzB4dxxASXuEBKw=;
        b=hui3Z2VTeI+yxlK6zyIEtILHfbQgJxVddV/SiX6DeuSzY79Kfe4D7g1zBMLMFPJ5L6
         wmQycZmyGD6dnbmb5KAWv+DD+Mg+g8HIPwIN4OGloUWOD6yLf/31yo7MuQ1W5itfXGI2
         b2i4wpgbTVMBC6YtMH2XmWHTR0t4vcyshyXLCg7/1xghjF1gCj3lkid62D96vGBVuqrz
         9I/YBBqf9Lr3yF6zGKbXu/Gh7hPqPpg6BA349PK2KYjki7TcWK9jaZjp6kfwnYWkhDrJ
         Qg5fH0K72/f/WUREnWxIlI1+eWohQY8tjQv9ARB34wQmu3sgCTA+oS9NPRmUBKc0Q8IK
         9HQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUOvQHxbXqXSlOag6kZrh1w/2bLEGEyvd2F9tsvY9zzdnmf4h1CAqLO8eAYIFiG3FKEUhDqWCLgYw6hEe0tKpGwm4rcwKhVqD8J257
X-Gm-Message-State: AOJu0YwfiTXSPrOl5Im8ynb2RHCRj7fksAkELDP7L2Y9nJaBvIfDzoMu
	ch8tvlVe6oKARIwThvRlAY/9772acK2ZBzo+0fFk4E2KJRf868ssQ4zbn9wlbbI=
X-Google-Smtp-Source: AGHT+IEOp5Z7JHtY8l4UoPuY/jR6T3IYDex/kZU1e2WpLFswrPJSHkIzZhdC+1o76Ax2K18wmbbOfQ==
X-Received: by 2002:a5d:4083:0:b0:349:bb17:6e60 with SMTP id o3-20020a5d4083000000b00349bb176e60mr9370805wrp.2.1713784412724;
        Mon, 22 Apr 2024 04:13:32 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b4-20020a5d6344000000b00347363b77dasm11684546wrw.33.2024.04.22.04.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:13:32 -0700 (PDT)
Message-ID: <3f42fdb9-044f-460b-8701-7a95f9d5e638@linaro.org>
Date: Mon, 22 Apr 2024 13:13:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal/debugfs: Make tze_seq_show() skip invalid
 trips and trips with no stats
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba
 <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>
References: <2727917.mvXUDI8C0e@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2727917.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/04/2024 17:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, tze_seq_show() output includes all of the trips in the zone
> except for critical ones, including invalid trips and trips with no stats
> which is confusing.
> 
> Make it skip the trips for which there is not mitigation information.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


