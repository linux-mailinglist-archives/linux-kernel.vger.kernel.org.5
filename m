Return-Path: <linux-kernel+bounces-18483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DBD825E42
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050A31C23C4B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64E1FDE;
	Sat,  6 Jan 2024 05:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/xf9JXG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE51FAB;
	Sat,  6 Jan 2024 05:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f3a5b9e09cso510037b3.0;
        Fri, 05 Jan 2024 21:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704517391; x=1705122191; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S6WQ72yzEWlJPYXcZ4mWVTOsW9/5ZgzPZbDV727HLoM=;
        b=f/xf9JXGFP2Ti0+fB8RUF+T7p6uWiCAr/GQvBsewuPS6qnLO6mHhbmPD5cHhFq+GhF
         Vkhg0cdkl2bq5XVDU2VaXYXEc/IxJPTJ0MLjmGkNU4TBst+27UFhIsqgK9naCfC88azN
         oB29hJtHBp4faiz6GlGooj7DdHkzvTSIVo5FVKrn9dq6hrGDWqFthkZCGe76GS3PRqhu
         yYkn5elmXgxUtqCRew3xIUyZBSWfwtO6EL7XuP3HYic9LY3DO044cDvtf28UKSTC+gCK
         waKakDapVTVZizU0mI5udaMAJZqE4c0f8COJbb6L0pxYSrAopDVwtTPHqNe7clBXFJfZ
         na4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704517391; x=1705122191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6WQ72yzEWlJPYXcZ4mWVTOsW9/5ZgzPZbDV727HLoM=;
        b=jMT+Arz6XKFDKyZ3Sr5BrWaFeFx/ovJSkP4/LjT/B+dIwa0lBUEz311Sx8wpIfFVJL
         5EEooA5nvMScqaFJhhr5jL46t/5lKdZWx7Zi9XMub9O9cWSLyokvFjXx+E1ZkEvIFjry
         W+uHzMRbOI7rcAfBq0RegZiGco6YbJa5RRXlFyXMo5S5DZsXAGCjtWMyNIbnBwrntIrD
         6031LMlXDWgbBYQ3wcZC0RkZkgsXhEOsZQtwfCQcNAPPI/Scs15xcwQD1w/4rv2N0Ct8
         LiHmxMQ4G8nD//QYG6KE/m+QQor6W5Qgso6bpK7uICg0BRtXifrq1BnNlFszE6/Tsa0O
         ofoA==
X-Gm-Message-State: AOJu0YyHHUOO8DSESPNkCXpGXAjjC0C/fkt0jTNHAGAZdmL+SQFuXLi5
	uIes182CLONo5OW+aCU+Rbo=
X-Google-Smtp-Source: AGHT+IFr/vi7aARiyYM6iY4rSPLOVL4MWF50+EoxzlpgqAasBcl0pW4oMEkfDMqGstDbshlkp0K+hA==
X-Received: by 2002:a81:5dc5:0:b0:5ed:902c:602b with SMTP id r188-20020a815dc5000000b005ed902c602bmr445255ywb.1.1704517390958;
        Fri, 05 Jan 2024 21:03:10 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id p68-20020a0dff47000000b005d4035e6135sm1224047ywf.74.2024.01.05.21.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 21:03:10 -0800 (PST)
Date: Fri, 5 Jan 2024 21:03:07 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
	=?utf-8?B?4KSwKQ==?= <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCHv3 net-next 2/3] ptp: add ioctl interface for
 ptp_gettimex64any()
Message-ID: <ZZjfC9LvQFrtwu_x@hoboy.vegasvil.org>
References: <20240104212439.3276458-1-maheshb@google.com>
 <ZZczNlXzM8lrZgH5@hoboy.vegasvil.org>
 <CAF2d9jga9oc4OST6PMU=C9rz_NDrURCcLGx-1tP31U00z63vbA@mail.gmail.com>
 <ZZjdUlaYyHZSiwSM@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZjdUlaYyHZSiwSM@hoboy.vegasvil.org>

On Fri, Jan 05, 2024 at 08:55:46PM -0800, Richard Cochran wrote:
> On Fri, Jan 05, 2024 at 09:51:40AM -0800, Mahesh Bandewar (महेश बंडेवार) wrote:
> 
> > POSIX clocks are employed in this series for syscall width
> > measurement, potentially leading to misunderstandings about
> > overlapping functionality. However, their roles are distinct and serve
> > different purposes.
> 
> I don't see any difference in purposes.  The multi_clock_gettime call
> is a more general solution.  Thus it will obviate the need for any new
> PTP ioctls.

And to be clear, I object to the third patch, the new ioctl.

ptp_clock_info.gettimex64any() can and should be presented as an
optimized back end for the multi_clock_gettime system call.

Thanks,
Richard

