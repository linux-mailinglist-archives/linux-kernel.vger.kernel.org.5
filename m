Return-Path: <linux-kernel+bounces-162480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C2F8B5BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CED8B2645D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781E80603;
	Mon, 29 Apr 2024 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SmVtEDzt"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3680022
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401987; cv=none; b=esBVaaAsgzbtt/vLvkT8cN7DtWmqLE6NPji3oj1Q4sZFXqhW0aJTYPJMHAkLsio3Jt6kxt4fN/NVWkhIVkwB+sg5BdHGNoXvNPSAqfN78QgxsQkulvZpw2+SBWFm7xoSEmXggsVMIa/9YXBRAj9jRRmqZXXqqcaN8M7q7S0nKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401987; c=relaxed/simple;
	bh=7ffg10nGRai65DzA6Sm+DBPvuVwQZ6AScKW/4TvgHFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4FyxNy8jrHRGTJc22UIin7VD0HHPsYzgS9KNzZrYjVg7uA7UaaQae0+8clADP9QPNRpS+lUdnv8HCK/ud6R+/wLJB5oPYoEPkIof3boVLske0OeNWfRNPFDgb9tf8+dPgHXLeMi3wryi0lKfuyZoV2dGqn8zTYC1jrhLTsiIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SmVtEDzt; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c8641b41e7so807469b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714401985; x=1715006785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PL6tZzyAQb/T1bd4KCzi312ESM92EvfA0363dcOQhRE=;
        b=SmVtEDztMGKiJha93yc3YzWgOimowBu5KUyLGBxxDTLWJqPXUofvnlaadzFiaJCRby
         i+0vD3qO18KYmzKrCRS8U33f1TJ8JxZ+jtkNbvDS2fgngM1BoPdhZ60Yz8VJID/YsgUK
         t73vSALFj0ZuJBn0UxxtKERyn9nzXuRs23ajZx+9Ok3MIVEPxo+S8NmG9+tG9sDJe5Ht
         5r44OzK2qilLvtef3lR9W3DXENwSQQpuA67arusaR4sUGOHXKqezz2rzdIDRdYhuSa2I
         lS2v5dsf6A0zeiZ1GsubbwLJy2ncGfhXEDrHMiy2MxKRZL7EV0OXF+ZHpYVh9gK1I4dR
         +djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714401985; x=1715006785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PL6tZzyAQb/T1bd4KCzi312ESM92EvfA0363dcOQhRE=;
        b=lvA1vPaA4cu9U/8QnvA48b5BTIjwGe9nCPwEwTp2Jv1EyRmZ5xnNYdsSjklHR1nf7W
         AvekSNITG81koGTdCcmJgubaQKfos/B5YXY1lFuF5H8BWbXeKK/v63jhGNNOpFYcPnQE
         AHdwsZlPmF07etCD7/2QixxjTChQaltB8jPhMQqnbEOKDi7OBgWM4TbASQZk3EA3UVGl
         LlZuHU/rqQJJPck5+BrW9ujE+IIvkXH0LcvwwjYSXb+GjI/YOhKyZZZRc9sj2V6P71XE
         k0z8e+wi1xt/fZoieLgTo72IpI4mR2eadCvS//lxn0m227aIJk5uBcfEYRpxXT/D7u7r
         1/kg==
X-Forwarded-Encrypted: i=1; AJvYcCWmX0aJvK9Hgu/Gbvq6lyfgn5keEe13yShmlnOoXBJLC14KjeQtj5MueWCFVhIk7xvHK1EKkmUg7ll6GJfMQ2MDPsqt81E9gx1JEeB6
X-Gm-Message-State: AOJu0Yz0W9UWXGSqxw7EwAWVzMWuGG3u3i5eN3xNK9S12rmd6qEY49+G
	5FPwFMMQdra82UfLbC/vseCmN3x3LI6PAHoQaZFOv4gKJlWo1hxl+u1gzIxno7s=
X-Google-Smtp-Source: AGHT+IFOe6gG5Zd5JVe9dZoFq+NoColD5kYFlBUlxnFkxrkFHFXSMMmhpY3dNxMYFJzSXNRqXqK1iQ==
X-Received: by 2002:a54:408f:0:b0:3c7:45db:3ad2 with SMTP id i15-20020a54408f000000b003c745db3ad2mr31396oii.16.1714401985232;
        Mon, 29 Apr 2024 07:46:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mi23-20020a056214559700b0069b4cc9780fsm3071361qvb.2.2024.04.29.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:46:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s1SGt-001ToN-OO;
	Mon, 29 Apr 2024 11:46:23 -0300
Date: Mon, 29 Apr 2024 11:46:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rientjes@google.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev
Subject: Re: [RFC v2 0/3] iommu/intel: Free empty page tables on unmaps
Message-ID: <20240429144623.GN231144@ziepe.ca>
References: <20240426034323.417219-1-pasha.tatashin@soleen.com>
 <2daf168e-e2b2-4b19-9b39-d58b358c8cd9@redhat.com>
 <CA+CK2bC4SWTCG2bnA16Xe+gX7=N=UYWB1wSns-K-jNqC1yrdvQ@mail.gmail.com>
 <9bf62e97-dfdd-4537-8fb0-b5f293856f59@redhat.com>
 <ZiwC4snk03ptUQij@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiwC4snk03ptUQij@casper.infradead.org>

On Fri, Apr 26, 2024 at 08:39:14PM +0100, Matthew Wilcox wrote:

> I think there's a lot of space in the struct page that can be used.
> These are iommu page tables, not cpu page tables, so things are a bit
> different for them.  But should they be converted to use ptdesc?  Maybe!

Definately! Someday we will need more stuff in here..

Jason

