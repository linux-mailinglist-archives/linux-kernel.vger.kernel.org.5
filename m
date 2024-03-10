Return-Path: <linux-kernel+bounces-98121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA241877562
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8946C1C211E1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503DB12B72;
	Sun, 10 Mar 2024 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3ookcX3"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F965FC11;
	Sun, 10 Mar 2024 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710047756; cv=none; b=NL8ADolYPVACkrON4LHMjq8AYxJn+5otOvLTcJX1drNKvZkTBudmNBdTARXCdIJv9B/Vb02nNDxpziR8DJBQ/jMbvibTmxaV4x9XPok0dZL9vqxSwvqwyucWzKfyNa5Pbdg67do3+hWjN3Vv7W9Wjm9OUNZxCuH3BqvXugRJg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710047756; c=relaxed/simple;
	bh=vXhuuwRSejHHHe+LgqA/u1RoF61aDD/N8FU91I8iswk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJJ+FrOSdvj9A/QCR+IAh35Ed/pC2R66aWXrZFqk8LwxXYHIxfDOvnmNEb1fUBCkNYM4oFETcOm4tx3Hol10DXV7QQH2gvjpLNZvk5ng6mDjyi7jTjuW/Tcz8vp2wuwo0hhBp6pRkNOcekCuIGZkK25VCJc4B0KcPgeoMOgzVL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3ookcX3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5a50d91b4so2011157b3a.2;
        Sat, 09 Mar 2024 21:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710047754; x=1710652554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ib9PakcuVArrXU32Jhanxs2A34a1U+6aNXslHCS6WAo=;
        b=Y3ookcX3AMIaxXyYr92SYP57YrArQ762L61a3JnADhEmHzaPQMS62KHjCpJzj+ej21
         bCD3nNhprFwVK87l80reDRY6dCs9xVhEfM6I1ZtjXHNKT/JKEY8FSZLmP3ZHADQuiIXA
         d5GtOVQ4qASIXQkPzWHvYV+pRBBvin68YlbNBrmOhdA28tsbbg0597rnTd4EI5qx/VCu
         amF29KWMIunL9x2FOl8LJbLpfLaL6CU78Iw8sSqFCOyDgUHlY5VLTj7rvbid/7mAtS11
         eCdq19XlBktOpEntPHjYaCxL3CFtaObHsprrG8jcmtImQlRMAAXDGrJcbiYdnYnQn7lB
         MJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710047754; x=1710652554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib9PakcuVArrXU32Jhanxs2A34a1U+6aNXslHCS6WAo=;
        b=WhyBGVqOf8mcF613vkTYfHjS1tY52Rum0bEYQFCHbZwnDOHNL7GMF5J75TfiRKuXNR
         kKZrK/ilbI7Tyk/57alkr6ziPMj0FrHgG87tC1P7xQr5MJ/3wGkJON7NSkMkTrgRZrcG
         PwZgsV1MiuU9w3r9COOR0TME7FtaITPnoCAUPy+6zZUbdoEvOBzf6l68bqKcKOM5NT02
         +u1VcdtP30ff6TZzq2gML6Ce4idM7b8Tcy7wQWrjnFfxzicr5OeDtW0EVZ0e4Js8DU37
         j/d9Hbq3CUdIe/E7E+3U2fdhjMlW5JRmlFHjEEjuIGB7ou2L9y5crZTsDlA/RLxmqkWE
         oxZw==
X-Forwarded-Encrypted: i=1; AJvYcCUg3yYXitvH4FEdTgp2yH8DIsic8+suqZnTlorS1mOg1Tc5nqJNtFYx/YtVE87YnQPwv3DhKJak/EJflmHHq+P2ULadxOyheB9PIZNj
X-Gm-Message-State: AOJu0Yz4x3FiN76oHUcJDhycozf/MvfucoBpPN7WpXnqGyvrEwkB5fD1
	J8j3E2gwD4y9XbQJHk32IzJGwqPVT/sDj2dYPY1FK4TFUwrf3ATA
X-Google-Smtp-Source: AGHT+IGMIvB5cs+S/HGrUGZyss/scGcRTYSqLqLl/lXBb0keu0BuOmpYrDesk/YDS4HNAcFxo71OPQ==
X-Received: by 2002:a05:6a00:4b16:b0:6e6:1b89:aef3 with SMTP id kq22-20020a056a004b1600b006e61b89aef3mr4835799pfb.14.1710047754369;
        Sat, 09 Mar 2024 21:15:54 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5296:fec3:1fa8:a601])
        by smtp.gmail.com with ESMTPSA id x26-20020aa784da000000b006e6660588dasm1970445pfn.128.2024.03.09.21.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 21:15:53 -0800 (PST)
Date: Sat, 9 Mar 2024 21:15:51 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] input: make input_class constant
Message-ID: <Ze1CBxx1sYHSK9yo@google.com>
References: <20240305-class_cleanup-input-v1-1-0c3d950c25db@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-input-v1-1-0c3d950c25db@marliere.net>

On Tue, Mar 05, 2024 at 04:42:13PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the input_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied, thank you.

-- 
Dmitry

