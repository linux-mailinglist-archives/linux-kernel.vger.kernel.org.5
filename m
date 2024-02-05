Return-Path: <linux-kernel+bounces-53151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEEF84A147
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A72B25299
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBE45971;
	Mon,  5 Feb 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxbjCSdT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DFA482C7;
	Mon,  5 Feb 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155275; cv=none; b=XUjEk0T/UZabu7xJT4ZMZNnxNA8JOYuAPwfPIS9YwQMZF8mMW/mgNEU66gjB5b0HA1GKZ9ePRbuvp2u2trTBhUSA3JSLT5j39QMQNbx+QdVFoVnV76l29WMagaeGDNLqmCwCn3QTJBS+cAkGgAXFGzcDMkQ0Zmu+wOHSloMq1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155275; c=relaxed/simple;
	bh=rHc71STkcx8dTZZ6L0OVB6DKHz1LbPEMHMbCsUFfeb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmpBzc+SacNe+5xH9UhU6XYffxchQVpoTHP0NLSufQL+iaCpBNwfOxQ2h9mSAxdfEKnwvJac14jqZEZAalTgZSGichb9pZcWtitntPOS5elPy+LqBfVHgG7sQSOquj/It0w5P930TbrfWRhoGUTZfNlo2E6ubhR86gilRSZ9T/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxbjCSdT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d71cb97937so41535885ad.3;
        Mon, 05 Feb 2024 09:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155273; x=1707760073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raXu6WkHrvYZrU6RUEY0o2T0Q/6ZYXqplw83wU9Efi4=;
        b=DxbjCSdTCn1MSrVH6mWM8fVyyrqQQ/CPrCrPHVjoyGQe2gDf6Iog03D1EdC8b0odWl
         367vfG4LGb3srErVpdOVEx3V6Q7dLXcZmI5ZpCQp4DhZrb6+fZd2pkWkZONGKnoUk+tO
         xLmRps+Vpyduz1C6IgTFoWwSUBmHcApXsHGZo4OKq5jjbH8t9Foep1T9RHjXu/h9YEEU
         LIDS8+y46/k8QibM5QSuA4Dci6mfqGy1HDEK9uwa7446zTEt4M39iPSbyK8GchQ4KNIs
         C93CsU7wLODx7WENPNxzvCU9ERSyA/6blhOGMMcW0WAppFG3KmhMh/dYyfvXg+sZbw1E
         cWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155273; x=1707760073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raXu6WkHrvYZrU6RUEY0o2T0Q/6ZYXqplw83wU9Efi4=;
        b=EHaywGRszS/GHjljuy4L9kIdRWq/raNonZ88AqXVAbal+39BzBTMaKpmHuRMnSAD/B
         SHOYsH1iSMGGlt3r+0JbK8KcOfpXmzTH8YY8otZIEYC7Y8azBYZ1u34RGhOFjShdzoqc
         i2hiQpmlt4rtHgeIFT3dGF8Q8RTitgqzvInlQIoKsWNWhHQCNqIEBsBmdDAZtwzKEkpo
         +BffsNPdQu8cOmGIfSc06Lk6a/3nTC/3FC8LpxOxQF18JQPQ38/GF381RZMLrcQMqCqS
         951HqsOI7kUW2LT4R+SyXJ30lJV/l8Y265JWgGXAdNyk8lONa00sECHZWpiYlHK9k+aI
         MrWw==
X-Gm-Message-State: AOJu0YziULegM1SBG3zzXIUiE94lHrjPKzZ8zxSR7BxzS4AqewJBGF9a
	aPl52tRNWheVARguH2oWqvoJtySuDvlKMikxgpA1e/E8/ZJ/LasPK9wwjr9hB8c=
X-Google-Smtp-Source: AGHT+IF328rN6lIIl3asnb8+T3kzpcVXvn9DuNtIwkPPa6IiqGB8LK2reVrfnB3hEX/ZdJZnY9bkZA==
X-Received: by 2002:a17:902:ea09:b0:1d8:f129:a0bc with SMTP id s9-20020a170902ea0900b001d8f129a0bcmr308878plg.13.1707155273173;
        Mon, 05 Feb 2024 09:47:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5dmLi3jgfeA0R5D0pSfmuxWgT789scJPTMzBGtDDnjCOThoMcfkuUFF9MEAJlU2qlwHWCIX8dgGXbqRW/lniDEM8L9AlfnEPpMv2+5I9HrmHZjQuJdsTheVJL0+KoiN+RUoufdnUdsn1yXRBWUSjbOXQ8Xaa7tUHRQHQYdIC4lGaiOMwSoIqUi3qEL1vOHYbdt6EX8JeqeGnSzeJ02QDFtQ==
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id t21-20020a170902dcd500b001d739667fc3sm133951pll.207.2024.02.05.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:47:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 07:47:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH v3 3/8] workqueue: Implement BH workqueues to eventually
 replace tasklets
Message-ID: <ZcEfRy9GAaODMWAW@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-4-tj@kernel.org>
 <20240205044817.593-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205044817.593-1-hdanton@sina.com>

On Mon, Feb 05, 2024 at 12:48:17PM +0800, Hillf Danton wrote:
> I see no need to exec bh works for 2ms with irq disabled.

The irqs are enabled and locks are released while work items are executing.

Thanks.

-- 
tejun

