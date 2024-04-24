Return-Path: <linux-kernel+bounces-157402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8B8B110F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AE81C23B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43116D4C6;
	Wed, 24 Apr 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7WUNqQe"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1A16D309;
	Wed, 24 Apr 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980025; cv=none; b=Xyjum1f33P5eJhIMTCnoAW9XP+zWKSfejlcVQ79w6MUlVfTyr9djLwatZ03VNKpxvWa356qWIB+NfCPrsZBUGvhH9GygBDxf4FeJxG5yYWA5pNzWOzbP0QuSKCOzpBpL/boHuK8OThtKDD6sYumj4Se+U8XjZTYchnn2irU/G3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980025; c=relaxed/simple;
	bh=VJtryPRdSbhoR83wh/nDtVyZr+nW68cEM8Mep7RI3F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/RvavFhjPgw3F9kLDdJuaYepK3WeHEerbV7FiFoxtJlHxE6vEH/fVaqNTztnYAZVa2Fm+II4e5H8X28/LW23WYNM42436Cp7OkxqqWzTF7WrRImxGbjq/9aPdUCKU7TzLjkKaraaiXUUTFlQG4TPxB4BN/bCFeIYsNQpBHB0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7WUNqQe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e651a9f3ffso445545ad.1;
        Wed, 24 Apr 2024 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713980023; x=1714584823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHbc1IMizMcaJzF17qOyImQ9KDMCW7lW672qBB1+MZ8=;
        b=P7WUNqQe+TcVMZ0qm9DebQaUXULDCVAGSYrPRztboOlMZ810rqQzlvRwD7/0CsV5CH
         INTOg9n4NtsaTgCAA5Mo956UgCE92e1KZmiQfjN428owkZnuGyTnHrZVkMo9R3qLW/Lv
         bo71jQudL433pEmOGESbwxOgNcn28j0hDXHPZe1w2sSuOdJSQzwKMV2FFYAYWYvdAj3m
         3uZlPDxuUU1y76XzfjYgTTC4/WFpDtVXYeuW2nxosfY8srjZCNf249TgCtlVgstM0DXl
         L03OeGkYsFdJ6MrKLaWNLTuLLNGJnXeUlcGqmKMp02WVdgIbM2CB7Lbps1NJwIh/t6af
         u/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713980023; x=1714584823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHbc1IMizMcaJzF17qOyImQ9KDMCW7lW672qBB1+MZ8=;
        b=Dyqw1ldk/fTuClcPxI8CGzAqhGsyDCzoLy9OelsvrsEu4TG/TEJOM+lUU8PhbqETH5
         NI88jrFCMQsVJOKh8rZO05TJyfGAbNmgDoeZpOTboQkPaj0dp3krp8v5aU5wa5QkjxpN
         x5Rav4CPInzkW4Osne8qJK6BE3Lh3hyGcPMzojv2X7MwhqlfI4fJMl4SYI6kquwh84h6
         Oja+Ip80QQ4yllsqoRyqOtnmwbzbKCBv65N2Mn6xNS96hf3AKoLMQuizTBTZkeDpPjKH
         cwz80C9GHEpc5tOGyakHVdgh0qgzPnQBnzPQPxM1EzOdQaVnd99uFV2h7xDYvjrX+x9b
         bwDg==
X-Forwarded-Encrypted: i=1; AJvYcCWRZ7kore4J1cJezFw6HuOmmaBB6I1NmxeidLPVF/ZtymTE/DwqqbtRkgvQkowqIVxA6xF3kFa9/C0xCp8MdQu4gwxU9Vaj
X-Gm-Message-State: AOJu0YyTnM5DkouVnkz+jSxVCmiyiuDMEYWv5urvSp+Add4q5F482U8N
	YguS2Hh24/cu9wvtuI+3UiE9+WaSLQKYawIpA81gAKAN0CTHfXkjyx4XA5kC
X-Google-Smtp-Source: AGHT+IEDHG570kcEbQkDBI/fAKBX6nHzx+s1iKH/aSwFx9HFu1aOZIdQeTBMPhX/rh/U5n6hNo9mHg==
X-Received: by 2002:a17:903:1108:b0:1e4:ae60:91fe with SMTP id n8-20020a170903110800b001e4ae6091femr3456137plh.51.1713980022823;
        Wed, 24 Apr 2024 10:33:42 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4652])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090332c300b001e40d27bc2dsm12183772plr.26.2024.04.24.10.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:33:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 24 Apr 2024 07:33:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Sam Sun <samsun1006219@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	syzkaller-bugs@googlegroups.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2] workqueue: Fix divide error in
 wq_update_node_max_active()
Message-ID: <ZilCdb2_LFOA71J-@slm.duckdns.org>
References: <CAEkJfYPGS1_4JqvpSo0=FM0S1ytB8CEbyreLTtWpR900dUZymw@mail.gmail.com>
 <20240424135155.1339671-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424135155.1339671-1-jiangshanlai@gmail.com>

Applied to wq/for-6.9-fixes.

Thanks.

-- 
tejun

