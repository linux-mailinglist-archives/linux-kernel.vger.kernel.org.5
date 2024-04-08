Return-Path: <linux-kernel+bounces-134904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5D889B87B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C0E1F21DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2FC28DC1;
	Mon,  8 Apr 2024 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0U7uAH9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1323F219F0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561608; cv=none; b=IXzG9OoiZvP+x8oQ1JHM/WkMbvQju/SlMykdtZMy2LHJwwC1hCJZJ3E3WtNmnJr9NcrJy7c3DXuL+pNv2EMu8/Zg3qJh/ucxrpdWpypBrofr6s1tJoWYBzaYiqqr+U+8Virzxvk88MdGslnYdefPaSBQ5r6kox0cgs1TFJvG3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561608; c=relaxed/simple;
	bh=Ni7HvNm5U0I3Dy8ia12IlwiVKh7s5+qpbpTyHOdBxQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc7RN2KfEXP3VT6himGKCJUdRJrX1qBA3QwmorM4W5tEGgvBcOeQLipYaicQqyy4N21RHTZwgIRFgJizdRmRSvJ+nNhzZNnYYCxZDKVnCQmPscinbR+scViO/v7IgrCRL1Zfp9yXN7Gzto+CXG812ldSkDcRr7qWHTr9psnNomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0U7uAH9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712561605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1ekjaOH/ZVs1uSejqLbBkJhchKKbAwLuZOoQubtwZA=;
	b=H0U7uAH9gUwv6vCAM88dYFHoAsbNKqFHDLyjhCppSD1gvfjlSMU/DdTYpGneCEDCW3nW/G
	1ZEVT1no5FUo4eWQ15m6f9H69OKvCjR/tc/iRp+KrBHbA9uO2VxhGaA1QVC/qfsgfPJmy2
	XfpQxP5j40cXuHEebrlWnLuQDl/4YhE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-aDGwmsp_Pt-GwRrMRYWCYg-1; Mon, 08 Apr 2024 03:33:24 -0400
X-MC-Unique: aDGwmsp_Pt-GwRrMRYWCYg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41663c713b7so3657955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712561603; x=1713166403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1ekjaOH/ZVs1uSejqLbBkJhchKKbAwLuZOoQubtwZA=;
        b=FvENA3GXM7gmYxU5/RKYB/0X+RmFLZReYdI256zlAqwH5W7oKxnt3wgw/anX1EliBA
         Z1+YVjgGqapcRI6e2HeRgaUpenI5DyN4gM1s5pJt2xwp8eg9vLSwkpxfPnzRtBeSiLaN
         Wgp2gFFJh0wQ7jkrQIyafOnVuLPZ8/vaoP+qQ68RcJ7axrqVsHD4dN0whyMwTTqXu0HB
         KGrPtWkjW/NhXhiO6XYWt4UM0DkhAzxzxhHa+yUt4juDt3FYr0qSovUcSZbvCC+dxaoV
         S+/LUksjgNwiQTJzYd7ZQxJXczhKIg+75Ju1f8SF6xD98opzl4S7w0tDQZ3/Meg+4Ae0
         4WBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7GcCdimuLuWlH/G+wWZ9/AtVLj5ekjo0rLcuwAln9ypkZ6ut7WrngXaaMVO4OKYUkhxcmfsF/UUQ6wChoyU3pXqpVApxWueyPwkEj
X-Gm-Message-State: AOJu0YxhzKO/0VZDqpZ+ZarJRhlP/q6DhwvERMtLwNk/Gxh++8FgsYy8
	c4CyPk87C+TCH6+jEj43Vp+zElCPYbGD/WVF8u78ywIfKrWSKCuCaesps2ZGs6vnacnQnwf/+8B
	bY12m9zypJYzc79RVgXsGqGKkk4kijPyOdZ6Ypl5Zk/aIA1bmzGRaGpL97hLGlg==
X-Received: by 2002:a05:600c:450d:b0:416:389d:a4b6 with SMTP id t13-20020a05600c450d00b00416389da4b6mr5091677wmo.12.1712561603390;
        Mon, 08 Apr 2024 00:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/SGjudmzbcPixdO5UefgKZZdV+4wdtz6qX0cmlw84R4F3NMtGUXyrFS0IXMbUAGBX/Ln24g==
X-Received: by 2002:a05:600c:450d:b0:416:389d:a4b6 with SMTP id t13-20020a05600c450d00b00416389da4b6mr5091642wmo.12.1712561602800;
        Mon, 08 Apr 2024 00:33:22 -0700 (PDT)
Received: from redhat.com ([2.52.152.188])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c35d300b004163345d2b4sm9448357wmq.36.2024.04.08.00.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:33:22 -0700 (PDT)
Date: Mon, 8 Apr 2024 03:33:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
	stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
	yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240408033143-mutt-send-email-mst@kernel.org>
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
 <20240328052814-mutt-send-email-mst@kernel.org>
 <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
 <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41d65de-dc43-45f6-ba6c-ae722fbb70a8@redhat.com>

On Mon, Apr 08, 2024 at 02:15:24PM +1000, Gavin Shan wrote:
> Hi Michael,
> 
> On 3/30/24 19:02, Gavin Shan wrote:
> > On 3/28/24 19:31, Michael S. Tsirkin wrote:
> > > On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
> > > > All the callers of vhost_get_avail_idx() are concerned to the memory
> > > > barrier, imposed by smp_rmb() to ensure the order of the available
> > > > ring entry read and avail_idx read.
> > > > 
> > > > Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> > > > the avail_idx is advanced. With it, the callers needn't to worry
> > > > about the memory barrier.
> > > > 
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > 
> > > Previous patches are ok. This one I feel needs more work -
> > > first more code such as sanity checking should go into
> > > this function, second there's actually a difference
> > > between comparing to last_avail_idx and just comparing
> > > to the previous value of avail_idx.
> > > I will pick patches 1-2 and post a cleanup on top so you can
> > > take a look, ok?
> > > 
> > 
> > Thanks, Michael. It's fine to me.
> > 
> 
> A kindly ping.
> 
> If it's ok to you, could you please merge PATCH[1-2]? Our downstream
> 9.4 need the fixes, especially for NVidia's grace-hopper and grace-grace
> platforms.
> 
> For PATCH[3], I also can help with the improvement if you don't have time
> for it. Please let me know.
> 
> Thanks,
> Gavin

The thing to do is basically diff with the patch I wrote :)
We can also do a bit more cleanups on top of *that*, like unifying
error handling.

-- 
MST


