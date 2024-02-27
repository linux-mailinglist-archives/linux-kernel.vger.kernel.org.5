Return-Path: <linux-kernel+bounces-83880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B377A869FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2419C1F24EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9034F8B1;
	Tue, 27 Feb 2024 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBd/DPGl"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C21E894
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060490; cv=none; b=Dckfii+U8TRaOEkjgJeP0I1ZjRWN5g8N4NB3VB4KDLuFXP8TPUU8LyolEe7ywZ5/B3PSG+ZUl4OG6QU5TzqwYiPFyHsO0bBGOODTkAnO5cl3WgUV/ixXCixW+mujPP5jg1CbWH5XSqQlRts2UX34mn+pgZ5ilZ6z+98bJUQKfBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060490; c=relaxed/simple;
	bh=SFqUZKS3btSbaCVDcjF20U6jeyelHzTX5jo8GjDl914=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2MN24i61pm885kkX4g8364Od6uIJEeAlyX3oZK5OcFunpj5c8pPItXBkGAiyJd5pB/e2iZArtw6tHQfqpYJDHa7OXZVk8OJTs9PBpc7RVw7DfVRPPKQAjtSvOnybOtmRLwTfSoUtnpg8/XUMllGZOpJOOCCd3+QEw6N7Uv4PXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBd/DPGl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d93edfa76dso40357745ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060488; x=1709665288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+XYa+6xdty24fg8M4aMK8wsLqrMuV3Nkbfx/C4KTQw=;
        b=WBd/DPGlm08/174v24c3yzS3yIGLagt1XLAkL2xKYqkZmI52xfHnRMGno2dKTyS8f1
         zisGQ7rB7wmvlU10cmXwiQ8EnLyAhAdOA5bfDt8EdhwNA7zLLyj16XxrcLNXgv2aBiEA
         QC5i6HETWl03q8U9SIXEcHGJ31Hgabtx0fozbnJ5mch+wBdy2jdnnBqRW1qjYzGK1tF2
         TxRFtkSefGgjjr/USRjSYv05bU+jyhsJHdQQLsXXQXaiPz9qo7fX8OVAq7pjLxLve1zI
         DH088HGhE0YvfHQG6+Zo8YPajsQCGBVGZ/UeUrq8FeblNBVNU2OvHTWWoTwaPgYoSMGj
         6Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060488; x=1709665288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+XYa+6xdty24fg8M4aMK8wsLqrMuV3Nkbfx/C4KTQw=;
        b=FXEdb2pC1vfkDpxY45CkwT4Ymm+K4ypnt3QQorw5SLn32UhhYRzcNHyKcY9Khjl7Vd
         O3dZ2ryPd1/rbQ26GK+g5XBW0trDzSQ2HoUtoylqocll4+iwWdBA5/DQq1LWYVLD5zXH
         PT82Tadc0b+rX4c7Zh9WVe9wWsImKnGbeUAK5M0qiU2B8fIdOxwtd/7elp3mgndJbBf9
         O0YhViQA9Rg4duoTkDWl0/mYdlDODHo+CTTpljjTj9/Rohds5yjhf+iRSh8ijgZN/+lS
         IAPlOv9hYd/PuuUy5LRBLfbEhqQ9YIC45Fw6mdvLM+4ZEUUcE5+89q6NV95okWogSUsR
         zWbg==
X-Forwarded-Encrypted: i=1; AJvYcCWdq/mi3dUQMWN1kBDakBATcRJXajyB6VtpepDjulihX8i7WQoPjQrMZpp9hoy0GP4C0mZxyMDOOvdgNwb5rV0WquU3u+o/78RDcEzx
X-Gm-Message-State: AOJu0YxXwOsCFrkpijOyEfbQ5VIPiflFjSsNAF0TBOIUNOFtSMRZW0J2
	sWITxVWGobKR5vbQN+tU//smFikxrqV/Zb2t8xvnkQQynyrU4GB7Bs3RhbM99bM=
X-Google-Smtp-Source: AGHT+IF+N1Dn96il0wvwHxygBW9Cfb4LN9lDUfvdPRZrA6rHyAmyr/leIL9C7sutkgAtT4RWVybiXg==
X-Received: by 2002:a17:902:fc87:b0:1db:4941:f703 with SMTP id mf7-20020a170902fc8700b001db4941f703mr12832574plb.15.1709060488029;
        Tue, 27 Feb 2024 11:01:28 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902b94100b001dcc3b0b612sm421448pls.287.2024.02.27.11.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:01:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 27 Feb 2024 09:01:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Introduce from_wq() helper for cleaner
 callback declarations
Message-ID: <Zd4xhvh9Drl4qrCV@slm.duckdns.org>
References: <20240227185628.5336-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227185628.5336-1-apais@linux.microsoft.com>

On Tue, Feb 27, 2024 at 06:56:28PM +0000, Allen Pais wrote:
> To streamline the transition from tasklets to worqueues, a new helper
> function, from_wq(), is introduced. This helper, inspired by existing
> from_() patterns, utilizes container_of() and eliminates the redundancy
> of declaring variable types, leading to more concise and readable code.
> 
> The modified code snippet demonstrates the enhanced clarity achieved
> with from_wq():
> 
>   void callback(struct work_struct *w)
>    {
>      - struct some_data_structure *local = container_of(w,
> 						       struct some_data_structure,
> 						       work);
>      + struct some_data_structure *local = from_wq(local, w, work);

I'm not necessarily against it but it's a bit meh in terms of how much it
saves. Also, can you please name it from_work()?

Thanks.

-- 
tejun

