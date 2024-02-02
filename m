Return-Path: <linux-kernel+bounces-49672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FF7846DE1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70F7286D3F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AF7C085;
	Fri,  2 Feb 2024 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YNK2lbY/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9637C086
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869735; cv=none; b=lNpUzFJdglGVqv2mFqNQ/Dqvug+WaDVv9BqVbOI6XuW3WHwMyzap2IvC5KnCr9zcwbPAE+o6Dh3OXTmGiRMoCxfvBH7YhJ8mXv/rZRu5fwkGQzUKVEtPWjgeIMpz/t6CTlpfDUxdFesk7iWGK/tX+ZW6QTaCBfqBNJIyI0wztjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869735; c=relaxed/simple;
	bh=dL7uGPwyAybhRY8krEHZS8RFuBz71FSPqdxQAnbnt4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srIgWwy0a7evb1lvH2aLD5K4co7ddCeLKWN/8ukJcFTAM30zncwGFjJQt9U0ZYEZxydrSj/WELWu3vAIa+MgxJyhtXNxgrH4mev2vvVJs64j4UIsdMWxU65lMbzPWoTK4UsiN5kkAf7S9OeiYVJl8OtYcmgf+uK8pMEehRe7pGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YNK2lbY/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so2859330a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706869731; x=1707474531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=omQ7+GMjSKpytu49hD1r+ofiPUD7xzcIASpmQF4KMg8=;
        b=YNK2lbY/UaJmTekLCjyhzQA/VXUGKOuaCtwbNZY3sU6iGMIzDo5JLg5tOKxM25sTdf
         q4t56n6epQh7Y5SZE94UR6oWo3fYId+m+g3L9vaGN8ie6fTJTg0v0fcMRygrE4skG8Bv
         xxGoXxhbHKp+3jUO/ALwzcLmRzLUwgLj4VhUno5cWR/perXPJiWNj+5meOqsOfP5rZTQ
         H591aLcXGj6gR0YqDPakdICLuCS8Bk81ALUaAj7t0XT/IshEjZx8u8cnROm5kkdACchV
         pfXVlTk2oOwyDp6OmmUEBMT741R375/LWtDB6J+007rpxeoqNzj8KKiUZ9Eeu44Qrzpd
         O9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869731; x=1707474531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omQ7+GMjSKpytu49hD1r+ofiPUD7xzcIASpmQF4KMg8=;
        b=CBGjRylDs7KZizPmcjK2lY/QZaSce2zNaLccg+93ulpVOZgP8OC61W4RaQwB/PNUyz
         IyiVRwy/quCcMDEYl+y1IQ9s2Qo1TTZTvf+MS5c8Xzjb1b53MnAUDyF6yIrQzRQmeyi8
         1th2hXeXBi1HDXXJv5+G4z+wMmziby+vheL6Ybz2QLC/Xz3FtvzoUv51wFy2y2EXo90P
         U/UZNK9hbxy0OcrJGrhtgqNEW7lOeRRpnghSwreAI8V5fj8ruQvRS46VdKmZ28xlYApx
         GBOZuf9qgxv76qiwXJqn2wqb9Y2EGINooidW8/Uyj5K6rAMR3EuRYE1MVyS3/psd8u5d
         TE5g==
X-Gm-Message-State: AOJu0Yy3YFg6UbiYq/xVYjs2nDnAJdR7gMSuvCiABdPgGo8CPQ1vTCWR
	4EwsvbYPBtvOIf2aCwNu7KstDuzMTDfG4wMaxF0IdOyslKlVXvmZ+Wq6/HNOYwg=
X-Google-Smtp-Source: AGHT+IG4AOnjxO6LKG0JUwNvEozHpt5V9r6qBfw97aEaTDBYIAlV4QevQFNkea1ghpdkAe0RVG5OQw==
X-Received: by 2002:a17:906:dfcb:b0:a31:616c:7a7 with SMTP id jt11-20020a170906dfcb00b00a31616c07a7mr5920041ejc.16.1706869731229;
        Fri, 02 Feb 2024 02:28:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVWuzfSG63KyB0eGfg4z9LmgreyMrmTwJktNb4iEoYA/y6yAJz8gCvOYk6l56zD43KH4jbqDkNe6+8AgKtqnabalYpJQufAIq4DcIfgwOOEKrFg1EaqVX6xHFIeGJ4kJFE9KfUPM8PCTLWZv591nrUWGqcJsM5yh7E+9knsxJXAC2DQ5SAnaBWx661SjCsDXPs0njgF4IBFtRmrA1wzfSCv3kt4hE82dvLWnU6SvV8zKWI2IqirvTwsrtUFqdCanHBTpzb6g03uuDaRko42pYmXJW1cDtKiJo4CdhiNRMJAVQGszqTfxvJVMfraXCRa/yDSnHVHg4djeDJ8A4CN
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id pw22-20020a17090720b600b00a310c9d0cb9sm727641ejb.121.2024.02.02.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:28:50 -0800 (PST)
Date: Fri, 2 Feb 2024 11:28:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Simplify the allocation of slab caches
Message-ID: <ZbzD35e4pw5xfzLI@nanopsycho>
References: <20240201100924.210298-1-chentao@kylinos.cn>
 <1706866812511330.14.seg@mailgw>
 <961cc4ad-0133-44ee-be22-ba2fbf4ebe12@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <961cc4ad-0133-44ee-be22-ba2fbf4ebe12@kylinos.cn>

Fri, Feb 02, 2024 at 10:46:33AM CET, chentao@kylinos.cn wrote:
>On 2024/2/1 20:47, Jiri Pirko wrote:
>> Thu, Feb 01, 2024 at 11:09:24AM CET, chentao@kylinos.cn wrote:
>> > Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>> > to simplify the creation of SLAB caches.
>> > 
>> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> 
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> 
>> btw, why don't you bulk these changes into patchsets of 15 patches? Or,
>> given the low complexicity of the patch, just merge multiple patches
>> that are changing similar locations togeter.
>Sorry, I haven't sent a patchset, I'm worried about messing up.
>I'll try to deal with these similar issues in the way you recommended in the
>future, thank you for the reminder.

Also, please fix your email client. It breaks threads.

>-- 
>Thanks,
>  Kunwu
>

