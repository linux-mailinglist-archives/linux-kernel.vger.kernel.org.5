Return-Path: <linux-kernel+bounces-29464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA76830E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74366B24AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54D2557C;
	Wed, 17 Jan 2024 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDCryfpH"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C952554C;
	Wed, 17 Jan 2024 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526725; cv=none; b=NyF4PRHCi4HMGvVhC/72yqVh1VYkmkBJavryDvDEj6l/XvaCzafw9cXgnmxJhS6u/xPLzboX5rbsHnvbeyNlFWWXOAdww38xaa1raBzxYHOMxL6+DnootRE2oOhaMA7+zHknHwme9BMz83Bgfwlqj3R7l6qFckjk/Vu1gCSU6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526725; c=relaxed/simple;
	bh=arqZU/3Z0F7K9P8r+NixD5Edp8x8KPCmaUDGtcTrCis=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHmFNjD+JDHBHUNSZ1oqL6fLcxss6g0bdQjRE1NMd5rsP/z2IQOUSUT0/2bCLX6SBLrTax2PdecfKDky8h+GRlOy4xl3ZPmEPBF3eEcEWOVm+QgM3BdfKWEQLwE48p4TlmQVUsv7eGMfGz2DIJsZWnc/cdPRQkM+roGspjukG0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDCryfpH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-290004a6082so503222a91.2;
        Wed, 17 Jan 2024 13:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705526723; x=1706131523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxyzYcAuO/5y4DHuZHOAGASYGQy+icQxkqpjwxzSajg=;
        b=KDCryfpHtyvSDpln4SBbKOaGmp+kCUhr4RYeUD/PKtgiEaoodhQXJTKBIHdbTJJuDE
         gNn/y2utui9aLCTbrrysWaEIA0AtwMmwd8rhZ0hKOo15e2sqIXiyJa0tBplwITWS8KmH
         PvPrusYWD8gKh6YlPus0WYcCuF6NtwntbRzW+WEuNQCvwAj4YJUbzVSVBo/k6OgvElM1
         844grwKfKUA6XOtVi6wLHNl0O+JZbdZHcpjwCWtatZdjYBb7e56Z7lqFvtyypkCJP4P0
         TJj6lqfh1Q4liM/5rS/qGcsInIQjc+KHGX+2ddqRbNLuhsG0TTkO4UiG7GKlaGJ783AW
         3bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705526723; x=1706131523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxyzYcAuO/5y4DHuZHOAGASYGQy+icQxkqpjwxzSajg=;
        b=jTS5MXQA/eBnn+LNY10YZHePGgdcL8GI9wDlsrcl650F/J/pGBclCqXCE8dKikp68v
         7QFA5QheOjNdDYwhOU+odDagVCh5tG59Uw713mmvB7kEjCNPE+hFHKOghtY79BWRuvGf
         6n9lT5GiXQs/f7mvZhp8gtFUeW5p4UypRiEgjK0G+rUdyBUNnbLmDG+6fZ60LgIMuItW
         icFPSRwNkfb0Vhv4cONUYWZ0OoS+JfEncZ6UZnPVb3TqF5prflfOdySUiZkrUrGZNlzs
         Wo4uChfZSn3awf5+x9aj84UKKNItFkD11S1RS26OM2fJ4apf6/QzFUDeq16pKEtd12G+
         SZQQ==
X-Gm-Message-State: AOJu0YyGaJiGZl3aSsYVFTux+Yu6Lfbn6ppYhGViJP3MtFL7rTbC/c/7
	mAuMlkVEIJ2OXmceLjoOAdE=
X-Google-Smtp-Source: AGHT+IEk6HSQEc7HjBa0D/G2KtT1MGHMvB7VPCCl3epcOXmGuN/pC9G0Ra72sYRJ+AeEOwbD1/I7QQ==
X-Received: by 2002:a17:90a:9482:b0:28e:8267:1308 with SMTP id s2-20020a17090a948200b0028e82671308mr2448844pjo.7.1705526723169;
        Wed, 17 Jan 2024 13:25:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b0028bdc73edfcsm138322pjb.12.2024.01.17.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:25:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 17 Jan 2024 13:25:21 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:INA209 HARDWARE MONITOR DRIVER" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon: ina2xx: Describe ina260 chip
Message-ID: <c0772428-1366-44f1-833c-2d343580470e@roeck-us.net>
References: <4c82dc4d412e91d1601c1da5bca1cdf1a91cd9b8.1704724242.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c82dc4d412e91d1601c1da5bca1cdf1a91cd9b8.1704724242.git.michal.simek@amd.com>

On Mon, Jan 08, 2024 at 03:30:51PM +0100, Michal Simek wrote:
> Describe ina260 chip which is precision digital current and power monitor
> with precision integrated shunt resistor.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Guenter

