Return-Path: <linux-kernel+bounces-8198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89B281B388
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871F41F24B19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285851039;
	Thu, 21 Dec 2023 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z36njX8K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227F50254;
	Thu, 21 Dec 2023 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e2d00f99cso778582e87.0;
        Thu, 21 Dec 2023 02:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703154500; x=1703759300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/zr94GTauXwZwFsx4VX9/N+8rHOzF4/CCB3fbhOq+A=;
        b=Z36njX8Kz5mBu4Ie8dTpjPDuae6Bc2L3MPB8NhB3P2ZbnYH20ZZL/9FfvBfrt9zkU8
         duFTeNSdczqJjW3AjKW+S12vKvobGlQdtUBBH91FYntNHt0a+9VT59bRcoSJ7hn5fSrT
         uTLZF2zysMLmZBEYyjj4HPLzs44bDUOuKARn0nh77iVRKWpvWu/7R9rtQo+lT4xGG4EV
         TT85pDfsW4IcYbj66Qv0vyjek1HZxNCDRj4kiV1ZOlgjM9Ih8d37jiI6gXwblcldjrx/
         lj/C4YitzOr1Gx10RoHdGgcEtPB8HGrPDRPujk9n4rd5QY6gpw+q6Vpa2caUxYMauYvN
         VdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703154500; x=1703759300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/zr94GTauXwZwFsx4VX9/N+8rHOzF4/CCB3fbhOq+A=;
        b=FI2EmlXn9ejr76zh+iUqQ17BMPby6vd5JZ3YDGvJ4anUam+1gmDxwr5PSlNLs/qrAk
         FsDCUlNqfqLx7/7pQLBAh7XJhqQXUw/ybJjb7E+bWyz4cYoVAMKkiyLZ4pdPG3aU4SpO
         cpiDHknPqhBujsMgPXo0eW01hKkOldO+/AfkYJJ+gLuFAX9cVlww1TP7OoTjkxSfpW0G
         cRZvEZLrSccmdVpVqPzvxaqb0oZZDjCAtq4oy4t6n1piyOoTfNqEa2NBdtb5Fz2rre5V
         OH9BWlrtFzFmLKy9pIWqgrLAcxDUQ7Dtx7O3DeHv+HRAX/tIdYwgPD95uj8mhrsRfp7c
         Os9A==
X-Gm-Message-State: AOJu0YxCZh7IiDVUse6J4wQyqXgs4+A6MQtyxEhazpwSadmntArHyjp6
	7IbtTwuTgmcZFf8c42gnByA=
X-Google-Smtp-Source: AGHT+IGVbbn2lD5eRSA5EVvPBzSWh/vOlMT4+BgaGme3oRBRxdU7tv5TxMJZ4XqRGRKfxniFN1QNiw==
X-Received: by 2002:ac2:419a:0:b0:50d:13f5:9bca with SMTP id z26-20020ac2419a000000b0050d13f59bcamr8743854lfh.63.1703154499777;
        Thu, 21 Dec 2023 02:28:19 -0800 (PST)
Received: from pc636 (host-90-233-221-204.mobileonline.telia.com. [90.233.221.204])
        by smtp.gmail.com with ESMTPSA id e2-20020a05651236c200b0050beead375bsm232257lfs.57.2023.12.21.02.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:28:19 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 21 Dec 2023 11:28:17 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 3/7] doc: Add rcutree.rcu_normal_wake_from_gp to
 kernel-parameters.txt
Message-ID: <ZYQTQWZCZMPgLsWV@pc636>
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-4-urezki@gmail.com>
 <1aa6e7a4-57de-480f-bc1c-5a1b28dd666b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aa6e7a4-57de-480f-bc1c-5a1b28dd666b@paulmck-laptop>

On Tue, Dec 19, 2023 at 05:17:19PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 28, 2023 at 09:00:29AM +0100, Uladzislau Rezki (Sony) wrote:
> > This commit adds rcutree.rcu_normal_wake_from_gp description
> > to the kernel-parameters.txt file.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Very good, but could you please fold this into the first patch, which
> is the one that adds this kernel parameter?
> 
No problem :)

--
Uladzislau Rezki

