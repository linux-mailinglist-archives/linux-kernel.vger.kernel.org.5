Return-Path: <linux-kernel+bounces-133165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CEC899FD3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFC0285E12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B230916F27B;
	Fri,  5 Apr 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggW49QXl"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD879F3;
	Fri,  5 Apr 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327568; cv=none; b=js7GfxzPfZMOHB6rDc1rzrxySkJNcz1qZr99gbPYogqhzO5yoiMbIkzAGCzrTd9Hej8bri89+pLFiz1uyCuQgV/Bu2pESrftPfkfRsUTZrLXQOZ+t8T9hWfLRXR9/77v9y6CWWIhjGyldH1Kfpo61FthhyLgLKfjhh68JzfJ4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327568; c=relaxed/simple;
	bh=+oo3aoyeQYFyc18BS/Ko8Z7rugy4H+kTpGy/XFlZNaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtN2oXrM8GFl7o5AfvgJy9vZEgwWGSywmQmnVTRM/6UZOe6YDoE1Orm0gH4aJAwQ11AtdMO+TALE5SXcEAube5S9udZooyxYwizswvM1nKo7MI2byUIzUn+Z7njiElSlODHzG78Elzy0AZ5Pczeoa4eJpHDs3BJ6YOAleL2kHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggW49QXl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e2e09fc27so1464662a12.0;
        Fri, 05 Apr 2024 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712327565; x=1712932365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BS81x8TgiZotkdmg7KJCaBTl5pwcK5PQXZyvnJwjgzU=;
        b=ggW49QXlevp0AievJMN1YSQ2eBmP8twPi5t7HqxnCoVRNQaOJadgQOsRfxu8/cZHiN
         Ei+/LALmMcZzZ1BjXELKV8FJFiFqX+oPS5c65IiFeHWGfYpgG0Bdk1u45W1J2IYt4B3o
         c3LSfZXk/A6hafj0PW7r9ZnWLZjSSOIP4IjQBUBKMbEtWl849hx/xCG3cHe4Dj2BHTkp
         G39ENaX+b6/ePlSBMFsTucm+u7enrvVU5EEsPHn9iNUN3A0FkbMahtPFJvN3Fzqkww3O
         EvbmNr9hK1PHJgI1dn0YcFmCJXFnry+ym9AGEu/VghQ/VtIJFJsdLwmRtbOaKBQPs0Yq
         Pjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327565; x=1712932365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS81x8TgiZotkdmg7KJCaBTl5pwcK5PQXZyvnJwjgzU=;
        b=FMZJA4mEDi9wBgQoAlasqCLJ++URUcWX5nDn9FZ0re/gp4+Ry8XqXenmMW/eVDXvOH
         yHgV7sYPakg3D5VoR9sDbAcuSLu3QD2vn6TlV/oQvz/xgljpzYTdPInGdmOuacYVZZS7
         MkBBhd/mTFgeGkkv7IDHTIGRelvTDiqNl4jzaLRTemCeqoBq20d+bOsWgu0TssR7BkPU
         gksd5ZJcffclKkQBUvv2TZK7Ytl3VKnpRBBItuCASaztzZg3ivDTmxinQSNB8FFZCChr
         /qG3x5UWx2q3+QLnTFdjI+FCJ5zUGRt65jlKEicNRoD/ad+ddPHUfR8ASdAO9qhd5f5H
         pryA==
X-Forwarded-Encrypted: i=1; AJvYcCXsPC+YufjxWgRPhvfNMT3D1lkMD0M/wmH8q018RneUQgCPPdSxKs9VsNYJYmDqJxq6pQgvIzu/69qcKOHoctpnbnTD9LVTm/T9kcsO
X-Gm-Message-State: AOJu0YyG1ro7r4Lhc3++pfjwC0/fKXtCzAy0c/b05Gi7zMwJkZat7aNn
	itnqhR+Qv8GZYKWm8d86qoNPMNcuZBTuhcXKDesADZOyIsfv451+
X-Google-Smtp-Source: AGHT+IHknrErSLdjdwLAoXYuvvbyExzg4+NqILRcgR1gVkWXerNNZU/EBW3H5xt1vN3N51pBrlnpsQ==
X-Received: by 2002:a50:bb29:0:b0:56d:c85a:7893 with SMTP id y38-20020a50bb29000000b0056dc85a7893mr70911ede.8.1712327564348;
        Fri, 05 Apr 2024 07:32:44 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id h1-20020a0564020e8100b005682a0e915fsm841041eda.76.2024.04.05.07.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:32:43 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:32:40 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 01/16] net: dsa: vsc73xx: use
 read_poll_timeout instead delay loop
Message-ID: <20240405143240.rwm5klyy7nm7lvdm@skbuf>
References: <20240403103734.3033398-1-paweldembicki@gmail.com>
 <20240403103734.3033398-2-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403103734.3033398-2-paweldembicki@gmail.com>

On Wed, Apr 03, 2024 at 12:37:17PM +0200, Pawel Dembicki wrote:
> Switch the delay loop during the Arbiter empty check from
> vsc73xx_adjust_link() to use read_poll_timeout(). Functionally,
> one msleep() call is eliminated at the end of the loop in the timeout
> case.
> 
> As Russell King suggested:
> 
> "This [change] avoids the issue that on the last iteration, the code reads
> the register, tests it, finds the condition that's being waiting for is
> false, _then_ waits and end up printing the error message - that last
> wait is rather useless, and as the arbiter state isn't checked after
> waiting, it could be that we had success during the last wait."
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

