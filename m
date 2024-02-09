Return-Path: <linux-kernel+bounces-59836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228A84FC59
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D325B2309A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C782881;
	Fri,  9 Feb 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGuwUIJM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3315A787;
	Fri,  9 Feb 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504830; cv=none; b=BqX2qA9S13P4Tv4I5i/FVSqzGat9f0JL5ds01o73llr8cOpH3ugijGGqoXMA45FcOAbbTEz1kV31mZ/kvGkraC+eB/i+Q7fjRMOtHA1uVEMowq2Kc1TixJfaKysB9DhH+hDE0B9LtcNdSsXBE92gRlg+Ti5mYcOE+svyEUn4hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504830; c=relaxed/simple;
	bh=Uiu9rcF8HErDKSXJdAGh78HZUQboLCeqrgDr/pFVze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+NHLjBA0PAtiBljfWWTJJ71OcME0M6gZElxYSxPn4Feh0a0BNXTKay9JfJR3xbGQop0+ukvC97AgU3xE05JxyoQNTOsJZImIoqOGu6SmJH2yYrvMdsN8rfwTaIwtG1mE/ZhJC2bXljTEAWVlzDnE8wvHzF233zOkRhIwYnC4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGuwUIJM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7431e702dso12136045ad.1;
        Fri, 09 Feb 2024 10:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707504828; x=1708109628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JiWoPTqj0w0145AsV2LagOsp+GlPDJWJK4JEkgbKXeE=;
        b=OGuwUIJM7bX0zokVlQNWXIgk0dt/vsBO0pdyPBY7wOUezjUs6xsrKThsK8ZZRQ3Hpv
         vUh4CCsojuh8XVtdAcnnhnvyMJuyVsDsQmHdzzeg0dEFaMKteGfrS3UslKOiAISW6eKq
         zlkZ7aRp6BvbAGfWX74V89nC2QzuK5mmUohsjqoFWQiU/qmnM3t3ipeIxhZgNciSPsH6
         Ck+IDV+YDtAs+3Rg6rlt7oCRdlP3Lrh4pQgP38kjzExdD9xzbB3xivjtcoQt5YZCcAZL
         GwMUBej6N5f2FnjzI+qYh/IyVo/uCAFSG3T4gDER/zOhqvqkL84gyn3zMXlM4rwO24GX
         kD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707504828; x=1708109628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiWoPTqj0w0145AsV2LagOsp+GlPDJWJK4JEkgbKXeE=;
        b=OOsiCsSvT6z5iMYN/qUFuLN0PZgDUHMnl9w2TevVQNr9LZ5y0OiSE/eBaw5vFEgspt
         mG5QJKdNTspPgLDWimHqUYHZDGTfSlrSaTVUWIqouIEkDPYoUmlTzTJfa+eHd0g3bo+G
         5RMD6IT2e4X3Aq72D1gC5CLdsaArfPqCTzfPDtaBjBCoCpkwOBfb+gddtfanaLccg2RK
         Aqv8lnMPZ9zGy/IaxMamhlt10jOG9wtPQBDUa5lqBgGwAomYRmrHk1HnaiyQdKt0DzoQ
         JrrMSLdWGhfvoT+R9y1LaLOu4SyVRuTnwfZ1N5SQCI7p3Gs5/S7+4J710CBrJvAtX97F
         egLA==
X-Gm-Message-State: AOJu0YwR1sw/0o5NXzJiB6y17ILAqUn9mP7GNWBsMxNaYvP8BbMiHHr2
	yg9UxqqzQmZryrzj3Zgk+wzYyKUIY/POIgw0zl8+SWmxkR+Wx7ohpsGU4pzT
X-Google-Smtp-Source: AGHT+IF+V4hu/VgSK9crSXAER6XYu1OvOapxFJR77kae4IdCEEHdoU5C+NuR2YAWWwHjlYlIzCvZuw==
X-Received: by 2002:a17:902:e5c4:b0:1d8:fcac:efe5 with SMTP id u4-20020a170902e5c400b001d8fcacefe5mr160202plf.17.1707504828353;
        Fri, 09 Feb 2024 10:53:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7TeZcQhkzqH43UA5AKy7DDSq0VDWP1RrWiO7S0eytsijnpdQCIgUPPMt1KnoT+RsxeS6bxLc8Iggpr7dwocWQxeGWMEWRQySN1z89IfOP6TSaJb4A+PC27rzKAtzN9QzT+AWDfnvzFiLtnzg4quo8B5Fr/XC1QWM4xybftrNVyP1ASEzcWEbP
Received: from google.com ([2620:15c:9d:2:9ec:8b78:c8c:fc9])
        by smtp.gmail.com with ESMTPSA id kw13-20020a170902f90d00b001d752c4f180sm1839706plb.94.2024.02.09.10.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:53:47 -0800 (PST)
Date: Fri, 9 Feb 2024 10:53:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] input: ti_am335x_tsc: remove redundant assignment
 to variable config
Message-ID: <ZcZ0uT4hCZuJPL7z@google.com>
References: <20240205215940.1851349-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205215940.1851349-1-colin.i.king@gmail.com>

On Mon, Feb 05, 2024 at 09:59:40PM +0000, Colin Ian King wrote:
> The variable config is being initialized with a value that is never
> read, it is being re-assigned in the next statement. The initialization
> is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/input/touchscreen/ti_am335x_tsc.c:160:2: warning: Value stored
> to 'config' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thank you.

-- 
Dmitry

