Return-Path: <linux-kernel+bounces-38838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524BD83C707
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE4F1C22B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B005D7316A;
	Thu, 25 Jan 2024 15:36:18 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182AF73170;
	Thu, 25 Jan 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196978; cv=none; b=BDuxp8kcmTonmdI7PKIFpC3O/Sa5NBOqnNzu5nw0uqLQweQ40gZJsAagyJK5BKOR4jvT/zCrISFWkj2lJdhoHbn+YCE7Tpi5vPY8UxP9TUpas/sO+YXvozi43iVLLiu5qgVjKNjQFxRT8UlN1Ifqm4yedjQ5RQ9jEFc4/jO4Gzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196978; c=relaxed/simple;
	bh=Fxq6kkiG+dJZ/VNJkEc06gi+jmyZF2rGKm1JWnpOm5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rp7n9F4Wq9Lfycs/8GCvmGoEXkh0gj1aMW9OQMhoYOnuL/j+cSLXao4+lY1T4lYEc8H0sCXQ2GvouvgVFKLik3TaN+vHptoPJlI1rEZl/glL9osuzAsTlIcpcuisSoZZ0sLus/zwXb4f5dW1LTvc03yDmYfmQd0dyKGa+wveqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2dc7827a97so769416266b.2;
        Thu, 25 Jan 2024 07:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706196972; x=1706801772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpAh/AgeLA3yAZ+8/BxWrNJnaxhn5Tb3BytJoAv2i+I=;
        b=Tke0OwVeOdw6hoyjXGF9hSnCp2sNa/ij4ivJZ6nBk325bxPTbRPHepAkUtwa/mTRfm
         SNg9MHAvMGHERBgwsLED3+l3Ej9x7vAF+DZrRWLvO3nMZgfnxAnwVUKwl0RousstugyF
         NsZmfaOm03oiuz/qcigdqJOLTJSQI1BA3QQHglBOT+VA5g4rZJq5eQRC0FxYxXvCsNDS
         GwoT10pGPxf0kcb8fxAtCBhw441eubP5+zBkg5nBn0v+T5v09Vltf4XFuTvaQXIqakxo
         ilEPNCfNv+uLJQL3BtBqlWgtSbvMDAq3ZpTguVbjHYGs3PdiAJHcdUFqaU+Deq++B9KT
         4Acw==
X-Gm-Message-State: AOJu0YwPYPDBU6IevzdW4WkmlaQK7yPiOb86m53NIH/0o37lWlztHjzm
	rm40tMuziTT6YcVYJahnMgUbf0i9mXwTBqJ0zwFR7jLY6rqHKRlx
X-Google-Smtp-Source: AGHT+IGIRMS6s46BQQttwTEKXx/01hU23t7uTsm4HcMNUcNWqctF9c1iZDS50ehb/W0/fsXPZZQcEQ==
X-Received: by 2002:a17:906:b7c3:b0:a31:b59:9cec with SMTP id fy3-20020a170906b7c300b00a310b599cecmr690538ejb.16.1706196972374;
        Thu, 25 Jan 2024 07:36:12 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id ep21-20020a1709069b5500b00a2ae7fb3fc6sm1161842ejc.93.2024.01.25.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:36:12 -0800 (PST)
Date: Thu, 25 Jan 2024 07:36:10 -0800
From: Breno Leitao <leitao@debian.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
	edumazet@google.com, Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org,
	weiwan@google.com,
	"open list:IEEE 802.15.4 SUBSYSTEM" <linux-wpan@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 02/22] net: fill in MODULE_DESCRIPTION()s for
 ieee802154
Message-ID: <ZbJ/6saj5Rn20x1N@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
 <20240122184543.2501493-3-leitao@debian.org>
 <20240124175158.7c8b9490@xps-13>
 <ZbIxYnEbFXi6NBMU@gmail.com>
 <20240125155532.285a2bbd@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240125155532.285a2bbd@xps-13>

On Thu, Jan 25, 2024 at 03:55:32PM +0100, Miquel Raynal wrote:
> Hi Breno,
> 
> leitao@debian.org wrote on Thu, 25 Jan 2024 02:01:06 -0800:
> 
> > Hello Miquèl,
> > 
> > On Wed, Jan 24, 2024 at 05:51:58PM +0100, Miquel Raynal wrote:
> > > Hi Breno,
> > > 
> > > leitao@debian.org wrote on Mon, 22 Jan 2024 10:45:23 -0800:
> > >   
> > > > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > > > Add descriptions to ieee802154 modules.
> > > > 
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>  
> > > 
> > > I just see the v2 now. Please use "v2" in your commit title using -v or
> > > git-format-patch.  
> > 
> > Sorry, I am not sure I followed what you meant.  I've sent the v2, which
> > contains the 'v2' _tag_:
> 
> I believe *this* is a v2 because you fixed your initial patch,
> following Stefan's suggestion.
> 
> Anyway, it's fine for me to merge this patch through net directly (I
> don't know if net maintainers want W=1 fixes to go through net or
> net-next) so:

Thanks Miquèl. Jakub convinced Paolo that these fixes should go through
net, that is why I am targeting `net`.

https://lore.kernel.org/all/20240122105708.52d33fa0@kernel.org/

