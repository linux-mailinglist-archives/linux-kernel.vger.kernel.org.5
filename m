Return-Path: <linux-kernel+bounces-109263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3998816F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF951C20383
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2826BFB4;
	Wed, 20 Mar 2024 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL+4NNsQ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B476A35D;
	Wed, 20 Mar 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957578; cv=none; b=njIDGH/KXkQAWF6FeKdymSsboG+YQCFbkB1RURdA9/4Lte+ygkOLzvhx8hkcWiRpIQ/CdIMLrllyM7p/1/w8QL6NihLy6gkrIFw1NKvMWGlQ9i0Epdj1wTH28QxGy6HCzMPWVAjzPXjsHzQYBlUJVqT43piNU4QDzfZopFYwr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957578; c=relaxed/simple;
	bh=CKsxIN3qnQZvRKwtdHbydmzJ6EscP69AwdsUvQtKlXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm/Hp5c++Q2XZ2CLSTl6TfoYMYKqHgSl7nVWIn53oC5kH/I51J9/LiHMgNS847lzul/01o3cxt7ZE2uerOy1yppE37U/1WLNgBvrR/epUD+09mORR2YTVMgapi69aRfVcXpC6a+icYxqW9PG5M5ZQaVsjxceMKLH1JBTDm9ESJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL+4NNsQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dee27acf7aso225835ad.2;
        Wed, 20 Mar 2024 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710957576; x=1711562376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wO2woPFTP1dqOwxqifq7A1+P/J5nu7I1BzhjZG4OLA=;
        b=SL+4NNsQZezagXpskHooqekAKzM2m0HKEeF738wL3CGaLSBVxpVJmV22nr/oNBG4be
         Y2v55kkWYV7l9IkSLhQARrNhfDDT85cc1jEossOQTRmLdGCaFsVx2iLiEthIpFi9QW2T
         JJ0SuyFzSE1aAwOVhnZzLB99ONnA9lW/IYGuwk2wo0NTTnjEGhYLbVjnve+FeIbMz21N
         FRR9qu96ZDM488cWIUsqE9vEvcgH957nutDmiySLsY5u+KX0qeGAvMZpUbXXsTqlPe5A
         NEKXa4qcV5Dj7lp1pkvdEnjMb60R9gWI0hR+HoVt36gbuY/zcaQXopvUoyfX95mSojnz
         z2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957576; x=1711562376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wO2woPFTP1dqOwxqifq7A1+P/J5nu7I1BzhjZG4OLA=;
        b=tA1SsZ8ySI79k3L8QW+axBfmGHzd+WzcZ9ySlux8hXzF4bcJchZuaeiNB/Xi55DL9m
         U9D9f8vGa0PniT0k6iPg0KAF9jK0QlhW1367M6Aw5r+x8INl2FwMWyfLTsAP8w4Y/y0R
         F1InNHAiHTJ4FmPAk1/gIvF0Wv5Xivk69/x5oE138nhrEye6KLkWpbe3eVqnNgn8PFj7
         qabis9HhIJhdUWYQflAir+bQprVD1DlwokLP3I9dwFe+/eDeX2dfiGr8UmdY3nH4hIrX
         flQZ877DKiNnqGg24ZdRT8xB8XCD6ZMU1+n69328vjM5u+lD7++m9XWciQJa57wYRuX7
         Iu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmOGnI0yzmHoa+ajupYXYPsdnlGViSls+jhuh73j62h+XEwv10T286FCiaWKDFbT31wZU3DB6LzF08SeekrChkZDEnu0qVNoXXxShJZbrcCGxuwC+xKJuK31WLtFSMjA5K6BI+OcI2
X-Gm-Message-State: AOJu0YwVA6d/Pcl0bggugWVzUZvJT5xalIqS6i2k1417WCGVOjhmY+ti
	3TggbKNfblLer/PHaoLvrP8RaRfZLwNnMvlaeH4QBbhAGDQQRz2mBSi81Txt
X-Google-Smtp-Source: AGHT+IGhYmOXoAM/t0PVekkv1InO9r3UvXpth7X3ywfYPJ4Zg110QlCcJBzYVhNKmD9WzksHZbtDDw==
X-Received: by 2002:a17:903:192:b0:1e0:3347:5bf with SMTP id z18-20020a170903019200b001e0334705bfmr3566800plg.37.1710957576013;
        Wed, 20 Mar 2024 10:59:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001e00d9680cesm7921669plg.130.2024.03.20.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:59:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 20 Mar 2024 10:59:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Ober <dober6023@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdelvare@suse.com, corbet@lwn.net,
	dober@lenovo.com, mpearson@lenovo.com
Subject: Re: [PATCH v4] hwmon:Add EC Chip driver for Lenovo ThinkStation
 motherboards
Message-ID: <f748574c-93cf-48ec-8e88-44d5b35fb107@roeck-us.net>
References: <20240315115810.15816-1-dober6023@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315115810.15816-1-dober6023@gmail.com>

On Fri, Mar 15, 2024 at 07:58:10AM -0400, David Ober wrote:
> This addition adds in the ability for the system to scan
> the EC chip in the Lenovo ThinkStation systems to get the
> current fan RPM speeds the Maximum speed value for each
> fan also provides the CPU, DIMM other thermal statuses
> 
> Signed-off-by: David Ober <dober@lenovo.com>
> Signed-off-by: David Ober <dober6023@gmail.com>

Applied to hwmon-next.

Please note that I'll push the branch after the commit window closed.

Thanks,
Guenter

