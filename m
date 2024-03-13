Return-Path: <linux-kernel+bounces-101623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D79887A993
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7D5281BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0FC127;
	Wed, 13 Mar 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TK/TAtRc"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A744A11
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340576; cv=none; b=oZLz/3yOAQI4PV7dJBETkNgXSbKuoyMiYhWppS3otmyqbQJShDGHSraJ4W6rzfx/GPrU+sSQ41Ds1nJcOFKyGyqjJehNWGJx+mzGLCKi7kou2/lERxyVifVxQj2o1rjZ5l0g0ec+Hle5VUK7nzvLhzZff3RlSnktBkERmNhI9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340576; c=relaxed/simple;
	bh=WBtDlLFwjr6a2gQKftAx1qOjLB+FqxnGKwhOZqeQ0jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcCEvTk7R9uIgEl86YfJ3i6cneOUf+pNvwfrKRq1IkoG8XHwA+ka9RlF0cBtU8qzYM010gARe17BKRY0cnnY1sCgcR5FI2bVNLYlPO04hYYDwOV1FBVXCNMme1CPpIz5QMLpLcR5txB8gcT+J5mQiR/sUT0j163PHeDlcTWDLWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TK/TAtRc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a45f257b81fso661437666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710340573; x=1710945373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+VNUI98uGBbk7n2ey+cvrGu4esT/FnUUpds3abi4QF0=;
        b=TK/TAtRckQ3UhnY+oVDNTU2bH+57Zw7Y6giS5SUVLquqOaS5Hb2uxm4Quv2bvOZNxh
         6Xmnbos7dpsld5FDOxsFDPFu7F7qQ4XoPKeULlZg1QxjrEpwNL9tTxTa8vl3TJnjdZc2
         ZvW8s7PiOzNTMnHR0KDmELA0InMbjkG7hEMCqUqIYjfWTgaU2wzCE2zXSblFY+sYR5wt
         INt16/SxpwVfB+K6D8PAr4UdzNyQgHBsSUH7X5k0gz2HnR83S/lKcWFu/cXuDOwgEv2l
         s8dXvle1whr3cbD0sxG0WRvw6zE9BQWq6mvkZG2q6VtVdSKf1INXEs2alq0rR2oyeIOn
         J7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710340573; x=1710945373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VNUI98uGBbk7n2ey+cvrGu4esT/FnUUpds3abi4QF0=;
        b=B1blNs/ilvuxswPCawhxx8aroz9DNUadgmzCqjebKhMzaj9KBJT8BFWG/RV7rJduuL
         tbzjcnxKINiaA7su3bjJ68CSTIR1ncp+OQ6W1d0foSC1j0kpaSE3AQiZp7+qffIU73rI
         AEIb2XxVqhDrE/qPJXavC3XEj8ECjT/QOz2dKow8SCEtclkMkrdezI4NYQd1yPKF2JAk
         I4geVaLuH11tov0GP4jF5deFLuCJPsn7gF5siBdxUsNPqXRMaYzYK26PM1pLAL8LTRnn
         69oZJ8WnZoBuStNDxBOJNGdru3ucTuzq2EBt6O1GHOqteG1EyqZ1j+3ifF2Bx8B2Nrm5
         BdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/U7RIzoY3D6tMsk05pmgOLG7p6/NtWTF0jX9GpXUwQtaMTIb8M1TMjcF/wOQRNhFvSHebSdMtKINZCweIyjLcngqzU4Ky9cS3HMob
X-Gm-Message-State: AOJu0YzXsgU8UWyTVaB/+wFwXL/nHi8oDWo9gpMFokn9u+NWKBmNR1R1
	jv0ckjp2P5BKSldV1P6Jvs7eBZ8pTaRl8TZ5UiwsafOnqtSNlpQkNZNKuWqWBlQ=
X-Google-Smtp-Source: AGHT+IFCa7DFbtK3UHRnTZLgXaB5cqtF2pyYFRenSdXtbOB2+Qa8CNuq+x9/Pi/H+Tmk36J9EbvdjA==
X-Received: by 2002:a17:906:ba87:b0:a45:c1a0:5c03 with SMTP id cu7-20020a170906ba8700b00a45c1a05c03mr9938948ejd.47.1710340572593;
        Wed, 13 Mar 2024 07:36:12 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b00a45c9ea48e3sm4895099eju.193.2024.03.13.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:36:12 -0700 (PDT)
Date: Wed, 13 Mar 2024 17:36:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: wlan-ng: Rename 'wlan_unsetup' to
 'wlan_teardown'
Message-ID: <089411e2-50fc-4a66-bd07-f76c5aa2788e@moroto.mountain>
References: <ZfGG093fyjI4G/ci@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfGG093fyjI4G/ci@MOLeToid>

On Wed, Mar 13, 2024 at 11:58:27AM +0100, Felix N. Kimbu wrote:
> Rename function identifier 'wlan_unsetup' to 'wlan_teardown' in files
> p80211netdev.c, p80211netdev.h and prism2usb.c, a pairing function for
> 'wlan_setup' to match common kernel coding style.
> 
> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

We're probably going to delete the wlan-ng driver soon though...

regards,
dan carpenter

