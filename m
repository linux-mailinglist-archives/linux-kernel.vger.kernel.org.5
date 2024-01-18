Return-Path: <linux-kernel+bounces-30450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2481C831ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572721C21FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F02D78F;
	Thu, 18 Jan 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQOBgyb3"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03C2D780;
	Thu, 18 Jan 2024 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600790; cv=none; b=BYZb46mzzEf/17+lLaR2hvRq2qxyo3fktx920PUGF95S3VfgyyGfiFF23AFqr7tYV14CGGzGhrpIGq9ay+EQp42WUAUolTLmiU3uYZyLD7bB7xUgFZvaGQQ5RJarvaXBZgxwZTtkj/F1Kquldp2EwmyXOgL/KJVfheZCktYlhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600790; c=relaxed/simple;
	bh=FzQfzcORlDMR3Al0CbgSoIRAPuO2tKgANcfWrPTXfuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHwmXTAoFNXU4sXqrLpmNXLPTXK1n9Rj4S1FIPnKSR6QMwtEuXxTMaK6D/M04zyfzwmjRNHI3GkVyy1ZsAGuAayCPUeLpctQH9e06UKsPtaBq21Bq7Cv5F4BVUUBPIcT3c6DH/d96IQPQhsVI6eFPs0/i0JoyhKZkKnBDRiwDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQOBgyb3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso8972679a12.3;
        Thu, 18 Jan 2024 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705600788; x=1706205588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gI+m/qqF4e5NbM42ZLgD1gPN8rh7MYIeNL8vD1jR7CY=;
        b=SQOBgyb3Xelx/E8QHcJ23kVB/CAaUl+r4tv5MbIo9BQJ8snrj3IUV59UCfvd6GWRYW
         ON/zt+QNde097Y3r7mizHKpfIadj3nskWyAQVp8SWoBgqhq4RUsKsOeU6H3DGT3GdDcc
         2VQz5OT1wZ78XNVNJftPlsNS3N0StKCWk56Bx8vE28bFpCXdjDptZfdZvl/uD7wbiWoN
         EPRdMXUQ2EBpI/Zmqadbe6Mmj5EbbRc7hLrDZlf0kswcsb8nJ5PTIzTUeD/RW5a28+Nz
         2RGuBiElM14yHe32D9wBkXqyyVx8S4Cahd5IunQ1s0qTFSF9BjxZwW7A+7cvFKC3ekGU
         5QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600788; x=1706205588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI+m/qqF4e5NbM42ZLgD1gPN8rh7MYIeNL8vD1jR7CY=;
        b=u97OOcCQn+T8wHOsIXN7fVbztW30sA6B7exEyFWbaVgN2yiZ523jjktu7tgF2oTefC
         SfocSB0kmPkT2xA3K32E7dlWLtkcja4R3bEKdtv1ZUZsfmtOEem07/bXWzoGQRxQqq+F
         5nz/XrOTcKooUN8VwEPFtvOkumRhmlXzeYFxECL3dKJMfUz5Xy5SliWLCgiDlPnVrgcP
         C8l+HyrGh2DfvFjGMIMOmOExw7wrQ5ge3RVz1WnPyC7CiFJ+ZeDjG78b052m+cxNfkEn
         DHH6+AF3A05ndwuebSTzzDclD2hz72g/2HmVIKOkdPFqdhoOXYLGocCl/PEmIBrprrSC
         3DTw==
X-Gm-Message-State: AOJu0Yy5Qb0QNmqZ5+aQXUAD3yYeNqQZQCOZOPuQRptpa5qNjxOTwCxP
	/RzgXpr5txjHupJdqbQhoDrVABxxNsNpqNZbNZa/Bvw37nVzO94wDy4VzZ57
X-Google-Smtp-Source: AGHT+IHKWWk0QVlZw1BgfXSP3oHRH0jT8I6f+LqK4gR7hyWI7xLtWLCcStwzxUW6cJ+1FfVjel4gsQ==
X-Received: by 2002:a05:6a20:2453:b0:199:ddac:ad4f with SMTP id t19-20020a056a20245300b00199ddacad4fmr1301291pzc.100.1705600787881;
        Thu, 18 Jan 2024 09:59:47 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f04f:73f4:b79:a70c])
        by smtp.gmail.com with ESMTPSA id w29-20020a63af1d000000b005c67ca3c2c2sm1834801pge.21.2024.01.18.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 09:59:47 -0800 (PST)
Date: Thu, 18 Jan 2024 09:59:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Valek - 2N <jiriv@axis.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: cap11xx - stop using chip ID when configuring it
Message-ID: <ZalnEZ83M0jlQI2s@google.com>
References: <ZXlCRsnOu_L8xeTC@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXlCRsnOu_L8xeTC@google.com>

On Tue, Dec 12, 2023 at 09:33:58PM -0800, Dmitry Torokhov wrote:
> struct cap11xx_hw_model is supposed to describe the chip capabilities,
> however later code changes introduced checks against chip ID.
> 
> Introduce new capabilities in cap11xx_hw_model and use them when applying
> chip configuration, and remove the enum for chip ID. While at it, rename
> no_gain to has_gain to match the rest of the new capabilities.

Jiri, if you could give this a spin on your device that would be great.

Thanks!

-- 
Dmitry

