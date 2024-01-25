Return-Path: <linux-kernel+bounces-38469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B17CC83C094
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09036B2778A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D8259B49;
	Thu, 25 Jan 2024 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7WF2Ibo"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484591C16;
	Thu, 25 Jan 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180513; cv=none; b=in5w3c6T9tDRzQ6XinlIUOCZfz5hG0f/teTfOlcmqSQ/y7vLUUXZGoBpPUR4LTjAjfkBh+POGLd1EhRbmH1wOTXJD8eetl559kkTe4rjtvwW37dwCiuSnCB/8lTZFttjoUvKGObgiNsMEqkH5wWJLDtfI5Op5lJNG2sxkFrhfyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180513; c=relaxed/simple;
	bh=CZvtojiC0XEHWqTBwc7RTmZP9uSs74MPCzz4IDlB2Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAZxMiJhCdxNj82cRWnSk/5yIqAA+gMG2Nxxd1uhFKLDy+hq63ZvZAoklSsxsHm4GhWY1KV/j4MEkDis3JZZxVg34Hk48jwGb4a1Ie6NwIdrQfxEEVlxAXPH8Yg47HY4TEEvSdCVO68ZHvynHdEwx7M5YmtllmO/HS49xQ+6/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7WF2Ibo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5100fd7f71dso2386956e87.1;
        Thu, 25 Jan 2024 03:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706180510; x=1706785310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=miuHCVwgH0ReGM1PaYlhcfq7/djqKFtBuYNwdTBB2rs=;
        b=O7WF2IboPkiL62qQinMC6InYGnmFuC7YfXkbagmlOav0nOg571nO+d0/d/Z7nfJMvB
         pS+o8WKF4z/IM5RqQIQ7vY+bmSPxVkwnsgiP7g3C+HrxfPxChb92EErygT3wswTFANSc
         Kf9NDTHOMnbiN2u3PKhwxm/No1/BGVx/ycFfTu+yqAX+1kOp9eifjUoszlVaS+SAIOyS
         CUx9+ZfDFIxeHiuzNL659i5CfS8KXh9+44rOA8V9RTsUPOHJSYJmSyjFhcg6V8gImZM7
         JRQ87+BY9cpDErYFW387suMC2yqN+YGD4r7xTLinj+V+I5UFeV1EaEDoEbVAwcxMhOLQ
         4wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180510; x=1706785310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miuHCVwgH0ReGM1PaYlhcfq7/djqKFtBuYNwdTBB2rs=;
        b=pHARuzsYnNdj3mSJVsfHjQhpIbLGwxkhD3as3NQ4K4dWteMQ6KNefd3bcqeYhECXCl
         059KkhQSdQzuwmRFGzPLhgUmT8e9r0tdttcfG8fzZYE7uqhLMqG9gO7KTR+YmwCzQaxw
         PIe4lIg95TUwdtbwytX10rOd5mdi4MBXXlf9B/DsdnJbcj9rZLJ54l+cGUQE3PNOkjhm
         yJQB+fG2cGDcTSUqQW+xZ2pPJpI/zTZqCfITKfDSZ86ujIsuggJASFGfhZ0rrDPKeqCZ
         AexquqHThLqc9b2VZGC9kyKqSCGHT0ft+yA8ePY5xJPMamraRK0N9qs6hSWuIcYDdY2w
         zdDg==
X-Gm-Message-State: AOJu0Yy/0MsjMs+2Xtsa0HFNRkkq+6cJS0Fu7hWIaS8FkgK6T4xy4DU/
	dcTxhC0ry1ib0XBWBaqj6mlWeSvyAk9OFrglRyqwlX8coIQ7zTUs
X-Google-Smtp-Source: AGHT+IFlB2MgGLnpQeRwCJpsgL6fLkk+sNLY3XK5121CEnUBfLxwPC5+nWSbyXBQ20M00lfQUDSEkQ==
X-Received: by 2002:ac2:57c5:0:b0:50e:6317:54ab with SMTP id k5-20020ac257c5000000b0050e631754abmr324729lfo.42.1706180509935;
        Thu, 25 Jan 2024 03:01:49 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d14-20020a194f0e000000b0051006813733sm766441lfb.86.2024.01.25.03.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:01:49 -0800 (PST)
Date: Thu, 25 Jan 2024 14:01:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Furong Xu <0x1207@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net] net: stmmac: xgmac: fix safety error descriptions
Message-ID: <3aagjpld4v7u4cfj3lge5rg6v6ro3ehnstjz3jfculx3vdpbvd@4y3hw7v4idhp>
References: <20240123085037.939471-1-0x1207@gmail.com>
 <ii3muj3nmhuo6s5hm3g7wuiubtyzr632klrcesubtuaoyifogb@ohmunpxvdtsv>
 <20240125103454.0000312a@gmail.com>
 <c37feb621fa3f7867af8d97ffe36f577966ba3ec.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37feb621fa3f7867af8d97ffe36f577966ba3ec.camel@redhat.com>

On Thu, Jan 25, 2024 at 11:09:06AM +0100, Paolo Abeni wrote:
> On Thu, 2024-01-25 at 10:34 +0800, Furong Xu wrote:
> > On Wed, 24 Jan 2024 17:25:27 +0300
> > Serge Semin <fancer.lancer@gmail.com> wrote:
> > 
> > > On Tue, Jan 23, 2024 at 04:50:37PM +0800, Furong Xu wrote:
> > > > Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> > > > XGMAC core") prints safety error descriptions when safety error assert,
> > > > but missed some special errors, and mixed correctable errors and
> > > > uncorrectable errors together.
> > > > This patch complete the error code list and print the type of errors.  
> > > 
> > > The XGMAC ECC Safety code has likely been just copied from the DW GMAC
> > > v5 (DW QoS Eth) part. So this change is partly relevant to that code too. I
> > > can't confirm that the special errors support is relevant to the DW
> > > QoS Eth too (it likely is though), so what about splitting this patch
> > > up into two:
> > > 1. Elaborate the errors description for DW GMAC v5 and DW XGMAC.
> > > 2. Add new ECC safety errors support.
> > > ?
> > > 
> > > On the other hand if we were sure that both DW QoS Eth and XGMAC
> > > safety features implementation match the ideal solution would be to
> > > refactor out the common code into a dedicated module.
> > > 
> > > -Serge(y)
> > > 
> > 
> > Checked XGMAC Version 3.20a and DW QoS Eth Version 5.20a, the safety error
> > code definitions are not identical at all, they do have some differences,
> > about more than 20 bits of status register are different.
> > I think we should just leave them in individual implementations.
> 

> @Serge: given the above, would you still advice for splitting this
> patch into 2?

Preliminary I would still in insist on splitting up. I'll double check
the patch and the Safety feature implementations in both devices and
give more detailed response to Furong in an hour or so.

-Serge(y)

> 
> Thanks,
> 
> Paolo
> 

