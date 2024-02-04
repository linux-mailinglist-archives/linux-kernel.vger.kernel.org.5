Return-Path: <linux-kernel+bounces-51719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71503848E92
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0141C214EF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593F225DA;
	Sun,  4 Feb 2024 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL/2FsXc"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65F225AC;
	Sun,  4 Feb 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057954; cv=none; b=XaVRqOgeHxrRFyQ2PtpUOGnlEekerdMfgC7gozYMfIOsUuJCSC3xSRR0CQxC3WUADAeePb6Bt8jUyBrNcoWpApGq5Al4KxyEPHluhgkFU4zbnCFcTTrCSUxm0MIKBibsr5hty8T1JqYExldiXE53mTWGGDk768E+GgPxSXj9TCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057954; c=relaxed/simple;
	bh=YenNIZwRKLKsQFgoZYIyCfXxVNYLV7RzcQTxVof1mDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiJCN1J6DxaKPBpjNrBuNdfOWMKxlSoiljmwGX6WhW6BhjWmOBkmB3gScV4UqG5CjsQnC1lzDGNfQPNffm6H448UTeNLElAXMx/o3R6ViNuCNbv1pWnNE/JLVkcfOfCDsdIruIy4BVQGLwvWupMidcPwb+IcO1QvY9CeHVYjgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL/2FsXc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so2928700a91.2;
        Sun, 04 Feb 2024 06:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707057952; x=1707662752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4Z1CvXWgSSfD9byvO9qZBZU2k8q/qLZYoBWgzMgYhQ=;
        b=gL/2FsXcPZTplQcZpEQxupOcLY1nL6pXUT9BZ1U1Jtu1PQLXo9UTOx1DcLs/BC+FqV
         wLbME+3jD3/X0rblST5sOdJzbUD2hiXqH/KrJHJA2KvmqhVFqsL9F0TobcqRzu89+W63
         EbxNvpqdI1nIrEQi3T0I+E40XufmA0CqhueBZwOBSj7YWYYC3u0jb2PSys5zAFqjGl5o
         rTozjlV2WtgppNLwU3d6/7gWZ1ror4JHE7iJzu/Kb+bHC4fLHoybBXiNiYXc6KO2iZ4D
         zKs0WgVs3OwGbKmKJ5zKooB0hmd3O7NUkNZ4U+aWDuQEcxkxDYYpstzazsgdv1dc1iEz
         VYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707057952; x=1707662752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4Z1CvXWgSSfD9byvO9qZBZU2k8q/qLZYoBWgzMgYhQ=;
        b=oLrbl0ef57dZxk5QSrlZb5AYF5T/RhHbVzOt0z/ZLX3N7dE6PEzRBachwUEVSvRGkD
         j7/4+7NFwEEcmKvk1DiO4fi2P6XgfXS+o7M+QkBFO+hOVEZBXPytjMV7DqPc7bJYBzLT
         q3+uFTWv9OiSx0scybh+I+F0OG/uE/u94BWPbfvBREcsCGs+UzS8dorT2Ag+noyknecG
         UusWHZm8h8cKcSlU21kresYGTDoiFe15H7G2S36LwehRvR6l10xfNrzesGpGSDRzzYuV
         HY+7M4zq4s6JOGkiRdpFDo0sQQisNAcPfzVIo/B8wAEmUjdVazo3bMYfQE+HK+NR8DVS
         wi6w==
X-Gm-Message-State: AOJu0Yw5q0u+afubctmpW53D0J1oiSFsmM/Y6t7DTMITxHnM5l3gLuyf
	Fk6AtZxSTI+YdE1Vzi036z28C6pvFYG408xS8ASA+8LGoDatlb9L
X-Google-Smtp-Source: AGHT+IEh3XB83Xq8GlWM5Fwd+yTWJFPE3dCC+xCAr2fcdJJTD8Wj40Ybfu1fbKhs++wYUbgZH1f7vw==
X-Received: by 2002:a17:90a:c68e:b0:296:2afe:25e with SMTP id n14-20020a17090ac68e00b002962afe025emr7848783pjt.32.1707057951780;
        Sun, 04 Feb 2024 06:45:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPN8yL2rL7xAuqSzR26HNnATQVrhm29fnqkktKatED1KczPVSWO3hvhBcxj/8L9PKuvraojfdchrsZNl/9+gguQuofWOySqkBUIaphbQ5K8xqArfrLmY4a/b/13v6TBn5HTfNVSlzGHxM3BVFaZ5gr2Tv7HtE/6AMhE6qbTPgA
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mi14-20020a17090b4b4e00b002963e682f6fsm3299768pjb.57.2024.02.04.06.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:45:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 06:45:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 04/11] hwmon: (coretemp) Introduce enum for attr index
Message-ID: <508b0bac-daef-47fd-afe3-0eadb5e67379@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-5-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-5-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:37PM +0800, Zhang Rui wrote:
> Introduce enum coretemp_attr_index to better describe the index of each
> sensor attribute.
> 
> No functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

