Return-Path: <linux-kernel+bounces-44952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD4784295A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1597E292464
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E812C528;
	Tue, 30 Jan 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6iLpe90"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB212BF2C;
	Tue, 30 Jan 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632299; cv=none; b=AdsAYBxfdB/4MAeR1xRatgqwmPOrG1gnx8DGDfUOUGlYSH/jzUiU1YyhAEbBpS37thuqPqX0pI79d9s6VSH2hxNx0xaOw7L9tPqnsXAzia4ce9vWkDQ9va7fuC/XUlIUkAxrbuL17b/N0XDSqZ+7yyCrJuAQlM5W8bGKWN7AN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632299; c=relaxed/simple;
	bh=ROemg6+Ns9pPgrVA1K+Ft/vDAClIhd7m/s/0hgh0VYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvI7EBM77NyIKjKlAAPBIZevTtXKJYNNL6IGxzG9EvYMQ7GWB0TC6f2HC9/CAXsfY2CBXy6dnxdYWXYJwMXyvARxlyS25BCgQd0pWm4ySwVUN/VFJTDAW78B8l5Ph38ejCsFLYjPbOKli/mvUff4vUku4n1+AJ486PUQuE3THdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6iLpe90; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1196416a12.0;
        Tue, 30 Jan 2024 08:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706632297; x=1707237097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oF3cV1qV8ijwBNPsuRLVGr2oR8VMOLuQMFd6pDB7yE=;
        b=I6iLpe90ajPbnZdC2fhjYjaBAkiSZmaOorpSx1PoOSU4kMEO1PqqY2UtVZA11NChIe
         Y1t2T0hxTZthvJFhZkjcIKSPSINM1H5iGMiOmm7hgbudvuVY4Qa/W5vpej5pCGODvJIC
         x4bQ9K4v86Ecmy0JxQ/t0EpoEMrS98Cl9GWEJr5cVmeZAv/0ER8zLZtjM5KdRM/waLBc
         rbwXAvaTX4STjHuSMIHgOmbs7lVKuS+ASvNpsu3rPSH5FNjX+Wx3TFdAEt1K74GCKtK4
         sdLd2L5mhcM9/a2qdH9adW7f4cCOTXmRVN9+DZ7gBEyYzE5gUlwJRqzK5kjhw+ESliT6
         jUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632297; x=1707237097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oF3cV1qV8ijwBNPsuRLVGr2oR8VMOLuQMFd6pDB7yE=;
        b=icMBFW8bTcBydq5S4/n2Wfc9iedK9tsy7hHXRshZ28AiIV2z66emB9RxHWJBal7XMZ
         RWVbmuEeJ6kBQE/PhcrGGnqCi/7mQZJ/xFDuXlFBYpBAq208y/BquFQchLkht6Pn7nmT
         UWbazljUAKMhgO/ApLPN7uPv2bqZ4gsP+6e0NqVj0IrlJq8y4tTjnTmqsudaoYUDgXoC
         cRIqcobPDotICwgWdPkkAjeptS3P8OVVEEUNpkoMV9sF7V33HlIKBR85ZLgkaWN1o9aN
         +b/8OLc1U94fkOWHsSv8HC4uJ/3Xga40/fAUEX4+Jh8meu0/Edrlk14wHMqMJ+g4H1fU
         CnbA==
X-Gm-Message-State: AOJu0YzgNpYSQQjaa0d+LmKXY1lwIC6H9xo2+mwN+ZI8IlgMtKXKgw+n
	BHsPliE0XtbigGGlZH9+rc/KAAJ7usRcC9r39Ynru7wA3bhShV87
X-Google-Smtp-Source: AGHT+IGO0qgo6TzKRGMi7+cKjrllBbWKqTNBb7K3tmTp4MRIE+Id8XpP1vDI0sH7kx4T4p6LzFSfEA==
X-Received: by 2002:a05:6a21:99a3:b0:19c:7e6f:85f2 with SMTP id ve35-20020a056a2199a300b0019c7e6f85f2mr9168290pzb.1.1706632296801;
        Tue, 30 Jan 2024 08:31:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i17-20020a63e451000000b005d8b8efac4csm6063827pgk.85.2024.01.30.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:31:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 30 Jan 2024 08:31:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus_core) Allow to hook PMBUS_SMBALERT_MASK
Message-ID: <6aa79b06-ab59-4f4b-96c4-bdfb03974aec@roeck-us.net>
References: <20240130152903.3651341-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130152903.3651341-1-naresh.solanki@9elements.com>

On Tue, Jan 30, 2024 at 08:59:03PM +0530, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Use _pmbus_write_word_data to allow intercepting writes to
> PMBUS_SMBALERT_MASK in the custom chip specific code.
> 
> This is required for MP2971/MP2973 which doesn't follow the
> PMBUS specification for PMBUS_SMBALERT_MASK.

Applied, but is there going to be a follow-up patch for those chips ?

Thanks,
Guenter

