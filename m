Return-Path: <linux-kernel+bounces-67946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81885737A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FEC1F24F52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8976F4E2;
	Fri, 16 Feb 2024 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrNsZHFZ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BCDDDC1;
	Fri, 16 Feb 2024 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047286; cv=none; b=TEIr8jyKYM1P1terqUYNwW42VS6HLkurHfEMG+VDpP5cTLrEJML3ckHyDJByNwuLpQdZ8obE4t7mgj1CEyb9tLTGVh2hca+1bhYPDchia+qGrdfKkg5qZ4ek5A9xFO6NWrqqUaBF0aR4fbSlmvmPC/xvsMoI1uDFwbMppv1Bcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047286; c=relaxed/simple;
	bh=Omkyv/ijNPsT9zBVZmn3vGXG+CLOXI+snt+6eX6Zbck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5lurw62cyTqF38+LZE6pBXAsoJd5ijQzkE3JXU/S+vSXbRy60kerw/2pWZ+wIW+vIzky3D3wwF4MyEJHvYbujHGtcvFJeRoFYaWFvYPt/AqO0i15Ters57RswgFE3idoaQ89qSSj0kO6w4Z7D7Ijt8n0VfNqayPhy/FXDW3PTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrNsZHFZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d146737e6so485443f8f.0;
        Thu, 15 Feb 2024 17:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708047282; x=1708652082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jzFjftUHCCCXFtG6EptiA3RMrTwV5kvtkepZmVTZewE=;
        b=UrNsZHFZ01sMC4WlwMLdbP/ybDgdl5/JrVtcXUqnKBDZ5f5XEuUyA/9766ePLi8n0E
         J1vKx6cX3iUctApKf/FZsR162FG4NvYVbh2B+tT0oasqEuRzZ+m6eae5hKuf69X3b//+
         IeyQLbW9+EpMdbE+0WWdCzakWRuglBW3N+T1t60r9u+JIyEmPto7aZ0UCASibsoABu5N
         ND6onRnT5Sfy15aVW+RAmx6VRlEmWQfwAIV+pt4PDmfTrOF9d1rVbgimfrLevEJRw7Uk
         vD9PJD2DxGmhv//9hvV9zcquu+758FQJh+uboSaJSm6Xhs6gRvXSxXKjAd+Vj1BOynvi
         lM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708047282; x=1708652082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzFjftUHCCCXFtG6EptiA3RMrTwV5kvtkepZmVTZewE=;
        b=tK0+aJE9iGGxngT9I2c/2huoDnNakeH368oDpP97m5+bvYSkhBaH9bbXfEKqG7l7cP
         8BOKMBeyJuiaSszSg7CCd9Gt8s52UdJVX0fJwPpLGzKdIY++uVEeiHispS3ikAbMWDGL
         w6Q/TEkZUDyZrKZYOuBn2n5Kgs2YaLEr63CXd9fIWfdTEyKDYpkMn2xRaUmjOgD88LUT
         p2y7aQUEwcOTnHVD1kgkBlTVxhYTedc5PEBsbqPU7oH48A6TtufmlCLeINWXp66hQveE
         8HwCPHyB+0RrAgOL0QhVbisMNEo8F/oLmxHHEIYH5ve89mKeZPCq8hK0vXgBj6+KzEHY
         JcbA==
X-Forwarded-Encrypted: i=1; AJvYcCW2hH9mL8FGKtVHzo6ZbZK6YLNYEp3P9Ono0K/fkp7sYY7/kONM8w1z5Jmmy9eSXUmsewOuY6/XHo8EbyKaXxQFBNiyaWU5UV7mwvn62O7qB47e5u0pOXVOH3bNbtFNF2eoNdUd
X-Gm-Message-State: AOJu0YzjzKk2Lp+TRLIv63BkJtuAytVUNNLlzxB5ENK9HFY73gs/NLhp
	4u+u8/7dhrPD7krPGWl+kiSvLsN1WCVbWDrseJdfbZNG89HwgqZb
X-Google-Smtp-Source: AGHT+IEKX4mPK8p3LVtgqAEYyCPcuWaiS7Wg/M61Uzh8Z2MrCR1EPMqWz1zamkiXHkPSe7lbjeYPxA==
X-Received: by 2002:adf:f892:0:b0:33c:fb94:1e12 with SMTP id u18-20020adff892000000b0033cfb941e12mr2617815wrp.54.1708047282318;
        Thu, 15 Feb 2024 17:34:42 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033b406bc689sm665199wrn.75.2024.02.15.17.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 17:34:41 -0800 (PST)
Date: Fri, 16 Feb 2024 03:34:39 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: arinc.unal@arinc9.com
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH netnext 0/8] MT7530 DSA Subdriver Improvements Act III
Message-ID: <20240216013439.dq7s5hp74mjahy4d@skbuf>
References: <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>

On Thu, Feb 08, 2024 at 08:51:28AM +0300, Arınç ÜNAL via B4 Relay wrote:
> Hello!
> 
> This is the third patch series with the goal of simplifying the MT7530 DSA
> subdriver and improving support for MT7530, MT7531, and the switch on the
> MT7988 SoC.

There was an automation failure, you used the name "netnext" in the
subject prefix and patchwork reacted with "Patch does not apply to net"...

Please resend to get some build testing. I gave a quick look over the
patches and I didn't see anything obviously objectionable.

