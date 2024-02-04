Return-Path: <linux-kernel+bounces-51911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13228490A2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCAC1F21A77
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D122C695;
	Sun,  4 Feb 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAvaYm0k"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82B2C689
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081857; cv=none; b=LSz2W0XWTmmPz6Md/N+kfmGYcsJjG7veKfXv5XJ/umDPkgtQiplByHQL7sIjQXZw3D65MQEI0iepcMdjv/fruIGMha2KgpqhET+X1nlbetd2/5/cs1CID+4QbJLqlSXPsEyiAfGG331JQb8kRANqlpE43vBgx1HHmti0RoXl848=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081857; c=relaxed/simple;
	bh=9RJSKKjfi3BXuxWbHIIp99qE//7VY0Bwh+8SQe2MDrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/SowCQljg1ShgFitk7zBXjZZwzZ8Y/3YzuSPKMkKaCkiwC2Skm1zkQ+GyjbmF42n8u1YRuyWbKNv+fWSs8D7MLxu88+nISI3rW/vFM52NpE/SxdbadqUphsdtNmUuPTrJXhLizhOV8Ph9/wSGFo/2Ix5l4W+t1cwr1oIVtAwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAvaYm0k; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7354ba334so33616135ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707081855; x=1707686655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4BuOMXnh6IsWB+y9vpfdoFWXYg4t3XnC592E9eGVkM=;
        b=BAvaYm0kIHUtpX10UjNhUgZMYHiHEszQBJodYxKoNijW97bEG3L0oocTjp4CMXBn2N
         vrG+gZxS/A4tiX73P/ClSJJkBrHAF+ZCgOqPPU9xKUdlsl1gQrDuH/Ci/6xb2OE0EPAC
         qZZaFW3zbd+2ZE5XTIZSHJ6x72JFhVWOFtiqz1FhAWmD9IbS7lDwCUnzewLHcKFP5c0Z
         PaLIRUf3eVMtc3CP7sCg7OSEg5WS5cZxHR0H21GA7gH5gZ1yYJXHWZl8XtZfB3NO0dQE
         Xr+ry9vhhF62n4Um2gpyxXoi4dnvVNxw175O08sKX+x1FuGThRCkf3xoBgt2BG7EsGm5
         g9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707081855; x=1707686655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4BuOMXnh6IsWB+y9vpfdoFWXYg4t3XnC592E9eGVkM=;
        b=M3OtdeGZOHwbdptfLN9ljbLWnRXmqC/VMXU95JHjuzsDKi7e9ox08GU5GLMOwpsMjB
         b3cDE2Q1c45eDdEh5DBrihHapW3aln6i58kkb9Q136nK3bHaqr69AcpXTAyg9u06XVPy
         O/UMSXrymSOiaNJ8qr0JyaRSstlOfRh+rvUeG2E5/Nmitoh4DVXOGpAHxPsbBWQDSfH0
         QGloQfGsGmVmazrP9lvmPN1cAwyynvpLLR/lqiaNEUG+z18nTo6eIxu0I76bhfcRyNnc
         6wSPD1VVDJcJISz13QZdNRwxuoIWQokLxN0l/h5USSG9QJJJzbovB3tp0W1trfn+Y4/j
         sK7w==
X-Gm-Message-State: AOJu0Yzbn/I4qTpIfTWOZw03mxOpMpPQBWkTOZZXjv04PWqc5gsKJP/T
	Bj4R6ax7+xUUrT6JRtiXWfAofwrxNEgS0Vvzj1Ygc7N8+ntTEpaS
X-Google-Smtp-Source: AGHT+IEiHqZqlKQhogUwoRULjOrEa2QYf7gpNNFKfa8dBzqKvy6hBc4K3+kMOSD0V49fIW5i3p9CjA==
X-Received: by 2002:a17:902:eccf:b0:1d9:7941:2274 with SMTP id a15-20020a170902eccf00b001d979412274mr11037272plh.4.1707081855120;
        Sun, 04 Feb 2024 13:24:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXq5RDOSdzhxZDtDULnG3A4EiZjkVrG/po2ENRF12ql2DNKRbI5/XRO1jnBnxvAPk+6yhBLI5zktg/sJZyKQb5tN1c7UQcwAMD9NSr5nWmxm++FTOCCUBb++cqH7rId1bDN6EgDynkG5y2bWIGYVBfVBmEouLp87rrZyA==
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001d7365fe0c7sm4874475plr.164.2024.02.04.13.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:24:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 4 Feb 2024 11:24:13 -1000
From: Tejun Heo <tj@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] workqueue: make wq_subsys const
Message-ID: <ZcAAfe8EAiqU7CWJ@slm.duckdns.org>
References: <20240204-bus_cleanup-workqueue-v1-1-311748f9101a@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-workqueue-v1-1-311748f9101a@marliere.net>

On Sun, Feb 04, 2024 at 10:47:05AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the wq_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied to wq/for-6.9.

Thanks.

-- 
tejun

