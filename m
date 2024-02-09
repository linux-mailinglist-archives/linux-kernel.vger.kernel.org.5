Return-Path: <linux-kernel+bounces-59840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D984FC62
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E441D1F21533
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2713980C1C;
	Fri,  9 Feb 2024 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwtDETOR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707F57339;
	Fri,  9 Feb 2024 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504976; cv=none; b=GqlqHyjkt12yZtaKi1zL0HZPr18JsI8pOxAYjVtRHb0nvZTzKdgG5wrsUyU157mbFdbggWfmiAb4Mi7S6mqbUH83GV4rGNh9HVKoEgea5bnExAM3/Am/jIRoNDbj5auBZRbGl63nA0LTSEnG8mVC/1b6e6I+de8KO1FtYKnhzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504976; c=relaxed/simple;
	bh=C9S2oNwOOfhw1Ocskog3nsge/HD81Vm1NImbMpSpgYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQZvggnW/tNJ0o5wTvHps0TZ7SkTjL1iANhg65Np1Xayao1YSmr2kvAaQu36/o97KaFPypm4IAzTloXPxW+TC7tp209eL0fyHQQQwJ2ml4RPMJzoKbxuw/Lia3H+St8YIeWufNYncyc+EWUjgFjadWApg023FPbYODIRJY2fTDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwtDETOR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d944e8f367so10694845ad.0;
        Fri, 09 Feb 2024 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707504974; x=1708109774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56hgMqr3mswCnWTmMb87WQwpoLmhLltp/8RI39azy0Q=;
        b=kwtDETORaeIZyJ5GswVr2CPfFgdFKIhkh/HlZhwqphJGaZhMSEXEDVgRm/rItcetBq
         4jOvmh+oCVkVboXWIwdCro15yk1YUTDZN/+SIxz3ruaSCDbN3t2pUp/BaYC9cjlu6siD
         85SwZH+4jlTCDluHpPyqg7p/Jrf6AXyyyDF71nktLhyiMxofNPg7n99l1+4tMz8tEQzE
         11kMbCf49BKcFAiL+yjT42iyfBcvoJTY1DtEEAiZarEWA85RV9gnuqxVrgntVv1evoxL
         ESQpFHAgzQNmq5NSBUs7m1EWAa5SNjODQZAn63BcpbcwBRHG4wL1vkTZ1cR9RDQxLaPM
         dh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504974; x=1708109774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56hgMqr3mswCnWTmMb87WQwpoLmhLltp/8RI39azy0Q=;
        b=qtIL1cVPRhopNidwNHS2Q2vxbOxln7qP4kIX+vsPNyUXtCx1wkFNhyLbfG+FsaeTG5
         DjE8Lj6nUbXjnbQn9sxEMAKHf/tspMZUnMT7zx7kmnqQlU6jOQc1oh0Cmx9ql8a8fr+r
         2F1kkAnnJOuSlzKfVLdUZFU6Pdi6B8gCyIJtatbtHKZWUXf8i7evkNKQRcKGl7Cs39BH
         4EgO/YQbXM8rX0PkTNm3Tuoruibn+PkCdCDClqZagIFgaB0e0BUre3t/gu+/65Pq0gSi
         1LW2hygi1PjQgV9x8PM/LixDPBAEWwrhbrMMo1vuE38I226drTtkQMvHPRi3/E1klBuP
         CPgQ==
X-Gm-Message-State: AOJu0YyStg0jbn8cjl8uunSxYyIolhvQHFpgDWE/4VSRUU77dYfnIhvE
	f6RxVG4O3hFigJCD+IAGJvK/SA1Dvsq2CVmFeTAHCWVXFxj4nPEZ
X-Google-Smtp-Source: AGHT+IEfTKQr1tJLEw0FhCX2wQeGeOD8/LznWPv9wkv7W5WtuaR7MMqHEGB5GTH/HFZP71SmkqHDFQ==
X-Received: by 2002:a17:902:9f87:b0:1d9:657c:2769 with SMTP id g7-20020a1709029f8700b001d9657c2769mr119939plq.19.1707504974268;
        Fri, 09 Feb 2024 10:56:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYlk1nnzdg273wMBD0TlhR6Ex1Db4qqsAlWzgp9N2xrKjlR4Z3Ll4QNQmgN1UgNggrDZ2kvKKro10zHppccIWiEj8o/FJjRXuwADw5+rKMOsUplakT4BPh613rrk2Rw31w9nr8i+Z4fbrev7ADEXGvqqrqq00BGkKS95jNo4R4VOa/Xt+wW5YKr4jTIvET9SN/kqULLfb9YmFgr5LzxQoGscyAGHdLfVxpikYJP7P3LUeVpKvuVreBQONCZcj2XCGLlAjPwyLJ0s3rG1yg5hqJ227QE0/293fthgV0KxI969k8fDWhMWebhI9LX7MH+sT/eTXnCoKXiv2qCk6AJmrnyPblLouVywWif/iu7EDuh5SGOLv3r2eWC7oUSh59iMMV5w81eWwa/IFBZS+H84FCL//AQoG8tzkM5GRxlLt2Tl0KpwrNrut/7rvABggTmdJi2eZBnZo0cZEX8Hr3
Received: from google.com ([2620:15c:9d:2:9ec:8b78:c8c:fc9])
        by smtp.gmail.com with ESMTPSA id jh21-20020a170903329500b001d9609f2e30sm1843385plb.1.2024.02.09.10.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:56:13 -0800 (PST)
Date: Fri, 9 Feb 2024 10:56:10 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Brenton Simpson <appsforartists@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Cameron Gutman <aicommander@gmail.com>,
	Erica Taylor <rickytaylor26@gmail.com>,
	Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
	Jonathan Frederick <doublej472@gmail.com>,
	Matthias Benkmann <matthias.benkmann@gmail.com>,
	Matthias Berndt <matthias_berndt@gmx.de>, nate@yocom.org,
	Sam Lantinga <slouken@libsdl.org>, Vicki Pfau <vi@endrift.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	trivial@kernel.org
Subject: Re: [PATCH] Input: xpad - sort xpad_device by vendor and product ID
Message-ID: <ZcZ1Sn_iPwlgfI3s@google.com>
References: <Zbl49VAMZx2qrz-p@google.com>
 <20240130231903.293265-1-appsforartists@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130231903.293265-1-appsforartists@google.com>

Hi Brenton,

On Tue, Jan 30, 2024 at 11:19:03PM +0000, Brenton Simpson wrote:
> Signed-off-by: Brenton Simpson <appsforartists@google.com>

Empty patch descriptions are frowned upon. You should be able to add at
least a single sentence why the change is being made.

..

>  
>  static const struct usb_device_id xpad_table[] = {
> +	/* Please keep this list sorted by vendor ID.  Because the lines use different
> +	 * macros, you may need to sort it by hand.
> +	 */

Kernel style of multi-line comments is:

	/*
	 * line 1
	 * line 2.
	 */

I adjusted and applied, thank you.

Thanks.

-- 
Dmitry

