Return-Path: <linux-kernel+bounces-100704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826B3879C33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282001F24968
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692414264C;
	Tue, 12 Mar 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b="RUE5oF9v"
Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1D713E7C7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271190; cv=none; b=qRlSu4D9LVuchVRXeDD3rkAIUt1q37jyM+SWReDUG/i0ex1ySdR2NMKcBkwdT+cnwtZVSpwxBkWPD7wQUsaEPL7CHvtdQzPr51tdfzWMih9e/YQhT8TaUdsPLoAwHzIUtUftk8G2JDcU1p5o1+a+puQc6KLsB1Nxj0EG0ykHTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271190; c=relaxed/simple;
	bh=11OvWtOFVZRffgirsvb1zupDwPimkc32RHn7MZAY8L4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aQzJpVFOKm9DhyO/MMDRoZaqC/Dh5SiyPZb/KWKZRXMj+c7vY0iFM+iVXkJvGgu80E+Dl2Gwvca5OFQz/CVfHZu1mROiNS3RYEr0hf6IpErcwNoJEzGvh/BZeYZV6IdZIepHCiz8C6T51fcfiVCH0nIqA9b9bHe0TvZY40bnVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi; spf=pass smtp.mailfrom=kolumbus.fi; dkim=pass (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b=RUE5oF9v; arc=none smtp.client-ip=62.142.5.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kolumbus.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolumbus.fi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kolumbus.fi; s=elisa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:feedback-id:from:to:cc:reply-to:subject:date:
	 in-reply-to:references:list-archive:list-subscribe:list-unsubscribe:
	 content-type:content-transfer-encoding:message-id;
	bh=2UMWdXsaK65XnO3iND/GwA8mm3VFbXYhEHiKEGQDhIk=;
	b=RUE5oF9vGAkWIqEQCfQGsIrBHUA4+iDPEEoXjTpFBBL0oWTlMlMRJ6DlMVdutVjtygBbKWTPtLxM+
	 m+vUbnoHXGg4q/kVn+9V5XRgK+iKoSM7Kao9wdLcoACyY9kwajrIbFpl6fMndA2j+Z9gwqUUFjMrCm
	 DZRn746E/7KYLFZHyYfu8hhq66a62pIX0h5pMmXXCfOu+5EUDc/aziEvX7dc3OysoT26u0xjcv9ppf
	 2++N5dumzXpSmQ8+XRneOzGChgalYczmocmOwtoDEcuGFIEzAg0t5Sty+oi2cJQHEHQvNmkR4c6Gf7
	 nQLAzReT9kj8W/aaQwTYMnEdeynaZcA==
Feedback-ID: 5c3835a5:4c8f1b:elisa
Received: from smtpclient.apple (85-156-116-237.elisa-laajakaista.fi [85.156.116.237])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTPSA
	id 53a189ad-e0a5-11ee-abf4-005056bdd08f;
	Tue, 12 Mar 2024 21:18:37 +0200 (EET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [drivers/scsi] Question about `st_setup`
From: =?utf-8?B?IkthaSBNw6RraXNhcmEgKEtvbHVtYnVzKSI=?= <kai.makisara@kolumbus.fi>
In-Reply-To: <CALGdzuoubbra4xKOJcsyThdk5Y1BrAmZs==wbqjbkAgmKS39Aw@mail.gmail.com>
Date: Tue, 12 Mar 2024 21:18:26 +0200
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Zijie Zhao <zzjas98@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <A452650A-330D-4591-B687-3654DE6CF40F@kolumbus.fi>
References: <CALGdzuoubbra4xKOJcsyThdk5Y1BrAmZs==wbqjbkAgmKS39Aw@mail.gmail.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 12. Mar 2024, at 16.43, Chenyuan Yang <chenyuan0y@gmail.com> wrote:
> 
> Dear Linux Developers for SCSI Driver,
> 
> We are curious about the functionality of `st_setup`
> (https://elixir.bootlin.com/linux/latest/source/drivers/scsi/st.c#L4102).
> 
> ```
> static int __init st_setup(char *str)
> {
>  int i, len, ints[5];
>  char *stp;
> 
>  stp = get_options(str, ARRAY_SIZE(ints), ints);
> 
>  if (ints[0] > 0) {
>    for (i = 0; i < ints[0] && i < ARRAY_SIZE(parms); i++)
>    if (parms[i].val)
>      *parms[i].val = ints[i + 1];
>  }
>  ...
> }
> ```
> 
> For this function, we are trying to understand how it works but not
> sure whether it would be an out-of-bound read.
> 
> The length of both `ints` and `parms` is 5 (the latterdefined at
> https://elixir.bootlin.com/linux/latest/source/drivers/scsi/st.c#L125).
> Thus, when `ints[0]` is 5, we could assign `ints[5]`
> (out-of-bound-read) to `parms[4].val`. Based on our understanding of
> the `get_options` function
> (https://elixir.bootlin.com/linux/latest/source/lib/cmdline.c#L107),
> it could be possible that `ints[0] == 5`, where the first element of
> `ints` indicates the number of parsed options. Hence, it is possible
> to do
> a out-of-bound read once `debug_flag` is enabled (to pass `if
> (parms[i].val)`).
> 
I think your analysis is correct and there is a bug.


> Please correct us if we miss some key prerequisites for this function
> or the data structure.
> Thanks in advance!
> 
> Based on our understanding, the possible fix could be
> ```
> int i, len, ints[6];
> ```
> which allocates `len(parms) + 1` for `ints`.

Yes, this would fix the bug. However, it might be better to define
size of ints[] as ARRAY_SIZE(parms)+1 to connect the size directly
to the definition of parameters.

(The bug applies to the case where st is compiled into the kernel
and a list of integers is used to define the options. Not a common
case, but a bug should be fixed.)

Thanks,
Kai


