Return-Path: <linux-kernel+bounces-140234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F728A0F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEC9286CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FECF146A77;
	Thu, 11 Apr 2024 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfjqtKyB"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B8140E3D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830890; cv=none; b=uoYA6YPd1ZlZdkdPdwEHgiQ6fKXi+Hj2/Gfd0kj6piIGntLcJvBgaQiyRwEvTAYGHtZa1iaZjEd1CgEzFQZX7Wsq9pXSQkD95ffZ4svpwBNK7dxMf0aNnS1MN/TFP7phg8qLMHqSroMJXo0T+YFK4FFRCkSFP7i/QG7NnRlKLuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830890; c=relaxed/simple;
	bh=zvOqY81UI1gje8b+KKXpBiaE2ZEmEDpgfgaX97t3ET8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvAxYaB62FPXEa/vXLDQn5CCQfudxOso3sBMlLCKV+SNqj3x58UYMDH53LMTGSwTVWcTJsn2uzwpo6/g3AqMCxcLDmG4+lpBr/oWX1GEIed4PfzYnVNclmO9fcZTv4gCqfgqDgi3y1O9cyuRMwvoYN7yqezyW9hlspgz7DvvtHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfjqtKyB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44f2d894b7so868361166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712830887; x=1713435687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xvdfu9ArjMbK1qf/YQdnlhdZxBJiNRZlOj4rVjSQLs=;
        b=hfjqtKyBF3Em+5dKq/Pe6ryRii+9+6IEBbhJQp+HOHlaqeG/sJ+Pvku2CflFtBcdE5
         qlgkaJa9HYlduLNmqjltr9q5vK+JB98bxnAjIDiWwEIJ4ApEk0Atf/9U/xZuBu83Scb8
         kqiLj7tKdIkL9CyO4t1vS8YS7Ns7PmpnVOMV4nt7MSCIW3+SxMSQsATGKwafdyK7ohPR
         izpqgnBTI2W7m0kL85XJBXJaLdPWGnqxUpdwSfzLJ0CFAYs57xOVW33rIUByQB7gNE2S
         XNb4hI7Iut2bhB3HWUmiBKbIADKFv7lnvt+u0T64qY8B2IZUAoQ6/a03JwFJk4b3L1/v
         0YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712830887; x=1713435687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Xvdfu9ArjMbK1qf/YQdnlhdZxBJiNRZlOj4rVjSQLs=;
        b=FSh0cH2KJQmyOhbtLaoVoW6VGMndNKGCdBEcQ7lNXVM75DLatiem5/UyVBfhMC+AL9
         1QRe9qJNN+f249l16G8OAzv1RMj+FD9HsWN759e/VfvyfW5V0o8IPkTF4+l+5iYV/Ol7
         Esc20rQTbkJe4c/GzZGbCdWiAMnFtK58MuTxMHRvC+l0sMucBEDE9I8zAC91+V8fU/B7
         TYNVHSgg26RmMgYoCAJaw3JjO7KF7kLMrfhEsuQVLA8CtZFU7ylhKQijV4HoN7LZnK/z
         yROLKVZABq2dcMeziTWc9+agdaaieifqWmvtjh1hllSmy0L6ZlnMxBMuMDlOSm8Fb2BQ
         17sw==
X-Forwarded-Encrypted: i=1; AJvYcCWgcY+M7zHeS2uyrgVtFXFkU0jsJQ2btrgYfqzJ59L91t+SAsZAfSM21H8SD0/PGIdR5HLoJA30hI1adwart/DTdL/mklXZ+SGQKQcn
X-Gm-Message-State: AOJu0YyWb2ihqPEsEowl7wsVr9UUX5PIloCh90SfEbR1iHBjUKC5et6I
	xihWTeYk2npf0pL6cFVPbY7FxE/PRi1bVxRU2R1TCJGQYpiSQ31EbczJdT7ZxyI=
X-Google-Smtp-Source: AGHT+IG136xJRDYzgDgQExKc2yfZPoo7wrVxMm/rzGH1QMYV8XsYZj/631Jbg8RJ77bGIRh4geUH4g==
X-Received: by 2002:a17:907:d15:b0:a51:fa5b:8b9e with SMTP id gn21-20020a1709070d1500b00a51fa5b8b9emr4430989ejc.60.1712830886922;
        Thu, 11 Apr 2024 03:21:26 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id w22-20020a170907271600b00a4e48e52ecbsm605751ejk.198.2024.04.11.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 03:21:26 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:21:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] bcachefs: fix typo in reference to BCACHEFS_DEBUG
Message-ID: <b6d90387-7892-4c28-9855-ae35faacfe9c@moroto.mountain>
References: <20240411082931.56362-1-lukas.bulwahn@redhat.com>
 <a2683fad-07db-4857-9ebf-7adf31a09e50@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2683fad-07db-4857-9ebf-7adf31a09e50@huawei.com>

On Thu, Apr 11, 2024 at 05:21:05PM +0800, Hongbo Li wrote:
> Also, I am curious why such spelling errors cannot be detected at the
> compilation stage.
> 

The IS_ENABLED() macro is testing whether the define exists or not.
In this case both "CONFIG_BCACHEFS_DEBUG" and "CONFIG_BCACHEFS_DEBU" do
not exist for this config.

Lukas's scripts make a list of macros we expect to exist and then checks
against the list.

regards,
dan carpenter


