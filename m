Return-Path: <linux-kernel+bounces-89939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CD386F7D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792651C20B1D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA497AE67;
	Sun,  3 Mar 2024 23:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIc9ZQJo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275A1E51E;
	Sun,  3 Mar 2024 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709507259; cv=none; b=fm6Wzk8Bi2kcCBkOoKO3vG7BZ8uU5nZJ1BLj7aEgDPthzsiqP9LYXf4kf2t4Y5CAiA8QyOYPrt7BiFKhRLrSfAxcuzIiwFSQBkK/mcluhqyKI/h24HLuF0LXnUJfVzcb7mewfHnFd+NAPGxDMLkNibak9D2ATrAKpmAmhf/Bixg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709507259; c=relaxed/simple;
	bh=B9px6JztnioA9DkA0ZUYPPiEdwMdurngJs/K6SBzgmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIZsT/lsisN9puR9Zp3NHR1y+CuDv6Rkz+vUE/0ifnkNl1jQmbi8wv88Agqw5CU2m2zMtxTjAJN3ZYxZxw1gOfODN9tWTJgRcO44P/pJ1syve2PoYilKJ9F56mFzezyMfrqkhVyWGX9icBq8jEVRJ6Dy9eYTgZaeNWcoYAe+9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIc9ZQJo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd178fc492so1268735ad.2;
        Sun, 03 Mar 2024 15:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709507257; x=1710112057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfo1eizHPxo4qfCiO/4wnEUdMI9Pd/F6WwzIGsBYpoQ=;
        b=gIc9ZQJo87lBRlYOnxPnvK2celZ9H3eNWtxxtO8udU2dwG3U1IIVgYL8QNvRyM3qkg
         NeWunR5igPZ7FhWDR+jRUZzc5+ApdaPKdlfmhMAXJy8PrUOqekdUGGABS2lYUGDmk+GI
         m0bbx2N39XMWMK+51xLHTz3ZCaknLHk1gMI3fNHNkB7janeCkFfBelyTs+Zm/OcF0WdD
         6D1k3PjesQ7AFXIkc/CimcZhv4k1T0NhkmGv26fEcYzlmyOldWkVYoAmmNxWUA+hEvMJ
         I3RqUUSi1nvrv+slZ2Lk3vIm3dFMd/LcaFSMoQy8b9FGiEFHvGYSX4BkRi1hTSpuKBfE
         KMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709507257; x=1710112057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfo1eizHPxo4qfCiO/4wnEUdMI9Pd/F6WwzIGsBYpoQ=;
        b=D6U6CPpJCbP2V+vYbc+P61DjLig9dBwKdpdgXpKrnfkNa9NNt1rhHIt3lSSAFlOdc/
         dz+ASm7KKrn30CXj4JdV4kM4J4gKKkHgyw5byj0P9NpRteLDVHSSur0gb+XFM8qEpDL2
         kZtZIYiQxoib3+N5/a48nq7oghJwvGpzBv1DEgV1XcvU1wJtOteV6RGw6jjXAEUJZx0w
         7CmAozVrz3v+ELaCcLvzkCFTW8IeiIHl+eU4vbe8WzFugve0eo9S+S6wkxCDr+ri9Q4L
         NxJMooUrQKFiSfIlgQIz1LtGAGw15dHUB8EQfl7giybGxS50PGpnUjiGQCI1leCxf4Dm
         5c4A==
X-Forwarded-Encrypted: i=1; AJvYcCW9ogu7rBCw8ZL7E5WiKZj/ivQTc/IEm683MQu3blenRkDorh38mfZj9Phw/r0QIcnc4PUB+tfAfOE/AvAfrPPeIXwMU641cMGkN26F
X-Gm-Message-State: AOJu0YzP2T72xb27rQlS1hX2SwG1L/5hm8e+7RIWD9XhwkuGfrq+4vK6
	oAXVOxIf+fhqquPBd4hQ/pfmsE5+QcKfvXkkJoAnwrw3V65reX7Fpf3nj2cy
X-Google-Smtp-Source: AGHT+IGayPzkhz9+EBmeobrW/Awobcrf3osap6PdiHKlwqjt6saWbAMpj9ZSWfs/lo+wjn9Am56uFA==
X-Received: by 2002:a17:903:595:b0:1db:4746:5fdd with SMTP id jv21-20020a170903059500b001db47465fddmr5461658plb.43.1709507256875;
        Sun, 03 Mar 2024 15:07:36 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:99d7:8333:f50c:d6a6])
        by smtp.gmail.com with ESMTPSA id n15-20020a170903110f00b001dcc3a46a6bsm7069581plh.262.2024.03.03.15.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 15:07:36 -0800 (PST)
Date: Sun, 3 Mar 2024 15:07:34 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - make rmi_bus_type const
Message-ID: <ZeUCtjGS4BWXb_GV@google.com>
References: <20240210-bus_cleanup-input2-v1-0-0daef7e034e0@marliere.net>
 <20240210-bus_cleanup-input2-v1-1-0daef7e034e0@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-bus_cleanup-input2-v1-1-0daef7e034e0@marliere.net>

On Sat, Feb 10, 2024 at 12:15:01PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the variable rmi_bus_type to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied, thank you.

-- 
Dmitry

