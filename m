Return-Path: <linux-kernel+bounces-29716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2A9831251
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FFE1C216B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84F6FBC;
	Thu, 18 Jan 2024 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ay/mWYLF"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C953A4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705555110; cv=none; b=XSzLCUHJdHEcF2vwDjCiPVZxmza9cOw0iuYnaJnGwj2UkfJOdXiNXx114/TualhbH8l8wZ4qjgJNKe6SWxF/2D14An8gwZt1xZJLOdISJIppaZ0gpM5b66zJvxkcWGJn5iNYYGHBAAqtI6CMjY7MhwUBk07Dmgwp0nmn6VjdyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705555110; c=relaxed/simple;
	bh=g8+ApyBJoF5xUTZW1DkFbJTYFwKi5DHg6LfLSQgmfUY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uyYWX5wzoHzNbQrFIvexNM5+E92H6a94FhmVpkH686EGIKnoH/4APbrfYpxMNhw9LeFQ1dHPEbZgVRpXkcOnZMVx8ZKxunCg6bvSjF++OL1WetrG0B+ZxzLOUTeAC/gVaMmbZa7le7p3yrEtGFBiavKBD4eFoaP+3jyGUNK3fq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ay/mWYLF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337d05b8942so172198f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705555107; x=1706159907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hw9WGdZl+aPz4/jKX094Hfu6nX8oGJA9fRpfx0jLQ50=;
        b=Ay/mWYLF73wDxMio+A9giRJrKCy72j4qJznbj1LPKnxrzxSQ8IB0WYOWLc7BKbqO6S
         TkkP0k/GXS4UM+z4usktQj7akv1XW6jEBN2S54kk8fzcTLLgoUi5JC5GTofXPEgkG+eD
         Q57oVCGxQX+PVUNzcd3k+Y8FSZ8aWt06oIicCHegKrFEcbn+9nJAp21TpRinomzuhO5R
         G7vU4mnvJx122siX/6H57I7ZDWTcQ9hjb3LQJ0ouLmdD497csRgvKQrTTj7NmEBBbIld
         6v1FZceu7dFmTA1B/jFNPOUmDiSHGCkhOugTlHC7ivW+zkV6FC8WSsXPgCG+QnJEwWrO
         8SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705555107; x=1706159907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw9WGdZl+aPz4/jKX094Hfu6nX8oGJA9fRpfx0jLQ50=;
        b=kvIVlYXeMckaAYuvMDmtVgCCqZqVKZKkegesyyIEC5JYCyjgT/9tqCNh+kQBLfTQ+J
         WH56oeZzJQvdrmosXLf4rqvBZu3H5iOj0Hxj7oBXVkl9cgPVzisDn+KMjCs7Oe3CJwXL
         9w24yRi+773HiPKE8gLfWMilj/eWXqRAgIvPhDGA9EKCEnck4ZkdsQQC/tQiMmeZRbBT
         aJfMZmA2FgJDI/sr80ifoMxVm+RHg06lvR6gUmmm50hZAiGC2aRTLcbokMIp3zjHbtPl
         OnsY+rup0mBML+IbX45v+Djghg6MHzA3rfA+LqM7ijR0ZR1wihCJLKFlS+Hd2MI0zL/c
         5afA==
X-Gm-Message-State: AOJu0Yy/ECmxuPN12wPzsvXSSAFTFTuPnbCo0xcR6rs2IPB+IJsYneyD
	Wgg7oIDB+2Y3EuM8f880oKbrwqwmRKHmtMVDVgywypdorDSrq6YaNtvIVJyhG/k=
X-Google-Smtp-Source: AGHT+IEHDTe08VNGP4ymt6YFUNpJRAvw7ARumo+OHR6UoJZQnvx7DinpVjJBD/tVEYXlpZ4D89a1Iw==
X-Received: by 2002:a5d:4607:0:b0:337:8fa0:f4f4 with SMTP id t7-20020a5d4607000000b003378fa0f4f4mr148958wrq.89.1705555106913;
        Wed, 17 Jan 2024 21:18:26 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id h5-20020adf9cc5000000b003368849129dsm3073468wre.15.2024.01.17.21.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 21:18:26 -0800 (PST)
Date: Thu, 18 Jan 2024 08:18:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Subject: Re: [PATCH] coccinelle: semantic patch to check for potential
 struct_size calls
Message-ID: <8860d9a3-ddc9-41a7-a6b2-d1a1a2bb2de6@moroto.mountain>
References: <20230227202428.3657443-1-jacob.e.keller@intel.com>
 <6ee33330-134c-4bdd-a5eb-e8ff0db6cc8b@moroto.mountain>
 <CO1PR11MB508917C85AAD2ADEFFDAA204D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB508917C85AAD2ADEFFDAA204D6722@CO1PR11MB5089.namprd11.prod.outlook.com>

On Wed, Jan 17, 2024 at 09:54:19PM +0000, Keller, Jacob E wrote:
> > drivers/misc/vmw_vmci/vmci_datagram.c
> >    227                          dg_info = kmalloc(sizeof(*dg_info) +
> >    228                                      (size_t) dg->payload_size, GFP_ATOMIC);
> > 
> > The Cocci check is looking specifically for:
> > 
> > 	sizeof(*dg_info) + (sizeof(*dg_info->msg_payload) * dg->payload_size)
> > 
> 
> I think that's a slightly different formulation.
> 

I thought that that was what the check was looking for.  To me it seems
like an unusual way to write it, but it's not buggy and your Coccinelle
script did trigger a warning correctly...  But yeah, I was slightly
puzzled why it would be in this format.

regards,
dan carpenter


