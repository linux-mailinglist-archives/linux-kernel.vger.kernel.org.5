Return-Path: <linux-kernel+bounces-81132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545188670BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5BA285B36
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054858233;
	Mon, 26 Feb 2024 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K76OoFLd"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7685813E;
	Mon, 26 Feb 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942107; cv=none; b=o1e4RFE1fJtUBIzPB2gn0fBx/NKtPf1H4AonHZWaJ1Ca1ygQJplkROK0lXJEl6GB/hvnyXWUEe82dbR1rY1HMWtxCCVa5gGakx8VH5z6EeVs4ZlifqvpVN9rEHdV5mUko+5zBzjl+hzJTsv0uwwxOi/5smQVYwUQRH3XJMotYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942107; c=relaxed/simple;
	bh=lwjbu1Q0/9loDrm+iJepXM7M1HSx/bbkPALcAKCv0Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbjwDEBfuuTnQuHZkQnIb++/Jbx27noFZEVP1Eq4uwVI/nglfeLJ4VKDuEk7/GKdag66DxtWKOm7Y+4IRc3+gnpZwCEGx0El54e0cCPMlC77zvqDS1YQ8tkK650TVV2TlNzBGMSxL+YyTal2DXO4h12V6mmBMv7Me+7EKVgoyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K76OoFLd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc98892850so8749385ad.0;
        Mon, 26 Feb 2024 02:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708942105; x=1709546905; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KmvSrMWGTpoTLX2/mgE51mXymfz8MKqe8Izfo4yIEPo=;
        b=K76OoFLdKUGGFyDopkci0kJsRRPk6pPseO1p5d0hwd2nHfzBHBHXHGTIbx+OwrJz54
         GJ7Eu7q/dzXY/Cy4LkSKcgIQzhlFglj2eGDR1VZ9IaR0VONkXqJdhSX+mXozzEowf/FL
         m9hU7BMAr+RHXdm4C5wwQEZVj1QvyIZbLA3+vnw/0akP1cUiCOOmPSXlFF0avmt50zFL
         bn/QpXO362pmziDyMrYitgR0nZJ5UdxxQgShBm/ne3dn5XyYfltsUoWDt1qF4i6mtNQr
         THjth+ji6oz7aSLC+LOA/0k73WHlFbiuNrCBxUBqFHiwIhvEHqrYKdK8hBvxI6ffOZUw
         0Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708942105; x=1709546905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmvSrMWGTpoTLX2/mgE51mXymfz8MKqe8Izfo4yIEPo=;
        b=r9ufh98BYHhMjBsc7qE0zP0osPf9ZZ+tozMYl3ZVdunRnRwQ+YFR6ecfHqAjfZuQ5t
         Ggy5awCeHUTndZ28ai73XzuxDLLbhXlD5wxfducPtE9fuiBZRDiKtXo4cB+NXrCD4NXl
         aaXTf8RGEJTZWqt+srH1mRL5YW4ZK4P36bGdLiKFBPyVD+QRMXTVQN/qVIKdZeSvmKBm
         bTUUa1UE/n28VfW8Ov/CHVUSwt8g9S7vx0ks7n8uCqp6Ix+jUMK3ZpTF5u4/avMMgDBC
         68YaoX3AD6jKNG5VtPajm1iIaAwXEJyEz3n8BqRVwxV9vbUx7BlWnAoqLTHOcFw4kX49
         WNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm/1pws5utxW664X0nuUaalSCYroS9o8j/7T8RlsamWZ2FJZmpfZwgFjXHrE/WaMmPiUorTTgh6TCpKY81MfhLT7skNSjcYZAdhcZ16tzaytTGCJiHS1IEXDfQNtBlJLN6n1dKIWS/
X-Gm-Message-State: AOJu0YzXkCUrRCW0oSb5ohvhugLhizYbUKkq8ip9CuNxcd7OYEM7ibOu
	c1SuhPkXKpmVV8tAVmRqKJyDpSdvzwemmxhsVU6n9oDjWYGZQy9V
X-Google-Smtp-Source: AGHT+IGQ26tAcyyC/8tI5qPNi4DYuzcZCygBrxkPaZuSUugpHT00ENprx0I82J8f9CWB/jx1fBCcKA==
X-Received: by 2002:a17:902:efd6:b0:1dc:affa:5f6c with SMTP id ja22-20020a170902efd600b001dcaffa5f6cmr278239plb.2.1708942105288;
        Mon, 26 Feb 2024 02:08:25 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ji22-20020a170903325600b001dc23e877bfsm3578580plb.268.2024.02.26.02.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:08:24 -0800 (PST)
Date: Mon, 26 Feb 2024 18:08:19 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jones Syue =?utf-8?B?6Jab5oe35a6X?= <jonessyue@qnap.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"j.vosburgh@gmail.com" <j.vosburgh@gmail.com>,
	"andy@greyhouse.net" <andy@greyhouse.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with __agg_has_partner
Message-ID: <ZdxjEzNQpT_duEfC@Laptop-X1>
References: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>

On Mon, Feb 26, 2024 at 02:24:52AM +0000, Jones Syue 薛懷宗 wrote:
> Replace macro MAC_ADDRESS_EQUAL() for null_mac_addr checking with inline
> function__agg_has_partner(). When MAC_ADDRESS_EQUAL() is verifiying

nit: function __agg_has_partner()

> aggregator's partner mac addr with null_mac_addr, means that seeing if
> aggregator has a valid partner or not. Using __agg_has_partner() makes it
> more clear to understand.
> 
> In ad_port_selection_logic(), since aggregator->partner_system and
> port->partner_oper.system has been compared first as a prerequisite, it is
> safe to replace the upcoming MAC_ADDRESS_EQUAL() for null_mac_addr checking
> with __agg_has_partner().
> 
> Delete null_mac_addr, which is not required anymore in bond_3ad.c, since
> all references to it are gone.
> 
> Signed-off-by: Jones Syue <jonessyue@qnap.com>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

