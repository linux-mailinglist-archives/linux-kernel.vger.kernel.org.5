Return-Path: <linux-kernel+bounces-130118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3945897445
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639481F232AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9876149DE1;
	Wed,  3 Apr 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U3QC94Hu"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB259B67
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159058; cv=none; b=aQsgoC57tHH6+fb/erWOpnBuORxWORGcEwODLw9rRmhRVnrF/MzYY2eTOjk+sqXL72++qw/5Vj9iOk1ix9n8KXyBcK2Gkb7rL7wzZqaFl8lV0FpKq/yqpDvzKIlG8qUiVmP0uhsT9BWOsGhOnFhGtbN37hWi4x2LLZgOWFDEIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159058; c=relaxed/simple;
	bh=uOamvgZx3i26S0kHCSK6ShX3F/IohLv1voGOcXD6Y0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+ilRy5FiZA7X0M2X4eynSGobB+weM2cYpDcsAbgeqbEAH1X1mHp6V2dUWeTdiaG4jyaXfYJPv7O53Z0v1jzOT8Oi6sw4jBAHJxhZmJSjseI3BMSwZDDK7vjFXFn27kZF7WhghyS7MOtdjPpTLQtO+DEISwtp8FW+zp1ZiWOM1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U3QC94Hu; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e9ddea8b3dso315364a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712159055; x=1712763855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PVVYuNrAUl36pyd3xeuvzvQvdQgmwGY67VpgOIWSOw=;
        b=U3QC94HuPmdeR+8S9GLsXwTvVBjJog/AwExJ1IeyXnmxBBvEFd8F9fY1+EheF+kUV1
         ZwKsnsTx4nGp2wbilnz5J59CXzSNPv+vXZwnP/1PNwuiDjxnQqpccuCl2i+H6Tp3Ppzo
         xr+JeP0dfG+zDMpy032NqHAlTK/bynaHixcmCv0rA0MBvgDVf5+ptCurwvv38VcxQK69
         XDoNEEL7FeBAQUY7Kbc6IWppLpbOBehTNyLBm9CZ7Wp+Yjg52SuzkcXpO+5tkrANDWPB
         a8dz7naCSNptlwLWy0UX4nNhNRTRhHY5MR5jTsEs4JkWcFXc8vta2LTd81HKzxactbHO
         ANxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159055; x=1712763855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PVVYuNrAUl36pyd3xeuvzvQvdQgmwGY67VpgOIWSOw=;
        b=JwI97Q4P8mszcphLNNxWb7da5a/3mZxsVYx4W9J/AVrIqNPImAMW2ytmXJzzjRfj/j
         gkY760kkhx+R+LgJj+0b5L3xD1kfd0/1CEo5kPUGg0vI/8H7qwDXyLzBQU7wg/DzIzAM
         SEHJ2wnALeXCuVAKwGibx8pdb5h9u3IusmQZ0hxljcO9BHPO0ZJU5/+kpaROTtiqS/Z2
         i87IdusC9pKmlBXzcsea9q7YqRbBGjgxWNcmGEMfADFYS8dEriUoj+eRGIqa3NHs64hh
         x71nX1M2D2rtSftGhj9yJp5WY6CC6K4twoLNt2udK3fRbToWnsv7OTfWW3jg1U+x3XVy
         lh2w==
X-Forwarded-Encrypted: i=1; AJvYcCWxwyZRxInls8tmlqD3X5TXroBL0SgzDjb//GxbpZZlA7MY+XILKZn3wQO3PfMhQMkwaLeVRsCd5hcmw/9adCWe4JHXvG437/tmJBwf
X-Gm-Message-State: AOJu0YylowVZzushn2RWpKb4jjg0Fc4NHVr8RXDH2/vYg1XsxOvW4Em6
	WtFMjhjXwfw59zg21mnPPQSGAyPnUhDgtU97+r6T0l3yJHXKGkt7Upub5pqdLdI=
X-Google-Smtp-Source: AGHT+IFZkhbozTXxif0mxmF92PRdOyaPTrbx7gCtN2UwQ51SV5wycjFky/1bPdc61ntu60EA8vaM6A==
X-Received: by 2002:a9d:6f85:0:b0:6e8:aba7:4b8b with SMTP id h5-20020a9d6f85000000b006e8aba74b8bmr6319870otq.34.1712159055700;
        Wed, 03 Apr 2024 08:44:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f8-20020a9d5e88000000b006e6e3fdec53sm2673494otl.35.2024.04.03.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:44:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rs2mc-007hKH-2b;
	Wed, 03 Apr 2024 12:44:14 -0300
Date: Wed, 3 Apr 2024 12:44:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Tao Liu <ltao@redhat.com>, Gal Pressman <gal.pressman@linux.dev>,
	sleybo@amazon.com, leon@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: Implementing .shutdown method for efa module
Message-ID: <20240403154414.GD1363414@ziepe.ca>
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
 <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
 <20240326153223.GF8419@ziepe.ca>
 <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>

On Mon, Apr 01, 2024 at 04:23:32PM +0300, Margolin, Michael wrote:
> Jason
> 
> Thanks for your response, efa_remove() is performing reset to the device
> which should stop all DMA from the device.
> 
> Except skipping cleanups that are unnecessary for shutdown flow are there
> any other reasons to prefer a separate function for shutdown?

Yes you should skip "cleanups" like removing the IB device and
otherwise as there is a risk of system hang/deadlock in a shutdown
handler context.

Jason

