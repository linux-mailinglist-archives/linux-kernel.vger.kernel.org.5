Return-Path: <linux-kernel+bounces-50456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F68847929
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D2C1C2846A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1B1332BF;
	Fri,  2 Feb 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYaSVsI5"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACA1332B4;
	Fri,  2 Feb 2024 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900344; cv=none; b=cv2QAiL6zLCdD59wcsHut4O25hb7ILBx7U6gjHr4XIzUdpj18Qna06zzSjfvWKZAwaO25kpcEOsmoKT855pAB4vxsBZG9wgKPTn/g41HNVi62Lho3shV+HmSvdDRDvjo1acW87Njvh43+3wp9pH/hf6kSKRvyBNnF+U+D9krsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900344; c=relaxed/simple;
	bh=lZOa3LlQgdWLR/A2bEYQ83D1Q7MjYh9ePkIGqaQC9bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJRzSCx17KLnDB5UqXS07Qa6M3AN0kXy5nOKUhUY1vXdRKi29qgRucxzkb8jfZYiShvBzdcqnmpvYZcCOgx5lmX3ZEXd2fPa8G07V7nmQcZtoEZZ0AmRIp0ZURaL8V3BzFWeUqTzdiFgIOkB8LRoOaSp1lnqF4xN5H4kQCvxvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYaSVsI5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7431e702dso21190385ad.1;
        Fri, 02 Feb 2024 10:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706900342; x=1707505142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgGmeg6oetcImjqjHI/WooEUzAXXWxBgMOgWJ9OZ6f8=;
        b=OYaSVsI5a7IeFv7AVV14HH6SAQP5YFL+ziRHSJav/MtHYVS0Ti7AdWPhJx70sXn4Ar
         RnIQz3XzFDjRMY09txuyXMnkvnARd7Q2gXp3GJ6IZIQyGUZDIqNqu2EOzumvfUDSabR/
         FheuQXDS81OTG2nQrxk5qHFhY7tgkEl+r2R5bRwQiB9mwwxv+wtiybkaLpLgDio93by1
         b/L9tjyrFIbwAogau53f5yhVwCIVxzSDrc3V5Sm2RcEHI3j2e7hs/qXXZWHe0VaMvbno
         3m+c2JmXs2ETnhENtb8npjplJFSETabHyHxnTLnKML/OJL7lVKgwRyNkAiN03dFKf1Ub
         URPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706900342; x=1707505142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgGmeg6oetcImjqjHI/WooEUzAXXWxBgMOgWJ9OZ6f8=;
        b=rJ69d9/nnJCntSJRwXTlEY1ecFztE5A1zLxRI/o1PAgj/EMwoL56GTz/THSzRdN0kE
         WtulIrfle7KXF9R8NfAuvzqJA2tMXp9M/u5XCeIGghAGH5RYWPm0a4/l5any3ODxxEy8
         bvL0s1GIaNbx0kYzCUzzTR6NAoBZGR/pmaCJevbOeb7vELx7Z3whpZUV35zO6igRHtnH
         73gQl+sKwV0t2ZQrJJKoMp/+cST5P+/1VPmlscoGSvhTARiGscnz5ZvZ03xgWBgc5gsT
         QQZCteyT111OpSSH4gapW0gkx8klX9VSnBRmmr5nJErhhjWxPkPC3CI+gHyPtgrLTkSU
         Ot9A==
X-Gm-Message-State: AOJu0YyIlUW4//hxpspnDBVCKVeIugW92jmY11inNG0msB+Yhx+Exw+A
	08e2r+3zpAj53CgvOH7KrX4zHI2JOhY/EXZQDGqC9VX8d/tGD1C2
X-Google-Smtp-Source: AGHT+IELr9yrkwY19+dwD7NEYhxitLeUNOfuVd5ZrfhTW1hBt9IyjhTGl4d8LpYB0yXwFhYsryyoPg==
X-Received: by 2002:a17:902:e808:b0:1d9:860a:c87e with SMTP id u8-20020a170902e80800b001d9860ac87emr785492plg.38.1706900342242;
        Fri, 02 Feb 2024 10:59:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUBcUNGX6zsZaKTxEhEtjSl+8htL2i2ChN7cKNXm3oL/KFyrIJFK4Bcvv0ni7bRf5TtQKRByalQXigSB8xAM15K7kzTZAfhDIOIX8bb9fyFB2w6LQoPTXQ/T6SoSTYnPJ1Qsq0b+x0BjDDy6kRmrDutS6z9/7zgi0tMZ4qbsDx5kyc9I3YQcjoBbILDWFbZCD3THzSlYzhw0hx3Xf11nD/0zUSIXdnsFM7P4GW0S1PoASyKb2PMSWGevyufDW66GLw09LX4/j/WKpyFP5BwQ/Q4YceRHj0dLNDWRDeZIyJ8OYdNaqEKIheaD6EPN1tdFlvhj9UoSrkWjeMUe9XOBElRM2fymhErd7DmdsRBB262rXm7N13p9W7X6rhBytiN5So4NIvnec4WEChWjZhV5wke0LU41XnKug8Bh3zla6JZ3pzN1gPU0z7Gkluppw1KYSBYBdag1fhsVWGsVavQ4byjngLeF7poFKBQS+eiZMbi0q9ZdwwvhPrqajOBU9yNgxZjXKWpmvlVBuXqRiJcYJb1kIkEXgGe/nuCQhCf41v1FDvG4MDzmLsqI6brADCZQSErXh25vMAUW9gwfPT9gNXLUmL8iiH0ibmVMr6gzXBg+9rfsqLJb/ELVOcaXB22C4XkK3YkjHoq8cxwWcpcz0c9Wom4VZ+H0anyH8/OKlDnK1oELmSLwRB//7fi5cYnmolIieTaxznkGriLnzuQ0Szwf4qLDAUl4lvvafHXsVpvClzOGcuZTxj+FSSn20AHypuL9gkfXu1aal7XC0Ye3XnWQ+dEeI7BCWJ7URP4fzxacpfHWcxxqxWdwWkTkkui3XnOUYmz/mgBGK17OudZaV5MULSa
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ju24-20020a170903429800b001d8e782707dsm1920025plb.203.2024.02.02.10.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:59:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 2 Feb 2024 10:59:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net,
	broonie@kernel.org, naresh.solanki@9elements.com,
	vincent@vtremblay.dev, patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com, bhelgaas@google.com, festevam@denx.de,
	alexander.stein@ew.tq-group.com, heiko@sntech.de,
	jernej.skrabec@gmail.com, macromorgan@hotmail.com,
	forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	cosmo.chou@quantatw.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add asteralabs
Message-ID: <87b03f2b-f6ff-464f-82ac-5f9f2a302614@roeck-us.net>
References: <20240115100518.2887549-1-chou.cosmo@gmail.com>
 <20240115100518.2887549-2-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115100518.2887549-2-chou.cosmo@gmail.com>

On Mon, Jan 15, 2024 at 06:05:16PM +0800, Cosmo Chou wrote:
> Add vendor prefix for Astera Labs, Inc.
> https://www.asteralabs.com
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

