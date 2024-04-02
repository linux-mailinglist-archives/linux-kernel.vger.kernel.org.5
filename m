Return-Path: <linux-kernel+bounces-128392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77764895A49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BDADB27ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3194515A499;
	Tue,  2 Apr 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mV0rh8a0"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99362AD1E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076608; cv=none; b=mkkqdx4RPjb7/Wkq0Tug5fkwJ1qP6Of1rZeiLnE/PAcVcWujBedUIhJwUbvrMmOcHiOiOPTlF+AbR/mGWG5jA5a2uplnkGnnVtPnliY7szRFoWg+usRg9vs9f3q/NNjEcm9vx5Y7f47nq0Fddg8DgRHK5xeM30GySSwEU6pGGRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076608; c=relaxed/simple;
	bh=a5VC7rpVvraZunv6Dwst6lVP7+CUM4jij1XoG9GZ/Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBnVY2IQAU2N8H02e/Miq4mEATm79G287/rB0re0bwN5xejoBmblOmPzTaxmjaUKccBPB3p8/cd89y6bvu2yUrztXkCJ1HHke6Cz0cYsUr5Mo2Z/0Ov7e1M55mcFmvDWco534P+ZJkaU1yj0IyA0CAUzfsXJL+27t9jnp+e9RVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mV0rh8a0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4a387ff7acso655645566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712076605; x=1712681405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odERAu60Ug6RsmH7NPCr90WTw8RZSM0Nag43RhUfhM8=;
        b=mV0rh8a0avUBKzIkJwQ2i6tMq4+xbfipBpivRCmd0g9en6q0TUMUyRCxx5L76u+98H
         pWJiT7zIP4KifONIV2gRTlrIYYeBhhPtQtNVGEf5LYaGR1QxvwTJHpB1IJ4IF6ymuuZM
         qM4FsuaLmxMEMhO0Fa5cGcVsFSJ3bfaTvFrnEOoyCExa7C/IYQK/C1gWI4v8okhhT+/A
         l5vSjPCnSYdci62jv8EU+wLtuxdx7SWNa/ZcG4I0eiEt3z/DLt4xYeAJvXkyDezqoZgX
         pkGhcqsD0zD5HPRmjb1ShxJ63XejiZHOdsPzIrxEPLH5iPuhG4BVgthnv8H9CvkXIePi
         Ojmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076605; x=1712681405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odERAu60Ug6RsmH7NPCr90WTw8RZSM0Nag43RhUfhM8=;
        b=bgnKRQENJJCjuveioTj5GdVLT5gS1C4AQ75SunZUuAr68gdt+9Q5nX7V5ywlIjGQ6h
         jtqtVdJ/ldoTzZpY0AJdfpJTYrsH6MiQowu+iVtjitLh3sRHXkePoA/EZJLXEcIxFmQ8
         xA7SV22DHv6iHxRRigpwlA1AflgaRI9rYvQEI8q3A/9Zt9o5RVHT6CHbnAsRusB123Hi
         RqFhYFNXpR6WCogzv+uhgzqiJdxgHSG/3GOfkVkFigNZ7hpZc6ktQC+JpykbU9nPpvFz
         jjHe8eXYZd6TMVVUoCj/QAiBH6jlRAh12GI1Q7zEPoq+NHIyoUv7c9iobfCabC49muyC
         WNkw==
X-Forwarded-Encrypted: i=1; AJvYcCUh14tU5k4IuRvKIjhDp72d6BAI/i82Cx/LAHdiNSsk2MUmLAHgEcV27+o1cicJvrKE5JrPRGey9L2JD+/AmlOjrIcLzyBmeh2rwqsx
X-Gm-Message-State: AOJu0YzPlJ8cZgvZ1hpUznuI2Q2SSfV+LucV0G/xhS2nSD76wXCDztkH
	321Ptti7f20YlAf+PsC6Hl/I6C6Lvx0xGXtnyQF8OrBfa5Cx/fbOs8dpeNw3nVc=
X-Google-Smtp-Source: AGHT+IH8OA9pcpehly5awaPgXOENbA8rXra2anS24UXloU1zSe9/5QM+mSIWTveOmI1kpt9iwyCeJg==
X-Received: by 2002:a17:906:39c2:b0:a4e:7f22:cfc2 with SMTP id i2-20020a17090639c200b00a4e7f22cfc2mr233199eje.28.1712076604896;
        Tue, 02 Apr 2024 09:50:04 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bn1-20020a170907268100b00a4e6750a358sm2897610ejc.187.2024.04.02.09.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:50:04 -0700 (PDT)
Date: Tue, 2 Apr 2024 19:50:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	felixkimbu1@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] staging: pi433: Rename return value from "status"
 to "ret".
Message-ID: <1f1572b9-9b0f-45b4-94ec-7f79467a7205@moroto.mountain>
References: <20240402111414.871089-1-ikobh7@gmail.com>
 <20240402111414.871089-7-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402111414.871089-7-ikobh7@gmail.com>

On Tue, Apr 02, 2024 at 02:14:14PM +0300, Shahar Avidar wrote:
> Drivers init functions usually use either "ret" or "rc" naming their
> return variable.
> 

status is also fine.  Just leave this as-is probably.

regards,
dan carpenter


