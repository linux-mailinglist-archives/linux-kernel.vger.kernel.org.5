Return-Path: <linux-kernel+bounces-117782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB488B2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BE3B2F5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE61DA26;
	Mon, 25 Mar 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrDsaNBc"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8621C6A6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393982; cv=none; b=K5wqb3H8F5Kgm8V8ZFg3vudPL4EHYi3Cxkh5SNvKMJOrYihuNNhe9f1WtYyWqLDuR3OO+C0IKg2GMIvma1JLotANBM/7ztHc5rT8of3nHPVOgmAWYc6Ld0AIrvoLfwdot3TvkdEUoOEHwfCBQYx4eE9i5CTT+/bdXGaMkZMrdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393982; c=relaxed/simple;
	bh=Pf3baqpiL9CXyAtyMt3CMQfMAERbePVnSfK8M1AeWVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W83+7msVTUarNyF6OunacGIaHxEIQslHBZnPZ5mb/cK0T0f3oGfEyjx9zgQjReEuh9+1JY7MHMVZy2wpobVgaXzZ0k3wCdOPJw1OjrddVPFHVzNvfRdRMZBCQ5fff8IgcTC+4Sbv+m/U3MBil2mnf9GgXip5vNzabOhXQLQRzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrDsaNBc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so3535901b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393980; x=1711998780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZWicdVUiBTASAelQCcZRo5ucY/Bs7Wqk40aLTSkBtQ=;
        b=YrDsaNBcienkPfMKiVbQMswU6WlkFtMev2v8h5bCncrbcO70Qq6lksLJAfi9L/ma0T
         Qo9BMkuk2vCcNo35M0atqb7I6bdElEava6Kb1P3t5sJGzANktL9G0bzid5uc6hkt7oHx
         5mebB+vsRMPF3pFT+DVwsRTKNyJgUA6CdJRh/Dtj/2uJJg1bsBhI5d15faAyRkqUUyCp
         rkE52q1mSkDu8TzHNxipqr5wAgxgsasxgCq5l7MDPqgXYFOTAZ1ML0lBCp2CkUq0y9QY
         5YYf0XiELicNUA4P6GkDLCPLB0t85EYceTYfTVAxbcDmjcl5RhWfe+AEBVLs/8vzfmNA
         9iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393980; x=1711998780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZWicdVUiBTASAelQCcZRo5ucY/Bs7Wqk40aLTSkBtQ=;
        b=uwvb25Jh8Qq8/PspVeeP1CxIEKRjUfOH1DcLLmKkUwXhWSzWlsEix7j0GX0OVhpR88
         tRYxlpbz1ZvFqKg6zICNdd/Ihy++9ohB5/P9lLtGundgf7T53tVJ7tU+amVQOXOC3QM5
         3cCh2vma/GYfCeyxvtGE9kMdt/9mfa9yEALregUJG6bXthu9MdRBrhJXH+q+NOb62PqZ
         uk11NUcYLY5zFWsPExiCg3JyH/qi8dr9708Yd0KzYbFKUaGRfIFF7uT/aEonJB6Bxx1w
         HNglFNt0uzXLn6Wb9U6y+6EKAqoHkQ6t9b1EnNKwx0v1KfB9/4B7Hj/7Hs57kCiVX643
         bs/w==
X-Gm-Message-State: AOJu0YwM65j6ILucF07IQaKIc888Qtbajt6H8rQGXTq3bX/3Nj4ypzFR
	pPZUKYJbBCxFBvGR3lTd+HrfzJgJ4efgNEShPesjkZ9iyyF05h7I
X-Google-Smtp-Source: AGHT+IH9tTozYXgAYXGEHEHURYPnQvOD0afXIzRkCYSwi6YVEQC2v562yUrF9seItqOWeaIdCkhkMA==
X-Received: by 2002:a05:6a21:339a:b0:1a3:aaea:a45b with SMTP id yy26-20020a056a21339a00b001a3aaeaa45bmr10352138pzb.39.1711393980246;
        Mon, 25 Mar 2024 12:13:00 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001db5ca97817sm5019247plg.68.2024.03.25.12.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:12:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 09:12:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH 4/4] workqueue: Use list_last_entry() to get the last
 idle worker
Message-ID: <ZgHMulIbpKt2qHWL@slm.duckdns.org>
References: <20240308094253.2104-1-jiangshanlai@gmail.com>
 <20240308094253.2104-5-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308094253.2104-5-jiangshanlai@gmail.com>

On Fri, Mar 08, 2024 at 05:42:53PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> It is clearer than open code.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Applied to wq/for-6.10.

Thanks.

-- 
tejun

