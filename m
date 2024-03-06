Return-Path: <linux-kernel+bounces-94038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33888738E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B4C1C20E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8A512C52C;
	Wed,  6 Mar 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Us2g2gT/"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D7130ACE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735036; cv=none; b=Rq1hr3RucSFCOlLTfJ0p1pdyfI+kUeknLERMsVNGfqnvdOTmXWti8Qk//FDjigR5eV2ZD6rvWmdaEU0Y9rHfFwhObAgiRlzzjLN0yRNFw/Qc+kj0QUjIeJOop/XSTbJ8FU7ODZEFMYIlbCYCZsndYCyI0VjDWpVomcJHfIzn54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735036; c=relaxed/simple;
	bh=wdJDKRGS7HFTRE8jxAsQE8U65zjJmRnaG0CudQdRd+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVml8dn526UTM/N03vECfisJTCcfxx2BktZQ8903nipLt56GY+eR0dCdo0MZ+6Uwz/wccN8ODlB4NPApQNuA+EXRPmq+Uelq/fIcCgvX0RhUlj+4v01EeRPMTh7TDDMrWXgtjJgG9OtJo64M0IjLfcvgqAKUbRIi1Vl09YQBuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Us2g2gT/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e4c676f0aso1411570f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 06:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709735034; x=1710339834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJrroynuRnHM9d1uxPX2EIxDpMmTQhr265Ne8XiRXJ0=;
        b=Us2g2gT/BroLpTQ5pnBCRIMgKu6chDvKboLg5nvalACT+k2Yq0gufVu+Q1rkdrrcuh
         HG4H22Baot02e5KJJT+SM2pYIVz+uS9qocctFosjlFCmVWLSTvwEqKQQk2MVJvoojSUw
         zdNxZmftRWTNa4NmAHOVOsJXiCDgtgWjRy2hil00dQaGi3iQpgjJKjqkWXzuHqsURrae
         uLkIIjNXV+BkSTrqP4OT6NM0HkHpFqcZxf3sJDD1+FPrAhqUkaouHPLIzRhyEI/1dB5I
         q+LbaBQFmPHbDp6GKVJGuKZh8xWkpfbDYoez878eq6IMWzbRnq8+ewHOZQdB0JnmJutm
         QjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735034; x=1710339834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJrroynuRnHM9d1uxPX2EIxDpMmTQhr265Ne8XiRXJ0=;
        b=V/KBiJ71oO6lSXvtw0nUyiZ+n1Zo9Kep1oMVRzcN2/uXeV/91YJn5Y6FtjHOpHochX
         31O5ALGjXDEAqengnI6kUxJnt1oCy0D7dyKymD0EAn5EhtfI2g22eYsr+4COEHwivKdm
         5reoPfptuRQfDQhwpSjcx2owIBS28H9GFu7TmnWJ0ScHE7oGHlp907d4JV4r5FOOHukC
         59kieMWvXkA2HKypZyF7jAD/ofAPuvnjlVTrP8F85Ow0Z7h2B4s/ZmFfoGqxzUuwIyhD
         /9KiEH9DkYbH6VmAvfgavDLtOe8FSSzSSNbg9kCxaW8lXLvFfr5bwP2gJs4FMi1KsVe5
         ITWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVys7MBr3K3xa+wJqWX7SPFhjEXQvSK9XvfLxXoDlUzVNCOyfZaDhMgNMvH1qxG/5WEnDf9z6MdEOcWZXd/nXj0J6CeL14ihIxzJDcX
X-Gm-Message-State: AOJu0YzODVZp5PrHq115GbGdlNP/yfZj1HovjBIgo4QHQRHSJ/TPmywE
	NzOEG+639hTJq8FnCzCXOOIosDGPb0vRX2nhCfJLeLpPMtfohBSj1RsRThwViiY=
X-Google-Smtp-Source: AGHT+IGCOKQomyj1XoUe7rvgu9g82j1JsX9Z7KQrQqSb0Ub+eD1e9HZF+KS6bVximLW/7kDpMlUX3A==
X-Received: by 2002:a5d:6310:0:b0:33e:834:13d5 with SMTP id i16-20020a5d6310000000b0033e083413d5mr10627030wru.69.1709735033674;
        Wed, 06 Mar 2024 06:23:53 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bu16-20020a056000079000b0033dc3f3d689sm17892394wrb.93.2024.03.06.06.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:23:53 -0800 (PST)
Date: Wed, 6 Mar 2024 17:23:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 3/7] staging: media: starfive: Sink rectangle set to
 ISP source pad
Message-ID: <892d9583-afc9-4acb-8013-faf021f8ae87@moroto.mountain>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
 <20240306093334.9321-4-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306093334.9321-4-changhuang.liang@starfivetech.com>

On Wed, Mar 06, 2024 at 01:33:30AM -0800, Changhuang Liang wrote:
> Sink rectangle will be valid for all source pads.
> 

This commit message is just really unclear.  What does "Sink rectangle
set to ISP source pad" even mean?  A better subject would probably be
"staging: media: starfive: Use PAD_SINK instead of PAD_SRC for crop"

But why are we making this change?  It's not clear.

regards,
dan carpenter


