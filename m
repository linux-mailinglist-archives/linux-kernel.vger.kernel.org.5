Return-Path: <linux-kernel+bounces-162160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E48B56CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C0EB25BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368065490C;
	Mon, 29 Apr 2024 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="S+BAcXuo"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088F753E08
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390408; cv=none; b=QdLRKbqbe5bPpdknnGaBX21a+UI+ojJLfEWjX/XAEO5RhwFEfwYOCYra7x+2jjVgi+mugueuJXw3THqaLsGyCtnhPD5ilN2rSehDjXE2RXuWOScpV3XUSaIBrOP42VRzR+/Rrlw5WDRmGdw7uP7SLV9B69DqPG8Kqy5f/n66nz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390408; c=relaxed/simple;
	bh=T5u2lMKvu+j4rBpymuN81EhS/d6sMpdsy2QjZnmZ+W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjWXB1j91uiE5xrB9r08UxFgI/fBWHXUx75hUvu5Vzr36lEQ7XUNGMgA9EPqtVZRlz76HBZnTSpK+E4gi8dvOaPoOjtyvFn/D4wWpHG33LD3phgglI3slbw9iUK45LFn+zscz8IDdfMTEs+vKifNciZj6BXfv07bAwYWm4/1dpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=S+BAcXuo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55bf737cecso509841166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714390405; x=1714995205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5u2lMKvu+j4rBpymuN81EhS/d6sMpdsy2QjZnmZ+W4=;
        b=S+BAcXuogMr3EbjGi0NsEe11vAJOa14vjCQE5bdZS94cf1+kXh/5PiDwJhO7ZxvsJF
         yR7dsZdCJHXF6DsrSla2Bx8bpbKfaqU6nmlwi33T7NC0uV+gPEPv6zWPkgIYit3dcTF9
         kLr2X+KGbsB3Uy2KJqUKognFon+lES6tvhnnFswHp+x4BLtol2GUE+SgLEIbZY7e7y7h
         W6y6WhdMWzWeshT7jTKD9J1Pg6PQwgQZp6n/Rv5hMnL+Jri5ipqbbOB2sSBIWVfxoMwG
         LxPB2/4H3+P8k9ipHPFuhPRqt+CXnxaOq/fNVkfF1TwE4KWnL8yaNyZadjUqyymyJ02L
         p/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390405; x=1714995205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5u2lMKvu+j4rBpymuN81EhS/d6sMpdsy2QjZnmZ+W4=;
        b=MF/LaD5U1DxwzECNKZKkZJG1RouliqRMPAm0h28nrYEd6iiRA5EKIWspkNQFaU+jy+
         wzNW9RI7TAYFKQn6XI8/cm4/AFOHUS9+YbzFMwVfVRYjBlrNa4jqhx85FNUp6uZo8Sc2
         qyKVV/vnqKfoEFQ2m50A9tx3QXUUuMlgk6vTF4VGERSOo5+18tsJQFapirUeJb0OFjqt
         Ct3G0oONM7zSo2RJaliFtesFfIOjZ4JSTbwW5WJ53TAZYH+uGcPVBqDnGm4smUJhGIIk
         gs1NMhQ/IwI0JdF6Wq9jYqIiYc5TcVtgfDTp1aToc8kCzFhca/xBeJrU8rm6am6emFtP
         5CWg==
X-Forwarded-Encrypted: i=1; AJvYcCWodbOmA+J1v83kT9PrfrV3xZceU23+To+WZQYfuy8hlCEJo7Fj3gpiCvUd3wguZge7aOBybChWfKtmh/4V+92h35UT2v2pm+gXbthc
X-Gm-Message-State: AOJu0Yx/3VU0bDtFw3OqFMRqX3ExQYqipvLajVfCM/8xtMAnoiaIP2tX
	94gsVKfvQQW0J0/OPXKd+3Czitrc3tLLYVLH1N9GlMI/21B6L4SdC+uPPCHkuBQ=
X-Google-Smtp-Source: AGHT+IFdbXEljyCuu2jaPB/O0NFSFiDxHx/SCaRq11wR98P+PBd/51MdfM5cXCYE/OmPvqH1o9qaMw==
X-Received: by 2002:a17:906:1ec2:b0:a58:82b3:9b88 with SMTP id m2-20020a1709061ec200b00a5882b39b88mr5855057ejj.37.1714390405113;
        Mon, 29 Apr 2024 04:33:25 -0700 (PDT)
Received: from localhost (89-24-35-126.nat.epc.tmcz.cz. [89.24.35.126])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906309200b00a523b03a1edsm13711103ejv.20.2024.04.29.04.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:33:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:33:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v3 3/9] octeontx2-pf: Create representor netdev
Message-ID: <Zi-Fg7oZBCtCvbBA@nanopsycho>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428105312.9731-4-gakula@marvell.com>

Sun, Apr 28, 2024 at 12:53:06PM CEST, gakula@marvell.com wrote:
>Adds initial devlink support to set/get the switchdev mode.
>Representor netdevs are created for each rvu devices when
>the switch mode is set to 'switchdev'. These netdevs are
>be used to control and configure VFs.
>
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>


Are you still missing creating of devlink port as I requested? Why?

