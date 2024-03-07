Return-Path: <linux-kernel+bounces-96145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4398757A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D31C2222B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC31369BB;
	Thu,  7 Mar 2024 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGXJnhKK"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D81369B9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841194; cv=none; b=i+j+NuuicMb7WblRVFBvBwdlejaQD3eniXqhIYOBTqBpCF2l75bmSWrkwpEHz+NsXid2lJcmvBo7+o0C3R1wG9gWFDSoEV2NUir4WPJGgkLs99wQOx1IQ+T6BFT1GWbZC/p2hoYVXuOrl+vVJi2IRLgHJZJ/6i9HS77Cm49geXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841194; c=relaxed/simple;
	bh=c0hc0Jlokiv+h4+olMLKgcz+yIpQYgsFeipF9imgYiA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5xZJb2/5tA03DthunNWCLT1pDiwPsm+JKBiLPiquSK8599EB9CCknbZ45kIQFNmwdjDB1j1GbTGrgz+0+pRv3Tb9LNUgKWOswT/ZdxakLpT3ZUvQ52QZVt137+EyP0rt572b+apqVYd5o8twtRmNwKiJQdvD8D8ox6VBwej4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGXJnhKK; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51331634948so2355237e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709841191; x=1710445991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2oGWNE4s+cepa8Ev6EQ8I+x56rO+/ljdhe2e4aoysxk=;
        b=RGXJnhKKg8EQWLEtG5Nv8fEepWy+aNOTIU98b9OMUuaXGpj6nTD+p3JgiJ/AQD4dqU
         Q0uk/En7z5YK/6x2qYf/i+1aojge9inkXQdHA6YxLddROug1YNZcXvybmYoCLIspZoJd
         4iZ3KAhhz5MJ7dPqoAE73/+qSLTm3ZmhdjzbTvC4Zi1HDNW0554BHIZwsUlmdYjMIcyu
         sCTTjD49hZLf8Up3i2RgI7t5CAGK9/R+dr9+B5SN+8gzR4nkeVndzHcPdthTpjpb0fuK
         mF/2METxZ2t5131U94ScvRR09waDECtl+f6KB+NMv264rCVIPvbSF5Cedu5a+hsevhjY
         pLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709841191; x=1710445991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oGWNE4s+cepa8Ev6EQ8I+x56rO+/ljdhe2e4aoysxk=;
        b=K3j3HHBsaJJGv4PTAH/oyRKyq/55icwCQ8L7+xnBELStQQnwrA2RlYhWgaQbFffDjo
         oNhGZ9/czDMjcxkpPeZ9mKrmZTyq7EmcG5uqgm1IbqSokE5wBtESXh1Foge6GzpLL+Ms
         NFamBWjfi/Zfcvi2hwYirigH4POnu+RqLXpNjsVZca1ylXv8iEWfb40P+qh5I48J+krc
         zcPcI3OS5RKKoyLuZNhjjHe/TivruGV7mPMnchq8oVtCumPQlfbxrvW7ljRhs4L1ZjbD
         CJf0dZlAbpNb0h2iiE71zaG4mAtrO6GLbspo1OwmVaSux4/Ds8oBTlcACeraUMykJVz+
         uASA==
X-Forwarded-Encrypted: i=1; AJvYcCVal9e3YX5ARP2FLRE8tTj/x1RFM411sVE5Oi2oy6MJpngejlzsLrN4WqnkedW2FsryKN9+YvTECWf1PaFFAF29R5RWkSMHQYR00sxu
X-Gm-Message-State: AOJu0YzYuzEyMr7SjSg8n7auPNHVAk4bci+xl5xLCJ3D5q49VnY3KxKl
	PgIhhKbarboh8f6oUYiaqQvjrBrQYDsZ93sIg/8Ss6x62FHXyVoP
X-Google-Smtp-Source: AGHT+IEcs8IKY/ML44vMEPIMX6tcOpEpxUVlrbrpqlYoyWwM2FLXCbbvkkX80LZJPpSc0cH+du5H4g==
X-Received: by 2002:a05:6512:547:b0:513:506:2191 with SMTP id h7-20020a056512054700b0051305062191mr898906lfl.33.1709841190893;
        Thu, 07 Mar 2024 11:53:10 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q28-20020ac246fc000000b005130ece9099sm3128067lfo.277.2024.03.07.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:53:10 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Thu, 7 Mar 2024 20:53:08 +0100
To: "Huang, Rulin" <rulin.huang@intel.com>
Cc: Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
	akpm@linux-foundation.org, colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional
 change happened
Message-ID: <ZeobJI7mfgrAP-MN@pc638.lan>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com>
 <Zei9n-VMxtzG8z4Y@pc636>
 <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
 <140860ab-59f2-4633-8a55-fb6cfa854250@intel.com>
 <Zek1ZVmCtddF7f3y@MiWiFi-R3L-srv>
 <654d9312-85df-4f57-8151-1ad802d5201e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654d9312-85df-4f57-8151-1ad802d5201e@intel.com>

>
> Thanks for your guiding and encouragement!
> 
Thank you again. v8 looks good to me :)

--
Uladzislau Rezki

