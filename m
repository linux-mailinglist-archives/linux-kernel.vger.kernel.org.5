Return-Path: <linux-kernel+bounces-68966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70148582AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D101F22565
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B195B12FB3F;
	Fri, 16 Feb 2024 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/Z5RBOW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B9712F5B4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101320; cv=none; b=T7HMhYYpXeUDUiQ/Ku1BBs2zBjVhHgTL3OmME195H/5wWnz5tfav3NgpB6YGzfY8ZmUFp/707C38V0s4tvaapyRX2mP8f42SXtK21/twkXEWLwZbur8z+H3VYcxw/TyJFB/QYaPDgsWu7R1/G21OTc7f+NmqoYZiAi2t0YyTv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101320; c=relaxed/simple;
	bh=B8vlj4rkb1u9ir6i8zWwzwehWfHDgJSDiokvLcp80UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgT6ujjRQ7doeEpw7Vtu0T/vK2lXs+QZBwtzkYup/IadAsJeE0IO45hmWGWRLIZ6APuZa9+R07G3/ZtuEpgG3dpIuczO/He1jifEqIh3gKYE5rfWwNxyq9nRPH7DasEXOuwra7zVplflWCOojhNq/fDYohc8LphemVZbQxkZ92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/Z5RBOW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d94323d547so8181425ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708101318; x=1708706118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qB1S0iggCcGqJZnZJni4F7wDrDu/4TbUI7hAzeTwi04=;
        b=L/Z5RBOWSveaFFwxK5z/jfCg23TtvW/bs5s+/zj7iAzXUHSducjKfl8NSvUb6Q6XTO
         X/d8tJ/Fk/6IX1zseqYlT37FunkBjxnw63q7KU048gW56wyT8dZMipHiqHy/kliYYxX8
         4IZem+0yGNZ/Yhpi78kLYYMaThyEqWwnm/SEWmXyJEildZbSxuetN1rrOf+Fw44kRfg9
         NKbMSkRSFclgpb7CCfHRQL3J5l25DQz3YMaUwxEzqFmPse4nMTQFDp1eT8Wo5ibKAzaC
         neFIoTtwLyHRWZlmpoR7/9L8hr1xnP4Y2vl0BaV33vT28f8PdHPk+GcOsVq24EOFN5Pr
         EnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101318; x=1708706118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB1S0iggCcGqJZnZJni4F7wDrDu/4TbUI7hAzeTwi04=;
        b=NBTONaKByMN/ONJ5z2lvsw0SKGBiqsna/XJN9MKbmcgH98+Lw7tdNYtum07ZsqMt5A
         0Mf7dOF74QTNFNYhEvRPiW1eskuRpyKds6HhKf8P3eLF15DvjhMFAlRAx2GqR6FUcLJC
         1/CClweljJp1o/1uF/szeOBDz0e/UYZzHQ7CPBLoBZ3weAAYsoYnOvZsZn8enf8vbjU2
         gu7W6biJ8WuXq3xvwGbQLfAjqINoEldKaJUKrauaEP0DBafoNkplcQlt5Twb2gKsQF9m
         nnOjWFXtst1Bx49q/zRwTrpBbKZYFyP7Dz2+S2vZuBSDfuL8DIR15f5E+JnWXXKjDI5u
         yGqw==
X-Forwarded-Encrypted: i=1; AJvYcCWXaF2KULsx6hz4PPn23lY8e5K0N80ETWlcNRp2Sk0+bybBJ/pAMRj/KvBH29p60zmIax7cJllaWURN6alt/KcYI2Orfk1SAxJ0ob4g
X-Gm-Message-State: AOJu0Yxy8Lmt7Yn9+PvzNU/bJp7DATifECrmvKTtZVCeV24roEPNxkXW
	PHBGxz1CUQG6ARjOZC43EMcHACU/w6za13bFsJ3kPrzN8GLHwrq1
X-Google-Smtp-Source: AGHT+IEIjtKvLUeniYuDfTEQOpT0IMwtTX/PPNX50BowfrFEZdDD1j8NLLKLhelM4RfMVGIJCcqI4Q==
X-Received: by 2002:a17:902:da87:b0:1db:28c4:b757 with SMTP id j7-20020a170902da8700b001db28c4b757mr6214986plx.0.1708101317734;
        Fri, 16 Feb 2024 08:35:17 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902e30200b001dbb0c5d155sm81874plc.80.2024.02.16.08.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:35:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 16 Feb 2024 06:35:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 wq/for-6.9] workqueue, irq_work: Build fix for
 !CONFIG_IRQ_WORK
Message-ID: <Zc-OxJtCtMZC_LT0@slm.duckdns.org>
References: <Zc0IzeM6tAvm1NTl@mtj.duckdns.org>
 <Zc65DUZKIx5IIgrX@slm.duckdns.org>
 <Zc7uKXZwHdATHyMY@slm.duckdns.org>
 <CADYN=9+-er+j_7MQDrVbs8Kt5zAz5EdEjszeJWuHjP1K1GjWFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9+-er+j_7MQDrVbs8Kt5zAz5EdEjszeJWuHjP1K1GjWFg@mail.gmail.com>

On Fri, Feb 16, 2024 at 11:24:26AM +0100, Anders Roxell wrote:
> I applied this patch on yesterdays next tag next-20240215 and I was able to
> build the arm64 tinyconfig.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for confirming. Applying to wq/for-6.9. Hopefully, this won't cause
any new breakages.

Thanks.

-- 
tejun

