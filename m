Return-Path: <linux-kernel+bounces-112041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610DA887480
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D1E1F22799
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BE08060E;
	Fri, 22 Mar 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA255Q+k"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DA07F483
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143693; cv=none; b=NGudzVVubdrr+W6UGQZsem+re+/xt9qLeVH3VZgs21PZ0BjpQrR6fU/BmaS/kqMuFVAgW33bRp5ytc85CD66VOgoRiu1qHQgyW5OjwcIHGTnezZsfosYwPN9Chv6vL9Go5T6lTMURz1HaFA+TO4rp8UbueMVEwwCyPP3raic1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143693; c=relaxed/simple;
	bh=JRn1NuNP7U6YtaqPT6ImHvBN3AeUHhggtDcKgrMvIj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG0VESMSCEukkRMLj95sGpDJSrN3y2C7jAp5SKF9srmpdpCbCf/9oJ7lO9JmC99U3rYUSZUca+wh56sCNh2z4ztuMP+W0IUGd3yD20zEOnp3au2VV/TN2w7q078oVIi0pin/NLXFZ0eatiDGCyAW06uTrKiDYv7/PZDTNn1gpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA255Q+k; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e01c38f98cso16643035ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711143691; x=1711748491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/qQVgzKtnZ6yVXAlT9wbTl7bYZK0GrvdvhqcAfhj7w=;
        b=eA255Q+k+k3ldk5vTw/J4jmhbaV1U92+aoFmyDe4BE5/hVxcYsxHafTd91oVBfbJEE
         1FYPRfvee8fZGMQ144wHCzcxgvE1QvX1XmVAfYq0Ky7GcTmGo9oXc9Cdj8w84RqRTlGv
         Qs1mLB64hNOiJeFDgs5b+N0MVZ/Vql0TfU3y7exWwSHaXjxwn8ZmSHcZrotkHynJzGP8
         qT8XmUE9yFzH8qirTviqdH2G+jcmhs6dNkV/NrcgGN+kCqj3iTZ+PFJvYY/p8asMS5iU
         hJv0gGRXn/8gbYWQlurap+NLrirlxvbKXLcPz2bgveDscJrJWaBmkVwB0KPrID0mliyL
         V9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711143691; x=1711748491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/qQVgzKtnZ6yVXAlT9wbTl7bYZK0GrvdvhqcAfhj7w=;
        b=Uf54gZp9kXRlzjzS0hMzxsort1oSo67hj8aAlx1Mjc+Ftb6zf3mx7Y5vkIvq+W/0GD
         fx1Mm2mR5wKz87Ew/WGmzfI3EjSzxFI8InDjtsi3qiMoEMy3FlDznFbMG7fCBWoly2nU
         Tn4VnXE0tgiFldGj0ZQuG8LT9mR8R6kNaO8Kr9Wa/YWpXpAU4MJ8tQRTLVCHL6Y7unTw
         C4O4tSSG5oEIjZQlBs9HX3zS7CXF8QRdhHI+X6i16qdgpBJyzjC6ZJ6PgyxROGbCyKnB
         MDT2R4sVh/V8FbTwAOd8fZtl4MNO2XqEaq0Pyl1m87abHJogmABIpjcIsaQ2Bn02atOr
         7EZw==
X-Gm-Message-State: AOJu0Yy0x0c5TkCc61dzt4tr0g3ejx/fE5a898WTmEJcgGjB6AhUxHOO
	vhyeOaz6fbwxz49NE096rQU3ro0DCpsssF8w/KvPt6Tn0mncCLvv
X-Google-Smtp-Source: AGHT+IF7PurDu/X1uIB1GZTuiW9PPG4QkeR7Dv4GGfeuMEZ+Uh5VIvZ4OrGB55eO8J/3YfoMGD3QCA==
X-Received: by 2002:a17:902:ed46:b0:1e0:16ca:422d with SMTP id y6-20020a170902ed4600b001e016ca422dmr1028435plb.53.1711143691284;
        Fri, 22 Mar 2024 14:41:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902d5cd00b001dd744f97d0sm205748plh.273.2024.03.22.14.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:41:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Mar 2024 14:41:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 3/4] x86/topology: Handle the !APIC case gracefully
Message-ID: <69c8e34b-1297-47fe-8f24-b74bf82714b1@roeck-us.net>
References: <20240322184944.141421692@linutronix.de>
 <20240322185305.242709302@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322185305.242709302@linutronix.de>

On Fri, Mar 22, 2024 at 07:56:38PM +0100, Thomas Gleixner wrote:
> If there is no local APIC enumerated and registered then the topology
> bitmaps are empty. Therefore topology_init_possible_cpus() will die with a
> division by zero exception.
> 
> Prevent this by registering a fake APIC id to populate the topology
> bitmap. This also allows to use all topology query interfaces
> unconditionally. It does not affect the actual APIC code because either the
> local APIC address was not registered or no local APIC could be detected.
> 
> Fixes: f1f758a80516 ("x86/topology: Add a mechanism to track topology via APIC IDs")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

