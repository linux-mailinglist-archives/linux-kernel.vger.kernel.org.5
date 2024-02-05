Return-Path: <linux-kernel+bounces-52796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B0849CBD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0A3286D81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4FC2C6AD;
	Mon,  5 Feb 2024 14:13:52 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73A2C69E;
	Mon,  5 Feb 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142431; cv=none; b=R+9o4KYxjgTJvWvDahkX6JZ9TMaJ3bN/lsfhy2XwGEYALz1qAE93bSx5zrAHYaM/Ju9VDJf2MV0iUpiFs1Rwq9JRNchsiCh1lu5wVaUB6vE657S518wxbCy5VmC8knZLjV0ux+k6s6yUO1h/rEnMd3HwNTsh8gqlz+zQp6Wqd58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142431; c=relaxed/simple;
	bh=KUfFaTnVcuPK7F5qH9QCHcEyVuC0AaGY+Jw1pHyJEqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG1AULtwwzvF/13OxX7BgDjRRpk1mQLR+K5lGXnYQ7chjisqNQ4W1laFDKXUCCGFw3D3g+kbkg+BoiyTX/inre45zyLAVJDx8Ouj0iPn7OKkR4eclfsfnsZdX78OxoFX6kDEd+4BNIqNG/ikNXNyp3+km2E/HRlxBb+EwnmbwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51124e08565so6809017e87.3;
        Mon, 05 Feb 2024 06:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707142428; x=1707747228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjZklipkmdXJhUNXYZTkvKzntyfYj7woEZ5k2D/zz2g=;
        b=r/vv+GzicXZVhCNYgJS3EQ1FZV0P5e1Y3R28Fw3HyvSRxNtljmLZkEzoj9d3zytc+9
         d6iKJmV6YCnP8t8fPvVx5HyekdpfUgYB90mYBISK3dPF9HTqMErM3q1rUGPfCPFdBDoJ
         jOwct5lXOWV15qPGRtW8y2jIAt9AMIxrfRrssro4MNC1iLayGP4dinJbceve+fH3QW1p
         AGm0jgylmKq2ICSa+N1TVQHZxLn5W8jvkMnjSkpF2g2IJy1gDGMKDRJ5dzaS2cl2vpuW
         TgdG9kPJERGM2vMOydvbSvv14GX1cHus7ICMcYKmKilslarMkV77Xu9debfJzRx5VHSA
         scAA==
X-Gm-Message-State: AOJu0Yx5FZO56mqqzHXYF75j04ePimHCe+L+IuwWGsr9GH1vIOkaDNtU
	DAEZMVwc7mDKP+xh0Dj3jc9O7ThBuGKRaEpWetjUGJXUn/y+AY2U
X-Google-Smtp-Source: AGHT+IFfz7N06CRxAkudHv29g5IbD95knXgAY5otzcmaknrMnsvP1nrc4pifk7LvLhw/WJSBXE9ugQ==
X-Received: by 2002:ac2:4eca:0:b0:511:5353:2ace with SMTP id p10-20020ac24eca000000b0051153532acemr1285652lfr.22.1707142427564;
        Mon, 05 Feb 2024 06:13:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZPSlNuCnBtq9VsUUsxRgdYjVaIR64sZyNdi1stJYMIeFlt+p0BgNm4uLZgJ+iSP3IbF+Y8fmyjmPWMJ2LCtGs6lWYsuagUDrP+z6A1boNXhHIWEaVoxcYoUxBdXigwGynxUP8cBdbl3sli6KzXoU/eMaLhuVn4mkmRAECl7ip3PRq0Fy4+3xrk1khwVJDOpJwZxcv0te6a7uFDsUDpnQoO56g8fB6mz4vknBv8z3UABNIHf8AxK+PhzFb5vjsvVuVW9DKK4ssXBw12QeuqJF3OQkird8UX2zgUSvOJqoNW9T1iHoTw6YKD9wYI3kEgxbwk9q8WIguBaCDwbqn5HWuvAFAuJPq88M99Cl+KWaUZw==
Received: from gmail.com (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906475400b00a353ca3d907sm4361222ejs.217.2024.02.05.06.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:13:47 -0800 (PST)
Date: Mon, 5 Feb 2024 06:13:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
	"open list:IEEE 802.15.4 SUBSYSTEM" <linux-wpan@vger.kernel.org>
Subject: Re: [PATCH net 08/10] net: fill in MODULE_DESCRIPTION()s for
 ieee802154
Message-ID: <ZcDs/GFkZ881bJR7@gmail.com>
References: <20240205101400.1480521-1-leitao@debian.org>
 <20240205101400.1480521-9-leitao@debian.org>
 <20240205144118.12cdc824@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205144118.12cdc824@xps-13>

Hello Miquel,

On Mon, Feb 05, 2024 at 02:41:18PM +0100, Miquel Raynal wrote:
> Hi Breno,
> 
> Please be more cautious with your titles. It's your second or third
> e-mail with this content without version number. And you also forgot to
> collect Stefan Ack.

Sorry, in fact, the commit you are referring to is already in landed
net-next:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=6aa89bf8ac9a

The problem here is that this commit shouldn't be against net, since it
is already net-next.

This workstream was applied part in net, and part in net-next. I am
trying to focus in fixing all the warning in "net" and not touch those in
net-next. This commit is already in net-next, but, and shouldn't be in
`net`. I will resend the patch without it.

Sorry if this caused any confusion.

