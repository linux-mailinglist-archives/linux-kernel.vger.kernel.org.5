Return-Path: <linux-kernel+bounces-152795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D518AC455
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C471F215A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B0F481D5;
	Mon, 22 Apr 2024 06:40:04 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5F1391;
	Mon, 22 Apr 2024 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768003; cv=none; b=M6SwIOTBA1Ii3l2mSo2viwyA7CF+9yawJwUoDz3kZFmq4dYXtPODXM+fef9l3rWJzgpMWw185UXMXBM3OE2MgLQ6X+3cOw6DCRNLfXHAatWBHQmmrnoD+WfuTgGxTfCAuYqbF2xkpjKW6NVTriuJpky74zeegBW0eoBi7V4u69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768003; c=relaxed/simple;
	bh=GyFEmL6NH/ZWyt1loGOak01X2cUqqWZ4MMmyVbjqWmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gW9fAXWdYLtLMsV2QbutQ2EkXTM3Oo5dvGD57Ms+LijTySZRXlhjzLlPvj/ac3ZGgY2UIjjblXtRuhxZlp7Dybju8W32eDRRukVSg4gjlyq4kOLSQRMsdTYtHFfCBd9RwW4LmAS5evBSvErPcT+1ccoMVAHagwLf8e4pR6GHXNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a559b919303so172355266b.1;
        Sun, 21 Apr 2024 23:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713768000; x=1714372800;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJMq++kg1PghWv8jRnf8Je6kb0hKjRSJ/QT0tPfaRy8=;
        b=sq6C1Zewda+/qxrxuvcXbO6VB9KWKsx0SRV+S0v9317G5EFzmrUpU7BBEo6ELbXzYE
         nqhgZY6SHBSHuyzHWmviW9MCmneyHfGDKslO9/8GPmAxQLm7PxvaXssyJKD8ZpWSWRlr
         FhPoYSBobX1aQXIfcFvDwT5u+M5WLqUc+5AJY9KAvf7/kUJYnC2It/uGfigDV0reWjAE
         20499ftt1EGiIEsxdiZWdXWiuKxM/fKoB4CBo2OsqzYfasMaVuSTQruBIVOELumhYEUa
         u55mD6YgPatQnDOkdrrY2UmpwjIQXNPBAsMk0nq1gihxdiSSyYi2Ajur+2zlSicmk2Vk
         R+bg==
X-Forwarded-Encrypted: i=1; AJvYcCWfnyFdHPfXivp9xkgj1sYxsnT5OKHJOp+9XkWChnqM9EpGhxMzPd8GwDe/+iQoKFwxZk3IvmA+gDUuygSpQRpB+tU9rm/SSsW9f5BQDexPs2A2OYzyrPHg1svOG490OHyuXt2f7K7CiSLcH71uDTpm/ZT9j+rky4j7VuNeq/5s
X-Gm-Message-State: AOJu0YyrdXtq4Kyw/HV1fZ+SJmRyzLDiiqDNZJQP3F6LqgAQD607WNQ/
	E7/XzsVbo6k4HFSUefb3xwgFyVqvYeeooLa7zc03PfMRCWORSKSz
X-Google-Smtp-Source: AGHT+IGtLBGFSoN5TNSBuIxWdgRvEyQ19u5EHulCguBs5Optxu4BICaGHpZvw6N/6zjcZ4exXIGR0A==
X-Received: by 2002:a17:906:584e:b0:a51:e05f:2455 with SMTP id h14-20020a170906584e00b00a51e05f2455mr6626810ejs.48.1713768000390;
        Sun, 21 Apr 2024 23:40:00 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id gc24-20020a170906c8d800b00a55ac217235sm1586981ejb.90.2024.04.21.23.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 23:40:00 -0700 (PDT)
Message-ID: <0032f249-7787-4875-a782-0847c04d5c9c@kernel.org>
Date: Mon, 22 Apr 2024 08:39:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v3] net: ppp: Fix deadlock caused by unsafe-irq lock
 in ap_get()
To: Jakub Kicinski <kuba@kernel.org>, Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, linux-kernel@vger.kernel.org,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 gregkh@linuxfoundation.org, syzkaller-bugs@googlegroups.com
References: <000000000000423dd10611261d47@google.com>
 <20240419183815.30147-1-aha310510@gmail.com>
 <20240419173108.30cf9090@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240419173108.30cf9090@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20. 04. 24, 2:31, Jakub Kicinski wrote:
> On Sat, 20 Apr 2024 03:38:15 +0900 Jeongjun Park wrote:
>> read_lock() present in ap_get() is interrupt-vulnerable, so the function needs to be modified.
>>
>>
>> Reported-by: syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com
> 
> Improve the commit message to explain the problem more clearly.

Esp. I would like to see the stack trace leading to the problem (be it 
generated or investigated).

thanks,
-- 
js
suse labs


