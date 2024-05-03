Return-Path: <linux-kernel+bounces-167256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14238BA683
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A12823F7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886713958A;
	Fri,  3 May 2024 05:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hckp1U3t"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A4139581
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 05:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713113; cv=none; b=r5mMb/GW7IZ1VMsAI4BSaUIUSPlqfxCcTwuB4YWgfd3mZSkJnDYfdzUvYq9h7zXvHK5md9GsujTwZH3Iy0SIBCqqtCxwVhCEYwQnN+wszUGfSbeo3sDSv3UGATe58Qxv91MkYJCf1EAjjaNohUK6L7rp50nJdy5u2zyaycdIW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713113; c=relaxed/simple;
	bh=4IFUujD0WtUytHMnCa5Oq26awC+SVnMB+m5+QMpSIrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1UMkEeW0sI7VNnjW8DmoVpYTK/HvrGoo6CYMcLchNiPc/ZVsnS9Cv5fE7mKDA7uZECde7MB8nlcT0oo8EhJvQ5rfVjGWadWEEt9Bow5EMtCWkZtLeFrmpcrZVc0YHVLyUWUR2QtFm+6hakVr/O1gsNSTh7cvuiXymIcRzwtvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hckp1U3t; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b79451128so51756445e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 22:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714713110; x=1715317910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ52txFEn84DZ4Gx318II2hjm45dLlkgVXuI6MMj02M=;
        b=hckp1U3tOXxRX0r+FHs4fCYqqOuurTULLqYOfu+oXH7ivDw4+Vas/tRrUev4BDbF/C
         R/hGkGJ0W7rmLNZu9NW5WuTO2l5LDnRDeGyeQNArOrJkG1HEK/ORUFxdrX3SpQDvzlb9
         vCP17nipEOu7jEo3NDRhRvTA2POyy830uj7ty43YqEU9MjwZc7E8gCbxYMaxir4ksYz/
         AIHezR0gb4aNX8iC6rE/U1KvvUcrLJimooaz9UXjTrYHGahwSxXP6vwI//QU+odLHZRY
         ++7Uoh6wan3+Q0LQYe8ACMK6j4W/yjBbvLnHAfeLuElTVWtyqM3mTurfLjsv6w01MAUm
         qKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714713110; x=1715317910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ52txFEn84DZ4Gx318II2hjm45dLlkgVXuI6MMj02M=;
        b=RS4pJNk6kZdXIUNpWg3D01eglB/aDMpXQAQ76s+LIN5KSUQ9dOEdoZ8f7KoPEKaqX0
         3Jxa5I358fNAuID1cE1ZctEavJK5bZxlU+6LzD9ep+UWtHBSJDGXEDiwlj+qJE74UlEj
         +beC6Dtwcuzq3psZPKUDN+REMC5BlpRfJYb7skHJvmeIkW1bRM0L4DkCwx5ebKEHpESd
         Hfau1MjuD7ygq5VIbQOddKq8h8aZ0kllLC6hky8yQhIs6gtPc65z6LcfHJQ7oSAV+TPu
         5wii/nAtsPiE2ZtimKRZuj5qr4Jm55Pi27tKv/5lAHohWpSC/P1DZUkPiXKxLzc/3wG8
         DwYg==
X-Forwarded-Encrypted: i=1; AJvYcCWbdhGzAhEUyk3cbxob9wGEqL9kPlc3wr1HQmuwg2SJZYSmgyn/80AbFzzDfhn/x8G4GTffFHuM5pbGex50PmmHNqu85F1/7uCY9b1a
X-Gm-Message-State: AOJu0YyQ5VEc+Ihx/fS0qq08TNU84ygjpLiEo7Oq0RDW9i2IL184OXlP
	pRwxepY7LqOmaitKbtdEHfUhSoyNLX1b7MpQDnXBtzIj6vCccafO2hu65FTlNQOWshyWrajSTsg
	R
X-Google-Smtp-Source: AGHT+IHlVU6WqV9hfbm78/kvRSpT3qBzDU+6UDBfCiHBW2deYrVDpU1cdv/gO3y+VfA5WQLnrHXNhQ==
X-Received: by 2002:a05:600c:3c93:b0:419:f2a0:138e with SMTP id bg19-20020a05600c3c9300b00419f2a0138emr1271927wmb.34.1714713110268;
        Thu, 02 May 2024 22:11:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b0041496734318sm7964771wmo.24.2024.05.02.22.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 22:11:50 -0700 (PDT)
Date: Fri, 3 May 2024 08:11:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ashok Kumar <ashokemailat@yahoo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: fb_tinylcd Alignment to open parenthesis
Message-ID: <37db687e-ce7f-4f18-8464-f9b04226e14c@moroto.mountain>
References: <ZjRDUO6/M+RDCcQJ.ref@c>
 <ZjRDUO6/M+RDCcQJ@c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjRDUO6/M+RDCcQJ@c>

On Thu, May 02, 2024 at 06:52:16PM -0700, Ashok Kumar wrote:
> Corrected coding style CHECK: Alignment should match open parenthesis
> 

The original author was aligned it deliberately to improve readability.

Just ignore checkpatch on this.

regards,
dan carpenter


