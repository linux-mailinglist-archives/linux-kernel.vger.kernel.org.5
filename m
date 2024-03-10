Return-Path: <linux-kernel+bounces-98163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D62D8775E6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38E21F22549
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33C81DDD6;
	Sun, 10 Mar 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSWi1DhI"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC82633FE;
	Sun, 10 Mar 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710060866; cv=none; b=pkMxsVbkR8tCZaJEl31RgH3WuIDW9+BMQ9fsE6EFJM4KpdAwmBvTtTBwchmFJF64/VjZ1jUUgDBApXgMPwah9+TtrUS1Cok34WHBBCafhNgb12jFWNmkPvTtaS/h59Q3YzBJV1n97PeH3JdnnezfMJT51oV+7xFku4/L95shs7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710060866; c=relaxed/simple;
	bh=KB4Zv3BC8DftspKQqdE5wd50UdwEPrwTsA3NxL6cUFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecf3MrJCNa7XDWgY+rPnUWzi61dbIc/aaXKFPmYFGotzRH9beNO9I1dz7sEj7jkhKeOAfivli5NBnh3B/ixugvvawlsX0UEIKfjy/Aw1NgboESk2HZAKYpKKhzY5MhX8OsX1GuEKGG1tihviQGffm7D8bpsPFQkUUEtwEcMmYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSWi1DhI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e7a109a7dso526731f8f.0;
        Sun, 10 Mar 2024 00:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710060863; x=1710665663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaNv/cH5pcXfLKx3G88KIeQrKhEm2jihXS83oIwf6QE=;
        b=KSWi1DhIaWjKTpND0GBytIr84udn5tTlXYlhp20Mot3B2KmRoLP4lvpqiSvciWtbaI
         uCWmjPmPE6SAvDpiwiQjc8c7LZNI5Y4HQZDAw9iP85zg8S0SrXRq+prYcTPLT7jHZw4l
         lv+vcEC77aFxaAfNAaNO/E91K9FaHVLWg05WFfTkdG+icMSlU3eIsNF9SE0b10te2SEC
         tAHSnwLoDpoaXiuxVrBw9ZOmt0L5PLSBfztsQEgz4OCPOhL1W3kbaRMwK1LO3N5fm4Xj
         ia2Kz9CGTP6AHunpAsdw0MnRflUstkFDSMKKvC60W+i9MJrYUBuJmvKcoYEDX4AlEHGP
         U2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710060863; x=1710665663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaNv/cH5pcXfLKx3G88KIeQrKhEm2jihXS83oIwf6QE=;
        b=Aed3i5xX3NRildwLb7oKr/zVt3dkfwNfxvoxTv8DUtN6aLt4bN5XPS9yywcZRQ2fx9
         1jZxWr26Cn+6vM07gtaRkVms83zmmyj6B8RjJLG1Cbb1knwu5Ap6KzTg/MLJK3JxpU5g
         +ivg1F/IBtlRjjXgZJh4c/Gpe1qbBGCOyRgUgxyizjOtIKOobMf9VfBSGpsA/71w9Mr1
         27IqLYd6wurZxV6ETG5FGLr0eEs9iRWFAh1H3qeeYMOML71lF7su1Hsk2+rB5kewbhXN
         hzehprPbbxcbkCpXa/kxmP4vyZDIUOPbPQnQPqXf46CN6inboHoWyFn9S9hfMYCWWGK1
         LFXA==
X-Forwarded-Encrypted: i=1; AJvYcCWzbthss71OYBbbAZIyPQbf5giOG2eCMN1uYnjvoPuDdeztiexjjb1+YiAeiWiZqagCEKwc3io3QpsgbCw0SjhBRKGdXlL4F/KPW1dR1Nxc3HXbEV3x4XRoQ5tcvMqRWBIpmFLAdNmZdo+S60Q=
X-Gm-Message-State: AOJu0YzEXpjA0BnoMjdheQ4btMZVLj0w1gs0TVSr5vgyzHHi04axDHgg
	YUPQfHyi6uOO4m+G3KL6JbmI5ZClyWm0qVlPIzcGALJt6HAUg2cWeabi0EYMOcLDiw==
X-Google-Smtp-Source: AGHT+IEyFzmX44iqGW7fkcPSwUL9x1M5qSYCSyfLz7R1FbkJMYP2oEDUveuY3N7uxSreQkdVIBpuuQ==
X-Received: by 2002:a5d:4fcc:0:b0:33d:be93:5021 with SMTP id h12-20020a5d4fcc000000b0033dbe935021mr2555657wrw.58.1710060862720;
        Sun, 10 Mar 2024 00:54:22 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id q25-20020adfab19000000b0033e45930f35sm3653515wrc.6.2024.03.10.00.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 00:54:21 -0800 (PST)
Date: Sun, 10 Mar 2024 08:54:20 +0000
From: Stafford Horne <shorne@gmail.com>
To: Dawei Li <set_pte_at@outlook.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: Use asm-generic's version of fix_to_virt() &
 virt_to_fix()
Message-ID: <Ze11PL6CILWUWlqw@antec>
References: <TY3P286MB35670C95140EEC4DD181AEE4CA262@TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB35670C95140EEC4DD181AEE4CA262@TY3P286MB3567.JPNP286.PROD.OUTLOOK.COM>

On Sat, Mar 09, 2024 at 06:24:07PM +0800, Dawei Li wrote:
> Openrisc's implementation of fix_to_virt() & virt_to_fix() share same
> functionality with ones of asm generic.
> 
> Plus, generic version of fix_to_virt() can trap invalid index at compile
> time.
> 
> Thus, Replace the arch-specific implementations with asm generic's ones.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>

Thanks, I have reviewed and tested this and it looks good.

I will queue for the next merge window.

-Stafford 

