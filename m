Return-Path: <linux-kernel+bounces-14951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E459C8224E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E3F1F22B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C896D17728;
	Tue,  2 Jan 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5/nB8j4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D717727;
	Tue,  2 Jan 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33731db55d9so2857225f8f.2;
        Tue, 02 Jan 2024 14:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704235277; x=1704840077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=buVy9lIBzo7ewo2YZoJgD+qCUyyJ4YO8qxNGQ9qvrsM=;
        b=h5/nB8j4u0opuD4xX20kUdanxvGbF4VzDQIXzfU7E8FTg4x7DtYLEvjhHewKi8SrSk
         zHeRGHBBUHvW8RDTMnuIK8HvEwzHw4nVBIqwB6jbI7wTzkkqqtyQiVURHXyfV6Rj4n9+
         3voqrQzBTJFa9ysNpxCi9OTVnWJsURL5L+p93KgWIxB/1diS3hSTSI+C9FxDjwYOm6aR
         iF0AHoUcVx5abprG5bN9l1tNquQL2FKMdEVujhkebRMJ+Fggv1p54x46wmAVabkDxGrU
         Fhk1GekVFG6vsPtz6qZBWGNBYDeWixCJgcJKyM9MmOSTT7wddk5s+YvMyVLCvSgFhDIf
         8NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704235277; x=1704840077;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buVy9lIBzo7ewo2YZoJgD+qCUyyJ4YO8qxNGQ9qvrsM=;
        b=rSV9D0KF739RI9mWCOAlMXyAGTqVZPkPFiNrpgaRl3SfGZ2DK94OxSDP/uPehcte6L
         fUDHmOeGjZFS/kQOf8y88Jg3Y6ISJaliNWxF/u712HW1KgOEwuN0UleZEPQPYr3sCaSs
         8Ge0Rf5+ELNtr+aEPVE+Yoz4a05DiEwAsFsCAMEmOp6+jDBh55r3EPyTqyQeFoLc4T4F
         AZ4D2CqFka11/jK2JAAkWnoli3VJrysvnZiZLiB+BIj40wEoYw66s4q/SEaEOSm+piaV
         4y3xFot7uB1Wz5iJPLmMsfjmaojC9o+6ltbfO+1jUHrGezowJ8j6CSMVNgrfztxJ06yi
         Rpxw==
X-Gm-Message-State: AOJu0YyXShlNAamcvzGythJjrWk7/u3IRBSw/dg8boNBwpJlO64LYCSS
	pDFYKysR6kvfFLjN/ndK+Es=
X-Google-Smtp-Source: AGHT+IFeVimvW0Y4Qb084jJJ5eAL8qcRvPDfKufOpcohmtP9UnQZUy02rr2kkD4CVIIlOXknEF30vA==
X-Received: by 2002:a5d:65cc:0:b0:336:7bf2:89da with SMTP id e12-20020a5d65cc000000b003367bf289damr9587308wrw.95.1704235276687;
        Tue, 02 Jan 2024 14:41:16 -0800 (PST)
Received: from Ansuel-xps. (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm29303085wrn.40.2024.01.02.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:41:16 -0800 (PST)
Message-ID: <6594910c.df0a0220.d72d6.9947@mx.google.com>
X-Google-Original-Message-ID: <ZZSRDOEQtQY2LYPK@Ansuel-xps.>
Date: Tue, 2 Jan 2024 23:41:16 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 0/4] net: phy: at803x: even more
 generalization
References: <20240102140330.7371-1-ansuelsmth@gmail.com>
 <20240102143707.69f08d5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102143707.69f08d5a@kernel.org>

On Tue, Jan 02, 2024 at 02:37:07PM -0800, Jakub Kicinski wrote:
> On Tue,  2 Jan 2024 15:03:24 +0100 Christian Marangi wrote:
> > This is part 3 of at803x required patches to split the PHY driver
> > in more specific PHY Family driver.
> > 
> > While adding support for a new PHY Family qca807x it was notice lots
> > of similarities with the qca808x cdt function. Hence this series
> > is done to make things easier in the future when qca807x PHY will be
> > submitted.
> 
> Does not apply..

Yes sorry was based on a tool old net-next branch and notice the fail on
patchwork. Was waiting the 24 hours to resend rebased.

Sorry for the noise.

-- 
	Ansuel

