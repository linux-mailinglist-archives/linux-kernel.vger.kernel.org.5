Return-Path: <linux-kernel+bounces-89940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF886F7D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E90A1F21303
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907EA7AE68;
	Sun,  3 Mar 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WK0WMqId"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A479DBF;
	Sun,  3 Mar 2024 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709507267; cv=none; b=Sug/tM2rRX1nLfYuNErz3ectHnoSyruYXcqorjtpdR7hsXIsdNBY9YpMsR+PT7P75b7joLC+GFZ5EWk0/qf46IzHE/dQimPsCle8IUtoUsDiCgNEmHBoZyhQ7y5QsN1IfkZQmGVco0hfB00Gs8hjzBLEbITGFehoUHUelOlCUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709507267; c=relaxed/simple;
	bh=4ofXeX6NFhVEMylptXFZLc0WCBSRwwyTdMKajwPn7uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av7FRC5NS5Ezxm9YSL0YU0CnmySZ/EmW/ioYmSvt9oGGqbym1J/KsCg7hoc4nr0pdGoF8CdmGxqhRli4Vgcq7XvLdIrn8gGlO0Fle2THBazTo/GPJ14dDB/WPxrST8BogjYhBqEqueJZulJTiNgNgQWTRxUt7F/9sC/FrjN7Y+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WK0WMqId; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e5d7f1f15bso1508841b3a.2;
        Sun, 03 Mar 2024 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709507266; x=1710112066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ceTMVxr2yabL6tzFXxo10kDCS1LtdgdIjh7XPQmWd2M=;
        b=WK0WMqId2rD3iBTRashQC2rsqg7H7ZxzJpQCLhWTTj4XKVjz8JT4F6Djs6xp2aZmsz
         zaK1gxkdpnTfQ57Mn0FalTpkpJBf/U2m8dYP7Q9sEkTKlHh9ILlZrVwRrIIfnYPbZFrn
         JeRrjmMWzC9Wkh+4GBph0XeDQPUUoLMd9ihTs6SAVe+QbxCxRhEU4VJVfUSk63EJKpW3
         arqLkamxR4HoTK5w5s5Ad+ahJlEDErpGNlWZNSixFYC5sdFpsNwy2ZG+AOfBuq6nHXL1
         eJY0DX+cmOe4wo20arQP5/ZDIxybt0h3RrdatT2U0OkBbYGcrOXwCtGI0N6E3HelXcpr
         zt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709507266; x=1710112066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceTMVxr2yabL6tzFXxo10kDCS1LtdgdIjh7XPQmWd2M=;
        b=qbLQarqjeZ6sreAkkojctb2xza0qUyxigJERTc2KmI2eLUW/FE77Lft2SnRgfw3XIK
         2AzhbsBf5FNIttPQlp1GD992nRAQ0cqm6XPEfumZN92pIMj6d0tUKffkL8O66YwusPCa
         DLhhDvWsaKpAqjFOtMhMFXjeKdKkTNpJ59Touym0JjH9nqQlkrdcZEU7Kxl6f10xL2mJ
         VS+th3wueGo7T/4d/Zu82QHCs7O1VW/r4K0i+xEOcqnDZYpQmNf9Z8cKJTqwCpvVUFxy
         PbhWb3NxmEgMIrcl6lgyEMbTKliPOyP/M1CJ04RGAwDJFQeVjdHq7Hoprnls+9a/sT2S
         l0/g==
X-Forwarded-Encrypted: i=1; AJvYcCXQh/4bAqT8mzdFoI/GrMMfKRYoxsDGuUXckrlOMnRlzDdmwPQHVtasgsad/cNovZ3lLp6zYXWN/B3bBKlBWqB9LKEjciQXw0LPJzyK
X-Gm-Message-State: AOJu0Ywd2QZfhUvmYHNOe7irkyIMplkaf6QhCHrpmArdLKpLVR5aDLSd
	dLAUhzUK+kgYBZs8xuU0zwfLZsU2bpDkobXv7AFpnxnvlqrdSiPy
X-Google-Smtp-Source: AGHT+IHtwWhrfFaAsVZBevWF8nS48w+sVqCFVdv69YZrgjGcJFiBvUclcE4g5MLTPH5/ESLBLm3PrA==
X-Received: by 2002:a05:6a00:9295:b0:6e6:1c12:513c with SMTP id jw21-20020a056a00929500b006e61c12513cmr1565412pfb.34.1709507265805;
        Sun, 03 Mar 2024 15:07:45 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:99d7:8333:f50c:d6a6])
        by smtp.gmail.com with ESMTPSA id j36-20020a63fc24000000b0059b2316be86sm6187146pgi.46.2024.03.03.15.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 15:07:44 -0800 (PST)
Date: Sun, 3 Mar 2024 15:07:42 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] Input: serio - make serio_bus const
Message-ID: <ZeUCvqvnLRHn4sLb@google.com>
References: <20240210-bus_cleanup-input2-v1-0-0daef7e034e0@marliere.net>
 <20240210-bus_cleanup-input2-v1-2-0daef7e034e0@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-bus_cleanup-input2-v1-2-0daef7e034e0@marliere.net>

On Sat, Feb 10, 2024 at 12:15:02PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the serio_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Applied, thank you.

-- 
Dmitry

