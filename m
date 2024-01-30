Return-Path: <linux-kernel+bounces-43660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA2841757
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B86C1C232C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C567D266;
	Tue, 30 Jan 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+GWtsjO"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9DDF51;
	Tue, 30 Jan 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573527; cv=none; b=LbKYEmkBrOWt9I1+Hh0c1SSx5LlMVXGcTt1ULmq1H21dsosQBRhx+2AYxDQT0AnxZ9S4B6z3Q+r1kJqL4l34RAr+8m+XLPHBuxjEn6U6IIYBDOCPwU+of/t7DqX7X3seEDicB0lO+ODXwso0rlmf2wY83q36XtBtsSgJk7ksIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573527; c=relaxed/simple;
	bh=7WwhF69nuEoT6qM+4Qh4Ybkyowgs8m887Z2Bc/TwfB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jB0f+A8i6kNal0mDIr6KEGTz5apioot518k3/jkn4NXXiHXaHDXOnKGuhnB9n/8Vz3Wv+KEeHFVpvQh4UdZJUmqyzHUt9SzsZ8tNmvyKCl11IVIWcBsQugulrJSAn5HsM/9Y6Gs/3Wch2+VQipQZu2eM8yY+4PnWw0+1ttsaUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+GWtsjO; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4bd9b71456fso579297e0c.2;
        Mon, 29 Jan 2024 16:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706573525; x=1707178325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hpc64mlk1JrWp3Y7/cRi9mFL822Vughz3f3V+hqyd1I=;
        b=H+GWtsjOvYMR9CTzvjw1CpO47nBDOEIRaLan9kNSHHmh3eU/ubYISTDoSGZjMTSHzD
         1m3zST6QFWP6OZqtbjnmKwJStX8MatXJPP1WcedFpG6wnuzBP7klI4Tv5+3QBTMsSDBL
         UGW6TDjGrcX+TXMS78KcZpoZ49jR+kF2wXk/pjmcW1kHPYUmRlari+hRXgyH4Bt5njx+
         2ZwgwpCCgh1Ch6nGef/EzfkoRi0jKu61QtztHrAmpXxPyQd9bnCI/fkKh6Dzwas+/UjP
         PsGJg6ME8m2lvShd3u2EnEue+1Mk0ElrbJL+BTajo6Ssz1hgj4+Fzw+PktOfVl304WXD
         1kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706573525; x=1707178325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpc64mlk1JrWp3Y7/cRi9mFL822Vughz3f3V+hqyd1I=;
        b=BgAQ//ljmi6YkoLwi7ZI7CWWpq873RJQoo9vt4ZOwWQDkXex7nMbmM9bCIemIexNWb
         L0q4MYO4rYXcoDObfjnQ5BoqOPVcgR5NAXUtSPkwaz3HLATrbBTuKda8GpH+tvLP6v+K
         rpR4Vl3Q/zfB9EeazuEaOG241I6nkZt1VJYBXChnGJE6zRhTXyVImg2vWClGwaPOWvbC
         eQ9hAl8Yo5V6WYq3Mi/4xYbR4d+ixxfoRCSDTWvGU1TLRX9XNRgqQMkzKWk6iFkLS2dl
         bx380KzZxxNR1kccOJWzeSQ94QweJPcRq2E68+4zpoliGbVPPaMTA4W9MO8p9xEognZd
         URbg==
X-Gm-Message-State: AOJu0YxmftXp1Mxa1EtTI0jR1wKVg/i/atNcEjZUjYbGtWXIGtBrsbbg
	fLER+JqYfEtL+Q1zBiLtq47ELGhrN1ASIeZLQr46ox7T772eZ9xHRTNdWNb1GQWm9a1gzg56geb
	GzB/C9pjNU84ulAbd2AieyMyuuWc=
X-Google-Smtp-Source: AGHT+IGlL28pYh80/KwcIcMBVX9zNyBUInjdWBaZ3cuQcc5GdxPBPTdE5IqnPapj1z6H3+Pjw7JcvPYT45mtaOt3/co=
X-Received: by 2002:ac5:ca07:0:b0:4b7:363d:89fd with SMTP id
 c7-20020ac5ca07000000b004b7363d89fdmr2438034vkm.33.1706573525227; Mon, 29 Jan
 2024 16:12:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129170016.356158639@linuxfoundation.org>
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 29 Jan 2024 16:11:53 -0800
Message-ID: <CAOMdWSL3K6JQKCvY-jmkfLuNgDhetLYShdgoTPnJOuBzbQUOuQ@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

