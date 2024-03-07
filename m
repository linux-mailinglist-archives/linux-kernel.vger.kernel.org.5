Return-Path: <linux-kernel+bounces-95182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFBB874A56
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FBC284AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6628D839EE;
	Thu,  7 Mar 2024 09:07:19 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E16823BF;
	Thu,  7 Mar 2024 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802438; cv=none; b=iXBs/6aUgnTCeHTc8kRWBinvzCYiGfv+DOD37a9DInLWwN9Bo0wXoWNVxYPZ90C/gRiaR7o9aE4yGMCvJyAOFjrRD/DyvXd2D/HFJIWPRgQ03vQ9H+tCa8YDD4HV4Tufc/FTB8RmjwiuCtv+RmL/AgtfkQQRa4yGnhvWbUaXJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802438; c=relaxed/simple;
	bh=2DRSDw8IU8iKhA8aEQNkiQBlZNCJhxwwQj5j96Furis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk+XQ7ufCJ0jsZITBWSp7/0jHbsZh20GTyttFi68QZRCfVqmJSwsxOP0qEJ/R/+KwoxUcrZW2nDOB9nT+BZJ9F3XocF4FOOzcN6wUubA10Dddt488sHfJRyf6EB7yb4hKSuk625yLJvUZKQyh4Enkl/xcLdRSG4blKW3I2T/NOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so828056a12.3;
        Thu, 07 Mar 2024 01:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802435; x=1710407235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6qm10nZVIh7lWdjNXoXuKqxvr/b4LeOyBSQKG+SB4c=;
        b=MpzF4QHLYvz6jmPS2se3wCeHXBjAz5Ftz6S7jEh5Ei7w7DEUVYqT82+ao6GDnW/aDJ
         ws1oz1bF7KFFLgYp0eSA8vAIeypr8dsJrbAs9Gs5bQzfRIbaNW49qmXP3eq7UH3Lg5p6
         IBEpI/p72je6Q0QW5nx/x42q6fyC15WstKmmMkJJN15l4F+3Yb6YAJl48d7EkMum0S/U
         Aut/BxLYAoK0DlN7JQJMNRoH2qSu4Uqp3j6qPQlkEhG80sj2igwG8hxCqdeZh8/dFHAu
         njlrDMfofjxBKf7tBH0E4ROFN/B9QpGVzxzwV+TLKpNNd+9iGATl4h6g3F1IykCAbFB5
         u2pA==
X-Forwarded-Encrypted: i=1; AJvYcCXad86huA+RsumqANhtBqyt5Ts/wblM7xWUrvhHQs8YnmxYWUQi1Ri+e/FTEhnl6DoGuqAtrWuz9slFKSDaw8d1DmHRJBNTyQDi4S/L
X-Gm-Message-State: AOJu0YxEGTYjaXxv97BJFCFlmtJurQGjKKj+IfqShrTC3dzb/W/Ygt7+
	cQD/ugb53181YupGJxs2dWXDauZHpPcfZYSOf7rfs6Xac8dwH0bD
X-Google-Smtp-Source: AGHT+IHN2mtpp9T0Lax6cS0skgPxEK7+k04UUfrKc8rgWJ48EOUo3PwQaUK8P/E5ax7lFMecR+6OQQ==
X-Received: by 2002:a17:906:ae55:b0:a45:c8d9:e8a0 with SMTP id lf21-20020a170906ae5500b00a45c8d9e8a0mr1089466ejb.43.1709802435211;
        Thu, 07 Mar 2024 01:07:15 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id pw20-20020a17090720b400b00a450164cec6sm5314346ejb.194.2024.03.07.01.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:07:14 -0800 (PST)
Date: Thu, 7 Mar 2024 01:07:12 -0800
From: Breno Leitao <leitao@debian.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: Leverage core stats allocator
Message-ID: <ZemDwNQnyPXbtMcz@gmail.com>
References: <20240306200416.2973179-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306200416.2973179-1-florian.fainelli@broadcom.com>

On Wed, Mar 06, 2024 at 12:04:09PM -0800, Florian Fainelli wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core
> and convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the DSA user network device code and leverage
> the network core allocation instead.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

