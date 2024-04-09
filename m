Return-Path: <linux-kernel+bounces-136339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0989D2D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789BA1F21447
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F91179955;
	Tue,  9 Apr 2024 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUyOliSU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB101DFC5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646663; cv=none; b=uASfLhcPjHmF6KI2bk9r0FXh7VhizR1e7zD5CpdAFY0x8OWnhC7e99vF/XBzlHGYyCpp/W/z+UFlHAysKHe5pbU/MlPpTWbTHT0bpFVrKp7++CPP8Buj47mvZIy4AgnlOV4+vLOLGv0HQce/6qYQXgWrfAsAkSlTCikXcJa5BVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646663; c=relaxed/simple;
	bh=vxqtjjZhNmxDSYl1zjr1PveROiGsx4Ga03/N7ZpEpKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvL/TBJ6iVL6DDKRb3d8KSUfzR07zQoaPzJMacrEUzO1EjSj/D3rxo+flU52k+VZp0GxQ/UuX9yvu0u1lj0iWA5tj4NHj9fYQ+b5Qm099OJUUWFQqEGEE5G49z8BcuFd01uC3jOQxgEnewoaplbPuXs7FHFPvHZkkyONizT374s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YUyOliSU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4644bde1d4so723697466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712646660; x=1713251460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIHINBvcDQZFvc46BboQQb5Ddni1aJUuI/LFrScFQmg=;
        b=YUyOliSUk3ID7Kx62+gHepOF5QlptkuYsriH4zOOSKolWajmcUlUE7/1/epQnYGpqa
         VIRBLr49o1MV7xJE6jhle2WB4Jt9dhEDvaGr9bgQVTscE78ulLCgc0EEYZiEldW8cq2C
         l66npmuhVv3Z7RoUd9Z1/wRQlfeOKQqpGoDYwmtmU7PJm9DzN4LxOKwIpiAHNZOe+vDS
         QC4NuPFohQ1QFGA7NZx+Q76SuD44lxYvOxDay/xO0fH81cTfoA5kABitBn3WsrY1lplf
         YL2brgbHmn7egqltRK/z+flv4LwvmydGh3IsqNcUW1kvRhx5KfyD2Don2lEyauHpmjLe
         cUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712646660; x=1713251460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIHINBvcDQZFvc46BboQQb5Ddni1aJUuI/LFrScFQmg=;
        b=iaxfudUFfYIV/H0E2buKOt3gG1AX8d84BctC7VAV9+Ddx3NEmtfrnwDYsR6RCnxbFH
         fkW9sdnSiCE40Zrl3Yhq9wRujY4XjW0v9EiQ7TtNkeNlFoDCnmjsaE8UytCkx2JQW/Jq
         rvMQ2fYERP9DVphHdD+1K8S1SRt8W8NR0DYAEa1Q/Gy9bfo73MtI6DMDWZ3eUe1R9M8m
         sIERPM54Fob4NFJwpXMllozTpxnA6pAyNMA0fJubrH2KxdbyzG3Yf53e26c+qk/VOYdx
         OLx9RhV4ESBUvIQDWrhHkt0E2I0h+lp3KATt7bThChtgIwHXXfAeeA38O+rhIyQNst6O
         IHLw==
X-Forwarded-Encrypted: i=1; AJvYcCXpAmq1p1H4ZS4bEkay0X2YrbQTMbkbOfwwZccwk31mljiCJKSKkiDofgpSjrtuECxV0gBg+AMxVv9GKk3MShAhmPhDcSyvsdKy40IA
X-Gm-Message-State: AOJu0YxgGWwB8WFVZlfnk1UpwQCBVHdbLZfqUoj1u5oEQdnkf9bUrVgT
	+127k1C5rQVGKuKW2obgnNFvtaD6WND9/EmZ+Z0TTtJuUSeYbPESRIlmNF5zctM=
X-Google-Smtp-Source: AGHT+IGzOQcvhC79NNrIeGfJCRejYSWAoFYjcKOpWljG4vVBYilGi0oqz11179BSFwo3nmvBc/cY1Q==
X-Received: by 2002:a17:906:d04c:b0:a51:b23c:1187 with SMTP id bo12-20020a170906d04c00b00a51b23c1187mr5304136ejb.12.1712646660261;
        Tue, 09 Apr 2024 00:11:00 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709067c0100b00a46aac377e8sm5318722ejo.54.2024.04.09.00.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:10:59 -0700 (PDT)
Date: Tue, 9 Apr 2024 10:10:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Erick Archer <erick.archer@gmx.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] [v2] staging: rtl8723bs: convert strncpy to strscpy
Message-ID: <3d8bf8b5-d8b9-4621-bd82-e51e844fd2d2@moroto.mountain>
References: <20240408194821.3183462-1-arnd@kernel.org>
 <20240408194821.3183462-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408194821.3183462-2-arnd@kernel.org>

On Mon, Apr 08, 2024 at 09:48:10PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-9 complains about a possibly unterminated string in the strncpy() destination:
> 
> In function 'rtw_cfg80211_add_monitor_if',
>     inlined from 'cfg80211_rtw_add_virtual_intf' at drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2209:9:
> drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2146:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>  2146 |  strncpy(mon_ndev->name, name, IFNAMSIZ);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This one is a false-positive because of the explicit termination in the following
> line, and recent versions of clang and gcc no longer warn about this.
> 
> Interestingly, the other strncpy() in this file is missing a termination but
> does not produce a warning, possibly because of the type confusion and the
> cast between u8 and char.
> 
> Change both strncpy() instances to strscpy(), which avoids the warning as well
> as the possibly missing termination. No additional padding is needed here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2:
>   use the two-argument version of strscpy(), which is simpler for the constant
>   size destination. Add the third instance in this driver as well.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


