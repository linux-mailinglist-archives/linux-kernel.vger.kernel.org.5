Return-Path: <linux-kernel+bounces-22721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB482A21D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9E8B2650E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CCB4EB3D;
	Wed, 10 Jan 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUiyZqNg"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE24E1DE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3376555b756so2685261f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704917977; x=1705522777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4Y5idhJN/b2YA/7tKi246i77Vd1olII45Is7/rbOJ0=;
        b=iUiyZqNgCnFkVto3hQiKF8VyOixXcMQPDYSayqSXXz9gCSepPHH2O9AO6sKb6iAOZH
         gGm792ekOZKOQ+3ThkQS4eVNh5QGy8+yopc6EKkqsE2BjSXnPi1E+vxp/ErE99BW0GUa
         k5GSUkKUEBWbt9F6C/xLO41qhzIY9NkDtRGLicIEY/3p77ZJPdX7EGsqM+wA7Azqehoj
         DhP3fIvLdBJvaoyX0OTTXXDUuYIbgfL47vzoTDThaJPaOYjI/mzOQ4zuokneJQHFoCMa
         xdrIlVvgRln6IOMxuX0UDHcnw8YudZvooEN6rwY/HE425OjErwJO5wwnYJkk7yxxyTKx
         vxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704917977; x=1705522777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4Y5idhJN/b2YA/7tKi246i77Vd1olII45Is7/rbOJ0=;
        b=KZVlVvdJrloK3BJ6F6gcGncX0zLkyDs4LUDGce/EmlKjYxa8y873zgSKu+WImL1COC
         /EMsBeJrBiEjvS66+KPK2wBZwkvuXDTxgne1WKMf3AdQ3C1ICstkMGi0yzM3k67Xx7s0
         Qw+hhq1qGJuPe4pbVn78y32YuveP63iyXjpsPHUPk0G1LWGJSf0oOn1WPIi57DIITXU6
         BBloWiRskAqkop+Bi64BT8BJwdxnn1W2ZLJJ8KF55Q/DeZCgwy8fIksiMjDvoq7fRN38
         DPcACPZYy70NmMPmo1s9s/7yXTP9uG3dBT2oET9LkOqjerlj5nh2/nRc4sVs+hFITe9N
         W2pQ==
X-Gm-Message-State: AOJu0YzXJW98beAPlDRCtt+0tT7VK7tFMyE4vTYfS9lKpw9jix+W4A6d
	aWmLbbhWveeWK8vUYd5/FSu4UvjQ0aSa9l5WbHSpjTQYNB0=
X-Google-Smtp-Source: AGHT+IG3HiAJlzmqFtXtKgjd2ICz2/cUda1a20KPRN8RDLfnmQlfE0i2/PldCAJPpMqIQtYSd6VysQ==
X-Received: by 2002:adf:fc90:0:b0:336:9ab3:dc47 with SMTP id g16-20020adffc90000000b003369ab3dc47mr8037wrr.42.1704917976732;
        Wed, 10 Jan 2024 12:19:36 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d46c8000000b003372befd19bsm5636334wrs.104.2024.01.10.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:19:36 -0800 (PST)
Date: Wed, 10 Jan 2024 23:19:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Rengarajan S <rengarajan.s@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pci1xxxx: fix off by one in
 pci1xxxx_process_read_data()
Message-ID: <05465217-174e-4888-a6ab-6251f4a9920b@moroto.mountain>
References: <ZZ7vIfj7Jgh-pJn8@moroto>
 <20240110144605.2a8813d4bfaff1a55edb9938@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110144605.2a8813d4bfaff1a55edb9938@hugovil.com>

On Wed, Jan 10, 2024 at 02:46:05PM -0500, Hugo Villeneuve wrote:
> Hi,
> it is not simply a matter of adding "fix" to the title.
> 
> You must explain what and why vs. how.
> 
> Please see:
>   https://cbea.ms/git-commit/#why-not-how
> 
> for some guidelines on writing a good commit message.
> 

If you can't understand why a buffer overflow is bad then I honestly
don't know what to say...

When I was a newbie, I encountered a driver which was written in
terrible style.  And I thought why do people allow it???  This is
garbage and it's messing up the Linux kernel with its bad style.

But after I got older, I realized that he was the only person with that
hardware and the only person who cared about it.   If I started fighting
with him about style then he would leave.  He was a quirky guy with bad
taste but he was still making useful contributions so it was better to
tolerate him.

These days I'm the old quirky guy.  If you want to fight with me about
commit messages, that's fine.  I can easily just add you to my list of
subsystems which only receive bug reports instead of patches.  (I think
only BPF is on the list currently because it's annoying to track the
bpf vs bpf-next tree).

Feel free to re-write this patch however you want and give me
Reported-by credit.

regards,
dan carpenter


