Return-Path: <linux-kernel+bounces-46493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104B844088
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83321F2C6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284D57BB13;
	Wed, 31 Jan 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAmqh163"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011FB7B3E3;
	Wed, 31 Jan 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707623; cv=none; b=spu5cRPsVQDhwg820NydzmxSavzHXIxpDjcny1RLSv+IcrnfGLiPWBz4jCn41F+SSvF92IGjnipL7kIpImM5mFLg9FGcZ1oKcmjbd00LTUu2O9uuCglHUd2FZcMQfFwwStfWvdTiIoOwVd9lxVuVk6AZ/SBEKwjmL594TV7AA2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707623; c=relaxed/simple;
	bh=omfvpfyhE2JHUeOU5bsJZgaeJu08LQaB+yaoeTyFGEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3hsCYMIRVl5F7Y+w/ges7n3mPmjLjVl0nAWcfdKGh8XGfzNnot2glCLQ5m/p7mlitBgjsBCNNnOgXhYQYHklno/pdQaj2jM06by4TmfPZwZNftd6aErHl8YrauAZy/W8zU5vnLG1kNoHK7R88ti0HXc5EKUtPuLQB41EOw8pH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAmqh163; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so581698a12.1;
        Wed, 31 Jan 2024 05:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706707621; x=1707312421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6Mlm1rYpgJEjcWexOZQE2YpTdhmKOn2T1JwDr7J3Rg=;
        b=ZAmqh163+r62E3KjFC7Ordakqtr0DuCjdpsa3Dq2tslnkpNQ/HVUHJyLoPvSZIzOgd
         //LFMa4b7V0kgQuEaZ3zFmwNE3OB/wrQcxrRtQA9au8KOnoc5lRuSSpoHwHieiQl22aq
         JxeC6ProP7IfOvPFIe62jJhiniCjfoM08/yZKYNLMNzG+iAzVmKn/xDgknlicDggoKtq
         y24/zXLMeQEWyRg68f74kRUeySuLcY4bVnnj8SvJcrU1cHJC/nnT6iFnzZozl9oIaOm3
         HVVXneyfvJblKCl+zv3ZbFcg+WECCMIVY7oRDTlKbkMTupcJuRlH0dqf95HFoMr5KA7n
         zxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707621; x=1707312421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6Mlm1rYpgJEjcWexOZQE2YpTdhmKOn2T1JwDr7J3Rg=;
        b=qtH5praGKm/l1GVU3FCpda6hMnGLT4s8F4CnKc42wamDDqCV74MoYP36rluUIJOli+
         rkk6KgXtBYHrZCDAxfA598P0ZG6sz3x57oqr4WjI7S1xG+/jG3ZKiBpVw7UMRKq09oaj
         /3mQDoKyum8IftsLp1UVEaZl5w1qDuNJ0BCxXXpGz9zanjEJE2cLW0qPg4kJRbJ5gwuM
         HSkgMh6OJ/TLiFyBoQ1u+hDuKU0dn9IwKP6yqmuOiIvlUTTPKAccYLAm9DDP55hHVlAI
         trIMhFrt+iaS9hGrkmuk3ofrXfo6fo+dHAI3FhGSci+tgJPmqUnSNPZGoCZ2bRxnYXqX
         sqog==
X-Gm-Message-State: AOJu0Yw0omt+hMuKN1DM0q2LEtqA5wmGPHwO4DfXKFiPP4WFowKDecjG
	CkAli5Ov7uTC0ke+Ae1HwT3mLeVWZvst6HGXj14u5zkIi7Xkm1Pd
X-Google-Smtp-Source: AGHT+IGSOFvdtutw5d/ymE7z7XB5saYDBdhTbsJU4Ac6nblsOGRd8PpxkWkp53bwuImqaA67HSbyug==
X-Received: by 2002:a17:90b:1983:b0:295:d09a:107 with SMTP id mv3-20020a17090b198300b00295d09a0107mr2994750pjb.11.1706707621248;
        Wed, 31 Jan 2024 05:27:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y15-20020a170902b48f00b001d8921f2058sm9004443plr.205.2024.01.31.05.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:27:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Jan 2024 05:26:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charles Hsu <ythsu0511@gmail.com>
Cc: jdelvare@suse.com, corbet@lwn.net, Delphine_CC_Chiu@wiwynn.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: Add driver for MPS MPQ8785 Synchronous
 Step-Down Converter
Message-ID: <98472af4-fd16-4bae-a7fb-0ce5719500bb@roeck-us.net>
References: <20240131074822.2962078-1-ythsu0511@gmail.com>
 <20240131074822.2962078-2-ythsu0511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131074822.2962078-2-ythsu0511@gmail.com>

On Wed, Jan 31, 2024 at 03:48:22PM +0800, Charles Hsu wrote:
> Add support for mpq8785 device from Monolithic Power Systems, Inc.
> (MPS) vendor. This is synchronous step-down controller.
> 
> Signed-off-by: Charles Hsu <ythsu0511@gmail.com>

Applied.

Thanks,
Guenter

