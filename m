Return-Path: <linux-kernel+bounces-142781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989348A3004
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CD8282678
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42385262;
	Fri, 12 Apr 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGDk3W68"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82084E542
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930345; cv=none; b=QeBmGVI3w8JxjggqBvmvU12SaURFbjefkfnv0vMq0fTGo2uU0xuEXMFN4Gj7+2+JZIwvCPfW0QXbypvUzu2cw2LNwsNQdItOSpaLSFRv9sOT1n7yPICc9VvHcIWsQ84BPIHHfKf0kJu8LLeMOHOmTP4N9emGtRPHvzYbTcKkfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930345; c=relaxed/simple;
	bh=iRrlgRjpj1l5DgqhygqjMRC2WZ+61RQk+ceq2zPm6iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyEZK/BHQtO8VuNMsxKlkHDdX45+tRbC3CUJud1JBBiv+I3xwUC46+ExdJWaj2Zo7tn0hYUXeZanOLrRfK+Mvv895LIw1Pu8zwZNiaVH1iqeaNAXF+Cs/51HpAr8tRihQuHwQlNU3y8owgI5kEu5ODAYWvENqKSImHYbDn4q0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XGDk3W68; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34665dd7744so692071f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712930342; x=1713535142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRrlgRjpj1l5DgqhygqjMRC2WZ+61RQk+ceq2zPm6iw=;
        b=XGDk3W68W4l6D3aalYRIg7A3LhS49Pz2UufeM2TTM2Uuz13Cm7bdeUKkvOkhZygz2y
         FskvKYbs3GhleVaftRdyYgCRazk53Q1LWD/S/4sNd9miXN4W88mD2beQK3wUiuUx87Pt
         V/Wq2r3NorkatmyK9oHYkNbqkIXCyFf9Wm7rcTkvvTNSti6mqBhG+bcrsIW/+N4i5aYm
         yFhl76q+x5L4ZHjmJfoWZCwecxAWCajeuP+9m5Ss++Q03UqXRjebZ7l8C0fUmCa+ewOr
         Jlb49DFlC/3tK+iAPAyqqGAHSwblnRRlTDuJCsJKOTU3YqPeD53rXYQA6aSneUbqx7wj
         lsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930342; x=1713535142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRrlgRjpj1l5DgqhygqjMRC2WZ+61RQk+ceq2zPm6iw=;
        b=FtJH1rrEGmGkYOeyZLgyb+CT9w5F0DagXa/h0jWUZSCoNGn3b/S/qWgwuTlS/PZiz0
         OTglpg8uzo/Nq+oYLrn9Pbo0MJuQSTStBvtfYJUp+IKbHLyfJpH6H0OUwEEc9FylZ6Bp
         //pH9XpC8doIAFkrLqQE4KnfRzjcUawdq8q4cgjnxbxYO+GDI5NpeR8nlQpETsrOCUoC
         9mwQmmj0kh+xnCtG9vk29nItQyzJ+/7+NqFFadRkPje1t1LabKgvzKiXixKo/fmmLQKQ
         VioX71K9JcWMyz5JoNxH1G4k+md1417P3e2bf+tFfWn2aKVkw3RKuNjBN89FSzATZzn+
         J/Yw==
X-Gm-Message-State: AOJu0Ywm9PwBf0U9JmelYmYVfCvYaDmYZYX4SjgBjChSWGdCz7fmVK70
	jl3h/y6mSfY0jGsqHMQIcMtTlIdk2b4L/hgOKwnCOiI+GJMgHYeeGmCMy9oB7h8=
X-Google-Smtp-Source: AGHT+IHeHtH8JT2+opNbTc8ZphhH9GamYlO8H85818lTedasC/bglErfszTsMsJI62wCROsIHkkVbw==
X-Received: by 2002:adf:a390:0:b0:343:668b:be04 with SMTP id l16-20020adfa390000000b00343668bbe04mr1522428wrb.3.1712930341858;
        Fri, 12 Apr 2024 06:59:01 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id z15-20020adfe54f000000b00345c2f84d5asm4329605wrm.10.2024.04.12.06.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:59:01 -0700 (PDT)
Message-ID: <b6547b42-3e3f-4437-8e01-2fc113125289@linaro.org>
Date: Fri, 12 Apr 2024 14:58:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] mtd: spi-nor: get rid of non-power-of-2 page size
 handling
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-3-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240412134405.381832-3-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


I'll let Pratyush review the details:
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

