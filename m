Return-Path: <linux-kernel+bounces-89930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96C786F76D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686341F214AC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7650B7AE4F;
	Sun,  3 Mar 2024 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJeuh37s"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49E1E484;
	Sun,  3 Mar 2024 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505110; cv=none; b=ISRyMI5ynE9Jka7tV8fBgp2A/eGw8y6+0KBuIWQ+3eBYeWf89Xb1HZHFHo/2HhNb1pQJ4Y0yQmbV04t2aNS+fqBToIFsKxfFY9dRVUDo9qF7Ebz4C+4oAJZeBiIMV5Tw9ccKfmKQEQhiw83YLYOWmTx5sy/5DbWuvEbGLQjWRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505110; c=relaxed/simple;
	bh=tVfVLgtXYUfLnXEzOs8FVL+6X7bfJi1XbwTO1o1SqQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5reaTw2O5C0g7Ys+VisJpSAGO+3ocTt5oOMKd9RKXTISdabHPVZPl2plZjyBiKu8YxW9IHWSrwmbVtwj2apgC9RluqyuQpzCZzfH7RRDNTRpSlFRnKbipspB6lkjqfJqTlyVYo57yj8YL97QtQ/VmJX4Y/hI6mVtM/H1p1KGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJeuh37s; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3907ff128so3962756a12.3;
        Sun, 03 Mar 2024 14:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709505109; x=1710109909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=znghxbZ4l34R7oZ3KohDywoN1rA+y1aUvwjzptHahq0=;
        b=iJeuh37saJXEq+z7r/1bUAJ/Y5ZZIxjnquLLmVl9WfECa2AEwdyxYb4SFbu1zuC885
         Ld2hjVxIdjs1Y0cAfb6anyjtcrt7RmKPDYDh/i3FhZebRjk7E9aZfspmNQMCK4hiCbkv
         PXn7GIjp6GZP1faEeoewnszP0+WjbZmG7dbE39UNExGMEIIFux3Ls3cpjRQBV6950hRl
         9myc+MD07FakcH3qD8XbuFVHli5zIppguhddLdiaEWyMdNsDOIIErc5ewCdpqytvpA8W
         EhUGW1a8Fsqf+kKpUvlgwsOLNq1eDERgNh5iP+q6APkopDmiwrP/Bbl0II9tu4KZMKzh
         ZAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709505109; x=1710109909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znghxbZ4l34R7oZ3KohDywoN1rA+y1aUvwjzptHahq0=;
        b=fID/1AIasjuPxLus2UOfipCspgvGxH3iMYi0WdD1/MaWgIB+dw0BIum2eTm0KAkIAn
         qPgRtXoiIpQJl2KqNWhgpsCimVfaOn4b5JsPD7G7+EvCSs1yMcUgzMWkCi+WpCJkJPdd
         NMokSCKwwPhhTlrZ2c3D303IoFq+Wm2r3+y3D0kOVfMCKMNBNtU9gWNQ0QbAyaAIUiNr
         u9VoBEYBB2++AVHh8FjINTUWCk5KstRN/VD61ForPGoAWXzObJ0jGhYQVf8quTp9ceZ7
         RRNo8/zDrVjE9Y+vmqZDSeIGE3uAxXsgFEwAXcgfeXcCOoQQHg9FblZJJwsZqjV3HeVl
         WBCw==
X-Forwarded-Encrypted: i=1; AJvYcCUHGrfO3lgQm9HTUU4S96dTO1aAD05i0gm7ObY28tUn5+7ikYF70pxC+3ZDUqQ3YURaRwMyIVN0fC9BJ+CYdeI5NwR7GGCRur3DH60ZPQd0UZkzUUAh9JLRphUyst37HmVAnSXWPRM8Fo6Ld36Z
X-Gm-Message-State: AOJu0YySD/UTM9fCI/QQH+CO+2q0CZ95QWjpq0ZGqmZY7zX1TGjhlY8o
	YJd7qmdFs2RF1j/oAH6ixMHxDgfI0wLb4p0nQDK0jL7cyxmXD2Ot
X-Google-Smtp-Source: AGHT+IFDE91gsfkorXaJ/eB0OfGef9DV/OeFmqrOvfd4+gpl6588evrCYRhKOq5C9DODIz+xzNQtyQ==
X-Received: by 2002:a17:902:f7ce:b0:1db:37b1:b1a3 with SMTP id h14-20020a170902f7ce00b001db37b1b1a3mr7551806plw.17.1709505108558;
        Sun, 03 Mar 2024 14:31:48 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:99d7:8333:f50c:d6a6])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001db5bdd5e3asm7081116plg.84.2024.03.03.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 14:31:48 -0800 (PST)
Date: Sun, 3 Mar 2024 14:31:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Jeff LaBundy <jeff@labundy.com>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: iqs269a - Use common error handling code in
 iqs269_parse_chan()
Message-ID: <ZeT6UUFNq1ujMW17@google.com>
References: <6bf9f962-cf75-459d-89f4-2546063fc154@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf9f962-cf75-459d-89f4-2546063fc154@web.de>

Hi Markus,

On Sat, Mar 02, 2024 at 09:24:53AM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 2 Mar 2024 09:15:20 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function implementation.

No, I do not think this is needed. However if you can introduce a fwnode
cleanup/free function (see include/linux/cleanup.h) maybe it would be
more useful and we could apply it to various drivers.

Thanks.

-- 
Dmitry

