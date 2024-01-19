Return-Path: <linux-kernel+bounces-31634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D83C8331AB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0A528461E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3E5916C;
	Fri, 19 Jan 2024 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDj5M2OX"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19189461
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707889; cv=none; b=JS86lA08ZDd+SwifPRLsdQ3DtNwRUxSSNR3RNHEVMuDUZ7eQ/mqwjsrj8MvlCQK8l+bM7RlwvhJWnVpT9cEqH2stPq5w+ewSyVsiz1zymu9P3+9j/0VngJYjRsYjtu78r5hvKbGhPvO6vPSWN8uwz0Hh83cJ9dApo6OGjP8xApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707889; c=relaxed/simple;
	bh=LkLJ+5tqdmp3Cr457JoEH6ObGU8CxA70ZIQEUTedgP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pny2AhsTv9U6exk6B3tHcNBQW3lgY8VJfDchZGEaUR45lXiwjAX5giK+5J2wpEl+2c42O8lJ+3WX4ZKyhDeJRPGOmqqThHk4seO0x+jm6WrzLuW/W+WS2XwNyOqFeVw9fvTNDG5UiMv9UDbXgQu6vZYYp3erJ6he0kUo0ynLD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDj5M2OX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d71e1d7c78so9815775ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705707887; x=1706312687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDgUEm4jG7gE8X40/QpweJM0sP9I7yjl+GVQsm1bvAc=;
        b=VDj5M2OXfmjH4GaLAK+5HSBsCE99QIRAr2J1bLOAez4JvZTO5M+MQY8AV0H/lqTiV6
         6QFeiBFfLIcbXWbbaGMZeG41jud6WPxhyWD+AIFafjZLVonlznLuMRCtL28TnSvtCXKO
         iHWgRDBuY0oVp+idXOxAZeFCUC/tpOjx87ur8kVy/9gn8iNYQT2xKsDzE2mXiw22l3V/
         5Ut8B0cn84NFHAw1I4rO7E4MuMGeRTJXlPIgiUDQUbN8dJCFMVoBz6Q/7j1qt+JT70/K
         yKHaJT41QcLvsUt7SiAR0I+jemsFjIu5WLkBRnqUEmy95UGLt4HHbVDfGhAFGFDitIz7
         cAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705707887; x=1706312687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDgUEm4jG7gE8X40/QpweJM0sP9I7yjl+GVQsm1bvAc=;
        b=iJizjPZSwNU2OMOfqXBCEPqZCI2hKPa97HUXf/YO7prM/qMathpv1xWkVVYsm8HH84
         jmlsuwJYZbZmq0ORB/I53g/BesafUSLyIbGnMpxmtMEuwVuhqbFrSt/J+1LDJHSBpfec
         Mz+b8KqJ/lpWyxjLpSnpDY9ZvuN7C0JOtICr+kXgjREu5Engvjx+qU22keSzR4RIv9PH
         aGASsi6c3pGAlyXinQm0vB6H6UVfs3O1gSsdyNfGSJS+vVQhEku3OPBO+Cg/79d21u0x
         m+EeluqKE3GUnu5tHdVh3ZS9sdg4X1E9zF6vePlCEfaW+jQge12Lzv4UrZ99y2OpmG/f
         OT0A==
X-Gm-Message-State: AOJu0YzGMRx0YP1X/f3zKxQuMnyJJ6iWp/+nqjRfdOvFvx95tnTF+gCW
	DhBVkDM0sd/c0WPd4pHCxp2DC+u0CLwwgbuvjasrX8RkeIpjsGAp6LdxxwkO
X-Google-Smtp-Source: AGHT+IFrkiYIUquNI+J68TK0HU9OS3U2ws8gIGRRU4UcFu6ZO1h0m67L3y4aodqMj++9ujrYq1AQuQ==
X-Received: by 2002:a17:902:724a:b0:1d7:2400:79d9 with SMTP id c10-20020a170902724a00b001d7240079d9mr585636pll.117.1705707887005;
        Fri, 19 Jan 2024 15:44:47 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001d726d9f591sm1016550plr.196.2024.01.19.15.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 15:44:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 19 Jan 2024 13:44:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Audra Mitchell <audra@redhat.com>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com, ddouwsma@redhat.com,
	loberman@redhat.com, raquini@redhat.com, rasmus.villemoes@prevas.dk
Subject: Re: [PATCH v3] workqueue.c: Increase workqueue name length
Message-ID: <ZasJbR9K0yXQivdC@mtj.duckdns.org>
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240115170822.451231-1-audra@redhat.com>
 <ZabLkep0gOFEyjxH@slm.duckdns.org>
 <Zafm-hkCI4sbOr78@fedora>
 <ZagJrod33CPFaXGg@mtj.duckdns.org>
 <Zarb_u7mZCBGrgSX@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zarb_u7mZCBGrgSX@fedora>

On Fri, Jan 19, 2024 at 03:30:54PM -0500, Audra Mitchell wrote:
> Do you want this as a stand alone patch or do you want me to re-submit both
> patches as a series?

A separate patch would be great.

Thanks.

-- 
tejun

