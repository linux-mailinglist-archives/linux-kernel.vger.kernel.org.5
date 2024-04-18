Return-Path: <linux-kernel+bounces-150669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E308AA2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C072F1C21143
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4C17BB04;
	Thu, 18 Apr 2024 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M699I2CV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE91EA74;
	Thu, 18 Apr 2024 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713468323; cv=none; b=ji4GKi+jL0V93o+QHoET+HhOBVDH2/K+E7bBUOuhJk6XaxCFybHadrRwnsj60KZCOuRc4sa2ue6jlOLTBNRVE1fW8gvhyrOkjCoXSrw3CuqecQfJTYJX2BzV6RUGTBK4X+Ui0yCu1jXz7oebxukbNRUtoV8hlqwt5e5MpVMRDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713468323; c=relaxed/simple;
	bh=fxAYPQ5unMjiC3b/D75pon+cD7jajBUI2cVC0HSyYWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxda328YYS3+4/yqxPslr2+42qhoBRJvyiw8UXYiK6OJBGyfpsNr1kyeSDy4Q2dNh6ul0UCRVawo6e1sCLErsyd6gSAEMZ3akMw7NcciLNi5hLsst+xqrdxwlZDzub6nl1u3WVXSGxOj+YsFp6rzp2hWNxkqj//pFaFPxHAGyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M699I2CV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3f17c6491so11123015ad.2;
        Thu, 18 Apr 2024 12:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713468321; x=1714073121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrQrE/kYgQ1L49lBGgkxyvXPqLP8osuWL33BSuvzYUg=;
        b=M699I2CVqhAfuncIsuhtRwIUIApbUTk46sQjYsMI0h5y5Q2iSO+eXL2bq/QUU6BQIi
         S5ESK+b4/kYzZTZYiToopqvINbdQ8JCx4uANrwnQXYNe+JJd4AJlhp8gPYfJJwKsd4si
         aY/epujxsK+2mI696fIpFD4xP26n5Vk/PUMzNBc+btgM3sNJnqfh653kOAFV/25q7qi4
         xFDCCr71bKimkvmHUoj9bSjJMIV3aBdY7sOtDpVnlOy8XEFRnNRRyo5+Pz/saE31LgGe
         G2rEwKyGbZy/jyRRwbJPo/W0SygYKa1oe9e101k6uFFQiFAXaMr/NCwXwa+J/EC6YKm+
         OjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713468321; x=1714073121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrQrE/kYgQ1L49lBGgkxyvXPqLP8osuWL33BSuvzYUg=;
        b=eFp/pIvbBxeTB/ij8bM72AOWWrL18Zz4+h0mn5MkfxBhIsJ5q+epXJudTEzQHphW6Z
         Li648dejo45JOJGDJ8jTgT71WdLLR6HxbRJ8RAg5DnbSWsiB50SkWw67lqVE7qkUnb5B
         32VmPKVBjgXg367RTCfAnITYFBjAcK7++CVyDF5ZPAq8M4dk475WAWizvXmmUejNyk50
         NhoGbsJ00IpjbSTi2pUQgU5I0k/A1O8fhihY/XBzzJ6b/yhBymJNAG1iK+ssB7U5zG8p
         6/tu/N/Oo0ICIWIIWLL+rrkLiYvVo/+lAD6uqwJXjF3toZ7PlbGM6+ZPGSr9hPnz7xfy
         He3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG6HzJmnCV1VudhhwY5jikIhyOmqksrTKBnHE2YCoi6/zNnUuww8d5j8wHZUNT5GWVKgEJMgjm+Ld1nFa9jfpJdkhQ0ka9ttcyLTHd
X-Gm-Message-State: AOJu0YzowygWS2dZfYcxdlisFmDKRIlcz5iOb4xqzeSlHw4muM+8eMZw
	1x5tPplKsmwVx9NX2Y6ZZu0+d+RhqOtipGRcm0wAM3WSIW4DbfbV
X-Google-Smtp-Source: AGHT+IF6I29nITXk+r2qyX9hSj+zNX1Wvhjz5adxjbXFGIiZOHJzu1+7IEr0gqooswGwe1xMAaVsGg==
X-Received: by 2002:a17:903:454:b0:1e2:88c9:6c08 with SMTP id iw20-20020a170903045400b001e288c96c08mr30951plb.49.1713468320712;
        Thu, 18 Apr 2024 12:25:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902e34a00b001e49bce99d9sm1890609plc.95.2024.04.18.12.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:25:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Apr 2024 12:25:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
Message-ID: <787e0ac1-cb31-47d9-8200-3f6a3b4119dd@roeck-us.net>
References: <20240411095424.875421572@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>

On Thu, Apr 11, 2024 at 11:53:29AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.274 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
[ ... ]
> 
> Sean Christopherson <seanjc@google.com>
>     KVM: Always flush async #PF workqueue when vCPU is being destroyed
> 

This backport is bad. In kvm_setup_async_pf(), it removes a call to
kvm_get_kvm(). However, it does not remove the call to kvm_put_kvm()
in its error handler. Also see upstream commit 7863e346e108 ("KVM:
async_pf: Cleanup kvm_setup_async_pf()") which explains that one of
the error paths in kvm_setup_async_pf() which is not supposed to be
observed can be observed after all.

Guenter

