Return-Path: <linux-kernel+bounces-80282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBBA862CDF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB27C2831B8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C61802E;
	Sun, 25 Feb 2024 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVBjxY00"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19471B805;
	Sun, 25 Feb 2024 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708893492; cv=none; b=OsscvcFL50pNoiNCfX0hXJlhKkdiZrPIdc59IC2B4YMzwaToMi+J5Olm9Q32B65crGiq0+L8uEzPea6sHoERWyxdHX57d726YlBrj/5OpLM4aBw1bClVwHWUrn4nKVhf47BszFRZlaa2pcwG0sr4qT6reVYCwjxcmLE6rLskytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708893492; c=relaxed/simple;
	bh=cMNPQGgv2AeFbafjuehqzeSHJWCg1kSsY3jQAIqeBNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIbVbcUkKgeFH1latjNADUnvuvu9EQDP1zlA2svpuDSGrhYiWzSXFbxb/y1V3ywx5cNVAN7UCZqrLwFyDKx97QLKdIqE5ch83KP1NV+hU44n1fJzjV+LL6nUfI+mrpt04sQOEEYUEynTx2rpZM+dGWknXYBqq+yn0q0taEEPZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVBjxY00; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c7b8fb8ba6so35982139f.2;
        Sun, 25 Feb 2024 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708893490; x=1709498290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+ydVDJcCRXowrn3OW64FOg+0XzcI1Xu19XUOKhDXHU=;
        b=OVBjxY00oZvCj90eCcJJBxFn29y/McbjcbH11Xh27rQfVupiNkPWazveUyL4B7YcxI
         ylBfmOVqxn+s0tM8FQf3ngG6A6kLWP3l2SYchZ1w5JintXvF1JcMUpdRUbmmtYY4m6tU
         ywFjNIU5UYdiWwMQUzyEacxX/UqOzQzT3HJyJW9zSh7e8W8F8JKGBAjtPXkCi7skP85w
         +WOmqtPVDBqM6h7twTNIDzGurAnpWRVbivjU0AWW1pZuDLIa18BuQlwL8dTLhTpyvnsG
         rRokYhYct5xlB5Uz4l9ZXi1tiNPTT/E/roaB10xKFatrb/v6L23khzeAn8ZcE0G/01Tk
         pE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708893490; x=1709498290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+ydVDJcCRXowrn3OW64FOg+0XzcI1Xu19XUOKhDXHU=;
        b=PTGZM7Fs6FDSynVjK2XrVzGXPNLKDKOK/qvEKbPSlaCv3oyavxlOLDS2dGAAZaNBMH
         ZZef17LHZjfXU9TdVF6RExHucFsEDkLJj+8cn2nBO8N2FiHDkmFwaM+d0jKIuc4Ntcj7
         hbaeUXPNzDzZEnB4XqJyQKg1nWFWKm14g5q6Bj9dS+B/4YMxp8gQuohF89+iTKepI9x5
         I8B3KNFvnPduf3D9tay0PU69CMMSJUinJpKJosre7DX0DzYIcGEFmr4ldkdckrrWGBRj
         sgm8QTTHjdWk8E4pRmAHCMxvMaJhjmI/XLbzl3EQLq9yDVET/0vnilYZhNPdqdSALvMR
         8XSg==
X-Forwarded-Encrypted: i=1; AJvYcCXV5b8ZoQnoL6FOSBreRv9n7nM3Wpto+ovfEiza3B89KMJbLo2bgSGkZEuQSzRdWEZxOI0cgxkqHyvEf+FThYb3Qb260nkJIAy1OD8dh/D/xG3BGkGB4QCp/SvoNohsYq1XNvKxHCY84f8=
X-Gm-Message-State: AOJu0Yz+fnWbKG28BXQhTD78dPJE+K3bUXQ4RT5/UDkB1QXWMWKn1bC6
	ObH1pVBkCKLVUpHl/DEybVYwa/0xt8UMnp0oEHGKSUvwjMzFnMKXpd6Ylq8m
X-Google-Smtp-Source: AGHT+IFbyarfsoR1zyJvyuB42BM829gEyLxH8GnwV66kVA+VBph16hryGLPtxpr3HgVknv9TzIUWtA==
X-Received: by 2002:a05:6602:6428:b0:7c7:b697:2195 with SMTP id gn40-20020a056602642800b007c7b6972195mr5064457iob.18.1708893489493;
        Sun, 25 Feb 2024 12:38:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j5-20020a63ec05000000b005dc8702f0a9sm2732170pgh.1.2024.02.25.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 12:38:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 25 Feb 2024 12:38:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: sis5595: drop unused DIV_TO_REG function
Message-ID: <c5320692-229c-40dc-91ea-f4d09f8a1cd6@roeck-us.net>
References: <20240225202841.60740-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225202841.60740-1-krzysztof.kozlowski@linaro.org>

On Sun, Feb 25, 2024 at 09:28:41PM +0100, Krzysztof Kozlowski wrote:
> 'DIV_TO_REG' function is not used:
> 
>   sis5595.c:159:18: error: unused function 'DIV_TO_REG' [-Werror,-Wunused-function]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

