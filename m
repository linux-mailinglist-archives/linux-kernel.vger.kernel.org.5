Return-Path: <linux-kernel+bounces-45729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822378434B7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13D92874C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73A720DE0;
	Wed, 31 Jan 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clM/DV6O"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF608208C1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706673863; cv=none; b=f6DpIEtB1S5HoNVmsK7BKi5mJO3P+F6lCMavA+KIQAvy05mK50hFiYmolCC1GMfGkNCVoIYkNvW88yFLMogueEINZLyDpl05TPMzFIqop/IfTjn8RcGAxluAvpYc0jo66e83J1LoaWYOd1/h8/w/a1nW880sPUVC+8/Xhe1xxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706673863; c=relaxed/simple;
	bh=EYxKNflX4ARpJiuBqBp+lb80Ak+T7fWcIV+CnHa1fSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/eXSql5eVOhVIZNecxg6DQXTuLxvYrES4grv3TpPrJ+sp8ULuWkk5hUWlNB9WLlOYWoUo6Ntw4kYnVLRdUSgK6GqLTucpulCAptuwWl9D5fJ8LZBgA54tAl8fpnr5CsHpf6+fNAVRfGzjQ1U0LY76P5OWzdfMpyoby0JQc1hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clM/DV6O; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d7881b1843so39185645ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706673861; x=1707278661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvrkhYHMJN+n38sQ+psyjf0ghJLFdv8r28W/2usElD8=;
        b=clM/DV6OND6OTx7ZQh12W8J6MpFbnjXSYSkXRWtxOX9/57CvLpbpqYp+cPHKfdag2S
         1l7pwBeCvIGyvP1MxCilVxF7tCEBKKPRAQovU2S5GPFTligivgrGKEFLcQnnhWbZ4I4Q
         aaZ6UAEt8ed/d2O0cu7riFWFHK15bS43eCO5CVcNYAKXAmp13EmcJkyJmp/BI0YHmoEC
         NmBmfPGojg0X3QQGK8xiRKaEJ+g4R/CeKwhOHub8iLo8I3s2oQwkwaYfKwmvacNxQSsv
         IurwaD0R/ijYopciyt35wkh3GOZLo/aGaT208JIi+Hx1jgrCnaW59BIiEmI6WrxrttEO
         04iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706673861; x=1707278661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvrkhYHMJN+n38sQ+psyjf0ghJLFdv8r28W/2usElD8=;
        b=CC8hP/45zrhYraGy/6HCPs0gC1m7mf8cFpKCEVrXFpWtNSRi6DkGaPasAzZ0tQdjDr
         dlNgkf31d8QrR22axVyhNFxVRbf4pOIx6sPdrfJnLc7ygEPniZwi9wgibjW0GfxllbXa
         /EFTcxVX3U0SvmXqgFsT/76E2ZwMOfkikauMqij3TodiPsgXsD5h4sL6UfPintMzuHfj
         TztwaFl7wtxkqWFXx4TUZ3v3oDLBIorTsYjxvlgB3PXwreqFNTqqIAXVAL2txg26lMUF
         FWjjgj1Vrhie1XY2uPNiBS8sXSrRnQJVZF16u5osJOcev/4sbH8Cays7sUJD8B7+SbQw
         vPOQ==
X-Gm-Message-State: AOJu0YzCde1u9XBQ9F3dIyAWZ2PTg5d+TmHCEW2kj1OeRJAvi3wmU7xg
	WGkXIDXrKYKM+x0GYzYaXuXAQOXyA+yohSJENGis19E031UnaiGugBbudRcVQRo=
X-Google-Smtp-Source: AGHT+IHcHaBWuTKDBXu9hXDzV0FpfNiMGV2gkusHn9LLBkW2Z/mhjsb0htU71ae8qdubgt8KANBKdQ==
X-Received: by 2002:a17:902:ec82:b0:1d9:55b:6a17 with SMTP id x2-20020a170902ec8200b001d9055b6a17mr753721plg.18.1706673860916;
        Tue, 30 Jan 2024 20:04:20 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902e18500b001d8d52905e9sm5115025pla.0.2024.01.30.20.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 20:04:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jan 2024 18:04:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Subject: Re: [PATCH v4 08/10] workqueue: Introduce struct wq_node_nr_active
Message-ID: <ZbnGw64YN-C7NDoe@slm.duckdns.org>
References: <20240125170628.2017784-1-tj@kernel.org>
 <20240125170628.2017784-9-tj@kernel.org>
 <CAJhGHyA=uO4P4skas0-DZCE+cS453V+PrJMOFj2G2DAc1tE0jA@mail.gmail.com>
 <Zbfq8egWUfYgkOsa@slm.duckdns.org>
 <20240130180010.GA2011608@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130180010.GA2011608@dev-arch.thelio-3990X>

Hello,

Thanks for the report. Can you please see whether the following patch fixes
the problem?

 http://lkml.kernel.org/r/ZbnGbC8YM0rcI8Jm@slm.duckdns.org

Thanks.

-- 
tejun

