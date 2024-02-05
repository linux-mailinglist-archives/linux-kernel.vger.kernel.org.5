Return-Path: <linux-kernel+bounces-52060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6CE849390
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C2F1F21841
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380AEBA39;
	Mon,  5 Feb 2024 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elp3gARk"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5531173A;
	Mon,  5 Feb 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112318; cv=none; b=KOXgbVdlkgDwxSYN0HgUc4voYFOlxu3qhXRW5I/6sMo/Ulq0VF3w+WXJOhlKCpL0k2E9Kqy7Befnq/6UAHYSUlwejuOKldMLnpwgIDdHZFhFEyxWu0KN5kc6qKEVVlHgAquelpZohXhi/ZSMdWy/y1dgMk4j2dHzAk4P6VPEmzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112318; c=relaxed/simple;
	bh=zTlG/e9j4wcqBxcG/1KrYMGKvFdWq5EvgWx6vmrw3rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juDF/WzkXORG9SCYVRQPNUgCCupLxg9/vKvc4KkkE3n9eO0mwHZNGSwA+3lolJv9cim5m3IYrb7E/QMIJPvJBAEhEAPbjBsRErKRDflbB4GgJp3cRUk1r6NDVdgGFDFQx+SjpaLrfy9qbbQZhHlxPQJUiyyiSTog80W03YNz7EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elp3gARk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d958e0d73dso21168725ad.1;
        Sun, 04 Feb 2024 21:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707112316; x=1707717116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpa/Ht11fwiOl8ZCYgt0xVEvknd+c7k79X7GVQlpg0c=;
        b=elp3gARkENbgErH77Lg8COKyo7lpETCsJEJZrMxK41ysxu8DYPVp40PYzan98Ng7pP
         HvFQcZW/2oAv3RyDiAhAgyMLFcq0D3LNvv7JTbtzfl2RtJRFHdA1RYTL1XCRug0KKBEJ
         uzHJTbteqeOq4FhoJUdWM8eOIgnIJ3VuoQmiMS8zbyNxT7IAPY2UtKXa7o912xofly0X
         GyR8pN8+A2WhKgwyXCS/LkfoQ70Jvf+AgJ9TwXRixN8k4f3dgaiN7GDv+GkbigQxtE7J
         EETf1Lf+Ko2Z4yuZjEkVmP493APWZjjlCCAGEz3UuJzGPjNf1rU5a+p1p6yHN34hMliq
         nw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707112316; x=1707717116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpa/Ht11fwiOl8ZCYgt0xVEvknd+c7k79X7GVQlpg0c=;
        b=syP6pbkoRuvAhhu/jl5GLbDpB3HsPWLwCC+zTvcgQRe32wdsfQTwFqWxpQ7he+u5Cz
         o+9TucuvNpZaR0xNp2/uu3c+681ouesBM1cCJObZ7zDN+TNHotbSPn5LgKbldezM4jhB
         aDt/qajf5kqWhO/Yd7VIZ/8WoMv+EDjz4TM/VbrZwAi9eQJ/Qq5Iwidnq7YkBmrlvUKW
         vscEQKLbi/8mzWDbJjH53wnYL2ym5dKHl2v49iTvllfiDU1U5EXkCz6i5JP0ieZmRyvq
         mC4WkVPz/VmXdgVe+MZLJoS5ZiXh674Ke8+8iK3GME4F+f+lWjiRs9LZK8sNeVdXfAF/
         wLuw==
X-Gm-Message-State: AOJu0Yz5UiLbQZHdp2KJvqaWq1O1IgsjjpjI85evgpzGn4SO1ye0CjCE
	1xdX9GnXiRSSsDoMTDOaQKmF5xC4KHpM/XRu8uQJphJnDxrNpSry
X-Google-Smtp-Source: AGHT+IHV7QwLuC3SMglGmlHDRagMweVZB7U55jJTA35cfY6LR38jHGRLCBJQO4PYLUZ/Ea2rWCnCsA==
X-Received: by 2002:a17:903:608:b0:1d9:6092:ce6e with SMTP id kg8-20020a170903060800b001d96092ce6emr5383625plb.2.1707112316175;
        Sun, 04 Feb 2024 21:51:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWro1HyBkLnfs55Tg1aFPrKcVedKuVO0cABGQblj8lPJ6HnOhdYKD+lr7r7D3s6zzUevPdwBdNzlfKdyhWvO7Y6UR16Gt+Nv9x2wU8ilJdVDMZiaqA7YapF98d3J3ohK71fKsinT2Qlr60VQ7FtjY8a4S8k5TKVuqyprXgpl5fGh0kdfBXoW3mqdPF27hrdH8kKexe0mZzy6XErC4cQYGPD6my1zSkAs3zK9+Of/VFaeMFzDc54Nevxl61pw7vVSILvlc3Rqds3QzOUHC1aX1uYRz15naJQv9+nclKRfGASvjz4171z3ClqnkQu775O9IRmRDa7I2qAv+Xx2e63AmwdrsHA0EgC/q+qdHlLZzyx5ntXuvM56guy
Received: from dragon (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id h9-20020a656389000000b005ca0ae17983sm5275295pgv.8.2024.02.04.21.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 21:51:55 -0800 (PST)
Date: Mon, 5 Feb 2024 13:51:39 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
	NXP Linux Team <linux-imx@nxp.com>, kernel@dh-electronics.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6ull-dhcor: Remove 900MHz operating point
Message-ID: <20240205054917.GB804317@dragon>
References: <20231221164633.2029-1-cniedermaier@dh-electronics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221164633.2029-1-cniedermaier@dh-electronics.com>

On Thu, Dec 21, 2023 at 05:46:33PM +0100, Christoph Niedermaier wrote:
> Due to CPU lifetime consideration of the SoC manufacturer [1] and
> the preferred area of operation in the industrial related
> environment, set the maximum frequency for each DHCOM i.MX6ULL to
> 792MHz, as with the industrial type. This is done by removing the
> operating point at 900MHz and set the clock-frequency to 792000000.
> 
> [1] https://www.nxp.com/docs/en/application-note/AN5337.pdf
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Applied, thanks!

