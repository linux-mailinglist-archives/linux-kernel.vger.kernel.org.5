Return-Path: <linux-kernel+bounces-24879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4482C424
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D631C22280
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A6E17540;
	Fri, 12 Jan 2024 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RurXtaro"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9321B585;
	Fri, 12 Jan 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cf1f4f6c3dso1908760a12.2;
        Fri, 12 Jan 2024 08:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705078787; x=1705683587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9F9H5m2UqD7K0wRa8JjG4+hM5ev/YDQv3Vx3krTev0=;
        b=RurXtaroF99+XFk+vJw6LodtmJr7KTiUF3nJ3pVpN4UmxOabKkc6+E9yVNKyfCbZ1L
         8FAldpAJ8UCXI19zMHOTBzXd3cVcRDxF+4L6QuJbmbCZgiT1/kQbOhzvuuqx9O547KR8
         LoXm+x+bZfMceTpRDaxDzVAEcVtQ+ayhFiwARRi5N94tONFnQj7L/bnMJu97eo+D680K
         fzmxh8S/o1NFoGFhtX8wWCHvQca7nZURThcoZqDaEp5SgGwAGdk5IavOhlWYkvC8TBPh
         rNu/PKEmvcvjt24zpa7yUsEBLruFNvbsvjr+Cg7ZTZ49eD1QpridSEebYyCg1oE7y4W7
         wlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705078787; x=1705683587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9F9H5m2UqD7K0wRa8JjG4+hM5ev/YDQv3Vx3krTev0=;
        b=DLCATjQ0Zrf5zbgXdmazt1RkG7sXOkmX5IfAJoWJSQdWA6UTB+t/qADWSR6bphkc+m
         FpT3Qc+JPmPorltw0fnhVDPE8cagj2TxqxpP+ELQyc3nbvliUY5McflAKqy0D+0BGiRv
         RMZZuHJIaDNHX2NMVHn61PHyAS0VUdsM7pSv3RuVa9VxEUkz2tuX2aEdosz6RkLI1LmE
         Yabb/b/U/ptAQR1RFREBx3TcIlenlqZluUSt1UBjIRqQ7LQ7DsF8csEgNq3uMGv8oU21
         HGSjTc0pX+znDto1JlP+ecixcqdlMN9pTQRAIpSIKB5Kfgv00oCsIHfl5YgzgIJNd+Fh
         aDng==
X-Gm-Message-State: AOJu0YzzybioWslz032zkLdKUqu50JxfRE3ilItn117veSNCXKrFXt3a
	Y3/yCOASip0dYv9HQ4aSI0IarYTnj6HpZiyzAmI=
X-Google-Smtp-Source: AGHT+IEG389YSvfn+IpZIBlscLZMHZhDFTYgbsonRLB5XKzjTeRqxMacx/YKJRvroOesq8X85g/4wKm4saq89cu7De0=
X-Received: by 2002:a05:6a20:1051:b0:199:f2bb:f166 with SMTP id
 gt17-20020a056a20105100b00199f2bbf166mr937692pzc.30.1705078786876; Fri, 12
 Jan 2024 08:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112125801.2650-1-2045gemini@gmail.com> <2024011212-disbelief-respect-5230@gregkh>
In-Reply-To: <2024011212-disbelief-respect-5230@gregkh>
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Sat, 13 Jan 2024 00:59:11 +0800
Message-ID: <CAOPYjvZYdPSiZ+jX4vhwPQ3AKRvW15XT1znAa8vd9a6DVoor5w@mail.gmail.com>
Subject: Re: [PATCH] tty: fix atomicity violation in n_tty_read
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, baijiaju1990@outlook.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I apologize for any confusion caused by my reference to Linux 5.17 in
the patch description. I'm currently working on a project involving
kernel static analysis to identify atomicity violations, and part of
this work involves comparison with a previous study that supports up
to Linux 5.17. Therefore, I initially ran my tool on 5.17 to filter
potential bugs that are still unaddressed in the upstream. I want to
clarify that the patch was developed and tested on linux-next. I
realize now that this may have led to misunderstandings, and I will
ensure clearer communication in future submissions.
My experience with Linux kernel contributions is still growing, and I
acknowledge that my recent submission might have been hasty and lacked
thorough consideration, especially regarding the critical nature of
n_tty_read and the potential impacts of the patch, like performance
concerns. I will take more care in future assessments before
submitting patches and continue to familiarize myself with the rules
and practices of the Linux kernel community.

Thanks,
Han

