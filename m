Return-Path: <linux-kernel+bounces-63872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA708535BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A371C24AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525705F84A;
	Tue, 13 Feb 2024 16:14:18 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A522089;
	Tue, 13 Feb 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840857; cv=none; b=emW5Kmu1R76GO9cV957e2qhpjgHOUZl3AVweag96ZLwvVGyq9v4br8gsZDDSbMCM4FuASYf8zo+2cGodUpWtqdQDjz2zoEgihIuAhMY43HhSaWblaoZpRvA7NztFV1BKQ8wfcrcgzzkThuXgCUz29hJEQkV5O6EMHm31fHHRhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840857; c=relaxed/simple;
	bh=Z3xvOvx1h67F1Heo3z3erfDNsDHd6VOCSIQ8qEpmQGA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a19D6QdAud+7yKdm8Hx8TT9LoNrW9rVJ4a5pufgh2Od+5Z8+fTulAD/vTQyNdLvpg5hUDG0ohl3PCpNTsLACyOIx/y3TdMR9cX73oB024sNr2Ggh7IFyQ8gzLgfJa6F1YbWESeyH06kyJRC/f38zoYNFblJ3e5GJHkdh49IxUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ5s00clpz6K5lL;
	Wed, 14 Feb 2024 00:10:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 60CA2141482;
	Wed, 14 Feb 2024 00:14:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 16:14:05 +0000
Date: Tue, 13 Feb 2024 16:14:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH] cxl/port: make cxl_bus_type const
Message-ID: <20240213161405.00006865@Huawei.com>
In-Reply-To: <20240213-bus_cleanup-cxl-v1-1-a601adabb391@marliere.net>
References: <20240213-bus_cleanup-cxl-v1-1-a601adabb391@marliere.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Feb 2024 11:46:59 -0300
"Ricardo B. Marliere" <ricardo@marliere.net> wrote:

> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the cxl_bus_type  variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

